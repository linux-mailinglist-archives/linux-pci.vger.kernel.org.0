Return-Path: <linux-pci+bounces-38321-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6524DBE2AE7
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 12:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52B9118935D2
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 10:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8257332E697;
	Thu, 16 Oct 2025 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gTWsBAl8"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A366A31E0EA;
	Thu, 16 Oct 2025 10:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760609342; cv=none; b=Ev9CKlubjBqD/MzZIfyZakoxWm0+20vt7UGXR+N2ar7Xg1/5deW9olntexIwBTBCKkPDt4PtHM13NGsnKn+aeH26EzWCWpSY3NNmdwFTIQcvmdedo6FkVKS1RL95b9WZS/G6IY4G/aocVrZMh63/xXZnxsXnoCAsQec4NXOzLYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760609342; c=relaxed/simple;
	bh=w368zsNX/7RFI6/9BhFxtQZ38q3Yz3Ll3aX5wpQs4Yk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t0v47YeaxUx25pe0rfxy4XUkjU50bPEdFRVpNIC5s8Sx1Mw20dT+0oEUDXCqKcJNBZy0OszVCrtbO7y5+OruIhxCWnOiZR8QcD2KF2nmLykmg+7HbjlP7fSyIxS5Nrw8VE8xMnfozKb6PledpSSK9VJlLE4YrcdVz+h1pAqgl2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gTWsBAl8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760609334;
	bh=w368zsNX/7RFI6/9BhFxtQZ38q3Yz3Ll3aX5wpQs4Yk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gTWsBAl8V5t8ELaCK2AvIZhRbfmRJSHj/8+sonVs+QxuGKIJwr++t3jsyLTyIlCbC
	 oPl4IcxJTbUxTi3PIipIaCOpS6jz7MIdHuJCh6MQurVBCEC4BIWMKiBT1vhWzuchwL
	 RZlMz5XxpPM6VeCCfCX3SI8PG16v24HifT8Bxb2YixtaraPRdppoBoEZ/vN/gSNsht
	 veVssPNvQQWse0y2XMZdo9/DZH6HpumskFrOobZMF2okKlce0eexy2auJ2sepwwMlu
	 18Ck0dTF6AAebsGzqhVYOzNtTROl7xg8sdHliUYYx5VQdEgvO2flplIXj6yQsn8WrH
	 RlNi1QrCF237w==
Received: from beast.luon.net (unknown [IPv6:2a10:3781:2531::8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7F0A917E1404;
	Thu, 16 Oct 2025 12:08:54 +0200 (CEST)
Received: by beast.luon.net (Postfix, from userid 1000)
	id 8A3F810C9C782; Thu, 16 Oct 2025 12:08:53 +0200 (CEST)
From: Sjoerd Simons <sjoerd@collabora.com>
Date: Thu, 16 Oct 2025 12:08:37 +0200
Subject: [PATCH 01/15] arm64: dts: mediatek: mt7981b: Add labels to
 commonly referenced nodes
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-openwrt-one-network-v1-1-de259719b6f2@collabora.com>
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

Add labels to various device nodes in the MT7981B DTSI, similar to other
mediatek dtsi files.

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
index 58c99f2a25218..6b024156fa7c5 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
@@ -14,14 +14,14 @@ cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu@0 {
+		cpu0: cpu@0 {
 			compatible = "arm,cortex-a53";
 			reg = <0x0>;
 			device_type = "cpu";
 			enable-method = "psci";
 		};
 
-		cpu@1 {
+		cpu1: cpu@1 {
 			compatible = "arm,cortex-a53";
 			reg = <0x1>;
 			device_type = "cpu";
@@ -29,7 +29,7 @@ cpu@1 {
 		};
 	};
 
-	oscillator-40m {
+	clk40m: oscillator-40m {
 		compatible = "fixed-clock";
 		clock-frequency = <40000000>;
 		clock-output-names = "clkxtal";
@@ -82,7 +82,7 @@ apmixedsys: clock-controller@1001e000 {
 			#clock-cells = <1>;
 		};
 
-		pwm@10048000 {
+		pwm: pwm@10048000 {
 			compatible = "mediatek,mt7981-pwm";
 			reg = <0 0x10048000 0 0x1000>;
 			clocks = <&infracfg CLK_INFRA_PWM_STA>,
@@ -127,7 +127,7 @@ uart2: serial@11004000 {
 			status = "disabled";
 		};
 
-		i2c@11007000 {
+		i2c0: i2c@11007000 {
 			compatible = "mediatek,mt7981-i2c";
 			reg = <0 0x11007000 0 0x1000>,
 			      <0 0x10217080 0 0x80>;
@@ -142,7 +142,7 @@ i2c@11007000 {
 			status = "disabled";
 		};
 
-		spi@11009000 {
+		spi2: spi@11009000 {
 			compatible = "mediatek,mt7981-spi-ipm", "mediatek,spi-ipm";
 			reg = <0 0x11009000 0 0x1000>;
 			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
@@ -156,7 +156,7 @@ spi@11009000 {
 			status = "disabled";
 		};
 
-		spi@1100a000 {
+		spi0: spi@1100a000 {
 			compatible = "mediatek,mt7981-spi-ipm", "mediatek,spi-ipm";
 			reg = <0 0x1100a000 0 0x1000>;
 			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
@@ -170,7 +170,7 @@ spi@1100a000 {
 			status = "disabled";
 		};
 
-		spi@1100b000 {
+		spi1: spi@1100b000 {
 			compatible = "mediatek,mt7981-spi-ipm", "mediatek,spi-ipm";
 			reg = <0 0x1100b000 0 0x1000>;
 			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
@@ -184,7 +184,7 @@ spi@1100b000 {
 			status = "disabled";
 		};
 
-		thermal@1100c800 {
+		thermal: thermal@1100c800 {
 			compatible = "mediatek,mt7981-thermal",
 				     "mediatek,mt7986-thermal";
 			reg = <0 0x1100c800 0 0x800>;
@@ -231,7 +231,7 @@ pio: pinctrl@11d00000 {
 			#interrupt-cells = <2>;
 		};
 
-		efuse@11f20000 {
+		efuse: efuse@11f20000 {
 			compatible = "mediatek,mt7981-efuse", "mediatek,efuse";
 			reg = <0 0x11f20000 0 0x1000>;
 			#address-cells = <1>;
@@ -246,14 +246,14 @@ thermal_calibration: thermal-calib@274 {
 			};
 		};
 
-		clock-controller@15000000 {
+		ethsys: clock-controller@15000000 {
 			compatible = "mediatek,mt7981-ethsys", "syscon";
 			reg = <0 0x15000000 0 0x1000>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 		};
 
-		wifi@18000000 {
+		wifi: wifi@18000000 {
 			compatible = "mediatek,mt7981-wmac";
 			reg = <0 0x18000000 0 0x1000000>,
 			      <0 0x10003000 0 0x1000>,

-- 
2.51.0


