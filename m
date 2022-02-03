Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5D24A7DF9
	for <lists+linux-pci@lfdr.de>; Thu,  3 Feb 2022 03:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349037AbiBCCg5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Feb 2022 21:36:57 -0500
Received: from mx.socionext.com ([202.248.49.38]:23386 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349018AbiBCCgz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Feb 2022 21:36:55 -0500
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 03 Feb 2022 11:36:55 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id F0C782021220;
        Thu,  3 Feb 2022 11:36:54 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 3 Feb 2022 11:36:54 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 78E95C1E22;
        Thu,  3 Feb 2022 11:36:54 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 2/3] PCI: uniphier-ep: Add support for non-legacy SoC
Date:   Thu,  3 Feb 2022 11:36:25 +0900
Message-Id: <1643855786-23186-3-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643855786-23186-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1643855786-23186-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Define SoC data that includes pci_epc_features and boolean 'is_legacy'
to distinguish between legacy SoC (ex. Pro5) and non-legacy SoC.

Rename uniphier_pcie_init_ep() to uniphier_pcie_init_ep_legacy() for
initializing PCIe controller implemented in legacy SoC, add new
uniphier_pcie_init_ep() and uniphier_pcie_wait_ep() for non-legacy SoC
in the same method as pcie-uniphier driver.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/pci/controller/dwc/pcie-uniphier-ep.c | 124 ++++++++++++++++++++++----
 1 file changed, 106 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-uniphier-ep.c b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
index 69810c6b0d58..073bdf7fcee3 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier-ep.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/iopoll.h>
 #include <linux/of_device.h>
 #include <linux/pci.h>
 #include <linux/phy/phy.h>
@@ -31,6 +32,17 @@
 #define PCL_RSTCTRL2			0x0024
 #define PCL_RSTCTRL_PHY_RESET		BIT(0)
 
+#define PCL_PINCTRL0			0x002c
+#define PCL_PERST_PLDN_REGEN		BIT(12)
+#define PCL_PERST_NOE_REGEN		BIT(11)
+#define PCL_PERST_OUT_REGEN		BIT(8)
+#define PCL_PERST_PLDN_REGVAL		BIT(4)
+#define PCL_PERST_NOE_REGVAL		BIT(3)
+#define PCL_PERST_OUT_REGVAL		BIT(0)
+
+#define PCL_PIPEMON			0x0044
+#define PCL_PCLK_ALIVE			BIT(15)
+
 #define PCL_MODE			0x8000
 #define PCL_MODE_REGEN			BIT(8)
 #define PCL_MODE_REGVAL			BIT(0)
@@ -51,6 +63,9 @@
 #define PCL_APP_INTX			0x8074
 #define PCL_APP_INTX_SYS_INT		BIT(0)
 
+#define PCL_APP_PM0			0x8078
+#define PCL_SYS_AUX_PWR_DET		BIT(8)
+
 /* assertion time of INTx in usec */
 #define PCL_INTX_WIDTH_USEC		30
 
@@ -60,7 +75,12 @@ struct uniphier_pcie_ep_priv {
 	struct clk *clk, *clk_gio;
 	struct reset_control *rst, *rst_gio;
 	struct phy *phy;
-	const struct pci_epc_features *features;
+	const struct uniphier_pcie_ep_soc_data *data;
+};
+
+struct uniphier_pcie_ep_soc_data {
+	bool is_legacy;
+	const struct pci_epc_features features;
 };
 
 #define to_uniphier_pcie(x)	dev_get_drvdata((x)->dev)
@@ -91,7 +111,7 @@ static void uniphier_pcie_phy_reset(struct uniphier_pcie_ep_priv *priv,
 	writel(val, priv->base + PCL_RSTCTRL2);
 }
 
-static void uniphier_pcie_init_ep(struct uniphier_pcie_ep_priv *priv)
+static void uniphier_pcie_init_ep_legacy(struct uniphier_pcie_ep_priv *priv)
 {
 	u32 val;
 
@@ -116,6 +136,63 @@ static void uniphier_pcie_init_ep(struct uniphier_pcie_ep_priv *priv)
 	msleep(100);
 }
 
