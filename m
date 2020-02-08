Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B66E41566C5
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2020 19:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgBHSg5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 8 Feb 2020 13:36:57 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38869 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbgBHSgz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 8 Feb 2020 13:36:55 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so2685698wrh.5;
        Sat, 08 Feb 2020 10:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pSnNMgA+gSAQQ6nMWDPiUCrU+iOorw2PAYUrDfXFr3c=;
        b=jSKwU31l2omkGhOo8Klfq4/dnt/uHPfVgTArVmIk1wyuK33KPZPDKDRPxgCvDuzA3U
         TxnDqqf2KNlxxB/tri3AmOmGHmoAzdb4x+s+jvC7RNvs96uL2oBSIwiW/iqTZjhkytXA
         Lr9i6hfqV9QwlC8yfGjdm4Xif4nrTP5C8laIaAcxUjKirfPvtn0/Zg7MMfCesHsIebrd
         gcN6x8LCg5sDClC8Z7fnwAd2ReE9kSzlq/dLBdRFcVdCGlI+LiQWFvlIhYqnFHjU/6fu
         9lHaoMh3eSUWAmmOmd7NqIBqBo+4dImAnv4kc23HCcL6zT1uq+CsOQ5aGqt3Ke+djebm
         BS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pSnNMgA+gSAQQ6nMWDPiUCrU+iOorw2PAYUrDfXFr3c=;
        b=Y+gyujcAcCge8Go8ItuIt0sfuxitp6aWGzP9CHqRGrgHG2L9y9v8MMkM7KgHFRMcIQ
         k2rq7Yia1nOZzbtr2cai4HLQ9cLpuRNzsy9jtQucsqBikKXsxnzyK3SaB3sFe1/xbUJF
         nGJi/qawGLtEA/J6IIp7/q+yTmE7ve/uHjGCKtU4ZFGTBrbLs6i2nWqlHTsG9LtTLZBD
         cMu79+9mzM/Pp4piFD6/a+1OnpaneZKFvpHQF69MzrX8YqRq2z/CZciA2XxXRVnvd0mh
         kyyOxHCibYT3mlhL2W6XlvUc301PCno3z41W0vfeudtuYYkRt9sPLSsfakvpDxx5Rma0
         bAjQ==
X-Gm-Message-State: APjAAAUwB2bOMxiqXWVBPI7PaF4PDZtKcgtmCIqF9Sfy/6RR/dNltnJ9
        YkXYmAj7X8RGsU7CcPQ1Fzk=
X-Google-Smtp-Source: APXvYqxV3t6DdBZqHr+wY/8yOTw4+8X9dB8KnGbkG8V0G3V9YBnL/KL9+PF777bKUVY9Buo/jGebIg==
X-Received: by 2002:adf:f10b:: with SMTP id r11mr6385996wro.307.1581187009944;
        Sat, 08 Feb 2020 10:36:49 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2510:d000:a553:90a1:93f5:e306])
        by smtp.gmail.com with ESMTPSA id b67sm8404385wmc.38.2020.02.08.10.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2020 10:36:49 -0800 (PST)
From:   Lad Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Andrew Murray <andrew.murray@arm.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 1/6] PCI: rcar: Preparation for adding endpoint support
Date:   Sat,  8 Feb 2020 18:36:36 +0000
Message-Id: <20200208183641.6674-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200208183641.6674-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200208183641.6674-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Prepare for adding endpoint support to rcar controller, there are no
functional changes with this patch, a common file is created so that
it can be shared with endpoint driver.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/configs/defconfig            |    2 +-
 drivers/pci/controller/Kconfig          |    4 +-
 drivers/pci/controller/Makefile         |    2 +-
 drivers/pci/controller/pcie-rcar-host.c | 1044 ++++++++++++++++++++++++++
 drivers/pci/controller/pcie-rcar.c      | 1229 ++-----------------------------
 drivers/pci/controller/pcie-rcar.h      |  126 ++++
 6 files changed, 1227 insertions(+), 1180 deletions(-)
 create mode 100644 drivers/pci/controller/pcie-rcar-host.c
 create mode 100644 drivers/pci/controller/pcie-rcar.h

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b2f6673..8a1f51d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -182,7 +182,7 @@ CONFIG_HOTPLUG_PCI=y
 CONFIG_HOTPLUG_PCI_ACPI=y
 CONFIG_PCI_AARDVARK=y
 CONFIG_PCI_TEGRA=y
-CONFIG_PCIE_RCAR=y
+CONFIG_PCIE_RCAR_HOST=y
 CONFIG_PCI_HOST_GENERIC=y
 CONFIG_PCI_XGENE=y
 CONFIG_PCIE_ALTERA=y
diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index f84e5ff..94bb5e9 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -54,12 +54,12 @@ config PCI_RCAR_GEN2
 	  There are 3 internal PCI controllers available with a single
 	  built-in EHCI/OHCI host controller present on each one.
 
-config PCIE_RCAR
+config PCIE_RCAR_HOST
 	bool "Renesas R-Car PCIe controller"
 	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	help
-	  Say Y here if you want PCIe controller support on R-Car SoCs.
+	  Say Y here if you want PCIe controller support on R-Car SoCs in host mode.
 
 config PCI_HOST_COMMON
 	bool
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index 01b2502..b4ada32 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
 obj-$(CONFIG_PCI_AARDVARK) += pci-aardvark.o
 obj-$(CONFIG_PCI_TEGRA) += pci-tegra.o
 obj-$(CONFIG_PCI_RCAR_GEN2) += pci-rcar-gen2.o
-obj-$(CONFIG_PCIE_RCAR) += pcie-rcar.o
+obj-$(CONFIG_PCIE_RCAR_HOST) += pcie-rcar.o pcie-rcar-host.o
 obj-$(CONFIG_PCI_HOST_COMMON) += pci-host-common.o
 obj-$(CONFIG_PCI_HOST_GENERIC) += pci-host-generic.o
 obj-$(CONFIG_PCIE_XILINX) += pcie-xilinx.o
diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
new file mode 100644
index 0000000..35cdac2
--- /dev/null
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -0,0 +1,1044 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe driver for Renesas R-Car SoCs
+ *  Copyright (C) 2014-2020 Renesas Electronics Europe Ltd
+ *
+ * Based on:
+ *  arch/sh/drivers/pci/pcie-sh7786.c
+ *  arch/sh/drivers/pci/ops-sh7786.c
+ *  Copyright (C) 2009-2011  Paul Mundt
+ *
+ * Author: Phil Edworthy <phil.edworthy@renesas.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/msi.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_pci.h>
+#include <linux/of_platform.h>
+#include <linux/pci.h>
+#include <linux/phy/phy.h>
+
+#include "pcie-rcar.h"
+
+struct rcar_msi {
+	DECLARE_BITMAP(used, INT_PCI_MSI_NR);
+	struct irq_domain *domain;
+	struct msi_controller chip;
+	unsigned long pages;
+	struct mutex lock;
+	int irq1;
+	int irq2;
+};
+
+static inline struct rcar_msi *to_rcar_msi(struct msi_controller *chip)
+{
+	return container_of(chip, struct rcar_msi, chip);
+}
+
+/* Structure representing the PCIe interface */
+struct rcar_pcie {
+	struct device		*dev;
+	struct phy		*phy;
+	void __iomem		*base;
+	struct list_head	resources;
+	int			root_bus_nr;
+	struct clk		*bus_clk;
+	struct			rcar_msi msi;
+};
+
+static u32 rcar_read_conf(struct rcar_pcie *pcie, int where)
+{
+	unsigned int shift = BITS_PER_BYTE * (where & 3);
+	u32 val = rcar_pci_read_reg(pcie->base, where & ~3);
+
+	return val >> shift;
+}
+
+/* Serialization is provided by 'pci_lock' in drivers/pci/access.c */
+static int rcar_pcie_config_access(struct rcar_pcie *pcie,
+		unsigned char access_type, struct pci_bus *bus,
+		unsigned int devfn, int where, u32 *data)
+{
+	unsigned int dev, func, reg, index;
+
+	dev = PCI_SLOT(devfn);
+	func = PCI_FUNC(devfn);
+	reg = where & ~3;
+	index = reg / 4;
+
+	/*
+	 * While each channel has its own memory-mapped extended config
+	 * space, it's generally only accessible when in endpoint mode.
+	 * When in root complex mode, the controller is unable to target
+	 * itself with either type 0 or type 1 accesses, and indeed, any
+	 * controller initiated target transfer to its own config space
+	 * result in a completer abort.
+	 *
+	 * Each channel effectively only supports a single device, but as
+	 * the same channel <-> device access works for any PCI_SLOT()
+	 * value, we cheat a bit here and bind the controller's config
+	 * space to devfn 0 in order to enable self-enumeration. In this
+	 * case the regular ECAR/ECDR path is sidelined and the mangled
+	 * config access itself is initiated as an internal bus transaction.
+	 */
+	if (pci_is_root_bus(bus)) {
+		if (dev != 0)
+			return PCIBIOS_DEVICE_NOT_FOUND;
+
+		if (access_type == RCAR_PCI_ACCESS_READ) {
+			*data = rcar_pci_read_reg(pcie->base, PCICONF(index));
+		} else {
+			/* Keep an eye out for changes to the root bus number */
+			if (pci_is_root_bus(bus) && (reg == PCI_PRIMARY_BUS))
+				pcie->root_bus_nr = *data & 0xff;
+
+			rcar_pci_write_reg(pcie->base, *data, PCICONF(index));
+		}
+
+		return PCIBIOS_SUCCESSFUL;
+	}
+
+	if (pcie->root_bus_nr < 0)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	/* Clear errors */
+	rcar_pci_write_reg(pcie->base, rcar_pci_read_reg(pcie->base, PCIEERRFR),
+			   PCIEERRFR);
+
+	/* Set the PIO address */
+	rcar_pci_write_reg(pcie->base, PCIE_CONF_BUS(bus->number) |
+		PCIE_CONF_DEV(dev) | PCIE_CONF_FUNC(func) | reg, PCIECAR);
+
+	/* Enable the configuration access */
+	if (bus->parent->number == pcie->root_bus_nr)
+		rcar_pci_write_reg(pcie->base, CONFIG_SEND_ENABLE | TYPE0,
+				   PCIECCTLR);
+	else
+		rcar_pci_write_reg(pcie->base, CONFIG_SEND_ENABLE | TYPE1,
+				   PCIECCTLR);
+
+	/* Check for errors */
+	if (rcar_pci_read_reg(pcie->base, PCIEERRFR) & UNSUPPORTED_REQUEST)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	/* Check for master and target aborts */
+	if (rcar_read_conf(pcie, RCONF(PCI_STATUS)) &
+		(PCI_STATUS_REC_MASTER_ABORT | PCI_STATUS_REC_TARGET_ABORT))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (access_type == RCAR_PCI_ACCESS_READ)
+		*data = rcar_pci_read_reg(pcie->base, PCIECDR);
+	else
+		rcar_pci_write_reg(pcie->base, *data, PCIECDR);
+
+	/* Disable the configuration access */
+	rcar_pci_write_reg(pcie->base, 0, PCIECCTLR);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int rcar_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
+			       int where, int size, u32 *val)
+{
+	struct rcar_pcie *pcie = bus->sysdata;
+	int ret;
+
+	ret = rcar_pcie_config_access(pcie, RCAR_PCI_ACCESS_READ,
+				      bus, devfn, where, val);
+	if (ret != PCIBIOS_SUCCESSFUL) {
+		*val = 0xffffffff;
+		return ret;
+	}
+
+	if (size == 1)
+		*val = (*val >> (BITS_PER_BYTE * (where & 3))) & 0xff;
+	else if (size == 2)
+		*val = (*val >> (BITS_PER_BYTE * (where & 2))) & 0xffff;
+
+	dev_dbg(&bus->dev, "pcie-config-read: bus=%3d devfn=0x%04x where=0x%04x size=%d val=0x%08x\n",
+		bus->number, devfn, where, size, *val);
+
+	return ret;
+}
+
+/* Serialization is provided by 'pci_lock' in drivers/pci/access.c */
+static int rcar_pcie_write_conf(struct pci_bus *bus, unsigned int devfn,
+				int where, int size, u32 val)
+{
+	struct rcar_pcie *pcie = bus->sysdata;
+	unsigned int shift;
+	u32 data;
+	int ret;
+
+	ret = rcar_pcie_config_access(pcie, RCAR_PCI_ACCESS_READ,
+				      bus, devfn, where, &data);
+	if (ret != PCIBIOS_SUCCESSFUL)
+		return ret;
+
+	dev_dbg(&bus->dev, "pcie-config-write: bus=%3d devfn=0x%04x where=0x%04x size=%d val=0x%08x\n",
+		bus->number, devfn, where, size, val);
+
+	if (size == 1) {
+		shift = BITS_PER_BYTE * (where & 3);
+		data &= ~(0xff << shift);
+		data |= ((val & 0xff) << shift);
+	} else if (size == 2) {
+		shift = BITS_PER_BYTE * (where & 2);
+		data &= ~(0xffff << shift);
+		data |= ((val & 0xffff) << shift);
+	} else
+		data = val;
+
+	ret = rcar_pcie_config_access(pcie, RCAR_PCI_ACCESS_WRITE,
+				      bus, devfn, where, &data);
+
+	return ret;
+}
+
+static struct pci_ops rcar_pcie_ops = {
+	.read	= rcar_pcie_read_conf,
+	.write	= rcar_pcie_write_conf,
+};
+
+static int rcar_pcie_setup(struct list_head *resource, struct rcar_pcie *pci)
+{
+	struct resource_entry *win;
+	int i = 0;
+
+	/* Setup PCI resources */
+	resource_list_for_each_entry(win, &pci->resources) {
+		struct resource *res = win->res;
+
+		if (!res->flags)
+			continue;
+
+		switch (resource_type(res)) {
+		case IORESOURCE_IO:
+		case IORESOURCE_MEM:
+			rcar_pcie_set_outbound(i, pci->base, res, true);
+			i++;
+			break;
+		case IORESOURCE_BUS:
+			pci->root_bus_nr = res->start;
+			break;
+		default:
+			continue;
+		}
+
+		pci_add_resource(resource, res);
+	}
+
+	return 1;
+}
+
+static void rcar_pcie_force_speedup(struct rcar_pcie *pcie)
+{
+	struct device *dev = pcie->dev;
+	unsigned int timeout = 1000;
+	u32 macsr;
+
+	if ((rcar_pci_read_reg(pcie->base, MACS2R) & LINK_SPEED) !=
+	    LINK_SPEED_5_0GTS)
+		return;
+
+	if (rcar_pci_read_reg(pcie->base, MACCTLR) & SPEED_CHANGE) {
+		dev_err(dev, "Speed change already in progress\n");
+		return;
+	}
+
+	macsr = rcar_pci_read_reg(pcie->base, MACSR);
+	if ((macsr & LINK_SPEED) == LINK_SPEED_5_0GTS)
+		goto done;
+
+	/* Set target link speed to 5.0 GT/s */
+	rcar_rmw32(pcie->base, EXPCAP(12), PCI_EXP_LNKSTA_CLS,
+		   PCI_EXP_LNKSTA_CLS_5_0GB);
+
+	/* Set speed change reason as intentional factor */
+	rcar_rmw32(pcie->base, MACCGSPSETR, SPCNGRSN, 0);
+
+	/* Clear SPCHGFIN, SPCHGSUC, and SPCHGFAIL */
+	if (macsr & (SPCHGFIN | SPCHGSUC | SPCHGFAIL))
+		rcar_pci_write_reg(pcie->base, macsr, MACSR);
+
+	/* Start link speed change */
+	rcar_rmw32(pcie->base, MACCTLR, SPEED_CHANGE, SPEED_CHANGE);
+
+	while (timeout--) {
+		macsr = rcar_pci_read_reg(pcie->base, MACSR);
+		if (macsr & SPCHGFIN) {
+			/* Clear the interrupt bits */
+			rcar_pci_write_reg(pcie->base, macsr, MACSR);
+
+			if (macsr & SPCHGFAIL)
+				dev_err(dev, "Speed change failed\n");
+
+			goto done;
+		}
+
+		msleep(1);
+	}
+
+	dev_err(dev, "Speed change timed out\n");
+
+done:
+	dev_info(dev, "Current link speed is %s GT/s\n",
+		 (macsr & LINK_SPEED) == LINK_SPEED_5_0GTS ? "5" : "2.5");
+}
+
+static int rcar_pcie_enable(struct rcar_pcie *pcie)
+{
+	struct device *dev = pcie->dev;
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
+	struct pci_bus *bus, *child;
+	int ret;
+
+	/* Try setting 5 GT/s link speed */
+	rcar_pcie_force_speedup(pcie);
+
+	rcar_pcie_setup(&bridge->windows, pcie);
+
+	pci_add_flags(PCI_REASSIGN_ALL_BUS);
+
+	bridge->dev.parent = dev;
+	bridge->sysdata = pcie;
+	bridge->busnr = pcie->root_bus_nr;
+	bridge->ops = &rcar_pcie_ops;
+	bridge->map_irq = of_irq_parse_and_map_pci;
+	bridge->swizzle_irq = pci_common_swizzle;
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		bridge->msi = &pcie->msi.chip;
+
+	ret = pci_scan_root_bus_bridge(bridge);
+	if (ret < 0)
+		return ret;
+
+	bus = bridge->bus;
+
+	pci_bus_size_bridges(bus);
+	pci_bus_assign_resources(bus);
+
+	list_for_each_entry(child, &bus->children, node)
+		pcie_bus_configure_settings(child);
+
+	pci_bus_add_devices(bus);
+
+	return 0;
+}
+
+static int phy_wait_for_ack(struct rcar_pcie *pcie)
+{
+	struct device *dev = pcie->dev;
+	unsigned int timeout = 100;
+
+	while (timeout--) {
+		if (rcar_pci_read_reg(pcie->base, H1_PCIEPHYADRR) & PHY_ACK)
+			return 0;
+
+		udelay(100);
+	}
+
+	dev_err(dev, "Access to PCIe phy timed out\n");
+
+	return -ETIMEDOUT;
+}
+
+static void phy_write_reg(struct rcar_pcie *pcie,
+			  unsigned int rate, u32 addr,
+			  unsigned int lane, u32 data)
+{
+	u32 phyaddr;
+
+	phyaddr = WRITE_CMD |
+		((rate & 1) << RATE_POS) |
+		((lane & 0xf) << LANE_POS) |
+		((addr & 0xff) << ADR_POS);
+
+	/* Set write data */
+	rcar_pci_write_reg(pcie->base, data, H1_PCIEPHYDOUTR);
+	rcar_pci_write_reg(pcie->base, phyaddr, H1_PCIEPHYADRR);
+
+	/* Ignore errors as they will be dealt with if the data link is down */
+	phy_wait_for_ack(pcie);
+
+	/* Clear command */
+	rcar_pci_write_reg(pcie->base, 0, H1_PCIEPHYDOUTR);
+	rcar_pci_write_reg(pcie->base, 0, H1_PCIEPHYADRR);
+
+	/* Ignore errors as they will be dealt with if the data link is down */
+	phy_wait_for_ack(pcie);
+}
+
+static int rcar_pcie_hw_init(struct rcar_pcie *pcie)
+{
+	int err;
+
+	/* Begin initialization */
+	rcar_pci_write_reg(pcie->base, 0, PCIETCTLR);
+
+	/* Set mode */
+	rcar_pci_write_reg(pcie->base, 1, PCIEMSR);
+
+	err = rcar_pcie_wait_for_phyrdy(pcie->base);
+	if (err)
+		return err;
+
+	/*
+	 * Initial header for port config space is type 1, set the device
+	 * class to match. Hardware takes care of propagating the IDSETR
+	 * settings, so there is no need to bother with a quirk.
+	 */
+	rcar_pci_write_reg(pcie->base, PCI_CLASS_BRIDGE_PCI << 16, IDSETR1);
+
+	/*
+	 * Setup Secondary Bus Number & Subordinate Bus Number, even though
+	 * they aren't used, to avoid bridge being detected as broken.
+	 */
+	rcar_rmw32(pcie->base, RCONF(PCI_SECONDARY_BUS), 0xff, 1);
+	rcar_rmw32(pcie->base, RCONF(PCI_SUBORDINATE_BUS), 0xff, 1);
+
+	/* Initialize default capabilities. */
+	rcar_rmw32(pcie->base, REXPCAP(0), 0xff, PCI_CAP_ID_EXP);
+	rcar_rmw32(pcie->base, REXPCAP(PCI_EXP_FLAGS),
+		   PCI_EXP_FLAGS_TYPE, PCI_EXP_TYPE_ROOT_PORT << 4);
+	rcar_rmw32(pcie->base, RCONF(PCI_HEADER_TYPE), 0x7f,
+		   PCI_HEADER_TYPE_BRIDGE);
+
+	/* Enable data link layer active state reporting */
+	rcar_rmw32(pcie->base, REXPCAP(PCI_EXP_LNKCAP), PCI_EXP_LNKCAP_DLLLARC,
+		   PCI_EXP_LNKCAP_DLLLARC);
+
+	/* Write out the physical slot number = 0 */
+	rcar_rmw32(pcie->base, REXPCAP(PCI_EXP_SLTCAP), PCI_EXP_SLTCAP_PSN, 0);
+
+	/* Set the completion timer timeout to the maximum 50ms. */
+	rcar_rmw32(pcie->base, TLCTLR + 1, 0x3f, 50);
+
+	/* Terminate list of capabilities (Next Capability Offset=0) */
+	rcar_rmw32(pcie->base, RVCCAP(0), 0xfff00000, 0);
+
+	/* Enable MSI */
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		rcar_pci_write_reg(pcie->base, 0x801f0000, PCIEMSITXR);
+
+	rcar_pci_write_reg(pcie->base, MACCTLR_INIT_VAL, MACCTLR);
+
+	/* Finish initialization - establish a PCI Express link */
+	rcar_pci_write_reg(pcie->base, CFINIT, PCIETCTLR);
+
+	/* This will timeout if we don't have a link. */
+	err = rcar_pcie_wait_for_dl(pcie->base);
+	if (err)
+		return err;
+
+	/* Enable INTx interrupts */
+	rcar_rmw32(pcie->base, PCIEINTXR, 0, 0xF << 8);
+
+	wmb();
+
+	return 0;
+}
+
+static int rcar_pcie_phy_init_h1(struct rcar_pcie *pcie)
+{
+	/* Initialize the phy */
+	phy_write_reg(pcie, 0, 0x42, 0x1, 0x0EC34191);
+	phy_write_reg(pcie, 1, 0x42, 0x1, 0x0EC34180);
+	phy_write_reg(pcie, 0, 0x43, 0x1, 0x00210188);
+	phy_write_reg(pcie, 1, 0x43, 0x1, 0x00210188);
+	phy_write_reg(pcie, 0, 0x44, 0x1, 0x015C0014);
+	phy_write_reg(pcie, 1, 0x44, 0x1, 0x015C0014);
+	phy_write_reg(pcie, 1, 0x4C, 0x1, 0x786174A0);
+	phy_write_reg(pcie, 1, 0x4D, 0x1, 0x048000BB);
+	phy_write_reg(pcie, 0, 0x51, 0x1, 0x079EC062);
+	phy_write_reg(pcie, 0, 0x52, 0x1, 0x20000000);
+	phy_write_reg(pcie, 1, 0x52, 0x1, 0x20000000);
+	phy_write_reg(pcie, 1, 0x56, 0x1, 0x00003806);
+
+	phy_write_reg(pcie, 0, 0x60, 0x1, 0x004B03A5);
+	phy_write_reg(pcie, 0, 0x64, 0x1, 0x3F0F1F0F);
+	phy_write_reg(pcie, 0, 0x66, 0x1, 0x00008000);
+
+	return 0;
+}
+
+static int rcar_pcie_phy_init_gen2(struct rcar_pcie *pcie)
+{
+	/*
+	 * These settings come from the R-Car Series, 2nd Generation User's
+	 * Manual, section 50.3.1 (2) Initialization of the physical layer.
+	 */
+	rcar_pci_write_reg(pcie->base, 0x000f0030, GEN2_PCIEPHYADDR);
+	rcar_pci_write_reg(pcie->base, 0x00381203, GEN2_PCIEPHYDATA);
+	rcar_pci_write_reg(pcie->base, 0x00000001, GEN2_PCIEPHYCTRL);
+	rcar_pci_write_reg(pcie->base, 0x00000006, GEN2_PCIEPHYCTRL);
+
+	rcar_pci_write_reg(pcie->base, 0x000f0054, GEN2_PCIEPHYADDR);
+	/* The following value is for DC connection, no termination resistor */
+	rcar_pci_write_reg(pcie->base, 0x13802007, GEN2_PCIEPHYDATA);
+	rcar_pci_write_reg(pcie->base, 0x00000001, GEN2_PCIEPHYCTRL);
+	rcar_pci_write_reg(pcie->base, 0x00000006, GEN2_PCIEPHYCTRL);
+
+	return 0;
+}
+
+static int rcar_pcie_phy_init_gen3(struct rcar_pcie *pcie)
+{
+	int err;
+
+	err = phy_init(pcie->phy);
+	if (err)
+		return err;
+
+	err = phy_power_on(pcie->phy);
+	if (err)
+		phy_exit(pcie->phy);
+
+	return err;
+}
+
+static int rcar_msi_alloc(struct rcar_msi *chip)
+{
+	int msi;
+
+	mutex_lock(&chip->lock);
+
+	msi = find_first_zero_bit(chip->used, INT_PCI_MSI_NR);
+	if (msi < INT_PCI_MSI_NR)
+		set_bit(msi, chip->used);
+	else
+		msi = -ENOSPC;
+
+	mutex_unlock(&chip->lock);
+
+	return msi;
+}
+
+static int rcar_msi_alloc_region(struct rcar_msi *chip, int no_irqs)
+{
+	int msi;
+
+	mutex_lock(&chip->lock);
+	msi = bitmap_find_free_region(chip->used, INT_PCI_MSI_NR,
+				      order_base_2(no_irqs));
+	mutex_unlock(&chip->lock);
+
+	return msi;
+}
+
+static void rcar_msi_free(struct rcar_msi *chip, unsigned long irq)
+{
+	mutex_lock(&chip->lock);
+	clear_bit(irq, chip->used);
+	mutex_unlock(&chip->lock);
+}
+
+static irqreturn_t rcar_pcie_msi_irq(int irq, void *data)
+{
+	struct rcar_pcie *pcie = data;
+	struct rcar_msi *msi = &pcie->msi;
+	struct device *dev = pcie->dev;
+	unsigned long reg;
+
+	reg = rcar_pci_read_reg(pcie->base, PCIEMSIFR);
+
+	/* MSI & INTx share an interrupt - we only handle MSI here */
+	if (!reg)
+		return IRQ_NONE;
+
+	while (reg) {
+		unsigned int index = find_first_bit(&reg, 32);
+		unsigned int msi_irq;
+
+		/* clear the interrupt */
+		rcar_pci_write_reg(pcie->base, 1 << index, PCIEMSIFR);
+
+		msi_irq = irq_find_mapping(msi->domain, index);
+		if (msi_irq) {
+			if (test_bit(index, msi->used))
+				generic_handle_irq(msi_irq);
+			else
+				dev_info(dev, "unhandled MSI\n");
+		} else {
+			/* Unknown MSI, just clear it */
+			dev_dbg(dev, "unexpected MSI\n");
+		}
+
+		/* see if there's any more pending in this vector */
+		reg = rcar_pci_read_reg(pcie->base, PCIEMSIFR);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int rcar_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
+			      struct msi_desc *desc)
+{
+	struct rcar_msi *msi = to_rcar_msi(chip);
+	struct rcar_pcie *pcie = container_of(chip, struct rcar_pcie, msi.chip);
+	struct msi_msg msg;
+	unsigned int irq;
+	int hwirq;
+
+	hwirq = rcar_msi_alloc(msi);
+	if (hwirq < 0)
+		return hwirq;
+
+	irq = irq_find_mapping(msi->domain, hwirq);
+	if (!irq) {
+		rcar_msi_free(msi, hwirq);
+		return -EINVAL;
+	}
+
+	irq_set_msi_desc(irq, desc);
+
+	msg.address_lo = rcar_pci_read_reg(pcie->base, PCIEMSIALR) & ~MSIFE;
+	msg.address_hi = rcar_pci_read_reg(pcie->base, PCIEMSIAUR);
+	msg.data = hwirq;
+
+	pci_write_msi_msg(irq, &msg);
+
+	return 0;
+}
+
+static int rcar_msi_setup_irqs(struct msi_controller *chip,
+			       struct pci_dev *pdev, int nvec, int type)
+{
+	struct rcar_pcie *pcie = container_of(chip, struct rcar_pcie, msi.chip);
+	struct rcar_msi *msi = to_rcar_msi(chip);
+	struct msi_desc *desc;
+	struct msi_msg msg;
+	unsigned int irq;
+	int hwirq;
+	int i;
+
+	/* MSI-X interrupts are not supported */
+	if (type == PCI_CAP_ID_MSIX)
+		return -EINVAL;
+
+	WARN_ON(!list_is_singular(&pdev->dev.msi_list));
+	desc = list_entry(pdev->dev.msi_list.next, struct msi_desc, list);
+
+	hwirq = rcar_msi_alloc_region(msi, nvec);
+	if (hwirq < 0)
+		return -ENOSPC;
+
+	irq = irq_find_mapping(msi->domain, hwirq);
+	if (!irq)
+		return -ENOSPC;
+
+	for (i = 0; i < nvec; i++) {
+		/*
+		 * irq_create_mapping() called from rcar_pcie_probe() pre-
+		 * allocates descs,  so there is no need to allocate descs here.
+		 * We can therefore assume that if irq_find_mapping() above
+		 * returns non-zero, then the descs are also successfully
+		 * allocated.
+		 */
+		if (irq_set_msi_desc_off(irq, i, desc)) {
+			/* TODO: clear */
+			return -EINVAL;
+		}
+	}
+
+	desc->nvec_used = nvec;
+	desc->msi_attrib.multiple = order_base_2(nvec);
+
+	msg.address_lo = rcar_pci_read_reg(pcie->base, PCIEMSIALR) & ~MSIFE;
+	msg.address_hi = rcar_pci_read_reg(pcie->base, PCIEMSIAUR);
+	msg.data = hwirq;
+
+	pci_write_msi_msg(irq, &msg);
+
+	return 0;
+}
+
+static void rcar_msi_teardown_irq(struct msi_controller *chip, unsigned int irq)
+{
+	struct rcar_msi *msi = to_rcar_msi(chip);
+	struct irq_data *d = irq_get_irq_data(irq);
+
+	rcar_msi_free(msi, d->hwirq);
+}
+
+static struct irq_chip rcar_msi_irq_chip = {
+	.name = "R-Car PCIe MSI",
+	.irq_enable = pci_msi_unmask_irq,
+	.irq_disable = pci_msi_mask_irq,
+	.irq_mask = pci_msi_mask_irq,
+	.irq_unmask = pci_msi_unmask_irq,
+};
+
+static int rcar_msi_map(struct irq_domain *domain, unsigned int irq,
+			irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &rcar_msi_irq_chip, handle_simple_irq);
+	irq_set_chip_data(irq, domain->host_data);
+
+	return 0;
+}
+
+static const struct irq_domain_ops msi_domain_ops = {
+	.map = rcar_msi_map,
+};
+
+static void rcar_pcie_unmap_msi(struct rcar_pcie *pcie)
+{
+	struct rcar_msi *msi = &pcie->msi;
+	int i, irq;
+
+	for (i = 0; i < INT_PCI_MSI_NR; i++) {
+		irq = irq_find_mapping(msi->domain, i);
+		if (irq > 0)
+			irq_dispose_mapping(irq);
+	}
+
+	irq_domain_remove(msi->domain);
+}
+
+static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
+{
+	struct rcar_msi *msi = &pcie->msi;
+	struct device *dev = pcie->dev;
+	phys_addr_t base;
+	int err, i;
+
+	mutex_init(&msi->lock);
+
+	msi->chip.dev = dev;
+	msi->chip.setup_irq = rcar_msi_setup_irq;
+	msi->chip.setup_irqs = rcar_msi_setup_irqs;
+	msi->chip.teardown_irq = rcar_msi_teardown_irq;
+
+	msi->domain = irq_domain_add_linear(dev->of_node, INT_PCI_MSI_NR,
+					    &msi_domain_ops, &msi->chip);
+	if (!msi->domain) {
+		dev_err(dev, "failed to create IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < INT_PCI_MSI_NR; i++)
+		irq_create_mapping(msi->domain, i);
+
+	/* Two irqs are for MSI, but they are also used for non-MSI irqs */
+	err = devm_request_irq(dev, msi->irq1, rcar_pcie_msi_irq,
+			       IRQF_SHARED | IRQF_NO_THREAD,
+			       rcar_msi_irq_chip.name, pcie);
+	if (err < 0) {
+		dev_err(dev, "failed to request IRQ: %d\n", err);
+		goto err;
+	}
+
+	err = devm_request_irq(dev, msi->irq2, rcar_pcie_msi_irq,
+			       IRQF_SHARED | IRQF_NO_THREAD,
+			       rcar_msi_irq_chip.name, pcie);
+	if (err < 0) {
+		dev_err(dev, "failed to request IRQ: %d\n", err);
+		goto err;
+	}
+
+	/* setup MSI data target */
+	msi->pages = __get_free_pages(GFP_KERNEL, 0);
+	if (!msi->pages) {
+		err = -ENOMEM;
+		goto err;
+	}
+	base = virt_to_phys((void *)msi->pages);
+
+	rcar_pci_write_reg(pcie->base, lower_32_bits(base) | MSIFE, PCIEMSIALR);
+	rcar_pci_write_reg(pcie->base, upper_32_bits(base), PCIEMSIAUR);
+
+	/* enable all MSI interrupts */
+	rcar_pci_write_reg(pcie->base, 0xffffffff, PCIEMSIIER);
+
+	return 0;
+
+err:
+	rcar_pcie_unmap_msi(pcie);
+	return err;
+}
+
+static void rcar_pcie_teardown_msi(struct rcar_pcie *pcie)
+{
+	struct rcar_msi *msi = &pcie->msi;
+
+	/* Disable all MSI interrupts */
+	rcar_pci_write_reg(pcie->base, 0, PCIEMSIIER);
+
+	/* Disable address decoding of the MSI interrupt, MSIFE */
+	rcar_pci_write_reg(pcie->base, 0, PCIEMSIALR);
+
+	free_pages(msi->pages, 0);
+
+	rcar_pcie_unmap_msi(pcie);
+}
+
+static int rcar_pcie_get_resources(struct rcar_pcie *pcie)
+{
+	struct device *dev = pcie->dev;
+	struct resource res;
+	int err, i;
+
+	pcie->phy = devm_phy_optional_get(dev, "pcie");
+	if (IS_ERR(pcie->phy))
+		return PTR_ERR(pcie->phy);
+
+	err = of_address_to_resource(dev->of_node, 0, &res);
+	if (err)
+		return err;
+
+	pcie->base = devm_ioremap_resource(dev, &res);
+	if (IS_ERR(pcie->base))
+		return PTR_ERR(pcie->base);
+
+	pcie->bus_clk = devm_clk_get(dev, "pcie_bus");
+	if (IS_ERR(pcie->bus_clk)) {
+		dev_err(dev, "cannot get pcie bus clock\n");
+		return PTR_ERR(pcie->bus_clk);
+	}
+
+	i = irq_of_parse_and_map(dev->of_node, 0);
+	if (!i) {
+		dev_err(dev, "cannot get platform resources for msi interrupt\n");
+		err = -ENOENT;
+		goto err_irq1;
+	}
+	pcie->msi.irq1 = i;
+
+	i = irq_of_parse_and_map(dev->of_node, 1);
+	if (!i) {
+		dev_err(dev, "cannot get platform resources for msi interrupt\n");
+		err = -ENOENT;
+		goto err_irq2;
+	}
+	pcie->msi.irq2 = i;
+
+	return 0;
+
+err_irq2:
+	irq_dispose_mapping(pcie->msi.irq1);
+err_irq1:
+	return err;
+}
+
+static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
+				    struct resource_entry *entry,
+				    int *index)
+{
+	u64 restype = entry->res->flags;
+	u64 cpu_addr = entry->res->start;
+	u64 cpu_end = entry->res->end;
+	u64 pci_addr = entry->res->start - entry->offset;
+	u32 flags = LAM_64BIT | LAR_ENABLE;
+	u64 mask;
+	u64 size = resource_size(entry->res);
+	int idx = *index;
+
+	if (restype & IORESOURCE_PREFETCH)
+		flags |= LAM_PREFETCH;
+
+	while (cpu_addr < cpu_end) {
+		if (idx >= MAX_NR_INBOUND_MAPS - 1) {
+			dev_err(pcie->dev, "Failed to map inbound regions!\n");
+			return -EINVAL;
+		}
+		/*
+		 * If the size of the range is larger than the alignment of
+		 * the start address, we have to use multiple entries to
+		 * perform the mapping.
+		 */
+		if (cpu_addr > 0) {
+			unsigned long nr_zeros = __ffs64(cpu_addr);
+			u64 alignment = 1ULL << nr_zeros;
+
+			size = min(size, alignment);
+		}
+		/* Hardware supports max 4GiB inbound region */
+		size = min(size, 1ULL << 32);
+
+		mask = roundup_pow_of_two(size) - 1;
+		mask &= ~0xf;
+
+		rcar_pcie_set_inbound(pcie->base, cpu_addr, pci_addr,
+				      mask | flags, idx, true);
+
+		pci_addr += size;
+		cpu_addr += size;
+		idx += 2;
+	}
+	*index = idx;
+
+	return 0;
+}
+
+static int rcar_pcie_parse_map_dma_ranges(struct rcar_pcie *pcie)
+{
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
+	struct resource_entry *entry;
+	int index = 0, err = 0;
+
+	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
+		err = rcar_pcie_inbound_ranges(pcie, entry, &index);
+		if (err)
+			break;
+	}
+
+	return err;
+}
+
+static const struct of_device_id rcar_pcie_of_match[] = {
+	{ .compatible = "renesas,pcie-r8a7779",
+	  .data = rcar_pcie_phy_init_h1 },
+	{ .compatible = "renesas,pcie-r8a7790",
+	  .data = rcar_pcie_phy_init_gen2 },
+	{ .compatible = "renesas,pcie-r8a7791",
+	  .data = rcar_pcie_phy_init_gen2 },
+	{ .compatible = "renesas,pcie-rcar-gen2",
+	  .data = rcar_pcie_phy_init_gen2 },
+	{ .compatible = "renesas,pcie-r8a7795",
+	  .data = rcar_pcie_phy_init_gen3 },
+	{ .compatible = "renesas,pcie-rcar-gen3",
+	  .data = rcar_pcie_phy_init_gen3 },
+	{},
+};
+
+static int rcar_pcie_probe(struct platform_device *pdev)
+{
+	int (*phy_init_fn)(struct rcar_pcie *pcie);
+	struct device *dev = &pdev->dev;
+	struct pci_host_bridge *bridge;
+	struct rcar_pcie *pcie;
+	u32 data;
+	int err;
+
+	bridge = pci_alloc_host_bridge(sizeof(*pcie));
+	if (!bridge)
+		return -ENOMEM;
+
+	pcie = pci_host_bridge_priv(bridge);
+
+	pcie->dev = dev;
+	platform_set_drvdata(pdev, pcie);
+
+	err = pci_parse_request_of_pci_ranges(dev, &pcie->resources,
+					      &bridge->dma_ranges, NULL);
+	if (err)
+		goto err_free_bridge;
+
+	pm_runtime_enable(pcie->dev);
+	err = pm_runtime_get_sync(pcie->dev);
+	if (err < 0) {
+		dev_err(pcie->dev, "pm_runtime_get_sync failed\n");
+		goto err_pm_disable;
+	}
+
+	err = rcar_pcie_get_resources(pcie);
+	if (err < 0) {
+		dev_err(dev, "failed to request resources: %d\n", err);
+		goto err_pm_put;
+	}
+
+	err = clk_prepare_enable(pcie->bus_clk);
+	if (err) {
+		dev_err(dev, "failed to enable bus clock: %d\n", err);
+		goto err_unmap_msi_irqs;
+	}
+
+	err = rcar_pcie_parse_map_dma_ranges(pcie);
+	if (err)
+		goto err_clk_disable;
+
+	phy_init_fn = of_device_get_match_data(dev);
+	err = phy_init_fn(pcie);
+	if (err) {
+		dev_err(dev, "failed to init PCIe PHY\n");
+		goto err_clk_disable;
+	}
+
+	/* Failure to get a link might just be that no cards are inserted */
+	if (rcar_pcie_hw_init(pcie)) {
+		dev_info(dev, "PCIe link down\n");
+		err = -ENODEV;
+		goto err_phy_shutdown;
+	}
+
+	data = rcar_pci_read_reg(pcie->base, MACSR);
+	dev_info(dev, "PCIe x%d: link up\n", (data >> 20) & 0x3f);
+
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		err = rcar_pcie_enable_msi(pcie);
+		if (err < 0) {
+			dev_err(dev,
+				"failed to enable MSI support: %d\n",
+				err);
+			goto err_phy_shutdown;
+		}
+	}
+
+	err = rcar_pcie_enable(pcie);
+	if (err)
+		goto err_msi_teardown;
+
+	return 0;
+
+err_msi_teardown:
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		rcar_pcie_teardown_msi(pcie);
+
+err_phy_shutdown:
+	if (pcie->phy) {
+		phy_power_off(pcie->phy);
+		phy_exit(pcie->phy);
+	}
+
+err_clk_disable:
+	clk_disable_unprepare(pcie->bus_clk);
+
+err_unmap_msi_irqs:
+	irq_dispose_mapping(pcie->msi.irq2);
+	irq_dispose_mapping(pcie->msi.irq1);
+
+err_pm_put:
+	pm_runtime_put(dev);
+
+err_pm_disable:
+	pm_runtime_disable(dev);
+	pci_free_resource_list(&pcie->resources);
+
+err_free_bridge:
+	pci_free_host_bridge(bridge);
+
+	return err;
+}
+
+static int rcar_pcie_resume_noirq(struct device *dev)
+{
+	struct rcar_pcie *pcie = dev_get_drvdata(dev);
+
+	if (rcar_pci_read_reg(pcie->base, PMSR) &&
+	    !(rcar_pci_read_reg(pcie->base, PCIETCTLR) & DL_DOWN))
+		return 0;
+
+	/* Re-establish the PCIe link */
+	rcar_pci_write_reg(pcie->base, MACCTLR_INIT_VAL, MACCTLR);
+	rcar_pci_write_reg(pcie->base, CFINIT, PCIETCTLR);
+	return rcar_pcie_wait_for_dl(pcie->base);
+}
+
+static const struct dev_pm_ops rcar_pcie_pm_ops = {
+	.resume_noirq = rcar_pcie_resume_noirq,
+};
+
+static struct platform_driver rcar_pcie_driver = {
+	.driver = {
+		.name = "rcar-pcie",
+		.of_match_table = rcar_pcie_of_match,
+		.pm = &rcar_pcie_pm_ops,
+		.suppress_bind_attrs = true,
+	},
+	.probe = rcar_pcie_probe,
+};
+builtin_platform_driver(rcar_pcie_driver);
diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index 759c654..d5568db 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * PCIe driver for Renesas R-Car SoCs
- *  Copyright (C) 2014 Renesas Electronics Europe Ltd
+ *  Copyright (C) 2014-2020 Renesas Electronics Europe Ltd
  *
  * Based on:
  *  arch/sh/drivers/pci/pcie-sh7786.c
