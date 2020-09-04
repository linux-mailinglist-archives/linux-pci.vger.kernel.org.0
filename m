Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472F825D2FC
	for <lists+linux-pci@lfdr.de>; Fri,  4 Sep 2020 09:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbgIDHvu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Sep 2020 03:51:50 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43586 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729832AbgIDHvs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Sep 2020 03:51:48 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0847pVRm090591;
        Fri, 4 Sep 2020 02:51:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599205891;
        bh=61uFu7DXWol1ihX5PVE9vYllDbMmKz2Vc4edreznYPg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wp9iFOh6aWNfUx8hPEt5TWCdnIvK6utSirv4TQoWB4ragLWDmpEm0A67Qf/nHFsz9
         YohfrSwjBY70KuzD9BeBM/f2ckXNDY4jpFM8pfhyk+CTc4X2yRaqx90Rw1rHYwcgtM
         YvIrodcj+f1lFEz0aPVkXe+emVyEFrx8Dg0HkqI8=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0847pVH9025758
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Sep 2020 02:51:31 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 4 Sep
 2020 02:51:31 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 4 Sep 2020 02:51:31 -0500
Received: from a0393678-ssd.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0847osN7058796;
        Fri, 4 Sep 2020 02:51:26 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, Rob Herring <robh@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tom Joseph <tjoseph@cadence.com>, <linux-pci@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ntb@googlegroups.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 06/17] PCI: endpoint: Add support to associate secondary EPC with EPF
Date:   Fri, 4 Sep 2020 13:20:41 +0530
Message-ID: <20200904075052.8911-7-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904075052.8911-1-kishon@ti.com>
References: <20200904075052.8911-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In the case of standard endpoint functions, only one endpoint
controller (EPC) will be associated with an endpoint function
(EPF). However for providing NTB (non transparent bridge)
functionality, two EPCs should be associated with a single EPF.
Add support to associate secondary EPC with EPF. This is in
preparation for adding NTB endpoint function driver.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 11 ++--
 drivers/pci/endpoint/pci-ep-cfs.c             |  6 +-
 drivers/pci/endpoint/pci-epc-core.c           | 50 ++++++++++++----
 drivers/pci/endpoint/pci-epf-core.c           | 57 +++++++++++++------
 include/linux/pci-epc.h                       | 25 +++++++-
 include/linux/pci-epf.h                       | 17 +++++-
 6 files changed, 128 insertions(+), 38 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 7a1f3abfde48..c0ac4e9cbe72 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -619,7 +619,8 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 
 		if (epf_test->reg[bar]) {
 			pci_epc_clear_bar(epc, epf->func_no, epf_bar);
-			pci_epf_free_space(epf, epf_test->reg[bar], bar);
+			pci_epf_free_space(epf, epf_test->reg[bar], bar,
+					   PRIMARY_INTERFACE);
 		}
 	}
 }
@@ -651,7 +652,8 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 
 		ret = pci_epc_set_bar(epc, epf->func_no, epf_bar);
 		if (ret) {
-			pci_epf_free_space(epf, epf_test->reg[bar], bar);
+			pci_epf_free_space(epf, epf_test->reg[bar], bar,
+					   PRIMARY_INTERFACE);
 			dev_err(dev, "Failed to set BAR%d\n", bar);
 			if (bar == test_reg_bar)
 				return ret;
@@ -771,7 +773,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	}
 
 	base = pci_epf_alloc_space(epf, test_reg_size, test_reg_bar,
-				   epc_features->align);
+				   epc_features->align, PRIMARY_INTERFACE);
 	if (!base) {
 		dev_err(dev, "Failed to allocated register space\n");
 		return -ENOMEM;
@@ -789,7 +791,8 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 			continue;
 
 		base = pci_epf_alloc_space(epf, bar_size[bar], bar,
-					   epc_features->align);
+					   epc_features->align,
+					   PRIMARY_INTERFACE);
 		if (!base)
 			dev_err(dev, "Failed to allocate space for BAR%d\n",
 				bar);
diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index 3710adf51912..6ca9e2f92460 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -94,13 +94,13 @@ static int pci_epc_epf_link(struct config_item *epc_item,
 	struct pci_epc *epc = epc_group->epc;
 	struct pci_epf *epf = epf_group->epf;
 
-	ret = pci_epc_add_epf(epc, epf);
+	ret = pci_epc_add_epf(epc, epf, PRIMARY_INTERFACE);
 	if (ret)
 		return ret;
 
 	ret = pci_epf_bind(epf);
 	if (ret) {
-		pci_epc_remove_epf(epc, epf);
+		pci_epc_remove_epf(epc, epf, PRIMARY_INTERFACE);
 		return ret;
 	}
 
@@ -120,7 +120,7 @@ static void pci_epc_epf_unlink(struct config_item *epc_item,
 	epc = epc_group->epc;
 	epf = epf_group->epf;
 	pci_epf_unbind(epf);
-	pci_epc_remove_epf(epc, epf);
+	pci_epc_remove_epf(epc, epf, PRIMARY_INTERFACE);
 }
 
 static struct configfs_item_operations pci_epc_item_ops = {
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index ea7e7465ce7a..0f6e2364ae6f 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -493,22 +493,32 @@ EXPORT_SYMBOL_GPL(pci_epc_write_header);
  * pci_epc_add_epf() - bind PCI endpoint function to an endpoint controller
  * @epc: the EPC device to which the endpoint function should be added
  * @epf: the endpoint function to be added
+ * @type: Identifies if the EPC is connected to the primary or secondary
+ *        interface of EPF
  *
  * A PCI endpoint device can have one or more functions. In the case of PCIe,
  * the specification allows up to 8 PCIe endpoint functions. Invoke
  * pci_epc_add_epf() to add a PCI endpoint function to an endpoint controller.
  */
-int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf)
+int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf,
+		    enum pci_epc_interface_type type)
 {
+	struct list_head *list;
 	u32 func_no;
 	int ret = 0;
 
-	if (epf->epc)
-		return -EBUSY;
-
 	if (IS_ERR(epc))
 		return -EINVAL;
 
+	if (epf->func_no > epc->max_functions - 1)
+		return -EINVAL;
+
+	if (type == PRIMARY_INTERFACE && epf->epc)
+		return -EBUSY;
+
+	if (type == SECONDARY_INTERFACE && epf->sec_epc)
+		return -EBUSY;
+
 	mutex_lock(&epc->lock);
 	func_no = find_first_zero_bit(&epc->function_num_map,
 				      BITS_PER_LONG);
@@ -524,11 +534,17 @@ int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf)
 	}
 
 	set_bit(func_no, &epc->function_num_map);
-	epf->func_no = func_no;
-	epf->epc = epc;
-
-	list_add_tail(&epf->list, &epc->pci_epf);
+	if (type == PRIMARY_INTERFACE) {
+		epf->func_no = func_no;
+		epf->epc = epc;
+		list = &epf->list;
+	} else {
+		epf->sec_epc_func_no = func_no;
+		epf->sec_epc = epc;
+		list = &epf->sec_epc_list;
+	}
 
+	list_add_tail(list, &epc->pci_epf);
 ret:
 	mutex_unlock(&epc->lock);
 
@@ -543,14 +559,26 @@ EXPORT_SYMBOL_GPL(pci_epc_add_epf);
  *
  * Invoke to remove PCI endpoint function from the endpoint controller.
  */
