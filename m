Return-Path: <linux-pci+bounces-40420-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 699D2C380C5
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 22:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 233BA3BD2C1
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 21:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AC12E6106;
	Wed,  5 Nov 2025 21:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WUkRIO/L"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D73E286D4E;
	Wed,  5 Nov 2025 21:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762377520; cv=none; b=nVEKaZLJJIoIm+m+G2Dm//payzX1rYrcOETY0FeGQ8352biQwO3B9Xy+9CcwfdBMNfCSiIqqzSFIjNgNGvttJ/nQjE2GYz/FySsqUQnZqs/CpV5pjkD0ZtV+2xjLahVj+wJTPa+tgXK/dXL1sjqi/nTu5EWT9eOA5qEThigf0KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762377520; c=relaxed/simple;
	bh=USBTzS5LeZooJ42tEMhi7N85ITpVvJxHo6le5MQpsP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NOrV+dw/0lsmvK5f9+h5V0A+tZSz8hg7m0NhRJkrwqzbhz0OZxD2CfLHZjmmRsMupSzP8v0Qxg1VD3f+Y8BC7REvq9vCObLZ5w7kLVdS4BaDuwcG53r3CP8PRLV3MtFx5SEY4PxhDv6rhyyacDie6EXQjClzeF2LLF5OEOJKUak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WUkRIO/L; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762377515;
	bh=USBTzS5LeZooJ42tEMhi7N85ITpVvJxHo6le5MQpsP8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WUkRIO/LYeerYC6Qq/d0vAfift6ItxGSaUObXGhLruOzlq7/kcBr+2CN1AmZAyYlB
	 ZRHuj0ONVxvE+iM881QLIewGCInjRhlpv766aT3kf5EdndnvQpUWI6mGcXSL9+D0bN
	 0ymjCtAs+DhWJriToq1IQY5gRFeScXU6UIUtzPu2MxzrkrxXxGN01BwA6CQ4EmIum6
	 Pk5d7dytEcRSh4zBULWcisWeYuZETEWT38J4AeK75/W2ocxODRxIv13QX4OA+rI2Yu
	 gHgcEnQgXIYVVIgDHHmZ463GAH23E5F2DeDcWV6rYF/15ONDTxTVsY/8HKSAF8qhz4
	 Y2Ku4wTENqHjg==
Received: from beast.luon.net (simons.connected.by.freedominter.net [45.83.240.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5918117E13DC;
	Wed,  5 Nov 2025 22:18:35 +0100 (CET)
Received: by beast.luon.net (Postfix, from userid 1000)
	id AC8E110F352E5; Wed, 05 Nov 2025 22:18:34 +0100 (CET)
From: Sjoerd Simons <sjoerd@collabora.com>
Date: Wed, 05 Nov 2025 22:18:01 +0100
Subject: [PATCH v3 06/13] arm64: dts: mediatek: mt7981b: Add PCIe and USB
 support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-openwrt-one-network-v3-6-008e2cab38d1@collabora.com>
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

Add device tree nodes for PCIe controller and USB3 XHCI host
controller on MT7981B SoC. Both controllers share the USB3 PHY
which can be configured for either USB3 or PCIe operation.

The USB3 XHCI controller supports USB 2.0 and USB 3.0 SuperSpeed
operation. The PCIe controller is compatible with PCIe Gen2
specifications.

Also add the topmisc syscon node required for USB/PCIe PHY
multiplexing.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
---
V1 -> V2: Keep xhci reg and phys properties in single lines
---
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi | 80 +++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
index 416096b80770c..d3f37413413e2 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
@@ -2,6 +2,7 @@
 
 #include <dt-bindings/clock/mediatek,mt7981-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/phy/phy.h>
 #include <dt-bindings/reset/mt7986-resets.h>
 
 / {
@@ -223,6 +224,55 @@ auxadc: adc@1100d000 {
 			status = "disabled";
 		};
 
+		xhci: usb@11200000 {
+			compatible = "mediatek,mt7986-xhci", "mediatek,mtk-xhci";
+			reg = <0 0x11200000 0 0x2e00>, <0 0x11203e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			clocks = <&infracfg CLK_INFRA_IUSB_SYS_CK>,
+				 <&infracfg CLK_INFRA_IUSB_CK>,
+				 <&infracfg CLK_INFRA_IUSB_133_CK>,
+				 <&infracfg CLK_INFRA_IUSB_66M_CK>,
+				 <&topckgen CLK_TOP_U2U3_XHCI_SEL>;
+			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck", "xhci_ck";
+			interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&u2port0 PHY_TYPE_USB2>, <&u3port0 PHY_TYPE_USB3>;
+			status = "disabled";
+		};
+
+		pcie: pcie@11280000 {
+			compatible = "mediatek,mt7981-pcie",
+				     "mediatek,mt8192-pcie";
+			reg = <0 0x11280000 0 0x4000>;
+			reg-names = "pcie-mac";
+			ranges = <0x82000000 0 0x20000000
+				  0x0 0x20000000 0 0x10000000>;
+			bus-range = <0x00 0xff>;
+			clocks = <&infracfg CLK_INFRA_IPCIE_CK>,
+				 <&infracfg CLK_INFRA_IPCIE_PIPE_CK>,
+				 <&infracfg CLK_INFRA_IPCIER_CK>,
+				 <&infracfg CLK_INFRA_IPCIEB_CK>;
+			clock-names = "pl_250m", "tl_26m", "peri_26m", "top_133m";
+			device_type = "pci";
+			phys = <&u3port0 PHY_TYPE_PCIE>;
+			phy-names = "pcie-phy";
+			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie_intc 0>,
+					<0 0 0 2 &pcie_intc 1>,
+					<0 0 0 3 &pcie_intc 2>,
+					<0 0 0 4 &pcie_intc 3>;
+			#address-cells = <3>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			status = "disabled";
+
+			pcie_intc: interrupt-controller {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+		};
+
 		pio: pinctrl@11d00000 {
 			compatible = "mediatek,mt7981-pinctrl";
 			reg = <0 0x11d00000 0 0x1000>,
@@ -252,6 +302,36 @@ mux {
 			};
 		};
 
+		topmisc: topmisc@11d10000 {
+			compatible = "mediatek,mt7981-topmisc", "syscon";
+			reg = <0 0x11d10000 0 0x10000>;
+			#clock-cells = <1>;
+		};
+
+		usb_phy: t-phy@11e10000 {
+			compatible = "mediatek,mt7981-tphy",
+				     "mediatek,generic-tphy-v2";
+			ranges = <0 0 0x11e10000 0x1700>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+
+			u2port0: usb-phy@0 {
+				reg = <0x0 0x700>;
+				clocks = <&topckgen CLK_TOP_USB_FRMCNT_SEL>;
+				clock-names = "ref";
+				#phy-cells = <1>;
+			};
+
+			u3port0: usb-phy@700 {
+				reg = <0x700 0x900>;
+				clocks = <&topckgen CLK_TOP_USB3_PHY_SEL>;
+				clock-names = "ref";
+				#phy-cells = <1>;
+				mediatek,syscon-type = <&topmisc 0x218 0>;
+			};
+		};
+
 		efuse@11f20000 {
 			compatible = "mediatek,mt7981-efuse", "mediatek,efuse";
 			reg = <0 0x11f20000 0 0x1000>;

-- 
2.51.0


