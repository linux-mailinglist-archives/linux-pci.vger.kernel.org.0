Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F0A54D519
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jun 2022 01:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbiFOXQS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 19:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349502AbiFOXQQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 19:16:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D3031227;
        Wed, 15 Jun 2022 16:16:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0EEEAB821FB;
        Wed, 15 Jun 2022 23:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399CDC3411B;
        Wed, 15 Jun 2022 23:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655334967;
        bh=iQSoYl8q4FhnbKwTEHq557y3eO3rlEfgfrGzacEwQu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XDMXZcrucvgmBooip37O64WSgqQ2mcgeawoWUk9Wn1mtcmgyQw6XrrzVJE/bU8/+r
         P3l7kLQ2o9W3rqo5S9TH/4JolP795ZpDVyKhU1WeA2g65TGGZ+D15xAjxQTaK1L9xx
         kJigRPvhjaHhfzKMn00bQbaSF/T7aejvh+6//1bB8OBgDuYr68z4K/TMZF4orN2oY5
         ZKAREf9qPO9lBXTcJ92TEhU6oyqX0LOD3ZJaNPtequ0lUgzh1PxBMRgG6xTfymoQKO
         /cwGmu7wpIb19q6GPVbGvweLFELhZN886bF8S0SYOaT9CzN+OBeyIULkoc4nz7/M3p
         K9x9Vag7pzLiA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <festevam@gmail.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v12 02/13] PCI: imx6: Move PHY management functions together
Date:   Wed, 15 Jun 2022 18:15:40 -0500
Message-Id: <20220615231551.1054753-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615231551.1054753-1-helgaas@kernel.org>
References: <20220615231551.1054753-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Collect imx6_pcie_init_phy(), imx7d_pcie_wait_for_phy_pll_lock(), and
imx6_setup_phy_mpll() earlier with other PHY-related code.  No functional
change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 256 +++++++++++++-------------
 1 file changed, 128 insertions(+), 128 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 8653ca8cbfb9..e63eb6380020 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -296,6 +296,134 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
 	return 0;
 }
 
