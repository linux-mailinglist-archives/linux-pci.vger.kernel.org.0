Return-Path: <linux-pci+bounces-10715-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A781993ADB8
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 10:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 076C6B22818
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 08:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035BD13957C;
	Wed, 24 Jul 2024 08:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlS0Y/Zw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D781384B3;
	Wed, 24 Jul 2024 08:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721808347; cv=none; b=UpS3TWSJ1gLWNyBz8WF5tg9ZhVaXiHIhZ7o02WxuF8+fO3dNjOVw+41KtV3AFYQoRFZU/h5dBWptdWEsOtAfuqGRQ73sZaCiK4vSscdDTB6SzLM9HmrO2ZlD0Xoyq4gBAPR4em4a7Mfz77M5XYquQgM7bQRefyDvVuh3snWeSSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721808347; c=relaxed/simple;
	bh=2ZFm6oJ8ZJGEVnquIxnlkrRi7n6uMfCChR+zqo7+p5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLnjUQ/o54mgVSJC+jS89UKIW+oSbtjqC9q82tktz+BLg0SY+sRXQyNWmgfLXIn5aLrErpoEafSyq8R59wy2AvvTfoeBEUlpSbnCZphL80aLcneLNQxEpFfJr4W9cnMNInG1+n1HgoMPy6pft+/MdSkcgHfGqtuqd12423XIxuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlS0Y/Zw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD814C32782;
	Wed, 24 Jul 2024 08:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721808347;
	bh=2ZFm6oJ8ZJGEVnquIxnlkrRi7n6uMfCChR+zqo7+p5Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LlS0Y/ZwbF3CDc5KVEh1EWvZ4Zjera+nBRtsp30/aTaEdvHMGBHDsxpaMW4CBm+ob
	 u98tm5BLlrE+b4F86x+gcCnZrNPPm+wcAoxhLO2NdmUZWMKSqqW5982OSBcPCfOSH6
	 Pyzn6GAeT07y8P0S2XHEwlS90UOzJtocJlmrPMlHTDl6zLY63CGZAe5PJMk2En/gDR
	 zZzlqcMLk2kC/Cr14MYDqK321E2lv2OQIPEs5MfR6qgCVr/83RQYIkiPonJLc1mSnA
	 Jzj3vr/V+7OLfPsHw8Gz+7EY3El+DBDS8SQQWIjDCB6yRq4jhLxzB7y0RJj7l2b3RI
	 Ep7QnEPMv/xAw==
Message-ID: <90d1d4a5-5d47-4ad0-ab0f-d4f549cd4eec@kernel.org>
Date: Wed, 24 Jul 2024 10:05:37 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/12] dt-bindings: PCI: Cleanup of brcmstb YAML and
 add 7712 SoC
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20240716213131.6036-1-james.quinlan@broadcom.com>
 <20240716213131.6036-2-james.quinlan@broadcom.com>
 <d20be2d3-4fdd-48ca-b73e-80e8157bd5b2@kernel.org>
 <CA+-6iNzsE0hwUhFyfuUZtuAVgOAS-L8pR37x8TV4R779g6E-Jg@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CA+-6iNzsE0hwUhFyfuUZtuAVgOAS-L8pR37x8TV4R779g6E-Jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/07/2024 20:44, Jim Quinlan wrote:
> On Wed, Jul 17, 2024 at 2:51 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 16/07/2024 23:31, Jim Quinlan wrote:
>>> o Change order of the compatible strings to be alphabetical
>>>
>>> o Describe resets/reset-names before using them in rules
>>>
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
>>> o Add minItems/maxItems where needed.
>>>
>>> o Change maintainer: Nicolas has not been active for a while.  It also
>>>   makes sense for a Broadcom employee to be the maintainer as many of the
>>>   details are privy to Broadcom.
>>>
>>> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
>>> ---
>>>  .../bindings/pci/brcm,stb-pcie.yaml           | 26 ++++++++++++++-----
>>>  1 file changed, 19 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>>> index 11f8ea33240c..692f7ed7c98e 100644
>>> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>>> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>>> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>>>  title: Brcmstb PCIe Host Controller
>>>
>>>  maintainers:
>>> -  - Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>>> +  - Jim Quinlan <james.quinlan@broadcom.com>
>>>
>>>  properties:
>>>    compatible:
>>> @@ -16,11 +16,11 @@ properties:
>>>            - brcm,bcm2711-pcie # The Raspberry Pi 4
>>>            - brcm,bcm4908-pcie
>>>            - brcm,bcm7211-pcie # Broadcom STB version of RPi4
>>> -          - brcm,bcm7278-pcie # Broadcom 7278 Arm
>>>            - brcm,bcm7216-pcie # Broadcom 7216 Arm
>>> -          - brcm,bcm7445-pcie # Broadcom 7445 Arm
>>> +          - brcm,bcm7278-pcie # Broadcom 7278 Arm
>>>            - brcm,bcm7425-pcie # Broadcom 7425 MIPs
>>>            - brcm,bcm7435-pcie # Broadcom 7435 MIPs
>>> +          - brcm,bcm7445-pcie # Broadcom 7445 Arm
>>>
>>>    reg:
>>>      maxItems: 1
>>> @@ -95,6 +95,18 @@ properties:
>>>        minItems: 1
>>>        maxItems: 3
>>>
>>> +  resets:
>>> +    minItems: 1
>>> +    items:
>>> +      - description: reset for external PCIe PERST# signal # perst
>>> +      - description: reset for phy reset calibration       # rescal
>>> +
>>> +  reset-names:
>>> +    minItems: 1
>>> +    items:
>>> +      - const: perst
>>> +      - const: rescal
>>
>> There are no devices with two resets. Anyway, this does not match one of
>> your variants which have first element as rescal.
> 
> 
> Hello Krzysztof,
> 
> At this commit there are two resets; the 4908 requires "perst" and the
> 7216 requires "rescal".   I now think what you are looking for is the
> top-level
> description of something like
> 
> resets:
>   maxItems: 1
>     oneOf:
>       - description: reset controller handling the PERST# signal
>       - description: phandle pointing to the RESCAL reset controller

Now tell me, what sort of new information comes with this description?
"Phandle"? It cannot be anything else. Redundant. "Pointing to"?
Redundant. "reset-controller"? Well, resets always point to reset
controller.

So what is the point of this description? Any point?

> 
> reset-names:
>   maxItems: 1
>     oneOf:
>       - const: perst
>       - const: rescal
> 
> I left out minItems because imItems==maxItems=1
> 
> Before I was giving both of them as the "potential candidates list"
> that will be used further on, but this is not how Yaml should be used.
> 
> Is the above in the right direction?

It's over complicated. First maxItems are redundant, because you define
number of items in items. Second, you have EXACTLY the same case as the
hardware for which I gave you bindings to use. I don't understand why
you insist on doing things differently, but you can. Take a look at many
other bindings how they achieve this - there are many, many examples.
But do not invent third or fourth method...

Best regards,
Krzysztof


