Return-Path: <linux-pci+bounces-4653-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0199876160
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 10:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DF2F1F2254D
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 09:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB33C53E32;
	Fri,  8 Mar 2024 09:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XuZEmsET"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523EA53E1B
	for <linux-pci@vger.kernel.org>; Fri,  8 Mar 2024 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709891762; cv=none; b=Gl5tSKrMBag68SfDPV/NSUghpHoL6l0+iUcIqKSupfDSluyUEMHYvjiPQDKiLbFfvbrkpAHuU3syuDJfGvMIMPdD29BVXfaY9fXaZ4+/A+BK8GcqdxbXIsk/nX8yGkHwkaDPMOyZ+yfn6b7bAARN6pPtDJknvdoen4vwKAIloiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709891762; c=relaxed/simple;
	bh=048FL+lWMOSIyoKXUVx1l4I7KcqtMLG1ou1jUMFPos4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZ/VeM7mc7SxPzycWPKoBTpg9Y5bFauB7rutQazim0e7uY99u7Lci2Xd7iSYmeVP1hIPW0QP+CAO4MEfB6uD739cV7ptKnMNeJceE4v1PF0zgMlNyoKKs0mxfZoXpFQgETm4cMACPUA8tyLLfDAaxi/10DXPmRD1H4+v+Aniquc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XuZEmsET; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-29b9f258cd9so946782a91.3
        for <linux-pci@vger.kernel.org>; Fri, 08 Mar 2024 01:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709891760; x=1710496560; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JUK3zdKghpmKi7BAcVW5ImJ4qoLWxSUUxIXqc6+4Iww=;
        b=XuZEmsETlMxjF0BysDZ3t5MKj1Ufh7KMAu/xSplVht/x+deWgiKV2mbzhRzF+aBee5
         /Pffifls2UbfptuqrfxQHlt5A2O820WjJpdlGKbNezvOGWCSZApo9B7nUGO5peHoWkEC
         kw1Fi++xtVpQ5UzGIPtAsIwc4XLAggD/PqP5Xw6wES6mYprx2e9FKECkBmsSQwfiCKZV
         l+BWTnCPdLnK4/le4yQcVx9tTncPedjlljxIWKJuYH1im7oR/fRtKHXA+geWOk+ctQR9
         mDyOoZtTE5EjwYW8dQdj0GH5BIpxCKoRqNbpvCCdl0wHEBMbpgyL0Q3oD4/gzpuhxs8K
         5zeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709891760; x=1710496560;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JUK3zdKghpmKi7BAcVW5ImJ4qoLWxSUUxIXqc6+4Iww=;
        b=ffU27XY6kk9qBdDlBvMuciWcaRhyR2K8fJYDPiOTdSYcbFbPX7zKX0IH2padmgeDue
         uXY812DTnxBbkcZ6cRgeXsuV5TvFgjfbaJjLsolXMRmlru52qW+39ug+By7Ww+2FLv8x
         ai9pXEGmVMRHAIhs7H3R0mE/tjoNHeW35BgNuoY50SYoBmpoS/0NvZ7SapHqszV5hIup
         xf0RI4G47Yb6SAGrZvOenZOdnm900dhYJ77q2gpsG7Js5FXglrrbw8W7SCh934HRDoxp
         4nEkoj/jlXsnAqbUB4i6eU4+Z4V/BVmFSC5GaKDAWh4mi1WDKA4Zx/5RRty1r3TrJuli
         7azA==
X-Forwarded-Encrypted: i=1; AJvYcCUZriBtgc79Jd2WWR2m3+xUNRIJPhxvaAvwrBgUzgqktEgxnNuQWcpYnn8Kx4eA65ZnIxKrYbGj2H5k00HJg9Xmgfzosj9/mJry
X-Gm-Message-State: AOJu0YyIMMby+joseWwSiFPfpIk8GUzYQQWaglAoxe+o/TMl+z/+HsVF
	0AfXYFDcQlb23yB+spPheKe6Kb5HtV48o6E5YYR9ZOUA7Ut0ambReUBgS3Dlbw==
X-Google-Smtp-Source: AGHT+IGOTlUHapfqElkZxE+j6NSs76sL89OIFPzQbD3+yFMWYqGGsRtHUD1W1wK1/RK2ZY2d13ivWw==
X-Received: by 2002:a17:90a:a8f:b0:299:7b37:9221 with SMTP id 15-20020a17090a0a8f00b002997b379221mr16693450pjw.12.1709891759544;
        Fri, 08 Mar 2024 01:55:59 -0800 (PST)
Received: from thinkpad ([117.217.183.232])
        by smtp.gmail.com with ESMTPSA id ei16-20020a17090ae55000b0029b73ccf4fesm2806572pjb.30.2024.03.08.01.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 01:55:59 -0800 (PST)
Date: Fri, 8 Mar 2024 15:25:47 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Yue Wang <yue.wang@Amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v1 1/1] PCI: dwc: Remove unused of_gpio.h
Message-ID: <20240308095547.GI3789@thinkpad>
References: <20240307122840.3682287-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240307122840.3682287-1-andriy.shevchenko@linux.intel.com>

On Thu, Mar 07, 2024 at 02:28:40PM +0200, Andy Shevchenko wrote:
> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it, simply remove the unused header.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c    | 1 -
>  drivers/pci/controller/dwc/pci-meson.c     | 1 -
>  drivers/pci/controller/dwc/pcie-qcom.c     | 1 -
>  drivers/pci/controller/dwc/pcie-tegra194.c | 2 --

What about the rest?

drivers/pci/controller/dwc/pcie-kirin.c
drivers/pci/controller/dwc/pci-imx6.c

There is also one non-dwc driver:

drivers/pci/controller/pci-aardvark.c

It is better to remove it from all PCI drivers in a single patch.

- Mani

>  4 files changed, 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index 0e406677060d..f6d2ba42958b 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -17,7 +17,6 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_gpio.h>
>  #include <linux/of_pci.h>
>  #include <linux/pci.h>
>  #include <linux/phy/phy.h>
> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
> index 6477c83262c2..db9482a113e9 100644
> --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c
> @@ -9,7 +9,6 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
> -#include <linux/of_gpio.h>
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
>  #include <linux/reset.h>
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 2ce2a3bd932b..0084a3390040 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -20,7 +20,6 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/of.h>
> -#include <linux/of_gpio.h>
>  #include <linux/pci.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/platform_device.h>
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 1f7b662cb8e1..633d8dc50339 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -13,7 +13,6 @@
>  #include <linux/clk.h>
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
> -#include <linux/gpio.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/interconnect.h>
>  #include <linux/interrupt.h>
> @@ -21,7 +20,6 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_gpio.h>
>  #include <linux/of_pci.h>
>  #include <linux/pci.h>
>  #include <linux/phy/phy.h>
> -- 
> 2.43.0.rc1.1.gbec44491f096
> 

-- 
மணிவண்ணன் சதாசிவம்

