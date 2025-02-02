Return-Path: <linux-pci+bounces-20634-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6476A24E22
	for <lists+linux-pci@lfdr.de>; Sun,  2 Feb 2025 14:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A4D3A619A
	for <lists+linux-pci@lfdr.de>; Sun,  2 Feb 2025 13:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9E51D88C4;
	Sun,  2 Feb 2025 13:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZPuaUrIf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2E21D63E9
	for <linux-pci@vger.kernel.org>; Sun,  2 Feb 2025 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738501629; cv=none; b=iel+5bS6uA9MRbLm4J5lk3jV2ECBfZuXNanSQrmTB6GpjVVqN5AxoS9BT0kI6ycVZBfBjCSS5Sw2GnPKBK4GPuy/yyP4ahunQUzbTdgK2HRBtEKIrQZfwZ7WSa624t242Pqc9aOiyGIkxsgWmM67LxwTi0r4cgQK1LH64SwIOuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738501629; c=relaxed/simple;
	bh=+EFGRjLtEDuefczYzpPUkBPKWRCgjH8wwNEFT9iTrkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QyrHbOQitXd15Bvt6fj5nhRH1JKCWsOoB/kir7aBw7yn5bI5BZSAMFM6SFUR++zS7pg2+WKAqhzipVCIV4PG519OUy3HaiLtFa2gZiBRA/4+mf9yaDTNEZuK+vEj4WrmW53isa24x8rHJXxaDcIsPomXrAdPwuI9BHzhPrZh7Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZPuaUrIf; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2166360285dso56373545ad.1
        for <linux-pci@vger.kernel.org>; Sun, 02 Feb 2025 05:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738501626; x=1739106426; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AEtSfESy0LXYwcIk97/DpCu1vJYOD5v/63GGs+ly7q8=;
        b=ZPuaUrIfJ1jFPO3pxFs+T4RtFaDUhunlW9+cgPXo4y3x00qJ6HYW1PQNWAphHucMwc
         StlOdSI/13Y9GUDKAHAqP52ws4sKsneAfU8iPV/CfbqZooXn9GhblkuEJktrXPvqBHMl
         vWrA7sYXjP3MuR2akJegqGMNnVHvwI1jab8bOY2dkkuKuuFkeh9cNEPi+VmLqMXk29dI
         2PIJb4LXXaIyyKkCvyNlTX2QxiWAufu8cxLD9om/B1r80Gn3MjXQvz78ln2Wvv2XsOaq
         B7miCFt0VQZvTVHPJL/Sx4Nz7LGmiGZYA/eZScgjd2rV3XKFpoo86ape/A0+bAxG3nRj
         NFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738501626; x=1739106426;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AEtSfESy0LXYwcIk97/DpCu1vJYOD5v/63GGs+ly7q8=;
        b=HmHFo2TdjN3ScuALn9wsF0jBdU+1RnawsWyBWf0xGQMvj40nDJOh20pb0uEA9ZRCml
         zNvoumtTC9RSYn7OV4WbZQbKhsObF6zyk4YSiY1A+1SXCKLb03kMLzfYCL9s7LQsXQTq
         KxxajVUsNJ3zEpb9NpooSSwmYkr7oE7wzFqbTwgdeG6wOXUtehiK4zEzp11es2IDBEZv
         ts3Aw70h2191JkP99bNLApPyXd49qE9JzHihBCcun5vRpwOd0Fxi3XDE2FZQOBOfLK1I
         Ye8t0duFuxmsq0IKnXUSqqTmpJcTzk/5RxORJDJE7WXDFIyQm0CtHPX+6nbHsENZnTxw
         uW6g==
X-Forwarded-Encrypted: i=1; AJvYcCV0h38njzXKI+dG66Q8k62ch/5m8z1OKgajaiWvsleljxhETGe2thAlFv/xNzcYSS8a9K61fcXeeaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjxLMLu8G/gbrsGJJZ4p6tTaQ13KduBoWoCZ+N9z9uXK2ZnyiK
	scmCt1IXO7FjLxPg+lFreI3uigugBUFgnu9enB3iXaIj20cQR3abM1j7l6gRLA==
