Return-Path: <linux-pci+bounces-11265-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8779894748B
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 07:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A997F1C20C27
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 05:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB56313D52A;
	Mon,  5 Aug 2024 05:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARC0SswW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812F813AA2A;
	Mon,  5 Aug 2024 05:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722834761; cv=none; b=bYWEi4L3EDI7rgvWrQsdGIMnQBPaq9omgJKySWIHlsTA8zSfTMNhqOhZRp3vyjiCMaTWNfp2T4OITTtr2HFkF7qQ+pDCycO65zYjZSucezBZzrzvdutVu/cskAGoyMMru7mmS+XcZJ88uWOit5hE6i6OewY++VoSbwvr6AetrFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722834761; c=relaxed/simple;
	bh=IhH5nuPyDwoZsaaFTPa3BZyc0epnKqTW7vxZAe5GUh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZG+kPUihvPXeKLxNSG97zOViEqCBUtiMXXHKY4/eBZyAxTtKEEDo+KqA5fMQpsT4JFQaHgfZLEKSwTvs4xfiz2b2ywD/w2dcroroIqgjkTi7bfTcUYWbeifhbwkHfIJXpCywsDvLqto1CsFOBrUNU9Z90z3hSSfUVmIFPVCoTSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARC0SswW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE20AC32782;
	Mon,  5 Aug 2024 05:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722834761;
	bh=IhH5nuPyDwoZsaaFTPa3BZyc0epnKqTW7vxZAe5GUh8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ARC0SswWMQU4M69RDdXtZ0i8+aMEukE9b5zZ+tTdf6T3QVBd+72SuPGDJepiR+cl+
	 fJlT7PJ7wuMwIxbEjCG6TtRQnSjHXYUER9a3shXRIdKKYbyS78U4I/b/f2Gepvkq3/
	 YJiyz2ap1RwmdMKbVzCI5IFhoDec8Pz/ysA97GYJI2JPYAgX6qdWZsIqhyBD2LsyxK
	 v80sywhvFT3fstmn6qlNe31SN8pnQn9zabQfjer3q8wzD37eECxEK1yrPhLc6ZQEmE
	 lUFp1FLkrxj5Limuk8NzIH3lbg0NWlVN6AereeThYRLgHhBBYFxrFHaGku1wycZCuK
	 MdRmLG042myjw==
Message-ID: <132a0367-596b-4ff2-b35c-e81e77f14340@kernel.org>
Date: Mon, 5 Aug 2024 07:12:34 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] dt-bindings: PCI: Add binding for qps615
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 cros-qcom-dts-watchers@chromium.org, Bartosz Golaszewski <brgl@bgdev.pl>,
 Jingoo Han <jingoohan1@gmail.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: andersson@kernel.org, quic_vbadigan@quicinc.com,
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240803-qps615-v2-0-9560b7c71369@quicinc.com>
 <20240803-qps615-v2-1-9560b7c71369@quicinc.com>
 <0cdaa0b2-ae50-40a1-abbb-7a6702d54ad5@kernel.org>
 <027dc9f7-6e0d-e331-8f90-92a3d56350ab@quicinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <027dc9f7-6e0d-e331-8f90-92a3d56350ab@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/08/2024 06:02, Krishna Chaitanya Chundru wrote:
> 
> 
> On 8/4/2024 2:26 PM, Krzysztof Kozlowski wrote:
>> On 03/08/2024 05:22, Krishna chaitanya chundru wrote:
>>> Add binding describing the Qualcomm PCIe switch, QPS615,
>>> which provides Ethernet MAC integrated to the 3rd downstream port
>>> and two downstream PCIe ports.
>>>
>>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>> ---
>>>   .../devicetree/bindings/pci/qcom,qps615.yaml       | 191 +++++++++++++++++++++
>>>   1 file changed, 191 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,qps615.yaml b/Documentation/devicetree/bindings/pci/qcom,qps615.yaml
>>> new file mode 100644
>>> index 000000000000..ea0c953ee56f
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/pci/qcom,qps615.yaml
>>> @@ -0,0 +1,191 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/pci/qcom,qps615.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Qualcomm QPS615 PCIe switch
>>> +
>>> +maintainers:
>>> +  - Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>> +
>>> +description: |
>>> +  Qualcomm QPS615 PCIe switch has one upstream and three downstream
>>> +  ports. The 3rd downstream port has integrated endpoint device of
>>> +  Ethernet MAC. Other two downstream ports are supposed to connect
>>> +  to external device.
>>> +
>>> +  The QPS615 PCIe switch can be configured through I2C interface before
>>> +  PCIe link is established to change FTS, ASPM related entry delays,
>>> +  tx amplitude etc for better power efficiency and functionality.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - pci1179,0623
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  qcom,qps615-controller:
>>
>> and now I see that you totally ignored comments. Repeating the same over
>> and over is a waste of time.
>>
>> <form letter>
>> This is a friendly reminder during the review process.
>>
>> It seems my or other reviewer's previous comments were not fully
>> addressed. Maybe the feedback got lost between the quotes, maybe you
>> just forgot to apply it. Please go back to the previous discussion and
>> either implement all requested changes or keep discussing them.
>>
>> Thank you.
>> </form letter>
>>
>>
>> Best regards,
>> Krzysztof
>>
> Hi Krzysztof,
> 
> In patch1 we are trying to add reference of i2c-adapter, you suggested
> to use i2c-bus for that. we got comments on the driver code not to use
> adapter and instead use i2c client reference. I felt i2c-bus is not
> ideal to represent i2c client device so used this name.

You did not respond to comment of using i2c-bus, just silently decided
to implement other property.

Anyway, why i2c-bus is not suitable here? I am quite surprised...



Best regards,
Krzysztof


