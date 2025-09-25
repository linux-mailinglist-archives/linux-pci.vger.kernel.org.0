Return-Path: <linux-pci+bounces-37027-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE83BA1B5E
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 23:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D22A8189604F
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 21:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC17272E42;
	Thu, 25 Sep 2025 21:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9jw1uPI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC7F1F91D6;
	Thu, 25 Sep 2025 21:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758837479; cv=none; b=PVJhMGF2VucX/38X5bUmVDfvmxVEmeXrB2t9mjSWVxt6CnMyQAptnhgbkGDTwRoUIxJW00gdXAzL/ntEz4S8EnaZZ6ZSttkASuA3ciQAAz7ETfJ5u1KKNstE7wXXViBNFfq13kA6zHSolHoaqizF0rt6m7v/IyGD8mkw9QmHrLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758837479; c=relaxed/simple;
	bh=XSHViZo3Pi55CeXnpkwa+76DxWBGmZaI9vptrJBuf3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=h4b03vz3DckNkv9z4G+rMTTgvDSkhcJgXYtL1Ua2Tn84Dge3yIIO2w9ZAwmf9zFd7roeY01XZMrm+3xzGF3pt+mJ0vpd4B9pet9S56p3GJopV9ZjzxTQtiSCqN5s8bBF3qg9TZuP5/3dkgUEsDaR7mQiFcfu08PC2ld4Bxah82Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9jw1uPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA3EC4CEF0;
	Thu, 25 Sep 2025 21:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758837478;
	bh=XSHViZo3Pi55CeXnpkwa+76DxWBGmZaI9vptrJBuf3Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=O9jw1uPIi82h87JIKbVTIqu+AZDAM6k59eR34EetiOXMbG80a0szGPh5gViG08yGl
	 /QUNaZ27F2FodFn/W1wqFbHSTGFO+dbS9UK1VEVHUI+BOYgO2wr1LrUSvIiwx54EFj
	 cC+Ynvw9g8wd/RcH0Lki2jVBgwo4GQrA+OPJWkK+gAokG3V9doBxAQ33aIz9teJGqx
	 T6ow1SftLrX7eYgxfMNiRvsdTzW2miiSy0qxTChgG4uzufaUT1Ggrb3a/wVsa9kXg2
	 MQEDzbZm4IlpLxs8hQ+Xm7FZhfoQ4HPZGXSHRve9tmG1jLdMjHGj8PfS5dXyYWU/sO
	 saYoyggiS0edA==
Date: Thu, 25 Sep 2025 16:57:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, jingoohan1@gmail.com, l.stach@pengutronix.de,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] PCI: imx6: Add a method to handle CLKREQ#
 override active low
Message-ID: <20250925215757.GA2205491@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923073913.2722668-3-hongxing.zhu@nxp.com>

