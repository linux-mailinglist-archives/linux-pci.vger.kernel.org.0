Return-Path: <linux-pci+bounces-33575-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64248B1DCE6
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 20:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3B81784D5
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 18:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C9C224B0D;
	Thu,  7 Aug 2025 18:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQZDK+9q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE641F8AC5;
	Thu,  7 Aug 2025 18:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754590194; cv=none; b=IXRTDV+3iFUCNLuEFm/HhtbscQdd7RZerrPZcJEQ0f1+os2CPYIAA4Mmvmx7yWwjesi3iyl+UiZ7Avg5rBXu8N5uuuyy1xp13VOX5CqGQq09dBZGxgQma/1gvuRiGlM3zMkxEfZV1jvXaDNEwkg3r3A1sbIUJ21qj46tUMwhCDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754590194; c=relaxed/simple;
	bh=dUzMOIBY9O7Bz5ml1R7Bd5C/W0k9vTbLBoP+Hcda9fw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IEjrmkq0z7sE1ytQtYiQSDSfjnTKgg+928X3LA2FtHK9xUL835YnYrVEPdasjRWn6iIb+FlQQKr9IK00TbSEJ5n6T8DM7pBccnvGciSkdHZeD0wHcIXp3aGwwh/zX5d+TWHPyw3rixT7Wc5ZdIpySr2CJJApMT1nw9CSPr+0YkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQZDK+9q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C380C4CEEB;
	Thu,  7 Aug 2025 18:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754590193;
	bh=dUzMOIBY9O7Bz5ml1R7Bd5C/W0k9vTbLBoP+Hcda9fw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=AQZDK+9qa9crE1AlMYL9xuM1Ma9M1NJ9PyYiN+urb9eDhs9N3ETIagtJkuCFSqf3L
	 9NsYZGiRSm9m0SJmdvL99oYu4BgWo5xp80YW+st7Ah2KDG1lgUcosEh2FO4s6C27IB
	 oA9Dk+QRxhdc4nqbuqgIwcYJXevWBEvpYvRLYruuFg95ccHDKYQvHy9PCehIvaJFz0
	 TCKW0k6t+QHW1FflI9vWeD+LyB6mVhc5OM/jNQBhd+7no16fP4Jpc3EJyHQTbXCdY6
	 tOJcg114W0W8fEzWp1Ysz3yqlZ5EJmDU9c8v6FZkdTVOQhdi5Yw5BYEbtWJ20kGNgl
	 Zk7obcqlL8lRg==
Date: Thu, 7 Aug 2025 13:09:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, p.zabel@pengutronix.de,
	johan+linaro@kernel.org, cassel@kernel.org, shradha.t@samsung.com,
	thippeswamy.havalige@amd.com, quic_schintav@quicinc.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 2/9] PCI: stm32: Add PCIe host support for STM32MP25
Message-ID: <20250807180951.GA56737@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610090714.3321129-3-christian.bruel@foss.st.com>

[+to Linus for pinctrl usage question below]

