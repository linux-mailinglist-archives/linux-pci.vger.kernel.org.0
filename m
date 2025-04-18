Return-Path: <linux-pci+bounces-26242-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A67BA93BB0
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 19:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D36C7AE55F
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 17:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E28215782;
	Fri, 18 Apr 2025 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VKy6O/Xf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BB113C9B3
	for <linux-pci@vger.kernel.org>; Fri, 18 Apr 2025 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744996056; cv=none; b=o91IiroyrrCxE8fLTtKHw9zdK4vMbLsZQNtun2petE2BDA8OD7guCAJp7KJj09l93wDXXqwuZNmW0v7i+ooU212vXnwRlARcPctbAkYVcx8B28fsgiCrabyeAHhOJilvH3RFYHsUDNgUXu73DvbQS39SAL6CG80sMIFVc9SkKbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744996056; c=relaxed/simple;
	bh=WdGGHLlvsM/i1MnTQ2dVztvbpKZ3JQ0HRd4+rdRBjUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G15L6gy0iu/4Bz2vDU6oUFdGnA2cnWW/kTiKoqjMwPU4o9p5FpNXv1RrzH254lEyYsXWhmsV5EO9keaMIECNi+BDdY7DFOfWZC3mrCCW2c3a2Ac4X+J/JWZPqEi/c5E7uU6ELfhymTYK1oKscopG3D8JqyXzo/ExOBhAVEF/I/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VKy6O/Xf; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7398d65476eso1727018b3a.1
        for <linux-pci@vger.kernel.org>; Fri, 18 Apr 2025 10:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744996053; x=1745600853; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nL6dqOeouWGje3PfIFhRZYZKH+4zhi7g+fExpzSbfis=;
        b=VKy6O/XfVFphQtRBySCY2ghsxfKquvyOBCde+lPIIX1hKWhWiTgAb3GRZoiWbiZAVZ
         LS9GnFy0PRVXc/PtlW2va/eU/n7OS1p9z6toQ6pIPI7oZp2IxdM9iYPBflwM38FW/n4B
         wBe+9t1yLE5HuLQg1IDAv4UUFfxtrz+DcVD+hIiXf+fE5aH0ebq+D2P0GJTK85hfLMRW
         IynIzKv0aAGmzmcz2NR7Mhj76+iBd8iMu2CUWl11vb7RWuhZQBUY+pny3EKQKohnUDk/
         nFmuJP2MsyRdLEyBOyqyjQccNmiCqAbqEQeA6JVpCsmLajrbl67PUS122nzlGwhAadrJ
         ejtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744996053; x=1745600853;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nL6dqOeouWGje3PfIFhRZYZKH+4zhi7g+fExpzSbfis=;
        b=nihOtvDAn12hBKeXsQPA5+oGDu8eo8PXbDxvEBfKEMTEtVxmPi2QtTT8Ab4F8+W4Vr
         79UBWke9cLcnci5p/wGZE9aEZpruAvIieIKBo2lvW4rz1brhjrRTbPpDUPNFLOagy8aF
         xw3IJxsiEnrp9eoFxHJSbtIkRU9HE9N9HdFsOwKR4Eq+uSN0TtVKzur5ihOP9w76SXyA
         BfX05pbKMzA2SBJAjqmHhSGNFJttgSJqbfFoe6k2IZgfYrU27UqtpO/psqSQXly0MM9Y
         2ppVb2FbrkQzJU0hmH7XbMGBOY8B9Kyk9W7egQNXAvZ/In4nyRUOGYZNd/oEeXxxdn9g
         icCA==
X-Forwarded-Encrypted: i=1; AJvYcCVS67NcRbpDbrW0WF3icX5im9QWa+1yBNlDxoLwIUQ3Da3fVIkXbdJlsION5t8z2HqcFeBtYe+F8Aw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz90UXr+4tE4+IZk+k0cG96Ic9rTHAxjDgrL1qbAxi5RMf8OMeJ
	UkEYZCSn2gLG4vyh+b2uCN7SXTXn8I74dzNugyoDOwktzwniP2dKDOf4jfkERg==
