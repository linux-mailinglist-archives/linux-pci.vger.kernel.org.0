Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6DA173BCD
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2020 16:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgB1Pl6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Feb 2020 10:41:58 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38284 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgB1Pl6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Feb 2020 10:41:58 -0500
Received: by mail-wr1-f67.google.com with SMTP id e8so3463428wrm.5;
        Fri, 28 Feb 2020 07:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hl7YvCZYU/kiTygtTBfm9Ao15gao/QRzWe+OXwcWy4o=;
        b=JOJAen9nrNQiuocBnsYoBU5s4xqBNl/vVojq6P4fQPbphtdqAk5GJtXGtJezdOJEjN
         ecnpMuQk51O64kdH3pfXJlbL03tKjYqKenwSAm4kBKO0AfTV4qz19acmGpnbzxI4Soxz
         YebY0fPtlndHmRi+15BQckj3f3DwI/a7bsZxssWy9UfWlQe4CTBi0huyslNN9B89PnFa
         I3L3yzx90VE7+w33m88Hyfg48mh9wcwjeN7gkewKbyHLllV0IsASsk3mCW83X7o2ApHy
         g1idaXUR/cCZxY7n4kI7/LWRYJsVrKoL4ueYEW1iQ/6qGIkGy47LFQRrNXp6oncU3kkf
         3RkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hl7YvCZYU/kiTygtTBfm9Ao15gao/QRzWe+OXwcWy4o=;
        b=Vf0djH/RZqXIggDsEXvYxE3IgJ4r9dRm0Mn+VPSw2jSXR7JO6SlNEa77HzD6jEM99H
         zqkIpzE7lAFmACy/4Sb2V2QK4zG42Xo5GzS/Loicp4cZCJt72jjNfWdtsi+XDGCgUN3t
         eXuibukiTGkbxUGesvZy6vgppQPCMicOY4f4YFzeSiN/xlj8j52Pq2BA7VJfRyrNjwkO
         ZWvGgud2mZSq+PkF278aDkmUe6LHHzJXyYBzu8KFPw4zCn5lnNm7eu41tRbS26uJh1ww
         vMg0z7FwcN42VesBgMl14uQbKh6PflLDh9prpt2iQcapXEqXuU4ESlBVwl9rdTMGrKw1
         iCxw==
X-Gm-Message-State: APjAAAUXuv6kFgmBnFM6mF18610mtUywT+tumUDG+nKYtQwU6nI+aLwj
        xoo23VQRdiGgJaoc0V/cIP0=
X-Google-Smtp-Source: APXvYqxWBLUAhnydY2jNSqMmPgUuW3RtELRdF5EEFqVAAyX04/ZVzAA/UJyE2ldJ+GSzYmVEE2ZpFA==
X-Received: by 2002:adf:94a3:: with SMTP id 32mr5791650wrr.276.1582904512935;
        Fri, 28 Feb 2020 07:41:52 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2510:d000:3855:fd13:6b76:a11b])
        by smtp.gmail.com with ESMTPSA id k16sm13355349wrd.17.2020.02.28.07.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 07:41:52 -0800 (PST)
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
Subject: [PATCH v5 2/7] PCI: rcar: Move shareable code to a common file
Date:   Fri, 28 Feb 2020 15:41:17 +0000
Message-Id: <20200228154122.14164-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228154122.14164-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200228154122.14164-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch moves sharable code to common file pcie-rcar.c and the #defines
to pcie-rcar.h so that the common code can be reused with endpoint driver.
There are no functional changes with this patch for the host controller
driver.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/controller/Makefile         |   2 +-
 drivers/pci/controller/pcie-rcar-host.c | 358 ++++++++------------------------
 drivers/pci/controller/pcie-rcar.c      | 117 +++++++++++
 drivers/pci/controller/pcie-rcar.h      | 125 +++++++++++
 4 files changed, 324 insertions(+), 278 deletions(-)
 create mode 100644 drivers/pci/controller/pcie-rcar.c
 create mode 100644 drivers/pci/controller/pcie-rcar.h

diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index 4ca2da6..b4ada32 100644
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
index 759c654..93f22d8 100644
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
@@ -155,36 +58,10 @@ struct rcar_pcie {
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
-	u32 val = rcar_pci_read_reg(pcie, where & ~3);
+	u32 val = rcar_pci_read_reg(pcie->base, where & ~3);
 
 	return val >> shift;
 }
