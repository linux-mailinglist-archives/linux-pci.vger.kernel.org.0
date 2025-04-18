Return-Path: <linux-pci+bounces-26243-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DDFA93BE0
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 19:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C23803B68BA
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 17:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BDC1C3306;
	Fri, 18 Apr 2025 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vr2ZMnPX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721D1184F
	for <linux-pci@vger.kernel.org>; Fri, 18 Apr 2025 17:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744996888; cv=none; b=UFAUJN1v0MGdrB9fF1H1iF/HP6/5skNBwtgXSS+Fnea/tzrzP3kEtwnUh5o/Iwo6+DGbetKlBtkrPP9rHgi4wSqPbrdKWFFHnr9I0Gdj5KiDCwIe5PMDaJ8Te1CP00CngZb6VLMA8j1Cmftp2FeG4gDZUkzNn2s5txAJr3QNBDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744996888; c=relaxed/simple;
	bh=WFrpL2F8bMxmglS8XNEkfLX3pO8HAqRtehC5w7mS+zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvZLppACR55xZOzEVZVE8/+j/R9wC4st6w0QLbPpchniai5hETiCuZKXPc8dndg3GrcLQi6/uN1nKjn0EfRh/RXv4DdI0/DOa2VvJTJqhDaO9GhNQTw6FXmbVXfRSeIDEzGdYwOQmZkV0JbodweAMdrBzxwhP5H1Vhc3d3DTmfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vr2ZMnPX; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7399838db7fso2109066b3a.0
        for <linux-pci@vger.kernel.org>; Fri, 18 Apr 2025 10:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744996885; x=1745601685; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=diDaW7dZMn7myQugjOx5Zl7LSJCwv2qr5u+uIuIApH8=;
        b=vr2ZMnPXzOnZ9KgTCHSvYSzjH5EPYrMr/+ljy/t9KV6pIQfZGULzdiG8Jj2pAz2Gxu
         BkNpf7mTwP2GWG5X6ryM7EAdg5UZ5awYJ4Xp+NgzIOO3+v+tm+QcMdN1Qbuwz6VzxRyo
         r5rPl8iJUDLIweJe7Y4g62lDVxqHTJ+xN8cWqFdi9nF/J1Pw8DlXIxszti9+/xsfYL9Y
         RbuXEkXNMuBhERAnsAIOHXmhsHzSBFDXADQroPb6zQGHxqnYSoRSTFMbLVWmQweC9lij
         2DS0jta+aaTl9JYYGWN41I18UmiDThg/zOdFOV20T1aagvWeBR9yet4R1mZAyPfWlAEU
         lT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744996885; x=1745601685;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=diDaW7dZMn7myQugjOx5Zl7LSJCwv2qr5u+uIuIApH8=;
        b=aduK7vrIcqBc7seEjavoIuLIEogNoPQbi4kud3nmt2brJnQeiDzlq78DAh1D2AaDXt
         URyjuzocJENY2mTKSXxJ5j2nWj1HkgMB73Vgbovh9/WGvbDso0aqqpLEd8m6eE2AQloe
         HSKP2Z5KD8wFryphvUrbu7sH2JKFCdYfb9KKRRIvXjH5U619BSU2K9qe8floujOnG0Qs
         dqpRdIxFxHzFllYdlXhTtwsCMrDElas9K0r0AG+obTL9bXzKnz0EGvUqjTuPWpySbvs5
         032G5cdfX1pKUCEV0tnWD1qiwnsoiM3DcaENqjj7gJ4gYibUuKSnRV2/s953z8o+pozJ
         TDRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGoDl7l8JPAgWepJVbgRzhzPq2BksEciuJZhhHU7Kjfw43otbcjmfuPOp7WeiTRsm6zDsrJAcCx4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrL2t3BmSG3aU7Sy7uQ+AK4d8l4S0FJ97Pti3wJ0hEYnqYKmXA
	zrhuRuvj14MVTOP7jtzAuQH3in2uWCr+UCxm/MGnLFZ2keO7hlhPMxplcqmzyg==
