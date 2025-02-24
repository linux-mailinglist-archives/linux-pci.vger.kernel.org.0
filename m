Return-Path: <linux-pci+bounces-22153-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813B3A415C4
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 08:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE98A3AAB0A
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 07:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21481A317E;
	Mon, 24 Feb 2025 07:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bSRa4TUB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDE2207DEF
	for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2025 07:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740380565; cv=none; b=iaubW3kOGI+paUe7TSxszQsKxZswqesP0Bme3FO1bvciD//iIqejMnd0xvW9BvupVkA4cN8r62rSoFHjFOxPJP9dCZhxDGzmQJe2ggtmuMwlbwG3soXve9xYgTeTK0vS79No3ntDA6d0zMT76+K2+Nh0vAyTKKN+RUxnTScBils=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740380565; c=relaxed/simple;
	bh=o7KXtFkkiossVlXHLyR6rFidy6CgsihrYaqqAvlOcIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b79jxPsfosBjvf2gDkhp2jsnuMumTHlnmUsOcn4cZxK7TedsBK/bqRoY28jRntjmD90hNjSddoO7f4mmC5IoRGBEml9PJLOxnu0987h8SqEC7x4Wuksp+nHAqdm69SHhGzhurpzoN/+0oSk+NeRKBo0WB1faEQYOyrgCd4PD04c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bSRa4TUB; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220c2a87378so66482095ad.1
        for <linux-pci@vger.kernel.org>; Sun, 23 Feb 2025 23:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740380563; x=1740985363; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6wvvGLB8O3NF43tAdS2H7DvAXcu+6aLP4+yb5jyf9L4=;
        b=bSRa4TUB1+c3Lj6xxrTPth2yZ+gsfb3LxC5f1OU1A3ngInkH42BYBLEsMVvuMif6Cn
         Nk9k2+0d1sumBwPyOA7j0uS1xFExTf2sQVa9skUafuUlIdR7B+9ViDncV78z8F0eAR0q
         OOBm1f/fgOSlqncI9ONa+2yCz2MSVRnsEoSZkWcLA0kX6US037mUs7Q2+pFve0CB+GCr
         +oWT8y9A0z8I6wDFTI4q2Mt3uCPjFDWzOXoNeOw1qu4uH8nGrDlaYgXLpqTcRfPJjNET
         1Ta67VGBI8E/5eq4SpJ2xaA2syXLQuw8pUVy9/J55E4cqpW9AM105Ie5FIGrio6jzDWj
         kfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740380563; x=1740985363;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wvvGLB8O3NF43tAdS2H7DvAXcu+6aLP4+yb5jyf9L4=;
        b=mn7uJqm3S0ptxmUXJdGEr48riVy+6ZudbFR6b9D5HuXm8qrbHd4B//Hu/uCEEs34VC
         HI91KTipW2OBvvUgt/GZoaeI9vRp3vqwAw/vDNMBicgXk7H4l0aNctdL9HVuV37PPT6h
         WIiLu9wV3lbZeXNi2nc3CiIKjSHkpGjNQxgZokoTCAfRAkzitWzh5MplBceJC3A1rNNR
         RpWf/7XJW+unWH5emiYCBL949r1cR6q1Kqp8TguxqtachwO5QdjDaM+9PqfO3DV7T0W6
         B9j7QvOTnwEUxPwQ/fSSk3SlSj40L79TkBL6vF43LuZ+3MINx+Cm0BS8rQuIbV1duPbK
         yE3A==
X-Forwarded-Encrypted: i=1; AJvYcCWh8+PDbn/4T6LeusNQY/9+VOHkUc54rUN4XAviBD4K/6t8LhcDeQPaYS7oBey26qYR/SSlVGpmL0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3VXjzT4plbi/K8TL6q1QD/8rS5Bf4orIfxE+iu3vNms4tSeh0
	QglQX290YZ2cF+LCugRWO6oPD27atY3ZQeUhVaB55nVhIRTAKfAAsDfVyTOzKA==
