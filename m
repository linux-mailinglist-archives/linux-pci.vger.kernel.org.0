Return-Path: <linux-pci+bounces-17578-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 318469E200A
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 15:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5060287D9D
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 14:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA071F754B;
	Tue,  3 Dec 2024 14:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cThtXUNV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16721F6679
	for <linux-pci@vger.kernel.org>; Tue,  3 Dec 2024 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237579; cv=none; b=GDnqiCYPckU68AO9yRqG61TzrkezfDoGsqXtwYMNeJOgsK2Ubj6sZoA82In0hfbBA18vKcTPyHoVZFmjcqna1BDOZoG3xmiSv1BZtSsFbt3xA65LBLzOB8SzUO2XoCuBEwZrQ88eg7A3FpHOqrrBG0DTQf9wEoaU1vNEh8ZPZnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237579; c=relaxed/simple;
	bh=w8xw1ili6O9MPpTtO7VdevXne64Ju3Re99Zgm8luRms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpXSPCB56sF2DFnZp1u0CAzexFXgd3PKSCqh0Oh3YYhxE57F0CcTn2yrDyKxQ6MiLeNOJOBnRxJL+vEytfhMBf4u8HOh4ctYuB6UHFx0n1Q3CktXpmD27egnQay6/L+qaKRq+hbdFIQyrTtD6GiXB1+02S9wrykIm5Df2XX44MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cThtXUNV; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-215b13e9ccbso16102405ad.0
        for <linux-pci@vger.kernel.org>; Tue, 03 Dec 2024 06:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733237576; x=1733842376; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+OqtoDTcuDSPlXiGjMGD8T8dleAY1Lykd97YYdvjsFI=;
        b=cThtXUNVDhwpRaw3VN5WrDD0v4hH7gqce0tPH0+10zHvUtRJ+YRr9nPkQ6U0BGdxtL
         QWCKno75GMbF/Zb5jy95FQ7PFV83iIEjBG0ZUwBcynJ9pRPDmjgwzs3CuyCcgCNhpW4y
         07eAjTBlXdyONerExKGJ/mA/V5v7Q2HqfXaNm6GK6WXgh4EkcYLfwCfBYjttLhcm4E5V
         6QELaCw2Uu2VD3V6nJPPGxHUpSMWGsGEVgX2TdKT3CDHOgkuraOuHqEx6hFLHM5KEZo0
         dm0MPkogjWPsXbbKkX2d5yZ3WLJ0O/QJAi7lE0tzKvGvGWFU6x4k1cqTqxwOR/8VVSfi
         VozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733237576; x=1733842376;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+OqtoDTcuDSPlXiGjMGD8T8dleAY1Lykd97YYdvjsFI=;
        b=lQi8EZIwW3cEUYhw3tA6HUaUQOdPo9C719258RKP7oxkVM9Jb5IX49N35TB40p0fSH
         C47+gLFOkZWYKVLGyh7+vG9Ekf0OcEkXnCcvn0DkLMZhzTV54Abz5C2Em5g1Ngj2vzU4
         RhySLdHH5sCje4Q6mrDZVWCOpcFvQjnkiZ3RFb3VEQ1b8eXmlrXUfgIbSUdvBqdJ4+wx
         HH04znVBfr1TMthmnhM/e7A9Pdkxd4NyDoXTmaecLaibAOMgh4s5cRFgLiJfuSZ8VJUR
         9h/yaQR97rlJ4af2exd4b44qjO+epWNLqJkoZZ1lxN/lYdKUuRTqy/BIn8naIvvcI0Ya
         4OBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQqWK5w4ZM+j6oW7sevqoJGpRRk6qKccp+taJBrDVnJj9kVo10RNEKZ7EBFrucc9sK2xaKVE38Eto=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3AWOXZOWgkmj/bKMBkG8161Dz7Hbf2lKTEgziVycmLEfbJhys
	yIXGjgTIuK5KYhDHXADZe0+r7m6oJPxet0rhlRNGeV2WxCTbXUGWA82pPL2/Ag==
X-Gm-Gg: ASbGncvxzTzICBct9+u3tspf+0rRYMhmFM/r+hOUcMa5ovnchetGRbt9JjSoFIjmTKm
	8CjzkMT6fr7UF0DT4PvytzftTddLpHUXotC1zodI733J7Iah6OIBcCVJeNznOdCZB6VvEQjeo9Z
	eBzJNXJ2VysgUIxH85xr8KBTUMtmhuV14jCq8Um0+Z9hIpY/g8rQvAY2+J8SE3bOi1QEq1ovvTo
	pA6B/2dIcZwmvupeZmmJs/rshjkF9YHYqA/hGeDd/VL0QqwzL1SVhB3OqaR
X-Google-Smtp-Source: AGHT+IG2+O34hbdTJ6jI9K4DCqLyYnmrK/L3HYJwczUUv/4lkpV9ewWB4mibpWI78gxJlkRNGNzT+g==
X-Received: by 2002:a17:902:ecc7:b0:215:7b7b:5cc9 with SMTP id d9443c01a7336-215bd0e035emr36010635ad.22.1733237575835;
        Tue, 03 Dec 2024 06:52:55 -0800 (PST)