X-Gm-Gg: ASbGncvm5TLBNtszeyITIh2ACYyh5y6xg+OMnABCYojsAN7NSUKg+7P6UB7b8k57ce0
	IQw0PrCxwxvjzVkONevsLFAaP8J3C96DPH/Fn3Gx8W4OSXeYZwf8jfn18Nn5MskGlmirSeaN3Mn
	EbxIveL24+7a3uCx5Ln/GOlrCJJ1y2g8sDFNFhhiIVPXMoBtddQz8ZYF1eThGLdQLh+S6gNr9Zo
	bDPsJsc6rlSmv2CQ79N6jVRyd61PWr7QEOFq4LTgYgMkainCvBvlFgR1qwf1IzvbUlaWzhAo31b
	eJIOx6H/Ui3SpyCra72yuwiBQMY=
X-Google-Smtp-Source: AGHT+IGf7rXJRyTcFI27feBfmhjEX0I+8c58hz5t6F6Q1lohSE/2dfBnbL0zXQhaGDdbLonQJ6VASA==
X-Received: by 2002:a17:903:1106:b0:216:2426:7668 with SMTP id d9443c01a7336-21dd7c62a86mr264119375ad.13.1738501626198;
        Sun, 02 Feb 2025 05:07:06 -0800 (PST)
