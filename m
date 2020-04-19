Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1AE1AFA8A
	for <lists+linux-pci@lfdr.de>; Sun, 19 Apr 2020 15:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgDSN11 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 19 Apr 2020 09:27:27 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:23951 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725793AbgDSN11 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 19 Apr 2020 09:27:27 -0400
X-IronPort-AV: E=Sophos;i="5.72,403,1580742000"; 
   d="scan'208";a="45108823"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 19 Apr 2020 22:27:25 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 14C3E422C025;
        Sun, 19 Apr 2020 22:27:20 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Tom Joseph <tjoseph@cadence.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v8 2/8] PCI: rcar: Move shareable code to a common file
Date:   Sun, 19 Apr 2020 14:26:57 +0100
Message-Id: <1587302823-4435-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587302823-4435-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1587302823-4435-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move shareable code to common file pcie-rcar.c and the #defines to
pcie-rcar.h so that the common code can be reused with endpoint driver.
There are no functional changes with this patch for the host controller
driver.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pci/controller/Makefile         |   2 +-
 drivers/pci/controller/pcie-rcar-host.c | 378 ++++++------------------
 drivers/pci/controller/pcie-rcar.c      | 116 ++++++++
 drivers/pci/controller/pcie-rcar.h      | 131 ++++++++
 4 files changed, 345 insertions(+), 282 deletions(-)
 create mode 100644 drivers/pci/controller/pcie-rcar.c
 create mode 100644 drivers/pci/controller/pcie-rcar.h

diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index 9dbccb5b24e1..39802ee32946 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
 obj-$(CONFIG_PCI_AARDVARK) += pci-aardvark.o
 obj-$(CONFIG_PCI_TEGRA) += pci-tegra.o
 obj-$(CONFIG_PCI_RCAR_GEN2) += pci-rcar-gen2.o
-obj-$(CONFIG_PCIE_RCAR_HOST) += pcie-rcar-host.o
+obj-$(CONFIG_PCIE_RCAR_HOST) += pcie-rcar.o pcie-rcar-host.o
 obj-$(CONFIG_PCI_HOST_COMMON) += pci-host-common.o
 obj-$(CONFIG_PCI_HOST_GENERIC) += pci-host-generic.o
 obj-$(CONFIG_PCIE_XILINX) += pcie-xilinx.o
diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index 759c6542c5c8..f5740995dd96 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * PCIe driver for Renesas R-Car SoCs
- *  Copyright (C) 2014 Renesas Electronics Europe Ltd
+ *  Copyright (C) 2014-2020 Renesas Electronics Europe Ltd
  *
  * Based on:
  *  arch/sh/drivers/pci/pcie-sh7786.c
@@ -30,104 +30,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
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
-
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
+#include "pcie-rcar.h"
 
 struct rcar_msi {
 	DECLARE_BITMAP(used, INT_PCI_MSI_NR);
@@ -145,42 +48,15 @@ static inline struct rcar_msi *to_rcar_msi(struct msi_controller *chip)
 }
 
 /* Structure representing the PCIe interface */
