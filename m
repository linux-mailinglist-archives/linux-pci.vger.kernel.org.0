Return-Path: <linux-pci+bounces-25740-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A5DA872D1
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 19:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C332B18949CA
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 17:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2335D1EB1A9;
	Sun, 13 Apr 2025 17:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qDVEIEz3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CB6145B0B
	for <linux-pci@vger.kernel.org>; Sun, 13 Apr 2025 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744564202; cv=none; b=fK8FpzdzCGiT99r/IhhLMnjPOKkMSljx24PKSZOONWlalmRbGHHI8zyiWlEIRaRN2G829sIJgwjh0ZzldseIfbSsRi/JNEmjTjAPflDEpMKH0NK19LLTVeglQrM3AL/yR12WbjGmuksYhkswZzrqLcyTjKBhQdQe/SIx3g4rWqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744564202; c=relaxed/simple;
	bh=VIDzddv+o5O40oGIPzcK+uFOnPDJBuCGtbfeOsXTDts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/KYxuZ/Tk2cEdXEe7fA6FqFv3NUjUQnZJpabGNbw8CCrhWFUkeNeywhztvL18/h4rOXtNd9rZ0E1buhjGVB+PVgutwbtI6yOvKWvJLdTNfI5zzUz/+XKoLfnMxgIJm5BFOR9gsiH0cTHouuRN4+wXwfInfkgLx/w3Duc/9LCHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qDVEIEz3; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2279915e06eso35721525ad.1
        for <linux-pci@vger.kernel.org>; Sun, 13 Apr 2025 10:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744564198; x=1745168998; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VbsBH030YmmrPLiGCvxSobJgevOjlBmu917XLPcMgfY=;
        b=qDVEIEz39rVHcUP5dyFbjjDTXAoy/f6Uegv8aAe4EUOwY/ZL8JyOk+GlV7VBgIfKmZ
         oucIy/M7tZxYYNoA1lwOvIKA9RKXB/E6Cjjwgc+T9xN/yonbVxd0/Mq8f3sFNQLWYqIw
         IGS+nLJyC2Wih1VSteYXxQaofdq3D3ANHZtcZ8+JrnKFWTXnHdO9b3OkV/lsmOO4VxOE
         TVQJ8DWzWYcETFGMdkGYZrb6mP6Yq5yDbA1ZDk3VP4kCSSxIoDbSN0doWoiFmW6SZYdg
         YPeFaQsmVj+/F0QzGBhX8/Y+No6YpLnXLjhVEk6v9q+skUyvoz5Fd0N+fBLFkCZ5nUdF
         AWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744564198; x=1745168998;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VbsBH030YmmrPLiGCvxSobJgevOjlBmu917XLPcMgfY=;
        b=UC1reG4mPlBLDitf/KbT6r9ume3YGJXgMr6ZHjg0oosphhyTJpvvvH0I6ZHPiewx1+
         sdOORSoOkGqQU1/1jJxQJRBiFwXALD7v5sPw2kLEMoh6Lo5dTKQSwJTZ99kXywvcqt4F
         qp0i/RD9nr5Uqwg4vqINu+nbD4GQBRC5hJgtuG8JPtbZZlaGLaHFcDPqdJ2J+3Z1a44Z
         Mr2EhvhEFINAxaxJIygXMeWLMtreJ42xY4H1pWZ/kOPuPYvhrezszimRaB+zfyu52kux
         PtPC+z3Xwwcji7iOtkxOUCNl457GAZ5l1skGnQYFvE/gKWm1knk7pQOtSPeka8j/T8RD
         teNA==
X-Forwarded-Encrypted: i=1; AJvYcCX1Lb6yj8PMn/d1s6K+hMv1NmlbbA4Qq88+AK0xkwvaH8Xt6v6yM5KWH3/LDJEW4ywbwDPo7L8P7X4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ43bdP3ftZ45wLDNdlfmaizB7LGnGzm/EUG1RBBR3AyFU0ISa
	oLE272BfPq5Pr9IGbqFADKSdvysnEOckWxZchGeLeygigxxqdLt2rgHwnowmwnNaVVSBeqaehuo
	=
