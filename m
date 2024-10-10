Return-Path: <linux-pci+bounces-14159-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EE9997EEB
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 10:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01BF81C22BF6
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 08:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4684A1C3F0F;
	Thu, 10 Oct 2024 07:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R7JCErfq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1351C3F0C
	for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2024 07:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728545024; cv=none; b=Jfy7VDPXUkOt3GR2z2FwQ18ApklBE2o+Sc7zlzXbIfVE9nAObmuSj6ji8yPZB9hNnH9dyC2hk96sUM3ZdfhatVOCKxuOV3OE3tA2SMzSxWY3W44+Vk/Mm+hWRCX9R7oV0OfVO7sxHgYSgJjQq0Robz0FE5JMi6HnvRk0gvoG6Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728545024; c=relaxed/simple;
	bh=MNw/KLL5DU2zG6PvY7IYp33np/chs/P+nM7r09OFw94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NntGOzSjpIDhWiv3SYXnDzcgI5zCKZcu2G4gf8jaRxoYbJj+qlSr/YOjynvXdliJidoNddgTrY43rl5+g5VFTRH7x1gMNumhuNmKjRuDzUzWDXi5nVqiioKeURTShqhJsil79LKiGpPEOERDN+j2kzU1bYHZoPTBYdP/rpu5Gds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R7JCErfq; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-27b7a1480bdso250930fac.2
        for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2024 00:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728545021; x=1729149821; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5IOlFpLvsPq3qlIZHkbwyXPVkIt/jV0bl5GNKYhS0rs=;
        b=R7JCErfq7ZxY5cpKrA6Wg4bEBMlqCmXgKMCiYCDm5g98G4izJ/ntIku8cS7nCP5oZu
         BecfIsETEG+FAZXqcgSwH2yAnfcL3Pib7rUVrFfjFqQMLZ8ESCZsEH7ZDJDKKgxwgF0D
         FneHfQSvTjHouAPwyIHsRu8oRVe3Xq1BqfsBV0NUM/iYngKe3IKdj807Yclc4vNMr42h
         2lIERGgtwh5BKgXjaDk7AlZDaN1qMVHTQWHC2CUxoJhsGLoLOSzMg9QKecPYoVDtCXVZ
         2azntSj74nJA/5DnUQ27zzasisk9itY3gY3TOsWLMGT4bkC6Q/TB3Y5dpDSUrZO7w4Pp
         cQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728545021; x=1729149821;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5IOlFpLvsPq3qlIZHkbwyXPVkIt/jV0bl5GNKYhS0rs=;
        b=hJXiVEFQmzQyQ0uA0ijDmATpmE6j1Tl1aF8jE2NlmzJQLlLEjVzfx5EmRBFkwY2jWB
         IsopV4sLID18h5PTeuevlzZs4jFyhzmcitzYOfdPpVTSKOMoww1GRRpc0vCriYUJWIq4
         2ysEus07EljfcgtrVnXuGP+feueN128LMfwsNDaE9XizItTfvTCa1WWGw/9tLjcv9tEf
         WRX/NL7kJjGerSNxUhPLsmb97uAEVF8rbaE54IwOzafmkb0qwyDQfGrSo1tK8iIQ4dpr
         n+HG68CDkMIOew8YhI0pO1EVJWXk0tWQwYGrqJ8uVeI5mZ8clwIKzIbH71FU6XtLoSBb
         EkaA==
X-Forwarded-Encrypted: i=1; AJvYcCU7dPy7MPUNRj3CQ8HJS5O9QNmxN6SOx4PBMSjQ4bakzTgizOwnQ5AQS3mprfz8J6eFDOYx5YhpAlk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzok3qS2GeXabwiwDZ3MjHfzLvi8Ej6XPy0AAYB4OOEnJ9/vPmz
	DFWRoq0EE+7Pm5lblZAniCtDQQb61HID/pWfEiGCXh4UCRq4PADe43GA6dbJfA==
