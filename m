Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F624552B3
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 03:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242544AbhKRCY4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Nov 2021 21:24:56 -0500
Received: from inva021.nxp.com ([92.121.34.21]:46620 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242538AbhKRCYv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Nov 2021 21:24:51 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 64DA52031B9;
        Thu, 18 Nov 2021 03:21:50 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0928D2031B2;
        Thu, 18 Nov 2021 03:21:50 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 148F7183AD05;
        Thu, 18 Nov 2021 10:21:48 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, marcel.ziswiler@toradex.com,
        tharvey@gateworks.com, kishon@ti.com, vkoul@kernel.org,
        robh@kernel.org, galak@kernel.crashing.org, shawnguo@kernel.org
Cc:     hongxing.zhu@nxp.com, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v6 8/8] PCI: imx: Add the imx8mm pcie support
Date:   Thu, 18 Nov 2021 09:54:49 +0800
Message-Id: <1637200489-11855-9-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1637200489-11855-1-git-send-email-hongxing.zhu@nxp.com>
References: <1637200489-11855-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

i.MX8MM PCIe works mostly like the i.MX8MQ one, but has a different PHY
and allows to output the internal PHY reference clock via the refclk pad.
Add the i.MX8MM PCIe support based on the standalone PHY driver.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Tim Harvey <tharvey@gateworks.com>
Tested-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 73 ++++++++++++++++++++++++---
 1 file changed, 66 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 26f49f797b0f..d8c587b4d54f 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -29,6 +29,7 @@
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/reset.h>
+#include <linux/phy/phy.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 
@@ -49,6 +50,7 @@ enum imx6_pcie_variants {
 	IMX6QP,
 	IMX7D,
 	IMX8MQ,
+	IMX8MM,
 };
 
 #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
@@ -88,6 +90,7 @@ struct imx6_pcie {
 	struct device		*pd_pcie;
 	/* power domain for pcie phy */
 	struct device		*pd_pcie_phy;
+	struct phy		*phy;
 	const struct imx6_pcie_drvdata *drvdata;
 };
 
@@ -372,6 +375,8 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 	case IMX7D:
 	case IMX8MQ:
 		reset_control_assert(imx6_pcie->pciephy_reset);
+		fallthrough;
+	case IMX8MM:
 		reset_control_assert(imx6_pcie->apps_reset);
 		break;
 	case IMX6SX:
@@ -407,7 +412,8 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 
 static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
 {
-	WARN_ON(imx6_pcie->drvdata->variant != IMX8MQ);
+	WARN_ON(imx6_pcie->drvdata->variant != IMX8MQ &&
+		imx6_pcie->drvdata->variant != IMX8MM);
 	return imx6_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
 }
 
@@ -446,6 +452,13 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 		break;
 	case IMX7D:
 		break;
+	case IMX8MM:
+		ret = clk_prepare_enable(imx6_pcie->pcie_aux);
+		if (ret) {
+			dev_err(dev, "unable to enable pcie_aux clock\n");
+			break;
+		}
+		break;
 	case IMX8MQ:
 		ret = clk_prepare_enable(imx6_pcie->pcie_aux);
 		if (ret) {
@@ -522,6 +535,14 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 		goto err_ref_clk;
 	}
 
+	switch (imx6_pcie->drvdata->variant) {
+	case IMX8MM:
+		if (phy_power_on(imx6_pcie->phy))
+			dev_err(dev, "unable to power on PHY\n");
+		break;
+	default:
+		break;
+	}
 	/* allow the clocks to stabilize */
 	usleep_range(200, 500);
 
@@ -538,6 +559,10 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 	case IMX8MQ:
 		reset_control_deassert(imx6_pcie->pciephy_reset);
 		break;
+	case IMX8MM:
+		if (phy_init(imx6_pcie->phy) != 0)
+			dev_err(dev, "Waiting for PHY ready timeout!\n");
+		break;
 	case IMX7D:
 		reset_control_deassert(imx6_pcie->pciephy_reset);
 
