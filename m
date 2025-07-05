Return-Path: <linux-pci+bounces-31558-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94500AF9EE0
	for <lists+linux-pci@lfdr.de>; Sat,  5 Jul 2025 09:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2EDE168454
	for <lists+linux-pci@lfdr.de>; Sat,  5 Jul 2025 07:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCE11DB924;
	Sat,  5 Jul 2025 07:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwOrt+Ig"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E822E3706;
	Sat,  5 Jul 2025 07:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751701688; cv=none; b=uKf72bGlOsJ8pxDvlGdMJhYony5kCEynRIvbZg+wgz8ZphbCjIgwXVITyjlMH//6HfdYOMPtqouqjqOjn/jVkaZZ5aWmKb5Aq1bMAQ3hlqhyeBgDftEzmPOccVnmRTqaoaoYL55RH/nE4gVOnu53MmR5IboJJYQDJTDulK56uW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751701688; c=relaxed/simple;
	bh=++KifqUfbYRvRlxKq94CtWj3DurfyheFMkPt0HzHSS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e8pkgQd7hfzgBi59tRTKMa8ZatIt+olIHygR2iKEwN569ZnpGMhXQoLTPaXeAL5GeG6Xnam+UTvlF0vGgJd5RTVhi6lX9ezCYnQRTKDJPloe3Gctl6Y1jQsJd+tKFNmi+KrP6MzSu6uqGUJdCJC+iTqOQP93Z+DNciEpM9QOpQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwOrt+Ig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80AC9C4CEE7;
	Sat,  5 Jul 2025 07:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751701687;
	bh=++KifqUfbYRvRlxKq94CtWj3DurfyheFMkPt0HzHSS8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XwOrt+IgliAniBEBc4gFPxJ578ZUpSpB0ZK/DsLMONEgCpv6ktjGBkBZBmEj2x8IG
	 AKhdBRCnM4pizAErq8zdelPXLzqWdu3K3PS4dSSyoINnJiqmqY8tgTv0HKzBXHAvpZ
	 PvFxLeJU8Lm9ZuEj6/TQUH8qrdIQd1/YCp5FQcUl0SwSttZU6cIgdUFQ09wF4h5wk6
	 P5HkSlj0crED3ZIEPnM7MKda1jkCA7JWfBBZOCyXFEMpzZjQNXVyNwFRCpGIShnxob
	 y/5xDnpgaEydh1QfZ2aeEb3Z6HXpA5jC5U/+WdGeOIfZyzCnk7d4hvB8jeIZsKxVeg
	 y8sfU5BREOUBg==
Message-ID: <a2fec2cf-46e2-4436-adc2-8f555a558929@kernel.org>
Date: Sat, 5 Jul 2025 09:47:56 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] dt-bindings: phy: Add PHY bindings support for
 FSD SoC
To: Pankaj Dubey <pankaj.dubey@samsung.com>,
 'Shradha Todi' <shradha.t@samsung.com>, 'Rob Herring' <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-fsd@tesla.com, mani@kernel.org, lpieralisi@kernel.org, kw@linux.com,
 bhelgaas@google.com, jingoohan1@gmail.com, krzk+dt@kernel.org,
 conor+dt@kernel.org, alim.akhtar@samsung.com, vkoul@kernel.org,
 kishon@kernel.org, arnd@arndb.de, m.szyprowski@samsung.com,
 jh80.chung@samsung.com
