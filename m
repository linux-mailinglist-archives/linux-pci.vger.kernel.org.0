Return-Path: <linux-pci+bounces-28195-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C29ABF067
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 11:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215661B633D9
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 09:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F2F259C8B;
	Wed, 21 May 2025 09:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gblETKwj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4242D20ADF8;
	Wed, 21 May 2025 09:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747820904; cv=none; b=S0hErZod0B8OWszm8Uss9YLj8wxdghUaGH/JnVwl5QXC8zrH8YFj4zfsX/aoJ/DGMT5dPOXJ0oEAbypD5G8AQrvdN+VVaWAzaSjBvFwCiBlcZjxr+DPGC7uQQFIuz5wgCCvXXj282fPv5RqnD3p4fVln1lkstwesvWHXSpfMg7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747820904; c=relaxed/simple;
	bh=eSB4+kYQk9B5Ny4FaYdOJjyIyatCOgRUu77XD/ivzsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWb2ZM6eOVgoFN5S2nHJFvCv1MKQxb5UVj3Snfxg6DVrcPoAjxUvZSToAGjv/LdqJo0nwh3AVfXTaJc0/RclMBDUF7BGX2xJm16BkZgu+GdhqXAuYW5xZH3vJKDFdpo2P/Z56wz9aZrt//Rn/nyQPfgMKMGBRI21SKH76KAgJ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gblETKwj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CFCC4CEE4;
	Wed, 21 May 2025 09:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747820903;
	bh=eSB4+kYQk9B5Ny4FaYdOJjyIyatCOgRUu77XD/ivzsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gblETKwjKAg/6vPGvMLFwRLy+nIftJcjXdnCHOvYyXv9G7Lkwb6k7dY8yvunqG1IA
	 crYzV1ujSs0vfCEeKG8/q2CUW67AHnNJhteYhFiE9yveWc7hH1zsp+3sot6hu/rE03
	 Zhc3bNANh32VIP4E/I1GHUpfy5cxDjyeWNsdISUwtWvkeHe8rHZ8lS+9bc54UxPoVD
	 3hj24fwedWXb1TLOc/DBKeFXhe/jU7liX553FZsoG4l4tYG10xS0lxoKgb8x9Aucek
	 l1+AOWG1lnDqihrcepARsaJ5huNo9vUKDERCMj4MwVw+Forxl1171xq7j1Y0kEv5Zg
	 Ppn1TgTmIN76w==
Date: Wed, 21 May 2025 11:48:21 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.or, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, 
	kw@linux.com, robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com, 
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com, vkoul@kernel.org, 
	kishon@kernel.org, arnd@arndb.de, m.szyprowski@samsung.com, jh80.chung@samsung.com
Subject: Re: [PATCH 09/10] PCI: exynos: Add support for Tesla FSD SoC
Message-ID: <20250521-competent-honeybee-of-will-3f3ae1@kuoka>
References: <20250518193152.63476-1-shradha.t@samsung.com>
 <CGME20250518193300epcas5p17e954bb18de9169d65e00501b1dcd046@epcas5p1.samsung.com>
 <20250518193152.63476-10-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250518193152.63476-10-shradha.t@samsung.com>

On Mon, May 19, 2025 at 01:01:51AM GMT, Shradha Todi wrote:
>  static int exynos_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -355,6 +578,26 @@ static int exynos_pcie_probe(struct platform_device *pdev)
>  	if (IS_ERR(ep->phy))
>  		return PTR_ERR(ep->phy);
>  
> +	if (ep->pdata->soc_variant == FSD) {
> +		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(36));
> +		if (ret)
> +			return ret;
> +
> +		ep->sysreg = syscon_regmap_lookup_by_phandle(dev->of_node,
> +				"samsung,syscon-pcie");
> +		if (IS_ERR(ep->sysreg)) {
> +			dev_err(dev, "sysreg regmap lookup failed.\n");
> +			return PTR_ERR(ep->sysreg);
> +		}
> +
> +		ret = of_property_read_u32_index(dev->of_node, "samsung,syscon-pcie", 1,
> +						 &ep->sysreg_offset);
> +		if (ret) {
> +			dev_err(dev, "couldn't get the register offset for syscon!\n");

So all MMIO will go via syscon? I am pretty close to NAKing all this,
but let's be sure that I got it right - please post your complete DTS
for upstream. That's a requirement from me for any samsung drivers - I
don't want to support fake, broken downstream solutions (based on
multiple past submissions).

Best regards,
Krzysztof


