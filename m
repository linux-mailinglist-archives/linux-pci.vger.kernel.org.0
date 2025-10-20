Return-Path: <linux-pci+bounces-38745-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E288BF135F
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 14:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ECB13B063F
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 12:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2073054FB;
	Mon, 20 Oct 2025 12:28:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3CB1917ED;
	Mon, 20 Oct 2025 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963321; cv=none; b=bjkKbNTIPuofl3hx/HKwWJavig7EzRbhB9Inye7ErrcbKDNlqmdhgIxfcQPde5loLPUASu4oUxUC3WrKfAdQqdbAlDQvzuNu55uBwuZdfN77Hii0Ap3Gv/BoKsJ5ktT2R/1Z7od/Fe8KKJHC20oDvuumsKUJzaX7cEUK17Lq7ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963321; c=relaxed/simple;
	bh=DofzcR0NQwkRhmZTsBxnrzKL84BAOs+RTSxhxO2pjsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okzCtyWAnQgABsJ+DB0eiBxOGPcGmTq7MzvyR+CjHIxYqkb7bEaZdEptGoASMCk8RHtj8biyIKEi5RGgoMQzzvB9PaCTFDzInD1F5ZE64Zu727Sotd9Z998zXQZs1+6KfFXNzjbySUFc6Nmvo0m+X5wHJZDDRaqtCWfy8TL/3ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vAozt-000000003am-1Wtt;
	Mon, 20 Oct 2025 12:28:21 +0000
Date: Mon, 20 Oct 2025 13:28:17 +0100
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
Message-ID: <aPYq4cnaAHu5ags5@makrotopia.org>
References: <20251016-openwrt-one-network-v1-0-de259719b6f2@collabora.com>
 <20251016-openwrt-one-network-v1-2-de259719b6f2@collabora.com>
 <aPDnT4tuSzNDzyAE@makrotopia.org>
 <5f430ff9-d701-426a-bf93-5290e6912eb4@collabora.com>
 <aPEfUBl6fMe6QYdY@makrotopia.org>
 <82594ce7-f093-4753-b808-cd234845aed8@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82594ce7-f093-4753-b808-cd234845aed8@collabora.com>

On Mon, Oct 20, 2025 at 12:23:14PM +0200, AngeloGioacchino Del Regno wrote:
> Il 16/10/25 18:37, Daniel Golle ha scritto:
> > On Thu, Oct 16, 2025 at 04:29:14PM +0200, AngeloGioacchino Del Regno wrote:
> > > Il 16/10/25 14:38, Daniel Golle ha scritto:
> > > > On Thu, Oct 16, 2025 at 12:08:38PM +0200, Sjoerd Simons wrote:
> > > > > Add explicit pinctrl configuration for UART0 on the OpenWrt One board,
> > > > > 
> > > > > Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> > > > > ---
> > > > >    arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts | 11 +++++++++++
> > > > >    1 file changed, 11 insertions(+)
> > > > > 
> > > > > diff --git a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
> > > > > index 968b91f55bb27..f836059d7f475 100644
> > > > > --- a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
> > > > > +++ b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
> > > > > @@ -22,6 +22,17 @@ memory@40000000 {
> > > > >    	};
> > > > >    };
> > > > > +&pio {
> > > > > +	uart0_pins: uart0-pins {
> > > > > +		mux {
> > > > > +			function = "uart";
> > > > > +			groups = "uart0";
> > > > > +		};
> > > > > +	};
> > > > > +};
> > > > > +
> > > > >    &uart0 {
> > > > > +	pinctrl-names = "default";
> > > > > +	pinctrl-0 = <&uart0_pins>;
> > > > >    	status = "okay";
> > > > >    };
> > > > 
> > > > As there is only a single possible pinctrl configuration for uart0,
> > > > both the pinmux definition as well as the pinctrl properties should go
> > > > into mt7981b.dtsi rather than in the board's dts.
> > > 
> > > If there's really one single possible pin configuration for the UART0 pins,
> > > as in, those pins *do not* have a GPIO mode, then yes I agree.
> > > 
> > > If those pins can be as well configured as GPIOs, this goes to board DTS.
> > 
> > I respectfully disagree and will explain below.
> > 
> 
> Thanks a lot for taking the time to write all this - explains everything,
> and even too much :) :)
> 
> Though, there's something funny here! The following snippet of "main" text
> does explain stuff that is interesting, but that I (not other people, so
> thanks again for saying all this) know already, but.....
> 
> > All pinmux pins on the MediaTek platform also allow being configured as
> > GPIOs. However, if you configure those as GPIOs the consequence is that
> > you cannot use UART0 any more at all. So using UART0 at all always
> > implies using exactly those pins, there is no alternative to that.
> > 
> > Hence every board with every possible uses of pins 32 and 33 (there is
> > only RX and TX for UART0, RTS/CTS flow-control is not possible) can be
> > represented without needing to configure the pinctrl for uart0 on the
> > board level. There isn't going to be any variation on the board-level
> > when it comes to uart0. Either it is enabled (status = "okay";), and
> > that will always imply using the 'uart0' group in mode 'uart', or, in
> > case any of the two pins of uart0 is used for something else that means
> > uart0 cannot be enabled. Simple as that.
> > 
> > Hence there is no need to duplicate that pinctrl settings on each and
> > every board, as controlling the 'status' property on the board-level
> > already gives 100% freedom.
> > 
> 
> ...all of this is not justifying your point.

So what is the rule then? I understand the logic of describing the
pins eg. for uart1 only on board-level as there are actual alternatives
regarding the pins to be used, and if also including RTS/CTS pins.
Hence, for uart1, there are several possible pingroups which can be
used. What would be the argument to keep a pinctrl description for
which the SoC doesn't offer any alternatives to be on the board-level?
There is nothing to be decided by the board, literally 0 freedom.

> 
> > (Sidenote: As even the BootROM already uses those two pins as UART for
> > debug output,
> 
> Funny thing is, your side note is what *fully* justifies your disagreement
> and it's also what triggers me to say that you're right, lol :)
> 
> Okay then, I am fine with this commit now and I can renew my
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Note that the patch you have just added your Reviewed-by:-tag to does
*not* add the uart0 pinctrl on SoC-level but board-level, so different
from what I argued for above. Did you mean to add Reviewed-by: for that
(which contraticts what you just wrote) or rather to the to-be-submitted
v2 of this series which includes the change to move the uart0 pinctrl
to mt7981b.dtsi?