References: <20250625165229.3458-1-shradha.t@samsung.com>
 <CGME20250625165319epcas5p3721c19f6e6b482438c62dd1ef784de03@epcas5p3.samsung.com>
 <20250625165229.3458-8-shradha.t@samsung.com>
 <20250627211721.GA153863-robh@kernel.org>
 <02af01dbea78$24f01310$6ed03930$@samsung.com>
 <f877b3d7-d770-4424-9813-da748775f456@kernel.org>
 <02bf01dbea8c$fc835cb0$f58a1610$@samsung.com>
 <5ea33054-8a08-4bb3-81e7-d832c53979dc@kernel.org>
 <000101dbece4$d8694d80$893be880$@samsung.com>
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
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJoF1BKBQkWlnSaAAoJEBuTQ307
 QWKbHukP/3t4tRp/bvDnxJfmNdNVn0gv9ep3L39IntPalBFwRKytqeQkzAju0whYWg+R/rwp
 +r2I1Fzwt7+PTjsnMFlh1AZxGDmP5MFkzVsMnfX1lGiXhYSOMP97XL6R1QSXxaWOpGNCDaUl
 ajorB0lJDcC0q3xAdwzRConxYVhlgmTrRiD8oLlSCD5baEAt5Zw17UTNDnDGmZQKR0fqLpWy
 786Lm5OScb7DjEgcA2PRm17st4UQ1kF0rQHokVaotxRM74PPDB8bCsunlghJl1DRK9s1aSuN
 hL1Pv9VD8b4dFNvCo7b4hfAANPU67W40AaaGZ3UAfmw+1MYyo4QuAZGKzaP2ukbdCD/DYnqi
 tJy88XqWtyb4UQWKNoQqGKzlYXdKsldYqrLHGoMvj1UN9XcRtXHST/IaLn72o7j7/h/Ac5EL
 8lSUVIG4TYn59NyxxAXa07Wi6zjVL1U11fTnFmE29ALYQEXKBI3KUO1A3p4sQWzU7uRmbuxn
 naUmm8RbpMcOfa9JjlXCLmQ5IP7Rr5tYZUCkZz08LIfF8UMXwH7OOEX87Y++EkAB+pzKZNNd
 hwoXulTAgjSy+OiaLtuCys9VdXLZ3Zy314azaCU3BoWgaMV0eAW/+gprWMXQM1lrlzvwlD/k
 whyy9wGf0AEPpLssLVt9VVxNjo6BIkt6d1pMg6mHsUEVzsFNBFVDXDQBEADNkrQYSREUL4D3
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
 YpsFAmgXUF8FCRaWWyoACgkQG5NDfTtBYptO0w//dlXJs5/42hAXKsk+PDg3wyEFb4NpyA1v
 qmx7SfAzk9Hf6lWwU1O6AbqNMbh6PjEwadKUk1m04S7EjdQLsj/MBSgoQtCT3MDmWUUtHZd5
 RYIPnPq3WVB47GtuO6/u375tsxhtf7vt95QSYJwCB+ZUgo4T+FV4hquZ4AsRkbgavtIzQisg
 Dgv76tnEv3YHV8Jn9mi/Bu0FURF+5kpdMfgo1sq6RXNQ//TVf8yFgRtTUdXxW/qHjlYURrm2
 H4kutobVEIxiyu6m05q3e9eZB/TaMMNVORx+1kM3j7f0rwtEYUFzY1ygQfpcMDPl7pRYoJjB
 dSsm0ZuzDaCwaxg2t8hqQJBzJCezTOIkjHUsWAK+tEbU4Z4SnNpCyM3fBqsgYdJxjyC/tWVT
 AQ18NRLtPw7tK1rdcwCl0GFQHwSwk5pDpz1NH40e6lU+NcXSeiqkDDRkHlftKPV/dV+lQXiu
 jWt87ecuHlpL3uuQ0ZZNWqHgZoQLXoqC2ZV5KrtKWb/jyiFX/sxSrodALf0zf+tfHv0FZWT2
 zHjUqd0t4njD/UOsuIMOQn4Ig0SdivYPfZukb5cdasKJukG1NOpbW7yRNivaCnfZz6dTawXw
 XRIV/KDsHQiyVxKvN73bThKhONkcX2LWuD928tAR6XMM2G5ovxLe09vuOzzfTWQDsm++9UKF a/A=
