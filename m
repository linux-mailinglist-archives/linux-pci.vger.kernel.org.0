Return-Path: <linux-pci+bounces-18505-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E183F9F3236
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 15:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E8BC167347
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 14:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6976204C09;
	Mon, 16 Dec 2024 14:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="lKQXyxcP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6691F9DA;
	Mon, 16 Dec 2024 14:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734357944; cv=none; b=bkU3hr4Hla/Axol/ENVT3CH1N8Sr9QpilSlXyDh3tKA9FLoUfSFQDgjnfMcIzJsAV055cuo1ZkkfyD+/tLovY0rOh1U7cHD47m0zFQAfC2/mhUO8w1CySXeL26YlT3+zp7AcRp28r7PcGawh2QngQ7S+cl8hdIpdX5vChcE1iAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734357944; c=relaxed/simple;
	bh=pPerfZEbJtBY3ypppTbyVtIx9qnt6U/cYwaJ7K/ilTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IcyQVMmsF4Tv6XLsn7K95sZoWgN6gvkNgbN5oybGiQj6JAUaGVcuGx0ASMb4J8XYJZTuOG1bJphtyyGimP/Su8PQjsNUaiPGA9jX1pRLsYn7hRrkqUMEVZzcNgbFqddvXXP8DK+VYeInqHp+lxDkaSXm8dC/yJqvtyRWC7/RvhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=lKQXyxcP; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGBSXHC019814;
	Mon, 16 Dec 2024 15:03:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	zg4ilhS7TTTXcjH+uIPD/koI66ea2Qpvy0x9hiKQl8Y=; b=lKQXyxcP27EDP2SN
	0Op6pw5jUuTudTT1tjc1Ox1RMd+Bs1nVCHNRFoAibKwrCoxzwXiAvMDKo8RG5zTW
	gSVmLkgZDsS8TwhTT3AXTQD9LVhpZTcwFSmeWlhCqTkTpvF5/omg4n7PSl0WLVPe
	uUVKQBCyxdf46N8npdM9WTXr/rJbFp8SDLwl71zoU/NeJJW1ZG0BU0MK6Ul+NNuq
	KgbNQoimNYQZuRLQbp8Zwv1gzQ8/BSRqrwKBh6x83P0scZoumiYKAus+IJsq8SGq
	KO//wHf0gnLp2zoJdrnuuh4jwZYN5EkuMZjBdnNI42j5M+BgaPbGtwtNlsOomhc1
	F9Ydbg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43jeeyj1h0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 15:03:33 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id F2E9840044;
	Mon, 16 Dec 2024 15:02:07 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 66AB926E55B;
	Mon, 16 Dec 2024 15:01:00 +0100 (CET)
Received: from [10.129.178.212] (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 16 Dec
 2024 15:00:59 +0100
Message-ID: <ef02ddbf-0838-4616-a3c5-ef7ab55de3c9@foss.st.com>
Date: Mon, 16 Dec 2024 15:00:58 +0100
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
>> Add driver to configure the STM32MP25 SoC PCIe Gen2 controller based on the
>> DesignWare PCIe core in endpoint mode.
> 
>> +config PCIE_STM32_EP
>> +	tristate "STMicroelectronics STM32MP25 PCIe Controller (endpoint mode)"
>> +	depends on ARCH_STM32 || COMPILE_TEST
>> +	depends on PCI_ENDPOINT
>> +	select PCIE_DW_EP
>> +	help
>> +	  Enables endpoint support for DesignWare core based PCIe controller in found
>> +	  in STM32MP25 SoC.
> 
> s/in found in/in/ (or "found in" if you prefer)
> 
> Wrap so help text fits in 80 columns when for "make menuconfig".
> 
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

OK thanks for the phrasing. This is inline with the DWC doc:
"... controller completes incoming configuration requests with a
configuration request retry status."
The only thing is that the PCIe specs talks about CRS, not RRS.

so slightly change to
"respond to config requests with Configuration Request Retry Status 
(CRS) until we're prepared to handle them."


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

Agree, this there are 2 conditions in this function: link is up + 
accepting config requests. I'll split or rename

Thanks
Christian
> 
> Bjorn
> 
> [1] https://lore.kernel.org/r/20241112203846.GA1856246@bhelgaas
> 