+static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
+{
+	switch (imx6_pcie->drvdata->variant) {
+	case IMX8MM:
+		/*
+		 * The PHY initialization had been done in the PHY
+		 * driver, break here directly.
+		 */
+		break;
+	case IMX8MQ:
+		/*
+		 * TODO: Currently this code assumes external
+		 * oscillator is being used
+		 */
+		regmap_update_bits(imx6_pcie->iomuxc_gpr,
+				   imx6_pcie_grp_offset(imx6_pcie),
+				   IMX8MQ_GPR_PCIE_REF_USE_PAD,
+				   IMX8MQ_GPR_PCIE_REF_USE_PAD);
+		/*
+		 * Regarding the datasheet, the PCIE_VPH is suggested
+		 * to be 1.8V. If the PCIE_VPH is supplied by 3.3V, the
+		 * VREG_BYPASS should be cleared to zero.
+		 */
+		if (imx6_pcie->vph &&
+		    regulator_get_voltage(imx6_pcie->vph) > 3000000)
+			regmap_update_bits(imx6_pcie->iomuxc_gpr,
+					   imx6_pcie_grp_offset(imx6_pcie),
+					   IMX8MQ_GPR_PCIE_VREG_BYPASS,
+					   0);
+		break;
+	case IMX7D:
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
+		break;
+	case IMX6SX:
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				   IMX6SX_GPR12_PCIE_RX_EQ_MASK,
+				   IMX6SX_GPR12_PCIE_RX_EQ_2);
+		fallthrough;
+	default:
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				   IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
+
+		/* configure constant input signal to the pcie ctrl and phy */
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				   IMX6Q_GPR12_LOS_LEVEL, 9 << 4);
+
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+				   IMX6Q_GPR8_TX_DEEMPH_GEN1,
+				   imx6_pcie->tx_deemph_gen1 << 0);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+				   IMX6Q_GPR8_TX_DEEMPH_GEN2_3P5DB,
+				   imx6_pcie->tx_deemph_gen2_3p5db << 6);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+				   IMX6Q_GPR8_TX_DEEMPH_GEN2_6DB,
+				   imx6_pcie->tx_deemph_gen2_6db << 12);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+				   IMX6Q_GPR8_TX_SWING_FULL,
+				   imx6_pcie->tx_swing_full << 18);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+				   IMX6Q_GPR8_TX_SWING_LOW,
+				   imx6_pcie->tx_swing_low << 25);
+		break;
+	}
+
+	imx6_pcie_configure_type(imx6_pcie);
+}
+
+static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
+{
+	u32 val;
+	struct device *dev = imx6_pcie->pci->dev;
+
+	if (regmap_read_poll_timeout(imx6_pcie->iomuxc_gpr,
+				     IOMUXC_GPR22, val,
+				     val & IMX7D_GPR22_PCIE_PHY_PLL_LOCKED,
+				     PHY_PLL_LOCK_WAIT_USLEEP_MAX,
+				     PHY_PLL_LOCK_WAIT_TIMEOUT))
+		dev_err(dev, "PCIe PLL lock timeout\n");
+}
+
+static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
+{
+	unsigned long phy_rate = clk_get_rate(imx6_pcie->pcie_phy);
+	int mult, div;
+	u16 val;
+
+	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
+		return 0;
+
+	switch (phy_rate) {
+	case 125000000:
+		/*
+		 * The default settings of the MPLL are for a 125MHz input
+		 * clock, so no need to reconfigure anything in that case.
+		 */
+		return 0;
+	case 100000000:
+		mult = 25;
+		div = 0;
+		break;
+	case 200000000:
+		mult = 25;
+		div = 1;
+		break;
+	default:
+		dev_err(imx6_pcie->pci->dev,
+			"Unsupported PHY reference clock rate %lu\n", phy_rate);
+		return -EINVAL;
+	}
+
+	pcie_phy_read(imx6_pcie, PCIE_PHY_MPLL_OVRD_IN_LO, &val);
+	val &= ~(PCIE_PHY_MPLL_MULTIPLIER_MASK <<
+		 PCIE_PHY_MPLL_MULTIPLIER_SHIFT);
+	val |= mult << PCIE_PHY_MPLL_MULTIPLIER_SHIFT;
+	val |= PCIE_PHY_MPLL_MULTIPLIER_OVRD;
+	pcie_phy_write(imx6_pcie, PCIE_PHY_MPLL_OVRD_IN_LO, val);
+
+	pcie_phy_read(imx6_pcie, PCIE_PHY_ATEOVRD, &val);
+	val &= ~(PCIE_PHY_ATEOVRD_REF_CLKDIV_MASK <<
+		 PCIE_PHY_ATEOVRD_REF_CLKDIV_SHIFT);
+	val |= div << PCIE_PHY_ATEOVRD_REF_CLKDIV_SHIFT;
+	val |= PCIE_PHY_ATEOVRD_EN;
+	pcie_phy_write(imx6_pcie, PCIE_PHY_ATEOVRD, val);
+
+	return 0;
+}
+
 static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
 {
 	u16 tmp;
@@ -500,19 +628,6 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 	return ret;
 }
 
-static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
-{
-	u32 val;
-	struct device *dev = imx6_pcie->pci->dev;
-
-	if (regmap_read_poll_timeout(imx6_pcie->iomuxc_gpr,
-				     IOMUXC_GPR22, val,
-				     val & IMX7D_GPR22_PCIE_PHY_PLL_LOCKED,
-				     PHY_PLL_LOCK_WAIT_USLEEP_MAX,
-				     PHY_PLL_LOCK_WAIT_TIMEOUT))
-		dev_err(dev, "PCIe PLL lock timeout\n");
-}
-
 static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
@@ -635,121 +750,6 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 	}
 }
 
