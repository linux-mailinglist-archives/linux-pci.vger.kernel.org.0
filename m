Return-Path: <linux-pci+bounces-3391-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C70852FB4
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 12:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614B91F22EC5
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 11:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74D6374E0;
	Tue, 13 Feb 2024 11:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9hFuNLe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A2C383B2;
	Tue, 13 Feb 2024 11:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707824478; cv=none; b=QLWu4yY9JfHD+JwH3ihzDiAwbwltHATLGlLt6xKNAfYb068HCcWdyRIpAjgp7wZ6gkK6sdlnIDZ+Zx3S/CLROdzgnwmI08kh0hDa3Q/F2QPZ0YYQY8fXl5K6X1X47y4yxScuOP8qblK45ORVAsBdCz8PbBUegeUih3/ck5mwSME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707824478; c=relaxed/simple;
	bh=vcE4VEnsqCeEFS58nCHqwFF96GXVJtY39V+7YxzpGJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmX0o3yDYW9Jmnkn4pJfTyVQTmCQh5I+/g5u10nEUkqe8HNU4AsMS9YWukuFILXjVe9bT6zv1XowLLnkjtJ5oEtGIXu+6JVAyDqvMEooRbd7Dnv0I2LgLw20maj87aGye0EQu3bL/2IkirBziaMh0Xa75KmukyBJPAjoPgCdnC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9hFuNLe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9924EC433C7;
	Tue, 13 Feb 2024 11:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707824478;
	bh=vcE4VEnsqCeEFS58nCHqwFF96GXVJtY39V+7YxzpGJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D9hFuNLeBmxFMZ2fEls4m360KhrHa7/r5yzhaHxZEIJJ/KOMNQaIspdeJ6qNkAGf7
	 om3V5xII6BmPVrnUd+Gf2uSJD54jTLiZLemsNeEsijEQG0JueGpvUWEphph8M7aCrb
	 UGKj9B2TRyQFgBNV2pi0J7wsXaUedkxT2VibHAVnD+185w1/MlhQfYVuY3HKi6xJ9+
	 eX+b3gJxUIo/otji1LhMgRhQhd3HloVXA2gJxSrHdHipV0HZR2kUIwRxu1D0lMlUlR
	 ZM5sdFoNfW2bkFzqBu4rX8JoFSKhrdZyskDt1Sttj04HvEeTme61/Vt4cTqLht2T5U
	 tGTaG/DoDvDBA==
Date: Tue, 13 Feb 2024 12:41:10 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: bhelgaas@google.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
	festevam@gmail.com, helgaas@kernel.org, hongxing.zhu@nxp.com,
	imx@lists.linux.dev, kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
	kw@linux.com, l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v10 03/14] PCI: imx6: Simplify reset handling by using by
 using *_FLAG_HAS_*_RESET
Message-ID: <ZctVVjjHYVczweta@lpieralisi>
References: <20240205173335.1120469-1-Frank.Li@nxp.com>
 <20240205173335.1120469-4-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205173335.1120469-4-Frank.Li@nxp.com>

