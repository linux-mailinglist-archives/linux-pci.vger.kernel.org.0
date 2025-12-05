Return-Path: <linux-pci+bounces-42696-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B71A9CA7BB4
	for <lists+linux-pci@lfdr.de>; Fri, 05 Dec 2025 14:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DEAB308C787
	for <lists+linux-pci@lfdr.de>; Fri,  5 Dec 2025 13:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EA22E093E;
	Fri,  5 Dec 2025 13:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmiUxdK/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953222F7ADE;
	Fri,  5 Dec 2025 13:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764940484; cv=none; b=TCXKIENTDluDHkWBaB2BX0uyDZv/dQwBqu0I2FgBregjNedliKxRFT5y4lt1Jfu0UMAYXAWFm8btUS7H7S7PZ+NkL/853P+JBKBfzT0CVB2MbIECqcoOevxME9IPs8VlYwzNhOo7gXFQZfCThG9CwGaICJbfvCPPJdUljTKZlhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764940484; c=relaxed/simple;
	bh=OnFV8M52MQ1fx9QsvZL97MqSp+jVOb4a/O9yUSS0J4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qhgqs3BtS6M35JXDGKQI/GrhxuRaKFnuCbBRu6y5OSIZMA+JO5KMqdjn9dPv0v4YTO2ccJs1TkgGAcZ+Tc38VWQU7MX3iSb44k8ZFCgqpQrTM0DZryvuhdk38ki5jLZnNykDYJr3f8bijtPkv3I52f37kkSF4/d73NelO+6Zv/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmiUxdK/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6E9C113D0;
	Fri,  5 Dec 2025 13:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764940484;
	bh=OnFV8M52MQ1fx9QsvZL97MqSp+jVOb4a/O9yUSS0J4E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WmiUxdK/26naJtIeK2IEsnq8Olgez6IpwDc5AuWUlbSftCuXjWB6qvP019Cly7ZK8
	 NzTrlqBci73zhCclAuOjmHJOJ37lzvZtoVvF1VO6CnFqioDhIpyCm4MmQgVVlj6O8U
	 D/giq3p5IfnVjLTF9jrDu5GOZ+eCBmO28R6tWbADiNiruWmLKRMWxMzhKSdWPbc6JL
	 r32uxx9U39Vfvsp5Bp2uqjHruV8C3wz4Flpm/od/23FH4TG7iXuyfbanGCDu3fQefr
	 Dn7wXKatYT6OGRWPTO8KuGtrBZYOblZSc0mbwfe9rBEbj3ZUaXybe/VYK0nTWhZzz9
	 g1cKqEBrKoiSQ==
Message-ID: <8bb852ac-1736-49db-be94-f6be9e500f74@kernel.org>
Date: Fri, 5 Dec 2025 14:14:37 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: PCI: qcom,pcie-ep-sa8255p: Document
 firmware managed PCIe endpoint
To: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@oss.qualcomm.com,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 quic_vbadigan@quicinc.com, quic_shazhuss@quicinc.com,
 konrad.dybcio@oss.qualcomm.com, Rama Krishna <quic_ramkri@quicinc.com>,
 Ayiluri Naga Rashmi <quic_nayiluri@quicinc.com>,
 Nitesh Gupta <quic_nitegupt@quicinc.com>
References: <20251203-firmware_managed_ep-v1-0-295977600fa5@oss.qualcomm.com>
 <20251203-firmware_managed_ep-v1-1-295977600fa5@oss.qualcomm.com>
 <20251205-majestic-guillemot-of-criticism-80c18b@quoll>
 <CAMyL0qO2FPBe7N6Q=hW-ymeiGDhABsU+VCj25jzcoQRhBoWbDA@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <CAMyL0qO2FPBe7N6Q=hW-ymeiGDhABsU+VCj25jzcoQRhBoWbDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/12/2025 13:58, Mrinmay Sarkar wrote:
>>>  1 file changed, 114 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep-sa8255p.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep-sa8255p.yaml
>>> new file mode 100644
>>> index 0000000000000000000000000000000000000000..970f65d46c8e2fa4c44665cb7a346dea1dc9e06a
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep-sa8255p.yaml
>>> @@ -0,0 +1,114 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/pci/qcom,pcie-ep-sa8255p.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Qualcomm firmware managed PCIe Endpoint Controller
>>> +
>>> +description:
>>> +  Qualcomm SA8255p SoC PCIe endpoint controller is based on the Synopsys
>>> +  DesignWare PCIe IP which is managed by firmware.
>>> +
>>> +maintainers:
>>> +  - Manivannan Sadhasivam <mani@kernel.org>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: qcom,sa8255p-pcie-ep
>>> +
>>> +  reg:
>>> +    minItems: 6
>>
>> Why is this flexible?
> 
> The reason for `minItems: 6` is that the DMA register space can be
> skipped if DMA is not used.

But the hardware has this anyway, so this must be here. You do not write
bindings depending how drivers use them in your use case.

Either drop minItems (fixed size of array) or provide rationale in terms
of hardware in commit msg.

...


>>> +
>>> +  dma-coherent: true
>>> +
>>> +  num-lanes:
>>> +    default: 2
>>
>> Isn't this deducible from the compatible? Do you have have different
>> PCIe controllers with different lanes?
> 
> SA8255p has 2 pcie controllers(pcie0 and pcie1).
> pcie0 supports 2 lanes, and pcie1 supports 4 lanes.

That's ok, thanks.


Best regards,
Krzysztof

