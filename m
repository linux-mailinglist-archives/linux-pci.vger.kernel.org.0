Return-Path: <linux-pci+bounces-38327-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BBFBE2C0F
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 12:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2A8C486539
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 10:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62504330D5A;
	Thu, 16 Oct 2025 10:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="g3jThabV"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E0C22B8B0;
	Thu, 16 Oct 2025 10:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760609345; cv=none; b=ESzT0mjm5FKM3ptvWN/oix8xSw2XhXsPm2iiD6BajraoxAvtMdMS6+645//Y0iOFJzI7lzAEl3wmJ6FHFOnOwxVfEOhneC6aWWxlLzf6N5WJyZd6uSSKx/8cF1fBNNLps4ZlAgG95GnaqpzwFWJcofWYN+4bI/qZLBLGqqZGUFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760609345; c=relaxed/simple;
	bh=UGU216bzWdi/xPxp07gdtNKrrz/AaYQxRBv23FP8Dhc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gZwtuxcu5UHDoRQ2u5j6FaOQkuutpBB6HQJkdRMIfHkhjJ7EMCFs5XOKldpbyThxcjSpQGZ+x8maP+x7MnY4zF1tweh+aH+rlBVppuvkRmAcCqlGI3j85dJ1qKzcMBNCqF1FY4kOm1iBtRP02x/x6HVYnF9WBSL2MTlxp6ZRgm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=g3jThabV; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760609335;
	bh=UGU216bzWdi/xPxp07gdtNKrrz/AaYQxRBv23FP8Dhc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g3jThabVnbKEswmG8jUG6jHBK5NrGZmgTT1Ptq31SygSJjC6iq+YVqKGP5FiqgTD0
	 52Fm3l4c9TOJmMpwdmQvwUZGHwTlI3MAfFmcJScDC80nseHasED02f62nlIEDSNBPJ
	 Ld/l+nzFrC+sV07Ox8pHbYEOl/5Pd029C19BTVClH2phRMzAug/NapUTkcYTuKNEN9
	 P6XmgqcIqODT9RhUPK/f5ZG25JsLWAUU/MwCbqrBnwu4j4oT+ACj7KS3lFLYtryF5r
	 TzYuI0KreYB3htZ70xwIrPNd4QwuxWXVFEQo96FzNVgNMuLxYPJIhjhmGU9S60H84n
	 EMCU7yZ8cEakg==
Received: from beast.luon.net (unknown [IPv6:2a10:3781:2531::8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5C4A817E1562;
	Thu, 16 Oct 2025 12:08:55 +0200 (CEST)
Received: by beast.luon.net (Postfix, from userid 1000)
	id D28A310C9C79C; Thu, 16 Oct 2025 12:08:53 +0200 (CEST)
From: Sjoerd Simons <sjoerd@collabora.com>
Date: Thu, 16 Oct 2025 12:08:50 +0200
Subject: [PATCH 14/15] arm64: dts: mediatek: mt7981b-openwrt-one: Enable
 wifi
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-openwrt-one-network-v1-14-de259719b6f2@collabora.com>
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

Enable Dual-band WiFI 6 functionality on the Openwrt One

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
---
 .../boot/dts/mediatek/mt7981b-openwrt-one.dts      | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
index 6e6e4f1515f67..4d1653c336e71 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
@@ -134,6 +134,22 @@ mux {
 			groups = "uart0";
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
@@ -213,6 +229,14 @@ &usb_phy {
 	status = "okay";
 };
 
+&wifi {
+	nvmem-cells = <&eeprom_factory_0>;
+	nvmem-cell-names = "eeprom";
+	pinctrl-names = "dbdc";
+	pinctrl-0 = <&wifi_dbdc_pins>;
+	status = "okay";
+};
+
 &xhci {
 	phys = <&u2port0 PHY_TYPE_USB2>;
 	vusb33-supply = <&reg_3p3v>;

-- 
2.51.0