@@ -11,336 +11,69 @@
  * Author: Phil Edworthy <phil.edworthy@renesas.com>
  */
 
-#include <linux/bitops.h>
-#include <linux/clk.h>
 #include <linux/delay.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/irqdomain.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/msi.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/of_pci.h>
-#include <linux/of_platform.h>
 #include <linux/pci.h>
-#include <linux/phy/phy.h>
-#include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
-#include <linux/slab.h>
 
-#define PCIECAR			0x000010
-#define PCIECCTLR		0x000018
-#define  CONFIG_SEND_ENABLE	BIT(31)
-#define  TYPE0			(0 << 8)
-#define  TYPE1			BIT(8)
-#define PCIECDR			0x000020
-#define PCIEMSR			0x000028
-#define PCIEINTXR		0x000400
-#define PCIEPHYSR		0x0007f0
-#define  PHYRDY			BIT(0)
-#define PCIEMSITXR		0x000840
+#include "pcie-rcar.h"
 
-/* Transfer control */
-#define PCIETCTLR		0x02000
-#define  DL_DOWN		BIT(3)
-#define  CFINIT			BIT(0)
-#define PCIETSTR		0x02004
-#define  DATA_LINK_ACTIVE	BIT(0)
-#define PCIEERRFR		0x02020
-#define  UNSUPPORTED_REQUEST	BIT(4)
-#define PCIEMSIFR		0x02044
-#define PCIEMSIALR		0x02048
-#define  MSIFE			BIT(0)
-#define PCIEMSIAUR		0x0204c
-#define PCIEMSIIER		0x02050
-
-/* root port address */
-#define PCIEPRAR(x)		(0x02080 + ((x) * 0x4))
-
-/* local address reg & mask */
-#define PCIELAR(x)		(0x02200 + ((x) * 0x20))
-#define PCIELAMR(x)		(0x02208 + ((x) * 0x20))
-#define  LAM_PREFETCH		BIT(3)
-#define  LAM_64BIT		BIT(2)
-#define  LAR_ENABLE		BIT(1)
-
-/* PCIe address reg & mask */
-#define PCIEPALR(x)		(0x03400 + ((x) * 0x20))
-#define PCIEPAUR(x)		(0x03404 + ((x) * 0x20))
-#define PCIEPAMR(x)		(0x03408 + ((x) * 0x20))
-#define PCIEPTCTLR(x)		(0x0340c + ((x) * 0x20))
-#define  PAR_ENABLE		BIT(31)
-#define  IO_SPACE		BIT(8)
-
-/* Configuration */
-#define PCICONF(x)		(0x010000 + ((x) * 0x4))
-#define PMCAP(x)		(0x010040 + ((x) * 0x4))
-#define EXPCAP(x)		(0x010070 + ((x) * 0x4))
-#define VCCAP(x)		(0x010100 + ((x) * 0x4))
-
-/* link layer */
-#define IDSETR1			0x011004
-#define TLCTLR			0x011048
-#define MACSR			0x011054
-#define  SPCHGFIN		BIT(4)
-#define  SPCHGFAIL		BIT(6)
-#define  SPCHGSUC		BIT(7)
-#define  LINK_SPEED		(0xf << 16)
-#define  LINK_SPEED_2_5GTS	(1 << 16)
-#define  LINK_SPEED_5_0GTS	(2 << 16)
-#define MACCTLR			0x011058
-#define  MACCTLR_NFTS_MASK	GENMASK(23, 16)	/* The name is from SH7786 */
-#define  SPEED_CHANGE		BIT(24)
-#define  SCRAMBLE_DISABLE	BIT(27)
-#define  LTSMDIS		BIT(31)
-#define  MACCTLR_INIT_VAL	(LTSMDIS | MACCTLR_NFTS_MASK)
-#define PMSR			0x01105c
-#define MACS2R			0x011078
-#define MACCGSPSETR		0x011084
-#define  SPCNGRSN		BIT(31)
-
-/* R-Car H1 PHY */
-#define H1_PCIEPHYADRR		0x04000c
-#define  WRITE_CMD		BIT(16)
-#define  PHY_ACK		BIT(24)
-#define  RATE_POS		12
-#define  LANE_POS		8
-#define  ADR_POS		0
-#define H1_PCIEPHYDOUTR		0x040014
-
-/* R-Car Gen2 PHY */
-#define GEN2_PCIEPHYADDR	0x780
-#define GEN2_PCIEPHYDATA	0x784
-#define GEN2_PCIEPHYCTRL	0x78c
-
-#define INT_PCI_MSI_NR		32
-
-#define RCONF(x)		(PCICONF(0) + (x))
-#define RPMCAP(x)		(PMCAP(0) + (x))
-#define REXPCAP(x)		(EXPCAP(0) + (x))
-#define RVCCAP(x)		(VCCAP(0) + (x))
-
-#define PCIE_CONF_BUS(b)	(((b) & 0xff) << 24)
-#define PCIE_CONF_DEV(d)	(((d) & 0x1f) << 19)
-#define PCIE_CONF_FUNC(f)	(((f) & 0x7) << 16)
-
-#define RCAR_PCI_MAX_RESOURCES	4
-#define MAX_NR_INBOUND_MAPS	6
-
-struct rcar_msi {
-	DECLARE_BITMAP(used, INT_PCI_MSI_NR);
-	struct irq_domain *domain;
-	struct msi_controller chip;
-	unsigned long pages;
-	struct mutex lock;
-	int irq1;
-	int irq2;
-};
-
-static inline struct rcar_msi *to_rcar_msi(struct msi_controller *chip)
+void rcar_pci_write_reg(void __iomem *base, u32 val, unsigned int reg)
 {
-	return container_of(chip, struct rcar_msi, chip);
+	writel(val, base + reg);
 }
 