X-Gm-Gg: ASbGncvx0dJByLXjOn3s+wvql9gsf39rk7Hi7YEHv5xtTAAaraSra0raV8CmFXm5O+3
	UR5d3Bp4HNlfT4wGUgFMiMUJ6rRT/NUpicVIONXIRw3i6/z0dcuEf8npZsyU3XxcjrFZaaDeTvY
	8XK0SUv9B3SbSmWae0e+Kloxj07wDAizGDa7ErQ8sz4IiuWIBhWLZAs2vpdfbod1z9ds0tPLfot
	hpZR9fm2q6cyHNrorYDuwx4jGs62Ty2TgmBnn32wLT4gaueI6Jl2Q+SGtmKGsz3gfHfrkJmsHst
	ySga+a+Snb8tc0d319YkfMDXW2Q5V677S+4elAJeAOxwBjEUWiiz
X-Google-Smtp-Source: AGHT+IEM5JXPlHa/46KPcgwjfAGRbntfwPEeRwa0pOWka95ljamo2KjNfPBab6Whg2HZjCAf5af8bg==
X-Received: by 2002:a17:902:f650:b0:223:37ec:63d3 with SMTP id d9443c01a7336-22bea4adeecmr130822495ad.18.1744564198505;
        Sun, 13 Apr 2025 10:09:58 -0700 (PDT)
Received: from thinkpad ([120.60.137.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c95c40sm84845325ad.127.2025.04.13.10.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 10:09:58 -0700 (PDT)
Date: Sun, 13 Apr 2025 22:39:52 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Janne Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>, 
	Sven Peter <sven@svenpeter.dev>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: Re: [PATCH v3 07/13] PCI: apple: Move away from INTMSK{SET,CLR} for
 INTx and private interrupts
Message-ID: <sbudn32sbw6d3z7n2yomlzdsbtumckw4o576zfe5nlvwpt22j4@hf2zpld7tvcb>
References: <20250401091713.2765724-1-maz@kernel.org>
 <20250401091713.2765724-8-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250401091713.2765724-8-maz@kernel.org>

On Tue, Apr 01, 2025 at 10:17:07AM +0100, Marc Zyngier wrote:
> T602x seems to have dropped the rather useful SET/CLR accessors
> to the masking register.
> 
> Instead, let's use the mask register directly, and wrap it with
> a brand new spinlock. No, this isn't moving in the right direction.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Acked-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Tested-by: Janne Grunau <j@jannau.net>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/pcie-apple.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> index 6d3aa186d9c5f..6b04bf0b41dcc 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -142,6 +142,7 @@ struct apple_pcie {
>  };
>  
>  struct apple_pcie_port {
> +	raw_spinlock_t		lock;
>  	struct apple_pcie	*pcie;
>  	struct device_node	*np;
>  	void __iomem		*base;
> @@ -261,14 +262,16 @@ static void apple_port_irq_mask(struct irq_data *data)
>  {
>  	struct apple_pcie_port *port = irq_data_get_irq_chip_data(data);
>  
> -	writel_relaxed(BIT(data->hwirq), port->base + PORT_INTMSKSET);
> +	guard(raw_spinlock_irqsave)(&port->lock);
> +	rmw_set(BIT(data->hwirq), port->base + PORT_INTMSK);
>  }
>  
>  static void apple_port_irq_unmask(struct irq_data *data)
>  {
>  	struct apple_pcie_port *port = irq_data_get_irq_chip_data(data);
>  
> -	writel_relaxed(BIT(data->hwirq), port->base + PORT_INTMSKCLR);
> +	guard(raw_spinlock_irqsave)(&port->lock);
> +	rmw_clear(BIT(data->hwirq), port->base + PORT_INTMSK);
>  }
>  
>  static bool hwirq_is_intx(unsigned int hwirq)
> @@ -387,7 +390,7 @@ static int apple_pcie_port_setup_irq(struct apple_pcie_port *port)
>  		return -ENOMEM;
>  
>  	/* Disable all interrupts */
> -	writel_relaxed(~0, port->base + PORT_INTMSKSET);
> +	writel_relaxed(~0, port->base + PORT_INTMSK);
>  	writel_relaxed(~0, port->base + PORT_INTSTAT);
>  
>  	irq_set_chained_handler_and_data(irq, apple_port_irq_handler, port);
> @@ -537,6 +540,8 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
>  	port->pcie = pcie;
>  	port->np = np;
>  
> +	raw_spin_lock_init(&port->lock);
> +
>  	port->base = devm_platform_ioremap_resource(platform, port->idx + 2);
>  	if (IS_ERR(port->base))
>  		return PTR_ERR(port->base);
> -- 
> 2.39.2
> 

-- 
மணிவண்ணன் சதாசிவம்

