Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B975E892F
	for <lists+linux-pci@lfdr.de>; Sat, 24 Sep 2022 09:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbiIXHcr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Sep 2022 03:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbiIXHcq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Sep 2022 03:32:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9EC979D1;
        Sat, 24 Sep 2022 00:32:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F48AB80E4B;
        Sat, 24 Sep 2022 07:32:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A2BC433D6;
        Sat, 24 Sep 2022 07:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664004761;
        bh=MvW2nw9Tq37atkISD2sTXKHttXxXGzJoXD9oQlvvmM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nb+O8uHfg69jJRTXdJmu12AgCkyAEm9hU9F3MQxF/azt+KNWw5Q8WcqoiLVZOEiCg
         wWOoWO4z/zz2w+Qjhas7ybMkaldJ41GeYaIYibwA4Ds9yo9bZ+1yVWOyT/DHcWPoEQ
         OtPBqb9Ma9wAqdGVYI8ipKuQHepilAuRIhKmqGKP/YP6siUCZ4PPZTMIdJzMjyTdH4
         kRBhrSjDl0mjx1N0/mY/U8ndRnbLe3V5tj3qrjx5r1mhRWqQ8K3oLItVFni5qyypEv
         c79sWPLm6XV2hQjP+R7STWG0DxT4MljjgQMy/KhLtWtwroKe1oZEv+eQ9I+2Ys0cUo
         YUi3JhfiNW6TQ==
Date:   Sat, 24 Sep 2022 13:02:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     p.zabel@pengutronix.de, l.stach@pengutronix.de,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        shawnguo@kernel.org, alexander.stein@ew.tq-group.com,
        marex@denx.de, richard.leitner@linux.dev,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: [PATCH v8 2/2] phy: freescale: imx8m-pcie: Add i.MX8MP PCIe PHY
 support
Message-ID: <Yy6yld/zNWB9bJKF@matsya>
References: <1663659498-5180-1-git-send-email-hongxing.zhu@nxp.com>
 <1663659498-5180-3-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1663659498-5180-3-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20-09-22, 15:38, Richard Zhu wrote:
> Add i.MX8MP PCIe PHY support.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Tested-by: Marek Vasut <marex@denx.de>
> Tested-by: Richard Leitner <richard.leitner@skidata.com>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 144 ++++++++++++++-------
>  1 file changed, 97 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> index ad7d2edfc414..bef0e9d64244 100644
> --- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> +++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> @@ -11,6 +11,9 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/mfd/syscon/imx7-iomuxc-gpr.h>
>  #include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/of_device.h>

why do you need all these headers..?

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

why this change? 

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
> +	enum		imx8_pcie_phy_type variant;
> +	const char	*gpr;
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

Lets do code reorg in a separate patch and then add support for new SOC,
that is more reviewable that this big pile of changes

> +	usleep_range(100, 200);
>  
> -	reset_control_deassert(imx8_phy->reset);
> +	/* Do the PHY common block reset */
> +	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> +			   IMX8MM_GPR_PCIE_CMN_RST,
> +			   IMX8MM_GPR_PCIE_CMN_RST);
> +
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
> @@ -209,6 +256,15 @@ static int imx8_pcie_phy_probe(struct platform_device *pdev)
>  		return PTR_ERR(imx8_phy->reset);
>  	}
>  
> +	if (imx8_phy->drvdata->variant == IMX8MP) {
> +		imx8_phy->perst =
> +			devm_reset_control_get_exclusive(dev, "perst");
> +		if (IS_ERR(imx8_phy->perst)) {
> +			dev_err(dev, "Failed to get PCIE PHY PERST control\n");
> +			return PTR_ERR(imx8_phy->perst);
> +		}
> +	}
> +
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	imx8_phy->base = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(imx8_phy->base))
> @@ -225,12 +281,6 @@ static int imx8_pcie_phy_probe(struct platform_device *pdev)
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
> -- 
> 2.25.1

-- 
~Vinod