X-Gm-Gg: ASbGncszF/nGFiT+wSJ/4Bf1YZOo/Iwa8H+MtAU5llKgQlKvsXdY8qWtpYmBMb8vNTV
	lDEztXvMWWab3kcQEoDIp5vhGLBxG7AHbAU3f7q8BGeqNOJYacyAR0ErV+aFZZdva/3LaxJw8tA
	H0YvnPFwTtfdP3/O+VvSkuJsdk7CAzO5EWfHPflFou0x8z5CsSOB+zUVO28gmEtdQO/cuSXxBEC
	eKLZ+Ys/9eLPyPuo3y/TNPv6dqszkWIxq8TlTJOxLBxRsgOiynEA0HKxwm83HVGrHxTofPEeBHi
	p5bxRekXPpSRItSWeHyNuXi2t64rq6WOO57y
X-Google-Smtp-Source: AGHT+IHZDCUkVb6KkQggLmytTi/Bc9e4L0SoN/9Y4bEIbQD8e9Ei3Q2gcbNibzYNgvXFukkN4bS6Cg==
X-Received: by 2002:a17:902:d502:b0:220:f509:686a with SMTP id d9443c01a7336-221a10f1e97mr202837705ad.29.1740380563145;
        Sun, 23 Feb 2025 23:02:43 -0800 (PST)
Received: from thinkpad ([36.255.17.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7325c3f4cd3sm16992430b3a.6.2025.02.23.23.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 23:02:42 -0800 (PST)
Date: Mon, 24 Feb 2025 12:32:36 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Sai Krishna Musham <sai.krishna.musham@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com,
	bharat.kumar.gogada@amd.com, thippeswamy.havalige@amd.com
Subject: Re: [PATCH 2/2] PCI: xilinx-cpm: Add support for PCIe RP PERST#
 signal
Message-ID: <20250224070236.nhowwz3uwk2rx4qi@thinkpad>
References: <20250224063046.1438006-1-sai.krishna.musham@amd.com>
 <20250224063046.1438006-3-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250224063046.1438006-3-sai.krishna.musham@amd.com>

On Mon, Feb 24, 2025 at 12:00:46PM +0530, Sai Krishna Musham wrote:
> Add GPIO-based control for the PCIe Root Port PERST# signal.
> 
> According to section 2.2 of the PCIe Electromechanical Specification
> (Revision 6.0), PERST# signal has to be deasserted after a delay of
> 100 ms (TPVPERL) to ensure proper reset sequencing during PCIe
> initialization.
> 
> Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
> ---
> This patch depends on the following patch series.
> https://lore.kernel.org/all/20250217072713.635643-3-thippeswamy.havalige@amd.com/
> ---
>  drivers/pci/controller/pcie-xilinx-cpm.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
> index 81e8bfae53d0..0e31b85658e6 100644
> --- a/drivers/pci/controller/pcie-xilinx-cpm.c
> +++ b/drivers/pci/controller/pcie-xilinx-cpm.c
> @@ -6,6 +6,8 @@
>   */
>  
>  #include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/irqchip.h>
> @@ -568,8 +570,29 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct pci_host_bridge *bridge;
>  	struct resource_entry *bus;
> +	struct gpio_desc *reset_gpio;
>  	int err;
>  
> +	/* Request the GPIO for PCIe reset signal */
> +	reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);

You've defined the polarity as 0x1 in the binding. Which corresponds to
GPIO_ACTIVE_LOW. So if you request the GPIO as GPIOD_OUT_LOW, it means the host
is going to drive the PERST# line as 'high', which corresponds to PERST#
deassert. I don't think you'd want that and if that is what is really happening,
the endpoint state machine would be broken. So I suspect that the polarity of
your PERST# line is wrong.

- Mani

> +	if (IS_ERR(reset_gpio)) {
> +		dev_err(dev, "Failed to request reset GPIO\n");
> +		return PTR_ERR(reset_gpio);
> +	}
> +
> +	/* Assert the reset signal */
> +	gpiod_set_value(reset_gpio, 0);
> +
> +	/*
> +	 * As per section 2.2 of the PCI Express Card Electromechanical
> +	 * Specification (Revision 6.0), the deassertion of the PERST# signal
> +	 * should be delayed by 100 ms (TPVPERL).
> +	 */
> +	msleep(100);
> +
> +	/* Deassert the reset signal */
> +	gpiod_set_value(reset_gpio, 1);
> +
>  	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*port));
>  	if (!bridge)
>  		return -ENODEV;
> -- 
> 2.44.1
> 

-- 
மணிவண்ணன் சதாசிவம்

