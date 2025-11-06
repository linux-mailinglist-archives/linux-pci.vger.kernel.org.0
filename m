Return-Path: <linux-pci+bounces-40475-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 707DBC39C07
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 10:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 599C44E8386
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 09:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A54630AD11;
	Thu,  6 Nov 2025 09:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pfvdnZdf"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D33309EED;
	Thu,  6 Nov 2025 09:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762420081; cv=none; b=I3m0JTNP9sCea+noOLm2t1d5AgljLlNNI0kpRalGJ7Fh9Piu+7pYouG21dS53wR1lwR+wtmw/m1uGZE4dliS9mDgBoHkn47+U22+31m9rle5paTzNuoqvrX2lWZ/z1TcNNtEa220V6wOxjEVtGIKkErfQg5AKsAXdXC8Jfu2pJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762420081; c=relaxed/simple;
	bh=R05X+3is5qj5XVu/b5MKnF2eXebOFORHFE9QRo9u2nY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Mfbxj+NXbak/Q6D93uXcYRjvAR5b+RFRPG4HlhcFiBHai0U1kCIoAaAU9Ks8z1cqUiQbSbnYLUHA6ZMwYBVzihAzvgs2lgo7HxTxqgItpdXu3aYLA3KALmFAuyRd9lSNhAE7/zuwQERmwrCXPpxAmS25z1pZXnWhPlj3X5CZcxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pfvdnZdf; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762420077;
	bh=R05X+3is5qj5XVu/b5MKnF2eXebOFORHFE9QRo9u2nY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pfvdnZdf6TGBy2ZLCk/bI7VlRofCuOQe3W0oeTcG48fm0WEfYaKC5NM+pN3UuGoYN
	 t2VIHpSB4fvCKhbdOHrzMw/o3RJBnqObwWq+DrLvMeFupTtFrd2zVhKREYzTlGBvdV
	 KaThJoaBUDnI5c1cA0Rc5fLhzVEmx0LzEIYrmoqkOM+zcNjY7bIvtVjpAf2oPQ56pV
	 M2xdg6+Pm2LdeWIlV5PTVNVwjND8ce4Tlz1l88jn1qX4Z4K6sOr1vC9EoRo9SOF+hc
	 GmUb6StYIsrOfVGKT3qdnlgkUH7XfSh/+zfbjolEXOaqHuhzSLCpMQLeS/aQR5UFVE
	 fbK8jinHQPDrw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3DA4717E1396;
	Thu,  6 Nov 2025 10:07:56 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, 
 Jianjun Wang <jianjun.wang@mediatek.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Lee Jones <lee@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>, 
 Sjoerd Simons <sjoerd@collabora.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org, 
 linux-phy@lists.infradead.org, netdev@vger.kernel.org, 
 Daniel Golle <daniel@makrotopia.org>, Bryan Hinton <bryan@bryanhinton.com>, 
 Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20251105-openwrt-one-network-v3-0-008e2cab38d1@collabora.com>
References: <20251105-openwrt-one-network-v3-0-008e2cab38d1@collabora.com>
Subject: Re: (subset) [PATCH v3 00/13] arm64: dts: mediatek: Add Openwrt
 One AP functionality
Message-Id: <176242007619.43434.4491815827433419833.b4-ty@collabora.com>
Date: Thu, 06 Nov 2025 10:07:56 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Wed, 05 Nov 2025 22:17:55 +0100, Sjoerd Simons wrote:
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

Applied to v6.18-next/dts64, thanks!

[01/13] arm64: dts: mediatek: mt7981b-openwrt-one: Enable SPI NOR
        commit: 869b3bb5ada2b1632ad0372df5789f07ff53fa68
[02/13] arm64: dts: mediatek: mt7981b-openwrt-one: Enable software leds
        commit: 9b2d2beaefcfa17259fdbce16d59d660894147cb

Cheers,
Angelo



