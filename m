Return-Path: <linux-pci+bounces-38759-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF5FBF1B2D
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 16:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C59BB34CE20
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 14:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DD32FB619;
	Mon, 20 Oct 2025 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VDIf1diV"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1755E1607A4;
	Mon, 20 Oct 2025 14:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968985; cv=none; b=er6/HhnW2FtAVOdaSTg8QfA5VhAzBPauoBgnaTg8ADX6ehiSR1rMefNa03wYRkFFVZzRTEbdHOOHFqUdQCLuaYJKO9WBvSOKrvq3OYhCm82Vpk+RhQZfp6SVtavCZTKs0ddMpsyK1oIqEK2acvKW5hFqsR7fBR9I4o8OZOolaiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968985; c=relaxed/simple;
	bh=wa/LFx+3nxvEsI8+aKge1iAS1QhaGGNlrbnB3buk7SI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HftYHxLPBzUlqB084iKcrqOIuVmj5d7lNMD2bMxYCZjoDRhMnflXYr2YdZ6XAXPeGU2c4+tUPVuqh4CTM9wl7tci9vBkLUz+Lcq4zfP4WxNirXrVuMAs1V5MuyGdixgQx29K/vXedFxxVJIBJ3sqYVqgj4wpbdpfRuqlmzAgafA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VDIf1diV; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760968980;
	bh=wa/LFx+3nxvEsI8+aKge1iAS1QhaGGNlrbnB3buk7SI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VDIf1diVrnftwL38ZREdQLDRwHdtKgievZhFbibJhQFutwAztvjM5o0Ofy8B+MuJ1
	 gbB2fB5zCNc+lFbJoxBbEDZzf1uheBzC+Nlx9sun+NUI/d/KYBq3Ff28STT0H965tq
	 nnrbsAdRosSrONRkoiNeZgNC8PuvSRPgPpkICA0Q54jAzdpR5hhw1tu2Y1cS27zwJX
	 FRg9vM1KZf5TCg1umqLDbOg3lDUSE36e1IEZJfrh77+iTevPfFGOU0jL5YfxqKJ1H/
	 gzueE+BKPyTjIQVERY1kpaRD5P4l5aKwVvJQygCbM/bzM0GDjLk7n4Ja3+QPhI/Axl
	 9w4l4cXjKqsWA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0AF5A17E0456;
	Mon, 20 Oct 2025 16:02:59 +0200 (CEST)
Message-ID: <8453efd3-630e-4f2c-950d-88a73927cc54@collabora.com>
Date: Mon, 20 Oct 2025 16:02:58 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] arm64: dts: mediatek: mt7981b-openwrt-one:
 Configure UART0 pinmux
To: Daniel Golle <daniel@makrotopia.org>
Cc: Sjoerd Simons <sjoerd@collabora.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang
 <jianjun.wang@mediatek.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Lee Jones <lee@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 kernel@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-phy@lists.infradead.org, netdev@vger.kernel.org,
 Bryan Hinton <bryan@bryanhinton.com>
References: <20251016-openwrt-one-network-v1-0-de259719b6f2@collabora.com>
 <20251016-openwrt-one-network-v1-2-de259719b6f2@collabora.com>
 <aPDnT4tuSzNDzyAE@makrotopia.org>
 <5f430ff9-d701-426a-bf93-5290e6912eb4@collabora.com>
 <aPEfUBl6fMe6QYdY@makrotopia.org>
 <82594ce7-f093-4753-b808-cd234845aed8@collabora.com>
 <aPYq4cnaAHu5ags5@makrotopia.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <aPYq4cnaAHu5ags5@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/10/25 14:28, Daniel Golle ha scritto:
