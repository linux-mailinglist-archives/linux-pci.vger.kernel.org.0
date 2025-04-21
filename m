Return-Path: <linux-pci+bounces-26327-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AAFA94D81
	for <lists+linux-pci@lfdr.de>; Mon, 21 Apr 2025 09:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEA3F188FE26
	for <lists+linux-pci@lfdr.de>; Mon, 21 Apr 2025 07:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EC720E32B;
	Mon, 21 Apr 2025 07:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xktvISbV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657D719258E
	for <linux-pci@vger.kernel.org>; Mon, 21 Apr 2025 07:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745221943; cv=none; b=CF2N5TzGnIRFUFOIKc/uW5vq9l+qKaPAkni8lkw8VJRtumWab5iiYSSAe7az/eGt9gbpbdJboB1S4wONLIN99iVCLSj+pO13YIw6bMS3B3lhrIMQUpvQePUK4Z0VDKHFvmGlCcbeU8kq7+csiJYIezS0vnHPrSvsG6VFfMF6ImM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745221943; c=relaxed/simple;
	bh=HgazNE+EAi9aDGd95o1eEJUQz7e8VH3VzN7hQ72AbuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUcF6A/hkFC0r4ptW1YLHCUHR49c/XjEPpTgd0zEmppiaB734zW2qn1Gst2eRW8+aQarx7qBRWwUSgcWkDRTCJEknbqBBbwiPqodgqdC5yC0io4CW40XzBibCWHksm8oFfb/6WMbv6YZS0Bo/yeQM6+GFLzJM4GeyNNOTUhWP8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xktvISbV; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-af523f4511fso3228940a12.0
        for <linux-pci@vger.kernel.org>; Mon, 21 Apr 2025 00:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745221940; x=1745826740; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i1r91vQQdH/uT+tuq1YB5oBLwuGUde4XwY4mg+7LMik=;
        b=xktvISbVizywSOoI0SqmuC9IfvSFR0atEbdJBnQ0UMWAe/yZnKUNojhM9YgcwvZ1Om
         0LTcqugWBhaF+lX+fcNEO+eacz8lGqTFiyqvlXVoomXEuchjIx5o0c+zbIRdETiH70si
         A8SrEfnMk6I1ggGaS3bx1YPLpAG0+anAv1ONPhAq6yhtKoOk8lutj/ONEz0WTviigfAH
         x/AnJUYkVc8V8n4fTdHwe8feEXKdPK8SXE3P/0vVMVSaNat6Lc86EHXsj87g8rS+IFSi
         YUnEyPhznILSdBaHQo7JLv7nOxPBEB/8ptGYfuVJJcMEai77eS5RjTCXmIymIKyXxQ62
         rzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745221940; x=1745826740;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1r91vQQdH/uT+tuq1YB5oBLwuGUde4XwY4mg+7LMik=;
        b=uJg5ILFRzrVrjgEjA7V4IkBV90m7oxk4aklMNFfeY+rojtYAexpsvw/AEqZrwy6Cad
         mgEXGFacshC/sG+ZTrOgVXOQJ7+gGMrWuch0CLGRz3br60VgAyjto/q4Y8t2rlUsdUZq
         /WWJO2WZHiMYW3adQw/b5YuwuIbZZ5jEA6XixBXiacCW33IkfvwrqNY1iMDua2e8Y/py
         cG6MqRembOv1jCO2Pv7GBSjq1TdFkOD5DRxTqGgsoUf42YUfZVnubkUscdkehQIMkWIg
         hBoHFW6n2EYqA4Fv1XGfTOLBhdWmTEmlK/9KKNu+wh5xlxu5OpwhVAffg92b09q9xXpl
         hl2A==
X-Forwarded-Encrypted: i=1; AJvYcCXgiBjSEc2rC+qq8ko+/QQiMLCuBF2qneQXBi5hoMr1BKuSpKgRZ5jNiCowPqCTCZTXxNp4sEOF7tY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyaf78N7SD7w90O1wzS5EdoVgiZDZO80tGU8VAXnKwvziEr8bCN
	0yM11ozSZjUdCkCdVXEu9cmAKclNYkwxBBYd4SF+YYOURGEBqk6M/llXURHoYw==
