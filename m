Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82755F06CD
	for <lists+linux-pci@lfdr.de>; Fri, 30 Sep 2022 10:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiI3Iqg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Sep 2022 04:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiI3Iqf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Sep 2022 04:46:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2F411F7FB
        for <linux-pci@vger.kernel.org>; Fri, 30 Sep 2022 01:46:34 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1oeBf5-0000eu-W7; Fri, 30 Sep 2022 10:46:24 +0200
Message-ID: <070a4442-6fd0-c63c-65d9-caca18eea20a@pengutronix.de>
Date:   Fri, 30 Sep 2022 09:46:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v10 4/4] phy: freescale: imx8m-pcie: Add i.MX8MP PCIe PHY
 support
Content-Language: en-US
To:     Richard Zhu <hongxing.zhu@nxp.com>, vkoul@kernel.org,
        p.zabel@pengutronix.de, l.stach@pengutronix.de,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        shawnguo@kernel.org, alexander.stein@ew.tq-group.com,
        marex@denx.de, richard.leitner@linux.dev
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <1664440622-18556-1-git-send-email-hongxing.zhu@nxp.com>
 <1664440622-18556-5-git-send-email-hongxing.zhu@nxp.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <1664440622-18556-5-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 29.09.22 09:37, Richard Zhu wrote:
> Add i.MX8MP PCIe PHY support.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Tested-by: Marek Vasut <marex@denx.de>
> Tested-by: Richard Leitner <richard.leitner@skidata.com>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> index 59b46a4ae069..be5e48864c5a 100644
> --- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> +++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> @@ -48,6 +48,7 @@
>  
>  enum imx8_pcie_phy_type {
>  	IMX8MM,
> +	IMX8MP,
>  };
>  
>  struct imx8_pcie_phy_drvdata {
> @@ -60,6 +61,7 @@ struct imx8_pcie_phy {
>  	struct clk		*clk;
>  	struct phy		*phy;
>  	struct regmap		*iomuxc_gpr;
> +	struct reset_control	*perst;
>  	struct reset_control	*reset;
>  	u32			refclk_pad_mode;
>  	u32			tx_deemph_gen1;
> @@ -87,6 +89,9 @@ static int imx8_pcie_phy_init(struct phy *phy)
>  			writel(imx8_phy->tx_deemph_gen2,
>  			       imx8_phy->base + PCIE_PHY_TRSV_REG6);
>  		break;
> +	case IMX8MP:
> +		reset_control_assert(imx8_phy->perst);
> +		break;
>  	}
>  
>  	if (pad_mode == IMX8_PCIE_REFCLK_PAD_INPUT ||
> @@ -141,6 +146,9 @@ static int imx8_pcie_phy_init(struct phy *phy)
>  			   IMX8MM_GPR_PCIE_CMN_RST);
>  
>  	switch (imx8_phy->drvdata->variant) {
> +	case IMX8MP:
> +		reset_control_deassert(imx8_phy->perst);
> +		fallthrough;
>  	case IMX8MM:
>  		reset_control_deassert(imx8_phy->reset);
>  		usleep_range(200, 500);
> @@ -181,8 +189,14 @@ static const struct imx8_pcie_phy_drvdata imx8mm_drvdata = {
>  	.gpr = "fsl,imx8mm-iomuxc-gpr",
>  };
>  
> +static const struct imx8_pcie_phy_drvdata imx8mp_drvdata = {
> +	.variant = IMX8MP,
> +	.gpr = "fsl,imx8mp-iomuxc-gpr",
> +};
> +
>  static const struct of_device_id imx8_pcie_phy_of_match[] = {
>  	{.compatible = "fsl,imx8mm-pcie-phy", .data = &imx8mm_drvdata, },
> +	{.compatible = "fsl,imx8mp-pcie-phy", .data = &imx8mp_drvdata, },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, imx8_pcie_phy_of_match);
> @@ -238,6 +252,15 @@ static int imx8_pcie_phy_probe(struct platform_device *pdev)
>  		return PTR_ERR(imx8_phy->reset);
>  	}
>  
> +	if (imx8_phy->drvdata->variant == IMX8MP) {
> +		imx8_phy->perst =
> +			devm_reset_control_get_exclusive(dev, "perst");
> +		if (IS_ERR(imx8_phy->perst)) {
> +			dev_err(dev, "Failed to get PCIE PHY PERST control\n");
> +			return PTR_ERR(imx8_phy->perst);

Nitpick: dev_err_probe here would be useful if user forgets to
enable PHY driver. Anyways:

Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Cheers,
Ahmad

> +		}
> +	}
> +
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	imx8_phy->base = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(imx8_phy->base))


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
