Return-Path: <linux-pci+bounces-4704-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3ADF8776F2
	for <lists+linux-pci@lfdr.de>; Sun, 10 Mar 2024 14:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736A31F21130
	for <lists+linux-pci@lfdr.de>; Sun, 10 Mar 2024 13:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB9228389;
	Sun, 10 Mar 2024 13:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oi9ktv6a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0437E28375
	for <linux-pci@vger.kernel.org>; Sun, 10 Mar 2024 13:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710076254; cv=none; b=LxfPirvEGfOb6OozsazGedgCES2YVXmCenmrVZ+tFmyv31fc/C8H3lwe1Y3HIZXrekg6CyjhEWk9YVksrtb9ocBbyIkqkuyqGeLvpTUliruecNT+KS0FbVkuMuKWSNGTN5ptC9GiamA+2jwgck+rVnB3ySMlb9hLMTr768RJxlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710076254; c=relaxed/simple;
	bh=ax2RNJorpp3TSFA3u6t7l1IpR8HjaNKlGKbBlwXPHTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SiREEQIjVjHrmLzcSkEq7hBpLbNAbQ4dQkuH63vNI4vrKZo2BEOM9xrxfZTH/jOWD5Sui1UaMNevVzmRC2QsjsUwRs0A5uxdWQmSWtPajjwgPRUaawvfGydihw56gts0PYLuwj1/BcTZv2ebbz58heoMRHh5x6wqFrvTfPuw1r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Oi9ktv6a; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dd3bdb6e9eso21218295ad.3
        for <linux-pci@vger.kernel.org>; Sun, 10 Mar 2024 06:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710076252; x=1710681052; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=au7P4O6xCDCWvwO0tgkblYFVdWtoYF+Jl11SBGPbJW4=;
        b=Oi9ktv6aoBxop11GbT/HxE4090A+KghAC8286wIRm5uJfMhgCStm+OF1SnRYelglqt
         oaUwq34rJ2Kxs3gKrdC9uQ8FXF2ZtKnJthyQpSSdfVjKqEJCJvgKMVIVCRC16SQb7D5U
         TcePeRHiAd1sVs6wu7FGEYv9uBBrr4FneT+FOa84J6yXGYIcEWxqK13fvtGRstgOGjUy
         0e0e4cqXYcm5MmoJZjMoBI5tCTH5UMEat6eCdh3B9kbV53V7TYPqlfYxo0wtjEuGK3in
         RTs5TEUT+V4HdlkQxSxFI1LZSOCb5QQDV+9jnS/6FGGRXZsSOAJOV9BOwEM2l4/H9xQr
         gCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710076252; x=1710681052;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=au7P4O6xCDCWvwO0tgkblYFVdWtoYF+Jl11SBGPbJW4=;
        b=mZUvgYB3qN6f+N5K4lspMtTs5Sp5XJMbPeptRzVkXMsZ6SYq98mH4SP+ynAATsje4a
         +ArNyJZ2VJVof66JP2OegjV1GH2L8YXgGVNlLgJ9zfYgIzjdzmYL5yJ1HKz8y+2khKMa
         mdNma62nJE19xYnyc4tREeS7Z4YJcIFY7klIJv21cL8TIuBX+6NYG4GbZIrw27CkeEfZ
         SPbGTlFAUjfNYV++O+2I5JX5eTbLtcP0NWkR9EbKzGlv2VCUbq6I5lwqt05NWnxUt5r+
         Ur6a4ySWKSdnz0Bw6RgDq/6FV/+DnBE9QR7U+2NbNDUFbeJLsFR0FxTwU2Clel6UnAcq
         wgPA==
X-Forwarded-Encrypted: i=1; AJvYcCUf0IRWMtj07pgWIIa4WvFmQn8cBjo5BP5bhiS3LNtZYi4sv3VyCBKwshqX5PawYdRxVBgNDDAC5BHMVpFSPKeHtcP+Q+YMnWJJ
X-Gm-Message-State: AOJu0YxP4gr0AfWR1mAw7d9xyKRtv/kuTtFuYkwCYdhPvKoYjv1NDBox
	Na5LXREw5iYVYdqr3JAKR8t63/Vt83ttVOC/NYjjamhx1e9bmxR8t9rzXSXP5w==
X-Google-Smtp-Source: AGHT+IFuv9OaGeFP6KlGcGd9oQzt86zGm2DdkpeYjp6iGs11PIU4RxOlG2h6k/PX/NU8+J70mccttg==
X-Received: by 2002:a17:902:c952:b0:1db:f6b0:92d with SMTP id i18-20020a170902c95200b001dbf6b0092dmr4686762pla.6.1710076252234;
        Sun, 10 Mar 2024 06:10:52 -0700 (PDT)
Received: from thinkpad ([120.138.12.86])
        by smtp.gmail.com with ESMTPSA id i14-20020a17090332ce00b001dd621111e2sm2642256plr.194.2024.03.10.06.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 06:10:51 -0700 (PDT)
Date: Sun, 10 Mar 2024 18:40:43 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@debian.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Lei Chuanhua <lchuanhua@maxlinear.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] PCI: dw-rockchip: Add error messages in .probe()s
 error paths
Message-ID: <20240310131043.GD3390@thinkpad>
References: <20240227141256.413055-2-ukleinek@debian.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240227141256.413055-2-ukleinek@debian.org>

On Tue, Feb 27, 2024 at 03:12:54PM +0100, Uwe Kleine-König wrote:
> Drivers that silently fail to probe provide a bad user experience and
> make it unnecessarily hard to debug such a failure. Fix it by using
> dev_err_probe() instead of a plain return.
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Uwe Kleine-König <ukleinek@debian.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> Hello,
> 
> changes since (implicit) v1, sent with Message-Id:
> 20240227111837.395422-2-ukleinek@debian.org:
> 
>  - use dev instead of rockchip->pci.dev as noticed by Serge Semin.
>  - added Reviewed-by: tag for Heiko. I assume he agrees to above
>    improvement and adding the tag despite the change is fine.
> 
> Best regards
> Uwe
> 
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 21 ++++++++++++-------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index d6842141d384..a13ca83ce260 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -225,11 +225,15 @@ static int rockchip_pcie_clk_init(struct rockchip_pcie *rockchip)
>  
>  	ret = devm_clk_bulk_get_all(dev, &rockchip->clks);
>  	if (ret < 0)
> -		return ret;
> +		return dev_err_probe(dev, ret, "failed to get clocks\n");
>  
>  	rockchip->clk_cnt = ret;
>  
> -	return clk_bulk_prepare_enable(rockchip->clk_cnt, rockchip->clks);
> +	ret = clk_bulk_prepare_enable(rockchip->clk_cnt, rockchip->clks);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable clocks\n");
> +
> +	return 0;
>  }
>  
>  static int rockchip_pcie_resource_get(struct platform_device *pdev,
> @@ -237,12 +241,14 @@ static int rockchip_pcie_resource_get(struct platform_device *pdev,
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
> @@ -320,10 +326,9 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
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

-- 
மணிவண்ணன் சதாசிவம்

