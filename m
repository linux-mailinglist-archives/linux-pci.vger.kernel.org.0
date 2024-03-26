Return-Path: <linux-pci+bounces-5174-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0516B88C077
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 12:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 287D31C3918C
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 11:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C6352F9A;
	Tue, 26 Mar 2024 11:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EGPWxTO4"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B675ED52F;
	Tue, 26 Mar 2024 11:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711451987; cv=none; b=rKAMPlNIz9coFMUjLXo2SrL2cWBbhLfpuP/CojCoMOT21SMhZR11EMm6rbI0yIBZt3Js0B/8OyRLoxKmIK3guUmKHfOzKiKfpROTbj7m8Y59wjA7MXEJrLUP0GNZOcD0LsgQxphdE4lnUhI1cPaCfUKBSZv39uN1BbRSPESPkEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711451987; c=relaxed/simple;
	bh=7SlessXmpKbUw4x9qtYMQC/384pim9FWhT6D7s2udQU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MV6LtPNTou3uhrAx3jPZGW940plxXtJlw60oviy4zJwwXBrzK0k17M8zP4ndviyWS5a6TyTP9YzL3F+hNFTg88T/kfaxQbX82YcVubXTQ6hEZd3WSj5hdoVzS4RbhchxhvH8pCi6o/8DJ9TbkSBq2LUpLBKKh3qG3VjDroqNs8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EGPWxTO4; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42QBJBYN079548;
	Tue, 26 Mar 2024 06:19:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711451951;
	bh=UD5RskTHbTr+klutH2EjFpSxwTDCx/MxCy8/6NDq45k=;
	h=From:To:CC:Subject:Date;
	b=EGPWxTO4x8D5m2SADzaMZ4kbR+Y+mnTpyRU9Z64O9XtiVNW+KSwvNOqy83VdtpsIO
	 8aWyKGPKtE6X3JtLUH0Q0Aq9SagtB+HEV5yqIuwJJ56bJQboqyaxVhC/E/SgkWuL+M
	 tLVQiOltMdVAdKoRf//K7o/Wy5Mj6a46A5wxTOFc=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42QBJB0C024929
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Mar 2024 06:19:11 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 06:19:11 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Mar 2024 06:19:11 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42QBJ6o0094889;
	Tue, 26 Mar 2024 06:19:07 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <manivannan.sadhasivam@linaro.org>,
        <fancer.lancer@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <cassel@kernel.org>, <dlemoal@kernel.org>,
        <yoshihiro.shimoda.uh@renesas.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v5] PCI: keystone: Fix pci_ops for AM654x SoC
Date: Tue, 26 Mar 2024 16:49:05 +0530
Message-ID: <20240326111905.2369778-1-s-vadapalli@ti.com>
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
ks_pcie_v3_65_add_bus() method are applicable to the controller version
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
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on linux-next tagged next-20240326.

v4:
https://lore.kernel.org/r/20240325053722.1955433-1-s-vadapalli@ti.com/
Changes since v4:
- As suggested by Niklas Cassel <cassel@kernel.org> at:
  https://lore.kernel.org/r/ZgF_5fYsI5lOFjOv@ryzen/
  the contents of "ks_pcie_v3_65_add_bus()" have been moved to
  "ks_pcie_msi_host_init()" instead of "ks_pcie_host_init()". This
  avoids unnecessary checks for "!ks_pcie->is_am6" since
  "ks_pcie_msi_host_init()" is specific to the v3.65a controller version
  which corresponds to "!ks_pcie->is_am6".
- Updated commit message to match the change in implementation.
- Added "Suggested-by" tag of Niklas Cassel <cassel@kernel.org> based on:
  https://lore.kernel.org/r/ZgKaNrhoReJ0A525@x1-carbon/
- Moved the definitions for ks_pcie_set_dbi_mode() and
  ks_pcie_clear_dbi_mode() above ks_pcie_msi_host_init().

Regards,
Siddharth.

 drivers/pci/controller/dwc/pci-keystone.c | 136 ++++++++++------------
 1 file changed, 60 insertions(+), 76 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 844de4418724..c2252448d9e8 100644
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
+	 /*
+	  * For BAR0, just setting bus address for inbound writes (MSI) should
+	  * be sufficient.  Use physical address to avoid any conflicts.
+	  */
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


