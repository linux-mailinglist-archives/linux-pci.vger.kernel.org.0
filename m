Return-Path: <linux-pci+bounces-43583-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E456CD94CC
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 13:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6542A3002768
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 12:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB69533A00F;
	Tue, 23 Dec 2025 12:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QXNvcrhT"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ADE30BF5C;
	Tue, 23 Dec 2025 12:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766493492; cv=none; b=ld3gx5H3Q27JWpAsLDtKsWFR7rS/0ZD2kVsXQ4rap2krtI39uvFjNP0tXreuPI1XqE8VACu8kv3pEZLQLJoeEP3ARLWuG8rpgDok138PNnozlsZNvU/jBnoc3a7rDufWDfR+0D3rOsUMp6cCaWF3hPtTOVbDAmOmyj6ce2ozqmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766493492; c=relaxed/simple;
	bh=K5Nj+BYQPFzSaJiXTGgmFgtyYEa4HLdec7n2eRuB2Tc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k3LjDQXoTquJqfrLOCmqt/DEzR/goF64d3EvJ4YsilrGh0P7bEJv71GJBDvaGxsiEAFKKhIac5jcBJA/lGIsaaFSz0qG5Y4ti8UJS22lDPP87N1G1l+ocWujNZp0nC97rOfOM6LXQggjWrjQmJI9YjFjgqzQW48/xUHCg8Ja8wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QXNvcrhT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1766493489;
	bh=K5Nj+BYQPFzSaJiXTGgmFgtyYEa4HLdec7n2eRuB2Tc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QXNvcrhTYXILhwMqpY3ljwG2I38H2MrXI7HIFkhDASQQBNSRDG4HIfWn9A3x3b8Oa
	 Qvu73DqtmF/L/hN0uXQ2NEZKTV6OtLXxFGQE2gEIG9zlX8s01ndlRPyhA6A8Pr+i85
	 /t8usTQRYKEUdGxGI9di8JdCcDhJGLfow6J1/nzOVtafjGNRvxO738SMQTGSk7T42D
	 cJTyx1ZA6XWJxJxqhwZOskEeGixJxxqjzPY5t3tbhC9+jdIShLFAlhm2yXptpoS9ao
	 Z6nS5BON0QtNBZuV3eicjNNXVL6nQyeWZMv3yp0vxMVyklrJU4myaZ/guQbM0cgjs5
	 WsAVwQtshSdxw==
Received: from beast.luon.net (unknown [IPv6:2a10:3781:2531:0:f337:3245:2545:b505])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 259A117E150C;
	Tue, 23 Dec 2025 13:38:09 +0100 (CET)
Received: by beast.luon.net (Postfix, from userid 1000)
	id 5F8C4117A0679; Tue, 23 Dec 2025 13:38:08 +0100 (CET)
From: Sjoerd Simons <sjoerd@collabora.com>
Date: Tue, 23 Dec 2025 13:37:56 +0100
Subject: [PATCH v5 6/8] arm64: dts: mediatek: mt7981b: Disable wifi by
 default
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-openwrt-one-network-v5-6-7d1864ea3ad5@collabora.com>
References: <20251223-openwrt-one-network-v5-0-7d1864ea3ad5@collabora.com>
In-Reply-To: <20251223-openwrt-one-network-v5-0-7d1864ea3ad5@collabora.com>
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
index 6be588be3761..1f4c11435466 100644
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