+static void uniphier_pcie_init_ep(struct uniphier_pcie_ep_priv *priv)
+{
+	u32 val;
+
+	if (priv->data->is_legacy) {
+		uniphier_pcie_init_ep_legacy(priv);
+		return;
+	}
+
+	/* set EP mode */
+	val = readl(priv->base + PCL_MODE);
+	val |= PCL_MODE_REGEN | PCL_MODE_REGVAL;
+	writel(val, priv->base + PCL_MODE);
+
+	/* use auxiliary power detection */
+	val = readl(priv->base + PCL_APP_PM0);
+	val |= PCL_SYS_AUX_PWR_DET;
+	writel(val, priv->base + PCL_APP_PM0);
+
+	/* assert PERST# */
+	val = readl(priv->base + PCL_PINCTRL0);
+	val &= ~(PCL_PERST_NOE_REGVAL | PCL_PERST_OUT_REGVAL
+		 | PCL_PERST_PLDN_REGVAL);
+	val |= PCL_PERST_NOE_REGEN | PCL_PERST_OUT_REGEN
+		| PCL_PERST_PLDN_REGEN;
+	writel(val, priv->base + PCL_PINCTRL0);
+
+	uniphier_pcie_ltssm_enable(priv, false);
+
+	usleep_range(100000, 200000);
+
+	/* deassert PERST# */
+	val = readl(priv->base + PCL_PINCTRL0);
+	val |= PCL_PERST_OUT_REGVAL | PCL_PERST_OUT_REGEN;
+	writel(val, priv->base + PCL_PINCTRL0);
+}
+
+static int uniphier_pcie_wait_ep(struct uniphier_pcie_ep_priv *priv)
+{
+	u32 status;
+	int ret;
+
+	if (priv->data->is_legacy)
+		return 0;
+
+	/* wait PIPE clock */
+	ret = readl_poll_timeout(priv->base + PCL_PIPEMON, status,
+				 status & PCL_PCLK_ALIVE, 100000, 1000000);
+	if (ret) {
+		dev_err(priv->pci.dev,
+			"Failed to initialize controller in EP mode\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static int uniphier_pcie_start_link(struct dw_pcie *pci)
 {
 	struct uniphier_pcie_ep_priv *priv = to_uniphier_pcie(pci);
@@ -209,7 +286,7 @@ uniphier_pcie_get_features(struct dw_pcie_ep *ep)
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct uniphier_pcie_ep_priv *priv = to_uniphier_pcie(pci);
 
-	return priv->features;
+	return &priv->data->features;
 }
 
 static const struct dw_pcie_ep_ops uniphier_pcie_ep_ops = {
@@ -248,8 +325,14 @@ static int uniphier_pcie_ep_enable(struct uniphier_pcie_ep_priv *priv)
 
 	uniphier_pcie_phy_reset(priv, false);
 
+	ret = uniphier_pcie_wait_ep(priv);
+	if (ret)
+		goto out_phy_exit;
+
 	return 0;
 
+out_phy_exit:
+	phy_exit(priv->phy);
 out_rst_gio_assert:
 	reset_control_assert(priv->rst_gio);
 out_rst_assert:
@@ -277,8 +360,8 @@ static int uniphier_pcie_ep_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	priv->features = of_device_get_match_data(dev);
-	if (WARN_ON(!priv->features))
+	priv->data = of_device_get_match_data(dev);
+	if (WARN_ON(!priv->data))
 		return -EINVAL;
 
 	priv->pci.dev = dev;
@@ -288,13 +371,15 @@ static int uniphier_pcie_ep_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	priv->clk_gio = devm_clk_get(dev, "gio");
-	if (IS_ERR(priv->clk_gio))
-		return PTR_ERR(priv->clk_gio);
+	if (priv->data->is_legacy) {
+		priv->clk_gio = devm_clk_get(dev, "gio");
+		if (IS_ERR(priv->clk_gio))
+			return PTR_ERR(priv->clk_gio);
 
-	priv->rst_gio = devm_reset_control_get_shared(dev, "gio");
-	if (IS_ERR(priv->rst_gio))
-		return PTR_ERR(priv->rst_gio);
+		priv->rst_gio = devm_reset_control_get_shared(dev, "gio");
+		if (IS_ERR(priv->rst_gio))
+			return PTR_ERR(priv->rst_gio);
+	}
 
 	priv->clk = devm_clk_get(dev, "link");
 	if (IS_ERR(priv->clk))
@@ -321,13 +406,16 @@ static int uniphier_pcie_ep_probe(struct platform_device *pdev)
 	return dw_pcie_ep_init(&priv->pci.ep);
 }
 
-static const struct pci_epc_features uniphier_pro5_data = {
-	.linkup_notifier = false,
-	.msi_capable = true,
-	.msix_capable = false,
-	.align = 1 << 16,
-	.bar_fixed_64bit = BIT(BAR_0) | BIT(BAR_2) | BIT(BAR_4),
-	.reserved_bar =  BIT(BAR_4),
+static const struct uniphier_pcie_ep_soc_data uniphier_pro5_data = {
+	.is_legacy = true,
+	.features = {
+		.linkup_notifier = false,
+		.msi_capable = true,
+		.msix_capable = false,
+		.align = 1 << 16,
+		.bar_fixed_64bit = BIT(BAR_0) | BIT(BAR_2) | BIT(BAR_4),
+		.reserved_bar =  BIT(BAR_4),
+	},
 };
 
 static const struct of_device_id uniphier_pcie_ep_match[] = {
-- 
2.7.4

