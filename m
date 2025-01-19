Return-Path: <linux-pci+bounces-20106-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE201A16059
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 06:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 182CE16507C
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 05:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805CB3B1A4;
	Sun, 19 Jan 2025 05:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZhdXxjZF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFE52B9A5
	for <linux-pci@vger.kernel.org>; Sun, 19 Jan 2025 05:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737264696; cv=none; b=BYkAsGqFUMhUxm731KuQ7XenP5rYmkmS673q3yFSo2CAn7Ki3Mp/hFijF7p/I9haSYqdlKXttVT2KlUpCASVBKXFPl+AzsDtDJZc5g2dGuLzwGL0DGhfbe77EYZTUcB997FUTgROgxNb1xB3hjtVSe5TnRVWsGfY/qMq944/Rj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737264696; c=relaxed/simple;
	bh=sZVec5zyaQ28R8dWm5xIlFPn5pf5o06477N1bBWRZ10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVL6Eu28CF0YWyYEDqYAzjkvg9nYQN46nijfrf0X3OhjiCoWgsLwtuz2d9aunQvLffiG2xumBI/0Je6mMsfTHMQrn4tsYntrgLWKg7cbysQrPIHt5E97GTz9y1CvNfGcl5FiNqPGAXE63Pd+hNLYezkhqb/hwsJUg0yHZ5pf+rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZhdXxjZF; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2164b662090so62329245ad.1
        for <linux-pci@vger.kernel.org>; Sat, 18 Jan 2025 21:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737264694; x=1737869494; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+LqTDeuHcZESK6dHmmDPyP62nMxYHWQwkfufkYuAh5M=;
        b=ZhdXxjZFOEvA5Vd1h1dmZqaP50zw1Ti+LjiY+YcW/EY78n2RB3rTodSNq8aSnXm9fo
         aIpe9wjeJPpouvRdLNm7g8JsNqQxEEx9QZs1kaVzSKWgBEXr/wIBH2ryX3LOkgde6h2s
         H4F4yKD4NiUgo+niyLK9SHIHDD7cb/Xk851oKZv6TY9TQpRazTRpkPkv9XcPLpe0YVEd
         V+I9AIfRYCVCVTDTB8X6SlIpZ7EPDu9y+QOGCBfo1bi1HB3aHJOzv7ehZLLgvaFH+Tnc
         YI7GyYXhXYhpBo+6CQ7WOirIjrC0ly/Ih1oaaaO8FCStQADiL9ixNSG9w9yTukwpGF7V
         enEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737264694; x=1737869494;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+LqTDeuHcZESK6dHmmDPyP62nMxYHWQwkfufkYuAh5M=;
        b=I4+Sm0yY5iXZ0D9K+2/WgUTB37/1yS/hpForIAGbyj3o3n+kiqS0XMCWWzdo1tzsr6
         4v6lQwqFs7e/zE+yqYJeDZs6BxOXF4AEHFfCgb/Qbj5V7/hO8ywdRwLurlo1KyuDx/qA
         RqdsHVUF9n8Q9O+mttBZfkoaLpBoi2gwM7nHnYnQ9QNiZzQW0ULAhqK4pIDkjFNhu/0t
         TvRAhrCqG/5YC1Fsfxy2z7NnVkXEeWtTOU+13dyqD4Md3tvJDk9DbHJCZcG6egqOGR2a
         DBGv5Wb1ySTUL7zl3k99xZABkK691VIHOldHfuaS1Ap7DDZ4Ul1HhdBPa3deOUPFuBok
         uE3g==
X-Forwarded-Encrypted: i=1; AJvYcCUaDWMzPbk//jR7ZpZemsjDQSCUNK77TCAg03ufHchnj9Kp4N1qrO3JjHmB92BTKsyshIgoG5CY6D8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh4pxeP6+rqu4CeM+Y94xzzUc2sv9Pz80PEx4feDrhZsFx4ZLr
	AQQc30fZ24G6/ko1uGrvz/bc9IRZ3rRWCpkIZiCnFBX6RLHeY+6yAQUtcbbrQg==
X-Gm-Gg: ASbGncvx+nmSqFj2cWsEDW34ud3VZAyjTrCBxl2+SbXgUoFOi0DXlwKgwfxZOzkGSVb
	sor185OeE6HMfJfbOwuvFRvU9/qNpuPLOXo4q2lmRMaUwmj8A+tUtWW4huonL7ZncmjhRpKjFna
	jvdrXdE+pITJEVAU9BAH7vQ8gTKP8G+vCXJd/4t5+9yUuGaBkRGNZl1g7gyHz1R5HaY6QnY9MgA
	OjTYn5rP2cVMv3HaMszB6eSG3n8Xkl2MaXOWHXB9YZHq0jLF+L9uwIk1rNM7O06itSbpvc1f10N
	l/Bg7Q==
X-Google-Smtp-Source: AGHT+IFuZr19j90VMfbZmyjUf53TYQloErYk54p7LYRG5hafCWuZsFHW0romtwbNkBx8JovrscU1wQ==
X-Received: by 2002:a17:903:703:b0:216:31aa:1308 with SMTP id d9443c01a7336-21c355e35c9mr102298195ad.34.1737264693896;
        Sat, 18 Jan 2025 21:31:33 -0800 (PST)
Received: from thinkpad ([120.60.143.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2cd609aesm39148195ad.0.2025.01.18.21.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 21:31:33 -0800 (PST)
Date: Sun, 19 Jan 2025 11:01:28 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Udit Kumar <u-kumar1@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 4/6] PCI: keystone: Describe resizable BARs as
 resizable BARs
Message-ID: <20250119053128.h6jvfkfjaj3ne337@thinkpad>
References: <20250113102730.1700963-8-cassel@kernel.org>
 <20250113102730.1700963-12-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250113102730.1700963-12-cassel@kernel.org>

On Mon, Jan 13, 2025 at 11:27:35AM +0100, Niklas Cassel wrote:
> Looking at "12.2.2.4.15 PCIe Subsystem BAR Configuration" in the
> AM65x TRM:
> https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf
> 
> We can see that BAR2 and BAR5 are not Fixed BARs, but actually Resizable
> BARs.
> 
> Now when we actually have support for Resizable BARs, let's configure
> these BARs as such.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pci-keystone.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 63bd5003da45..fdc610ec7e5e 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -966,10 +966,10 @@ static const struct pci_epc_features ks_pcie_am654_epc_features = {
>  	.msix_capable = true,
>  	.bar[BAR_0] = { .type = BAR_RESERVED, },
>  	.bar[BAR_1] = { .type = BAR_RESERVED, },
> -	.bar[BAR_2] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
> +	.bar[BAR_2] = { .type = BAR_RESIZABLE, },
>  	.bar[BAR_3] = { .type = BAR_FIXED, .fixed_size = SZ_64K, },
>  	.bar[BAR_4] = { .type = BAR_FIXED, .fixed_size = 256, },
> -	.bar[BAR_5] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
> +	.bar[BAR_5] = { .type = BAR_RESIZABLE, },
>  	.align = SZ_1M,
>  };
>  
> -- 
> 2.47.1
> 

-- 
மணிவண்ணன் சதாசிவம்

