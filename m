Return-Path: <linux-pci+bounces-19499-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B1AA05452
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 08:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6D107A1FA7
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 07:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B671A9B55;
	Wed,  8 Jan 2025 07:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLsyw3M+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382451A7264;
	Wed,  8 Jan 2025 07:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736320579; cv=none; b=IM9UF7dFUadreAt5vQKb6lKf+AcwWi2e4VcHfS2hoR11zUlE/a9QA9ubjnN2e/BCzgfZ4NuARE3JKdgJtBDK6y8jYPVIprJahzQy9Q13qCuRwEqSDF0cb3o4y0pxLis9QqAiTuceFN84jizcLQVvTUzgmLPeeHbMrwpne5mIQsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736320579; c=relaxed/simple;
	bh=/nZWOZiAApJjEeZw8vk1otC1prkpz+lJLIdowQPpjys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dHZshh7ROcs8R3GiU2D2xZhAlBImKqCMEAZzwRCL1EEn/yEbwpxM4RHfw+ehSN6FpPyW4RNvgaCmmIgTJsk8iGoPCQkqgeRcuf1iC6UqZoerqmXD6o/o1m09ad6YkEz4J2AeKQOWpFtF29aKZOmGhKaGHD4Uz20nAe0i4bjkyCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLsyw3M+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C136C4CEE0;
	Wed,  8 Jan 2025 07:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736320578;
	bh=/nZWOZiAApJjEeZw8vk1otC1prkpz+lJLIdowQPpjys=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HLsyw3M+3Pa17joy1bRfI9u5T7eGbFbYAN7qMyv6s4H7l3qY/73g5yCdSRi0ekuGu
	 BcbvrPAYZARHS91tJHAZZFjSU/aStVwPmvzvSiOaDYAB4fJYVLCBGb65dNvncQJ8Gn
	 SG8RV9/wt2UiEgcRioOKfDjOMJii6lKSDksNKz1pVgppcgBxPCkNkp73PWIryu5Dah
	 grvp4BEdC82tXh7y/aps8o7mLM+nUGgu9vJn+19Y4Z7j1X0hkfUOKP41nnCsPzkQpO
	 gD2O0A4As1KPr8uxaBKr+NaGsGjwTZayoEuIslvDtFbFqABWqdGezA/IGO2yCZg6X+
	 ttyihQrsxJRLg==
Message-ID: <14a456bd-3f24-4daf-9329-873d0f051a83@kernel.org>
Date: Wed, 8 Jan 2025 08:16:10 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: PCI: mediatek-gen3: Add MT8196 support
To: =?UTF-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= <Jianjun.Wang@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 Ryder Lee <Ryder.Lee@mediatek.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 =?UTF-8?B?WGF2aWVyIENoYW5nICjlvLXnjbvmlocp?= <Xavier.Chang@mediatek.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>
References: <20250103060035.30688-1-jianjun.wang@mediatek.com>
 <20250103060035.30688-2-jianjun.wang@mediatek.com>
 <ndj6j2mmylipr7mxg42f3lcwgx55cvcjnuuofmlk6n6t5uz5pr@bxugolyfublc>
 <04ae2a07e2c2d3c03e82596034b1b7711450a0ae.camel@mediatek.com>
 <eb2088d3-81f6-4cb8-a4d7-6ef985aedbda@kernel.org>
 <9b0a463312702fb78e4ca2ba79c9ec6b62e33c58.camel@mediatek.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJgPO8PBQkUX63hAAoJEBuTQ307
 QWKbBn8P+QFxwl7pDsAKR1InemMAmuykCHl+XgC0LDqrsWhAH5TYeTVXGSyDsuZjHvj+FRP+
 gZaEIYSw2Yf0e91U9HXo3RYhEwSmxUQ4Fjhc9qAwGKVPQf6YuQ5yy6pzI8brcKmHHOGrB3tP
 /MODPt81M1zpograAC2WTDzkICfHKj8LpXp45PylD99J9q0Y+gb04CG5/wXs+1hJy/dz0tYy
 iua4nCuSRbxnSHKBS5vvjosWWjWQXsRKd+zzXp6kfRHHpzJkhRwF6ArXi4XnQ+REnoTfM5Fk
 VmVmSQ3yFKKePEzoIriT1b2sXO0g5QXOAvFqB65LZjXG9jGJoVG6ZJrUV1MVK8vamKoVbUEe
 0NlLl/tX96HLowHHoKhxEsbFzGzKiFLh7hyboTpy2whdonkDxpnv/H8wE9M3VW/fPgnL2nPe
 xaBLqyHxy9hA9JrZvxg3IQ61x7rtBWBUQPmEaK0azW+l3ysiNpBhISkZrsW3ZUdknWu87nh6
 eTB7mR7xBcVxnomxWwJI4B0wuMwCPdgbV6YDUKCuSgRMUEiVry10xd9KLypR9Vfyn1AhROrq
 AubRPVeJBf9zR5UW1trJNfwVt3XmbHX50HCcHdEdCKiT9O+FiEcahIaWh9lihvO0ci0TtVGZ
 MCEtaCE80Q3Ma9RdHYB3uVF930jwquplFLNF+IBCn5JRzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmA872oFCRRflLYACgkQG5NDfTtBYpvScw/9GrqBrVLuJoJ52qBBKUBDo4E+5fU1bjt0
 Gv0nh/hNJuecuRY6aemU6HOPNc2t8QHMSvwbSF+Vp9ZkOvrM36yUOufctoqON+wXrliEY0J4
 ksR89ZILRRAold9Mh0YDqEJc1HmuxYLJ7lnbLYH1oui8bLbMBM8S2Uo9RKqV2GROLi44enVt
 vdrDvo+CxKj2K+d4cleCNiz5qbTxPUW/cgkwG0lJc4I4sso7l4XMDKn95c7JtNsuzqKvhEVS
 oic5by3fbUnuI0cemeizF4QdtX2uQxrP7RwHFBd+YUia7zCcz0//rv6FZmAxWZGy5arNl6Vm
 lQqNo7/Poh8WWfRS+xegBxc6hBXahpyUKphAKYkah+m+I0QToCfnGKnPqyYIMDEHCS/RfqA5
 t8F+O56+oyLBAeWX7XcmyM6TGeVfb+OZVMJnZzK0s2VYAuI0Rl87FBFYgULdgqKV7R7WHzwD
 uZwJCLykjad45hsWcOGk3OcaAGQS6NDlfhM6O9aYNwGL6tGt/6BkRikNOs7VDEa4/HlbaSJo
 7FgndGw1kWmkeL6oQh7wBvYll2buKod4qYntmNKEicoHGU+x91Gcan8mCoqhJkbqrL7+nXG2
 5Q/GS5M9RFWS+nYyJh+c3OcfKqVcZQNANItt7+ULzdNJuhvTRRdC3g9hmCEuNSr+CLMdnRBY fv0=
