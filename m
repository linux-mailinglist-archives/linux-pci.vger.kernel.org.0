Return-Path: <linux-pci+bounces-2694-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1C783FEC7
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 07:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26CBC2843CF
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 06:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C028B4D5AC;
	Mon, 29 Jan 2024 06:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="opHhLT04"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8874D5B4
	for <linux-pci@vger.kernel.org>; Mon, 29 Jan 2024 06:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706511542; cv=none; b=JT0CkxIY+s9WN7iE3BU8/nuo2d2UJl4txT8YI+l9U8fFYHkN2rHNW+nsyf3iG1evtE566bmLPGbuD+5kpy+Ty1T0ysM4DEMPHF7vPv3LllyfoDRMxf9QsW2JAdw5bmV64okkDR8po9hnANI34oJQJGHqN9sca+G2KbVJgLKY9MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706511542; c=relaxed/simple;
	bh=OXQjh4lioyfB8StO1nZmX9WLl+HFNIwwqGc1GR4QKLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgsItphQeNjV8v89i7pPluaCzUeaiDc+NQEvRJ4y82VQ4op3xtCOJAkp/aAiDZCz5n8qyP3/df9lY5gvAtpP8kgCP3tkXbHonlsx73t2cYC8NU5j7prHgzvp6fBMyP5j5ujVBrN5HKtehOn+oZzRI8vLUemlidCzH99WMQQEY/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=opHhLT04; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6818a9fe380so20363686d6.2
        for <linux-pci@vger.kernel.org>; Sun, 28 Jan 2024 22:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706511539; x=1707116339; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FwYcxzBqqOvegvaMhu9gdP9KfDlhUbugGliFvDojZT0=;
        b=opHhLT04j6jEhDUQl0KHkf/NtUUOganAu5SufZ4EcaVb+b1qeUJESAkdFv4DLoQXKf
         nGENClORkAfKnCFlaDfPbwhGyoDNk6S3CKnBqXRPDs2MnftDOVSW3Gu54rCH08NyGJnr
         o6aoTsEPfcew7aMpO/LS1OFOMIoaZJ4D+Gkb+3lsgQh4oPMw0HSXtbKi12aJuX8Mu2Ob
         0GwFpz9lJgHUOI1BrYyizJH5pThiOfwuvpRDYbumyJ8e31jQbmSgyHbwSsBYcJHPoeUq
         9PyivYDtgOk5KHMPuDV1s+e5/LLpdXJcvnO6ruYxXGbruETOcXxtJ2gxoS4N7VWWzLKy
         Kd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706511539; x=1707116339;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FwYcxzBqqOvegvaMhu9gdP9KfDlhUbugGliFvDojZT0=;
        b=bdo0wknCaitTRJpwCPJPxhPnzY37D01q7O4mSkq5l+pktooY4uKfXCXBRmXVJJFxbn
         Oh4lsu6vJ+iQbY4FCWIHTzWC94TFM/cWaIAnM1/wpGjySXcYjrtZ+bgkf7sukqoGqj8h
         RP6Pu8XIZWSjx86ol24EdIsdSCcv/4myGLjbacg/m4T+rraQljH24tvHxrz7HOyMoZtK
         4sxbhLCKMhdzo5S+FQ5DFvsPrCFqyLUXm6qaLuW3erdTeqC/cb+Gf1zTwhZOfpE7SBn8
         qN3QR3lCCse7YmuUP0lZsAgr3Qm5+YwgzehD1/HGHX5voX44hGa1Xo1GgBmdCTP9xUnf
         S87g==
X-Gm-Message-State: AOJu0Yw2S7QrcXKpS/U47PxXdSBWUFnDuA4+qT1fEYJJWc+lpMslqRoU
	J9IU275Xb/+dszf38FHnjeLPaj5x3HmLu06x/eRnFZ0fLDiGp454JtBuZkHn2w==
X-Google-Smtp-Source: AGHT+IH5SRvoNClvm0mfYs/inH/IxKkrY8a8G5cj2l07JgqvnKPSvqgPdo+o6ckTisfvK8pj9GlW0g==
X-Received: by 2002:ad4:5c47:0:b0:686:acd7:ea95 with SMTP id a7-20020ad45c47000000b00686acd7ea95mr7107306qva.71.1706511539120;
        Sun, 28 Jan 2024 22:58:59 -0800 (PST)
Received: from thinkpad ([117.193.214.109])
        by smtp.gmail.com with ESMTPSA id h4-20020a0cd804000000b006869dae6edbsm3124426qvj.77.2024.01.28.22.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 22:58:58 -0800 (PST)
Date: Mon, 29 Jan 2024 12:28:46 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, mturquette@baylibre.com,
	sboyd@kernel.org, jingoohan1@gmail.com, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
	linux@armlinux.org.uk, m.szyprowski@samsung.com,
	pankaj.dubey@samsung.com
