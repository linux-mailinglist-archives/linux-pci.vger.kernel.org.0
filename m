Return-Path: <linux-pci+bounces-38783-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F390DBF29A9
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 19:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80C8918A3901
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 17:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E9A330B2E;
	Mon, 20 Oct 2025 17:05:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891C42882B8;
	Mon, 20 Oct 2025 17:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979956; cv=none; b=fpm/NTj5VyFgI6LZpXC77qqWMnew91jH/6HX6W5SSgRV3H+FJKkceP9b/lpmP9gosiTCsbKr4BJN/C0T94eI97FAV8QeNAzq9esDadcLZmoNpXf0gPlZVToQSMq//P/Dn3a25994BaXdSj/9ofU6Yx5e7QkqD3cYKthFNYkOHjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979956; c=relaxed/simple;
	bh=uZtaVriTqVLLo5gfQFnqRnYNj4ib4262oLWhM+jcAa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f36DKnfelsDwTZJ8HZyFX27trLeYeHfb11HAmWhLdattRRPq2vZsV55/8ZXQT5k36HR2qQh2sDK4bn9aYynlXdDWiEcurSUP2LY3k8C6B+at8En2keAh1ZjfTAVEJTSnk4UR5VSaujxCBodwoGRTYRzlpaPoPWZStC8Flnkxf9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vAtKD-000000005HU-0nRf;
	Mon, 20 Oct 2025 17:05:37 +0000
Date: Mon, 20 Oct 2025 18:05:33 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Sjoerd Simons <sjoerd@collabora.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Lee Jones <lee@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	kernel@collabora.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org, netdev@vger.kernel.org,
	Bryan Hinton <bryan@bryanhinton.com>
Subject: Re: [PATCH 02/15] arm64: dts: mediatek: mt7981b-openwrt-one:
 Configure UART0 pinmux
Message-ID: <aPZr3WMybjTWnn9E@makrotopia.org>
References: <20251016-openwrt-one-network-v1-0-de259719b6f2@collabora.com>
 <20251016-openwrt-one-network-v1-2-de259719b6f2@collabora.com>
 <aPDnT4tuSzNDzyAE@makrotopia.org>
 <5f430ff9-d701-426a-bf93-5290e6912eb4@collabora.com>
 <aPEfUBl6fMe6QYdY@makrotopia.org>
 <82594ce7-f093-4753-b808-cd234845aed8@collabora.com>
 <aPYq4cnaAHu5ags5@makrotopia.org>
 <8453efd3-630e-4f2c-950d-88a73927cc54@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8453efd3-630e-4f2c-950d-88a73927cc54@collabora.com>

On Mon, Oct 20, 2025 at 04:02:58PM +0200, AngeloGioacchino Del Regno wrote:
> Il 20/10/25 14:28, Daniel Golle ha scritto:
> > On Mon, Oct 20, 2025 at 12:23:14PM +0200, AngeloGioacchino Del Regno wrote:
> > > Il 16/10/25 18:37, Daniel Golle ha scritto:
> > > > On Thu, Oct 16, 2025 at 04:29:14PM +0200, AngeloGioacchino Del Regno wrote:
> > > > > Il 16/10/25 14:38, Daniel Golle ha scritto:
> > > > > > On Thu, Oct 16, 2025 at 12:08:38PM +0200, Sjoerd Simons wrote:
> > > > > > > Add explicit pinctrl configuration for UART0 on the OpenWrt One board,
> > > > > > > 
> > > > > > > Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> > > > > > > ---
> > > > > > >     arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts | 11 +++++++++++
> > > > > > >     1 file changed, 11 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
> > > > > > > index 968b91f55bb27..f836059d7f475 100644
> > > > > > > --- a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
> > > > > > > +++ b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
> > > > > > > @@ -22,6 +22,17 @@ memory@40000000 {
> > > > > > >     	};
> > > > > > >     };
> > > > > > > +&pio {
> > > > > > > +	uart0_pins: uart0-pins {
> > > > > > > +		mux {
> > > > > > > +			function = "uart";
> > > > > > > +			groups = "uart0";
> > > > > > > +		};
> > > > > > > +	};
> > > > > > > +};
> > > > > > > +
> > > > > > >     &uart0 {
> > > > > > > +	pinctrl-names = "default";
> > > > > > > +	pinctrl-0 = <&uart0_pins>;
> > > > > > >     	status = "okay";
> > > > > > >     };
> > > > > > 
> > > > > > As there is only a single possible pinctrl configuration for uart0,
> > > > > > both the pinmux definition as well as the pinctrl properties should go
> > > > > > into mt7981b.dtsi rather than in the board's dts.
> > > > > 
> > > > > If there's really one single possible pin configuration for the UART0 pins,
> > > > > as in, those pins *do not* have a GPIO mode, then yes I agree.
> > > > > 
> > > > > If those pins can be as well configured as GPIOs, this goes to board DTS.
> > > > 
> > > > I respectfully disagree and will explain below.
> > > > 
> > > 
> > > Thanks a lot for taking the time to write all this - explains everything,
> > > and even too much :) :)
> > > 
> > > Though, there's something funny here! The following snippet of "main" text
> > > does explain stuff that is interesting, but that I (not other people, so
> > > thanks again for saying all this) know already, but.....
> > > 
> > > > All pinmux pins on the MediaTek platform also allow being configured as
> > > > GPIOs. However, if you configure those as GPIOs the consequence is that
> > > > you cannot use UART0 any more at all. So using UART0 at all always
> > > > implies using exactly those pins, there is no alternative to that.
> > > > 
> > > > Hence every board with every possible uses of pins 32 and 33 (there is
> > > > only RX and TX for UART0, RTS/CTS flow-control is not possible) can be
> > > > represented without needing to configure the pinctrl for uart0 on the
> > > > board level. There isn't going to be any variation on the board-level
> > > > when it comes to uart0. Either it is enabled (status = "okay";), and
> > > > that will always imply using the 'uart0' group in mode 'uart', or, in
> > > > case any of the two pins of uart0 is used for something else that means
> > > > uart0 cannot be enabled. Simple as that.
> > > > 
> > > > Hence there is no need to duplicate that pinctrl settings on each and
> > > > every board, as controlling the 'status' property on the board-level
> > > > already gives 100% freedom.
> > > > 
> > > 
> > > ...all of this is not justifying your point.
> > 
> > So what is the rule then? I understand the logic of describing the
> > pins eg. for uart1 only on board-level as there are actual alternatives
> > regarding the pins to be used, and if also including RTS/CTS pins.
> > Hence, for uart1, there are several possible pingroups which can be
> > used. What would be the argument to keep a pinctrl description for
> > which the SoC doesn't offer any alternatives to be on the board-level?
> > There is nothing to be decided by the board, literally 0 freedom.
> > 
> 
> As you described - the BootROM is using those two pins as UART0.
> 
> Should you want those pins to be used as GPIOs, you'd at least get HW glitches in
> early boot phases, or you'd render emergency download mode unusable - which is not
> a good idea, not practical, and also, well, almost a stupid thing to do from the
> hardware perspective.