X-Gm-Gg: ASbGncsOs/geMBJaqOPmOmuMsOdumAPaRYUxDyY1A8jrw/Mn1X0QKJXf3qWlUXnPN91
	PiTgvmmKFSBgJtAfnGN9CcYiWxOEnB9nSeTVQKs8wlPrbarZ2wkcMCVYMqRBn1lYURwsWtaj2nA
	v5yTwNS38LQ+fC6Cr5uUJNM+araxlwwGB3p9jvQKnmY2lwwo+JtodPdtU7bsfvyiIy/64V2piGn
	TiWZz1rrtkKBQoiHbKaF0EBJz/fvDvcG5nNDwh+y7iUVAjGoLiCTbCaiYXzeXq5UcQevwdSxRsK
	esM2eqEtuAdl58KuZfMNpCdeGNQ7VreOdwDSPbV1g1t4jh6ais0=
X-Google-Smtp-Source: AGHT+IFd8ioW+E3Ktz8zI+ikNBXvvgjozvxKBov9f/KWyoLC0PTaG7crTd+nou7TAO4V0w0FxgrPdg==
X-Received: by 2002:a05:6a00:3c76:b0:732:706c:c4ff with SMTP id d2e1a72fcca58-73dbe601c73mr4561736b3a.7.1744996052724;
        Fri, 18 Apr 2025 10:07:32 -0700 (PDT)
Received: from thinkpad ([36.255.17.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaee68bsm1880459b3a.175.2025.04.18.10.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 10:07:32 -0700 (PDT)
Date: Fri, 18 Apr 2025 22:37:26 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, 
	bhelgaas@google.com, vigneshr@ti.com, kishon@kernel.org, 18255117159@163.com, 
	cassel@kernel.org, wojciech.jasko-EXT@continental-corporation.com, 
	thomas.richard@bootlin.com, bwawrzyn@cisco.com, linux-pci@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH v4 4/4] PCI: j721e: Add support to build as a loadable
 module
Message-ID: <gqeraipycu4blfye77oyaysxatz757r7lsw72kq26smj4dwxoj@cytxxhqjrnno>
References: <20250417124408.2752248-1-s-vadapalli@ti.com>
 <20250417124408.2752248-5-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250417124408.2752248-5-s-vadapalli@ti.com>

On Thu, Apr 17, 2025 at 06:14:08PM +0530, Siddharth Vadapalli wrote:
> The 'pci-j721e.c' driver is the application/glue/wrapper driver for the
> Cadence PCIe Controllers on TI SoCs. Implement support for building it as a
> loadable module.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

One nitpick below. But no need to respin just for this. Hopefully, this can be
changed while applying the series.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> ---
> 
> v3 patch is at:
> https://lore.kernel.org/r/20250410104426.463453-5-s-vadapalli@ti.com/
> Changes since v3:
> - In the fourth patch of this series, the polarity for PERST# assert in
>   the driver's .remove callback has been fixed based on Mani's feedback at
>   https://lore.kernel.org/r/6bi5gul3sqvycmkf6cwokkvownjffaf2tkonjlefo2d7cautwx@uhfexzgz3okp/
> 
> Regards,
> Siddharth.
> 
>  drivers/pci/controller/cadence/Kconfig     |  6 ++---
>  drivers/pci/controller/cadence/pci-j721e.c | 31 +++++++++++++++++++++-
>  2 files changed, 33 insertions(+), 4 deletions(-)
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
> index ef1cfdae33bb..8a73a4d382d1 100644
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
> @@ -633,9 +644,23 @@ static void j721e_pcie_remove(struct platform_device *pdev)
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
> +	if (pcie->reset_gpio)

All 'gpiod_*' APIs accept NULL descriptors. So you don't necessarily need the
check here.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

