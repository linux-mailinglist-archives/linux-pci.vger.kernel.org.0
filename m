Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9BB5E99FC
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 09:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbiIZHAc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 03:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbiIZHAP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 03:00:15 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294E6140A5;
        Mon, 26 Sep 2022 00:00:09 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 152A81A24EF;
        Mon, 26 Sep 2022 09:00:08 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B98BB1A24F0;
        Mon, 26 Sep 2022 09:00:07 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id F33EA180222C;
        Mon, 26 Sep 2022 15:00:05 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     vkoul@kernel.org, p.zabel@pengutronix.de, l.stach@pengutronix.de,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        shawnguo@kernel.org, alexander.stein@ew.tq-group.com,
        marex@denx.de, richard.leitner@linux.dev
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v9 4/4] phy: freescale: imx8m-pcie: Add i.MX8MP PCIe PHY support
Date:   Mon, 26 Sep 2022 14:41:03 +0800
Message-Id: <1664174463-13721-5-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1664174463-13721-1-git-send-email-hongxing.zhu@nxp.com>
References: <1664174463-13721-1-git-send-email-hongxing.zhu@nxp.com>
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
---
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
index 9752818fe990..63636994d673 100644
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
@@ -181,10 +189,16 @@ static const struct imx8_pcie_phy_drvdata drvdata[] = {
 		.variant = IMX8MM,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 	},
+
+	[IMX8MP] = {
+		.variant = IMX8MP,
+		.gpr = "fsl,imx8mp-iomuxc-gpr",
+	},
 };
 
 static const struct of_device_id imx8_pcie_phy_of_match[] = {
 	{.compatible = "fsl,imx8mm-pcie-phy", .data = &drvdata[IMX8MM], },
+	{.compatible = "fsl,imx8mp-pcie-phy", .data = &drvdata[IMX8MP], },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, imx8_pcie_phy_of_match);
@@ -240,6 +254,15 @@ static int imx8_pcie_phy_probe(struct platform_device *pdev)
 		return PTR_ERR(imx8_phy->reset);
 	}
 
+	if (imx8_phy->drvdata->variant == IMX8MP) {
+		imx8_phy->perst =
+			devm_reset_control_get_exclusive(dev, "perst");
+		if (IS_ERR(imx8_phy->perst)) {
+			dev_err(dev, "Failed to get PCIE PHY PERST control\n");
+			return PTR_ERR(imx8_phy->perst);
+		}
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	imx8_phy->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(imx8_phy->base))
-- 
2.25.1

