Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7E31566D9
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2020 19:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbgBHShQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 8 Feb 2020 13:37:16 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35492 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbgBHShF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 8 Feb 2020 13:37:05 -0500
Received: by mail-wr1-f67.google.com with SMTP id w12so2709626wrt.2;
        Sat, 08 Feb 2020 10:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lPbXLDVjo4IU1vhem4KvBuyaMB+61kxEuMs9nb3zCoo=;
        b=fSYjK/Pct3a85VFYgT16AGFTYxde/nrQpmtO35V8NXS9bmUU/xp8T/wmULPOeTd+C2
         nkAY6yruNCs0C1vuAQYE6t02aQrpIgsaxlEW7P5EBNQAiI2UQ5zCqImFdLOA+f18Tmqt
         3IYjRkM6Eu53j3bUMZ557bs3G8raWi5QB7TXXpb4JHGRTRj8v4SNIfZIEnRfdoxiolY7
         raRiT1wH+e1WWWXZxG8h16BNnPaifQZ/7PCtT9HVYwTfWwaEfkhyLnn8LP2jcal3opNv
         U6k6RCbOA1SpkImImfnNjIXhlUeGdERhOsL7aLr4V3N303CnDo8u1CIa7nU333UcsZy7
         zUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lPbXLDVjo4IU1vhem4KvBuyaMB+61kxEuMs9nb3zCoo=;
        b=NEJbdfvCHrph5fJ/EzJyy4wkEJ3e3dr6x33veFUfhMap06Od0y363k2NckaANQ6Msr
         c4BNQtAe+3xPOimKMs9ip1WpAWC6SP+H4XMdI33YukdMwJo9q6QvBcqztoyurDC54Lj1
         drsanM5WvTtU7BBovuAlJHnHYTpZf6jyDXT0K1We1B9sr5J7uHdK6Duwjse8UKkXpeCd
         LHcGNRel6QXBuxoBAnBOvvbZjCJM0ZbajLpn0OlCgq8KyOw2NXY+Yu3HwrRcHlKZHUKW
         TGfP+R1r2qH9k90ir/cmZWyIA2FJ012USieezKreC01S9tugehfC3E11wx3f2DwdtVz/
         kAAA==
X-Gm-Message-State: APjAAAXerEZLwSk9sdvM04T/KB/jECk3HK4Y+3B9wHH7JWrxCOK5gHzd
        /fse1PVsfjuLwbAdoL6F9eA=
X-Google-Smtp-Source: APXvYqzfUKD7pGjujcE0gEIM6vUnIUWL9WQo5HuGKS90/i9SVX2LwhaVS5vSKV37h2qpK/09p6X8cw==
X-Received: by 2002:adf:f3cd:: with SMTP id g13mr6569551wrp.54.1581187021835;
        Sat, 08 Feb 2020 10:37:01 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2510:d000:a553:90a1:93f5:e306])
        by smtp.gmail.com with ESMTPSA id b67sm8404385wmc.38.2020.02.08.10.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2020 10:37:01 -0800 (PST)
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
Subject: [PATCH v4 5/6] PCI: rcar: Add support for rcar PCIe controller in endpoint mode
Date:   Sat,  8 Feb 2020 18:36:40 +0000
Message-Id: <20200208183641.6674-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200208183641.6674-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200208183641.6674-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch adds support for rcar PCIe controller to work in endpoint mode.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/controller/Kconfig        |   7 +
 drivers/pci/controller/Makefile       |   1 +
 drivers/pci/controller/pcie-rcar-ep.c | 492 ++++++++++++++++++++++++++++++++++
 drivers/pci/controller/pcie-rcar.h    |   6 +
 4 files changed, 506 insertions(+)
 create mode 100644 drivers/pci/controller/pcie-rcar-ep.c

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 94bb5e9..2fde0f5 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -61,6 +61,13 @@ config PCIE_RCAR_HOST
 	help
 	  Say Y here if you want PCIe controller support on R-Car SoCs in host mode.
 
