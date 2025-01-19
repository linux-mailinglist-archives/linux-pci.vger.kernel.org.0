Return-Path: <linux-pci+bounces-20108-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C12A1605B
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 06:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91AC43A61BC
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 05:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1FC3B1A4;
	Sun, 19 Jan 2025 05:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JO0fvKKa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D432B9A5
	for <linux-pci@vger.kernel.org>; Sun, 19 Jan 2025 05:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737264822; cv=none; b=CR1roz4HZETksoiTaMOLIDwa0uBCUnSUxosXy2bBKUUhDjyFzZi2DQb7eAXVtqxysEXQVXD/g9MJ9fz+sWs/wH0U0nPY0XxQe92hHkQ8KS0UQZXRTVLGm2lYZHTct5WrzUt9cN+F3ZD82PTB1mvfcFPxdZ4G/0Coc4mAX7WWZNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737264822; c=relaxed/simple;
	bh=h0ovjOJKOd0lWfjk/lo1602YaNHV5ReMyJNzMJP5uUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmvVQgN191jhNvkTwXaR9YlcQDugvCrQrR/erQMFFry+95YUqyT6cRKPFDsir3Z518VBhgf5cUX26yqGSCEDNSQwdqi2xsKRtmoSheGwi1cMZ/AiH52zDjEr3m5nJryBoE3XPhGqvi/U8lH1xunoEL8IhD5no0SuOVbHGdvv61I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JO0fvKKa; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21631789fcdso56037465ad.1
        for <linux-pci@vger.kernel.org>; Sat, 18 Jan 2025 21:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737264820; x=1737869620; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4vI0iAGnzu7S5oTjzbVtlW1pPkklWEuLHOcVvGs/EI0=;
        b=JO0fvKKaCsKREkeswzbyv0EU5Zd3BGxy7JehP0diSHpxacTbM8Bvh/obSTw/+5dKy6
         FRgwRezpkK/4YEMQ9swHhMWOhzw7hJiZ6btzE4UuoWp7rQGvg0ZHTCy/LYLM56cp6r1t
         1PXmmnlyM2QNIuI0BcpgXf/t2DAxs+EyQ6OrIfXCftuxnUnbr0VYd+SXbkfMlnCV8pO8
         6Oj7ChQhJO6Mec2Oz0Hnr6ezqA5UNz4BYtVVYwbYJ/ls8CJ/hEOzci3X7BUCpnDKYEIt
         w0/xuG4ZHTgkmgIWkAWUlvS2YucW3i/Ll+vtQ+u3RlKU7R56yJaKdAkep6NTJ8CdE1Ms
         n9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737264820; x=1737869620;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4vI0iAGnzu7S5oTjzbVtlW1pPkklWEuLHOcVvGs/EI0=;
        b=eEWFxC3Q+5dI0liBRpmDTLrzXlo73CEmeOS7f5F0nJ9DedWLNgZvphwbo8dh4Gzidi
         XpfAyy5+AIGNkkVZueVWc5BU9zknTkFOIuAAT4KyGuyzvkR9jo9kvNLTSy9h1vhQamsa
         JcF9thajTAukJsPqfEt9oxNkg3rOGhUIP4FI+KjWz1sLL5qPqZXJbvWhrvqSvaKsy2aE
         IEqoCEE+43o74heu7a4JcXgfvJnv+dZm0Y2FeVyCGoTQdJG8d2hktUP9RaxEEtozuixt
         6PyykWyXWyr5f+oNhlaxUqX2kWk+YjCARFT0RXRZ8ItNdD1ycDT0xH1kJJntVLVP6mMl
         q52g==
X-Forwarded-Encrypted: i=1; AJvYcCXnttBczrDhx2iNWiXIrDke4DCOTSE/AkOlMtIcR+pxIRGATSQ8LT0scH10pZkxxEuyQq7VdMDAY3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzeteyg/JS7dQWgLcRj3ay9Dnga9XH7lB4bvfnFQKlQixzX355+
	V7oiS1sVdDyA0XHdmen6/hHAQX90tpUaPt/HoMjP7RU/12YlHHiFN2pwDhb8QA==
