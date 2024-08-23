Return-Path: <linux-pci+bounces-12119-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE0395CE69
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 15:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DF001F2271E
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 13:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454F518859D;
	Fri, 23 Aug 2024 13:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRcxzYT0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DCB1DFE8;
	Fri, 23 Aug 2024 13:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421094; cv=none; b=hvJR9EKsMDCu+QGKj/VG1ef3usI1u1zkFJkmRY4AkkmgvXzlRi8/mLgOk6u8g9Ifs0RVgS3UZqJCBiWzHDvuzjiT31T9Ld6VsRrmNJnKsJ22YQBVkCl0AWn2QUcp0ztbNeM+vZ1DndIrjPVIGpdlgONo31zezc1Lf3MbJjeXwlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421094; c=relaxed/simple;
	bh=UE483HCROS2DBDxQZGMnMhL4YknFLf2TEl7zKV9B2eM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fM5SwolssAM4/EJBPYyD5tM8tsITklfOxex0jZ3OmpJoS3peCo3UVKFCVPMW60g7Q1/lRRPzsspc2gowW90kqMblVM6c7wsX94UJ25Bp3yMvKCL6Nw//K5KGqbglJfarMta1vsmVweYdoKCqO4ArAsLkJ+VPhzioEXc4Snucbtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRcxzYT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B34C32786;
	Fri, 23 Aug 2024 13:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421093;
	bh=UE483HCROS2DBDxQZGMnMhL4YknFLf2TEl7zKV9B2eM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XRcxzYT0+0378RLFOQuyD3+ZfetboZHOG4fmwphK8TrgtOh1sz5KgSpLy0Vei9UPC
	 9TnhWMezxUgoWyvUmtoMf1OeXUQ/VbZQewPzUQEol0H9BVmn4862etQqGgYaqm8gts
	 DktbZoXYoMnS6IzBnQZjKlANrXLverPEiRzC/E5rpRpEB8faWGkLaqkEz+xIUemUsI
	 KfJ4sjPmDzkXiwLwbeLbuwbt/SeYklBoLlehen67M/OfR4y1h8hlbiTSG1tzHwhW0k
	 zh1iTDEWzi2Lu7fHp8/nzO7X8Tovmrt+GgJnHasXHbS+m2FJqphYg6Sd2v4H5WrStY
	 a/Cu8/sMZYm2Q==
Message-ID: <ececab1a-b4c7-49ac-8a76-038d672a0dd4@kernel.org>
Date: Fri, 23 Aug 2024 15:51:25 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] dt-bindings: PCI: Add binding for qps615
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
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
References: <20240803-qps615-v2-1-9560b7c71369@quicinc.com>
 <5f65905c-f1e4-4f52-ba7c-10c1a4892e30@kernel.org>
 <f8985c98-82a5-08c3-7095-c864516b66b9@quicinc.com>
 <58317fe2-fbea-400e-bd1d-8e64d1311010@kernel.org>
 <100e27d7-2714-89ca-4a98-fccaa5b07be3@quicinc.com>
 <c80ae784-c1f3-4046-9d86-d7e57bd93669@kernel.org>
 <7f48f71c-7f57-492c-47df-6aac1d3b794b@quicinc.com>
 <aa311052-deba-4d13-9ede-1d863a4f362e@kernel.org>
 <20240822141622.tw7vcoc4ciwbydsw@thinkpad>
 <9cff09b0-d039-4e65-b6dc-57adaf94c12e@kernel.org>
 <20240823094419.7l2kvly4mnajrm4z@thinkpad>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240823094419.7l2kvly4mnajrm4z@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/08/2024 11:44, Manivannan Sadhasivam wrote:
> On Fri, Aug 23, 2024 at 11:01:37AM +0200, Krzysztof Kozlowski wrote:
>> On 22/08/2024 16:16, Manivannan Sadhasivam wrote:
>>> On Mon, Aug 05, 2024 at 04:43:47PM +0200, Krzysztof Kozlowski wrote:
>>>> On 05/08/2024 07:57, Krishna Chaitanya Chundru wrote:
>>>>>>
>>>>> Hi Krzysztof,
>>>>>
>>>>> QPS615 has a 3 downstream ports and 1 upstream port as described below
>>>>> diagram.
>>>>> For this entire switch there are some supplies which we described in the
>>>>> dt-binding (vdd18-supply, vdd09-supply etc) and one GPIO which controls
>>>>> reset of the switch (reset-gpio). The switch hardware can configure the
>>>>> individual ports DSP0, DSP1, DSP2, upstream port and also one integrated
>>>>> ethernet endpoint which is connected to DSP2(I didn't mentioned in the
>>>>> diagram) through I2C.
>>>>>
>>>>> The properties other than supplies,i2c client, reset gpio which
>>>>> are added will be applicable for all the ports.
>>>>> _______________________________________________________________
>>>>> |   |i2c|                   QPS615       |Supplies||Resx gpio |
>>>>> |   |___|              _________________ |________||__________|
>>>>> |      ________________| Upstream port |_____________         |
>>>>> |      |               |_______________|            |         |
>>>>> |      |                       |                    |         |
>>>>> |      |                       |                    |         |
>>>>> |  ____|_____              ____|_____            ___|____     |
>>>>> |  |DSP 0   |              | DSP 1  |            | DSP 2|     |
>>>>> |  |________|              |________|            |______|     |
>>>>> |_____________________________________________________________|
>>>>>
>>>>
>>>> I don't get why then properties should apply to main device node.
>>>>
>>>
>>> The problem here is, we cannot differentiate between main device node and the
>>> upstream node. Typically the differentiation is not needed because no one cared
>>> about configuring the upstream port. But this PCIe switch is special (as like
>>> most of the Qcom peripherals).
>>>
>>> I agree that if we don't differentiate then it also implies that all main node
>>> properties are applicable to upstream port and vice versa. But AFAIK, upstream
>>> port is often considered as the _device_ itself as it shares the same bus
>>> number.
>>
>> Well, above diagram shows supplies being part of the entire device, not
>> each port. That's confusing. Based on diagram, downstream ports do not
>> have any supplies... and what exactly do they supply? Let's look at
>> vdd18 and vdd09 which sound main supplies of the entire device. In
>> context of port: what exactly do they power? Which part of the port?
>>
> 
> The supplies for the downstream ports are derived from the switch power supply
> only. There is no way we can describe them as the port suppliers are internal to
> the device.

IIUC, this means supplies are not valid for downstream ports, so it is a
proof that binding is not correct. I don't get why we keep poking this
and get to the same conclusions I had 3 weeks ago.

Basically the binding is saying that downstream ports are identical to
the device. Including the aspect of having more downstream ports (so
device -> downstream ports -> downstream ports -> downstream ports ...
infinite). To remind that was my conclusion:

"Downstream port is not the same as device. Why downstream port has the
same supplies? To which pins are they connected?"

Best regards,
Krzysztof