@@ -221,13 +98,13 @@ static int rcar_pcie_config_access(struct rcar_pcie *pcie,
 			return PCIBIOS_DEVICE_NOT_FOUND;
 
 		if (access_type == RCAR_PCI_ACCESS_READ) {
-			*data = rcar_pci_read_reg(pcie, PCICONF(index));
+			*data = rcar_pci_read_reg(pcie->base, PCICONF(index));
 		} else {
 			/* Keep an eye out for changes to the root bus number */
 			if (pci_is_root_bus(bus) && (reg == PCI_PRIMARY_BUS))
 				pcie->root_bus_nr = *data & 0xff;
 
-			rcar_pci_write_reg(pcie, *data, PCICONF(index));
+			rcar_pci_write_reg(pcie->base, *data, PCICONF(index));
 		}
 
 		return PCIBIOS_SUCCESSFUL;
@@ -237,20 +114,23 @@ static int rcar_pcie_config_access(struct rcar_pcie *pcie,
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	/* Clear errors */
-	rcar_pci_write_reg(pcie, rcar_pci_read_reg(pcie, PCIEERRFR), PCIEERRFR);
+	rcar_pci_write_reg(pcie->base, rcar_pci_read_reg(pcie->base, PCIEERRFR),
+			   PCIEERRFR);
 
 	/* Set the PIO address */
-	rcar_pci_write_reg(pcie, PCIE_CONF_BUS(bus->number) |
+	rcar_pci_write_reg(pcie->base, PCIE_CONF_BUS(bus->number) |
 		PCIE_CONF_DEV(dev) | PCIE_CONF_FUNC(func) | reg, PCIECAR);
 
 	/* Enable the configuration access */
 	if (bus->parent->number == pcie->root_bus_nr)
-		rcar_pci_write_reg(pcie, CONFIG_SEND_ENABLE | TYPE0, PCIECCTLR);
+		rcar_pci_write_reg(pcie->base, CONFIG_SEND_ENABLE | TYPE0,
+				   PCIECCTLR);
 	else
-		rcar_pci_write_reg(pcie, CONFIG_SEND_ENABLE | TYPE1, PCIECCTLR);
+		rcar_pci_write_reg(pcie->base, CONFIG_SEND_ENABLE | TYPE1,
+				   PCIECCTLR);
 
 	/* Check for errors */
-	if (rcar_pci_read_reg(pcie, PCIEERRFR) & UNSUPPORTED_REQUEST)
+	if (rcar_pci_read_reg(pcie->base, PCIEERRFR) & UNSUPPORTED_REQUEST)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	/* Check for master and target aborts */
@@ -259,12 +139,12 @@ static int rcar_pcie_config_access(struct rcar_pcie *pcie,
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	if (access_type == RCAR_PCI_ACCESS_READ)
-		*data = rcar_pci_read_reg(pcie, PCIECDR);
+		*data = rcar_pci_read_reg(pcie->base, PCIECDR);
 	else
-		rcar_pci_write_reg(pcie, *data, PCIECDR);
+		rcar_pci_write_reg(pcie->base, *data, PCIECDR);
 
 	/* Disable the configuration access */
-	rcar_pci_write_reg(pcie, 0, PCIECCTLR);
+	rcar_pci_write_reg(pcie->base, 0, PCIECCTLR);
 
 	return PCIBIOS_SUCCESSFUL;
 }
@@ -332,41 +212,6 @@ static struct pci_ops rcar_pcie_ops = {
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
 static int rcar_pcie_setup(struct list_head *resource, struct rcar_pcie *pci)
 {
 	struct resource_entry *win;
@@ -382,7 +227,7 @@ static int rcar_pcie_setup(struct list_head *resource, struct rcar_pcie *pci)
 		switch (resource_type(res)) {
 		case IORESOURCE_IO:
 		case IORESOURCE_MEM:
-			rcar_pcie_setup_window(i, pci, res);
+			rcar_pcie_set_outbound(i, pci->base, res);
 			i++;
 			break;
 		case IORESOURCE_BUS:
@@ -404,37 +249,38 @@ static void rcar_pcie_force_speedup(struct rcar_pcie *pcie)
 	unsigned int timeout = 1000;
 	u32 macsr;
 
-	if ((rcar_pci_read_reg(pcie, MACS2R) & LINK_SPEED) != LINK_SPEED_5_0GTS)
+	if ((rcar_pci_read_reg(pcie->base, MACS2R) & LINK_SPEED) !=
+		LINK_SPEED_5_0GTS)
 		return;
 
-	if (rcar_pci_read_reg(pcie, MACCTLR) & SPEED_CHANGE) {
+	if (rcar_pci_read_reg(pcie->base, MACCTLR) & SPEED_CHANGE) {
 		dev_err(dev, "Speed change already in progress\n");
 		return;
 	}
 
-	macsr = rcar_pci_read_reg(pcie, MACSR);
+	macsr = rcar_pci_read_reg(pcie->base, MACSR);
 	if ((macsr & LINK_SPEED) == LINK_SPEED_5_0GTS)
 		goto done;
 
 	/* Set target link speed to 5.0 GT/s */
-	rcar_rmw32(pcie, EXPCAP(12), PCI_EXP_LNKSTA_CLS,
+	rcar_rmw32(pcie->base, EXPCAP(12), PCI_EXP_LNKSTA_CLS,
 		   PCI_EXP_LNKSTA_CLS_5_0GB);
 
 	/* Set speed change reason as intentional factor */
-	rcar_rmw32(pcie, MACCGSPSETR, SPCNGRSN, 0);
+	rcar_rmw32(pcie->base, MACCGSPSETR, SPCNGRSN, 0);
 
 	/* Clear SPCHGFIN, SPCHGSUC, and SPCHGFAIL */
 	if (macsr & (SPCHGFIN | SPCHGSUC | SPCHGFAIL))
-		rcar_pci_write_reg(pcie, macsr, MACSR);
+		rcar_pci_write_reg(pcie->base, macsr, MACSR);
 
 	/* Start link speed change */
-	rcar_rmw32(pcie, MACCTLR, SPEED_CHANGE, SPEED_CHANGE);
+	rcar_rmw32(pcie->base, MACCTLR, SPEED_CHANGE, SPEED_CHANGE);
 
 	while (timeout--) {
-		macsr = rcar_pci_read_reg(pcie, MACSR);
+		macsr = rcar_pci_read_reg(pcie->base, MACSR);
 		if (macsr & SPCHGFIN) {
 			/* Clear the interrupt bits */
-			rcar_pci_write_reg(pcie, macsr, MACSR);
+			rcar_pci_write_reg(pcie->base, macsr, MACSR);
 
 			if (macsr & SPCHGFAIL)
 				dev_err(dev, "Speed change failed\n");
@@ -498,7 +344,7 @@ static int phy_wait_for_ack(struct rcar_pcie *pcie)
 	unsigned int timeout = 100;
 
 	while (timeout--) {
-		if (rcar_pci_read_reg(pcie, H1_PCIEPHYADRR) & PHY_ACK)
+		if (rcar_pci_read_reg(pcie->base, H1_PCIEPHYADRR) & PHY_ACK)
 			return 0;
 
 		udelay(100);
@@ -521,60 +367,31 @@ static void phy_write_reg(struct rcar_pcie *pcie,
 		((addr & 0xff) << ADR_POS);
 
 	/* Set write data */
-	rcar_pci_write_reg(pcie, data, H1_PCIEPHYDOUTR);
-	rcar_pci_write_reg(pcie, phyaddr, H1_PCIEPHYADRR);
+	rcar_pci_write_reg(pcie->base, data, H1_PCIEPHYDOUTR);
+	rcar_pci_write_reg(pcie->base, phyaddr, H1_PCIEPHYADRR);
 
 	/* Ignore errors as they will be dealt with if the data link is down */
 	phy_wait_for_ack(pcie);
 
 	/* Clear command */
-	rcar_pci_write_reg(pcie, 0, H1_PCIEPHYDOUTR);
-	rcar_pci_write_reg(pcie, 0, H1_PCIEPHYADRR);
+	rcar_pci_write_reg(pcie->base, 0, H1_PCIEPHYDOUTR);
+	rcar_pci_write_reg(pcie->base, 0, H1_PCIEPHYADRR);
 
 	/* Ignore errors as they will be dealt with if the data link is down */
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
 
 	/* Begin initialization */
-	rcar_pci_write_reg(pcie, 0, PCIETCTLR);
+	rcar_pci_write_reg(pcie->base, 0, PCIETCTLR);
 
 	/* Set mode */
-	rcar_pci_write_reg(pcie, 1, PCIEMSR);
+	rcar_pci_write_reg(pcie->base, 1, PCIEMSR);
 
-	err = rcar_pcie_wait_for_phyrdy(pcie);
+	err = rcar_pcie_wait_for_phyrdy(pcie->base);
 	if (err)
 		return err;
 
@@ -583,51 +400,51 @@ static int rcar_pcie_hw_init(struct rcar_pcie *pcie)
 	 * class to match. Hardware takes care of propagating the IDSETR
 	 * settings, so there is no need to bother with a quirk.
 	 */
-	rcar_pci_write_reg(pcie, PCI_CLASS_BRIDGE_PCI << 16, IDSETR1);
+	rcar_pci_write_reg(pcie->base, PCI_CLASS_BRIDGE_PCI << 16, IDSETR1);
 
 	/*
 	 * Setup Secondary Bus Number & Subordinate Bus Number, even though
 	 * they aren't used, to avoid bridge being detected as broken.
 	 */
-	rcar_rmw32(pcie, RCONF(PCI_SECONDARY_BUS), 0xff, 1);
-	rcar_rmw32(pcie, RCONF(PCI_SUBORDINATE_BUS), 0xff, 1);
+	rcar_rmw32(pcie->base, RCONF(PCI_SECONDARY_BUS), 0xff, 1);
+	rcar_rmw32(pcie->base, RCONF(PCI_SUBORDINATE_BUS), 0xff, 1);
 
 	/* Initialize default capabilities. */
-	rcar_rmw32(pcie, REXPCAP(0), 0xff, PCI_CAP_ID_EXP);
-	rcar_rmw32(pcie, REXPCAP(PCI_EXP_FLAGS),
-		PCI_EXP_FLAGS_TYPE, PCI_EXP_TYPE_ROOT_PORT << 4);
-	rcar_rmw32(pcie, RCONF(PCI_HEADER_TYPE), 0x7f,
-		PCI_HEADER_TYPE_BRIDGE);
+	rcar_rmw32(pcie->base, REXPCAP(0), 0xff, PCI_CAP_ID_EXP);
+	rcar_rmw32(pcie->base, REXPCAP(PCI_EXP_FLAGS),
+		   PCI_EXP_FLAGS_TYPE, PCI_EXP_TYPE_ROOT_PORT << 4);
+	rcar_rmw32(pcie->base, RCONF(PCI_HEADER_TYPE), 0x7f,
+		   PCI_HEADER_TYPE_BRIDGE);
 
 	/* Enable data link layer active state reporting */
-	rcar_rmw32(pcie, REXPCAP(PCI_EXP_LNKCAP), PCI_EXP_LNKCAP_DLLLARC,
-		PCI_EXP_LNKCAP_DLLLARC);
+	rcar_rmw32(pcie->base, REXPCAP(PCI_EXP_LNKCAP), PCI_EXP_LNKCAP_DLLLARC,
+		   PCI_EXP_LNKCAP_DLLLARC);
 
 	/* Write out the physical slot number = 0 */
-	rcar_rmw32(pcie, REXPCAP(PCI_EXP_SLTCAP), PCI_EXP_SLTCAP_PSN, 0);
+	rcar_rmw32(pcie->base, REXPCAP(PCI_EXP_SLTCAP), PCI_EXP_SLTCAP_PSN, 0);
 
 	/* Set the completion timer timeout to the maximum 50ms. */
-	rcar_rmw32(pcie, TLCTLR + 1, 0x3f, 50);
+	rcar_rmw32(pcie->base, TLCTLR + 1, 0x3f, 50);
 
 	/* Terminate list of capabilities (Next Capability Offset=0) */
-	rcar_rmw32(pcie, RVCCAP(0), 0xfff00000, 0);
+	rcar_rmw32(pcie->base, RVCCAP(0), 0xfff00000, 0);
 
 	/* Enable MSI */
 	if (IS_ENABLED(CONFIG_PCI_MSI))
-		rcar_pci_write_reg(pcie, 0x801f0000, PCIEMSITXR);
+		rcar_pci_write_reg(pcie->base, 0x801f0000, PCIEMSITXR);
 
-	rcar_pci_write_reg(pcie, MACCTLR_INIT_VAL, MACCTLR);
+	rcar_pci_write_reg(pcie->base, MACCTLR_INIT_VAL, MACCTLR);
 
 	/* Finish initialization - establish a PCI Express link */
-	rcar_pci_write_reg(pcie, CFINIT, PCIETCTLR);
+	rcar_pci_write_reg(pcie->base, CFINIT, PCIETCTLR);
 
 	/* This will timeout if we don't have a link. */
-	err = rcar_pcie_wait_for_dl(pcie);
+	err = rcar_pcie_wait_for_dl(pcie->base);
 	if (err)
 		return err;
 
 	/* Enable INTx interrupts */
-	rcar_rmw32(pcie, PCIEINTXR, 0, 0xF << 8);
+	rcar_rmw32(pcie->base, PCIEINTXR, 0, 0xF << 8);
 
 	wmb();
 
@@ -663,16 +480,16 @@ static int rcar_pcie_phy_init_gen2(struct rcar_pcie *pcie)
 	 * These settings come from the R-Car Series, 2nd Generation User's
 	 * Manual, section 50.3.1 (2) Initialization of the physical layer.
 	 */
-	rcar_pci_write_reg(pcie, 0x000f0030, GEN2_PCIEPHYADDR);
-	rcar_pci_write_reg(pcie, 0x00381203, GEN2_PCIEPHYDATA);
-	rcar_pci_write_reg(pcie, 0x00000001, GEN2_PCIEPHYCTRL);
-	rcar_pci_write_reg(pcie, 0x00000006, GEN2_PCIEPHYCTRL);
+	rcar_pci_write_reg(pcie->base, 0x000f0030, GEN2_PCIEPHYADDR);
+	rcar_pci_write_reg(pcie->base, 0x00381203, GEN2_PCIEPHYDATA);
+	rcar_pci_write_reg(pcie->base, 0x00000001, GEN2_PCIEPHYCTRL);
+	rcar_pci_write_reg(pcie->base, 0x00000006, GEN2_PCIEPHYCTRL);
 
-	rcar_pci_write_reg(pcie, 0x000f0054, GEN2_PCIEPHYADDR);
+	rcar_pci_write_reg(pcie->base, 0x000f0054, GEN2_PCIEPHYADDR);
 	/* The following value is for DC connection, no termination resistor */
-	rcar_pci_write_reg(pcie, 0x13802007, GEN2_PCIEPHYDATA);
-	rcar_pci_write_reg(pcie, 0x00000001, GEN2_PCIEPHYCTRL);
-	rcar_pci_write_reg(pcie, 0x00000006, GEN2_PCIEPHYCTRL);
+	rcar_pci_write_reg(pcie->base, 0x13802007, GEN2_PCIEPHYDATA);
+	rcar_pci_write_reg(pcie->base, 0x00000001, GEN2_PCIEPHYCTRL);
+	rcar_pci_write_reg(pcie->base, 0x00000006, GEN2_PCIEPHYCTRL);
 
 	return 0;
 }
@@ -735,7 +552,7 @@ static irqreturn_t rcar_pcie_msi_irq(int irq, void *data)
 	struct device *dev = pcie->dev;
 	unsigned long reg;
 
-	reg = rcar_pci_read_reg(pcie, PCIEMSIFR);
+	reg = rcar_pci_read_reg(pcie->base, PCIEMSIFR);
 
 	/* MSI & INTx share an interrupt - we only handle MSI here */
 	if (!reg)
@@ -746,7 +563,7 @@ static irqreturn_t rcar_pcie_msi_irq(int irq, void *data)
 		unsigned int msi_irq;
 
 		/* clear the interrupt */
-		rcar_pci_write_reg(pcie, 1 << index, PCIEMSIFR);
+		rcar_pci_write_reg(pcie->base, 1 << index, PCIEMSIFR);
 
 		msi_irq = irq_find_mapping(msi->domain, index);
 		if (msi_irq) {
@@ -760,7 +577,7 @@ static irqreturn_t rcar_pcie_msi_irq(int irq, void *data)
 		}
 
 		/* see if there's any more pending in this vector */
-		reg = rcar_pci_read_reg(pcie, PCIEMSIFR);
+		reg = rcar_pci_read_reg(pcie->base, PCIEMSIFR);
 	}
 
 	return IRQ_HANDLED;
@@ -787,8 +604,8 @@ static int rcar_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
 
 	irq_set_msi_desc(irq, desc);
 
-	msg.address_lo = rcar_pci_read_reg(pcie, PCIEMSIALR) & ~MSIFE;
-	msg.address_hi = rcar_pci_read_reg(pcie, PCIEMSIAUR);
+	msg.address_lo = rcar_pci_read_reg(pcie->base, PCIEMSIALR) & ~MSIFE;
+	msg.address_hi = rcar_pci_read_reg(pcie->base, PCIEMSIAUR);
 	msg.data = hwirq;
 
 	pci_write_msi_msg(irq, &msg);
@@ -839,8 +656,8 @@ static int rcar_msi_setup_irqs(struct msi_controller *chip,
 	desc->nvec_used = nvec;
 	desc->msi_attrib.multiple = order_base_2(nvec);
 
-	msg.address_lo = rcar_pci_read_reg(pcie, PCIEMSIALR) & ~MSIFE;
-	msg.address_hi = rcar_pci_read_reg(pcie, PCIEMSIAUR);
+	msg.address_lo = rcar_pci_read_reg(pcie->base, PCIEMSIALR) & ~MSIFE;
+	msg.address_hi = rcar_pci_read_reg(pcie->base, PCIEMSIAUR);
 	msg.data = hwirq;
 
 	pci_write_msi_msg(irq, &msg);
@@ -940,11 +757,11 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
 	}
 	base = virt_to_phys((void *)msi->pages);
 
-	rcar_pci_write_reg(pcie, lower_32_bits(base) | MSIFE, PCIEMSIALR);
-	rcar_pci_write_reg(pcie, upper_32_bits(base), PCIEMSIAUR);
+	rcar_pci_write_reg(pcie->base, lower_32_bits(base) | MSIFE, PCIEMSIALR);
+	rcar_pci_write_reg(pcie->base, upper_32_bits(base), PCIEMSIAUR);
 
 	/* enable all MSI interrupts */
-	rcar_pci_write_reg(pcie, 0xffffffff, PCIEMSIIER);
+	rcar_pci_write_reg(pcie->base, 0xffffffff, PCIEMSIIER);
 
 	return 0;
 
@@ -958,10 +775,10 @@ static void rcar_pcie_teardown_msi(struct rcar_pcie *pcie)
 	struct rcar_msi *msi = &pcie->msi;
 
 	/* Disable all MSI interrupts */
-	rcar_pci_write_reg(pcie, 0, PCIEMSIIER);
+	rcar_pci_write_reg(pcie->base, 0, PCIEMSIIER);
 
 	/* Disable address decoding of the MSI interrupt, MSIFE */
-	rcar_pci_write_reg(pcie, 0, PCIEMSIALR);
+	rcar_pci_write_reg(pcie->base, 0, PCIEMSIALR);
 
 	free_pages(msi->pages, 0);
 
@@ -1054,21 +871,8 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
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
+		rcar_pcie_set_inbound(pcie->base, cpu_addr, pci_addr,
+				      lower_32_bits(mask) | flags, idx, true);
 
 		pci_addr += size;
 		cpu_addr += size;
@@ -1170,7 +974,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 		goto err_phy_shutdown;
 	}
 
-	data = rcar_pci_read_reg(pcie, MACSR);
+	data = rcar_pci_read_reg(pcie->base, MACSR);
 	dev_info(dev, "PCIe x%d: link up\n", (data >> 20) & 0x3f);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
@@ -1223,14 +1027,14 @@ static int rcar_pcie_resume_noirq(struct device *dev)
 {
 	struct rcar_pcie *pcie = dev_get_drvdata(dev);
 
-	if (rcar_pci_read_reg(pcie, PMSR) &&
-	    !(rcar_pci_read_reg(pcie, PCIETCTLR) & DL_DOWN))
+	if (rcar_pci_read_reg(pcie->base, PMSR) &&
+	    !(rcar_pci_read_reg(pcie->base, PCIETCTLR) & DL_DOWN))
 		return 0;
 
 	/* Re-establish the PCIe link */
-	rcar_pci_write_reg(pcie, MACCTLR_INIT_VAL, MACCTLR);
-	rcar_pci_write_reg(pcie, CFINIT, PCIETCTLR);
-	return rcar_pcie_wait_for_dl(pcie);
+	rcar_pci_write_reg(pcie->base, MACCTLR_INIT_VAL, MACCTLR);
+	rcar_pci_write_reg(pcie->base, CFINIT, PCIETCTLR);
+	return rcar_pcie_wait_for_dl(pcie->base);
 }
 
 static const struct dev_pm_ops rcar_pcie_pm_ops = {
diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
new file mode 100644
index 0000000..41275f9
--- /dev/null
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -0,0 +1,117 @@
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
+void rcar_pci_write_reg(void __iomem *base, u32 val, unsigned int reg)
+{
+	writel(val, base + reg);
+}
+
+u32 rcar_pci_read_reg(void __iomem *base, unsigned int reg)
+{
+	return readl(base + reg);
+}
+
+void rcar_rmw32(void __iomem *base, int where, u32 mask, u32 data)
+{
+	unsigned int shift = BITS_PER_BYTE * (where & 3);
+	u32 val = rcar_pci_read_reg(base, where & ~3);
+
+	val &= ~(mask << shift);
+	val |= data << shift;
+	rcar_pci_write_reg(base, val, where & ~3);
+}
+
+int rcar_pcie_wait_for_phyrdy(void __iomem *base)
+{
+	unsigned int timeout = 10;
+
+	while (timeout--) {
+		if (rcar_pci_read_reg(base, PCIEPHYSR) & PHYRDY)
+			return 0;
+
+		msleep(5);
+	}
+
+	return -ETIMEDOUT;
+}
+
+int rcar_pcie_wait_for_dl(void __iomem *base)
+{
+	unsigned int timeout = 10000;
+
+	while (timeout--) {
+		if ((rcar_pci_read_reg(base, PCIETSTR) & DATA_LINK_ACTIVE))
+			return 0;
+
+		udelay(5);
+		cpu_relax();
+	}
+
+	return -ETIMEDOUT;
+}
+
+void rcar_pcie_set_outbound(int win, void __iomem *base,
+			    struct resource *res)
+{
+	/* Setup PCIe address space mappings for each resource */
+	resource_size_t res_start;
+	resource_size_t size;
+	u32 mask;
+
+	rcar_pci_write_reg(base, 0x00000000, PCIEPTCTLR(win));
+
+	/*
+	 * The PAMR mask is calculated in units of 128Bytes, which
+	 * keeps things pretty simple.
+	 */
+	size = resource_size(res);
+	mask = (roundup_pow_of_two(size) / SZ_128) - 1;
+	rcar_pci_write_reg(base, mask << 7, PCIEPAMR(win));
+
+	if (res->flags & IORESOURCE_IO)
+		res_start = pci_pio_to_address(res->start);
+	else
+		res_start = res->start;
+
+	rcar_pci_write_reg(base, upper_32_bits(res_start), PCIEPAUR(win));
+	rcar_pci_write_reg(base, lower_32_bits(res_start) & ~0x7F,
+			   PCIEPALR(win));
+
+	/* First resource is for IO */
+	mask = PAR_ENABLE;
+	if (res->flags & IORESOURCE_IO)
+		mask |= IO_SPACE;
+
+	rcar_pci_write_reg(base, mask, PCIEPTCTLR(win));
+}
+
+void rcar_pcie_set_inbound(void __iomem *base,
+			   u64 cpu_addr, u64 pci_addr,
+			   u64 flags, int idx, bool host)
+{
+	/*
+	 * Set up 64-bit inbound regions as the range parser doesn't
+	 * distinguish between 32 and 64-bit types.
+	 */
+	if (host)
+		rcar_pci_write_reg(base, lower_32_bits(pci_addr),
+				   PCIEPRAR(idx));
+	rcar_pci_write_reg(base, lower_32_bits(cpu_addr), PCIELAR(idx));
+	rcar_pci_write_reg(base, flags, PCIELAMR(idx));
+
+	if (host)
+		rcar_pci_write_reg(base, upper_32_bits(pci_addr),
+				   PCIEPRAR(idx + 1));
+	rcar_pci_write_reg(base, upper_32_bits(cpu_addr), PCIELAR(idx + 1));
+	rcar_pci_write_reg(base, 0, PCIELAMR(idx + 1));
+}
diff --git a/drivers/pci/controller/pcie-rcar.h b/drivers/pci/controller/pcie-rcar.h
new file mode 100644
index 0000000..b529d806
--- /dev/null
+++ b/drivers/pci/controller/pcie-rcar.h
@@ -0,0 +1,125 @@
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
+void rcar_pcie_set_outbound(int win, void __iomem *base, struct resource *res);
+void rcar_pcie_set_inbound(void __iomem *base, u64 cpu_addr, u64 pci_addr,
+			   u64 mask, int idx, bool host);
+
+#endif
-- 
2.7.4

