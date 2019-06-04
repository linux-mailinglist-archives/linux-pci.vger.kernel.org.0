Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3B634816
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2019 15:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfFDNSY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jun 2019 09:18:24 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50446 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbfFDNSY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jun 2019 09:18:24 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x54DI91H082449;
        Tue, 4 Jun 2019 08:18:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559654289;
        bh=KYaPkNEQ60YlYRzupynkHvldNRiAueFkeDs6jBPtuQA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=xqWi2tP1kQaszC24APX2/Benq9KAhAPtpp+HuSP+SOjFnYQV7ikGSoDuJ7RADCYvA
         z1L5lNyKz7f0VPbINVNIv1rNPkGpp3M8MTLBeIdMIiF8Ech008Q7Hc3m9ZWbXzMMz6
         RL1x+w7BUKsKqyETmgzcl58P0CxOc+uLypwNOBTk=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x54DI93J002218
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Jun 2019 08:18:09 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 4 Jun
 2019 08:18:08 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 4 Jun 2019 08:18:08 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x54DGdGV098972;
        Tue, 4 Jun 2019 08:18:03 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 15/30] PCI: endpoint: Replace spinlock with mutex
Date:   Tue, 4 Jun 2019 18:45:01 +0530
Message-ID: <20190604131516.13596-16-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604131516.13596-1-kishon@ti.com>
References: <20190604131516.13596-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pci_epc_ops is not intended to be invoked from interrupt context.
Hence replace spin_lock_irqsave and spin_unlock_irqrestore with
mutex_lock and mutex_unlock respectively.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 82 +++++++++++------------------
 include/linux/pci-epc.h             |  6 +--
 2 files changed, 34 insertions(+), 54 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 80831a874dbd..eea07f9ec5ff 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -120,7 +120,6 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 						    u8 func_no)
 {
 	const struct pci_epc_features *epc_features;
-	unsigned long flags;
 
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
 		return NULL;
@@ -128,9 +127,9 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 	if (!epc->ops->get_features)
 		return NULL;
 
-	spin_lock_irqsave(&epc->lock, flags);
+	mutex_lock(&epc->lock);
 	epc_features = epc->ops->get_features(epc, func_no);
-	spin_unlock_irqrestore(&epc->lock, flags);
+	mutex_unlock(&epc->lock);
 
 	return epc_features;
 }
@@ -144,14 +143,12 @@ EXPORT_SYMBOL_GPL(pci_epc_get_features);
  */
 void pci_epc_stop(struct pci_epc *epc)
 {
-	unsigned long flags;
-
 	if (IS_ERR(epc) || !epc->ops->stop)
 		return;
 
-	spin_lock_irqsave(&epc->lock, flags);
+	mutex_lock(&epc->lock);
 	epc->ops->stop(epc);
-	spin_unlock_irqrestore(&epc->lock, flags);
+	mutex_unlock(&epc->lock);
 }
 EXPORT_SYMBOL_GPL(pci_epc_stop);
 
@@ -164,7 +161,6 @@ EXPORT_SYMBOL_GPL(pci_epc_stop);
 int pci_epc_start(struct pci_epc *epc)
 {
 	int ret;
-	unsigned long flags;
 
 	if (IS_ERR(epc))
 		return -EINVAL;
@@ -172,9 +168,9 @@ int pci_epc_start(struct pci_epc *epc)
 	if (!epc->ops->start)
 		return 0;
 
-	spin_lock_irqsave(&epc->lock, flags);
+	mutex_lock(&epc->lock);
 	ret = epc->ops->start(epc);
-	spin_unlock_irqrestore(&epc->lock, flags);
+	mutex_unlock(&epc->lock);
 
 	return ret;
 }
@@ -193,7 +189,6 @@ int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no,
 		      enum pci_epc_irq_type type, u16 interrupt_num)
 {
 	int ret;
-	unsigned long flags;
 
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
 		return -EINVAL;
@@ -201,9 +196,9 @@ int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no,
 	if (!epc->ops->raise_irq)
 		return 0;
 
-	spin_lock_irqsave(&epc->lock, flags);
+	mutex_lock(&epc->lock);
 	ret = epc->ops->raise_irq(epc, func_no, type, interrupt_num);
-	spin_unlock_irqrestore(&epc->lock, flags);
+	mutex_unlock(&epc->lock);
 
 	return ret;
 }
