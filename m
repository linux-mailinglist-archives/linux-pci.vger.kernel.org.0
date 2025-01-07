Return-Path: <linux-pci+bounces-19410-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCD9A0404C
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 14:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C7AE188086B
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 13:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425EA1E3DE7;
	Tue,  7 Jan 2025 13:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EBq9vu3U"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4EA1DE2A0;
	Tue,  7 Jan 2025 13:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736255077; cv=none; b=HO4A3WAzLe/u7JfOdfjhsR344PbDreZbYAEHeUjh/e2YUlWfdKfQNy/Mj1gdqdjooN5KXnftwN57EIJ2ufoIJFT5KnnxgA5Mi1StKVbQjnQfS3Q492Qzyzev3hK7PYM0C3w8oa/8vYToqrTqmwU1IKGRI2yQ7RuSMZsq9718E+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736255077; c=relaxed/simple;
	bh=hrjBwILl03AMkuILxv5+UdH95HodZymkjLogKmN18wU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CYSHWEvcPTqDHlfKz28/5yXjrNIn3xl4znEVZ1Z6OxeB3ibQaeF1R9RXWedEg9/gYncgy9lDsBH2hiWVJsVUNaNZ5hvRkYTKoJiVxxUn26Ko9aue6oPOSOcet7n0JCbmwTC9PmKRA/G6zY450PuDuYdWqggfK+7HSgWrhCJ56+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EBq9vu3U; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1736255072;
	bh=hrjBwILl03AMkuILxv5+UdH95HodZymkjLogKmN18wU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EBq9vu3U2s/KXM8+fmdhQS19ZZHkZCHSg9o8Y0Vn+zh4LodJlHCBBH18k28zi+oxO
	 v8+xrNdrb+I8J/XG6IUxDDU7hBE6HKuGwUzHEjeATlcIwa+ijCgqZtiHZ9j82P2lv9
	 ecioGCWeNvi5BdjaXIP2nyS/GBMa5tD4BE2kYuV5bOYlAoHgiS+j4LFEBJBT1Q9dCr
	 S5U0qu+H7k3j/9l6jjC4a48LbfoNS2oXTUNUZE06JDAvPJ6JMpyzEZtAprFN6oD47X
	 KU1oh/XbQU1CcjSPfcihPTJagNa4D9jk+rIzJATH0N9JVtmzgg7674/8kK7LYnuhx7
	 QH3Epgb8e39gg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5F26B17E154C;
	Tue,  7 Jan 2025 14:04:31 +0100 (CET)
Message-ID: <660e3bbb-4b16-49ad-82d1-a2c3e3ef76bb@collabora.com>
Date: Tue, 7 Jan 2025 14:04:30 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: PCI: mediatek-gen3: Add MT8196 support
To: =?UTF-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= <Jianjun.Wang@mediatek.com>,
 "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 Ryder Lee <Ryder.Lee@mediatek.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 =?UTF-8?B?WGF2aWVyIENoYW5nICjlvLXnjbvmlocp?= <Xavier.Chang@mediatek.com>
References: <20250103060035.30688-1-jianjun.wang@mediatek.com>
 <20250103060035.30688-2-jianjun.wang@mediatek.com>
 <0555fb64-312d-4490-9b03-89fca580c602@collabora.com>
 <8269f5fb280d0847ceba288a83a64c99bbf92cb7.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <8269f5fb280d0847ceba288a83a64c99bbf92cb7.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 06/01/25 10:19, Jianjun Wang (王建军) ha scritto:
> On Fri, 2025-01-03 at 10:26 +0100, AngeloGioacchino Del Regno wrote:
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>
>>
>> Il 03/01/25 07:00, Jianjun Wang ha scritto:
>>> Add compatible string and clock definition for MT8196. It has 6
>>> clocks like
>>> the MT8195, but 2 of them are different.
>>>
>>> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
>>> ---
>>>    .../bindings/pci/mediatek-pcie-gen3.yaml      | 29
>>> +++++++++++++++++++
>>>    1 file changed, 29 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-
>>> gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-
>>> gen3.yaml
>>> index f05aab2b1add..b4158a666fb6 100644
>>> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
>>> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
>>> @@ -51,6 +51,7 @@ properties:
>>>                  - mediatek,mt7986-pcie
>>>                  - mediatek,mt8188-pcie
>>>                  - mediatek,mt8195-pcie
>>> +              - mediatek,mt8196-pcie
>>>              - const: mediatek,mt8192-pcie
>>>          - const: mediatek,mt8192-pcie
>>>          - const: airoha,en7581-pcie
>>> @@ -197,6 +198,34 @@ allOf:
>>>              minItems: 1
>>>              maxItems: 2
>>>
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - mediatek,mt8196-pcie
>>> +    then:
>>> +      properties:
>>> +        clocks:
>>> +          minItems: 6
>>> +
>>> +        clock-names:
>>> +          items:
>>> +            - const: pl_250m
>>> +            - const: tl_26m
>>> +            - const: peri_26m
>>> +            - const: peri_mem
>>> +            - const: ahb_apb
>>
>> ahb_apb is a bus clock, so you can set it as
>>
>> - const: bus
> 
> Agree, I'll change it to "bus" in the next version, thanks.
> 
>>
>>
>>> +            - const: low_power
>>
>> Can you please clarify what the LP clock is for?
> 
> This is a power-saving clock. Its clock source consumes less power than
> a regular clock, we need to keep this clock on if when entering L1.2
> during suspend.
> 

In the driver, you are keeping all clocks ON instead.

Is this clock required to be ON when the full power ones are enabled and
the SoC is not in suspend state?

Can you please add handling for this "special" clock so that we can save power
during suspend?

Cheers,
Angelo

> Thanks.
> 
>>
>> Thanks,
>> Angelo
>>
>>> +
>>> +        resets:
>>> +          minItems: 1
>>> +          maxItems: 2
>>> +
>>> +        reset-names:
>>> +          minItems: 1
>>> +          maxItems: 2
>>> +
>>>      - if:
>>>          properties:
>>>            compatible:
>>
>>



