Return-Path: <linux-pci+bounces-27029-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2AFAA445C
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 09:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74F1F1C02537
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 07:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AFB20E338;
	Wed, 30 Apr 2025 07:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e96Q4IKs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B549A1D88D0
	for <linux-pci@vger.kernel.org>; Wed, 30 Apr 2025 07:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745999420; cv=none; b=IHCLK2CrimMNOd0v3KKZnbr1CjhyMMr7ClvKUu99KEuwkbEt+M7VfNF1oZUsrGt9Kb7UzjGvHXqdI1xM7QoPul44OPHsTxl2SI9g2CxK3aAt2TB5bBVVcaG0laYsB63R7ZngyEovLU5WnGbKVmdzLSocO2KA4ySLX9wQQ+Q57bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745999420; c=relaxed/simple;
	bh=dpGOxMLIeOmwxW/FB5SchRaiP+uCvl2prhEvt6qK08s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ya9jz5iD5LsDCha+yztcmQq0Yr2a0htss9YQ2IFrY797O3mMPo3SOhywzdjUXM5wbXpk+zbYalGrdWDMxlkDchpB42NHALj70R+xWUmn9+542jddkCkyqBsPEYV7WGGzMAVQHy6ofNps08b5Z64dovsIttrmoeenIPUlRY8IEJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e96Q4IKs; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-306b6ae4fb2so6370451a91.3
        for <linux-pci@vger.kernel.org>; Wed, 30 Apr 2025 00:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745999417; x=1746604217; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9yxKFbS7FJYlVTaW80XPyRVVbRWztaV2reVeiBVpKKQ=;
        b=e96Q4IKseXOyeDyxnanbHcGoohPRV2q+Ozf/UigxZsd5rM5r6PSiLlwjCQNjEVZqS7
         AO8Hs2BlmxJb2U5zx9XT8Wtm/PyyCu4BlZHuqzVYLuZvPRBUPTQ5Ju7ijComO+Y9zc/u
         QIMX1Sega50EC8yzP8BNwfNIO/1o5j9RBuOHjMmfl/gXoJEZZFZmCE7sK0prn0xJzR0Z
         R9wdNmOa0Nv4WbaOcy/Ic1mALFJT+9Q96gmA/xoz4nMr+AREOjU43CDJPIh3mhdWzJGI
         IEKGmJToh45+YpdFwoiTKaH1JNhgr9HPBKfOt09hIS2H/Qrjz10fFS2meQdOcJBIR8+N
         6tAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745999417; x=1746604217;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9yxKFbS7FJYlVTaW80XPyRVVbRWztaV2reVeiBVpKKQ=;
        b=RfKTF5Lab0k/RqEc5m9RRlk9X7EbQhR2Vt6OKq/gHTK5LHk+7UOvg3sSag2wddR1jY
         2YnfNPmgZiwFssvbfvNty2MTc2Tjo7ayJyl/7Q4F6xcgquHzYQtUOxXAYue9g4hoU+m4
         iRx1SEjORw7tlPmZ1vx8Q1XAMpYedn1zUSbHYo5pKC3erloJPLjAuZ4ppSPRi0kyzNVI
         1kJGSvDVxHZ8yb/WZGQ7AFJrQ+lju7zOKnDyInM2Q6tUUedjj0+YOufpR2P15RtvBZQg
         npy841rrJ0r5YpNRlzcDKf3hyUH4zuNWRQOE5fGy0+I91DZZgxRcv/hL2hgd1jkK3smJ
         wUsQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/3TpfbYAMqWn5i9z5OFVHhiTZOlR+ErybD9Gm+RfTPgiauONGZDg3cj+aIuDYGQuZjKqIvIR/ksg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGEdNClK3eY9dE0RoUBEx2pQtlDA3nM7eANqyAzNhzEEZeHAIt
	bycLVUND7N98CnSBcwajXMS2DBl3iOyULzP2Dy02/RA8UxFDzFWlOCYTorYk6Q==
