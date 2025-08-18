Return-Path: <linux-pci+bounces-34190-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8DCB29FA6
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 12:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B3A9176F89
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 10:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD9A30F525;
	Mon, 18 Aug 2025 10:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Ns5OP/Vn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A4C30100E;
	Mon, 18 Aug 2025 10:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514412; cv=none; b=ajNZ5hAof0lFpLR1PIo1Ix5BTy6oj4X2dQnfphBlIM7o6FW5ivFVvSxD40BCbnfh6YCTgmmi//zmkrJwNbbwESejoMIRib7YmZ5tz/sOTyMA+5rAXXA2XytdOIu0Gh4ClPVZ3Q70EONk6qTF8Ri/HkxA43TCL4nWF6PGR4k+8v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514412; c=relaxed/simple;
	bh=6hYQE+9xexyUbJIFBA4b/3yXIwMMyZeUUKgRm6gKxQk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=p3irtjSbtelQ2bzxB2/Z9n2WUY1p8rIn+UnLukxTzh16RrKuWCMvhSGIbec12eSz/+yYYfj1VxEGZkQBeRTKi+IOQpoJupBW8FZiWQDSIxYIPWUmROecbiH9NRdImdVkGg9fjzfBWFOSkx++uaCbCEMGDn7+1OmW71d2/9Azry8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Ns5OP/Vn; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I9Z0je028985;
	Mon, 18 Aug 2025 12:53:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	sX1oBWhQYj9bxa1O4MkbKyeiDwQaF+Lccrzrfxq3YzE=; b=Ns5OP/VnvRmLnLgD
	9RA7z5rw5ag2xsjnGb3k1KdgsZch33rgXeoxnkh1IqNN0vq/u1d1grsiwnxEflvQ
	5MUxN+aEKGwXH9XHDVzXA1SzGoiHClTs0QbFbxXXzBeLDqU5ZzccSAZRQaRrNRtq
	YFhivY3eoVm7RjDHXDyFMDJTS+NCHEYW/3c8jUG0LhrWjLghZJAq7LV0cINe/Myy
	ALf4IoFuRUlgKWMmahZlfYYPh5ILdmgrdjF5WE0e/HXQXQ/wIUIOEOqwt8JmHo1C
	Z8nf0xhPTRWRdqb6LmfcQu6Yy2zn7+6GpWyrru8Ui0fBhI7TFgQ+0KHa66eoPnQr
	VNZylg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48jfdk6ds4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 12:53:02 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8530040045;
	Mon, 18 Aug 2025 12:51:40 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7A72D723BAA;
	Mon, 18 Aug 2025 12:50:22 +0200 (CEST)
Received: from [10.130.77.120] (10.130.77.120) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 12:50:21 +0200
Message-ID: <917c9323-9c0c-406f-a314-a6e4a5511b45@foss.st.com>
Date: Mon, 18 Aug 2025 12:50:19 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christian Bruel <christian.bruel@foss.st.com>
Subject: Re: [PATCH v12 2/9] PCI: stm32: Add PCIe host support for STM32MP25
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>, <p.zabel@pengutronix.de>,
        <johan+linaro@kernel.org>, <cassel@kernel.org>,
        <shradha.t@samsung.com>, <thippeswamy.havalige@amd.com>,
        <quic_schintav@quicinc.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250813192957.GA286749@bhelgaas>
Content-Language: en-US
In-Reply-To: <20250813192957.GA286749@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_04,2025-08-14_01,2025-03-28_01