Subject: Re: [PATCH v4 2/2] PCI: exynos: Adapt to clk_bulk_* APIs
Message-ID: <20240129065846.GD2971@thinkpad>
References: <20240124103838.32478-1-shradha.t@samsung.com>
 <CGME20240124103858epcas5p3d96cdbe8a6c8f31ccc934025411a09b8@epcas5p3.samsung.com>
 <20240124103838.32478-3-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240124103838.32478-3-shradha.t@samsung.com>

On Wed, Jan 24, 2024 at 04:08:38PM +0530, Shradha Todi wrote:
> There is no need to hardcode the clock info in the driver as driver can
> rely on the devicetree to supply the clocks required for the functioning
> of the peripheral. Get rid of the static clock info and obtain the
> platform supplied clocks. All the clocks supplied is obtained and enabled
> using the devm_clk_bulk_get_all_enable() API.
> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pci-exynos.c | 54 ++-----------------------
>  1 file changed, 4 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
> index ec5611005566..3234eb5be1fb 100644
> --- a/drivers/pci/controller/dwc/pci-exynos.c
> +++ b/drivers/pci/controller/dwc/pci-exynos.c
> @@ -54,43 +54,11 @@
>  struct exynos_pcie {
>  	struct dw_pcie			pci;
>  	void __iomem			*elbi_base;
> -	struct clk			*clk;
> -	struct clk			*bus_clk;
> +	struct clk_bulk_data		*clks;
>  	struct phy			*phy;
>  	struct regulator_bulk_data	supplies[2];
>  };
>  
> -static int exynos_pcie_init_clk_resources(struct exynos_pcie *ep)
> -{
> -	struct device *dev = ep->pci.dev;
> -	int ret;
> -
> -	ret = clk_prepare_enable(ep->clk);
> -	if (ret) {
> -		dev_err(dev, "cannot enable pcie rc clock");
> -		return ret;
> -	}
> -
> -	ret = clk_prepare_enable(ep->bus_clk);
> -	if (ret) {
> -		dev_err(dev, "cannot enable pcie bus clock");
> -		goto err_bus_clk;
> -	}
> -
> -	return 0;
> -
> -err_bus_clk:
> -	clk_disable_unprepare(ep->clk);
> -
> -	return ret;
> -}
> -
> -static void exynos_pcie_deinit_clk_resources(struct exynos_pcie *ep)
> -{
> -	clk_disable_unprepare(ep->bus_clk);
> -	clk_disable_unprepare(ep->clk);
> -}
> -
>  static void exynos_pcie_writel(void __iomem *base, u32 val, u32 reg)
>  {
>  	writel(val, base + reg);
> @@ -332,17 +300,9 @@ static int exynos_pcie_probe(struct platform_device *pdev)
>  	if (IS_ERR(ep->elbi_base))
>  		return PTR_ERR(ep->elbi_base);
>  
> -	ep->clk = devm_clk_get(dev, "pcie");
> -	if (IS_ERR(ep->clk)) {
> -		dev_err(dev, "Failed to get pcie rc clock\n");
> -		return PTR_ERR(ep->clk);
> -	}
> -
> -	ep->bus_clk = devm_clk_get(dev, "pcie_bus");
> -	if (IS_ERR(ep->bus_clk)) {
> -		dev_err(dev, "Failed to get pcie bus clock\n");
> -		return PTR_ERR(ep->bus_clk);
> -	}
> +	ret = devm_clk_bulk_get_all_enable(dev, &ep->clks);
> +	if (ret < 0)
> +		return ret;
>  
>  	ep->supplies[0].supply = "vdd18";
>  	ep->supplies[1].supply = "vdd10";
> @@ -351,10 +311,6 @@ static int exynos_pcie_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	ret = exynos_pcie_init_clk_resources(ep);
> -	if (ret)
> -		return ret;
> -
>  	ret = regulator_bulk_enable(ARRAY_SIZE(ep->supplies), ep->supplies);
>  	if (ret)
>  		return ret;
> @@ -369,7 +325,6 @@ static int exynos_pcie_probe(struct platform_device *pdev)
>  
>  fail_probe:
>  	phy_exit(ep->phy);
> -	exynos_pcie_deinit_clk_resources(ep);
>  	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
>  
>  	return ret;
> @@ -383,7 +338,6 @@ static int __exit exynos_pcie_remove(struct platform_device *pdev)
>  	exynos_pcie_assert_core_reset(ep);
>  	phy_power_off(ep->phy);
>  	phy_exit(ep->phy);
> -	exynos_pcie_deinit_clk_resources(ep);
>  	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
>  
>  	return 0;
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்

