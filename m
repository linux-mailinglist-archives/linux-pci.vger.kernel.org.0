Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A3E5AAA3C
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 10:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbiIBIir (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 04:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235775AbiIBIig (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 04:38:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E010012750
        for <linux-pci@vger.kernel.org>; Fri,  2 Sep 2022 01:38:34 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1oU2Bw-0002Mx-GA; Fri, 02 Sep 2022 10:38:20 +0200
Message-ID: <0aae7d19a079e4631fc7b823d99ffbef30cfb4d2.camel@pengutronix.de>
Subject: Re: [PATCH v6 6/7] phy: freescale: imx8m-pcie: Add i.MX8MP PCIe PHY
 support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, p.zabel@pengutronix.de,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        shawnguo@kernel.org, vkoul@kernel.org,
        alexander.stein@ew.tq-group.com, marex@denx.de,
        richard.leitner@linux.dev
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Date:   Fri, 02 Sep 2022 10:38:19 +0200
In-Reply-To: <1662004960-14071-7-git-send-email-hongxing.zhu@nxp.com>
References: <1662004960-14071-1-git-send-email-hongxing.zhu@nxp.com>
         <1662004960-14071-7-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
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

Am Donnerstag, dem 01.09.2022 um 12:02 +0800 schrieb Richard Zhu:
> Add i.MX8MP PCIe PHY support.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Tested-by: Marek Vasut <marex@denx.de>
> Tested-by: Richard Leitner <richard.leitner@skidata.com>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 143 ++++++++++++++-------
>  1 file changed, 96 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> index ad7d2edfc414..c937d429ea8b 100644
> --- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> +++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> @@ -11,6 +11,9 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/mfd/syscon/imx7-iomuxc-gpr.h>
>  #include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/of_device.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> @@ -31,12 +34,10 @@
>  #define IMX8MM_PCIE_PHY_CMN_REG065	0x194
>  #define  ANA_AUX_RX_TERM		(BIT(7) | BIT(4))
>  #define  ANA_AUX_TX_LVL			GENMASK(3, 0)
> -#define IMX8MM_PCIE_PHY_CMN_REG75	0x1D4
> -#define  PCIE_PHY_CMN_REG75_PLL_DONE	0x3
> +#define IMX8MM_PCIE_PHY_CMN_REG075	0x1D4
> +#define  ANA_PLL_DONE			0x3
>  #define PCIE_PHY_TRSV_REG5		0x414
> -#define  PCIE_PHY_TRSV_REG5_GEN1_DEEMP	0x2D
>  #define PCIE_PHY_TRSV_REG6		0x418
> -#define  PCIE_PHY_TRSV_REG6_GEN2_DEEMP	0xF
>  
>  #define IMX8MM_GPR_PCIE_REF_CLK_SEL	GENMASK(25, 24)
>  #define IMX8MM_GPR_PCIE_REF_CLK_PLL	FIELD_PREP(IMX8MM_GPR_PCIE_REF_CLK_SEL, 0x3)
> @@ -47,16 +48,28 @@
>  #define IMX8MM_GPR_PCIE_SSC_EN		BIT(16)
>  #define IMX8MM_GPR_PCIE_AUX_EN_OVERRIDE	BIT(9)
>  
> +enum imx8_pcie_phy_type {
> +	IMX8MM,
> +	IMX8MP,
> +};
> +
> +struct imx8_pcie_phy_drvdata {
> +	enum	imx8_pcie_phy_type variant;
> +	char	gpr[128];

The static allocation is excessive and wastes a lot of memory. Just
make this a
const char *gpr;

> +};
> +
>  struct imx8_pcie_phy {
>  	void __iomem		*base;
>  	struct clk		*clk;
>  	struct phy		*phy;
>  	struct regmap		*iomuxc_gpr;
>  	struct reset_control	*reset;
> +	struct reset_control	*perst;
>  	u32			refclk_pad_mode;
>  	u32			tx_deemph_gen1;
>  	u32			tx_deemph_gen2;
>  	bool			clkreq_unused;
> +	const struct imx8_pcie_phy_drvdata	*drvdata;
>  };
>  
>  static int imx8_pcie_phy_init(struct phy *phy)
> @@ -68,31 +81,20 @@ static int imx8_pcie_phy_init(struct phy *phy)
>  	reset_control_assert(imx8_phy->reset);
>  
>  	pad_mode = imx8_phy->refclk_pad_mode;
> -	/* Set AUX_EN_OVERRIDE 1'b0, when the CLKREQ# isn't hooked */
> -	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> -			   IMX8MM_GPR_PCIE_AUX_EN_OVERRIDE,
> -			   imx8_phy->clkreq_unused ?
> -			   0 : IMX8MM_GPR_PCIE_AUX_EN_OVERRIDE);
> -	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> -			   IMX8MM_GPR_PCIE_AUX_EN,
> -			   IMX8MM_GPR_PCIE_AUX_EN);
> -	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> -			   IMX8MM_GPR_PCIE_POWER_OFF, 0);
> -	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> -			   IMX8MM_GPR_PCIE_SSC_EN, 0);
> -
> -	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> -			   IMX8MM_GPR_PCIE_REF_CLK_SEL,
> -			   pad_mode == IMX8_PCIE_REFCLK_PAD_INPUT ?
> -			   IMX8MM_GPR_PCIE_REF_CLK_EXT :
> -			   IMX8MM_GPR_PCIE_REF_CLK_PLL);
> -	usleep_range(100, 200);
> -
> -	/* Do the PHY common block reset */
> -	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> -			   IMX8MM_GPR_PCIE_CMN_RST,
> -			   IMX8MM_GPR_PCIE_CMN_RST);
> -	usleep_range(200, 500);
> +	switch (imx8_phy->drvdata->variant) {
> +	case IMX8MM:
> +		/* Tune PHY de-emphasis setting to pass PCIe compliance. */
> +		if (imx8_phy->tx_deemph_gen1)
> +			writel(imx8_phy->tx_deemph_gen1,
> +			       imx8_phy->base + PCIE_PHY_TRSV_REG5);
> +		if (imx8_phy->tx_deemph_gen2)
> +			writel(imx8_phy->tx_deemph_gen2,
> +			       imx8_phy->base + PCIE_PHY_TRSV_REG6);
> +		break;
> +	case IMX8MP:
> +		reset_control_assert(imx8_phy->perst);
> +		break;
> +	}
>  
>  	if (pad_mode == IMX8_PCIE_REFCLK_PAD_INPUT ||
>  	    pad_mode == IMX8_PCIE_REFCLK_PAD_UNUSED) {
> @@ -120,20 +122,44 @@ static int imx8_pcie_phy_init(struct phy *phy)
>  		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG065);
>  	}
>  
> -	/* Tune PHY de-emphasis setting to pass PCIe compliance. */
> -	if (imx8_phy->tx_deemph_gen1)
> -		writel(imx8_phy->tx_deemph_gen1,
> -		       imx8_phy->base + PCIE_PHY_TRSV_REG5);
> -	if (imx8_phy->tx_deemph_gen2)
> -		writel(imx8_phy->tx_deemph_gen2,
> -		       imx8_phy->base + PCIE_PHY_TRSV_REG6);
> +	/* Set AUX_EN_OVERRIDE 1'b0, when the CLKREQ# isn't hooked */
> +	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> +			   IMX8MM_GPR_PCIE_AUX_EN_OVERRIDE,
> +			   imx8_phy->clkreq_unused ?
> +			   0 : IMX8MM_GPR_PCIE_AUX_EN_OVERRIDE);
> +	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> +			   IMX8MM_GPR_PCIE_AUX_EN,
> +			   IMX8MM_GPR_PCIE_AUX_EN);
> +	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> +			   IMX8MM_GPR_PCIE_POWER_OFF, 0);
> +	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> +			   IMX8MM_GPR_PCIE_SSC_EN, 0);
> +
> +	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> +			   IMX8MM_GPR_PCIE_REF_CLK_SEL,
> +			   pad_mode == IMX8_PCIE_REFCLK_PAD_INPUT ?
> +			   IMX8MM_GPR_PCIE_REF_CLK_EXT :
> +			   IMX8MM_GPR_PCIE_REF_CLK_PLL);
> +	usleep_range(100, 200);
> +
> +	/* Do the PHY common block reset */
> +	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> +			   IMX8MM_GPR_PCIE_CMN_RST,
> +			   IMX8MM_GPR_PCIE_CMN_RST);
>  
> -	reset_control_deassert(imx8_phy->reset);
> +	switch (imx8_phy->drvdata->variant) {
> +	case IMX8MP:
> +		reset_control_deassert(imx8_phy->perst);
> +		fallthrough;
> +	case IMX8MM:
> +		reset_control_deassert(imx8_phy->reset);
> +		usleep_range(200, 500);
> +		break;
> +	}
>  
>  	/* Polling to check the phy is ready or not. */
> -	ret = readl_poll_timeout(imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG75,
> -				 val, val == PCIE_PHY_CMN_REG75_PLL_DONE,
> -				 10, 20000);
> +	ret = readl_poll_timeout(imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG075,
> +				 val, val == ANA_PLL_DONE, 10, 20000);
>  	return ret;
>  }
>  
> @@ -160,6 +186,25 @@ static const struct phy_ops imx8_pcie_phy_ops = {
>  	.owner		= THIS_MODULE,
>  };
>  
> +static const struct imx8_pcie_phy_drvdata drvdata[] = {
> +	[IMX8MM] = {
> +		.variant = IMX8MM,
> +		.gpr = "fsl,imx8mm-iomuxc-gpr",
> +	},
> +
> +	[IMX8MP] = {
> +		.variant = IMX8MP,
> +		.gpr = "fsl,imx8mp-iomuxc-gpr",
> +	},
> +};
> +
> +static const struct of_device_id imx8_pcie_phy_of_match[] = {
> +	{.compatible = "fsl,imx8mm-pcie-phy", .data = &drvdata[IMX8MM], },
> +	{.compatible = "fsl,imx8mp-pcie-phy", .data = &drvdata[IMX8MP], },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, imx8_pcie_phy_of_match);
> +
>  static int imx8_pcie_phy_probe(struct platform_device *pdev)
>  {
>  	struct phy_provider *phy_provider;
> @@ -172,6 +217,8 @@ static int imx8_pcie_phy_probe(struct platform_device *pdev)
>  	if (!imx8_phy)
>  		return -ENOMEM;
>  
> +	imx8_phy->drvdata = of_device_get_match_data(dev);
> +
>  	/* get PHY refclk pad mode */
>  	of_property_read_u32(np, "fsl,refclk-pad-mode",
>  			     &imx8_phy->refclk_pad_mode);
> @@ -197,7 +244,7 @@ static int imx8_pcie_phy_probe(struct platform_device *pdev)
>  
>  	/* Grab GPR config register range */
>  	imx8_phy->iomuxc_gpr =
> -		 syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
> +		 syscon_regmap_lookup_by_compatible(imx8_phy->drvdata->gpr);
>  	if (IS_ERR(imx8_phy->iomuxc_gpr)) {
>  		dev_err(dev, "unable to find iomuxc registers\n");
>  		return PTR_ERR(imx8_phy->iomuxc_gpr);
> @@ -208,6 +255,14 @@ static int imx8_pcie_phy_probe(struct platform_device *pdev)
>  		dev_err(dev, "Failed to get PCIEPHY reset control\n");
>  		return PTR_ERR(imx8_phy->reset);
>  	}

Missing newline.

Regards,
Lucas

> +	if (imx8_phy->drvdata->variant == IMX8MP) {
> +		imx8_phy->perst =
> +			devm_reset_control_get_exclusive(dev, "perst");
> +		if (IS_ERR(imx8_phy->perst)) {
> +			dev_err(dev, "Failed to get PCIE PHY PERST control\n");
> +			return PTR_ERR(imx8_phy->perst);
> +		}
> +	}
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	imx8_phy->base = devm_ioremap_resource(dev, res);
> @@ -225,12 +280,6 @@ static int imx8_pcie_phy_probe(struct platform_device *pdev)
>  	return PTR_ERR_OR_ZERO(phy_provider);
>  }
>  
> -static const struct of_device_id imx8_pcie_phy_of_match[] = {
> -	{.compatible = "fsl,imx8mm-pcie-phy",},
> -	{ },
> -};
> -MODULE_DEVICE_TABLE(of, imx8_pcie_phy_of_match);
> -
>  static struct platform_driver imx8_pcie_phy_driver = {
>  	.probe	= imx8_pcie_phy_probe,
>  	.driver = {


