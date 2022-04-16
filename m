Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5D25036FF
	for <lists+linux-pci@lfdr.de>; Sat, 16 Apr 2022 16:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbiDPOHs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Apr 2022 10:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbiDPOHs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Apr 2022 10:07:48 -0400
Received: from mxout4.routing.net (mxout4.routing.net [IPv6:2a03:2900:1:a::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6AA18363
        for <linux-pci@vger.kernel.org>; Sat, 16 Apr 2022 07:05:13 -0700 (PDT)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout4.routing.net (Postfix) with ESMTP id 755D91008DF;
        Sat, 16 Apr 2022 13:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1650117339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JyHwYPoep9BFDLoB0ZMsq8j0Yw86x9S39Cqz1XCAImc=;
        b=CgGX7EPzowNcfoFBExgbpTHJElkMO5owp4RgN5tZOFLWgF6weR58wvqVNTPBwCuyUBNSFT
        6IglZyfCJOeC3mCqGvnVapmYeW2o+QCIbaXMVJULpRzscQk59TRNe8se4aIKFsNx+1lmHK
        C51JplIIR2eRn54hk3iXGYC9meo1mD4=
Received: from localhost.localdomain (fttx-pool-217.61.150.108.bambit.de [217.61.150.108])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 1945C1005BA;
        Sat, 16 Apr 2022 13:55:38 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [RFC/RFT 6/6] arm64: dts: rockchip: Add PCIe v3 nodes to BPI-R2-Pro
Date:   Sat, 16 Apr 2022 15:54:58 +0200
Message-Id: <20220416135458.104048-7-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220416135458.104048-1-linux@fw-web.de>
References: <20220416135458.104048-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 62954ed6-c7f0-49ee-8548-52a70c509b55
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Add Nodes to Bananapi-R2-Pro board to support PCIe v3 and
set pcie regulators to always on.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 .../boot/dts/rockchip/rk3568-bpi-r2-pro.dts   | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
index 2700fb18a3bc..e3a0f7d219a2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
@@ -74,6 +74,67 @@ vcc5v0_sys: vcc5v0-sys {
 		vin-supply = <&dc_12v>;
 	};
 
+	pcie30_avdd0v9: pcie30-avdd0v9 {
+		compatible = "regulator-fixed";
+		regulator-name = "pcie30_avdd0v9";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <900000>;
+		vin-supply = <&vcc3v3_sys>;
+	};
+
+	pcie30_avdd1v8: pcie30-avdd1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "pcie30_avdd1v8";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc3v3_sys>;
+	};
+
+	/* pi6c pcie clock generator feeds both ports */
+	vcc3v3_pi6c_05: vcc3v3_pi6c_05-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_pcie";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+		enable-active-high;
+		gpios = <&gpio0 RK_PD4 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <20000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	/* actually fed by vcc3v3_sys, dependent on pi6c clock generator */
+	vcc3v3_minipcie: vcc3v3_minipcie-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_minipcie";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&gpio0 RK_PC6 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <5000>;
+		vin-supply = <&vcc3v3_pi6c_05>;
+	};
+
+	/* actually fed by vcc3v3_sys, dependent on pi6c clock generator */
+	vcc3v3_ngff: vcc3v3_ngff-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_ngff";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&gpio4 RK_PC1 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <5000>;
+		vin-supply = <&vcc3v3_pi6c_05>;
+	};
+
 	vbus: vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "vbus";
@@ -411,6 +472,24 @@ rgmii_phy1: ethernet-phy@0 {
 	};
 };
 
+&pcie30phy {
+       status = "okay";
+};
+
+&pcie3x1 {
+	rockchip,bifurcation;
+	reset-gpios = <&gpio3 RK_PA1 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_ngff>;
+	status = "okay";
+};
+
+&pcie3x2 {
+	rockchip,bifurcation;
+	reset-gpios = <&gpio2 RK_PD6 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_minipcie>;
+	status = "okay";
+};
+
 &pinctrl {
 	leds {
 		blue_led_pin: blue-led-pin {
-- 
2.25.1

