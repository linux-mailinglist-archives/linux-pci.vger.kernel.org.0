Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525AB2EBF27
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jan 2021 14:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbhAFNrI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jan 2021 08:47:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:50854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbhAFNrH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Jan 2021 08:47:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9553223121;
        Wed,  6 Jan 2021 13:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609940786;
        bh=zxCR5IPMVyUtLgw9iNAvhL1NSsx2Ep3Yv/Co5D5pP1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WfIA1I7JwmXFyLWbQfb1NMwLZkm/cTbJZ2IDXvHEDEXQtU5mGhKhO2Djrq/abFzw7
         YNLgMAmHaFEX+YimPat/a9qBoFM5q3U9CYQzWgCTcE31H143GIHu/qnmFexPHkYvl3
         dBTijGo8jBTEe2Hl+RYxZoTHKyr2U+SCxZv1uW8RxKjsjFzIOcSUpnfmCrvOcAu1rv
         vz7HctMfKC5mjNRMUcG384HE+4kVUImguBmFej2tqrkUSRmQQea5Vb1QVRzXrSaY/L
         VSeglprmcdDyMzDubZOWYNcSqN9JlM1ChTSyoQqRNJ6QsNo9Ad4ugb3gT0j5dcmLHc
         58EPdukbI/+3w==
Received: by wens.tw (Postfix, from userid 1000)
        id 757B35FBCC; Wed,  6 Jan 2021 21:46:24 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Chen-Yu Tsai <wens@csie.org>, Robin Murphy <robin.murphy@arm.com>,
        Johan Jonker <jbx6244@gmail.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 4/4] arm64: dts: rockchip: rk3399: Add NanoPi M4B
Date:   Wed,  6 Jan 2021 21:46:17 +0800
Message-Id: <20210106134617.391-5-wens@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210106134617.391-1-wens@kernel.org>
References: <20210106134617.391-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The NanoPi M4B is a minor revision of the original M4.

The differences against the original Nanopi M4 that are common with the
other M4V2 revision include:

  - microphone header removed
  - power button added
  - recovery button added

Additional changes specific to the M4B:

  - USB 3.0 hub removed; board now has 2x USB 3.0 type-A ports and 2x
    USB 2.0 ports
  - ADB toggle switch added; this changes the top USB 3.0 host port to
    a peripheral port
  - Type-C port no longer supports data or PD
  - WiFi/Bluetooth combo chip switched to AP6256, which supports BT 5.0
    but only 1T1R (down from 2T2R) for WiFi

Add a new dts file for the new board revision that shows the difference
against the original.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/rockchip/Makefile         |  1 +
 .../boot/dts/rockchip/rk3399-nanopi-m4b.dts   | 52 +++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4b.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 1ab55a124a87..622d320ddd13 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -33,6 +33,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-kobol-helios64.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-leez-p710.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopc-t4.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-m4.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-m4b.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-neo4.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-orangepi.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-pinebook-pro.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4b.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4b.dts
new file mode 100644
index 000000000000..72182c58cc46
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4b.dts
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * FriendlyElec NanoPi M4B board device tree source
+ *
+ * Copyright (c) 2020 Chen-Yu Tsai <wens@csie.org>
+ */
+
+/dts-v1/;
+#include "rk3399-nanopi-m4.dts"
+
+/ {
+	model = "FriendlyElec NanoPi M4B";
+	compatible = "friendlyarm,nanopi-m4b", "rockchip,rk3399";
+
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 1>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1500000>;
+		poll-interval = <100>;
+
+		recovery {
+			label = "Recovery";
+			linux,code = <KEY_VENDOR>;
+			press-threshold-microvolt = <18000>;
+		};
+	};
+};
+
+/* No USB type-C PD power manager */
+/delete-node/ &fusb0;
+
+&i2c4 {
+	status = "disabled";
+};
+
+&u2phy0_host {
+	phy-supply = <&vcc5v0_usb2>;
+};
+
+&u2phy0_otg {
+	phy-supply = <&vbus_typec>;
+};
+
+&u2phy1_otg {
+	phy-supply = <&vcc5v0_usb1>;
+};
+
+&vbus_typec {
+	enable-active-high;
+	gpios = <&gpio4 RK_PD2 GPIO_ACTIVE_HIGH>;
+};
-- 
2.29.2

