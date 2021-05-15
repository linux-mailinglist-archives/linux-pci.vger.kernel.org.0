Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0485F3818CE
	for <lists+linux-pci@lfdr.de>; Sat, 15 May 2021 14:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbhEOMmS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 May 2021 08:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbhEOMmQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 May 2021 08:42:16 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA09EC061573;
        Sat, 15 May 2021 05:41:02 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m9so1768666wrx.3;
        Sat, 15 May 2021 05:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=17/VAdaUS6CF4eSSsoyWrRCw5jf3Dp6ZsaL98hakDls=;
        b=TQ4PLyaddR8PPgf3VMXKX9B13naWoBgzetmYgvOtjp7jECcxCxFZQIXyBf3IHsoSKl
         fDvXQ7athTFRhLD/kt41knoZkaSMKJBWjp2E65GrFKScl/SMGGbD3fS7wdHLToO8Qu3m
         LIAzUnnSJ8CpES/54ukxSVNIbKp8Y/2BjTe5kgLCxHh3ZhD+dJ+wPlATGqtie1Kj5QHY
         72jkFN2MmYMAl5NQZSPsT8km0QEAgqPF0b0Im6wNF9KwD1VIs9+bfnrROd9udJosUSAa
         ogKLouvyuYjxB4r9AH2b6tKS9LSoPcUSkQ7kd2kn0zAS9wXFhduJNBEaZoHonI6RoI3J
         B+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=17/VAdaUS6CF4eSSsoyWrRCw5jf3Dp6ZsaL98hakDls=;
        b=pniAKgfT0poJgNis3CiwvHRN5iNPPYtiAAU7myuhZzDAwPMDELTQxZLMEHxVBjIXq0
         Ou3TAFjt1YETfqg2a6jZ/H9q95pf9eBAE8T97VIS5mijsT+0rmJcOhtdvjRxapVJ9fJq
         VrH62kFXa6ke/yjSIvd4osAkOmoJjxUap7ILAzUTzt/wuYKM3uZiiOBoiuyw3sEytKl1
         /qQxiipXEvcVQXtpCVswGXeWpQq52OG6+tHttNHTe0zdvhgGJQqxhPl1ZcrgH7zxmr4I
         pBekwsZRX5lCUGGBhvog7K9hgPNtoIEG8u87CrBhsZ5L8kTAiAmoBgrLsdIURfiPza4g
         ss9A==
X-Gm-Message-State: AOAM533RVVymZUAQhQgSEOZOZoH9A4yja2rbBLuJiYJRgXq3Q/KHDDsc
        TdC2ySZ7sMUv2zf17HAHA622Jwo21rDXe75V
X-Google-Smtp-Source: ABdhPJwmcfOzq6RbEnHZsraAvJ+Iar6gQZ1QQyfs6ejerhJ50nfScLCAavGkSwEpS2gNkLaxMWEPCQ==
X-Received: by 2002:a05:6000:1147:: with SMTP id d7mr9167852wrx.302.1621082461204;
        Sat, 15 May 2021 05:41:01 -0700 (PDT)
Received: from localhost.localdomain (29.red-83-49-33.dynamicip.rima-tde.net. [83.49.33.29])
        by smtp.gmail.com with ESMTPSA id w7sm9472749wru.51.2021.05.15.05.41.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 May 2021 05:41:00 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, devicetree@vger.kernel.org,
        matthias.bgg@gmail.com, john@phrozen.org, bhelgaas@google.com,
        robh+dt@kernel.org, linux-staging@lists.linux.dev,
        gregkh@linuxfoundation.org, neil@brown.name,
        ilya.lipnitskiy@gmail.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 3/4] staging: mt7621-pci: remove driver from staging
