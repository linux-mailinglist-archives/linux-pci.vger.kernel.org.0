Return-Path: <linux-pci+bounces-25531-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E6FA81D24
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 08:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48454423A3B
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 06:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CB61DEFE7;
	Wed,  9 Apr 2025 06:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xN78ymuA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D6342048
	for <linux-pci@vger.kernel.org>; Wed,  9 Apr 2025 06:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744180605; cv=none; b=YVd+zFUoFTBb3xW8HX3tLHgZ8NY2avA7MaPLsEeCzf4xlDFiMbpBITHlPTXVN4LhkZf+yQk2LhEArlZn/0kdmPy9qGgxT4IrPpuB/kb+ACkMQuxN5ZZd6Y5yrXfaGtSB/d0H6hiiCnsZPNRAg9UDJKrne34y9VyRi9G82wd6o3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744180605; c=relaxed/simple;
	bh=htJb0hi3i8Uumf4NXM2uKOYATRawaMO2ZOlca+fgrJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=niswVa59Ldu4g1TjR+QXlo52aaZPN+DA+EgF3vEcRBd0Pq92jwvlDclZTQmhXqU5AQ3oR0M6ScLOwgLu1DVQTXjlmqJhTj2Q8azxwDIpH9xE3MdVbjoQuSmkpzvRD/hjgq/RRchiH1k9SIKJONeTSpf4fiGQrlAOlt7sHP4Eo5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xN78ymuA; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-af523f4511fso5081938a12.0
        for <linux-pci@vger.kernel.org>; Tue, 08 Apr 2025 23:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744180601; x=1744785401; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JyLHBKKtBdcGeGPsMw3f6Qv4QssdQHR7Pid6EQwgQ8w=;
        b=xN78ymuAj77FKAMt+DD5OW2V6k9fRGCUP+uexXXWMI+QX8audVZ8rM2LhtvFA6TpwP
         0taWsSLOgCJW9/LKuwyW9PAWLfc2Lzkn3gwpqEbYYzmjJFfT5Gwhr8+fWQ5WNzY0sZZz
         OoXQ/NFPbEBeDRRMPLFH/kFEHjl6Nk2EotbmaD1qKS52biAtPeSw+2UYHVp0updP0toV
         dMnwkMkE0NtYpZWcbdBj4gaCZQVyDM1G+TctPLAVxouvLPai9Ylg9D92CXXeqHCdMwG0
         y2mPwolhvOyiyl5LIeP+RIrB313UTp0pY0SWSpodg/M369m2EIGHR/YQrz5/Dqs3HbvE
         X1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744180601; x=1744785401;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JyLHBKKtBdcGeGPsMw3f6Qv4QssdQHR7Pid6EQwgQ8w=;
        b=ho172HUfoM1qPJ1e7EXAca6D7X3Yh/SrYcLyTSFRN7Y30IDgW5QoZOMftmH0JNDvMO
         Dplemqao0anUaa5evOpDRZS4wT+1DpKKUf/OXhDodPyzTlEXsX4eJ/DwNES00oMNOgYY
         K9x7Xb02AgnQWGxBtW4HNzkteY0cCVaXKqLc7tN2Uj32qooXNDIrzfcNG6IV2U8EgMZg
         fINbRYXpTSt0UKF46x7T2NTxE80HAgB83ZfgJUzHLybq/F/iSvjzI2koGoENmG5tSogG
         2T9+H1bqoTGOrJBpteo60jsb1GRYh4k8bA4wemQDPisxhMpmJocJVKrfsH3ESzB1BRqP
         6dVg==
X-Forwarded-Encrypted: i=1; AJvYcCWlyUTNmwdkbKenxKa+MV2fWnLOH3bfvtrdgQL5vMOARWr4HMFEJ79SLDOGP/h2rtwx+ByDBRMSXNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX6sg0AQA2o0bAJkpWwwTmTaNVV/xTmrw3tLnyx/xvLnq2/1FZ
	tv/ZJv69ljD+e8yaCRhvloKXKrBj3Js4dvG24ZoGWQldqOG+2l52+FyHH0bRtQ==
X-Gm-Gg: ASbGncuGWNesp6EbxfuQmGO3DqjQtOGrsOau6BaanEfMLKFScU6uwUYTSCF4+Ge/sYB
	7RN9Uakx+YjMa0MqvAVPIWy6FsKn9D6Hi0cjDOIddao5MD5I1R/atQPg6p8KUQ5XUERyNGW6AA4
	O10jLiySkbrG6ui5fv0vNBmZraam8IVVv5YXwQ0q9Kz1BpxP8DEelZkcJ4PDPvmhuRXFUGzd3eV
	M4GGx05+DJCdGvMQ7kW7u5kJ0gSYo7xh+VZS6UwMBUs1yqos2AQeek/uwLEzzeLbBMIQVgRkMZ3
	TCDzTA99vnzJrH4lt4kWjOCPDNXx/nP7FrdGZ8owbex7T0VT0Qc=
X-Google-Smtp-Source: AGHT+IHsJVrpDdInYLAhJaCNmHpq2veRp8h4bN1zX1HiVkJrECPermHzrundQFT6RfXaFpJfsW7aQw==
X-Received: by 2002:a05:6a20:9f8e:b0:1f5:7eee:bb10 with SMTP id adf61e73a8af0-201591580c4mr2941076637.8.1744180601350;
        Tue, 08 Apr 2025 23:36:41 -0700 (PDT)
