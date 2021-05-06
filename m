Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0823E375CA0
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 23:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbhEFVKT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 17:10:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229650AbhEFVKQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 17:10:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2BD9861078;
        Thu,  6 May 2021 21:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620335357;
        bh=hnID+oqdKuoXeIuC+ZQ/vA9tFJT3nrrv8j6EW6wcrgM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=U497THrNaayZIFo6sDELoSwla3A5aSfztpF5ZckTVSb3pgKZdCYGGBHISat7IoBvZ
         a56eb/lGs1HJbc6q3R5KB79jVIhyS40St+VO5fjp/y4q7Szbx1ELc7FItweB0MwnmB
         BMtz2UZTQNabRCZhdQ6U9RTXSJWX64nScvxS3UqZiPUdCxcSL2AuT6Ya0SPmqGOkSN
         nduey/6vzL8oOw4asLoprrwt/sOcuN2XJqDIrEPMiJxTM+ets7mX18C1j9Wdro1OWB
         sL7GFQmPbu6Y12eCtbT5ouTu4wMvE8CzXdPLojXblsd5/heLYCyllyQJ2rDOD0Ug0D
         lCOw/e7SXEwLw==
Date:   Thu, 6 May 2021 16:09:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, andrew.smirnov@gmail.com,
        shawnguo@kernel.org, kw@linux.com, bhelgaas@google.com,
        stefan@agner.ch, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [RESEND v4 2/2] PCI: imx: clear vreg bypass when pcie vph
 voltage is 3v3
Message-ID: <20210506210915.GA1435377@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617091701-6444-3-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 30, 2021 at 04:08:21PM +0800, Richard Zhu wrote:
> Both 1.8v and 3.3v power supplies can be used by i.MX8MQ PCIe PHY.
> In default, the PCIE_VPH voltage is suggested to be 1.8v refer to data
> sheet. When PCIE_VPH is supplied by 3.3v in the HW schematic design,
> the VREG_BYPASS bits of GPR registers should be cleared from default
> value 1b'1 to 1b'0. Thus, the internal 3v3 to 1v8 translator would be
> turned on.

Maybe something like this?

  PCI: imx6: Enable PHY internal regulator when supplied >3V

  The i.MX8MQ PCIe PHY needs 1.8V but can by supplied by either a 1.8V
  or a 3.3V regulator.  

  The "vph-supply" DT property tells us which external regulator
  supplies the PHY.  If that regulator supplies anything over 3V,
  enable the PHY's internal 3.3V-to-1.8V regulator.

> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 853ea8e82952..94b43b4ecca1 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -37,6 +37,7 @@
>  #define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
>  #define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN	BIT(10)
>  #define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE	BIT(11)
> +#define IMX8MQ_GPR_PCIE_VREG_BYPASS		BIT(12)
>  #define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE	GENMASK(11, 8)
>  #define IMX8MQ_PCIE2_BASE_ADDR			0x33c00000
>  
> @@ -80,6 +81,7 @@ struct imx6_pcie {
>  	u32			tx_swing_full;
>  	u32			tx_swing_low;
>  	struct regulator	*vpcie;
> +	struct regulator	*vph;
>  	void __iomem		*phy_base;
>  
>  	/* power domain for pcie */
> @@ -621,6 +623,17 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
>  				   imx6_pcie_grp_offset(imx6_pcie),
>  				   IMX8MQ_GPR_PCIE_REF_USE_PAD,
>  				   IMX8MQ_GPR_PCIE_REF_USE_PAD);
> +		/*
> +		 * Regarding the datasheet, the PCIE_VPH is suggested
> +		 * to be 1.8V. If the PCIE_VPH is supplied by 3.3V, the
> +		 * VREG_BYPASS should be cleared to zero.
> +		 */
> +		if (imx6_pcie->vph &&
> +		    regulator_get_voltage(imx6_pcie->vph) > 3000000)
> +			regmap_update_bits(imx6_pcie->iomuxc_gpr,
> +					   imx6_pcie_grp_offset(imx6_pcie),
> +					   IMX8MQ_GPR_PCIE_VREG_BYPASS,
> +					   0);
>  		break;
>  	case IMX7D:
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> @@ -1130,6 +1143,13 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  		imx6_pcie->vpcie = NULL;
>  	}
>  
> +	imx6_pcie->vph = devm_regulator_get_optional(&pdev->dev, "vph");
> +	if (IS_ERR(imx6_pcie->vph)) {
> +		if (PTR_ERR(imx6_pcie->vph) != -ENODEV)
> +			return PTR_ERR(imx6_pcie->vph);
> +		imx6_pcie->vph = NULL;
> +	}
> +
>  	platform_set_drvdata(pdev, imx6_pcie);
>  
>  	ret = imx6_pcie_attach_pd(dev);
> -- 
> 2.17.1
> 
