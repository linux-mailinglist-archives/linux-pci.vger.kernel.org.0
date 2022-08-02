Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C3B588120
	for <lists+linux-pci@lfdr.de>; Tue,  2 Aug 2022 19:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbiHBRgp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Aug 2022 13:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiHBRgm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Aug 2022 13:36:42 -0400
Received: from mailserv1.kapsi.fi (mailserv1.kapsi.fi [IPv6:2001:67c:1be8::25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD5833A29;
        Tue,  2 Aug 2022 10:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=ext.kapsi.fi; s=20161220; h=Subject:Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=slMr5916vD+9RDJ4lDNYA3WKLFVZwkO7Qq68zICCIVM=; b=WAAGaGbYPF6jnS+A7gzqHjklbX
        dzU/fyImxQ/jMVbZYew3zkHPYV2g4FjMvtOJnDaipVaDkNdhhBh6FeKvfzuHJHH3XeH20AMd3e0gM
        RyZAXB+BKl8y1dxYQcitgewZzyU/2D4VFaPhh4V2vNCJildJW5U7TYajyt8reOrtEtBb2shrHaW1r
        kUYsrXcJVJEaddkc1Qco1fNWsoQrvXcb15RP0pCXjslRutTp0EsWS1Gc6PxOIOb+sN1cMNwMM/I+h
        rpPF8X8jnSFMeArMMW150Xk1uCvzYRjw2ZsF+jDsftcuPBR2qFksd8ATqLnGU8amji/s60/5flBM7
        BwYZQDrw==;
Received: from a82-197-11-249.mpynet.fi ([82.197.11.249]:55984 helo=localhost)
        by mailserv1.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maukka@ext.kapsi.fi>)
        id 1oIvoq-008Yn2-WB; Tue, 02 Aug 2022 20:36:38 +0300
Received: by localhost (sSMTP sendmail emulation); Tue, 02 Aug 2022 20:36:35 +0300
From:   Mauri Sandberg <maukka@ext.kapsi.fi>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, gregory.clement@bootlin.com,
        linux@armlinux.org.uk, lpieralisi@kernel.org, kw@linux.com,
        thomas.petazzoni@bootlin.com, pali@kernel.org,
        Mauri Sandberg <maukka@ext.kapsi.fi>
Date:   Tue,  2 Aug 2022 20:34:23 +0300
Message-Id: <20220802173423.47230-3-maukka@ext.kapsi.fi>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220802173423.47230-1-maukka@ext.kapsi.fi>
References: <20220718202843.6766-1-maukka@ext.kapsi.fi>
 <20220802173423.47230-1-maukka@ext.kapsi.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 82.197.11.249
X-SA-Exim-Mail-From: maukka@ext.kapsi.fi
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Subject: [PATCH v2 2/2] PCI: mvebu: add support for orion5x
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on mailserv1.kapsi.fi)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for orion5x PCIe controller.

There is Orion-specific errata that config space via CF8/CFC registers
is broken. Workaround documented in errata documented (linked from above
documentation) does not work when DMA is used and instead other
undocumented workaround is needed which maps config space to memory
(and therefore avoids usage of broken CF8/CFC memory mapped registers).

Signed-off-by: Mauri Sandberg <maukka@ext.kapsi.fi>
Cc: Pali Rohár <pali@kernel.org>
---
v1 -> v2:
 - do pcie related mvebu windows and remaps in pcie_setup()
---
 arch/arm/mach-orion5x/common.c     | 13 -------
 arch/arm/mach-orion5x/pci.c        | 14 +++++++
 drivers/pci/controller/Kconfig     |  2 +-
 drivers/pci/controller/pci-mvebu.c | 59 ++++++++++++++++++++++++++++++
 4 files changed, 74 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