X-Google-Smtp-Source: AGHT+IHdOeJvm7WVc4pJJZXKYMNh6j10WFnaWXG7+Y60rtwDAg3iK6ibsr+/4bayJBKskQxATQMM3w==
X-Received: by 2002:a05:6871:580d:b0:260:fbc0:96f2 with SMTP id 586e51a60fabf-2883451c512mr4829882fac.34.1728545021485;
        Thu, 10 Oct 2024 00:23:41 -0700 (PDT)
Received: from thinkpad ([220.158.156.184])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea44968210sm490197a12.90.2024.10.10.00.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 00:23:41 -0700 (PDT)
Date: Thu, 10 Oct 2024 12:53:35 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v3 06/12] PCI: rockchip-ep: Refactor
 rockchip_pcie_ep_probe() memory allocations
Message-ID: <20241010072335.2e3r7gxupyz57and@thinkpad>
References: <20241007041218.157516-1-dlemoal@kernel.org>
 <20241007041218.157516-7-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241007041218.157516-7-dlemoal@kernel.org>

On Mon, Oct 07, 2024 at 01:12:12PM +0900, Damien Le Moal wrote:
> Introduce the function rockchip_pcie_ep_get_resources() to parse the DT
> node of a rockchip PCIe endpoint controller and allocate the outbound
> memory region and memory needed for IRQ handling. This function tidies
> up rockchip_pcie_ep_probe(). No functional change.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/pci/controller/pcie-rockchip-ep.c | 109 ++++++++++++----------
>  1 file changed, 62 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> index a9b319d4e507..523e9cdfd241 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -524,15 +524,70 @@ static const struct of_device_id rockchip_pcie_ep_of_match[] = {
>  	{},
>  };
>  
> +static int rockchip_pcie_ep_get_resources(struct rockchip_pcie_ep *ep)

Almost all controller drivers use get_resources() function to acquire controller
resources like MMIO, clk, PHY etc... So if you were to refactor, I'd suggest to
first rename rockchip_pcie_parse_ep_dt() to rockchip_pcie_get_resources() to
maintain uniformity.

And if you want to move ob memory allocation to a single function to keep
probe() shorter, you should use a different function like
rockchip_pcie_ob_alloc() or something similar.

- Mani

