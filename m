Return-Path: <linux-pci+bounces-16821-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7479CD8CD
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 07:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805201F23423
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 06:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EE5188713;
	Fri, 15 Nov 2024 06:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bB7zh8A+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0AB187848
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 06:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653665; cv=none; b=LnES/LKJwV7HXoUY5upslD0XsAdCqoP4B9vK8WcHf9fs8WWmEIbcTI9SxAqVESq/KovDjyS2EQHMSfLVJrytgH8nXRLm4PJ8FMRlJpS+xnnEWiU5eDbAvz0ChzupOXCqmaf610ikYXliLeN2g//J4qz350T0HzaZ81zd36NdYng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653665; c=relaxed/simple;
	bh=x/2VSAbk+bd/qDKumw5Nythdu6G/pN92DH/s7nEgFDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+m4OUA12DzVVWiVUps/HBclsL+7q5dg4spXpY6Q2GHrXuyrG/HEod2K8QWw33lIghGXqwdTFLMpkwONRBu40MQzeDSSUn1utRsb3oq85CJncClShNNisBw6pspjyJm4Z3JWU+6jvcK6ULY1bUYx5Q38Ef6qwzg0HVz/fWyO/sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bB7zh8A+; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-295e9b63d6bso816396fac.0
        for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 22:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731653663; x=1732258463; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VpIhQ9mb9ycFkMd8PQ/S0ZDiIrP7seI2TZz9r3I3eW0=;
        b=bB7zh8A+4YNHlnJRWHl0AdwOyZLUqD7YAhPZs0D85RbtFhEJMiGiPiL9aj+pd5igsA
         8yLgjwev/I9f//Pw4ncgEL+FDHxn6igllRoeiDgJ4yy6EdpqyCsT9znBq5d+rRV+Q3qB
         BrfVQ1T6bbH1nhxEha4jzzNYgIw7W9+kLhPpRskE1kRHoI9r7VHTlcDwAaLN0/+GA2Os
         B22qix1W796c+ZF+XCd3/PpijbV2EqgNkXdbGaalzq6EIk/RUVxIYZb2fhdSvvhbs+92
         uTO2bTffO2jUJuhphPhaHpbQoKxnvacA85Sw2FF92nvYw9EUhMXP29QmJNl8+FMMCeYO
         pFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731653663; x=1732258463;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VpIhQ9mb9ycFkMd8PQ/S0ZDiIrP7seI2TZz9r3I3eW0=;
        b=ScFZsF+khUofSJny/0uusWTFz1CI29ClRBeUkhONSsqC31JZlIi0FP+8IFIfX4iFIh
         Y/UwuqV/8Kv69yZYjg7I059DZDDdbh1sUBnApozgM/hW0OOwPCTrvLdFK9myNZ9Vhofj
         p4i27gbhcpcofZGX2iUP5o8KjRkyJMeNm8VOFLFqgXSDRpDv9M/+ROKHSJq9GYolShy9
         UncMMQmnDqRcJPWzAxRctsocpCvih8SCn8Kd3aePTrPixFd6iIx1JN8s9DX232PWZacb
         I2oj5Mnb5qESlfZUT67m49MFt/19hg06SFmuOHFmSfPD61Lr8lcPQuggJA9JvYgzPPgN
         REEg==
X-Forwarded-Encrypted: i=1; AJvYcCUpNQQVoBkzI8AsFspNztRQeyOywlMeHkG8KN/47SW3yvaRJ7hyjHvsFvTonX/ffmKsh2DtjiwnOTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqHBNRXfJvZ73IvhH3+fUeM0NGr+TKEtcz4DhobU5SPlGXBCDa
	6IUPygjBYfs85leiKHd+1pT2QNpsacAzExlF8kZMGGMC7++iZZUxKA/cgKZfvA==
X-Google-Smtp-Source: AGHT+IGA2wP5EZO//DczjdnLKwXL89OrzkosGXPzS/O5S6Z8HF8QEOaPag4uwMWdG7hB0NyuZCDjFw==
X-Received: by 2002:a05:6871:691:b0:270:27e6:6f1a with SMTP id 586e51a60fabf-2962e2a0d04mr1279132fac.41.1731653662715;
        Thu, 14 Nov 2024 22:54:22 -0800 (PST)
Received: from thinkpad ([117.193.208.47])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1c3224asm650735a12.29.2024.11.14.22.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 22:54:22 -0800 (PST)
Date: Fri, 15 Nov 2024 12:24:12 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, frank.li@nxp.com,
	s.hauer@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev,
	kernel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 06/10] PCI: imx6: Fix the missing reference clock
 disable logic
Message-ID: <20241115065412.l2r5vmqaw3ufcjo3@thinkpad>
References: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
 <20241101070610.1267391-7-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241101070610.1267391-7-hongxing.zhu@nxp.com>

On Fri, Nov 01, 2024 at 03:06:06PM +0800, Richard Zhu wrote:
> Ensure the *_enable_ref_clk() function is symmetric by addressing missing
> disable parts on some platforms.
> 
> Fixes: d0a75c791f98 ("PCI: imx6: Factor out ref clock disable to match enable")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 54039d2760d5..bb130c84c016 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -595,10 +595,9 @@ static int imx_pcie_attach_pd(struct device *dev)
>  
>  static int imx6sx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
>  {
> -	if (enable)
> -		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -				  IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
> -
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +			   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
> +			   enable ? 0 : IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
>  	return 0;
>  }
>  
> @@ -627,19 +626,20 @@ static int imx8mm_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
>  {
>  	int offset = imx_pcie_grp_offset(imx_pcie);
>  
> -	if (enable) {
> -		regmap_clear_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE);
> -		regmap_set_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
> -	}
> -
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
> +			   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE,
> +			   enable ? 0 : IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE);
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
> +			   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
> +			   enable ? IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN : 0);
>  	return 0;
>  }
>  
>  static int imx7d_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
>  {
> -	if (!enable)
> -		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -				IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +			   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> +			   enable ? 0 : IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
>  	return 0;
>  }
>  
> -- 
> 2.37.1
> 

-- 
மணிவண்ணன் சதாசிவம்

