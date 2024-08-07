Return-Path: <linux-pci+bounces-11436-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8100094A99C
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 16:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34FCB287A88
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 14:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8275579F;
	Wed,  7 Aug 2024 14:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IRb26yMk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5114B339B1
	for <linux-pci@vger.kernel.org>; Wed,  7 Aug 2024 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039984; cv=none; b=k1D3cQtI+l6yTiyLm3bxgEIdemGsAYywGqafqgo9gBOzSI07f998q2KBc3Hn5OLp6EO01OYVxkCRd/eVtyqNr2aFVB6dAhtLlKRwQ2cX7hhisBHvp9cD9BipUVC5z9Ie+AmheCyndFstWduXzTe1HN+leaHkgJRt3b0tZLSRlko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039984; c=relaxed/simple;
	bh=chzMyUGfrV/jIY+r8gr7nxpwqtla1LE+GLkZtMX57X0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AY+VjOt/izijBCkpSdnDXoV0LSX5mYQjncy7zXbads5B7LFg+pwesSELSTHnhHk1cW6WtzT2Ymce4DTXKDVkCGfqTbwSY8Ppgysmai8jeOZIn7pWiy+rfqQG3bQHUZCKGCP8t2Rm0ATQVh8YIIqdKHcvxUZJvfHRsJ1EP8pE6EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IRb26yMk; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70d1fb6c108so1457708b3a.3
        for <linux-pci@vger.kernel.org>; Wed, 07 Aug 2024 07:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723039982; x=1723644782; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lRFsgP8Y1c32TT9S5zwl+bMoEl7yvNRAJ5VeQ46re5I=;
        b=IRb26yMkCfdngnRZK/exEr/O555x9/7OFJ1JqJRzppuqB2lRuemXK4UMUhGdY8H/es
         PjFq9NB1oagqTdpS6vxZVMbutJWesbQe9+UFB3bFdGClY9YCFMoP7Azbou4JDGcdasS2
         x3DeKQ/wmYh/xywZe+j64mEE8ls9zUa+yEHuxptgMQP/wCOtHv4YTKoDodug+WuLXxs3
         /1IoxvxoidXQthOTpzbjVmuuJ8MlXRi266avQpMkjaORFfO7/7t2qHsLaATkcLhb6SvH
         VhC5YKPCZcU994g5rQ8g+b26cEeBmaefzxOavK5AuoO7aKx73aZaFSooUaxSxN5MaK7x
         MBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723039983; x=1723644783;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lRFsgP8Y1c32TT9S5zwl+bMoEl7yvNRAJ5VeQ46re5I=;
        b=FN+TqIK5sLmQgTcY8IOQjp3IeTS1MwQhd4k8aNYWi43MYDkIyI8oqdGglpC+0KGG8F
         mNF3udmohym7Rszc3fRXKKL/hNXDOAQDHzxljGJuWZS9+XNZYiAkU297LMFmp8LtBEbX
         gTcljTCxX7Y06Ym84Pxy2GLYAefszFFqKoZFtByUorHTmG0M2Rvck5zElO0Wu4sv/f7J
         +Onnbtwn0MT4k2k6x4EvTYT8jDwhjkEofmcVtXTMKfzyGMocus6FUBx1EUIJEDoxYZNl
         BD83lWxIDMrQjxlKYlKl/vRuBl0PPYHrqETajqBzrfqijtQel+kbCwPJI/qGIHqxqGam
         vKKQ==
X-Gm-Message-State: AOJu0YxbUuQyPP7LZQ8OroBvQKUst1fBIcR5B6ynrmbBlBo1BvAywMFf
	EExc5eyEXdO6AYksR2Gp2zWXz96Dr2RgEvdmxwZd/ALcl8fjQqoXN4ValiYtWA==