X-Gm-Gg: ASbGncsZ3ECnUfOUMirek56IipPB96AcsvsmWWK8Ti6onPTxkZh52f+VAlCz27tWahu
	fQcIojaWS1jj20vSgs7NjUVxhQAYLfEYwdNbG5FnE9iYXaMFrL2cCHrDuC/9xik2M+NTEaD2p8f
	w3LsdQ+u2XscOprcYtFN+Zx6vBJMNGJBanxtM0tRA/PHbGXNGYv6P+g/+UabXFX8uL10nxXUqM6
	MEPB/v4cOkjDF/opMKaQJhoFpFndNPxBou2bVrpF7dDC8xTgmTBPts1fntKnNKFRxRpa7C6asaw
	ILKHC7A4ZV/zCE4/bWKStcoUHrSr0vS8mKclCOmNkh4PT+pyQCw=
X-Google-Smtp-Source: AGHT+IGIKaKQIFOu9VYmed0aqabB3yXABSsYwoomYpNUAH0PGzm0zYmtnyQUGmTNI11QtSJ4xMlRDw==
X-Received: by 2002:a05:6a21:1193:b0:1f5:8153:9407 with SMTP id adf61e73a8af0-203cbc746d2mr15311811637.20.1745221939756;
        Mon, 21 Apr 2025 00:52:19 -0700 (PDT)
Received: from thinkpad ([120.60.74.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0db145a8efsm5064684a12.49.2025.04.21.00.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 00:52:19 -0700 (PDT)
Date: Mon, 21 Apr 2025 13:22:11 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: webgeek1234@gmail.com
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: tegra: Allow building as a module
Message-ID: <pgp3cdksefn2z4n2hlyhftbdlfwyx7gbol7q6wdj5j4brux3cw@thts2qcahdw3>
References: <20250420-pci-tegra-module-v1-0-c0a1f831354a@gmail.com>
 <20250420-pci-tegra-module-v1-2-c0a1f831354a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250420-pci-tegra-module-v1-2-c0a1f831354a@gmail.com>

On Sun, Apr 20, 2025 at 09:59:06PM -0500, Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
> 
> The driver works fine as a module, so allow building as such.
> 

In the past, the former irqchip maintainer raised concerns for allowing the
irqchip drivers to be removed from the kernel. The concern was mostly (afaik)
due to not disposing all IRQs before removing the irq_domain.

So Marek submitted a series [1] that added a new API for that. But that series
didn't progress further. So if you want to make this driver a module, you need
to do 2 things:

1. Make sure the cited series gets merged and this driver uses the new API.
2. Get an Ack from Thomas (who is the only irqchip maintainer now).

- Mani

[1] https://lore.kernel.org/linux-pci/20240715114854.4792-1-kabel@kernel.org

> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  drivers/pci/controller/Kconfig     | 2 +-
>  drivers/pci/controller/pci-tegra.c | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 9800b768105402d6dd1ba4b134c2ec23da6e4201..a9164dd2eccaead5ae9348c24a5ad75fcb40f507 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -224,7 +224,7 @@ config PCI_HYPERV_INTERFACE
>  	  driver.
>  
>  config PCI_TEGRA
> -	bool "NVIDIA Tegra PCIe controller"
> +	tristate "NVIDIA Tegra PCIe controller"
>  	depends on ARCH_TEGRA || COMPILE_TEST
>  	depends on PCI_MSI
>  	help
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index b3cdbc5927de3742161310610dc5dcb836f5dd69..c260842695f2e983ae48fd52b43f62dbb9fb5dd3 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -2803,3 +2803,6 @@ static struct platform_driver tegra_pcie_driver = {
>  	.remove = tegra_pcie_remove,
>  };
>  module_platform_driver(tegra_pcie_driver);
> +MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
> +MODULE_DESCRIPTION("NVIDIA PCI host controller driver");
> +MODULE_LICENSE("GPL");
> 
> -- 
> 2.48.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

