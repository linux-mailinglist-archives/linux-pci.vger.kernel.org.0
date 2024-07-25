Return-Path: <linux-pci+bounces-10751-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D67D93BBC2
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 06:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F35F1B21978
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 04:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6B518029;
	Thu, 25 Jul 2024 04:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i4kH/NIl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FE312B95
	for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2024 04:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721881879; cv=none; b=aPS5aRmH6bC0xsSAhQtbZvylxNwlG1kbFlvSpef2wxxyYXjyXlaWkIdtmGnhq8qoWYnd/2jI4e34FtZGfotFG+JILIF5LWspqpAp8R0ETzkjvcKthB2/lSYPBoWz0wvQxGYigPKy2Tzdl96B9DUdLR6HQSooF+CP+hOzim4dL9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721881879; c=relaxed/simple;
	bh=X0LCLEP4obca1nLd4uqhOQvKIEY53jmMcqK3W3MSgRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVDM3A+PxE3KzBRvegW1wZY60a5a0k/sFRaV7ZMZMzfk05Pus/tXfV74V8SXw8zC3nLwKx/WTGyHtmRWJNexgcsyZ5kfVCvmj9LDMcXUzWv61NbBKL32IL/JfbdeZxRzO9NrDzQT3OijNPGt9BXSq8snU3Wrsp09maT3/LWir78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i4kH/NIl; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70eae5896bcso166033b3a.2
        for <linux-pci@vger.kernel.org>; Wed, 24 Jul 2024 21:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721881877; x=1722486677; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XXfannR0i35m+kTBwRZd8UAXF5c0K76k4L1K8mKl1Ek=;
        b=i4kH/NIldXSji/ilcniMrAQ97CA1IVs40pgk6sl5A/iIyJyoE/0Iaa6qnmwdAP1MsJ
         I7b0a5Ml2+cnJ9/0FXv44yguYL/2LoAWt2pRmYTQfWJW1WcOyrR/GDQfDaLYExkR6Rhm
         DQWiKMHZW+iSo+n3iIKH9o5N/gggwVdVyUAVE0no1byd2JKekv8eOdD7OPlIjh2z1onT
         /cDq4RmOpOHDTRsjy4EcsMKSRRg3/WC34nIz0lQbGkRY+dzTI0cRUhhLX9QdHs2N6lG8
         lK813LwsqW33VsTcudatAA2Qr7KeOxF5t2VForPD+wRI7bty6u2ab2WgisILKA2B7HUg
         aRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721881877; x=1722486677;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XXfannR0i35m+kTBwRZd8UAXF5c0K76k4L1K8mKl1Ek=;
        b=uEpI1MYT0piWe9jQFBVISu7xne2M/D98rvH6Oq1eYMiPjFgUrKxoG7SGEh2EVi9gSH
         MWJto8p6qV4qz+rz5TJtLB5oy7AQBQTnkSDcqUCVK/Xw8vULJJzk7JoT4mq2RlmRWtla
         m0ToTaFHfZTZwHLAXx4Y1aWhgIjuJvDFelPjNbmfWQmMnvsc9SMpWabqKKSzdxQ5Zyv9
         fd5P5+pfTPy8YV4Wm8gm/vmYlwE4l7GZVhhrYJeS676Caz3gQk0M8GGkliTYSaP9ZtMG
         gtjcS9yUkuUw0RF4ew5BsVkF/WzXw2HnyssqR8hrO1EZSUErmT/B6TdngSamwH8TW73I
         pkNg==
X-Gm-Message-State: AOJu0Yw/lxYqs7J35/92ggO+KfXdj7i++mVRU6TuHDbCQu9/sHLFjbzk
	yUOfEtfJ+/4Ifs5cr7c4LRofVHg1juKHnKjUluWV0h5fQgeec7zx0SOCg6KoBA==
X-Google-Smtp-Source: AGHT+IGXP64T7aTAPdkei1RXlp7A5rssNN997hjPGJuJA94RsOXciUbGOuoAzAwhs2/QCXjvj/Qa8w==
X-Received: by 2002:a05:6a00:22d1:b0:70b:152:331 with SMTP id d2e1a72fcca58-70eaa936f64mr2043343b3a.21.1721881876962;
        Wed, 24 Jul 2024 21:31:16 -0700 (PDT)
Received: from thinkpad ([103.244.168.26])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead812300sm343213b3a.114.2024.07.24.21.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 21:31:16 -0700 (PDT)
Date: Thu, 25 Jul 2024 10:01:11 +0530
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
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 03/12] PCI: brcmstb: Use common error handling code in
 brcm_pcie_probe()
Message-ID: <20240725043111.GD2317@thinkpad>
References: <20240716213131.6036-1-james.quinlan@broadcom.com>
 <20240716213131.6036-4-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240716213131.6036-4-james.quinlan@broadcom.com>

On Tue, Jul 16, 2024 at 05:31:18PM -0400, Jim Quinlan wrote:
> o Move the clk_prepare_enable() below the resource allocations.
> o Add a jump target (clk_out) so that a bit of exception handling can be
>   better reused at the end of this function implementation.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 29 +++++++++++++++------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index c08683febdd4..c257434edc08 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1613,31 +1613,30 @@ static int brcm_pcie_probe(struct platform_device *pdev)
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
> +
> +	ret = clk_prepare_enable(pcie->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "could not enable clock\n");
> +		return ret;
>  	}
>  
>  	ret = reset_control_reset(pcie->rescal);
> -	if (ret)
> +	if (ret) {
>  		dev_err(&pdev->dev, "failed to deassert 'rescal'\n");
> +		goto clk_out;

Please use a descriptive name for the err labels. Here this err path disables
and unprepares the clk, so use 'clk_disable_unprepare'.

> +	}
>  
>  	ret = brcm_phy_start(pcie);
>  	if (ret) {
>  		reset_control_rearm(pcie->rescal);
> -		clk_disable_unprepare(pcie->clk);
> -		return ret;
> +		goto clk_out;
>  	}
>  
>  	ret = brcm_pcie_setup(pcie);
> @@ -1676,6 +1675,10 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> +clk_out:
> +	clk_disable_unprepare(pcie->clk);
> +	return ret;
> +

This is leaking the resources. Move this new label below 'fail'.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

