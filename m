Return-Path: <linux-pci+bounces-20930-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4793A2CB69
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 19:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97DC83A3AAD
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 18:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0221F1DED60;
	Fri,  7 Feb 2025 18:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M+GQ6leg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13611DE89A
	for <linux-pci@vger.kernel.org>; Fri,  7 Feb 2025 18:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738952657; cv=none; b=eUD6etyw6zJNsc4rUqw9AmmvaFtH0xdWsklx4dHgJNifpONv0ZQDnT9UFnSCiksLNp/VIB+P93fKZn1/ioL3XtVGF+7HHBCyCpzNdBES5ZKzEH8kfKsj9xt2bgDTbAAWmETuUF8NE6eg6/YpDCyiw+f/3oOz4kpnU7nbzSyhZRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738952657; c=relaxed/simple;
	bh=c3Wx1XIoKpeCpjmwt5ragirFyD8d6iZ7jAaoQ+syRZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8ADJqlV8JXztn4JreJ+TQWsmMXvIBRF3rgV7FkADQk1BWiTlBvL5hvaw/q6OgQY41lrHE6dO4Li/nLMbbnBQkRfEw1p7fXd4GhbdupwYEkkCwCFMkwzUU7gHQw8ld8JPEKgDR2RarYQM/NxXVKMBi7k/m2hGd3hdmXbEivKeP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M+GQ6leg; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f3c119fe6so50222745ad.0
        for <linux-pci@vger.kernel.org>; Fri, 07 Feb 2025 10:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738952655; x=1739557455; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DkwAJF68ddKYCYzSotu3EQrgC/afwa7x23RU3wj1Lu4=;
        b=M+GQ6legghx9arWZIaxbhPXWx5AIWQORXBcpdyTXETJ570dKJkcOSRm8ba7AwFsqsO
         xezFiYDsIZxA0g40EeFDV79w5WwiDNRPB23Z57RrbjTUv/L4hiMMnzl2snYL597+S5ZC
         iOyF8Mq4kvSPpsuAuQ8E6dB1bgOAZt1URWRgYKhZ2XUYWEBwUKri3+Y3o3kDgT3bIMhQ
         jAFiFwRg9ZQAlYd6+Bi1sHX+TZC2rOxzCwhzW0kcRSKcTRHp8k9iL2DpmSlU8yhMvWh9
         eRh6SlklmZBfqzqtjGrMDvG7TuNcWOy7sV2kw57X/ku0LR3ox9p/PcGD7MPsx9I/169x
         iG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738952655; x=1739557455;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DkwAJF68ddKYCYzSotu3EQrgC/afwa7x23RU3wj1Lu4=;
        b=KuaKWmD42wUWdkedZNqmngogGGqIoUrqrVYsk1yPVbe/DFGVna3aISEj7YnTpKZrAa
         PWOsIw6EZF71wLJ/dde60+94Am8jDlyyYwNxq2++IaPCgZDdiBrS3q3FUNFa2icQ7ERR
         OPOGqD4xslZxNqNSGSy52ySU4++pUOIGz6oQrptloZZMaCB6yyqGnoXQQJCarmzydxef
         R24vVxn8/xRbbV8Xiq29BaZucHbg3RAXNZdPJBxtNUKtrUWWi3JBo6/GGosJXipAr6tD
         CLBogUe2VqwCDJDCAjshPozVliQDJ7qUa2AwDjNdbReVVlGJPNLq4lZAzPcSOJjCMpWM
         Olrg==
X-Forwarded-Encrypted: i=1; AJvYcCV4+0d9zDKb+s/L3JG9H1vf4X9/2ai/PBDBX0JoEHTENtaonHMQ6dmEMPrxtSHk5E6MALvIX7wFku0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjR0TY/QggsQzvoRDKl8xnpmZ26wd8BuI1BIzzAtuC7UMUS46T
	qPbE1+bDn9IfEAciUcLW7lwJ6tFukGr30gbWX+GjO99Y23zW26qMPruQEReT+g==