On Mon, Feb 05, 2024 at 12:33:24PM -0500, Frank Li wrote:
> Refactors the reset handling logic in the imx6 PCI driver by adding
> IMX6_PCIE_FLAG_HAS_*_RESET bitmask define for drvdata::flags.
> 
> The drvdata::flags and a bitmask ensures a cleaner and more scalable
> switch-case structure for handling reset.
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Change from v4 to v5:
>     - Add Mani's Reviewed-by tag
>     - Fixed MQ_EP's flags
>     
>     Chagne from v3 to v4:
>     - none
>     Change from v2 to v3:
>     - add Philipp's Reviewed-by tag
>     Change from v1 to v2:
>     - remove condition check before reset_control_(de)assert() because it is
>       none ops if a NULL pointer pass down.
>     - still keep condition check at probe to help identify dts file mismatch
>       problem.
>     
>     Change from v1 to v2:
>     - remove condition check before reset_control_(de)assert() because it is
>       none ops if a NULL pointer pass down.
>     - still keep condition check at probe to help identify dts file mismatch
>       problem.
> 
>  drivers/pci/controller/dwc/pci-imx6.c | 105 ++++++++++----------------
>  1 file changed, 39 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 59f117f855c26..a1653b58051b7 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -61,6 +61,8 @@ enum imx6_pcie_variants {
>  #define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
>  #define IMX6_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
>  #define IMX6_PCIE_FLAG_HAS_PHYDRV			BIT(3)
> +#define IMX6_PCIE_FLAG_HAS_APP_RESET		BIT(4)
> +#define IMX6_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
>  
>  #define imx6_check_flag(pci, val)     (pci->drvdata->flags & val)
>  
> @@ -661,18 +663,10 @@ static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
>  
>  static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
>  {
> +	reset_control_assert(imx6_pcie->pciephy_reset);
> +	reset_control_assert(imx6_pcie->apps_reset);
> +
>  	switch (imx6_pcie->drvdata->variant) {
> -	case IMX7D:
> -	case IMX8MQ:
> -	case IMX8MQ_EP:
> -		reset_control_assert(imx6_pcie->pciephy_reset);
> -		fallthrough;
> -	case IMX8MM:
> -	case IMX8MM_EP:
> -	case IMX8MP:
> -	case IMX8MP_EP:
> -		reset_control_assert(imx6_pcie->apps_reset);
> -		break;
>  	case IMX6SX:
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
>  				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
> @@ -693,6 +687,8 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
>  				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
>  		break;
> +	default:
> +		break;
>  	}
>  
>  	/* Some boards don't have PCIe reset GPIO. */
> @@ -706,14 +702,10 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  	struct dw_pcie *pci = imx6_pcie->pci;
>  	struct device *dev = pci->dev;
>  
> +	reset_control_deassert(imx6_pcie->pciephy_reset);
> +
>  	switch (imx6_pcie->drvdata->variant) {
> -	case IMX8MQ:
> -	case IMX8MQ_EP:
> -		reset_control_deassert(imx6_pcie->pciephy_reset);
> -		break;
>  	case IMX7D:
> -		reset_control_deassert(imx6_pcie->pciephy_reset);
> -
>  		/* Workaround for ERR010728, failure of PCI-e PLL VCO to
>  		 * oscillate, especially when cold.  This turns off "Duty-cycle
>  		 * Corrector" and other mysterious undocumented things.
> @@ -745,11 +737,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  
>  		usleep_range(200, 500);
>  		break;
> -	case IMX6Q:		/* Nothing to do */
> -	case IMX8MM:
> -	case IMX8MM_EP:
> -	case IMX8MP:
> -	case IMX8MP_EP:
> +	default:
>  		break;
>  	}
>  
> @@ -796,16 +784,11 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
>  				   IMX6Q_GPR12_PCIE_CTL_2,
>  				   IMX6Q_GPR12_PCIE_CTL_2);
>  		break;
> -	case IMX7D:
> -	case IMX8MQ:
> -	case IMX8MQ_EP:
> -	case IMX8MM:
> -	case IMX8MM_EP:
> -	case IMX8MP:
> -	case IMX8MP_EP:
> -		reset_control_deassert(imx6_pcie->apps_reset);
> +	default:
>  		break;
>  	}
> +
> +	reset_control_deassert(imx6_pcie->apps_reset);

You rely on the fact that passing NULL is a no-op on platforms where
this wasn't called before (valid question for other hunks in this commit),
correct ?

Just checking, it does not make things much cleaner but I am not opposed to
this change.

Thanks,
Lorenzo

