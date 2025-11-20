Return-Path: <linux-pci+bounces-41813-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0696CC75775
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 17:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5B12D361163
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 16:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F62364EA2;
	Thu, 20 Nov 2025 16:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2kg0Tjj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382E7363C6F;
	Thu, 20 Nov 2025 16:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656754; cv=none; b=kxbiiJUdqzxYcvvlTbRC4xZTCuQ/S5EVnjCAVnMZHUXjJibUJNp5wLrZ8I4lRWnlK1CwDSX3cU88dMZBtvpznh5g5+54GrEwH0tNd3edG3nmhgWpCCh3lWvPO+jCteEv5340EBRx51TTK2TENf2KTAPQbAsKSOUlGYhA+QfZZNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656754; c=relaxed/simple;
	bh=BnOq3z51JqZJ8uQTHJFdAkzYEzpauy5TFsDbeB3BY4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDtlCb/QsOAKgpoOea2MX3ug7ZC6gnkmwn1rVi0k5Ty92M62uxOqvjcO196H9LHFg0pU/bPZGo4Ed4WdcvwEEA8iSThasFqWNnzKfAW9DPAesgp8rBA8eu+BxfvQNps7t2zkf66QpOS6ajgOjvy/p8GtgTMnS3a7notYEXf0m7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2kg0Tjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08A7C116C6;
	Thu, 20 Nov 2025 16:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763656754;
	bh=BnOq3z51JqZJ8uQTHJFdAkzYEzpauy5TFsDbeB3BY4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V2kg0Tjj5QAKnndNOFZg5UC+/n0jys+8p9t5bz8p2y04vHxqxgOE2geeBodAahomQ
	 6m3d1+OMgwqwVvJImgdEJxg6I3jVlPT88OhSxZ93cPZtdsMP+msfK+1w3cGjTUH5Nv
	 KVXDDGdIK+t3KqYt6Q2bt2kY6nQrRG1SAVr2XiYmixARbV/XEroZo9xi4/Ag7AT0SJ
	 bSMR3ZrrUBkYF+RvU0I7zZpD2Aa96Em+gKXCZFEiXjNqiLkrPQxYJAxKRG/bx0AGZn
	 SfYsbZi5aoUPmDMmRb3KWQe8ti0Kl2mPqG4nN/orjZlqLPNlTDR71a2uEHdq723P1/
	 DQlMOgkh/0V3Q==
Date: Thu, 20 Nov 2025 16:39:04 +0000
From: Lee Jones <lee@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	patchwork-bot+netdevbpf@kernel.org,
	Sjoerd Simons <sjoerd@collabora.com>, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
	ryder.lee@mediatek.com, jianjun.wang@mediatek.com,
	bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, chunfeng.yun@mediatek.com, vkoul@kernel.org,
	kishon@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, lorenzo@kernel.org,
	nbd@nbd.name, kernel@collabora.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org, netdev@vger.kernel.org,
	daniel@makrotopia.org, bryan@bryanhinton.com,
	conor.dooley@microchip.com
Subject: Re: [PATCH v4 00/11] arm64: dts: mediatek: Add Openwrt One AP
 functionality
Message-ID: <20251120163904.GL661940@google.com>
References: <20251115-openwrt-one-network-v4-0-48cbda2969ac@collabora.com>
 <176360700676.1051457.11874224265724256534.git-patchwork-notify@kernel.org>
 <20251120152829.GH661940@google.com>
 <20251120073639.3fd7cc7c@kernel.org>
 <20251120154012.GJ661940@google.com>
 <20251120074457.5aa06d89@kernel.org>
 <c23d5d1e-4816-41c7-9886-41d586c84cc6@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c23d5d1e-4816-41c7-9886-41d586c84cc6@collabora.com>

On Thu, 20 Nov 2025, AngeloGioacchino Del Regno wrote:

> Il 20/11/25 16:44, Jakub Kicinski ha scritto:
> > On Thu, 20 Nov 2025 15:40:12 +0000 Lee Jones wrote:
> > > > > >    - [v4,02/11] dt-bindings: PCI: mediatek-gen3: Add MT7981 PCIe compatible
> > > > > >      (no matching commit)
> > > > > >    - [v4,03/11] dt-bindings: phy: mediatek,tphy: Add support for MT7981
> > > > > >      (no matching commit)
> > > > > >    - [v4,04/11] arm64: dts: mediatek: mt7981b: Add PCIe and USB support
> > > > > >      (no matching commit)
> > > > > >    - [v4,05/11] arm64: dts: mediatek: mt7981b-openwrt-one: Enable PCIe and USB
> > > > > >      (no matching commit)
> > > > > >    - [v4,06/11] dt-bindings: net: mediatek,net: Correct bindings for MT7981
> > > > > >      https://git.kernel.org/netdev/net-next/c/bc41fbbf6faa
> > > > > >    - [v4,07/11] arm64: dts: mediatek: mt7981b: Add Ethernet and WiFi offload support
> > > > > >      (no matching commit)
> > > > > >    - [v4,08/11] arm64: dts: mediatek: mt7981b-openwrt-one: Enable Ethernet
> > > > > >      (no matching commit)
> > > > > >    - [v4,09/11] arm64: dts: mediatek: mt7981b: Disable wifi by default
> > > > > >      (no matching commit)
> > > > > >    - [v4,10/11] arm64: dts: mediatek: mt7981b: Add wifi memory region
> > > > > >      (no matching commit)
> > > > > >    - [v4,11/11] arm64: dts: mediatek: mt7981b-openwrt-one: Enable wifi
> > > > > >      (no matching commit)
> > > 
> > > This is a very odd way of presenting that one patch from the set was merged.
> > > 
> > > Not sure I've seen this before.  Is it new?
> > > 
> > > It's very confusing.  Is it a core PW thing and / or can it be configured?
> > 
> > It's k.org infra bot. Konstantin, would it be possible to highlight
> > more that a series is partially applied?
> 
> I guess that adding "(subset)" like b4 does would improve those messages quite
> a lot ;-)

Right.  Or better still, just omit the ones that weren't touched.

-- 
Lee Jones [李琼斯]

