Return-Path: <linux-pci+bounces-41801-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C24EC75363
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 17:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C62104E50C2
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 15:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AF12BE639;
	Thu, 20 Nov 2025 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4NueJCx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04C9376BF2;
	Thu, 20 Nov 2025 15:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763653224; cv=none; b=ffGA2N8Ziu17QkWPR1qW/8x7c/tKW6I3kh9NNZv349T6dP2Xs1z/h6QSB0Kwy6TzczCbcPNkKsX+IgYlmb/kFQU6bdlwl01Kv3QdUiDrUsrLOOdxEnXiG47JY835MeImlnXoBxbde8PY4GbXc6N5FGtE7GoVf6sPaxxfKI7BIc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763653224; c=relaxed/simple;
	bh=tNNmZ2QL/T1AtHJf3KMxZyhhMvxqTgXsdcTVHNZESwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gkjv5WqVHQOY3rB4J18gt64Ih8WRG56MXsDMBwMP9RrZjozabg3VT4ftC72iQHHDRTMOynjqrGFw1L2wRVeFk8pwxl6pe9cWffFX0qLNMOtYRUxfXNk2+4sihEyze0sjDeObK+JZd2vm4KZB9w3X7vpXZMuo6ljOfAt0LPeSvfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4NueJCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC6EC4CEF1;
	Thu, 20 Nov 2025 15:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763653222;
	bh=tNNmZ2QL/T1AtHJf3KMxZyhhMvxqTgXsdcTVHNZESwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i4NueJCx9r7KrKIBLF+cUWlHEImFEFp6i4HTJfMhvWzE0AhQ79mVl9GJ5OUOETAfM
	 v62QWN+2FK0HlefMQ7hG+2OPPC0f9N+/gkosLtmKA10LtlP8Bb6C0zwAuL//WSEnXI
	 MT/BFVyE4z4b/wO3+IbcPDwRX7sIFXsco2qbEug2EQ4KzlmW5vKE5c8ACO1XaJXN4h
	 qnbhCjeCCgO/PPPzTjLptR4lFLi1Oh5evb4wDshNYs3UoCfHEbsrc4bUgNU43cgYSE
	 4+k2PcHFO4ggtL4T/WYyj66+4LfcwwcuIGBfwfs8EOo4ZCJdE0o7PmsRZlYtEdCVlQ
	 kjnswH7RBQq/Q==
Date: Thu, 20 Nov 2025 15:40:12 +0000
From: Lee Jones <lee@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: patchwork-bot+netdevbpf@kernel.org,
	Sjoerd Simons <sjoerd@collabora.com>, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com, bhelgaas@google.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	chunfeng.yun@mediatek.com, vkoul@kernel.org, kishon@kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, lorenzo@kernel.org, nbd@nbd.name,
	kernel@collabora.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org, netdev@vger.kernel.org,
	daniel@makrotopia.org, bryan@bryanhinton.com,
	conor.dooley@microchip.com
Subject: Re: [PATCH v4 00/11] arm64: dts: mediatek: Add Openwrt One AP
 functionality
Message-ID: <20251120154012.GJ661940@google.com>
References: <20251115-openwrt-one-network-v4-0-48cbda2969ac@collabora.com>
 <176360700676.1051457.11874224265724256534.git-patchwork-notify@kernel.org>
 <20251120152829.GH661940@google.com>
 <20251120073639.3fd7cc7c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251120073639.3fd7cc7c@kernel.org>

On Thu, 20 Nov 2025, Jakub Kicinski wrote:

> On Thu, 20 Nov 2025 15:28:29 +0000 Lee Jones wrote:
> > > Here is the summary with links:
> > >   - [v4,01/11] dt-bindings: mfd: syscon: Add mt7981-topmisc
> > >     (no matching commit)  
> > 
> > I thought this days of Net randomly picking up MFD patches were behind us!
> 
> Take another look at the message. We picked out just one of the changes
> here.

Ah super!

Thanks for the clarification and apologies for misreading the output.

> > >   - [v4,02/11] dt-bindings: PCI: mediatek-gen3: Add MT7981 PCIe compatible
> > >     (no matching commit)
> > >   - [v4,03/11] dt-bindings: phy: mediatek,tphy: Add support for MT7981
> > >     (no matching commit)
> > >   - [v4,04/11] arm64: dts: mediatek: mt7981b: Add PCIe and USB support
> > >     (no matching commit)
> > >   - [v4,05/11] arm64: dts: mediatek: mt7981b-openwrt-one: Enable PCIe and USB
> > >     (no matching commit)
> > >   - [v4,06/11] dt-bindings: net: mediatek,net: Correct bindings for MT7981
> > >     https://git.kernel.org/netdev/net-next/c/bc41fbbf6faa
> > >   - [v4,07/11] arm64: dts: mediatek: mt7981b: Add Ethernet and WiFi offload support
> > >     (no matching commit)
> > >   - [v4,08/11] arm64: dts: mediatek: mt7981b-openwrt-one: Enable Ethernet
> > >     (no matching commit)
> > >   - [v4,09/11] arm64: dts: mediatek: mt7981b: Disable wifi by default
> > >     (no matching commit)
> > >   - [v4,10/11] arm64: dts: mediatek: mt7981b: Add wifi memory region
> > >     (no matching commit)
> > >   - [v4,11/11] arm64: dts: mediatek: mt7981b-openwrt-one: Enable wifi
> > >     (no matching commit)

This is a very odd way of presenting that one patch from the set was merged.

Not sure I've seen this before.  Is it new?

It's very confusing.  Is it a core PW thing and / or can it be configured?

-- 
Lee Jones [李琼斯]