Date:   Sat, 15 May 2021 14:40:54 +0200
Message-Id: <20210515124055.22225-4-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210515124055.22225-1-sergio.paracuellos@gmail.com>
References: <20210515124055.22225-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Driver has been moved into its proper place in the
kernel 'arch/mips/pci'. Hence, remove it from staging.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/staging/Kconfig                       |   2 -
 drivers/staging/Makefile                      |   1 -
 drivers/staging/mt7621-pci/Kconfig            |   8 -
 drivers/staging/mt7621-pci/Makefile           |   2 -
 drivers/staging/mt7621-pci/TODO               |   4 -
 .../mt7621-pci/mediatek,mt7621-pci.txt        | 104 ---
 drivers/staging/mt7621-pci/pci-mt7621.c       | 624 ------------------
 7 files changed, 745 deletions(-)
 delete mode 100644 drivers/staging/mt7621-pci/Kconfig
 delete mode 100644 drivers/staging/mt7621-pci/Makefile
 delete mode 100644 drivers/staging/mt7621-pci/TODO
 delete mode 100644 drivers/staging/mt7621-pci/mediatek,mt7621-pci.txt
 delete mode 100644 drivers/staging/mt7621-pci/pci-mt7621.c

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index b7ae5bdc4eb5..9a21d730ab2b 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -86,8 +86,6 @@ source "drivers/staging/vc04_services/Kconfig"
 
 source "drivers/staging/pi433/Kconfig"
 
-source "drivers/staging/mt7621-pci/Kconfig"
-
 source "drivers/staging/mt7621-dma/Kconfig"
 
 source "drivers/staging/ralink-gdma/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 075c979bfe7c..b7b4916761d4 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -33,7 +33,6 @@ obj-$(CONFIG_KS7010)		+= ks7010/
 obj-$(CONFIG_GREYBUS)		+= greybus/
 obj-$(CONFIG_BCM2835_VCHIQ)	+= vc04_services/
 obj-$(CONFIG_PI433)		+= pi433/
-obj-$(CONFIG_PCI_MT7621)	+= mt7621-pci/
 obj-$(CONFIG_SOC_MT7621)	+= mt7621-dma/
 obj-$(CONFIG_DMA_RALINK)	+= ralink-gdma/
 obj-$(CONFIG_SOC_MT7621)	+= mt7621-dts/
