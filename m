Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A51CFBF1BB
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2019 13:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfIZLb2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Sep 2019 07:31:28 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52970 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfIZLb1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Sep 2019 07:31:27 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8QBVKGg016189;
        Thu, 26 Sep 2019 06:31:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1569497480;
        bh=5g6TwgnGUlfofXhn+QvD8y+MT6lDfC7QwOU9sIuCmvU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=EKRJWt69th/MO9ynM8MWbD0RpM+vv+pbGpzNW/t2BbTlgvntevwY28WOnN0R7ex8a
         a5wDsuZXuiwtzpMZ8CC5I8iCPB82iH7dxOEqoZ3LIceK1RCgiYfJZInqAwJz1AYA96
         q9/IMij7CgtySeLwZK/EbKAHKsd3xn40AnOesDYU=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8QBVK37031817
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Sep 2019 06:31:20 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 26
 Sep 2019 06:31:12 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 26 Sep 2019 06:31:12 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8QBUTk4069017;
        Thu, 26 Sep 2019 06:31:16 -0500
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
Subject: [RFC PATCH 11/21] PCI: endpoint: Add helper API to populate header with values from DT
Date:   Thu, 26 Sep 2019 16:59:23 +0530
Message-ID: <20190926112933.8922-12-kishon@ti.com>
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

Add helper API pci_epc_of_parse_header() to populate header with
values from device tree. These values will be written to the
configuration space header in the endpoint controller.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 23 +++++++++++++++++++++++
 include/linux/pci-epc.h             |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 49bdff217777..98acadbfc934 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -31,6 +31,29 @@ static int devm_pci_epc_match(struct device *dev, void *res, void *match_data)
 	return *epc == match_data;
 }
 
+/**
+ * pci_epc_of_parse_header() - parse the device tree to get PCI config space
+ *                             header
+ * @node: The device tree node (of endpoint function) which has the PCI config
+ *        space header values
+ * @header: standard configuration space header fields that has to be populated
+ *
+ * Invoke to populate *header* with the PCI configuration space values populated
+ * in device tree.
+ */
+void pci_epc_of_parse_header(struct device_node *node,
+			     struct pci_epf_header *header)
+{
+	of_property_read_u16(node, "vendor-id", &header->vendorid);
+	of_property_read_u16(node, "device-id", &header->deviceid);
+	of_property_read_u8(node, "baseclass-code", &header->baseclass_code);
+	of_property_read_u8(node, "subclass-code", &header->subclass_code);
+	of_property_read_u16(node, "subsys-vendor-id",
+			     &header->subsys_vendor_id);
+	of_property_read_u16(node, "subsys-id", &header->subsys_id);
+}
+EXPORT_SYMBOL_GPL(pci_epc_of_parse_header);
+
 /**
  * pci_epc_put() - release the PCI endpoint controller
  * @epc: epc returned by pci_epc_get()
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 993b1a55a239..18fff589a881 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -196,6 +196,8 @@ int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		      enum pci_epc_irq_type type, u16 interrupt_num);
 int pci_epc_start(struct pci_epc *epc);
 void pci_epc_stop(struct pci_epc *epc);
+void pci_epc_of_parse_header(struct device_node *node,
+			     struct pci_epf_header *header);
 const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 						    u8 func_no, u8 vfunc_no);
 unsigned int pci_epc_get_first_free_bar(const struct pci_epc_features
-- 
2.17.1

