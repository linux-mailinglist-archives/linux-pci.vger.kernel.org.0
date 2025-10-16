Return-Path: <linux-pci+bounces-38326-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 42947BE2B41
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 12:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 372885076DC
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 10:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C73B32F76E;
	Thu, 16 Oct 2025 10:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nNSNiutk"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6197F320CB7;
	Thu, 16 Oct 2025 10:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760609344; cv=none; b=s2LZtr3TxNwMvLevGqSjLTnw7UFNEM6zTNv2nDAlC81oC5BY9Si4oH8wNRnfjX3S2vRxBSb9B/XjUeatE9JH7XcsSdnRM+UEFV5oFeHy5zAKuY366edi3gonKj3nOYubejfd4xazwcTdOelI+6in0qNxRXjmaCFqhJIRzKBj16k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760609344; c=relaxed/simple;
	bh=UT1tGvKU5Kvq7l45Piyw1w46GgfZtcLVNXUBPC/Jvcg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eDy/ggK/FFa5aC72/FRUf8rK4Mxgy1fxvpgduuMWdWP7xWfvMNpefCsCF57/CMRFWer9tvfGUVJ/ZiJUh9Y2teLG5wlAmiXhIfzmN92N9VZdbrFdTS6gtGcR+tWZvQPbFuD3UeUEZonL6ScosqBHgN+3ADKAXiBRSQiCkEeXepE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nNSNiutk; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760609335;
	bh=UT1tGvKU5Kvq7l45Piyw1w46GgfZtcLVNXUBPC/Jvcg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nNSNiutkn7HdoT12AweE3Yf8fveb8adNGcEY8mIxvDC56vs5OWPYUEfyqDtwnzJ43
	 xue6+GOI6FE37MWsEDfvPmV0vTgLFM9YyRYfmTNP1ePNLzVR4zmKPogw/V5utQyjVf
	 QEOVbHfmrxKUq+u3CtdnBSj8QEkLRIEjtoVuTOxlF6bMCwvctIZC9oC7mUyG1kmva7
	 +zzYsvgRdvLJAdPgrmDKJUVbxcoedx2XIOLJiT+0+hfUcpoj3O64m/C3YKBbtAlAG5
	 nt430CPqMt95EzW/umLdkgxt0e/Ma3rfp03RYKyAQJHj0suGDHPJbnLzpD6BzSmr0s
	 KyIcxgeTJFFpA==
Received: from beast.luon.net (unknown [IPv6:2a10:3781:2531::8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3364617E14FF;
	Thu, 16 Oct 2025 12:08:55 +0200 (CEST)
Received: by beast.luon.net (Postfix, from userid 1000)
	id D6C8E10C9C79E; Thu, 16 Oct 2025 12:08:53 +0200 (CEST)
From: Sjoerd Simons <sjoerd@collabora.com>
Date: Thu, 16 Oct 2025 12:08:51 +0200
Subject: [PATCH 15/15] arm64: dts: mediatek: mt7981b-openwrt-one: Enable
 leds
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-openwrt-one-network-v1-15-de259719b6f2@collabora.com>
References: <20251016-openwrt-one-network-v1-0-de259719b6f2@collabora.com>
In-Reply-To: <20251016-openwrt-one-network-v1-0-de259719b6f2@collabora.com>
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

The Openwrt One has 3 status leds at the front (red, white, green) as
well as 2 software controlled leds for the LAN jack (amber, green).

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
---
 .../boot/dts/mediatek/mt7981b-openwrt-one.dts      | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
index 4d1653c336e71..0c0878488ae98 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
@@ -43,6 +43,50 @@ reg_5v: regulator-5v {
 		regulator-boot-on;
 		regulator-always-on;
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
 
 &eth {
@@ -109,6 +153,13 @@ mux {
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
@@ -152,6 +203,12 @@ conf {
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

-- 
2.51.0


