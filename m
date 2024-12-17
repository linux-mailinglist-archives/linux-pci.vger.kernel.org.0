Return-Path: <linux-pci+bounces-18587-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE019F4802
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 10:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3CFE188149C
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 09:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75921DDA17;
	Tue, 17 Dec 2024 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="2dlRNTOI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEFB12C80C;
	Tue, 17 Dec 2024 09:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734429116; cv=none; b=FBxPN1RT7G/lp9J6YpEAX78WOQKKzMu9traQI3jiEjYnNDieM3LM/M9Y4cPVGfBTxHSBfGFBKLqK9CSy0y1L25QmhTxBGN2VTTkRj4M1IQZ7gtuSEtni7WHk8g6UIPDV0fZBSF7YE6TeaV96df9i7wR3pWgegBBcmxN4Hym3aa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734429116; c=relaxed/simple;
	bh=ElpTi4cuh+T5xn3wOjzUjUknPTtMQH5zLyy757usTcY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=jJcCAZrXBW92pVNTH8MjKau+H6JhgbqqGuf6eXL5NqdJ8e+s9mgP6YaFcD/LngEyucex+0L4wC7okeTI4L5NDGnfsBVw+yZx23ZUIgeqJgtJtbaSbGXDpEr4PGyZ5aLT1WpODpUEJSqsePEtXJjkJbTPbYReY3ooeo33dtANLhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=2dlRNTOI; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH88B5q032037;
	Tue, 17 Dec 2024 10:51:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	oUC8C14nmQz9b0qpzY68JcxUFhr9uFuo+BsqJHz+Y0A=; b=2dlRNTOIZQmNVA3D
	37LZPO4YILCvvRaKRsS450lvas7bZUDWMzfnNwDgFDwMQh/LnStZDLrPLR2bR5oX
	tMcOojYwHlbjTeIIiIACkQAvjCEXTGFejvCw8QZvbxOlrLbN5c1mrt1kZ2UsINd6
	n5xwiM0PkZu/YPNOKwKPJxECH9l2U/ZDim5fA+AAtAAGNW+qWvJ0EvKf2t+mbDk1
	LKmOm87sfwRLqrKvCFR/H0nEGTxkE68rcG9FpWX059K4schTdZFEFDKs68wjvGp3
	mN4n3Y5hOq8tRu4SNTyPBqfLeWAob7ovSDEww+a4Wo9iPgnfxcu+7orYTXETHmj6
	WR+XMw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43k5h9gg7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 10:51:13 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6769C4004A;
	Tue, 17 Dec 2024 10:49:48 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BBB7425E64B;
	Tue, 17 Dec 2024 10:48:45 +0100 (CET)
Received: from [10.129.178.212] (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 17 Dec
 2024 10:48:44 +0100
Message-ID: <fdc487c4-cbdc-45ac-a79f-aff2b8ccafcc@foss.st.com>
Date: Tue, 17 Dec 2024 10:48:43 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christian Bruel <christian.bruel@foss.st.com>
Subject: Re: [PATCH v2 4/5] PCI: stm32: Add PCIe endpoint support for
 STM32MP25
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
 <20241126155119.1574564-5-christian.bruel@foss.st.com>
 <20241203152230.5mdrt27u5u5ecwcz@thinkpad>
 <4e257489-4d90-4e47-a4d9-a2444627c356@foss.st.com>
 <20241216161700.dtldi7fari6kafrr@thinkpad>
Content-Language: en-US
In-Reply-To: <20241216161700.dtldi7fari6kafrr@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01



On 12/16/24 17:17, Manivannan Sadhasivam wrote:
> On Mon, Dec 16, 2024 at 11:02:07AM +0100, Christian Bruel wrote:
>> Hi Manivanna,
>>
>> On 12/3/24 16:22, Manivannan Sadhasivam wrote:
>>> On Tue, Nov 26, 2024 at 04:51:18PM +0100, Christian Bruel wrote:
>>>
>>> [...]
>>>
>>>> +static int stm32_pcie_start_link(struct dw_pcie *pci)
>>>> +{
>>>> +	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
>>>> +	int ret;
>>>> +
>>>> +	if (stm32_pcie->link_status == STM32_PCIE_EP_LINK_ENABLED) {
>>>> +		dev_dbg(pci->dev, "Link is already enabled\n");
>>>> +		return 0;
>>>> +	}
>>>> +
>>>> +	ret = stm32_pcie_enable_link(pci);
>>>> +	if (ret) {
>>>> +		dev_err(pci->dev, "PCIe cannot establish link: %d\n", ret);
>>>> +		return ret;
>>>> +	}
>>>
>>> How the REFCLK is supplied to the endpoint? From host or generated locally?
>>
>>  From Host only, we don't support the separated clock model.
>>
> 
> OK. So even without refclk you are still able to access the controller
> registers? So the controller CSRs should be accessible by separate local clock I
> believe.
> 
> Anyhow, please add this limitation (refclk dependency from host) in commit
> message.
> 
> [...]
> 
>>>> +	ret = phy_set_mode(stm32_pcie->phy, PHY_MODE_PCIE);
>>>
>>> Hmm, so PHY mode is common for both endpoint and host?
>>
>> Yes it is. We need to init the phy here because it is a clock source for the
>> PCIe core clk
>>
> 
> Clock source? Is it coming directly to PCIe or through RCC? There is no direct
> clock representation from PHY to PCIe in DT binding.

The core_clk is generated directly by the PLL in the COMBOPHY, gated by 
the RCC

> 
> - Mani
> 

