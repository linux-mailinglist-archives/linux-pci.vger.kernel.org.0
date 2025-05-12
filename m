Return-Path: <linux-pci+bounces-27591-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED42AB3D03
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 18:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C13E3B85F3
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 16:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A848B248883;
	Mon, 12 May 2025 16:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="VvXRuTHy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED2E24886E;
	Mon, 12 May 2025 16:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066193; cv=none; b=fJUU5WOv/cBSKj9RaeKulfaQD71SVTWFV/rUXAN8uQIu3VeNYCGjf19ec02kDmJgoX9l37BPQYK5lGE9b//UlKbVD4poq+MoUh9T3YsgZM1TVXLQ06nhgyNhIMsuxfqEHn0gPfEc90Bga1gwLkrmdnMVwKXgSX04CRizbCf8mdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066193; c=relaxed/simple;
	bh=HPkbizzJPBBZVxpQgpvMoa7T4QCDgny19Bvar4SBW/E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=bbtc/VYEssWnjcRkKVfuAI/BZFOYsfk5vXiGaxxyfcsU0CASQYzlSF9yGgCa/ICIjUxUFyKIWgHXgbsijXLTVT+G1EqmoYlwQEe2NYmIaCwWEA1Klg8Zf28xHYw3hKYsoUJHtfG6xJ+bTPf7BQzmhcI7PT5e0UmEoDuYo1N3ZoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=VvXRuTHy; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CBSAd1030870;
	Mon, 12 May 2025 18:09:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	TQF/4z87M6Zev4BTJ0Pi8MpOAsMnb3E7xkduvvN1r+k=; b=VvXRuTHypFhS946I
	hXJUhnrSozdE5ib6zQ8hb9tSBWEmrq6CEE1RSDYmypvtI47ghJrWsxpUCQEZw336
	qM92Yo7fiNBGPfySZOq9C8I9QvLb4rqhnYfK35anvCYOBdpULYLJZprmaHmyT4+o
	QWbrMMTh7pfAf4g5SZk9mn7SFknuQ0NaO/yVJBP0oaGfqudQ2XJB5JX4YcJP/Lch
	0GhYtyjIR93b+NgXcX+vCFa12VWm3Xs9OmrIi30FJM5tY4+kl+dfTTzL/ha2OMod
	uOlDhYA1FHGtyNDGd2/RzMbvr0KVWbQAV4CeUvc9Ur8othH34MF2IFuiOkSw8jA4
	I9Cl7g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46jhrmwc1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 18:09:19 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1BFB540048;
	Mon, 12 May 2025 18:07:37 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CCDF6B2C9B7;
	Mon, 12 May 2025 18:06:18 +0200 (CEST)
Received: from [10.130.77.120] (10.130.77.120) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 18:06:18 +0200
Message-ID: <619756c5-1a61-4aa9-b7fb-6be65175ded2@foss.st.com>
Date: Mon, 12 May 2025 18:06:16 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christian Bruel <christian.bruel@foss.st.com>
Subject: Re: [PATCH v8 4/9] PCI: stm32: Add PCIe Endpoint support for
 STM32MP25
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <p.zabel@pengutronix.de>, <thippeswamy.havalige@amd.com>,
        <shradha.t@samsung.com>, <quic_schintav@quicinc.com>,
        <cassel@kernel.org>, <johan+linaro@kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250423090119.4003700-1-christian.bruel@foss.st.com>
 <20250423090119.4003700-5-christian.bruel@foss.st.com>
 <tdgyva6qyn6qwzvft4f7r3tgp5qswuv4q5swoaeomnnbxtmz5j@zo3gvevx2skp>
Content-Language: en-US
In-Reply-To: <tdgyva6qyn6qwzvft4f7r3tgp5qswuv4q5swoaeomnnbxtmz5j@zo3gvevx2skp>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_05,2025-05-09_01,2025-02-21_01

Hello Manivannan,

On 4/30/25 09:50, Manivannan Sadhasivam wrote:
> On Wed, Apr 23, 2025 at 11:01:14AM +0200, Christian Bruel wrote:
>> Add driver to configure the STM32MP25 SoC PCIe Gen1 2.5GT/s or Gen2 5GT/s
>> controller based on the DesignWare PCIe core in endpoint mode.
>>
>> Uses the common reference clock provided by the host.
>>
>> The PCIe core_clk receives the pipe0_clk from the ComboPHY as input,
>> and the ComboPHY PLL must be locked for pipe0_clk to be ready.
>> Consequently, PCIe core registers cannot be accessed until the ComboPHY is
>> fully initialised and refclk is enabled and ready.
>>
>> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
>> ---
>>   drivers/pci/controller/dwc/Kconfig         |  12 +
>>   drivers/pci/controller/dwc/Makefile        |   1 +
>>   drivers/pci/controller/dwc/pcie-stm32-ep.c | 414 +++++++++++++++++++++
>>   drivers/pci/controller/dwc/pcie-stm32.h    |   1 +
>>   4 files changed, 428 insertions(+)
>>   create mode 100644 drivers/pci/controller/dwc/pcie-stm32-ep.c
>>
>> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
>> index 2aec5d2f9a46..aceff7d1ef33 100644
>> --- a/drivers/pci/controller/dwc/Kconfig
>> +++ b/drivers/pci/controller/dwc/Kconfig
>> @@ -422,6 +422,18 @@ config PCIE_STM32_HOST
>>   	  This driver can also be built as a module. If so, the module
>>   	  will be called pcie-stm32.
>>   
>> +config PCIE_STM32_EP
>> +	tristate "STMicroelectronics STM32MP25 PCIe Controller (endpoint mode)"
>> +	depends on ARCH_STM32 || COMPILE_TEST
>> +	depends on PCI_ENDPOINT
>> +	select PCIE_DW_EP
>> +	help
>> +	  Enables endpoint support for DesignWare core based PCIe controller
>> +	  found in STM32MP25 SoC.
> 
> Can you please use similar description for the RC driver also?
> 
> "Enables Root Complex (RC) support for the DesignWare core based PCIe host
> controller found in STM32MP25 SoC."

