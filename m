Return-Path: <linux-pci+bounces-3400-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 121238534AB
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 16:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF2412826DA
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 15:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1585DF29;
	Tue, 13 Feb 2024 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIh/4hZE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3684A5DF25;
	Tue, 13 Feb 2024 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838290; cv=none; b=MgbFvSrsaENZI1QVBKPxTgB3vGJ5kQi8Gb+FFfXEL34mGmCLCbJvfaZ9FAui7VyKkZkhe63PZvKJtj4kQE6nHjb1+eZ5ydoYqlrSGQ5ryFjRxaP6AphyEJu+ehIjZzsC9w922rce/lvp1a7fRtEv/JuFZpmp2uEYK1oPTk3Y7G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838290; c=relaxed/simple;
	bh=HYasL8XbF+5vHoVzjtw/IPlU2Sq1D4BVs9+mL4vWqy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyRmNua6EkYBKHVoMwXdXwvkwutZkyAn+drDvbyM9f0uSS1zicD/sPGj2rsY3zbnV45vwccf42HipCnvQe3Yweu2LrC3sW0V5lc9ryutA6kp5K3OKjQjfNPMVc22HJJ/ZZNbxNxZ1DkUHVGdMHaFWiP3HyCFsMo4+IdYaVRwLzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIh/4hZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB7EC433F1;
	Tue, 13 Feb 2024 15:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707838290;
	bh=HYasL8XbF+5vHoVzjtw/IPlU2Sq1D4BVs9+mL4vWqy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TIh/4hZEdoNNPJ0Opikly7lJce7d2W5cgdgQwNpiHjKvxOtpE8vmxqnN0rntJZyoS
	 xM5b0HE/Tk+mPc7hrrU1bAbqpPgsNtEvnf0kLH1bxzWFbYBwhBMtYB7NPNhSdc/tFg
	 SLpoL6p2Rv0NEVFQStYUG1KhlPISnTovoC5tec5qjOXxJBmkbHY+eLkmYVhgxUPust
	 FUX74wAG83VDGiit5ueN9TMMsQS7uKoAafcr7C/ZtUISeia4nOpskiC1sDbksQoCeQ
	 xXXJ3LIamyt29axhUkIrer2x/iRIuWwOlfCyEqNRO3bNGOmDuUziiptjo4KBaQajW+
	 XU2uMfquj8Khw==
Date: Tue, 13 Feb 2024 16:31:22 +0100
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
Subject: Re: [PATCH v10 01/14] PCI: imx6: Simplify clock handling by using
 clk_bulk*() function
Message-ID: <ZcuLSkvPuyMXsQeD@lpieralisi>
References: <20240205173335.1120469-1-Frank.Li@nxp.com>
 <20240205173335.1120469-2-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205173335.1120469-2-Frank.Li@nxp.com>