-struct rcar_pcie {
-	struct device		*dev;
+struct rcar_pcie_host {
+	struct rcar_pcie	pcie;
 	struct phy		*phy;
-	void __iomem		*base;
 	struct list_head	resources;
 	int			root_bus_nr;
 	struct clk		*bus_clk;
 	struct			rcar_msi msi;
 };
 
-static void rcar_pci_write_reg(struct rcar_pcie *pcie, u32 val,
-			       unsigned int reg)
-{
-	writel(val, pcie->base + reg);
-}
-
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
-{
-	unsigned int shift = BITS_PER_BYTE * (where & 3);
-	u32 val = rcar_pci_read_reg(pcie, where & ~3);
-
-	val &= ~(mask << shift);
-	val |= data << shift;
-	rcar_pci_write_reg(pcie, val, where & ~3);
-}
-
 static u32 rcar_read_conf(struct rcar_pcie *pcie, int where)
 {
 	unsigned int shift = BITS_PER_BYTE * (where & 3);
@@ -190,10 +66,11 @@ static u32 rcar_read_conf(struct rcar_pcie *pcie, int where)
 }
 
 /* Serialization is provided by 'pci_lock' in drivers/pci/access.c */
-static int rcar_pcie_config_access(struct rcar_pcie *pcie,
+static int rcar_pcie_config_access(struct rcar_pcie_host *host,
 		unsigned char access_type, struct pci_bus *bus,
 		unsigned int devfn, int where, u32 *data)
 {
+	struct rcar_pcie *pcie = &host->pcie;
 	unsigned int dev, func, reg, index;
 
 	dev = PCI_SLOT(devfn);
@@ -225,7 +102,7 @@ static int rcar_pcie_config_access(struct rcar_pcie *pcie,
 		} else {
 			/* Keep an eye out for changes to the root bus number */
 			if (pci_is_root_bus(bus) && (reg == PCI_PRIMARY_BUS))
-				pcie->root_bus_nr = *data & 0xff;
+				host->root_bus_nr = *data & 0xff;
 
 			rcar_pci_write_reg(pcie, *data, PCICONF(index));
 		}
@@ -233,7 +110,7 @@ static int rcar_pcie_config_access(struct rcar_pcie *pcie,
 		return PCIBIOS_SUCCESSFUL;
 	}
 
-	if (pcie->root_bus_nr < 0)
+	if (host->root_bus_nr < 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	/* Clear errors */
@@ -244,7 +121,7 @@ static int rcar_pcie_config_access(struct rcar_pcie *pcie,
 		PCIE_CONF_DEV(dev) | PCIE_CONF_FUNC(func) | reg, PCIECAR);
 
 	/* Enable the configuration access */
-	if (bus->parent->number == pcie->root_bus_nr)
+	if (bus->parent->number == host->root_bus_nr)
 		rcar_pci_write_reg(pcie, CONFIG_SEND_ENABLE | TYPE0, PCIECCTLR);
 	else
 		rcar_pci_write_reg(pcie, CONFIG_SEND_ENABLE | TYPE1, PCIECCTLR);
@@ -272,10 +149,10 @@ static int rcar_pcie_config_access(struct rcar_pcie *pcie,
 static int rcar_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
 			       int where, int size, u32 *val)
 {
-	struct rcar_pcie *pcie = bus->sysdata;
+	struct rcar_pcie_host *host = bus->sysdata;
 	int ret;
 
-	ret = rcar_pcie_config_access(pcie, RCAR_PCI_ACCESS_READ,
+	ret = rcar_pcie_config_access(host, RCAR_PCI_ACCESS_READ,
 				      bus, devfn, where, val);
 	if (ret != PCIBIOS_SUCCESSFUL) {
 		*val = 0xffffffff;
@@ -297,12 +174,12 @@ static int rcar_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
 static int rcar_pcie_write_conf(struct pci_bus *bus, unsigned int devfn,
 				int where, int size, u32 val)
 {
-	struct rcar_pcie *pcie = bus->sysdata;
+	struct rcar_pcie_host *host = bus->sysdata;
 	unsigned int shift;
 	u32 data;
 	int ret;
 
-	ret = rcar_pcie_config_access(pcie, RCAR_PCI_ACCESS_READ,
+	ret = rcar_pcie_config_access(host, RCAR_PCI_ACCESS_READ,
 				      bus, devfn, where, &data);
 	if (ret != PCIBIOS_SUCCESSFUL)
 		return ret;
@@ -321,7 +198,7 @@ static int rcar_pcie_write_conf(struct pci_bus *bus, unsigned int devfn,
 	} else
 		data = val;
 
-	ret = rcar_pcie_config_access(pcie, RCAR_PCI_ACCESS_WRITE,
+	ret = rcar_pcie_config_access(host, RCAR_PCI_ACCESS_WRITE,
 				      bus, devfn, where, &data);
 
 	return ret;
@@ -332,48 +209,14 @@ static struct pci_ops rcar_pcie_ops = {
 	.write	= rcar_pcie_write_conf,
 };
 
-static void rcar_pcie_setup_window(int win, struct rcar_pcie *pcie,
-				   struct resource *res)
-{
-	/* Setup PCIe address space mappings for each resource */
-	resource_size_t size;
-	resource_size_t res_start;
-	u32 mask;
-
-	rcar_pci_write_reg(pcie, 0x00000000, PCIEPTCTLR(win));
-
-	/*
-	 * The PAMR mask is calculated in units of 128Bytes, which
-	 * keeps things pretty simple.
-	 */
-	size = resource_size(res);
-	mask = (roundup_pow_of_two(size) / SZ_128) - 1;
-	rcar_pci_write_reg(pcie, mask << 7, PCIEPAMR(win));
-
-	if (res->flags & IORESOURCE_IO)
-		res_start = pci_pio_to_address(res->start);
-	else
-		res_start = res->start;
-
-	rcar_pci_write_reg(pcie, upper_32_bits(res_start), PCIEPAUR(win));
-	rcar_pci_write_reg(pcie, lower_32_bits(res_start) & ~0x7F,
-			   PCIEPALR(win));
-
-	/* First resource is for IO */
-	mask = PAR_ENABLE;
-	if (res->flags & IORESOURCE_IO)
-		mask |= IO_SPACE;
-
-	rcar_pci_write_reg(pcie, mask, PCIEPTCTLR(win));
-}
-
-static int rcar_pcie_setup(struct list_head *resource, struct rcar_pcie *pci)
+static int rcar_pcie_setup(struct list_head *resource,
+			   struct rcar_pcie_host *host)
 {
 	struct resource_entry *win;
 	int i = 0;
 
 	/* Setup PCI resources */
-	resource_list_for_each_entry(win, &pci->resources) {
+	resource_list_for_each_entry(win, &host->resources) {
 		struct resource *res = win->res;
 
 		if (!res->flags)
@@ -382,11 +225,11 @@ static int rcar_pcie_setup(struct list_head *resource, struct rcar_pcie *pci)
 		switch (resource_type(res)) {
 		case IORESOURCE_IO:
 		case IORESOURCE_MEM:
-			rcar_pcie_setup_window(i, pci, res);
+			rcar_pcie_set_outbound(&host->pcie, i, res);
 			i++;
 			break;
 		case IORESOURCE_BUS:
-			pci->root_bus_nr = res->start;
+			host->root_bus_nr = res->start;
 			break;
 		default:
 			continue;
@@ -452,28 +295,29 @@ static void rcar_pcie_force_speedup(struct rcar_pcie *pcie)
 		 (macsr & LINK_SPEED) == LINK_SPEED_5_0GTS ? "5" : "2.5");
 }
 
-static int rcar_pcie_enable(struct rcar_pcie *pcie)
+static int rcar_pcie_enable(struct rcar_pcie_host *host)
 {
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(host);
+	struct rcar_pcie *pcie = &host->pcie;
 	struct device *dev = pcie->dev;
-	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
 	struct pci_bus *bus, *child;
 	int ret;
 
 	/* Try setting 5 GT/s link speed */
 	rcar_pcie_force_speedup(pcie);
 
-	rcar_pcie_setup(&bridge->windows, pcie);
+	rcar_pcie_setup(&bridge->windows, host);
 
 	pci_add_flags(PCI_REASSIGN_ALL_BUS);
 
 	bridge->dev.parent = dev;
-	bridge->sysdata = pcie;
-	bridge->busnr = pcie->root_bus_nr;
+	bridge->sysdata = host;
+	bridge->busnr = host->root_bus_nr;
 	bridge->ops = &rcar_pcie_ops;
 	bridge->map_irq = of_irq_parse_and_map_pci;
 	bridge->swizzle_irq = pci_common_swizzle;
 	if (IS_ENABLED(CONFIG_PCI_MSI))
-		bridge->msi = &pcie->msi.chip;
+		bridge->msi = &host->msi.chip;
 
 	ret = pci_scan_root_bus_bridge(bridge);
 	if (ret < 0)
@@ -535,35 +379,6 @@ static void phy_write_reg(struct rcar_pcie *pcie,
 	phy_wait_for_ack(pcie);
 }
 
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
 static int rcar_pcie_hw_init(struct rcar_pcie *pcie)
 {
 	int err;
@@ -601,7 +416,7 @@ static int rcar_pcie_hw_init(struct rcar_pcie *pcie)
 
 	/* Enable data link layer active state reporting */
 	rcar_rmw32(pcie, REXPCAP(PCI_EXP_LNKCAP), PCI_EXP_LNKCAP_DLLLARC,
-		PCI_EXP_LNKCAP_DLLLARC);
+		   PCI_EXP_LNKCAP_DLLLARC);
 
 	/* Write out the physical slot number = 0 */
 	rcar_rmw32(pcie, REXPCAP(PCI_EXP_SLTCAP), PCI_EXP_SLTCAP_PSN, 0);
@@ -634,8 +449,10 @@ static int rcar_pcie_hw_init(struct rcar_pcie *pcie)
 	return 0;
 }
 
-static int rcar_pcie_phy_init_h1(struct rcar_pcie *pcie)
+static int rcar_pcie_phy_init_h1(struct rcar_pcie_host *host)
 {
+	struct rcar_pcie *pcie = &host->pcie;
+
 	/* Initialize the phy */
 	phy_write_reg(pcie, 0, 0x42, 0x1, 0x0EC34191);
 	phy_write_reg(pcie, 1, 0x42, 0x1, 0x0EC34180);
@@ -657,8 +474,10 @@ static int rcar_pcie_phy_init_h1(struct rcar_pcie *pcie)
 	return 0;
 }
 
-static int rcar_pcie_phy_init_gen2(struct rcar_pcie *pcie)
+static int rcar_pcie_phy_init_gen2(struct rcar_pcie_host *host)
 {
+	struct rcar_pcie *pcie = &host->pcie;
+
 	/*
 	 * These settings come from the R-Car Series, 2nd Generation User's
 	 * Manual, section 50.3.1 (2) Initialization of the physical layer.
@@ -677,17 +496,17 @@ static int rcar_pcie_phy_init_gen2(struct rcar_pcie *pcie)
 	return 0;
 }
 
-static int rcar_pcie_phy_init_gen3(struct rcar_pcie *pcie)
+static int rcar_pcie_phy_init_gen3(struct rcar_pcie_host *host)
 {
 	int err;
 
-	err = phy_init(pcie->phy);
+	err = phy_init(host->phy);
 	if (err)
 		return err;
 
-	err = phy_power_on(pcie->phy);
+	err = phy_power_on(host->phy);
 	if (err)
-		phy_exit(pcie->phy);
+		phy_exit(host->phy);
 
 	return err;
 }
@@ -730,8 +549,9 @@ static void rcar_msi_free(struct rcar_msi *chip, unsigned long irq)
 
 static irqreturn_t rcar_pcie_msi_irq(int irq, void *data)
 {
-	struct rcar_pcie *pcie = data;
-	struct rcar_msi *msi = &pcie->msi;
+	struct rcar_pcie_host *host = data;
+	struct rcar_pcie *pcie = &host->pcie;
+	struct rcar_msi *msi = &host->msi;
 	struct device *dev = pcie->dev;
 	unsigned long reg;
 
@@ -770,7 +590,9 @@ static int rcar_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
 			      struct msi_desc *desc)
 {
 	struct rcar_msi *msi = to_rcar_msi(chip);
-	struct rcar_pcie *pcie = container_of(chip, struct rcar_pcie, msi.chip);
+	struct rcar_pcie_host *host = container_of(chip, struct rcar_pcie_host,
+						   msi.chip);
+	struct rcar_pcie *pcie = &host->pcie;
 	struct msi_msg msg;
 	unsigned int irq;
 	int hwirq;
@@ -799,8 +621,10 @@ static int rcar_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
 static int rcar_msi_setup_irqs(struct msi_controller *chip,
 			       struct pci_dev *pdev, int nvec, int type)
 {
-	struct rcar_pcie *pcie = container_of(chip, struct rcar_pcie, msi.chip);
 	struct rcar_msi *msi = to_rcar_msi(chip);
+	struct rcar_pcie_host *host = container_of(chip, struct rcar_pcie_host,
+						   msi.chip);
+	struct rcar_pcie *pcie = &host->pcie;
 	struct msi_desc *desc;
 	struct msi_msg msg;
 	unsigned int irq;
@@ -877,9 +701,9 @@ static const struct irq_domain_ops msi_domain_ops = {
 	.map = rcar_msi_map,
 };
 
-static void rcar_pcie_unmap_msi(struct rcar_pcie *pcie)
+static void rcar_pcie_unmap_msi(struct rcar_pcie_host *host)
 {
-	struct rcar_msi *msi = &pcie->msi;
+	struct rcar_msi *msi = &host->msi;
 	int i, irq;
 
 	for (i = 0; i < INT_PCI_MSI_NR; i++) {
@@ -891,10 +715,11 @@ static void rcar_pcie_unmap_msi(struct rcar_pcie *pcie)
 	irq_domain_remove(msi->domain);
 }
 
-static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
+static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
 {
+	struct rcar_pcie *pcie = &host->pcie;
 	struct device *dev = pcie->dev;
-	struct rcar_msi *msi = &pcie->msi;
+	struct rcar_msi *msi = &host->msi;
 	phys_addr_t base;
 	int err, i;
 
@@ -918,7 +743,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
 	/* Two irqs are for MSI, but they are also used for non-MSI irqs */
 	err = devm_request_irq(dev, msi->irq1, rcar_pcie_msi_irq,
 			       IRQF_SHARED | IRQF_NO_THREAD,
-			       rcar_msi_irq_chip.name, pcie);
+			       rcar_msi_irq_chip.name, host);
 	if (err < 0) {
 		dev_err(dev, "failed to request IRQ: %d\n", err);
 		goto err;
@@ -926,7 +751,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
 
 	err = devm_request_irq(dev, msi->irq2, rcar_pcie_msi_irq,
 			       IRQF_SHARED | IRQF_NO_THREAD,
-			       rcar_msi_irq_chip.name, pcie);
+			       rcar_msi_irq_chip.name, host);
 	if (err < 0) {
 		dev_err(dev, "failed to request IRQ: %d\n", err);
 		goto err;
@@ -949,13 +774,14 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
 	return 0;
 
 err:
-	rcar_pcie_unmap_msi(pcie);
+	rcar_pcie_unmap_msi(host);
 	return err;
 }
 
-static void rcar_pcie_teardown_msi(struct rcar_pcie *pcie)
+static void rcar_pcie_teardown_msi(struct rcar_pcie_host *host)
 {
-	struct rcar_msi *msi = &pcie->msi;
+	struct rcar_pcie *pcie = &host->pcie;
+	struct rcar_msi *msi = &host->msi;
 
 	/* Disable all MSI interrupts */
 	rcar_pci_write_reg(pcie, 0, PCIEMSIIER);
@@ -965,18 +791,19 @@ static void rcar_pcie_teardown_msi(struct rcar_pcie *pcie)
 
 	free_pages(msi->pages, 0);
 
-	rcar_pcie_unmap_msi(pcie);
+	rcar_pcie_unmap_msi(host);
 }
 
-static int rcar_pcie_get_resources(struct rcar_pcie *pcie)
+static int rcar_pcie_get_resources(struct rcar_pcie_host *host)
 {
+	struct rcar_pcie *pcie = &host->pcie;
 	struct device *dev = pcie->dev;
 	struct resource res;
 	int err, i;
 
-	pcie->phy = devm_phy_optional_get(dev, "pcie");
-	if (IS_ERR(pcie->phy))
-		return PTR_ERR(pcie->phy);
+	host->phy = devm_phy_optional_get(dev, "pcie");
+	if (IS_ERR(host->phy))
+		return PTR_ERR(host->phy);
 
 	err = of_address_to_resource(dev->of_node, 0, &res);
 	if (err)
@@ -986,10 +813,10 @@ static int rcar_pcie_get_resources(struct rcar_pcie *pcie)
 	if (IS_ERR(pcie->base))
 		return PTR_ERR(pcie->base);
 
-	pcie->bus_clk = devm_clk_get(dev, "pcie_bus");
-	if (IS_ERR(pcie->bus_clk)) {
+	host->bus_clk = devm_clk_get(dev, "pcie_bus");
+	if (IS_ERR(host->bus_clk)) {
 		dev_err(dev, "cannot get pcie bus clock\n");
-		return PTR_ERR(pcie->bus_clk);
+		return PTR_ERR(host->bus_clk);
 	}
 
 	i = irq_of_parse_and_map(dev->of_node, 0);
@@ -998,7 +825,7 @@ static int rcar_pcie_get_resources(struct rcar_pcie *pcie)
 		err = -ENOENT;
 		goto err_irq1;
 	}
-	pcie->msi.irq1 = i;
+	host->msi.irq1 = i;
 
 	i = irq_of_parse_and_map(dev->of_node, 1);
 	if (!i) {
@@ -1006,12 +833,12 @@ static int rcar_pcie_get_resources(struct rcar_pcie *pcie)
 		err = -ENOENT;
 		goto err_irq2;
 	}
-	pcie->msi.irq2 = i;
+	host->msi.irq2 = i;
 
 	return 0;
 
 err_irq2:
-	irq_dispose_mapping(pcie->msi.irq1);
+	irq_dispose_mapping(host->msi.irq1);
 err_irq1:
 	return err;
 }
@@ -1054,21 +881,8 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
 		mask = roundup_pow_of_two(size) - 1;
 		mask &= ~0xf;
 
-		/*
-		 * Set up 64-bit inbound regions as the range parser doesn't
-		 * distinguish between 32 and 64-bit types.
-		 */
-		rcar_pci_write_reg(pcie, lower_32_bits(pci_addr),
-				   PCIEPRAR(idx));
-		rcar_pci_write_reg(pcie, lower_32_bits(cpu_addr), PCIELAR(idx));
-		rcar_pci_write_reg(pcie, lower_32_bits(mask) | flags,
-				   PCIELAMR(idx));
-
-		rcar_pci_write_reg(pcie, upper_32_bits(pci_addr),
-				   PCIEPRAR(idx + 1));
-		rcar_pci_write_reg(pcie, upper_32_bits(cpu_addr),
-				   PCIELAR(idx + 1));
-		rcar_pci_write_reg(pcie, 0, PCIELAMR(idx + 1));
+		rcar_pcie_set_inbound(pcie, cpu_addr, pci_addr,
+				      lower_32_bits(mask) | flags, idx, true);
 
 		pci_addr += size;
 		cpu_addr += size;
@@ -1079,14 +893,14 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
 	return 0;
 }
 
-static int rcar_pcie_parse_map_dma_ranges(struct rcar_pcie *pcie)
+static int rcar_pcie_parse_map_dma_ranges(struct rcar_pcie_host *host)
 {
-	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(host);
 	struct resource_entry *entry;
 	int index = 0, err = 0;
 
 	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
-		err = rcar_pcie_inbound_ranges(pcie, entry, &index);
+		err = rcar_pcie_inbound_ranges(&host->pcie, entry, &index);
 		if (err)
 			break;
 	}
@@ -1113,22 +927,23 @@ static const struct of_device_id rcar_pcie_of_match[] = {
 static int rcar_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct rcar_pcie_host *host;
 	struct rcar_pcie *pcie;
 	u32 data;
 	int err;
-	int (*phy_init_fn)(struct rcar_pcie *);
+	int (*phy_init_fn)(struct rcar_pcie_host *);
 	struct pci_host_bridge *bridge;
 
-	bridge = pci_alloc_host_bridge(sizeof(*pcie));
+	bridge = pci_alloc_host_bridge(sizeof(*host));
 	if (!bridge)
 		return -ENOMEM;
 
-	pcie = pci_host_bridge_priv(bridge);
-
+	host = pci_host_bridge_priv(bridge);
+	pcie = &host->pcie;
 	pcie->dev = dev;
-	platform_set_drvdata(pdev, pcie);
+	platform_set_drvdata(pdev, host);
 
-	err = pci_parse_request_of_pci_ranges(dev, &pcie->resources,
+	err = pci_parse_request_of_pci_ranges(dev, &host->resources,
 					      &bridge->dma_ranges, NULL);
 	if (err)
 		goto err_free_bridge;
@@ -1140,24 +955,24 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 		goto err_pm_disable;
 	}
 
-	err = rcar_pcie_get_resources(pcie);
+	err = rcar_pcie_get_resources(host);
 	if (err < 0) {
 		dev_err(dev, "failed to request resources: %d\n", err);
 		goto err_pm_put;
 	}
 
-	err = clk_prepare_enable(pcie->bus_clk);
+	err = clk_prepare_enable(host->bus_clk);
 	if (err) {
 		dev_err(dev, "failed to enable bus clock: %d\n", err);
 		goto err_unmap_msi_irqs;
 	}
 
-	err = rcar_pcie_parse_map_dma_ranges(pcie);
+	err = rcar_pcie_parse_map_dma_ranges(host);
 	if (err)
 		goto err_clk_disable;
 
 	phy_init_fn = of_device_get_match_data(dev);
-	err = phy_init_fn(pcie);
+	err = phy_init_fn(host);
 	if (err) {
 		dev_err(dev, "failed to init PCIe PHY\n");
 		goto err_clk_disable;
@@ -1174,7 +989,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	dev_info(dev, "PCIe x%d: link up\n", (data >> 20) & 0x3f);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		err = rcar_pcie_enable_msi(pcie);
+		err = rcar_pcie_enable_msi(host);
 		if (err < 0) {
 			dev_err(dev,
 				"failed to enable MSI support: %d\n",
@@ -1183,7 +998,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 		}
 	}
 
-	err = rcar_pcie_enable(pcie);
+	err = rcar_pcie_enable(host);
 	if (err)
 		goto err_msi_teardown;
 
@@ -1191,27 +1006,27 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 
 err_msi_teardown:
 	if (IS_ENABLED(CONFIG_PCI_MSI))
-		rcar_pcie_teardown_msi(pcie);
+		rcar_pcie_teardown_msi(host);
 
 err_phy_shutdown:
-	if (pcie->phy) {
-		phy_power_off(pcie->phy);
-		phy_exit(pcie->phy);
+	if (host->phy) {
+		phy_power_off(host->phy);
+		phy_exit(host->phy);
 	}
 
 err_clk_disable:
-	clk_disable_unprepare(pcie->bus_clk);
+	clk_disable_unprepare(host->bus_clk);
 
 err_unmap_msi_irqs:
-	irq_dispose_mapping(pcie->msi.irq2);
-	irq_dispose_mapping(pcie->msi.irq1);
+	irq_dispose_mapping(host->msi.irq2);
+	irq_dispose_mapping(host->msi.irq1);
 
 err_pm_put:
 	pm_runtime_put(dev);
 
 err_pm_disable:
 	pm_runtime_disable(dev);
-	pci_free_resource_list(&pcie->resources);
+	pci_free_resource_list(&host->resources);
 
 err_free_bridge:
 	pci_free_host_bridge(bridge);
@@ -1221,7 +1036,8 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 
 static int rcar_pcie_resume_noirq(struct device *dev)
 {
-	struct rcar_pcie *pcie = dev_get_drvdata(dev);
+	struct rcar_pcie_host *host = dev_get_drvdata(dev);
+	struct rcar_pcie *pcie = &host->pcie;
 
 	if (rcar_pci_read_reg(pcie, PMSR) &&
 	    !(rcar_pci_read_reg(pcie, PCIETCTLR) & DL_DOWN))
diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
new file mode 100644
index 000000000000..b82f200985ec
--- /dev/null
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe driver for Renesas R-Car SoCs
+ *  Copyright (C) 2014-2020 Renesas Electronics Europe Ltd
+ *
+ * Author: Phil Edworthy <phil.edworthy@renesas.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/pci.h>
+
+#include "pcie-rcar.h"
+
+void rcar_pci_write_reg(struct rcar_pcie *pcie, u32 val, unsigned int reg)
+{
+	writel(val, pcie->base + reg);
+}
+
+u32 rcar_pci_read_reg(struct rcar_pcie *pcie, unsigned int reg)
+{
+	return readl(pcie->base + reg);
+}
+
+void rcar_rmw32(struct rcar_pcie *pcie, int where, u32 mask, u32 data)
+{
+	unsigned int shift = BITS_PER_BYTE * (where & 3);
+	u32 val = rcar_pci_read_reg(pcie, where & ~3);
+
+	val &= ~(mask << shift);
+	val |= data << shift;
+	rcar_pci_write_reg(pcie, val, where & ~3);
+}
+
+int rcar_pcie_wait_for_phyrdy(struct rcar_pcie *pcie)
+{
+	unsigned int timeout = 10;
+
+	while (timeout--) {
+		if (rcar_pci_read_reg(pcie, PCIEPHYSR) & PHYRDY)
+			return 0;
+
+		msleep(5);
+	}
+
+	return -ETIMEDOUT;
+}
+
+int rcar_pcie_wait_for_dl(struct rcar_pcie *pcie)
+{
+	unsigned int timeout = 10000;
+
+	while (timeout--) {
+		if ((rcar_pci_read_reg(pcie, PCIETSTR) & DATA_LINK_ACTIVE))
+			return 0;
+
+		udelay(5);
+		cpu_relax();
+	}
+
+	return -ETIMEDOUT;
+}
+
+void rcar_pcie_set_outbound(struct rcar_pcie *pcie, int win,
+			    struct resource *res)
+{
+	/* Setup PCIe address space mappings for each resource */
+	resource_size_t res_start;
+	resource_size_t size;
+	u32 mask;
+
+	rcar_pci_write_reg(pcie, 0x00000000, PCIEPTCTLR(win));
+
+	/*
+	 * The PAMR mask is calculated in units of 128Bytes, which
+	 * keeps things pretty simple.
+	 */
+	size = resource_size(res);
+	mask = (roundup_pow_of_two(size) / SZ_128) - 1;
+	rcar_pci_write_reg(pcie, mask << 7, PCIEPAMR(win));
+
+	if (res->flags & IORESOURCE_IO)
+		res_start = pci_pio_to_address(res->start);
+	else
+		res_start = res->start;
+
+	rcar_pci_write_reg(pcie, upper_32_bits(res_start), PCIEPAUR(win));
+	rcar_pci_write_reg(pcie, lower_32_bits(res_start) & ~0x7F,
+			   PCIEPALR(win));
+
+	/* First resource is for IO */
+	mask = PAR_ENABLE;
+	if (res->flags & IORESOURCE_IO)
+		mask |= IO_SPACE;
+
+	rcar_pci_write_reg(pcie, mask, PCIEPTCTLR(win));
+}
+
+void rcar_pcie_set_inbound(struct rcar_pcie *pcie, u64 cpu_addr,
+			   u64 pci_addr, u64 flags, int idx, bool host)
+{
+	/*
+	 * Set up 64-bit inbound regions as the range parser doesn't
+	 * distinguish between 32 and 64-bit types.
+	 */
+	if (host)
+		rcar_pci_write_reg(pcie, lower_32_bits(pci_addr),
+				   PCIEPRAR(idx));
+	rcar_pci_write_reg(pcie, lower_32_bits(cpu_addr), PCIELAR(idx));
+	rcar_pci_write_reg(pcie, flags, PCIELAMR(idx));
+
+	if (host)
+		rcar_pci_write_reg(pcie, upper_32_bits(pci_addr),
+				   PCIEPRAR(idx + 1));
+	rcar_pci_write_reg(pcie, upper_32_bits(cpu_addr), PCIELAR(idx + 1));
+	rcar_pci_write_reg(pcie, 0, PCIELAMR(idx + 1));
+}
diff --git a/drivers/pci/controller/pcie-rcar.h b/drivers/pci/controller/pcie-rcar.h
new file mode 100644
index 000000000000..cec7768b4725
--- /dev/null
+++ b/drivers/pci/controller/pcie-rcar.h
@@ -0,0 +1,131 @@
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
+struct rcar_pcie {
+	struct device		*dev;
+	void __iomem		*base;
+};
+
+enum {
+	RCAR_PCI_ACCESS_READ,
+	RCAR_PCI_ACCESS_WRITE,
+};
+
+void rcar_pci_write_reg(struct rcar_pcie *pcie, u32 val, unsigned int reg);
+u32 rcar_pci_read_reg(struct rcar_pcie *pcie, unsigned int reg);
+void rcar_rmw32(struct rcar_pcie *pcie, int where, u32 mask, u32 data);
+int rcar_pcie_wait_for_phyrdy(struct rcar_pcie *pcie);
+int rcar_pcie_wait_for_dl(struct rcar_pcie *pcie);
+void rcar_pcie_set_outbound(struct rcar_pcie *pcie, int win,
+			    struct resource *res);
+void rcar_pcie_set_inbound(struct rcar_pcie *pcie, u64 cpu_addr,
+			   u64 pci_addr, u64 flags, int idx, bool host);
+
+#endif
-- 
2.17.1