Yes, will align the messages

>> +
>> +	  This driver can also be built as a module. If so, the module
>> +	  will be called pcie-stm32-ep.
>> +
>>   config PCI_DRA7XX
>>   	tristate
>>   
> 
> [...]
> 
>> +static int stm32_add_pcie_ep(struct stm32_pcie *stm32_pcie,
>> +			     struct platform_device *pdev)
>> +{
>> +	struct dw_pcie_ep *ep = &stm32_pcie->pci.ep;
>> +	struct device *dev = &pdev->dev;
>> +	int ret;
>> +
>> +	ret = pm_runtime_resume_and_get(dev);
> 
> This needs to be called before devm_pm_runtime_enable().

OK. Also and we must use pm_runtime_get_noresume() here.

> 
>> +	if (ret < 0) {
>> +		dev_err(dev, "pm runtime resume failed: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
>> +				 STM32MP25_PCIECR_TYPE_MASK,
>> +				 STM32MP25_PCIECR_EP);
>> +	if (ret) {
>> +		goto err_pm_put_sync;
>> +		return ret;
>> +	}
>> +
>> +	reset_control_assert(stm32_pcie->rst);
>> +	reset_control_deassert(stm32_pcie->rst);
>> +
>> +	ep->ops = &stm32_pcie_ep_ops;
>> +
>> +	ret = dw_pcie_ep_init(ep);
>> +	if (ret) {
>> +		dev_err(dev, "failed to initialize ep: %d\n", ret);
>> +		goto err_pm_put_sync;
>> +	}
>> +
>> +	ret = stm32_pcie_enable_resources(stm32_pcie);
>> +	if (ret) {
>> +		dev_err(dev, "failed to enable resources: %d\n", ret);
>> +		goto err_ep_deinit;
>> +	}
>> +
>> +	ret = dw_pcie_ep_init_registers(ep);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to initialize DWC endpoint registers\n");
>> +		goto err_disable_resources;
>> +	}
>> +
>> +	pci_epc_init_notify(ep->epc);
>> +
> 
> Hmm, looks like you need to duplicate dw_pcie_ep_init_registers() and
> pci_epc_init_notify() in stm32_pcie_perst_deassert() for hw specific reasons.
> So can you drop these from there?

We cannot remove dw_pcie_ep_init_registers() and 
dw_pcie_ep_init_registers() here because the PCIe registers need to be 
ready at the end of pcie_stm32_probe, as the host might already be 
running. In that case the host enumerates with /sys/bus/pci/rescan 
rather than asserting/deasserting PERST#.
Therefore, we do not need to reboot the host after initializing the EP."


> 
>> +	return 0;
>> +
>> +err_disable_resources:
>> +	stm32_pcie_disable_resources(stm32_pcie);
>> +
>> +err_ep_deinit:
>> +	dw_pcie_ep_deinit(ep);
>> +
>> +err_pm_put_sync:
>> +	pm_runtime_put_sync(dev);
>> +	return ret;
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
>> +	stm32_pcie->phy = devm_phy_get(dev, NULL);
>> +	if (IS_ERR(stm32_pcie->phy))
>> +		return dev_err_probe(dev, PTR_ERR(stm32_pcie->phy),
>> +				     "failed to get pcie-phy\n");
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
>> +	stm32_pcie->perst_gpio = devm_gpiod_get(dev, "reset", GPIOD_IN);
>> +	if (IS_ERR(stm32_pcie->perst_gpio))
>> +		return dev_err_probe(dev, PTR_ERR(stm32_pcie->perst_gpio),
>> +				     "Failed to get reset GPIO\n");
>> +
>> +	ret = phy_set_mode(stm32_pcie->phy, PHY_MODE_PCIE);
>> +	if (ret)
>> +		return ret;
>> +
>> +	platform_set_drvdata(pdev, stm32_pcie);
>> +
>> +	ret = devm_pm_runtime_enable(dev);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Failed to enable pm runtime %d\n", ret);
> 
> Use dev_err_probe() please for consistency.

OK

thank you

Christian
> 
> - Mani
> 

