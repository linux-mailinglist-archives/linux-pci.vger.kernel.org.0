Return-Path: <linux-pci+bounces-1591-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8424D821886
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 09:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1033E1F21A7A
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 08:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842BD4C8F;
	Tue,  2 Jan 2024 08:48:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A0C5382
	for <linux-pci@vger.kernel.org>; Tue,  2 Jan 2024 08:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1rKaR9-0004UX-8C; Tue, 02 Jan 2024 09:47:47 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1rKaR5-0038oO-JY; Tue, 02 Jan 2024 09:47:44 +0100
Received: from mfe by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1rKaR6-009tC8-J4; Tue, 02 Jan 2024 09:47:44 +0100
Date: Tue, 2 Jan 2024 09:47:44 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>
Cc: krzysztof.kozlowski@linaro.org, devicetree@vger.kernel.org,
	conor+dt@kernel.org, hongxing.zhu@nxp.com,
	krzysztof.kozlowski+dt@linaro.org, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org,
	linux-kernel@vger.kernel.org, s.hauer@pengutronix.de,
	helgaas@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
	manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
	shawnguo@kernel.org, kw@linux.com, festevam@gmail.com,
	robh@kernel.org, linux-arm-kernel@lists.infradead.org,
	l.stach@pengutronix.de
Subject: Re: [PATCH v7 01/16] PCI: imx6: Simplify clock handling by using
 bulk_clk_*() function
Message-ID: <20240102084744.tyquwp6hkb36tfxg@pengutronix.de>
References: <20231227182727.1747435-1-Frank.Li@nxp.com>
 <20231227182727.1747435-2-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231227182727.1747435-2-Frank.Li@nxp.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org

Hi Frank,

On 23-12-27, Frank Li wrote:
> Refactors the clock handling logic. Adds clk_names[] define in drvdata.
> Using clk_bulk*() api simplifies the code.

does this influence the clock enable/disable sequence ordering? Just
asking to avoid regressions on older platforms which may require some
sort of order (e.g. require clock-a before clock-b).

Regards,
  Marco

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
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
>  drivers/pci/controller/dwc/pci-imx6.c | 125 ++++++++------------------
>  1 file changed, 35 insertions(+), 90 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 74703362aeec7..50d9faaa17f71 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -61,12 +61,15 @@ enum imx6_pcie_variants {
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
> +	const char *clk_names[IMX6_PCIE_MAX_CLKS];
>  };
>  
>  struct imx6_pcie {
> @@ -74,11 +77,8 @@ struct imx6_pcie {
>  	int			reset_gpio;
>  	bool			gpio_active_high;
>  	bool			link_is_up;
> -	struct clk		*pcie_bus;
> -	struct clk		*pcie_phy;
> -	struct clk		*pcie_inbound_axi;
> -	struct clk		*pcie;
> -	struct clk		*pcie_aux;
> +	struct clk_bulk_data	clks[IMX6_PCIE_MAX_CLKS];
> +	u32			clks_cnt;
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
> +	for (i = 0; i < imx6_pcie->clks_cnt; i++)
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
> +	ret =  clk_bulk_prepare_enable(imx6_pcie->clks_cnt, imx6_pcie->clks);
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
> +	clk_bulk_disable_unprepare(imx6_pcie->clks_cnt, imx6_pcie->clks);
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
> +	clk_bulk_disable_unprepare(imx6_pcie->clks_cnt, imx6_pcie->clks);
>  }
>  
>  static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
> @@ -1305,32 +1265,19 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  		return imx6_pcie->reset_gpio;
>  	}
>  
> -	/* Fetch clocks */
> -	imx6_pcie->pcie_bus = devm_clk_get(dev, "pcie_bus");
> -	if (IS_ERR(imx6_pcie->pcie_bus))
> -		return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_bus),
> -				     "pcie_bus clock source missing or invalid\n");
> +	while (imx6_pcie->drvdata->clk_names[imx6_pcie->clks_cnt]) {
> +		int i = imx6_pcie->clks_cnt;
> +
> +		imx6_pcie->clks[i].id = imx6_pcie->drvdata->clk_names[i];
> +		imx6_pcie->clks_cnt++;
> +	}
>  
> -	imx6_pcie->pcie = devm_clk_get(dev, "pcie");
> -	if (IS_ERR(imx6_pcie->pcie))
> -		return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie),
> -				     "pcie clock source missing or invalid\n");
> +	/* Fetch clocks */
> +	ret = devm_clk_bulk_get(dev, imx6_pcie->clks_cnt, imx6_pcie->clks);
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
> -	case IMX8MQ:
> -	case IMX8MQ_EP:
> -		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
> -		if (IS_ERR(imx6_pcie->pcie_aux))
> -			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
> -					     "pcie_aux clock source missing or invalid\n");
> -		fallthrough;
>  	case IMX7D:
>  		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
>  			imx6_pcie->controller_id = 1;
> @@ -1353,10 +1300,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
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
> @@ -1372,14 +1315,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
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
> @@ -1477,6 +1412,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
>  		.dbi_length = 0x200,
>  		.gpr = "fsl,imx6q-iomuxc-gpr",
> +		.clk_names = {"pcie_bus", "pcie", "pcie_phy"},
>  	},
>  	[IMX6SX] = {
>  		.variant = IMX6SX,
> @@ -1484,6 +1420,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE |
>  			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.gpr = "fsl,imx6q-iomuxc-gpr",
> +		.clk_names = {"pcie_bus", "pcie", "pcie_phy", "pcie_inbound_axi"},
>  	},
>  	[IMX6QP] = {
>  		.variant = IMX6QP,
> @@ -1492,40 +1429,48 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.dbi_length = 0x200,
>  		.gpr = "fsl,imx6q-iomuxc-gpr",
> +		.clk_names = {"pcie_bus", "pcie", "pcie_phy"},
>  	},
>  	[IMX7D] = {
>  		.variant = IMX7D,
>  		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.gpr = "fsl,imx7d-iomuxc-gpr",
> +		.clk_names = {"pcie_bus", "pcie", "pcie_phy"},
>  	},
>  	[IMX8MQ] = {
>  		.variant = IMX8MQ,
>  		.gpr = "fsl,imx8mq-iomuxc-gpr",
> +		.clk_names = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"},
>  	},
>  	[IMX8MM] = {
>  		.variant = IMX8MM,
>  		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.gpr = "fsl,imx8mm-iomuxc-gpr",
> +		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
>  	},
>  	[IMX8MP] = {
>  		.variant = IMX8MP,
>  		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.gpr = "fsl,imx8mp-iomuxc-gpr",
> +		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
>  	},
>  	[IMX8MQ_EP] = {
>  		.variant = IMX8MQ_EP,
>  		.mode = DW_PCIE_EP_TYPE,
>  		.gpr = "fsl,imx8mq-iomuxc-gpr",
> +		.clk_names = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"},
>  	},
>  	[IMX8MM_EP] = {
>  		.variant = IMX8MM_EP,
>  		.mode = DW_PCIE_EP_TYPE,
>  		.gpr = "fsl,imx8mm-iomuxc-gpr",
> +		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
>  	},
>  	[IMX8MP_EP] = {
>  		.variant = IMX8MP_EP,
>  		.mode = DW_PCIE_EP_TYPE,
>  		.gpr = "fsl,imx8mp-iomuxc-gpr",
> +		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
>  	},
>  };
>  
> -- 
> 2.34.1
> 
> 
> 

