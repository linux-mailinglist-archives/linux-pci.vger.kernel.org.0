Return-Path: <linux-pci+bounces-41317-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 453DAC60B51
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 22:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 459C84E465D
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 21:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E04C30BB8C;
	Sat, 15 Nov 2025 20:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DSjV0V1+"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB50225332E;
	Sat, 15 Nov 2025 20:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763240327; cv=none; b=WWGVMLTjjJp2h5ACBmvRqFXd0K7ADErn3zChT7kH5Dtjla9N1PaBt2qQY791tIzt4Xryzo80teBt6JYhH/Qd8iDl4POm/Uc75H8SntptAZ56X+myTobSl4vNAIRs0ojCLNwA/djQjt3z7XIBEc6VqTAxbqdYCwninR4dcB7xoZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763240327; c=relaxed/simple;
	bh=BQ/4Q4O4iwtOMxBPtuM66Fi5zxdH24aH3c3Edh+F6Gw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qxtfge9dL6VyPD/zn/1/6XBvvPeVUzykHMTOZMJx3lvjLqZURudUlNVLVKk/CLvm3XFmfLMpRhegEJ8xRtJmiaL1OiTA7wTonau4TO68sbBef/xI40WwNml8cAWfA8uDqQzn0HSCsUm8p4r7y2It6nbdTD/acg6EnZoIYiErrso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DSjV0V1+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763240312;
	bh=BQ/4Q4O4iwtOMxBPtuM66Fi5zxdH24aH3c3Edh+F6Gw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DSjV0V1+pdTcThXzfMFVFxo3AXV/sO/vdOgnuumLXA/McJRmPAAXKSP1q7jizRTcD
	 d3EYyfDdqRvo5GEp8XZFCsJkQF7jrT7msKMHKMPHXzMx0GrBVxI7uRizgYtf5EOqrj
	 WSsM8brRdXl9o3g9hU+6oWsWVoQIry5k7OCd0HrYIcgfWzMTBQjedpytCbfrqT8UM2
	 yScTd+eEA3Z/sJ/R+8t7hLirwdPAe5OS/1h+w6lmm2Ww99zTZJVraRVfX+X4054Kcs
	 0Ig3cE5js9Xu+EF3ozrRoz4n6SWCm6OIcmF7/9Pwxtqo/zqcuBhSqHrYR4i2iKjtIF
	 vBA3IAlVcFsBw==