@@ -219,7 +214,6 @@ EXPORT_SYMBOL_GPL(pci_epc_raise_irq);
 int pci_epc_get_msi(struct pci_epc *epc, u8 func_no)
 {
 	int interrupt;
-	unsigned long flags;
 
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
 		return 0;
@@ -227,9 +221,9 @@ int pci_epc_get_msi(struct pci_epc *epc, u8 func_no)
 	if (!epc->ops->get_msi)
 		return 0;
 
-	spin_lock_irqsave(&epc->lock, flags);
+	mutex_lock(&epc->lock);
 	interrupt = epc->ops->get_msi(epc, func_no);
-	spin_unlock_irqrestore(&epc->lock, flags);
+	mutex_unlock(&epc->lock);
 
 	if (interrupt < 0)
 		return 0;
@@ -252,7 +246,6 @@ int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 interrupts)
 {
 	int ret;
 	u8 encode_int;
-	unsigned long flags;
 
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
 	    interrupts > 32)
@@ -263,9 +256,9 @@ int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 interrupts)
 
 	encode_int = order_base_2(interrupts);
 
-	spin_lock_irqsave(&epc->lock, flags);
+	mutex_lock(&epc->lock);
 	ret = epc->ops->set_msi(epc, func_no, encode_int);
-	spin_unlock_irqrestore(&epc->lock, flags);
+	mutex_unlock(&epc->lock);
 
 	return ret;
 }
@@ -281,7 +274,6 @@ EXPORT_SYMBOL_GPL(pci_epc_set_msi);
 int pci_epc_get_msix(struct pci_epc *epc, u8 func_no)
 {
 	int interrupt;
-	unsigned long flags;
 
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
 		return 0;
@@ -289,9 +281,9 @@ int pci_epc_get_msix(struct pci_epc *epc, u8 func_no)
 	if (!epc->ops->get_msix)
 		return 0;
 
-	spin_lock_irqsave(&epc->lock, flags);
+	mutex_lock(&epc->lock);
 	interrupt = epc->ops->get_msix(epc, func_no);
-	spin_unlock_irqrestore(&epc->lock, flags);
+	mutex_unlock(&epc->lock);
 
 	if (interrupt < 0)
 		return 0;
@@ -311,7 +303,6 @@ EXPORT_SYMBOL_GPL(pci_epc_get_msix);
 int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts)
 {
 	int ret;
-	unsigned long flags;
 
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
 	    interrupts < 1 || interrupts > 2048)
@@ -320,9 +311,9 @@ int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts)
 	if (!epc->ops->set_msix)
 		return 0;
 
-	spin_lock_irqsave(&epc->lock, flags);
+	mutex_lock(&epc->lock);
 	ret = epc->ops->set_msix(epc, func_no, interrupts - 1);
-	spin_unlock_irqrestore(&epc->lock, flags);
+	mutex_unlock(&epc->lock);
 
 	return ret;
 }
@@ -339,17 +330,15 @@ EXPORT_SYMBOL_GPL(pci_epc_set_msix);
 void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no,
 			phys_addr_t phys_addr)
 {
-	unsigned long flags;
-
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
 		return;
 
 	if (!epc->ops->unmap_addr)
 		return;
 
-	spin_lock_irqsave(&epc->lock, flags);
+	mutex_lock(&epc->lock);
 	epc->ops->unmap_addr(epc, func_no, phys_addr);
-	spin_unlock_irqrestore(&epc->lock, flags);
+	mutex_unlock(&epc->lock);
 }
 EXPORT_SYMBOL_GPL(pci_epc_unmap_addr);
 
@@ -367,7 +356,6 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no,
 		     phys_addr_t phys_addr, u64 pci_addr, size_t size)
 {
 	int ret;
-	unsigned long flags;
 
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
 		return -EINVAL;
@@ -375,9 +363,9 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no,
 	if (!epc->ops->map_addr)
 		return 0;
 
-	spin_lock_irqsave(&epc->lock, flags);
+	mutex_lock(&epc->lock);
 	ret = epc->ops->map_addr(epc, func_no, phys_addr, pci_addr, size);
-	spin_unlock_irqrestore(&epc->lock, flags);
+	mutex_unlock(&epc->lock);
 
 	return ret;
 }
@@ -394,8 +382,6 @@ EXPORT_SYMBOL_GPL(pci_epc_map_addr);
 void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no,
 		       struct pci_epf_bar *epf_bar)
 {
-	unsigned long flags;
-
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
 	    (epf_bar->barno == BAR_5 &&
 	     epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64))
