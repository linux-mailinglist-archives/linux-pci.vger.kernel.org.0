Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5273F1D341E
	for <lists+linux-pci@lfdr.de>; Thu, 14 May 2020 17:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgENPBR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 May 2020 11:01:17 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36016 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbgENPBQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 May 2020 11:01:16 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04EF0e7k102730;
        Thu, 14 May 2020 10:00:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589468440;
        bh=JTb7YgvROaherg13FvnZRBqflcI4vuUymmflrjhSi4Y=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=IYJF5ySRCYhEZz3qmkRG1jJ0EPpNDP/pEirpobrLA4HeVqY2SxI7O7Auss+m00L4B
         pgR4AeEL2dWRpZvZSwTLRo/UtZTNbH1GOT/FXLnWLIVPi18G34Io5EnNW4sgcFPjeq
         nPw4HSTnl2AJVgMQuJ2HHxsc3/FkIX6tbmWIDeis=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04EF0e3X118803
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 May 2020 10:00:40 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 14
 May 2020 10:00:39 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 14 May 2020 10:00:39 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04EExgAt019279;
        Thu, 14 May 2020 10:00:35 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-pci@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-ntb@googlegroups.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 11/19] PCI: endpoint: Add helper API to populate header with values from DT
Date:   Thu, 14 May 2020 20:29:19 +0530
Message-ID: <20200514145927.17555-12-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200514145927.17555-1-kishon@ti.com>
References: <20200514145927.17555-1-kishon@ti.com>
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
 drivers/pci/endpoint/pci-epc-core.c | 24 ++++++++++++++++++++++++
 include/linux/pci-epc.h             |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index df8789fee01e..31a82af397a3 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -31,6 +31,30 @@ static int devm_pci_epc_match(struct device *dev, void *res, void *match_data)
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
+	of_property_read_u16(node, "epf,vendor-id", &header->vendorid);
+	of_property_read_u16(node, "epf,device-id", &header->deviceid);
+	of_property_read_u8(node, "epf,baseclass-code",
+			    &header->baseclass_code);
+	of_property_read_u8(node, "epf,subclass-code", &header->subclass_code);
+	of_property_read_u16(node, "epf,subsys-vendor-id",
+			     &header->subsys_vendor_id);
+	of_property_read_u16(node, "epf,subsys-id", &header->subsys_id);
+}
+EXPORT_SYMBOL_GPL(pci_epc_of_parse_header);
+
 /**
  * pci_epc_put() - release the PCI endpoint controller
  * @epc: epc returned by pci_epc_get()
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 463586889453..490a9077df52 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -199,6 +199,8 @@ int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no,
 		      enum pci_epc_irq_type type, u16 interrupt_num);
 int pci_epc_start(struct pci_epc *epc);
 void pci_epc_stop(struct pci_epc *epc);
+void pci_epc_of_parse_header(struct device_node *node,
+			     struct pci_epf_header *header);
 const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 						    u8 func_no);
 enum pci_barno
-- 
2.17.1