X-Gm-Gg: ASbGnctzMbMK0W2ZXSDrLgFIEJvcqW2I5Yp42ofuOf5FZ9QBa/OrnpR/SlZ5tTYBV7x
	DeeBB2BySGRBmgoSfxJAxUR4mJ8ZOh8SeqjWNeg7/mEdBIIKh6uxb6eEYiYcNdI8GKq3jXaqpAk
	eAD+9O4iUjTSqtUIt+BjnvfBT+yDQZwfFdgjvCVJt7Bptr9Qy05xESYCQjizT7pbCq4nvnvZs/2
	0BTLmp3DAKNzzp9IHXCTpHOQnr2mvaAKxvV7UXMij6dFb2BNYxykxQmibh4ij1TBqkFCIgzLlLh
	cm1hzMzyzpnl6d/pWZRzqe18OtUT2gJeEhwclsyIjEYWAyspb7fi
X-Google-Smtp-Source: AGHT+IFvx4UAfDgrq2sMjoLi6VEnM3rJ09t7/z8JxBTCQ55y5uUYEKoDCPk40jK6HkYjUv4z1LuM8A==
X-Received: by 2002:a17:90b:56c3:b0:2ff:502e:62d4 with SMTP id 98e67ed59e1d1-30a3336472dmr2604246a91.32.1745999416760;
        Wed, 30 Apr 2025 00:50:16 -0700 (PDT)
