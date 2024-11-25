Return-Path: <linux-pci+bounces-17284-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD369D8963
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 16:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03653167ED6
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 15:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2AA14E2E8;
	Mon, 25 Nov 2024 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="flm1/MBD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DD217C61;
	Mon, 25 Nov 2024 15:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732548712; cv=none; b=VFgF+j9KM8BjPUTzan3qoXoi80x0gxZahJcG/V/vEtSbqNDX/tkWTYe6U0zGRCt35PhPvVsR5kaEYTfKPX4ISZ/8CIh0iPIfKR2XzL9mMi4xkYDUwUCR/tDOEoIziShjLqMKVU4i1VOQyFFZUBwGDA23tq88NAMG0adM1wSF6/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732548712; c=relaxed/simple;
	bh=n093t7DUeKuwj7a+ks7cWRK0o0kCcn3/Fu9MwnngsPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=obOmqvi8Tu2Y7qPhUfGuauqNLwimeAk8OCMYKFC4nbHDa55yIV2QZ8uM00d+6Chlz1Pb5UTA+vIDG0+nq9qiaPDyhFrAybvVyyToNyZ0PkjnGlUjAnT26u9ZMi5A4iD9ZN8clPgtlAKFUkz+ygRKdPZdeezowJdOAYYf0s91fE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=flm1/MBD; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APBRKnZ016452;
	Mon, 25 Nov 2024 16:31:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	YP8a99fDyJG955EP8lVaVAT87+zHSjvQosHEPzJ1NsY=; b=flm1/MBDqwkwMUbJ
	QkssTzezfgqvUcF9/eYZKX70ziMyBSdOyfn7eV/U/3uxdVEhXMwPHLtyjsvAMNLL
	VvCJP0a3eW+PYTjnoCA/PlnHMuyOlMqh92MHd46ef45gfbbPtnzTrHpGEG9usJgV
	XCGeJnB5sF30r0YCz8LfCRdWCOFEBKhTyHGWMbqMY0JaqIzwgYfWUrv7w4+BTRTj
	FMn2RgaPaoETXbu+Ni2zZqS5H9islnjiEhmMt76+bQKxXYptQV6Gqz0zGzlYxcKH
	Trf9z/SbP7KbUUf91ZTCl4yMZJQ+hZfLp8jjp3mExq7k4aiJd95FYE2K1o5DN6ZW
	rmJf1A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 433tvndppw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 16:31:22 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E1E2940047;
	Mon, 25 Nov 2024 16:29:56 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 43FAA2A1043;
	Mon, 25 Nov 2024 16:28:47 +0100 (CET)
Received: from [10.129.178.212] (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 25 Nov
 2024 16:28:46 +0100
Message-ID: <acf6834f-6851-4daf-85da-076e6ca142db@foss.st.com>
Date: Mon, 25 Nov 2024 16:28:45 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] PCI: stm32: Add PCIe endpoint support for STM32MP25
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <p.zabel@pengutronix.de>, <cassel@kernel.org>,
        <quic_schintav@quicinc.com>, <fabrice.gasnier@foss.st.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20241112203846.GA1856246@bhelgaas>
Content-Language: en-US
From: Christian Bruel <christian.bruel@foss.st.com>
In-Reply-To: <20241112203846.GA1856246@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01



On 11/12/24 21:38, Bjorn Helgaas wrote:
> On Tue, Nov 12, 2024 at 05:19:24PM +0100, Christian Bruel wrote:
>> Add driver to configure the STM32MP25 SoC PCIe Gen2 controller based on the
>> DesignWare PCIe core in endpoint mode.
>> Uses the common reference clock provided by the host.
> 
>> +++ b/drivers/pci/controller/dwc/Kconfig
> 
>> +config PCIE_STM32_EP
>> +	tristate "STMicroelectronics STM32MP25 PCIe Controller (endpoint mode)"
>> +	depends on ARCH_STM32 || COMPILE_TEST
>> +	depends on PCI_ENDPOINT
>> +	select PCIE_DW_EP
>> +	help
>> +	  Enables endpoint support for DesignWare core based PCIe controller in found
>> +	  in STM32MP25 SoC.
>> +
>> +	  This driver can also be built as a module. If so, the module
>> +	  will be called pcie-stm32-ep.
> 
> Move as for the host mode entry.
> 
>> +++ b/drivers/pci/controller/dwc/pcie-stm32-ep.c
> 
>> +static const struct of_device_id stm32_pcie_ep_of_match[] = {
>> +	{ .compatible = "st,stm32mp25-pcie-ep" },
>> +	{},
>> +};
> 
> Move next to stm32_pcie_ep_driver.
> 
>> +static void stm32_pcie_ep_init(struct dw_pcie_ep *ep)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>> +	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
>> +	enum pci_barno bar;
>> +
>> +	for (bar = BAR_0; bar <= PCI_STD_NUM_BARS; bar++)
> 
> Most users just use "bar = 0".  BAR_0 is 0, but there's no real
> connection with PCI_STD_NUM_BARS, so I think 0 is probably better.
> 
> Looks like this should be "bar < PCI_STD_NUM_BARS"?

oops, thanks

> 
>> +		dw_pcie_ep_reset_bar(pci, bar);
>> +
>> +	/* Defer Completion Requests until link started */
> 
> Not sure what a Completion Request is.  Is this some internal STM or
> DWC thing?  Or is this related to Request Retry Status completions for
> config requests?

