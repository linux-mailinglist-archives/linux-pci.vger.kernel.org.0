Return-Path: <linux-pci+bounces-39855-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 292A3C2269A
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 22:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D57B54E7B11
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 21:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE3D329E54;
	Thu, 30 Oct 2025 21:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sjoerd@collabora.com header.b="g3yElmKq"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238C7235053;
	Thu, 30 Oct 2025 21:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761859632; cv=pass; b=BXyPcIki9LLZgGonFXmG/LTP3kC8pjDMCD/r3Vzu4sJOPWlCnpk9ZHuCcbwgZ5t1XN4f2mPJKeZmxaevasVUphpDsyMS33p4LMjo2AgQY5oWOAHqMmsKW/5+pS2x4RdegOMIOClgB8VTuceu3M/a+EwnXNowdXIp94DVBUNDhmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761859632; c=relaxed/simple;
	bh=+FeCx4UfMrohbrMdvHoPB10eAhqDKvesqpVDKI/q1Wg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HAxs80PY8MD4ju8MOijcKUwVUAVpDY4JXrFLnHDyKdjOcCJXq0V+P7eM8cmlImM+8N58DnhKwyOLJuCqTOAakSKj+/z/M2sIWvReP1cidmMhFimw8VQLmVU9ID8khVZ9K9xwaDs9N4fTq4nwBcFgx5+gw1Ws1FUSL2OsSQEO67E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sjoerd@collabora.com header.b=g3yElmKq; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1761859574; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AMHNToO9uyH2UOzZxFbb68jVb8fRSxPJkx2uGcVBs/9gdG16OTxWSqbRDtjo45Z/FlXyS/FV+J25HRLJ6eE0mwzhoQpGPt8aSSAi4kt0fH/jZQCCxK7BQgcUefeohbYXnHcKtgTmArbRM/+KYIPB10Vi91lWfVPR0oE7a0Tgd88=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761859574; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ixRLpty5QKDOE0ulxvqD55Wb9bzwJbHlOe5KFSOLS1E=; 
	b=C87w96dCEC6ElqmbmEvGOSTnDEU0vYB9JwkPlW+pp3+V/xALKyuPcmjyx712KT7yM4Yys2ExWU7CSClHlyTQ3hojI79O+7j1ufpxDUUgtjl8GcQp9VlndlyKTulH4INak4h+0reqYs9iVQrstaEVzyH089qEufBmTQ5g+eC7R0w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sjoerd@collabora.com;
	dmarc=pass header.from=<sjoerd@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761859574;
	s=zohomail; d=collabora.com; i=sjoerd@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=ixRLpty5QKDOE0ulxvqD55Wb9bzwJbHlOe5KFSOLS1E=;
	b=g3yElmKq8LU2i4TbafpRnAEbkB1BmNCRln05g6k8WHT1ZVYQGKWV23fb3FJSpnWi
	9Hx5p5E79qn3bFI5Npy3N0kbsz9U6rX3ggbLg03vvs5D9YK8cdErhhhtfzjfFgkdU8r
	9MNcrZ/v/23ECwSTe6xbuIllyt+ePSWN22sOQvNU=
Received: by mx.zohomail.com with SMTPS id 1761859569654684.60417196483;
	Thu, 30 Oct 2025 14:26:09 -0700 (PDT)
Message-ID: <7d7595a0a33b4e56828beea86f6037bd9ecc8f8d.camel@collabora.com>
Subject: Re: [PATCH 11/15] arm64: dts: mediatek: mt7981b-openwrt-one: Enable
 SPI NOR
From: Sjoerd Simons <sjoerd@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,  Matthias Brugger
 <matthias.bgg@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang	
 <jianjun.wang@mediatek.com>, Bjorn Helgaas <bhelgaas@google.com>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>,  Manivannan Sadhasivam	 <mani@kernel.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul	 <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Lee Jones	 <lee@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"	
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski	
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lorenzo Bianconi	
 <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-phy@lists.infradead.org, netdev@vger.kernel.org, Daniel Golle
	 <daniel@makrotopia.org>, Bryan Hinton <bryan@bryanhinton.com>
Date: Thu, 30 Oct 2025 22:26:00 +0100
In-Reply-To: <c9865ab0-cbc2-47b5-b7cf-acb8b9c52695@collabora.com>
References: <20251016-openwrt-one-network-v1-0-de259719b6f2@collabora.com>
	 <20251016-openwrt-one-network-v1-11-de259719b6f2@collabora.com>
	 <c9865ab0-cbc2-47b5-b7cf-acb8b9c52695@collabora.com>
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