In-Reply-To: <9b0a463312702fb78e4ca2ba79c9ec6b62e33c58.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/01/2025 09:43, Jianjun Wang (王建军) wrote:
> On Mon, 2025-01-06 at 13:27 +0100, Krzysztof Kozlowski wrote:
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>
>>
>> On 06/01/2025 10:26, Jianjun Wang (王建军) wrote:
>>> On Fri, 2025-01-03 at 10:10 +0100, Krzysztof Kozlowski wrote:
>>>> External email : Please do not click links or open attachments
>>>> until
>>>> you have verified the sender or the content.
>>>>
>>>>
>>>> On Fri, Jan 03, 2025 at 02:00:11PM +0800, Jianjun Wang wrote:
>>>>> +        clock-names:
>>>>> +          items:
>>>>> +            - const: pl_250m
>>>>> +            - const: tl_26m
>>>>> +            - const: peri_26m
>>>>> +            - const: peri_mem
>>>>> +            - const: ahb_apb
>>>>> +            - const: low_power
>>>>> +
>>>>> +        resets:
>>>>> +          minItems: 1
>>>>> +          maxItems: 2
>>>>> +
>>>>> +        reset-names:
>>>>> +          minItems: 1
>>>>> +          maxItems: 2
>>>>
>>>> Why resets are flexible?
>>>
>>> There are two resets, one for MAC and another for PHY, some
>>> platforms
>>> may only use one of them.
>>
>> Even more questions. What does it mean use? Is it there or is it not?
> 
> It will be used by calling the reset controller's APIs in the PCIe
> controller driver. Ideally, it should be de-asserted before PCIe
> initialization and should be asserted if PCIe powers down or the driver
> is removed.

So it is there? Then drop minItems.

> 
>> Platform like SoC? But this is one specific SoC, it cannot be used on
>> different SoC.
> 
> Yes, it should be SoC, each SoC have its own resets, and the number of
> resets for each SoC is defined by the hardware design, most SoCs should
> have one reset for MAC and one reset for PHY.

You respond with some obvious things, so this review won't work.
Properties are supposed to be constrained. Your arguments that something
else has something else, do not apply. It does not matter what something
else has.

> 
>>
>>>
>>> Would you prefer to set the number of resets to a fixed value for
>>> specific platforms?
>>
>> Everything should be constrained to match hardware.
> 
> For MT8196, there are 2 resets. Should I use a fixed item in this case?

Yes. I asked why this soc has this flexible and you speak about some
other socs.



Best regards,
Krzysztof