this is sysconf bit maps to the app_req_retry_en Synopsys controller 
signal. "When app_req_retry_en is asserted, the controller completes 
incoming configuration requess with a CRS"

> 
>> +	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
>> +			   STM32MP25_PCIECR_REQ_RETRY_EN,
>> +			   STM32MP25_PCIECR_REQ_RETRY_EN);
>> +}
> 
>> +static int stm32_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>> +				unsigned int type, u16 interrupt_num)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>> +
>> +	switch (type) {
>> +	case PCI_IRQ_INTX:
>> +		return dw_pcie_ep_raise_intx_irq(ep, func_no);
>> +	case PCI_IRQ_MSI:
>> +		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
>> +	default:
>> +		dev_err(pci->dev, "UNKNOWN IRQ type\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
> 
> Is the compiler not smart enough to notice that this is unreachable?
> 
>> +static void stm32_pcie_perst_deassert(struct dw_pcie *pci)
>> +{
>> +	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
>> +	struct device *dev = pci->dev;
>> +	struct dw_pcie_ep *ep = &pci->ep;
>> +	int ret;
>> +
>> +	if (stm32_pcie->link_status == STM32_PCIE_EP_LINK_ENABLED) {
>> +		dev_dbg(pci->dev, "Link is already enabled\n");
>> +		return;
>> +	}
>> +
>> +	dev_dbg(dev, "PERST de-asserted by host. Starting link training\n");
>> +
>> +	ret = pm_runtime_resume_and_get(dev);
>> +	if (ret < 0) {
>> +		dev_err(dev, "pm runtime resume failed: %d\n", ret);
>> +		return;
>> +	}
>> +
>> +	ret = stm32_pcie_enable_resources(stm32_pcie);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to enable resources: %d\n", ret);
>> +		pm_runtime_put_sync(dev);
>> +		return;
>> +	}
>> +
>> +	ret = dw_pcie_ep_init_registers(ep);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to complete initialization: %d\n", ret);
>> +		stm32_pcie_disable_resources(stm32_pcie);
>> +		pm_runtime_put_sync(dev);
>> +		return;
>> +	}
>> +
>> +	pci_epc_init_notify(ep->epc);
>> +
>> +	ret = stm32_pcie_enable_link(pci);
>> +	if (ret) {
>> +		dev_err(dev, "PCIe Cannot establish link: %d\n", ret);
>> +		stm32_pcie_disable_resources(stm32_pcie);
>> +		pm_runtime_put_sync(dev);
>> +		return;
>> +	}
>> +
>> +	stm32_pcie->link_status = STM32_PCIE_EP_LINK_ENABLED;
>> +}
> 
>> +static int stm32_add_pcie_ep(struct stm32_pcie *stm32_pcie,
>> +			     struct platform_device *pdev)
>> +{
>> +	struct dw_pcie *pci = stm32_pcie->pci;
>> +	struct dw_pcie_ep *ep = &pci->ep;
>> +	struct device *dev = &pdev->dev;
>> +	int ret;
>> +
>> +	ret = regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
>> +				 STM32MP25_PCIECR_TYPE_MASK,
>> +				 STM32MP25_PCIECR_EP);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = pm_runtime_resume_and_get(dev);
>> +	if (ret < 0) {
>> +		dev_err(dev, "pm runtime resume failed: %d\n", ret);
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
>> +		pm_runtime_put_sync(dev);
>> +		return ret;
>> +	}
>> +
>> +	ret = stm32_pcie_enable_resources(stm32_pcie);
>> +	if (ret) {
>> +		dev_err(dev, "failed to enable resources: %d\n", ret);
>> +		dw_pcie_ep_deinit(ep);
>> +		pm_runtime_put_sync(dev);
>> +		return ret;
>> +	}
>> +
>> +	ret = dw_pcie_ep_init_registers(ep);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to initialize DWC endpoint registers\n");
>> +		stm32_pcie_disable_resources(stm32_pcie);
>> +		dw_pcie_ep_deinit(ep);
>> +		pm_runtime_put_sync(dev);
>> +		return ret;
>> +	}
> 
> Consider gotos for the error cases with a cleanup block at the end.
> There's a fair bit of repetition there as more things get initialized,
> and it's error-prone to extend this in the future.
> 
> Same applies in stm32_pcie_perst_deassert().
> 
>> +	pci_epc_init_notify(ep->epc);
>> +
>> +	return 0;
>> +}
>> +
>> +static int stm32_pcie_probe(struct platform_device *pdev)
>> +{
>> +	struct stm32_pcie *stm32_pcie;
>> +	struct dw_pcie *dw;
>> +	struct device *dev = &pdev->dev;
>> +	int ret;
>> +
>> +	stm32_pcie = devm_kzalloc(dev, sizeof(*stm32_pcie), GFP_KERNEL);
>> +	if (!stm32_pcie)
>> +		return -ENOMEM;
>> +
>> +	dw = devm_kzalloc(dev, sizeof(*dw), GFP_KERNEL);
>> +	if (!dw)
>> +		return -ENOMEM;
> 
> Add blank line here.
> 
>> +	stm32_pcie->pci = dw;
> 
>> +static struct platform_driver stm32_pcie_ep_driver = {
>> +	.probe = stm32_pcie_probe,
>> +	.remove_new = stm32_pcie_remove,
> 
> .remove().
> 
>> +	.driver = {
>> +		.name = "stm32-ep-pcie",
>> +		.of_match_table = stm32_pcie_ep_of_match,
>> +	},
>> +};