On Thu, 2025-10-16 at 13:28 +0200, AngeloGioacchino Del Regno wrote:
> Il 16/10/25 12:08, Sjoerd Simons ha scritto:
> > The openwrt one has a SPI NOR flash which from factory is used for:
> > * Recovery system
> > * WiFi eeprom data
> > * ethernet Mac addresses
> >=20
> > Describe this following the same partitions as the openwrt configuratio=
n
> > uses.
> >=20
> > Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> > ---
> > =C2=A0 .../boot/dts/mediatek/mt7981b-openwrt-one.dts=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 83 ++++++++++++++++++++++
> > =C2=A0 1 file changed, 83 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
> > b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
> > index b6ca628ee72fd..9878009385cc6 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
> > +++ b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
> > @@ -3,6 +3,7 @@
> > =C2=A0 /dts-v1/;
> > =C2=A0=20
> > =C2=A0 #include "mt7981b.dtsi"
> > +#include "dt-bindings/pinctrl/mt65xx.h"
> > =C2=A0=20
> > =C2=A0 / {
> > =C2=A0=C2=A0	compatible =3D "openwrt,one", "mediatek,mt7981b";
> > @@ -54,6 +55,25 @@ mux {
> > =C2=A0=C2=A0		};
> > =C2=A0=C2=A0	};
> > =C2=A0=20
> > +	spi2_flash_pins: spi2-pins {
> > +		mux {
> > +			function =3D "spi";
> > +			groups =3D "spi2";
> > +		};
> > +
> > +		conf-pu {
> > +			bias-pull-up =3D <MTK_PUPD_SET_R1R0_11>;
> > +			drive-strength =3D <MTK_DRIVE_8mA>;
>=20
> drive-strength =3D <8>;
>=20
> > +			pins =3D "SPI2_CS", "SPI2_WP";
> > +		};
> > +
> > +		conf-pd {
> > +			bias-pull-down =3D <MTK_PUPD_SET_R1R0_11>;
> > +			drive-strength =3D <MTK_DRIVE_8mA>;
>=20
> ditto
>=20
> > +			pins =3D "SPI2_CLK", "SPI2_MOSI", "SPI2_MISO";
> > +		};
> > +	};
> > +
> > =C2=A0=C2=A0	uart0_pins: uart0-pins {
> > =C2=A0=C2=A0		mux {
> > =C2=A0=C2=A0			function =3D "uart";
> > @@ -62,6 +82,69 @@ mux {
> > =C2=A0=C2=A0	};
> > =C2=A0 };
> > =C2=A0=20
> > +&spi2 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&spi2_flash_pins>;
> > +	status =3D "okay";
> > +
> > +	flash@0 {
> > +		compatible =3D "jedec,spi-nor";
> > +		reg =3D <0>;
> > +		spi-max-frequency =3D <40000000>;
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <1>;
> > +
> > +		partitions {
> > +			compatible =3D "fixed-partitions";
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <1>;
> > +
> > +			partition@0 {
> > +				reg =3D <0x00000 0x40000>;
> > +				label =3D "bl2-nor";
> > +			};
> > +
> > +			partition@40000 {
> > +				reg =3D <0x40000 0xc0000>;
> > +				label =3D "factory";
> > +				read-only;
> > +
> > +				nvmem-layout {
> > +					compatible =3D "fixed-layout";
> > +					#address-cells =3D <1>;
> > +					#size-cells =3D <1>;
> > +
> > +					eeprom_factory_0: eeprom@0 {
>=20
> wifi_calibration:
>=20
> > +						reg =3D <0x0 0x1000>;
> > +					};
> > +
> > +					macaddr_factory_4: macaddr@4 {
>=20
> macaddr_factory_gmac1?
>=20
> You're not using this in the later commit where you enable ethernet nodes=
,
> did you miss adding that to gmac1 or what is this used for?

gmac1 gets its mac from u-boot, passed in through device-tree; Haven't chec=
ked where u-boot gets it
from yet. I did spot it at offset 0x2a in this factory data, so that seems =
likely candidate.

However this particular mac is used by the wifi phy. I discovered after sen=
ding this patch the kernel
driver loads it directly from the "eeprom" area, so we could potentially dr=
op this node.=20

As mentioned in the commit message, I kept the same layouts as openwrt uses=
. Though i'd be fine to
minimize the nvmem cells just to what's referenced in the dtb.

> > +						reg =3D <0x4 0x6>;
> > +						compatible =3D "mac-base";
> > +						#nvmem-cell-cells =3D <1>;
> > +					};
> > +
> > +					macaddr_factory_24: macaddr@24 {
>=20
> macaddr_factory_gmac0 ?


That seems nicer, will add that in V2 (same for the previous naming suggest=
ion)



--=20
Sjoerd Simons
Collabora Ltd.

