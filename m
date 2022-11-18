Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACD762FD90
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 20:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242724AbiKRTCU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 14:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242959AbiKRTBx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 14:01:53 -0500
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091EA2FFFC;
        Fri, 18 Nov 2022 11:01:39 -0800 (PST)
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
        by mxout3.routing.net (Postfix) with ESMTP id 41062604DC;
        Fri, 18 Nov 2022 19:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1668798098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rLXaSi0nuYISQNA4/ZZOAgFRiUbo5QoSWGShK+kyzL8=;
        b=RzpUfc38A2J1HvklQknH14z6OqQdbFlIs+cswd/DJsnTKTaQDBe65Dp0iNk7+Oo57WLr1e
        KdTjCZ4R5VTq4apKt9ccuiMWk4maCRq8LvhhdmWjGWVx9XMLtOFtXV1yLorZEiFMrOmZnB
        7KYY0XdG1K0Cfz6bgu1sZ+qrN+7PG4M=
Received: from frank-G5.. (fttx-pool-80.245.77.125.bambit.de [80.245.77.125])
        by mxbulk.masterlogin.de (Postfix) with ESMTPSA id E1F5C1226BC;
        Fri, 18 Nov 2022 19:01:37 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-usb@vger.kernel.org,
        Sam Shih <sam.shih@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v6 06/11] arm64: dts: mt7986: add spi related device nodes
Date:   Fri, 18 Nov 2022 20:01:21 +0100
Message-Id: <20221118190126.100895-7-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221118190126.100895-1-linux@fw-web.de>
References: <20221118190126.100895-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sam Shih <sam.shih@mediatek.com>

This patch adds spi support for MT7986.

Signed-off-by: Sam Shih <sam.shih@mediatek.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts | 35 ++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi    | 28 ++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts | 35 ++++++++++++++++++++
 3 files changed, 98 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
index 2f48cc3d3ddb..006878e3f2b2 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
@@ -59,6 +59,20 @@ switch: switch@0 {
 };
 
 &pio {
+	spi_flash_pins: spi-flash-pins {
+		mux {
+			function = "spi";
+			groups = "spi0", "spi0_wp_hold";
+		};
+	};
+
+	spic_pins: spic-pins {
+		mux {
+			function = "spi";
+			groups = "spi1_2";
+		};
+	};
+
 	uart1_pins: uart1-pins {
 		mux {
 			function = "uart";
@@ -105,6 +119,27 @@ conf {
 	};
 };
 
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi_flash_pins>;
+	cs-gpios = <0>, <0>;
+	status = "okay";
+	spi_nand: spi_nand@0 {
+		compatible = "spi-nand";
+		reg = <0>;
+		spi-max-frequency = <10000000>;
+		spi-tx-buswidth = <4>;
+		spi-rx-buswidth = <4>;
+	};
+};
+
+&spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spic_pins>;
+	cs-gpios = <0>, <0>;
+	status = "okay";
+};
+
 &switch {
 	ports {
 		#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
index afc01abfa99c..29da9b8ed753 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -253,6 +253,34 @@ i2c0: i2c@11008000 {
 			status = "disabled";
 		};
 
+		spi0: spi@1100a000 {
+			compatible = "mediatek,mt7986-spi-ipm", "mediatek,spi-ipm";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0x1100a000 0 0x100>;
+			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&topckgen CLK_TOP_MPLL_D2>,
+				 <&topckgen CLK_TOP_SPI_SEL>,
+				 <&infracfg CLK_INFRA_SPI0_CK>,
+				 <&infracfg CLK_INFRA_SPI0_HCK_CK>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk", "hclk";
+			status = "disabled";
+		};
+
+		spi1: spi@1100b000 {
+			compatible = "mediatek,mt7986-spi-ipm", "mediatek,spi-ipm";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0x1100b000 0 0x100>;
+			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&topckgen CLK_TOP_MPLL_D2>,
+				 <&topckgen CLK_TOP_SPIM_MST_SEL>,
+				 <&infracfg CLK_INFRA_SPI1_CK>,
+				 <&infracfg CLK_INFRA_SPI1_HCK_CK>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk", "hclk";
+			status = "disabled";
+		};
+
 		ethsys: syscon@15000000 {
 			 #address-cells = <1>;
 			 #size-cells = <1>;
diff --git a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
index 79c5c78f7a14..2c7f1d4fb352 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
@@ -100,6 +100,20 @@ fixed-link {
 };
 
 &pio {
+	spi_flash_pins: spi-flash-pins {
+		mux {
+			function = "spi";
+			groups = "spi0", "spi0_wp_hold";
+		};
+	};
+
+	spic_pins: spic-pins {
+		mux {
+			function = "spi";
+			groups = "spi1_2";
+		};
+	};
+
 	wf_2g_5g_pins: wf-2g-5g-pins {
 		mux {
 			function = "wifi";
@@ -132,6 +146,27 @@ conf {
 	};
 };
 
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi_flash_pins>;
+	cs-gpios = <0>, <0>;
+	status = "okay";
+	spi_nand: spi_nand@0 {
+		compatible = "spi-nand";
+		reg = <0>;
+		spi-max-frequency = <10000000>;
+		spi-tx-buswidth = <4>;
+		spi-rx-buswidth = <4>;
+	};
+};
+
+&spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spic_pins>;
+	cs-gpios = <0>, <0>;
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
2.34.1

