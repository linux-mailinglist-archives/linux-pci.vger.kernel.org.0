Return-Path: <linux-pci+bounces-38322-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BD6BE2AEA
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 12:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B946819C184C
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 10:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C578732E6BC;
	Thu, 16 Oct 2025 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FSKOlFpm"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0274E2571BE;
	Thu, 16 Oct 2025 10:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760609342; cv=none; b=FQNKy+kocRHL5lw1e43Dvs2QWNQzyRaKKRcMhBkIIgBFa8UDb2yFrMScuQLeTDW9EHSdZNS0jBndh6XSszhpdkfwKHYa+WLirasn9mhg6coq8rFShrVJyCwTIBCNmcBEhqoeoP2XUvDmLhJYsajYskBJV6WREde66FEm+tgTPr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760609342; c=relaxed/simple;
	bh=YvAn2hXGjztM1f4HAy7F7ikwrS8JBglEj5IZ6jjRVbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=isPmWoutiq+/MktsMuHGZTUBLgnSu7fXj5hBDSZYtPK1iUfmHDy8YTRjf6Hq5UPSFlHSB+vTw1rdnbeYsgyE/ubkuzlyIgoU6a1DswTUvnbcyNDOadRNgI5H435hD0dYkJBuHbilMqrhGDKh7sYksD4nsd66nIWkJz76pfAZ0wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FSKOlFpm; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760609335;
	bh=YvAn2hXGjztM1f4HAy7F7ikwrS8JBglEj5IZ6jjRVbk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FSKOlFpmwY7sUH1WQ/xDcnfPl7kPCE2PU2w3q6mkklwXimgaee8Lrfd5F55Mueol/
	 +vRfOg5LBWulaWOqgNwp4tbZz8DM1hp5aVv2CG6DrlOOIPMjP0Fv8uQTUPFmJy8q83
	 FwB7cwUi3JjrV7fyaCVCBR2LPpVLvN/R5NvbcfUoTDEeZRA96mCmxgyCJmJv507hF4
	 iljK26EEF8A8iXRqIRRXfYdek6nmA/SH3qy52EUZL9az0VfF3qyHyc3UbI6hsURWWT
	 IDz937cM4t3WGk9cG3z1TCX6Fa/iLrJWHLgq/eTBGXkYW3+L0YXmsiJms6XjtFLywi
	 q04mimivQkHSw==
Received: from beast.luon.net (simons.connected.by.freedominter.net [45.83.240.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F1B3E17E1418;
	Thu, 16 Oct 2025 12:08:54 +0200 (CEST)
Received: by beast.luon.net (Postfix, from userid 1000)
	id C6ED810C9C798; Thu, 16 Oct 2025 12:08:53 +0200 (CEST)
From: Sjoerd Simons <sjoerd@collabora.com>
Date: Thu, 16 Oct 2025 12:08:48 +0200
Subject: [PATCH 12/15] arm64: dts: mediatek: mt7981b-openwrt-one: Enable
 Ethernet
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-openwrt-one-network-v1-12-de259719b6f2@collabora.com>
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

Enable the Ethernet subsystem on OpenWrt One board with dual-MAC
configuration:
- GMAC0: Connected to external Airoha EN8811H 2.5GbE PHY via SGMII
  (2500base-x mode) for WAN connectivity with LED indicators
- GMAC1: Connected to internal MT7981 1GbE PHY (GMII mode) for LAN

Ethernet aliases are defined to provide consistent network interface
naming (ethernet0 = LAN, ethernet1 = WAN).

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
---
 .../boot/dts/mediatek/mt7981b-openwrt-one.dts      | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
index 9878009385cc6..6e6e4f1515f67 100644
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
 
@@ -41,6 +45,56 @@ reg_5v: regulator-5v {
 	};
 };
 
+&eth {
+	status = "okay";
+
+	gmac0: mac@0 {
+		compatible = "mediatek,eth-mac";
+		reg = <0>;
+		nvmem-cells = <&macaddr_factory_24 0>;
+		nvmem-cell-names = "mac-address";
+		phy-mode = "2500base-x";
+		phy-handle = <&phy15>;
+	};
+
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
+		interrupts = <38 IRQ_TYPE_EDGE_FALLING>;
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
@@ -145,6 +199,10 @@ partition@180000 {
 	};
 };
 
+&sgmiisys0 {
+	mediatek,pnswap;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins>;

-- 
2.51.0


