Return-Path: <linux-pci+bounces-38942-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A2FBF8B52
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 22:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2AA4189AF3D
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 20:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B642F278E47;
	Tue, 21 Oct 2025 20:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sjoerd@collabora.com header.b="LTIsdLSW"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F103F9FB;
	Tue, 21 Oct 2025 20:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761078157; cv=pass; b=DZRttURrMToWn0bO4aPMs45s9KV8VDMAU7/IsWWxBY43ods84SvAFBI0xXzSfoLXtJzyKYZgP8DHBzT/BMD8abCQ9a1PUOWTwv2psewYUOP+MngqePha54kO17rEOC46YJeA4FDVzyF0lT4tRcFb9iC4M9PXnvMzbEP/epRSzu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761078157; c=relaxed/simple;
	bh=dQUuT/cvEQMcRlSDp4ZHtYKdqQ9zzwEEbrwS4uf5EgE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RSJcXbO5tMHvF452T1rmLzdAtBBLN1DNdgjyNdciL/Iof636M/x2OvjxAvsPkxOl/RYjyz8borkgpF61xadQjywgb2rZvsffW6SHWPLxUYw9l0ud0Qxb8DzaJCkvIoFXK5l2AmnQvZa+pIgh+lpJGuZGNWuYR7c0cLP6jbHm7K8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sjoerd@collabora.com header.b=LTIsdLSW; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1761078107; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QrY/3a0vxy2P8JAKFOWpysYjzg9YpdQXvP+aIg2gtIeBQB2GZ0VHr/28YkYykdW1ePNjrhHjDLlNaNi9fEJyHUG5G84GGV+Qi6KCIYFeIZLscaE0Hl2YgCokXDgmszFSTsboUhQiDF9EqFGB6cyWBrnfxf9G4VNp2kbMWlXz99k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761078107; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hAvzwpzQSETC2lKwgfVXJKcyUwiMeJEWklgbWrWua1w=; 
	b=gaqh9cwprh56WWxPqBWHY4c06cztH2dd/JXRzKlsNmG22IMiFPCpx/AFJwoyXYumggiRClhix/qPEJKDiKGhcE9Zd5yA1RcLNfdMI/XXOF5Gt11RwoioTvYx65Qh9MTuSA/FFIfk6Mae178SBhmcmkGsHceWA6x8pa1aLvj2A3c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sjoerd@collabora.com;
	dmarc=pass header.from=<sjoerd@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761078107;
	s=zohomail; d=collabora.com; i=sjoerd@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=hAvzwpzQSETC2lKwgfVXJKcyUwiMeJEWklgbWrWua1w=;
	b=LTIsdLSW3epqhH5OvoiycJDnQqP3nIYZbR5vNpzfS79o/Limr7vlOShUEfzal4LV
	b7iKvQLnGJUd2uIs+yNTkLy8SIRK5GbE+5pjp3160njZMvf4itG+twGlnZe1TQRFU41
	QQ6j6xhEEGpWCgs+L/LFvW1FZFSKrlJ3BdlarpLs=
Received: by mx.zohomail.com with SMTPS id 176107810303712.61020879160435;
	Tue, 21 Oct 2025 13:21:43 -0700 (PDT)
Message-ID: <8f5335a703905dea9d8d0c1840862a3478da1ca7.camel@collabora.com>
Subject: Re: [PATCH 12/15] arm64: dts: mediatek: mt7981b-openwrt-one: Enable
 Ethernet
From: Sjoerd Simons <sjoerd@collabora.com>
To: Andrew Lunn <andrew@lunn.ch>, Eric Woudstra <ericwouds@gmail.com>
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
Date: Tue, 21 Oct 2025 22:21:31 +0200
In-Reply-To: <4f82aa17-1bf8-4d72-bc1f-b32f364e1cf6@lunn.ch>
References: <20251016-openwrt-one-network-v1-0-de259719b6f2@collabora.com>
	 <20251016-openwrt-one-network-v1-12-de259719b6f2@collabora.com>
	 <4f82aa17-1bf8-4d72-bc1f-b32f364e1cf6@lunn.ch>
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

On Fri, 2025-10-17 at 19:31 +0200, Andrew Lunn wrote:
> > +&mdio_bus {
> > +	phy15: ethernet-phy@f {
> > +		compatible =3D "ethernet-phy-id03a2.a411";
> > +		reg =3D <0xf>;
> > +		interrupt-parent =3D <&pio>;
> > +		interrupts =3D <38 IRQ_TYPE_EDGE_FALLING>;
>=20
> This is probably wrong. PHY interrupts are generally level, not edge.

Sadly i can't find a datasheet for the PHY, so can't really validate that e=
asily. Maybe Eric can
comment here as the author of the relevant PHY driver.

I'd note that the mt7986a-bananapi-bpi-r3-mini dts has the same setup for t=
his PHY, however that's
ofcourse not authoritative.

--=20
Sjoerd Simons <sjoerd@collabora.com>