On Mon, Feb 05, 2024 at 12:33:22PM -0500, Frank Li wrote:
> Refector the clock handling logic. Add 'clk_names' define in drvdata. Use
> clk_bulk*() api simplify the code.
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Change from v9 to v10
>     - fixed missed delete a case, which need failthrough to next one.
>     Change from v8 to v9
>     - change clks names
>     - Add Manivannan's review tag
>     
>     Change from v7 to v8
>     - update comment message
>     - using ARRAY_SIZE to count clk_names.
>     Change from v6 to v7
>     - none
>     Change from v4 to v5
>     - update commit message
>     - direct using clk name list, instead of macro
>     - still keep caculate clk list count because sizeof return pre allocated
>     array size.
>     
>     Change from v3 to v4
>     - using clk_bulk_*() API
>     Change from v1 to v3
>     - none
>     
>     Change from v4 to v5
>     - update commit message
>     - direct using clk name list, instead of macro
>     - still keep caculate clk list count because sizeof return pre allocated
>     array size.
>     
>     Change from v3 to v4
>     - using clk_bulk_*() API
>     Change from v1 to v3
>     - none
>     
>     Change from v8 to v9
>     - change clks names
>     - Add Manivannan's review tag
>     
>     Change from v7 to v8
>     - update comment message
>     - using ARRAY_SIZE to count clk_names.
>     Change from v6 to v7
>     - none
>     Change from v4 to v5
>     - update commit message
>     - direct using clk name list, instead of macro
>     - still keep caculate clk list count because sizeof return pre allocated
>     array size.
>     
>     Change from v3 to v4
>     - using clk_bulk_*() API
>     Change from v1 to v3
>     - none
>     
>     Change from v4 to v5
>     - update commit message
>     - direct using clk name list, instead of macro
>     - still keep caculate clk list count because sizeof return pre allocated
>     array size.
>     
>     Change from v3 to v4
>     - using clk_bulk_*() API
>     Change from v1 to v3
>     - none
> 
>  drivers/pci/controller/dwc/pci-imx6.c | 138 ++++++++++----------------
>  1 file changed, 50 insertions(+), 88 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 74703362aeec7..82854e94c5621 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -61,12 +61,16 @@ enum imx6_pcie_variants {
>  #define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
>  #define IMX6_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
>  
> +#define IMX6_PCIE_MAX_CLKS       6
> +
>  struct imx6_pcie_drvdata {
>  	enum imx6_pcie_variants variant;
>  	enum dw_pcie_device_mode mode;
>  	u32 flags;
>  	int dbi_length;
>  	const char *gpr;
> +	const char * const *clk_names;
> +	const u32 clks_cnt;
>  };
>  
>  struct imx6_pcie {
> @@ -74,11 +78,7 @@ struct imx6_pcie {
>  	int			reset_gpio;
>  	bool			gpio_active_high;
>  	bool			link_is_up;
> -	struct clk		*pcie_bus;
> -	struct clk		*pcie_phy;
> -	struct clk		*pcie_inbound_axi;
> -	struct clk		*pcie;
> -	struct clk		*pcie_aux;
> +	struct clk_bulk_data	clks[IMX6_PCIE_MAX_CLKS];

Why can't you allocate this dynamically ?

>  	struct regmap		*iomuxc_gpr;
>  	u16			msi_ctrl;
>  	u32			controller_id;
> @@ -407,13 +407,18 @@ static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
>  
>  static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
>  {
> -	unsigned long phy_rate = clk_get_rate(imx6_pcie->pcie_phy);
> +	unsigned long phy_rate = 0;
>  	int mult, div;
>  	u16 val;
> +	int i;
>  
>  	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
>  		return 0;
>  
> +	for (i = 0; i < imx6_pcie->drvdata->clks_cnt; i++)
> +		if (strncmp(imx6_pcie->clks[i].id, "pcie_phy", 8) == 0)
> +			phy_rate = clk_get_rate(imx6_pcie->clks[i].clk);
> +
>  	switch (phy_rate) {
>  	case 125000000:
>  		/*
> @@ -550,19 +555,11 @@ static int imx6_pcie_attach_pd(struct device *dev)
>  
>  static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
>  {
> -	struct dw_pcie *pci = imx6_pcie->pci;
> -	struct device *dev = pci->dev;
>  	unsigned int offset;
>  	int ret = 0;
>  
>  	switch (imx6_pcie->drvdata->variant) {
>  	case IMX6SX:
> -		ret = clk_prepare_enable(imx6_pcie->pcie_inbound_axi);
> -		if (ret) {
> -			dev_err(dev, "unable to enable pcie_axi clock\n");
> -			break;
> -		}
> -
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
>  				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
>  		break;
> @@ -589,12 +586,6 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
>  	case IMX8MQ_EP:
>  	case IMX8MP:
>  	case IMX8MP_EP:
> -		ret = clk_prepare_enable(imx6_pcie->pcie_aux);
> -		if (ret) {
> -			dev_err(dev, "unable to enable pcie_aux clock\n");
> -			break;
> -		}
> -
>  		offset = imx6_pcie_grp_offset(imx6_pcie);
>  		/*
>  		 * Set the over ride low and enabled
> @@ -615,9 +606,6 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
>  static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
>  {
>  	switch (imx6_pcie->drvdata->variant) {
> -	case IMX6SX:
> -		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
> -		break;
>  	case IMX6QP:
>  	case IMX6Q:
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> @@ -631,14 +619,6 @@ static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
>  				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
>  				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
>  		break;
> -	case IMX8MM:
> -	case IMX8MM_EP:
> -	case IMX8MQ:
> -	case IMX8MQ_EP:
> -	case IMX8MP:
> -	case IMX8MP_EP:
> -		clk_disable_unprepare(imx6_pcie->pcie_aux);
> -		break;
>  	default:
>  		break;
>  	}
> @@ -650,23 +630,9 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
>  	struct device *dev = pci->dev;
>  	int ret;
>  
> -	ret = clk_prepare_enable(imx6_pcie->pcie_phy);
> -	if (ret) {
> -		dev_err(dev, "unable to enable pcie_phy clock\n");
> +	ret = clk_bulk_prepare_enable(imx6_pcie->drvdata->clks_cnt, imx6_pcie->clks);
> +	if (ret)
>  		return ret;
> -	}
> -
> -	ret = clk_prepare_enable(imx6_pcie->pcie_bus);
> -	if (ret) {
> -		dev_err(dev, "unable to enable pcie_bus clock\n");
> -		goto err_pcie_bus;
> -	}
> -
> -	ret = clk_prepare_enable(imx6_pcie->pcie);
> -	if (ret) {
> -		dev_err(dev, "unable to enable pcie clock\n");
> -		goto err_pcie;
> -	}
>  
>  	ret = imx6_pcie_enable_ref_clk(imx6_pcie);
>  	if (ret) {
> @@ -679,11 +645,7 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
>  	return 0;
>  
>  err_ref_clk:
> -	clk_disable_unprepare(imx6_pcie->pcie);
> -err_pcie:
> -	clk_disable_unprepare(imx6_pcie->pcie_bus);
> -err_pcie_bus:
> -	clk_disable_unprepare(imx6_pcie->pcie_phy);
> +	clk_bulk_disable_unprepare(imx6_pcie->drvdata->clks_cnt, imx6_pcie->clks);
>  
>  	return ret;
>  }
> @@ -691,9 +653,7 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
>  static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
>  {
>  	imx6_pcie_disable_ref_clk(imx6_pcie);
> -	clk_disable_unprepare(imx6_pcie->pcie);
> -	clk_disable_unprepare(imx6_pcie->pcie_bus);
> -	clk_disable_unprepare(imx6_pcie->pcie_phy);
> +	clk_bulk_disable_unprepare(imx6_pcie->drvdata->clks_cnt, imx6_pcie->clks);
>  }
>  
>  static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
> @@ -1252,6 +1212,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  	struct device_node *node = dev->of_node;
>  	int ret;
>  	u16 val;
> +	int i;
>  
>  	imx6_pcie = devm_kzalloc(dev, sizeof(*imx6_pcie), GFP_KERNEL);
>  	if (!imx6_pcie)
> @@ -1305,32 +1266,20 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  		return imx6_pcie->reset_gpio;
>  	}
>  
> -	/* Fetch clocks */
> -	imx6_pcie->pcie_bus = devm_clk_get(dev, "pcie_bus");
> -	if (IS_ERR(imx6_pcie->pcie_bus))
> -		return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_bus),
> -				     "pcie_bus clock source missing or invalid\n");
> +	if (imx6_pcie->drvdata->clks_cnt >= IMX6_PCIE_MAX_CLKS)
> +		return dev_err_probe(dev, -ENOMEM, "clks_cnt is too big\n");

Same question as above, this should not fail if the clks array is
dynamically allocated according to imx6_pcie->drvdata->clks_cnt.

Lorenzo

>  
> -	imx6_pcie->pcie = devm_clk_get(dev, "pcie");
> -	if (IS_ERR(imx6_pcie->pcie))
> -		return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie),
> -				     "pcie clock source missing or invalid\n");
> +	for (i = 0; i < imx6_pcie->drvdata->clks_cnt; i++)
> +		imx6_pcie->clks[i].id = imx6_pcie->drvdata->clk_names[i];
> +
> +	/* Fetch clocks */
> +	ret = devm_clk_bulk_get(dev, imx6_pcie->drvdata->clks_cnt, imx6_pcie->clks);
> +	if (ret)
> +		return ret;
>  
>  	switch (imx6_pcie->drvdata->variant) {
> -	case IMX6SX:
> -		imx6_pcie->pcie_inbound_axi = devm_clk_get(dev,
> -							   "pcie_inbound_axi");
> -		if (IS_ERR(imx6_pcie->pcie_inbound_axi))
> -			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_inbound_axi),
> -					     "pcie_inbound_axi clock missing or invalid\n");
> -		break;
>  	case IMX8MQ:
>  	case IMX8MQ_EP:
> -		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
> -		if (IS_ERR(imx6_pcie->pcie_aux))
> -			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
> -					     "pcie_aux clock source missing or invalid\n");
> -		fallthrough;
>  	case IMX7D:
>  		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
>  			imx6_pcie->controller_id = 1;
> @@ -1353,10 +1302,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  	case IMX8MM_EP:
>  	case IMX8MP:
>  	case IMX8MP_EP:
> -		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
> -		if (IS_ERR(imx6_pcie->pcie_aux))
> -			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
> -					     "pcie_aux clock source missing or invalid\n");
>  		imx6_pcie->apps_reset = devm_reset_control_get_exclusive(dev,
>  									 "apps");
>  		if (IS_ERR(imx6_pcie->apps_reset))
> @@ -1372,14 +1317,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  	default:
>  		break;
>  	}
> -	/* Don't fetch the pcie_phy clock, if it has abstract PHY driver */
> -	if (imx6_pcie->phy == NULL) {
> -		imx6_pcie->pcie_phy = devm_clk_get(dev, "pcie_phy");
> -		if (IS_ERR(imx6_pcie->pcie_phy))
> -			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_phy),
> -					     "pcie_phy clock source missing or invalid\n");
> -	}
> -
>  
>  	/* Grab turnoff reset */
>  	imx6_pcie->turnoff_reset = devm_reset_control_get_optional_exclusive(dev, "turnoff");
> @@ -1470,6 +1407,11 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
>  	imx6_pcie_assert_core_reset(imx6_pcie);
>  }
>  
> +static const char * const imx6q_clks[] = {"pcie_bus", "pcie", "pcie_phy"};
> +static const char * const imx8mm_clks[] = {"pcie_bus", "pcie", "pcie_aux"};
> +static const char * const imx8mq_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"};
> +static const char * const imx6sx_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_inbound_axi"};
> +
>  static const struct imx6_pcie_drvdata drvdata[] = {
>  	[IMX6Q] = {
>  		.variant = IMX6Q,
> @@ -1477,6 +1419,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
>  		.dbi_length = 0x200,
>  		.gpr = "fsl,imx6q-iomuxc-gpr",
> +		.clk_names = imx6q_clks,
> +		.clks_cnt = ARRAY_SIZE(imx6q_clks),
>  	},
>  	[IMX6SX] = {
>  		.variant = IMX6SX,
> @@ -1484,6 +1428,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE |
>  			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.gpr = "fsl,imx6q-iomuxc-gpr",
> +		.clk_names = imx6sx_clks,
> +		.clks_cnt = ARRAY_SIZE(imx6sx_clks),
>  	},
>  	[IMX6QP] = {
>  		.variant = IMX6QP,
> @@ -1492,40 +1438,56 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.dbi_length = 0x200,
>  		.gpr = "fsl,imx6q-iomuxc-gpr",
> +		.clk_names = imx6q_clks,
> +		.clks_cnt = ARRAY_SIZE(imx6q_clks),
>  	},
>  	[IMX7D] = {
>  		.variant = IMX7D,
>  		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.gpr = "fsl,imx7d-iomuxc-gpr",
> +		.clk_names = imx6q_clks,
> +		.clks_cnt = ARRAY_SIZE(imx6q_clks),
>  	},
>  	[IMX8MQ] = {
>  		.variant = IMX8MQ,
>  		.gpr = "fsl,imx8mq-iomuxc-gpr",
> +		.clk_names = imx8mq_clks,
> +		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
>  	},
>  	[IMX8MM] = {
>  		.variant = IMX8MM,
>  		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.gpr = "fsl,imx8mm-iomuxc-gpr",
> +		.clk_names = imx8mm_clks,
> +		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
>  	},
>  	[IMX8MP] = {
>  		.variant = IMX8MP,
>  		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.gpr = "fsl,imx8mp-iomuxc-gpr",
> +		.clk_names = imx8mm_clks,
> +		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
>  	},
>  	[IMX8MQ_EP] = {
>  		.variant = IMX8MQ_EP,
>  		.mode = DW_PCIE_EP_TYPE,
>  		.gpr = "fsl,imx8mq-iomuxc-gpr",
> +		.clk_names = imx8mq_clks,
> +		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
>  	},
>  	[IMX8MM_EP] = {
>  		.variant = IMX8MM_EP,
>  		.mode = DW_PCIE_EP_TYPE,
>  		.gpr = "fsl,imx8mm-iomuxc-gpr",
> +		.clk_names = imx8mm_clks,
> +		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
>  	},
>  	[IMX8MP_EP] = {
>  		.variant = IMX8MP_EP,
>  		.mode = DW_PCIE_EP_TYPE,
>  		.gpr = "fsl,imx8mp-iomuxc-gpr",
> +		.clk_names = imx8mm_clks,
> +		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
>  	},
>  };
>  
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