Received: from beast.luon.net (simons.connected.by.freedominter.net [45.83.240.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D99D217E129C;
	Sat, 15 Nov 2025 21:58:32 +0100 (CET)
Received: by beast.luon.net (Postfix, from userid 1000)
	id 3443C110527E5; Sat, 15 Nov 2025 21:58:32 +0100 (CET)
From: Sjoerd Simons <sjoerd@collabora.com>
Date: Sat, 15 Nov 2025 21:58:10 +0100
Subject: [PATCH v4 07/11] arm64: dts: mediatek: mt7981b: Add Ethernet and
 WiFi offload support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251115-openwrt-one-network-v4-7-48cbda2969ac@collabora.com>
References: <20251115-openwrt-one-network-v4-0-48cbda2969ac@collabora.com>
In-Reply-To: <20251115-openwrt-one-network-v4-0-48cbda2969ac@collabora.com>
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

Add device tree nodes for the Ethernet subsystem on MT7981B SoC,
including:
- Ethernet MAC controller with dual GMAC support
- Wireless Ethernet Dispatch (WED)
- SGMII PHY controllers for high-speed Ethernet interfaces
- Reserved memory regions for WiFi offload processor

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
---
V1 -> V2: Don't add unneeded interrupt-parent
---
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi | 133 +++++++++++++++++++++++++++++-
 1 file changed, 132 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
index d3f37413413e2..6be588be3761a 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
@@ -2,6 +2,7 @@
 
 #include <dt-bindings/clock/mediatek,mt7981-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/reset/mt7986-resets.h>
 
@@ -47,11 +48,36 @@ reserved-memory {
 		#size-cells = <2>;
 		ranges;
 
+		wo_boot: wo-boot@15194000 {
+			reg = <0 0x15194000 0 0x1000>;
+			no-map;
+		};
+
+		wo_ilm0: wo-ilm@151e0000 {
+			reg = <0 0x151e0000 0 0x8000>;
+			no-map;
+		};
+
+		wo_dlm0: wo-dlm@151e8000 {
+			reg = <0 0x151e8000 0 0x2000>;
+			no-map;
+		};
+
 		/* 192 KiB reserved for ARM Trusted Firmware (BL31) */
 		secmon_reserved: secmon@43000000 {
 			reg = <0 0x43000000 0 0x30000>;
 			no-map;
 		};
+
+		wo_emi0: wo-emi@47d80000 {
+			reg = <0 0x47d80000 0 0x40000>;
+			no-map;
+		};
+
+		wo_data: wo-data@47dc0000 {
+			reg = <0 0x47dc0000 0 0x240000>;
+			no-map;
+		};
 	};
 
 	soc {
@@ -107,6 +133,18 @@ pwm: pwm@10048000 {
 			#pwm-cells = <2>;
 		};
 
+		sgmiisys0: syscon@10060000 {
+			compatible = "mediatek,mt7981-sgmiisys_0", "syscon";
+			reg = <0 0x10060000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		sgmiisys1: syscon@10070000 {
+			compatible = "mediatek,mt7981-sgmiisys_1", "syscon";
+			reg = <0 0x10070000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		uart0: serial@11002000 {
 			compatible = "mediatek,mt7981-uart", "mediatek,mt6577-uart";
 			reg = <0 0x11002000 0 0x100>;
@@ -345,15 +383,108 @@ soc-uuid@140 {
 			thermal_calibration: thermal-calib@274 {
 				reg = <0x274 0xc>;
 			};
+
+			phy_calibration: phy-calib@8dc {
+				reg = <0x8dc 0x10>;
+			};
 		};
 
-		clock-controller@15000000 {
+		ethsys: clock-controller@15000000 {
 			compatible = "mediatek,mt7981-ethsys", "syscon";
 			reg = <0 0x15000000 0 0x1000>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 		};
 
+		wed: wed@15010000 {
+			compatible = "mediatek,mt7981-wed",
+				     "syscon";
+			reg = <0 0x15010000 0 0x1000>;
+			interrupts = <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>;
+			memory-region = <&wo_emi0>, <&wo_ilm0>, <&wo_dlm0>,
+					<&wo_data>, <&wo_boot>;
+			memory-region-names = "wo-emi", "wo-ilm", "wo-dlm",
+					      "wo-data", "wo-boot";
+			mediatek,wo-ccif = <&wo_ccif0>;
+		};
+
+		eth: ethernet@15100000 {
+			compatible = "mediatek,mt7981-eth";
+			reg = <0 0x15100000 0 0x40000>;
+			assigned-clocks = <&topckgen CLK_TOP_NETSYS_2X_SEL>,
+					  <&topckgen CLK_TOP_SGM_325M_SEL>;
+			assigned-clock-parents = <&topckgen CLK_TOP_CB_NET2_800M>,
+						 <&topckgen CLK_TOP_CB_SGM_325M>;
+			clocks = <&ethsys CLK_ETH_FE_EN>,
+				 <&ethsys CLK_ETH_GP2_EN>,
+				 <&ethsys CLK_ETH_GP1_EN>,
+				 <&ethsys CLK_ETH_WOCPU0_EN>,
+				 <&topckgen CLK_TOP_SGM_REG>,
+				 <&sgmiisys0 CLK_SGM0_TX_EN>,
+				 <&sgmiisys0 CLK_SGM0_RX_EN>,
+				 <&sgmiisys0 CLK_SGM0_CK0_EN>,
+				 <&sgmiisys0 CLK_SGM0_CDR_CK0_EN>,
+				 <&sgmiisys1 CLK_SGM1_TX_EN>,
+				 <&sgmiisys1 CLK_SGM1_RX_EN>,
+				 <&sgmiisys1 CLK_SGM1_CK1_EN>,
+				 <&sgmiisys1 CLK_SGM1_CDR_CK1_EN>,
+				 <&topckgen CLK_TOP_NETSYS_SEL>,
+				 <&topckgen CLK_TOP_NETSYS_500M_SEL>;
+			clock-names = "fe", "gp2", "gp1", "wocpu0",
+				      "sgmii_ck",
+				      "sgmii_tx250m", "sgmii_rx250m",
+				      "sgmii_cdr_ref", "sgmii_cdr_fb",
+				      "sgmii2_tx250m", "sgmii2_rx250m",
+				      "sgmii2_cdr_ref", "sgmii2_cdr_fb",
+				      "netsys0", "netsys1";
+			interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "fe0", "fe1", "fe2", "fe3", "pdma0",
+					  "pdma1", "pdma2", "pdma3";
+			sram = <&eth_sram>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			mediatek,ethsys = <&ethsys>;
+			mediatek,sgmiisys = <&sgmiisys0>, <&sgmiisys1>;
+			mediatek,infracfg = <&topmisc>;
+			mediatek,wed = <&wed>;
+			status = "disabled";
+
+			mdio_bus: mdio-bus {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				int_gbe_phy: ethernet-phy@0 {
+					compatible = "ethernet-phy-ieee802.3-c22";
+					reg = <0>;
+					phy-mode = "gmii";
+					phy-is-integrated;
+					nvmem-cells = <&phy_calibration>;
+					nvmem-cell-names = "phy-cal-data";
+				};
+			};
+		};
+
+		eth_sram: sram@15140000 {
+			compatible = "mmio-sram";
+			reg = <0 0x15140000 0 0x40000>;
+			ranges = <0 0x15140000 0 0x40000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
+		wo_ccif0: syscon@151a5000 {
+			compatible = "mediatek,mt7986-wo-ccif", "syscon";
+			reg = <0 0x151a5000 0 0x1000>;
+			interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		wifi@18000000 {
 			compatible = "mediatek,mt7981-wmac";
 			reg = <0 0x18000000 0 0x1000000>,

-- 
2.51.0