Received: from thinkpad ([120.56.197.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a349e4586sm909365a91.8.2025.04.30.00.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 00:50:16 -0700 (PDT)
Date: Wed, 30 Apr 2025 13:20:06 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, 
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, p.zabel@pengutronix.de, 
	thippeswamy.havalige@amd.com, shradha.t@samsung.com, quic_schintav@quicinc.com, 
	cassel@kernel.org, johan+linaro@kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/9] PCI: stm32: Add PCIe Endpoint support for
 STM32MP25
Message-ID: <tdgyva6qyn6qwzvft4f7r3tgp5qswuv4q5swoaeomnnbxtmz5j@zo3gvevx2skp>
References: <20250423090119.4003700-1-christian.bruel@foss.st.com>
 <20250423090119.4003700-5-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250423090119.4003700-5-christian.bruel@foss.st.com>

On Wed, Apr 23, 2025 at 11:01:14AM +0200, Christian Bruel wrote:
> Add driver to configure the STM32MP25 SoC PCIe Gen1 2.5GT/s or Gen2 5GT/s
> controller based on the DesignWare PCIe core in endpoint mode.
> 
> Uses the common reference clock provided by the host.
> 
> The PCIe core_clk receives the pipe0_clk from the ComboPHY as input,
> and the ComboPHY PLL must be locked for pipe0_clk to be ready.
> Consequently, PCIe core registers cannot be accessed until the ComboPHY is
> fully initialised and refclk is enabled and ready.
> 
> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> ---
>  drivers/pci/controller/dwc/Kconfig         |  12 +
>  drivers/pci/controller/dwc/Makefile        |   1 +
>  drivers/pci/controller/dwc/pcie-stm32-ep.c | 414 +++++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-stm32.h    |   1 +
>  4 files changed, 428 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-stm32-ep.c
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 2aec5d2f9a46..aceff7d1ef33 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -422,6 +422,18 @@ config PCIE_STM32_HOST
>  	  This driver can also be built as a module. If so, the module
>  	  will be called pcie-stm32.
>  
> +config PCIE_STM32_EP
> +	tristate "STMicroelectronics STM32MP25 PCIe Controller (endpoint mode)"
> +	depends on ARCH_STM32 || COMPILE_TEST
> +	depends on PCI_ENDPOINT
> +	select PCIE_DW_EP
> +	help
> +	  Enables endpoint support for DesignWare core based PCIe controller
> +	  found in STM32MP25 SoC.

Can you please use similar description for the RC driver also?

"Enables Root Complex (RC) support for the DesignWare core based PCIe host
controller found in STM32MP25 SoC."

> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called pcie-stm32-ep.
> +
>  config PCI_DRA7XX
>  	tristate
>  

[...]

> +static int stm32_add_pcie_ep(struct stm32_pcie *stm32_pcie,
> +			     struct platform_device *pdev)
> +{
> +	struct dw_pcie_ep *ep = &stm32_pcie->pci.ep;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	ret = pm_runtime_resume_and_get(dev);

This needs to be called before devm_pm_runtime_enable().

> +	if (ret < 0) {
> +		dev_err(dev, "pm runtime resume failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
> +				 STM32MP25_PCIECR_TYPE_MASK,
> +				 STM32MP25_PCIECR_EP);
> +	if (ret) {
> +		goto err_pm_put_sync;
> +		return ret;
> +	}
> +
> +	reset_control_assert(stm32_pcie->rst);
> +	reset_control_deassert(stm32_pcie->rst);
> +
> +	ep->ops = &stm32_pcie_ep_ops;
> +
> +	ret = dw_pcie_ep_init(ep);
> +	if (ret) {
> +		dev_err(dev, "failed to initialize ep: %d\n", ret);
> +		goto err_pm_put_sync;
> +	}
> +
> +	ret = stm32_pcie_enable_resources(stm32_pcie);
> +	if (ret) {
> +		dev_err(dev, "failed to enable resources: %d\n", ret);
> +		goto err_ep_deinit;
> +	}
> +
> +	ret = dw_pcie_ep_init_registers(ep);
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize DWC endpoint registers\n");
> +		goto err_disable_resources;
> +	}
> +
> +	pci_epc_init_notify(ep->epc);
> +

Hmm, looks like you need to duplicate dw_pcie_ep_init_registers() and
pci_epc_init_notify() in stm32_pcie_perst_deassert() for hw specific reasons.
So can you drop these from there?

> +	return 0;
> +
> +err_disable_resources:
> +	stm32_pcie_disable_resources(stm32_pcie);
> +
> +err_ep_deinit:
> +	dw_pcie_ep_deinit(ep);
> +
> +err_pm_put_sync:
> +	pm_runtime_put_sync(dev);
> +	return ret;
> +}
> +
> +static int stm32_pcie_probe(struct platform_device *pdev)
> +{
> +	struct stm32_pcie *stm32_pcie;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	stm32_pcie = devm_kzalloc(dev, sizeof(*stm32_pcie), GFP_KERNEL);
> +	if (!stm32_pcie)
> +		return -ENOMEM;
> +
> +	stm32_pcie->pci.dev = dev;
> +	stm32_pcie->pci.ops = &dw_pcie_ops;
> +
> +	stm32_pcie->regmap = syscon_regmap_lookup_by_compatible("st,stm32mp25-syscfg");
> +	if (IS_ERR(stm32_pcie->regmap))
> +		return dev_err_probe(dev, PTR_ERR(stm32_pcie->regmap),
> +				     "No syscfg specified\n");
> +
> +	stm32_pcie->phy = devm_phy_get(dev, NULL);
> +	if (IS_ERR(stm32_pcie->phy))
> +		return dev_err_probe(dev, PTR_ERR(stm32_pcie->phy),
> +				     "failed to get pcie-phy\n");
> +
> +	stm32_pcie->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(stm32_pcie->clk))
> +		return dev_err_probe(dev, PTR_ERR(stm32_pcie->clk),
> +				     "Failed to get PCIe clock source\n");
> +
> +	stm32_pcie->rst = devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(stm32_pcie->rst))
> +		return dev_err_probe(dev, PTR_ERR(stm32_pcie->rst),
> +				     "Failed to get PCIe reset\n");
> +
> +	stm32_pcie->perst_gpio = devm_gpiod_get(dev, "reset", GPIOD_IN);
> +	if (IS_ERR(stm32_pcie->perst_gpio))
> +		return dev_err_probe(dev, PTR_ERR(stm32_pcie->perst_gpio),
> +				     "Failed to get reset GPIO\n");
> +
> +	ret = phy_set_mode(stm32_pcie->phy, PHY_MODE_PCIE);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, stm32_pcie);
> +
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to enable pm runtime %d\n", ret);

Use dev_err_probe() please for consistency.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

