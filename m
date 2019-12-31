Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B62D12D851
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2019 12:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfLaLeS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Dec 2019 06:34:18 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:32806 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfLaLeQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Dec 2019 06:34:16 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBVBXtKW097725;
        Tue, 31 Dec 2019 05:33:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577792035;
        bh=5snp5fw9QLv4HKFNhn1dH0ZAh+BCRnwFffHokQkHm90=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=XSuHH6c/BEl5e2sWtHa0C8LwveIO45b5D8UjDzRr/sgOEn8PJa7IQZiTrMfkp3v/p
         RMtds1fz+0KG1ZpItrdJF68ckRxfuN8Y6Snu8vVqxtrJ2IMfb61LC/Q9c5jaKC2EWo
         ttn2lBY+fyw87iteXhwBVWI6hOx5anWMavUlhN2c=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBVBXtOK090274
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 31 Dec 2019 05:33:55 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 31
 Dec 2019 05:33:55 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 31 Dec 2019 05:33:55 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBVBXX34024759;
        Tue, 31 Dec 2019 05:33:50 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 3/7] PCI: endpoint: Add support to add virtual function in endpoint core
Date:   Tue, 31 Dec 2019 17:05:30 +0530
Message-ID: <20191231113534.30405-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191231113534.30405-1-kishon@ti.com>
References: <20191231113534.30405-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to add virtual function in endpoint core. The virtual
function can only be associated with a physical function instead of a
endpoint controller. Provide APIs to associate a virtual function with
a physical function here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-epc-core.c |  2 +-
 drivers/pci/endpoint/pci-epf-core.c | 92 ++++++++++++++++++++++++++++-
 include/linux/pci-epf.h             | 16 ++++-
 3 files changed, 107 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 13c03ccb39ac..fef8a212cbd9 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -477,7 +477,7 @@ int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf)
 	u32 func_no;
 	int ret = 0;
 
-	if (epf->epc)
+	if (epf->epc || epf->is_vf)
 		return -EBUSY;
 
 	if (IS_ERR(epc))
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 244e00f48c5c..3e0f94b47901 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -30,13 +30,20 @@ static const struct device_type pci_epf_type;
  */
 void pci_epf_unbind(struct pci_epf *epf)
 {
+	struct pci_epf *epf_vf;
+
 	if (!epf->driver) {
 		dev_WARN(&epf->dev, "epf device not bound to driver\n");
 		return;
 	}
 
 	mutex_lock(&epf->lock);
-	epf->driver->ops->unbind(epf);
+	list_for_each_entry(epf_vf, &epf->pci_vepf, list) {
+		if (epf_vf->is_bound)
+			epf_vf->driver->ops->unbind(epf_vf);
+	}
+	if (epf->is_bound)
+		epf->driver->ops->unbind(epf);
 	mutex_unlock(&epf->lock);
 	module_put(epf->driver->owner);
 }
