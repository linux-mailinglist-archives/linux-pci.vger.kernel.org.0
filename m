Return-Path: <linux-pci+bounces-40416-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FABC37FB8
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 22:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C03318876B4
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 21:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABB12C0276;
	Wed,  5 Nov 2025 21:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VOReS/tB"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6CC248F73;
	Wed,  5 Nov 2025 21:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762377518; cv=none; b=J9borlUMqza8Ix6B0yLHsO1l67vCZv5eq2944mOeevq129rk0QoG7m/1mGufZiInALaUsvuhL2oiUlgV/9suj5wfkSRkd70dQ3WgcspWGOt2E4XGtgm1A4hJFqcd/mOHSI1oJfTVba1YK1jdJN264RVIXCGAFMbEVj8bCzMcljs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762377518; c=relaxed/simple;
	bh=bArrOhdqiPrD9jwVtY5HEE/53V3p8i0UZ8xJQqCPlD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aFIFfHVuBHejyNquFCTQ5NVVpd+XAsPVAtqzJBJ0qM+zA30HpEdccADwtvRnvpy3d7MmDSFUGQFJWcejZ3iF0br5UNpzM4DTFcRHEeh0gOtv0g0juRibDaK/t4/B84CRG2XQnerXbdlkRvw+dWkDh5tJOTa05scMIG8Wz5mv+BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VOReS/tB; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762377515;
	bh=bArrOhdqiPrD9jwVtY5HEE/53V3p8i0UZ8xJQqCPlD0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VOReS/tBa/q6ng2Yhr2+/vUP5UB2401ugVhFf+0UORldLzyq+GXymaYL+4TyWBzbq
	 E5iJPmF4FgnRteq2+Zzs4MGmfv6KXhmt2G3qH5ETOCYYTIUARBRY6u25jdHX+O/gMo
	 RQjh+GIR3h/L5Zus48T6qNKpMtJhHs1KZ5A/r+YahUv+BbOSHCEvWT7GIIh/9XOhL7
	 6WqcFwJl8Xo3y+1LOMSyZZ/b8WZs6XemcZZkphmKBEawG5voNrNc2TjHbEBZ2Imc79
	 JR7TkSCCYcSdQkGq79iDohJaa4FfGFvVEDfMbGBBWDITlglqViL0jmLc5ieNhvCiXt
	 VgNVVQbZqGcxg==
Received: from beast.luon.net (unknown [IPv6:2a10:3781:2531::8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E12A417E129C;
	Wed,  5 Nov 2025 22:18:34 +0100 (CET)
Received: by beast.luon.net (Postfix, from userid 1000)
	id 96B5110F352DD; Wed, 05 Nov 2025 22:18:34 +0100 (CET)
From: Sjoerd Simons <sjoerd@collabora.com>
Date: Wed, 05 Nov 2025 22:17:57 +0100
Subject: [PATCH v3 02/13] arm64: dts: mediatek: mt7981b-openwrt-one: Enable
 software leds
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-openwrt-one-network-v3-2-008e2cab38d1@collabora.com>
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

The openwrt has 3 status leds at the front:
* red: Used as failsafe led by openwrt
* white: Used as boot led by openwrt
* green: Used as running/upgrade led by openwrt

On the back each RJ45 jack has the typical amber/green leds. For the WAN
jack this is hardware controlled by the phy, for LAN these are under
software control and enabled by this patch.

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
---
V2 -> V3: Move earlier in the patch sequence
V1 -> V2:
  - Improve commit message
  - Re-order nodes to be alphabetical
---
 .../boot/dts/mediatek/mt7981b-openwrt-one.dts      | 59 ++++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi          |  2 +-
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
index 6bb98629f4536..2e39e72877301 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
@@ -3,6 +3,8 @@
 /dts-v1/;
 
 #include "mt7981b.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
 #include "dt-bindings/pinctrl/mt65xx.h"
 
 / {
@@ -21,9 +23,60 @@ memory@40000000 {
 		reg = <0 0x40000000 0 0x40000000>;
 		device_type = "memory";
 	};
+
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
 };
 
 &pio {
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
@@ -44,6 +97,12 @@ conf-pd {
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
index f00e5bf63de35..416096b80770c 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
@@ -94,7 +94,7 @@ apmixedsys: clock-controller@1001e000 {
 			#clock-cells = <1>;
 		};
 
-		pwm@10048000 {
+		pwm: pwm@10048000 {
 			compatible = "mediatek,mt7981-pwm";
 			reg = <0 0x10048000 0 0x1000>;
 			clocks = <&infracfg CLK_INFRA_PWM_STA>,

-- 
2.51.0


