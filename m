Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278DF5F2843
	for <lists+linux-pci@lfdr.de>; Mon,  3 Oct 2022 07:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiJCFo0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Oct 2022 01:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiJCFoZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Oct 2022 01:44:25 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7B53AE64;
        Sun,  2 Oct 2022 22:44:23 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C63DB212667;
        Mon,  3 Oct 2022 07:44:21 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8B68021266F;
        Mon,  3 Oct 2022 07:44:21 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 827E41802204;
        Mon,  3 Oct 2022 13:44:19 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     vkoul@kernel.org, a.fatoum@pengutronix.de, p.zabel@pengutronix.de,
        l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, shawnguo@kernel.org,
        alexander.stein@ew.tq-group.com, marex@denx.de,
        richard.leitner@linux.dev
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v11 4/4] phy: freescale: imx8m-pcie: Add i.MX8MP PCIe PHY support
Date:   Mon,  3 Oct 2022 13:24:55 +0800
Message-Id: <1664774695-23483-5-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1664774695-23483-1-git-send-email-hongxing.zhu@nxp.com>
References: <1664774695-23483-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add i.MX8MP PCIe PHY support.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Tested-by: Marek Vasut <marex@denx.de>
Tested-by: Richard Leitner <richard.leitner@skidata.com>
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
index ed8e0011d736..ecd40ab5ad78 100644
--- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
+++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
@@ -48,6 +48,7 @@
 
 enum imx8_pcie_phy_type {
 	IMX8MM,
+	IMX8MP,
 };
 
 struct imx8_pcie_phy_drvdata {
@@ -60,6 +61,7 @@ struct imx8_pcie_phy {
 	struct clk		*clk;
 	struct phy		*phy;
 	struct regmap		*iomuxc_gpr;
+	struct reset_control	*perst;
 	struct reset_control	*reset;
 	u32			refclk_pad_mode;
 	u32			tx_deemph_gen1;
@@ -87,6 +89,9 @@ static int imx8_pcie_phy_init(struct phy *phy)
 			writel(imx8_phy->tx_deemph_gen2,
 			       imx8_phy->base + PCIE_PHY_TRSV_REG6);
 		break;
+	case IMX8MP:
+		reset_control_assert(imx8_phy->perst);
+		break;
 	}
 
 	if (pad_mode == IMX8_PCIE_REFCLK_PAD_INPUT ||
@@ -141,6 +146,9 @@ static int imx8_pcie_phy_init(struct phy *phy)
 			   IMX8MM_GPR_PCIE_CMN_RST);
 
 	switch (imx8_phy->drvdata->variant) {
+	case IMX8MP:
+		reset_control_deassert(imx8_phy->perst);
+		fallthrough;
 	case IMX8MM:
 		reset_control_deassert(imx8_phy->reset);
 		usleep_range(200, 500);
@@ -181,8 +189,14 @@ static const struct imx8_pcie_phy_drvdata imx8mm_drvdata = {
 	.variant = IMX8MM,
 };
 
+static const struct imx8_pcie_phy_drvdata imx8mp_drvdata = {
+	.gpr = "fsl,imx8mp-iomuxc-gpr",
+	.variant = IMX8MP,
+};
+
 static const struct of_device_id imx8_pcie_phy_of_match[] = {
 	{.compatible = "fsl,imx8mm-pcie-phy", .data = &imx8mm_drvdata, },
+	{.compatible = "fsl,imx8mp-pcie-phy", .data = &imx8mp_drvdata, },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, imx8_pcie_phy_of_match);
@@ -238,6 +252,14 @@ static int imx8_pcie_phy_probe(struct platform_device *pdev)
 		return PTR_ERR(imx8_phy->reset);
 	}
 
+	if (imx8_phy->drvdata->variant == IMX8MP) {
+		imx8_phy->perst =
+			devm_reset_control_get_exclusive(dev, "perst");
+		if (IS_ERR(imx8_phy->perst))
+			dev_err_probe(dev, PTR_ERR(imx8_phy->perst),
+				      "Failed to get PCIE PHY PERST control\n");
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	imx8_phy->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(imx8_phy->base))
-- 
2.25.1

