Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1BB379199
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 16:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241889AbhEJO4O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 10:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241912AbhEJOz1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 May 2021 10:55:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E601AC046858
        for <linux-pci@vger.kernel.org>; Mon, 10 May 2021 07:15:17 -0700 (PDT)
Received: from dude03.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::39])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1lg6gj-0000Fk-4j; Mon, 10 May 2021 16:15:13 +0200
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de,
        patchwork-lst@pengutronix.de
Subject: [PATCH 7/7] PCI: imx6: Add i.MX8MM support
Date:   Mon, 10 May 2021 16:15:09 +0200
Message-Id: <20210510141509.929120-7-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210510141509.929120-1-l.stach@pengutronix.de>
References: <20210510141509.929120-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::39
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

i.MX8MM PCIe works mostly like the i.MX8MQ one, but has a different PHY
and allows to output the internal PHY reference clock via the refclk pad.

Based on work in the downstream kernel by Richard Zhu.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/controller/dwc/pci-imx6.c | 105 +++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index f184077f6d17..1f3e806ade64 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -40,6 +40,14 @@
 #define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE	GENMASK(11, 8)
 #define IMX8MQ_PCIE2_BASE_ADDR			0x33c00000
 
+#define IMX8MM_GPR_PCIE_REF_CLK_SEL		GENMASK(25, 24)
+#define IMX8MM_GPR_PCIE_REF_CLK_PLL		FIELD_PREP(IMX8MM_GPR_PCIE_REF_CLK_SEL, 0x3)
+#define IMX8MM_GPR_PCIE_REF_CLK_EXT		FIELD_PREP(IMX8MM_GPR_PCIE_REF_CLK_SEL, 0x2)
+#define IMX8MM_GPR_PCIE_AUX_EN			BIT(19)
+#define IMX8MM_GPR_PCIE_CMN_RST			BIT(18)
+#define IMX8MM_GPR_PCIE_POWER_OFF		BIT(17)
+#define IMX8MM_GPR_PCIE_SSC_EN			BIT(16)
+
 #define to_imx6_pcie(x)	dev_get_drvdata((x)->dev)
 
 enum imx6_pcie_variants {
@@ -48,6 +56,7 @@ enum imx6_pcie_variants {
 	IMX6QP,
 	IMX7D,
 	IMX8MQ,
+	IMX8MM,
 };
 
 #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
@@ -138,6 +147,17 @@ struct imx6_pcie {
 #define PCIE_PHY_CMN_REG26		0x98
 #define PCIE_PHY_CMN_REG26_ATT_MODE	0xBC
 
+#define PCIE_PHY_CMN_REG62			0x188
+#define PCIE_PHY_CMN_REG62_PLL_CLK_OUT		BIT(3)
+#define PCIE_PHY_CMN_REG64			0x190
+#define PCIE_PHY_CMN_REG64_AUX_RX_TX_TERM	0x8C
+#define PCIE_PHY_CMN_REG75			0x1D4
+#define PCIE_PHY_CMN_REG75_PLL_DONE		0x3
+#define PCIE_PHY_TRSV_REG5			0x414
+#define PCIE_PHY_TRSV_REG5_GEN1_DEEMP		0x2D
+#define PCIE_PHY_TRSV_REG6			0x418
+#define PCIE_PHY_TRSV_REG6_GEN2_DEEMP		0xF
+
 #define PHY_RX_OVRD_IN_LO 0x1005
 #define PHY_RX_OVRD_IN_LO_RX_DATA_EN		BIT(5)
 #define PHY_RX_OVRD_IN_LO_RX_PLL_EN		BIT(3)
@@ -370,6 +390,7 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX7D:
 	case IMX8MQ:
+	case IMX8MM:
 		reset_control_assert(imx6_pcie->pciephy_reset);
 		reset_control_assert(imx6_pcie->apps_reset);
 		break;
@@ -406,7 +427,8 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 
 static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
 {
-	WARN_ON(imx6_pcie->drvdata->variant != IMX8MQ);
+	WARN_ON(imx6_pcie->drvdata->variant != IMX8MQ &&
+		imx6_pcie->drvdata->variant != IMX8MM);
 	return imx6_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
 }
 
@@ -446,6 +468,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 	case IMX7D:
 		break;
 	case IMX8MQ:
+	case IMX8MM:
 		ret = clk_prepare_enable(imx6_pcie->pcie_aux);
 		if (ret) {
 			dev_err(dev, "unable to enable pcie_aux clock\n");
@@ -482,6 +505,19 @@ static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
 		dev_err(dev, "PCIe PLL lock timeout\n");
 }
 
+static void imx8mm_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
+{
+	struct device *dev = imx6_pcie->pci->dev;
+	int ret;
+	u32 val;
+
+	ret = readl_poll_timeout(imx6_pcie->phy_base + PCIE_PHY_CMN_REG75,
+				 val, val == PCIE_PHY_CMN_REG75_PLL_DONE,
+				 10, 20000);
+	if (ret)
+		dev_err(dev, "PCIe PLL lock timeout\n");
+}
+
 static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
@@ -537,6 +573,10 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 	case IMX8MQ:
 		reset_control_deassert(imx6_pcie->pciephy_reset);
 		break;
+	case IMX8MM:
+		reset_control_deassert(imx6_pcie->pciephy_reset);
+		imx8mm_pcie_wait_for_phy_pll_lock(imx6_pcie);
+		break;
 	case IMX7D:
 		reset_control_deassert(imx6_pcie->pciephy_reset);
 
@@ -613,6 +653,47 @@ static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
 static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 {
 	switch (imx6_pcie->drvdata->variant) {
+	case IMX8MM:
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR14,
+				   IMX8MQ_GPR_PCIE_REF_USE_PAD,
+				   imx6_pcie->refclk_pad_mode == 1 ?
+				   IMX8MQ_GPR_PCIE_REF_USE_PAD :0);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR14,
+				   IMX8MM_GPR_PCIE_AUX_EN,
+				   IMX8MM_GPR_PCIE_AUX_EN);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR14,
+				   IMX8MM_GPR_PCIE_POWER_OFF, 0);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR14,
+				   IMX8MM_GPR_PCIE_SSC_EN, 0);
+
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR14,
+				   IMX8MM_GPR_PCIE_REF_CLK_SEL,
+				   imx6_pcie->refclk_pad_mode == 1 ?
+				   IMX8MM_GPR_PCIE_REF_CLK_EXT :
+				   IMX8MM_GPR_PCIE_REF_CLK_PLL);
+
+		usleep_range(100, 200);
+
+		if (imx6_pcie->refclk_pad_mode == 2) {
+			/* Configure the PHY to output the refclock via pad */
+			writel(PCIE_PHY_CMN_REG62_PLL_CLK_OUT,
+			       imx6_pcie->phy_base + PCIE_PHY_CMN_REG62);
+			writel(PCIE_PHY_CMN_REG64_AUX_RX_TX_TERM,
+			       imx6_pcie->phy_base + PCIE_PHY_CMN_REG64);
+		}
+
+		/* Do the PHY common block reset */
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR14,
+				   IMX8MM_GPR_PCIE_CMN_RST,
+				   IMX8MM_GPR_PCIE_CMN_RST);
+		usleep_range(200, 500);
+
+		/* Tune PHY de-emphasis setting to pass PCIe compliance. */
+		writel(PCIE_PHY_TRSV_REG5_GEN1_DEEMP,
+		       imx6_pcie->phy_base + PCIE_PHY_TRSV_REG5);
+		writel(PCIE_PHY_TRSV_REG6_GEN2_DEEMP,
+		       imx6_pcie->phy_base + PCIE_PHY_TRSV_REG6);
+		break;
 	case IMX8MQ:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr,
 				   imx6_pcie_grp_offset(imx6_pcie),
