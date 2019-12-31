Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E869F12D7B8
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2019 11:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfLaKBp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Dec 2019 05:01:45 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36880 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfLaKBp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Dec 2019 05:01:45 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBVA1bBN129453;
        Tue, 31 Dec 2019 04:01:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577786497;
        bh=vmnnnNRcFSIyJUOGml0h/bshwH86B9ckqGcK9N7kRKE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WGAwb+tfdYa7B/fQy97F2z0OWOF5J3Wpj62VIz3Gfxt7hQ76V99xrwumjxBa48EvK
         VcRl/9TQoPFKTgZ1NmNwDo3lzIm1a24p8wmY/pWLK2WF6rIZ1L1WOgBKkItr/xTaUh
         ROFlcXiode/yeTL/Pxuq7nlCAvi8KST0GYdryNKk=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBVA1bp3079517
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 31 Dec 2019 04:01:37 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 31
 Dec 2019 04:01:37 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 31 Dec 2019 04:01:37 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBVA1TZh020876;
        Tue, 31 Dec 2019 04:01:35 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <andrew.murray@arm.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/5] PCI: endpoint: Replace spinlock with mutex
Date:   Tue, 31 Dec 2019 15:33:28 +0530
Message-ID: <20191231100331.6316-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191231100331.6316-1-kishon@ti.com>
References: <20191231100331.6316-1-kishon@ti.com>
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
index 82a0636fc562..0f8de1d97c15 100644
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
@@ -314,7 +306,6 @@ int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts,
 		     enum pci_barno bir, u32 offset)
 {
 	int ret;
-	unsigned long flags;
 
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
 	    interrupts < 1 || interrupts > 2048)
@@ -323,9 +314,9 @@ int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts,
 	if (!epc->ops->set_msix)
 		return 0;
 
-	spin_lock_irqsave(&epc->lock, flags);
+	mutex_lock(&epc->lock);
 	ret = epc->ops->set_msix(epc, func_no, interrupts - 1, bir, offset);
-	spin_unlock_irqrestore(&epc->lock, flags);
+	mutex_unlock(&epc->lock);
 
 	return ret;
 }
@@ -342,17 +333,15 @@ EXPORT_SYMBOL_GPL(pci_epc_set_msix);
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
 
@@ -370,7 +359,6 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no,
 		     phys_addr_t phys_addr, u64 pci_addr, size_t size)
 {
 	int ret;
-	unsigned long flags;
 
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
 		return -EINVAL;
@@ -378,9 +366,9 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no,
 	if (!epc->ops->map_addr)
 		return 0;
 
-	spin_lock_irqsave(&epc->lock, flags);
+	mutex_lock(&epc->lock);
 	ret = epc->ops->map_addr(epc, func_no, phys_addr, pci_addr, size);
-	spin_unlock_irqrestore(&epc->lock, flags);
+	mutex_unlock(&epc->lock);
 
 	return ret;
 }
@@ -397,8 +385,6 @@ EXPORT_SYMBOL_GPL(pci_epc_map_addr);
 void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no,
 		       struct pci_epf_bar *epf_bar)
 {
-	unsigned long flags;
-
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
 	    (epf_bar->barno == BAR_5 &&
 	     epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64))
@@ -407,9 +393,9 @@ void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no,
 	if (!epc->ops->clear_bar)
 		return;
 
-	spin_lock_irqsave(&epc->lock, flags);
+	mutex_lock(&epc->lock);
 	epc->ops->clear_bar(epc, func_no, epf_bar);
-	spin_unlock_irqrestore(&epc->lock, flags);
+	mutex_unlock(&epc->lock);
 }
 EXPORT_SYMBOL_GPL(pci_epc_clear_bar);
 
@@ -425,7 +411,6 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no,
 		    struct pci_epf_bar *epf_bar)
 {
 	int ret;
-	unsigned long irq_flags;
 	int flags = epf_bar->flags;
 
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
@@ -440,9 +425,9 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no,
 	if (!epc->ops->set_bar)
 		return 0;
 
-	spin_lock_irqsave(&epc->lock, irq_flags);
+	mutex_lock(&epc->lock);
 	ret = epc->ops->set_bar(epc, func_no, epf_bar);
-	spin_unlock_irqrestore(&epc->lock, irq_flags);
+	mutex_unlock(&epc->lock);
 
 	return ret;
 }
@@ -463,7 +448,6 @@ int pci_epc_write_header(struct pci_epc *epc, u8 func_no,
 			 struct pci_epf_header *header)
 {
 	int ret;
-	unsigned long flags;
 
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
 		return -EINVAL;
@@ -471,9 +455,9 @@ int pci_epc_write_header(struct pci_epc *epc, u8 func_no,
 	if (!epc->ops->write_header)
 		return 0;
 
-	spin_lock_irqsave(&epc->lock, flags);
+	mutex_lock(&epc->lock);
 	ret = epc->ops->write_header(epc, func_no, header);
-	spin_unlock_irqrestore(&epc->lock, flags);
+	mutex_unlock(&epc->lock);
 
 	return ret;
 }
@@ -490,8 +474,6 @@ EXPORT_SYMBOL_GPL(pci_epc_write_header);
  */
 int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf)
 {
-	unsigned long flags;
-
 	if (epf->epc)
 		return -EBUSY;
 
@@ -503,9 +485,9 @@ int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf)
 
 	epf->epc = epc;
 
-	spin_lock_irqsave(&epc->lock, flags);
+	mutex_lock(&epc->lock);
 	list_add_tail(&epf->list, &epc->pci_epf);
-	spin_unlock_irqrestore(&epc->lock, flags);
+	mutex_unlock(&epc->lock);
 
 	return 0;
 }
@@ -520,15 +502,13 @@ EXPORT_SYMBOL_GPL(pci_epc_add_epf);
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
 
@@ -607,7 +587,7 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
 		goto err_ret;
 	}
 
-	spin_lock_init(&epc->lock);
+	mutex_init(&epc->lock);
 	INIT_LIST_HEAD(&epc->pci_epf);
 	ATOMIC_INIT_NOTIFIER_HEAD(&epc->notifier);
 
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index ff9e0b3e5424..97c78464013c 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -89,7 +89,7 @@ struct pci_epc_mem {
  * @mem: address space of the endpoint controller
  * @max_functions: max number of functions that can be configured in this EPC
  * @group: configfs group representing the PCI EPC device
- * @lock: spinlock to protect pci_epc ops
+ * @lock: mutex to protect pci_epc ops
  * @notifier: used to notify EPF of any EPC events (like linkup)
  */
 struct pci_epc {
@@ -99,8 +99,8 @@ struct pci_epc {
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

