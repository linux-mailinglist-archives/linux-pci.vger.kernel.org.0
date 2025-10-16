Return-Path: <linux-pci+bounces-38373-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08451BE4A0A
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 18:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88D245E2BAE
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 16:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F16341650;
	Thu, 16 Oct 2025 16:38:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F8932AAC3;
	Thu, 16 Oct 2025 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760632688; cv=none; b=e0Eh+IC71BjI38YfUZsD9syNnHzuiYLfhYufnbTLkG6Aqn6zlxB/liG/3K1K5vP483IuavW/q3lbssH6wTcbMMOWtgLKakAdKXaqY2Ig3gKs+4COiBd/3BRsU0V0NB1VdG1ncJkmaNtg+g7mMKtKou3NZqOU1O3PLzdd3NpQ/HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760632688; c=relaxed/simple;
	bh=YxBKu+zIUX8CGJj4jbQUYQMuxHt2FoP59bIPuC+yGWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2VVpwWnhfAKEujn45Ap5KTrjohUbkjzQlLn/OcIESwXATi0CS22cjECqQJnrSwsuK9qcH8RM6i2Tk8JlXTGwbN8SxTrf7Fo0hGUXvJmNRDmj3apkutmHAotrBLFACpj1U8xoU5dWErPGK5fEWxHtbUYURWMu1JoOXdptOr5jCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1v9Qz1-000000002mr-31Oo;
	Thu, 16 Oct 2025 16:37:43 +0000
Date: Thu, 16 Oct 2025 17:37:36 +0100
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
Message-ID: <aPEfUBl6fMe6QYdY@makrotopia.org>
References: <20251016-openwrt-one-network-v1-0-de259719b6f2@collabora.com>
 <20251016-openwrt-one-network-v1-2-de259719b6f2@collabora.com>
 <aPDnT4tuSzNDzyAE@makrotopia.org>
 <5f430ff9-d701-426a-bf93-5290e6912eb4@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f430ff9-d701-426a-bf93-5290e6912eb4@collabora.com>

On Thu, Oct 16, 2025 at 04:29:14PM +0200, AngeloGioacchino Del Regno wrote:
> Il 16/10/25 14:38, Daniel Golle ha scritto:
> > On Thu, Oct 16, 2025 at 12:08:38PM +0200, Sjoerd Simons wrote:
> > > Add explicit pinctrl configuration for UART0 on the OpenWrt One board,
> > > 
> > > Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> > > ---
> > >   arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts | 11 +++++++++++
> > >   1 file changed, 11 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
> > > index 968b91f55bb27..f836059d7f475 100644
> > > --- a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
> > > +++ b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
> > > @@ -22,6 +22,17 @@ memory@40000000 {
> > >   	};
> > >   };
> > > +&pio {
> > > +	uart0_pins: uart0-pins {
> > > +		mux {
> > > +			function = "uart";
> > > +			groups = "uart0";
> > > +		};
> > > +	};
> > > +};
> > > +
> > >   &uart0 {
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&uart0_pins>;
> > >   	status = "okay";
> > >   };
> > 
> > As there is only a single possible pinctrl configuration for uart0,
> > both the pinmux definition as well as the pinctrl properties should go
> > into mt7981b.dtsi rather than in the board's dts.
> 
> If there's really one single possible pin configuration for the UART0 pins,
> as in, those pins *do not* have a GPIO mode, then yes I agree.
> 
> If those pins can be as well configured as GPIOs, this goes to board DTS.

I respectfully disagree and will explain below.

All pinmux pins on the MediaTek platform also allow being configured as
GPIOs. However, if you configure those as GPIOs the consequence is that
you cannot use UART0 any more at all. So using UART0 at all always
implies using exactly those pins, there is no alternative to that.

Hence every board with every possible uses of pins 32 and 33 (there is
only RX and TX for UART0, RTS/CTS flow-control is not possible) can be
represented without needing to configure the pinctrl for uart0 on the
board level. There isn't going to be any variation on the board-level
when it comes to uart0. Either it is enabled (status = "okay";), and
that will always imply using the 'uart0' group in mode 'uart', or, in
case any of the two pins of uart0 is used for something else that means
uart0 cannot be enabled. Simple as that.

Hence there is no need to duplicate that pinctrl settings on each and
every board, as controlling the 'status' property on the board-level
already gives 100% freedom.

(Sidenote: As even the BootROM already uses those two pins as UART for
debug output, it is very unlikely that anyone would actually use them
for anything else in production. Apart from being used as GPIOs you can
also use pins 32 and 33 as an I2C target for external debug access to the
registers of either the sgmii0_phy, sgmii1_phy or u3_phy. However, that
doesn't matter in terms of the debate above, as the crucial point there
is that using uart0 always implies using group 'uart0' in 'uart' mode.)