X-Google-Smtp-Source: AGHT+IE+2bxt0RWYDzoa/0717PVsVp/VC5L53fxD/frfjlYdSeFOHQvtM70NjBfd+Nz1QbuAWz1Ktg==
X-Received: by 2002:a05:6a00:6f0f:b0:706:67c9:16d0 with SMTP id d2e1a72fcca58-7106d0812eemr17260571b3a.26.1723039982533;
        Wed, 07 Aug 2024 07:13:02 -0700 (PDT)
Received: from thinkpad ([120.60.60.211])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec06a25sm8462024b3a.33.2024.08.07.07.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 07:13:02 -0700 (PDT)
Date: Wed, 7 Aug 2024 19:42:48 +0530
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
Subject: Re: [PATCH v5 12/12] PCI: brcmstb: Enable 7712 SOCs
Message-ID: <20240807141248.GL3412@thinkpad>
References: <20240731222831.14895-1-james.quinlan@broadcom.com>
 <20240731222831.14895-13-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240731222831.14895-13-james.quinlan@broadcom.com>

On Wed, Jul 31, 2024 at 06:28:26PM -0400, Jim Quinlan wrote:
> The Broadcom STB 7712 is the sibling chip of the RPi 5 (2712).
> It has one PCIe controller with a single port, supports gen2
> and one lane only.  The current revision of the chip is "C0"
> or "C1".
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 4623b70f9ad8..44b323a13357 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1202,6 +1202,10 @@ static void brcm_extend_rbus_timeout(struct brcm_pcie *pcie)
>  	const unsigned int REG_OFFSET = PCIE_RGR1_SW_INIT_1(pcie) - 8;
>  	u32 timeout_us = 4000000; /* 4 seconds, our setting for L1SS */
>  
> +	/* 7712 does not have this (RGR1) timer */
> +	if (pcie->soc_base == BCM7712)
> +		return;
> +
>  	/* Each unit in timeout register is 1/216,000,000 seconds */
>  	writel(216 * timeout_us, pcie->base + REG_OFFSET);
>  }
> @@ -1673,6 +1677,13 @@ static const int pcie_offsets_bmips_7425[] = {
>  	[PCIE_INTR2_CPU_BASE] = 0x4300,
>  };
>  
> +static const int pcie_offset_bcm7712[] = {
> +	[EXT_CFG_INDEX]  = 0x9000,
> +	[EXT_CFG_DATA]   = 0x9004,
> +	[PCIE_HARD_DEBUG] = 0x4304,
> +	[PCIE_INTR2_CPU_BASE] = 0x4400,
> +};
> +
>  static const struct pcie_cfg_data generic_cfg = {
>  	.offsets	= pcie_offsets,
>  	.soc_base	= GENERIC,
> @@ -1738,6 +1749,14 @@ static const struct pcie_cfg_data bcm7216_cfg = {
>  	.num_inbound_wins = 3,
>  };
>  
> +static const struct pcie_cfg_data bcm7712_cfg = {
> +	.offsets	= pcie_offset_bcm7712,
> +	.perst_set	= brcm_pcie_perst_set_7278,
> +	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
> +	.soc_base	= BCM7712,
> +	.num_inbound_wins = 10,
> +};
> +
>  static const struct of_device_id brcm_pcie_match[] = {
>  	{ .compatible = "brcm,bcm2711-pcie", .data = &bcm2711_cfg },
>  	{ .compatible = "brcm,bcm4908-pcie", .data = &bcm4908_cfg },
> @@ -1747,6 +1766,7 @@ static const struct of_device_id brcm_pcie_match[] = {
>  	{ .compatible = "brcm,bcm7445-pcie", .data = &generic_cfg },
>  	{ .compatible = "brcm,bcm7435-pcie", .data = &bcm7435_cfg },
>  	{ .compatible = "brcm,bcm7425-pcie", .data = &bcm7425_cfg },
> +	{ .compatible = "brcm,bcm7712-pcie", .data = &bcm7712_cfg },
>  	{},
>  };
>  
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்

