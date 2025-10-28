Return-Path: <linux-pci+bounces-39529-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 994D1C14D06
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 14:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 563AA4F9559
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 13:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A91E3195F4;
	Tue, 28 Oct 2025 13:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sjoerd@collabora.com header.b="ZwoIEHXc"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C165D2765E3;
	Tue, 28 Oct 2025 13:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761657921; cv=pass; b=fmGbrkrFwIFaSm+IepdyktW/4UR8YbCvMiiyfgSLGtfE565eQavs5WN6HPj05tz4nFRdGrfkyrmZ0HXi9j2VfYcoQnFDE9NdswZ+2jsSnkjcx1cxcQIyLOhGQ7dsAYhmmobD1Um70meQ3+cleyn1bhdeqOfqxdzxAkcuAdxnJH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761657921; c=relaxed/simple;
	bh=98jTqZUcQ5Qf4P1DNrN2dsmZVex8R7C740H3NeDUBVI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cs+20O9UKgFWH9KMG880Jl6i6bNmlJFihvDb7upIHTDW4zJeQUWM85vLHEFmzLulPg1MpeFy/uGrZdjhhU5/0ENjDDHVHC0lLHxdMkWbPfwL+rW5UYN+ERmx4BcKr5Q5hLIjsv+JWXNYnkirMYINSvnzCQFcfaUpnAIejjc/KPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sjoerd@collabora.com header.b=ZwoIEHXc; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1761657869; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZCTOLf2S+q8m7fxAVIx8Y+bCTP95emO4YmHpi3NRritxQmxe3ATRHjgeW0BrRIv/SbQdJcPkYSIUlLoL7Sl45gi2zztEIUBUCnLkgM8wr8gLtilOLj+4p0mgiYOXQchJqvmPzkbMfQ+hjVO2mN6HwX4WU2/7ifnbvDnEokHm7os=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761657869; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8/d3UUUhdWoIZXpk8NwqSpg4DExzAbF8PYQkQhgem3s=; 
	b=mVNRJGLaKBa+FnpaA60HLtOXJLBTBabrws/EXB4240rOpfhff5FXpf/VNKnYWCwBu00BOQ3NWKiZVwJqhU0Q3gMtrBNyvabfFoH3VOmcPyKqHEO88TmrhOh57Z7cNaIbziW7X/3hIqvD/KY4twXCtuQs4aGT6BhvdTOPnX+n6xw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sjoerd@collabora.com;
	dmarc=pass header.from=<sjoerd@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761657869;
	s=zohomail; d=collabora.com; i=sjoerd@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=8/d3UUUhdWoIZXpk8NwqSpg4DExzAbF8PYQkQhgem3s=;
	b=ZwoIEHXchlDN8s9MvkdPt0IM1C2ZQYDwtGfbijZC9gXXVKG93gOrptfLgnMCk5QN
	KWqWvywAsKEtYwEZm6+KZfkQE2jPZsK7IM4T470U+hBGQFBMILmP97pYYcSjTIEpo1C
	3viKQ0jStrCNXpRAwgnP937Ec/N+iwr3jwOZzaVI=
Received: by mx.zohomail.com with SMTPS id 1761657866228953.45389749315;
	Tue, 28 Oct 2025 06:24:26 -0700 (PDT)
Message-ID: <408842eda1caa53247ff759cd9ea75dcab624594.camel@collabora.com>
Subject: Re: [PATCH 12/15] arm64: dts: mediatek: mt7981b-openwrt-one: Enable
 Ethernet
From: Sjoerd Simons <sjoerd@collabora.com>
To: Eric Woudstra <ericwouds@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>
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
Date: Tue, 28 Oct 2025 14:24:19 +0100
In-Reply-To: <05610ae5-4a8a-47e9-808b-7ff98fade78e@gmail.com>
References: <20251016-openwrt-one-network-v1-0-de259719b6f2@collabora.com>
	 <20251016-openwrt-one-network-v1-12-de259719b6f2@collabora.com>
	 <4f82aa17-1bf8-4d72-bc1f-b32f364e1cf6@lunn.ch>
	 <8f5335a703905dea9d8d0c1840862a3478da1ca7.camel@collabora.com>
	 <05610ae5-4a8a-47e9-808b-7ff98fade78e@gmail.com>
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

On Tue, 2025-10-28 at 12:14 +0100, Eric Woudstra wrote:
>=20
>=20
> On 10/21/25 10:21 PM, Sjoerd Simons wrote:
> > On Fri, 2025-10-17 at 19:31 +0200, Andrew Lunn wrote:
> > > > +&mdio_bus {
> > > > +	phy15: ethernet-phy@f {
> > > > +		compatible =3D "ethernet-phy-id03a2.a411";
> > > > +		reg =3D <0xf>;
> > > > +		interrupt-parent =3D <&pio>;
> > > > +		interrupts =3D <38 IRQ_TYPE_EDGE_FALLING>;
> > >=20
> > > This is probably wrong. PHY interrupts are generally level, not edge.
> >=20
> > Sadly i can't find a datasheet for the PHY, so can't really validate th=
at
> > easily. Maybe Eric can
> > comment here as the author of the relevant PHY driver.
> >=20
> > I'd note that the mt7986a-bananapi-bpi-r3-mini dts has the same setup f=
or
> > this PHY, however that's
> > ofcourse not authoritative.
> >=20
>=20
> Lucien would have access to the correct information about the interrupt.

Thanks! For what it's worth i got around to putting a scope on the line las=
t
night. It looks like the interrupt line is pulled down until cleared, so it
appears it's indeed a Level interrupt as Andrew guessed. But would be great=
 to
have this confirmed based on the documentation :)

--=20
Sjoerd Simons <sjoerd@collabora.com>
Collabora

