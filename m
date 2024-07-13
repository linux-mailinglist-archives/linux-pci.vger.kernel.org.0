Return-Path: <linux-pci+bounces-10231-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E25209304C6
	for <lists+linux-pci@lfdr.de>; Sat, 13 Jul 2024 11:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01B6B1C20D34
	for <lists+linux-pci@lfdr.de>; Sat, 13 Jul 2024 09:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8692946558;
	Sat, 13 Jul 2024 09:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTIJHVcq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1D21C280;
	Sat, 13 Jul 2024 09:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720864359; cv=none; b=jTyFpi+Dk1aUaWk6FWNm+UJiP8L+aNhK5lJ/YG6Oh0iEmDfeNlcAMewZITqnSrSndAQrXmaUP/foqzRkHfAZPiVPkKLNQpFAUuSTIHALVLmqMcpb2oFgN2EcoT8F2AHBDE+hrF54mfKcqoImcJbNS+pODSpdp15NAeUeA24I7T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720864359; c=relaxed/simple;
	bh=dO8JRg3tW996RKEzTLC6VYgYN0soO2YWXjMijWbOZzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n6ip/CJyPZw4Ql2zigC+NkRDXJDi4fx3ZiIjqG/UtBV5DyJ8U4jSlax8AR2KPbSy5QIP5mCdEKFr/ZyG95eTHCAjF4ZBvY/rNh998qIfIK3ZOlOm9ZXT1ghF+lwhusOp87gjzr7Kt20IxCyZut3rpMG7NWtThVurOo5Bm9WkRbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTIJHVcq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A57FC32781;
	Sat, 13 Jul 2024 09:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720864358;
	bh=dO8JRg3tW996RKEzTLC6VYgYN0soO2YWXjMijWbOZzg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PTIJHVcqL2qoGT+Y5G6hNDnJMl4k8uMlHovvUtrVHB4OdmMNOZSROYBQVN03s5APB
	 eKjTY2bP3lgRc4+f2kSEOMLq7Hepy8HFMG4n8MljMXg7VdeSfJjtCVcgT99yzYR1yK
	 w0sWXYG19ya5/DX5/zCFZY2Yv41PUQB01IfW5/iXhZ0pW3xBzRD51DE5lO/I2CAibA
	 1f4zmRpHTEujNISbwMpYQYQIHwXu1sxjgkrxK7HUfQ97X+sDIntEFBbHIO0T1asWqK
	 oS6F6Q20I9genVfIx0d9GJTS8Rq5567E+bp8KGFJAwYRxYkP66fT3z/jUWY4m4iL5i
	 BS3QT0spl8Q4A==
Message-ID: <a547d143-261e-4a46-b27f-40581ed06d32@kernel.org>
Date: Sat, 13 Jul 2024 11:52:27 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] dt-bindings: PCI: Add Broadcom STB 7712 SOC,
 update maintainer
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
References: <20240703180300.42959-1-james.quinlan@broadcom.com>
 <20240703180300.42959-2-james.quinlan@broadcom.com>
 <df291860-cbbe-4f94-a18d-00ae9cf905b1@kernel.org>
 <CA+-6iNzZXF+yTmjMZ0SU0jO4L0ZzETZ-VvQpe4txv=SNTyo_bA@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CA+-6iNzZXF+yTmjMZ0SU0jO4L0ZzETZ-VvQpe4txv=SNTyo_bA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/07/2024 21:54, Jim Quinlan wrote:
> On Thu, Jul 4, 2024 at 2:40 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 03/07/2024 20:02, Jim Quinlan wrote:
>>> - Update maintainer; Nicolas hasn't been active and it
>>>   makes more sense to have a Broadcom maintainer
>>> - Add a driver compatible string for the new STB SOC 7712
>>
>> You meant device? Bindings are for hardware.
> 
> Hello Krzysztof,
> 
> I should have replied to this before sending out V3.  Since your form
> letter says I did not address previous comments, I will address them
> here and now (your v2 review of the bindings commit).
> 
>>
>>> - Add two new resets for the 7712: "bridge", for the
>>>   the bridge between the PCIe core and the memory bus;
>>>   "swinit", the PCIe core reset.
>>> - Order the compatible strings alphabetically
>>> - Restructure the reset controllers so that the definitions
>>>   appear first before any rules that govern them.
>>
>> Please split cleanups from new device support.
> Okay.
>>
>>>
>>> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
>>> ---
>>>  .../bindings/pci/brcm,stb-pcie.yaml           | 44 +++++++++++++++----
>>>  1 file changed, 36 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>>> index 11f8ea33240c..a070f35d28d7 100644
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
>>> @@ -16,11 +16,12 @@ properties:
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
>>> +          - brcm,bcm7712-pcie # STB sibling SOC of Raspberry Pi 5
>>>
>>>    reg:
>>>      maxItems: 1
>>> @@ -95,6 +96,20 @@ properties:
>>>        minItems: 1
>>>        maxItems: 3
>>>
>>> +  resets:
>>> +    items:
>>> +      - description: reset for phy calibration
>>> +      - description: reset for PCIe/CPU bus bridge
>>> +      - description: reset for soft PCIe core reset
>>> +      - description: reset for PERST# PCIe signal
>>
>> This won't work and I doubt you tested your code. You miss minItems.
>>
>>> +
>>> +  reset-names:
>>> +    items:
>>> +      - const: rescal
>>> +      - const: bridge
>>> +      - const: swinit
>>> +      - const: perst
>>
>> This does not match what you have in conditional, so just keep min and
>> max Items here.
> 
> I do not understand.  There are four possible resets, but any one chip
> uses only 0, 1, or 3 of them:
> 
>     CHIP            NUM_RESETS    NAMES
>     ====            ==========    =====
>     4908            1             perst
>     7216            1             rescal
>     7712            3             rescal, bridge, swinit
>     Other_Chips     0             -
> 
> Although I list four "reset-names", I have, in the rule for 7712,
> maxItems=3 because it only uses rescal, bridge, and swinit.  So I
> don't know what you mean when you say "this does not match what you
> have in your conditional".  AFAICT, they are not supposed to match.

One place says they have order A+B+C, other place says they have order
C+B+A or whatever other combination. Look at first element: A ! = C. So
they do not match.


> 
> 
>>
>>
>>> +
>>>  required:
>>>    - compatible
>>>    - reg
>>> @@ -118,13 +133,10 @@ allOf:
>>>      then:
>>>        properties:
>>>          resets:
>>> -          items:
>>> -            - description: reset controller handling the PERST# signal
>>> -
>>> +          minItems: 1
>>
>> maxItems instead. Why three resets should be valid?
> For the "4908" conditional, minItems==maxItems==1.  I do not
> understand your question "Why three resets should be valid" -- can you
> please elaborate?

Where do you have maxItems? I see only minItems.

> 
>>
>>
>>>          reset-names:
>>>            items:
>>>              - const: perst
>>> -
>>>        required:
>>>          - resets
>>>          - reset-names
>>> @@ -136,12 +148,28 @@ allOf:
>>>      then:
>>>        properties:
>>>          resets:
>>> +          minItems: 1
>>> +        reset-names:
>>>            items:
>>> -            - description: phandle pointing to the RESCAL reset controller
>>> +            - const: rescal
>>> +      required:
>>> +        - resets
>>> +        - reset-names
>>
>> Why?
> 
> I do not know what you are questioning.  The 7216 device uses one
> reset: the "rescal".  Again, maxItems==minItems==1.  Please see the
> summary note below.

You are breaking the ABI, so I am questioning. I don't see ABI break
explained in the commit msg.

> 
>>
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            const: brcm,bcm7712-pcie
>>> +    then:
>>> +      properties:
>>> +        resets:
>>> +          minItems: 3
>>
>> Again, you do not have 4 items here.
> 
> I do not want to have 4 items here; I want to have 3 for "rescal",
> "bridge," and "swinit".  In this case, maxItems==minItems==3.

Your schema does not define that.

> 
> Now , for V1 you requested that I define all resets at the top; I've
> done that and there are 4 of them.  But no chip uses all 4; each
> individual chip only uses 0, 1, or 3 resets.

I assumed they follow same order. If you have different order, the top
defines only widest constraints.

> 
> So there is no way that each chip's conditional rule can define
> minItems and maxItems to match the description list of 4 resets,
> unless you want me to undo your V1 request of describing the resets at
> the top level instead of describing them in the rules.
> 


Best regards,
Krzysztof