X-Gm-Gg: ASbGnctXyfcix9SBwaKhqPGqQiOROWEH7LxL0VCY7Yq5OuDG8jJ+e2wLoQakSQy1JkQ
	RmoinKYts9IsFSK3wIQZFNDtWE761T7NwvvE6iim08qeqx9iLaHW1DbAuha5z0LdMRcp/Lv7LP/
	lrLQKp28rD+2TBtJTt3xNFxN71++N4GKcWnDRAwT35mOV5cdVOnBdlM1rfJOI5VqpSTYOlAdKMs
	Jp1Q+w4WOF0IvBJZl2xSXuOZog7JFllnje/6IxnoSs8LY6EJ1HVzyN1K7czU+wTFyq/Fn8iM1UZ
	a3s8sjaVn0N2tqkBywunUjVh4g==
X-Google-Smtp-Source: AGHT+IGA7rR64+8iuyium8I0L5YN9X5M5xr/Pbcn8VKunOXV0dz9WjvNVRMuT/szkavIDCp3qlMBoA==
X-Received: by 2002:a17:903:987:b0:215:a964:e680 with SMTP id d9443c01a7336-21f4e6ce779mr71018085ad.25.1738952655067;
        Fri, 07 Feb 2025 10:24:15 -0800 (PST)