-void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf)
+void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf,
+			enum pci_epc_interface_type type)
 {
+	struct list_head *list;
+	u32 func_no = 0;
+
 	if (!epc || IS_ERR(epc) || !epf)
 		return;
 
+	if (type == PRIMARY_INTERFACE) {
+		func_no = epf->func_no;
+		list = &epf->list;
+	} else {
+		func_no = epf->sec_epc_func_no;
+		list = &epf->sec_epc_list;
+	}
+
 	mutex_lock(&epc->lock);
-	clear_bit(epf->func_no, &epc->function_num_map);
-	list_del(&epf->list);
+	clear_bit(func_no, &epc->function_num_map);
+	list_del(list);
 	epf->epc = NULL;
 	mutex_unlock(&epc->lock);
 }
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index e44a317a2a2a..79329ec6373c 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -74,24 +74,37 @@ EXPORT_SYMBOL_GPL(pci_epf_bind);
  * @epf: the EPF device from whom to free the memory
  * @addr: the virtual address of the PCI EPF register space
  * @bar: the BAR number corresponding to the register space
+ * @type: Identifies if the allocated space is for primary EPC or secondary EPC
  *
  * Invoke to free the allocated PCI EPF register space.
  */
-void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar)
+void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
+			enum pci_epc_interface_type type)
 {
 	struct device *dev = epf->epc->dev.parent;
+	struct pci_epf_bar *epf_bar;
+	struct pci_epc *epc;
 
 	if (!addr)
 		return;
 
-	dma_free_coherent(dev, epf->bar[bar].size, addr,
-			  epf->bar[bar].phys_addr);
+	if (type == PRIMARY_INTERFACE) {
+		epc = epf->epc;
+		epf_bar = epf->bar;
+	} else {
+		epc = epf->sec_epc;
+		epf_bar = epf->sec_epc_bar;
+	}
+
+	dev = epc->dev.parent;
+	dma_free_coherent(dev, epf_bar[bar].size, addr,
+			  epf_bar[bar].phys_addr);
 
-	epf->bar[bar].phys_addr = 0;
-	epf->bar[bar].addr = NULL;
-	epf->bar[bar].size = 0;
-	epf->bar[bar].barno = 0;
-	epf->bar[bar].flags = 0;
+	epf_bar[bar].phys_addr = 0;
+	epf_bar[bar].addr = NULL;
+	epf_bar[bar].size = 0;
+	epf_bar[bar].barno = 0;
+	epf_bar[bar].flags = 0;
 }
 EXPORT_SYMBOL_GPL(pci_epf_free_space);
 
@@ -101,15 +114,18 @@ EXPORT_SYMBOL_GPL(pci_epf_free_space);
  * @size: the size of the memory that has to be allocated
  * @bar: the BAR number corresponding to the allocated register space
  * @align: alignment size for the allocation region
+ * @type: Identifies if the allocation is for primary EPC or secondary EPC
  *
  * Invoke to allocate memory for the PCI EPF register space.
  */
 void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
