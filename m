Return-Path: <linux-pci+bounces-4124-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BB286908E
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 13:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 746C51C22E85
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 12:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77A613A88A;
	Tue, 27 Feb 2024 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hu1nXtT6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C3113AA2A
	for <linux-pci@vger.kernel.org>; Tue, 27 Feb 2024 12:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036919; cv=none; b=FsNbMFDTzQly9ba4f4aUd7LauSNsPV78Yv1/rKBSyt8CJoD169Rs8S3a2W/LLHoIQFeLcbDc6hNY2QBcU/7J87uxnbrSoyCj/tLXPAg7wiHyAMvTxhtwb+acC20kAA0FIAiZXuUgdUv9d8FTFOVIR3ujomZnH2oegmzKkkMgFMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036919; c=relaxed/simple;
	bh=btPvxEtNQMZXHXCkW3iVq+IGImCWfopExTpHhLNJhxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMSIQ7gGKIxLXgOezpyrwZ+RnUZF6zrnm8M+/nzqmOUm7Y2QwGwgXb96fdkbDLhrisRDgu6tup0t5U46DF5D2kVEXC903667Oix93Ti9SmIJrPCbMoJwclFgv+W+SpoFmH9DywyWf9WPlZRIoa6pFjivAdle8YOORXchTt99IOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hu1nXtT6; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5129cdae3c6so5367571e87.1
        for <linux-pci@vger.kernel.org>; Tue, 27 Feb 2024 04:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709036916; x=1709641716; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FHY/81rtpLypB+r9zCeqoeJnUswfp/HHFeOatBG7+Uw=;
        b=hu1nXtT6pA3nOMOU5Ie4XEH1myM6jaFqkLHs7/0mKZjq5UiOjMBubrAAprap03SNrk
         C0L3kTE4+3trIdptRPbISPWDY0fxEElcx6aDxhL95QpBaXZ3nXaHWVI3Ub+7KVIOpI/X
         TskIssSksStSVFfbhe2wW9EAl8bVf8Qz3a8W3fcxh0lajazZ1wLKSgvurictgL0ujAP7
         MUSg7WUvpceXsdFTyfwdcoR64E6CKQsFxUY9QgvUjIwfQrCFymwGD7AG6PyKpdSTBaFN
         yOKNcra5joSGF0FHjVHARyNNkTUglLYG7pLCsQ5RT/24L0YdH6L1QsHwWwr9dP30fLGl
         hKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709036916; x=1709641716;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FHY/81rtpLypB+r9zCeqoeJnUswfp/HHFeOatBG7+Uw=;
        b=E2RAdzKsNbJyntGUdrBbaIO2cnMCLIV2kNAqcACI1K+rKmNxWxqjdqqT31bIe1ABJq
         3tsTL32Pl4SUwNiu4UKfsGnMysqCWlhlGKOnWdekm24ro8QU35G1hf2bQZ1rzs2lHDa1
         3qJPaJNM7VU3NcUl8cKMSwwMXshzD9DA1+6X+rM5CUc91WvouGMsUYRpEM774L6QO9w6
         mO4aT5QQ8/2+pDnz2RImfjp7ME8IAsO+M6VSjufpetJXIQ7z6h6Kgi3l6m4v/wJ8Knxn
         1oIHRE5+uV2u1HbdJhu+g/fWRdxm+wYm81956LwJQxa/TN43XOi+l9eRh6cVTSit1IXX
         a8WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj34n4FombNemvVjH/9VA0EZd3bMKX6sFvH6IIu9AvWl5J5yO5I83GTMbY08y1FAnL96nHw80775iInAoMc5xC8x142fAm2X8+
X-Gm-Message-State: AOJu0YyQT9AsbsbgPTp3AB7+Sybm29q4P4tytRUYKMge9jhvJOJguanN
	zHTHGq5fOHfU1cBAw5CgG+n7fbCFdtw7du6qwn9JEr8BXujVlohT
