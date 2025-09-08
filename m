Return-Path: <linux-pci+bounces-35630-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE96B483DC
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 08:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E6503B4003
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 06:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0931E5B60;
	Mon,  8 Sep 2025 06:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sScEA+sA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B911D5CD7;
	Mon,  8 Sep 2025 06:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757311571; cv=none; b=KMaeT5cjqYtTFeSEVCPIebNge9cY+Ex8FEJW/WdX38qDKb6583aFb5GgjTIJ+cAoskeUWTHtvdXPRC4fZ8YxfNZyfqItMJ+YJika6Bf0JdE99CODSTnaygLXv6BBMaw61d92/EUgJunjvByCmPx+PCsgdhr4t1oxTCVjwfmGG/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757311571; c=relaxed/simple;
	bh=4A5Es5qiO5aqxXgStXXtaG5FSdU+XymwE0oZAPA6t9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AG9uWd66dC9YNpG23rFbD0XYXCoY/q1YtARdvyjAQIvTUpQLmZgAIFcURacBuLZyL06AiMUN865M2OA5g+1FFYkyjwEFpkZxUcESSyn1t5osaAmppCZsrSxYcf0DcPgNhOhCTDoq05AeCMunmnwLoTy/sgERZQrRgXmm+O5L4AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sScEA+sA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E95C4CEF5;
	Mon,  8 Sep 2025 06:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757311570;
	bh=4A5Es5qiO5aqxXgStXXtaG5FSdU+XymwE0oZAPA6t9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sScEA+sA2FKBBArmW0BBu8JxohX0FkHC+f/SBFY3YeWqUOyysMHCxb7/7iDt+0qoD
	 TsDDdpD59sTlAPboK/rVjWhddPoh60Zx1CDViPXKrn6jIjwIKT2mSWE7hgQEneqsIL
	 w5Im1LuSNaxaq6vY4DtByjrjiF4QYmI1ISKmTYFBzd+i4JStxYFPoEaQ38RISDvtnf
	 AsoxLk3IWske/zTAK4Woe+7WX4AX200yGqkhe1/Ebgv9aa4tqEtJzbMmYEZ1gYmulU
	 3mgXxvNNK0fvhzYLfcB+cDrwwIpvmYvb6lxEK7wH+QTufrLqN/IKyq9a2wLDyiB0SY
	 RtwRLrLKVyZIw==
Date: Mon, 8 Sep 2025 11:36:02 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] PCI: imx6: Add a method to handle CLKREQ#
 override active low
Message-ID: <ryvt2k2blew5wisy7edkjqdcmulrwey7lkeriasrmvaigpe3ku@vdgkod2bf7ma>
References: <20250820081048.2279057-1-hongxing.zhu@nxp.com>
 <20250820081048.2279057-3-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250820081048.2279057-3-hongxing.zhu@nxp.com>

On Wed, Aug 20, 2025 at 04:10:48PM GMT, Richard Zhu wrote:
> The CLKREQ# is an open drain, active low signal that is driven low by
> the card to request reference clock.
> 
> Since the reference clock may be required by i.MX PCIe host too.

Add some info on why the refclk is needed by the host.

> To make
> sure this clock is available even when the CLKREQ# isn't driven low by
> the card(e.x no card connected), force CLKREQ# override active low for
> i.MX PCIe host during initialization.
> 

CLKREQ# override is not a spec defined feature. So you need to explain what it
does first.

> The CLKREQ# override can be cleared safely when supports-clkreq is
> present and PCIe link is up later. Because the CLKREQ# would be driven
> low by the card in this case.
> 

Why do you need to depend on 'supports-clkreq' property? Don't you already know
if your platform supports CLKREQ# or not? None of the upstream DTS has the
'supports-clkreq' property set and the NXP binding also doesn't enable this
property.

So I'm wondering how you are suddenly using this property. The property implies
that when not set to true, CLKREQ# is not supported by the platform. So when the
driver starts using this property, all the old DTS based platforms are not going
to release CLKREQ# from driving low, so L1SS will not be entered for them. Do
you really want it to happen?

- Mani

> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 35 +++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 80e48746bbaf6..a73632b47e2d3 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -52,6 +52,8 @@
>  #define IMX95_PCIE_REF_CLKEN			BIT(23)
>  #define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
>  #define IMX95_PCIE_SS_RW_REG_1			0xf4
> +#define IMX95_PCIE_CLKREQ_OVERRIDE_EN		BIT(8)
> +#define IMX95_PCIE_CLKREQ_OVERRIDE_VAL		BIT(9)
>  #define IMX95_PCIE_SYS_AUX_PWR_DET		BIT(31)
>  
>  #define IMX95_PE0_GEN_CTRL_1			0x1050
> @@ -136,6 +138,7 @@ struct imx_pcie_drvdata {
>  	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
>  	int (*core_reset)(struct imx_pcie *pcie, bool assert);
>  	int (*wait_pll_lock)(struct imx_pcie *pcie);
> +	void (*clr_clkreq_override)(struct imx_pcie *pcie);
>  	const struct dw_pcie_host_ops *ops;
>  };
>  
> @@ -149,6 +152,7 @@ struct imx_pcie {
>  	struct gpio_desc	*reset_gpiod;
>  	struct clk_bulk_data	*clks;
>  	int			num_clks;
> +	bool			supports_clkreq;
>  	struct regmap		*iomuxc_gpr;
>  	u16			msi_ctrl;
>  	u32			controller_id;
> @@ -267,6 +271,13 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
>  			   IMX95_PCIE_REF_CLKEN,
>  			   IMX95_PCIE_REF_CLKEN);
>  
> +	/* Force CLKREQ# low by override */
> +	regmap_update_bits(imx_pcie->iomuxc_gpr,
> +			   IMX95_PCIE_SS_RW_REG_1,
> +			   IMX95_PCIE_CLKREQ_OVERRIDE_EN |
> +			   IMX95_PCIE_CLKREQ_OVERRIDE_VAL,
> +			   IMX95_PCIE_CLKREQ_OVERRIDE_EN |
> +			   IMX95_PCIE_CLKREQ_OVERRIDE_VAL);
>  	return 0;
>  }
>  
> @@ -1298,6 +1309,18 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
>  		regulator_disable(imx_pcie->vpcie);
>  }
>  
> +static void imx8mm_pcie_clr_clkreq_override(struct imx_pcie *imx_pcie)
> +{
> +	imx8mm_pcie_enable_ref_clk(imx_pcie, false);
> +}
> +
> +static void imx95_pcie_clr_clkreq_override(struct imx_pcie *imx_pcie)
> +{
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
> +			   IMX95_PCIE_CLKREQ_OVERRIDE_EN |
> +			   IMX95_PCIE_CLKREQ_OVERRIDE_VAL, 0);
> +}
> +
>  static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -1322,6 +1345,12 @@ static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
>  		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
>  		dw_pcie_dbi_ro_wr_dis(pci);
>  	}
> +
> +	/* Clear CLKREQ# override if supports_clkreq is true and link is up */
> +	if (dw_pcie_link_up(pci) && imx_pcie->supports_clkreq) {
> +		if (imx_pcie->drvdata->clr_clkreq_override)
> +			imx_pcie->drvdata->clr_clkreq_override(imx_pcie);
> +	}
>  }
>  
>  /*
> @@ -1745,6 +1774,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	pci->max_link_speed = 1;
>  	of_property_read_u32(node, "fsl,max-link-speed", &pci->max_link_speed);
>  
> +	imx_pcie->supports_clkreq =
> +		of_property_read_bool(node, "supports-clkreq");
>  	imx_pcie->vpcie = devm_regulator_get_optional(&pdev->dev, "vpcie");
>  	if (IS_ERR(imx_pcie->vpcie)) {
>  		if (PTR_ERR(imx_pcie->vpcie) != -ENODEV)
> @@ -1873,6 +1904,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
>  		.init_phy = imx8mq_pcie_init_phy,
>  		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> +		.clr_clkreq_override = imx8mm_pcie_clr_clkreq_override,
>  	},
>  	[IMX8MM] = {
>  		.variant = IMX8MM,
> @@ -1883,6 +1915,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_off[0] = IOMUXC_GPR12,
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> +		.clr_clkreq_override = imx8mm_pcie_clr_clkreq_override,
>  	},
>  	[IMX8MP] = {
>  		.variant = IMX8MP,
> @@ -1893,6 +1926,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_off[0] = IOMUXC_GPR12,
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> +		.clr_clkreq_override = imx8mm_pcie_clr_clkreq_override,
>  	},
>  	[IMX8Q] = {
>  		.variant = IMX8Q,
> @@ -1913,6 +1947,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.core_reset = imx95_pcie_core_reset,
>  		.init_phy = imx95_pcie_init_phy,
>  		.wait_pll_lock = imx95_pcie_wait_for_phy_pll_lock,
> +		.clr_clkreq_override = imx95_pcie_clr_clkreq_override,
>  	},
>  	[IMX8MQ_EP] = {
>  		.variant = IMX8MQ_EP,
> -- 
> 2.37.1
> 

-- 
மணிவண்ணன் சதாசிவம்

