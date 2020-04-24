Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C7F1B768B
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 15:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgDXNKT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 09:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgDXNKT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Apr 2020 09:10:19 -0400
Received: from vultr.net.flygoat.com (vultr.net.flygoat.com [IPv6:2001:19f0:6001:3633:5400:2ff:fe8c:553])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD76C09B045;
        Fri, 24 Apr 2020 06:10:07 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id DB5172049A;
        Fri, 24 Apr 2020 13:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1587733807; bh=SAGZxafNPO8H/Hl2I90awokdzxBVf9SSykBRpibt+Dg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cEt6N4IEUCmFFUWB1hMxlH+SdyrgXTDniho3F9mULlj1gybft43dGdQyFNWN6ZtW5
         0gSEMUouYoH/JYyX255KXJVi9do1K8lydMp0nhKe7eKtfYsTQ5hMp/tDZ3+tCetW1k
         6Vtq0GMGuj21nLg5n3E/c136pPCMt5IQCdoN73VlOh4kdBaYZ0seDhW144CZdR9xjW
         Z5RPs47E14NRpWjYiwuI/rUG5yovMVsbUFZEqvOphR15dxpZlldPAhTG0XLfRbobdt
         AzXIJozzKlG+NJviG5fp7TRBw99Uu0vRQ1r+erUHx/SHY491UWQWZxP06gP/YDgQQr
         +ZcLgpMprH2tw==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-pci@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Paul Burton <paulburton@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: [PATCH v5 3/6] PCI: Add Loongson PCI Controller support
Date:   Fri, 24 Apr 2020 21:08:34 +0800
Message-Id: <20200424130847.328584-4-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200424130847.328584-1-jiaxun.yang@flygoat.com>
References: <20200424130847.328584-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This controller can be found on Loongson-2K SoC, Loongson-3
systems with RS780E/LS7A PCH.

The RS780E part of code was previously located at
arch/mips/pci/ops-loongson3.c and now it can use generic PCI
driver implementation.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

--
v2:
	- Clean up according to rob's suggestions
	- Claim that it can't work as a module
v3:
	- Fix a typo
---
 drivers/pci/controller/Kconfig        |   9 +
 drivers/pci/controller/Makefile       |   1 +
 drivers/pci/controller/pci-loongson.c | 257 ++++++++++++++++++++++++++
 3 files changed, 267 insertions(+)
 create mode 100644 drivers/pci/controller/pci-loongson.c

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 91bfdb784829..7d7e70402ebd 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -258,6 +258,16 @@ config PCI_HYPERV_INTERFACE
 	  The Hyper-V PCI Interface is a helper driver allows other drivers to
 	  have a common interface with the Hyper-V PCI frontend driver.
 
+config PCI_LOONGSON
+	bool "LOONGSON PCI Controller"
+	depends on MACH_LOONGSON64 || COMPILE_TEST
+	depends on OF
+	depends on PCI_QUIRKS
+	default MACH_LOONGSON64
+	help
+	  Say Y here if you want to enable PCI controller support on
+	  Loongson systems.
+
 source "drivers/pci/controller/dwc/Kconfig"
 source "drivers/pci/controller/mobiveil/Kconfig"
 source "drivers/pci/controller/cadence/Kconfig"
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index 158c59771824..fbac4b0190a0 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_PCIE_MEDIATEK) += pcie-mediatek.o
 obj-$(CONFIG_PCIE_TANGO_SMP8759) += pcie-tango.o
 obj-$(CONFIG_VMD) += vmd.o
 obj-$(CONFIG_PCIE_BRCMSTB) += pcie-brcmstb.o
+obj-$(CONFIG_PCI_LOONGSON) += pci-loongson.o
 # pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
 obj-y				+= dwc/
 obj-y				+= mobiveil/
diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
new file mode 100644
index 000000000000..0bd3b52c14fb
--- /dev/null
+++ b/drivers/pci/controller/pci-loongson.c
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Loongson PCI Host Controller Driver
+ *
+ * Copyright (C) 2020 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#include <linux/of_address.h>
+#include <linux/of_pci.h>
+#include <linux/of_platform.h>
+#include <linux/pci.h>
+#include <linux/pci_ids.h>
+
+#include "../pci.h"
+
+/* Device IDs */
+#define DEV_PCIE_PORT_0	0x7a09
+#define DEV_PCIE_PORT_1	0x7a19
+#define DEV_PCIE_PORT_2	0x7a29
+
+#define DEV_LS2K_APB	0x7a02
+#define DEV_LS7A_CONF	0x7a10
+#define DEV_LS7A_LPC	0x7a0c
+
+#define FLAG_CFG0	BIT(0)
+#define FLAG_CFG1	BIT(1)
+#define FLAG_DEV_FIX	BIT(2)
+
+struct loongson_pci {
+	void __iomem *cfg0_base;
+	void __iomem *cfg1_base;
+	struct platform_device *pdev;
+	u32 flags;
+};
+
+/* Fixup wrong class code in PCIe bridges */
+static void bridge_class_quirk(struct pci_dev *dev)
+{
+	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON,
+			DEV_PCIE_PORT_0, bridge_class_quirk);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON,
+			DEV_PCIE_PORT_1, bridge_class_quirk);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON,
+			DEV_PCIE_PORT_2, bridge_class_quirk);
+
+static void system_bus_quirk(struct pci_dev *pdev)
+{
+	u16 tmp;
+
+	pdev->mmio_always_on = 1;
+	pdev->non_compliant_bars = 1;
+	/* Enable MEM & IO Decoding */
+	pci_read_config_word(pdev, PCI_STATUS, &tmp);
+	tmp |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY;
+	pci_write_config_word(pdev, PCI_STATUS, tmp);
+}
+
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
+			DEV_LS2K_APB, system_bus_quirk);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
+			DEV_LS7A_CONF, system_bus_quirk);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
+			DEV_LS7A_LPC, system_bus_quirk);
+
+static void loongson_mrrs_quirk(struct pci_dev *dev)
+{
+	struct pci_bus *bus = dev->bus;
+	struct pci_dev *bridge;
+	static const struct pci_device_id bridge_devids[] = {
+		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_0) },
+		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_1) },
+		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_2) },
+		{ 0, },
+	};
+
+
+	/* look for the matching bridge */
+	while (!pci_is_root_bus(bus)) {
+		bridge = bus->self;
+		bus = bus->parent;
+		/*
+		 * Some Loongson PCIE ports has a h/w limitation of
+		 * 256 bytes maximum read request size. It can't handle
+		 * anything higher than this. So force this limit on
+		 * any devices attached under these ports.
+		 */
+		if (pci_match_id(bridge_devids, bridge)) {
+			if (pcie_get_readrq(dev) > 256) {
+				dev_info(&dev->dev, "limiting MRRS to 256\n");
+				pcie_set_readrq(dev, 256);
+			}
+			break;
+		}
+	}
+}
+DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk);
+
+static void __iomem *cfg1_map(struct loongson_pci *priv, int bus, int dev,
+				int func, int where)
+{
+	unsigned long addroff = 0x0;
+
+	if (bus != 0)
+		addroff |= BIT(28); /* Type 1 Access */
+	addroff |= (where & 0xff) | ((where & 0xf00) << 16);
+	addroff |= (bus << 16) | (dev << 11) | (func << 8);
+	return priv->cfg1_base + addroff;
+}
+
+static void __iomem *cfg0_map(struct loongson_pci *priv, int bus, int dev,
+				int func, int where)
+{
+	unsigned long addroff = 0x0;
+
+	if (bus != 0)
+		addroff |= BIT(24); /* Type 1 Access */
+	addroff |= (bus << 16) | (dev << 11) | (func << 8) | where;
+	return priv->cfg0_base + addroff;
+}
+
+void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devfn,
+			       int where)
+{
+	unsigned char busnum = bus->number;
+	int device = PCI_SLOT(devfn);
+	int function = PCI_FUNC(devfn);
+	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
+	struct loongson_pci *priv =  pci_host_bridge_priv(bridge);
+
+	/*
+	 * Do not read more than one device on the bus other than
+	 * the host bridge.
+	 */
+	if (bus->primary != 0 && device > 0 &&
+		priv->flags & FLAG_DEV_FIX)
+		return NULL;
+
+	/* CFG0 can only access standard space */
+	if (where < PCI_CFG_SPACE_SIZE && priv->flags & FLAG_CFG0 &&
+		priv->cfg0_base)
+		return cfg0_map(priv, busnum, device, function, where);
+
+	/* CFG1 can access exp space */
+	if (where < PCI_CFG_SPACE_EXP_SIZE && priv->flags & FLAG_CFG1 &&
+		priv->cfg1_base)
+		return cfg1_map(priv, busnum, device, function, where);
+
+	return NULL;
+}
+
+static int loongson_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	int irq;
+	u8 val;
+
+	irq = of_irq_parse_and_map_pci(dev, slot, pin);
+	if (irq > 0)
+		return irq;
+
+	/* Care i8259 legacy systems */
+	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &val);
+	/* 0xff is also invalid */
+	if (val == 0xff)
+		return 0;
+
+	return val;
+}
+
+/* H/w only accept 32-bit PCI operations */
+static struct pci_ops loongson_pci_ops = {
+	.map_bus = pci_loongson_map_bus,
+	.read	= pci_generic_config_read32,
+	.write	= pci_generic_config_write32,
+};
+
+static const struct of_device_id loongson_pci_of_match[] = {
+	{ .compatible = "loongson,rs780e-pci",
+		.data = (void *)(FLAG_CFG0), },
+	{ .compatible = "loongson,ls2k-pci",
+		.data = (void *)(FLAG_CFG0 | FLAG_CFG1 | FLAG_DEV_FIX), },
+	{ .compatible = "loongson,ls7a-pci",
+		.data = (void *)(FLAG_CFG0 | FLAG_CFG1 | FLAG_DEV_FIX), },
+	{}
+};
+
+static int loongson_pci_probe(struct platform_device *pdev)
+{
+	struct loongson_pci *priv;
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+	struct pci_host_bridge *bridge;
+	struct resource *regs;
+	int err;
+
+	if (!node)
+		return -ENODEV;
+
+	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*priv));
+	if (!bridge)
+		return -ENODEV;
+
+	priv = pci_host_bridge_priv(bridge);
+	priv->pdev = pdev;
+	priv->flags = (unsigned long)of_device_get_match_data(dev);
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!regs) {
+		dev_err(dev, "missing mem resources for cfg0\n");
+		return -EINVAL;
+	}
+
+	priv->cfg0_base = devm_pci_remap_cfg_resource(dev, regs);
+	if (IS_ERR(priv->cfg0_base))
+		return PTR_ERR(priv->cfg0_base);
+
+	/* CFG1 is optional */
+	if (priv->flags & FLAG_CFG1) {
+		regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		if (!regs)
+			dev_info(dev, "missing mem resource for cfg1\n");
+		else {
+			priv->cfg1_base = devm_pci_remap_cfg_resource(dev, regs);
+			if (IS_ERR(priv->cfg1_base))
+				priv->cfg1_base = NULL;
+		}
+	}
+
+
+	err = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
+						&bridge->dma_ranges, NULL);
+	if (err) {
+		dev_err(dev, "Failed to get bridge resources\n");
+		return err;
+	}
+
+	bridge->dev.parent = dev;
+	bridge->sysdata = priv;
+	bridge->ops = &loongson_pci_ops;
+	bridge->map_irq = loongson_map_irq;
+
+	err = pci_host_probe(bridge);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static struct platform_driver loongson_pci_driver = {
+	.driver = {
+		.name = "loongson-pci",
+		.of_match_table = loongson_pci_of_match,
+	},
+	.probe = loongson_pci_probe,
+};
+builtin_platform_driver(loongson_pci_driver);
-- 
2.26.0.rc2

