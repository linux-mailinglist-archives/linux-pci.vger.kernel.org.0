Return-Path: <linux-pci+bounces-20704-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD78A2771F
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 17:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2491C1653E8
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 16:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E405E2153D0;
	Tue,  4 Feb 2025 16:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Ndf4c3Yw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC56215170;
	Tue,  4 Feb 2025 16:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738686458; cv=none; b=V/49woLKd7JfoXNAoVKJQqwmZsghI3B8kPHAOnhEagE89/eJWSWNlNj0ogyyymsWFBVbNNAckPcIpnV6GVBNH2rHgl05vh7++bIvEXmXn21Qzb8g10rUDumDqO62nGpBMLEDKVQHzmW+8Ubq/2bsE2vIlPxoPL7H83i5qkA0kOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738686458; c=relaxed/simple;
	bh=18AKuIhRKg93IcWY1shmZslYEXBdujMopqiE0MjpfxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nBirlue7FWAvuCWzaUHuo1OvFBlzZ6ltlQBIvH2pVb563+mVL4i4r9+aZ4XLVeA4wkBL764hODdAPJiMucQ2PVmFLG85UHpDwnzNfwbFHkvqNn5TQSLoGwbx0NnRT2E5mHlvthaO3srUWVju3uchmzbbftwsvBRiccoQlnIfYRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Ndf4c3Yw; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514EooFS010239;
	Tue, 4 Feb 2025 17:27:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	vBqJU0VJ9b0hw2k+f88TiFDvfm37U6arpWYPUOrPFDE=; b=Ndf4c3YwOMwhkdwh
	bRUUWteqdnaeZdThT9zTjz/W7dDDraA6YpoTN2KIJJhSQjvsV8YZHM8tgbzdHX98
	1o4xxNfl4FzeCI32ZE5St7kMrwQoUzhVf0uluUzI63pwgZ1jLG/RB7S+CCbNRXHN
	mi2BG1/myFXJmtMVwEOIZsZI1q7hVS2FD/3axmOOmsPglh/1MgwQGgiw9xlNPzRk
	jRIKxl3dKEpVFaf3aeuRMvSaHAh7uOpkl3dxhz6TL5gc+ksfPqCGymsGyQ3PHT1c
	NLqJawOF/I1F0kWqE0M29x76NxhcUX6m8Z7GdrfX5mmlhSQK7a+AzHeNR7N19gRY
	vJylDg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44kmjw8hmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 17:27:03 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6A99F400DE;
	Tue,  4 Feb 2025 17:25:33 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EFCF12ABD4D;
	Tue,  4 Feb 2025 17:23:07 +0100 (CET)
Received: from [10.129.178.212] (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Feb
 2025 17:23:07 +0100
Message-ID: <f4be9537-5631-4d11-9237-0cc421891669@foss.st.com>
Date: Tue, 4 Feb 2025 17:23:05 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/10] PCI: stm32: Add PCIe host support for STM32MP25
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <jingoohan1@gmail.com>, <p.zabel@pengutronix.de>,
        <johan+linaro@kernel.org>, <quic_schintav@quicinc.com>,
        <cassel@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <fabrice.gasnier@foss.st.com>
References: <20250128120745.334377-1-christian.bruel@foss.st.com>
 <20250128120745.334377-4-christian.bruel@foss.st.com>
 <20250202130657.zcnvnnwclxup6y7i@thinkpad>
From: Christian Bruel <christian.bruel@foss.st.com>
Content-Language: en-US
In-Reply-To: <20250202130657.zcnvnnwclxup6y7i@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_08,2025-02-04_01,2024-11-22_01



On 2/2/25 14:06, Manivannan Sadhasivam wrote:
> On Tue, Jan 28, 2025 at 01:07:38PM +0100, Christian Bruel wrote:
>> Add driver for the STM32MP25 SoC PCIe Gen1 2.5 GT/s and Gen2 5GT/s
>> controller based on the DesignWare PCIe core.
>>
>> Supports MSI via GICv2m, Single Virtual Channel, Single Function
>>
>> Supports wakeup-source from gpio wake_irq with dw_pcie_wake_irq_handler
>> for host wakeup.
>>
> 
> "Supports WAKE# GPIO" is what should be mentioned above.

