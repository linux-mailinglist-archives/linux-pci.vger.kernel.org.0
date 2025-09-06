Return-Path: <linux-pci+bounces-35598-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29408B46F47
	for <lists+linux-pci@lfdr.de>; Sat,  6 Sep 2025 15:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBF5E5A1DE9
	for <lists+linux-pci@lfdr.de>; Sat,  6 Sep 2025 13:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289AD2F39CC;
	Sat,  6 Sep 2025 13:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="QnenhXeT"
X-Original-To: linux-pci@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931172EE29F;
	Sat,  6 Sep 2025 13:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757166848; cv=none; b=Lhjr6Egn13X6eeNJiyqVOv0J6Kt0biupdBck8ub6kkqziQl/bfzcQFwNIARmbQjkGB2niYMtXb3mMOhEw7WzV0rK94JJhasWggtNBMnYVnx1HX4gOsyQo0fUwTvdm8aeDGcGCbI0vOqLA4x5n6gH5tvXa47y2z8kfUvvspdzMS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757166848; c=relaxed/simple;
	bh=Dw5uo181Dm3Fr9E03p865uWj8jVKOwAN1D+SIhGoS3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7X8fenDtiIqzGr+uABABj0V5rj1kn+PhJ5sNY5CeUlsymwwcA5X/FvJy+is/a5Mm3M3myLOS5gd2pcwOsseO1k0Zcih3TIxUdqns0wFT1jvyAgZ0rBT1MAFvhC/2cfxWbyZlb2GQMZhx6mOmbGnuij6GZA+1LyBMaLvJL7URJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=QnenhXeT; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 1D6D920285;
	Sat,  6 Sep 2025 15:54:05 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 15xGSrIbygqB; Sat,  6 Sep 2025 15:54:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1757166844; bh=Dw5uo181Dm3Fr9E03p865uWj8jVKOwAN1D+SIhGoS3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QnenhXeTVnAZ4hc1cPKPDtuClk2YEMAQ1CvdjE8PRoj4rTwwfuAekElrTBr7hQSgB
	 N7IvFyxXZ34NEK28AsfeUGPCS0Oqsudvn3qk7kPn8TGAgNI+IJgPITbWXXnKXe3qso
	 Zc35meOMW+qDjq4diZXyxFRBSk9bgCZyZ9It6mwk5G6qgvILI2F+58bJ70+sKAuUon
	 dnIfrXCdRUVWoa3Kc7raD2OP716eQrQLe8uSes1OZIP9KDhq9b1QszVP4VmnEY9/nL
	 yGstc9ZF08io+5dtjwoQr/FUt2mRNqNjW6CLLXu71fEkiltKNK7Umc7qK19o6bEvce
	 PuVkMK5WfjdwQ==
From: Yao Zi <ziyao@disroot.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH 3/3] arm64: dts: rockchip: Enable PCIe controller on Radxa E20C
Date: Sat,  6 Sep 2025 13:52:46 +0000
Message-ID: <20250906135246.19398-4-ziyao@disroot.org>
In-Reply-To: <20250906135246.19398-1-ziyao@disroot.org>
References: <20250906135246.19398-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Radxa E20C provides one of its GbE ports through RTL8111H connected to
SoC's PCIe controller. Let's enable the controller and the PHY used by
it to allow usage of the port.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 .../boot/dts/rockchip/rk3528-radxa-e20c.dts     | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
index 12eec2c1db22..e880c7a7e674 100644
--- a/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
@@ -171,6 +171,10 @@ vdd_logic: regulator-vdd-logic {
 	};
 };
 
+&combphy {
+	status = "okay";
+};
+
 &cpu0 {
 	cpu-supply = <&vdd_arm>;
 };
@@ -229,6 +233,13 @@ rgmii_phy: ethernet-phy@1 {
 	};
 };
 
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pciem1_pins>, <&pcie_reset_g>;
+	reset-gpios = <&gpio1 RK_PA2 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
 &pinctrl {
 	ethernet {
 		gmac1_rstn_l: gmac1-rstn-l {
@@ -256,6 +267,12 @@ wan_led_g: wan-led-g {
 		};
 	};
 
+	pcie {
+		pcie_reset_g: pcie-reset-g {
+			rockchip,pins = <1 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	sdmmc {
 		sdmmc_vol_ctrl_h: sdmmc-vol-ctrl-h {
 			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
-- 
2.50.1


