Return-Path: <linux-pci+bounces-25749-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9663A872F6
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 19:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3DF117206A
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 17:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3BE1F2BA9;
	Sun, 13 Apr 2025 17:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DWyeEVwh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39221F1936
	for <linux-pci@vger.kernel.org>; Sun, 13 Apr 2025 17:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744565052; cv=none; b=PjvyJ6rHqOw9iug3lzwiHnWL35ofeo2cgrb+XQ6s/sMfrQUabZAU0uX1E/c3yOwrAcKHvGIHOpDOqTMq3xh4Gl6q5iZdQLsWs0YnHUPnESzVvP0op+RG6CznZp7Jw+cFA/a2om0IxtwV/mjSclbdFQ1Vq7vEAh3sN4s8A2yMb4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744565052; c=relaxed/simple;
	bh=6mpwTBXDtKtOWzvRXUOm2Kslk7WOSmE7W5jFMnQJFso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHm2LipHc52fYzFQoNNAfDZnjsAUZuiW4u7mO3NqWVc4kxByCx8s3whFuJB9YDC96YN1U/CN5L11D/wpRPks4lDmedHulZLUbkOOf+C3csUrSN1VdWA3bo/USCrAAD77Vg/CXolC/Xa9jHCguIr70HpKHdEz1H/LfnhYcWgg11I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DWyeEVwh; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7369ce5d323so2807136b3a.1
        for <linux-pci@vger.kernel.org>; Sun, 13 Apr 2025 10:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744565050; x=1745169850; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C1v1jpUQBgB0UDZI3nApqVs2lUM02dJl8JbpTG+9uNg=;
        b=DWyeEVwhXGixlZfohvXxpJH9YX5JBwKXatRdbiVfqM61PAruxpMqt5mZpS+t/ErMQe
         MHNv/74h5zxKe8A4IuWszt+N0NlqSAhxAtCNAmIA8bQ6yNC5hINts9ErDLeaKhZ/ztOl
         iIF/eoC76K0/9A0rGHDclUefaKrK4jrrvHPLuJdB9VWHtjEOja75LCQcQyXsRTSyQ5dn
         U0mpAl0rDajo254vc8IfcChJkDQ44ZrR6xW0lcl9RlwBh+0UW+0ptqJItzkOJBGz0etE
         v5vebRFknE+Hf1FE6iDOHTtXzvvjENywawo1hQM/91duFjlvsLjB8Dyyqde0GEaCDr4U
         Dccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744565050; x=1745169850;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C1v1jpUQBgB0UDZI3nApqVs2lUM02dJl8JbpTG+9uNg=;
        b=QEsNjnSUZ2IlOhnIkwJV54eTwel8vhEEfC4wnUCGEAjfSGD1kwi9A9+5sI5O2JeWH2
         V6EvNjf/vHGKBYXuJflAhMuhDpX7rdxhhaw3G28wSo0q/HkZpxb4NwQjt6rQtIPsByqt
         sCj9FdhAqkTHmXHOZ/jTzB/ozKdxTPvrJmbqG3dLrdj0bDzBZMA9Xwx9LJqUhI+SVSDR
         b2d+3XnakOy+T+yZlWLzGPSyQBU+4l9gXMxsH2RpCCE+bBXs7186ZVFwK34V1HotHmMi
         D5AlE10U1vxDrO6nvArYZ09lvPfwSihYadCxpK7icMKVO51DWXNsejL+T0yMtga/Bmw0
         9gDg==
X-Forwarded-Encrypted: i=1; AJvYcCXS+Y0+sxiqoTuqJc+Oy0ifHMldBSPgQ8fOvPn8qjpei1NQ+Af3TbmhKtQBjAb2cLLpaFLEAewIJHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcXq6QN7vhDmj9jELJt9R2/HM5L7F2DoEPsWGXuPd8ispkvm6i
	kebpJeWX96WYVueM8W92VigtmO5irzD0qHTwuPnnlxF4SBpSNtComQJ1Ug7rAQ==
X-Gm-Gg: ASbGncsQZjJqE2Qh05qFWFK1Fz5w4C0Hh7D8v8CGcewiMz/rSebkdFJC2I3GpMtpghN
	Ed2HpwkMMj4Hme9vCMY8skUoCEC/uuG+0sdqy3LBagGji61UUc2EQw8cz46g9mcF1ne29SfF5jW
	MaWanqPJjsBriKSEIKzaD5MNzJDtzVRA+7Y3oUovuRibsVOsxzDxvPEezITbzJarCmQ0kigyYx/
	Rlp0wYXNqhQGmMXZjzrC7MEo4T5vGEhqwQxk7zLNt5CJrn2um8duhrM5I4y8k6AL8hTSLfdWw5T
	Fafue7wnuhHE7AY4SL49WWtTq45OkqrCOa+QQmPp/VwBZz4T6WeL
