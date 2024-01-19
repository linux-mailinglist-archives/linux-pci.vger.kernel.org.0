Return-Path: <linux-pci+bounces-2343-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E428325B7
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 09:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2777A1F21DD7
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 08:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B26C1D684;
	Fri, 19 Jan 2024 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OJ82LM7x"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602B625772
	for <linux-pci@vger.kernel.org>; Fri, 19 Jan 2024 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705652764; cv=none; b=BB90UNdcfgr2HfegpJ8yC2ORqCuvj0g6Ez2a7ShyWu5zT7dvgZq4eiJ/8W6uLOdpo1/ZrfSCjYRmFwQ5qS9wZHHZjwQ5rgPn4mvOyuklYvexRh7oG5WXydu/Qc5x3oZ4qbD4JoAdcsT+LP/o4B1NYfwo96oxzMoLNv3pC7Z94sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705652764; c=relaxed/simple;
	bh=14enbQNT425H/s7qxuMVbS/EvYQp4sjrhMrRGBV63bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8vAQKBGg29aJKJHBITbcGpK3MbkSF8O1mNBOYKo2fbx5xJf0hgeIOG7EFCDh5m3c++vfyomY8vkiIx8wsYFFw9HzLv/sNKNiGKFoPd//pJBV6N9UTuEcfQj8qdOspt0EYB+5BCHZnH1+qfBVk8EPTJI3NnQ/dNDcufWdok5Vw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OJ82LM7x; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-59502aa878aso207404eaf.1
        for <linux-pci@vger.kernel.org>; Fri, 19 Jan 2024 00:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705652761; x=1706257561; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KkWXmKH0r8EujnkQjuJIPEC6n7Ky9X3nKqyBzdmGTX4=;
        b=OJ82LM7xlE8pkOUcXBrRuBZ98DpqOqIe7Vd3yjwutEO9uJwutgmIFDIjGhmgDLyQma
         zMkhmsu36uZH+Q5+4QDBUWIYNXXP8T8A9vonVB5+rKp6njgVPjJVJtXeqNaESl7q8FHC
         NkLpVRXBCFVeDG5ebYdd59KHGQHVq1PA4jnTnrxXEurWso4a5pF2oYjtYycqvS57dsIe
         BJcVKbO4WB7oiM9GjNxpTvYfr+RbliJH7I5vwic9nKKsQW5djxnOuzzVmfvsnW2qlZhp
         wCe4r+LDuIX34/+ATvnYUxEB5lpE28N+qHpIWsRlB8KRkMM2dJS5O/fW3JszEaoKT+S4
         wvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705652761; x=1706257561;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KkWXmKH0r8EujnkQjuJIPEC6n7Ky9X3nKqyBzdmGTX4=;
        b=G9AqKDI2LyEqGFDvGYYVjHqTh3IPtAORiW2g2yISN0nKINIKaUw5nZPeODUU/OJPKj
         MFDecgdID3i55JcYeBj3q+oFe2hv06W8k7HMugJLBu2/GCqqP79g57Yv0N57GC2kNkoL
         HEz9HY3ghdPyuUzqTaT7jiyLCj2DBczU3osQs2lmZmt9aMOK/pU22JI+lYXuzyAhSfog
         oaX1QE5LDTaXsiL7nHAFl/yzq206NXY4YF0m9vxirHRLxrREyWUkIDc86+i77E9MZVLE
         lxREvhO73saUyD+xZv4PTIFrE29obpyCXDu9FWdcm01dMuEXWPu7glIQFt1jHxw7Nv8x
         CtgA==
X-Gm-Message-State: AOJu0YyaixqfQ0hvN8cv5VjOj+nu5gEZIgY4/XQtyDF/FPXIYhzYm2cZ
	r9vIFYnixO3fJvRgiLz+auW+LLBKfRR97Fq47P+vQz3JQa3m+qUkYM0nOXR7fg==
X-Google-Smtp-Source: AGHT+IH4zHVhjf2dGBDi9fXZGMfVXKS+wYAhsQnF5CU4QOXjKDKMimg65NlxwYiYaoOMd3gXW0pP8w==
X-Received: by 2002:a05:6359:3511:b0:175:bfae:a564 with SMTP id un17-20020a056359351100b00175bfaea564mr1866729rwb.38.1705652761382;
        Fri, 19 Jan 2024 00:26:01 -0800 (PST)
Received: from thinkpad ([117.248.2.56])
        by smtp.gmail.com with ESMTPSA id p27-20020a056a0026db00b006dbad3a1b84sm2346449pfw.190.2024.01.19.00.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 00:26:00 -0800 (PST)
Date: Fri, 19 Jan 2024 13:55:52 +0530
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
Subject: Re: [PATCH v8 08/16] PCI: imx6: Simplify switch-case logic by
 involve init_phy callback
