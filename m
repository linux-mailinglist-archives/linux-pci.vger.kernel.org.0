Return-Path: <linux-pci+bounces-40421-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3E6C37F43
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 22:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EDA8A34F5EB
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 21:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764732E92A2;
	Wed,  5 Nov 2025 21:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="N1qA/7Am"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C052E0922;
	Wed,  5 Nov 2025 21:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762377522; cv=none; b=quCHz3fNG+Vwo4X3VUPXY0opeIXgUxSQ2XSupkOC8FhESC/7TRTfNOg68ql+IWwAYk5btQrUuE/J/Nq8PogK6zmIksj+YDso62vlmCIaKJi/j51A5Ogwvc14kh4h6R/Lh4dEw7tspac41eZHFso08TvStcfx13+bFE3JTOWH2nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762377522; c=relaxed/simple;
	bh=haXHZnrCQw87Hh0XlwT4Nqlq0lDr5SGoeyDsPgAcJ6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=prxIF1dszkhwoE33DlLYdm9efh3igCFegRljRzvNkEnQN/C6VPh//N3YvUz/P5Oovq+jnhF83oRxRGpGOXPbPB2MoxqwWUo9cDj+YPRwOwKJPny+zEI9HgAw2qTSVrdRWNUsBaU2VlzjZHIFRGAU95vmsQn2KTQMhyDXAgK+EkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=N1qA/7Am; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762377515;
	bh=haXHZnrCQw87Hh0XlwT4Nqlq0lDr5SGoeyDsPgAcJ6c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=N1qA/7AmkMt4wN9yHy1phEnePp5ToltlmZwi7UCQxXJhlXCL6boQBVdmwpoNtT8KS
	 1X9s51SEPTLvco84Ou9mu/1q7X9ITJ4rv9QHS1yryzpoUpFuSCo/fOTVZq8ISh6Krx
	 kSMG98HfMijUn/ebXM+RRkEg5wOX6HPEg09mKH//uRLukU2lb/Mi4AnOqXIlIpgD8e
	 l9PVEOccMc5Mt25cBc+GBXKeuDbglnliEVbfnq/ctRiishATKfBCbtrXO+OtmOaATJ
	 DRXagBcQDZ/Ww8oM9BTwO4aphu2lcOX1lSnzmWSMOud08FP0ecqwbQ7Sa0UvpvhoKH
	 whKx1JPflZ1mA==
Received: from beast.luon.net (unknown [IPv6:2a10:3781:2531::8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8654D17E1402;
	Wed,  5 Nov 2025 22:18:35 +0100 (CET)
Received: by beast.luon.net (Postfix, from userid 1000)
	id C8D3810F352EF; Wed, 05 Nov 2025 22:18:34 +0100 (CET)
From: Sjoerd Simons <sjoerd@collabora.com>
Date: Wed, 05 Nov 2025 22:18:06 +0100
Subject: [PATCH v3 11/13] arm64: dts: mediatek: mt7981b: Disable wifi by
 default
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-openwrt-one-network-v3-11-008e2cab38d1@collabora.com>
References: <20251105-openwrt-one-network-v3-0-008e2cab38d1@collabora.com>
In-Reply-To: <20251105-openwrt-one-network-v3-0-008e2cab38d1@collabora.com>
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
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Lee Jones <lee@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org, 
 linux-phy@lists.infradead.org, netdev@vger.kernel.org, 
 Daniel Golle <daniel@makrotopia.org>, Bryan Hinton <bryan@bryanhinton.com>, 
 Sjoerd Simons <sjoerd@collabora.com>
X-Mailer: b4 0.14.3

Disable the wifi block by default as it won't function properly without
at least pin muxing.

This doesn't enable wifi on any of the existing mt7981b devices as a
required memory-region property is missing, causing the driver to fail
probing anyway.

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
---
V2: Newly introduced patch
---
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
index 6be588be3761a..1f4c114354660 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
@@ -499,6 +499,7 @@ wifi@18000000 {
 			clock-names = "mcu", "ap2conn";
 			resets = <&watchdog MT7986_TOPRGU_CONSYS_SW_RST>;
 			reset-names = "consys";
+			status = "disabled";
 		};
 	};
 

-- 
2.51.0


