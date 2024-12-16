Return-Path: <linux-pci+bounces-18492-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E38029F2C8D
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 10:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 770351884F10
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 09:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436A11CEEA0;
	Mon, 16 Dec 2024 09:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="L0Bkks35"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED39B1FF7C5;
	Mon, 16 Dec 2024 09:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734339841; cv=none; b=cPaFopK2q1olVQQD1oMIIIn1DNdxQ+KFx+P73f4arFQ74fTJ93IPg/uKVOUyW7gEkDjcbm+lG8DCKc4qS2+8LIrTYRguHCgx28Lz2a7q403H2dx2UEFBTAyAuR8Lew8xlOGzBp6OYikWcZDMSt4Sv2MAVd9TkaVwGslfc84ijHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734339841; c=relaxed/simple;
	bh=CljY2RwFknjTO+is6XZkZD2Yymz65xLDCzaPzsLtn+o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=RGkgQFNEd7vAZRpBH83LXw5kQQF+Mgfef1p5xggA2FLrNSUqr4zpHZLFGp68Mdjqm3LzkbbkwO2e7fjK3n80W1iRV/rfTICVBi0qtaVrY4bXqixaWF+h4MnsXNr+tLxn70tH/f5AQM69uUjmFqixbshSUYZzAagjc0KviGPx1UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=L0Bkks35; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG745De008787;
	Mon, 16 Dec 2024 10:03:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	qEiYvLzMgKQ0x0UiYk5dXUdjJMxAHCIuBnIQTXs7ixk=; b=L0Bkks35yTScHY35
	e7APZFOiRqTQOkfdu47wttEGeQzHNUmj3medmECIMfgrHt1nUJhXnqVtLjY45bVc
	sVBfC3Q0QC32qAquA1P8EhdE7eOQrb3wL4c2TjHzD6MzXEOAApopBROKju6fZu8r
	vblgZp3jfLR49hD2ofqsRJBbduh4lXzVyuZyN7JqUMchRzoVsQudclAJvJ2v7xgd
	CAq/emATuINpQ5+vw+WQHdWGMyddXrWqVvIm080sii8rKdVzSiphTs8MYryjCTvH
	+RuMEleH6VxiGnYfelepsHPa+wf0IJry1nl6ILKeKRLqRnydFJ3J933rxErqO0i1
	TapOgg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43jfg8rh4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 10:03:15 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6E64E40044;
	Mon, 16 Dec 2024 10:01:41 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 10BE7263542;
	Mon, 16 Dec 2024 10:00:36 +0100 (CET)
Received: from [10.129.178.212] (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 16 Dec
 2024 10:00:35 +0100
Message-ID: <ced7a55a-d968-497f-abc2-663855882a3f@foss.st.com>
Date: Mon, 16 Dec 2024 10:00:27 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christian Bruel <christian.bruel@foss.st.com>
Subject: Re: [PATCH v2 2/5] PCI: stm32: Add PCIe host support for STM32MP25
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <p.zabel@pengutronix.de>, <cassel@kernel.org>,
        <quic_schintav@quicinc.com>, <fabrice.gasnier@foss.st.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20241126155119.1574564-1-christian.bruel@foss.st.com>
 <20241126155119.1574564-3-christian.bruel@foss.st.com>
 <20241203145244.trgrobtfmumtiwuc@thinkpad>
Content-Language: en-US
In-Reply-To: <20241203145244.trgrobtfmumtiwuc@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hi Manivannan,

On 12/3/24 15:52, Manivannan Sadhasivam wrote:
> On Tue, Nov 26, 2024 at 04:51:16PM +0100, Christian Bruel wrote:
>> Add driver for the STM32MP25 SoC PCIe Gen2 controller based on the
>> DesignWare PCIe core.
>>
>> Supports MSI via GICv2m, Single Virtual Channel, Single Function
>>
>> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
>> ---
>>   drivers/pci/controller/dwc/Kconfig      |  12 +
>>   drivers/pci/controller/dwc/Makefile     |   1 +
>>   drivers/pci/controller/dwc/pcie-stm32.c | 402 ++++++++++++++++++++++++
>>   drivers/pci/controller/dwc/pcie-stm32.h |  15 +
>>   4 files changed, 430 insertions(+)
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
>> index 000000000000..fa787406c0e4
>> --- /dev/null
>> +++ b/drivers/pci/controller/dwc/pcie-stm32.c
>> @@ -0,0 +1,402 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * STMicroelectronics STM32MP25 PCIe root complex driver.
>> + *
>> + * Copyright (C) 2024 STMicroelectronics
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
>> +	struct dw_pcie *pci;
>> +	struct regmap *regmap;
>> +	struct reset_control *rst;
>> +	struct phy *phy;
>> +	struct clk *clk;
>> +	struct gpio_desc *perst_gpio;
>> +	struct gpio_desc *wake_gpio;
>> +	unsigned int wake_irq;
>> +	bool link_is_up;
>> +};
>> +
>> +static int stm32_pcie_start_link(struct dw_pcie *pci)
>> +{
>> +	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
>> +	u32 ret;
>> +
>> +	if (stm32_pcie->perst_gpio) {
> 
> gpiod_set_value() will bail out if 'perst_gpio' is NULL. So no need to add a
> check.

OK

> 
>> +		/* Make sure PERST# is asserted. */
> 
> Why?

Ack. We have GPIOD_OUT_HIGH already thanks devm_gpiod_get_optional, so 
PERST# is asserted already at probe


> 
>> +		gpiod_set_value(stm32_pcie->perst_gpio, 1);
>> +
>> +		fsleep(PCIE_T_PERST_CLK_US);
>> +		gpiod_set_value(stm32_pcie->perst_gpio, 0);
> 
> Why can't you deassert PERST# in stm32_add_pcie_port()?

Code reuse between probe and resume. (Need de-assert PERST# after the 
refclk is stable from both probe or resume_noirq paths).
Can move this from start_link to:
  - probe after the phy_init
  - and resume_no_irq after the phy_init
before dw_pcie_setup_rc

> 
>> +	}
>> +
>> +	ret = regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
>> +				 STM32MP25_PCIECR_LTSSM_EN,
>> +				 STM32MP25_PCIECR_LTSSM_EN);
>> +
>> +	if (stm32_pcie->perst_gpio)
> 
> It doesn't hurt to call msleep() always.