In-Reply-To: <000101dbece4$d8694d80$893be880$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/07/2025 15:09, Pankaj Dubey wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzk@kernel.org>
>> Sent: Thursday, July 3, 2025 1:48 AM
>> To: Shradha Todi <shradha.t@samsung.com>; 'Rob Herring'
>> <robh@kernel.org>
>> Cc: linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; linux-
>> kernel@vger.kernel.org; linux-phy@lists.infradead.org; linux-fsd@tesla.com;
>> mani@kernel.org; lpieralisi@kernel.org; kw@linux.com;
>> bhelgaas@google.com; jingoohan1@gmail.com; krzk+dt@kernel.org;
>> conor+dt@kernel.org; alim.akhtar@samsung.com; vkoul@kernel.org;
>> kishon@kernel.org; arnd@arndb.de; m.szyprowski@samsung.com;
>> jh80.chung@samsung.com; pankaj.dubey@samsung.com
>> Subject: Re: [PATCH v2 07/10] dt-bindings: phy: Add PHY bindings support for
>> FSD SoC
>>
>> On 01/07/2025 15:35, Shradha Todi wrote:
>>>>> does not support auto adaptation so we need to tune the PHYs
>>>>> according to the use case (considering channel loss, etc). This is
>>>>> why we
>>>>
>>>> So not same? Decide. Either it is same or not, cannot be both.
>>>>
>>>> If you mean that some wiring is different on the board, then how does
>>>> it differ in soc thus how it is per-soc property? If these are
>>>> use-cases, then how is even suitable for DT?
>>>>
>>>> I use your Tesla FSD differently and then I exchange DTSI and compatibles?
>>>>
>>>> You are no describing real problem and both binding and your
>>>> explanations are vague and imprecise. Binding tells nothing about it,
>>>> so it is example of skipping important decisions.
>>>>
>>>>> have 2 different SW PHY initialization sequence depending on the
>>>>> instance number. Do you think having different compatible (something
>>>>> like
>>>>> tesla,fsd-pcie-phy0 and tesla,fsd-pcie-phy1) and having phy ID as
>>>>> platform data is okay in this case? I actually took reference from files like:
>>>>
>>>> And in different use case on same soc you are going to reverse
>>>> compatibles or instance IDs?
>>>>
>>>
>>> Even though both the PHYs are exactly identical in terms of hardware,
>>> they need to be programmed/initialized/configured differently.
>>>
>>> Sorry for my misuse of the word "use-case". To clarify, these
>>> configurations will always remain the same for FSD SoC even if you use it
>> differently.
>>>
>>> I will use different compatibles for them as I understand that it is
>>> the best option.
>>
>> I still do not see the difference in hardware explained.
>>
> 
> Hi Krzysztof 
> 
> Let me add more details and see if that makes sense to understand the intention
> behind the current design of the PHY driver.
> 
> In FSD SoC, the two PHY instances, although having identical hardware design and
> register maps, are placed in different locations (Placement and routing) inside the
> SoC and have distinct PHY-to-Controller topologies. 
> 
> One instance is connected to two PCIe controllers, while the other is connected to
> only one. As a result, they experience different analog environments, including
> varying channel losses and noise profiles.
> 
> Since these PHYs lack internal adaptation mechanisms and f/w based tuning,
> manual register programming is required for analog tuning, such as equalization,
> de-emphasis, and gain. To ensure optimal signal integrity, it is essential to use different
> register values for each PHY instance, despite their identical hardware design.
> This is because the same register values may not be suitable for both instances due to
> their differing environments and topologies.
> 
> Do let us know if this explains the intention behind separate programming sequence
> for both instance of the PHY?
Thanks, it explains and it should be in binding description if you go
with different compatible, but you should first check if existing
properties do not describe these differences enough, e.g. num-lanes,
max-link-speed.

equalization has its own properties for example.

Best regards,
Krzysztof

