Return-Path: <linux-pci+bounces-38741-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10485BF122B
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 14:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A101423843
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 12:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492613164B1;
	Mon, 20 Oct 2025 12:18:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3009A3128AB;
	Mon, 20 Oct 2025 12:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760962703; cv=none; b=tzG4zTt14ppgQCessZK/uQYCH00hfDfILU2qUSXshyN7xTmL8al5wqDlAKVmxg3O7Y2oq8bPW0ETkqhMkgoYle/AGWubtT77UFIub/aw2N6qvlvoFsZjnxs50e6juPySSuKhRDj39pOMd+dRWYqc19hKvH7DZwkeGUrgm2jl9sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760962703; c=relaxed/simple;
	bh=80FbDkBe1shvB1vnoWDwQhn8pRsa4OW0LHoxQpVfERE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYBE2vrklGToIXhcTHGqreRkJ+kEpEhLNp8C4I9brv8/3oA1A5W/8JhFSu6nPChDlGxJhJsIVLuGRI/TfgGMWyUlhG5YSFbIYjws2MgEzf39uvz45m6fpkK8IkxFzj1yt+ZQ8u63POFkyUEotQyZRaCRxMbgzkTI4fxARbVroTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vAopx-000000003X8-401e;
	Mon, 20 Oct 2025 12:18:06 +0000
Date: Mon, 20 Oct 2025 13:17:57 +0100
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
Subject: Re: [PATCH 10/15] arm64: dts: mediatek: mt7981b: Add Ethernet and
 WiFi offload support
Message-ID: <aPYodR5N89vRUyQp@makrotopia.org>
References: <20251016-openwrt-one-network-v1-0-de259719b6f2@collabora.com>
 <20251016-openwrt-one-network-v1-10-de259719b6f2@collabora.com>
 <aPEhiVdgkVLvF9Et@makrotopia.org>
 <8a637fc2-7768-4816-bb4f-3af2e32908e4@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a637fc2-7768-4816-bb4f-3af2e32908e4@collabora.com>

On Mon, Oct 20, 2025 at 12:27:53PM +0200, AngeloGioacchino Del Regno wrote:
> Il 16/10/25 18:47, Daniel Golle ha scritto:
> > On Thu, Oct 16, 2025 at 12:08:46PM +0200, Sjoerd Simons wrote:
> > > Add device tree nodes for the Ethernet subsystem on MT7981B SoC,
> > > including:
> > > - Ethernet MAC controller with dual GMAC support
> > > - Wireless Ethernet Dispatch (WED)
> > > - SGMII PHY controllers for high-speed Ethernet interfaces
> > > - Reserved memory regions for WiFi offload processor
> > > 
> > > Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> > > ---
> > >   arch/arm64/boot/dts/mediatek/mt7981b.dtsi | 133 ++++++++++++++++++++++++++++++
> > >   1 file changed, 133 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
> > > index 13950fe6e8766..c85fa0ddf2da8 100644
> > > --- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
> > > +++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
> 
> ..snip..
> 
> > > +
> > > +			mdio_bus: mdio-bus {
> > > +				#address-cells = <1>;
> > > +				#size-cells = <0>;
> > > +
> > > +				int_gbe_phy: ethernet-phy@0 {
> > > +					compatible = "ethernet-phy-ieee802.3-c22";
> > > +					reg = <0>;
> > > +					phy-mode = "gmii";
> > > +					phy-is-integrated;
> > > +					nvmem-cells = <&phy_calibration>;
> > > +					nvmem-cell-names = "phy-cal-data";
> > 
> > Please also define the two LEDs here with their corresponding (only)
> > pinctrl options for each of them, with 'status = "disabled";'. This
> > makes it easier for boards to make use of the Ethernet PHY leds by just
> > referencing the LED and setting the status to 'okay'.
> > 
> 
> Sorry Daniel, definitely no. The LEDs really are board specific.
> 
> Try to convince me otherwise, but for this one I really doubt that you can.

You are right, the LEDs themselves are board-specific and may not even
be present.

However, the LED controller is always present because it is part of the
PHY which is built-into the SoC. And the pinctrl property which I'd like
to see described on SoC-level is a property of the LED controller rather
than the LED itself. Sadly the device tree node doesn't make the
distinction between LED and LED controller, so I understand you your
argument as well.

