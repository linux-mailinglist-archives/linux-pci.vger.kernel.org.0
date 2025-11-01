Return-Path: <linux-pci+bounces-40027-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DFCC28038
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 14:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A28E94E8D1F
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 13:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6108030507E;
	Sat,  1 Nov 2025 13:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nh2aYfQi"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04972FF161;
	Sat,  1 Nov 2025 13:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762003990; cv=none; b=e9pPS5Uu12khZOgJQPOnSMnQCNpJyehyuZ3mppoO3hwsHOIY/ZS/d6dySOcuPd88KD34TShX/NA/Ro4BrJKW6aI/AUWjF5OnRcrlbYz8m4QKY+HaZA8DlonpuIU/UDpRFDjbm0bVuZ1bF3QnXLV20OO0GMz7X9sEGUl47Orv8x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762003990; c=relaxed/simple;
	bh=ZDZDYWQ0pBb006s9WoF4BubE2PEuT8OM2W2BmbduJzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MiFKxEdsTtysVKtfkzoD04sBm0AM0giPlyKDN1stHJVPKHGYe/zY4M72ApSq1Df8qB3z2mngXFYGXXJQl0j1arEB2pbHij1wdS54i1ILNFsFKm/U+zglskOqdcBbxH4yBRZMwzg4vpP6QlTSRpOsvFXcGrf9/rvD3Uah24SER+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nh2aYfQi; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762003980;
	bh=ZDZDYWQ0pBb006s9WoF4BubE2PEuT8OM2W2BmbduJzY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nh2aYfQiFcRIetufBWS4vqK2KujifLFy12b1CPMyEOtcoYhLE/xrV5Z+8TBe2ka1Y
	 tbkq5j9dPw+LmwO5l3yr0d8wgLaMh5I8BDq0dWngGXFhKtZQMp+hSKQJ2h5HIwJ8FL
	 89c5YvH3G2+WvzansquvT24h55dufBJ440yPgy5QvlS2W/E2J8Gb4YfucZnT/zJNyG
	 1KFlTc05ffnK2Yg0admBEDga9+t+9okKrtOpkkzwi7Iq8Ulyxgmnl1nC5XSm8GRNVi
	 Z+J0ig2rqLRqsLHepcS1MLKLb/tmbTbIRkjWu1JCKlOcw8BuM0wZn4C3qAwBr72z9o
	 r9SWVNNmJ+4lA==
Received: from beast.luon.net (unknown [IPv6:2a10:3781:2531::8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E9FB817E35CB;
	Sat,  1 Nov 2025 14:32:59 +0100 (CET)
Received: by beast.luon.net (Postfix, from userid 1000)
	id BF4D510E9D03E; Sat, 01 Nov 2025 14:32:58 +0100 (CET)
From: Sjoerd Simons <sjoerd@collabora.com>
Date: Sat, 01 Nov 2025 14:32:56 +0100
Subject: [PATCH v2 11/15] arm64: dts: mediatek: mt7981b-openwrt-one: Enable
 Ethernet
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-openwrt-one-network-v2-11-2a162b9eea91@collabora.com>
References: <20251101-openwrt-one-network-v2-0-2a162b9eea91@collabora.com>
In-Reply-To: <20251101-openwrt-one-network-v2-0-2a162b9eea91@collabora.com>
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

Enable the Ethernet subsystem on OpenWrt One board with dual-MAC
configuration:
- GMAC0: Connected to external Airoha EN8811H 2.5GbE PHY via SGMII
  (2500base-x mode) for WAN connectivity with LED indicators
- GMAC1: Connected to internal MT7981 1GbE PHY (GMII mode) for LAN

Ethernet aliases are defined to provide consistent network interface
naming (ethernet0 = LAN, ethernet1 = WAN).

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
---
V1 -> V2:
  - Switch gmac0 phy irq to Level
  - Update mac nvmem label name
---
 .../boot/dts/mediatek/mt7981b-openwrt-one.dts      | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
index 183e48d985ed7..90edb9f493c6d 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
@@ -3,6 +3,8 @@
 /dts-v1/;
 
 #include "mt7981b.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
 #include "dt-bindings/pinctrl/mt65xx.h"
 
 / {
@@ -10,6 +12,8 @@ / {
 	model = "OpenWrt One";
 
 	aliases {
+		ethernet0 = &gmac1;
+		ethernet1 = &gmac0;
 		serial0 = &uart0;
 	};
 
@@ -41,6 +45,58 @@ reg_5v: regulator-5v {
 	};
 };
 
+&eth {
+	status = "okay";
+
+	/* WAN interface */
+	gmac0: mac@0 {
+		compatible = "mediatek,eth-mac";
+		reg = <0>;
+		nvmem-cells = <&wan_factory_mac 0>;
+		nvmem-cell-names = "mac-address";
+		phy-mode = "2500base-x";
+		phy-handle = <&phy15>;
+	};
+
+	/* LAN interface */
+	gmac1: mac@1 {
+		compatible = "mediatek,eth-mac";
+		reg = <1>;
+		phy-mode = "gmii";
+		phy-handle = <&int_gbe_phy>;
+	};
+};
+
+&mdio_bus {
+	phy15: ethernet-phy@f {
+		compatible = "ethernet-phy-id03a2.a411";
+		reg = <0xf>;
+		interrupt-parent = <&pio>;
+		interrupts = <38 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpios = <&pio 39 GPIO_ACTIVE_LOW>;
+		reset-assert-us = <10000>;
+		reset-deassert-us = <20000>;
+		airoha,pnswap-rx;
+
+		leds {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led@0 {
+				reg = <0>;
+				function = LED_FUNCTION_WAN;
+				color = <LED_COLOR_ID_AMBER>;
+			};
+
+			led@1 {
+				reg = <1>;
+				function = LED_FUNCTION_WAN;
+				color = <LED_COLOR_ID_GREEN>;
+			};
+		};
+	};
+};
+
 &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie_pins>;
@@ -132,6 +188,10 @@ partition@180000 {
 	};
 };
 
+&sgmiisys0 {
+	mediatek,pnswap;
+};
+
 &uart0 {
 	status = "okay";
 };

-- 
2.51.0


