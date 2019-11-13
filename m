Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 742DEFAC99
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2019 10:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfKMJJL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Nov 2019 04:09:11 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:2683 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfKMJJK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Nov 2019 04:09:10 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dcbc8350000>; Wed, 13 Nov 2019 01:09:09 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 13 Nov 2019 01:09:09 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 13 Nov 2019 01:09:09 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Nov
 2019 09:09:09 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 13 Nov 2019 09:09:09 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dcbc8310001>; Wed, 13 Nov 2019 01:09:08 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <andrew.murray@arm.com>,
        <bhelgaas@google.com>, <kishon@ti.com>, <thierry.reding@gmail.com>
CC:     <Jisheng.Zhang@synaptics.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH 2/4] PCI: endpoint: Add notification for core init completion
Date:   Wed, 13 Nov 2019 14:38:49 +0530
Message-ID: <20191113090851.26345-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191113090851.26345-1-vidyas@nvidia.com>
References: <20191113090851.26345-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1573636149; bh=9U6u+odfldnbQptdUxvIfB0A/9BF5Luwy6niejQ8RZU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=E5F+Gu5UddwAPwEUAMkbFNBaMOtk4AlmXaEo7SJHwmMjyXkTQe9YTvDoxkT/bt+No
         4ex2GD2tDuLnuzTwxiBS1rWQ3T6HXcdcNprStfEX0XGu4Zney1QoTapnYB0MwQcqiC
         szHRYzggZub3Dl9U7A/JCiNJnOYZbw+MXwlFp5vCILYR52PJUbK36yEz5AxAitpDfo
         nZKBfIb8k2xezfQK/FnypWbPF+Hrst0U3dk1bNZauryZTcXj2u9Iehtl3db9/K6jrO
         Jw6Lhlo+KbvULL8Jvpe7yrTpW/lACZTU86FklLP+f9iUrrQBn2DnhQGe6vx9LwKfcc
         TG+4r/gXS4U8Q==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to send notifications to EPF from EPC once the core
registers initialization is complete.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 19 ++++++++++++++++++-
 include/linux/pci-epc.h             |  1 +
 include/linux/pci-epf.h             |  5 +++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 2f6436599fcb..fcc3f7fb19c0 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -542,10 +542,27 @@ void pci_epc_linkup(struct pci_epc *epc)
 	if (!epc || IS_ERR(epc))
 		return;
 
-	atomic_notifier_call_chain(&epc->notifier, 0, NULL);
+	atomic_notifier_call_chain(&epc->notifier, LINK_UP, NULL);
 }
 EXPORT_SYMBOL_GPL(pci_epc_linkup);
 
+/**
+ * pci_epc_init_notify() - Notify the EPF device that EPC device's core
+ *			   initialization is completed.
+ * @epc: the EPC device whose core initialization is completeds
+ *
+ * Invoke to Notify the EPF device that the EPC device's initialization
+ * is completed.
+ */
+void pci_epc_init_notify(struct pci_epc *epc)
+{
+	if (!epc || IS_ERR(epc))
+		return;
+
+	atomic_notifier_call_chain(&epc->notifier, CORE_INIT, NULL);
+}
+EXPORT_SYMBOL_GPL(pci_epc_init_notify);
+
 /**
  * pci_epc_destroy() - destroy the EPC device
  * @epc: the EPC device that has to be destroyed
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 241e6a6f39fb..c670543e42f9 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -160,6 +160,7 @@ void devm_pci_epc_destroy(struct device *dev, struct pci_epc *epc);
 void pci_epc_destroy(struct pci_epc *epc);
 int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf);
 void pci_epc_linkup(struct pci_epc *epc);
+void pci_epc_init_notify(struct pci_epc *epc);
 void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf);
 int pci_epc_write_header(struct pci_epc *epc, u8 func_no,
 			 struct pci_epf_header *hdr);
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 4993f7f6439b..3cb65ac1648c 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -15,6 +15,11 @@
 
 struct pci_epf;
 
+enum pci_notify_event {
+	CORE_INIT,
+	LINK_UP,
+};
+
 enum pci_barno {
 	BAR_0,
 	BAR_1,
-- 
2.17.1