>  }
>  
>  static void imx6_pcie_ltssm_disable(struct device *dev)
> @@ -819,16 +802,11 @@ static void imx6_pcie_ltssm_disable(struct device *dev)
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
>  				   IMX6Q_GPR12_PCIE_CTL_2, 0);
>  		break;
> -	case IMX7D:
> -	case IMX8MQ:
> -	case IMX8MQ_EP:
> -	case IMX8MM:
> -	case IMX8MM_EP:
> -	case IMX8MP:
> -	case IMX8MP_EP:
> -		reset_control_assert(imx6_pcie->apps_reset);
> +	default:
>  		break;
>  	}
> +
> +	reset_control_assert(imx6_pcie->apps_reset);
>  }
>  
>  static int imx6_pcie_start_link(struct dw_pcie *pci)
> @@ -1287,38 +1265,26 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  					     "failed to get pcie phy\n");
>  	}
>  
> +	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_APP_RESET)) {
> +		imx6_pcie->apps_reset = devm_reset_control_get_exclusive(dev, "apps");
> +		if (IS_ERR(imx6_pcie->apps_reset))
> +			return dev_err_probe(dev, PTR_ERR(imx6_pcie->apps_reset),
> +					     "failed to get pcie apps reset control\n");
> +	}
> +
> +	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_PHY_RESET)) {
> +		imx6_pcie->pciephy_reset = devm_reset_control_get_exclusive(dev, "pciephy");
> +		if (IS_ERR(imx6_pcie->pciephy_reset))
> +			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pciephy_reset),
> +					     "Failed to get PCIEPHY reset control\n");
> +	}
> +
>  	switch (imx6_pcie->drvdata->variant) {
>  	case IMX8MQ:
>  	case IMX8MQ_EP:
>  	case IMX7D:
>  		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
>  			imx6_pcie->controller_id = 1;
> -
> -		imx6_pcie->pciephy_reset = devm_reset_control_get_exclusive(dev,
> -									    "pciephy");
> -		if (IS_ERR(imx6_pcie->pciephy_reset)) {
> -			dev_err(dev, "Failed to get PCIEPHY reset control\n");
> -			return PTR_ERR(imx6_pcie->pciephy_reset);
> -		}
> -
> -		imx6_pcie->apps_reset = devm_reset_control_get_exclusive(dev,
> -									 "apps");
> -		if (IS_ERR(imx6_pcie->apps_reset)) {
> -			dev_err(dev, "Failed to get PCIE APPS reset control\n");
> -			return PTR_ERR(imx6_pcie->apps_reset);
> -		}
> -		break;
> -	case IMX8MM:
> -	case IMX8MM_EP:
> -	case IMX8MP:
> -	case IMX8MP_EP:
> -		imx6_pcie->apps_reset = devm_reset_control_get_exclusive(dev,
> -									 "apps");
> -		if (IS_ERR(imx6_pcie->apps_reset))
> -			return dev_err_probe(dev, PTR_ERR(imx6_pcie->apps_reset),
> -					     "failed to get pcie apps reset control\n");
> -
> -		break;
>  	default:
>  		break;
>  	}
> @@ -1448,13 +1414,17 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  	},
>  	[IMX7D] = {
>  		.variant = IMX7D,
> -		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> +		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
> +			 IMX6_PCIE_FLAG_HAS_APP_RESET |
> +			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
>  		.gpr = "fsl,imx7d-iomuxc-gpr",
>  		.clk_names = imx6q_clks,
>  		.clks_cnt = ARRAY_SIZE(imx6q_clks),
>  	},
>  	[IMX8MQ] = {
>  		.variant = IMX8MQ,
> +		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
> +			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
>  		.gpr = "fsl,imx8mq-iomuxc-gpr",
>  		.clk_names = imx8mq_clks,
>  		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
> @@ -1471,13 +1441,16 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  	[IMX8MP] = {
>  		.variant = IMX8MP,
>  		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
> -			 IMX6_PCIE_FLAG_HAS_PHYDRV,
> +			 IMX6_PCIE_FLAG_HAS_PHYDRV |
> +			 IMX6_PCIE_FLAG_HAS_APP_RESET,
>  		.gpr = "fsl,imx8mp-iomuxc-gpr",
>  		.clk_names = imx8mm_clks,
>  		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
>  	},
>  	[IMX8MQ_EP] = {
>  		.variant = IMX8MQ_EP,
> +		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
> +			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
>  		.mode = DW_PCIE_EP_TYPE,
>  		.gpr = "fsl,imx8mq-iomuxc-gpr",
>  		.clk_names = imx8mq_clks,
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