On Tue, Jun 10, 2025 at 11:07:07AM +0200, Christian Bruel wrote:
> Add driver for the STM32MP25 SoC PCIe Gen1 2.5 GT/s and Gen2 5GT/s
> controller based on the DesignWare PCIe core.
> 
> Supports MSI via GICv2m, Single Virtual Channel, Single Function
> 
> Supports WAKE# GPIO.
> 
> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> ---
>  drivers/pci/controller/dwc/Kconfig      |  12 +
>  drivers/pci/controller/dwc/Makefile     |   1 +
>  drivers/pci/controller/dwc/pcie-stm32.c | 368 ++++++++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-stm32.h |  15 +
>  4 files changed, 396 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-stm32.c
>  create mode 100644 drivers/pci/controller/dwc/pcie-stm32.h
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index d9f0386396ed..387151f25f5f 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -410,6 +410,18 @@ config PCIE_SPEAR13XX
>  	help
>  	  Say Y here if you want PCIe support on SPEAr13XX SoCs.
>  
> +config PCIE_STM32_HOST
> +	tristate "STMicroelectronics STM32MP25 PCIe Controller (host mode)"
> +	depends on ARCH_STM32 || COMPILE_TEST
> +	depends on PCI_MSI
> +	select PCIE_DW_HOST
> +	help
> +	  Enables Root Complex (RC) support for the DesignWare core based PCIe
> +	  controller found in STM32MP25 SoC.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called pcie-stm32.
> +
>  config PCI_DRA7XX
>  	tristate
>  
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index 908cb7f345db..9d3b43504725 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -30,6 +30,7 @@ obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
>  obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
>  obj-$(CONFIG_PCIE_VISCONTI_HOST) += pcie-visconti.o
>  obj-$(CONFIG_PCIE_RCAR_GEN4) += pcie-rcar-gen4.o
> +obj-$(CONFIG_PCIE_STM32_HOST) += pcie-stm32.o
>  
>  # The following drivers are for devices that use the generic ACPI
>  # pci_root.c driver but don't support standard ECAM config access.
> diff --git a/drivers/pci/controller/dwc/pcie-stm32.c b/drivers/pci/controller/dwc/pcie-stm32.c
> new file mode 100644
> index 000000000000..6bf1b63f88c6
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-stm32.c
> @@ -0,0 +1,368 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * STMicroelectronics STM32MP25 PCIe root complex driver.
> + *
> + * Copyright (C) 2025 STMicroelectronics
> + * Author: Christian Bruel <christian.bruel@foss.st.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_platform.h>
> +#include <linux/phy/phy.h>
> +#include <linux/pinctrl/devinfo.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pm_wakeirq.h>
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
> +};
> +
> +static void stm32_pcie_deassert_perst(struct stm32_pcie *stm32_pcie)
> +{
> +	/* Delay PERST# de-assertion until the power stabilizes */
> +	msleep(PCIE_T_PVPERL_MS);
> +
> +	gpiod_set_value(stm32_pcie->perst_gpio, 0);
> +
> +	/* Wait for the REFCLK to stabilize */
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
> +static int stm32_pcie_suspend_noirq(struct device *dev)
> +{
> +	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = dw_pcie_suspend_noirq(&stm32_pcie->pci);
> +	if (ret)
> +		return ret;
> +
> +	stm32_pcie_assert_perst(stm32_pcie);
> +
> +	clk_disable_unprepare(stm32_pcie->clk);
> +
> +	if (!device_wakeup_path(dev))
> +		phy_exit(stm32_pcie->phy);
> +
> +	return pinctrl_pm_select_sleep_state(dev);

Isn't there some setup required before we can use
pinctrl_select_state(), pinctrl_pm_select_sleep_state(),
pinctrl_pm_select_default_state(), etc?

I expected something like devm_pinctrl_get() in the .probe() path, but
I don't see anything.  I don't know how pinctrl works, but I don't see
how dev->pins gets set up.

> +}
> +
> +static int stm32_pcie_resume_noirq(struct device *dev)
> +{
> +	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
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
> +	if (!device_wakeup_path(dev)) {
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
> +	ret = dw_pcie_resume_noirq(&stm32_pcie->pci);
> +	if (ret)
> +		goto err_disable_clk;
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
> +static int stm32_add_pcie_port(struct stm32_pcie *stm32_pcie)
> +{
> +	struct device *dev = stm32_pcie->pci.dev;
> +	unsigned int wake_irq;
> +	int ret;
> +
> +	/* Start to enable resources with PERST# asserted */
> +
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
> +	stm32_pcie_deassert_perst(stm32_pcie);
> +
> +	if (stm32_pcie->wake_gpio) {
> +		wake_irq = gpiod_to_irq(stm32_pcie->wake_gpio);
> +		ret = dev_pm_set_dedicated_wake_irq(dev, wake_irq);
> +		if (ret) {
> +			dev_err(dev, "Failed to enable wakeup irq %d\n", ret);
> +			goto err_assert_perst;
> +		}
> +		irq_set_irq_type(wake_irq, IRQ_TYPE_EDGE_FALLING);
> +	}
> +
> +	return 0;
> +
> +err_assert_perst:
> +	stm32_pcie_assert_perst(stm32_pcie);
> +
> +err_phy_exit:
> +	phy_exit(stm32_pcie->phy);
> +
> +	return ret;
> +}
> +
> +static void stm32_remove_pcie_port(struct stm32_pcie *stm32_pcie)
> +{
> +	dev_pm_clear_wake_irq(stm32_pcie->pci.dev);
> +
> +	stm32_pcie_assert_perst(stm32_pcie);
> +
> +	phy_exit(stm32_pcie->phy);
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
> +	if (IS_ERR(stm32_pcie->phy)) {
> +		of_node_put(root_port);
> +		return dev_err_probe(dev, PTR_ERR(stm32_pcie->phy),
> +				     "Failed to get pcie-phy\n");
> +	}
> +
> +	stm32_pcie->perst_gpio = devm_fwnode_gpiod_get(dev, of_fwnode_handle(root_port),
> +						       "reset", GPIOD_OUT_HIGH, NULL);
> +	if (IS_ERR(stm32_pcie->perst_gpio)) {
> +		if (PTR_ERR(stm32_pcie->perst_gpio) != -ENOENT) {
> +			of_node_put(root_port);
> +			return dev_err_probe(dev, PTR_ERR(stm32_pcie->perst_gpio),
> +					     "Failed to get reset GPIO\n");
> +		}
> +		stm32_pcie->perst_gpio = NULL;
> +	}
> +
> +	stm32_pcie->wake_gpio = devm_fwnode_gpiod_get(dev, of_fwnode_handle(root_port),
> +						      "wake", GPIOD_IN, NULL);
> +
> +	if (IS_ERR(stm32_pcie->wake_gpio)) {
> +		if (PTR_ERR(stm32_pcie->wake_gpio) != -ENOENT) {
> +			of_node_put(root_port);
> +			return dev_err_probe(dev, PTR_ERR(stm32_pcie->wake_gpio),
> +					     "Failed to get wake GPIO\n");
> +		}
> +		stm32_pcie->wake_gpio = NULL;
> +	}
> +
> +	of_node_put(root_port);
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
> +	stm32_pcie->pci.pp.ops = &stm32_pcie_host_ops;
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
> +	ret = stm32_add_pcie_port(stm32_pcie);
> +	if (ret)
> +		return ret;
> +
> +	reset_control_assert(stm32_pcie->rst);
> +	reset_control_deassert(stm32_pcie->rst);
> +
> +	ret = clk_prepare_enable(stm32_pcie->clk);
> +	if (ret) {
> +		dev_err(dev, "Core clock enable failed %d\n", ret);
> +		goto err_remove_port;
> +	}
> +
> +	ret = pm_runtime_set_active(dev);
> +	if (ret < 0) {
> +		clk_disable_unprepare(stm32_pcie->clk);
> +		stm32_remove_pcie_port(stm32_pcie);
> +		return dev_err_probe(dev, ret, "Failed to activate runtime PM\n");
> +	}
> +
> +	pm_runtime_no_callbacks(dev);
> +
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret < 0) {
> +		clk_disable_unprepare(stm32_pcie->clk);
> +		stm32_remove_pcie_port(stm32_pcie);
> +		return dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
> +	}
> +
> +	ret = dw_pcie_host_init(&stm32_pcie->pci.pp);
> +	if (ret)
> +		goto err_disable_clk;
> +
> +	if (stm32_pcie->wake_gpio)
> +		device_init_wakeup(dev, true);
> +
> +	return 0;
> +
> +err_disable_clk:
> +	clk_disable_unprepare(stm32_pcie->clk);
> +
> +err_remove_port:
> +	stm32_remove_pcie_port(stm32_pcie);
> +
> +	return ret;
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
> +	clk_disable_unprepare(stm32_pcie->clk);
> +
> +	stm32_remove_pcie_port(stm32_pcie);
> +
> +	pm_runtime_put_noidle(&pdev->dev);
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
> index 000000000000..387112c4e42c
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-stm32.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * ST PCIe driver definitions for STM32-MP25 SoC
> + *
> + * Copyright (C) 2025 STMicroelectronics - All Rights Reserved
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
> -- 
> 2.34.1
> 