Received: from thinkpad ([120.56.198.53])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1e382a4sm510787b3a.96.2025.04.08.23.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 23:36:40 -0700 (PDT)
Date: Wed, 9 Apr 2025 12:06:35 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, 
	bhelgaas@google.com, vigneshr@ti.com, kishon@kernel.org, 18255117159@163.com, 
	cassel@kernel.org, wojciech.jasko-EXT@continental-corporation.com, 
	thomas.richard@bootlin.com, bwawrzyn@cisco.com, linux-pci@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH v2 4/4] PCI: j721e: Add support to build as a loadable
 module
Message-ID: <zsxnx7biwogov5dw5yiafkgk6tsrtspac75bjbrca5uevweaim@ly67hwfyk7qh>
References: <20250330083914.529222-1-s-vadapalli@ti.com>
 <20250330083914.529222-5-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250330083914.529222-5-s-vadapalli@ti.com>

On Sun, Mar 30, 2025 at 02:09:14PM +0530, Siddharth Vadapalli wrote:
> The 'pci-j721e.c' driver is the application/glue/wrapper driver for the
> Cadence PCIe Controllers on TI SoCs. Implement support for building it as a
> loadable module.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> v1:
> https://lore.kernel.org/r/20250307103128.3287497-5-s-vadapalli@ti.com/
> Changes since v1:
> - Based on feedback from Thomas at:
>   https://lore.kernel.org/r/88b3ecbe-32b6-4310-afb9-da19a2d0506a@bootlin.com/
>   the "check" for a non-NULL "pcie-refclk" in j721e_pcie_remove() has been
>   dropped.
> 
> Regards,
> Siddharth.
> 
>  drivers/pci/controller/cadence/Kconfig     |  6 ++--
>  drivers/pci/controller/cadence/pci-j721e.c | 33 +++++++++++++++++++++-
>  2 files changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
> index 82b58096eea0..72d7d264d6c3 100644
> --- a/drivers/pci/controller/cadence/Kconfig
> +++ b/drivers/pci/controller/cadence/Kconfig
> @@ -43,10 +43,10 @@ config PCIE_CADENCE_PLAT_EP
>  	  different vendors SoCs.
>  
>  config PCI_J721E
> -	bool
> +	tristate
>  
>  config PCI_J721E_HOST
> -	bool "TI J721E PCIe controller (host mode)"
> +	tristate "TI J721E PCIe controller (host mode)"
>  	depends on ARCH_K3 || COMPILE_TEST
>  	depends on OF
>  	select PCIE_CADENCE_HOST
> @@ -57,7 +57,7 @@ config PCI_J721E_HOST
>  	  core.
>  
>  config PCI_J721E_EP
> -	bool "TI J721E PCIe controller (endpoint mode)"
> +	tristate "TI J721E PCIe controller (endpoint mode)"
>  	depends on ARCH_K3 || COMPILE_TEST
>  	depends on OF
>  	depends on PCI_ENDPOINT
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index ef1cfdae33bb..8bffcd31729c 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -15,6 +15,7 @@
>  #include <linux/irqchip/chained_irq.h>
>  #include <linux/irqdomain.h>
>  #include <linux/mfd/syscon.h>
> +#include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
> @@ -27,6 +28,7 @@
>  #define cdns_pcie_to_rc(p) container_of(p, struct cdns_pcie_rc, pcie)
>  
>  #define ENABLE_REG_SYS_2	0x108
> +#define ENABLE_CLR_REG_SYS_2	0x308
>  #define STATUS_REG_SYS_2	0x508
>  #define STATUS_CLR_REG_SYS_2	0x708
>  #define LINK_DOWN		BIT(1)
> @@ -116,6 +118,15 @@ static irqreturn_t j721e_pcie_link_irq_handler(int irq, void *priv)
>  	return IRQ_HANDLED;
>  }
>  
> +static void j721e_pcie_disable_link_irq(struct j721e_pcie *pcie)
> +{
> +	u32 reg;
> +
> +	reg = j721e_pcie_intd_readl(pcie, ENABLE_CLR_REG_SYS_2);
> +	reg |= pcie->linkdown_irq_regfield;
> +	j721e_pcie_intd_writel(pcie, ENABLE_CLR_REG_SYS_2, reg);
> +}
> +
>  static void j721e_pcie_config_link_irq(struct j721e_pcie *pcie)
>  {
>  	u32 reg;
> @@ -633,9 +644,25 @@ static void j721e_pcie_remove(struct platform_device *pdev)
>  	struct j721e_pcie *pcie = platform_get_drvdata(pdev);
>  	struct cdns_pcie *cdns_pcie = pcie->cdns_pcie;
>  	struct device *dev = &pdev->dev;
> +	struct cdns_pcie_ep *ep;
> +	struct cdns_pcie_rc *rc;
> +
> +	if (pcie->mode == PCI_MODE_RC) {
> +		rc = container_of(cdns_pcie, struct cdns_pcie_rc, pcie);
> +		cdns_pcie_host_disable(rc);
> +	} else {
> +		ep = container_of(cdns_pcie, struct cdns_pcie_ep, pcie);
> +		cdns_pcie_ep_disable(ep);
> +	}
> +
> +	if (pcie->reset_gpio) {
> +		msleep(PCIE_T_PVPERL_MS);

There is no point in adding a delay before PERST# assertion.

> +		gpiod_set_value_cansleep(pcie->reset_gpio, 1);

This is not PERST# assert, isn't it? Typo?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

