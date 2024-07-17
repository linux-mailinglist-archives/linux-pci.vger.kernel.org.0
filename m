Return-Path: <linux-pci+bounces-10435-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDA2933DA0
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 15:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F041B20E39
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 13:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2D617F4F7;
	Wed, 17 Jul 2024 13:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyxaDqzQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC63566A;
	Wed, 17 Jul 2024 13:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721223047; cv=none; b=MKj8NYQEXRCqjbz50Ifa+It8lAYJbpR8XaNmsTdOtn8ZxqtdWEa+0JBjvAXIzy5BNxACZk6qaZfz8dOcYckte9vKHjHTlpFKo27whr2a78fVD6rPbxQ/iWnSe6w/8ewz60uapeh2JxxJ9tUAGXq2IGsN/t0D9v+HzGLx6V2Q54U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721223047; c=relaxed/simple;
	bh=EjnGtehLHIKPE9q1cLN8XdIbtNHm5pvem+IG50mZpqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IPX0l0tsQsQbXFKHMiVVvmljhqnY+WJCjxQ18Ep/xejdcQ1vNjM84vAVbZRiRn9zU84w25NmAJ8+HG5Jk2chAJZnmvycsPgMS4YrfetBQiqafS/3yCItA0MunJlL2+jcZDcdCQYW59UlkWreBo/fO8hc0n0T4fG9WW9bYxU2ziA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyxaDqzQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A0CC32782;
	Wed, 17 Jul 2024 13:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721223047;
	bh=EjnGtehLHIKPE9q1cLN8XdIbtNHm5pvem+IG50mZpqA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MyxaDqzQe01C+DLKfhrub218xtvehXwEJ/jjaDw1rOck7qXJ2xCdqL34iZtz4+zgS
	 0zSvUClqP3k0OWal6okIcuQH5BBAy6PQLuCo9n/NxSYTfF7ZdHJ8/84hvLatGO2eQF
	 ysUPgnFY70DY/J7bVIqSLjxYmXw1rxwHWvlUkXvvSVzNze1qdU8Fm96lpN1qYFOxUp
	 9tjuaKqj21iI5pNlScumyJLJFw0da61JqXNqVAPD1Cumm534QHLoexXTXFXcRghVQT
	 XWpVAEst3AYYmzQrIpmgCT4EpRJbqLDudYw/M5fCSHlhAwaWY/ZrZuNlkxM/ZXNI1r
	 Z1BQRrIoCMeFw==
Message-ID: <8e260164-cce2-4153-9f9c-0330c76408ef@kernel.org>
Date: Wed, 17 Jul 2024 15:30:39 +0200
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
 <CA+-6iNwvShkUwgQ5iTqa53gX1RtOMcDACPOJtqKm6zWCXN6Rtg@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CA+-6iNwvShkUwgQ5iTqa53gX1RtOMcDACPOJtqKm6zWCXN6Rtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/07/2024 15:20, Jim Quinlan wrote:
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
> 
> I'm sorry Krzysztof, but AFAICT I paid attention to all of your comments and
> tried to answer them as best as I could.  Please do not resort to a
> form letter; if
> you think I missed something(s) please oblige me and say what it is rather than
> having  me search for something that you know and I do not.

I do not see your response at all to my comments on patch #2.

> 
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
> The 4908 chip exclusively uses the "perst" reset, and the  7216 chip
> exclusively uses the "rescal" reset.   The rest of the chips use zero
> resets.   All together, there are two resets.

This is not enum, but a list. What you do mean overall two resets? You
have a chip which is both 4908 and 7216 at the same time? How is this
possible?

> 
> You are the one that wanted me to first list all resets at the top,
> and refer to them by the conditional rules.

No, I wanted widest constraints at the top.

My comment at v2 was already saying this:

"This does not match what you have in conditional, so just keep min and
max Items here."

and you have numerous examples in the code for this.

Best regards,
Krzysztof


