Return-Path: <linux-pci+bounces-11405-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E53949DF1
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 04:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 634321F22E52
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 02:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C90017AE0E;
	Wed,  7 Aug 2024 02:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TCqXbPeT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C04E372
	for <linux-pci@vger.kernel.org>; Wed,  7 Aug 2024 02:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722999189; cv=none; b=EoSFDDvlxkLz0n3o7QuN+oGcwfKdr1n/DBbRAg8L3+p2dwyWFn992arRK2cTZhDTUaKAtaJDgh99BBx0/DdoVLDpagnWyAs0/pHQMDkglQd2ILnb1dTBz3v916MDoAM+9iT+bE/cmfbpnCvQ0Bf8miD48/LaRBcj/0S+x86q7Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722999189; c=relaxed/simple;
	bh=Vs+yRqnsnTYiBhgxijbw0m5004WaG/JwP8yyfpt0My4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPOBexmlNDNTmIzkPDe9A6qLn6ztmxQBQyfL96lJ2NaVHShBsHlG7qsXI3TL2PnPjQX/wLb6MhNikRblb46clH5ZtEmF0PtcTt5tfy7Yh58oKC8FgEQJEZZ/uI0bZQwq6933bbkIJXOAF8p1cHi/7EOnRsHKg2R1fGTn1lLo5+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TCqXbPeT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc692abba4so13442475ad.2
        for <linux-pci@vger.kernel.org>; Tue, 06 Aug 2024 19:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722999186; x=1723603986; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rxNTPURWQk7/dc/jj+R3PwdiQ6MWMSIu7JR1EjXWtLw=;
        b=TCqXbPeTj9OLeJ6lF25Fzk4nAwCiIntKF+KYUaS0fvUKJjzFVzDFu02e5sXLfR1Att
         MUHLt235TFs8kZSpu0cVNqy4OrYoDJVESvr4zfQ2sqvuhxIAuV/caDgnet0GbwHcQBmt
         aoAZd0pV3w0VikEiznvXlnl0jRh+guvcf4rD+nXsqWznlJA1950TGPcNErIuk3AV3NuI
         IgLxJ0nGRhb+vyXcBqE7UtBC7sytWG2lwputkKBSwxW5EY08nCZ/pcUQSkuicoygkNCQ
         w1VCmAVFDNGEqqBLEEZNJkVh9LgOQI12P/ULph/Hrm+aX/B2vgid5ovPeQ3l8jLB9rcY
         IHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722999186; x=1723603986;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rxNTPURWQk7/dc/jj+R3PwdiQ6MWMSIu7JR1EjXWtLw=;
        b=U8y+KITtzOLnEP0DtDozoM4xHT4G/5imI1DoX+Z7oYQcLNp97oF6WzwTNf1L5L7Y43
         OpP59uIqK9m2URtVY4w0f7idBp1H+Fl9G5S4z4g1QSdFLtJX5AiZ2C84Uin970km2IKc
         JHxeUV0qZq+frIEHJbj5zZq4MlKYn6ykje4oUtDUusU8lH/MEJcOokmyRoHZlz31LPZy
         ZyPfxlkAQtvqHLgWdxAjcF2st3Za+EVLF5vo1sxnF5XH10iF5wI5Y22Ew1lEtyiL8tut
         ESQzjz8u4faTq0Hy2rgxgGV95GatFkV5ajWY9v3cAXiBgPu+6ftlSUT6tWl9lwDrXc9k
         fy4A==
X-Gm-Message-State: AOJu0YxoL0A0jiQeUp28H3f0qaaQDyCZTFs9iUf9ybJqoeJuPP1VCOTp
	0gHA5RpLersqW21Ka77dB03ZRwtP34baPN4SxhHfLMcN7w8AVt3zGzcEjKwPyg==
X-Google-Smtp-Source: AGHT+IExm1nyHNpY2Df0ueTbO0F5rX3vC1NzqDjMXBn0ObX2Q18HN9I7GSRRDFbcDAWCC26CjfW4JQ==
X-Received: by 2002:a17:902:e802:b0:1fb:5c3d:b8c3 with SMTP id d9443c01a7336-1ff57262fa6mr180863515ad.4.1722999185616;
        Tue, 06 Aug 2024 19:53:05 -0700 (PDT)
