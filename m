Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E231D3474AA
	for <lists+linux-pci@lfdr.de>; Wed, 24 Mar 2021 10:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbhCXJat (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Mar 2021 05:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbhCXJaV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Mar 2021 05:30:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C67FC061763
        for <linux-pci@vger.kernel.org>; Wed, 24 Mar 2021 02:30:21 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1lOzqB-0001u3-Bg; Wed, 24 Mar 2021 10:30:15 +0100
Message-ID: <6d31825ab3c47bb2e3440445b1dad3f4f1c53c44.camel@pengutronix.de>
Subject: Re: [PATCH v2 3/3] PCI: imx: clear vreg bypass when pcie vph
 voltage is 3v3
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, andrew.smirnov@gmail.com,
        shawnguo@kernel.org, kw@linux.com, bhelgaas@google.com,
        stefan@agner.ch, lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Date:   Wed, 24 Mar 2021 10:30:13 +0100
In-Reply-To: <1616564059-8713-4-git-send-email-hongxing.zhu@nxp.com>
References: <1616564059-8713-1-git-send-email-hongxing.zhu@nxp.com>
         <1616564059-8713-4-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Mittwoch, dem 24.03.2021 um 13:34 +0800 schrieb Richard Zhu:
> Both 1.8v and 3.3v power supplies can be used by i.MX8MQ PCIe PHY.
> In default, the PCIE_VPH voltage is suggested to be 1.8v refer to data
> sheet. When PCIE_VPH is supplied by 3.3v in the HW schematic design,
> the VREG_BYPASS bits of GPR registers should be cleared from default
> value 1b'1 to 1b'0. Thus, the internal 3v3 to 1v8 translator would be
> turned on.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 853ea8e82952..beca085a9300 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -37,6 +37,7 @@
>  #define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
>  #define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN	BIT(10)
>  #define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE	BIT(11)
> +#define IMX8MQ_GPR_PCIE_VREG_BYPASS		BIT(12)
>  #define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE	GENMASK(11, 8)
>  #define IMX8MQ_PCIE2_BASE_ADDR			0x33c00000
>  
> 
> 
> 
> @@ -80,6 +81,7 @@ struct imx6_pcie {
>  	u32			tx_swing_full;
>  	u32			tx_swing_low;
>  	struct regulator	*vpcie;
> +	struct regulator	*vph;
>  	void __iomem		*phy_base;
>  
> 
> 
> 
>  	/* power domain for pcie */
> @@ -611,6 +613,8 @@ static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
>  
> 
> 
> 
>  static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
>  {
> +	int phy_uv;
> +
No need for this variable...

>  	switch (imx6_pcie->drvdata->variant) {
>  	case IMX8MQ:
>  		/*
> @@ -621,6 +625,18 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
>  				   imx6_pcie_grp_offset(imx6_pcie),
>  				   IMX8MQ_GPR_PCIE_REF_USE_PAD,
>  				   IMX8MQ_GPR_PCIE_REF_USE_PAD);
> +		/*
> +		 * Regarding to the datasheet, the PCIE_VPH is suggested
> +		 * to be 1.8V. If the PCIE_VPH is supplied by 3.3V, the
> +		 * VREG_BYPASS should be cleared to zero.
> +		 */
> +		if (imx6_pcie->vph)
> +			phy_uv = regulator_get_voltage(imx6_pcie->vph);
> +		if (phy_uv > 3000000)
> +			regmap_update_bits(imx6_pcie->iomuxc_gpr,
> +					   imx6_pcie_grp_offset(imx6_pcie),
> +					   IMX8MQ_GPR_PCIE_VREG_BYPASS,
> +					   0);

...if you just fold this into a single condition. Right now phy_uv
might be used uninitialized when the vph-supply is not specified in the
DT. Better write this as:

if (imx6_pcie->vph && regulator_get_voltage(imx6_pcie->vph) > 3000000)

Regards,
Lucas

>  		break;
>  	case IMX7D:
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> @@ -1130,6 +1146,13 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  		imx6_pcie->vpcie = NULL;
>  	}
>  
> 
> 
> 
> 
> 
> 
> 
> +	imx6_pcie->vph = devm_regulator_get_optional(&pdev->dev, "vph");
> +	if (IS_ERR(imx6_pcie->vph)) {
> +		if (PTR_ERR(imx6_pcie->vph) != -ENODEV)
> +			return PTR_ERR(imx6_pcie->vph);
> +		imx6_pcie->vph = NULL;
> +	}
> +
>  	platform_set_drvdata(pdev, imx6_pcie);
>  
> 
> 
> 
> 
> 
> 
> 
>  	ret = imx6_pcie_attach_pd(dev);


