Return-Path: <linux-pci+bounces-33737-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 062CBB20A40
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 15:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBE25423664
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 13:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A80F2BDC38;
	Mon, 11 Aug 2025 13:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Zv4kHUCX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D46149C41;
	Mon, 11 Aug 2025 13:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754919201; cv=none; b=HIilbBZQTEHFgmy8ss/xHxMJsJMi85s68lvAECQyH0SjDPswI2lQSg6XblPuabdXf92ebQA5xUt8OVPsKftskZaql2gGRdJF1rW4dBfUC3ZF0Q4RMwQI6tPxMGIEm9aOzU7OnJ6j8RJmaAC2fSmhjG8fAFHsHt0BHIT8hHUpco8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754919201; c=relaxed/simple;
	bh=x2Z43D2zhojMQgM06ThDtCQhqvpuE3g3VjKgoKe5c+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kYrFGFUnngLbhlyI2rINWU11bKyN1T5+U59yzCQpOCw/tjkf4tg85rxae9oMpNSw2xXP3nAIgOLvBxfLj6zdKoaBFFKQisAlPnTB6g76NHDlIuukk4Zy4SMNH8avQW1gkb+pCD5yfmUxU30W4MIAjxEqAXQzJfpy30RD4pghyQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Zv4kHUCX; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BDNkl9025158;
	Mon, 11 Aug 2025 15:32:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	aywYyzoixAm3Sjd8epTOZToUh9Gg+kyh1HfqY33n5bw=; b=Zv4kHUCXcILUQIx5
	iF4WiJiPI9HHvmA+T3RoIcBguAuS3C3kJDOPnxHM0kLu4l/+9SwtqS4cV6SWc5UI
	wU25e4iXd6rhFt8jyReReMhjqGC3POpMn3Fsvn19vgxAyo5jU/cF5q6co8GkTBAi
	Y6ZkpKmwjsMMOAufHn1POVfQotIT9MsYheaNWLEwgf03SC9ZweA5EIPWXG57iv43
	4NsH6+qCCE4kbtBLzwSxUc6wYRfBjVsj4PvD9iEtZhEol8L2Nv878LY6uMrUDmjR
	o4uMnnnj6GuP8q+wSo0cNWkJQunTzuuQGx8Gf2Yoq7qBpxK+gD4WWO6kpG+ueWv3
	ajQglg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48dw7g65xf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 15:32:49 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 036A340044;
	Mon, 11 Aug 2025 15:31:19 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0BA2474D375;
	Mon, 11 Aug 2025 15:30:11 +0200 (CEST)
Received: from [10.130.77.120] (10.130.77.120) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 15:30:10 +0200
Message-ID: <2c497e75-bdb7-45ee-96ba-e293e33db91b@foss.st.com>
Date: Mon, 11 Aug 2025 15:30:08 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/9] PCI: stm32: Add PCIe host support for STM32MP25
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Linus Walleij <linus.walleij@linaro.org>, <lpieralisi@kernel.org>,
        <kwilczynski@kernel.org>, <mani@kernel.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <p.zabel@pengutronix.de>, <johan+linaro@kernel.org>,
        <cassel@kernel.org>, <shradha.t@samsung.com>,
        <thippeswamy.havalige@amd.com>, <quic_schintav@quicinc.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250808164527.GA92564@bhelgaas>
From: Christian Bruel <christian.bruel@foss.st.com>
Content-Language: en-US
In-Reply-To: <20250808164527.GA92564@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_02,2025-08-11_01,2025-03-28_01



On 8/8/25 18:45, Bjorn Helgaas wrote:
> On Fri, Aug 08, 2025 at 04:55:52PM +0200, Christian Bruel wrote:
>> On 8/7/25 20:09, Bjorn Helgaas wrote:
>>> [+to Linus for pinctrl usage question below]
>>>
>>> On Tue, Jun 10, 2025 at 11:07:07AM +0200, Christian Bruel wrote:
>>>> Add driver for the STM32MP25 SoC PCIe Gen1 2.5 GT/s and Gen2 5GT/s
>>>> controller based on the DesignWare PCIe core.
> 
>>>> +	return pinctrl_pm_select_sleep_state(dev);
>>>
>>> Isn't there some setup required before we can use
>>> pinctrl_select_state(), pinctrl_pm_select_sleep_state(),
>>> pinctrl_pm_select_default_state(), etc?
>>>
>>> I expected something like devm_pinctrl_get() in the .probe() path, but
>>> I don't see anything.  I don't know how pinctrl works, but I don't see
>>> how dev->pins gets set up.
>>
>> Linus knows better, but the dev->pins states are attached to the dev struct
>> before probe by the pinctrl driver
>>
>> /**
>>   * pinctrl_bind_pins() - called by the device core before probe
>>   * @dev: the device that is just about to probe
>>   */
>> int pinctrl_bind_pins(struct device *dev)
> 
> Thanks for the pointer.  Might be worthy of a mention in
> Documentation/driver-api/pin-control.rst.  Maybe pinctrl/consumer.h
> could even have a bread crumb to that effect since drivers use all
> those interfaces that rely in the implicit initialization done before
> their .probe().
> 
> pin-control.rst mentions pinctrl_get_select_default() being called
> just before the driver probe, but that's now unused and it looks like
> pinctrl_bind_pins() does something similar:
> 
>    really_probe
>      pinctrl_bind_pins
>        dev->pins = devm_kzalloc()
>        devm_pinctrl_get
>        pinctrl_lookup_state(PINCTRL_STATE_DEFAULT)
>        pinctrl_lookup_state(PINCTRL_STATE_INIT)
>        pinctrl_select_state(init)      # if present, else default
>      call_driver_probe

Yeah, and state_init is not mentioned in the documentation even for the 
'normal probe'. The only doc I see from the original commit 
ef0eebc05130b0d22b0ea65c0cd014ee16fc89c7

" 

     Let's introudce a new "init" state.  If this is defined we'll set
     pinctrl to this state before probe and then "default" after probe
     (unless the driver explicitly changed states already). 

"

I will propose something in pin-control.rst, with maybe some code-block 
for the pm part and respin [PATCH 0/2] Add pinctrl_pm_select_init_state 
helper function...

Christian

> 
> Bjorn