@@ -51,6 +58,7 @@ EXPORT_SYMBOL_GPL(pci_epf_unbind);
  */
 int pci_epf_bind(struct pci_epf *epf)
 {
+	struct pci_epf *epf_vf;
 	int ret;
 
 	if (!epf->driver) {
@@ -62,13 +70,91 @@ int pci_epf_bind(struct pci_epf *epf)
 		return -EAGAIN;
 
 	mutex_lock(&epf->lock);
+	list_for_each_entry(epf_vf, &epf->pci_vepf, list) {
+		epf_vf->func_no = epf->func_no;
+		epf_vf->epc = epf->epc;
+		ret = epf_vf->driver->ops->bind(epf_vf);
+		if (ret)
+			goto ret;
+		epf_vf->is_bound = true;
+	}
+
 	ret = epf->driver->ops->bind(epf);
+	if (ret)
+		goto ret;
+	epf->is_bound = true;
+
+	mutex_unlock(&epf->lock);
+	return 0;
+
+ret:
 	mutex_unlock(&epf->lock);
+	pci_epf_unbind(epf);
 
 	return ret;
 }
 EXPORT_SYMBOL_GPL(pci_epf_bind);
 
+/**
+ * pci_epf_add_vepf() - associate virtual EP function to physical EP function
+ * @epf_pf: the physical EP function to which the virtual EP function should be
+ *   associated
+ * @epf_vf: the virtual EP function to be added
+ *
+ * A physical endpoint function can be associated with multiple virtual
+ * endpoint functions. Invoke pci_epf_add_epf() to add a virtual PCI endpoint
+ * function to a physical PCI endpoint function.
+ */
+int pci_epf_add_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf)
+{
+	u32 vfunc_no;
+
+	if (IS_ERR_OR_NULL(epf_pf) || IS_ERR_OR_NULL(epf_vf))
+		return -EINVAL;
+
+	if (epf_pf->epc || epf_vf->epc || epf_vf->epf_pf)
+		return -EBUSY;
+
+	mutex_lock(&epf_pf->lock);
+	vfunc_no = find_first_zero_bit(&epf_pf->vfunction_num_map,
+				       BITS_PER_LONG);
+	if (vfunc_no >= BITS_PER_LONG)
+		return -EINVAL;
+
+	set_bit(vfunc_no, &epf_pf->vfunction_num_map);
+	epf_vf->vfunc_no = vfunc_no;
+
+	epf_vf->epf_pf = epf_pf;
+	epf_vf->is_vf = true;
+
+	list_add_tail(&epf_vf->list, &epf_pf->pci_vepf);
+	mutex_unlock(&epf_pf->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_epf_add_vepf);
+
+/**
+ * pci_epf_remove_vepf() - remove virtual EP function from physical EP function
+ * @epf_pf: the physical EP function from which the virtual EP function should
+ *   be removed
+ * @epf_vf: the virtual EP function to be removed
+ *
+ * Invoke to remove a virtual endpoint function from the physcial endpoint
+ * function.
+ */
+void pci_epf_remove_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf)
+{
+	if (IS_ERR_OR_NULL(epf_pf) || IS_ERR_OR_NULL(epf_vf))
+		return;
+
+	mutex_lock(&epf_pf->lock);
+	clear_bit(epf_vf->vfunc_no, &epf_pf->vfunction_num_map);
+	list_del(&epf_vf->list);
+	mutex_unlock(&epf_pf->lock);
+}
+EXPORT_SYMBOL_GPL(pci_epf_remove_vepf);
+
 /**
  * pci_epf_free_space() - free the allocated PCI EPF register space
  * @addr: the virtual address of the PCI EPF register space
@@ -258,6 +344,10 @@ struct pci_epf *pci_epf_create(const char *name)
 		return ERR_PTR(-ENOMEM);
 	}
 
+	/* VFs are numbered starting with 1. So set BIT(0) by default */
+	epf->vfunction_num_map = 1;
+	INIT_LIST_HEAD(&epf->pci_vepf);
+
 	dev = &epf->dev;
 	device_initialize(dev);
 	dev->bus = &pci_epf_bus_type;
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index efbc08a153ff..9544ce81d8fb 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -107,12 +107,18 @@ struct pci_epf_bar {
  * @header: represents standard configuration header
  * @bar: represents the BAR of EPF device
  * @msi_interrupts: number of MSI interrupts required by this function
- * @func_no: unique function number within this endpoint device
+ * @func_no: unique (physical) function number within this endpoint device
+ * @vfunc_no: unique virtual function number within a physical function
  * @epc: the EPC device to which this EPF device is bound
+ * @epf_pf: the physical EPF device to which this virtual EPF device is bound
  * @driver: the EPF driver to which this EPF device is bound
  * @list: to add pci_epf as a list of PCI endpoint functions to pci_epc
  * @nb: notifier block to notify EPF of any EPC events (like linkup)
  * @lock: mutex to protect pci_epf_ops
+ * @is_bound: indicates if bind notification to function driver has been invoked
+ * @is_vf: true - virtual function, false - physical function
+ * @vfunction_num_map: bitmap to manage virtual function number
+ * @pci_vepf: list of virtual endpoint functions associated with this function
  */
 struct pci_epf {
 	struct device		dev;
@@ -122,13 +128,19 @@ struct pci_epf {
 	u8			msi_interrupts;
 	u16			msix_interrupts;
 	u8			func_no;
+	u8			vfunc_no;
 
 	struct pci_epc		*epc;
+	struct pci_epf		*epf_pf;
 	struct pci_epf_driver	*driver;
 	struct list_head	list;
 	struct notifier_block   nb;
 	/* mutex to protect against concurrent access of pci_epf_ops */
 	struct mutex		lock;
+	unsigned int		is_bound;
+	unsigned int		is_vf;
+	unsigned long		vfunction_num_map;
+	struct list_head	pci_vepf;
 };
 
 /**
@@ -171,4 +183,6 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar);
 int pci_epf_bind(struct pci_epf *epf);
 void pci_epf_unbind(struct pci_epf *epf);
+int pci_epf_add_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);
+void pci_epf_remove_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);
 #endif /* __LINUX_PCI_EPF_H */
-- 
2.17.1

