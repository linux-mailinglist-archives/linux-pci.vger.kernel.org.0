Return-Path: <linux-pci+bounces-35047-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5793B3AA4C
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 20:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B4E173B62
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 18:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470BD322C99;
	Thu, 28 Aug 2025 18:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="7PhGVjWo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4B830F52A;
	Thu, 28 Aug 2025 18:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756407037; cv=none; b=LkYJ9TCa/iMJigQz4gKZp6PUy2XgCb24rtxlRL68CB75mE/YfyS4fS0NRpwZz59zQO8dn4G/TLs1X8xnpaPWbp9HOZlW545B37QN+iRo203zi/OWiWwP0CewOE2Ce/lzYzNddsA/yjSiK1ybM5oz/598DvA0nyZbzB9OWXxIbEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756407037; c=relaxed/simple;
	bh=rDPt11hUyYEKYzRsksxc2au3/QreRdUJKeYIrv01Z1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OQbhIZC0oJthhb9OWN6QVrP5a+EPi8wU9UzrDWESSPcrpaeaC/kIdhL7717JDDUgoAJTogf20e81HrBRB6f4PW3xsXnmatFVP9Dl9EEjGJ3yMevx35k+NrqgD7yYilZmLXTnmtLBxLdmkl1VFg+6IBxT3Hu5NhDfm0kfivChruw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=7PhGVjWo; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SGK1Q6000314;
	Thu, 28 Aug 2025 20:49:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	QngEIke0AHC8FxDBE5xQKqvSi6Ne/Qs63SuZOpgs9rU=; b=7PhGVjWors7Len+8
	8boKa4Mku8xTRTVBQIwPckTq5qP62dkbDckuIoWUjJwRBQVkDO/NCvZ/Xd0f0lAc
	qlMzdA0j+8xixjOEBDzfNE/bMlhcC43lIyqxbxLuD0mDYI/P53pBKDim9k2ond7K
	DDEnnnkNsHh8ul7tnHtQkcbAN98RKbHDJ2kr7mEAZfVmQZDlc/Lhzv/v5bB+XRpC
	4RVE5sqxff1+wnAQ9BtratCEwvItq0kJIPBIj1U+we+otSG3PWul6RlLRfkKN5kk
	EZ2IBrk3RwkwnBuzL7MQ2Kt7kXS5AgcdWUIsu+Xd7OBNOZQ/yFhTSOIBk3mYIzUJ
	DfW2Ag==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48q5xbwhff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 20:49:56 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D36834004B;
	Thu, 28 Aug 2025 20:48:10 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E170277A5A4;
	Thu, 28 Aug 2025 20:46:34 +0200 (CEST)
Received: from [10.130.77.120] (10.130.77.120) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 20:46:33 +0200
Message-ID: <3a0afc93-a7ae-467e-97ad-f1c8d7d7a693@foss.st.com>
Date: Thu, 28 Aug 2025 20:46:30 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 06/11] PCI: stm32: Add PCIe Endpoint support for
 STM32MP25
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>, <linus.walleij@linaro.org>,
        <corbet@lwn.net>, <p.zabel@pengutronix.de>, <shradha.t@samsung.com>,
        <mayank.rana@oss.qualcomm.com>, <namcao@linutronix.de>,
        <qiang.yu@oss.qualcomm.com>, <thippeswamy.havalige@amd.com>,
        <inochiama@gmail.com>, <quic_schintav@quicinc.com>,
        <johan+linaro@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>
References: <20250828171622.GA945192@bhelgaas>
From: Christian Bruel <christian.bruel@foss.st.com>
Content-Language: en-US
In-Reply-To: <20250828171622.GA945192@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01



On 8/28/25 19:16, Bjorn Helgaas wrote:
> On Thu, Aug 28, 2025 at 02:12:57PM +0200, Christian Bruel wrote:
>> On 8/27/25 20:58, Bjorn Helgaas wrote:
>>> On Wed, Aug 20, 2025 at 09:54:06AM +0200, Christian Bruel wrote:
>>>> Add driver to configure the STM32MP25 SoC PCIe Gen1 2.5GT/s or Gen2 5GT/s
>>>> controller based on the DesignWare PCIe core in endpoint mode.
>>>
>>>> +static void stm32_pcie_perst_deassert(struct dw_pcie *pci)
>>>> +{
>>>> +	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
>>>> +	struct device *dev = pci->dev;
>>>> +	struct dw_pcie_ep *ep = &pci->ep;
>>>> +	int ret;
>>>> +
>>>> +	dev_dbg(dev, "PERST de-asserted by host\n");
>>>> +
>>>> +	ret = pm_runtime_resume_and_get(dev);
>>>> +	if (ret < 0) {
>>>> +		dev_err(dev, "Failed to resume runtime PM: %d\n", ret);
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	ret = stm32_pcie_enable_resources(stm32_pcie);
>>>> +	if (ret) {
>>>> +		dev_err(dev, "Failed to enable resources: %d\n", ret);
>>>> +		goto err_pm_put_sync;
>>>> +	}
>>>> +
>>>> +	/*
>>>> +	 * Need to reprogram the configuration space registers here because the
>>>> +	 * DBI registers were incorrectly reset by the PHY RCC during phy_init().
>>>
>>> Is this incorrect reset of DBI registers a software issue or some kind
>>> of hardware erratum that might be fixed someday?  Or maybe it's just a
>>> characteristic of the hardware and thus not really "incorrect"?
>>>
>>> I do see that qcom_pcie_perst_deassert() in pcie-qcom-ep.c also calls
>>> dw_pcie_ep_init_registers() in the qcom_pcie_ep_perst_irq_thread()
>>> path.
>>>
>>> So does pex_ep_event_pex_rst_deassert() (pcie-tegra194.c) in the
>>> tegra_pcie_ep_pex_rst_irq() path.
>>>
>>> But as far as I can tell, none of the other dwc drivers need this, so
>>> maybe it's something to do with the glue around the DWC core?
>>
>> The RCC PHY reset is connected to the Synopsys cold reset logic, which
>> explains why the registers need to be restored. This point has been
>> addressed in the reference manual.
> 
> OK.  I dropped "incorrectly" from the comment because I think future
> readers will wonder about whether or how this could be fixed, and it
> sounds like it's just a feature of the hardware that we need to deal
> with.

OK, thank you. "unexpectedly" would have been appropriate, but just drop 
it is even better.

> 
>>>> +	 */
>>>> +	ret = dw_pcie_ep_init_registers(ep);
>>>> +	if (ret) {
>>>> +		dev_err(dev, "Failed to complete initialization: %d\n", ret);
>>>> +		goto err_disable_resources;
>>>> +	}
>>