index 7bcb41137bbf..9d8be5ce1266 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -231,19 +231,6 @@ void __init orion5x_init_early(void)
 
 void orion5x_setup_wins(void)
 {
-	/*
-	 * The PCIe windows will no longer be statically allocated
-	 * here once Orion5x is migrated to the pci-mvebu driver.
-	 */
-	mvebu_mbus_add_window_remap_by_id(ORION_MBUS_PCIE_IO_TARGET,
-					  ORION_MBUS_PCIE_IO_ATTR,
-					  ORION5X_PCIE_IO_PHYS_BASE,
-					  ORION5X_PCIE_IO_SIZE,
-					  ORION5X_PCIE_IO_BUS_BASE);
-	mvebu_mbus_add_window_by_id(ORION_MBUS_PCIE_MEM_TARGET,
-				    ORION_MBUS_PCIE_MEM_ATTR,
-				    ORION5X_PCIE_MEM_PHYS_BASE,
-				    ORION5X_PCIE_MEM_SIZE);
 	mvebu_mbus_add_window_remap_by_id(ORION_MBUS_PCI_IO_TARGET,
 					  ORION_MBUS_PCI_IO_ATTR,
 					  ORION5X_PCI_IO_PHYS_BASE,
diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
index 9574c73f3c03..7c4e2f355cc7 100644
--- a/arch/arm/mach-orion5x/pci.c
+++ b/arch/arm/mach-orion5x/pci.c
@@ -150,6 +150,20 @@ static int __init pcie_setup(struct pci_sys_data *sys)
 	 */
 	orion_pcie_setup(PCIE_BASE);
 
+	/*
+	 * The PCIe windows will no longer be statically allocated
+	 * here once Orion5x is migrated to the pci-mvebu driver.
+	 */
+	mvebu_mbus_add_window_remap_by_id(ORION_MBUS_PCIE_IO_TARGET,
+					  ORION_MBUS_PCIE_IO_ATTR,
+					  ORION5X_PCIE_IO_PHYS_BASE,
+					  ORION5X_PCIE_IO_SIZE,
+					  ORION5X_PCIE_IO_BUS_BASE);
+	mvebu_mbus_add_window_by_id(ORION_MBUS_PCIE_MEM_TARGET,
+				    ORION_MBUS_PCIE_MEM_ATTR,
+				    ORION5X_PCIE_MEM_PHYS_BASE,
+				    ORION5X_PCIE_MEM_SIZE);
+
 	/*
 	 * Check whether to apply Orion-1/Orion-NAS PCIe config
 	 * read transaction workaround.
diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index b8d96d38064d..a249375837f0 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -5,7 +5,7 @@ menu "PCI controller drivers"
 
 config PCI_MVEBU
 	tristate "Marvell EBU PCIe controller"
-	depends on ARCH_MVEBU || ARCH_DOVE || COMPILE_TEST
+	depends on ARCH_MVEBU || ARCH_DOVE || ARCH_ORION5X || COMPILE_TEST
 	depends on MVEBU_MBUS
 	depends on ARM
 	depends on OF
diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index c1ffdb06c971..1d3052aa7e49 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -1487,6 +1487,54 @@ static int mvebu_pcie_parse_request_resources(struct mvebu_pcie *pcie)
 	return 0;
 }
 
+static int orion_pcie_rd_conf_wa(void __iomem *wa_base, struct pci_bus *bus,
+			  u32 devfn, int where, int size, u32 *val)
+{
+	*val = readl(wa_base + (PCIE_CONF_BUS(bus->number) |
+				PCIE_CONF_DEV(PCI_SLOT(devfn)) |
+				PCIE_CONF_FUNC(PCI_FUNC(devfn)) |
+				PCIE_CONF_REG(where)));
+
+	if (size == 1)
+		*val = (*val >> (8 * (where & 3))) & 0xff;
+	else if (size == 2)
+		*val = (*val >> (8 * (where & 3))) & 0xffff;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+/* Relevant only for Orion-1/Orion-NAS */
+#define ORION5X_PCIE_WA_PHYS_BASE	0xf0000000
+#define ORION5X_PCIE_WA_VIRT_BASE	IOMEM(0xfd000000)
+#define ORION5X_PCIE_WA_SIZE		SZ_16M
+#define ORION_MBUS_PCIE_WA_TARGET	0x04
+#define ORION_MBUS_PCIE_WA_ATTR		0x79
+
+static int mvebu_pcie_child_rd_conf_wa(struct pci_bus *bus, u32 devfn, int where, int size, u32 *val)
+{
+	struct mvebu_pcie *pcie = bus->sysdata;
+	struct mvebu_pcie_port *port;
+
+	port = mvebu_pcie_find_port(pcie, bus, devfn);
+	if (!port)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (!mvebu_pcie_link_up(port))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	/*
+	 * We only support access to the non-extended configuration
+	 * space when using the WA access method (or we would have to
+	 * sacrifice 256M of CPU virtual address space.)
+	 */
+	if (where >= 0x100) {
+		*val = 0xffffffff;
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+
+	return orion_pcie_rd_conf_wa(ORION5X_PCIE_WA_VIRT_BASE, bus, devfn, where, size, val);
+}
+
 static int mvebu_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1663,6 +1711,16 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 	bridge->align_resource = mvebu_pcie_align_resource;
 	bridge->map_irq = mvebu_pcie_map_irq;
 
+	if (of_machine_is_compatible("marvell,orion5x-88f5181")) {
+		dev_info(dev, "Applying Orion-1/Orion-NAS PCIe config read transaction workaround\n");
+
+		mvebu_pcie_child_ops.read = mvebu_pcie_child_rd_conf_wa;
+		mvebu_mbus_add_window_by_id(ORION_MBUS_PCIE_WA_TARGET,
+					    ORION_MBUS_PCIE_WA_ATTR,
+					    ORION5X_PCIE_WA_PHYS_BASE,
+					    ORION5X_PCIE_WA_SIZE);
+	}
+
 	return pci_host_probe(bridge);
 }
 
@@ -1733,6 +1791,7 @@ static const struct of_device_id mvebu_pcie_of_match_table[] = {
 	{ .compatible = "marvell,armada-370-pcie", },
 	{ .compatible = "marvell,dove-pcie", },
 	{ .compatible = "marvell,kirkwood-pcie", },
+	{ .compatible = "marvell,orion5x-pcie", },
 	{},
 };
 
-- 
2.25.1

