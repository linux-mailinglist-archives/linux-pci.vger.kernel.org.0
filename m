Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36C7ED797B
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 17:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733145AbfJOPMI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 11:12:08 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:38110 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfJOPMH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Oct 2019 11:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1571152327; x=1602688327;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I1HQ40Yz5nhSZHj8Efhb8t+NSkA4Lqjdb0qM50SZFGE=;
  b=TcD43VO/1iCB9ASKOj4EI8nJPi9aBpk6ktHfeH6Pu92UqpqeRGHWCdWm
   7NICjH2wf4oV4IOd5uU70/a5QBUOGvqZ++6QuoxQcXCJYFh+SIizz3GjJ
   wrBBGK8K3qgpwb954jOVvACxdo3Kcq02wzh3vhhkaveOtnuyotKQi5Z0N
   8=;
X-IronPort-AV: E=Sophos;i="5.67,300,1566864000"; 
   d="scan'208";a="429292546"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-859fe132.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 15 Oct 2019 15:12:05 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-859fe132.us-west-2.amazon.com (Postfix) with ESMTPS id D71E922186A;
        Tue, 15 Oct 2019 15:12:04 +0000 (UTC)
Received: from EX13D13EUA004.ant.amazon.com (10.43.165.22) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 15 Oct 2019 15:12:04 +0000
Received: from localhost (10.43.161.223) by EX13D13EUA004.ant.amazon.com
 (10.43.165.22) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 15 Oct
 2019 15:12:03 +0000
From:   Yuri Volchkov <volchkov@amazon.de>
To:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
CC:     <joro@8bytes.org>, <bhelgaas@google.com>, <dwmw2@infradead.org>,
        <neugebar@amazon.co.uk>, Yuri Volchkov <volchkov@amazon.de>
Subject: [PATCH 2/2] iommu/dmar: catch early fault occurrences
Date:   Tue, 15 Oct 2019 17:11:12 +0200
Message-ID: <20191015151112.17225-3-volchkov@amazon.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015151112.17225-1-volchkov@amazon.de>
References: <20191015151112.17225-1-volchkov@amazon.de>
MIME-Version: 1.0
X-Originating-IP: [10.43.161.223]
X-ClientProxiedBy: EX13D10UWA002.ant.amazon.com (10.43.160.228) To
 EX13D13EUA004.ant.amazon.com (10.43.165.22)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

First dmar faults can happen even before linux have scanned PCI
bus. In such case worker will not have chance to lookup a
corresponding 'struct pci_dev'.

This commit defers processing of the fault until intel_iommu_init
function has been called. At this point of time pci devices will be
already initialized.

Signed-off-by: Yuri Volchkov <volchkov@amazon.de>
---
 drivers/iommu/dmar.c        | 51 ++++++++++++++++++++++++++++++++++++-
 drivers/iommu/intel-iommu.c |  1 +
 include/linux/intel-iommu.h |  1 +
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 0749873e3e41..8db2af3de29f 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1674,7 +1674,10 @@ void dmar_msi_read(int irq, struct msi_msg *msg)
 }
 
 struct dmar_fault_info {
-	struct work_struct work;
+	union {
+		struct work_struct work;
+		struct list_head backlog_list;
+	};
 	struct intel_iommu *iommu;
 	int type;
 	int pasid;
@@ -1757,12 +1760,58 @@ static int dmar_fault_handle_one(struct dmar_fault_info *info)
 	return 0;
 }
 
+struct fault_backlog {
+	struct list_head queue;
+	struct mutex lock;
+	bool is_active;
+};
+
+static struct fault_backlog fault_backlog = {
+	.queue = LIST_HEAD_INIT(fault_backlog.queue),
+	.lock = __MUTEX_INITIALIZER(fault_backlog.lock),
+	.is_active = true,
+};
+
+void dmar_process_deferred_faults(void)
+{
+	struct dmar_fault_info *info, *tmp;
+
+	mutex_lock(&fault_backlog.lock);
+	WARN_ON(!fault_backlog.is_active);
+
+	list_for_each_entry_safe(info, tmp, &fault_backlog.queue,
+				 backlog_list) {
+		dmar_fault_handle_one(info);
+		list_del(&info->backlog_list);
+		free_dmar_fault_info(info);
+	}
+	fault_backlog.is_active = false;
+	mutex_unlock(&fault_backlog.lock);
+}
+
 static void dmar_fault_handle_work(struct work_struct *work)
 {
 	struct dmar_fault_info *info;
 
 	info = container_of(work, struct dmar_fault_info, work);
 
+	if (fault_backlog.is_active) {
+		/* Postpone handling until PCI devices will be
+		 * initialized
+		 */
+
+		mutex_lock(&fault_backlog.lock);
+		if (!fault_backlog.is_active) {
+			mutex_unlock(&fault_backlog.lock);
+			goto process;
+		}
+
+		list_add(&info->backlog_list, &fault_backlog.queue);
+		mutex_unlock(&fault_backlog.lock);
+		return;
+	}
+
+process:
 	dmar_fault_handle_one(info);
 	free_dmar_fault_info(info);
 }
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 3f974919d3bd..a97c05fac5e9 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5041,6 +5041,7 @@ int __init intel_iommu_init(void)
 		iommu_disable_protect_mem_regions(iommu);
 	}
 	pr_info("Intel(R) Virtualization Technology for Directed I/O\n");
+	dmar_process_deferred_faults();
 
 	intel_iommu_enabled = 1;
 	intel_iommu_debugfs_init();
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index f8963c833fb0..480a31b41263 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -649,6 +649,7 @@ extern void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 extern int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iommu);
 
 extern int dmar_ir_support(void);
+extern void dmar_process_deferred_faults(void);
 
 void *alloc_pgtable_page(int node);
 void free_pgtable_page(void *vaddr);
-- 
2.23.0




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Ralf Herbrich
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



