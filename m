Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9323D41F2
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jul 2021 23:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhGWU0Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jul 2021 16:26:25 -0400
Received: from finn.gateworks.com ([108.161.129.64]:57826 "EHLO
        finn.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231754AbhGWU0Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jul 2021 16:26:24 -0400
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1m727Q-0057Vc-Gh; Fri, 23 Jul 2021 20:50:04 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 3/6] PCI: imx6: add IMX8MM support
Date:   Fri, 23 Jul 2021 13:49:55 -0700
Message-Id: <20210723204958.7186-4-tharvey@gateworks.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210723204958.7186-1-tharvey@gateworks.com>
References: <20210723204958.7186-1-tharvey@gateworks.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add IMX8MM support to the existing driver which shares most
functionality with the IMX8MM.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 103 +++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 80fc98acf097..8fb36d33a244 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -49,6 +49,7 @@ enum imx6_pcie_variants {
 	IMX6QP,
 	IMX7D,
 	IMX8MQ,
+	IMX8MM,
 };
 
 #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
@@ -83,6 +84,7 @@ struct imx6_pcie {
 	struct regulator	*vpcie;
 	struct regulator	*vph;
 	void __iomem		*phy_base;
+	bool			ext_osc;
 
 	/* power domain for pcie */
 	struct device		*pd_pcie;
@@ -139,10 +141,29 @@ struct imx6_pcie {
 #define PCIE_PHY_CMN_REG26		0x98
 #define PCIE_PHY_CMN_REG26_ATT_MODE	0xBC
 
+#define PCIE_PHY_CMN_REG62                      0x188
+#define PCIE_PHY_CMN_REG62_PLL_CLK_OUT          0x08
+#define PCIE_PHY_CMN_REG64                      0x190
+#define PCIE_PHY_CMN_REG64_AUX_RX_TX_TERM       0x8C
+#define PCIE_PHY_CMN_REG75                      0x1D4
+#define PCIE_PHY_CMN_REG75_PLL_DONE             0x3
+#define PCIE_PHY_TRSV_REG5                      0x414
+#define PCIE_PHY_TRSV_REG5_GEN1_DEEMP           0x2D
+#define PCIE_PHY_TRSV_REG6                      0x418
+#define PCIE_PHY_TRSV_REG6_GEN2_DEEMP           0xF
+
 #define PHY_RX_OVRD_IN_LO 0x1005
 #define PHY_RX_OVRD_IN_LO_RX_DATA_EN		BIT(5)
 #define PHY_RX_OVRD_IN_LO_RX_PLL_EN		BIT(3)
 
+#define IMX8MM_GPR_PCIE_REF_CLK_SEL		(0x3 << 24)
+#define IMX8MM_GPR_PCIE_REF_CLK_PLL		(0x3 << 24)
+#define IMX8MM_GPR_PCIE_REF_CLK_EXT		(0x2 << 24)
+#define IMX8MM_GPR_PCIE_AUX_EN			BIT(19)
+#define IMX8MM_GPR_PCIE_CMN_RST			BIT(18)
+#define IMX8MM_GPR_PCIE_POWER_OFF		BIT(17)
+#define IMX8MM_GPR_PCIE_SSC_EN			BIT(16)
+
 static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, bool exp_val)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
@@ -371,6 +392,7 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX7D:
 	case IMX8MQ:
+	case IMX8MM:
 		reset_control_assert(imx6_pcie->pciephy_reset);
 		reset_control_assert(imx6_pcie->apps_reset);
 		break;
@@ -407,7 +429,6 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 
 static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
 {
-	WARN_ON(imx6_pcie->drvdata->variant != IMX8MQ);
 	return imx6_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
 }
 
@@ -447,6 +468,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 	case IMX7D:
 		break;
 	case IMX8MQ:
+	case IMX8MM:
 		ret = clk_prepare_enable(imx6_pcie->pcie_aux);
 		if (ret) {
 			dev_err(dev, "unable to enable pcie_aux clock\n");
@@ -536,6 +558,7 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX8MQ:
+	case IMX8MM:
 		reset_control_deassert(imx6_pcie->pciephy_reset);
 		break;
 	case IMX7D:
@@ -613,7 +636,74 @@ static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
 
 static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 {
+	unsigned int offset;
+
 	switch (imx6_pcie->drvdata->variant) {
+	case IMX8MM:
+		offset = imx6_pcie_grp_offset(imx6_pcie);
+
+		dev_info(imx6_pcie->pci->dev, "%s REF_CLK is used!.\n",
+				imx6_pcie->ext_osc ? "EXT" : "PLL");
+		if (imx6_pcie->ext_osc) {
+			regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
+					IMX8MQ_GPR_PCIE_REF_USE_PAD, 0);
+			regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
+					IMX8MM_GPR_PCIE_REF_CLK_SEL,
+					IMX8MM_GPR_PCIE_REF_CLK_SEL);
+			regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
+					IMX8MM_GPR_PCIE_AUX_EN,
+					IMX8MM_GPR_PCIE_AUX_EN);
+			regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
+					IMX8MM_GPR_PCIE_POWER_OFF, 0);
+			regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
+					IMX8MM_GPR_PCIE_SSC_EN, 0);
+			regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
+					IMX8MM_GPR_PCIE_REF_CLK_SEL,
+					IMX8MM_GPR_PCIE_REF_CLK_EXT);
+			udelay(100);
+			/* Do the PHY common block reset */
+			regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
+					IMX8MM_GPR_PCIE_CMN_RST,
+					IMX8MM_GPR_PCIE_CMN_RST);
+			udelay(200);
+		} else {
+			/* Configure the internal PLL as REF clock */
+			regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
+					IMX8MQ_GPR_PCIE_REF_USE_PAD, 0);
+			regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
+					IMX8MM_GPR_PCIE_REF_CLK_SEL,
+					IMX8MM_GPR_PCIE_REF_CLK_SEL);
+			regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
+					IMX8MM_GPR_PCIE_AUX_EN,
+					IMX8MM_GPR_PCIE_AUX_EN);
+			regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
+					IMX8MM_GPR_PCIE_POWER_OFF, 0);
+			regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
+					IMX8MM_GPR_PCIE_SSC_EN, 0);
+			regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
+					IMX8MM_GPR_PCIE_REF_CLK_SEL,
+					IMX8MM_GPR_PCIE_REF_CLK_PLL);
+			udelay(100);
+			/* Configure the PHY */
+			writel(PCIE_PHY_CMN_REG62_PLL_CLK_OUT,
+					imx6_pcie->phy_base + PCIE_PHY_CMN_REG62);
+			writel(PCIE_PHY_CMN_REG64_AUX_RX_TX_TERM,
+					imx6_pcie->phy_base + PCIE_PHY_CMN_REG64);
+			/* Do the PHY common block reset */
+			regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
+					IMX8MM_GPR_PCIE_CMN_RST,
+					IMX8MM_GPR_PCIE_CMN_RST);
+			udelay(200);
+		}
+		/*
+		 * In order to pass the compliance tests.
+		 * Configure the TRSV regiser of iMX8MM PCIe PHY.
+		 */
+		writel(PCIE_PHY_TRSV_REG5_GEN1_DEEMP,
+				imx6_pcie->phy_base + PCIE_PHY_TRSV_REG5);
+		writel(PCIE_PHY_TRSV_REG6_GEN2_DEEMP,
+				imx6_pcie->phy_base + PCIE_PHY_TRSV_REG6);
+		break;
 	case IMX8MQ:
 		/*
 		 * TODO: Currently this code assumes external
@@ -753,6 +843,7 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
 		break;
 	case IMX7D:
 	case IMX8MQ:
+	case IMX8MM:
 		reset_control_deassert(imx6_pcie->apps_reset);
 		break;
 	}
@@ -871,6 +962,7 @@ static void imx6_pcie_ltssm_disable(struct device *dev)
 				   IMX6Q_GPR12_PCIE_CTL_2, 0);
 		break;
 	case IMX7D:
+	case IMX8MM:
 		reset_control_assert(imx6_pcie->apps_reset);
 		break;
 	default:
@@ -929,6 +1021,7 @@ static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
 				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
 				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
 		break;
+	case IMX8MM:
 	case IMX8MQ:
 		clk_disable_unprepare(imx6_pcie->pcie_aux);
 		break;
@@ -1024,6 +1117,9 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(pci->dbi_base))
 		return PTR_ERR(pci->dbi_base);
 
+	/* check for EXT osc */
+	imx6_pcie->ext_osc = of_property_read_bool(node, "fsl,ext-osc");
+
 	/* Fetch GPIOs */
 	imx6_pcie->reset_gpio = of_get_named_gpio(node, "reset-gpio", 0);
 	imx6_pcie->gpio_active_high = of_property_read_bool(node,
@@ -1067,6 +1163,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 					     "pcie_inbound_axi clock missing or invalid\n");
 		break;
 	case IMX8MQ:
+	case IMX8MM:
 		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
 		if (IS_ERR(imx6_pcie->pcie_aux))
 			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
@@ -1202,6 +1299,9 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
 	},
+	[IMX8MM] = {
+		.variant = IMX8MM,
+	},
 };
 
 static const struct of_device_id imx6_pcie_of_match[] = {
@@ -1210,6 +1310,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx6qp-pcie", .data = &drvdata[IMX6QP], },
 	{ .compatible = "fsl,imx7d-pcie",  .data = &drvdata[IMX7D],  },
 	{ .compatible = "fsl,imx8mq-pcie", .data = &drvdata[IMX8MQ], } ,
+	{ .compatible = "fsl,imx8mm-pcie", .data = &drvdata[IMX8MM], },
 	{},
 };
 
-- 
2.17.1

