Return-Path: <linux-pci+bounces-11741-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F35F95425D
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 09:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451071C20ECD
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 07:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DFE84E16;
	Fri, 16 Aug 2024 07:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mC7QMY6N"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0DD84A21
	for <linux-pci@vger.kernel.org>; Fri, 16 Aug 2024 07:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723792053; cv=none; b=A/dJqkvssAp+JOTE21YMzLyXsb/9m6ktRZfwHXtZlHgcTOQz3PhN7eNxCtjjhFs3LOkiKRBLds7M1Gnt98e2XcYCNLPsz97RS5ps4Keea2S7/JfLxUon1qyng4D1NoYAp8wSEJAxQUxbpkvDRgUDpn+IR4Ots+kQYzuN5qCW1Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723792053; c=relaxed/simple;
	bh=fXgcrco1fosTB7VaQPkK50FCi2bb1sTEczfnQhaQohQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIogX9mqW5O4u+0+HHrwz0y4OxO9RWLercshOoN+ZfdlmQtQNGp+wyudAycnFr7vETFP0F+IJSiuURsLnU0o2KxJJ0HC3xPMNlm1/LS6ACplJfDJbGPW0E54AULwtYs8KzsikW2Fg4Ivt3HmtbvY2OunQqZCPICzcms6el9O01U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mC7QMY6N; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d3c071d276so1279540a91.1
        for <linux-pci@vger.kernel.org>; Fri, 16 Aug 2024 00:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723792050; x=1724396850; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O0k8JzYHQaThRxAHYqkzcgQEmY5VY+g+3F3Xyn+HevI=;
        b=mC7QMY6NeGIgDlFGZ8MagJvuJ1SYMofDgsXsmN+urVzu47D/Z8SXe4QNYxKqxsuqEr
         Apvoew/9St9BPvCFLxF7T6Eaq4on97XHhg2vwXU6lJqlqNj6u9ijbpa05XXALYyrOdCr
         pkLE4Codm7vhSK/ZX5pLBFjfIlWZS9aqspBqRCWFLojxLoSEhny7TZSNv1zNXmSZC3bk
         ZMONFT/8Z9rLlWhgVFWu38SW/oS617QQAsDcH80cvykMCgQvuZjhsYsLyTWYDuFqJ/uK
         0SvXz9w6OJ6A3Ck7I9IPaGigPMk5UNtMkoL8LexzIHWDZnCgeTy9sUQJ+qMqg21WK3/C
         khQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723792050; x=1724396850;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O0k8JzYHQaThRxAHYqkzcgQEmY5VY+g+3F3Xyn+HevI=;
        b=nmzYnwGKvzTBEV8asCoGUu+K9SMWa1hSUkMbWAl6fuIOmsX8/V7D5NNyct6jlBkYgI
         RKOyUNCRR1yLbEf6Da96LwMAj6Z9I/ZhaMs+P+/XckKL4Zoh+rA1BfAMwCb3KCrdaa1q
         zveO6m8KCvzxmohcpc+lVoZpSFLCnvT0omSTEpQVpHj9RHd5UEv/WFQX5XBkXvMyDXof
         LT6gQDRHR2+ZeY4qPob7Rc/E050jA2COr+wbRmu3KGsl8gGLpArPOtn5KaQbSRe3d1Qg
         GxcnxglMvwMI8Jqdin6UZ85dE3VztF3GG7vp4YY3M+J1xOVI5mnGef55svUdzlt+LPZT
         y/NQ==
X-Gm-Message-State: AOJu0YxlLTASHW3VXFrLPLsIgLDuOGUBY0fLukJQxgB1sti8glwF4cvc
	DpMqqAS2HWq7YA5mYMAIx8A8NYua76H+UNdy/RpMXHxx8UVd1+jMi6INfNwJcw==
X-Google-Smtp-Source: AGHT+IHKExLprs85qhO0U2PEP/08ew+AFLlzlNAEgq2CZoEQqhDB9QZy1dnL1kGwmhCct0aCPZ+DBg==
X-Received: by 2002:a17:90b:374a:b0:2d3:d7b9:2c7e with SMTP id 98e67ed59e1d1-2d3dfd9074bmr2315720a91.24.1723792050274;
        Fri, 16 Aug 2024 00:07:30 -0700 (PDT)
Received: from thinkpad ([36.255.17.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3d97f97sm1053761a91.50.2024.08.16.00.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 00:07:29 -0700 (PDT)
Date: Fri, 16 Aug 2024 12:37:24 +0530
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
Subject: Re: [PATCH v6 05/13] PCI: brcmstb: Use bridge reset if available
Message-ID: <20240816070724.GJ2331@thinkpad>
References: <20240815225731.40276-1-james.quinlan@broadcom.com>
 <20240815225731.40276-6-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240815225731.40276-6-james.quinlan@broadcom.com>

On Thu, Aug 15, 2024 at 06:57:18PM -0400, Jim Quinlan wrote:
> The 7712 SOC has a bridge reset which can be described in the device tree.
> Use it if present.  Otherwise, continue to use the legacy method to reset
> the bridge.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/pcie-brcmstb.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 790a149f6581..af14debd81d0 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -265,6 +265,7 @@ struct brcm_pcie {
>  	enum pcie_type		type;
>  	struct reset_control	*rescal;
>  	struct reset_control	*perst_reset;
> +	struct reset_control	*bridge_reset;
>  	int			num_memc;
>  	u64			memc_size[PCIE_BRCM_MAX_MEMC];
>  	u32			hw_rev;
> @@ -732,12 +733,19 @@ static void __iomem *brcm7425_pcie_map_bus(struct pci_bus *bus,
>  
>  static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
>  {
> -	u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
> -	u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
> +	if (val)
> +		reset_control_assert(pcie->bridge_reset);
> +	else
> +		reset_control_deassert(pcie->bridge_reset);
>  
> -	tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> -	tmp = (tmp & ~mask) | ((val << shift) & mask);
> -	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> +	if (!pcie->bridge_reset) {
> +		u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
> +		u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
> +
> +		tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> +		tmp = (tmp & ~mask) | ((val << shift) & mask);
> +		writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> +	}
>  }
>  
>  static void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32 val)
> @@ -1621,10 +1629,16 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  	if (IS_ERR(pcie->perst_reset))
>  		return PTR_ERR(pcie->perst_reset);
>  
> +	pcie->bridge_reset = devm_reset_control_get_optional_exclusive(&pdev->dev, "bridge");
> +	if (IS_ERR(pcie->bridge_reset))
> +		return PTR_ERR(pcie->bridge_reset);
> +
>  	ret = clk_prepare_enable(pcie->clk);
>  	if (ret)
>  		return dev_err_probe(&pdev->dev, ret, "could not enable clock\n");
>  
> +	pcie->bridge_sw_init_set(pcie, 0);
> +
>  	ret = reset_control_reset(pcie->rescal);
>  	if (ret) {
>  		clk_disable_unprepare(pcie->clk);
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்

