Return-Path: <linux-pci+bounces-40419-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E603FC38045
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 22:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7558D3BC98D
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 21:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18102DF150;
	Wed,  5 Nov 2025 21:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pSe49kn1"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5976126C02;
	Wed,  5 Nov 2025 21:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762377519; cv=none; b=m6ASPQlsF3TEhwMdXCFP0tRwKjDesZ1/ugM2ilThDwicJ/1Jbj+bpT0gaiEc1T8XwRUy/8i/FKZ0pgffS6c720knddbTrIbHNEetfNYmaF2RUzZa/4cSVP77m6BVMn+hOyUunNLfOpyuQF5CEIkm6cRE1U27FabueZzt2d1zVpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762377519; c=relaxed/simple;
	bh=vTtFVwZhj2dtk28F9mb0pMLT2K98WweVea9+cuC24ag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C+ED7EDiKfbt3fInhR6slhqsz2NB1XXeJIuDxUw20s2DRG11sozyu/x8tDCQZzEnCVMMRtClOyXy/EL3pM/N0QweYdwRH+hsGsHSs9EG/M1VkjiJuhnJ4O/tPigdJ/yAGr7Nmm5oowhFPujbnW2SfPFZnTqi+BIIoySdq4Cn+Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pSe49kn1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762377515;
	bh=vTtFVwZhj2dtk28F9mb0pMLT2K98WweVea9+cuC24ag=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pSe49kn1CNJa/3TIsAfyiPmVF6y8Y8PaNI39JUJJAAPA5wWIFh6XiC4HVZx6wEFNL
	 L5Kdzgoirrmikw+CUAcBOG09J/CVlUGuVArOzbmO7Wslf7ZxtcAwnpndJ43sBsrCq1
	 v/WOwnTgqG36ax9SAtLwXvRr9iFPFbDxYpPnBjW0uNx0LGTceQTwIerakX6nh/fve2
	 gDgnn7FFMsjEfMxOyPv6ZSm9V2QYVpS7DfzQzkZ+RBkSvVkeyS66FamW1RxSMduaYI
	 esxgWGjHuf5H2/qYR975Jxrx8kLKRiAIjaJPBj3Zh03WC2gVt5fDKiYp1fSDHIIPAT
	 u+lL/PGRDqsvQ==
Received: from beast.luon.net (unknown [IPv6:2a10:3781:2531::8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0483317E12AA;
	Wed,  5 Nov 2025 22:18:35 +0100 (CET)
Received: by beast.luon.net (Postfix, from userid 1000)
	id 916BF10F352DB; Wed, 05 Nov 2025 22:18:34 +0100 (CET)
From: Sjoerd Simons <sjoerd@collabora.com>
Date: Wed, 05 Nov 2025 22:17:56 +0100
Subject: [PATCH v3 01/13] arm64: dts: mediatek: mt7981b-openwrt-one: Enable
 SPI NOR
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-openwrt-one-network-v3-1-008e2cab38d1@collabora.com>
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

The openwrt one has a SPI NOR flash which from factory is used for:
* Recovery system
* WiFi eeprom data
* ethernet Mac addresses

Describe this following the same partitions as the openwrt configuration
uses.

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
---
V2 -> V3: Move earlier in the patch sequence
V1 -> V2:
  - Use numeric drive-strength values rather then defines
  - Make nvmem cell labers more meaningfull
  - Only define nvmem cells used in later patches by devicetree
---
 .../boot/dts/mediatek/mt7981b-openwrt-one.dts      | 79 ++++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi          |  2 +-
 2 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
index 968b91f55bb27..6bb98629f4536 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
@@ -3,6 +3,7 @@
 /dts-v1/;
 
 #include "mt7981b.dtsi"
+#include "dt-bindings/pinctrl/mt65xx.h"
 
 / {
 	compatible = "openwrt,one", "mediatek,mt7981b";
@@ -22,6 +23,84 @@ memory@40000000 {
 	};
 };
 
+&pio {
+	spi2_flash_pins: spi2-pins {
+		mux {
+			function = "spi";
+			groups = "spi2";
+		};
+
+		conf-pu {
+			bias-pull-up = <MTK_PUPD_SET_R1R0_11>;
+			drive-strength = <8>;
+			pins = "SPI2_CS", "SPI2_WP";
+		};
+
+		conf-pd {
+			bias-pull-down = <MTK_PUPD_SET_R1R0_11>;
+			drive-strength = <8>;
+			pins = "SPI2_CLK", "SPI2_MOSI", "SPI2_MISO";
+		};
+	};
+};
+
+&spi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi2_flash_pins>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <40000000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				reg = <0x00000 0x40000>;
+				label = "bl2-nor";
+			};
+
+			partition@40000 {
+				reg = <0x40000 0xc0000>;
+				label = "factory";
+				read-only;
+
+				nvmem-layout {
+					compatible = "fixed-layout";
+					#address-cells = <1>;
+					#size-cells = <1>;
+
+					wifi_factory_calibration: eeprom@0 {
+						reg = <0x0 0x1000>;
+					};
+
+					wan_factory_mac: macaddr@24 {
+						reg = <0x24 0x6>;
+						compatible = "mac-base";
+						#nvmem-cell-cells = <1>;
+					};
+				};
+			};
+
+			partition@100000 {
+				reg = <0x100000 0x80000>;
+				label = "fip-nor";
+			};
+
+			partition@180000 {
+				reg = <0x180000 0xc80000>;
+				label = "recovery";
+			};
+		};
+	};
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
index 130ce2fda3995..f00e5bf63de35 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
@@ -156,7 +156,7 @@ i2c@11007000 {
 			status = "disabled";
 		};
 
-		spi@11009000 {
+		spi2: spi@11009000 {
 			compatible = "mediatek,mt7981-spi-ipm", "mediatek,spi-ipm";
 			reg = <0 0x11009000 0 0x1000>;
 			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;

-- 
2.51.0


