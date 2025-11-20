Return-Path: <linux-pci+bounces-41799-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA079C751AA
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 16:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 46A60361518
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 15:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCC536212A;
	Thu, 20 Nov 2025 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeFFEDcz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED4C3587CD;
	Thu, 20 Nov 2025 15:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763653001; cv=none; b=CiWyPAN0D2fZ7T2AHoAINxB+ppd+TsMQWgL95Nu8uwi2GWgaNVIbc+b0GqsWvYmPsn5CLuOxa+L6OvIflVRh45NEHCKzS17rA5kVGvIpGmM2Z8oagr44DnJXt1azn0hvCKBVLFt6svA/uJvllYtjYdgNfA85DkvKKGDIZWULX/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763653001; c=relaxed/simple;
	bh=+aGNaTeVJngMwOwA64XdaB9ifWJd/aa78elcucuzIgc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N8n5hIpps7TC+OfHyAI9VKXfEmQV8CD0SRb9bTQ757C/L4RVqGdk5AI5sIjsi397WbsRSRacqLgrmLhyeEDYWOZMt0erCa8+dHOKfmHbiGzxAtUQIdRUP8IfjLOWp36pXI2FLFcRhb4nDeMv1pY42CPciuOk69H7kFR1e9E6zSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SeFFEDcz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC21C4CEF1;
	Thu, 20 Nov 2025 15:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763653001;
	bh=+aGNaTeVJngMwOwA64XdaB9ifWJd/aa78elcucuzIgc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SeFFEDczH7jPbHi+EYQ+sIf0oCHiwIQ5iPH115LBNjCwEIhCXk3C1JCMr/s47Cccw
	 HIjpwg1T0ze1NrOk61RfXwoGWrOtYLXvQuh2KdkpNWxtAMQ3ooIahWo71l0v0MXaBr
	 8J4H01xV557QizPm//LwiO87c8EFsFxXmuNSSgIVDfefXObbxRBiO9LUZVBIw1rakz
	 EQS72Cxfd2gCh0dDwTlTGUCjcQRPNGo73n9Zwpxk971lJALOlsqQN2uJc6HIZqwnlm
	 aL2g+etKHCmgEEgC1S/YYnxZvR6HNV5oCiPaMoE40pGkkaXIiKbpaL/RHXmUS1fEI0
	 lFeoPixvjRkSA==
Date: Thu, 20 Nov 2025 07:36:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lee Jones <lee@kernel.org>
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
Message-ID: <20251120073639.3fd7cc7c@kernel.org>
In-Reply-To: <20251120152829.GH661940@google.com>
References: <20251115-openwrt-one-network-v4-0-48cbda2969ac@collabora.com>
	<176360700676.1051457.11874224265724256534.git-patchwork-notify@kernel.org>
	<20251120152829.GH661940@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Nov 2025 15:28:29 +0000 Lee Jones wrote:
> > Here is the summary with links:
> >   - [v4,01/11] dt-bindings: mfd: syscon: Add mt7981-topmisc
> >     (no matching commit)  
> 
> I thought this days of Net randomly picking up MFD patches were behind us!

Take another look at the message. We picked out just one of the changes
here.

> >   - [v4,02/11] dt-bindings: PCI: mediatek-gen3: Add MT7981 PCIe compatible
> >     (no matching commit)
> >   - [v4,03/11] dt-bindings: phy: mediatek,tphy: Add support for MT7981
> >     (no matching commit)
> >   - [v4,04/11] arm64: dts: mediatek: mt7981b: Add PCIe and USB support
> >     (no matching commit)
> >   - [v4,05/11] arm64: dts: mediatek: mt7981b-openwrt-one: Enable PCIe and USB
> >     (no matching commit)
> >   - [v4,06/11] dt-bindings: net: mediatek,net: Correct bindings for MT7981
> >     https://git.kernel.org/netdev/net-next/c/bc41fbbf6faa
> >   - [v4,07/11] arm64: dts: mediatek: mt7981b: Add Ethernet and WiFi offload support
> >     (no matching commit)
> >   - [v4,08/11] arm64: dts: mediatek: mt7981b-openwrt-one: Enable Ethernet
> >     (no matching commit)
> >   - [v4,09/11] arm64: dts: mediatek: mt7981b: Disable wifi by default
> >     (no matching commit)
> >   - [v4,10/11] arm64: dts: mediatek: mt7981b: Add wifi memory region
> >     (no matching commit)
> >   - [v4,11/11] arm64: dts: mediatek: mt7981b-openwrt-one: Enable wifi
> >     (no matching commit)

