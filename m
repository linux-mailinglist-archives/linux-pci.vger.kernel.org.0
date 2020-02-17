Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B28F81611B8
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2020 13:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgBQMLL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Feb 2020 07:11:11 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2716 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729656AbgBQMLK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Feb 2020 07:11:10 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4a82d00000>; Mon, 17 Feb 2020 04:10:56 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 17 Feb 2020 04:11:09 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 17 Feb 2020 04:11:09 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 17 Feb
 2020 12:11:09 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 17 Feb 2020 12:11:09 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e4a82d90002>; Mon, 17 Feb 2020 04:11:09 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <andrew.murray@arm.com>,
        <bhelgaas@google.com>, <kishon@ti.com>, <thierry.reding@gmail.com>
CC:     <Jisheng.Zhang@synaptics.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V3 3/5] PCI: endpoint: Add notification for core init completion
Date:   Mon, 17 Feb 2020 17:40:34 +0530
Message-ID: <20200217121036.3057-4-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217121036.3057-1-vidyas@nvidia.com>
References: <20200217121036.3057-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581941456; bh=6Iopf0Q6A3DDLlHopVYOdLyoIpX4hHn9y3CGW1XIkKU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=DJT52cbXjSQEPGFh2grgktj414HkaetbwuoCPvvvtaU/N84NiGNKoH/rshjN3Qoxm
         9KhIEGc6E9Gjj2hzOD469ayLzx5e1ARJDulAsCVFvI9GK5loWHqKsAKFtbHfGBYnvD
         QAn7GQeCeWH3zKGgoV3qFEpEfnd6ICWm7igQ0pA2DG38D+lvQ8hllAP/8tOeomxHM2
         wMcmmxwgqzGD6+EaiI1wqcmQs5wNH6ANf1LFEa/m9Z62b8zNAeWYJm/Vl7V2T4Sk4J
         xBIk8ACRIHSvHMs60P5G9/olkX76a36HPmjGh/CK53szDR2/cKe53Q1WUJcYxAXqUg
         wsyPjZZs6AGdg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to send notifications to EPF from EPC once the core
registers initialization is complete.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
V3:
* Added Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

V2:
* None

 drivers/pci/endpoint/pci-epc-core.c | 19 ++++++++++++++++++-
 include/linux/pci-epc.h             |  1 +
 include/linux/pci-epf.h             |  5 +++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index dc1c673534e0..0d22a377a0cf 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -540,10 +540,27 @@ void pci_epc_linkup(struct pci_epc *epc)
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
index 9ffe6bd081ae..0d7e91bad91e 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -165,6 +165,7 @@ void devm_pci_epc_destroy(struct device *dev, struct pci_epc *epc);
 void pci_epc_destroy(struct pci_epc *epc);
 int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf);
 void pci_epc_linkup(struct pci_epc *epc);
+void pci_epc_init_notify(struct pci_epc *epc);
 void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf);
 int pci_epc_write_header(struct pci_epc *epc, u8 func_no,
 			 struct pci_epf_header *hdr);
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index bcdf4f07bde7..0c628e30c582 100644
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

