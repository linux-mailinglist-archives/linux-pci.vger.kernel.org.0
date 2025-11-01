Return-Path: <linux-pci+bounces-40024-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FF9C28011
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 14:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F40473B08EA
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 13:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E755A2FF156;
	Sat,  1 Nov 2025 13:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YKvrwlao"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE17A2FB630;
	Sat,  1 Nov 2025 13:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762003987; cv=none; b=ZyNkAkRo8/GkWUKuU+GNPDGmdQAMr/JNo4jn/UVblgCkTU5Sm1QlwsTIdPmZweUONpF3RTtNxx/vOtQTzren3Se5b8zVdUPm7wlFQ5KiCx0+8M1FzyDnU8X8NCKv9umfBRpWekIgv0D3/pgU/kDei4ZtBEX+gPDJ+BRfkSBvfV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762003987; c=relaxed/simple;
	bh=0sGo50QhZAUYvr8C78XK2zx4ueC1IRMyU0XyDQeBYdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ALKFJNKomBd+hGaGhP6DalXJS76xkBCU//yqX7iepNSAftyk5qlwAQSmfgo7QEVD3m308/Ebcbj5h9AOBE295HxD7u9tjqdc4IfMjLX55HGX5lp9knHbGsRUcotr9cV5C9/7QHzh8CMSP+tLNnSJwLjYAjHepxdjprti4DWawpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YKvrwlao; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762003979;
	bh=0sGo50QhZAUYvr8C78XK2zx4ueC1IRMyU0XyDQeBYdk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YKvrwlaomCvVdf5pO1wXRaCE+ht8dEiMbKaDBBcl6Tip0dFVPXlhJV2Z+qBQORr3y
	 p5CzK5WZx8pSjLvHokFHo8aD2hVj5iXkP96EMUdMgiXIsYuj5TISAMMOFXgE3wMMis
	 6zhUTPMMOQo+M6jscxmHeC3Z9bvbybDwNq+mFViQnOP6EwshA6LQz/z7Vz/JGPEzns
	 uZIvY3QVvF4UlrA+Wc/HIBpTr6pF6l0pu8ZqMxik+AgQuCf1Yod4SCADH7n+aj25Zb
	 NP43GxJltFfCvD308GkIFX44YhMDVTWT0fiiWSPdVYkuyMVXXGTElDACaCI8sse2LT
	 Lpkyrtt6uAkjw==
Received: from beast.luon.net (simons.connected.by.freedominter.net [45.83.240.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 799B317E153A;
	Sat,  1 Nov 2025 14:32:59 +0100 (CET)
Received: by beast.luon.net (Postfix, from userid 1000)
	id D28E510E9D044; Sat, 01 Nov 2025 14:32:58 +0100 (CET)
From: Sjoerd Simons <sjoerd@collabora.com>
Date: Sat, 01 Nov 2025 14:32:59 +0100
Subject: [PATCH v2 14/15] arm64: dts: mediatek: mt7981b-openwrt-one: Enable
 wifi
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-openwrt-one-network-v2-14-2a162b9eea91@collabora.com>
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

Enable Dual-band WiFI 6 functionality on the Openwrt One

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
---
V1 -> V2: Update eeprom node label
---
 .../boot/dts/mediatek/mt7981b-openwrt-one.dts      | 24 ++++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi          |  2 +-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
index 90edb9f493c6d..b13f16d7816bf 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
@@ -129,6 +129,22 @@ conf-pd {
 			pins = "SPI2_CLK", "SPI2_MOSI", "SPI2_MISO";
 		};
 	};
+
+	wifi_dbdc_pins: wifi-dbdc-pins {
+		mux {
+			function = "eth";
+			groups = "wf0_mode1";
+		};
+
+		conf {
+			pins = "WF_HB1", "WF_HB2", "WF_HB3", "WF_HB4",
+			       "WF_HB0", "WF_HB0_B", "WF_HB5", "WF_HB6",
+			       "WF_HB7", "WF_HB8", "WF_HB9", "WF_HB10",
+			       "WF_TOP_CLK", "WF_TOP_DATA", "WF_XO_REQ",
+			       "WF_CBA_RESETB", "WF_DIG_RESETB";
+			drive-strength = <MTK_DRIVE_4mA>;
+		};
+	};
 };
 
 &spi2 {
@@ -200,6 +216,14 @@ &usb_phy {
 	status = "okay";
 };
 
+&wifi {
+	nvmem-cells = <&wifi_factory_calibration>;
+	nvmem-cell-names = "eeprom";
+	pinctrl-names = "dbdc";
+	pinctrl-0 = <&wifi_dbdc_pins>;
+	status = "okay";
+};
+
 &xhci {
 	phys = <&u2port0 PHY_TYPE_USB2>;
 	vusb33-supply = <&reg_3p3v>;
diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
index eb2effb3c1ed2..17dd13d4c0015 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
@@ -490,7 +490,7 @@ wo_ccif0: syscon@151a5000 {
 			interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		wifi@18000000 {
+		wifi: wifi@18000000 {
 			compatible = "mediatek,mt7981-wmac";
 			reg = <0 0x18000000 0 0x1000000>,
 			      <0 0x10003000 0 0x1000>,

-- 
2.51.0


