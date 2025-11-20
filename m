Return-Path: <linux-pci+bounces-41803-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56981C752D6
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 16:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A8274EB51C
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 15:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C2235F8AB;
	Thu, 20 Nov 2025 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKY+ap4N"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD44362148;
	Thu, 20 Nov 2025 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763653500; cv=none; b=GnmSdlndKslllJ51NPMukaUR+lyyAxLNuDu3vCLkAQ0bwZqliScowQVr0+RNCKJykD3tx8XcGRd1CC+ghG5RPJcsE1WX96UDwZrSDRyMIVWZhXG/nWR8YR0GCQmIeAUwCsArcsXwnEkgKF8kUPkxdK1NICjZfxa1SyNKXMWKgCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763653500; c=relaxed/simple;
	bh=3LqOxODjnWoAP85raLtIKnv5cNa5InqYMD4HtPn0Jyk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h0BKLKCSF/JIAqFotLk1w86W6r+m+u5avFpQNRjcp3MOHVO6O8XI9/7TO0+axqRrIEVGW/3m59LLVDhNg2DdGR/wZINi8Xd+t/Hm8goAoFhz4Ii7POfa7GY3OTGzQtQlholQpn2KAUt6oM00OY+9MV/mLyswAf0/QvU8lrS/ojc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKY+ap4N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D90FC4CEF1;
	Thu, 20 Nov 2025 15:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763653500;
	bh=3LqOxODjnWoAP85raLtIKnv5cNa5InqYMD4HtPn0Jyk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LKY+ap4NYFE5J1G3Sy7gfSDDID+FtmQ7psQdU05gg25PHaQWWaA+KmwaNu0UUCqk3
	 RWQVdK/BTkOv7omtykdjw8g1kjb2FnXcqvBzi84P13BLVL/Dz/2CGJ8X/yGvPDCAJr
	 g2sIZslOqXkQ0ix0413DAJWjG3ZXo4P5uSCajXUmzI/SHLKgnC+ivm11nZ70iPv6Fi
	 uuBM6FpnqCmPeGxYRjn9TtvQCw1kCylery5WZeV2WpyqeyrQmUCBReJjZIeH98X/TP
	 sw2EvTHsIEquigEPX91TxuLN2Sy9ncO3wZXs7QQp+nbA9JnAwKlZ/1OOdVjiY6BqrE
	 jmS7kRCJS5ZFw==
Date: Thu, 20 Nov 2025 07:44:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lee Jones <lee@kernel.org>, Konstantin Ryabitsev
 <konstantin@linuxfoundation.org>
Cc: patchwork-bot+netdevbpf@kernel.org, Sjoerd Simons
 <sjoerd@collabora.com>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, ryder.lee@mediatek.com,
 jianjun.wang@mediatek.com, bhelgaas@google.com, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, chunfeng.yun@mediatek.com,
 vkoul@kernel.org, kishon@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 lorenzo@kernel.org, nbd@nbd.name, kernel@collabora.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
 netdev@vger.kernel.org, daniel@makrotopia.org, bryan@bryanhinton.com,
 conor.dooley@microchip.com
Subject: Re: [PATCH v4 00/11] arm64: dts: mediatek: Add Openwrt One AP
 functionality
Message-ID: <20251120074457.5aa06d89@kernel.org>
In-Reply-To: <20251120154012.GJ661940@google.com>
References: <20251115-openwrt-one-network-v4-0-48cbda2969ac@collabora.com>
	<176360700676.1051457.11874224265724256534.git-patchwork-notify@kernel.org>
	<20251120152829.GH661940@google.com>
	<20251120073639.3fd7cc7c@kernel.org>
	<20251120154012.GJ661940@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Nov 2025 15:40:12 +0000 Lee Jones wrote:
> > > >   - [v4,02/11] dt-bindings: PCI: mediatek-gen3: Add MT7981 PCIe compatible
> > > >     (no matching commit)
> > > >   - [v4,03/11] dt-bindings: phy: mediatek,tphy: Add support for MT7981
> > > >     (no matching commit)
> > > >   - [v4,04/11] arm64: dts: mediatek: mt7981b: Add PCIe and USB support
> > > >     (no matching commit)
> > > >   - [v4,05/11] arm64: dts: mediatek: mt7981b-openwrt-one: Enable PCIe and USB
> > > >     (no matching commit)
> > > >   - [v4,06/11] dt-bindings: net: mediatek,net: Correct bindings for MT7981
> > > >     https://git.kernel.org/netdev/net-next/c/bc41fbbf6faa
> > > >   - [v4,07/11] arm64: dts: mediatek: mt7981b: Add Ethernet and WiFi offload support
> > > >     (no matching commit)
> > > >   - [v4,08/11] arm64: dts: mediatek: mt7981b-openwrt-one: Enable Ethernet
> > > >     (no matching commit)
> > > >   - [v4,09/11] arm64: dts: mediatek: mt7981b: Disable wifi by default
> > > >     (no matching commit)
> > > >   - [v4,10/11] arm64: dts: mediatek: mt7981b: Add wifi memory region
> > > >     (no matching commit)
> > > >   - [v4,11/11] arm64: dts: mediatek: mt7981b-openwrt-one: Enable wifi
> > > >     (no matching commit)  
> 
> This is a very odd way of presenting that one patch from the set was merged.
> 
> Not sure I've seen this before.  Is it new?
> 
> It's very confusing.  Is it a core PW thing and / or can it be configured?

It's k.org infra bot. Konstantin, would it be possible to highlight
more that a series is partially applied?

