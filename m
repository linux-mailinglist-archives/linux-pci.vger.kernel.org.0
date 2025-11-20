Return-Path: <linux-pci+bounces-41798-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFFEC751C2
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 16:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF7344E54BC
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 15:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFA7359FA6;
	Thu, 20 Nov 2025 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="us4llj4X"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D95F32FA1A;
	Thu, 20 Nov 2025 15:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763652520; cv=none; b=byxck8fJDykeRDYq2gr+bJyWsX0h6XSUyBx06tNUYZWSuzXdRrEj9/8RcNgMEqC/NIG/ovFIkM1ePlcvm+g9j23/rv+WfbyGCXBTj1UChw4Irvk0m86qWf5TwBOPRFlHqqQKQ0rtS1Mnq2IKlPDCGCXH5XD8YY0UpR1ChTnckAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763652520; c=relaxed/simple;
	bh=av02gv+HZPyHd+lIw8Xh7wER3k0Uka5SXi0z88gxPdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMYRvxPmDK1ntxnhk5y5/EMU1lojiPnXMLoMwQMC+XkMz/YLua8SIMfB1Us7vUHChJv/Du5WxnVEEYVJdcOfFR5VX1k3uRCCcLl2FSWKWyDNgxlOHSeopTmWQx0egtGDrLjFngdhVwcq7s71PV14bKF1FsX7ynWcqVVoWCuQaeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=us4llj4X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A68C4CEF1;
	Thu, 20 Nov 2025 15:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763652519;
	bh=av02gv+HZPyHd+lIw8Xh7wER3k0Uka5SXi0z88gxPdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=us4llj4X391VYU8sOmxwWHHr6n8k/hYwLXlgcz+nzomv7v/yeE+FiT65IYWIbAgx9
	 E3WOUcrMWSI5nuc6ZyTFcoN0rQJStQZ7jj3YcB5EzwnM9SgQNrrF3cTp2pgTU56adT
	 qY5/wBteX0BiewTsoMC6LFq5JKx/5lyeiGolcnXD2fY8OSms46Scsrxx/I6GTHCh4w
	 Q+ywHWt7pBT1aF4HfZVeOTsI2mVlnnUiyOPCn/2zNXDYgqt70Bi1vigQrviKy82t/R
	 Tfq9jc21NLFEJqyJGJi9TIuVjv5kfs6oyASQOLIQdp3xVyZdcwmnc2qV8d4CFOqhSN
	 2LxJGd8kQrtbQ==
Date: Thu, 20 Nov 2025 15:28:29 +0000
From: Lee Jones <lee@kernel.org>
To: patchwork-bot+netdevbpf@kernel.org
Cc: Sjoerd Simons <sjoerd@collabora.com>, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com, bhelgaas@google.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	chunfeng.yun@mediatek.com, vkoul@kernel.org, kishon@kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, lorenzo@kernel.org,
	nbd@nbd.name, kernel@collabora.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org, netdev@vger.kernel.org,
	daniel@makrotopia.org, bryan@bryanhinton.com,
	conor.dooley@microchip.com
Subject: Re: [PATCH v4 00/11] arm64: dts: mediatek: Add Openwrt One AP
 functionality
Message-ID: <20251120152829.GH661940@google.com>
References: <20251115-openwrt-one-network-v4-0-48cbda2969ac@collabora.com>
 <176360700676.1051457.11874224265724256534.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <176360700676.1051457.11874224265724256534.git-patchwork-notify@kernel.org>

On Thu, 20 Nov 2025, patchwork-bot+netdevbpf@kernel.org wrote:

> Hello:
> 
> This series was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
> 
> On Sat, 15 Nov 2025 21:58:03 +0100 you wrote:
> > Significant changes in V4:
> >   * Drop patches that were picked up
> >   * Improve mediatek,net dt bindings:
> >     - Move back to V2 version (widening global constraint, constraining
> >       per compatible)
> >     - Ensure all compatibles are constraint in the amount of WEDs (2 for
> >       everything apart from mt7981). Specifically adding constraints for
> >       mediatek,mt7622-eth and ralink,rt5350-eth
> > Significant changes in V3:
> >   * Drop patches that were picked up
> >   * Re-order patches so changes that don't require dt binding changes
> >     come first (Requested by Angelo)
> >   * Specify drive power directly rather then using MTK_DRIVE_...
> >   * Simply mediatek,net binding changes to avoid accidental changes to
> >     other compatibles then mediatek,mt7981-eth
> > Significant changes in V2:
> >   * https://lore.kernel.org/lkml/20251016-openwrt-one-network-v1-0-de259719b6f2@collabora.com/
> >   * Only introduce labels in mt7981b.dtsi when required
> >   * Switch Airoha EN8811H phy irq to level rather then edge triggered
> >   * Move uart0 pinctrl from board dts to soc dtsi
> >   * Only overwrite constraints with non-default values in MT7981 bindings
> >   * Make SPI NOR nvmem cell labels more meaningfull
> >   * Seperate fixing and disable-by-default for the mt7981 in seperate
> >     patches
> > 
> > [...]
> 
> Here is the summary with links:
>   - [v4,01/11] dt-bindings: mfd: syscon: Add mt7981-topmisc
>     (no matching commit)

I thought this days of Net randomly picking up MFD patches were behind us!

>   - [v4,02/11] dt-bindings: PCI: mediatek-gen3: Add MT7981 PCIe compatible
>     (no matching commit)
>   - [v4,03/11] dt-bindings: phy: mediatek,tphy: Add support for MT7981
>     (no matching commit)
>   - [v4,04/11] arm64: dts: mediatek: mt7981b: Add PCIe and USB support
>     (no matching commit)
>   - [v4,05/11] arm64: dts: mediatek: mt7981b-openwrt-one: Enable PCIe and USB
>     (no matching commit)
>   - [v4,06/11] dt-bindings: net: mediatek,net: Correct bindings for MT7981
>     https://git.kernel.org/netdev/net-next/c/bc41fbbf6faa
>   - [v4,07/11] arm64: dts: mediatek: mt7981b: Add Ethernet and WiFi offload support
>     (no matching commit)
>   - [v4,08/11] arm64: dts: mediatek: mt7981b-openwrt-one: Enable Ethernet
>     (no matching commit)
>   - [v4,09/11] arm64: dts: mediatek: mt7981b: Disable wifi by default
>     (no matching commit)
>   - [v4,10/11] arm64: dts: mediatek: mt7981b: Add wifi memory region
>     (no matching commit)
>   - [v4,11/11] arm64: dts: mediatek: mt7981b-openwrt-one: Enable wifi
>     (no matching commit)
> 
> You are awesome, thank you!
> -- 
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
> 
> 

-- 
Lee Jones [李琼斯]