Received: from thinkpad ([120.60.48.217])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215964b6b76sm35813645ad.191.2024.12.03.06.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 06:52:55 -0800 (PST)
Date: Tue, 3 Dec 2024 20:22:44 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	p.zabel@pengutronix.de, cassel@kernel.org,
	quic_schintav@quicinc.com, fabrice.gasnier@foss.st.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] PCI: stm32: Add PCIe host support for STM32MP25
Message-ID: <20241203145244.trgrobtfmumtiwuc@thinkpad>
References: <20241126155119.1574564-1-christian.bruel@foss.st.com>
 <20241126155119.1574564-3-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241126155119.1574564-3-christian.bruel@foss.st.com>

On Tue, Nov 26, 2024 at 04:51:16PM +0100, Christian Bruel wrote:
> Add driver for the STM32MP25 SoC PCIe Gen2 controller based on the
> DesignWare PCIe core.
> 
> Supports MSI via GICv2m, Single Virtual Channel, Single Function
> 
> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> ---
>  drivers/pci/controller/dwc/Kconfig      |  12 +
>  drivers/pci/controller/dwc/Makefile     |   1 +
>  drivers/pci/controller/dwc/pcie-stm32.c | 402 ++++++++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-stm32.h |  15 +
>  4 files changed, 430 insertions(+)
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
> index 000000000000..fa787406c0e4
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-stm32.c
> @@ -0,0 +1,402 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * STMicroelectronics STM32MP25 PCIe root complex driver.
> + *
> + * Copyright (C) 2024 STMicroelectronics
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
> +	struct dw_pcie *pci;
> +	struct regmap *regmap;
> +	struct reset_control *rst;
> +	struct phy *phy;
> +	struct clk *clk;
> +	struct gpio_desc *perst_gpio;
> +	struct gpio_desc *wake_gpio;
> +	unsigned int wake_irq;
> +	bool link_is_up;
> +};
> +
> +static int stm32_pcie_start_link(struct dw_pcie *pci)
> +{
> +	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
> +	u32 ret;
> +
> +	if (stm32_pcie->perst_gpio) {

gpiod_set_value() will bail out if 'perst_gpio' is NULL. So no need to add a
check.

> +		/* Make sure PERST# is asserted. */

Why?

> +		gpiod_set_value(stm32_pcie->perst_gpio, 1);
> +
> +		fsleep(PCIE_T_PERST_CLK_US);
> +		gpiod_set_value(stm32_pcie->perst_gpio, 0);

Why can't you deassert PERST# in stm32_add_pcie_port()?

> +	}
> +
> +	ret = regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
> +				 STM32MP25_PCIECR_LTSSM_EN,
> +				 STM32MP25_PCIECR_LTSSM_EN);
> +
> +	if (stm32_pcie->perst_gpio)

It doesn't hurt to call msleep() always.

> +		msleep(PCIE_T_RRS_READY_MS);
> +
> +	return ret;
> +}
> +
> +static void stm32_pcie_stop_link(struct dw_pcie *pci)
> +{
> +	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
> +
> +	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
> +			   STM32MP25_PCIECR_LTSSM_EN, 0);
> +
> +	/* Assert PERST# */
> +	if (stm32_pcie->perst_gpio)
> +		gpiod_set_value(stm32_pcie->perst_gpio, 1);

I don't like tying PERST# handling with start/stop link. PERST# should be
handled based on the power/clock state.

