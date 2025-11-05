Return-Path: <linux-pci+bounces-40324-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B47C34B06
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 10:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C4FB4FD2BF
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 09:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336312DC789;
	Wed,  5 Nov 2025 09:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="h3zOaont"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1F535965;
	Wed,  5 Nov 2025 09:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762333377; cv=none; b=iyaJjTC7aQ7KtMb2EsF4+x5lgfzZ7DTdo3x4U/5ZcTO6ydyCaoNl62iFpLWeelDTGOb/rX1rSsoS3T7Dmzha85rnipYSKyxEH993Iq5bXZ8ChABuYiH7acMhrMrZhZDO6UE2fj0N+8j5o/Ya89nmcYgdN7e7VIQyiB8Myr9nw80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762333377; c=relaxed/simple;
	bh=D1kXj4gtsjUnasLlwa3L0gfdoh8wYVSZBwRgpQpcno4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cTNfsyyJa/bJysDs3xtBZS0kjOJxw6DrVa8K+zjTvjewfIe7UJRPczrLJFsZ8h7extz24I4GFJVBWX8ZCUbaxk7jEDjp+hYR0ZaIya+GGVjaDQynXkBxEvfIrI5DnSkjaTUxQgd/8OXLM1TCkwGE4X5G404weWUOXrUtsSS3kKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=h3zOaont; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762333373;
	bh=D1kXj4gtsjUnasLlwa3L0gfdoh8wYVSZBwRgpQpcno4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=h3zOaontMw3gV8UO0mm/nlUz+mKiMAJ99bIKofwKyKMd/ku7pb/GREpFL28XlSSRW
	 6QabUiN3r+QP4AGsx65Op2USw/0Iov00cLyZIeMPqY59O6xhNsIj3xGobD6ai/5suM
	 5k8uAbunwROmwGt4grXyY3HkP+gnb8Uy2xyRAl7BJZPqggeMaXfPUfk5raLjPKNSXs
	 0KrLHyYneizQ6UDiG4QI6ENcGQhGjmoTLZtNzeZrGpchVx6h2saSzoedBzZNFncFrJ
	 7j8NV+Ko32UNle3d/5zC03+HIDvkrQCZNGoU3DOtiRm6U9cvZMJvL7gR1rUrAEuwo9
	 qLBNnNUOT1d/Q==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 33AF817E0CA1;
	Wed,  5 Nov 2025 10:02:52 +0100 (CET)
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
In-Reply-To: <20251101-openwrt-one-network-v2-0-2a162b9eea91@collabora.com>
References: <20251101-openwrt-one-network-v2-0-2a162b9eea91@collabora.com>
Subject: Re: (subset) [PATCH v2 00/15] arm64: dts: mediatek: Add Openwrt
 One AP functionality
Message-Id: <176233337214.16133.6784720310145740675.b4-ty@collabora.com>
Date: Wed, 05 Nov 2025 10:02:52 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Sat, 01 Nov 2025 14:32:45 +0100, Sjoerd Simons wrote:
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

[01/15] arm64: dts: mediatek: mt7981b: Configure UART0 pinmux
        commit: 8bc650405f4476667973b10ec58152d37cd41a99
[02/15] arm64: dts: mediatek: mt7981b: Add reserved memory for TF-A
        commit: c6dcf3283044533ec425eb45af3627ec8834aebe

Cheers,
Angelo



