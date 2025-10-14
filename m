Return-Path: <linux-pci+bounces-38072-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C87BDAB3D
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 18:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75F9F19A2264
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 16:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3502F6169;
	Tue, 14 Oct 2025 16:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="mRAGeN0U"
X-Original-To: linux-pci@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53C4303C9B;
	Tue, 14 Oct 2025 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760460646; cv=none; b=NlMU/UVkJyyS+lAcxdmrWeupkzU6rB+GvwRtZSFb/r0T4znU1xcI1rChDyP10ceYTfnR9bo39ozEQFn87FsABbchQVHEziVddQIPZ+2/2xtOmYgDCBx8rKCRqk2fKIEBnh6wqJF0Vekz0YgYtRYh0l9noWwdC21TIRCK3RP6s1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760460646; c=relaxed/simple;
	bh=ilSIMMnMM/Cu2nwRjeJoR67uTilw4KQKTOqESILO3E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AM5cQsx16hMDcOLin/wwdh8wQ8qHHSKYnlSOrNNkdsoklG4ZQsEbV6ZQs9G+HVwJ/FkyULGpbqq80yrYuMdiK2Zpj8omaRYta3TnrWu4+4ZQIMeM00EfMxQK+R9yyoFYuO0Gtz+sS7K2k3e/t73NwdQcWvlMAquBSghaUGq5HAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=mRAGeN0U; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 5777225FA9;
	Tue, 14 Oct 2025 18:50:43 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hPTHbgqsDYzo; Tue, 14 Oct 2025 18:50:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1760460642; bh=ilSIMMnMM/Cu2nwRjeJoR67uTilw4KQKTOqESILO3E8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mRAGeN0UykiqzN5dKfI2Z0Mfjano7I1NT7ripjsWaz1GKoRRzCaqQBhqiA3JXoxsU
	 u6Nc+xX/8Tw8lU5gRHBbqk7EQV5v6fHdhy9yC/UkeMKwFstKrqn/GiiqgB2cJoBsHX
	 jgyPaYee7NM9wnJXMm+WOGuuF2e0p4o67/MyWZG17lB6mKqTIbwKSiKPnxNS9iK8a8
	 7A4rgI9pOs6bdHjhmE7/0wpSDrb72yygQSBW8q50XJSzG9MxY10EGRSCA7+SDXCW+m
	 xHhgM5PCc7PXjfhcaAkryO89UHrLUeLkp6qF2jJc2avckJ8Ks80rUQMhJu22ZAFUEY
	 jgo8L9Io8N52Q==
From: Yao Zi <ziyao@disroot.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yao Zi <ziyao@disroot.org>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Furong Xu <0x1207@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH net-next 3/4] net: stmmac: Add glue driver for Motorcomm YT6801 ethernet controller
Date: Tue, 14 Oct 2025 16:47:46 +0000
Message-ID: <20251014164746.50696-5-ziyao@disroot.org>
In-Reply-To: <20251014164746.50696-2-ziyao@disroot.org>
References: <20251014164746.50696-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Motorcomm YT6801 is a PCIe ethernet controller based on DWMAC4 IP. It
integrates an GbE phy, supporting WOL, VLAN tagging and various types
of offloading. It ships an on-chip eFuse for storing various vendor
configuration, including MAC address.

This patch adds basic glue code for the controller, allowing it to be
set up and transmit data at a reasonable speed. Features like WOL could
be implemented in the future.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |   9 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-motorcomm.c | 388 ++++++++++++++++++
 3 files changed, 398 insertions(+)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 9507131875b2..1f5222060c44 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -358,6 +358,15 @@ config DWMAC_LOONGSON
 	  This selects the LOONGSON PCI bus support for the stmmac driver,
 	  Support for ethernet controller on Loongson-2K1000 SoC and LS7A1000 bridge.
 
+config DWMAC_MOTORCOMM
+	tristate "Motorcomm PCI DWMAC support"
+	depends on STMMAC_ETH
+	depends on PCI
+	select MOTORCOMM_PHY
+	help
+	  This enables glue driver for Motorcomm DWMAC-based PCI Ethernet
+	  controllers. Currently only YT6801 is supported.
+
 config STMMAC_PCI
 	tristate "STMMAC PCI bus support"
 	depends on STMMAC_ETH && PCI
diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index 51e068e26ce4..2e925a7089b4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -46,4 +46,5 @@ dwmac-altr-socfpga-objs := dwmac-socfpga.o
 obj-$(CONFIG_STMMAC_PCI)	+= stmmac-pci.o
 obj-$(CONFIG_DWMAC_INTEL)	+= dwmac-intel.o
 obj-$(CONFIG_DWMAC_LOONGSON)	+= dwmac-loongson.o