Received: from thinkpad ([120.60.72.69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5929abd1sm94465395ad.271.2024.08.06.19.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 19:53:05 -0700 (PDT)
Date: Wed, 7 Aug 2024 08:22:52 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 03/12] PCI: brcmstb: Use common error handling code in
 brcm_pcie_probe()
Message-ID: <20240807025252.GE3412@thinkpad>
References: <20240731222831.14895-1-james.quinlan@broadcom.com>
 <20240731222831.14895-4-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240731222831.14895-4-james.quinlan@broadcom.com>

On Wed, Jul 31, 2024 at 06:28:17PM -0400, Jim Quinlan wrote:
> o Move the clk_prepare_enable() below the resource allocations.
> o Move the clk_prepare_enable() out of __brcm_pcie_remove() but
>   add it to the end of brcm_pcie_remove().
> o Add a jump target (clk_disable_unprepare) so that a bit of exception
>   handling can be better reused at the end of this function implementation.
> o Use dev_err_probe() where it makes sense.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 34 ++++++++++++---------------
>  1 file changed, 15 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index c08683febdd4..7595e7009192 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1473,7 +1473,6 @@ static void __brcm_pcie_remove(struct brcm_pcie *pcie)
>  		dev_err(pcie->dev, "Could not stop phy\n");
>  	if (reset_control_rearm(pcie->rescal))
>  		dev_err(pcie->dev, "Could not rearm rescal reset\n");
> -	clk_disable_unprepare(pcie->clk);
>  }
>  
>  static void brcm_pcie_remove(struct platform_device *pdev)
> @@ -1484,6 +1483,7 @@ static void brcm_pcie_remove(struct platform_device *pdev)
>  	pci_stop_root_bus(bridge->bus);
>  	pci_remove_root_bus(bridge->bus);
>  	__brcm_pcie_remove(pcie);
> +	clk_disable_unprepare(pcie->clk);
>  }
>  
>  static const int pcie_offsets[] = {
> @@ -1613,31 +1613,26 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  
>  	pcie->ssc = of_property_read_bool(np, "brcm,enable-ssc");
>  
> -	ret = clk_prepare_enable(pcie->clk);
> -	if (ret) {
> -		dev_err(&pdev->dev, "could not enable clock\n");
> -		return ret;
> -	}
>  	pcie->rescal = devm_reset_control_get_optional_shared(&pdev->dev, "rescal");
> -	if (IS_ERR(pcie->rescal)) {
> -		clk_disable_unprepare(pcie->clk);
> +	if (IS_ERR(pcie->rescal))
>  		return PTR_ERR(pcie->rescal);
> -	}
> +
>  	pcie->perst_reset = devm_reset_control_get_optional_exclusive(&pdev->dev, "perst");
> -	if (IS_ERR(pcie->perst_reset)) {
> -		clk_disable_unprepare(pcie->clk);
> +	if (IS_ERR(pcie->perst_reset))
>  		return PTR_ERR(pcie->perst_reset);
> -	}
>  
> -	ret = reset_control_reset(pcie->rescal);
> +	ret = clk_prepare_enable(pcie->clk);
>  	if (ret)
> -		dev_err(&pdev->dev, "failed to deassert 'rescal'\n");
> +		return dev_err_probe(&pdev->dev, ret, "could not enable clock\n");
> +
> +	ret = reset_control_reset(pcie->rescal);
> +	if (dev_err_probe(&pdev->dev, ret, "failed to deassert 'rescal'\n"))
> +		goto clk_disable_unprepare;
>  
>  	ret = brcm_phy_start(pcie);
>  	if (ret) {
>  		reset_control_rearm(pcie->rescal);
> -		clk_disable_unprepare(pcie->clk);
> -		return ret;
> +		goto clk_disable_unprepare;
>  	}
>  
>  	ret = brcm_pcie_setup(pcie);
> @@ -1654,10 +1649,8 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  	msi_np = of_parse_phandle(pcie->np, "msi-parent", 0);
>  	if (pci_msi_enabled() && msi_np == pcie->np) {
>  		ret = brcm_pcie_enable_msi(pcie);
> -		if (ret) {
> -			dev_err(pcie->dev, "probe of internal MSI failed");
> +		if (dev_err_probe(pcie->dev, ret, "probe of internal MSI failed"))
>  			goto fail;
> -		}
>  	}
>  
>  	bridge->ops = pcie->type == BCM7425 ? &brcm7425_pcie_ops : &brcm_pcie_ops;
> @@ -1678,6 +1671,9 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  
>  fail:
>  	__brcm_pcie_remove(pcie);
> +clk_disable_unprepare:
> +	clk_disable_unprepare(pcie->clk);
> +

TBH, this is not improving the code readability. __brcm_pcie_remove() used to
free all the resources and now you just moved clk_disable_unprepare() out of it
to save 2 lines in probe(). And you ended up calling clk_disable_unprepare()
separately in brcm_pcie_remove().

So please remove the label and call clk_disable_unprepare() in the error path
(just 2 instances) and continue to use __brcm_pcie_remove() to free all
resources (I would've preferred to have separate error labels instead of calling
__brcm_pcie_remove() though, but not this).

- Mani

-- 
மணிவண்ணன் சதாசிவம்