@@ -740,6 +821,7 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
 		break;
 	case IMX7D:
 	case IMX8MQ:
+	case IMX8MM:
 		reset_control_deassert(imx6_pcie->apps_reset);
 		break;
 	}
@@ -858,6 +940,7 @@ static void imx6_pcie_ltssm_disable(struct device *dev)
 				   IMX6Q_GPR12_PCIE_CTL_2, 0);
 		break;
 	case IMX7D:
+	case IMX8MM:
 		reset_control_assert(imx6_pcie->apps_reset);
 		break;
 	default:
@@ -917,6 +1000,7 @@ static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
 				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
 		break;
 	case IMX8MQ:
+	case IMX8MM:
 		clk_disable_unprepare(imx6_pcie->pcie_aux);
 		break;
 	default:
@@ -991,8 +1075,17 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	imx6_pcie->pci = pci;
 	imx6_pcie->drvdata = of_device_get_match_data(dev);
 
-	/* Find the PHY if one is present in DT, only imx7d uses it */
-	np = of_find_compatible_node(NULL, NULL, "fsl,imx7d-pcie-phy");
+	/* Find the PHY if one is present in DT */
+	switch (imx6_pcie->drvdata->variant) {
+	case IMX7D:
+		np = of_find_compatible_node(NULL, NULL, "fsl,imx7d-pcie-phy");
+		break;
+	case IMX8MM:
+		np = of_find_compatible_node(NULL, NULL, "fsl,imx8mm-pcie-phy");
+		break;
+	default:
+		break;
+	}
 	if (np) {
 		imx6_pcie->phy_base = devm_of_iomap(dev, np, 0, NULL);
 		if (IS_ERR(imx6_pcie->phy_base)) {
@@ -1055,6 +1148,8 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		 */
 		imx6_pcie->refclk_pad_mode = 1;
 
+		fallthrough;
+	case IMX8MM:
 		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
 		if (IS_ERR(imx6_pcie->pcie_aux))
 			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
@@ -1188,6 +1283,9 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
 	},
+	[IMX8MM] = {
+		.variant = IMX8MM,
+	},
 };
 
 static const struct of_device_id imx6_pcie_of_match[] = {
@@ -1196,6 +1294,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx6qp-pcie", .data = &drvdata[IMX6QP], },
 	{ .compatible = "fsl,imx7d-pcie",  .data = &drvdata[IMX7D],  },
 	{ .compatible = "fsl,imx8mq-pcie", .data = &drvdata[IMX8MQ], } ,
+	{ .compatible = "fsl,imx8mm-pcie", .data = &drvdata[IMX8MM], } ,
 	{},
 };
 
-- 
2.29.2