It is optional in the DT. Why wait if we don't have a reset signal ?

> 
>> +		msleep(PCIE_T_RRS_READY_MS);
>> +
>> +	return ret;
>> +}
>> +
>> +static void stm32_pcie_stop_link(struct dw_pcie *pci)
>> +{
>> +	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
>> +
>> +	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
>> +			   STM32MP25_PCIECR_LTSSM_EN, 0);
>> +
>> +	/* Assert PERST# */
>> +	if (stm32_pcie->perst_gpio)
>> +		gpiod_set_value(stm32_pcie->perst_gpio, 1);
> 
> I don't like tying PERST# handling with start/stop link. PERST# should be
> handled based on the power/clock state.

I don't understand your point: We turn off the PHY in suspend_noirq(), 
so that seems a logical place to de-assert in resume_noirq after the 
refclk is ready. PERST# should be kept active until the PHY stablilizes 
the clock in resume. From the PCIe electromechanical specs, PERST# goes 
active while the refclk is not stable/


> 
>> +}
>> +
>> +static int stm32_pcie_suspend(struct device *dev)
>> +{
>> +	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
>> +
>> +	if (device_may_wakeup(dev) || device_wakeup_path(dev))
>> +		enable_irq_wake(stm32_pcie->wake_irq);
>> +
>> +	return 0;
>> +}
>> +
>> +static int stm32_pcie_resume(struct device *dev)
>> +{
>> +	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
>> +
>> +	if (device_may_wakeup(dev) || device_wakeup_path(dev))
>> +		disable_irq_wake(stm32_pcie->wake_irq);
>> +
>> +	return 0;
>> +}
>> +
>> +static int stm32_pcie_suspend_noirq(struct device *dev)
>> +{
>> +	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
>> +
>> +	stm32_pcie->link_is_up = dw_pcie_link_up(stm32_pcie->pci);
>> +
>> +	stm32_pcie_stop_link(stm32_pcie->pci);
> 
> I don't understand how endpoint can wakeup the host if PERST# gets asserted.

The stm32 PCIe doesn't support L2, we don't expect an in-band beacon for 
the wakeup. We support wakeup only from sideband WAKE#, that will 
restart the link from IRQ

> 
>> +	clk_disable_unprepare(stm32_pcie->clk);
>> +
>> +	if (!device_may_wakeup(dev) && !device_wakeup_path(dev))
>> +		phy_exit(stm32_pcie->phy);
>> +
>> +	return pinctrl_pm_select_sleep_state(dev);
>> +}
>> +
>> +static int stm32_pcie_resume_noirq(struct device *dev)
>> +{
>> +	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
>> +	struct dw_pcie *pci = stm32_pcie->pci;
>> +	struct dw_pcie_rp *pp = &pci->pp;
>> +	int ret;
>> +
>> +	/* init_state must be called first to force clk_req# gpio when no
> 
> CLKREQ#
> 
> Why RC should control CLKREQ#?

REFCLK is gated with CLKREQ#, So we cannot access the core
without CLKREQ# if no device is present. So force it with a init pinmux
the time to init the PHY and the core DBI registers

> 
> Also please use preferred style for multi-line comments:
> 
> 	/*
> 	 * ...
> 	 */
> 
>> +	 * device is plugged.
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
>> +	if (!device_may_wakeup(dev) && !device_wakeup_path(dev)) {
>> +		ret = phy_init(stm32_pcie->phy);
>> +		if (ret) {
>> +			pinctrl_pm_select_default_state(dev);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	ret = clk_prepare_enable(stm32_pcie->clk);
>> +	if (ret)
>> +		goto clk_err;
> 
> Please name the goto labels of their purpose. Like err_phy_exit.

OK

> 
>> +
>> +	ret = dw_pcie_setup_rc(pp);
>> +	if (ret)
>> +		goto pcie_err;
> 
> This should be, 'err_disable_clk'.
> 
>> +
>> +	if (stm32_pcie->link_is_up) {
> 
> Why do you need this check? You cannot start the link in the absence of an
> endpoint?
> 

It is an optimization to avoid unnecessary "dw_pcie_wait_for_link" if no 
device is present during suspend


>> +		ret = stm32_pcie_start_link(stm32_pcie->pci);
>> +		if (ret)
>> +			goto pcie_err;
>> +
>> +		/* Ignore errors, the link may come up later */
>> +		dw_pcie_wait_for_link(stm32_pcie->pci);
>> +	}
>> +
>> +	pinctrl_pm_select_default_state(dev);
>> +
>> +	return 0;
>> +
>> +pcie_err:
>> +	dw_pcie_host_deinit(pp);
>> +	clk_disable_unprepare(stm32_pcie->clk);
>> +clk_err:
>> +	phy_exit(stm32_pcie->phy);
>> +	pinctrl_pm_select_default_state(dev);
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct dev_pm_ops stm32_pcie_pm_ops = {
>> +	NOIRQ_SYSTEM_SLEEP_PM_OPS(stm32_pcie_suspend_noirq,
>> +				  stm32_pcie_resume_noirq)
> 
> Can you make use of dw_pcie_{suspend/resume}_noirq() APIs?

dw_pcie_suspend_noirq bails out with read_poll_timeout on ltssm = 
DW_PCIE_LTSS_L2_IDLE. We don't support L2.

> 
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
> 
> [...]
> 
>> +	if (device_property_read_bool(dev, "wakeup-source")) {
>> +		stm32_pcie->wake_gpio = devm_gpiod_get_optional(dev, "wake",
>> +								GPIOD_IN);
>> +		if (IS_ERR(stm32_pcie->wake_gpio))
>> +			return dev_err_probe(dev, PTR_ERR(stm32_pcie->wake_gpio),
>> +					     "Failed to get wake GPIO\n");
>> +	}
>> +
>> +	if (stm32_pcie->wake_gpio) {
>> +		stm32_pcie->wake_irq = gpiod_to_irq(stm32_pcie->wake_gpio);
>> +
>> +		ret = devm_request_threaded_irq(&pdev->dev,
>> +						stm32_pcie->wake_irq, NULL,
>> +						stm32_pcie_wake_irq_handler,
>> +						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>> +						"wake_irq", stm32_pcie);
>> +
>> +		if (ret)
>> +			return dev_err_probe(dev, ret, "Failed to request WAKE IRQ: %d\n", ret);
>> +	}
> 
> Can we move WAKE# gpio handling to DWC core? There is nothing STM32 specific
> here.
> 

OK

>> +
>> +	ret = devm_pm_runtime_enable(dev);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Failed to enable runtime PM %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = pm_runtime_resume_and_get(dev);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Failed to get runtime PM %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = stm32_add_pcie_port(stm32_pcie, pdev);
>> +	if (ret)  {
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
>> +	struct dw_pcie_rp *pp = &stm32_pcie->pci->pp;
>> +
>> +	if (stm32_pcie->wake_gpio)
>> +		device_init_wakeup(&pdev->dev, false);
>> +
>> +	dw_pcie_host_deinit(pp);
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
>> +		.pm		= &stm32_pcie_pm_ops,
> 
> Just use a single space instead of tab.
> 
> Could you also set PROBE_PREFER_ASYNCHRONOUS to allow async probing of
> controller drivers?

OK

> 
>> +	},
>> +};
>> +
>> +static bool is_stm32_pcie_driver(struct device *dev)
>> +{
>> +	/* PCI bridge */
>> +	dev = get_device(dev);
>> +
>> +	/* Platform driver */
>> +	dev = get_device(dev->parent);
>> +
>> +	return (dev->driver == &stm32_pcie_driver.driver);
>> +}
>> +
>> +/*
>> + * DMA masters can only access the first 4GB of memory space,
>> + * so we setup the bus DMA limit accordingly.
>> + */
>> +static int stm32_dma_limit(struct pci_dev *pdev, void *data)
>> +{
>> +	dev_dbg(&pdev->dev, "disabling DMA DAC for device");
>> +
>> +	pdev->dev.bus_dma_limit = DMA_BIT_MASK(32);
>> +
>> +	return 0;
>> +}
>> +
>> +static void quirk_stm32_dma_mask(struct pci_dev *pci)
>> +{
>> +	struct pci_dev *root_port;
>> +
>> +	root_port = pcie_find_root_port(pci);
>> +
>> +	if (root_port && is_stm32_pcie_driver(root_port->dev.parent))
>> +		pci_walk_bus(pci->bus, stm32_dma_limit, NULL);
>> +}
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SYNOPSYS, 0x0550, quirk_stm32_dma_mask);
> 
> This is not the correct way of using DMA masks as Bjorn noted.

Yes, fixed will dma-ranges

thanks

Christian

> 
> - Mani
> 

