Return-Path: <linux-pci+bounces-10232-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BD09304CA
	for <lists+linux-pci@lfdr.de>; Sat, 13 Jul 2024 11:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A76AB22072
	for <lists+linux-pci@lfdr.de>; Sat, 13 Jul 2024 09:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EC24964C;
	Sat, 13 Jul 2024 09:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hoi6pzI3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD011BC57;
	Sat, 13 Jul 2024 09:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720864431; cv=none; b=Fd/zETU0SKSGHfj0UCsVFN4DQMwOWFMT0yWWZftOe2IsmWPdKfV5bniWHYVKqlKsTS4d1fJY2GOooOWsxX4LaSDUpW0Ttfp7BJ0Is6sKhUTbYoXXNe/asMBfH4yYT5mnuMWxnaYsN7A40bosJYzB8dr4NNaGkugbB6+ffPxBgn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720864431; c=relaxed/simple;
	bh=RLGuewcKeMcKJCtVg6hn99HtGiVFDk4BWax3UwXsF68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MfZ4Q2NR7P6OKZt0P9t/nT3or6WPjkWKD/DvBoCqyPYdYyIWBv0v6XJQOHIRmU64/NO4vLsf2bZaCJRUei49q/ToJhza8uXSJgPfK5Itgt+RhsJUIw0XF96Em0xFby1gRR7qVjKqcAzxdORY/Sv66h4L8mqjUoT7b0Cc+ADlbm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hoi6pzI3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1112C32781;
	Sat, 13 Jul 2024 09:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720864431;
	bh=RLGuewcKeMcKJCtVg6hn99HtGiVFDk4BWax3UwXsF68=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hoi6pzI3mhNuXPEFZgxDpnG4g0L0PWSE5rtgLbXjFTyOKt4re1ei9t3Src6T91idq
	 ECtU3m4rE2h9dGBnSnbttuAGfyo6rcQBbETkNW7xxPdgQYI0q0fNh2NUblT14ohrmg
	 TFsXjIJA5G5C8hb6uLPIvIk+5ooVu2pfsaOlmpzT8LZQHzzYa3CP35DHgNo7xhEEdv
	 iK5s67n2cDtMQtz7fwx7ti0ETp6bceIJrBUF4jLmiQ21Xzg2bZObcbHkH8QnvyP2/z
	 BgGLHCwiC+15Po5syWpFMO16ZAqwvs6jTLAKfmSLtylJTdFzd3RV/RKpKuJOpvhG0m
	 5/Ieuz1nLqC6w==
Message-ID: <3cecb092-2175-4e57-83d4-4507a902762a@kernel.org>
Date: Sat, 13 Jul 2024 11:53:43 +0200
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
 <CA+-6iNwSk9-k=BZLbmPtwHHgqWs4ZB9OPGfF3Ruy4883dSTH7A@mail.gmail.com>
 <b71cb924-7f63-4141-97da-319d8c840465@kernel.org>
 <CA+-6iNxcmkd9O9y6=2By7pm+dAiyZt7GwYSMM++AUzLFF7yC4g@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CA+-6iNxcmkd9O9y6=2By7pm+dAiyZt7GwYSMM++AUzLFF7yC4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/07/2024 22:13, Jim Quinlan wrote:
> On Sun, Jul 7, 2024 at 7:58 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 05/07/2024 22:02, Jim Quinlan wrote:
>>> On Thu, Jul 4, 2024 at 2:40 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>
>>>> On 03/07/2024 20:02, Jim Quinlan wrote:
>>>>> - Update maintainer; Nicolas hasn't been active and it
>>>>>   makes more sense to have a Broadcom maintainer
>>>>> - Add a driver compatible string for the new STB SOC 7712
>>>>
>>>> You meant device? Bindings are for hardware.
>>>>
>>>>> - Add two new resets for the 7712: "bridge", for the
>>>>>   the bridge between the PCIe core and the memory bus;
>>>>>   "swinit", the PCIe core reset.
>>>>> - Order the compatible strings alphabetically
>>>>> - Restructure the reset controllers so that the definitions
>>>>>   appear first before any rules that govern them.
>>>>
>>>> Please split cleanups from new device support.
>>>>
>>>>>
>>>>> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
>>>>> ---
>>>>>  .../bindings/pci/brcm,stb-pcie.yaml           | 44 +++++++++++++++----
>>>>>  1 file changed, 36 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>>>>> index 11f8ea33240c..a070f35d28d7 100644
>>>>> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>>>>> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>>>>> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>  title: Brcmstb PCIe Host Controller
>>>>>
>>>>>  maintainers:
>>>>> -  - Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>>>>> +  - Jim Quinlan <james.quinlan@broadcom.com>
>>>>>
>>>>>  properties:
>>>>>    compatible:
>>>>> @@ -16,11 +16,12 @@ properties:
>>>>>            - brcm,bcm2711-pcie # The Raspberry Pi 4
>>>>>            - brcm,bcm4908-pcie
>>>>>            - brcm,bcm7211-pcie # Broadcom STB version of RPi4
>>>>> -          - brcm,bcm7278-pcie # Broadcom 7278 Arm
>>>>>            - brcm,bcm7216-pcie # Broadcom 7216 Arm
>>>>> -          - brcm,bcm7445-pcie # Broadcom 7445 Arm
>>>>> +          - brcm,bcm7278-pcie # Broadcom 7278 Arm
>>>>>            - brcm,bcm7425-pcie # Broadcom 7425 MIPs
>>>>>            - brcm,bcm7435-pcie # Broadcom 7435 MIPs
>>>>> +          - brcm,bcm7445-pcie # Broadcom 7445 Arm
>>>>> +          - brcm,bcm7712-pcie # STB sibling SOC of Raspberry Pi 5
>>>>>
>>>>>    reg:
>>>>>      maxItems: 1
>>>>> @@ -95,6 +96,20 @@ properties:
>>>>>        minItems: 1
>>>>>        maxItems: 3
>>>>>
>>>>> +  resets:
>>>>> +    items:
>>>>> +      - description: reset for phy calibration
>>>>> +      - description: reset for PCIe/CPU bus bridge
>>>>> +      - description: reset for soft PCIe core reset
>>>>> +      - description: reset for PERST# PCIe signal
>>>>
>>>> This won't work and I doubt you tested your code. You miss minItems.
>>>
>>> I did test my code and there were no errors.  I perform the following test:
>>>
>>> make ARCH=arm64 dt_binding_check DT_CHECKER_FLAGS=-m
>>> DT_SCHEMA_FILES=Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>>>
>>> Is this incorrect?
>>
>> That's correct and you are right - it passes the checks. Recent dtschema
>> changed the logic behind this. I am not sure if the new approach will
>> stay, I would find explicit minItems here more obvious and readable, so:
>> resets:
>>   minItems: 1
>>   items:
>>     - .........
>>     - .........
>>     - .........
>>     - .........
>>
>>
>>>
>>>>
>>>>> +
>>>>> +  reset-names:
>>>>> +    items:
>>>>> +      - const: rescal
>>>>> +      - const: bridge
>>>>> +      - const: swinit
>>>>> +      - const: perst
>>>>
>>>> This does not match what you have in conditional, so just keep min and
>>>> max Items here.
>>>
>>> I'm not sure what you mean.  One chips uses a single reset, another
>>> chip uses a different single reset,
>>> and the third (7712) uses three of the four resets.
>>
>> Your conditional in allOf:if:then has different order.
> Different order then what, and ordering by chip or by reset name?

Where is my comment? Comment is under reset-names.

> 
>>
>>>
>>> I was instructed to separate the descriptions from the rules, or at
>>> least that's what I thought I was asked.
>>>>
>>>>
>>>>> +
>>>>>  required:
>>>>>    - compatible
>>>>>    - reg
>>>>> @@ -118,13 +133,10 @@ allOf:
>>>>>      then:
>>>>>        properties:
>>>>>          resets:
>>>>> -          items:
>>>>> -            - description: reset controller handling the PERST# signal
>>>>> -
>>>>> +          minItems: 1
>>>>
>>>> maxItems instead. Why three resets should be valid?
>>>
>>> See above.  Note that I was just instructed to separate the rules from
>>> the descriptions.
>>> In doing so I placed all of the reset descripts on the top and then
>>> the rules below.
>>> There are four possible resets but no single chip uses all of them and
>>> three chips
>>> use one or three of them.
>>>
>>> Please advise.
>>
>> I don't understand that explanation. Why this particular variant works
>> with 1, 2, 3 or 4 resets in the same time?
> 
> What do you mean in the "same time"?  The resets are just not present

Your schema says that you can have 1, 2, 3 or 4 resets.

> in most of our PCIe HW.  In two chips there is only 1 reset in the HW,
> and in the 7712 there are 3 resets in the HW.   You asked me to
> describe all of the resets first at the top level and I have done
> that.  But none of our chips ever use all four.
> 

Then express specific constraints in schema.

Best regards,
Krzysztof


