Return-Path: <linux-pci+bounces-41818-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8790DC75908
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 18:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 9856B2BEF5
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 17:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2209C36214A;
	Thu, 20 Nov 2025 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqLfR4iU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15D02F1FF3;
	Thu, 20 Nov 2025 17:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763658676; cv=none; b=jw1rjqC3XTNVwat/7jxXF/ls187TCJYgCtDGX6kOAT7o+5EJut8MYaGxngzw2DfBqQuTqt5nrS7dMm5XpFdzuzDyO650TT+/X8I8fLj9MBZ9ssLd//OY6Vpn930+F3HZXaFE3GqI+fdpUWGPKdtf6mlST2TJpubgFo/0QSf4i8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763658676; c=relaxed/simple;
	bh=TMLntoU8iUOS/qsRpXy6ReTJ0gjhyOEPYkzAMR3tBsI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HS8KKNst0vZ1JTzoXTYXGbjn8aB8dF6D+RXImhcUEvuxCevbg1zM4DbcsWA/wNRItsy8ILXy9gfqow10XJBQ4PrrwZN+G/Ecabp2AVB0Rt7vBFD4rxVExc9gUXrKL43aMBLVJhAkfRsLeatt9OFVlLSqr+/JwvXR/blILh8AXyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqLfR4iU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A38C4CEF1;
	Thu, 20 Nov 2025 17:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763658675;
	bh=TMLntoU8iUOS/qsRpXy6ReTJ0gjhyOEPYkzAMR3tBsI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aqLfR4iUeq0dB4adf+THdyDTXEYLPmrUzBfkTi+siE4FErR83JFGTcLfKnZPwMODP
	 zj2cUYj3WBLrInuLNgbziXnA7+G9xs8XtvV8dheiKGDn0HgJZReHIrRT/oWGXTphBw
	 jav2dXGGvpcDBBZpIT1RCdSYwVNydmY44mIGqMAlNo1AsrYfgc5+mcS8i3aaEEr2ud
	 4TUiRefxrRVy12nbdxe98sT9eFv8FdR5zFScbGQQFtJSC3KnpPv1GWm214oV8dZjgT
	 NBl/XpNE1EKX2BLhLbdvZITRXTf7HBvkVza3ncDhy4jxeipTFt+dX7P+f3c6f1D9CH
	 5vSYkUHWrDl8w==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, 
 Jianjun Wang <jianjun.wang@mediatek.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
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
In-Reply-To: <20251115-openwrt-one-network-v4-0-48cbda2969ac@collabora.com>
References: <20251115-openwrt-one-network-v4-0-48cbda2969ac@collabora.com>
Subject: Re: (subset) [PATCH v4 00/11] arm64: dts: mediatek: Add Openwrt
 One AP functionality
Message-Id: <176365866697.207696.9870186215211079064.b4-ty@kernel.org>
Date: Thu, 20 Nov 2025 22:41:06 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Sat, 15 Nov 2025 21:58:03 +0100, Sjoerd Simons wrote:
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

Applied, thanks!

[03/11] dt-bindings: phy: mediatek,tphy: Add support for MT7981
        commit: 80ac0fba0f1a72be2c7b532b8e2ad61300a165c3

Best regards,
-- 
~Vinod



