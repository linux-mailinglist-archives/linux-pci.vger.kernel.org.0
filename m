Return-Path: <linux-pci+bounces-5185-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF71088C577
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 15:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C07B1F60EE4
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 14:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E78313C671;
	Tue, 26 Mar 2024 14:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="igrJ00EC"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE0A13C3F8;
	Tue, 26 Mar 2024 14:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464211; cv=none; b=pS/PcPiT7lOV3MctFFHWXDjQYaMpQyGReAr1xGn3oL4Rf2eHZmmiQYLFlF2YP5x35gncigHEffbL7ln0+ISwKxO0IFaY1Zr1B6S5byqLsgXMgyz7zFeS/OJsDRL8wY/57CGT3BHWYNsLE9PudRkrfYQZT3Ef6t4HwrxlnfI7Klg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464211; c=relaxed/simple;
	bh=dhPNFnXqNz7MyRueA7i8eRJMctZ7L861mSkCd6aiLic=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WStdbNnalX6Mdw+sLmdJWGeyRF3sEaNX+hSD1sFU15mZGbFGAlUJ73b0NJ7/njOpfrLDFcJ7p4C9hYOMEGqFEpoEfIkBcPvfVixlb9clhvemwT9iBVzawDJylbIqC1I7hjNCyTPZS7s47GzhepxrOq8E5ziCVBaqpqMCCNeqLPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=igrJ00EC; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42QEh4et120096;
	Tue, 26 Mar 2024 09:43:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711464184;
	bh=BXUiSRzxDxZfaQUcL26qbyVKdqBilV07vRkMOn/zbh8=;
	h=From:To:CC:Subject:Date;
	b=igrJ00ECxwQaeze00MPcpOWFZhsvQKjWc18mpT5G0Gx+Kk0Zjywmj7+QYUQnk02Vd
	 8DaJQOaXRk1tCE1eNIYK2S/vhgMCvTV2GQtTmr1eq2Ny0PBwIJy+x4Dbwze2XvtwtL
	 YtsdFWQwE4gyYK2IuvaSi0Dnh6kxhyY8jnas8yF4=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42QEh4nc092364
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Mar 2024 09:43:04 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 09:43:04 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Mar 2024 09:43:04 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42QEgxxZ014526;
	Tue, 26 Mar 2024 09:43:00 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <manivannan.sadhasivam@linaro.org>,
        <fancer.lancer@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <cassel@kernel.org>, <dlemoal@kernel.org>,
        <yoshihiro.shimoda.uh@renesas.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v6] PCI: keystone: Fix pci_ops for AM654x SoC
Date: Tue, 26 Mar 2024 20:12:58 +0530
Message-ID: <20240326144258.2404433-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

In the process of converting .scan_bus() callbacks to .add_bus(), the
ks_pcie_v3_65_scan_bus() function was changed to ks_pcie_v3_65_add_bus().
The .scan_bus() method belonged to ks_pcie_host_ops which was specific
to controller version 3.65a, while the .add_bus() method had been added
to ks_pcie_ops which is shared between the controller versions 3.65a and
4.90a. Neither the older ks_pcie_v3_65_scan_bus() method, nor the newer
ks_pcie_v3_65_add_bus() method is applicable to the controller version
4.90a which is present in AM654x SoCs.

Thus, as a fix, move the contents of "ks_pcie_v3_65_add_bus()" to the
.msi_init callback "ks_pcie_msi_host_init()" which is specific to the
3.65a controller. Also, move the definitions of ks_pcie_set_dbi_mode()
and ks_pcie_clear_dbi_mode() above ks_pcie_msi_host_init() in order to
avoid forward declaration.

Fixes: 6ab15b5e7057 ("PCI: dwc: keystone: Convert .scan_bus() callback to use add_bus")
Suggested-by: Serge Semin <fancer.lancer@gmail.com>
Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Suggested-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on linux-next tagged next-20240326.

v5:
https://lore.kernel.org/r/20240326111905.2369778-1-s-vadapalli@ti.com/
Changes since v5:
- Fixed indentation of comment as pointed out by:
  Niklas Cassel <cassel@kernel.org>
  at:
  https://lore.kernel.org/r/ZgLUCqh12RMApzyr@x1-carbon/
- Collected Reviewed-by tag from:
  Niklas Cassel <cassel@kernel.org>