Message-ID: <20240119082552.GG2866@thinkpad>
References: <20240108232145.2116455-1-Frank.Li@nxp.com>
 <20240108232145.2116455-9-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240108232145.2116455-9-Frank.Li@nxp.com>

On Mon, Jan 08, 2024 at 06:21:37PM -0500, Frank Li wrote:
> Simplify switch-case logic by involve init_phy callback.
> 

"Instead of using the switch case statement to initialize the PHY handled by
this driver itself, let's introduce a new callback init_phy() and define it for
platforms that require it. This simplifies the code."

> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> 
> Notes:
>     Change from v7 to v8:
>     - rework commit message
>     - wrap comments to 100 chars
>     - return 0 at imx7d_pcie_init_phy()
>     
>     change from v1 to v4:
>     - none
> 
>  drivers/pci/controller/dwc/pci-imx6.c | 134 +++++++++++++-------------
>  1 file changed, 69 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index fd83af238fa60..ac338a88fe21e 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -69,6 +69,9 @@ enum imx6_pcie_variants {
>  #define IMX6_PCIE_MAX_CLKS       6
>  
>  #define IMX6_PCIE_MAX_INSTANCES			2
> +
> +struct imx6_pcie;
> +
>  struct imx6_pcie_drvdata {
>  	enum imx6_pcie_variants variant;
>  	enum dw_pcie_device_mode mode;
> @@ -81,6 +84,7 @@ struct imx6_pcie_drvdata {
>  	const u32 ltssm_mask;
>  	const u32 mode_off[IMX6_PCIE_MAX_INSTANCES];
>  	const u32 mode_mask[IMX6_PCIE_MAX_INSTANCES];
> +	int (*init_phy)(struct imx6_pcie *pcie);
>  };
>  
>  struct imx6_pcie {
> @@ -322,76 +326,66 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
>  	return 0;
>  }
>  
> -static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
> +static int imx8mq_pcie_init_phy(struct imx6_pcie *imx6_pcie)
>  {
> -	switch (imx6_pcie->drvdata->variant) {
> -	case IMX8MM:
> -	case IMX8MM_EP:
> -	case IMX8MP:
> -	case IMX8MP_EP:
> -		/*
> -		 * The PHY initialization had been done in the PHY
> -		 * driver, break here directly.
> -		 */
> -		break;
> -	case IMX8MQ:
> -	case IMX8MQ_EP:
> -		/*
> -		 * TODO: Currently this code assumes external
> -		 * oscillator is being used
> -		 */
> +	/* TODO: Currently this code assumes external oscillator is being used */
> +	regmap_update_bits(imx6_pcie->iomuxc_gpr,
> +			   imx6_pcie_grp_offset(imx6_pcie),
> +			   IMX8MQ_GPR_PCIE_REF_USE_PAD,
> +			   IMX8MQ_GPR_PCIE_REF_USE_PAD);
> +	/*
> +	 * Regarding the datasheet, the PCIE_VPH is suggested to be 1.8V. If the PCIE_VPH is
> +	 * supplied by 3.3V, the VREG_BYPASS should be cleared to zero.
> +	 */
> +	if (imx6_pcie->vph && regulator_get_voltage(imx6_pcie->vph) > 3000000)
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr,
>  				   imx6_pcie_grp_offset(imx6_pcie),
> -				   IMX8MQ_GPR_PCIE_REF_USE_PAD,
> -				   IMX8MQ_GPR_PCIE_REF_USE_PAD);
> -		/*
> -		 * Regarding the datasheet, the PCIE_VPH is suggested
> -		 * to be 1.8V. If the PCIE_VPH is supplied by 3.3V, the
> -		 * VREG_BYPASS should be cleared to zero.
> -		 */
> -		if (imx6_pcie->vph &&
> -		    regulator_get_voltage(imx6_pcie->vph) > 3000000)
> -			regmap_update_bits(imx6_pcie->iomuxc_gpr,
> -					   imx6_pcie_grp_offset(imx6_pcie),
> -					   IMX8MQ_GPR_PCIE_VREG_BYPASS,
> -					   0);
> -		break;
> -	case IMX7D:
> -		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
> -		break;
> -	case IMX6SX:
> -		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -				   IMX6SX_GPR12_PCIE_RX_EQ_MASK,
> -				   IMX6SX_GPR12_PCIE_RX_EQ_2);
> -		fallthrough;
> -	default:
> -		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +				   IMX8MQ_GPR_PCIE_VREG_BYPASS,
> +				   0);
> +
> +	return 0;
> +}
> +
> +static int imx7d_pcie_init_phy(struct imx6_pcie *imx6_pcie)
> +{
> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
> +
> +	return 0;
> +}
> +
> +static int imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
> +{
> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
>  				   IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
>  
> -		/* configure constant input signal to the pcie ctrl and phy */
> -		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -				   IMX6Q_GPR12_LOS_LEVEL, 9 << 4);
> -
> -		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
> -				   IMX6Q_GPR8_TX_DEEMPH_GEN1,
> -				   imx6_pcie->tx_deemph_gen1 << 0);
> -		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
> -				   IMX6Q_GPR8_TX_DEEMPH_GEN2_3P5DB,
> -				   imx6_pcie->tx_deemph_gen2_3p5db << 6);
> -		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
> -				   IMX6Q_GPR8_TX_DEEMPH_GEN2_6DB,
> -				   imx6_pcie->tx_deemph_gen2_6db << 12);
> -		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
> -				   IMX6Q_GPR8_TX_SWING_FULL,
> -				   imx6_pcie->tx_swing_full << 18);
> -		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
> -				   IMX6Q_GPR8_TX_SWING_LOW,
> -				   imx6_pcie->tx_swing_low << 25);
> -		break;
> -	}
> +	/* configure constant input signal to the pcie ctrl and phy */
> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +			   IMX6Q_GPR12_LOS_LEVEL, 9 << 4);
> +
> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
> +			   IMX6Q_GPR8_TX_DEEMPH_GEN1,
> +			   imx6_pcie->tx_deemph_gen1 << 0);
> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
> +			   IMX6Q_GPR8_TX_DEEMPH_GEN2_3P5DB,
> +			   imx6_pcie->tx_deemph_gen2_3p5db << 6);
> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
> +			   IMX6Q_GPR8_TX_DEEMPH_GEN2_6DB,
> +			   imx6_pcie->tx_deemph_gen2_6db << 12);
> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
> +			   IMX6Q_GPR8_TX_SWING_FULL,
> +			   imx6_pcie->tx_swing_full << 18);
> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
> +			   IMX6Q_GPR8_TX_SWING_LOW,
> +			   imx6_pcie->tx_swing_low << 25);
> +	return 0;
> +}
>  
> -	imx6_pcie_configure_type(imx6_pcie);
> +static int imx6sx_pcie_init_phy(struct imx6_pcie *imx6_pcie)
> +{
> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +			   IMX6SX_GPR12_PCIE_RX_EQ_MASK, IMX6SX_GPR12_PCIE_RX_EQ_2);
> +
> +	return imx6_pcie_init_phy(imx6_pcie);
>  }
>  
>  static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
> @@ -902,7 +896,11 @@ static int imx6_pcie_host_init(struct dw_pcie_rp *pp)
>  	}
>  
>  	imx6_pcie_assert_core_reset(imx6_pcie);
> -	imx6_pcie_init_phy(imx6_pcie);
> +
> +	if (imx6_pcie->drvdata->init_phy)
> +		imx6_pcie->drvdata->init_phy(imx6_pcie);
> +
> +	imx6_pcie_configure_type(imx6_pcie);
>  
>  	ret = imx6_pcie_clk_enable(imx6_pcie);
>  	if (ret) {
> @@ -1386,6 +1384,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
>  		.mode_off[0] = IOMUXC_GPR12,
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> +		.init_phy = imx6_pcie_init_phy,
>  	},
>  	[IMX6SX] = {
>  		.variant = IMX6SX,
> @@ -1399,6 +1398,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
>  		.mode_off[0] = IOMUXC_GPR12,
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> +		.init_phy = imx6sx_pcie_init_phy,
>  	},
>  	[IMX6QP] = {
>  		.variant = IMX6QP,
> @@ -1413,6 +1413,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
>  		.mode_off[0] = IOMUXC_GPR12,
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> +		.init_phy = imx6_pcie_init_phy,
>  	},
>  	[IMX7D] = {
>  		.variant = IMX7D,
> @@ -1424,6 +1425,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  		.clks_cnt = ARRAY_SIZE(imx6_3clks_bus_pcie_phy),
>  		.mode_off[0] = IOMUXC_GPR12,
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> +		.init_phy = imx7d_pcie_init_phy,
>  	},
>  	[IMX8MQ] = {
>  		.variant = IMX8MQ,
> @@ -1436,6 +1438,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.mode_off[1] = IOMUXC_GPR12,
>  		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
> +		.init_phy = imx8mq_pcie_init_phy,
>  	},
>  	[IMX8MM] = {
>  		.variant = IMX8MM,
> @@ -1471,6 +1474,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.mode_off[1] = IOMUXC_GPR12,
>  		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
> +		.init_phy = imx8mq_pcie_init_phy,
>  	},
>  	[IMX8MM_EP] = {
>  		.variant = IMX8MM_EP,
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