X-Gm-Gg: ASbGncs8tLJk/hGLG3yKEygmsq5JnzbkD28DfkLt1KuTLsMMuQr5W0m18eLyDFegTR5
	f1oM3e98omYngYq7LyUr76ZVWKZt6vxUtlUnuMLZWClfeiKsgEiR+jO2DgMO5ip6wlDvYbFlMG1
	Oy/vH0iqP8ORFyjP/SobGwaBTsHE2FnLX1cxAM6qa0+SvX+EwBo36HHFBGn8jkfQy+5GCn7c4pJ
	9H5rNqkZN5zwET3AdBooTMLUrD52C2HRbv2jVVSdreMW4s5rtf0njAYj3F8h3zuBkKEszqcK6sN
	QBEhRZC8QIiUEVQuRUfdYh7LCqd70nPktt0StEe4m/uFZ6SXvzQQ
X-Google-Smtp-Source: AGHT+IFUadNaSMrrwOrDcOej0XwrPKaauXBdUtJHJ3I1t9Dp5wnCQzoR0bQRXbgQzLUhtiuZ05wR5A==
X-Received: by 2002:a05:6a00:2d0d:b0:737:cd8:2484 with SMTP id d2e1a72fcca58-73dbe5244cemr5947531b3a.6.1744996885641;
        Fri, 18 Apr 2025 10:21:25 -0700 (PDT)
Received: from thinkpad ([220.158.156.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8c020bsm1843171b3a.28.2025.04.18.10.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 10:21:25 -0700 (PDT)
Date: Fri, 18 Apr 2025 22:51:19 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, 
	bhelgaas@google.com, cassel@kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com, kthota@nvidia.com, 
	mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V3] PCI: dwc: tegra194: Broaden architecture dependency
Message-ID: <vrqkwvwwjrirsrrionoqbdynha3pahabmkhzk5rs5vfb3wugh7@4zagyt7ycbbv>
References: <20250417074607.2281010-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250417074607.2281010-1-vidyas@nvidia.com>

On Thu, Apr 17, 2025 at 01:16:07PM +0530, Vidya Sagar wrote:
> Replace ARCH_TEGRA_194_SOC dependency with a more generic ARCH_TEGRA
> check, allowing the PCIe controller to be built on Tegra platforms
> beyond Tegra194. Additionally, ensure compatibility by requiring
> ARM64 or COMPILE_TEST.
> 
> Link: https://patchwork.kernel.org/project/linux-pci/patch/20250128044244.2766334-1-vidyas@nvidia.com/
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> v3:
> * Addressed warning from kernel test robot
> 
> v2:
> * Addressed review comments from Niklas Cassel and Manivannan Sadhasivam
> 
>  drivers/pci/controller/dwc/Kconfig | 4 ++--
>  drivers/phy/tegra/Kconfig          | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index d9f0386396ed..815b6e0d6a0c 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -226,7 +226,7 @@ config PCIE_TEGRA194
>  
>  config PCIE_TEGRA194_HOST
>  	tristate "NVIDIA Tegra194 (and later) PCIe controller (host mode)"
> -	depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
> +	depends on ARCH_TEGRA && (ARM64 || COMPILE_TEST)
>  	depends on PCI_MSI
>  	select PCIE_DW_HOST
>  	select PHY_TEGRA194_P2U
> @@ -241,7 +241,7 @@ config PCIE_TEGRA194_HOST
>  
>  config PCIE_TEGRA194_EP
>  	tristate "NVIDIA Tegra194 (and later) PCIe controller (endpoint mode)"
> -	depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
> +	depends on ARCH_TEGRA && (ARM64 || COMPILE_TEST)
>  	depends on PCI_ENDPOINT
>  	select PCIE_DW_EP
>  	select PHY_TEGRA194_P2U
> diff --git a/drivers/phy/tegra/Kconfig b/drivers/phy/tegra/Kconfig
> index f30cfb42b210..342fb736da4b 100644
> --- a/drivers/phy/tegra/Kconfig
> +++ b/drivers/phy/tegra/Kconfig
> @@ -13,7 +13,7 @@ config PHY_TEGRA_XUSB
>  
>  config PHY_TEGRA194_P2U
>  	tristate "NVIDIA Tegra194 PIPE2UPHY PHY driver"
> -	depends on ARCH_TEGRA_194_SOC || ARCH_TEGRA_234_SOC || COMPILE_TEST
> +	depends on ARCH_TEGRA || COMPILE_TEST
>  	select GENERIC_PHY
>  	help
>  	  Enable this to support the P2U (PIPE to UPHY) that is part of Tegra 19x
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