> +{
> +	struct rockchip_pcie *rockchip = &ep->rockchip;
> +	struct device *dev = rockchip->dev;
> +	struct pci_epc_mem_window *windows = NULL;
> +	int err, i;
> +
> +	err = rockchip_pcie_parse_ep_dt(rockchip, ep);
> +	if (err)
> +		return err;
> +
> +	ep->ob_addr = devm_kcalloc(dev, ep->max_regions, sizeof(*ep->ob_addr),
> +				   GFP_KERNEL);
> +
> +	if (!ep->ob_addr)
> +		return -ENOMEM;
> +
> +	windows = devm_kcalloc(dev, ep->max_regions,
> +			       sizeof(struct pci_epc_mem_window), GFP_KERNEL);
> +	if (!windows)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < ep->max_regions; i++) {
> +		windows[i].phys_base = rockchip->mem_res->start + (SZ_1M * i);
> +		windows[i].size = SZ_1M;
> +		windows[i].page_size = SZ_1M;
> +	}
> +	err = pci_epc_multi_mem_init(ep->epc, windows, ep->max_regions);
> +	devm_kfree(dev, windows);
> +
> +	if (err < 0) {
> +		dev_err(dev, "failed to initialize the memory space\n");
> +		return err;
> +	}
> +
> +	ep->irq_cpu_addr = pci_epc_mem_alloc_addr(ep->epc, &ep->irq_phys_addr,
> +						  SZ_1M);
> +	if (!ep->irq_cpu_addr) {
> +		dev_err(dev, "failed to reserve memory space for MSI\n");
> +		goto err_epc_mem_exit;
> +	}
> +
> +	ep->irq_pci_addr = ROCKCHIP_PCIE_EP_DUMMY_IRQ_ADDR;
> +
> +	return 0;
> +
> +err_epc_mem_exit:
> +	pci_epc_mem_exit(ep->epc);
> +
> +	return err;
> +}
> +
> +static void rockchip_pcie_ep_release_resources(struct rockchip_pcie_ep *ep)
> +{
> +	pci_epc_mem_exit(ep->epc);
> +}
> +
>  static int rockchip_pcie_ep_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct rockchip_pcie_ep *ep;
>  	struct rockchip_pcie *rockchip;
>  	struct pci_epc *epc;
> -	size_t max_regions;
> -	struct pci_epc_mem_window *windows = NULL;
> -	int err, i;
> +	int err;
>  	u32 cfg_msi, cfg_msix_cp;
>  
>  	ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
> @@ -552,13 +607,13 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
>  	ep->epc = epc;
>  	epc_set_drvdata(epc, ep);
>  
> -	err = rockchip_pcie_parse_ep_dt(rockchip, ep);
> +	err = rockchip_pcie_ep_get_resources(ep);
>  	if (err)
>  		return err;
>  
>  	err = rockchip_pcie_enable_clocks(rockchip);
>  	if (err)
> -		return err;
> +		goto err_release_resources;
>  
>  	err = rockchip_pcie_init_port(rockchip);
>  	if (err)
> @@ -568,47 +623,9 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
>  	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
>  			    PCIE_CLIENT_CONFIG);
>  
> -	max_regions = ep->max_regions;
> -	ep->ob_addr = devm_kcalloc(dev, max_regions, sizeof(*ep->ob_addr),
> -				   GFP_KERNEL);
> -
> -	if (!ep->ob_addr) {
> -		err = -ENOMEM;
> -		goto err_uninit_port;
> -	}
> -
>  	/* Only enable function 0 by default */
>  	rockchip_pcie_write(rockchip, BIT(0), PCIE_CORE_PHY_FUNC_CFG);
>  
> -	windows = devm_kcalloc(dev, ep->max_regions,
> -			       sizeof(struct pci_epc_mem_window), GFP_KERNEL);
> -	if (!windows) {
> -		err = -ENOMEM;
> -		goto err_uninit_port;
> -	}
> -	for (i = 0; i < ep->max_regions; i++) {
> -		windows[i].phys_base = rockchip->mem_res->start + (SZ_1M * i);
> -		windows[i].size = SZ_1M;
> -		windows[i].page_size = SZ_1M;
> -	}
> -	err = pci_epc_multi_mem_init(epc, windows, ep->max_regions);
> -	devm_kfree(dev, windows);
> -
> -	if (err < 0) {
> -		dev_err(dev, "failed to initialize the memory space\n");
> -		goto err_uninit_port;
> -	}
> -
> -	ep->irq_cpu_addr = pci_epc_mem_alloc_addr(epc, &ep->irq_phys_addr,
> -						  SZ_1M);
> -	if (!ep->irq_cpu_addr) {
> -		dev_err(dev, "failed to reserve memory space for MSI\n");
> -		err = -ENOMEM;
> -		goto err_epc_mem_exit;
> -	}
> -
> -	ep->irq_pci_addr = ROCKCHIP_PCIE_EP_DUMMY_IRQ_ADDR;
> -
>  	/*
>  	 * MSI-X is not supported but the controller still advertises the MSI-X
>  	 * capability by default, which can lead to the Root Complex side
> @@ -638,10 +655,8 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
>  	pci_epc_init_notify(epc);
>  
>  	return 0;
> -err_epc_mem_exit:
> -	pci_epc_mem_exit(epc);
> -err_uninit_port:
> -	rockchip_pcie_deinit_phys(rockchip);
> +err_release_resources:
> +	rockchip_pcie_ep_release_resources(ep);
>  err_disable_clocks:
>  	rockchip_pcie_disable_clocks(rockchip);
>  	return err;
> -- 
> 2.46.2
> 

-- 
மணிவண்ணன் சதாசிவம்

