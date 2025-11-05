Return-Path: <linux-pci+bounces-40426-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF3BC37F9A
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 22:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9207F4EAE99
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 21:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B75F2F3630;
	Wed,  5 Nov 2025 21:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IaRJcfEJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748542E7BD3;
	Wed,  5 Nov 2025 21:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762377524; cv=none; b=ClfEwOUbYhNxAyha+xENcmb5go9BTvKsTJCV9M/AEgsYCZjHdTFw7u/BTI8L8U6MXw9p2JCSyGdQiuC095b4oL4tuYhRp4BlhPikg5P/1VZTrMx8NAftoCD4RdmUmw+zJctRECjk6nXr0ZkWlRGxWTJiuGpmK+cczSqHBmabQ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762377524; c=relaxed/simple;
	bh=qtE8TxX+bp4mVeKXXycM622mPKaw8qoe/nGz0YEjV0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RPcNb0qKgErbTLQ6FurZbAtTT7ruEmDsRMBb1J3OSPyM1CFYajGzJ4U/UAR0Kea5cVSGohy9oeTE87VWFuiARqVBqx/WqfU7ymnwYGYzH1F7tx+JH6pygQVOcXKZrXTSR+t3GG6Pprz15DD4w/51c3ukCeK2INjAxV4rZFGHaxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IaRJcfEJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762377516;
	bh=qtE8TxX+bp4mVeKXXycM622mPKaw8qoe/nGz0YEjV0g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IaRJcfEJJPmuVxfIA0AMonJG0NAIwG2GFs1HcbU8uvXF99pgELvzC5G7nSSRhwUVJ
	 LuwV5lD0JO+6NbQDCg/6824/ru1L/WtPNmPZ9XIv2dmNWRPrG1D+ir8Y18q8GzoaIE
	 qEW8KlPcmRtH5QYv8gEmfKMpqY/vnwuoHhrQxhH/YBZUJn8Mrio3T/yeFVOaa9Kfp/
	 3bU7QVAyxxZtxGmkVSf/V0rYQ39sDr5ivWxPxN2ygRhLyKoa/vXN3Zh8b/MbgnaR53
	 jdmgxlQ8Y7in86CB/YBRRqqqam07WivxiWw5icWmtAT4asEubhTmOpyhAMNyxRoJ/A
	 g3EvDDnrDetBw==
Received: from beast.luon.net (unknown [IPv6:2a10:3781:2531::8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4164C17E1500;
	Wed,  5 Nov 2025 22:18:36 +0100 (CET)
Received: by beast.luon.net (Postfix, from userid 1000)
	id B209C10F352E7; Wed, 05 Nov 2025 22:18:34 +0100 (CET)
From: Sjoerd Simons <sjoerd@collabora.com>
Date: Wed, 05 Nov 2025 22:18:02 +0100
Subject: [PATCH v3 07/13] arm64: dts: mediatek: mt7981b-openwrt-one: Enable
 PCIe and USB
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-openwrt-one-network-v3-7-008e2cab38d1@collabora.com>
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

Enable the PCIe controller and USB3 XHCI host on the OpenWrt One
board. The USB controller is configured for USB 2.0 only mode, as the
shared USB3/PCIe PHY is dedicated to PCIe functionality on this board.

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
---
 .../boot/dts/mediatek/mt7981b-openwrt-one.dts      | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
index 2e39e72877301..7382599cfea29 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
@@ -67,9 +67,40 @@ led-2 {
 			linux,default-trigger = "netdev";
 		};
 	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_5v: regulator-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
+
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_pins>;
+	status = "okay";
 };
 
 &pio {
+	pcie_pins: pcie-pins {
+		mux {
+			function = "pcie";
+			groups = "pcie_pereset";
+		};
+	};
+
 	pwm_pins: pwm-pins {
 		mux {
 			function = "pwm";
@@ -163,3 +194,15 @@ partition@180000 {
 &uart0 {
 	status = "okay";
 };
+
+&usb_phy {
+	status = "okay";
+};
+
+&xhci {
+	phys = <&u2port0 PHY_TYPE_USB2>;
+	vusb33-supply = <&reg_3p3v>;
+	vbus-supply = <&reg_5v>;
+	mediatek,u3p-dis-msk = <0x01>;
+	status = "okay";
+};

-- 
2.51.0


