Return-Path: <linux-pci+bounces-10685-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAE593AAF2
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 04:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06D73B2350C
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 02:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6FD79F0;
	Wed, 24 Jul 2024 02:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n5y6AsFx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7335B18040
	for <linux-pci@vger.kernel.org>; Wed, 24 Jul 2024 02:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721787188; cv=none; b=ZmN0P9xwrXuimIimhz1WRyHggT7f8R/ZxqNJn+CtCJ7a7eTxa0fjQV8c4D63olcvlJnUH0kO1E3s/Zznxp303KbW5EdSvcAxTqMfzJPpHHGeAq3xtJeHERTsbS/2xxozK/sa3RBu4hLm2ip3bx1UWHLEIIXaNc1xsQqCLFoi/go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721787188; c=relaxed/simple;
	bh=zxRx6PS/BB5neEVqroTn3GBIguriVgxJTg1YuD2hYqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7FbFfrt2n8sKXuXw58t2+IpzdkTHIcKKj016OwoGD2qZ7JC9A3VEN50q9SCxk3GY7TDmzl/hjpGMtRiRD6pbuECi2JLGarzDZ1eunIgQvOHNiLOCBOQvIZjH+1PiR3L+4SVi5xPs3p4W6YRQIRDX3S3X+REimGchvmOEs0dhGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n5y6AsFx; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52f04150796so3991868e87.3
        for <linux-pci@vger.kernel.org>; Tue, 23 Jul 2024 19:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721787184; x=1722391984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h54jAPwrOx54tpaQLg9+LwjbtZwsdB+FHhiP8Skn4II=;
        b=n5y6AsFxK2tTOlcCGBI7fZDDrKjL7gzf24y/a+YBD2RvytwBPve9Xk/mDVkR7TnPev
         1aT3omzfwlMtM/Of84MOVafiLXlcXzaFdhjJZEhGFt5PlXdbL+2d9hHy9+ncBRaTW4IL
         l0qGhakTD2n4Kx0wk/iDbpStenIqiFZY7xut07QSDKFQIncJL7IBbT7Dc7lXMgGHvrPA
         35vaEZ3OZ/NkCnBs+JKn7z+WhfUkzhgM/YnAXXE6nqq4rY69zyQJqEH553sErQ/liXjd
         b7pFb71Q4JnzyS14MXrXa1OSqel2cHLLDUv5a1lZR482zLjhJFsGdJyAejnAIioj0J0E
         CTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721787184; x=1722391984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h54jAPwrOx54tpaQLg9+LwjbtZwsdB+FHhiP8Skn4II=;
        b=xBVoLrxUZ4x3zDCuXDZmF1g/IxDY4Ib6fMAwRQq4CG+kxxaQR+lzqq9EoiEL4zjT6G
         0NHyKJKiJ4urMMAJThvRH/Pq4B4kDUHGroCW1CFpdnCIrTunpPMmuKZNDI6YUkOZyGdv
         V+EycCiIiMjNOrPsj7Ylzz5HNS163E9cnpY3q4RzlxcOQ+y42o95U2BR60rttBptzLLy
         VjwsMUddWZzEvDYslF0TLC2Ard6roC7aJzWpMo9pzmtPMArO50JRLxbQzVcCZBIc73Ry
         /aWn0SxFl6oKk0LtRBrF19EFV16yU/C0WDrnT3nWfe8AoKNxYE7y3QWIpJcfHzLmpVWF
         GlNA==
X-Forwarded-Encrypted: i=1; AJvYcCVpwVR6BNtu7ETwX/0uj0MMc2hTBnVM48w/+nJLucbG9mCV2C/GIPEP14JoD2wQlSMqcq7ydtS9ykXkea3LGsa54KW+jJmby9eX
X-Gm-Message-State: AOJu0YzqMSeDI2ID7/5qfs6LpDkAmKfEnAFdSrWI6VZ2weqG7RbWR8ba
	Yful2UpvKSNHNUbhzG9fVVIQlFgqqZXNmHDCnwJtJStBkxLdO2jGCEDol2G1c9k=
X-Google-Smtp-Source: AGHT+IGe2gdDtP0jYuva3hSreTxdFinLmhIMcyMOvFMx/S7foul0J6nvmcN6d9USXnjaYe/LViYKnw==
X-Received: by 2002:a05:6512:3403:b0:52c:e180:4eac with SMTP id 2adb3069b0e04-52fcefea667mr362218e87.9.1721787184385;
        Tue, 23 Jul 2024 19:13:04 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fc51c5af9sm483686e87.148.2024.07.23.19.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 19:13:03 -0700 (PDT)
Date: Wed, 24 Jul 2024 05:13:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Mayank Rana <quic_mrana@quicinc.com>
Cc: will@kernel.org, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, 
	bhelgaas@google.com, jingoohan1@gmail.com, manivannan.sadhasivam@linaro.org, 
	cassel@kernel.org, yoshihiro.shimoda.uh@renesas.com, s-vadapalli@ti.com, 
	u.kleine-koenig@pengutronix.de, dlemoal@kernel.org, amishin@t-argos.ru, thierry.reding@gmail.com, 
	jonathanh@nvidia.com, Frank.Li@nxp.com, ilpo.jarvinen@linux.intel.com, 
	vidyas@nvidia.com, marek.vasut+renesas@gmail.com, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, quic_ramkri@quicinc.com, quic_nkela@quicinc.com, 
	quic_shazhuss@quicinc.com, quic_msarkar@quicinc.com, quic_nitegupt@quicinc.com
Subject: Re: [PATCH V2 0/7] Add power domain and MSI functionality with PCIe
 host generic ECAM driver
Message-ID: <rzf5jaxs2g4usnqzgvisiols2zlizcqr3pg4b63kxkoaekkjdf@rleudqbiur5m>
References: <1721067215-5832-1-git-send-email-quic_mrana@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1721067215-5832-1-git-send-email-quic_mrana@quicinc.com>

On Mon, Jul 15, 2024 at 11:13:28AM GMT, Mayank Rana wrote:
> Based on previously received feedback, this patch series adds functionalities
> with existing PCIe host generic ECAM driver (pci-host-generic.c) to get PCIe
> host root complex functionality on Qualcomm SA8775P auto platform.
> 
> Previously sent RFC patchset to have separate Qualcomm PCIe ECAM platform driver:
> https://lore.kernel.org/all/d10199df-5fb3-407b-b404-a0a4d067341f@quicinc.com/T/                                                                                                      
> 
> 1. Interface to allow requesting firmware to manage system resources and performing
> PCIe Link up (devicetree binding in terms of power domain and runtime PM APIs is used in driver)
> 2. Performing D3 cold with system suspend and D0 with system resume (usage of GenPD
> framework based power domain controls these operations)
> 3. SA8775P is using Synopsys Designware PCIe controller which supports MSI controller.
> This MSI functionality is used with PCIe host generic driver after splitting existing MSI
> functionality from pcie-designware-host.c file into pcie-designware-msi.c file.

Please excuse me my ignorance if this is described somewhere. Why are
you using DWC-specific MSI handling instead of using GIC ITS?

> Below architecture is used on Qualcomm SA8775P auto platform to get ECAM compliant PCIe
> controller based functionality. Here firmware VM based PCIe driver takes care of resource
> management and performing PCIe link related handling (D0 and D3cold). Linux VM based PCIe
> host generic driver uses power domain to request firmware VM to perform these operations
> using SCMI interface.

-- 
With best wishes
Dmitry

