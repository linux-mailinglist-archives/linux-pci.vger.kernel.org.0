Return-Path: <linux-pci+bounces-27094-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4478AAA762C
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 17:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D2287AC439
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 15:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC502571BD;
	Fri,  2 May 2025 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xsf9AdLd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A2E2550D4
	for <linux-pci@vger.kernel.org>; Fri,  2 May 2025 15:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746200198; cv=none; b=TifsJW87YNEPDwOVKtzgGMacE+zu6H6TrP7P1b1crnELx8Ym7GhdvfG8YxsG+MmVhDz31H4GxTVNhyCFSMxGj/BxiBgCkRyaL1Rz19Hx6IoRF6eeFrwxZjQmH9aydgiX3aozaFiJljJhupPMiCKgDna89kcjpxiMYqeFmYed3OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746200198; c=relaxed/simple;
	bh=3BAV8Vn4xGGDhP96Ad7to89CEGi5VAjBKGPATV/9yrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+lANlLOC4Hp2bDUFp2b7qENm0XnvxGk2rbohH77d39xlANbZ6mdRS07qSzkiCZ3qUZZIHRiAgBvw+ZX0/Ha59/6+8A7OmfFUAIYS0BAoIA9FbtCSd8kSmW0OhNH3GHtWHq5jK40mFnLVuayJwP2ut2yse9iDVn5QZskUQJAF3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xsf9AdLd; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-739525d4e12so2328663b3a.3
        for <linux-pci@vger.kernel.org>; Fri, 02 May 2025 08:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746200196; x=1746804996; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ID/3gEVRaELChbZF1u1wTlxxoC3hlcOuUi/IoEPjJzQ=;
        b=Xsf9AdLd1uXRrktRw3bXyCetKFazuNAiY6MmKMhw7Huoxf0UKsVfY99NtNrhyzvifo
         5HS7lXf3kumJPcB/qgOMCs3FFBQ88AWfmR5ivPRWWCWzTRbqRfGp4WnCBGi/6o6pox5R
         60L6MlKFew+SE3DkrLzb7FdoangsNxGKLiazJugK8ukzfFyzSuK17DALS3aa7P2P+cTs
         I/zLDFCUHB+G0zZZpJw6Fku+hueyrOb/vc5hHOphWgg1RTXJ2ZgVT9hGLpxOzPqc90tn
         xFmCiebpWfwB1jEnK4xpLECVnMo8xSzKH8+SvMZKl5Q/ZxqM/jPgS/hmlotpLbuJt4Mq
         +Mdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746200196; x=1746804996;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ID/3gEVRaELChbZF1u1wTlxxoC3hlcOuUi/IoEPjJzQ=;
        b=HtWUN9iqEA67mlofLACWTEb3WfKzfqPnkZb4wDjzINVkVcxuT0zbigc0DXrNhAbYue
         /el7385zAPV83p1IPEWVou7DaSe9sHU7Mf9PxRdLiaXeYxeSalXF2gk5vvG+5lamnL00
         6NetGCZR74NFJQfR52ILGmP9a9z8NCvhl1+R4apO49/QhXTGAHkdr5+WI/XMFVNy/0Ra
         QPnQQ22c3ant5HcgW8uwdfaG9nQ50E1iE4l3cmMQ9TjA2sEqJPgTZ8aPNk/TJoZEHsS0
         097b1lio2CSmLkbdoW+4E3bGad80Fy8TpBvk48zcNQCeqf892amCT9QVFytMC47zae8I
         t5Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUqND87rG0vNaXXWFUKk1NuTfORFkZ/FUwemp3SRFXB5T0PxUpseU7IuMUxgkH6DhD1mIsKHcMVrcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHwS/z5Ngpf/b4h1yJCtEg/noEubokmYXNBz/DWsadve7smpve
	ZsDg+mUZ7CH4iExZsgDL50KjkgaTaI8mInF6XJhQ8eu9QLBe85ybLpEvNcy3gQ==
