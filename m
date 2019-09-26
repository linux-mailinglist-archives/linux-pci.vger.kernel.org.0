Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 075BABF1B3
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2019 13:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfIZLbI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Sep 2019 07:31:08 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50968 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfIZLbH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Sep 2019 07:31:07 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8QBUx71042347;
        Thu, 26 Sep 2019 06:30:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1569497459;
        bh=6Ioi8K1OssG13g6PVxuHfADXQnIy2g3W7qB18SNPWyw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=kRsZTqOy6X2yeu9rr2r5uNAOOTjIm5aO3etgX/liaqU4Tx9hfQ1A+6nUA03R/s102
         9tBofIhk7R3VUP3KSoRPToFB7lZ/ZLfjw9rz4h+xpZstgQtGxRa9MRjh2SlbFHkWvK
         iPS73ogAd3YJX4wd99H+bG47F9nfhmr4ffNPyQJc=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8QBUxYW091258
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Sep 2019 06:30:59 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 26
 Sep 2019 06:30:59 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 26 Sep 2019 06:30:51 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8QBUTjx069017;
        Thu, 26 Sep 2019 06:30:55 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Mark Rutland <mark.rutland@arm.com>, <kishon@ti.com>,
        <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-ntb@googlegroups.com>
Subject: [RFC PATCH 06/21] PCI: endpoint: Add API to create EPF device from device tree
Date:   Thu, 26 Sep 2019 16:59:18 +0530
Message-ID: <20190926112933.8922-7-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926112933.8922-1-kishon@ti.com>
References: <20190926112933.8922-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add API to create EPF device from device tree and the device managed
interface corresponding to it. This is added in order to define
an endpoint function completely from device tree.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-epf-core.c | 68 +++++++++++++++++++++++++++++
 include/linux/pci-epf.h             |  6 +++
 2 files changed, 74 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 16feff8cad50..c74c7cc6d8bd 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -529,6 +529,73 @@ struct pci_epf *pci_epf_create(const char *name)
 }
 EXPORT_SYMBOL_GPL(pci_epf_create);
 
+/**
+ * pci_epf_of_create() - create a new PCI EPF device from device tree node
+ * @node: the device node of the PCI EPF device.
+ *
+ * Invoke to create a new PCI EPF device by providing a device tree node
+ * with compatible property.
+ */
+struct pci_epf *pci_epf_of_create(struct device_node *node)
+{
+	struct pci_epf *epf;
+	const char *compat;
+	int ret;
+
+	of_node_get(node);
+
+	ret = of_property_read_string(node, "compatible", &compat);
+	if (ret) {
+		of_node_put(node);
+		return ERR_PTR(ret);
+	}
+
+	epf = pci_epf_create(compat);
+	if (!IS_ERR(epf))
+		epf->node = node;
+
+	return epf;
+}
+EXPORT_SYMBOL_GPL(pci_epf_of_create);
+
+static void devm_epf_release(struct device *dev, void *res)
+{
+	struct pci_epf *epf = *(struct pci_epf **)res;
+
+	pci_epf_destroy(epf);
+}
+
+/**
+ * devm_pci_epf_of_create() - create a new PCI EPF device from device tree node
+ * @dev: device that is creating the new EPF
+ * @node: the device node of the PCI EPF device.
+ *
+ * Invoke to create a new PCI EPF device by providing a device tree node with
+ * compatible property. While at that, it also associates the device with the
+ * EPF using devres. On driver detach, release function is invoked on the devres
+ * data, where devres data is freed.
+ */
+struct pci_epf *devm_pci_epf_of_create(struct device *dev,
+				       struct device_node *node)
+{
+	struct pci_epf **ptr, *epf;
+
+	ptr = devres_alloc(devm_epf_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	epf = pci_epf_of_create(node);
+	if (!IS_ERR(epf)) {
+		*ptr = epf;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return epf;
+}
+EXPORT_SYMBOL_GPL(devm_pci_epf_of_create);
+
 const struct pci_epf_device_id *
 pci_epf_match_device(const struct pci_epf_device_id *id, struct pci_epf *epf)
 {
@@ -549,6 +616,7 @@ static void pci_epf_dev_release(struct device *dev)
 {
 	struct pci_epf *epf = to_pci_epf(dev);
 
+	of_node_put(epf->node);
 	kfree(epf->name);
 	kfree(epf);
 }
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 02090eb41563..7e997fb656fb 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -11,6 +11,7 @@
 
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
+#include <linux/of.h>
 #include <linux/pci.h>
 
 struct pci_epf;
@@ -101,6 +102,7 @@ struct pci_epf_bar {
 /**
  * struct pci_epf - represents the PCI EPF device
  * @dev: the PCI EPF device
+ * @node: the device tree node of the PCI EPF device
  * @name: the name of the PCI EPF device
  * @header: represents standard configuration header
  * @bar: represents the BAR of EPF device
@@ -125,6 +127,7 @@ struct pci_epf_bar {
  */
 struct pci_epf {
 	struct device		dev;
+	struct device_node	*node;
 	const char		*name;
 	struct pci_epf_header	*header;
 	struct pci_epf_bar	bar[6];
@@ -167,6 +170,9 @@ static inline void *epf_get_drvdata(struct pci_epf *epf)
 const struct pci_epf_device_id *
 pci_epf_match_device(const struct pci_epf_device_id *id, struct pci_epf *epf);
 struct pci_epf *pci_epf_create(const char *name);
+struct pci_epf *pci_epf_of_create(struct device_node *node);
+struct pci_epf *devm_pci_epf_of_create(struct device *dev,
+				       struct device_node *node);
 void pci_epf_destroy(struct pci_epf *epf);
 int __pci_epf_register_driver(struct pci_epf_driver *driver,
 			      struct module *owner);
-- 
2.17.1

