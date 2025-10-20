Return-Path: <linux-pci+bounces-38721-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806D7BF0844
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 12:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33C2D3AB911
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 10:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FD02F7AA8;
	Mon, 20 Oct 2025 10:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XH//neKq"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D9E2F5A02;
	Mon, 20 Oct 2025 10:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760955800; cv=none; b=D61aOzpNp8cPAyH5nuBL7L0vl/ky4ldqK/EMFdvSC6YrX7zRq2owhwejWCoEITTpzf9QqLhZ75NEkwv2GELQC/RIwXc3WaclMgD63UiyndLwDVmGdZV3ycggva5aPJCRi90FFYeYPtdMoCFxbaqOAnyrmcbb7r9t63OI3V7CwLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760955800; c=relaxed/simple;
	bh=OxzG71sDwuES4H6I4qFPGwWEW0NNXV3gRKLkV68zpaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PSyqSGuUkR5aIeic0UTQHy4kUt2Kc81bOTx/HUme4zOZRC4qEhOu1ntvwXUOHSCbQ/AOFwf1VIumBS85hcKvXHySTivmslgkcuGJ5i50cJ032NfcWpKcAJ+z5FQ7b27f+eMjSfe9nhfSa916ITYusmz8I2yZEkYkYWY6Ej3JGOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XH//neKq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760955796;
	bh=OxzG71sDwuES4H6I4qFPGwWEW0NNXV3gRKLkV68zpaE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XH//neKq+w5ZgmjiqKKIco53S1kTKoUN8zlzWGaHQ8eqMxEhNaqwvK724JMy91qct
	 SqKfpex0IJtdEjSv88RB15h0kV/JycwfSC8bTA9LFfHIQZ10PQ0ES8GNIIQxrZ5snr
	 JC939XvsPv0CDkgO+8enjSZ0MeRrXJ8axcyu5SVnYUQCPZJo4aiiXMCUE2ZvWpDXp/
	 /crTyWIfJAIkew8Hpq8q2uyIhqben3OMy18dM0yJ/3dpAn3KiSJym0YV91fopaPvOR
	 AEYNXvHbCVg4i4NP3th6xaoTA5npM+/tS1btPBBSuu+/OVxIOjV1hSX+EOX8JAWqT0
	 E8WFxFyEYHcoQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 462D917E04DA;
	Mon, 20 Oct 2025 12:23:15 +0200 (CEST)
Message-ID: <82594ce7-f093-4753-b808-cd234845aed8@collabora.com>
Date: Mon, 20 Oct 2025 12:23:14 +0200
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
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <aPEfUBl6fMe6QYdY@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/10/25 18:37, Daniel Golle ha scritto:
> On Thu, Oct 16, 2025 at 04:29:14PM +0200, AngeloGioacchino Del Regno wrote:
>> Il 16/10/25 14:38, Daniel Golle ha scritto:
>>> On Thu, Oct 16, 2025 at 12:08:38PM +0200, Sjoerd Simons wrote:
>>>> Add explicit pinctrl configuration for UART0 on the OpenWrt One board,
>>>>
>>>> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
>>>> ---
>>>>    arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts | 11 +++++++++++
>>>>    1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
>>>> index 968b91f55bb27..f836059d7f475 100644
>>>> --- a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
>>>> +++ b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
>>>> @@ -22,6 +22,17 @@ memory@40000000 {
>>>>    	};
>>>>    };
>>>> +&pio {
>>>> +	uart0_pins: uart0-pins {
>>>> +		mux {
>>>> +			function = "uart";
>>>> +			groups = "uart0";
>>>> +		};
>>>> +	};
>>>> +};
>>>> +
>>>>    &uart0 {
>>>> +	pinctrl-names = "default";
>>>> +	pinctrl-0 = <&uart0_pins>;
>>>>    	status = "okay";
>>>>    };
>>>
>>> As there is only a single possible pinctrl configuration for uart0,
>>> both the pinmux definition as well as the pinctrl properties should go
>>> into mt7981b.dtsi rather than in the board's dts.
>>
>> If there's really one single possible pin configuration for the UART0 pins,
>> as in, those pins *do not* have a GPIO mode, then yes I agree.
>>
>> If those pins can be as well configured as GPIOs, this goes to board DTS.
> 
> I respectfully disagree and will explain below.
> 

Thanks a lot for taking the time to write all this - explains everything,
and even too much :) :)

Though, there's something funny here! The following snippet of "main" text
does explain stuff that is interesting, but that I (not other people, so
thanks again for saying all this) know already, but.....

> All pinmux pins on the MediaTek platform also allow being configured as
> GPIOs. However, if you configure those as GPIOs the consequence is that
> you cannot use UART0 any more at all. So using UART0 at all always
> implies using exactly those pins, there is no alternative to that.
> 
> Hence every board with every possible uses of pins 32 and 33 (there is
> only RX and TX for UART0, RTS/CTS flow-control is not possible) can be
> represented without needing to configure the pinctrl for uart0 on the
> board level. There isn't going to be any variation on the board-level
> when it comes to uart0. Either it is enabled (status = "okay";), and
> that will always imply using the 'uart0' group in mode 'uart', or, in
> case any of the two pins of uart0 is used for something else that means
> uart0 cannot be enabled. Simple as that.
> 
> Hence there is no need to duplicate that pinctrl settings on each and
> every board, as controlling the 'status' property on the board-level
> already gives 100% freedom.
> 

...all of this is not justifying your point.

> (Sidenote: As even the BootROM already uses those two pins as UART for
> debug output,

Funny thing is, your side note is what *fully* justifies your disagreement
and it's also what triggers me to say that you're right, lol :)

Okay then, I am fine with this commit now and I can renew my

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers!
Angelo

> it is very unlikely that anyone would actually use them
> for anything else in production. Apart from being used as GPIOs you can
> also use pins 32 and 33 as an I2C target for external debug access to the
> registers of either the sgmii0_phy, sgmii1_phy or u3_phy. However, that
> doesn't matter in terms of the debate above, as the crucial point there
> is that using uart0 always implies using group 'uart0' in 'uart' mode.)



