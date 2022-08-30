Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3BE5A5D3A
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 09:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiH3Hpo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 03:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiH3Hpl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 03:45:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33362610E;
        Tue, 30 Aug 2022 00:45:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFA9C614E2;
        Tue, 30 Aug 2022 07:45:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D186C433C1;
        Tue, 30 Aug 2022 07:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661845538;
        bh=0AmD9efKkJBFo1GwVMluQEg1TLCwCH6ZxLnndj3/734=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rCXkCrd37RvDap0KsYcZj+bYkAcFfAxoIAZcy4bRUnIbeWIFRISy6KWYkcyDEkvka
         gezXZKg/Q48loSa2wdMYu7LX7t0bvW1tqisl8hAtJFsGApqAnRdgb+pPd0vKYhRW+o
         wa/EU6XFbtJ1b6WaaFb8enKdLZbdc4WLuv6crMl5sq5V8Qb53MNb7ay8wbgCI2iq3p
         P7B16HFC8ctrj3UaBimH9OSxALpxg2NZAHXZVnHGHO20UWqgsevFrcOI1en7apmU5G
         YMsRKbcHNAeq0REwY3hSBdKI2utS5RF+x5fzQO4o3pSvE8dHUQCdpQfXU9OFD5pO28
         vSu5LZpDUeAUA==
Date:   Tue, 30 Aug 2022 13:15:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>, p.zabel@pengutronix.de,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        shawnguo@kernel.org, alexander.stein@ew.tq-group.com,
        marex@denx.de, richard.leitner@linux.dev,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: [PATCH 2/2] fixup! phy: freescale: imx8m-pcie: Add iMX8MP PCIe
 PHY support
Message-ID: <Yw3AHmMG9G1g9ruZ@matsya>
References: <1661760917-9558-1-git-send-email-hongxing.zhu@nxp.com>
 <20220829151623.808344-1-l.stach@pengutronix.de>
 <20220829151623.808344-2-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829151623.808344-2-l.stach@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 29-08-22, 17:16, Lucas Stach wrote:
> ---
>  drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 31 +++-------------------
>  1 file changed, 3 insertions(+), 28 deletions(-)

Pls squash and resend the patch properly!


> 
> diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> index 3463b4299f2f..f714f419b91f 100644
> --- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> +++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> @@ -13,6 +13,7 @@
>  #include <linux/module.h>
>  #include <linux/of_address.h>
>  #include <linux/of_device.h>
> +#include <linux/of_device.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> @@ -47,10 +48,6 @@
>  #define IMX8MM_GPR_PCIE_SSC_EN		BIT(16)
>  #define IMX8MM_GPR_PCIE_AUX_EN_OVERRIDE	BIT(9)
>  
> -#define IMX8MP_GPR_REG0			0x0
> -#define IMX8MP_GPR_PHY_APB_RST		BIT(4)
> -#define IMX8MP_GPR_PHY_INIT_RST		BIT(5)
> -
>  enum imx8_pcie_phy_type {
>  	IMX8MM,
>  	IMX8MP,
> @@ -58,10 +55,8 @@ enum imx8_pcie_phy_type {
>  
>  struct imx8_pcie_phy {
>  	void __iomem		*base;
> -	struct device		*dev;
>  	struct clk		*clk;
>  	struct phy		*phy;
> -	struct regmap		*hsio_blk_ctrl;
>  	struct regmap		*iomuxc_gpr;
>  	struct reset_control	*reset;
>  	struct reset_control	*perst;
> @@ -93,13 +88,6 @@ static int imx8_pcie_phy_init(struct phy *phy)
>  		break;
>  	case IMX8MP:
>  		reset_control_assert(imx8_phy->perst);
> -
> -		/* release pcie_phy_apb_reset and pcie_phy_init_resetn */
> -		regmap_update_bits(imx8_phy->hsio_blk_ctrl, IMX8MP_GPR_REG0,
> -				   IMX8MP_GPR_PHY_APB_RST |
> -				   IMX8MP_GPR_PHY_INIT_RST,
> -				   IMX8MP_GPR_PHY_APB_RST |
> -				   IMX8MP_GPR_PHY_INIT_RST);
>  		break;
>  	}
>  
> @@ -204,21 +192,16 @@ static int imx8_pcie_phy_probe(struct platform_device *pdev)
>  {
>  	struct phy_provider *phy_provider;
>  	struct device *dev = &pdev->dev;
> -	const struct of_device_id *of_id;
>  	struct device_node *np = dev->of_node;
>  	struct imx8_pcie_phy *imx8_phy;
>  	struct resource *res;
>  
> -	of_id = of_match_device(imx8_pcie_phy_of_match, dev);
> -	if (!of_id)
> -		return -EINVAL;
> -
>  	imx8_phy = devm_kzalloc(dev, sizeof(*imx8_phy), GFP_KERNEL);
>  	if (!imx8_phy)
>  		return -ENOMEM;
>  
> -	imx8_phy->dev = dev;
> -	imx8_phy->variant = (enum imx8_pcie_phy_type)of_id->data;
> +	imx8_phy->variant =
> +		(enum imx8_pcie_phy_type)of_device_get_match_data(dev);
>  
>  	/* get PHY refclk pad mode */
>  	of_property_read_u32(np, "fsl,refclk-pad-mode",
> @@ -257,14 +240,6 @@ static int imx8_pcie_phy_probe(struct platform_device *pdev)
>  		return PTR_ERR(imx8_phy->reset);
>  	}
>  	if (imx8_phy->variant == IMX8MP) {
> -		/* Grab HSIO MIX config register range */
> -		imx8_phy->hsio_blk_ctrl =
> -			 syscon_regmap_lookup_by_compatible("fsl,imx8mp-hsio-blk-ctrl");
> -		if (IS_ERR(imx8_phy->hsio_blk_ctrl)) {
> -			dev_err(dev, "Unable to find HSIO MIX registers\n");
> -			return PTR_ERR(imx8_phy->hsio_blk_ctrl);
> -		}
> -
>  		imx8_phy->perst =
>  			devm_reset_control_get_exclusive(dev, "perst");
>  		if (IS_ERR(imx8_phy->perst)) {
> -- 
> 2.30.2

-- 
~Vinod
