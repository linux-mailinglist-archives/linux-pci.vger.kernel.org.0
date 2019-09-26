Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA3DBF176
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2019 13:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfIZLbL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Sep 2019 07:31:11 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50980 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfIZLbL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Sep 2019 07:31:11 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8QBV3MU042367;
        Thu, 26 Sep 2019 06:31:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1569497463;
        bh=iaR4/VPvHXdgGcChNIDAglMw0NIfiR18nZfC93JIGCk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=CH27UaMC6h0DmkS/FvOR0OXtMzqrOiA4EgMLJdoReHAUiONQmSOzpuLtbABypp3Iw
         w/ESVD+sCX1JrOR7laHlkzAgYhoNJa6Zw08UycuCcMR1zJ2w4JkmUlHEaW/Fj0+KmC
         5im6Y6NehNR8k3OTnupdbYv/73HI5Uox2WOn9WRI=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8QBV3B5050162
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Sep 2019 06:31:03 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 26
 Sep 2019 06:31:03 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 26 Sep 2019 06:31:03 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8QBUTk0069017;
        Thu, 26 Sep 2019 06:30:59 -0500
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
Subject: [RFC PATCH 07/21] PCI: endpoint: Add "pci-epf-bus" driver
Date:   Thu, 26 Sep 2019 16:59:19 +0530
Message-ID: <20190926112933.8922-8-kishon@ti.com>
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

Add "pci-epf-bus" driver that helps to create EPF device from
device tree. This is added in order to define an endpoint function
completely from device tree.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/Makefile      |  3 +-
 drivers/pci/endpoint/pci-epf-bus.c | 54 ++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/endpoint/pci-epf-bus.c

diff --git a/drivers/pci/endpoint/Makefile b/drivers/pci/endpoint/Makefile
index 95b2fe47e3b0..36cf33cf975c 100644
--- a/drivers/pci/endpoint/Makefile
+++ b/drivers/pci/endpoint/Makefile
@@ -5,4 +5,5 @@
 
 obj-$(CONFIG_PCI_ENDPOINT_CONFIGFS)	+= pci-ep-cfs.o
 obj-$(CONFIG_PCI_ENDPOINT)		+= pci-epc-core.o pci-epf-core.o\
-					   pci-epc-mem.o functions/
+					   pci-epc-mem.o pci-epf-bus.o \
+					   functions/
diff --git a/drivers/pci/endpoint/pci-epf-bus.c b/drivers/pci/endpoint/pci-epf-bus.c
new file mode 100644
index 000000000000..c47eeae7fe7a
--- /dev/null
+++ b/drivers/pci/endpoint/pci-epf-bus.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * PCI Endpoint *Function* Bus Driver
+ *
+ * Copyright (C) 2019 Texas Instruments
+ * Author: Kishon Vijay Abraham I <kishon@ti.com>
+ */
+
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pci-epf.h>
+#include <linux/platform_device.h>
+
+static int pci_epf_bus_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = of_node_get(dev->of_node);
+	struct device_node *child;
+	struct pci_epf *epf;
+
+	for_each_child_of_node(node, child) {
+		epf = devm_pci_epf_of_create(dev, child);
+		if (IS_ERR(epf)) {
+			dev_err(dev, "Failed to create PCI EPF device %s\n",
+				node->full_name);
+			of_node_put(child);
+			break;
+		}
+	}
+	of_node_put(node);
+
+	return 0;
+}
+
+static const struct of_device_id pci_epf_bus_id_table[] = {
+	{ .compatible = "pci-epf-bus" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, pci_epf_bus_id_table);
+
+static struct platform_driver pci_epf_bus_driver = {
+	.probe		= pci_epf_bus_probe,
+	.driver		= {
+		.name	= "pci-epf-bus",
+		.of_match_table = of_match_ptr(pci_epf_bus_id_table),
+	},
+};
+
+module_platform_driver(pci_epf_bus_driver);
+
+MODULE_AUTHOR("Texas Instruments Inc.");
+MODULE_DESCRIPTION("PCI EPF Bus Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

