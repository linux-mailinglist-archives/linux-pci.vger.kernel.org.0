Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548C276C58A
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 08:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjHBGrY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 02:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjHBGrV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 02:47:21 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9170D2101;
        Tue,  1 Aug 2023 23:47:16 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 697521A0EAE;
        Wed,  2 Aug 2023 08:41:18 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 066651A0EB6;
        Wed,  2 Aug 2023 08:41:18 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 6FE031802183;
        Wed,  2 Aug 2023 14:41:16 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, shawnguo@kernel.org, lpieralisi@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH 8/9] PCI: imx6: Add i.MX6SX PCIe EP support
Date:   Wed,  2 Aug 2023 14:06:50 +0800
Message-Id: <1690956412-2439-9-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1690956412-2439-1-git-send-email-hongxing.zhu@nxp.com>
References: <1690956412-2439-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the i.MX6SX PCIe EP support.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 4da9553b49b4..bcc83c9d0ec5 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -48,6 +48,7 @@ enum imx6_pcie_variants {
 	IMX6Q,
 	IMX6Q_EP,
 	IMX6SX,
+	IMX6SX_EP,
 	IMX6QP,
 	IMX6QP_EP,
 	IMX7D,
@@ -361,6 +362,7 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
 		break;
 	case IMX6SX:
+	case IMX6SX_EP:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6SX_GPR12_PCIE_RX_EQ_MASK,
 				   IMX6SX_GPR12_PCIE_RX_EQ_2);
@@ -559,6 +561,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX6SX:
+	case IMX6SX_EP:
 		ret = clk_prepare_enable(imx6_pcie->pcie_inbound_axi);
 		if (ret) {
 			dev_err(dev, "unable to enable pcie_axi clock\n");
@@ -620,6 +623,7 @@ static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
 {
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX6SX:
+	case IMX6SX_EP:
 		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
 		break;
 	case IMX6QP:
@@ -717,6 +721,7 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 		reset_control_assert(imx6_pcie->apps_reset);
 		break;
 	case IMX6SX:
+	case IMX6SX_EP:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
 				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
@@ -781,6 +786,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 		imx7d_pcie_wait_for_phy_pll_lock(imx6_pcie);
 		break;
 	case IMX6SX:
+	case IMX6SX_EP:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
 				   IMX6SX_GPR5_PCIE_BTNRST_RESET, 0);
 		break;
@@ -839,6 +845,7 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
 	case IMX6Q:
 	case IMX6Q_EP:
 	case IMX6SX:
+	case IMX6SX_EP:
 	case IMX6QP:
 	case IMX6QP_EP:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
@@ -865,6 +872,7 @@ static void imx6_pcie_ltssm_disable(struct device *dev)
 	case IMX6Q:
 	case IMX6Q_EP:
 	case IMX6SX:
+	case IMX6SX_EP:
 	case IMX6QP:
 	case IMX6QP_EP:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
@@ -1200,6 +1208,7 @@ static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
 	/* Others poke directly at IOMUXC registers */
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX6SX:
+	case IMX6SX_EP:
 	case IMX6QP:
 	case IMX6QP_EP:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
@@ -1363,6 +1372,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX6SX:
+	case IMX6SX_EP:
 		imx6_pcie->pcie_inbound_axi = devm_clk_get(dev,
 							   "pcie_inbound_axi");
 		if (IS_ERR(imx6_pcie->pcie_inbound_axi))
@@ -1536,6 +1546,12 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 	},
+	[IMX6SX_EP] = {
+		.variant = IMX6SX_EP,
+		.mode = DW_PCIE_EP_TYPE,
+		.flags = IMX6_PCIE_FLAG_IMX6_PHY,
+		.gpr = "fsl,imx6q-iomuxc-gpr",
+	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
 		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
@@ -1590,6 +1606,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx6q-pcie",  .data = &drvdata[IMX6Q],  },
 	{ .compatible = "fsl,imx6q-pcie-ep", .data = &drvdata[IMX6Q_EP], },
 	{ .compatible = "fsl,imx6sx-pcie", .data = &drvdata[IMX6SX], },
+	{ .compatible = "fsl,imx6sx-pcie-ep", .data = &drvdata[IMX6SX_EP], },
 	{ .compatible = "fsl,imx6qp-pcie", .data = &drvdata[IMX6QP], },
 	{ .compatible = "fsl,imx6qp-pcie-ep", .data = &drvdata[IMX6QP_EP], },
 	{ .compatible = "fsl,imx7d-pcie",  .data = &drvdata[IMX7D],  },
-- 
2.34.1