-/* Structure representing the PCIe interface */
-struct rcar_pcie {
-	struct device		*dev;
-	struct phy		*phy;
-	void __iomem		*base;
-	struct list_head	resources;
-	int			root_bus_nr;
-	struct clk		*bus_clk;
-	struct			rcar_msi msi;
-};
-
-static void rcar_pci_write_reg(struct rcar_pcie *pcie, u32 val,
-			       unsigned int reg)
+u32 rcar_pci_read_reg(void __iomem *base, unsigned int reg)
 {
-	writel(val, pcie->base + reg);
+	return readl(base + reg);
 }
 
-static u32 rcar_pci_read_reg(struct rcar_pcie *pcie, unsigned int reg)
-{
-	return readl(pcie->base + reg);
-}
-
-enum {
-	RCAR_PCI_ACCESS_READ,
-	RCAR_PCI_ACCESS_WRITE,
-};
-
-static void rcar_rmw32(struct rcar_pcie *pcie, int where, u32 mask, u32 data)
+void rcar_rmw32(void __iomem *base, int where, u32 mask, u32 data)
 {
 	unsigned int shift = BITS_PER_BYTE * (where & 3);
-	u32 val = rcar_pci_read_reg(pcie, where & ~3);
+	u32 val = rcar_pci_read_reg(base, where & ~3);
 
 	val &= ~(mask << shift);
 	val |= data << shift;
-	rcar_pci_write_reg(pcie, val, where & ~3);
-}
-
-static u32 rcar_read_conf(struct rcar_pcie *pcie, int where)
-{
-	unsigned int shift = BITS_PER_BYTE * (where & 3);
-	u32 val = rcar_pci_read_reg(pcie, where & ~3);
-
-	return val >> shift;
+	rcar_pci_write_reg(base, val, where & ~3);
 }
 
