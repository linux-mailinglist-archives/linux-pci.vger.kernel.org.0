Return-Path: <linux-pci+bounces-12142-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1184795D8C8
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 23:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C34DB2837DF
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 21:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3E41C825C;
	Fri, 23 Aug 2024 21:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+rIkiPP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1281614A4C9;
	Fri, 23 Aug 2024 21:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724450193; cv=none; b=QS2bWujMTF3sbF5SUFbmx+3qb0FDHxf1LHZBVfIpxEf1hVkkTdVMtVjrwTaVU41sc3W9INYJkx4ceTodVt3X2Xzb+qvh6+z0SD/tkw0zOJQiEv7TCc6BaPP4/2wC82bEyQ/6aTCtxfW2L1f4mdwq0JYKoBSF3LtUmXy1HqLceHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724450193; c=relaxed/simple;
	bh=cQcA4pt2yuf+AwdPKlHpKCqDfLYRtAaZeHJ8MzVBTqY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=aKDD7INB0fvZavOF4sNGpeXTsaqHWeugXzLHkLQ3+X7GNEya1FuByMemdPsBcPw3TF3yOOjw4MQ0s1cY4eZpTEbeRKRpCvvIEB+0ZZhBXTb5Arj6wKoKGUg7BZPNCAPlqdKLZkhZ5ctGp+y2YUHRouBoH2eaJZT474AuiKKiwzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+rIkiPP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C66C32786;
	Fri, 23 Aug 2024 21:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724450191;
	bh=cQcA4pt2yuf+AwdPKlHpKCqDfLYRtAaZeHJ8MzVBTqY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=H+rIkiPPgwQ8LX3o3QMOKgD7w6dCEZroofX39O355wZKItRJagUvrzS/v6bgOLw3i
	 Kl8BPBIvqXmM++U/0ML2RGvom5ecrjgRGBdOX2bSg7X0vVeX/gpDz1Ih/8ssrfwb6N
	 6J0ezS5kdD20dbxPJ7XvGME4Vo2m8bEj6kBn+KRWk3udiC29/jYW54QO/TTTqwW1hl
	 teQdHLFqDbU9Ban8bq0t/N8j8SWYKtKayimDD4UVj2iPdnLtaSpo5mTA9wP1bYnRSr
	 wt1vivHCoOSLd/GGBsCpqg94CzYQgI4qNXpMncsU6bB0YWJZNKA6CztgowmnO6I4oF
	 4if23zPSBVeSg==
Date: Fri, 23 Aug 2024 16:56:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wu Bo <bo.wu@vivo.com>
Cc: linux-kernel@vger.kernel.org, Pratyush Anand <pratyush.anand@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Wu Bo <wubo.oduw@gmail.com>
Subject: Re: [PATCH] PCI: dwc: change to use devm_clk_get_enabled() helpers
Message-ID: <20240823215629.GA387603@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823012516.1972826-1-bo.wu@vivo.com>

This is spear13xx-specific, not a generic dwc change, so the subject
should be:

  PCI: spear13xx: <Capitalized> ...

On Thu, Aug 22, 2024 at 07:25:16PM -0600, Wu Bo wrote:

Include the fact that you're using devm_clk_get_enabled() here so the
commit log is complete even without the subject line.

> Make the code cleaner and avoid call clk_disable_unprepare()
> 
> Signed-off-by: Wu Bo <bo.wu@vivo.com>
> ---
>  drivers/pci/controller/dwc/pcie-spear13xx.c | 18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-spear13xx.c b/drivers/pci/controller/dwc/pcie-spear13xx.c
> index 201dced209f0..37d9ccffc2e6 100644
> --- a/drivers/pci/controller/dwc/pcie-spear13xx.c
> +++ b/drivers/pci/controller/dwc/pcie-spear13xx.c
> @@ -221,32 +221,18 @@ static int spear13xx_pcie_probe(struct platform_device *pdev)
>  
>  	phy_init(spear13xx_pcie->phy);
>  
> -	spear13xx_pcie->clk = devm_clk_get(dev, NULL);
> +	spear13xx_pcie->clk = devm_clk_get_enabled(dev, NULL);
>  	if (IS_ERR(spear13xx_pcie->clk)) {
>  		dev_err(dev, "couldn't get clk for pcie\n");
>  		return PTR_ERR(spear13xx_pcie->clk);
>  	}
> -	ret = clk_prepare_enable(spear13xx_pcie->clk);
> -	if (ret) {
> -		dev_err(dev, "couldn't enable clk for pcie\n");
> -		return ret;
> -	}
>  
>  	if (of_property_read_bool(np, "st,pcie-is-gen1"))
>  		pci->link_gen = 1;
>  
>  	platform_set_drvdata(pdev, spear13xx_pcie);
>  
> -	ret = spear13xx_add_pcie_port(spear13xx_pcie, pdev);
> -	if (ret < 0)
> -		goto fail_clk;
> -
> -	return 0;
> -
> -fail_clk:
> -	clk_disable_unprepare(spear13xx_pcie->clk);
> -
> -	return ret;
> +	return spear13xx_add_pcie_port(spear13xx_pcie, pdev);

Nice cleanup, I like it.

>  }
>  
>  static const struct of_device_id spear13xx_pcie_of_match[] = {
> -- 
> 2.25.1
> 