X-Google-Smtp-Source: AGHT+IFM+YdieMiL9r0SStfI5t0k0rConT5oK7CRUa4UafAiZdqdwpgSv57rF8TAB6+nr1CsWpsXWQ==
X-Received: by 2002:a05:6a00:2e27:b0:736:53c5:33ba with SMTP id d2e1a72fcca58-73bd12657e3mr11703409b3a.16.1744565049844;
        Sun, 13 Apr 2025 10:24:09 -0700 (PDT)
Received: from thinkpad ([120.60.137.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd2328435sm5153419b3a.157.2025.04.13.10.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 10:24:09 -0700 (PDT)
Date: Sun, 13 Apr 2025 22:54:03 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Janne Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>, 
	Sven Peter <sven@svenpeter.dev>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: Re: [PATCH v3 13/13] PCI: apple: Add T602x PCIe support
Message-ID: <3mwdadqtt7733nq2okj47a5rsztgxuip3ukfsy44l7hhh2z7o5@njrv5c5l5fh7>
References: <20250401091713.2765724-1-maz@kernel.org>
 <20250401091713.2765724-14-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250401091713.2765724-14-maz@kernel.org>

On Tue, Apr 01, 2025 at 10:17:13AM +0100, Marc Zyngier wrote:
> From: Hector Martin <marcan@marcan.st>
> 
> This version of the hardware moved around a bunch of registers, so we
> avoid the old compatible for these and introduce register offset
> structures to handle the differences.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Acked-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Tested-by: Janne Grunau <j@jannau.net>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/pcie-apple.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> index 847cba753d28d..5b85d9497070c 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -124,6 +124,13 @@
>  #define   PORT_TUNSTAT_PERST_ACK_PEND	BIT(1)
>  #define PORT_PREFMEM_ENABLE		0x00994
>  
> +/* T602x (M2-pro and co) */
> +#define PORT_T602X_MSIADDR	0x016c
> +#define PORT_T602X_MSIADDR_HI	0x0170
> +#define PORT_T602X_PERST	0x082c
> +#define PORT_T602X_RID2SID	0x3000
> +#define PORT_T602X_MSIMAP	0x3800
> +
>  #define PORT_MSIMAP_ENABLE	BIT(31)
>  #define PORT_MSIMAP_TARGET	GENMASK(7, 0)
>  
> @@ -158,6 +165,18 @@ static const struct hw_info t8103_hw = {
>  	.max_rid2sid		= 64,
>  };
>  
> +static const struct hw_info t602x_hw = {
> +	.phy_lane_ctl		= 0,
> +	.port_msiaddr		= PORT_T602X_MSIADDR,
> +	.port_msiaddr_hi	= PORT_T602X_MSIADDR_HI,
> +	.port_refclk		= 0,
> +	.port_perst		= PORT_T602X_PERST,
> +	.port_rid2sid		= PORT_T602X_RID2SID,
> +	.port_msimap		= PORT_T602X_MSIMAP,
> +	/* 16 on t602x, guess for autodetect on future HW */
> +	.max_rid2sid		= 512,
> +};
> +
>  struct apple_pcie {
>  	struct mutex		lock;
>  	struct device		*dev;
> @@ -425,6 +444,7 @@ static int apple_pcie_port_setup_irq(struct apple_pcie_port *port)
>  	/* Disable all interrupts */
>  	writel_relaxed(~0, port->base + PORT_INTMSK);
>  	writel_relaxed(~0, port->base + PORT_INTSTAT);
> +	writel_relaxed(~0, port->base + PORT_LINKCMDSTS);
>  
>  	irq_set_chained_handler_and_data(irq, apple_port_irq_handler, port);
>  
> @@ -865,6 +885,7 @@ static int apple_pcie_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id apple_pcie_of_match[] = {
> +	{ .compatible = "apple,t6020-pcie",	.data = &t602x_hw },
>  	{ .compatible = "apple,pcie",		.data = &t8103_hw },
>  	{ }
>  };
> -- 
> 2.39.2
> 

-- 
மணிவண்ணன் சதாசிவம்

