Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A69B34CBED
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 12:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfFTKdf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 06:33:35 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18647 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726222AbfFTKdf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jun 2019 06:33:35 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D286968E86C6D27CF9A1;
        Thu, 20 Jun 2019 18:33:32 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Thu, 20 Jun 2019 18:33:25 +0800
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@huawei.com>
CC:     <bhelgaas@google.com>, <linuxarm@huawei.com>, <arm@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <joe@perches.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 2/5] lib: logic_pio: Add logic_pio_unregister_range()
Date:   Thu, 20 Jun 2019 18:31:53 +0800
Message-ID: <1561026716-140537-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1561026716-140537-1-git-send-email-john.garry@huawei.com>
References: <1561026716-140537-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a function to unregister a logical PIO range.

The method used to allocate LOGIC_PIO_CPU_MMIO regions during registration
is slightly modified to ensure that we get no overlap when regions are
unregistered. This is needed because the allocation scheme assumed that no
regions are ever unregistered.

Logical PIO space can still be leaked when unregistering certain
LOGIC_PIO_CPU_MMIO regions, but this acceptable for now since there are no
callers to unregister LOGIC_PIO_CPU_MMIO regions, and the logical PIO
region allocation scheme would need significant work to improve this.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 include/linux/logic_pio.h |  1 +
 lib/logic_pio.c           | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/logic_pio.h b/include/linux/logic_pio.h
index cbd9d8495690..88e1e6304a71 100644
--- a/include/linux/logic_pio.h
+++ b/include/linux/logic_pio.h
@@ -117,6 +117,7 @@ struct logic_pio_hwaddr *find_io_range_by_fwnode(struct fwnode_handle *fwnode);
 unsigned long logic_pio_trans_hwaddr(struct fwnode_handle *fwnode,
 			resource_size_t hw_addr, resource_size_t size);
 int logic_pio_register_range(struct logic_pio_hwaddr *newrange);
+void logic_pio_unregister_range(struct logic_pio_hwaddr *range);
 resource_size_t logic_pio_to_hwaddr(unsigned long pio);
 unsigned long logic_pio_trans_cpuaddr(resource_size_t hw_addr);
 
diff --git a/lib/logic_pio.c b/lib/logic_pio.c
index 761296376fbc..45eb57af2574 100644
--- a/lib/logic_pio.c
+++ b/lib/logic_pio.c
@@ -56,7 +56,7 @@ int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
 			/* for MMIO ranges we need to check for overlap */
 			if (start >= range->hw_start + range->size ||
 			    end < range->hw_start) {
-				mmio_sz += range->size;
+				mmio_sz = range->io_start + range->size;
 			} else {
 				ret = -EFAULT;
 				goto end_register;
@@ -98,6 +98,20 @@ int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
 	return ret;
 }
 
+/**
+ * logic_pio_unregister_range - unregister logical PIO range for a host
+ * @range: pointer to the IO range which has been already registered.
+ *
+ * Unregister a previously-registered IO range node.
+ */
+void logic_pio_unregister_range(struct logic_pio_hwaddr *range)
+{
+	mutex_lock(&io_range_mutex);
+	list_del_rcu(&range->list);
+	mutex_unlock(&io_range_mutex);
+	synchronize_rcu();
+}
+
 /**
  * find_io_range_by_fwnode - find logical PIO range for given FW node
  * @fwnode: FW node handle associated with logical PIO range
-- 
2.17.1