On 8/13/25 21:29, Bjorn Helgaas wrote:
> On Tue, Jun 10, 2025 at 11:07:07AM +0200, Christian Bruel wrote:
>> Add driver for the STM32MP25 SoC PCIe Gen1 2.5 GT/s and Gen2 5GT/s
>> controller based on the DesignWare PCIe core.
>> ...
> 
>> +struct stm32_pcie {
>> +	struct dw_pcie pci;
>> +	struct regmap *regmap;
>> +	struct reset_control *rst;
>> +	struct phy *phy;
>> +	struct clk *clk;
>> +	struct gpio_desc *perst_gpio;
>> +	struct gpio_desc *wake_gpio;
>> +};
>> +
>> +static void stm32_pcie_deassert_perst(struct stm32_pcie *stm32_pcie)
>> +{
>> +	/* Delay PERST# de-assertion until the power stabilizes */
>> +	msleep(PCIE_T_PVPERL_MS);
>> +
>> +	gpiod_set_value(stm32_pcie->perst_gpio, 0);
>> +
>> +	/* Wait for the REFCLK to stabilize */
>> +	if (stm32_pcie->perst_gpio)
>> +		msleep(PCIE_T_RRS_READY_MS);
> 
> This obviously relies on gpiod_set_value(stm32_pcie->perst_gpio, 0)
> being a no-op when perst_gpio == NULL.  Since we're testing perst_gpio
> anyway, I think it might be more readable to avoid relying on
> gpiod_set_value() being a no-op:
> 
>    msleep(PCIE_T_PVPERL_MS);
> 
>    if (stm32_pcie->perst_gpio) {
>      gpiod_set_value(stm32_pcie->perst_gpio, 0);
>      msleep(PCIE_T_RRS_READY_MS);
>    }
> 
> (And a similar change in stm32_pcie_assert_perst())
> 
> But this seems wrong because PCIE_T_PVPERL_MS is a delay before PERST#
> is deasserted, but when perst_gpio == NULL, PERST# has already *been*
> deasserted.
> 
> So it seems like it would make more sense as:
> 
>    if (stm32_pcie->perst_gpio) {
>      msleep(PCIE_T_PVPERL_MS);
>      gpiod_set_value(stm32_pcie->perst_gpio, 0);
>    }
> 
>    msleep(PCIE_T_RRS_READY_MS);

I agree, grouping pvperl_ms and the PERST# deassertion together makes 
sense. thank you.

> 
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
>> +static int stm32_pcie_suspend_noirq(struct device *dev)
>> +{
>> +	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
>> +	int ret;
>> +
>> +	ret = dw_pcie_suspend_noirq(&stm32_pcie->pci);
>> +	if (ret)
>> +		return ret;
>> +
>> +	stm32_pcie_assert_perst(stm32_pcie);
>> +
>> +	clk_disable_unprepare(stm32_pcie->clk);
>> +
>> +	if (!device_wakeup_path(dev))
>> +		phy_exit(stm32_pcie->phy);
>> +
>> +	return pinctrl_pm_select_sleep_state(dev);
>> +}
>> +
>> +static int stm32_pcie_resume_noirq(struct device *dev)
>> +{
>> +	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
>> +	int ret;
>> +
>> +	/*
>> +	 * The core clock is gated with CLKREQ# from the COMBOPHY REFCLK,
>> +	 * thus if no device is present, must force it low with an init pinmux
>> +	 * to be able to access the DBI registers.
> 
> What happens on initial probe if no device is present?  I assume we
> access DBI registers in the dw_pcie_host_init() path, and it seems
> like we'd have the same issue with DBI not being accessible when no
> device is present.

Correct, same issue. The magic happens with the PINCTRL init state that 
is automatically called before probe. As I tried to explain in the 
Documentation in the pinctrl patch:

- if ``init`` and ``default`` are defined in the device tree, the "init"
   state is selected before the driver probe and the "default" state is
   selected after the driver probe.

> 
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
>> +	if (!device_wakeup_path(dev)) {
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
>> +	ret = dw_pcie_resume_noirq(&stm32_pcie->pci);
>> +	if (ret)
>> +		goto err_disable_clk;
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
>> +static int stm32_add_pcie_port(struct stm32_pcie *stm32_pcie)
>> +{
>> +	struct device *dev = stm32_pcie->pci.dev;
>> +	unsigned int wake_irq;
>> +	int ret;
>> +
>> +	/* Start to enable resources with PERST# asserted */
> 
> I guess if device tree doesn't describe PERST#, we assume PERST# is
> actually *deasserted* already at this point (because
> stm32_pcie_deassert_perst() does nothing other than the delay)?

yes, this also implies that PV is stable

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
>> +	stm32_pcie_deassert_perst(stm32_pcie);
>> +
>> +	if (stm32_pcie->wake_gpio) {
>> +		wake_irq = gpiod_to_irq(stm32_pcie->wake_gpio);
>> +		ret = dev_pm_set_dedicated_wake_irq(dev, wake_irq);
>> +		if (ret) {
>> +			dev_err(dev, "Failed to enable wakeup irq %d\n", ret);
>> +			goto err_assert_perst;
>> +		}
>> +		irq_set_irq_type(wake_irq, IRQ_TYPE_EDGE_FALLING);
>> +	}
>> +
>> +	return 0;
>> +
>> +err_assert_perst:
>> +	stm32_pcie_assert_perst(stm32_pcie);
>> +
>> +err_phy_exit:
>> +	phy_exit(stm32_pcie->phy);
>> +
>> +	return ret;
>> +}
>> +
>> +static void stm32_remove_pcie_port(struct stm32_pcie *stm32_pcie)
>> +{
>> +	dev_pm_clear_wake_irq(stm32_pcie->pci.dev);
>> +
>> +	stm32_pcie_assert_perst(stm32_pcie);
>> +
>> +	phy_exit(stm32_pcie->phy);
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
>> +	if (IS_ERR(stm32_pcie->phy)) {
>> +		of_node_put(root_port);
>> +		return dev_err_probe(dev, PTR_ERR(stm32_pcie->phy),
>> +				     "Failed to get pcie-phy\n");
>> +	}
>> +
>> +	stm32_pcie->perst_gpio = devm_fwnode_gpiod_get(dev, of_fwnode_handle(root_port),
>> +						       "reset", GPIOD_OUT_HIGH, NULL);
>> +	if (IS_ERR(stm32_pcie->perst_gpio)) {
>> +		if (PTR_ERR(stm32_pcie->perst_gpio) != -ENOENT) {
>> +			of_node_put(root_port);
>> +			return dev_err_probe(dev, PTR_ERR(stm32_pcie->perst_gpio),
>> +					     "Failed to get reset GPIO\n");
>> +		}
>> +		stm32_pcie->perst_gpio = NULL;
> 
> This looks like perst_gpio is optional in device tree?  Is that really
> the case?  It seems hard to ensure we have the PCIE_T_PVPERL_MS and
> PCIE_T_RRS_READY_MS delays in the right place if we don't have
> perst_gpio.

perst_gpio was initially made optional for pre-silicon platforms with 
hooked PHY functions (or no PHY).
It is assumed that the PV and REFCLK signals are already stable, I 
suppose that without perst_gpio, the system must rely on these 
assumptions. But my experience with other models without perst as gpio 
is limited to this.

> 
>> +	}
>> +
>> +	stm32_pcie->wake_gpio = devm_fwnode_gpiod_get(dev, of_fwnode_handle(root_port),
>> +						      "wake", GPIOD_IN, NULL);
>> +
>> +	if (IS_ERR(stm32_pcie->wake_gpio)) {
>> +		if (PTR_ERR(stm32_pcie->wake_gpio) != -ENOENT) {
>> +			of_node_put(root_port);
>> +			return dev_err_probe(dev, PTR_ERR(stm32_pcie->wake_gpio),
>> +					     "Failed to get wake GPIO\n");
>> +		}
>> +		stm32_pcie->wake_gpio = NULL;
>> +	}
>> +
>> +	of_node_put(root_port);
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
>> +	stm32_pcie->pci.pp.ops = &stm32_pcie_host_ops;
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
>> +	ret = stm32_add_pcie_port(stm32_pcie);
>> +	if (ret)
>> +		return ret;
>> +
>> +	reset_control_assert(stm32_pcie->rst);
>> +	reset_control_deassert(stm32_pcie->rst);
>> +
>> +	ret = clk_prepare_enable(stm32_pcie->clk);
>> +	if (ret) {
>> +		dev_err(dev, "Core clock enable failed %d\n", ret);
>> +		goto err_remove_port;
>> +	}
>> +
>> +	ret = pm_runtime_set_active(dev);
>> +	if (ret < 0) {
>> +		clk_disable_unprepare(stm32_pcie->clk);
>> +		stm32_remove_pcie_port(stm32_pcie);
>> +		return dev_err_probe(dev, ret, "Failed to activate runtime PM\n");
>> +	}
>> +
>> +	pm_runtime_no_callbacks(dev);
>> +
>> +	ret = devm_pm_runtime_enable(dev);
>> +	if (ret < 0) {
>> +		clk_disable_unprepare(stm32_pcie->clk);
>> +		stm32_remove_pcie_port(stm32_pcie);
>> +		return dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
>> +	}
>> +
>> +	ret = dw_pcie_host_init(&stm32_pcie->pci.pp);
>> +	if (ret)
>> +		goto err_disable_clk;
>> +
>> +	if (stm32_pcie->wake_gpio)
>> +		device_init_wakeup(dev, true);
>> +
>> +	return 0;
>> +
>> +err_disable_clk:
>> +	clk_disable_unprepare(stm32_pcie->clk);
>> +
>> +err_remove_port:
>> +	stm32_remove_pcie_port(stm32_pcie);
>> +
>> +	return ret;
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
>> +	clk_disable_unprepare(stm32_pcie->clk);
>> +
>> +	stm32_remove_pcie_port(stm32_pcie);
>> +
>> +	pm_runtime_put_noidle(&pdev->dev);
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
>> index 000000000000..387112c4e42c
>> --- /dev/null
>> +++ b/drivers/pci/controller/dwc/pcie-stm32.h
>> @@ -0,0 +1,15 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * ST PCIe driver definitions for STM32-MP25 SoC
>> + *
>> + * Copyright (C) 2025 STMicroelectronics - All Rights Reserved
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
>> -- 
>> 2.34.1
>>