diff --git a/drivers/staging/mt7621-pci/Kconfig b/drivers/staging/mt7621-pci/Kconfig
deleted file mode 100644
index ce58042f2f21..000000000000
--- a/drivers/staging/mt7621-pci/Kconfig
+++ /dev/null
@@ -1,8 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-config PCI_MT7621
-	tristate "MediaTek MT7621 PCI Controller"
-	depends on RALINK
-	select PCI_DRIVERS_GENERIC
-	help
-	  This selects a driver for the MediaTek MT7621 PCI Controller.
-
diff --git a/drivers/staging/mt7621-pci/Makefile b/drivers/staging/mt7621-pci/Makefile
deleted file mode 100644
index f4e651cf7ce3..000000000000
--- a/drivers/staging/mt7621-pci/Makefile
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_PCI_MT7621)       += pci-mt7621.o
diff --git a/drivers/staging/mt7621-pci/TODO b/drivers/staging/mt7621-pci/TODO
deleted file mode 100644
index d674a9ac85c1..000000000000
--- a/drivers/staging/mt7621-pci/TODO
+++ /dev/null
@@ -1,4 +0,0 @@
-
-- general code review and cleanup
-
-Cc: NeilBrown <neil@brown.name>
diff --git a/drivers/staging/mt7621-pci/mediatek,mt7621-pci.txt b/drivers/staging/mt7621-pci/mediatek,mt7621-pci.txt
deleted file mode 100644
index 327a68267309..000000000000
--- a/drivers/staging/mt7621-pci/mediatek,mt7621-pci.txt
+++ /dev/null
@@ -1,104 +0,0 @@
-MediaTek MT7621 PCIe controller
-
-Required properties:
-- compatible: "mediatek,mt7621-pci"
-- device_type: Must be "pci"
-- reg: Base addresses and lengths of the PCIe subsys and root ports.
-- bus-range: Range of bus numbers associated with this controller.
-- #address-cells: Address representation for root ports (must be 3)
-- pinctrl-names : The pin control state names.
-- pinctrl-0: The "default" pinctrl state.
-- #size-cells: Size representation for root ports (must be 2)
-- ranges: Ranges for the PCI memory and I/O regions.
-- #interrupt-cells: Must be 1
-- interrupt-map-mask and interrupt-map: Standard PCI IRQ mapping properties.
-  Please refer to the standard PCI bus binding document for a more detailed
-  explanation.
-- status: either "disabled" or "okay".
-- resets: Must contain an entry for each entry in reset-names.
-  See ../reset/reset.txt for details.
-- reset-names: Must be "pcie0", "pcie1", "pcieN"... based on the number of
-  root ports.
-- clocks: Must contain an entry for each entry in clock-names.
-  See ../clocks/clock-bindings.txt for details.
-- clock-names: Must be "pcie0", "pcie1", "pcieN"... based on the number of
-  root ports.
-- reset-gpios: GPIO specs for the reset pins.
-
-In addition, the device tree node must have sub-nodes describing each PCIe port
-interface, having the following mandatory properties:
-
-Required properties:
-- reg: Only the first four bytes are used to refer to the correct bus number
-      and device number.
-- #address-cells: Must be 3
-- #size-cells: Must be 2
-- ranges: Sub-ranges distributed from the PCIe controller node. An empty
-  property is sufficient.
-- bus-range: Range of bus numbers associated with this port.
-
-Example for MT7621:
-
-	pcie: pcie@1e140000 {
-		compatible = "mediatek,mt7621-pci";
-        reg = <0x1e140000 0x100    /* host-pci bridge registers */
-               0x1e142000 0x100    /* pcie port 0 RC control registers */
-               0x1e143000 0x100    /* pcie port 1 RC control registers */
-               0x1e144000 0x100>;  /* pcie port 2 RC control registers */
-
-		#address-cells = <3>;
-		#size-cells = <2>;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&pcie_pins>;
-
-		device_type = "pci";
-
-		bus-range = <0 255>;
-		ranges = <
-			0x02000000 0 0x00000000 0x60000000 0 0x10000000 /* pci memory */
-			0x01000000 0 0x00000000 0x1e160000 0 0x00010000 /* io space */
-		>;
-
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0xF0000 0 0 1>;
-		interrupt-map = <0x10000 0 0 1 &gic GIC_SHARED 4 IRQ_TYPE_LEVEL_HIGH>,
-				<0x20000 0 0 1 &gic GIC_SHARED 24 IRQ_TYPE_LEVEL_HIGH>,
-				<0x30000 0 0 1 &gic GIC_SHARED 25 IRQ_TYPE_LEVEL_HIGH>;
-
-		status = "disabled";
-
-		resets = <&rstctrl 24 &rstctrl 25 &rstctrl 26>;
-		reset-names = "pcie0", "pcie1", "pcie2";
-		clocks = <&clkctrl 24 &clkctrl 25 &clkctrl 26>;
-		clock-names = "pcie0", "pcie1", "pcie2";
-
-		reset-gpios = <&gpio 19 GPIO_ACTIVE_LOW>,
-				<&gpio 8 GPIO_ACTIVE_LOW>,
-				<&gpio 7 GPIO_ACTIVE_LOW>;
-
-		pcie@0,0 {
-			reg = <0x0000 0 0 0 0>;
-			#address-cells = <3>;
-			#size-cells = <2>;
-			ranges;
-			bus-range = <0x00 0xff>;
-		};
-
-		pcie@1,0 {
-			reg = <0x0800 0 0 0 0>;
-			#address-cells = <3>;
-			#size-cells = <2>;
-			ranges;
-			bus-range = <0x00 0xff>;
-		};
-
-		pcie@2,0 {
-			reg = <0x1000 0 0 0 0>;
-			#address-cells = <3>;
-			#size-cells = <2>;
-			ranges;
-			bus-range = <0x00 0xff>;
-		};
-	};
-
diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
deleted file mode 100644
index fe1945819d25..000000000000
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ /dev/null
@@ -1,624 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * BRIEF MODULE DESCRIPTION
- *     PCI init for Ralink RT2880 solution
- *
- * Copyright 2007 Ralink Inc. (bruce_chang@ralinktech.com.tw)
- *
- * May 2007 Bruce Chang
- * Initial Release
- *
- * May 2009 Bruce Chang
- * support RT2880/RT3883 PCIe
- *
- * May 2011 Bruce Chang
- * support RT6855/MT7620 PCIe
- */
-
-#include <linux/bitops.h>
-#include <linux/clk.h>
-#include <linux/delay.h>
-#include <linux/gpio/consumer.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_pci.h>
-#include <linux/of_platform.h>
-#include <linux/pci.h>
-#include <linux/phy/phy.h>
-#include <linux/platform_device.h>
-#include <linux/reset.h>
-#include <linux/sys_soc.h>
-
-/* MediaTek specific configuration registers */
-#define PCIE_FTS_NUM			0x70c
-#define PCIE_FTS_NUM_MASK		GENMASK(15, 8)
-#define PCIE_FTS_NUM_L0(x)		(((x) & 0xff) << 8)
-
-/* Host-PCI bridge registers */
-#define RALINK_PCI_PCICFG_ADDR		0x0000
-#define RALINK_PCI_PCIMSK_ADDR		0x000C
-#define RALINK_PCI_CONFIG_ADDR		0x0020
-#define RALINK_PCI_CONFIG_DATA		0x0024
-#define RALINK_PCI_MEMBASE		0x0028
-#define RALINK_PCI_IOBASE		0x002C
-
-/* PCIe RC control registers */
-#define MT7621_PCIE_OFFSET		0x2000
-#define MT7621_NEXT_PORT		0x1000
-
-#define RALINK_PCI_BAR0SETUP_ADDR	0x0010
-#define RALINK_PCI_ID			0x0030
-#define RALINK_PCI_CLASS		0x0034
-#define RALINK_PCI_SUBID		0x0038
-#define RALINK_PCI_STATUS		0x0050
-
-/* Some definition values */
-#define PCIE_REVISION_ID		BIT(0)
-#define PCIE_CLASS_CODE			(0x60400 << 8)
-#define PCIE_BAR_MAP_MAX		GENMASK(30, 16)
-#define PCIE_BAR_ENABLE			BIT(0)
-#define PCIE_PORT_INT_EN(x)		BIT(20 + (x))
-#define PCIE_PORT_LINKUP		BIT(0)
-
-#define PERST_DELAY_MS			100
-
-/**
- * struct mt7621_pcie_port - PCIe port information
- * @base: I/O mapped register base
- * @list: port list
- * @pcie: pointer to PCIe host info
- * @clk: pointer to the port clock gate
- * @phy: pointer to PHY control block
- * @pcie_rst: pointer to port reset control
- * @gpio_rst: gpio reset
- * @slot: port slot
- * @enabled: indicates if port is enabled
- */
-struct mt7621_pcie_port {
-	void __iomem *base;
-	struct list_head list;
-	struct mt7621_pcie *pcie;
-	struct clk *clk;
-	struct phy *phy;
-	struct reset_control *pcie_rst;
-	struct gpio_desc *gpio_rst;
-	u32 slot;
-	bool enabled;
-};
-
-/**
- * struct mt7621_pcie - PCIe host information
- * @base: IO Mapped Register Base
- * @io: IO resource
- * @mem: pointer to non-prefetchable memory resource
- * @dev: Pointer to PCIe device
- * @io_map_base: virtual memory base address for io
- * @ports: pointer to PCIe port information
- * @resets_inverted: depends on chip revision
- * reset lines are inverted.
- */
-struct mt7621_pcie {
-	void __iomem *base;
-	struct device *dev;
-	struct resource io;
-	struct resource *mem;
-	unsigned long io_map_base;
-	struct list_head ports;
-	bool resets_inverted;
-};
-
-static inline u32 pcie_read(struct mt7621_pcie *pcie, u32 reg)
-{
-	return readl(pcie->base + reg);
-}
-
-static inline void pcie_write(struct mt7621_pcie *pcie, u32 val, u32 reg)
-{
-	writel(val, pcie->base + reg);
-}
-
-static inline void pcie_rmw(struct mt7621_pcie *pcie, u32 reg, u32 clr, u32 set)
-{
-	u32 val = readl(pcie->base + reg);
-
-	val &= ~clr;
-	val |= set;
-	writel(val, pcie->base + reg);
-}
-
-static inline u32 pcie_port_read(struct mt7621_pcie_port *port, u32 reg)
-{
-	return readl(port->base + reg);
-}
-
-static inline void pcie_port_write(struct mt7621_pcie_port *port,
-				   u32 val, u32 reg)
-{
-	writel(val, port->base + reg);
-}
-
-static inline u32 mt7621_pci_get_cfgaddr(unsigned int bus, unsigned int slot,
-					 unsigned int func, unsigned int where)
-{
-	return (((where & 0xF00) >> 8) << 24) | (bus << 16) | (slot << 11) |
-		(func << 8) | (where & 0xfc) | 0x80000000;
-}
-
-static void __iomem *mt7621_pcie_map_bus(struct pci_bus *bus,
-					 unsigned int devfn, int where)
-{
-	struct mt7621_pcie *pcie = bus->sysdata;
-	u32 address = mt7621_pci_get_cfgaddr(bus->number, PCI_SLOT(devfn),
-					     PCI_FUNC(devfn), where);
-
-	writel(address, pcie->base + RALINK_PCI_CONFIG_ADDR);
-
-	return pcie->base + RALINK_PCI_CONFIG_DATA + (where & 3);
-}
-
-struct pci_ops mt7621_pci_ops = {
-	.map_bus	= mt7621_pcie_map_bus,
-	.read		= pci_generic_config_read,
-	.write		= pci_generic_config_write,
-};
-
-static u32 read_config(struct mt7621_pcie *pcie, unsigned int dev, u32 reg)
-{
-	u32 address = mt7621_pci_get_cfgaddr(0, dev, 0, reg);
-
-	pcie_write(pcie, address, RALINK_PCI_CONFIG_ADDR);
-	return pcie_read(pcie, RALINK_PCI_CONFIG_DATA);
-}
-
-static void write_config(struct mt7621_pcie *pcie, unsigned int dev,
-			 u32 reg, u32 val)
-{
-	u32 address = mt7621_pci_get_cfgaddr(0, dev, 0, reg);
-
-	pcie_write(pcie, address, RALINK_PCI_CONFIG_ADDR);
-	pcie_write(pcie, val, RALINK_PCI_CONFIG_DATA);
-}
-
-static inline void mt7621_rst_gpio_pcie_assert(struct mt7621_pcie_port *port)
-{
-	if (port->gpio_rst)
-		gpiod_set_value(port->gpio_rst, 1);
-}
-
-static inline void mt7621_rst_gpio_pcie_deassert(struct mt7621_pcie_port *port)
-{
-	if (port->gpio_rst)
-		gpiod_set_value(port->gpio_rst, 0);
-}
-
-static inline bool mt7621_pcie_port_is_linkup(struct mt7621_pcie_port *port)
-{
-	return (pcie_port_read(port, RALINK_PCI_STATUS) & PCIE_PORT_LINKUP) != 0;
-}
-
-static inline void mt7621_control_assert(struct mt7621_pcie_port *port)
-{
-	struct mt7621_pcie *pcie = port->pcie;
-
-	if (pcie->resets_inverted)
-		reset_control_assert(port->pcie_rst);
-	else
-		reset_control_deassert(port->pcie_rst);
-}
-
-static inline void mt7621_control_deassert(struct mt7621_pcie_port *port)
-{
-	struct mt7621_pcie *pcie = port->pcie;
-
-	if (pcie->resets_inverted)
-		reset_control_deassert(port->pcie_rst);
-	else
-		reset_control_assert(port->pcie_rst);
-}
-
-static void setup_cm_memory_region(struct mt7621_pcie *pcie)
-{
-	struct resource *mem_resource = pcie->mem;
-	struct device *dev = pcie->dev;
-	resource_size_t mask;
-
-	if (mips_cps_numiocu(0)) {
-		/*
-		 * FIXME: hardware doesn't accept mask values with 1s after
-		 * 0s (e.g. 0xffef), so it would be great to warn if that's
-		 * about to happen
-		 */
-		mask = ~(mem_resource->end - mem_resource->start);
-
-		write_gcr_reg1_base(mem_resource->start);
-		write_gcr_reg1_mask(mask | CM_GCR_REGn_MASK_CMTGT_IOCU0);
-		dev_info(dev, "PCI coherence region base: 0x%08llx, mask/settings: 0x%08llx\n",
-			 (unsigned long long)read_gcr_reg1_base(),
-			 (unsigned long long)read_gcr_reg1_mask());
-	}
-}
-
-static int mt7621_pci_parse_request_of_pci_ranges(struct pci_host_bridge *host)
-{
-	struct mt7621_pcie *pcie = pci_host_bridge_priv(host);
-	struct device *dev = pcie->dev;
-	struct device_node *node = dev->of_node;
-	struct of_pci_range_parser parser;
-	struct resource_entry *entry;
-	struct of_pci_range range;
-	LIST_HEAD(res);
-
-	if (of_pci_range_parser_init(&parser, node)) {
-		dev_err(dev, "missing \"ranges\" property\n");
-		return -EINVAL;
-	}
-
-	/*
-	 * IO_SPACE_LIMIT for MIPS is 0xffff but this platform uses IO at
-	 * upper address 0x001e160000. of_pci_range_to_resource does not work
-	 * well for MIPS platforms that don't define PCI_IOBASE, so set the IO
-	 * resource manually instead.
-	 */
-	for_each_of_pci_range(&parser, &range) {
-		switch (range.flags & IORESOURCE_TYPE_BITS) {
-		case IORESOURCE_IO:
-			pcie->io_map_base =
-				(unsigned long)ioremap(range.cpu_addr,
-						       range.size);
-			pcie->io.name = node->full_name;
-			pcie->io.flags = range.flags;
-			pcie->io.start = range.cpu_addr;
-			pcie->io.end = range.cpu_addr + range.size - 1;
-			pcie->io.parent = pcie->io.child = pcie->io.sibling = NULL;
-			set_io_port_base(pcie->io_map_base);
-			break;
-		}
-	}
-
-	entry = resource_list_first_type(&host->windows, IORESOURCE_MEM);
-	if (!entry) {
-		dev_err(dev, "Cannot get memory resource");
-		return -EINVAL;
-	}
-
-	pcie->mem = entry->res;
-	pci_add_resource(&res, &pcie->io);
-	pci_add_resource(&res, entry->res);
-	list_splice_init(&res, &host->windows);
-
-	return 0;
-}
-
-static int mt7621_pcie_parse_port(struct mt7621_pcie *pcie,
-				  int slot)
-{
-	struct mt7621_pcie_port *port;
-	struct device *dev = pcie->dev;
-	struct platform_device *pdev = to_platform_device(dev);
-	char name[10];
-
-	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
-	if (!port)
-		return -ENOMEM;
-
-	port->base = devm_platform_ioremap_resource(pdev, slot + 1);
-	if (IS_ERR(port->base))
-		return PTR_ERR(port->base);
-
-	snprintf(name, sizeof(name), "pcie%d", slot);
-	port->clk = devm_clk_get(dev, name);
-	if (IS_ERR(port->clk)) {
-		dev_err(dev, "failed to get pcie%d clock\n", slot);
-		return PTR_ERR(port->clk);
-	}
-
-	snprintf(name, sizeof(name), "pcie%d", slot);
-	port->pcie_rst = devm_reset_control_get_exclusive(dev, name);
-	if (PTR_ERR(port->pcie_rst) == -EPROBE_DEFER) {
-		dev_err(dev, "failed to get pcie%d reset control\n", slot);
-		return PTR_ERR(port->pcie_rst);
-	}
-
-	snprintf(name, sizeof(name), "pcie-phy%d", slot);
-	port->phy = devm_phy_get(dev, name);
-	if (IS_ERR(port->phy) && slot != 1)
-		return PTR_ERR(port->phy);
-
-	port->gpio_rst = devm_gpiod_get_index_optional(dev, "reset", slot,
-						       GPIOD_OUT_LOW);
-	if (IS_ERR(port->gpio_rst)) {
-		dev_err(dev, "Failed to get GPIO for PCIe%d\n", slot);
-		return PTR_ERR(port->gpio_rst);
-	}
-
-	port->slot = slot;
-	port->pcie = pcie;
-
-	INIT_LIST_HEAD(&port->list);
-	list_add_tail(&port->list, &pcie->ports);
-
-	return 0;
-}
-
-static int mt7621_pcie_parse_dt(struct mt7621_pcie *pcie)
-{
-	struct device *dev = pcie->dev;
-	struct platform_device *pdev = to_platform_device(dev);
-	struct device_node *node = dev->of_node, *child;
-	int err;
-
-	pcie->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(pcie->base))
-		return PTR_ERR(pcie->base);
-
-	for_each_available_child_of_node(node, child) {
-		int slot;
-
-		err = of_pci_get_devfn(child);
-		if (err < 0) {
-			of_node_put(child);
-			dev_err(dev, "failed to parse devfn: %d\n", err);
-			return err;
-		}
-
-		slot = PCI_SLOT(err);
-
-		err = mt7621_pcie_parse_port(pcie, slot);
-		if (err) {
-			of_node_put(child);
-			return err;
-		}
-	}
-
-	return 0;
-}
-
-static int mt7621_pcie_init_port(struct mt7621_pcie_port *port)
-{
-	struct mt7621_pcie *pcie = port->pcie;
-	struct device *dev = pcie->dev;
-	u32 slot = port->slot;
-	int err;
-
-	err = phy_init(port->phy);
-	if (err) {
-		dev_err(dev, "failed to initialize port%d phy\n", slot);
-		return err;
-	}
-
-	err = phy_power_on(port->phy);
-	if (err) {
-		dev_err(dev, "failed to power on port%d phy\n", slot);
-		phy_exit(port->phy);
-		return err;
-	}
-
-	port->enabled = true;
-
-	return 0;
-}
-
-static void mt7621_pcie_reset_assert(struct mt7621_pcie *pcie)
-{
-	struct mt7621_pcie_port *port;
-
-	list_for_each_entry(port, &pcie->ports, list) {
-		/* PCIe RC reset assert */
-		mt7621_control_assert(port);
-
-		/* PCIe EP reset assert */
-		mt7621_rst_gpio_pcie_assert(port);
-	}
-
-	msleep(PERST_DELAY_MS);
-}
-
-static void mt7621_pcie_reset_rc_deassert(struct mt7621_pcie *pcie)
-{
-	struct mt7621_pcie_port *port;
-
-	list_for_each_entry(port, &pcie->ports, list)
-		mt7621_control_deassert(port);
-}
-
-static void mt7621_pcie_reset_ep_deassert(struct mt7621_pcie *pcie)
-{
-	struct mt7621_pcie_port *port;
-
-	list_for_each_entry(port, &pcie->ports, list)
-		mt7621_rst_gpio_pcie_deassert(port);
-
-	msleep(PERST_DELAY_MS);
-}
-
-static void mt7621_pcie_init_ports(struct mt7621_pcie *pcie)
-{
-	struct device *dev = pcie->dev;
-	struct mt7621_pcie_port *port, *tmp;
-	int err;
-
-	mt7621_pcie_reset_assert(pcie);
-	mt7621_pcie_reset_rc_deassert(pcie);
-
-	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
-		u32 slot = port->slot;
-
-		if (slot == 1) {
-			port->enabled = true;
-			continue;
-		}
-
-		err = mt7621_pcie_init_port(port);
-		if (err) {
-			dev_err(dev, "Initiating port %d failed\n", slot);
-			list_del(&port->list);
-		}
-	}
-
-	mt7621_pcie_reset_ep_deassert(pcie);
-
-	tmp = NULL;
-	list_for_each_entry(port, &pcie->ports, list) {
-		u32 slot = port->slot;
-
-		if (!mt7621_pcie_port_is_linkup(port)) {
-			dev_err(dev, "pcie%d no card, disable it (RST & CLK)\n",
-				slot);
-			mt7621_control_assert(port);
-			clk_disable_unprepare(port->clk);
-			port->enabled = false;
-
-			if (slot == 0) {
-				tmp = port;
-				continue;
-			}
-
-			if (slot == 1 && tmp && !tmp->enabled)
-				phy_power_off(tmp->phy);
-		}
-	}
-}
-
-static void mt7621_pcie_enable_port(struct mt7621_pcie_port *port)
-{
-	struct mt7621_pcie *pcie = port->pcie;
-	u32 slot = port->slot;
-	u32 offset = MT7621_PCIE_OFFSET + (slot * MT7621_NEXT_PORT);
-	u32 val;
-
-	/* enable pcie interrupt */
-	val = pcie_read(pcie, RALINK_PCI_PCIMSK_ADDR);
-	val |= PCIE_PORT_INT_EN(slot);
-	pcie_write(pcie, val, RALINK_PCI_PCIMSK_ADDR);
-
-	/* map 2G DDR region */
-	pcie_write(pcie, PCIE_BAR_MAP_MAX | PCIE_BAR_ENABLE,
-		   offset + RALINK_PCI_BAR0SETUP_ADDR);
-
-	/* configure class code and revision ID */
-	pcie_write(pcie, PCIE_CLASS_CODE | PCIE_REVISION_ID,
-		   offset + RALINK_PCI_CLASS);
-}
-
-static int mt7621_pcie_enable_ports(struct mt7621_pcie *pcie)
-{
-	struct device *dev = pcie->dev;
-	struct mt7621_pcie_port *port;
-	u8 num_slots_enabled = 0;
-	u32 slot;
-	u32 val;
-	int err;
-
-	/* Setup MEMWIN and IOWIN */
-	pcie_write(pcie, 0xffffffff, RALINK_PCI_MEMBASE);
-	pcie_write(pcie, pcie->io.start, RALINK_PCI_IOBASE);
-
-	list_for_each_entry(port, &pcie->ports, list) {
-		if (port->enabled) {
-			err = clk_prepare_enable(port->clk);
-			if (err) {
-				dev_err(dev, "enabling clk pcie%d\n", slot);
-				return err;
-			}
-
-			mt7621_pcie_enable_port(port);
-			dev_info(dev, "PCIE%d enabled\n", port->slot);
-			num_slots_enabled++;
-		}
-	}
-
-	for (slot = 0; slot < num_slots_enabled; slot++) {
-		val = read_config(pcie, slot, PCI_COMMAND);
-		val |= PCI_COMMAND_MASTER;
-		write_config(pcie, slot, PCI_COMMAND, val);
-		/* configure RC FTS number to 250 when it leaves L0s */
-		val = read_config(pcie, slot, PCIE_FTS_NUM);
-		val &= ~PCIE_FTS_NUM_MASK;
-		val |= PCIE_FTS_NUM_L0(0x50);
-		write_config(pcie, slot, PCIE_FTS_NUM, val);
-	}
-
-	return 0;
-}
-
-static int mt7621_pcie_register_host(struct pci_host_bridge *host)
-{
-	struct mt7621_pcie *pcie = pci_host_bridge_priv(host);
-
-	host->ops = &mt7621_pci_ops;
-	host->sysdata = pcie;
-	return pci_host_probe(host);
-}
-
-static const struct soc_device_attribute mt7621_pci_quirks_match[] = {
-	{ .soc_id = "mt7621", .revision = "E2" }
-};
-
-static int mt7621_pci_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	const struct soc_device_attribute *attr;
-	struct mt7621_pcie *pcie;
-	struct pci_host_bridge *bridge;
-	int err;
-
-	if (!dev->of_node)
-		return -ENODEV;
-
-	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
-	if (!bridge)
-		return -ENOMEM;
-
-	pcie = pci_host_bridge_priv(bridge);
-	pcie->dev = dev;
-	platform_set_drvdata(pdev, pcie);
-	INIT_LIST_HEAD(&pcie->ports);
-
-	attr = soc_device_match(mt7621_pci_quirks_match);
-	if (attr)
-		pcie->resets_inverted = true;
-
-	err = mt7621_pcie_parse_dt(pcie);
-	if (err) {
-		dev_err(dev, "Parsing DT failed\n");
-		return err;
-	}
-
-	err = mt7621_pci_parse_request_of_pci_ranges(bridge);
-	if (err) {
-		dev_err(dev, "Error requesting pci resources from ranges");
-		return err;
-	}
-
-	/* set resources limits */
-	ioport_resource.start = pcie->io.start;
-	ioport_resource.end = pcie->io.end;
-
-	mt7621_pcie_init_ports(pcie);
-
-	err = mt7621_pcie_enable_ports(pcie);
-	if (err) {
-		dev_err(dev, "Error enabling pcie ports\n");
-		return err;
-	}
-
-	setup_cm_memory_region(pcie);
-
-	return mt7621_pcie_register_host(bridge);
-}
-
-static const struct of_device_id mt7621_pci_ids[] = {
-	{ .compatible = "mediatek,mt7621-pci" },
-	{},
-};
-MODULE_DEVICE_TABLE(of, mt7621_pci_ids);
-
-static struct platform_driver mt7621_pci_driver = {
-	.probe = mt7621_pci_probe,
-	.driver = {
-		.name = "mt7621-pci",
-		.of_match_table = of_match_ptr(mt7621_pci_ids),
-	},
-};
-builtin_platform_driver(mt7621_pci_driver);
-- 
2.25.1