+obj-$(CONFIG_DWMAC_MOTORCOMM)	+= dwmac-motorcomm.o
 stmmac-pci-objs:= stmmac_pci.o
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c
new file mode 100644
index 000000000000..03a88ee6b014
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c
@@ -0,0 +1,388 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * DWMAC glue driver for Motorcomm PCI Ethernet controllers
+ *
+ * Copyright (c) 2025 Yao Zi <ziyao@disroot.org>
+ */
+
+#include <linux/bits.h>
+#include <linux/dev_printk.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/stmmac.h>
+
+#include "dwmac4.h"
+#include "stmmac.h"
+
+#define DRIVER_NAME "dwmac-motorcomm"
+
+/* Register definition */
+#define EPHY_CTRL				0x1004
+#define  EPHY_RESET				BIT(0)
+#define OOB_WOL_CTRL				0x1010
+#define  OOB_WOL_CTRL_DIS			BIT(0)
+#define MGMT_INT_CTRL0				0x1100
+#define MGMT_INT_CTRL0_MASK			GENMASK(31, 16)
+#define  MGMT_INT_CTRL0_MASK_RXCH		GENMASK(3, 0)
+#define  MGMT_INT_CTRL0_MASK_TXCH		BIT(4)
+#define  MGMT_INT_CTRL0_MASK_MISC		BIT(5)
+#define INT_MODERATION				0x1108
+#define INT_MODERATION_RX			GENMASK(11, 0)
+#define INT_MODERATION_TX			GENMASK(27, 16)
+#define EFUSE_OP_CTRL_0				0x1500
+#define  EFUSE_OP_MODE				GENMASK(1, 0)
+#define   EFUSE_OP_ROW_READ			0x1
+#define  EFUSE_OP_START				BIT(2)
+#define  EFUSE_OP_ADDR				GENMASK(15, 8)
+#define EFUSE_OP_CTRL_1				0x1504
+#define  EFUSE_OP_DONE				BIT(1)
+#define  EFUSE_OP_RD_DATA			GENMASK(31, 24)
+#define SYS_RESET				0x152c
+#define  SYS_RESET_RESET			BIT(31)
+#define GMAC_OFFSET				0x2000
+
+/* Constants */
+#define EFUSE_READ_TIMEOUT_US			20000
+#define EFUSE_PATCH_REGION_OFFSET		18
+#define EFUSE_PATCH_MAX_NUM			39
+#define EFUSE_ADDR_MACA0LR			0x1520
+#define EFUSE_ADDR_MACA0HR			0x1524
+
+struct motorcomm_efuse_patch {
+	__le16 addr;
+	__le32 data;
+} __packed;
+
+struct dwmac_motorcomm_priv {
+	void __iomem *base;
+	struct device *dev;
+};
+
+static int motorcomm_efuse_read_byte(struct dwmac_motorcomm_priv *priv,
+				     u8 offset, u8 *byte)
+{
+	u32 reg;
+	int ret;
+
+	writel(FIELD_PREP(EFUSE_OP_MODE, EFUSE_OP_ROW_READ)	|
+	       FIELD_PREP(EFUSE_OP_ADDR, offset)		|
+	       EFUSE_OP_START, priv->base + EFUSE_OP_CTRL_0);
+
+	ret = readl_poll_timeout(priv->base + EFUSE_OP_CTRL_1,
+				 reg, reg & EFUSE_OP_DONE, 2000,
+				 EFUSE_READ_TIMEOUT_US);
+
+	reg = readl(priv->base + EFUSE_OP_CTRL_1);
+	*byte = FIELD_GET(EFUSE_OP_RD_DATA, reg);
+
+	return ret;
+}
+
+static int motorcomm_efuse_read_patch(struct dwmac_motorcomm_priv *priv,
+				      u8 index,
+				      struct motorcomm_efuse_patch *patch)
+{
+	u8 buf[sizeof(*patch)], offset;
+	int i, ret;
+
+	for (i = 0; i < sizeof(*patch); i++) {
+		offset = EFUSE_PATCH_REGION_OFFSET + sizeof(*patch) * index + i;
+
+		ret = motorcomm_efuse_read_byte(priv, offset, &buf[i]);
+		if (ret)
+			return ret;
+	}
+
+	memcpy(patch, buf, sizeof(*patch));
+
+	return 0;
+}
+
+static int motorcomm_efuse_get_patch_value(struct dwmac_motorcomm_priv *priv,
+					   u16 addr, u32 *value)
+{
+	struct motorcomm_efuse_patch patch;
+	int i, ret;
+
+	for (i = 0; i < EFUSE_PATCH_MAX_NUM; i++) {
+		ret = motorcomm_efuse_read_patch(priv, i, &patch);
+		if (ret)
+			return ret;
+
+		if (patch.addr == 0) {
+			return -ENOENT;
+		} else if (le16_to_cpu(patch.addr) == addr) {
+			*value = le32_to_cpu(patch.data);
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+
+static int motorcomm_efuse_read_mac(struct dwmac_motorcomm_priv *priv, u8 *mac)
+{
+	u32 maca0lr, maca0hr;
+	int ret;
+
+	ret = motorcomm_efuse_get_patch_value(priv, EFUSE_ADDR_MACA0LR,
+					      &maca0lr);
+	if (ret)
+		return dev_err_probe(priv->dev, ret,
+				     "failed to read maca0lr from eFuse\n");
+
+	ret = motorcomm_efuse_get_patch_value(priv, EFUSE_ADDR_MACA0HR,
+					      &maca0hr);
+	if (ret)
+		return dev_err_probe(priv->dev, ret,
+				     "failed to read maca0hr from eFuse\n");
+
+	mac[0] = FIELD_GET(GENMASK(15, 8), maca0hr);
+	mac[1] = FIELD_GET(GENMASK(7, 0), maca0hr);
+	mac[2] = FIELD_GET(GENMASK(31, 24), maca0lr);
+	mac[3] = FIELD_GET(GENMASK(23, 16), maca0lr);
+	mac[4] = FIELD_GET(GENMASK(15, 8), maca0lr);
+	mac[5] = FIELD_GET(GENMASK(7, 0), maca0lr);
+
+	return 0;
+}
+
+static void motorcomm_reset_phy(struct dwmac_motorcomm_priv *priv)
+{
+	u32 reg = readl(priv->base + EPHY_CTRL);
+
+	reg &= ~EPHY_RESET;
+	writel(reg, priv->base + EPHY_CTRL);
+
+	reg |= EPHY_RESET;
+	writel(reg, priv->base + EPHY_CTRL);
+}
+
+static void motorcomm_reset(struct dwmac_motorcomm_priv *priv)
+{
+	u32 reg = readl(priv->base + SYS_RESET);
+
+	reg &= ~SYS_RESET_RESET;
+	writel(reg, priv->base + SYS_RESET);
+
+	reg |= SYS_RESET_RESET;
+	writel(reg, priv->base + SYS_RESET);
+
+	motorcomm_reset_phy(priv);
+}
+
+static void motorcomm_init(struct dwmac_motorcomm_priv *priv)
+{
+	writel(0x0, priv->base + MGMT_INT_CTRL0);
+
+	writel(FIELD_PREP(INT_MODERATION_RX, 200) |
+	       FIELD_PREP(INT_MODERATION_TX, 200),
+	       priv->base + INT_MODERATION);
+
+	/*
+	 * OOB WOL must be disabled during normal operation, or DMA interrupts
+	 * cannot be delivered to the host.
+	 */
+	writel(OOB_WOL_CTRL_DIS, priv->base + OOB_WOL_CTRL);
+}
+
+static int motorcomm_suspend(struct device *dev, void *bsp_priv)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int ret;
+
+	ret = pci_save_state(pdev);
+	if (ret)
+		return ret;
+
+	pci_set_power_state(pdev, PCI_D3hot);
+
+	return 0;
+}
+
+static int motorcomm_resume(struct device *dev, void *bsp_priv)
+{
+	struct dwmac_motorcomm_priv *priv = bsp_priv;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int ret;
+
+	pci_restore_state(pdev);
+	pci_set_power_state(pdev, PCI_D0);
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return ret;
+
+	pci_set_master(pdev);
+
+	motorcomm_reset_phy(priv);
+	motorcomm_init(priv);
+
+	return 0;
+}
+
+static struct plat_stmmacenet_data *
+motorcomm_default_plat_data(struct pci_dev *pdev)
+{
+	struct plat_stmmacenet_data *plat;
+	struct device *dev = &pdev->dev;
+
+	plat = devm_kzalloc(dev, sizeof(*plat), GFP_KERNEL);
+	if (!plat)
+		return NULL;
+
+	plat->mdio_bus_data = devm_kzalloc(dev, sizeof(*plat->mdio_bus_data),
+					   GFP_KERNEL);
+	if (!plat->mdio_bus_data)
+		return NULL;
+
+	plat->dma_cfg = devm_kzalloc(dev, sizeof(*plat->dma_cfg), GFP_KERNEL);
+	if (!plat->dma_cfg)
+		return NULL;
+
+	plat->axi = devm_kzalloc(dev, sizeof(*plat->axi), GFP_KERNEL);
+	if (!plat->axi)
+		return NULL;
+
+	plat->dma_cfg->pbl		= DEFAULT_DMA_PBL;
+	plat->dma_cfg->pblx8		= true;
+	plat->dma_cfg->txpbl		= 32;
+	plat->dma_cfg->rxpbl		= 32;
+	plat->dma_cfg->eame		= true;
+	plat->dma_cfg->mixed_burst	= true;
+
+	plat->axi->axi_wr_osr_lmt	= 1;
+	plat->axi->axi_rd_osr_lmt	= 1;
+	plat->axi->axi_mb		= true;
+	plat->axi->axi_blen[0]		= 4;
+	plat->axi->axi_blen[1]		= 8;
+	plat->axi->axi_blen[2]		= 16;
+	plat->axi->axi_blen[3]		= 32;
+
+	plat->bus_id		= pci_dev_id(pdev);
+	plat->phy_addr		= -1;
+	plat->phy_interface	= PHY_INTERFACE_MODE_INTERNAL;
+	plat->clk_csr		= STMMAC_CSR_20_35M;
+	plat->tx_coe		= 1;
+	plat->rx_coe		= 1;
+	plat->maxmtu		= JUMBO_LEN;
+	plat->rx_queues_to_use	= 1;
+	plat->tx_queues_to_use	= 1;
+	plat->clk_ref_rate	= 125000000;
+	plat->has_gmac4		= 1;
+	plat->suspend		= motorcomm_suspend;
+	plat->resume		= motorcomm_resume;
+	plat->flags		= STMMAC_FLAG_TSO_EN;
+
+	return plat;
+}
+
+static int motorcomm_setup_irq(struct pci_dev *pdev,
+			       struct stmmac_resources *res,
+			       struct plat_stmmacenet_data *plat)
+{
+	int ret;
+
+	ret = pci_alloc_irq_vectors(pdev, 6, 6, PCI_IRQ_MSIX);
+	if (ret > 0) {
+		res->rx_irq[0]	= pci_irq_vector(pdev, 0);
+		res->tx_irq[0]	= pci_irq_vector(pdev, 4);
+		res->irq	= pci_irq_vector(pdev, 5);
+
+		plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
+
+		return 0;
+	}
+
+	dev_info(&pdev->dev, "failed to allocate MSI-X vector: %d\n", ret);
+	dev_info(&pdev->dev, "try MSI instead\n");
+
+	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to allocate MSI\n");
+
+	res->irq = pci_irq_vector(pdev, 0);
+
+	return 0;
+}
+
+static int motorcomm_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct plat_stmmacenet_data *plat;
+	struct dwmac_motorcomm_priv *priv;
+	struct stmmac_resources res = {};
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &pdev->dev;
+
+	plat = motorcomm_default_plat_data(pdev);
+	if (!plat)
+		return -ENOMEM;
+
+	plat->bsp_priv = priv;
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to enable device\n");
+
+	priv->base = pcim_iomap_region(pdev, 0, DRIVER_NAME);
+	if (IS_ERR(priv->base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->base),
+				     "failed to map IO region\n");
+
+	pci_set_master(pdev);
+
+	motorcomm_reset(priv);
+
+	ret = motorcomm_efuse_read_mac(priv, res.mac);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to read MAC from eFuse\n");
+
+	ret = motorcomm_setup_irq(pdev, &res, plat);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to setup IRQ\n");
+
+	motorcomm_init(priv);
+
+	res.addr = priv->base + GMAC_OFFSET;
+
+	return stmmac_dvr_probe(&pdev->dev, plat, &res);
+}
+
+static void motorcomm_remove(struct pci_dev *pdev)
+{
+	stmmac_dvr_remove(&pdev->dev);
+	pci_free_irq_vectors(pdev);
+}
+
+static const struct pci_device_id dwmac_motorcomm_pci_id_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOTORCOMM, 0x6801) },
+	{ },
+};
+MODULE_DEVICE_TABLE(pci, dwmac_motorcomm_pci_id_table);
+
+static struct pci_driver dwmac_motorcomm_pci_driver = {
+	.name = DRIVER_NAME,
+	.id_table = dwmac_motorcomm_pci_id_table,
+	.probe = motorcomm_probe,
+	.remove = motorcomm_remove,
+	.driver = {
+		.pm = &stmmac_simple_pm_ops,
+	},
+};
+
+module_pci_driver(dwmac_motorcomm_pci_driver);
+
+MODULE_DESCRIPTION("DWMAC glue driver for Motorcomm PCI Ethernet controllers");
+MODULE_AUTHOR("Yao Zi <ziyao@disroot.org>");
+MODULE_LICENSE("GPL");
-- 
2.50.1