-/* Serialization is provided by 'pci_lock' in drivers/pci/access.c */
-static int rcar_pcie_config_access(struct rcar_pcie *pcie,
-		unsigned char access_type, struct pci_bus *bus,
-		unsigned int devfn, int where, u32 *data)
+int rcar_pcie_wait_for_phyrdy(void __iomem *base)
 {
-	unsigned int dev, func, reg, index;
-
-	dev = PCI_SLOT(devfn);
-	func = PCI_FUNC(devfn);
-	reg = where & ~3;
-	index = reg / 4;
-
-	/*
-	 * While each channel has its own memory-mapped extended config
-	 * space, it's generally only accessible when in endpoint mode.
-	 * When in root complex mode, the controller is unable to target
-	 * itself with either type 0 or type 1 accesses, and indeed, any
-	 * controller initiated target transfer to its own config space
-	 * result in a completer abort.
-	 *
-	 * Each channel effectively only supports a single device, but as
-	 * the same channel <-> device access works for any PCI_SLOT()
-	 * value, we cheat a bit here and bind the controller's config
-	 * space to devfn 0 in order to enable self-enumeration. In this
-	 * case the regular ECAR/ECDR path is sidelined and the mangled
-	 * config access itself is initiated as an internal bus transaction.
-	 */
-	if (pci_is_root_bus(bus)) {
-		if (dev != 0)
-			return PCIBIOS_DEVICE_NOT_FOUND;
-
-		if (access_type == RCAR_PCI_ACCESS_READ) {
-			*data = rcar_pci_read_reg(pcie, PCICONF(index));
-		} else {
-			/* Keep an eye out for changes to the root bus number */
-			if (pci_is_root_bus(bus) && (reg == PCI_PRIMARY_BUS))
-				pcie->root_bus_nr = *data & 0xff;
-
-			rcar_pci_write_reg(pcie, *data, PCICONF(index));
-		}
-
-		return PCIBIOS_SUCCESSFUL;
-	}
-
-	if (pcie->root_bus_nr < 0)
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	/* Clear errors */
-	rcar_pci_write_reg(pcie, rcar_pci_read_reg(pcie, PCIEERRFR), PCIEERRFR);
-
-	/* Set the PIO address */
-	rcar_pci_write_reg(pcie, PCIE_CONF_BUS(bus->number) |
-		PCIE_CONF_DEV(dev) | PCIE_CONF_FUNC(func) | reg, PCIECAR);
-
-	/* Enable the configuration access */
-	if (bus->parent->number == pcie->root_bus_nr)
-		rcar_pci_write_reg(pcie, CONFIG_SEND_ENABLE | TYPE0, PCIECCTLR);
-	else
-		rcar_pci_write_reg(pcie, CONFIG_SEND_ENABLE | TYPE1, PCIECCTLR);
-
-	/* Check for errors */
-	if (rcar_pci_read_reg(pcie, PCIEERRFR) & UNSUPPORTED_REQUEST)
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	/* Check for master and target aborts */
-	if (rcar_read_conf(pcie, RCONF(PCI_STATUS)) &
-		(PCI_STATUS_REC_MASTER_ABORT | PCI_STATUS_REC_TARGET_ABORT))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	if (access_type == RCAR_PCI_ACCESS_READ)
-		*data = rcar_pci_read_reg(pcie, PCIECDR);
-	else
-		rcar_pci_write_reg(pcie, *data, PCIECDR);
-
-	/* Disable the configuration access */
-	rcar_pci_write_reg(pcie, 0, PCIECCTLR);
-
-	return PCIBIOS_SUCCESSFUL;
-}
+	unsigned int timeout = 10;
 
