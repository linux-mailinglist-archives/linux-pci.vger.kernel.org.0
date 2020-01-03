Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64CA212F691
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2020 11:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbgACKIE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jan 2020 05:08:04 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10125 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgACKID (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jan 2020 05:08:03 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e0f12730002>; Fri, 03 Jan 2020 02:07:47 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 03 Jan 2020 02:08:02 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 03 Jan 2020 02:08:02 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 3 Jan
 2020 10:08:02 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 3 Jan 2020 10:08:02 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.48]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e0f127e0000>; Fri, 03 Jan 2020 02:08:01 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <andrew.murray@arm.com>,
        <bhelgaas@google.com>, <kishon@ti.com>, <thierry.reding@gmail.com>
CC:     <Jisheng.Zhang@synaptics.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V2 3/5] PCI: endpoint: Add notification for core init completion
Date:   Fri, 3 Jan 2020 15:37:34 +0530
Message-ID: <20200103100736.27627-4-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103100736.27627-1-vidyas@nvidia.com>
References: <20200103100736.27627-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578046067; bh=Ha+bcuXGrM0L03R3lRVubmjiE0J+PZcOB0XAy0EUE5c=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=XHumTBBOq4zk1kksPblE5ZUSUrzLSmEl8wbn906VZpik6Gzt+DFwwioE8PzD+qHVa
         LNKWGidyu34JtJAAyOU7EdmV38tiE2JDajYDQ+hYryyLI4tMObAGjxXYd48caSrbE+
         gIDZSKuUXKAokHF+2804e8fniTT9AzfD4+F1EWSfNu9LW/LSHzja/s+opScSHn4ROW
         AA3ZrZ0tie/6Phd3lT9Y/uxG8dVhgG7kpSUH4E5fjoUqsV5f0tnBF4+ezRNCp1lymc
         HKPH8Gzo+JwdfKcxLG7b0/2eW84q2PIN59Ao4em/fuU8vYMXzdTOOVRCuFTQtOJCcD
         lwsLSqddEHtvw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to send notifications to EPF from EPC once the core
registers initialization is complete.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* None

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
index ec8d4d896564..31cdae7e2cdd 100644
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