-static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
-{
-	switch (imx6_pcie->drvdata->variant) {
-	case IMX8MM:
-		/*
-		 * The PHY initialization had been done in the PHY
-		 * driver, break here directly.
-		 */
-		break;
-	case IMX8MQ:
-		/*
-		 * TODO: Currently this code assumes external
-		 * oscillator is being used
-		 */
-		regmap_update_bits(imx6_pcie->iomuxc_gpr,
-				   imx6_pcie_grp_offset(imx6_pcie),
-				   IMX8MQ_GPR_PCIE_REF_USE_PAD,
-				   IMX8MQ_GPR_PCIE_REF_USE_PAD);
-		/*
-		 * Regarding the datasheet, the PCIE_VPH is suggested
-		 * to be 1.8V. If the PCIE_VPH is supplied by 3.3V, the
-		 * VREG_BYPASS should be cleared to zero.
-		 */
-		if (imx6_pcie->vph &&
-		    regulator_get_voltage(imx6_pcie->vph) > 3000000)
-			regmap_update_bits(imx6_pcie->iomuxc_gpr,
-					   imx6_pcie_grp_offset(imx6_pcie),
-					   IMX8MQ_GPR_PCIE_VREG_BYPASS,
-					   0);
-		break;
-	case IMX7D:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
-		break;
-	case IMX6SX:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX6SX_GPR12_PCIE_RX_EQ_MASK,
-				   IMX6SX_GPR12_PCIE_RX_EQ_2);
-		fallthrough;
-	default:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
-
-		/* configure constant input signal to the pcie ctrl and phy */
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX6Q_GPR12_LOS_LEVEL, 9 << 4);
-
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
-				   IMX6Q_GPR8_TX_DEEMPH_GEN1,
-				   imx6_pcie->tx_deemph_gen1 << 0);
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
-				   IMX6Q_GPR8_TX_DEEMPH_GEN2_3P5DB,
-				   imx6_pcie->tx_deemph_gen2_3p5db << 6);
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
-				   IMX6Q_GPR8_TX_DEEMPH_GEN2_6DB,
-				   imx6_pcie->tx_deemph_gen2_6db << 12);
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
-				   IMX6Q_GPR8_TX_SWING_FULL,
-				   imx6_pcie->tx_swing_full << 18);
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
-				   IMX6Q_GPR8_TX_SWING_LOW,
-				   imx6_pcie->tx_swing_low << 25);
-		break;
-	}
-
-	imx6_pcie_configure_type(imx6_pcie);
-}
-
-static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
-{
-	unsigned long phy_rate = clk_get_rate(imx6_pcie->pcie_phy);
-	int mult, div;
-	u16 val;
-
-	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
-		return 0;
-
-	switch (phy_rate) {
-	case 125000000:
-		/*
-		 * The default settings of the MPLL are for a 125MHz input
-		 * clock, so no need to reconfigure anything in that case.
-		 */
-		return 0;
-	case 100000000:
-		mult = 25;
-		div = 0;
-		break;
-	case 200000000:
-		mult = 25;
-		div = 1;
-		break;
-	default:
-		dev_err(imx6_pcie->pci->dev,
-			"Unsupported PHY reference clock rate %lu\n", phy_rate);
-		return -EINVAL;
-	}
-
-	pcie_phy_read(imx6_pcie, PCIE_PHY_MPLL_OVRD_IN_LO, &val);
-	val &= ~(PCIE_PHY_MPLL_MULTIPLIER_MASK <<
-		 PCIE_PHY_MPLL_MULTIPLIER_SHIFT);
-	val |= mult << PCIE_PHY_MPLL_MULTIPLIER_SHIFT;
-	val |= PCIE_PHY_MPLL_MULTIPLIER_OVRD;
-	pcie_phy_write(imx6_pcie, PCIE_PHY_MPLL_OVRD_IN_LO, val);
-
-	pcie_phy_read(imx6_pcie, PCIE_PHY_ATEOVRD, &val);
-	val &= ~(PCIE_PHY_ATEOVRD_REF_CLKDIV_MASK <<
-		 PCIE_PHY_ATEOVRD_REF_CLKDIV_SHIFT);
-	val |= div << PCIE_PHY_ATEOVRD_REF_CLKDIV_SHIFT;
-	val |= PCIE_PHY_ATEOVRD_EN;
-	pcie_phy_write(imx6_pcie, PCIE_PHY_ATEOVRD, val);
-
-	return 0;
-}
-
 static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
-- 
2.25.1