On Tue, Sep 23, 2025 at 03:39:13PM +0800, Richard Zhu wrote:
> The CLKREQ# is an open drain, active low signal that is driven low by
> the card to request reference clock. It's an optional signal added in
> PCIe CEM r4.0, sec 2. Thus, this signal wouldn't be driven low if it's
> reserved.
> 
> Since the reference clock controlled by CLKREQ# may be required by i.MX
> PCIe host too. To make sure this clock is ready even when the CLKREQ#
> isn't driven low by the card(e.x the scenario described above), force
> CLKREQ# override active low for i.MX PCIe host during initialization.
> 
> The CLKREQ# override can be cleared safely when supports-clkreq is
> present and PCIe link is up later. Because the CLKREQ# would be driven
> low by the card at this time.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 43 ++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 80e48746bbaf..6b03b1111d06 100644
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
> @@ -239,6 +243,16 @@ static unsigned int imx_pcie_grp_offset(const struct imx_pcie *imx_pcie)
>  	return imx_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
>  }
>  
> +static void  imx95_pcie_clkreq_override(struct imx_pcie *imx_pcie, bool enable)
> +{
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
> +			   IMX95_PCIE_CLKREQ_OVERRIDE_EN,
> +			   enable ? IMX95_PCIE_CLKREQ_OVERRIDE_EN : 0);
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
> +			   IMX95_PCIE_CLKREQ_OVERRIDE_VAL,
> +			   enable ? IMX95_PCIE_CLKREQ_OVERRIDE_VAL : 0);
> +}
> +
>  static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
>  {
>  	/*
> @@ -685,7 +699,7 @@ static int imx6q_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
>  	return 0;
>  }
>  
> -static int imx8mm_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
> +static void imx8mm_pcie_clkreq_override(struct imx_pcie *imx_pcie, bool enable)
>  {
>  	int offset = imx_pcie_grp_offset(imx_pcie);
>  
> @@ -695,6 +709,11 @@ static int imx8mm_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
>  	regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
>  			   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
>  			   enable ? IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN : 0);
> +}
> +
> +static int imx8mm_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
> +{
> +	imx8mm_pcie_clkreq_override(imx_pcie, enable);
>  	return 0;
>  }
>  
> @@ -1298,6 +1317,16 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
>  		regulator_disable(imx_pcie->vpcie);
>  }
>  
> +static void imx8mm_pcie_clr_clkreq_override(struct imx_pcie *imx_pcie)
> +{
> +	imx8mm_pcie_clkreq_override(imx_pcie, false);
> +}
> +
> +static void imx95_pcie_clr_clkreq_override(struct imx_pcie *imx_pcie)
> +{
> +	imx95_pcie_clkreq_override(imx_pcie, false);
> +}
> +
>  static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -1322,6 +1351,12 @@ static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
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
> @@ -1745,6 +1780,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	pci->max_link_speed = 1;
>  	of_property_read_u32(node, "fsl,max-link-speed", &pci->max_link_speed);
>  
> +	imx_pcie->supports_clkreq =
> +		of_property_read_bool(node, "supports-clkreq");
>  	imx_pcie->vpcie = devm_regulator_get_optional(&pdev->dev, "vpcie");
>  	if (IS_ERR(imx_pcie->vpcie)) {
>  		if (PTR_ERR(imx_pcie->vpcie) != -ENODEV)
> @@ -1873,6 +1910,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
>  		.init_phy = imx8mq_pcie_init_phy,
>  		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> +		.clr_clkreq_override = imx8mm_pcie_clr_clkreq_override,
>  	},
>  	[IMX8MM] = {
>  		.variant = IMX8MM,
> @@ -1883,6 +1921,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_off[0] = IOMUXC_GPR12,
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> +		.clr_clkreq_override = imx8mm_pcie_clr_clkreq_override,
>  	},
>  	[IMX8MP] = {
>  		.variant = IMX8MP,
> @@ -1893,6 +1932,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_off[0] = IOMUXC_GPR12,
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> +		.clr_clkreq_override = imx8mm_pcie_clr_clkreq_override,

imx8mm_pcie_enable_ref_clk() and imx8mm_pcie_clr_clkreq_override()
both call imx8mm_pcie_clkreq_override().

All these devices that use imx8mm_pcie_clr_clkreq_override() also
enable the refclk in .init() by overriding clkreq, so .post_init()
clears that override.

>  	},
>  	[IMX8Q] = {
>  		.variant = IMX8Q,
> @@ -1913,6 +1953,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.core_reset = imx95_pcie_core_reset,
>  		.init_phy = imx95_pcie_init_phy,
>  		.wait_pll_lock = imx95_pcie_wait_for_phy_pll_lock,
> +		.clr_clkreq_override = imx95_pcie_clr_clkreq_override,

But here there's no .enable_ref_clk() method, so I guess this device
must override clkreq automatically and the driver doesn't have to
enable that?

>  	},
>  	[IMX8MQ_EP] = {
>  		.variant = IMX8MQ_EP,
> -- 
> 2.37.1
> 