-			  size_t align)
+			  size_t align, enum pci_epc_interface_type type)
 {
-	void *space;
-	struct device *dev = epf->epc->dev.parent;
+	struct pci_epf_bar *epf_bar;
 	dma_addr_t phys_addr;
+	struct pci_epc *epc;
+	struct device *dev;
+	void *space;
 
 	if (size < 128)
 		size = 128;
@@ -119,17 +135,26 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 	else
 		size = roundup_pow_of_two(size);
 
+	if (type == PRIMARY_INTERFACE) {
+		epc = epf->epc;
+		epf_bar = epf->bar;
+	} else {
+		epc = epf->sec_epc;
+		epf_bar = epf->sec_epc_bar;
+	}
+
+	dev = epc->dev.parent;
 	space = dma_alloc_coherent(dev, size, &phys_addr, GFP_KERNEL);
 	if (!space) {
 		dev_err(dev, "failed to allocate mem space\n");
 		return NULL;
 	}
 
-	epf->bar[bar].phys_addr = phys_addr;
-	epf->bar[bar].addr = space;
-	epf->bar[bar].size = size;
-	epf->bar[bar].barno = bar;
-	epf->bar[bar].flags |= upper_32_bits(size) ?
+	epf_bar[bar].phys_addr = phys_addr;
+	epf_bar[bar].addr = space;
+	epf_bar[bar].size = size;
+	epf_bar[bar].barno = bar;
+	epf_bar[bar].flags |= upper_32_bits(size) ?
 				PCI_BASE_ADDRESS_MEM_TYPE_64 :
 				PCI_BASE_ADDRESS_MEM_TYPE_32;
 
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 88d311bad984..d9cb3944fb87 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -13,6 +13,12 @@
 
 struct pci_epc;
 
+enum pci_epc_interface_type {
+	UNKNOWN_INTERFACE = -1,
+	PRIMARY_INTERFACE,
+	SECONDARY_INTERFACE,
+};
+
 enum pci_epc_irq_type {
 	PCI_EPC_IRQ_UNKNOWN,
 	PCI_EPC_IRQ_LEGACY,
@@ -20,6 +26,19 @@ enum pci_epc_irq_type {
 	PCI_EPC_IRQ_MSIX,
 };
 
+static inline const char *
+pci_epc_interface_string(enum pci_epc_interface_type type)
+{
+	switch (type) {
+	case PRIMARY_INTERFACE:
+		return "primary";
+	case SECONDARY_INTERFACE:
+		return "secondary";
+	default:
+		return "UNKNOWN interface";
+	}
+}
+
 /**
  * struct pci_epc_ops - set of function pointers for performing EPC operations
  * @write_header: ops to populate configuration space header
@@ -175,10 +194,12 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
 		 struct module *owner);
 void devm_pci_epc_destroy(struct device *dev, struct pci_epc *epc);
 void pci_epc_destroy(struct pci_epc *epc);
-int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf);
+int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf,
+		    enum pci_epc_interface_type type);
 void pci_epc_linkup(struct pci_epc *epc);
 void pci_epc_init_notify(struct pci_epc *epc);
-void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf);
+void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf,
+			enum pci_epc_interface_type type);
 int pci_epc_write_header(struct pci_epc *epc, u8 func_no,
 			 struct pci_epf_header *hdr);
 int pci_epc_set_bar(struct pci_epc *epc, u8 func_no,
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index f373a134ac04..1dc66824f5a8 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -14,6 +14,7 @@
 #include <linux/pci.h>
 
 struct pci_epf;
+enum pci_epc_interface_type;
 
 enum pci_notify_event {
 	CORE_INIT,
@@ -119,6 +120,11 @@ struct pci_epf_bar {
  * @list: to add pci_epf as a list of PCI endpoint functions to pci_epc
  * @nb: notifier block to notify EPF of any EPC events (like linkup)
  * @lock: mutex to protect pci_epf_ops
+ * @sec_epc: the secondary EPC device to which this EPF device is bound
+ * @sec_epc_list: to add pci_epf as list of PCI endpoint functions to secondary
+ *   EPC device
+ * @sec_epc_bar: represents the BAR of EPF device associated with secondary EPC
+ * @sec_epc_func_no: unique (physical) function number within the secondary EPC
  */
 struct pci_epf {
 	struct device		dev;
@@ -135,6 +141,12 @@ struct pci_epf {
 	struct notifier_block   nb;
 	/* mutex to protect against concurrent access of pci_epf_ops */
 	struct mutex		lock;
+
+	/* Below members are to attach secondary EPC to an endpoint function */
+	struct pci_epc		*sec_epc;
+	struct list_head	sec_epc_list;
+	struct pci_epf_bar	sec_epc_bar[6];
+	u8			sec_epc_func_no;
 };
 
 /**
@@ -171,8 +183,9 @@ int __pci_epf_register_driver(struct pci_epf_driver *driver,
 			      struct module *owner);
 void pci_epf_unregister_driver(struct pci_epf_driver *driver);
 void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
-			  size_t align);
-void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar);
+			  size_t align, enum pci_epc_interface_type type);
+void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
+			enum pci_epc_interface_type type);
 int pci_epf_bind(struct pci_epf *epf);
 void pci_epf_unbind(struct pci_epf *epf);
 #endif /* __LINUX_PCI_EPF_H */
-- 
2.17.1

