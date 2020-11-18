Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0EC2B76C6
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 08:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgKRHRf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 02:17:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:54528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbgKRHRf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Nov 2020 02:17:35 -0500
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 473CF2467A;
        Wed, 18 Nov 2020 07:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605683854;
        bh=AQ/Sx1u+bYD4zoGriANF0/uI3pWLqX2+CyXLECxBBZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kl0OBN5c7oqPQZtM5/3Y8jkB2MPA6nc0A6hfq6bRrXp342xtQ+lYfotLa7gUu3ZXZ
         HHdqly/VpzlbJnRQDshj7AqjXy07krYR4xCD4LS6wIGu5f3329+AtIdpvNOfIwMwcr
         xORywiOSYczE3Yh/f9XTuI1YxDi5GsgYSHvX9ObI=
Received: by wens.tw (Postfix, from userid 1000)
        id 9F9715FF27; Wed, 18 Nov 2020 15:17:31 +0800 (CST)
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
Subject: [PATCH v2 4/4] arm64: dts: rockchip: rk3399: Add NanoPi M4B
Date:   Wed, 18 Nov 2020 15:17:24 +0800
Message-Id: <20201118071724.4866-5-wens@kernel.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201118071724.4866-1-wens@kernel.org>
References: <20201118071724.4866-1-wens@kernel.org>
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
index 5a53979b7057..fd47414e40eb 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -32,6 +32,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-kobol-helios64.dtb
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
2.29.1