+config PCIE_RCAR_EP
+	bool "Renesas R-Car PCIe endpoint controller"
+	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on PCI_ENDPOINT
+	help
+	  Say Y here if you want PCIe controller support on R-Car SoCs in endpoint mode.
+
 config PCI_HOST_COMMON
 	bool
 	select PCI_ECAM
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index b4ada32..067bd33 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_PCI_AARDVARK) += pci-aardvark.o
 obj-$(CONFIG_PCI_TEGRA) += pci-tegra.o
 obj-$(CONFIG_PCI_RCAR_GEN2) += pci-rcar-gen2.o
 obj-$(CONFIG_PCIE_RCAR_HOST) += pcie-rcar.o pcie-rcar-host.o
+obj-$(CONFIG_PCIE_RCAR_EP) += pcie-rcar.o pcie-rcar-ep.o
 obj-$(CONFIG_PCI_HOST_COMMON) += pci-host-common.o
 obj-$(CONFIG_PCI_HOST_GENERIC) += pci-host-generic.o
 obj-$(CONFIG_PCIE_XILINX) += pcie-xilinx.o
diff --git a/drivers/pci/controller/pcie-rcar-ep.c b/drivers/pci/controller/pcie-rcar-ep.c
new file mode 100644
index 0000000..32a7fca
--- /dev/null
+++ b/drivers/pci/controller/pcie-rcar-ep.c
@@ -0,0 +1,492 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe endpoint driver for Renesas R-Car SoCs
+ *  Copyright (c) 2020 Renesas Electronics Europe GmbH
+ *
+ * Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_pci.h>
+#include <linux/of_platform.h>
+#include <linux/pci.h>
+#include <linux/pci-epc.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+
+#include "pcie-rcar.h"
+
+/* Structure representing the PCIe interface */
+struct rcar_pcie {
+	phys_addr_t		*ob_addr;
+	struct pci_epc_mem_window *ob_window;
+	struct pci_epc		*epc;
+	struct device		*dev;
+	void __iomem		*base;
+	u8			max_functions;
+	unsigned int		bar_to_atu[MAX_NR_INBOUND_MAPS];
+	unsigned long		*ib_window_map;
+	u32			num_ib_windows;
+	u32			num_ob_windows;
+};
+
+static void rcar_pcie_ep_hw_init(struct rcar_pcie *pcie)
+{
+	u32 val;
+
+	rcar_pci_write_reg(pcie->base, 0, PCIETCTLR);
+
+	/* Set endpoint mode */
+	rcar_pci_write_reg(pcie->base, 0, PCIEMSR);
+
+	/* Initialize default capabilities. */
+	rcar_rmw32(pcie->base, REXPCAP(0), 0xff, PCI_CAP_ID_EXP);
+	rcar_rmw32(pcie->base, REXPCAP(PCI_EXP_FLAGS),
+		   PCI_EXP_FLAGS_TYPE, PCI_EXP_TYPE_ENDPOINT << 4);
+	rcar_rmw32(pcie->base, RCONF(PCI_HEADER_TYPE), 0x7f,
+		   PCI_HEADER_TYPE_NORMAL);
+
+	/* Write out the physical slot number = 0 */
+	rcar_rmw32(pcie->base, REXPCAP(PCI_EXP_SLTCAP), PCI_EXP_SLTCAP_PSN, 0);
+
+	val = rcar_pci_read_reg(pcie->base, EXPCAP(1));
+	/* device supports fixed 128 bytes MPSS */
+	val &= ~GENMASK(2, 0);
+	rcar_pci_write_reg(pcie->base, val, EXPCAP(1));
+
+	val = rcar_pci_read_reg(pcie->base, EXPCAP(2));
+	/* read requests size 128 bytes */
+	val &= ~GENMASK(14, 12);
+	/* payload size 128 bytes */
+	val &= ~GENMASK(7, 5);
+	rcar_pci_write_reg(pcie->base, val, EXPCAP(2));
+
+	/* Set target link speed to 5.0 GT/s */
+	rcar_rmw32(pcie->base, EXPCAP(12), PCI_EXP_LNKSTA_CLS,
+		   PCI_EXP_LNKSTA_CLS_5_0GB);
+
+	/* Set the completion timer timeout to the maximum 50ms. */
+	rcar_rmw32(pcie->base, TLCTLR + 1, 0x3f, 50);
+
+	/* Terminate list of capabilities (Next Capability Offset=0) */
+	rcar_rmw32(pcie->base, RVCCAP(0), 0xfff00000, 0);
+
+	/* flush modifications */
+	wmb();
+}
+
+static int rcar_pcie_ep_get_window(struct rcar_pcie *pcie, phys_addr_t addr)
+{
+	int i;
+
+	for (i = 0; i < pcie->num_ob_windows; i++)
+		if (pcie->ob_window[i].phys_base == addr)
+			return i;
+
+	return -EINVAL;
+}
+
+static int rcar_pcie_parse_outbound_ranges(struct rcar_pcie *pcie,
+					   struct platform_device *pdev)
+{
+	char outbound_name[10];
+	struct resource *res;
+	unsigned int i = 0;
+
+	pcie->num_ob_windows = 0;
+	for (i = 0; i < RCAR_PCI_MAX_RESOURCES; i++) {
+		sprintf(outbound_name, "memory%u", i);
+		res = platform_get_resource_byname(pdev,
+						   IORESOURCE_MEM,
+						   outbound_name);
+		if (!res) {
+			dev_err(pcie->dev, "missing outbound window %u\n", i);
+			return -EINVAL;
+		}
+		if (!devm_request_mem_region(&pdev->dev, res->start,
+					     resource_size(res),
+					     outbound_name)) {
+			dev_err(pcie->dev, "Cannot request memory region %s.\n",
+				outbound_name);
+			return -EIO;
+		}
+
+		pcie->ob_window[i].phys_base = res->start;
+		pcie->ob_window[i].size = resource_size(res);
+		/* controller doesn't support multiple allocation
+		 * from same window, so set page_size to window size
+		 */
+		pcie->ob_window[i].page_size = resource_size(res);
+	}
+	pcie->num_ob_windows = i;
+
+	return 0;
+}
+
+static int rcar_pcie_ep_get_pdata(struct rcar_pcie *pcie,
+				  struct platform_device *pdev)
+{
+	struct pci_epc_mem_window *window;
+	struct device *dev = pcie->dev;
+	struct resource res;
+	int err;
+
+	err = of_address_to_resource(dev->of_node, 0, &res);
+	if (err)
+		return err;
+	pcie->base = devm_ioremap_resource(dev, &res);
+	if (IS_ERR(pcie->base))
+		return PTR_ERR(pcie->base);
+
+	pcie->ob_window = devm_kcalloc(dev, RCAR_PCI_MAX_RESOURCES,
+				       sizeof(*window), GFP_KERNEL);
+	if (!pcie->ob_window)
+		return -ENOMEM;
+
+	rcar_pcie_parse_outbound_ranges(pcie, pdev);
+
+	err = of_property_read_u8(dev->of_node, "max-functions",
+				  &pcie->max_functions);
+	if (err < 0)
+		pcie->max_functions = 1;
+
+	return 0;
+}
+
+static int rcar_pcie_ep_write_header(struct pci_epc *epc, u8 fn,
+				     struct pci_epf_header *hdr)
+{
+	struct rcar_pcie *ep = epc_get_drvdata(epc);
+	u32 val;
+
+	if (!fn)
+		val = hdr->vendorid;
+	else
+		val = rcar_pci_read_reg(ep->base, IDSETR0);
+	val |= hdr->deviceid << DEVICE_ID_SHFIT;
+	rcar_pci_write_reg(ep->base, val, IDSETR0);
+
+	val = hdr->revid;
+	val |= hdr->progif_code << 8;
+	val |= hdr->subclass_code << 16;
+	val |= hdr->baseclass_code << 24;
+	rcar_pci_write_reg(ep->base, val, IDSETR1);
+
+	if (!fn)
+		val = hdr->subsys_vendor_id;
+	else
+		val = rcar_pci_read_reg(ep->base, SUBIDSETR);
+	val |= hdr->subsys_id << 16;
+	rcar_pci_write_reg(ep->base, val, SUBIDSETR);
+
+	if (hdr->interrupt_pin > PCI_INTERRUPT_INTA)
+		return -EINVAL;
+	val = rcar_pci_read_reg(ep->base, PCICONF(15));
+	val |= (hdr->interrupt_pin << 8);
+	rcar_pci_write_reg(ep->base, val, PCICONF(15));
+
+	return 0;
+}
+
+static int rcar_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no,
+				struct pci_epf_bar *epf_bar)
+{
+	struct rcar_pcie *ep = epc_get_drvdata(epc);
+	dma_addr_t cpu_addr = epf_bar->phys_addr;
+	int flags = epf_bar->flags | LAR_ENABLE | LAM_64BIT;
+	enum pci_barno bar = epf_bar->barno;
+	u64 size = 1ULL << fls64(epf_bar->size - 1);
+	u32 mask;
+	int idx;
+	int err;
+
+	idx = find_first_zero_bit(ep->ib_window_map, ep->num_ib_windows);
+	if (idx >= ep->num_ib_windows) {
+		dev_err(ep->dev, "no free inbound window\n");
+		return -EINVAL;
+	}
+
+	if ((flags & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_IO)
+		flags |= IO_SPACE;
+
+	ep->bar_to_atu[bar] = idx;
+	/* use 64 bit bars */
+	set_bit(idx, ep->ib_window_map);
+	set_bit(idx + 1, ep->ib_window_map);
+
+	if (cpu_addr > 0) {
+		unsigned long nr_zeros = __ffs64(cpu_addr);
+		u64 alignment = 1ULL << nr_zeros;
+
+		size = min(size, alignment);
+	} else {
+		size = size;
+	}
+
+	size = min(size, 1ULL << 32);
+
+	mask = roundup_pow_of_two(size) - 1;
+	mask &= ~0xf;
+
+	rcar_pcie_set_inbound(ep->base, cpu_addr,
+			      0x0, mask | flags, idx, false);
+
+	err = rcar_pcie_wait_for_phyrdy(ep->base);
+	if (err) {
+		dev_err(ep->dev, "phy not ready\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void rcar_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn,
+				   struct pci_epf_bar *epf_bar)
+{
+	struct rcar_pcie *ep = epc_get_drvdata(epc);
+	enum pci_barno bar = epf_bar->barno;
+	u32 atu_index = ep->bar_to_atu[bar];
+
+	rcar_pcie_set_inbound(ep->base, 0x0, 0x0, 0x0, bar, false);
+
+	clear_bit(atu_index, ep->ib_window_map);
+	clear_bit(atu_index + 1, ep->ib_window_map);
+}
+
+static int rcar_pcie_ep_map_addr(struct pci_epc *epc, u8 fn,
+				 phys_addr_t addr, u64 pci_addr, size_t size)
+{
+	struct rcar_pcie *ep = epc_get_drvdata(epc);
+	struct resource res;
+	int window;
+	int err;
+
+	/* check if we have a link. */
+	err = rcar_pcie_wait_for_dl(ep->base);
+	if (err) {
+		dev_err(ep->dev, "link not up\n");
+		return err;
+	}
+
+	window = rcar_pcie_ep_get_window(ep, addr);
+	if (window < 0) {
+		dev_err(ep->dev, "failed to get corresponding window\n");
+		return -EINVAL;
+	}
+
+	memset(&res, 0x0, sizeof(res));
+	res.start = pci_addr;
+	res.end = pci_addr + size - 1;
+	res.flags = IORESOURCE_MEM;
+
+	rcar_pcie_set_outbound(window, ep->base, &res, false);
+
+	ep->ob_addr[window] = addr;
+
+	return 0;
+}
+
+static void rcar_pcie_ep_unmap_addr(struct pci_epc *epc, u8 fn,
+				    phys_addr_t addr)
+{
+	struct rcar_pcie *ep = epc_get_drvdata(epc);
+	struct resource res;
+	int idx;
+
+	for (idx = 0; idx < ep->num_ob_windows; idx++)
+		if (ep->ob_addr[idx] == addr)
+			break;
+
+	if (idx >= ep->num_ob_windows)
+		return;
+
+	memset(&res, 0x0, sizeof(res));
+	rcar_pcie_set_outbound(idx, ep->base, &res, false);
+
+	ep->ob_addr[idx] = 0;
+}
+
+static int rcar_pcie_ep_assert_intx(struct rcar_pcie *ep, u8 fn, u8 intx)
+{
+	u32 val;
+
+	val = rcar_pci_read_reg(ep->base, PCIEMSITXR);
+	if ((val & PCI_MSI_FLAGS_ENABLE)) {
+		dev_err(ep->dev, "MSI is enabled, cannot assert INTx\n");
+		return -EINVAL;
+	}
+
+	val = rcar_pci_read_reg(ep->base, PCICONF(1));
+	if ((val & INTDIS_SHIFT)) {
+		dev_err(ep->dev, "INTx message transmission is disabled\n");
+		return -EINVAL;
+	}
+
+	val = rcar_pci_read_reg(ep->base, PCIEINTXR);
+	if ((val & ASTINTX_SHIFT)) {
+		dev_err(ep->dev, "INTx is already asserted\n");
+		return -EINVAL;
+	}
+
+	val |= ASTINTX_SHIFT;
+	rcar_pci_write_reg(ep->base, val, PCIEINTXR);
+	mdelay(1);
+	val = rcar_pci_read_reg(ep->base, PCIEINTXR);
+	val &= ~ASTINTX_SHIFT;
+	rcar_pci_write_reg(ep->base, val, PCIEINTXR);
+
+	return 0;
+}
+
+static int rcar_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn,
+				  enum pci_epc_irq_type type,
+				  u16 interrupt_num)
+{
+	struct rcar_pcie *ep = epc_get_drvdata(epc);
+
+	switch (type) {
+	case PCI_EPC_IRQ_LEGACY:
+		return rcar_pcie_ep_assert_intx(ep, fn, 0);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int rcar_pcie_ep_start(struct pci_epc *epc)
+{
+	struct rcar_pcie *ep = epc_get_drvdata(epc);
+
+	rcar_pci_write_reg(ep->base, CFINIT, PCIETCTLR);
+
+	return 0;
+}
+
+static void rcar_pcie_ep_stop(struct pci_epc *epc)
+{
+	struct rcar_pcie *ep = epc_get_drvdata(epc);
+
+	rcar_pci_write_reg(ep->base, 0, PCIETCTLR);
+}
+
+static const struct pci_epc_features rcar_pcie_epc_features = {
+	.linkup_notifier = false,
+	.msi_capable = false,
+	.msix_capable = false,
+	/* use 64-bit bars so mark bar1/3/5 as reserved */
+	.reserved_bar = 1 << BAR_1 | 1 << BAR_3 | 1 << BAR_5,
+	.bar_fixed_64bit =  (1 << BAR_0) | (1 << BAR_2) | (1 << BAR_4),
+	.bar_fixed_size[0] = 128,
+	.bar_fixed_size[2] = 256,
+	.bar_fixed_size[4] = 256,
+};
+
+static const struct pci_epc_features*
+rcar_pcie_ep_get_features(struct pci_epc *epc, u8 func_no)
+{
+	return &rcar_pcie_epc_features;
+}
+
+static const struct pci_epc_ops rcar_pcie_epc_ops = {
+	.write_header	= rcar_pcie_ep_write_header,
+	.set_bar	= rcar_pcie_ep_set_bar,
+	.clear_bar	= rcar_pcie_ep_clear_bar,
+	.map_addr	= rcar_pcie_ep_map_addr,
+	.unmap_addr	= rcar_pcie_ep_unmap_addr,
+	.raise_irq	= rcar_pcie_ep_raise_irq,
+	.start		= rcar_pcie_ep_start,
+	.stop		= rcar_pcie_ep_stop,
+	.get_features	= rcar_pcie_ep_get_features,
+};
+
+static const struct of_device_id rcar_pcie_ep_of_match[] = {
+	{ .compatible = "renesas,r8a774c0-pcie-ep", },
+	{ .compatible = "renesas,rcar-gen3-pcie-ep" },
+	{ },
+};
+
+static int rcar_pcie_ep_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct rcar_pcie *pcie;
+	struct pci_epc *epc;
+	int err;
+
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	pcie->dev = dev;
+
+	pm_runtime_enable(pcie->dev);
+	err = pm_runtime_get_sync(pcie->dev);
+	if (err < 0) {
+		dev_err(pcie->dev, "pm_runtime_get_sync failed\n");
+		goto err_pm_disable;
+	}
+
+	err = rcar_pcie_ep_get_pdata(pcie, pdev);
+	if (err < 0) {
+		dev_err(dev, "failed to request resources: %d\n", err);
+		goto err_pm_put;
+	}
+
+	pcie->num_ib_windows = MAX_NR_INBOUND_MAPS;
+	pcie->ib_window_map =
+			devm_kcalloc(dev, BITS_TO_LONGS(pcie->num_ib_windows),
+				     sizeof(long), GFP_KERNEL);
+	if (!pcie->ib_window_map) {
+		err = -ENOMEM;
+		dev_err(dev, "failed to allocate memory for inbound map\n");
+		goto err_pm_put;
+	}
+
+	pcie->ob_addr = devm_kcalloc(dev, pcie->num_ob_windows,
+				     sizeof(*pcie->ob_addr), GFP_KERNEL);
+	if (!pcie->ob_addr) {
+		err = -ENOMEM;
+		dev_err(dev, "failed to allocate memory for outbound memory pointers\n");
+		goto err_pm_put;
+	}
+
+	epc = devm_pci_epc_create(dev, &rcar_pcie_epc_ops);
+	if (IS_ERR(epc)) {
+		dev_err(dev, "failed to create epc device\n");
+		err = PTR_ERR(epc);
+		goto err_pm_put;
+	}
+
+	epc->max_functions = pcie->max_functions;
+	pcie->epc = epc;
+	epc_set_drvdata(epc, pcie);
+
+	err = pci_epc_mem_init(epc, pcie->ob_window, pcie->num_ob_windows);
+	if (err < 0) {
+		dev_err(dev, "failed to initialize the epc memory space\n");
+		goto err_pm_put;
+	}
+
+	rcar_pcie_ep_hw_init(pcie);
+
+	return 0;
+
+err_pm_put:
+	pm_runtime_put(dev);
+
+err_pm_disable:
+	pm_runtime_disable(dev);
+
+	return err;
+}
+
+static struct platform_driver rcar_pcie_ep_driver = {
+	.driver = {
+		.name = "rcar-pcie-ep",
+		.of_match_table = rcar_pcie_ep_of_match,
+		.suppress_bind_attrs = true,
+	},
+	.probe = rcar_pcie_ep_probe,
+};
+builtin_platform_driver(rcar_pcie_ep_driver);
diff --git a/drivers/pci/controller/pcie-rcar.h b/drivers/pci/controller/pcie-rcar.h
index cbb21d3..e8d1516 100644
--- a/drivers/pci/controller/pcie-rcar.h
+++ b/drivers/pci/controller/pcie-rcar.h
@@ -60,7 +60,10 @@
 #define VCCAP(x)		(0x010100 + ((x) * 0x4))
 
 /* link layer */
+#define IDSETR0			0x011000
+#define  DEVICE_ID_SHFIT	16
 #define IDSETR1			0x011004
+#define SUBIDSETR		0x011024
 #define TLCTLR			0x011048
 #define MACSR			0x011054
 #define  SPCHGFIN		BIT(4)
@@ -101,6 +104,9 @@
 #define REXPCAP(x)		(EXPCAP(0) + (x))
 #define RVCCAP(x)		(VCCAP(0) + (x))
 
+#define INTDIS_SHIFT		BIT(10)
+#define ASTINTX_SHIFT		BIT(16)
+
 #define PCIE_CONF_BUS(b)	(((b) & 0xff) << 24)
 #define PCIE_CONF_DEV(d)	(((d) & 0x1f) << 19)
 #define PCIE_CONF_FUNC(f)	(((f) & 0x7) << 16)
-- 
2.7.4

