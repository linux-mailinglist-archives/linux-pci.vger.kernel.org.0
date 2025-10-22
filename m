Return-Path: <linux-pci+bounces-39008-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB38BFBE0D
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 14:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E680C4F08F7
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 12:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA867342C95;
	Wed, 22 Oct 2025 12:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QSk6D6ZI"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C8A19CC28;
	Wed, 22 Oct 2025 12:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761136558; cv=none; b=BF0NVjX1LcWR4aueGWQhWFloToLW/H54QQsBnoHpldmMznk78U8KMT79S86APQ2M7AdJv+hWbsdLDtIGFuJfwrR6xyCfduIAWWNCtcbA85aChvQN6jbfDdouHIZy1qa/uNjZS4aK70Eir49jYNhw53/ZNSW+0EMq938t6IohEuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761136558; c=relaxed/simple;
	bh=6GygRBHvxfcqGXnEi/9P3tlsxMuta/koSy98GYmAOXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ta7dioEumgRbe1s+cbkhqVR37yu7sUa0P23kykPgHhVICe2hs1sBXJRuSIC7rlm69VrBwKdRM7CYAYBfqjY61UL871TBgUGrwEC9FSuRGa89YiETxRB7H7BLAZ77OwsGbGXUkrT6zmIYCVpgIsMXLGzHF2K6omQkAWTi0NMtSWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QSk6D6ZI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=R95DGcQ4LYALHG8T4SNxi7BAAXg7er7ggzkRbLh42No=; b=QSk6D6ZIL39KWQjpQVXzyu/daU
	CkHCg8qd7kd0YqSVIzxh2OYFZ1Gtf6Zy1PMvilS2ibzw5vrduZP1N74w4P6Tj1JfPOXck0ka2IkIN
	G3R9KHuq/zrSWxPK36Hjw1+QvspeXZMa8vN0KtQZWpHSk2jPm3N1Cw59r3FE3Ov57v3Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vBY3w-00Bkxo-MY; Wed, 22 Oct 2025 14:35:32 +0200
Date: Wed, 22 Oct 2025 14:35:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sjoerd Simons <sjoerd@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
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
	Daniel Golle <daniel@makrotopia.org>,
	Bryan Hinton <bryan@bryanhinton.com>
Subject: Re: [PATCH 15/15] arm64: dts: mediatek: mt7981b-openwrt-one: Enable
 leds
Message-ID: <9ecffb7f-839c-4e4d-bef1-f59747d020b2@lunn.ch>
References: <20251016-openwrt-one-network-v1-0-de259719b6f2@collabora.com>
 <20251016-openwrt-one-network-v1-15-de259719b6f2@collabora.com>
 <d8077ee4-21c2-43c5-b130-7ff270b09791@lunn.ch>
 <79d4a7379bce245d22b56c677fd7b3a263836239.camel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79d4a7379bce245d22b56c677fd7b3a263836239.camel@collabora.com>

On Wed, Oct 22, 2025 at 09:26:11AM +0200, Sjoerd Simons wrote:
> Hey,
> 
> On Fri, 2025-10-17 at 19:35 +0200, Andrew Lunn wrote:
> > On Thu, Oct 16, 2025 at 12:08:51PM +0200, Sjoerd Simons wrote:
> > > The Openwrt One has 3 status leds at the front (red, white, green) as
> > > well as 2 software controlled leds for the LAN jack (amber, green).
> > 
> > A previous patch in this series added 2 PHY LEDs. Are they connected
> > to a LAN jack? Are there multiple RJ45 connectors? Is it clear from
> > /sys/class/leds what LED is what?
> 
> Yeah there are two RJ45 jacks. One referred to as WAN in the openwrt one
> documentation (2.5G), which uses phy integrated leds. One referred to as LAN,
> which for some reason is using software controlled leds rather then the phy's
> led controller, which this patch adds support for.
> 
> When applying this set you'll get:
> ```
> root@openwrt-debian:/sys/class/leds# ls -1                                     
> amber:lan                                                                      
> green:lan                                                                      
> green:status                                                                   
> mdio-bus:0f:amber:wan                                                          
> mdio-bus:0f:green:wan                                                          
> mt76-phy0                                                                      
> mt76-phy1                                                                      
> red:status                                                                     
> white:status                       
> ```
> 
> Which is hopefully clear enough

You can also get to the LEDs associated to a MAC via
/sys/class/net/eth42/leds, or a subdirectory.

Please could you expand the commit message with more details of the
different RJ45 connectors, and how the different LEDs map to them.

Thanks

	Andrew