X-Google-Smtp-Source: AGHT+IFi1NfRtwzpzbUtPjPYsIEDay1aMMDdth4HOv3+lyyyS97y08UpyZ9Ke2GISBMzGnqhbMWz0Q==
X-Received: by 2002:a05:6512:108f:b0:512:b696:e312 with SMTP id j15-20020a056512108f00b00512b696e312mr7169790lfg.46.1709036915841;
        Tue, 27 Feb 2024 04:28:35 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id i18-20020a056512319200b005130479a912sm231483lfe.68.2024.02.27.04.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 04:28:35 -0800 (PST)
Date: Tue, 27 Feb 2024 15:28:32 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@debian.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Lei Chuanhua <lchuanhua@maxlinear.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jesper Nilsson <jesper.nilsson@axis.com>, 
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: dw-rockchip: Add error messages in .probe()s error
 paths
Message-ID: <6dyzzqaqqx6k46rujeo52od7xgemvdbe7n5qzg647exdo6w7xc@4luaoc6qqd6a>
References: <20240227111837.395422-2-ukleinek@debian.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240227111837.395422-2-ukleinek@debian.org>

On Tue, Feb 27, 2024 at 12:18:35PM +0100, Uwe Kleine-König wrote:
> Drivers that silently fail to probe provide a bad user experience and
> make it unnecessarily hard to debug such a failure. Fix it by using
> dev_err_probe() instead of a plain return.
> 
> Signed-off-by: Uwe Kleine-König <ukleinek@debian.org>
> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 23 ++++++++++++-------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index d6842141d384..4c16d8d2e178 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -225,11 +225,17 @@ static int rockchip_pcie_clk_init(struct rockchip_pcie *rockchip)
>  
>  	ret = devm_clk_bulk_get_all(dev, &rockchip->clks);
>  	if (ret < 0)
> -		return ret;
> +		return dev_err_probe(rockchip->pci.dev, ret,
> +				     "failed to get clocks\n");

+		return dev_err_probe(dev, ret, "failed to get clocks\n");

>  
>  	rockchip->clk_cnt = ret;
>  
> -	return clk_bulk_prepare_enable(rockchip->clk_cnt, rockchip->clks);
> +	ret = clk_bulk_prepare_enable(rockchip->clk_cnt, rockchip->clks);
> +	if (ret)

> +		return dev_err_probe(rockchip->pci.dev, ret,
> +				     "failed to enable clocks\n");

ditto

-Serge(y)

> +
> +	return 0;
>  }
>  
>  static int rockchip_pcie_resource_get(struct platform_device *pdev,
> @@ -237,12 +243,14 @@ static int rockchip_pcie_resource_get(struct platform_device *pdev,
>  {
>  	rockchip->apb_base = devm_platform_ioremap_resource_byname(pdev, "apb");
>  	if (IS_ERR(rockchip->apb_base))
> -		return PTR_ERR(rockchip->apb_base);
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rockchip->apb_base),
> +				     "failed to map apb registers\n");
>  
>  	rockchip->rst_gpio = devm_gpiod_get_optional(&pdev->dev, "reset",
>  						     GPIOD_OUT_HIGH);
>  	if (IS_ERR(rockchip->rst_gpio))
> -		return PTR_ERR(rockchip->rst_gpio);
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rockchip->rst_gpio),
> +				     "failed to get reset gpio\n");
>  
>  	rockchip->rst = devm_reset_control_array_get_exclusive(&pdev->dev);
>  	if (IS_ERR(rockchip->rst))
> @@ -320,10 +328,9 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  		rockchip->vpcie3v3 = NULL;
>  	} else {
>  		ret = regulator_enable(rockchip->vpcie3v3);
> -		if (ret) {
> -			dev_err(dev, "failed to enable vpcie3v3 regulator\n");
> -			return ret;
> -		}
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "failed to enable vpcie3v3 regulator\n");
>  	}
>  
>  	ret = rockchip_pcie_phy_init(rockchip);
> 
> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> -- 
> 2.43.0
> 
> 

