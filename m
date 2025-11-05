Return-Path: <linux-pci+bounces-40429-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A87CC38021
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 22:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62541A24B6E
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 21:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14E02F6175;
	Wed,  5 Nov 2025 21:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pX5785Xe"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744FF2E8DEB;
	Wed,  5 Nov 2025 21:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762377524; cv=none; b=qbcfGyeB6edquKbZEkDis/eoY49AMB5bpb3QDR4Y82OkCnjl8b3FMU7l8jJYr0skqhEt+aiW20OWFafAp03ZjVOJyhCgZnKwz0JDyfdEeF4YX9pndjWnMkYpELAOD1dfbgeoFSKFP00On1nDqciTW2uELYA4K81mwrdIBGoE9VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762377524; c=relaxed/simple;
	bh=HT2YugA6R+JpQglGJhQu+r3GtnpE3Srg2faLNwIOQZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XN2tJsQq5jDDGl0wu5md+giXnO1F8uDCwew85oC1pO65+2HorNkcg5+KSvQzWXl2xIrNCtobssh9F9YxkWLw8zwZWrhOIqpDUUSAoP0PFjWRp+zdQKgKzqxTBKXF+U43OuJhoZ28OTqb7K7DQPVwwITATFWK+JgrYtNGv9KBSY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pX5785Xe; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762377520;
	bh=HT2YugA6R+JpQglGJhQu+r3GtnpE3Srg2faLNwIOQZE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pX5785XeaN9MSnSwL2CJEFah8vNhRL8O3uSgIa5IIUsi0dsVKQvFHNPboZ1/t6VGy
	 HYMGlF/jafIWUIBCk3xUfon2NPBc/8iS7yAe6TOMu+7np1x2bdtprDcNn2WTGFcX5c
	 t9YD1NdO/D97DTeU+AuNZeMagJIob4P/4RUTgI0pyfPYexY505AVtR4IYod4lwE/iD
	 14zbJi4IQ7nOQq2nXVZRLfsFZOl8Se0bc8bOiGCKbU7u2hCgO/MHEZmy7Tp5lOFOO+
	 arFcHIVGSPsrSCy0aGHPYhJxu8F2xT+eBJsfmFn39sWISuHJXg3lY64C/eh1tAKFqu
	 /M/mfIOF6ApyQ==
Received: from beast.luon.net (unknown [IPv6:2a10:3781:2531::8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6F62117E156C;
	Wed,  5 Nov 2025 22:18:40 +0100 (CET)
Received: by beast.luon.net (Postfix, from userid 1000)
	id CC1B810F352F1; Wed, 05 Nov 2025 22:18:34 +0100 (CET)
From: Sjoerd Simons <sjoerd@collabora.com>
Date: Wed, 05 Nov 2025 22:18:07 +0100
Subject: [PATCH v3 12/13] arm64: dts: mediatek: mt7981b: Add wifi memory
 region
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-openwrt-one-network-v3-12-008e2cab38d1@collabora.com>
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

Add required memory region for the builtin wifi block.

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
---
V1 -> V2: Don't set status to in this patch
---
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
index 1f4c114354660..a7be3670e0059 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
@@ -69,6 +69,11 @@ secmon_reserved: secmon@43000000 {
 			no-map;
 		};
 
+		wmcpu_emi: wmcpu-reserved@47c80000 {
+			reg = <0 0x47c80000 0 0x100000>;
+			no-map;
+		};
+
 		wo_emi0: wo-emi@47d80000 {
 			reg = <0 0x47d80000 0 0x40000>;
 			no-map;
@@ -497,6 +502,7 @@ wifi@18000000 {
 			clocks = <&topckgen CLK_TOP_NETSYS_MCU_SEL>,
 				 <&topckgen CLK_TOP_AP2CNN_HOST_SEL>;
 			clock-names = "mcu", "ap2conn";
+			memory-region = <&wmcpu_emi>;
 			resets = <&watchdog MT7986_TOPRGU_CONSYS_SW_RST>;
 			reset-names = "consys";
 			status = "disabled";

-- 
2.51.0