OK. dropping wakeup-source property as well

> 
>> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
>> ---
>>   drivers/pci/controller/dwc/Kconfig      |  12 +
>>   drivers/pci/controller/dwc/Makefile     |   1 +
>>   drivers/pci/controller/dwc/pcie-stm32.c | 372 ++++++++++++++++++++++++
>>   drivers/pci/controller/dwc/pcie-stm32.h |  15 +
>>   4 files changed, 400 insertions(+)
>>   create mode 100644 drivers/pci/controller/dwc/pcie-stm32.c
>>   create mode 100644 drivers/pci/controller/dwc/pcie-stm32.h
>>
>> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
>> index b6d6778b0698..0c18879b604c 100644
>> --- a/drivers/pci/controller/dwc/Kconfig
>> +++ b/drivers/pci/controller/dwc/Kconfig
>> @@ -389,6 +389,18 @@ config PCIE_SPEAR13XX
>>   	help
>>   	  Say Y here if you want PCIe support on SPEAr13XX SoCs.
>>   
>> +config PCIE_STM32
>> +	tristate "STMicroelectronics STM32MP25 PCIe Controller (host mode)"
>> +	depends on ARCH_STM32 || COMPILE_TEST
>> +	depends on PCI_MSI
>> +	select PCIE_DW_HOST
>> +	help
>> +	  Enables support for the DesignWare core based PCIe host controller
>> +	  found in STM32MP25 SoC.
>> +
>> +	  This driver can also be built as a module. If so, the module
>> +	  will be called pcie-stm32.
>> +
>>   config PCI_DRA7XX
>>   	tristate
>>   
>> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
>> index a8308d9ea986..576d99cb3bc5 100644
>> --- a/drivers/pci/controller/dwc/Makefile
>> +++ b/drivers/pci/controller/dwc/Makefile
>> @@ -28,6 +28,7 @@ obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
>>   obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
>>   obj-$(CONFIG_PCIE_VISCONTI_HOST) += pcie-visconti.o
>>   obj-$(CONFIG_PCIE_RCAR_GEN4) += pcie-rcar-gen4.o
>> +obj-$(CONFIG_PCIE_STM32) += pcie-stm32.o
>>   
>>   # The following drivers are for devices that use the generic ACPI
>>   # pci_root.c driver but don't support standard ECAM config access.
>> diff --git a/drivers/pci/controller/dwc/pcie-stm32.c b/drivers/pci/controller/dwc/pcie-stm32.c
>> new file mode 100644
>> index 000000000000..d5e473bb390f
>> --- /dev/null
>> +++ b/drivers/pci/controller/dwc/pcie-stm32.c
>> @@ -0,0 +1,372 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * STMicroelectronics STM32MP25 PCIe root complex driver.
>> + *
>> + * Copyright (C) 2024 STMicroelectronics
> 
> 2025?
> 
>> + * Author: Christian Bruel <christian.bruel@foss.st.com>
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/phy/phy.h>
>> +#include <linux/pinctrl/devinfo.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/reset.h>
>> +#include "pcie-designware.h"
>> +#include "pcie-stm32.h"
>> +#include "../../pci.h"
>> +
>> +struct stm32_pcie {
>> +	struct dw_pcie pci;
>> +	struct regmap *regmap;
>> +	struct reset_control *rst;
>> +	struct phy *phy;
>> +	struct clk *clk;
>> +	struct gpio_desc *perst_gpio;
>> +	struct gpio_desc *wake_gpio;
>> +	unsigned int wake_irq;
>> +};
>> +
>> +static void stm32_pcie_deassert_perst(struct stm32_pcie *stm32_pcie)
>> +{
>> +	gpiod_set_value(stm32_pcie->perst_gpio, 0);
>> +
>> +	if (stm32_pcie->perst_gpio)
>> +		msleep(PCIE_T_RRS_READY_MS);
>> +}
>> +
>> +static void stm32_pcie_assert_perst(struct stm32_pcie *stm32_pcie)
>> +{
>> +	gpiod_set_value(stm32_pcie->perst_gpio, 1);
>> +}
>> +
>> +static int stm32_pcie_start_link(struct dw_pcie *pci)
>> +{
>> +	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
>> +
>> +	return regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
>> +				  STM32MP25_PCIECR_LTSSM_EN,
>> +				  STM32MP25_PCIECR_LTSSM_EN);
>> +}
>> +
>> +static void stm32_pcie_stop_link(struct dw_pcie *pci)
>> +{
>> +	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
>> +
>> +	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
>> +			   STM32MP25_PCIECR_LTSSM_EN, 0);
>> +}
>> +
>> +static int stm32_pcie_suspend(struct device *dev)
>> +{
>> +	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
>> +
>> +	if (device_may_wakeup(dev))
>> +		enable_irq_wake(stm32_pcie->wake_irq);
>> +
>> +	return 0;
>> +}
>> +
>> +static int stm32_pcie_resume(struct device *dev)
>> +{
>> +	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
>> +
>> +	if (device_may_wakeup(dev))
>> +		disable_irq_wake(stm32_pcie->wake_irq);
>> +
>> +	return 0;
>> +}
>> +
>> +static int stm32_pcie_suspend_noirq(struct device *dev)
>> +{
> 
> Can you consider making use of dw_pcie_{suspend/resume}_noirq()?

I considered this, but dw_pcie_suspend_noirq needs to be tweaked as it 
checks both the pme_turn_off hook and whether we are entering into L2, 
which we don't support.

For the former, I can check the PCI_EXP_DEVSTAT_AUXPD capability before 
polling for L2 LTSSM. It looks like only the Layerscape platform uses 
this. I will need a Tested-by for this new dw_pcie_suspend_noirq.

Do you advise keeping stm32_pcie_suspend_noirq or modifying 
dw_pcie_suspend_noirq to this effect?

Thanks,

> 
>> +	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
>> +
>> +	stm32_pcie_stop_link(&stm32_pcie->pci);
>> +
>> +	stm32_pcie_assert_perst(stm32_pcie);
>> +
>> +	clk_disable_unprepare(stm32_pcie->clk);
>> +
>> +	if (!device_may_wakeup(dev))
>> +		phy_exit(stm32_pcie->phy);
>> +
>> +	return pinctrl_pm_select_sleep_state(dev);
>> +}
>> +
>> +static int stm32_pcie_resume_noirq(struct device *dev)
>> +{
>> +	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
>> +	struct dw_pcie_rp *pp = &stm32_pcie->pci.pp;
>> +	int ret;
>> +
>> +	/*
>> +	 * The core clock is gated with CLKREQ# from the COMBOPHY REFCLK,
>> +	 * thus if no device is present, must force it low with an init pinmux
>> +	 * to be able to access the DBI registers.
>> +	 */
>> +	if (!IS_ERR(dev->pins->init_state))
>> +		ret = pinctrl_select_state(dev->pins->p, dev->pins->init_state);
>> +	else
>> +		ret = pinctrl_pm_select_default_state(dev);
>> +
>> +	if (ret) {
>> +		dev_err(dev, "Failed to activate pinctrl pm state: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	if (!device_may_wakeup(dev)) {
>> +		ret = phy_init(stm32_pcie->phy);
>> +		if (ret) {
>> +			pinctrl_pm_select_default_state(dev);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	ret = clk_prepare_enable(stm32_pcie->clk);
>> +	if (ret)
>> +		goto err_phy_exit;
>> +
>> +	stm32_pcie_deassert_perst(stm32_pcie);
>> +
>> +	ret = dw_pcie_setup_rc(pp);
>> +	if (ret)
>> +		goto err_disable_clk;
>> +
>> +	ret = stm32_pcie_start_link(&stm32_pcie->pci);
>> +	if (ret)
>> +		goto err_disable_clk;
>> +
>> +	/* Ignore errors, the link may come up later */
>> +	dw_pcie_wait_for_link(&stm32_pcie->pci);
> 
> These can be dropped when using dw_pcie_resume_noirq().

OK for dw_pcie_resume_noirq if we can keep it balanced with 
dw_pcie_suspend_noirq

> 
>> +
>> +	pinctrl_pm_select_default_state(dev);
>> +
>> +	return 0;
>> +
>> +err_disable_clk:
>> +	stm32_pcie_assert_perst(stm32_pcie);
>> +	clk_disable_unprepare(stm32_pcie->clk);
>> +
>> +err_phy_exit:
>> +	phy_exit(stm32_pcie->phy);
>> +	pinctrl_pm_select_default_state(dev);
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct dev_pm_ops stm32_pcie_pm_ops = {
>> +	NOIRQ_SYSTEM_SLEEP_PM_OPS(stm32_pcie_suspend_noirq,
>> +				  stm32_pcie_resume_noirq)
>> +	SYSTEM_SLEEP_PM_OPS(stm32_pcie_suspend, stm32_pcie_resume)
>> +};
>> +
>> +static const struct dw_pcie_host_ops stm32_pcie_host_ops = {
>> +};
>> +
>> +static const struct dw_pcie_ops dw_pcie_ops = {
>> +	.start_link = stm32_pcie_start_link,
>> +	.stop_link = stm32_pcie_stop_link
>> +};
>> +
>> +static int stm32_add_pcie_port(struct stm32_pcie *stm32_pcie,
>> +			       struct platform_device *pdev)
>> +{
>> +	struct device *dev = stm32_pcie->pci.dev;
>> +	struct dw_pcie_rp *pp = &stm32_pcie->pci.pp;
>> +	int ret;
>> +
> 
> You need to assert PERST# before configuring the resources.

It is already initialized to GPIOD_OUT_HIGH in gpiod_get, I can have an 
explicit stm32_pcie_assert_perst but is it necessary ?

> 
>> +	ret = phy_set_mode(stm32_pcie->phy, PHY_MODE_PCIE);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = phy_init(stm32_pcie->phy);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
>> +				 STM32MP25_PCIECR_TYPE_MASK,
>> +				 STM32MP25_PCIECR_RC);
>> +	if (ret)
>> +		goto err_phy_exit;
>> +
>> +	reset_control_assert(stm32_pcie->rst);
>> +	reset_control_deassert(stm32_pcie->rst);
>> +
>> +	ret = clk_prepare_enable(stm32_pcie->clk);
>> +	if (ret) {
>> +		dev_err(dev, "Core clock enable failed %d\n", ret);
>> +		goto err_phy_exit;
>> +	}
>> +
>> +	stm32_pcie_deassert_perst(stm32_pcie);
>> +
>> +	pp->ops = &stm32_pcie_host_ops;
>> +	ret = dw_pcie_host_init(pp);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to initialize host: %d\n", ret);
>> +		goto err_disable_clk;
>> +	}
> 
> Technically, dw_pcie_host_init() is not related to root port. So please move it
> to probe() instead.

OK will move, thanks

> 
>> +
>> +	return 0;
>> +
>> +err_disable_clk:
>> +	clk_disable_unprepare(stm32_pcie->clk);
>> +	stm32_pcie_assert_perst(stm32_pcie);
>> +
>> +err_phy_exit:
>> +	phy_exit(stm32_pcie->phy);
>> +
>> +	return ret;
>> +}
>> +
>> +static int stm32_pcie_parse_port(struct stm32_pcie *stm32_pcie)
>> +{
>> +	struct device *dev = stm32_pcie->pci.dev;
>> +	struct device_node *root_port;
>> +
>> +	root_port = of_get_next_available_child(dev->of_node, NULL);
>> +
>> +	stm32_pcie->phy = devm_of_phy_get(dev, root_port, NULL);
>> +	if (IS_ERR(stm32_pcie->phy))
>> +		return dev_err_probe(dev, PTR_ERR(stm32_pcie->phy),
>> +				     "Failed to get pcie-phy\n");
> 
> OF refcount not decremented in both the error and success case.

I don't understand your point, isn't devm_of_phy_get managed to 
decrement the phy resources ?

> 
>> +
>> +	stm32_pcie->perst_gpio = devm_fwnode_gpiod_get(dev, of_fwnode_handle(root_port),
>> +						       "reset", GPIOD_OUT_HIGH, NULL);
>> +	if (IS_ERR(stm32_pcie->perst_gpio)) {
>> +		if (PTR_ERR(stm32_pcie->perst_gpio) != -ENOENT)
>> +			return dev_err_probe(dev, PTR_ERR(stm32_pcie->perst_gpio),
>> +					     "Failed to get reset GPIO\n");
>> +		stm32_pcie->perst_gpio = NULL;
>> +	}
>> +
>> +	if (device_property_read_bool(dev, "wakeup-source")) {
> 
> As per the current logic, 'wakeup-source' is applicable even without WAKE# GPIO,
> which doesn't make sense.

Agree, wakeup-source is not needed

> 
>> +		stm32_pcie->wake_gpio = devm_fwnode_gpiod_get(dev, of_fwnode_handle(root_port),
>> +							      "wake", GPIOD_IN, NULL);
>> +
>> +		if (IS_ERR(stm32_pcie->wake_gpio)) {
>> +			if (PTR_ERR(stm32_pcie->wake_gpio) != -ENOENT)
>> +				return dev_err_probe(dev, PTR_ERR(stm32_pcie->wake_gpio),
>> +						     "Failed to get wake GPIO\n");
>> +			stm32_pcie->wake_gpio = NULL;
>> +		}
> 
> Hmm. I think we need to move WAKE# handling inside drivers/pci/pcie/portdrv.c
> since that is responsible for the root port. While other root port properties
> have some dependency with the RC (like PERST#, PHY etc...), WAKE# handling could
> be moved safel >
> And once done, it can benefit all platforms.

OK I'll check if there is a convenient way to do this through a 
port_service

> 
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int stm32_pcie_probe(struct platform_device *pdev)
>> +{
>> +	struct stm32_pcie *stm32_pcie;
>> +	struct device *dev = &pdev->dev;
>> +	int ret;
>> +
>> +	stm32_pcie = devm_kzalloc(dev, sizeof(*stm32_pcie), GFP_KERNEL);
>> +	if (!stm32_pcie)
>> +		return -ENOMEM;
>> +
>> +	stm32_pcie->pci.dev = dev;
>> +	stm32_pcie->pci.ops = &dw_pcie_ops;
>> +
>> +	stm32_pcie->regmap = syscon_regmap_lookup_by_compatible("st,stm32mp25-syscfg");
>> +	if (IS_ERR(stm32_pcie->regmap))
>> +		return dev_err_probe(dev, PTR_ERR(stm32_pcie->regmap),
>> +				     "No syscfg specified\n");
>> +
>> +	stm32_pcie->clk = devm_clk_get(dev, NULL);
>> +	if (IS_ERR(stm32_pcie->clk))
>> +		return dev_err_probe(dev, PTR_ERR(stm32_pcie->clk),
>> +				     "Failed to get PCIe clock source\n");
>> +
>> +	stm32_pcie->rst = devm_reset_control_get_exclusive(dev, NULL);
>> +	if (IS_ERR(stm32_pcie->rst))
>> +		return dev_err_probe(dev, PTR_ERR(stm32_pcie->rst),
>> +				     "Failed to get PCIe reset\n");
>> +
>> +	ret = stm32_pcie_parse_port(stm32_pcie);
>> +	if (ret)
>> +		return ret;
>> +
>> +	platform_set_drvdata(pdev, stm32_pcie);
>> +
>> +	if (stm32_pcie->wake_gpio) {
>> +		stm32_pcie->wake_irq = gpiod_to_irq(stm32_pcie->wake_gpio);
>> +
>> +		ret = devm_request_threaded_irq(&pdev->dev,
>> +						stm32_pcie->wake_irq, NULL,
>> +						dw_pcie_wake_irq_handler,
>> +						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>> +						"wake_irq", stm32_pcie->pci.dev);
>> +
>> +		if (ret)
>> +			return dev_err_probe(dev, ret, "Failed to request WAKE IRQ: %d\n", ret);
>> +	}
>> +
>> +	ret = devm_pm_runtime_enable(dev);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Failed to enable runtime PM %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = pm_runtime_resume_and_get(dev);
> 
> Why do you need to do PM resume here? Is there a parent that needs to be resumed
> now? I know that other controller drivers have this pattern, but most of them
> are just doing it wrong.

OK, so just pm_runtime_get_noresume() should be enough

> 
> Most likely you need pm_runtime_set_active() before devm_pm_runtime_enable().

OK

> 
>> +	if (ret < 0) {
>> +		dev_err(dev, "Failed to get runtime PM %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = stm32_add_pcie_port(stm32_pcie, pdev);
>> +	if (ret)  {
> 
> Nit: double space.
> 
>> +		pm_runtime_put_sync(&pdev->dev);
>> +		return ret;
>> +	}
>> +
>> +	if (stm32_pcie->wake_gpio)
>> +		device_set_wakeup_capable(dev, true);
>> +
>> +	return 0;
>> +}
>> +
>> +static void stm32_pcie_remove(struct platform_device *pdev)
>> +{
>> +	struct stm32_pcie *stm32_pcie = platform_get_drvdata(pdev);
>> +	struct dw_pcie_rp *pp = &stm32_pcie->pci.pp;
>> +
>> +	if (stm32_pcie->wake_gpio)
>> +		device_init_wakeup(&pdev->dev, false);
>> +
>> +	dw_pcie_host_deinit(pp);
>> +
>> +	stm32_pcie_assert_perst(stm32_pcie);
>> +
>> +	clk_disable_unprepare(stm32_pcie->clk);
>> +
>> +	phy_exit(stm32_pcie->phy);
>> +
>> +	pm_runtime_put_sync(&pdev->dev);
>> +}
>> +
>> +static const struct of_device_id stm32_pcie_of_match[] = {
>> +	{ .compatible = "st,stm32mp25-pcie-rc" },
>> +	{},
>> +};
>> +
>> +static struct platform_driver stm32_pcie_driver = {
>> +	.probe = stm32_pcie_probe,
>> +	.remove = stm32_pcie_remove,
>> +	.driver = {
>> +		.name = "stm32-pcie",
>> +		.of_match_table = stm32_pcie_of_match,
>> +		.pm = &stm32_pcie_pm_ops,
>> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>> +	},
>> +};
>> +
>> +module_platform_driver(stm32_pcie_driver);
>> +
>> +MODULE_AUTHOR("Christian Bruel <christian.bruel@foss.st.com>");
>> +MODULE_DESCRIPTION("STM32MP25 PCIe Controller driver");
>> +MODULE_LICENSE("GPL");
>> +MODULE_DEVICE_TABLE(of, stm32_pcie_of_match);
>> diff --git a/drivers/pci/controller/dwc/pcie-stm32.h b/drivers/pci/controller/dwc/pcie-stm32.h
>> new file mode 100644
>> index 000000000000..3efd00937d3d
>> --- /dev/null
>> +++ b/drivers/pci/controller/dwc/pcie-stm32.h
>> @@ -0,0 +1,15 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * ST PCIe driver definitions for STM32-MP25 SoC
>> + *
>> + * Copyright (C) 2024 STMicroelectronics - All Rights Reserved
>> + * Author: Christian Bruel <christian.bruel@foss.st.com>
>> + */
>> +
>> +#define to_stm32_pcie(x)	dev_get_drvdata((x)->dev)
>> +
>> +#define STM32MP25_PCIECR_TYPE_MASK	GENMASK(11, 8)
>> +#define STM32MP25_PCIECR_LTSSM_EN	BIT(2)
>> +#define STM32MP25_PCIECR_RC		BIT(10)
>> +
>> +#define SYSCFG_PCIECR			0x6000
> 
> You can just move these definitions inside the driver itself.
> 

Some definitions will be duplicated with the ep driver, but on the other 
side this file is very small... is it OK to duplicate definitions 
instead of having the bitfields together ?


> - Mani
> 

