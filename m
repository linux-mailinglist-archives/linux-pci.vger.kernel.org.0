Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFA47D9260
	for <lists+linux-pci@lfdr.de>; Fri, 27 Oct 2023 10:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345645AbjJ0Ino (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Oct 2023 04:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbjJ0Inb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2023 04:43:31 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBD61BCC;
        Fri, 27 Oct 2023 01:42:26 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39R8g4WH124179;
        Fri, 27 Oct 2023 03:42:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1698396124;
        bh=WGO6hjkMHMtX7U62PjVv9kWlUZJFjcfJsN4vTr8Xu5o=;
        h=From:To:CC:Subject:Date;
        b=gvdGeey7NVse+nim+ro0tvPZy5DGZBMZlL4eFZPT8yUdStQJjEHd7myi6UlzhVX/P
         2nZBkiP1PbvIrTsiEAvcYA9sNlMPB66jcLUQxJLVGCDPGnbDsggJ+ARoc9r//3V3eg
         UTmWgRDlC5q3AupyNUJ2dfgSVYGk/m8oJMPFzhS0=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39R8g4i9004917
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Oct 2023 03:42:04 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 27
 Oct 2023 03:42:04 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 27 Oct 2023 03:42:04 -0500
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39R8fxTB012713;
        Fri, 27 Oct 2023 03:42:00 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <u.kleine-koenig@pengutronix.de>
CC:     <fancer.lancer@gmail.com>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <r-gunasekaran@ti.com>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [RFC PATCH] PCI: keystone: Refactor ks_pcie_v3_65_add_bus() functionality
Date:   Fri, 27 Oct 2023 14:11:59 +0530
Message-ID: <20231027084159.4166188-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The .add_bus() callback "ks_pcie_v3_65_add_bus()" exists to setup BAR0 for
MSI configuration. This method is expected to be invoked after the
enumeration of endpoints for the v3.65a DWC PCIe IP Controller.

Based on the discussion at [0], the contents of "ks_pcie_v3_65_add_bus()"
can be moved to the .host_init callback "ks_pcie_host_init()" and the
.add_bus callback within "struct pci_ops ks_pcie_ops" is no longer
required.

Hence, for the v3.65a DWC PCIe IP Controllers (!ks_pcie->is_am6), perform
the MSI specific configuration of BAR0 within "ks_pcie_host_init()"
itself.

[0] https://lore.kernel.org/r/20231019220847.GA1413474@bhelgaas/

Suggested-by: Serge Semin <fancer.lancer@gmail.com>
Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
Hello,

This patch is based on linux-next tagged next-20231027.
This patch depends on the patch at:
https://lore.kernel.org/r/20231019081330.2975470-1-s-vadapalli@ti.com/

Regards,
Siddharth.

 drivers/pci/controller/dwc/pci-keystone.c | 51 ++++++++---------------
 1 file changed, 17 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index e9245b7632c5..369f5e556df3 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -447,44 +447,10 @@ static struct pci_ops ks_child_pcie_ops = {
 	.write = pci_generic_config_write,
 };
 
-/**
- * ks_pcie_v3_65_add_bus() - keystone add_bus post initialization
- * @bus: A pointer to the PCI bus structure.
- *
- * This sets BAR0 to enable inbound access for MSI_IRQ register
- */
-static int ks_pcie_v3_65_add_bus(struct pci_bus *bus)
-{
-	struct dw_pcie_rp *pp = bus->sysdata;
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
-
-	if (!pci_is_root_bus(bus))
-		return 0;
-
-	/* Configure and set up BAR0 */
-	ks_pcie_set_dbi_mode(ks_pcie);
-
-	/* Enable BAR0 */
-	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 1);
-	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, SZ_4K - 1);
-
-	ks_pcie_clear_dbi_mode(ks_pcie);
-
-	 /*
-	  * For BAR0, just setting bus address for inbound writes (MSI) should
-	  * be sufficient.  Use physical address to avoid any conflicts.
-	  */
-	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, ks_pcie->app.start);
-
-	return 0;
-}
-
 static struct pci_ops ks_pcie_ops = {
 	.map_bus = dw_pcie_own_conf_map_bus,
 	.read = pci_generic_config_read,
 	.write = pci_generic_config_write,
-	.add_bus = ks_pcie_v3_65_add_bus,
 };
 
 static struct pci_ops ks_pcie_am6_ops = {
@@ -834,6 +800,23 @@ static int __init ks_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret < 0)
 		return ret;
 
+	if (!ks_pcie->is_am6) {
+		/* Configure and set up BAR0 */
+		ks_pcie_set_dbi_mode(ks_pcie);
+
+		/* Enable BAR0 */
+		dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 1);
+		dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, SZ_4K - 1);
+
+		ks_pcie_clear_dbi_mode(ks_pcie);
+
+		/*
+		 * For BAR0, just setting bus address for inbound writes (MSI) should
+		 * be sufficient.  Use physical address to avoid any conflicts.
+		 */
+		dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, ks_pcie->app.start);
+	}
+
 #ifdef CONFIG_ARM
 	/*
 	 * PCIe access errors that result into OCP errors are caught by ARM as
-- 
2.34.1

