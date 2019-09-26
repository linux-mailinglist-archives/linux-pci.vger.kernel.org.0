Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA96BF16F
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2019 13:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfIZLbD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Sep 2019 07:31:03 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52866 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfIZLbD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Sep 2019 07:31:03 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8QBUtqC016119;
        Thu, 26 Sep 2019 06:30:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1569497455;
        bh=4zHnlcPjrtmbIQZ9Yub799bUIN/qndEfK5n4s1oKXSI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=OXXAw2TFU4DSgE1N4jo04YQO4YG5zvgFHh+qqrW7hdrV+biWQ8dH3MgfMmNc8Sy4d
         a5l49OEt1+qsAx1AirKy6mLmtoZ35nV5X6+0wR+nssdV/NQC8THLpKJsOya90wEBBg
         sD0cmrZXN/BFL+qJ87zvgXL0xlonrjROSogStJLY=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8QBUt7o030976
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Sep 2019 06:30:55 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 26
 Sep 2019 06:30:47 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 26 Sep 2019 06:30:54 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8QBUTjw069017;
        Thu, 26 Sep 2019 06:30:51 -0500
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
Subject: [RFC PATCH 05/21] PCI: endpoint: Add API to get reference to EPC from device-tree
Date:   Thu, 26 Sep 2019 16:59:17 +0530
Message-ID: <20190926112933.8922-6-kishon@ti.com>
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

Add of_pci_epc_get() and of_pci_epc_get_by_name() to get reference
to EPC from device-tree. This is added in preparation to define
an endpoint function from device tree.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 61 +++++++++++++++++++++++++++++
 include/linux/pci-epc.h             |  4 +-
 2 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 5bc094093a47..0c2fdd39090c 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -83,6 +83,66 @@ struct pci_epc *pci_epc_get(const char *epc_name)
 }
 EXPORT_SYMBOL_GPL(pci_epc_get);
 
+/**
+ * of_pci_epc_get() - get PCI endpoint controller from device node and index
+ * @node: device node which contains the phandle to endpoint controller
+ * @index: index of the endpoint controller in "epcs" property
+ *
+ * Returns the EPC corresponding to the _index_ entry in "epcs" property
+ * present in device node, after getting a refcount  to it or -ENODEV if
+ * there is no such EPC or -EPROBE_DEFER if there is a phandle to the phy,
+ * but the device is not yet loaded.
+ */
+struct pci_epc *of_pci_epc_get(struct device_node *node, int index)
+{
+	struct device_node *epc_node;
+	struct class_dev_iter iter;
+	struct pci_epc *epc;
+	struct device *dev;
+
+	epc_node = of_parse_phandle(node, "epcs", index);
+	if (!epc_node)
+		return ERR_PTR(-ENODEV);
+
+	class_dev_iter_init(&iter, pci_epc_class, NULL, NULL);
+	while ((dev = class_dev_iter_next(&iter))) {
+		epc = to_pci_epc(dev);
+		if (epc_node != epc->dev.of_node)
+			continue;
+
+		of_node_put(epc_node);
+		class_dev_iter_exit(&iter);
+		get_device(&epc->dev);
+		return epc;
+	}
+
+	of_node_put(node);
+	class_dev_iter_exit(&iter);
+	return ERR_PTR(-EPROBE_DEFER);
+}
+EXPORT_SYMBOL_GPL(of_pci_epc_get);
+
+/**
+ * of_pci_epc_get_by_name() - get PCI endpoint controller from device node
+ *                            and string
+ * @node: device node which contains the phandle to endpoint controller
+ * @epc_name: name of endpoint controller as present in "epc-names" property
+ *
+ * Returns the EPC corresponding to the epc_name in "epc-names" property
+ * present in device node.
+ */
+struct pci_epc *of_pci_epc_get_by_name(struct device_node *node,
+				       const char *epc_name)
+{
+	int index = 0;
+
+	if (epc_name)
+		index = of_property_match_string(node, "epc-names", epc_name);
+
+	return of_pci_epc_get(node, index);
+}
+EXPORT_SYMBOL_GPL(of_pci_epc_get_by_name);
+
 /**
  * pci_epc_get_first_free_bar() - helper to get first unreserved BAR
  * @epc_features: pci_epc_features structure that holds the reserved bar bitmap
@@ -661,6 +721,7 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
 	device_initialize(&epc->dev);
 	epc->dev.class = pci_epc_class;
 	epc->dev.parent = dev;
+	epc->dev.of_node = dev->of_node;
 	epc->ops = ops;
 
 	ret = dev_set_name(&epc->dev, "%s", dev_name(dev));
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 0fff52675a6b..ef6531af6ed2 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -202,7 +202,9 @@ unsigned int pci_epc_get_first_free_bar(const struct pci_epc_features
 					*epc_features);
 struct pci_epc *pci_epc_get(const char *epc_name);
 void pci_epc_put(struct pci_epc *epc);
-
+struct pci_epc *of_pci_epc_get(struct device_node *node, int index);
+struct pci_epc *of_pci_epc_get_by_name(struct device_node *node,
+				       const char *epc_name);
 int __pci_epc_mem_init(struct pci_epc *epc, phys_addr_t phys_addr, size_t size,
 		       size_t page_size);
 void pci_epc_mem_exit(struct pci_epc *epc);
-- 
2.17.1

