Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86E2578BEB
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jul 2022 22:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbiGRUkU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jul 2022 16:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236086AbiGRUkK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jul 2022 16:40:10 -0400
Received: from mailserv1.kapsi.fi (mailserv1.kapsi.fi [IPv6:2001:67c:1be8::25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC38B3054C;
        Mon, 18 Jul 2022 13:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=ext.kapsi.fi; s=20161220; h=Subject:Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=q64OX1RaF24+rgYgUdUthpna0pMNsJC6RL3XDFNHJPk=; b=FLGAEi4tJlTTDhiWeHN6U+lthz
        vpTgU7E2oDAtyinhkzIzIWr9bg0qWL8/C5diFtWTxwKdDr+OwKMC1DdpDsYHts0TqTRu6ak56/dTu
        eeiTBii2Hl1smvL7jaKemVvgRu2ElxVmRbmr5GcVMT0GC5JIPClG92xWWkpnja6i7t6eF6HULSI77
        SlkUz0Gr/hbLusbH3llLQh/XNoIjg3kbYevcZtPytgyUyCRFV9BnFEgWi9kvIhEs/MKEQ2EGvsJhK
        nnhCMQAWNQPnPWqA5CS+XBM4Xx6rqHukGdxbcg4/5OgQ0QIgOxiLi2x7lm4QSe0JTrmInAHxaM7xW
        6xmUsIsA==;
Received: from a82-197-11-249.mpynet.fi ([82.197.11.249]:56882 helo=localhost)
        by mailserv1.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maukka@ext.kapsi.fi>)
        id 1oDXMz-00G7F9-39; Mon, 18 Jul 2022 23:29:35 +0300
Received: by localhost (sSMTP sendmail emulation); Mon, 18 Jul 2022 23:29:32 +0300
From:   Mauri Sandberg <maukka@ext.kapsi.fi>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, gregory.clement@bootlin.com,
        linux@armlinux.org.uk, lpieralisi@kernel.org, kw@linux.com,
        thomas.petazzoni@bootlin.com, pali@kernel.org,
        Mauri Sandberg <maukka@ext.kapsi.fi>
Date:   Mon, 18 Jul 2022 23:28:43 +0300
Message-Id: <20220718202843.6766-4-maukka@ext.kapsi.fi>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220718202843.6766-1-maukka@ext.kapsi.fi>
References: <20220718202843.6766-1-maukka@ext.kapsi.fi>
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
Subject: [PATCH 2/2] PCI: mvebu: add support for orion5x
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
 arch/arm/mach-orion5x/common.c     | 13 -------
 drivers/pci/controller/Kconfig     |  2 +-
 drivers/pci/controller/pci-mvebu.c | 59 ++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 14 deletions(-)

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

