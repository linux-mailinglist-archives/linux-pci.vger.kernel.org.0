Return-Path: <linux-pci+bounces-28192-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 968D2ABF058
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 11:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 109BA7A3BCF
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 09:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C16F253B75;
	Wed, 21 May 2025 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjhjgSnA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E36B253B5A;
	Wed, 21 May 2025 09:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747820703; cv=none; b=U+YcMYp4/bhfDdbeyBYPm7HnP1pJFAjoOwLVmhy9mTkUFmrjkYmoai1oDMjnVXxwsfSn2EvtKwCJl0tp/OxvZEGVeB/2luGkFAMjcnUmPenX2eZIuEH0wSkYdU6TxrBf1v9zWD2KBZtw4Iui+xX/N92GnIiTMwRvylqdtfgdA/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747820703; c=relaxed/simple;
	bh=FZEEaVi5Z5wlFR4wqNKg2BEAk2iE1vh3bIqVALVnJN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2i5ohEzdqil0Y3fnjj30ybNfQLMz7r8WN3KfziVE65g2m9DN137qLYIgw4OdaOswtTF36YnQEx2hjtllFSsSuF7/qMq8YXsT+yM1j1HRXFn3ZF0Ri+z8RmASVQMvZIGmuroT13c7j4q9JfHWa8G+bkTBuNOVsI1/ypIp/AGK+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjhjgSnA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF46DC4CEEA;
	Wed, 21 May 2025 09:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747820702;
	bh=FZEEaVi5Z5wlFR4wqNKg2BEAk2iE1vh3bIqVALVnJN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FjhjgSnAQckzuwu9psZRqGye7MuCDKWsuflqm5RH3Ls3rFxZwJWEhyEGDklBCIq0W
	 2ok6ePTvqpDkdaG+5pULv/53UNXzidBzKJGEKQ04pahsvE4RfM8YF3y84Xkzb3AsFe
	 MNtNhQ5bXF84GoYcadh+MiZs7wuB3yE3c7WcwoDyAL5s/ebbd9O3+z44d2BtRCJmBz
	 f2LiYJ7Yqo+Uh/HxgDC2YEmn0NbzJesB6E9BBO6qqOmFSZTtCmoUi1/KH3l5wU5W9w
	 dnw7GmkVfp2UhbXPZA0VFrPIOT0aaHKj4Z3VyeDHzz8NBnW8/XW/J7EXZxdaF9hdDe
	 cf+bfYlebTF4w==
Date: Wed, 21 May 2025 11:44:59 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.or, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, 
	kw@linux.com, robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com, 
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com, vkoul@kernel.org, 
	kishon@kernel.org, arnd@arndb.de, m.szyprowski@samsung.com, jh80.chung@samsung.com, 
	Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: Re: [PATCH 04/10] PCI: exynos: Add platform device private data
Message-ID: <20250521-cheerful-spiked-mackerel-ef7ade@kuoka>
References: <20250518193152.63476-1-shradha.t@samsung.com>
 <CGME20250518193239epcas5p4cb4112382560f38ad9708e000eb2335f@epcas5p4.samsung.com>
 <20250518193152.63476-5-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250518193152.63476-5-shradha.t@samsung.com>

On Mon, May 19, 2025 at 01:01:46AM GMT, Shradha Todi wrote:
> -static const struct dw_pcie_ops dw_pcie_ops = {
> +static const struct dw_pcie_ops exynos_dw_pcie_ops = {
>  	.read_dbi = exynos_pcie_read_dbi,
>  	.write_dbi = exynos_pcie_write_dbi,
>  	.link_up = exynos_pcie_link_up,
> @@ -279,6 +286,7 @@ static int exynos_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct exynos_pcie *ep;
> +	const struct samsung_pcie_pdata *pdata;
>  	struct device_node *np = dev->of_node;
>  	int ret;
>  
> @@ -286,8 +294,11 @@ static int exynos_pcie_probe(struct platform_device *pdev)
>  	if (!ep)
>  		return -ENOMEM;
>  
> +	pdata = of_device_get_match_data(dev);
> +
> +	ep->pdata = pdata;
>  	ep->pci.dev = dev;
> -	ep->pci.ops = &dw_pcie_ops;
> +	ep->pci.ops = pdata->dwc_ops;
>  
>  	ep->phy = devm_of_phy_get(dev, np, NULL);
>  	if (IS_ERR(ep->phy))
> @@ -363,9 +374,9 @@ static int exynos_pcie_resume_noirq(struct device *dev)
>  		return ret;
>  
>  	/* exynos_pcie_host_init controls ep->phy */
> -	exynos_pcie_host_init(pp);
> +	ep->pdata->host_ops->init(pp);
>  	dw_pcie_setup_rc(pp);
> -	exynos_pcie_start_link(pci);
> +	ep->pdata->dwc_ops->start_link(pci);

One more layer of indirection.

Read:
https://lore.kernel.org/all/CAL_JsqJgaeOcnUzw+rUF2yO4hQYCdZYssjxHzrDvvHGJimrASA@mail.gmail.com/

Best regards,
Krzysztof