Received: from thinkpad ([120.60.136.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acebddbb1a4sm6169353a12.7.2025.02.02.05.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2025 05:07:05 -0800 (PST)
Date: Sun, 2 Feb 2025 18:36:57 +0530
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
Message-ID: <20250202130657.zcnvnnwclxup6y7i@thinkpad>
References: <20250128120745.334377-1-christian.bruel@foss.st.com>
 <20250128120745.334377-4-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250128120745.334377-4-christian.bruel@foss.st.com>

On Tue, Jan 28, 2025 at 01:07:38PM +0100, Christian Bruel wrote:
> Add driver for the STM32MP25 SoC PCIe Gen1 2.5 GT/s and Gen2 5GT/s
> controller based on the DesignWare PCIe core.
> 
> Supports MSI via GICv2m, Single Virtual Channel, Single Function
> 
> Supports wakeup-source from gpio wake_irq with dw_pcie_wake_irq_handler
> for host wakeup.
> 

"Supports WAKE# GPIO" is what should be mentioned above.

> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> ---
>  drivers/pci/controller/dwc/Kconfig      |  12 +
>  drivers/pci/controller/dwc/Makefile     |   1 +
>  drivers/pci/controller/dwc/pcie-stm32.c | 372 ++++++++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-stm32.h |  15 +
>  4 files changed, 400 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-stm32.c
>  create mode 100644 drivers/pci/controller/dwc/pcie-stm32.h
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index b6d6778b0698..0c18879b604c 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -389,6 +389,18 @@ config PCIE_SPEAR13XX
>  	help
>  	  Say Y here if you want PCIe support on SPEAr13XX SoCs.
>  
> +config PCIE_STM32
> +	tristate "STMicroelectronics STM32MP25 PCIe Controller (host mode)"
> +	depends on ARCH_STM32 || COMPILE_TEST
> +	depends on PCI_MSI
> +	select PCIE_DW_HOST
> +	help
> +	  Enables support for the DesignWare core based PCIe host controller
> +	  found in STM32MP25 SoC.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called pcie-stm32.
> +
>  config PCI_DRA7XX
>  	tristate
>  
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index a8308d9ea986..576d99cb3bc5 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
>  obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
>  obj-$(CONFIG_PCIE_VISCONTI_HOST) += pcie-visconti.o
>  obj-$(CONFIG_PCIE_RCAR_GEN4) += pcie-rcar-gen4.o
> +obj-$(CONFIG_PCIE_STM32) += pcie-stm32.o
>  
>  # The following drivers are for devices that use the generic ACPI
>  # pci_root.c driver but don't support standard ECAM config access.
> diff --git a/drivers/pci/controller/dwc/pcie-stm32.c b/drivers/pci/controller/dwc/pcie-stm32.c
> new file mode 100644
> index 000000000000..d5e473bb390f
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-stm32.c
> @@ -0,0 +1,372 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * STMicroelectronics STM32MP25 PCIe root complex driver.
> + *
> + * Copyright (C) 2024 STMicroelectronics

2025?

> + * Author: Christian Bruel <christian.bruel@foss.st.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_platform.h>
> +#include <linux/phy/phy.h>
> +#include <linux/pinctrl/devinfo.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include "pcie-designware.h"
> +#include "pcie-stm32.h"
> +#include "../../pci.h"
> +
> +struct stm32_pcie {
> +	struct dw_pcie pci;
> +	struct regmap *regmap;
> +	struct reset_control *rst;
> +	struct phy *phy;
> +	struct clk *clk;
> +	struct gpio_desc *perst_gpio;
> +	struct gpio_desc *wake_gpio;
> +	unsigned int wake_irq;
> +};
> +
> +static void stm32_pcie_deassert_perst(struct stm32_pcie *stm32_pcie)
> +{
> +	gpiod_set_value(stm32_pcie->perst_gpio, 0);
> +
> +	if (stm32_pcie->perst_gpio)
> +		msleep(PCIE_T_RRS_READY_MS);
> +}
> +
> +static void stm32_pcie_assert_perst(struct stm32_pcie *stm32_pcie)
> +{
> +	gpiod_set_value(stm32_pcie->perst_gpio, 1);
> +}
> +
> +static int stm32_pcie_start_link(struct dw_pcie *pci)
> +{
> +	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
> +
> +	return regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
> +				  STM32MP25_PCIECR_LTSSM_EN,
> +				  STM32MP25_PCIECR_LTSSM_EN);
> +}
> +
> +static void stm32_pcie_stop_link(struct dw_pcie *pci)
> +{
> +	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
> +
> +	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
> +			   STM32MP25_PCIECR_LTSSM_EN, 0);
> +}
> +
> +static int stm32_pcie_suspend(struct device *dev)
> +{
> +	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
> +
> +	if (device_may_wakeup(dev))
> +		enable_irq_wake(stm32_pcie->wake_irq);
> +
> +	return 0;
> +}
> +
> +static int stm32_pcie_resume(struct device *dev)
> +{
> +	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
> +
> +	if (device_may_wakeup(dev))
> +		disable_irq_wake(stm32_pcie->wake_irq);
> +
> +	return 0;
> +}
> +
> +static int stm32_pcie_suspend_noirq(struct device *dev)
> +{

Can you consider making use of dw_pcie_{suspend/resume}_noirq()?

> +	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
> +
> +	stm32_pcie_stop_link(&stm32_pcie->pci);
> +
> +	stm32_pcie_assert_perst(stm32_pcie);
> +
> +	clk_disable_unprepare(stm32_pcie->clk);
> +
> +	if (!device_may_wakeup(dev))
> +		phy_exit(stm32_pcie->phy);
> +
> +	return pinctrl_pm_select_sleep_state(dev);
> +}
> +
> +static int stm32_pcie_resume_noirq(struct device *dev)
> +{
> +	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
> +	struct dw_pcie_rp *pp = &stm32_pcie->pci.pp;
> +	int ret;
> +
> +	/*
> +	 * The core clock is gated with CLKREQ# from the COMBOPHY REFCLK,
> +	 * thus if no device is present, must force it low with an init pinmux
> +	 * to be able to access the DBI registers.
> +	 */
> +	if (!IS_ERR(dev->pins->init_state))
> +		ret = pinctrl_select_state(dev->pins->p, dev->pins->init_state);
> +	else
> +		ret = pinctrl_pm_select_default_state(dev);
> +
> +	if (ret) {
> +		dev_err(dev, "Failed to activate pinctrl pm state: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (!device_may_wakeup(dev)) {
> +		ret = phy_init(stm32_pcie->phy);
> +		if (ret) {
> +			pinctrl_pm_select_default_state(dev);
> +			return ret;
> +		}
> +	}
> +
> +	ret = clk_prepare_enable(stm32_pcie->clk);
> +	if (ret)
> +		goto err_phy_exit;
> +
> +	stm32_pcie_deassert_perst(stm32_pcie);
> +
> +	ret = dw_pcie_setup_rc(pp);
> +	if (ret)
> +		goto err_disable_clk;
> +
> +	ret = stm32_pcie_start_link(&stm32_pcie->pci);
> +	if (ret)
> +		goto err_disable_clk;
> +
> +	/* Ignore errors, the link may come up later */
> +	dw_pcie_wait_for_link(&stm32_pcie->pci);

These can be dropped when using dw_pcie_resume_noirq().

> +
> +	pinctrl_pm_select_default_state(dev);
> +
> +	return 0;
> +
> +err_disable_clk:
> +	stm32_pcie_assert_perst(stm32_pcie);
> +	clk_disable_unprepare(stm32_pcie->clk);
> +
> +err_phy_exit:
> +	phy_exit(stm32_pcie->phy);
> +	pinctrl_pm_select_default_state(dev);
> +
> +	return ret;
> +}
> +
> +static const struct dev_pm_ops stm32_pcie_pm_ops = {
> +	NOIRQ_SYSTEM_SLEEP_PM_OPS(stm32_pcie_suspend_noirq,
> +				  stm32_pcie_resume_noirq)
> +	SYSTEM_SLEEP_PM_OPS(stm32_pcie_suspend, stm32_pcie_resume)
> +};
> +
> +static const struct dw_pcie_host_ops stm32_pcie_host_ops = {
> +};
> +
> +static const struct dw_pcie_ops dw_pcie_ops = {
> +	.start_link = stm32_pcie_start_link,
> +	.stop_link = stm32_pcie_stop_link
> +};
> +
> +static int stm32_add_pcie_port(struct stm32_pcie *stm32_pcie,
> +			       struct platform_device *pdev)
> +{
> +	struct device *dev = stm32_pcie->pci.dev;
> +	struct dw_pcie_rp *pp = &stm32_pcie->pci.pp;
> +	int ret;
> +

You need to assert PERST# before configuring the resources.

> +	ret = phy_set_mode(stm32_pcie->phy, PHY_MODE_PCIE);
> +	if (ret)
> +		return ret;
> +
> +	ret = phy_init(stm32_pcie->phy);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
> +				 STM32MP25_PCIECR_TYPE_MASK,
> +				 STM32MP25_PCIECR_RC);
> +	if (ret)
> +		goto err_phy_exit;
> +
> +	reset_control_assert(stm32_pcie->rst);
> +	reset_control_deassert(stm32_pcie->rst);
> +
> +	ret = clk_prepare_enable(stm32_pcie->clk);
> +	if (ret) {
> +		dev_err(dev, "Core clock enable failed %d\n", ret);
> +		goto err_phy_exit;
> +	}
> +
> +	stm32_pcie_deassert_perst(stm32_pcie);
> +
> +	pp->ops = &stm32_pcie_host_ops;
> +	ret = dw_pcie_host_init(pp);
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize host: %d\n", ret);
> +		goto err_disable_clk;
> +	}