@@ -404,9 +390,9 @@ void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no,
 	if (!epc->ops->clear_bar)
 		return;
 
-	spin_lock_irqsave(&epc->lock, flags);
+	mutex_lock(&epc->lock);
 	epc->ops->clear_bar(epc, func_no, epf_bar);
-	spin_unlock_irqrestore(&epc->lock, flags);
+	mutex_unlock(&epc->lock);
 }
 EXPORT_SYMBOL_GPL(pci_epc_clear_bar);
 
@@ -422,7 +408,6 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no,
 		    struct pci_epf_bar *epf_bar)
 {
 	int ret;
-	unsigned long irq_flags;
 	int flags = epf_bar->flags;
 
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
@@ -437,9 +422,9 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no,
 	if (!epc->ops->set_bar)
 		return 0;
 
-	spin_lock_irqsave(&epc->lock, irq_flags);
+	mutex_lock(&epc->lock);
 	ret = epc->ops->set_bar(epc, func_no, epf_bar);
-	spin_unlock_irqrestore(&epc->lock, irq_flags);
+	mutex_unlock(&epc->lock);
 
 	return ret;
 }
@@ -460,7 +445,6 @@ int pci_epc_write_header(struct pci_epc *epc, u8 func_no,
 			 struct pci_epf_header *header)
 {
 	int ret;
-	unsigned long flags;
 
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
 		return -EINVAL;
@@ -468,9 +452,9 @@ int pci_epc_write_header(struct pci_epc *epc, u8 func_no,
 	if (!epc->ops->write_header)
 		return 0;
 
-	spin_lock_irqsave(&epc->lock, flags);
+	mutex_lock(&epc->lock);
 	ret = epc->ops->write_header(epc, func_no, header);
-	spin_unlock_irqrestore(&epc->lock, flags);
+	mutex_unlock(&epc->lock);
 
 	return ret;
 }
@@ -487,8 +471,6 @@ EXPORT_SYMBOL_GPL(pci_epc_write_header);
  */
 int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf)
 {
-	unsigned long flags;
-
 	if (epf->epc)
 		return -EBUSY;
 
@@ -500,9 +482,9 @@ int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf)
 
 	epf->epc = epc;
 
-	spin_lock_irqsave(&epc->lock, flags);
+	mutex_lock(&epc->lock);
 	list_add_tail(&epf->list, &epc->pci_epf);
-	spin_unlock_irqrestore(&epc->lock, flags);
+	mutex_unlock(&epc->lock);
 
 	return 0;
 }
@@ -517,14 +499,12 @@ EXPORT_SYMBOL_GPL(pci_epc_add_epf);
  */
 void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf)
 {
-	unsigned long flags;
-
 	if (!epc || IS_ERR(epc))
 		return;
 
-	spin_lock_irqsave(&epc->lock, flags);
+	mutex_lock(&epc->lock);
 	list_del(&epf->list);
-	spin_unlock_irqrestore(&epc->lock, flags);
+	mutex_unlock(&epc->lock);
 }
 EXPORT_SYMBOL_GPL(pci_epc_remove_epf);
 
@@ -603,7 +583,7 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
 		goto err_ret;
 	}
 
-	spin_lock_init(&epc->lock);
+	mutex_init(&epc->lock);
 	INIT_LIST_HEAD(&epc->pci_epf);
 	ATOMIC_INIT_NOTIFIER_HEAD(&epc->notifier);
 
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 834dfc00aa00..a430d02aa1ff 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -88,7 +88,7 @@ struct pci_epc_mem {
  * @mem: address space of the endpoint controller
  * @max_functions: max number of functions that can be configured in this EPC
  * @group: configfs group representing the PCI EPC device
- * @lock: spinlock to protect pci_epc ops
+ * @lock: mutex to protect pci_epc ops
  * @notifier: used to notify EPF of any EPC events (like linkup)
  */
 struct pci_epc {
@@ -98,8 +98,8 @@ struct pci_epc {
 	struct pci_epc_mem		*mem;
 	u8				max_functions;
 	struct config_group		*group;
-	/* spinlock to protect against concurrent access of EP controller */
-	spinlock_t			lock;
+	/* mutex to protect against concurrent access of EP controller */
+	struct mutex			lock;
 	struct atomic_notifier_head	notifier;
 };
 
-- 
2.17.1

