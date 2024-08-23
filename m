Return-Path: <linux-pci+bounces-12075-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B9B95C8CA
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 11:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE69428314F
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 09:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD028149C79;
	Fri, 23 Aug 2024 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VE0Q1rfe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC88E1442F4;
	Fri, 23 Aug 2024 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724403996; cv=none; b=Fy0ANJpqTZN1T2cuvz7+yEljMEZSdE7oaoYqKmikmi1pfFn86JctOWg6VJuUmyYkvIsKKPGNMO8NRj54tmPJYfRIlRiXI9U7r3JRzKM+z/3hNPtZdqv/vATK6kdSweHzrK+sUyZThOnuHXbGN6h6foDLuTBE59FaDMWHgKA0bv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724403996; c=relaxed/simple;
	bh=E0K9BVlAinKOdFlygcfsApTpKAoMe644T1TVWtyM6E4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DjOvuiQE1b0JsQOyH+yRaHJFjEZLVA2S7mDDXDqJN9Ug930y8cM8jz87mYziTcxJYwMvEO/fJjhtXGBIhgRDxmWH7y5KOlWcYpM3xZVueFpLZhTuiakP0LsBPmXQMtxA3C5BDC9IDgSjWIF/rah+MYsMMXkuNUfX1u3l79Man4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VE0Q1rfe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4035C32786;
	Fri, 23 Aug 2024 09:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724403996;
	bh=E0K9BVlAinKOdFlygcfsApTpKAoMe644T1TVWtyM6E4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VE0Q1rfeKUR/o1bPbuT8w8OB8ooEPzB3TipQjnSeKQVp07nKbkZR2E7eIPFZo81zN
	 obOC6larKQbQVKTuLYMutOWGQmMCZaebkxQLSKO51VDUtU7A+kHKwkg4yOMNmFm0EB
	 GfAyvDqZA29DdOPt9aZwap2py1vSc6DBd9c0nCvtxgjIT16Y+f2Ea6xsOTEU9tb1JX
	 5NzY+7RAM14KO4YUn0TqJVgnWhwSjQgRyRhCbO4NBNKd+IzYEB/4BZd7p+B1pK7zVH
	 AYBdcExzgg+46gIVeCTaRIZ42ArXnmWtiJQUgPlNRQaENWZ4tPnhoMdMoJZ5594b/g
	 HHaEekzTtlbjQ==
Message-ID: <7969b2e6-1046-4bd4-bdfe-d2bc12a1db1b@kernel.org>
Date: Fri, 23 Aug 2024 11:06:28 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] dt-bindings: PCI: Add binding for qps615
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>,
 Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 cros-qcom-dts-watchers@chromium.org, Bartosz Golaszewski <brgl@bgdev.pl>,
 Jingoo Han <jingoohan1@gmail.com>, andersson@kernel.org,
 quic_vbadigan@quicinc.com, linux-arm-msm@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240803-qps615-v2-0-9560b7c71369@quicinc.com>
 <20240803-qps615-v2-1-9560b7c71369@quicinc.com>
 <5f65905c-f1e4-4f52-ba7c-10c1a4892e30@kernel.org>
 <f8985c98-82a5-08c3-7095-c864516b66b9@quicinc.com>
 <ZrEGypbL85buXEsO@hu-bjorande-lv.qualcomm.com>
 <90582c92-ca50-4776-918d-b7486cf942b0@kernel.org>
 <20240808120109.GA18983@thinkpad>
 <cb69c01b-08d0-40a1-9ea2-215979fb98c8@kernel.org>
 <20240808124121.GB18983@thinkpad>
 <c5bae58c-4200-40d3-94c6-669d2ee131d4@kernel.org>
 <20240822140956.unt45fgpleqwniwa@thinkpad>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240822140956.unt45fgpleqwniwa@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/08/2024 16:09, Manivannan Sadhasivam wrote:
