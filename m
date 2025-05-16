Return-Path: <linux-pci+bounces-27838-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F7DAB97DB
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 10:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 173153A99FB
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 08:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAE522D9F9;
	Fri, 16 May 2025 08:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="bV5T8TAK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC342282E1;
	Fri, 16 May 2025 08:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747384872; cv=none; b=aUJQ3uuPXbhLO332C3gArkRwTxSEF8KPJMIzFD1534BRVCYI0prP6KpAzQJR8RLXp7JQdLfJ6qLpXuODfryr6kBKUwNoOn943iaYXL96JX6tYV02tqlwXYxEqj4wlDZGvAnuOOnEejl4ECOiGN74bI08N4sheNjQJjXqMcOkw3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747384872; c=relaxed/simple;
	bh=vFvunMkscxWQ2aGc2PjT/YAlhcjkc5XfDLQnAOD2iUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=buKg6F0QIo9qutB6srUb2VO+Do3iunzOKfT1h0QjoNZQdaizeFKs7oOlFQ4EO7r8CKjq6RagQ6B2cjL2ei8qBZAVTcm/4/CzXt2M3TyQgIvr9m2dirtHxhLkuCnU7auZ0OTZ8XDB1EQTaqH7rHZoWUi9/qpX9lzQz2a6T1Aig5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=bV5T8TAK; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54G7PoHT028005;
	Fri, 16 May 2025 10:40:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	jOVQbSyRtvHqlvBwmgwbNuyQyI33ggIazbqG1gBI7zE=; b=bV5T8TAK7sCLOU2a
	M33BxFPl4Hm54I2NCmUuqlxss0eiqlrpXONjMgoIpqqFYl9vfMqMaiq6qtGd/vzM
	uclxTteUpXmPMHaztuyyZt/g08HdkcZUJPPBwTdFYlt5yfQGh+0uYeu3FnQ33LBc
	PpNV8gAuTu8Dq64zPc3NeGa1igIHNyp6GqRpfsP5ssE9mGe1nYwF2B1gkREIqFDl
	2mG5Qw8Pwm2iwD0FUjuypOyhDZw3ezcK1msu1YhxZESXebfmFJ/vFuBxFHRlX906
	c6aKPkBTAjFxL7spZ2AmChDAqzVt0NRJnZbJOz5QkJpvZL2+5s+6qCWpAdbLbZ0E
	bvA56A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46mbdy4g62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 10:40:13 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1FCE04002D;
	Fri, 16 May 2025 10:38:37 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8E7B0B34A7F;
	Fri, 16 May 2025 10:37:18 +0200 (CEST)
Received: from [10.130.77.120] (10.130.77.120) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 May
 2025 10:37:17 +0200
Message-ID: <7df0c1e5-f53b-4a44-920a-c2dfe8842481@foss.st.com>
Date: Fri, 16 May 2025 10:37:16 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/9] PCI: stm32: Add PCIe host support for STM32MP25
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
 <20250423090119.4003700-3-christian.bruel@foss.st.com>
 <gzw3rcuwuu7yswljzde2zszqlzkfsilozdfv2ebrcxjpvngpkk@hvzqb5wbjalb>
 <c01d0d72-e43c-4e10-b298-c8ed4f5d1942@foss.st.com>
 <ec33uuugief45swij7eu3mbx7htfxov6qa5miucqsrdp36z7qe@svpbhliveks4>
From: Christian Bruel <christian.bruel@foss.st.com>
Content-Language: en-US
In-Reply-To: <ec33uuugief45swij7eu3mbx7htfxov6qa5miucqsrdp36z7qe@svpbhliveks4>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_03,2025-05-15_01,2025-03-28_01



