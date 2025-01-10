Return-Path: <linux-pci+bounces-19636-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7711A095D6
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 16:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D803116AF82
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 15:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC64220FAB5;
	Fri, 10 Jan 2025 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="VKOOHwJa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A2D1DA3D;
	Fri, 10 Jan 2025 15:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736523429; cv=none; b=lDf3v5REZdamiLbSt68G+Uf42ifxlc91Aw5swlKP7suKCkSmqJcztJSqyA2Za/q0/BngLfGXamoHFOs1fmkHj/6rDhchjiUxGz28iUtlpPTEZCs3/GFJMPx5iOYkUpFop6N/Ek5kLLiLPFCe5acziIsArKSY5fPmb0hArE9ARwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736523429; c=relaxed/simple;
	bh=n4tdxyCF3JYvVTJ8ok+wFQDptiJ3aQFnTaM4GSLNOBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eHsIXPqDHKSuk3xW1L/HggulVuNXionyIW7RnU9+CRfVPGn578/KdYtLD8Y1kaLHgogh0hxQQU8wgQzC25a44nwSyXTIYH289yKkwBcWoGhgLI9mqpVArQsrRFkBwPY0OToGfkzAT3aRoGelnqlDA1R0Hn7Ok7IUgaL5AQSq6UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=VKOOHwJa; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50ABpdGv019917;
	Fri, 10 Jan 2025 16:36:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	c/Qxz5rQoH3z73VG+7QliAVS43rJ+oVZjv3N8LtNERY=; b=VKOOHwJaVzU8zyc3
	Uk9mCiTKiBn1qwVaMlM4DE41fylBp7Puq5fLrwLYv8Y1j4qfDi8bCNLq/F6b7Axu
	hJsSgAEs5FaNiK7HnvLIuwGn0NP+hwJgk7ZxgL+rxy5uYLbEDeQoT2YYzWLgNtko
	S4ECUMMopB0lUXNyAl2QBvB5mRZyGID237XbR7xFGEbrHWVBz362SkNVhj6fMzaE
	eC1bt81A0XlHltOab7UVE9HmRGeCACRfUtCva8nLiZdo7PkWcsbKX2xBi8e1VAPA
	cr3CiQ2XLg/jj+87txfqVvfYjkqAETA2ZE46FAH4moL0GpTKOgrn9PzzNUwdyxwf
	WtKY7g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44331t8vb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 16:36:20 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id EB3CC40092;
	Fri, 10 Jan 2025 16:34:55 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AF63C2954B8;
	Fri, 10 Jan 2025 16:33:12 +0100 (CET)
Received: from [10.129.178.212] (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 10 Jan
 2025 16:33:12 +0100
Message-ID: <96492d7e-8039-43be-9f63-eff81083f790@foss.st.com>
Date: Fri, 10 Jan 2025 16:33:05 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
From: Christian Bruel <christian.bruel@foss.st.com>
In-Reply-To: <20241216161700.dtldi7fari6kafrr@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
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

We have the following simplified clock dependencies (details in the RM)

                                 _____________
RCC  ck_icn_pcie--- ------------|-> dbi_clk  |
                     _________   |            |
      ck_icn_phy ---|->       |  |            |
                    |  pipe0--|--|->core_clk  |
      ck_ker ----- -|->       |  |            |
                    |         |  |            |
      100mhz pad ---|-> pll   |  |            |
                    |_________|  |____________|
                      COMBOPHY      PCIE


I considered adding the COMBOPHY pipe0 as the clock provider for the 
PCIe core_clk, but this did not provide any advantage since the PLL 
needs to be locked first and all settings need to be completed. 
Therefore, using clock_prepare_enable(pipe0) would be redundant with 
what phy_init already accomplishes. The phy_init function is necessary 
because it is used by the USB3 driver.

Since the core_clk is operational when all three other clocks are 
enabled and the PLL is locked, modeling pipe0 had minimal value, 
especially considering the dependencies of the USB3 driver.

I will add a comment in the code to explain this.

> 
> - Mani
> 

