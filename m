Return-Path: <linux-pci+bounces-11705-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 277FA95382D
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 18:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D21EB285096
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 16:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E063C37703;
	Thu, 15 Aug 2024 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OXUsAW6o"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522B21AD401
	for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 16:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723739107; cv=none; b=XZ6SbEF+prMwDIB0V+91ZmPtFTrw861nIlpCwT0JWWwvXM/BK05BrLxE//YD/eJ9yLW0WT1km5YHvyhinV/BTannZbI4glvbctl7Z5QosK37kaEed6AYUMHQW0CP9/LWnpmtUeAGiboTJqI3XnINAYC2CqEt0FIVs3jPadQcYME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723739107; c=relaxed/simple;
	bh=NoNuEvn7tp8Jic3j78xm1TiJXcYt5TFN3+CibXhlwvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7jyUsvQKEoHiSCmpjAt2bwArlIgQb2Q1MXuVnpSjeLDWg82Kgy5pjJo3rrZ8qqO21qbys0TGwGyWumzz7OTtXoNDSHgfdInsQWx5zu7BkMjmY7Q6TvswzQMk5sl1FcDx4jbm6xkUy+1HxtLyhVwKHd3XeNCD4CgqEKyV6K6y8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OXUsAW6o; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d3c0d587e4so804386a91.2
        for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 09:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723739106; x=1724343906; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fkUGIQbwRXV6Lq2jowcyGfccaaCLPz7bWJxbdPn9n30=;
        b=OXUsAW6oISN0a//3b2BnhG1lXxQFPs8FE5ap77EdCEFQVzg5ZwUI1iM4918+CO6tXa
         tQzUsj1Us5HkXHpItX6mF9qR9wJ1bkNuNloN/yCkJJXOTXf/ZVJextekGuc9y6s0CwjN
         AUe35Fu0/RcvqjE8bsOP47a1y0iuUYby7YsJAlawlIMERrDIkrkzQlDUvWiBiZYBmY0W
         3JKohUj2OR0RTlhYy6otHME2j+a4At3MVTIIOVfMsv/tl5cZRl/TE8OFYLplCXJOnphx
         92HCQ8QYoohXTSkOrxZWmBjG22h2VcQ8/fPsFyrruhxM6g58m8WM2xESnWAbDRR8rSnH
         zv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723739106; x=1724343906;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fkUGIQbwRXV6Lq2jowcyGfccaaCLPz7bWJxbdPn9n30=;
        b=Pos8mVJyqszFsrkVIP9F4oiOQ/8QrdjcX+Fx1m7IUbMOlkcyD7r1QRZ5O0PMidf6Zl
         DRW7Xn6Bx9Wk5WX0IVnAw61bEkIxXM8YglmrCpWwzxScREEA2z9MEVuT+tTiTVqKXrST
         bij4+hPyLOQ5JihRKdo51LMMhX33ehL8WFKXaR5G+S9aJUWosxG9qebFgUQw2Q4LlD6l
         Q16lmKzLQARU38Ow51pS9RPwzvt2xleqhI20TOzbj9UadsO6gFzpEiZe4K+D1AvEY0H9
         nbHg+HcsoyIQHdsK/If9T3+kRWJE4ylk5/s+AP4q5wjP0v4jwmLppYdmi06Emvo3WvUn
         Y+KA==
X-Forwarded-Encrypted: i=1; AJvYcCVzYjT3dOlHs/Z/UnVBoGEtsOLoxIpmueh06W9RX4576aUSjjMfkKphiBgf3V2qOcD7P/mLNSRQrimrtI20/H1+hs1Am6y/cDgR
X-Gm-Message-State: AOJu0Yyfzr5gp6GEGEl4rKsu9Had+ElgEaIVNbFUpLmw1U888KhrzJXY
	jTKA+wH0tuvPf+xLbpXS63yZUkenAJTTG2cTrKiu6IKD6wf6LKqFmrRn9+n+pg==
X-Google-Smtp-Source: AGHT+IEf9BWPqw66jhhiHQthvPGpBzvSfL+a+8WG13ziSXvFf+QiYJM8a8qmItiT1VexAhIkaMs9OQ==
X-Received: by 2002:a17:90b:ec1:b0:2bd:7e38:798e with SMTP id 98e67ed59e1d1-2d3dfff5d77mr163380a91.28.1723739105668;
        Thu, 15 Aug 2024 09:25:05 -0700 (PDT)
Received: from thinkpad ([36.255.17.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac7ca30bsm3787522a91.7.2024.08.15.09.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 09:25:04 -0700 (PDT)
Date: Thu, 15 Aug 2024 21:54:59 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] PCI: rockchip: Refactor
 rockchip_pcie_disable_clocks function signature
Message-ID: <20240815162459.GG2562@thinkpad>
References: <20240625104039.48311-1-linux.amoon@gmail.com>
 <20240625104039.48311-3-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240625104039.48311-3-linux.amoon@gmail.com>

On Tue, Jun 25, 2024 at 04:10:34PM +0530, Anand Moon wrote:
> Updated rockchip_pcie_disable_clocks function to accept
> a struct rockchip pointer instead of a void pointer.
> 

Please use imperative tone in all patch descriptions.

s/Updated/Update

> Signed-off-by: Anand Moon <linux.amoon@gmail.com>

With above,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> v4: None
> v3: None
> v2: None
> ---
>  drivers/pci/controller/pcie-rockchip.c | 4 +---
>  drivers/pci/controller/pcie-rockchip.h | 2 +-
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
> index 024308bb6ac8..81deb7fc6882 100644
> --- a/drivers/pci/controller/pcie-rockchip.c
> +++ b/drivers/pci/controller/pcie-rockchip.c
> @@ -272,10 +272,8 @@ int rockchip_pcie_enable_clocks(struct rockchip_pcie *rockchip)
>  }
>  EXPORT_SYMBOL_GPL(rockchip_pcie_enable_clocks);
>  
> -void rockchip_pcie_disable_clocks(void *data)
> +void rockchip_pcie_disable_clocks(struct rockchip_pcie *rockchip)
>  {
> -	struct rockchip_pcie *rockchip = data;
> -
>  	clk_bulk_disable_unprepare(ROCKCHIP_NUM_CLKS, rockchip->clks);
>  }
>  EXPORT_SYMBOL_GPL(rockchip_pcie_disable_clocks);
> diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
> index 27e951b41b80..3330b1e55dcd 100644
> --- a/drivers/pci/controller/pcie-rockchip.h
> +++ b/drivers/pci/controller/pcie-rockchip.h
> @@ -354,7 +354,7 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip);
>  int rockchip_pcie_get_phys(struct rockchip_pcie *rockchip);
>  void rockchip_pcie_deinit_phys(struct rockchip_pcie *rockchip);
>  int rockchip_pcie_enable_clocks(struct rockchip_pcie *rockchip);
> -void rockchip_pcie_disable_clocks(void *data);
> +void rockchip_pcie_disable_clocks(struct rockchip_pcie *rockchip);
>  void rockchip_pcie_cfg_configuration_accesses(
>  		struct rockchip_pcie *rockchip, u32 type);
>  
> -- 
> 2.44.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

