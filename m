Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95000501CFA
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 22:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245713AbiDNVBS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 17:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiDNVBR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 17:01:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F6FDD976
        for <linux-pci@vger.kernel.org>; Thu, 14 Apr 2022 13:58:50 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1nf6Y1-00071j-Ks; Thu, 14 Apr 2022 22:58:37 +0200
Message-ID: <fb1cb6eebdb95def2d48b38ddc3b95398fde99d4.camel@pengutronix.de>
Subject: Re: [PATCH v2 3/7] phy: freescale: imx8m-pcie: Add iMX8MP PCIe PHY
 support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, p.zabel@pengutronix.de,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        shawnguo@kernel.org, vkoul@kernel.org,
        alexander.stein@ew.tq-group.com
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Date:   Thu, 14 Apr 2022 22:58:36 +0200
In-Reply-To: <1646644054-24421-4-git-send-email-hongxing.zhu@nxp.com>
References: <1646644054-24421-1-git-send-email-hongxing.zhu@nxp.com>
         <1646644054-24421-4-git-send-email-hongxing.zhu@nxp.com>
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

Am Montag, dem 07.03.2022 um 17:07 +0800 schrieb Richard Zhu:
> Add the i.MX8MP PCIe PHY support
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 205 ++++++++++++++++-----
>  1 file changed, 163 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> index 04b1aafb29f4..3d01da4323a6 100644
> --- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> +++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> @@ -11,6 +11,8 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/mfd/syscon/imx7-iomuxc-gpr.h>
>  #include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> @@ -30,12 +32,10 @@
>  #define IMX8MM_PCIE_PHY_CMN_REG065	0x194
>  #define  ANA_AUX_RX_TERM		(BIT(7) | BIT(4))
>  #define  ANA_AUX_TX_LVL			GENMASK(3, 0)
> -#define IMX8MM_PCIE_PHY_CMN_REG75	0x1D4
> -#define  PCIE_PHY_CMN_REG75_PLL_DONE	0x3
> +#define IMX8MM_PCIE_PHY_CMN_REG075	0x1D4
> +#define  ANA_PLL_DONE			0x3

Why do you drop the register prefix from the name here?

