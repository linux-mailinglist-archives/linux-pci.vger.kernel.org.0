Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08E45A5001
	for <lists+linux-pci@lfdr.de>; Mon, 29 Aug 2022 17:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiH2PQm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Aug 2022 11:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiH2PQk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Aug 2022 11:16:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF7679EF2
        for <linux-pci@vger.kernel.org>; Mon, 29 Aug 2022 08:16:39 -0700 (PDT)
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1oSgUz-0006bl-QP; Mon, 29 Aug 2022 17:16:25 +0200
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     p.zabel@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, shawnguo@kernel.org,
        vkoul@kernel.org, alexander.stein@ew.tq-group.com, marex@denx.de,
        richard.leitner@linux.dev, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH 2/2] fixup! phy: freescale: imx8m-pcie: Add iMX8MP PCIe PHY support
Date:   Mon, 29 Aug 2022 17:16:23 +0200
Message-Id: <20220829151623.808344-2-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220829151623.808344-1-l.stach@pengutronix.de>
References: <1661760917-9558-1-git-send-email-hongxing.zhu@nxp.com>
 <20220829151623.808344-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

---
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 31 +++-------------------
 1 file changed, 3 insertions(+), 28 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
index 3463b4299f2f..f714f419b91f 100644
--- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
+++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/of_device.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
@@ -47,10 +48,6 @@
 #define IMX8MM_GPR_PCIE_SSC_EN		BIT(16)
 #define IMX8MM_GPR_PCIE_AUX_EN_OVERRIDE	BIT(9)
 
-#define IMX8MP_GPR_REG0			0x0
-#define IMX8MP_GPR_PHY_APB_RST		BIT(4)
-#define IMX8MP_GPR_PHY_INIT_RST		BIT(5)
-
 enum imx8_pcie_phy_type {
 	IMX8MM,
 	IMX8MP,
@@ -58,10 +55,8 @@ enum imx8_pcie_phy_type {
 
 struct imx8_pcie_phy {
 	void __iomem		*base;
-	struct device		*dev;
 	struct clk		*clk;
 	struct phy		*phy;
-	struct regmap		*hsio_blk_ctrl;
 	struct regmap		*iomuxc_gpr;
 	struct reset_control	*reset;
 	struct reset_control	*perst;
@@ -93,13 +88,6 @@ static int imx8_pcie_phy_init(struct phy *phy)
 		break;
 	case IMX8MP:
 		reset_control_assert(imx8_phy->perst);
-
-		/* release pcie_phy_apb_reset and pcie_phy_init_resetn */
-		regmap_update_bits(imx8_phy->hsio_blk_ctrl, IMX8MP_GPR_REG0,
-				   IMX8MP_GPR_PHY_APB_RST |
-				   IMX8MP_GPR_PHY_INIT_RST,
-				   IMX8MP_GPR_PHY_APB_RST |
-				   IMX8MP_GPR_PHY_INIT_RST);
 		break;
 	}
 
@@ -204,21 +192,16 @@ static int imx8_pcie_phy_probe(struct platform_device *pdev)
 {
 	struct phy_provider *phy_provider;
 	struct device *dev = &pdev->dev;
-	const struct of_device_id *of_id;
 	struct device_node *np = dev->of_node;
 	struct imx8_pcie_phy *imx8_phy;
 	struct resource *res;
 
-	of_id = of_match_device(imx8_pcie_phy_of_match, dev);
-	if (!of_id)
-		return -EINVAL;
-
 	imx8_phy = devm_kzalloc(dev, sizeof(*imx8_phy), GFP_KERNEL);
 	if (!imx8_phy)
 		return -ENOMEM;
 
-	imx8_phy->dev = dev;
-	imx8_phy->variant = (enum imx8_pcie_phy_type)of_id->data;
+	imx8_phy->variant =
+		(enum imx8_pcie_phy_type)of_device_get_match_data(dev);
 
 	/* get PHY refclk pad mode */
 	of_property_read_u32(np, "fsl,refclk-pad-mode",
@@ -257,14 +240,6 @@ static int imx8_pcie_phy_probe(struct platform_device *pdev)
 		return PTR_ERR(imx8_phy->reset);
 	}
 	if (imx8_phy->variant == IMX8MP) {
-		/* Grab HSIO MIX config register range */
-		imx8_phy->hsio_blk_ctrl =
-			 syscon_regmap_lookup_by_compatible("fsl,imx8mp-hsio-blk-ctrl");
-		if (IS_ERR(imx8_phy->hsio_blk_ctrl)) {
-			dev_err(dev, "Unable to find HSIO MIX registers\n");
-			return PTR_ERR(imx8_phy->hsio_blk_ctrl);
-		}
-
 		imx8_phy->perst =
 			devm_reset_control_get_exclusive(dev, "perst");
 		if (IS_ERR(imx8_phy->perst)) {
-- 
2.30.2