No, that's not a problem. During reset the pinctrl/gpio controller is always
reset to the default and no matter how the pins were used in Linux before the
reset. Hence debug output and also emrgency download mode always works.
The only disadvantage of use the pins differently is that the bootrom output
on one of them cannot be prevented -- but in case that's not a problem (eg.
because the pin is later used as an input rather than output) it can totally
be done, though it would be stupid as it would render the debug UART unusable.
Yet, I'd consider it a possible choice of a board designer.

> 
> This means that it is very, very, very unlikely (to the point that it's practically
> impossible) that those pins can ever be used for anything else that is not *the*
> one of the two functions that are supported for them (which is UART0 in this case).
> 
> In this case, adding the pins at the board level would only create unnecessary
> duplication and nothing else, because, well, noone could possibly ever use those
> for anything else, again.
> 
> That's the criteria.

So this criteria, avoiding unnecessary duplication, is also what I thought and
is very true for the argument I presented before which somehow wasn't what has
convinced you: That using uart0 in any possible way **always** implied using
the uart0 pingroup in uart mode, because there aren't any other pins which can
be used for uart0. In this sense, if uart0 is used at all, it is **not** the
choice of the board designer which pins to use for that -- there simply is only
that one single option.

> 
> If the BootROM didn't use those pins, and those could support both GPIO mode and
> HW function mode (any: uart0, 1, 2...n, spi, i2c, whatever else), even though it
> is likely for boards to use them for one specific function, there is nothing that
> stops a HW engineer to decide to route those elsewhere and use them as a GPIO
> instead, so that's not a SoC configuration, but rather a HW implementation decision
> at the PCB level.

That's exactly my point: There isn't any other option to route uart0 to. Only
those two pins. The other alternative functions of those pins (apart from GPIO)
are rather esoteric debugging features (I2C access to SoC internals).

> 
> See it like this (although this is an oversimplified view):
>  - SoC DT describes the SoC (the chip) - in this case the MT7981B chip
>  - Board DT describes decisions that were taken by the HW engineer that developed
>    the PCB on which the MT7981B was placed.

So the choice of a HW engineer regarding uart0 is simply whether uart0
is used or not. If uart0 is used, the HW engineer doesn't have any choice
regarding which pins they would like to use for the uart0 RX and TX lines,
the SoC design dictates exactly one option for that.

> 
> Clearly, if there's a board design (usually, a "base project") that has derivatives
> (for example, a device with eMMC, one with UFS, one with both, one with two SFP,
> one with one SFP and one soldered ethernet chip on a non-exposed SFP interface,
> etc) it is ok to have a "board-common" dtsi and specific board variants on top,
> like it is done with some bananapi and some genio boards.
> 
> Lots of text here - yet oversimplified. There is much more to say, but I think
> (and hope) that this is enough to make you understand the main point (of course
> feel free to throw more questions if what I wrote doesn't fully satisfy you).
> 
> > > 
> > > > (Sidenote: As even the BootROM already uses those two pins as UART for
> > > > debug output,
> > > 
> > > Funny thing is, your side note is what *fully* justifies your disagreement
> > > and it's also what triggers me to say that you're right, lol :)
> > > 
> > > Okay then, I am fine with this commit now and I can renew my
> > > 
> > > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > 
> > Note that the patch you have just added your Reviewed-by:-tag to does
> > *not* add the uart0 pinctrl on SoC-level but board-level, so different
> > from what I argued for above.
> 
> Ewwww I'm doing too may things at once. Pretty crazy days around here :)))
> 
> >> Did you mean to add Reviewed-by: for that
> > (which contraticts what you just wrote) or rather to the to-be-submitted
> > v2 of this series which includes the change to move the uart0 pinctrl
> > to mt7981b.dtsi?
> 
> Yeah. Sorry.
> 
> I repeat then, so that this is clear: you are right, the pinctrl for UART0 on the
> MT7981B SoC must go to mt7981b.dtsi and *not* to mt7981b-openwrt-one.

Thank you, that should make it clear to Sjoerd as well (who may skip and ignore
all of our debating :).

