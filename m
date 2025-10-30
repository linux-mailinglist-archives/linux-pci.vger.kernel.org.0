Return-Path: <linux-pci+bounces-39849-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F5BC2253D
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 21:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E9461AA1DDF
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 20:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D898133554F;
	Thu, 30 Oct 2025 20:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sjoerd@collabora.com header.b="eE9lQAyj"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118C4329E76;
	Thu, 30 Oct 2025 20:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761856532; cv=pass; b=G27TFIa/DIBtc5MpHr34Feapl65OM52nQezihjuFZjLxD21ap+o5FcpcuvdR8HeE+DHA+RRBvCUazbkimXaNteRPYrTGviAW0/XijmLhTk3yRAFCufck5a/WaYLwfb1fLsaxkNBw+7NuG4N2CY3WCEeP5wjJkMXrY9KCaTmdgtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761856532; c=relaxed/simple;
	bh=ORDHBq2wSgguhYiKPUgFjArpWqxxv043hPSpzGj95z8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oGNxEwDsnYIOtx5dI3dEea0jPVmX1qNZsg06NKbDqVn5g3MX4Dl4PPFLXtOeC/Xu/KKC6KnWXET/K9S/mqQH3hd2vGYmGIfH6YLYT5fAoxbwps3u1C7a/kgKdqp/7wD+W8wKTclKbAdoRdO9K4D/vjoEhXvMTtDTSmq0Iic8Bp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sjoerd@collabora.com header.b=eE9lQAyj; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1761856485; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gkFbZ213okCftKgeKgIIwNoz8BwA4nDP6MzCr0YARnjslWbS8bf914DjEU26RKsesu0i7gZx4BTfyz1xxAgNbQMZ+hOgVrrgyBtWW8VMvkD1hskA7r5/OPkLeophqY65m9j/4O4l1Y9P6SwMdoSy8qMjWiwQU/R+tvzDuY+qM+k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761856485; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+Wkm4p/uQ+Vqh1gCohypGhEVZ1/dwpzLDQlD8Bjlil8=; 
	b=Gnr8xIhUAPzV2qfRb1oLqyxVo5sYZWiNHe+DDVUg/CHGOPZtjMxE9wPQmju6dCohAzktipJKP2YWvL5u9mW/WZSFsCaUWNk3l1EeVNWUSTxJB/E4oPJwqb0FZwBiY+h8vUyCgRnA6upcsdDuS10nEcP/oYKeYkbfFBQxcXmxQAc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sjoerd@collabora.com;
	dmarc=pass header.from=<sjoerd@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761856485;
	s=zohomail; d=collabora.com; i=sjoerd@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=+Wkm4p/uQ+Vqh1gCohypGhEVZ1/dwpzLDQlD8Bjlil8=;
	b=eE9lQAyjvcD+VsAFUGr3EGVzq1lb8anctgxPOFZUE+IyjqTE06JyDOHlv1dZWFZ+
	GJu62lcDIBD5F/Za7yXXSFfmLJl7bfrpDY2VhzDNK66M909P75cdhk3qdwz/uSfrpMY
	nlZLfK3BN7dj33lt0OVX5CDVbVQpWIkm0m886a44=
Received: by mx.zohomail.com with SMTPS id 1761856481126419.9479106165559;
	Thu, 30 Oct 2025 13:34:41 -0700 (PDT)
Message-ID: <f2c3e18fe22284c4a5ab0ce085e2d17be844a0a8.camel@collabora.com>
Subject: Re: [PATCH 10/15] arm64: dts: mediatek: mt7981b: Add Ethernet and
 WiFi offload support
From: Sjoerd Simons <sjoerd@collabora.com>
To: Daniel Golle <daniel@makrotopia.org>
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
 linux-phy@lists.infradead.org, netdev@vger.kernel.org,  Bryan Hinton
 <bryan@bryanhinton.com>
Date: Thu, 30 Oct 2025 21:34:28 +0100
In-Reply-To: <aPEhiVdgkVLvF9Et@makrotopia.org>
References: <20251016-openwrt-one-network-v1-0-de259719b6f2@collabora.com>
	 <20251016-openwrt-one-network-v1-10-de259719b6f2@collabora.com>
	 <aPEhiVdgkVLvF9Et@makrotopia.org>
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

On Thu, 2025-10-16 at 17:47 +0100, Daniel Golle wrote:
> On Thu, Oct 16, 2025 at 12:08:46PM +0200, Sjoerd Simons wrote:
> > Add device tree nodes for the Ethernet subsystem on MT7981B SoC,
> > including:
> > - Ethernet MAC controller with dual GMAC support
> > - Wireless Ethernet Dispatch (WED)
> > - SGMII PHY controllers for high-speed Ethernet interfaces
> > - Reserved memory regions for WiFi offload processor
> >=20
> > Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> > ---
> > =C2=A0arch/arm64/boot/dts/mediatek/mt7981b.dtsi | 133 +++++++++++++++++=
+++++++++++++
> > =C2=A01 file changed, 133 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
> > b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
> > index 13950fe6e8766..c85fa0ddf2da8 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi

[snip]
> > 			mdio_bus: mdio-bus {
> > +				#address-cells =3D <1>;
> > +				#size-cells =3D <0>;
> > +
> > +				int_gbe_phy: ethernet-phy@0 {
> > +					compatible =3D "ethernet-phy-ieee802.3-c22";
> > +					reg =3D <0>;
> > +					phy-mode =3D "gmii";
> > +					phy-is-integrated;
> > +					nvmem-cells =3D <&phy_calibration>;
> > +					nvmem-cell-names =3D "phy-cal-data";
>=20
> Please also define the two LEDs here with their corresponding (only)
> pinctrl options for each of them, with 'status =3D "disabled";'. This
> makes it easier for boards to make use of the Ethernet PHY leds by just
> referencing the LED and setting the status to 'okay'.

I left those out on purpose as i can't easily validate them. They're probab=
ly better to be added once
someone adds a board using the hw led control.

>=20
--=20
Sjoerd Simons
Collabora Ltd.

