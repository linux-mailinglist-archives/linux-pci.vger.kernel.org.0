Return-Path: <linux-pci+bounces-40427-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC35C38030
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 22:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5206A3BDFCA
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 21:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF582C0276;
	Wed,  5 Nov 2025 21:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RZt8bfUA"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CE12E22BF;
	Wed,  5 Nov 2025 21:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762377524; cv=none; b=RwozxYH488EhiJ6TVpCvPAvwGGTREFztSrKtS8ddUswc+t0hhvyNWa+eXqZkxJ76NnBi4XO3hztajkwit650zbeXzeZV3p+HCGJV8Gj/HMitKjMQIN7YhXYImvJY0VObKevpeBI3irwltITUvQu676s9W3DFjqfulzv8BXJLj6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762377524; c=relaxed/simple;
	bh=l3tEWhRqP4lk80hQap0vJX2rjpGnZh5LT9KfShignVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BlU1vmEtyVRBmUk5LytlsvEfNeQgFSa3RRHVAwhRB/TBmljA0vjh2FTKtyomhQ2xyx1CIU8UI/WXXZO1TI0KnbqaCR7WbSUD9smMmus2enZdCnk9q+jFPU0djegfzLH/m9mVRaowB5KaecESz7aYD+2BoeXD2bQR8mJz+mvp3Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RZt8bfUA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762377516;
	bh=l3tEWhRqP4lk80hQap0vJX2rjpGnZh5LT9KfShignVs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RZt8bfUA3x1BMPbp6nkMXKDVBZsmSqC8Cr6yQf9Bmt2Dn+/fwoSYvUgfRuREfi7tC
	 Q/Q8f7iMK8cG1uT2ybpCwmTx6q0+56XFN+FUXpTwPkiJMlqFbUFh6CDhq3d/Sb3pYd
	 0khH4Qat4TIVxrmiUAmDbJPZJT6v44l65FEstFParsZO2eah/zNv3Ok8LrSTZFrPLT
	 QOlF3l0Ffm4b5G93+j/mYrVhX1W2ZC5PZDl3BBzk01fwCQCSA3FY8u3Pgkmvk7bXAF
	 cQY9ji73EbfDjeSbnSNsBMHmBoCAp688kMuyKVrKb17vGX9Deq5zuP796vQziSjtIf
	 lHPsXdw8w/mGw==
Received: from beast.luon.net (unknown [IPv6:2a10:3781:2531::8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3395417E14FF;
	Wed,  5 Nov 2025 22:18:36 +0100 (CET)
Received: by beast.luon.net (Postfix, from userid 1000)
	id D51B210F352F3; Wed, 05 Nov 2025 22:18:34 +0100 (CET)
From: Sjoerd Simons <sjoerd@collabora.com>
Date: Wed, 05 Nov 2025 22:18:08 +0100
Subject: [PATCH v3 13/13] arm64: dts: mediatek: mt7981b-openwrt-one: Enable
 wifi
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-openwrt-one-network-v3-13-008e2cab38d1@collabora.com>
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

Enable Dual-band WiFI 6 functionality on the Openwrt One

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
---
V2 -> V3: replace MTK_DRIVE_4mA with direct value
V1 -> V2: Update eeprom node label
---
 .../boot/dts/mediatek/mt7981b-openwrt-one.dts      | 24 ++++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi          |  2 +-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
index 2aea899006453..3de368c73bc81 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
@@ -180,6 +180,22 @@ conf-pd {
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
+			drive-strength = <4>;
+		};
+	};
 };
 
 &pwm {
@@ -257,6 +273,14 @@ &usb_phy {
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
index a7be3670e0059..66d89495bac52 100644
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


