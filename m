Return-Path: <linux-pci+bounces-41713-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9ECC71E41
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 03:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 5E58929B2B
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 02:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4A52F49E0;
	Thu, 20 Nov 2025 02:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8MjIokI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE72A28A1F1;
	Thu, 20 Nov 2025 02:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763607041; cv=none; b=jcjOVaoDOZV1+wgKwk8UzQIbTpSF8lan2VPmIdYN98+KeYZDi0xeoUzwahEKJXgsk5NBwDQSc0YcsTqLJ9iHq7UMoz4se7JKfSoeSKuwkMPeFtOkSy3MCm9w7gqXCrqIhgkvd/4b0GolVNXxqu7JgXmZknCQafuM0NHCpAl9PR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763607041; c=relaxed/simple;
	bh=Aa7WnttGEYS9DURKutasxGDYsZUdjqB9YngO+llu6wc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C4r4IUpwi1U+MkLX3u93wu4GRdtISbFU00bXwvUs0hNX4ejM4ZcgNlUoyNB+IFnIpNBAyHfjonraHBDoTbNRAvqRfwuuHoEf+T3SiV0DkO1mTNCuFnbNzDt+pay6Z+s4MlW+6fDzRsmGCemUjRxx8GIswWzElSAm8GGYXot7Sck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8MjIokI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE17C4CEF5;
	Thu, 20 Nov 2025 02:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763607041;
	bh=Aa7WnttGEYS9DURKutasxGDYsZUdjqB9YngO+llu6wc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S8MjIokIPFiZtBoyLBhAKt0Eug5olwn21DgCteRt2goUeFiplqSVQ0DaqYvklPhyY
	 CS6dPeKFTQq8swWVerxdr/5zzsYF/BKPGHhHhpFXgo9ae/HcvxaRnI8AMl6Fi6c7Bk
	 +CDWkdTTQ2Ciey6FwLEhQrPo5NyN8Z6pwhxSub3K9YLEN906H3WNsDabCsJ7uJPwwv
	 WbwKo4JVKIRsFYv6yqO9uIwikHQVDb4oiUOLL6Cre0bDb4ErQ1MRPixvYzd6JPJv+z
	 m8+4+SzI6lWRulT2OP6V8nNlbYVlB2Df9yTZi/CIxe+J/p5us+qqAo0L6z4az0lpZF
	 ZvxsXSDUBtB3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB15F39EF96C;
	Thu, 20 Nov 2025 02:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 00/11] arm64: dts: mediatek: Add Openwrt One AP
 functionality
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176360700676.1051457.11874224265724256534.git-patchwork-notify@kernel.org>
Date: Thu, 20 Nov 2025 02:50:06 +0000
References: <20251115-openwrt-one-network-v4-0-48cbda2969ac@collabora.com>
In-Reply-To: <20251115-openwrt-one-network-v4-0-48cbda2969ac@collabora.com>
To: Sjoerd Simons <sjoerd@collabora.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 ryder.lee@mediatek.com, jianjun.wang@mediatek.com, bhelgaas@google.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 chunfeng.yun@mediatek.com, vkoul@kernel.org, kishon@kernel.org,
 lee@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, lorenzo@kernel.org,
 nbd@nbd.name, kernel@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-phy@lists.infradead.org, netdev@vger.kernel.org, daniel@makrotopia.org,
 bryan@bryanhinton.com, conor.dooley@microchip.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 15 Nov 2025 21:58:03 +0100 you wrote:
> Significant changes in V4:
>   * Drop patches that were picked up
>   * Improve mediatek,net dt bindings:
>     - Move back to V2 version (widening global constraint, constraining
>       per compatible)
>     - Ensure all compatibles are constraint in the amount of WEDs (2 for
>       everything apart from mt7981). Specifically adding constraints for
>       mediatek,mt7622-eth and ralink,rt5350-eth
> Significant changes in V3:
>   * Drop patches that were picked up
>   * Re-order patches so changes that don't require dt binding changes
>     come first (Requested by Angelo)
>   * Specify drive power directly rather then using MTK_DRIVE_...
>   * Simply mediatek,net binding changes to avoid accidental changes to
>     other compatibles then mediatek,mt7981-eth
> Significant changes in V2:
>   * https://lore.kernel.org/lkml/20251016-openwrt-one-network-v1-0-de259719b6f2@collabora.com/
>   * Only introduce labels in mt7981b.dtsi when required
>   * Switch Airoha EN8811H phy irq to level rather then edge triggered
>   * Move uart0 pinctrl from board dts to soc dtsi
>   * Only overwrite constraints with non-default values in MT7981 bindings
>   * Make SPI NOR nvmem cell labels more meaningfull
>   * Seperate fixing and disable-by-default for the mt7981 in seperate
>     patches
> 
> [...]

Here is the summary with links:
  - [v4,01/11] dt-bindings: mfd: syscon: Add mt7981-topmisc
    (no matching commit)
  - [v4,02/11] dt-bindings: PCI: mediatek-gen3: Add MT7981 PCIe compatible
    (no matching commit)
  - [v4,03/11] dt-bindings: phy: mediatek,tphy: Add support for MT7981
    (no matching commit)
  - [v4,04/11] arm64: dts: mediatek: mt7981b: Add PCIe and USB support
    (no matching commit)
  - [v4,05/11] arm64: dts: mediatek: mt7981b-openwrt-one: Enable PCIe and USB
    (no matching commit)
  - [v4,06/11] dt-bindings: net: mediatek,net: Correct bindings for MT7981
    https://git.kernel.org/netdev/net-next/c/bc41fbbf6faa
  - [v4,07/11] arm64: dts: mediatek: mt7981b: Add Ethernet and WiFi offload support
    (no matching commit)
  - [v4,08/11] arm64: dts: mediatek: mt7981b-openwrt-one: Enable Ethernet
    (no matching commit)
  - [v4,09/11] arm64: dts: mediatek: mt7981b: Disable wifi by default
    (no matching commit)
  - [v4,10/11] arm64: dts: mediatek: mt7981b: Add wifi memory region
    (no matching commit)
  - [v4,11/11] arm64: dts: mediatek: mt7981b-openwrt-one: Enable wifi
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