X-Gm-Gg: ASbGnctHJdLfYGHhTlLFZrzGpEJ+kXZuV7slKcJPtvpvXRD6cPgp/m9pxbY+U54JoKE
	YmWnL6/O1kNZS7cm7tMJQKpyMSPjo9r6anxMAX99j8q6DPauf+mK6URIlO/mVnX08W1GkCKfWcu
	904ZquR/C/yR7ugoFfBV8lmYMhrMi/Fqlb7uhsunb1cebWPReqIhbNb2nL4fPdKtqU2pOXgdTjV
	8BQFtwGCDRVgn58UOeoumJoRSrQ7cgojpu6sjXEXhKutF+PEwJsJmJ5CLsq0DFgZ1De6ozr9Ytk
	Xt4gEw==
X-Google-Smtp-Source: AGHT+IF9G2b79a1VfoH6m4pswjFmDLBJqbv/WfnV9XujUXsWzuIF8RjvzijezxL13+j7j+Aah4HtiA==
X-Received: by 2002:a05:6a00:3ccf:b0:728:f21b:ce4c with SMTP id d2e1a72fcca58-72db1b652e2mr14312654b3a.5.1737264819679;
        Sat, 18 Jan 2025 21:33:39 -0800 (PST)
Received: from thinkpad ([120.60.143.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab7f069esm4625678b3a.28.2025.01.18.21.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 21:33:39 -0800 (PST)
Date: Sun, 19 Jan 2025 11:03:34 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Udit Kumar <u-kumar1@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 6/6] PCI: dw-rockchip: Describe resizable BARs as
 resizable BARs
Message-ID: <20250119053334.tgp7yycky5s6ub2v@thinkpad>
References: <20250113102730.1700963-8-cassel@kernel.org>
 <20250113102730.1700963-14-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250113102730.1700963-14-cassel@kernel.org>

On Mon, Jan 13, 2025 at 11:27:37AM +0100, Niklas Cassel wrote:
> Looking at "11.4.4.29 USP_PCIE_RESBAR Registers Summary" in the rk3588 TRM,
> we can see that none of the BARs are Fixed BARs, but actually Resizable
> BARs.
> 
> I couldn't find any reference in the rk3568 TRM, but looking at the
> downstream PCIe endpoint driver, rk3568 and rk3588 are treated as the same,
> so the BARs on rk3568 must also be Resizable BARs.
> 
> Now when we actually have support for Resizable BARs, let's configure
> these BARs as such.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 22 +++++++++----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index ce4b511bff9b..6a307a961756 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -273,12 +273,12 @@ static const struct pci_epc_features rockchip_pcie_epc_features_rk3568 = {
>  	.msi_capable = true,
>  	.msix_capable = true,
>  	.align = SZ_64K,
> -	.bar[BAR_0] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
> -	.bar[BAR_1] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
> -	.bar[BAR_2] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
> -	.bar[BAR_3] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
> -	.bar[BAR_4] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
> -	.bar[BAR_5] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
> +	.bar[BAR_0] = { .type = BAR_RESIZABLE, },
> +	.bar[BAR_1] = { .type = BAR_RESIZABLE, },
> +	.bar[BAR_2] = { .type = BAR_RESIZABLE, },
> +	.bar[BAR_3] = { .type = BAR_RESIZABLE, },
> +	.bar[BAR_4] = { .type = BAR_RESIZABLE, },
> +	.bar[BAR_5] = { .type = BAR_RESIZABLE, },
>  };
>  
>  /*
> @@ -293,12 +293,12 @@ static const struct pci_epc_features rockchip_pcie_epc_features_rk3588 = {
>  	.msi_capable = true,
>  	.msix_capable = true,
>  	.align = SZ_64K,
> -	.bar[BAR_0] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
> -	.bar[BAR_1] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
> -	.bar[BAR_2] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
> -	.bar[BAR_3] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
> +	.bar[BAR_0] = { .type = BAR_RESIZABLE, },
> +	.bar[BAR_1] = { .type = BAR_RESIZABLE, },
> +	.bar[BAR_2] = { .type = BAR_RESIZABLE, },
> +	.bar[BAR_3] = { .type = BAR_RESIZABLE, },
>  	.bar[BAR_4] = { .type = BAR_RESERVED, },
> -	.bar[BAR_5] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
> +	.bar[BAR_5] = { .type = BAR_RESIZABLE, },
>  };
>  
>  static const struct pci_epc_features *
> -- 
> 2.47.1
> 

-- 
மணிவண்ணன் சதாசிவம்