-static int rcar_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
-			       int where, int size, u32 *val)
-{
-	struct rcar_pcie *pcie = bus->sysdata;
-	int ret;
+	while (timeout--) {
+		if (rcar_pci_read_reg(base, PCIEPHYSR) & PHYRDY)
+			return 0;
 
-	ret = rcar_pcie_config_access(pcie, RCAR_PCI_ACCESS_READ,
-				      bus, devfn, where, val);
-	if (ret != PCIBIOS_SUCCESSFUL) {
-		*val = 0xffffffff;
-		return ret;
+		msleep(5);
 	}
 
-	if (size == 1)
-		*val = (*val >> (BITS_PER_BYTE * (where & 3))) & 0xff;
-	else if (size == 2)
-		*val = (*val >> (BITS_PER_BYTE * (where & 2))) & 0xffff;
-
-	dev_dbg(&bus->dev, "pcie-config-read: bus=%3d devfn=0x%04x where=0x%04x size=%d val=0x%08x\n",
-		bus->number, devfn, where, size, *val);
-
-	return ret;
+	return -ETIMEDOUT;
 }
 
-/* Serialization is provided by 'pci_lock' in drivers/pci/access.c */
-static int rcar_pcie_write_conf(struct pci_bus *bus, unsigned int devfn,
-				int where, int size, u32 val)
+int rcar_pcie_wait_for_dl(void __iomem *base)
 {
-	struct rcar_pcie *pcie = bus->sysdata;
-	unsigned int shift;
-	u32 data;
-	int ret;
-
-	ret = rcar_pcie_config_access(pcie, RCAR_PCI_ACCESS_READ,
-				      bus, devfn, where, &data);
-	if (ret != PCIBIOS_SUCCESSFUL)
-		return ret;
-
-	dev_dbg(&bus->dev, "pcie-config-write: bus=%3d devfn=0x%04x where=0x%04x size=%d val=0x%08x\n",
-		bus->number, devfn, where, size, val);
+	unsigned int timeout = 10000;
 
-	if (size == 1) {
-		shift = BITS_PER_BYTE * (where & 3);
-		data &= ~(0xff << shift);
-		data |= ((val & 0xff) << shift);
-	} else if (size == 2) {
-		shift = BITS_PER_BYTE * (where & 2);
-		data &= ~(0xffff << shift);
-		data |= ((val & 0xffff) << shift);
-	} else
-		data = val;
+	while (timeout--) {
+		if ((rcar_pci_read_reg(base, PCIETSTR) & DATA_LINK_ACTIVE))
+			return 0;
 
-	ret = rcar_pcie_config_access(pcie, RCAR_PCI_ACCESS_WRITE,
-				      bus, devfn, where, &data);
+		udelay(5);
+		cpu_relax();
+	}
 
-	return ret;
+	return -ETIMEDOUT;
 }
 
-static struct pci_ops rcar_pcie_ops = {
-	.read	= rcar_pcie_read_conf,
-	.write	= rcar_pcie_write_conf,
-};
-
-static void rcar_pcie_setup_window(int win, struct rcar_pcie *pcie,
-				   struct resource *res)
+void rcar_pcie_set_outbound(int win, void __iomem *base,
+			    struct resource *res, bool host)
 {
 	/* Setup PCIe address space mappings for each resource */
-	resource_size_t size;
 	resource_size_t res_start;
+	resource_size_t size;
 	u32 mask;
 
-	rcar_pci_write_reg(pcie, 0x00000000, PCIEPTCTLR(win));
+	rcar_pci_write_reg(base, 0x00000000, PCIEPTCTLR(win));
 
 	/*
 	 * The PAMR mask is calculated in units of 128Bytes, which
@@ -348,15 +81,19 @@ static void rcar_pcie_setup_window(int win, struct rcar_pcie *pcie,
 	 */
 	size = resource_size(res);
 	mask = (roundup_pow_of_two(size) / SZ_128) - 1;
-	rcar_pci_write_reg(pcie, mask << 7, PCIEPAMR(win));
+	rcar_pci_write_reg(base, mask << 7, PCIEPAMR(win));
 
-	if (res->flags & IORESOURCE_IO)
-		res_start = pci_pio_to_address(res->start);
-	else
+	if (!host) {
 		res_start = res->start;
+	} else {
+		if (res->flags & IORESOURCE_IO)
+			res_start = pci_pio_to_address(res->start);
+		else
+			res_start = res->start;
+	}
 
-	rcar_pci_write_reg(pcie, upper_32_bits(res_start), PCIEPAUR(win));
-	rcar_pci_write_reg(pcie, lower_32_bits(res_start) & ~0x7F,
+	rcar_pci_write_reg(base, upper_32_bits(res_start), PCIEPAUR(win));
+	rcar_pci_write_reg(base, lower_32_bits(res_start) & ~0x7F,
 			   PCIEPALR(win));
 
 	/* First resource is for IO */
@@ -364,886 +101,26 @@ static void rcar_pcie_setup_window(int win, struct rcar_pcie *pcie,
 	if (res->flags & IORESOURCE_IO)
 		mask |= IO_SPACE;
 
-	rcar_pci_write_reg(pcie, mask, PCIEPTCTLR(win));
-}
-
-static int rcar_pcie_setup(struct list_head *resource, struct rcar_pcie *pci)
-{
-	struct resource_entry *win;
-	int i = 0;
-
-	/* Setup PCI resources */
-	resource_list_for_each_entry(win, &pci->resources) {
-		struct resource *res = win->res;
-
-		if (!res->flags)
-			continue;
-
-		switch (resource_type(res)) {
-		case IORESOURCE_IO:
-		case IORESOURCE_MEM:
-			rcar_pcie_setup_window(i, pci, res);
-			i++;
-			break;
-		case IORESOURCE_BUS:
-			pci->root_bus_nr = res->start;
-			break;
-		default:
-			continue;
-		}
-
-		pci_add_resource(resource, res);
-	}
-
-	return 1;
-}
-
-static void rcar_pcie_force_speedup(struct rcar_pcie *pcie)
-{
-	struct device *dev = pcie->dev;
-	unsigned int timeout = 1000;
-	u32 macsr;
-
-	if ((rcar_pci_read_reg(pcie, MACS2R) & LINK_SPEED) != LINK_SPEED_5_0GTS)
-		return;
-
-	if (rcar_pci_read_reg(pcie, MACCTLR) & SPEED_CHANGE) {
-		dev_err(dev, "Speed change already in progress\n");
-		return;
-	}
-
-	macsr = rcar_pci_read_reg(pcie, MACSR);
-	if ((macsr & LINK_SPEED) == LINK_SPEED_5_0GTS)
-		goto done;
-
-	/* Set target link speed to 5.0 GT/s */
-	rcar_rmw32(pcie, EXPCAP(12), PCI_EXP_LNKSTA_CLS,
-		   PCI_EXP_LNKSTA_CLS_5_0GB);
-
-	/* Set speed change reason as intentional factor */
-	rcar_rmw32(pcie, MACCGSPSETR, SPCNGRSN, 0);
-
-	/* Clear SPCHGFIN, SPCHGSUC, and SPCHGFAIL */
-	if (macsr & (SPCHGFIN | SPCHGSUC | SPCHGFAIL))
-		rcar_pci_write_reg(pcie, macsr, MACSR);
-
-	/* Start link speed change */
-	rcar_rmw32(pcie, MACCTLR, SPEED_CHANGE, SPEED_CHANGE);
-
-	while (timeout--) {
-		macsr = rcar_pci_read_reg(pcie, MACSR);
-		if (macsr & SPCHGFIN) {
-			/* Clear the interrupt bits */
-			rcar_pci_write_reg(pcie, macsr, MACSR);
-
-			if (macsr & SPCHGFAIL)
-				dev_err(dev, "Speed change failed\n");
-
-			goto done;
-		}
-
-		msleep(1);
-	}
-
-	dev_err(dev, "Speed change timed out\n");
-
-done:
-	dev_info(dev, "Current link speed is %s GT/s\n",
-		 (macsr & LINK_SPEED) == LINK_SPEED_5_0GTS ? "5" : "2.5");
-}
-
-static int rcar_pcie_enable(struct rcar_pcie *pcie)
-{
-	struct device *dev = pcie->dev;
-	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
-	struct pci_bus *bus, *child;
-	int ret;
-
-	/* Try setting 5 GT/s link speed */
-	rcar_pcie_force_speedup(pcie);
-
-	rcar_pcie_setup(&bridge->windows, pcie);
-
-	pci_add_flags(PCI_REASSIGN_ALL_BUS);
-
-	bridge->dev.parent = dev;
-	bridge->sysdata = pcie;
-	bridge->busnr = pcie->root_bus_nr;
-	bridge->ops = &rcar_pcie_ops;
-	bridge->map_irq = of_irq_parse_and_map_pci;
-	bridge->swizzle_irq = pci_common_swizzle;
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		bridge->msi = &pcie->msi.chip;
-
-	ret = pci_scan_root_bus_bridge(bridge);
-	if (ret < 0)
-		return ret;
-
-	bus = bridge->bus;
-
-	pci_bus_size_bridges(bus);
-	pci_bus_assign_resources(bus);
-
-	list_for_each_entry(child, &bus->children, node)
-		pcie_bus_configure_settings(child);
-
-	pci_bus_add_devices(bus);
-
-	return 0;
-}
-
-static int phy_wait_for_ack(struct rcar_pcie *pcie)
-{
-	struct device *dev = pcie->dev;
-	unsigned int timeout = 100;
-
-	while (timeout--) {
-		if (rcar_pci_read_reg(pcie, H1_PCIEPHYADRR) & PHY_ACK)
-			return 0;
-
-		udelay(100);
-	}
-
-	dev_err(dev, "Access to PCIe phy timed out\n");
-
-	return -ETIMEDOUT;
-}
-
-static void phy_write_reg(struct rcar_pcie *pcie,
-			  unsigned int rate, u32 addr,
-			  unsigned int lane, u32 data)
-{
-	u32 phyaddr;
-
-	phyaddr = WRITE_CMD |
-		((rate & 1) << RATE_POS) |
-		((lane & 0xf) << LANE_POS) |
-		((addr & 0xff) << ADR_POS);
-
-	/* Set write data */
-	rcar_pci_write_reg(pcie, data, H1_PCIEPHYDOUTR);
-	rcar_pci_write_reg(pcie, phyaddr, H1_PCIEPHYADRR);
-
-	/* Ignore errors as they will be dealt with if the data link is down */
-	phy_wait_for_ack(pcie);
-
-	/* Clear command */
-	rcar_pci_write_reg(pcie, 0, H1_PCIEPHYDOUTR);
-	rcar_pci_write_reg(pcie, 0, H1_PCIEPHYADRR);
-
-	/* Ignore errors as they will be dealt with if the data link is down */
-	phy_wait_for_ack(pcie);
-}
-
-static int rcar_pcie_wait_for_phyrdy(struct rcar_pcie *pcie)
-{
-	unsigned int timeout = 10;
-
-	while (timeout--) {
-		if (rcar_pci_read_reg(pcie, PCIEPHYSR) & PHYRDY)
-			return 0;
-
-		msleep(5);
-	}
-
-	return -ETIMEDOUT;
-}
-
-static int rcar_pcie_wait_for_dl(struct rcar_pcie *pcie)
-{
-	unsigned int timeout = 10000;
-
-	while (timeout--) {
-		if ((rcar_pci_read_reg(pcie, PCIETSTR) & DATA_LINK_ACTIVE))
-			return 0;
-
-		udelay(5);
-		cpu_relax();
-	}
-
-	return -ETIMEDOUT;
-}
-
-static int rcar_pcie_hw_init(struct rcar_pcie *pcie)
-{
-	int err;
-
-	/* Begin initialization */
-	rcar_pci_write_reg(pcie, 0, PCIETCTLR);
-
-	/* Set mode */
-	rcar_pci_write_reg(pcie, 1, PCIEMSR);
-
-	err = rcar_pcie_wait_for_phyrdy(pcie);
-	if (err)
-		return err;
-
-	/*
-	 * Initial header for port config space is type 1, set the device
-	 * class to match. Hardware takes care of propagating the IDSETR
-	 * settings, so there is no need to bother with a quirk.
-	 */
-	rcar_pci_write_reg(pcie, PCI_CLASS_BRIDGE_PCI << 16, IDSETR1);
-
-	/*
-	 * Setup Secondary Bus Number & Subordinate Bus Number, even though
-	 * they aren't used, to avoid bridge being detected as broken.
-	 */
-	rcar_rmw32(pcie, RCONF(PCI_SECONDARY_BUS), 0xff, 1);
-	rcar_rmw32(pcie, RCONF(PCI_SUBORDINATE_BUS), 0xff, 1);
-
-	/* Initialize default capabilities. */
-	rcar_rmw32(pcie, REXPCAP(0), 0xff, PCI_CAP_ID_EXP);
-	rcar_rmw32(pcie, REXPCAP(PCI_EXP_FLAGS),
-		PCI_EXP_FLAGS_TYPE, PCI_EXP_TYPE_ROOT_PORT << 4);
-	rcar_rmw32(pcie, RCONF(PCI_HEADER_TYPE), 0x7f,
-		PCI_HEADER_TYPE_BRIDGE);
-
-	/* Enable data link layer active state reporting */
-	rcar_rmw32(pcie, REXPCAP(PCI_EXP_LNKCAP), PCI_EXP_LNKCAP_DLLLARC,
-		PCI_EXP_LNKCAP_DLLLARC);
-
-	/* Write out the physical slot number = 0 */
-	rcar_rmw32(pcie, REXPCAP(PCI_EXP_SLTCAP), PCI_EXP_SLTCAP_PSN, 0);
-
-	/* Set the completion timer timeout to the maximum 50ms. */
-	rcar_rmw32(pcie, TLCTLR + 1, 0x3f, 50);
-
-	/* Terminate list of capabilities (Next Capability Offset=0) */
-	rcar_rmw32(pcie, RVCCAP(0), 0xfff00000, 0);
-
-	/* Enable MSI */
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		rcar_pci_write_reg(pcie, 0x801f0000, PCIEMSITXR);
-
-	rcar_pci_write_reg(pcie, MACCTLR_INIT_VAL, MACCTLR);
-
-	/* Finish initialization - establish a PCI Express link */
-	rcar_pci_write_reg(pcie, CFINIT, PCIETCTLR);
-
-	/* This will timeout if we don't have a link. */
-	err = rcar_pcie_wait_for_dl(pcie);
-	if (err)
-		return err;
-
-	/* Enable INTx interrupts */
-	rcar_rmw32(pcie, PCIEINTXR, 0, 0xF << 8);
-
-	wmb();
-
-	return 0;
-}
-
-static int rcar_pcie_phy_init_h1(struct rcar_pcie *pcie)
-{
-	/* Initialize the phy */
-	phy_write_reg(pcie, 0, 0x42, 0x1, 0x0EC34191);
-	phy_write_reg(pcie, 1, 0x42, 0x1, 0x0EC34180);
-	phy_write_reg(pcie, 0, 0x43, 0x1, 0x00210188);
-	phy_write_reg(pcie, 1, 0x43, 0x1, 0x00210188);
-	phy_write_reg(pcie, 0, 0x44, 0x1, 0x015C0014);
-	phy_write_reg(pcie, 1, 0x44, 0x1, 0x015C0014);
-	phy_write_reg(pcie, 1, 0x4C, 0x1, 0x786174A0);
-	phy_write_reg(pcie, 1, 0x4D, 0x1, 0x048000BB);
-	phy_write_reg(pcie, 0, 0x51, 0x1, 0x079EC062);
-	phy_write_reg(pcie, 0, 0x52, 0x1, 0x20000000);
-	phy_write_reg(pcie, 1, 0x52, 0x1, 0x20000000);
-	phy_write_reg(pcie, 1, 0x56, 0x1, 0x00003806);
-
-	phy_write_reg(pcie, 0, 0x60, 0x1, 0x004B03A5);
-	phy_write_reg(pcie, 0, 0x64, 0x1, 0x3F0F1F0F);
-	phy_write_reg(pcie, 0, 0x66, 0x1, 0x00008000);
-
-	return 0;
+	rcar_pci_write_reg(base, mask, PCIEPTCTLR(win));
 }
 
-static int rcar_pcie_phy_init_gen2(struct rcar_pcie *pcie)
+void rcar_pcie_set_inbound(void __iomem *base,
+			   u64 cpu_addr, u64 pci_addr,
+			   u64 mask, int idx, bool host)
 {
 	/*
-	 * These settings come from the R-Car Series, 2nd Generation User's
-	 * Manual, section 50.3.1 (2) Initialization of the physical layer.
+	 * Set up 64-bit inbound regions as the range parser doesn't
+	 * distinguish between 32 and 64-bit types.
 	 */
-	rcar_pci_write_reg(pcie, 0x000f0030, GEN2_PCIEPHYADDR);
-	rcar_pci_write_reg(pcie, 0x00381203, GEN2_PCIEPHYDATA);
-	rcar_pci_write_reg(pcie, 0x00000001, GEN2_PCIEPHYCTRL);
-	rcar_pci_write_reg(pcie, 0x00000006, GEN2_PCIEPHYCTRL);
-
-	rcar_pci_write_reg(pcie, 0x000f0054, GEN2_PCIEPHYADDR);
-	/* The following value is for DC connection, no termination resistor */
-	rcar_pci_write_reg(pcie, 0x13802007, GEN2_PCIEPHYDATA);
-	rcar_pci_write_reg(pcie, 0x00000001, GEN2_PCIEPHYCTRL);
-	rcar_pci_write_reg(pcie, 0x00000006, GEN2_PCIEPHYCTRL);
-
-	return 0;
-}
-
-static int rcar_pcie_phy_init_gen3(struct rcar_pcie *pcie)
-{
-	int err;
-
-	err = phy_init(pcie->phy);
-	if (err)
-		return err;
-
-	err = phy_power_on(pcie->phy);
-	if (err)
-		phy_exit(pcie->phy);
-
-	return err;
-}
-
-static int rcar_msi_alloc(struct rcar_msi *chip)
-{
-	int msi;
-
-	mutex_lock(&chip->lock);
-
-	msi = find_first_zero_bit(chip->used, INT_PCI_MSI_NR);
-	if (msi < INT_PCI_MSI_NR)
-		set_bit(msi, chip->used);
-	else
-		msi = -ENOSPC;
-
-	mutex_unlock(&chip->lock);
-
-	return msi;
-}
-
-static int rcar_msi_alloc_region(struct rcar_msi *chip, int no_irqs)
-{
-	int msi;
-
-	mutex_lock(&chip->lock);
-	msi = bitmap_find_free_region(chip->used, INT_PCI_MSI_NR,
-				      order_base_2(no_irqs));
-	mutex_unlock(&chip->lock);
-
-	return msi;
-}
-
-static void rcar_msi_free(struct rcar_msi *chip, unsigned long irq)
-{
-	mutex_lock(&chip->lock);
-	clear_bit(irq, chip->used);
-	mutex_unlock(&chip->lock);
-}
-
-static irqreturn_t rcar_pcie_msi_irq(int irq, void *data)
-{
-	struct rcar_pcie *pcie = data;
-	struct rcar_msi *msi = &pcie->msi;
-	struct device *dev = pcie->dev;
-	unsigned long reg;
-
-	reg = rcar_pci_read_reg(pcie, PCIEMSIFR);
-
-	/* MSI & INTx share an interrupt - we only handle MSI here */
-	if (!reg)
-		return IRQ_NONE;
-
-	while (reg) {
-		unsigned int index = find_first_bit(&reg, 32);
-		unsigned int msi_irq;
-
-		/* clear the interrupt */
-		rcar_pci_write_reg(pcie, 1 << index, PCIEMSIFR);
-
-		msi_irq = irq_find_mapping(msi->domain, index);
-		if (msi_irq) {
-			if (test_bit(index, msi->used))
-				generic_handle_irq(msi_irq);
-			else
-				dev_info(dev, "unhandled MSI\n");
-		} else {
-			/* Unknown MSI, just clear it */
-			dev_dbg(dev, "unexpected MSI\n");
-		}
-
-		/* see if there's any more pending in this vector */
-		reg = rcar_pci_read_reg(pcie, PCIEMSIFR);
-	}
-
-	return IRQ_HANDLED;
-}
-
-static int rcar_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
-			      struct msi_desc *desc)
-{
-	struct rcar_msi *msi = to_rcar_msi(chip);
-	struct rcar_pcie *pcie = container_of(chip, struct rcar_pcie, msi.chip);
-	struct msi_msg msg;
-	unsigned int irq;
-	int hwirq;
-
-	hwirq = rcar_msi_alloc(msi);
-	if (hwirq < 0)
-		return hwirq;
-
-	irq = irq_find_mapping(msi->domain, hwirq);
-	if (!irq) {
-		rcar_msi_free(msi, hwirq);
-		return -EINVAL;
-	}
-
-	irq_set_msi_desc(irq, desc);
-
-	msg.address_lo = rcar_pci_read_reg(pcie, PCIEMSIALR) & ~MSIFE;
-	msg.address_hi = rcar_pci_read_reg(pcie, PCIEMSIAUR);
-	msg.data = hwirq;
-
-	pci_write_msi_msg(irq, &msg);
-
-	return 0;
-}
-
-static int rcar_msi_setup_irqs(struct msi_controller *chip,
-			       struct pci_dev *pdev, int nvec, int type)
-{
-	struct rcar_pcie *pcie = container_of(chip, struct rcar_pcie, msi.chip);
-	struct rcar_msi *msi = to_rcar_msi(chip);
-	struct msi_desc *desc;
-	struct msi_msg msg;
-	unsigned int irq;
-	int hwirq;
-	int i;
-
-	/* MSI-X interrupts are not supported */
-	if (type == PCI_CAP_ID_MSIX)
-		return -EINVAL;
-
-	WARN_ON(!list_is_singular(&pdev->dev.msi_list));
-	desc = list_entry(pdev->dev.msi_list.next, struct msi_desc, list);
-
-	hwirq = rcar_msi_alloc_region(msi, nvec);
-	if (hwirq < 0)
-		return -ENOSPC;
-
-	irq = irq_find_mapping(msi->domain, hwirq);
-	if (!irq)
-		return -ENOSPC;
-
-	for (i = 0; i < nvec; i++) {
-		/*
-		 * irq_create_mapping() called from rcar_pcie_probe() pre-
-		 * allocates descs,  so there is no need to allocate descs here.
-		 * We can therefore assume that if irq_find_mapping() above
-		 * returns non-zero, then the descs are also successfully
-		 * allocated.
-		 */
-		if (irq_set_msi_desc_off(irq, i, desc)) {
-			/* TODO: clear */
-			return -EINVAL;
-		}
-	}
-
-	desc->nvec_used = nvec;
-	desc->msi_attrib.multiple = order_base_2(nvec);
-
-	msg.address_lo = rcar_pci_read_reg(pcie, PCIEMSIALR) & ~MSIFE;
-	msg.address_hi = rcar_pci_read_reg(pcie, PCIEMSIAUR);
-	msg.data = hwirq;
-
-	pci_write_msi_msg(irq, &msg);
-
-	return 0;
-}
-
-static void rcar_msi_teardown_irq(struct msi_controller *chip, unsigned int irq)
-{
-	struct rcar_msi *msi = to_rcar_msi(chip);
-	struct irq_data *d = irq_get_irq_data(irq);
-
-	rcar_msi_free(msi, d->hwirq);
-}
-
-static struct irq_chip rcar_msi_irq_chip = {
-	.name = "R-Car PCIe MSI",
-	.irq_enable = pci_msi_unmask_irq,
-	.irq_disable = pci_msi_mask_irq,
-	.irq_mask = pci_msi_mask_irq,
-	.irq_unmask = pci_msi_unmask_irq,
-};
-
-static int rcar_msi_map(struct irq_domain *domain, unsigned int irq,
-			irq_hw_number_t hwirq)
-{
-	irq_set_chip_and_handler(irq, &rcar_msi_irq_chip, handle_simple_irq);
-	irq_set_chip_data(irq, domain->host_data);
-
-	return 0;
-}
-
-static const struct irq_domain_ops msi_domain_ops = {
-	.map = rcar_msi_map,
-};
-
-static void rcar_pcie_unmap_msi(struct rcar_pcie *pcie)
-{
-	struct rcar_msi *msi = &pcie->msi;
-	int i, irq;
-
-	for (i = 0; i < INT_PCI_MSI_NR; i++) {
-		irq = irq_find_mapping(msi->domain, i);
-		if (irq > 0)
-			irq_dispose_mapping(irq);
-	}
-
-	irq_domain_remove(msi->domain);
-}
-
-static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
-{
-	struct device *dev = pcie->dev;
-	struct rcar_msi *msi = &pcie->msi;
-	phys_addr_t base;
-	int err, i;
-
-	mutex_init(&msi->lock);
-
-	msi->chip.dev = dev;
-	msi->chip.setup_irq = rcar_msi_setup_irq;
-	msi->chip.setup_irqs = rcar_msi_setup_irqs;
-	msi->chip.teardown_irq = rcar_msi_teardown_irq;
-
-	msi->domain = irq_domain_add_linear(dev->of_node, INT_PCI_MSI_NR,
-					    &msi_domain_ops, &msi->chip);
-	if (!msi->domain) {
-		dev_err(dev, "failed to create IRQ domain\n");
-		return -ENOMEM;
-	}
-
-	for (i = 0; i < INT_PCI_MSI_NR; i++)
-		irq_create_mapping(msi->domain, i);
-
-	/* Two irqs are for MSI, but they are also used for non-MSI irqs */
-	err = devm_request_irq(dev, msi->irq1, rcar_pcie_msi_irq,
-			       IRQF_SHARED | IRQF_NO_THREAD,
-			       rcar_msi_irq_chip.name, pcie);
-	if (err < 0) {
-		dev_err(dev, "failed to request IRQ: %d\n", err);
-		goto err;
-	}
-
-	err = devm_request_irq(dev, msi->irq2, rcar_pcie_msi_irq,
-			       IRQF_SHARED | IRQF_NO_THREAD,
-			       rcar_msi_irq_chip.name, pcie);
-	if (err < 0) {
-		dev_err(dev, "failed to request IRQ: %d\n", err);
-		goto err;
-	}
-
-	/* setup MSI data target */
-	msi->pages = __get_free_pages(GFP_KERNEL, 0);
-	if (!msi->pages) {
-		err = -ENOMEM;
-		goto err;
-	}
-	base = virt_to_phys((void *)msi->pages);
-
-	rcar_pci_write_reg(pcie, lower_32_bits(base) | MSIFE, PCIEMSIALR);
-	rcar_pci_write_reg(pcie, upper_32_bits(base), PCIEMSIAUR);
-
-	/* enable all MSI interrupts */
-	rcar_pci_write_reg(pcie, 0xffffffff, PCIEMSIIER);
-
-	return 0;
-
-err:
-	rcar_pcie_unmap_msi(pcie);
-	return err;
-}
-
-static void rcar_pcie_teardown_msi(struct rcar_pcie *pcie)
-{
-	struct rcar_msi *msi = &pcie->msi;
-
-	/* Disable all MSI interrupts */
-	rcar_pci_write_reg(pcie, 0, PCIEMSIIER);
-
-	/* Disable address decoding of the MSI interrupt, MSIFE */
-	rcar_pci_write_reg(pcie, 0, PCIEMSIALR);
-
-	free_pages(msi->pages, 0);
-
-	rcar_pcie_unmap_msi(pcie);
-}
-
-static int rcar_pcie_get_resources(struct rcar_pcie *pcie)
-{
-	struct device *dev = pcie->dev;
-	struct resource res;
-	int err, i;
-
-	pcie->phy = devm_phy_optional_get(dev, "pcie");
-	if (IS_ERR(pcie->phy))
-		return PTR_ERR(pcie->phy);
-
-	err = of_address_to_resource(dev->of_node, 0, &res);
-	if (err)
-		return err;
-
-	pcie->base = devm_ioremap_resource(dev, &res);
-	if (IS_ERR(pcie->base))
-		return PTR_ERR(pcie->base);
-
-	pcie->bus_clk = devm_clk_get(dev, "pcie_bus");
-	if (IS_ERR(pcie->bus_clk)) {
-		dev_err(dev, "cannot get pcie bus clock\n");
-		return PTR_ERR(pcie->bus_clk);
-	}
-
-	i = irq_of_parse_and_map(dev->of_node, 0);
-	if (!i) {
-		dev_err(dev, "cannot get platform resources for msi interrupt\n");
-		err = -ENOENT;
-		goto err_irq1;
-	}
-	pcie->msi.irq1 = i;
-
-	i = irq_of_parse_and_map(dev->of_node, 1);
-	if (!i) {
-		dev_err(dev, "cannot get platform resources for msi interrupt\n");
-		err = -ENOENT;
-		goto err_irq2;
-	}
-	pcie->msi.irq2 = i;
-
-	return 0;
-
-err_irq2:
-	irq_dispose_mapping(pcie->msi.irq1);
-err_irq1:
-	return err;
-}
-
-static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
-				    struct resource_entry *entry,
-				    int *index)
-{
-	u64 restype = entry->res->flags;
-	u64 cpu_addr = entry->res->start;
-	u64 cpu_end = entry->res->end;
-	u64 pci_addr = entry->res->start - entry->offset;
-	u32 flags = LAM_64BIT | LAR_ENABLE;
-	u64 mask;
-	u64 size = resource_size(entry->res);
-	int idx = *index;
-
-	if (restype & IORESOURCE_PREFETCH)
-		flags |= LAM_PREFETCH;
-
-	while (cpu_addr < cpu_end) {
-		if (idx >= MAX_NR_INBOUND_MAPS - 1) {
-			dev_err(pcie->dev, "Failed to map inbound regions!\n");
-			return -EINVAL;
-		}
-		/*
-		 * If the size of the range is larger than the alignment of
-		 * the start address, we have to use multiple entries to
-		 * perform the mapping.
-		 */
-		if (cpu_addr > 0) {
-			unsigned long nr_zeros = __ffs64(cpu_addr);
-			u64 alignment = 1ULL << nr_zeros;
-
-			size = min(size, alignment);
-		}
-		/* Hardware supports max 4GiB inbound region */
-		size = min(size, 1ULL << 32);
-
-		mask = roundup_pow_of_two(size) - 1;
-		mask &= ~0xf;
-
-		/*
-		 * Set up 64-bit inbound regions as the range parser doesn't
-		 * distinguish between 32 and 64-bit types.
-		 */
-		rcar_pci_write_reg(pcie, lower_32_bits(pci_addr),
+	if (host)
+		rcar_pci_write_reg(base, lower_32_bits(pci_addr),
 				   PCIEPRAR(idx));
-		rcar_pci_write_reg(pcie, lower_32_bits(cpu_addr), PCIELAR(idx));
-		rcar_pci_write_reg(pcie, lower_32_bits(mask) | flags,
-				   PCIELAMR(idx));
+	rcar_pci_write_reg(base, lower_32_bits(cpu_addr), PCIELAR(idx));
+	rcar_pci_write_reg(base, lower_32_bits(mask), PCIELAMR(idx));
 
-		rcar_pci_write_reg(pcie, upper_32_bits(pci_addr),
+	if (host)
+		rcar_pci_write_reg(base, upper_32_bits(pci_addr),
 				   PCIEPRAR(idx + 1));
-		rcar_pci_write_reg(pcie, upper_32_bits(cpu_addr),
-				   PCIELAR(idx + 1));
-		rcar_pci_write_reg(pcie, 0, PCIELAMR(idx + 1));
-
-		pci_addr += size;
-		cpu_addr += size;
-		idx += 2;
-	}
-	*index = idx;
-
-	return 0;
-}
-
-static int rcar_pcie_parse_map_dma_ranges(struct rcar_pcie *pcie)
-{
-	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
-	struct resource_entry *entry;
-	int index = 0, err = 0;
-
-	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
-		err = rcar_pcie_inbound_ranges(pcie, entry, &index);
-		if (err)
-			break;
-	}
-
-	return err;
+	rcar_pci_write_reg(base, upper_32_bits(cpu_addr), PCIELAR(idx + 1));
+	rcar_pci_write_reg(base, 0, PCIELAMR(idx + 1));
 }
-
-static const struct of_device_id rcar_pcie_of_match[] = {
-	{ .compatible = "renesas,pcie-r8a7779",
-	  .data = rcar_pcie_phy_init_h1 },
-	{ .compatible = "renesas,pcie-r8a7790",
-	  .data = rcar_pcie_phy_init_gen2 },
-	{ .compatible = "renesas,pcie-r8a7791",
-	  .data = rcar_pcie_phy_init_gen2 },
-	{ .compatible = "renesas,pcie-rcar-gen2",
-	  .data = rcar_pcie_phy_init_gen2 },
-	{ .compatible = "renesas,pcie-r8a7795",
-	  .data = rcar_pcie_phy_init_gen3 },
-	{ .compatible = "renesas,pcie-rcar-gen3",
-	  .data = rcar_pcie_phy_init_gen3 },
-	{},
-};
-
-static int rcar_pcie_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct rcar_pcie *pcie;
-	u32 data;
-	int err;
-	int (*phy_init_fn)(struct rcar_pcie *);
-	struct pci_host_bridge *bridge;
-
-	bridge = pci_alloc_host_bridge(sizeof(*pcie));
-	if (!bridge)
-		return -ENOMEM;
-
-	pcie = pci_host_bridge_priv(bridge);
-
-	pcie->dev = dev;
-	platform_set_drvdata(pdev, pcie);
-
-	err = pci_parse_request_of_pci_ranges(dev, &pcie->resources,
-					      &bridge->dma_ranges, NULL);
-	if (err)
-		goto err_free_bridge;
-
-	pm_runtime_enable(pcie->dev);
-	err = pm_runtime_get_sync(pcie->dev);
-	if (err < 0) {
-		dev_err(pcie->dev, "pm_runtime_get_sync failed\n");
-		goto err_pm_disable;
-	}
-
-	err = rcar_pcie_get_resources(pcie);
-	if (err < 0) {
-		dev_err(dev, "failed to request resources: %d\n", err);
-		goto err_pm_put;
-	}
-
-	err = clk_prepare_enable(pcie->bus_clk);
-	if (err) {
-		dev_err(dev, "failed to enable bus clock: %d\n", err);
-		goto err_unmap_msi_irqs;
-	}
-
-	err = rcar_pcie_parse_map_dma_ranges(pcie);
-	if (err)
-		goto err_clk_disable;
-
-	phy_init_fn = of_device_get_match_data(dev);
-	err = phy_init_fn(pcie);
-	if (err) {
-		dev_err(dev, "failed to init PCIe PHY\n");
-		goto err_clk_disable;
-	}
-
-	/* Failure to get a link might just be that no cards are inserted */
-	if (rcar_pcie_hw_init(pcie)) {
-		dev_info(dev, "PCIe link down\n");
-		err = -ENODEV;
-		goto err_phy_shutdown;
-	}
-
-	data = rcar_pci_read_reg(pcie, MACSR);
-	dev_info(dev, "PCIe x%d: link up\n", (data >> 20) & 0x3f);
-
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		err = rcar_pcie_enable_msi(pcie);
-		if (err < 0) {
-			dev_err(dev,
-				"failed to enable MSI support: %d\n",
-				err);
-			goto err_phy_shutdown;
-		}
-	}
-
-	err = rcar_pcie_enable(pcie);
-	if (err)
-		goto err_msi_teardown;
-
-	return 0;
-
-err_msi_teardown:
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		rcar_pcie_teardown_msi(pcie);
-
-err_phy_shutdown:
-	if (pcie->phy) {
-		phy_power_off(pcie->phy);
-		phy_exit(pcie->phy);
-	}
-
-err_clk_disable:
-	clk_disable_unprepare(pcie->bus_clk);
-
-err_unmap_msi_irqs:
-	irq_dispose_mapping(pcie->msi.irq2);
-	irq_dispose_mapping(pcie->msi.irq1);
-
-err_pm_put:
-	pm_runtime_put(dev);
-
-err_pm_disable:
-	pm_runtime_disable(dev);
-	pci_free_resource_list(&pcie->resources);
-
-err_free_bridge:
-	pci_free_host_bridge(bridge);
-
-	return err;
-}
-
-static int rcar_pcie_resume_noirq(struct device *dev)
-{
-	struct rcar_pcie *pcie = dev_get_drvdata(dev);
-
-	if (rcar_pci_read_reg(pcie, PMSR) &&
-	    !(rcar_pci_read_reg(pcie, PCIETCTLR) & DL_DOWN))
-		return 0;
-
-	/* Re-establish the PCIe link */
-	rcar_pci_write_reg(pcie, MACCTLR_INIT_VAL, MACCTLR);
-	rcar_pci_write_reg(pcie, CFINIT, PCIETCTLR);
-	return rcar_pcie_wait_for_dl(pcie);
-}
-
-static const struct dev_pm_ops rcar_pcie_pm_ops = {
-	.resume_noirq = rcar_pcie_resume_noirq,
-};
-
-static struct platform_driver rcar_pcie_driver = {
-	.driver = {
-		.name = "rcar-pcie",
-		.of_match_table = rcar_pcie_of_match,
-		.pm = &rcar_pcie_pm_ops,
-		.suppress_bind_attrs = true,
-	},
-	.probe = rcar_pcie_probe,
-};
-builtin_platform_driver(rcar_pcie_driver);
diff --git a/drivers/pci/controller/pcie-rcar.h b/drivers/pci/controller/pcie-rcar.h
new file mode 100644
index 0000000..cbb21d3
--- /dev/null
+++ b/drivers/pci/controller/pcie-rcar.h
@@ -0,0 +1,126 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PCIe driver for Renesas R-Car SoCs
+ *  Copyright (C) 2014-2020 Renesas Electronics Europe Ltd
+ *
+ * Author: Phil Edworthy <phil.edworthy@renesas.com>
+ */
+
+#ifndef _PCIE_RCAR_H
+#define _PCIE_RCAR_H
+
+#define PCIECAR			0x000010
+#define PCIECCTLR		0x000018
+#define  CONFIG_SEND_ENABLE	BIT(31)
+#define  TYPE0			(0 << 8)
+#define  TYPE1			BIT(8)
+#define PCIECDR			0x000020
+#define PCIEMSR			0x000028
+#define PCIEINTXR		0x000400
+#define PCIEPHYSR		0x0007f0
+#define  PHYRDY			BIT(0)
+#define PCIEMSITXR		0x000840
+
+/* Transfer control */
+#define PCIETCTLR		0x02000
+#define  DL_DOWN		BIT(3)
+#define  CFINIT			BIT(0)
+#define PCIETSTR		0x02004
+#define  DATA_LINK_ACTIVE	BIT(0)
+#define PCIEERRFR		0x02020
+#define  UNSUPPORTED_REQUEST	BIT(4)
+#define PCIEMSIFR		0x02044
+#define PCIEMSIALR		0x02048
+#define  MSIFE			BIT(0)
+#define PCIEMSIAUR		0x0204c
+#define PCIEMSIIER		0x02050
+
+/* root port address */
+#define PCIEPRAR(x)		(0x02080 + ((x) * 0x4))
+
+/* local address reg & mask */
+#define PCIELAR(x)		(0x02200 + ((x) * 0x20))
+#define PCIELAMR(x)		(0x02208 + ((x) * 0x20))
+#define  LAM_PREFETCH		BIT(3)
+#define  LAM_64BIT		BIT(2)
+#define  LAR_ENABLE		BIT(1)
+
+/* PCIe address reg & mask */
+#define PCIEPALR(x)		(0x03400 + ((x) * 0x20))
+#define PCIEPAUR(x)		(0x03404 + ((x) * 0x20))
+#define PCIEPAMR(x)		(0x03408 + ((x) * 0x20))
+#define PCIEPTCTLR(x)		(0x0340c + ((x) * 0x20))
+#define  PAR_ENABLE		BIT(31)
+#define  IO_SPACE		BIT(8)
+
+/* Configuration */
+#define PCICONF(x)		(0x010000 + ((x) * 0x4))
+#define PMCAP(x)		(0x010040 + ((x) * 0x4))
+#define EXPCAP(x)		(0x010070 + ((x) * 0x4))
+#define VCCAP(x)		(0x010100 + ((x) * 0x4))
+
+/* link layer */
+#define IDSETR1			0x011004
+#define TLCTLR			0x011048
+#define MACSR			0x011054
+#define  SPCHGFIN		BIT(4)
+#define  SPCHGFAIL		BIT(6)
+#define  SPCHGSUC		BIT(7)
+#define  LINK_SPEED		(0xf << 16)
+#define  LINK_SPEED_2_5GTS	(1 << 16)
+#define  LINK_SPEED_5_0GTS	(2 << 16)
+#define MACCTLR			0x011058
+#define  MACCTLR_NFTS_MASK	GENMASK(23, 16)	/* The name is from SH7786 */
+#define  SPEED_CHANGE		BIT(24)
+#define  SCRAMBLE_DISABLE	BIT(27)
+#define  LTSMDIS		BIT(31)
+#define  MACCTLR_INIT_VAL	(LTSMDIS | MACCTLR_NFTS_MASK)
+#define PMSR			0x01105c
+#define MACS2R			0x011078
+#define MACCGSPSETR		0x011084
+#define  SPCNGRSN		BIT(31)
+
+/* R-Car H1 PHY */
+#define H1_PCIEPHYADRR		0x04000c
+#define  WRITE_CMD		BIT(16)
+#define  PHY_ACK		BIT(24)
+#define  RATE_POS		12
+#define  LANE_POS		8
+#define  ADR_POS		0
+#define H1_PCIEPHYDOUTR		0x040014
+
+/* R-Car Gen2 PHY */
+#define GEN2_PCIEPHYADDR	0x780
+#define GEN2_PCIEPHYDATA	0x784
+#define GEN2_PCIEPHYCTRL	0x78c
+
+#define INT_PCI_MSI_NR		32
+
+#define RCONF(x)		(PCICONF(0) + (x))
+#define RPMCAP(x)		(PMCAP(0) + (x))
+#define REXPCAP(x)		(EXPCAP(0) + (x))
+#define RVCCAP(x)		(VCCAP(0) + (x))
+
+#define PCIE_CONF_BUS(b)	(((b) & 0xff) << 24)
+#define PCIE_CONF_DEV(d)	(((d) & 0x1f) << 19)
+#define PCIE_CONF_FUNC(f)	(((f) & 0x7) << 16)
+
+#define RCAR_PCI_MAX_RESOURCES	4
+#define MAX_NR_INBOUND_MAPS	6
+
+enum {
+	RCAR_PCI_ACCESS_READ,
+	RCAR_PCI_ACCESS_WRITE,
+};
+
+void rcar_pci_write_reg(void __iomem *base, u32 val, unsigned int reg);
+u32 rcar_pci_read_reg(void __iomem *base, unsigned int reg);
+void rcar_rmw32(void __iomem *base, int where, u32 mask, u32 data);
+int rcar_pcie_wait_for_phyrdy(void __iomem *base);
+int rcar_pcie_wait_for_dl(void __iomem *base);
+void rcar_pcie_set_outbound(int win, void __iomem *base,
+			    struct resource *res, bool host);
+void rcar_pcie_set_inbound(void __iomem *base, u64 cpu_addr, u64 pci_addr,
+			   u64 mask, int idx, bool host);
+
+#endif
-- 
2.7.4

