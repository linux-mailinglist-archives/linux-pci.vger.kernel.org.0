Return-Path: <linux-pci+bounces-1736-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29281826022
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jan 2024 16:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77556B23074
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jan 2024 15:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710D579F9;
	Sat,  6 Jan 2024 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SLJfWpJz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E7F79EC
	for <linux-pci@vger.kernel.org>; Sat,  6 Jan 2024 15:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6d9f94b9186so457735b3a.0
        for <linux-pci@vger.kernel.org>; Sat, 06 Jan 2024 07:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704554835; x=1705159635; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IGnHddRRR39bPJdc9yil/sTAP9OrR9P0NakHbvwB6io=;
        b=SLJfWpJznVa0++wPNDikZLZp1dla1dz4Fu3o1dxYkCkQltn6N4bOl8oxM4LSI93cx2
         PifnN0IADQwkO7LEsGxcCJnN8LGBV81WaM8oJOcPLtXPHgPRhbH925AMtfCq40f8+H52
         NThHWUWG9pB3x74kaN1wl/nxdVtADW1ENP9u3uYTXgXEpNYPQeSDHttZe6+K4SOEhYN0
         fwpjmGV+PeX5woNE5SmxOxS+XUuw0BKVuG03bTGoFulLq6I/TT9bf+ceGR75mnwIo38S
         em65eMJGrl7NlCIh3ehLiJGeMQtMC81KCpPRuwm9sH/etERIJEeUmASVHu1F1d/NODNj
         +cQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704554835; x=1705159635;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IGnHddRRR39bPJdc9yil/sTAP9OrR9P0NakHbvwB6io=;
        b=GfaY5xKdwc+KwTFQJlYq8E9iemeDJqeqLi22V9a1N+vDFM83+yepsRKBho0IC/cY2J
         Kb2i/iYo75eSK0zkhgd5O3jylp369JJurFOQullNIewEzKfGr/g2oUIe5BXx4D86/bG6
         BqH7aeoX5vDr2JetJkWRmNehWgCUZVnKexiRg/aNz48fNR6qidIMVXESFjryX5uPWNjH
         7ol7RNcgN99Tf7azH0TQcxnD1TU57iv8bFMJ6DThfgufwByYtiOhvOW49iwWHjmTUGXa
         OsKIbt8Lt6JvUQO/d04eCFWm4YttiM0bVtMoT8W3f9kBCs+x5fp1vDXpb2LR2TjrcTtv
         AQUA==
X-Gm-Message-State: AOJu0YzJYIwxd+bJ0058FyqEPF+kRI+0HTlWp6DDEtGR2z1ywAdudzXj
	MTKWsiQfCmfNr2E0+nl9NYwX0ciezh7P
X-Google-Smtp-Source: AGHT+IG6/ogh81hP2GuC/tJj4VtpQbaF24F7gXWXt/dWAVTZ98B31mEVpIdxzv2ekE28yV9KXpz+9Q==
X-Received: by 2002:a05:6a20:12c6:b0:199:2927:45 with SMTP id v6-20020a056a2012c600b0019929270045mr1215916pzg.101.1704554835437;
        Sat, 06 Jan 2024 07:27:15 -0800 (PST)
Received: from thinkpad ([103.197.115.97])
        by smtp.gmail.com with ESMTPSA id o23-20020a056a001b5700b006cecaff9e29sm3202904pfv.128.2024.01.06.07.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 07:27:15 -0800 (PST)
Date: Sat, 6 Jan 2024 20:57:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: krzysztof.kozlowski@linaro.org, bhelgaas@google.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
	helgaas@kernel.org, hongxing.zhu@nxp.com, imx@lists.linux.dev,
	kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
	kw@linux.com, l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, robh@kernel.org, s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: Re: [PATCH v7 01/16] PCI: imx6: Simplify clock handling by using
 bulk_clk_*() function
Message-ID: <20240106152708.GD2512@thinkpad>
References: <20231227182727.1747435-1-Frank.Li@nxp.com>
 <20231227182727.1747435-2-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231227182727.1747435-2-Frank.Li@nxp.com>

On Wed, Dec 27, 2023 at 01:27:12PM -0500, Frank Li wrote:

Subject mentions, 'bulk_clk' APIs but there is no such thing. It should be
'clk_bulk()' APIs.

> Refactors the clock handling logic. Adds clk_names[] define in drvdata.
> Using clk_bulk*() api simplifies the code.
> 

I've mentioned this many times in the past. But let me reiterate here again:

Commit message should be in imperative mood as per Linux Kernel rules for
submitting patches. Please see here:
Documentation/process/submitting-patches.rst

The relevant part is:

"Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
to do frotz", as if you are giving orders to the codebase to change
its behaviour."

Please use this same format for rest of the patches as well for future ones.

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

Extra space after =

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

Why can't you initialize i to 0 directly?

Rest looks good to me.

- Mani

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

-- 
மணிவண்ணன் சதாசிவம்