>  #define PCIE_PHY_TRSV_REG5		0x414
> -#define  PCIE_PHY_TRSV_REG5_GEN1_DEEMP	0x2D
>  #define PCIE_PHY_TRSV_REG6		0x418
> -#define  PCIE_PHY_TRSV_REG6_GEN2_DEEMP	0xF
>  
>  #define IMX8MM_GPR_PCIE_REF_CLK_SEL	GENMASK(25, 24)
>  #define IMX8MM_GPR_PCIE_REF_CLK_PLL	FIELD_PREP(IMX8MM_GPR_PCIE_REF_CLK_SEL, 0x3)
> @@ -46,16 +46,43 @@
>  #define IMX8MM_GPR_PCIE_SSC_EN		BIT(16)
>  #define IMX8MM_GPR_PCIE_AUX_EN_OVERRIDE	BIT(9)
>  
> +#define IMX8MP_GPR_REG0			0x0
> +#define IMX8MP_GPR_CLK_MOD_EN		BIT(0)
> +#define IMX8MP_GPR_PHY_APB_RST		BIT(4)
> +#define IMX8MP_GPR_PHY_INIT_RST		BIT(5)
> +#define IMX8MP_GPR_REG1			0x4
> +#define IMX8MP_GPR_PM_EN_CORE_CLK	BIT(0)
> +#define IMX8MP_GPR_PLL_LOCK		BIT(13)
> +#define IMX8MP_GPR_REG2			0x8
> +#define IMX8MP_GPR_P_PLL_MASK		GENMASK(5, 0)
> +#define IMX8MP_GPR_M_PLL_MASK		GENMASK(15, 6)
> +#define IMX8MP_GPR_S_PLL_MASK		GENMASK(18, 16)
> +#define IMX8MP_GPR_P_PLL		(0xc << 0)
> +#define IMX8MP_GPR_M_PLL		(0x320 << 6)
> +#define IMX8MP_GPR_S_PLL		(0x4 << 16)
> +#define IMX8MP_GPR_REG3			0xc
> +#define IMX8MP_GPR_PLL_CKE		BIT(17)
> +#define IMX8MP_GPR_PLL_RST		BIT(31)
> +
> +enum imx8_pcie_phy_type {
> +	IMX8MM,
> +	IMX8MP,
> +};
> +
>  struct imx8_pcie_phy {
>  	void __iomem		*base;
> +	struct device		*dev;
>  	struct clk		*clk;
>  	struct phy		*phy;
> +	struct regmap		*hsio_blk_ctrl;
>  	struct regmap		*iomuxc_gpr;
>  	struct reset_control	*reset;
> +	struct reset_control	*perst;
>  	u32			refclk_pad_mode;
>  	u32			tx_deemph_gen1;
>  	u32			tx_deemph_gen2;
>  	bool			clkreq_unused;
> +	enum imx8_pcie_phy_type	variant;
>  };
>  
>  static int imx8_pcie_phy_init(struct phy *phy)
> @@ -67,6 +94,87 @@ static int imx8_pcie_phy_init(struct phy *phy)
>  	reset_control_assert(imx8_phy->reset);
>  
>  	pad_mode = imx8_phy->refclk_pad_mode;
> +	switch (imx8_phy->variant) {
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

Could you tell us something more about this reset. What exactly is it
resetting. Do we really need to assert it before starting the HSIO PLL?
AFAICS the PLL should be pretty much independent of the PHY.

Do we need to enable this PLL when the PHY gets an external refclock? I
couldn't test it yet, but I suspect that the HSIO PLL is only needed as
an internal reference, when the i.MX8MP is the refclock source, either
through the PHY pads or via a clkout from the PLL.
 
> +		/* Set P=12,M=800,S=4 and must set ICP=2'b01. */
> +		regmap_update_bits(imx8_phy->hsio_blk_ctrl, IMX8MP_GPR_REG2,
> +				   IMX8MP_GPR_P_PLL_MASK |
> +				   IMX8MP_GPR_M_PLL_MASK |
> +				   IMX8MP_GPR_S_PLL_MASK,
> +				   IMX8MP_GPR_P_PLL |
> +				   IMX8MP_GPR_M_PLL |
> +				   IMX8MP_GPR_S_PLL);
> +		/* wait greater than 1/F_FREF =1/2MHZ=0.5us */
> +		udelay(1);
> +
> +		regmap_update_bits(imx8_phy->hsio_blk_ctrl, IMX8MP_GPR_REG3,
> +				   IMX8MP_GPR_PLL_RST,
> +				   IMX8MP_GPR_PLL_RST);
> +		udelay(10);
> +
> +		/* Set 1 to pll_cke of GPR_REG3 */
> +		regmap_update_bits(imx8_phy->hsio_blk_ctrl, IMX8MP_GPR_REG3,
> +				   IMX8MP_GPR_PLL_CKE,
> +				   IMX8MP_GPR_PLL_CKE);
> +
> +		/* Lock time should be greater than 300cycle=300*0.5us=150us */
> +		ret = regmap_read_poll_timeout(imx8_phy->hsio_blk_ctrl,
> +					     IMX8MP_GPR_REG1, val,
> +					     val & IMX8MP_GPR_PLL_LOCK,
> +					     10, 1000);
> +		if (ret) {
> +			dev_err(imx8_phy->dev, "PCIe PLL lock timeout\n");
> +			return ret;
> +		}
> +
> +		/* pcie_clock_module_en */
> +		regmap_update_bits(imx8_phy->hsio_blk_ctrl, IMX8MP_GPR_REG0,
> +				   IMX8MP_GPR_CLK_MOD_EN,
> +				   IMX8MP_GPR_CLK_MOD_EN);

You shouldn't need to touch this bit. The HSIO blk-ctrl already enables
this bit when the PCIe power-domain is powered up.

> +		udelay(10);
> +
> +		reset_control_deassert(imx8_phy->reset);
> +		reset_control_deassert(imx8_phy->perst);
> +
> +		/* release pcie_phy_apb_reset and pcie_phy_init_resetn */
> +		regmap_update_bits(imx8_phy->hsio_blk_ctrl, IMX8MP_GPR_REG0,
> +				   IMX8MP_GPR_PHY_APB_RST |
> +				   IMX8MP_GPR_PHY_INIT_RST,
> +				   IMX8MP_GPR_PHY_APB_RST |
> +				   IMX8MP_GPR_PHY_INIT_RST);

Not sure about those yet. We might want to toggle them via a virtual PD
in the HSIO blk-ctrl.

> +		break;
> +	}
> +
> +	if (pad_mode == IMX8_PCIE_REFCLK_PAD_INPUT) {
> +		/* Configure the pad as input */
> +		val = readl(imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG061);
> +		writel(val & ~ANA_PLL_CLK_OUT_TO_EXT_IO_EN,
> +		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG061);
> +	} else if (pad_mode == IMX8_PCIE_REFCLK_PAD_OUTPUT) {
> +		/* Configure the PHY to output the refclock via pad */
> +		writel(ANA_PLL_CLK_OUT_TO_EXT_IO_EN,
> +		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG061);
> +		writel(ANA_PLL_CLK_OUT_TO_EXT_IO_SEL,
> +		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG062);
> +		writel(AUX_PLL_REFCLK_SEL_SYS_PLL,
> +		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG063);
> +		val = ANA_AUX_RX_TX_SEL_TX | ANA_AUX_TX_TERM;
> +		writel(val | ANA_AUX_RX_TERM_GND_EN,
> +		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG064);
> +		writel(ANA_AUX_RX_TERM | ANA_AUX_TX_LVL,
> +		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG065);
> +	}
> +
>  	/* Set AUX_EN_OVERRIDE 1'b0, when the CLKREQ# isn't hooked */
>  	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
>  			   IMX8MM_GPR_PCIE_AUX_EN_OVERRIDE,
> @@ -91,42 +199,30 @@ static int imx8_pcie_phy_init(struct phy *phy)
>  	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
>  			   IMX8MM_GPR_PCIE_CMN_RST,
>  			   IMX8MM_GPR_PCIE_CMN_RST);
> -	usleep_range(200, 500);
>  
> -	if (pad_mode == IMX8_PCIE_REFCLK_PAD_INPUT) {
> -		/* Configure the pad as input */
> -		val = readl(imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG061);
> -		writel(val & ~ANA_PLL_CLK_OUT_TO_EXT_IO_EN,
> -		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG061);
> -	} else if (pad_mode == IMX8_PCIE_REFCLK_PAD_OUTPUT) {
> -		/* Configure the PHY to output the refclock via pad */
> -		writel(ANA_PLL_CLK_OUT_TO_EXT_IO_EN,
> -		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG061);
> -		writel(ANA_PLL_CLK_OUT_TO_EXT_IO_SEL,
> -		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG062);
> -		writel(AUX_PLL_REFCLK_SEL_SYS_PLL,
> -		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG063);
> -		val = ANA_AUX_RX_TX_SEL_TX | ANA_AUX_TX_TERM;
> -		writel(val | ANA_AUX_RX_TERM_GND_EN,
> -		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG064);
> -		writel(ANA_AUX_RX_TERM | ANA_AUX_TX_LVL,
> -		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG065);
> +	switch (imx8_phy->variant) {
> +	case IMX8MM:
> +		reset_control_deassert(imx8_phy->reset);
> +		usleep_range(200, 500);
> +		break;
> +
> +	case IMX8MP:
> +		/* wait for core_clk enabled */
> +		ret = regmap_read_poll_timeout(imx8_phy->hsio_blk_ctrl,
> +					     IMX8MP_GPR_REG1, val,
> +					     val & IMX8MP_GPR_PM_EN_CORE_CLK,
> +					     10, 20000);
> +		if (ret) {
> +			dev_err(imx8_phy->dev, "PCIe CORE CLK enable failed\n");
> +			return ret;
> +		}
> +
> +		break;
>  	}
>  
> -	/* Tune PHY de-emphasis setting to pass PCIe compliance. */
> -	if (imx8_phy->tx_deemph_gen1)
> -		writel(imx8_phy->tx_deemph_gen1,
> -		       imx8_phy->base + PCIE_PHY_TRSV_REG5);
> -	if (imx8_phy->tx_deemph_gen2)
> -		writel(imx8_phy->tx_deemph_gen2,
> -		       imx8_phy->base + PCIE_PHY_TRSV_REG6);
> -
> -	reset_control_deassert(imx8_phy->reset);
> -
>  	/* Polling to check the phy is ready or not. */
> -	ret = readl_poll_timeout(imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG75,
> -				 val, val == PCIE_PHY_CMN_REG75_PLL_DONE,
> -				 10, 20000);
> +	ret = readl_poll_timeout(imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG075,
> +				 val, val == ANA_PLL_DONE, 10, 20000);
>  	return ret;
>  }
>  
> @@ -153,18 +249,33 @@ static const struct phy_ops imx8_pcie_phy_ops = {
>  	.owner		= THIS_MODULE,
>  };
>  
> +static const struct of_device_id imx8_pcie_phy_of_match[] = {
> +	{.compatible = "fsl,imx8mm-pcie-phy", .data = (void *)IMX8MM},
> +	{.compatible = "fsl,imx8mp-pcie-phy", .data = (void *)IMX8MP},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, imx8_pcie_phy_of_match);
> +
>  static int imx8_pcie_phy_probe(struct platform_device *pdev)
>  {
>  	struct phy_provider *phy_provider;
>  	struct device *dev = &pdev->dev;
> +	const struct of_device_id *of_id;
>  	struct device_node *np = dev->of_node;
>  	struct imx8_pcie_phy *imx8_phy;
>  	struct resource *res;
>  
> +	of_id = of_match_device(imx8_pcie_phy_of_match, dev);
> +	if (!of_id)
> +		return -EINVAL;
> +
>  	imx8_phy = devm_kzalloc(dev, sizeof(*imx8_phy), GFP_KERNEL);
>  	if (!imx8_phy)
>  		return -ENOMEM;
>  
> +	imx8_phy->dev = dev;
> +	imx8_phy->variant = (enum imx8_pcie_phy_type)of_id->data;
> +
>  	/* get PHY refclk pad mode */
>  	of_property_read_u32(np, "fsl,refclk-pad-mode",
>  			     &imx8_phy->refclk_pad_mode);
> @@ -201,6 +312,22 @@ static int imx8_pcie_phy_probe(struct platform_device *pdev)
>  		dev_err(dev, "Failed to get PCIEPHY reset control\n");
>  		return PTR_ERR(imx8_phy->reset);
>  	}
> +	if (imx8_phy->variant == IMX8MP) {
> +		/* Grab HSIO MIX config register range */
> +		imx8_phy->hsio_blk_ctrl =
> +			 syscon_regmap_lookup_by_compatible("fsl,imx8mp-hsio-blk-ctrl");
> +		if (IS_ERR(imx8_phy->hsio_blk_ctrl)) {
> +			dev_err(dev, "unable to find hsio mix registers\n");
> +			return PTR_ERR(imx8_phy->hsio_blk_ctrl);
> +		}
> +
> +		imx8_phy->perst =
> +			devm_reset_control_get_exclusive(dev, "perst");
> +		if (IS_ERR(imx8_phy->perst)) {
> +			dev_err(dev, "Failed to get PCIEPHY perst control\n");
> +			return PTR_ERR(imx8_phy->perst);
> +		}
> +	}

I still hope that we can push all the HSIO blk-ctrl register access
into the blk-ctrl driver, by adding the PLL as a clock there and maybe
abstracting the PHY reset bits a virtual PD for the PHY, so we don't
need this direct access in the PHY driver. Depends a bit on weather we
are able to get the sequencing right when splitting things across
multiple drivers.

Regards,
Lucas

>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	imx8_phy->base = devm_ioremap_resource(dev, res);
> @@ -218,12 +345,6 @@ static int imx8_pcie_phy_probe(struct platform_device *pdev)
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


