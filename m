Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF83D62685B
	for <lists+linux-pci@lfdr.de>; Sat, 12 Nov 2022 10:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbiKLJPy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Nov 2022 04:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234731AbiKLJPq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Nov 2022 04:15:46 -0500
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEA415FF0;
        Sat, 12 Nov 2022 01:15:44 -0800 (PST)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout1.routing.net (Postfix) with ESMTP id 17A4740784;
        Sat, 12 Nov 2022 09:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1668244542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F7qc67EOmhxuOSlex6iiFD1G2DVBWXMCgBKUNU2VR8c=;
        b=LpWuodLXqW2SE7b3LzX5fcuzNU0S84z7OVZ2nOo1RhVSEj5fEoCYJ0Wa6eboNxgtqRJJIe
        1VQv6aTAJHSV/GTPArG8O88R0SF2OSy1bn/IXteuBwIaLxodBgHduEwV+rhuGhXk8hXs4O
        lkN6ZLc4HoY6hCmxGJE0u9wzu5Eysp4=
Received: from frank-G5.. (fttx-pool-157.180.227.41.bambit.de [157.180.227.41])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 050A9360217;
        Sat, 12 Nov 2022 09:15:40 +0000 (UTC)
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
        Sam Shih <sam.shih@mediatek.com>
Subject: [PATCH v4 08/11] arm64: dts: mt7986: add mmc related device nodes
Date:   Sat, 12 Nov 2022 10:15:15 +0100
Message-Id: <20221112091518.7846-9-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221112091518.7846-1-linux@fw-web.de>
References: <20221112091518.7846-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 74e84647-1ff4-4e5d-ad6d-a5c45e8a483b
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sam Shih <sam.shih@mediatek.com>

This patch adds mmc support for MT7986.

Signed-off-by: Sam Shih <sam.shih@mediatek.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v3:
- fix pullups/pulldowns for mt7986a-rfb to have generic bias-pull-*

v2:
- update mmc-node because clocks changed
---
 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts | 87 ++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi    | 15 ++++
 2 files changed, 102 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
index 2b5d7ea31b4d..e1a0331aaa5f 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
@@ -5,6 +5,8 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/pinctrl/mt65xx.h>
+
 #include "mt7986a.dtsi"
 
 / {
@@ -24,6 +26,15 @@ memory@40000000 {
 		reg = <0 0x40000000 0 0x40000000>;
 	};
 
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-1.8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
 	reg_3p3v: regulator-3p3v {
 		compatible = "regulator-fixed";
 		regulator-name = "fixed-3.3V";
@@ -76,7 +87,83 @@ switch: switch@0 {
 	};
 };
 
+&mmc0 {
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc0_pins_default>;
+	pinctrl-1 = <&mmc0_pins_uhs>;
+	bus-width = <8>;
+	max-frequency = <200000000>;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	hs400-ds-delay = <0x14014>;
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_1p8v>;
+	non-removable;
+	no-sd;
+	no-sdio;
+	status = "okay";
+};
+
 &pio {
+	mmc0_pins_default: mmc0-pins {
+		mux {
+			function = "emmc";
+			groups = "emmc_51";
+		};
+		conf-cmd-dat {
+			pins = "EMMC_DATA_0", "EMMC_DATA_1", "EMMC_DATA_2",
+			       "EMMC_DATA_3", "EMMC_DATA_4", "EMMC_DATA_5",
+			       "EMMC_DATA_6", "EMMC_DATA_7", "EMMC_CMD";
+			input-enable;
+			drive-strength = <4>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>; /* pull-up 10K */
+		};
+		conf-clk {
+			pins = "EMMC_CK";
+			drive-strength = <6>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>; /* pull-down 50K */
+		};
+		conf-ds {
+			pins = "EMMC_DSL";
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>; /* pull-down 50K */
+		};
+		conf-rst {
+			pins = "EMMC_RSTB";
+			drive-strength = <4>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>; /* pull-up 10K */
+		};
+	};
+
+	mmc0_pins_uhs: mmc0-uhs-pins {
+		mux {
+			function = "emmc";
+			groups = "emmc_51";
+		};
+		conf-cmd-dat {
+			pins = "EMMC_DATA_0", "EMMC_DATA_1", "EMMC_DATA_2",
+			       "EMMC_DATA_3", "EMMC_DATA_4", "EMMC_DATA_5",
+			       "EMMC_DATA_6", "EMMC_DATA_7", "EMMC_CMD";
+			input-enable;
+			drive-strength = <4>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>; /* pull-up 10K */
+		};
+		conf-clk {
+			pins = "EMMC_CK";
+			drive-strength = <6>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>; /* pull-down 50K */
+		};
+		conf-ds {
+			pins = "EMMC_DSL";
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>; /* pull-down 50K */
+		};
+		conf-rst {
+			pins = "EMMC_RSTB";
+			drive-strength = <4>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>; /* pull-up 10K */
+		};
+	};
+
 	spi_flash_pins: spi-flash-pins {
 		mux {
 			function = "spi";
diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
index 2bcf48890ba8..4b85a645fd55 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -304,6 +304,21 @@ ssusb: usb@11200000 {
 			status = "disabled";
 		};
 
+		mmc0: mmc@11230000 {
+			compatible = "mediatek,mt7986-mmc";
+			reg = <0 0x11230000 0 0x1000>,
+			      <0 0x11c20000 0 0x1000>;
+			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&topckgen CLK_TOP_EMMC_416M_SEL>,
+				 <&infracfg CLK_INFRA_MSDC_HCK_CK>,
+				 <&infracfg CLK_INFRA_MSDC_CK>,
+				 <&infracfg CLK_INFRA_MSDC_133M_CK>,
+				 <&infracfg CLK_INFRA_MSDC_66M_CK>;
+			clock-names = "source", "hclk", "source_cg", "bus_clk",
+				      "sys_cg";
+			status = "disabled";
+		};
+
 		usb_phy: t-phy@11e10000 {
 			compatible = "mediatek,mt7986-tphy",
 				     "mediatek,generic-tphy-v2";
-- 
2.34.1

