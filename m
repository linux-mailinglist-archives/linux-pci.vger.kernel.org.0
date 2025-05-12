Return-Path: <linux-pci+bounces-27590-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADA1AB3BB4
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 17:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDC763B3DCE
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 15:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CE7236426;
	Mon, 12 May 2025 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="rnuUverq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FE21EDA11;
	Mon, 12 May 2025 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747062716; cv=none; b=hfRd0XZUkNMqF2RYlUEv+jruF+GaLM06Pf7o1WfrncOT3IZ1L3YZ8zJNas40cM97z5AZLhxh17ObSiMqE6jfKULyzh0EygigYzGVdbpXFMGB5zOboPzV0xSjJlR6pAhWcxsg6A6aC1I+4QFokrBYQuRfYR2eNneKwCJB+wEpYEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747062716; c=relaxed/simple;
	bh=oRZq7V38BDPzrnIKHLulsvxYYp+PkT3EdJDnzIgMVNQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=eITQrbsg+hu+Ye3fGniVEu+UENkJRQbL4pSKrc3VO9bIVVSCjIv63hLgCUpVdYRTJ0w41HkspF5E+pTsmXGUlgOJRv46YtRm7P3Y9M1MGAIL/XFbuLtsRc8llxTdDFa5l4e2IdRVGZwY3A7HxFEi5pp4oX9WXfKWJHcHS1+BNh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=rnuUverq; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CD4kW1025877;
	Mon, 12 May 2025 17:11:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	BsohuFHL0A1uGoWvntQ5+Cuy1yzn6J9UrbSwG2edDAA=; b=rnuUverqE269o+TQ
	pLW8NzKc9m5dDDkRw+fVwCvwLK9Aw4KkSzKfPSEDSpoMdaa6/vDn9pF6CX7Kx4Y6
	BokEFE2Ycmt6iokXnRg7lvVZ7A0TTIp3A5jbKjI4g6owBUKGynNHyfJMTbseNzGa
	4YxoABtAZSUNcV1z3r2o5/Z1kjsdluS+oHSrAT5ObUIgr0vk2ipLSYEVvl+Vxewi
	BZdFVyBwBTGXEIi9+srPgDi7Wa25O/3K+SUilx250eeAP6ROgacOH3eDoxKnKGL7
	XbKOMz5tqaTVVIpZH3XaGM39OlvUQNj8EExDTEUfW5cf0qjZB2g7mOMslDCtzK80
	BbR3Hw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46hv7kqvq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 17:11:19 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0094F40045;
	Mon, 12 May 2025 17:09:42 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 75DB7B20C2D;
	Mon, 12 May 2025 17:08:25 +0200 (CEST)
Received: from [10.130.77.120] (10.130.77.120) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 17:08:24 +0200
Message-ID: <c01d0d72-e43c-4e10-b298-c8ed4f5d1942@foss.st.com>
Date: Mon, 12 May 2025 17:08:13 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christian Bruel <christian.bruel@foss.st.com>
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
Content-Language: en-US
In-Reply-To: <gzw3rcuwuu7yswljzde2zszqlzkfsilozdfv2ebrcxjpvngpkk@hvzqb5wbjalb>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_05,2025-05-09_01,2025-02-21_01

Hi Manivannan,

On 4/30/25 09:30, Manivannan Sadhasivam wrote:
> On Wed, Apr 23, 2025 at 11:01:12AM +0200, Christian Bruel wrote:
>> Add driver for the STM32MP25 SoC PCIe Gen1 2.5 GT/s and Gen2 5GT/s
>> controller based on the DesignWare PCIe core.
>>
>> Supports MSI via GICv2m, Single Virtual Channel, Single Function
>>
>> Supports WAKE# GPIO.
>>
> 
> Mostly looks good. Just a couple of comments below.
> 
>> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
>> ---
>>   drivers/pci/controller/dwc/Kconfig      |  12 +
>>   drivers/pci/controller/dwc/Makefile     |   1 +
>>   drivers/pci/controller/dwc/pcie-stm32.c | 368 ++++++++++++++++++++++++
>>   drivers/pci/controller/dwc/pcie-stm32.h |  15 +
>>   4 files changed, 396 insertions(+)
>>   create mode 100644 drivers/pci/controller/dwc/pcie-stm32.c
>>   create mode 100644 drivers/pci/controller/dwc/pcie-stm32.h
>>
> 
> [...]
> 
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
>> +	ret = pm_runtime_set_active(dev);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Failed to activate runtime PM %d\n", ret);
> 
> Please use dev_err_probe() here and below.

OK, will report this in the EP driver also.

> 
>> +		return ret;
>> +	}
>> +
>> +	ret = devm_pm_runtime_enable(dev);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Failed to enable runtime PM %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	pm_runtime_get_noresume(dev);
>> +
> 
> I know that a lot of the controller drivers do this for no obvious reason. But
> in this case, I believe you want to enable power domain or genpd before
> registering the host bridge. Is that right? 

We call pm_runtime_enable() before stm32_add_pcie_port() and 
dw_pcie_host_init(). This ensures that PCIe is active during the PERST# 
sequence and before accessing the DWC registers.

 > And the fact that you are not
> decrementing the runtime usage count means, you want to keep it ON all the time?
> Beware that your system suspend/resume calls would never get executed.

We do not support PM runtime autosuspend, so we must notify PM runtime 
that PCIe is always active. Without invoking pm_runtime_get_noresume(), 
PCIe would mistakenly be marked as suspended.
The function stm32_pcie_suspend_noirq() is triggered when the system 
transitions to Stop or Standby power states, (from /sys/power/state)

> 
> Also in any case, you need to call this before devm_pm_runtime_enable().
> Otherwise, PM core will suspend the parent and enable it during
> pm_runtime_get_noresume(), which is redundant.

OK, I will invert the calls.

Thank you

Christian

> 
> - Mani
> 