@@ -614,6 +639,8 @@ static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
 static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 {
 	switch (imx6_pcie->drvdata->variant) {
+	case IMX8MM:
+		break;
 	case IMX8MQ:
 		/*
 		 * TODO: Currently this code assumes external
@@ -753,6 +780,7 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
 		break;
 	case IMX7D:
 	case IMX8MQ:
+	case IMX8MM:
 		reset_control_deassert(imx6_pcie->apps_reset);
 		break;
 	}
@@ -871,6 +899,7 @@ static void imx6_pcie_ltssm_disable(struct device *dev)
 				   IMX6Q_GPR12_PCIE_CTL_2, 0);
 		break;
 	case IMX7D:
+	case IMX8MM:
 		reset_control_assert(imx6_pcie->apps_reset);
 		break;
 	default:
@@ -930,6 +959,7 @@ static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
 				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
 		break;
 	case IMX8MQ:
+	case IMX8MM:
 		clk_disable_unprepare(imx6_pcie->pcie_aux);
 		break;
 	default:
@@ -1043,11 +1073,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	}
 
 	/* Fetch clocks */
-	imx6_pcie->pcie_phy = devm_clk_get(dev, "pcie_phy");
-	if (IS_ERR(imx6_pcie->pcie_phy))
-		return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_phy),
-				     "pcie_phy clock source missing or invalid\n");
-
 	imx6_pcie->pcie_bus = devm_clk_get(dev, "pcie_bus");
 	if (IS_ERR(imx6_pcie->pcie_bus))
 		return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_bus),
@@ -1089,10 +1114,39 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 			dev_err(dev, "Failed to get PCIE APPS reset control\n");
 			return PTR_ERR(imx6_pcie->apps_reset);
 		}
+		break;
+	case IMX8MM:
+		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
+		if (IS_ERR(imx6_pcie->pcie_aux))
+			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
+					     "pcie_aux clock source missing or invalid\n");
+		imx6_pcie->apps_reset = devm_reset_control_get_exclusive(dev,
+									 "apps");
+		if (IS_ERR(imx6_pcie->apps_reset)) {
+			dev_err(dev, "Failed to get PCIE APPS reset control\n");
+			return PTR_ERR(imx6_pcie->apps_reset);
+		}
+
+		imx6_pcie->phy = devm_phy_get(dev, "pcie-phy");
+		if (IS_ERR(imx6_pcie->phy)) {
+			if (PTR_ERR(imx6_pcie->phy) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
+			dev_err(dev, "Failed to get PCIE PHY\n");
+			return PTR_ERR(imx6_pcie->phy);
+		}
+
 		break;
 	default:
 		break;
 	}
+	/* Don't fetch the pcie_phy clock, if it has abstract PHY driver */
+	if (imx6_pcie->phy == NULL) {
+		imx6_pcie->pcie_phy = devm_clk_get(dev, "pcie_phy");
+		if (IS_ERR(imx6_pcie->pcie_phy))
+			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_phy),
+					     "pcie_phy clock source missing or invalid\n");
+	}
+
 
 	/* Grab turnoff reset */
 	imx6_pcie->turnoff_reset = devm_reset_control_get_optional_exclusive(dev, "turnoff");
@@ -1202,6 +1256,10 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
 	},
+	[IMX8MM] = {
+		.variant = IMX8MM,
+		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
+	},
 };
 
 static const struct of_device_id imx6_pcie_of_match[] = {
@@ -1209,7 +1267,8 @@ static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx6sx-pcie", .data = &drvdata[IMX6SX], },
 	{ .compatible = "fsl,imx6qp-pcie", .data = &drvdata[IMX6QP], },
 	{ .compatible = "fsl,imx7d-pcie",  .data = &drvdata[IMX7D],  },
-	{ .compatible = "fsl,imx8mq-pcie", .data = &drvdata[IMX8MQ], } ,
+	{ .compatible = "fsl,imx8mq-pcie", .data = &drvdata[IMX8MQ], },
+	{ .compatible = "fsl,imx8mm-pcie", .data = &drvdata[IMX8MM], },
 	{},
 };
 
-- 
2.25.1