> On Mon, Oct 20, 2025 at 12:23:14PM +0200, AngeloGioacchino Del Regno wrote:
>> Il 16/10/25 18:37, Daniel Golle ha scritto:
>>> On Thu, Oct 16, 2025 at 04:29:14PM +0200, AngeloGioacchino Del Regno wrote:
>>>> Il 16/10/25 14:38, Daniel Golle ha scritto:
>>>>> On Thu, Oct 16, 2025 at 12:08:38PM +0200, Sjoerd Simons wrote:
>>>>>> Add explicit pinctrl configuration for UART0 on the OpenWrt One board,
>>>>>>
>>>>>> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
>>>>>> ---
>>>>>>     arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts | 11 +++++++++++
>>>>>>     1 file changed, 11 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
>>>>>> index 968b91f55bb27..f836059d7f475 100644
>>>>>> --- a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
>>>>>> +++ b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
>>>>>> @@ -22,6 +22,17 @@ memory@40000000 {
>>>>>>     	};
>>>>>>     };
>>>>>> +&pio {
>>>>>> +	uart0_pins: uart0-pins {
>>>>>> +		mux {
>>>>>> +			function = "uart";
>>>>>> +			groups = "uart0";
>>>>>> +		};
>>>>>> +	};
>>>>>> +};
>>>>>> +
>>>>>>     &uart0 {
>>>>>> +	pinctrl-names = "default";
>>>>>> +	pinctrl-0 = <&uart0_pins>;
>>>>>>     	status = "okay";
>>>>>>     };
>>>>>
>>>>> As there is only a single possible pinctrl configuration for uart0,
>>>>> both the pinmux definition as well as the pinctrl properties should go
>>>>> into mt7981b.dtsi rather than in the board's dts.
>>>>
>>>> If there's really one single possible pin configuration for the UART0 pins,
>>>> as in, those pins *do not* have a GPIO mode, then yes I agree.
>>>>
>>>> If those pins can be as well configured as GPIOs, this goes to board DTS.
>>>
>>> I respectfully disagree and will explain below.
>>>
>>
>> Thanks a lot for taking the time to write all this - explains everything,
>> and even too much :) :)
>>
>> Though, there's something funny here! The following snippet of "main" text
>> does explain stuff that is interesting, but that I (not other people, so
>> thanks again for saying all this) know already, but.....
>>
>>> All pinmux pins on the MediaTek platform also allow being configured as
>>> GPIOs. However, if you configure those as GPIOs the consequence is that
>>> you cannot use UART0 any more at all. So using UART0 at all always
>>> implies using exactly those pins, there is no alternative to that.
>>>
>>> Hence every board with every possible uses of pins 32 and 33 (there is
>>> only RX and TX for UART0, RTS/CTS flow-control is not possible) can be
>>> represented without needing to configure the pinctrl for uart0 on the
>>> board level. There isn't going to be any variation on the board-level
>>> when it comes to uart0. Either it is enabled (status = "okay";), and
>>> that will always imply using the 'uart0' group in mode 'uart', or, in
>>> case any of the two pins of uart0 is used for something else that means
>>> uart0 cannot be enabled. Simple as that.
>>>
>>> Hence there is no need to duplicate that pinctrl settings on each and
>>> every board, as controlling the 'status' property on the board-level
>>> already gives 100% freedom.
>>>
>>
>> ...all of this is not justifying your point.
> 
> So what is the rule then? I understand the logic of describing the
> pins eg. for uart1 only on board-level as there are actual alternatives
> regarding the pins to be used, and if also including RTS/CTS pins.
> Hence, for uart1, there are several possible pingroups which can be
> used. What would be the argument to keep a pinctrl description for
> which the SoC doesn't offer any alternatives to be on the board-level?
> There is nothing to be decided by the board, literally 0 freedom.
> 

As you described - the BootROM is using those two pins as UART0.

Should you want those pins to be used as GPIOs, you'd at least get HW glitches in
early boot phases, or you'd render emergency download mode unusable - which is not
a good idea, not practical, and also, well, almost a stupid thing to do from the
hardware perspective.

This means that it is very, very, very unlikely (to the point that it's practically
impossible) that those pins can ever be used for anything else that is not *the*
one of the two functions that are supported for them (which is UART0 in this case).

In this case, adding the pins at the board level would only create unnecessary
duplication and nothing else, because, well, noone could possibly ever use those
for anything else, again.

That's the criteria.

If the BootROM didn't use those pins, and those could support both GPIO mode and
HW function mode (any: uart0, 1, 2...n, spi, i2c, whatever else), even though it
is likely for boards to use them for one specific function, there is nothing that
stops a HW engineer to decide to route those elsewhere and use them as a GPIO
instead, so that's not a SoC configuration, but rather a HW implementation decision
at the PCB level.

See it like this (although this is an oversimplified view):
  - SoC DT describes the SoC (the chip) - in this case the MT7981B chip
  - Board DT describes decisions that were taken by the HW engineer that developed
    the PCB on which the MT7981B was placed.

Clearly, if there's a board design (usually, a "base project") that has derivatives
(for example, a device with eMMC, one with UFS, one with both, one with two SFP,
one with one SFP and one soldered ethernet chip on a non-exposed SFP interface,
etc) it is ok to have a "board-common" dtsi and specific board variants on top,
like it is done with some bananapi and some genio boards.

Lots of text here - yet oversimplified. There is much more to say, but I think
(and hope) that this is enough to make you understand the main point (of course
feel free to throw more questions if what I wrote doesn't fully satisfy you).

>>
>>> (Sidenote: As even the BootROM already uses those two pins as UART for
>>> debug output,
>>
>> Funny thing is, your side note is what *fully* justifies your disagreement
>> and it's also what triggers me to say that you're right, lol :)
>>
>> Okay then, I am fine with this commit now and I can renew my
>>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Note that the patch you have just added your Reviewed-by:-tag to does
> *not* add the uart0 pinctrl on SoC-level but board-level, so different
> from what I argued for above.

Ewwww I'm doing too may things at once. Pretty crazy days around here :)))

 >> Did you mean to add Reviewed-by: for that
> (which contraticts what you just wrote) or rather to the to-be-submitted
> v2 of this series which includes the change to move the uart0 pinctrl
> to mt7981b.dtsi?

Yeah. Sorry.

I repeat then, so that this is clear: you are right, the pinctrl for UART0 on the
MT7981B SoC must go to mt7981b.dtsi and *not* to mt7981b-openwrt-one.

Cheers,
Angelo