> On Thu, Aug 08, 2024 at 03:06:28PM +0200, Krzysztof Kozlowski wrote:
>> On 08/08/2024 14:41, Manivannan Sadhasivam wrote:
>>> On Thu, Aug 08, 2024 at 02:13:01PM +0200, Krzysztof Kozlowski wrote:
>>>> On 08/08/2024 14:01, Manivannan Sadhasivam wrote:
>>>>> On Mon, Aug 05, 2024 at 07:18:04PM +0200, Krzysztof Kozlowski wrote:
>>>>>> On 05/08/2024 19:07, Bjorn Andersson wrote:
>>>>>>> On Mon, Aug 05, 2024 at 09:41:26AM +0530, Krishna Chaitanya Chundru wrote:
>>>>>>>> On 8/4/2024 2:23 PM, Krzysztof Kozlowski wrote:
>>>>>>>>> On 03/08/2024 05:22, Krishna chaitanya chundru wrote:
>>>>>>>>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,qps615.yaml b/Documentation/devicetree/bindings/pci/qcom,qps615.yaml
>>>>>>> [..]
>>>>>>>>>> +  qps615,axi-clk-freq-hz:
>>>>>>>>>> +    description:
>>>>>>>>>> +      AXI clock which internal bus of the switch.
>>>>>>>>>
>>>>>>>>> No need, use CCF.
>>>>>>>>>
>>>>>>>> ack
>>>>>>>
>>>>>>> This is a clock that's internal to the QPS615, so there's no clock
>>>>>>> controller involved and hence I don't think CCF is applicable.
>>>>>>
>>>>>> AXI does not sound that internal.
>>>>>
>>>>> Well, AXI is applicable to whatever entity that implements it. We mostly seen it
>>>>> in ARM SoCs (host), but in this case the PCIe switch also has a microcontroller
>>>>> /processor of some sort, so AXI is indeed relevant for it. The naming actually
>>>>> comes from the switch's i2c register name that is being configured in the driver
>>>>> based on this property value.
>>>>>
>>>>>> DT rarely needs to specify internal
>>>>>> clock rates. What if you want to define rates for 20 clocks? Even
>>>>>> clock-frequency is deprecated, so why this would be allowed?
>>>>>> bus-frequency is allowed for buses, but that's not the case here, I guess?
>>>>>>
>>>>>
>>>>> This clock frequency is for the switch's internal AXI bus that runs at default
>>>>> 200MHz. And this property is used to specify a frequency that is configured over
>>>>> the i2c interface so that the switch's AXI bus can operate in a low frequency
>>>>> there by reducing the power consumption of the switch.
>>>>>
>>>>> It is not strictly needed for the switch operation, but for power optimization.
>>>>> So this property can also be dropped for the initial submission and added later
>>>>> if you prefer.
>>>>
>>>> So if the clock rate can change, why this is static in DTB? Or why this
>>>> is configurable per-board?
>>>>
>>>
>>> Because, board manufacturers can change the frequency depending on the switch
>>> configuration (enablement of DSP's etc...)
>>>
>>>> There is a reason why clock-frequency property is not welcomed and you
>>>> are re-implementing it.
>>>>
>>>
>>> Hmm, I'm not aware that 'clock-frequency' is not encouraged these days. So you
>>> are suggesting to change the rate in the driver itself based on the switch
>>> configuration? If so, what difference does it make?
>>
>> Based on the switch, other clocks, votes etc. whatever is reasonable
>> there. In most cases, not sure if this one here as well, devices can
>> operate on different clock frequencies thus specifying fixed frequency
>> in the DTS is simplification and lack of flexibility. It is chosen by
>> people only because it is easier for them but then they come back with
>> ABI issues when it turns out they need to switch to some dynamic control.
>>
> 
> Atleast for this device, this frequency is going to be static. Because, the
> device itself cannot change the frequency, only the host driver can. That too is
> only possible before enumerating the device. So there is no way the frequency is
> going to change dynamically.

We have assigned-clocks properties for this... but there are no clock
inputs here, so maybe it is not applicable? What generates this internal
AXI clock? Does it have internal oscillator?

So many questions and nothing in the property description helps to
understand this.

Best regards,
Krzysztof