Technically, dw_pcie_host_init() is not related to root port. So please move it
to probe() instead.

> +
> +	return 0;
> +
> +err_disable_clk:
> +	clk_disable_unprepare(stm32_pcie->clk);
> +	stm32_pcie_assert_perst(stm32_pcie);
> +
> +err_phy_exit:
> +	phy_exit(stm32_pcie->phy);
> +
> +	return ret;
> +}
> +
> +static int stm32_pcie_parse_port(struct stm32_pcie *stm32_pcie)
> +{
> +	struct device *dev = stm32_pcie->pci.dev;
> +	struct device_node *root_port;
> +
> +	root_port = of_get_next_available_child(dev->of_node, NULL);
> +
> +	stm32_pcie->phy = devm_of_phy_get(dev, root_port, NULL);
> +	if (IS_ERR(stm32_pcie->phy))
> +		return dev_err_probe(dev, PTR_ERR(stm32_pcie->phy),
> +				     "Failed to get pcie-phy\n");

OF refcount not decremented in both the error and success case.

> +
> +	stm32_pcie->perst_gpio = devm_fwnode_gpiod_get(dev, of_fwnode_handle(root_port),
> +						       "reset", GPIOD_OUT_HIGH, NULL);
> +	if (IS_ERR(stm32_pcie->perst_gpio)) {
> +		if (PTR_ERR(stm32_pcie->perst_gpio) != -ENOENT)
> +			return dev_err_probe(dev, PTR_ERR(stm32_pcie->perst_gpio),
> +					     "Failed to get reset GPIO\n");
> +		stm32_pcie->perst_gpio = NULL;
> +	}
> +
> +	if (device_property_read_bool(dev, "wakeup-source")) {

As per the current logic, 'wakeup-source' is applicable even without WAKE# GPIO,
which doesn't make sense.

> +		stm32_pcie->wake_gpio = devm_fwnode_gpiod_get(dev, of_fwnode_handle(root_port),
> +							      "wake", GPIOD_IN, NULL);
> +
> +		if (IS_ERR(stm32_pcie->wake_gpio)) {
> +			if (PTR_ERR(stm32_pcie->wake_gpio) != -ENOENT)
> +				return dev_err_probe(dev, PTR_ERR(stm32_pcie->wake_gpio),
> +						     "Failed to get wake GPIO\n");
> +			stm32_pcie->wake_gpio = NULL;
> +		}

Hmm. I think we need to move WAKE# handling inside drivers/pci/pcie/portdrv.c
since that is responsible for the root port. While other root port properties
have some dependency with the RC (like PERST#, PHY etc...), WAKE# handling could
be moved safely.

And once done, it can benefit all platforms.

> +	}
> +
> +	return 0;
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
> +	ret = stm32_pcie_parse_port(stm32_pcie);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, stm32_pcie);
> +
> +	if (stm32_pcie->wake_gpio) {
> +		stm32_pcie->wake_irq = gpiod_to_irq(stm32_pcie->wake_gpio);
> +
> +		ret = devm_request_threaded_irq(&pdev->dev,
> +						stm32_pcie->wake_irq, NULL,
> +						dw_pcie_wake_irq_handler,
> +						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +						"wake_irq", stm32_pcie->pci.dev);
> +
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to request WAKE IRQ: %d\n", ret);
> +	}
> +
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to enable runtime PM %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = pm_runtime_resume_and_get(dev);

Why do you need to do PM resume here? Is there a parent that needs to be resumed
now? I know that other controller drivers have this pattern, but most of them
are just doing it wrong.

Most likely you need pm_runtime_set_active() before devm_pm_runtime_enable().

> +	if (ret < 0) {
> +		dev_err(dev, "Failed to get runtime PM %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = stm32_add_pcie_port(stm32_pcie, pdev);
> +	if (ret)  {

Nit: double space.

> +		pm_runtime_put_sync(&pdev->dev);
> +		return ret;
> +	}
> +
> +	if (stm32_pcie->wake_gpio)
> +		device_set_wakeup_capable(dev, true);
> +
> +	return 0;
> +}
> +
> +static void stm32_pcie_remove(struct platform_device *pdev)
> +{
> +	struct stm32_pcie *stm32_pcie = platform_get_drvdata(pdev);
> +	struct dw_pcie_rp *pp = &stm32_pcie->pci.pp;
> +
> +	if (stm32_pcie->wake_gpio)
> +		device_init_wakeup(&pdev->dev, false);
> +
> +	dw_pcie_host_deinit(pp);
> +
> +	stm32_pcie_assert_perst(stm32_pcie);
> +
> +	clk_disable_unprepare(stm32_pcie->clk);
> +
> +	phy_exit(stm32_pcie->phy);
> +
> +	pm_runtime_put_sync(&pdev->dev);
> +}
> +
> +static const struct of_device_id stm32_pcie_of_match[] = {
> +	{ .compatible = "st,stm32mp25-pcie-rc" },
> +	{},
> +};
> +
> +static struct platform_driver stm32_pcie_driver = {
> +	.probe = stm32_pcie_probe,
> +	.remove = stm32_pcie_remove,
> +	.driver = {
> +		.name = "stm32-pcie",
> +		.of_match_table = stm32_pcie_of_match,
> +		.pm = &stm32_pcie_pm_ops,
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +};
> +
> +module_platform_driver(stm32_pcie_driver);
> +
> +MODULE_AUTHOR("Christian Bruel <christian.bruel@foss.st.com>");
> +MODULE_DESCRIPTION("STM32MP25 PCIe Controller driver");
> +MODULE_LICENSE("GPL");
> +MODULE_DEVICE_TABLE(of, stm32_pcie_of_match);
> diff --git a/drivers/pci/controller/dwc/pcie-stm32.h b/drivers/pci/controller/dwc/pcie-stm32.h
> new file mode 100644
> index 000000000000..3efd00937d3d
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-stm32.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * ST PCIe driver definitions for STM32-MP25 SoC
> + *
> + * Copyright (C) 2024 STMicroelectronics - All Rights Reserved
> + * Author: Christian Bruel <christian.bruel@foss.st.com>
> + */
> +
> +#define to_stm32_pcie(x)	dev_get_drvdata((x)->dev)
> +
> +#define STM32MP25_PCIECR_TYPE_MASK	GENMASK(11, 8)
> +#define STM32MP25_PCIECR_LTSSM_EN	BIT(2)
> +#define STM32MP25_PCIECR_RC		BIT(10)
> +
> +#define SYSCFG_PCIECR			0x6000

You can just move these definitions inside the driver itself.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

