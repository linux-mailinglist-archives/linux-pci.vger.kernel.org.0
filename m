Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 808C815A7AA
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2020 12:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgBLLV4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Feb 2020 06:21:56 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56630 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbgBLLVz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Feb 2020 06:21:55 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01CBLmOD065869;
        Wed, 12 Feb 2020 05:21:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581506508;
        bh=YwWboun219hl2JViX7Q/BOoaisYf+ToKJpMH3k4a83U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=XwJpf1cafM878qBmpgXeEi24u+/wYC8g0n+7Kmf2K9w58gDMYJ+YZjk05c2PKcG6J
         EdvxlEb+H3p4cIlfTXN6f88HzbaxCzDjTUaEqffqL/xCKxMw2/wekAwuX8g/LkVx1N
         ACDi6NlA1/0IZZ7Xf/bd41kqtBdEXThwcdKMsj9k=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01CBLmKk078547;
        Wed, 12 Feb 2020 05:21:48 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 12
 Feb 2020 05:21:48 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 12 Feb 2020 05:21:48 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01CBLc5Y049841;
        Wed, 12 Feb 2020 05:21:45 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Vidya Sagar <vidyas@nvidia.com>,
        Athani Nadeem Ladkhan <nadeem@cadence.com>,
        Tom Joseph <tjoseph@cadence.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 2/5] PCI: endpoint: Replace spinlock with mutex
Date:   Wed, 12 Feb 2020 16:55:11 +0530
Message-ID: <20200212112514.2000-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200212112514.2000-1-kishon@ti.com>
References: <20200212112514.2000-1-kishon@ti.com>
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
index 2f6436599fcb..e51a12ed85bb 100644
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
@@ -517,15 +499,13 @@ EXPORT_SYMBOL_GPL(pci_epc_add_epf);
  */
 void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf)
 {
-	unsigned long flags;
-
 	if (!epc || IS_ERR(epc) || !epf)
 		return;
 
-	spin_lock_irqsave(&epc->lock, flags);
+	mutex_lock(&epc->lock);
 	list_del(&epf->list);
 	epf->epc = NULL;
-	spin_unlock_irqrestore(&epc->lock, flags);
+	mutex_unlock(&epc->lock);
 }
 EXPORT_SYMBOL_GPL(pci_epc_remove_epf);
 
@@ -604,7 +584,7 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
 		goto err_ret;
 	}
 
-	spin_lock_init(&epc->lock);
+	mutex_init(&epc->lock);
 	INIT_LIST_HEAD(&epc->pci_epf);
 	ATOMIC_INIT_NOTIFIER_HEAD(&epc->notifier);
 
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 36644ccd32ac..9dd60f2e9705 100644
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