Regards,
Siddharth.

 drivers/pci/controller/dwc/pci-keystone.c | 136 ++++++++++------------
 1 file changed, 60 insertions(+), 76 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 844de4418724..6cb3a4713009 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -245,8 +245,68 @@ static struct irq_chip ks_pcie_msi_irq_chip = {
 	.irq_unmask = ks_pcie_msi_unmask,
 };
 
+/**
+ * ks_pcie_set_dbi_mode() - Set DBI mode to access overlaid BAR mask registers
+ * @ks_pcie: A pointer to the keystone_pcie structure which holds the KeyStone
+ *	     PCIe host controller driver information.
+ *
+ * Since modification of dbi_cs2 involves different clock domain, read the
+ * status back to ensure the transition is complete.
+ */
+static void ks_pcie_set_dbi_mode(struct keystone_pcie *ks_pcie)
+{
+	u32 val;
+
+	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
+	val |= DBI_CS2;
+	ks_pcie_app_writel(ks_pcie, CMD_STATUS, val);
+
+	do {
+		val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
+	} while (!(val & DBI_CS2));
+}
+
+/**
+ * ks_pcie_clear_dbi_mode() - Disable DBI mode
+ * @ks_pcie: A pointer to the keystone_pcie structure which holds the KeyStone
+ *	     PCIe host controller driver information.
+ *
+ * Since modification of dbi_cs2 involves different clock domain, read the
+ * status back to ensure the transition is complete.
+ */
+static void ks_pcie_clear_dbi_mode(struct keystone_pcie *ks_pcie)
+{
+	u32 val;
+
+	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
+	val &= ~DBI_CS2;
+	ks_pcie_app_writel(ks_pcie, CMD_STATUS, val);
+
+	do {
+		val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
+	} while (val & DBI_CS2);
+}
+
 static int ks_pcie_msi_host_init(struct dw_pcie_rp *pp)
 {
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
+
+	/* Configure and set up BAR0 */
+	ks_pcie_set_dbi_mode(ks_pcie);
+
+	/* Enable BAR0 */
+	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 1);
+	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, SZ_4K - 1);
+
+	ks_pcie_clear_dbi_mode(ks_pcie);
+
+	/*
+	 * For BAR0, just setting bus address for inbound writes (MSI) should
+	 * be sufficient.  Use physical address to avoid any conflicts.
+	 */
+	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, ks_pcie->app.start);
+
 	pp->msi_irq_chip = &ks_pcie_msi_irq_chip;
 	return dw_pcie_allocate_domains(pp);
 }
@@ -340,48 +400,6 @@ static const struct irq_domain_ops ks_pcie_intx_irq_domain_ops = {
 	.xlate = irq_domain_xlate_onetwocell,
 };
 
-/**
- * ks_pcie_set_dbi_mode() - Set DBI mode to access overlaid BAR mask registers
- * @ks_pcie: A pointer to the keystone_pcie structure which holds the KeyStone
- *	     PCIe host controller driver information.
- *
- * Since modification of dbi_cs2 involves different clock domain, read the
- * status back to ensure the transition is complete.
- */
-static void ks_pcie_set_dbi_mode(struct keystone_pcie *ks_pcie)
-{
-	u32 val;
-
-	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
-	val |= DBI_CS2;
-	ks_pcie_app_writel(ks_pcie, CMD_STATUS, val);
-
-	do {
-		val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
-	} while (!(val & DBI_CS2));
-}
-
-/**
- * ks_pcie_clear_dbi_mode() - Disable DBI mode
- * @ks_pcie: A pointer to the keystone_pcie structure which holds the KeyStone
- *	     PCIe host controller driver information.
- *
- * Since modification of dbi_cs2 involves different clock domain, read the
- * status back to ensure the transition is complete.
- */
-static void ks_pcie_clear_dbi_mode(struct keystone_pcie *ks_pcie)
-{
-	u32 val;
-
-	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
-	val &= ~DBI_CS2;
-	ks_pcie_app_writel(ks_pcie, CMD_STATUS, val);
-
-	do {
-		val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
-	} while (val & DBI_CS2);
-}
-
 static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
 {
 	u32 val;
@@ -445,44 +463,10 @@ static struct pci_ops ks_child_pcie_ops = {
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
 
 /**
-- 
2.40.1


