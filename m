Return-Path: <linux-pci+bounces-40025-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 089A7C28023
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 14:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB838401C54
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 13:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313832FFFA9;
	Sat,  1 Nov 2025 13:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="E2Y4n+Ev"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597CE2FBDF5;
	Sat,  1 Nov 2025 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762003988; cv=none; b=uxbhNy55qzSH5ujCiCuAL/GquCKY2JELcYsQhgIxXJKksvsCpx7/shCxT/QR8nkigz/5JdTWhlPbCPELr79FCr1/YhSG0fnlG+vushxHhWtOWkfinTsh9vV2sg3Tc99VkSbUW7fgQ9WxduLRRT9LgV8F9RGhNNGOVxrf+KiWAPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762003988; c=relaxed/simple;
	bh=UijHeDMHMdBNIO9BLCrR9i8WyBLXoUJhDobFME3OXHY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=coyeVg7ID0SqbxN/O109Q4337PkruuG3tyoMG7CA566JQJDoxrlGMNSmYnJnCY8U3gC6y8vgvZjunRJqWAt/WmzEYHOfd+Uelv+SUGWYs7zWspmn2fFxAw+6HQL5jxS7pRpx6drnRfSza8lFX0N4nym+yqN9NWY53hhMo3NVNYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=E2Y4n+Ev; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762003979;
	bh=UijHeDMHMdBNIO9BLCrR9i8WyBLXoUJhDobFME3OXHY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E2Y4n+EvnaE3MViZJ+XtsJMVOGjHDNaXPHmKm7axkj15Dv1CxLY1N8BjXN02rR8O0
	 9TvvzOxKf4fnbLYiwGtq7+KCVzMMr324qhvDZC3P8vK53ZLTd/0useF9Bh6e8Zd6vB
	 c2NXXUGlc4EwCg83rG+hSzrN3UPVRlNcY2M8G+2zaRI5mKoEOnT7A2o93LSBBDgwwt
	 12sD3DVv7WpV7RolzzryQw1AQbd1VdYpIuf/c9iigfn8fZKxbpDCb+ti2l5lhxemt8
	 n+YJ2TdqlN+mtwTrYmyMYs2+s2Ch4ZKIwk3V4g8pxJOMe5GCobJ2vKfhTG8x0b2RfR
	 BuygEanXt5xVg==
Received: from beast.luon.net (simons.connected.by.freedominter.net [45.83.240.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AB5BE17E15C9;
	Sat,  1 Nov 2025 14:32:59 +0100 (CET)
Received: by beast.luon.net (Postfix, from userid 1000)
	id DC29010E9D046; Sat, 01 Nov 2025 14:32:58 +0100 (CET)
From: Sjoerd Simons <sjoerd@collabora.com>
Date: Sat, 01 Nov 2025 14:33:00 +0100
Subject: [PATCH v2 15/15] arm64: dts: mediatek: mt7981b-openwrt-one: Enable
 software leds
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-openwrt-one-network-v2-15-2a162b9eea91@collabora.com>
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

The openwrt has 3 status leds at the front:
* red: Used as failsafe led by openwrt
* white: Used as boot led by openwrt
* green: Used as running/upgrade led by openwrt

On the back each RJ45 jack has the typical amber/green leds. For the WAN
jack this is hardware controlled by the phy, for LAN these are under
software control and enabled by this patch.

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
---
V1 -> V2:
  - Improve commit message
  - Re-order nodes to be alphabetical
---
 .../boot/dts/mediatek/mt7981b-openwrt-one.dts      | 57 ++++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi          |  2 +-
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
index b13f16d7816bf..b308b7ad4945d 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
@@ -26,6 +26,50 @@ memory@40000000 {
 		device_type = "memory";
 	};
 
+	pwm-leds {
+		compatible = "pwm-leds";
+
+		led-0 {
+			color = <LED_COLOR_ID_WHITE>;
+			default-brightness = <0>;
+			function = LED_FUNCTION_STATUS;
+			max-brightness = <255>;
+			pwms = <&pwm 0 10000>;
+		};
+
+		led-1 {
+			color = <LED_COLOR_ID_GREEN>;
+			default-brightness = <0>;
+			function = LED_FUNCTION_STATUS;
+			max-brightness = <255>;
+			pwms = <&pwm 1 10000>;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&pio 9 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-1 {
+			color = <LED_COLOR_ID_AMBER>;
+			function = LED_FUNCTION_LAN;
+			gpios = <&pio 34 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "netdev";
+		};
+
+		led-2 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_LAN;
+			gpios = <&pio 35 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "netdev";
+		};
+	};
+
 	reg_3p3v: regulator-3p3v {
 		compatible = "regulator-fixed";
 		regulator-name = "fixed-3.3V";
@@ -111,6 +155,13 @@ mux {
 		};
 	};
 
+	pwm_pins: pwm-pins {
+		mux {
+			function = "pwm";
+			groups = "pwm0_0", "pwm1_1";
+		};
+	};
+
 	spi2_flash_pins: spi2-pins {
 		mux {
 			function = "spi";
@@ -147,6 +198,12 @@ conf {
 	};
 };
 
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm_pins>;
+	status = "okay";
+};
+
 &spi2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi2_flash_pins>;
diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
index 17dd13d4c0015..66d89495bac52 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
@@ -126,7 +126,7 @@ apmixedsys: clock-controller@1001e000 {
 			#clock-cells = <1>;
 		};
 
-		pwm@10048000 {
+		pwm: pwm@10048000 {
 			compatible = "mediatek,mt7981-pwm";
 			reg = <0 0x10048000 0 0x1000>;
 			clocks = <&infracfg CLK_INFRA_PWM_STA>,

-- 
2.51.0


