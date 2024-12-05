Return-Path: <linux-pci+bounces-17738-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C596B9E5497
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 12:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B2EB285BC3
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 11:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C716521325E;
	Thu,  5 Dec 2024 11:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Joc3kW/F"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEA1213249;
	Thu,  5 Dec 2024 11:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733399502; cv=none; b=c9K9eSZSB937x+1qBULyBVg6HiV2pZTCVMaf6X3ZYVU1zzhjlfN9bhKgFd+CtmKZJvSxQs09edCaxLBaeyy2xpntJwNtjOSABLU5KpfS2i+m9RkVrX6rp1RtCwv9oaUcUaUI+xMvn/EwmoYVUs5T5Wk/SV5sU8tu5PGZbj4wy3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733399502; c=relaxed/simple;
	bh=oWf1oYpaircxbb7ijNv7L4QRWi8/CRKE5AD2tihxiho=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=orOf+9r0+UO0M5nVrzM9K0zmloUVeqxJeX7HVbzKOwGkzarQFWZ2ijEkdglO8JJAkxMbnfNlqWkZrhOIrRLGsrp22IbOL2PUg5/N25f09iPjTVvRbwuKMtStLVHbjooqeBn6PZN62w38SUGvcIbV294gj8G+WfR5fYv5JuAqMH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Joc3kW/F; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5ANMBj026590;
	Thu, 5 Dec 2024 12:50:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	DwOpMaW2es02J1yfBmzoVz6Jv19EkUC2xX3SDPzEuqM=; b=Joc3kW/FpGpozv/F
	49MXK1F3AUIaGDlU0HmQlEy2tYgzNNZdBeXQwaWuNtio/g6MPlb4ftsBGiwKbi8E
	6FL8hx/WN1hSMIBcxw3kOfykVoKfFxh/z9PAHBqKD+qqyA4uYJLW9md83bGqqOlm
	+cqsp8LW61JlT6RSyF/jNRr0cQoh+9TiCv0NYStWxoUYOF5KQOT27dJk8xXfSMHu
	gZnujWyBv9FKpQc8K9QeS4IwlJN7Ctxvb1torK6Y7SesS3Uqox0dODmK4ngz7xuH
	MSsNpC4o4X6lUb4XAD+oxtUGuMDRWhsrjG3aBrUfFK9VUM/51UsdKak7Mw7OyV14
	jtDQsg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 438ehp4gjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 12:50:57 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 907B640044;
	Thu,  5 Dec 2024 12:49:26 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 454DE29BB01;
	Thu,  5 Dec 2024 12:46:38 +0100 (CET)
Received: from [10.129.178.212] (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 5 Dec
 2024 12:46:37 +0100
Message-ID: <9340979e-8f0e-465b-a524-4ff315a9941d@foss.st.com>
Date: Thu, 5 Dec 2024 12:46:29 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christian Bruel <christian.bruel@foss.st.com>
Subject: Re: [PATCH v2 2/5] PCI: stm32: Add PCIe host support for STM32MP25
To: Lucas Stach <l.stach@pengutronix.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC: <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <p.zabel@pengutronix.de>, <cassel@kernel.org>,
        <quic_schintav@quicinc.com>, <fabrice.gasnier@foss.st.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20241129205822.GA2772018@bhelgaas>
 <9ca967aea19d6c28327f3a9bb77e23f6245603e9.camel@pengutronix.de>
Content-Language: en-US
In-Reply-To: <9ca967aea19d6c28327f3a9bb77e23f6245603e9.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hello Bjorn and Lucas,

On 11/29/24 22:18, Lucas Stach wrote:
> Am Freitag, dem 29.11.2024 um 14:58 -0600 schrieb Bjorn Helgaas:
>> [+to Rob, DMA mask question]
>>
>> On Tue, Nov 26, 2024 at 04:51:16PM +0100, Christian Bruel wrote:
>>> Add driver for the STM32MP25 SoC PCIe Gen2 controller based on the
>>> DesignWare PCIe core.
>>
>> Can you include the numeric rate, not just "gen2", so we don't have to
>> search for it?
>>
>>> +static int stm32_pcie_resume_noirq(struct device *dev)
>>> +{
>>> +	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
>>> +	struct dw_pcie *pci = stm32_pcie->pci;
>>> +	struct dw_pcie_rp *pp = &pci->pp;
>>> +	int ret;
>>> +
>>> +	/* init_state must be called first to force clk_req# gpio when no
>>> +	 * device is plugged.
>>> +	 */
>>
>> Use drivers/pci/ conventional comment style:
>>
>>    /*
>>     * text ...
>>     */
>>
>>> +static bool is_stm32_pcie_driver(struct device *dev)
>>> +{
>>> +	/* PCI bridge */
>>> +	dev = get_device(dev);
>>> +
>>> +	/* Platform driver */
>>> +	dev = get_device(dev->parent);
>>> +
>>> +	return (dev->driver == &stm32_pcie_driver.driver);
>>> +}
>>> +
>>> +/*
>>> + * DMA masters can only access the first 4GB of memory space,
>>> + * so we setup the bus DMA limit accordingly.
>>> + */
>>> +static int stm32_dma_limit(struct pci_dev *pdev, void *data)
>>> +{
>>> +	dev_dbg(&pdev->dev, "disabling DMA DAC for device");
>>> +
>>> +	pdev->dev.bus_dma_limit = DMA_BIT_MASK(32);
>>
>> I don't think this is the right way to do this.  Surely there's a way
>> to describe the DMA capability of the bridge once instead of iterating
>> over all the downstream devices?  This quirk can't work for hot-added
>> devices anyway.
>>

agree,

> This should simply be a dma-ranges property in the PCIe host controller
> DT node, which should describe the DMA address range limits for
> transactions passing through the host.

far better indeed, dma-ranges works like a charm

thanks,

> 
> Regards,
> Lucas
> 
>>> +	return 0;
>>> +}
>>> +
>>> +static void quirk_stm32_dma_mask(struct pci_dev *pci)
>>> +{
>>> +	struct pci_dev *root_port;
>>> +
>>> +	root_port = pcie_find_root_port(pci);
>>> +
>>> +	if (root_port && is_stm32_pcie_driver(root_port->dev.parent))
>>> +		pci_walk_bus(pci->bus, stm32_dma_limit, NULL);
>>> +}
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SYNOPSYS, 0x0550, quirk_stm32_dma_mask);
>>
> 