On 5/15/25 13:29, Manivannan Sadhasivam wrote:
> On Mon, May 12, 2025 at 05:08:13PM +0200, Christian Bruel wrote:
>> Hi Manivannan,
>>
>> On 4/30/25 09:30, Manivannan Sadhasivam wrote:
>>> On Wed, Apr 23, 2025 at 11:01:12AM +0200, Christian Bruel wrote:
>>>> Add driver for the STM32MP25 SoC PCIe Gen1 2.5 GT/s and Gen2 5GT/s
>>>> controller based on the DesignWare PCIe core.
>>>>
>>>> Supports MSI via GICv2m, Single Virtual Channel, Single Function
>>>>
>>>> Supports WAKE# GPIO.
>>>>
>>>
>>> Mostly looks good. Just a couple of comments below.
>>>
>>>> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
>>>> ---
>>>>    drivers/pci/controller/dwc/Kconfig      |  12 +
>>>>    drivers/pci/controller/dwc/Makefile     |   1 +
>>>>    drivers/pci/controller/dwc/pcie-stm32.c | 368 ++++++++++++++++++++++++
>>>>    drivers/pci/controller/dwc/pcie-stm32.h |  15 +
>>>>    4 files changed, 396 insertions(+)
>>>>    create mode 100644 drivers/pci/controller/dwc/pcie-stm32.c
>>>>    create mode 100644 drivers/pci/controller/dwc/pcie-stm32.h
>>>>
>>>
>>> [...]
>>>
>>>> +static int stm32_pcie_probe(struct platform_device *pdev)
>>>> +{
>>>> +	struct stm32_pcie *stm32_pcie;
>>>> +	struct device *dev = &pdev->dev;
>>>> +	int ret;
>>>> +
>>>> +	stm32_pcie = devm_kzalloc(dev, sizeof(*stm32_pcie), GFP_KERNEL);
>>>> +	if (!stm32_pcie)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	stm32_pcie->pci.dev = dev;
>>>> +	stm32_pcie->pci.ops = &dw_pcie_ops;
>>>> +	stm32_pcie->pci.pp.ops = &stm32_pcie_host_ops;
>>>> +
>>>> +	stm32_pcie->regmap = syscon_regmap_lookup_by_compatible("st,stm32mp25-syscfg");
>>>> +	if (IS_ERR(stm32_pcie->regmap))
>>>> +		return dev_err_probe(dev, PTR_ERR(stm32_pcie->regmap),
>>>> +				     "No syscfg specified\n");
>>>> +
>>>> +	stm32_pcie->clk = devm_clk_get(dev, NULL);
>>>> +	if (IS_ERR(stm32_pcie->clk))
>>>> +		return dev_err_probe(dev, PTR_ERR(stm32_pcie->clk),
>>>> +				     "Failed to get PCIe clock source\n");
>>>> +
>>>> +	stm32_pcie->rst = devm_reset_control_get_exclusive(dev, NULL);
>>>> +	if (IS_ERR(stm32_pcie->rst))
>>>> +		return dev_err_probe(dev, PTR_ERR(stm32_pcie->rst),
>>>> +				     "Failed to get PCIe reset\n");
>>>> +
>>>> +	ret = stm32_pcie_parse_port(stm32_pcie);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	platform_set_drvdata(pdev, stm32_pcie);
>>>> +
>>>> +	ret = pm_runtime_set_active(dev);
>>>> +	if (ret < 0) {
>>>> +		dev_err(dev, "Failed to activate runtime PM %d\n", ret);
>>>
>>> Please use dev_err_probe() here and below.
>>
>> OK, will report this in the EP driver also.
>>
>>>
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	ret = devm_pm_runtime_enable(dev);
>>>> +	if (ret < 0) {
>>>> +		dev_err(dev, "Failed to enable runtime PM %d\n", ret);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	pm_runtime_get_noresume(dev);
>>>> +
>>>
>>> I know that a lot of the controller drivers do this for no obvious reason. But
>>> in this case, I believe you want to enable power domain or genpd before
>>> registering the host bridge. Is that right?
>>
>> We call pm_runtime_enable() before stm32_add_pcie_port() and
>> dw_pcie_host_init(). This ensures that PCIe is active during the PERST#
>> sequence and before accessing the DWC registers.
>>
> 
> What do you mean by 'PCIe is active'? Who is activating it other than this
> driver?

"PCIe is active" in the sense of pm_runtime_active() and PM runtime_enabled.

A better call point would be just before dw_host_init(), after the PCIe 
controller is reset :

stm32_add_pcie_port()
clk_prepare_enable()
devm_pm_runtime_enable()
dw_pcie_host_init()

with this sequence, the stm32_pcie_suspend_noirq() is well balanced. 
does that sound better ?

> 
>>> And the fact that you are not
>>> decrementing the runtime usage count means, you want to keep it ON all the time?
>>> Beware that your system suspend/resume calls would never get executed.
>>
>> We do not support PM runtime autosuspend, so we must notify PM runtime that
>> PCIe is always active. Without invoking pm_runtime_get_noresume(), PCIe
>> would mistakenly be marked as suspended.
> 
> This cannot happen unless the child devices are also suspended? Or if there are
> no child devices connected.

If no device is connected or if one is active, without 
pm_runtime_get_noresume(), pm_genpd_summary says "PCIe suspended" 
despite being clocked and having accessible configuration space

thank you,

Christian

> 
> - Mani
> 