> +}
> +
> +static int stm32_pcie_suspend(struct device *dev)
> +{
> +	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
> +
> +	if (device_may_wakeup(dev) || device_wakeup_path(dev))
> +		enable_irq_wake(stm32_pcie->wake_irq);
> +
> +	return 0;
> +}
> +
> +static int stm32_pcie_resume(struct device *dev)
> +{
> +	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
> +
> +	if (device_may_wakeup(dev) || device_wakeup_path(dev))
> +		disable_irq_wake(stm32_pcie->wake_irq);
> +
> +	return 0;
> +}
> +
> +static int stm32_pcie_suspend_noirq(struct device *dev)
> +{
> +	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
> +
> +	stm32_pcie->link_is_up = dw_pcie_link_up(stm32_pcie->pci);
> +
> +	stm32_pcie_stop_link(stm32_pcie->pci);

I don't understand how endpoint can wakeup the host if PERST# gets asserted.

> +	clk_disable_unprepare(stm32_pcie->clk);
> +
> +	if (!device_may_wakeup(dev) && !device_wakeup_path(dev))
> +		phy_exit(stm32_pcie->phy);
> +
> +	return pinctrl_pm_select_sleep_state(dev);
> +}
> +
> +static int stm32_pcie_resume_noirq(struct device *dev)
> +{
> +	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
> +	struct dw_pcie *pci = stm32_pcie->pci;
> +	struct dw_pcie_rp *pp = &pci->pp;
> +	int ret;
> +
> +	/* init_state must be called first to force clk_req# gpio when no

CLKREQ#

Why RC should control CLKREQ#?

Also please use preferred style for multi-line comments:

	/*
	 * ...
	 */

> +	 * device is plugged.
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
> +	if (!device_may_wakeup(dev) && !device_wakeup_path(dev)) {
> +		ret = phy_init(stm32_pcie->phy);
> +		if (ret) {
> +			pinctrl_pm_select_default_state(dev);
> +			return ret;
> +		}
> +	}
> +
> +	ret = clk_prepare_enable(stm32_pcie->clk);
> +	if (ret)
> +		goto clk_err;

Please name the goto labels of their purpose. Like err_phy_exit.

> +
> +	ret = dw_pcie_setup_rc(pp);
> +	if (ret)
> +		goto pcie_err;

This should be, 'err_disable_clk'.

> +
> +	if (stm32_pcie->link_is_up) {

Why do you need this check? You cannot start the link in the absence of an
endpoint?

> +		ret = stm32_pcie_start_link(stm32_pcie->pci);
> +		if (ret)
> +			goto pcie_err;
> +
> +		/* Ignore errors, the link may come up later */
> +		dw_pcie_wait_for_link(stm32_pcie->pci);
> +	}
> +
> +	pinctrl_pm_select_default_state(dev);
> +
> +	return 0;
> +
> +pcie_err:
> +	dw_pcie_host_deinit(pp);
> +	clk_disable_unprepare(stm32_pcie->clk);
> +clk_err:
> +	phy_exit(stm32_pcie->phy);
> +	pinctrl_pm_select_default_state(dev);
> +
> +	return ret;
> +}
> +
> +static const struct dev_pm_ops stm32_pcie_pm_ops = {
> +	NOIRQ_SYSTEM_SLEEP_PM_OPS(stm32_pcie_suspend_noirq,
> +				  stm32_pcie_resume_noirq)

Can you make use of dw_pcie_{suspend/resume}_noirq() APIs?

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

[...]

> +	if (device_property_read_bool(dev, "wakeup-source")) {
> +		stm32_pcie->wake_gpio = devm_gpiod_get_optional(dev, "wake",
> +								GPIOD_IN);
> +		if (IS_ERR(stm32_pcie->wake_gpio))
> +			return dev_err_probe(dev, PTR_ERR(stm32_pcie->wake_gpio),
> +					     "Failed to get wake GPIO\n");
> +	}
> +
> +	if (stm32_pcie->wake_gpio) {
> +		stm32_pcie->wake_irq = gpiod_to_irq(stm32_pcie->wake_gpio);
> +
> +		ret = devm_request_threaded_irq(&pdev->dev,
> +						stm32_pcie->wake_irq, NULL,
> +						stm32_pcie_wake_irq_handler,
> +						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +						"wake_irq", stm32_pcie);
> +
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to request WAKE IRQ: %d\n", ret);
> +	}

Can we move WAKE# gpio handling to DWC core? There is nothing STM32 specific
here.

> +
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to enable runtime PM %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to get runtime PM %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = stm32_add_pcie_port(stm32_pcie, pdev);
> +	if (ret)  {
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
> +	struct dw_pcie_rp *pp = &stm32_pcie->pci->pp;
> +
> +	if (stm32_pcie->wake_gpio)
> +		device_init_wakeup(&pdev->dev, false);
> +
> +	dw_pcie_host_deinit(pp);
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
> +		.pm		= &stm32_pcie_pm_ops,

Just use a single space instead of tab.

Could you also set PROBE_PREFER_ASYNCHRONOUS to allow async probing of
controller drivers?

> +	},
> +};
> +
> +static bool is_stm32_pcie_driver(struct device *dev)
> +{
> +	/* PCI bridge */
> +	dev = get_device(dev);
> +
> +	/* Platform driver */
> +	dev = get_device(dev->parent);
> +
> +	return (dev->driver == &stm32_pcie_driver.driver);
> +}
> +
> +/*
> + * DMA masters can only access the first 4GB of memory space,
> + * so we setup the bus DMA limit accordingly.
> + */
> +static int stm32_dma_limit(struct pci_dev *pdev, void *data)
> +{
> +	dev_dbg(&pdev->dev, "disabling DMA DAC for device");
> +
> +	pdev->dev.bus_dma_limit = DMA_BIT_MASK(32);
> +
> +	return 0;
> +}
> +
> +static void quirk_stm32_dma_mask(struct pci_dev *pci)
> +{
> +	struct pci_dev *root_port;
> +
> +	root_port = pcie_find_root_port(pci);
> +
> +	if (root_port && is_stm32_pcie_driver(root_port->dev.parent))
> +		pci_walk_bus(pci->bus, stm32_dma_limit, NULL);
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SYNOPSYS, 0x0550, quirk_stm32_dma_mask);

This is not the correct way of using DMA masks as Bjorn noted.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