Received: from thinkpad ([120.60.76.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650e6c0sm33523025ad.22.2025.02.07.10.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 10:24:14 -0800 (PST)
Date: Fri, 7 Feb 2025 23:54:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	jingoohan1@gmail.com, p.zabel@pengutronix.de,
	johan+linaro@kernel.org, quic_schintav@quicinc.com,
	cassel@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	fabrice.gasnier@foss.st.com
Subject: Re: [PATCH v4 03/10] PCI: stm32: Add PCIe host support for STM32MP25
Message-ID: <20250207182408.ila3lng3el4s7kf6@thinkpad>
References: <20250128120745.334377-1-christian.bruel@foss.st.com>
 <20250128120745.334377-4-christian.bruel@foss.st.com>
 <20250202130657.zcnvnnwclxup6y7i@thinkpad>
 <f4be9537-5631-4d11-9237-0cc421891669@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4be9537-5631-4d11-9237-0cc421891669@foss.st.com>

On Tue, Feb 04, 2025 at 05:23:05PM +0100, Christian Bruel wrote:

[...]

> > > +static int stm32_pcie_suspend_noirq(struct device *dev)
> > > +{
> > 
> > Can you consider making use of dw_pcie_{suspend/resume}_noirq()?
> 
> I considered this, but dw_pcie_suspend_noirq needs to be tweaked as it
> checks both the pme_turn_off hook and whether we are entering into L2, which
> we don't support.
> 
> For the former, I can check the PCI_EXP_DEVSTAT_AUXPD capability before
> polling for L2 LTSSM. It looks like only the Layerscape platform uses this.
> I will need a Tested-by for this new dw_pcie_suspend_noirq.
> 
> Do you advise keeping stm32_pcie_suspend_noirq or modifying
> dw_pcie_suspend_noirq to this effect?
> 

Please modify dw_pcie_suspend_noirq() to fit your needs. We will review the
change.

For testing the change, you can CC the Layerscape maintainer and request for
testing.

> Thanks,
> 
> > 
> > > +	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
> > > +
> > > +	stm32_pcie_stop_link(&stm32_pcie->pci);
> > > +
> > > +	stm32_pcie_assert_perst(stm32_pcie);
> > > +
> > > +	clk_disable_unprepare(stm32_pcie->clk);
> > > +
> > > +	if (!device_may_wakeup(dev))
> > > +		phy_exit(stm32_pcie->phy);
> > > +
> > > +	return pinctrl_pm_select_sleep_state(dev);
> > > +}
> > > +
> > > +static int stm32_pcie_resume_noirq(struct device *dev)
> > > +{
> > > +	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
> > > +	struct dw_pcie_rp *pp = &stm32_pcie->pci.pp;
> > > +	int ret;
> > > +
> > > +	/*
> > > +	 * The core clock is gated with CLKREQ# from the COMBOPHY REFCLK,
> > > +	 * thus if no device is present, must force it low with an init pinmux
> > > +	 * to be able to access the DBI registers.
> > > +	 */
> > > +	if (!IS_ERR(dev->pins->init_state))
> > > +		ret = pinctrl_select_state(dev->pins->p, dev->pins->init_state);
> > > +	else
> > > +		ret = pinctrl_pm_select_default_state(dev);
> > > +
> > > +	if (ret) {
> > > +		dev_err(dev, "Failed to activate pinctrl pm state: %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	if (!device_may_wakeup(dev)) {
> > > +		ret = phy_init(stm32_pcie->phy);
> > > +		if (ret) {
> > > +			pinctrl_pm_select_default_state(dev);
> > > +			return ret;
> > > +		}
> > > +	}
> > > +
> > > +	ret = clk_prepare_enable(stm32_pcie->clk);
> > > +	if (ret)
> > > +		goto err_phy_exit;
> > > +
> > > +	stm32_pcie_deassert_perst(stm32_pcie);
> > > +
> > > +	ret = dw_pcie_setup_rc(pp);
> > > +	if (ret)
> > > +		goto err_disable_clk;
> > > +
> > > +	ret = stm32_pcie_start_link(&stm32_pcie->pci);
> > > +	if (ret)
> > > +		goto err_disable_clk;
> > > +
> > > +	/* Ignore errors, the link may come up later */
> > > +	dw_pcie_wait_for_link(&stm32_pcie->pci);
> > 
> > These can be dropped when using dw_pcie_resume_noirq().
> 
> OK for dw_pcie_resume_noirq if we can keep it balanced with
> dw_pcie_suspend_noirq
> 
> > 
> > > +
> > > +	pinctrl_pm_select_default_state(dev);
> > > +
> > > +	return 0;
> > > +
> > > +err_disable_clk:
> > > +	stm32_pcie_assert_perst(stm32_pcie);
> > > +	clk_disable_unprepare(stm32_pcie->clk);
> > > +
> > > +err_phy_exit:
> > > +	phy_exit(stm32_pcie->phy);
> > > +	pinctrl_pm_select_default_state(dev);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static const struct dev_pm_ops stm32_pcie_pm_ops = {
> > > +	NOIRQ_SYSTEM_SLEEP_PM_OPS(stm32_pcie_suspend_noirq,
> > > +				  stm32_pcie_resume_noirq)
> > > +	SYSTEM_SLEEP_PM_OPS(stm32_pcie_suspend, stm32_pcie_resume)
> > > +};
> > > +
> > > +static const struct dw_pcie_host_ops stm32_pcie_host_ops = {
> > > +};
> > > +
> > > +static const struct dw_pcie_ops dw_pcie_ops = {
> > > +	.start_link = stm32_pcie_start_link,
> > > +	.stop_link = stm32_pcie_stop_link
> > > +};
> > > +
> > > +static int stm32_add_pcie_port(struct stm32_pcie *stm32_pcie,
> > > +			       struct platform_device *pdev)
> > > +{
> > > +	struct device *dev = stm32_pcie->pci.dev;
> > > +	struct dw_pcie_rp *pp = &stm32_pcie->pci.pp;
> > > +	int ret;
> > > +
> > 
> > You need to assert PERST# before configuring the resources.
> 
> It is already initialized to GPIOD_OUT_HIGH in gpiod_get, I can have an
> explicit stm32_pcie_assert_perst but is it necessary ?
> 

Ok, not necessary. Although, I would recommend to keep a comment here so that if
someone refactors the code, they would notice it.

> > 
> > > +	ret = phy_set_mode(stm32_pcie->phy, PHY_MODE_PCIE);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = phy_init(stm32_pcie->phy);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
> > > +				 STM32MP25_PCIECR_TYPE_MASK,
> > > +				 STM32MP25_PCIECR_RC);
> > > +	if (ret)
> > > +		goto err_phy_exit;
> > > +
> > > +	reset_control_assert(stm32_pcie->rst);
> > > +	reset_control_deassert(stm32_pcie->rst);
> > > +
> > > +	ret = clk_prepare_enable(stm32_pcie->clk);
> > > +	if (ret) {
> > > +		dev_err(dev, "Core clock enable failed %d\n", ret);
> > > +		goto err_phy_exit;
> > > +	}
> > > +
> > > +	stm32_pcie_deassert_perst(stm32_pcie);
> > > +
> > > +	pp->ops = &stm32_pcie_host_ops;
> > > +	ret = dw_pcie_host_init(pp);
> > > +	if (ret) {
> > > +		dev_err(dev, "Failed to initialize host: %d\n", ret);
> > > +		goto err_disable_clk;
> > > +	}
> > 
> > Technically, dw_pcie_host_init() is not related to root port. So please move it
> > to probe() instead.
> 
> OK will move, thanks
> 
> > 
> > > +
> > > +	return 0;
> > > +
> > > +err_disable_clk:
> > > +	clk_disable_unprepare(stm32_pcie->clk);
> > > +	stm32_pcie_assert_perst(stm32_pcie);
> > > +
> > > +err_phy_exit:
> > > +	phy_exit(stm32_pcie->phy);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static int stm32_pcie_parse_port(struct stm32_pcie *stm32_pcie)
> > > +{
> > > +	struct device *dev = stm32_pcie->pci.dev;
> > > +	struct device_node *root_port;
> > > +
> > > +	root_port = of_get_next_available_child(dev->of_node, NULL);
> > > +
> > > +	stm32_pcie->phy = devm_of_phy_get(dev, root_port, NULL);
> > > +	if (IS_ERR(stm32_pcie->phy))
> > > +		return dev_err_probe(dev, PTR_ERR(stm32_pcie->phy),
> > > +				     "Failed to get pcie-phy\n");
> > 
> > OF refcount not decremented in both the error and success case.
> 
> I don't understand your point, isn't devm_of_phy_get managed to decrement
> the phy resources ?
> 

You should drop the refcount of the root_port using of_node_put().

> > 
> > > +
> > > +	stm32_pcie->perst_gpio = devm_fwnode_gpiod_get(dev, of_fwnode_handle(root_port),
> > > +						       "reset", GPIOD_OUT_HIGH, NULL);
> > > +	if (IS_ERR(stm32_pcie->perst_gpio)) {
> > > +		if (PTR_ERR(stm32_pcie->perst_gpio) != -ENOENT)
> > > +			return dev_err_probe(dev, PTR_ERR(stm32_pcie->perst_gpio),
> > > +					     "Failed to get reset GPIO\n");
> > > +		stm32_pcie->perst_gpio = NULL;
> > > +	}
> > > +
> > > +	if (device_property_read_bool(dev, "wakeup-source")) {
> > 
> > As per the current logic, 'wakeup-source' is applicable even without WAKE# GPIO,
> > which doesn't make sense.
> 
> Agree, wakeup-source is not needed
> 
> > 
> > > +		stm32_pcie->wake_gpio = devm_fwnode_gpiod_get(dev, of_fwnode_handle(root_port),
> > > +							      "wake", GPIOD_IN, NULL);
> > > +
> > > +		if (IS_ERR(stm32_pcie->wake_gpio)) {
> > > +			if (PTR_ERR(stm32_pcie->wake_gpio) != -ENOENT)
> > > +				return dev_err_probe(dev, PTR_ERR(stm32_pcie->wake_gpio),
> > > +						     "Failed to get wake GPIO\n");
> > > +			stm32_pcie->wake_gpio = NULL;
> > > +		}
> > 
> > Hmm. I think we need to move WAKE# handling inside drivers/pci/pcie/portdrv.c
> > since that is responsible for the root port. While other root port properties
> > have some dependency with the RC (like PERST#, PHY etc...), WAKE# handling could
> > be moved safel >
> > And once done, it can benefit all platforms.
> 
> OK I'll check if there is a convenient way to do this through a port_service
> 

You can drop the WAKE# support altogether and add it in the subsequent patches
once this initial driver gets merged. It is up to you.

> > 
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +

[...]

> > You can just move these definitions inside the driver itself.
> > 
> 
> Some definitions will be duplicated with the ep driver, but on the other
> side this file is very small... is it OK to duplicate definitions instead of
> having the bitfields together ?
> 

I didn't notice that these are reused by the ep driver. Fine with me.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

