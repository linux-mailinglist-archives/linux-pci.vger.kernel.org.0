Return-Path: <linux-pci+bounces-19730-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4835DA1065A
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 13:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04FFA3A843B
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 12:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8E3236ED6;
	Tue, 14 Jan 2025 12:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="kIy0G59J"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C23236EB3;
	Tue, 14 Jan 2025 12:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736856864; cv=none; b=O/dbSDvbic1s/WC9b51cvOH0srZK9LV9iV62nMgeQtFBCAi6gkma6u7w04sgNbN6oBgWd58QZJPzEL7SPWY1XMF+HYzaJJZ+v5ATJPgiJIvpmO2Tlb+nfdPIlycpF3j4bVkWhSKrIYX9He5KGbXw/VtDqJx6RFWuEQGKti8ACos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736856864; c=relaxed/simple;
	bh=nkEZI+Mih7ssNn9jD9GJ6XhtAwIBP7qJkakJUVsoFB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BVdPubP6CYU2W8cdFwfz2iWQfZwQS19dUEknZ3pkFavyxSXcxk3uka4EbnNUnzBCEIUaln4bAhzQp5+aKVBob7NDuapDYY12ZJwMHZmAX9w1qLoHZ5W+P+WP0Ir2OW1u0bRPFZ/CISPbNwaN65IIUBgVsZGEJvIk9JT30Y2KwvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=kIy0G59J; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EALNs7026707;
	Tue, 14 Jan 2025 13:13:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	xl+nX529n8UyoO0y0l/TMia7BBc8N084qojjlS7Yf84=; b=kIy0G59JVkFMnw7y
	y783Or0jfu3+ENUvpX4ZGBPs66MxleRo9U0jfvLstvaBmEGHenA2oG8c7jj7fTAi
	0K/Nw8RWP58CA/1V+Uu1eJUSrBiFP2crZX84D64zBKKKq2putS+7vsQ7bJ1n4QSB
	pkvI9VRlwMoZIRAO27TdmxNEnPNIcgJlqsilw2inz2TdtvhDAEjvtcpYeYBmMI93
	ghLl8CGSwnrwQkmlyU8y1UwP7HTIvQoRYTufbPewdJ+71J8GzoaYLROmBuvC5Jf+
	GuBD1vOM6gIJM9Cu9tAbyzPD6KD8AoJaYl5O8GLrNYMkmrVAn5/19OgabbMNz0T8
	ZL0ldw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 445p3p0fjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 13:13:39 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A420B40045;
	Tue, 14 Jan 2025 13:12:12 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 44211298E15;
	Tue, 14 Jan 2025 13:10:54 +0100 (CET)
Received: from [10.129.178.212] (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Jan
 2025 13:10:53 +0100
Message-ID: <092f5cd4-ff29-4a70-82ca-6044a72d5f11@foss.st.com>
Date: Tue, 14 Jan 2025 13:10:52 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] PCI: stm32: Add PCIe endpoint support for
 STM32MP25
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
References: <20241205172738.GA3054352@bhelgaas>
Content-Language: en-US
From: Christian Bruel <christian.bruel@foss.st.com>
In-Reply-To: <20241205172738.GA3054352@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01



On 12/5/24 18:27, Bjorn Helgaas wrote:
> On Tue, Nov 26, 2024 at 04:51:18PM +0100, Christian Bruel wrote:

>> +static void stm32_pcie_ep_init(struct dw_pcie_ep *ep)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>> +	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
>> +	enum pci_barno bar;
>> +
>> +	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
>> +		dw_pcie_ep_reset_bar(pci, bar);
>> +
>> +	/* Defer Completion Requests until link started */
> 
> I asked about this before [1] but didn't finish the conversation.  My
> main point is that I think "Completion Request" is a misnomer.
> There's a "Configuration Request" and a "Completion," but no such
> thing as a "Completion Request."
> 
> Based on your previous response, I think this should say something
> like "respond to config requests with Request Retry Status (RRS) until
> we're prepared to handle them."
> 
>> +	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
>> +			   STM32MP25_PCIECR_REQ_RETRY_EN,
>> +			   STM32MP25_PCIECR_REQ_RETRY_EN);
>> +}
>> +
>> +static int stm32_pcie_enable_link(struct dw_pcie *pci)
>> +{
>> +	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
>> +	int ret;
>> +
>> +	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
>> +			   STM32MP25_PCIECR_LTSSM_EN,
>> +			   STM32MP25_PCIECR_LTSSM_EN);
>> +
>> +	ret = dw_pcie_wait_for_link(pci);
>> +	if (ret)
>> +		return ret;
>> +
>> +	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
>> +			   STM32MP25_PCIECR_REQ_RETRY_EN,
>> +			   0);
> 
> And I assume this means the endpoint will accept config requests and
> handle them normally instead of responding with RRS.
> 
> Strictly speaking this is a different condition than "the link is up"
> because the link must be up in order to even receive a config request.
> The purpose of RRS is for devices that need more initialization time
> after the link is up before they can respond to config requests.
> 
> The fact that the hardware provides this bit makes me think the
> designer anticipated that the link might come up before the rest of
> the device is fully initialized.

You are correct and I am unable to reproduce a scenario where this is 
still required.

Upon reviewing the history, I initially implemented this to address a 
dependency issue in the original code, where enable_link was invoked 
prematurely following the deassertion of PERST, as soon as the host was 
ready but before the device configuration space was initialized, so host 
enumeration was wrong.

Since then, the perst_irq is enabled by start_link. Consequently, the 
initialization, enable_link, and enumeration sequence is now correct

This bit is useless and can be dropped

Thank you for identifying it.

Christian

> 
> Bjorn
> 
> [1] https://lore.kernel.org/r/20241112203846.GA1856246@bhelgaas
> 

