Return-Path: <linux-pci+bounces-38963-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE14BFA88E
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 09:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A9E34E1BC2
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 07:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3250E2F6581;
	Wed, 22 Oct 2025 07:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sjoerd@collabora.com header.b="WS0HFeV7"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D5B2F5499;
	Wed, 22 Oct 2025 07:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118030; cv=pass; b=Ztr11Da0sB4r2mwx5E9OFiXytwRXcZDRHQNWdzBy70xT596I92TSJVFjB6rnpD0s/79ePk1UioDMyFZdCjf7TgOJuHx5701VIvCKW3zsJj5YaKi412x1AdPzpjI8c6n1B8RjNfMbwgRi89hBpn83VRRTpL1J745B7YxiBPcrr/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118030; c=relaxed/simple;
	bh=NDxYGC5XxpUY1aK/+Eotq3Iw1MRu+0HKGlYJLjiIChc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cWZMw29TxHgB2xyAlfrVrgt8ii7Y8rAR2nJOWFSDOC/BPifdHtvlHsIV/RW0BU1iq6kkiMCLsXp7Ezn2n8BbSu3FRTnA5i/OsgBNJ5Hquled9ugXszt2w2UeCTJHhcLlz9jz4bL+T8WaZZ7Q/bEqbYoKhRQ1/z9EfvE2NLviM8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sjoerd@collabora.com header.b=WS0HFeV7; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1761117986; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GWdWVJIci83v/eS69HecZIVsU2dKjax3EaKZENbtz8G9fVU3kFO9nY0W8fbL857a5mW3ciUZqRmPGiAn2qFYSRfUsXikN42get9YJK0XRoxavO8HtvhmmTrh6sXVgQ091coljHNh/p5NRqUQXn8vNn0LieCpkgF8NE75OevzYL8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761117986; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Ne+Pmve/YJpQYWLxsEpgG2oak24NJMv5+UeWTnSp+5I=; 
	b=ZFwP3ceil6N4YJkKFYDLfc3uNtz7sFBZZs9URI8eHspzPQ9RO5mfmYIwTuRp/Pt0BgCsLXgGGmuDL0oIbK3wlG8wJHJesye68F3WBpKfNl3nVdW2Waqixq2ZVPbPC8gOtczfnFApIzT0yRx1/5t9XZJUMQlDgLGmCtf2orhIpWw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sjoerd@collabora.com;
	dmarc=pass header.from=<sjoerd@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761117986;
	s=zohomail; d=collabora.com; i=sjoerd@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=Ne+Pmve/YJpQYWLxsEpgG2oak24NJMv5+UeWTnSp+5I=;
	b=WS0HFeV7KBFtIbds/DTNEOfzlWHiuEhf7zgrHzyBNXymtekgif2dvr8//CXl1Eja
	5o0inS7TmzZMLQ8iQ3Ei7kl5nEinVZYEVFx7L46Nzx0eWtQ5TQX0iSAx2IQCmJK8X72
	FD3DTFDuVjIDxFN5LhSIHklpFieoF/gr9TrumGso=
Received: by mx.zohomail.com with SMTPS id 1761117982200158.6072297880238;
	Wed, 22 Oct 2025 00:26:22 -0700 (PDT)
Message-ID: <79d4a7379bce245d22b56c677fd7b3a263836239.camel@collabora.com>
Subject: Re: [PATCH 15/15] arm64: dts: mediatek: mt7981b-openwrt-one: Enable
 leds
From: Sjoerd Simons <sjoerd@collabora.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno	
 <angelogioacchino.delregno@collabora.com>, Ryder Lee
 <ryder.lee@mediatek.com>,  Jianjun Wang <jianjun.wang@mediatek.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi	 <lpieralisi@kernel.org>,
 Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=	 <kwilczynski@kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, Chunfeng Yun	 <chunfeng.yun@mediatek.com>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Lee Jones <lee@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,  "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>, 
	kernel@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, 	linux-pci@vger.kernel.org,
 linux-phy@lists.infradead.org, netdev@vger.kernel.org,  Daniel Golle
 <daniel@makrotopia.org>, Bryan Hinton <bryan@bryanhinton.com>
Date: Wed, 22 Oct 2025 09:26:11 +0200
In-Reply-To: <d8077ee4-21c2-43c5-b130-7ff270b09791@lunn.ch>
References: <20251016-openwrt-one-network-v1-0-de259719b6f2@collabora.com>
	 <20251016-openwrt-one-network-v1-15-de259719b6f2@collabora.com>
	 <d8077ee4-21c2-43c5-b130-7ff270b09791@lunn.ch>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-5 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

Hey,

On Fri, 2025-10-17 at 19:35 +0200, Andrew Lunn wrote:
> On Thu, Oct 16, 2025 at 12:08:51PM +0200, Sjoerd Simons wrote:
> > The Openwrt One has 3 status leds at the front (red, white, green) as
> > well as 2 software controlled leds for the LAN jack (amber, green).
>=20
> A previous patch in this series added 2 PHY LEDs. Are they connected
> to a LAN jack? Are there multiple RJ45 connectors? Is it clear from
> /sys/class/leds what LED is what?

Yeah there are two RJ45 jacks. One referred to as WAN in the openwrt one
documentation (2.5G), which uses phy integrated leds. One referred to as LA=
N,
which for some reason is using software controlled leds rather then the phy=
's
led controller, which this patch adds support for.

When applying this set you'll get:
```
root@openwrt-debian:/sys/class/leds# ls -1                                 =
   =20
amber:lan                                                                  =
   =20
green:lan                                                                  =
   =20
green:status                                                               =
   =20
mdio-bus:0f:amber:wan                                                      =
   =20
mdio-bus:0f:green:wan                                                      =
   =20
mt76-phy0                                                                  =
   =20
mt76-phy1                                                                  =
   =20
red:status                                                                 =
   =20
white:status                      =20
```

Which is hopefully clear enough



--=20
Sjoerd Simons <sjoerd@collabora.com>
Collabora