X-Gm-Gg: ASbGncsyk+YmfbmDBmYBtY92byyXIOAE990GpGSWD+MWvSdIZPzcrx6t0ggVqdw6y5d
	Wp1nwTQYsND/I6zJe7YJGd4J8G6aqv1KDh4qPbRTn+JtyaAlgSpcNXrh0xSJTsBNGew0WF0wuYm
	7bFPlDfmEBpI8qwDtU0T0O75y/hoMYLuZ+eEBHHI/WoMOdIGeMAZXJkaKnKVWIytz+iLqlozaIs
	Ch3z5hDPDJgc2Ak8MKBoZW3ZqVo6j+KXIO1m6QiFg2Ge1Xl9sDE94H9WLM/fBXD/Ly5R2CtwHaO
	8f0KYp85TMqruq2FkdDabut7PvLZxFW/sHMYbhxAyh5Ipw5JWnDwxA==
X-Google-Smtp-Source: AGHT+IFb0CRE5XpBeKP67vibx/Q9XRU6cVwp3u+88sAT+xVnNz7vp/obg79d1d6ykFtM6a7ldH9EkA==
X-Received: by 2002:a05:6a21:3943:b0:1ee:dcd3:80d7 with SMTP id adf61e73a8af0-20cdc0f55fdmr5042626637.0.1746200195776;
        Fri, 02 May 2025 08:36:35 -0700 (PDT)
Received: from thinkpad ([220.158.156.122])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fb3b7cb28sm913569a12.42.2025.05.02.08.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 08:36:35 -0700 (PDT)
Date: Fri, 2 May 2025 21:06:31 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com, 
	jingoohan1@gmail.com, cassel@kernel.org, robh@kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Standardize link status check to return bool
Message-ID: <7oxb4uviwnpnkdjacihwjrzqhxpd7nk244ivpwml5372jsiimm@5hgnnfjlfkr3>
References: <20250428171027.13237-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250428171027.13237-1-18255117159@163.com>

On Tue, Apr 29, 2025 at 01:10:24AM +0800, Hans Zhang wrote:
> 1. PCI: dwc: Standardize link status check to return bool.
> 2. PCI: mobiveil: Refactor link status check.
> 3. PCI: cadence: Simplify j721e link status check.
> 

Thanks for the cleanup. Looks good to me except the redundancy conversion that
Niklas noted. So with that change,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Hans Zhang (3):
>   PCI: dwc: Standardize link status check to return bool.
>   PCI: mobiveil: Refactor link status check.
>   PCI: cadence: Simplify j721e link status check.
> 
>  drivers/pci/controller/cadence/pci-j721e.c             | 6 +-----
>  drivers/pci/controller/dwc/pci-dra7xx.c                | 2 +-
>  drivers/pci/controller/dwc/pci-exynos.c                | 4 ++--
>  drivers/pci/controller/dwc/pci-keystone.c              | 5 ++---
>  drivers/pci/controller/dwc/pci-meson.c                 | 6 +++---
>  drivers/pci/controller/dwc/pcie-armada8k.c             | 6 +++---
>  drivers/pci/controller/dwc/pcie-designware.c           | 2 +-
>  drivers/pci/controller/dwc/pcie-designware.h           | 4 ++--
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c          | 2 +-
>  drivers/pci/controller/dwc/pcie-histb.c                | 9 +++------
>  drivers/pci/controller/dwc/pcie-keembay.c              | 2 +-
>  drivers/pci/controller/dwc/pcie-kirin.c                | 7 ++-----
>  drivers/pci/controller/dwc/pcie-qcom-ep.c              | 4 ++--
>  drivers/pci/controller/dwc/pcie-qcom.c                 | 2 +-
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c            | 2 +-
>  drivers/pci/controller/dwc/pcie-spear13xx.c            | 7 ++-----
>  drivers/pci/controller/dwc/pcie-tegra194.c             | 2 +-
>  drivers/pci/controller/dwc/pcie-uniphier.c             | 2 +-
>  drivers/pci/controller/dwc/pcie-visconti.c             | 2 +-
>  drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c | 9 ++-------
>  drivers/pci/controller/mobiveil/pcie-mobiveil.h        | 2 +-
>  21 files changed, 34 insertions(+), 53 deletions(-)
> 
> 
> base-commit: 286ed198b899739862456f451eda884558526a9d
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

