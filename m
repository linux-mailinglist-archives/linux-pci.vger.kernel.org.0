Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E445B62E1EB
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 17:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240291AbiKQQad (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 11:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbiKQQ34 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 11:29:56 -0500
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B757FC2F;
        Thu, 17 Nov 2022 08:27:46 -0800 (PST)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout2.routing.net (Postfix) with ESMTP id 7306F61657;
        Thu, 17 Nov 2022 16:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1668702464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U3hZQONS0EP5Jp9Xg2+d5FMW8Hr9Q1NGCXKpI1aNQ24=;
        b=dAiM2gsEvTuKJIukR9FIBH0+Vy2ajPwQ/+EfDuZ2oIeJrf4Mf4RXOLHDjrjx+i2mERHh8f
        9ng+pnCrc75XXL6tPv0Z8gZCqMUIxhJ2RAMlCQKw2IGqtkpySOV1nxkcKDBw05MV4emPBx
        HC6uUnXdFu1/5u1s1ZIj7KSSzBR+4qw=
Received: from frank-G5.. (fttx-pool-80.245.75.65.bambit.de [80.245.75.65])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 18EA0100501;
        Thu, 17 Nov 2022 16:27:43 +0000 (UTC)
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
        Jieyy Yang <jieyy.yang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v5 09/11] arm64: dts: mt7986: add pcie related device nodes
Date:   Thu, 17 Nov 2022 17:27:26 +0100
Message-Id: <20221117162728.20608-10-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221117162728.20608-1-linux@fw-web.de>
References: <20221117162728.20608-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: dfb25ea5-1a6e-4895-b22a-3994239809a8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sam Shih <sam.shih@mediatek.com>

This patch adds PCIe support for MT7986.

Signed-off-by: Jieyy Yang <jieyy.yang@mediatek.com>
Signed-off-by: Sam Shih <sam.shih@mediatek.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
changes compared to sams original version:

- add clock-names to pcie node
- update clocks to new binding
---
bindings-patches:
https://patchwork.kernel.org/project/linux-mediatek/list/?series=690172
---
 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts | 16 ++++++
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi    | 52 ++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
index e1a0331aaa5f..01fa08c57c39 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
@@ -102,6 +102,15 @@ &mmc0 {
 	non-removable;
 	no-sd;
 	no-sdio;
+};
+
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_pins>;
+	status = "okay";
+};
+
+&pcie_phy {
 	status = "okay";
 };
 
@@ -164,6 +173,13 @@ conf-rst {
 		};
 	};
 
+	pcie_pins: pcie-pins {
+		mux {
+			function = "pcie";
+			groups = "pcie_clk", "pcie_wake", "pcie_pereset";
+		};
+	};
+
 	spi_flash_pins: spi-flash-pins {
 		mux {
 			function = "spi";
diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
index b3ad8978b563..b310abc02dcc 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/mt7986-clk.h>
 #include <dt-bindings/reset/mt7986-resets.h>
+#include <dt-bindings/phy/phy.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -319,6 +320,57 @@ mmc0: mmc@11230000 {
 			status = "disabled";
 		};
 
+		pcie: pcie@11280000 {
+			compatible = "mediatek,mt7986-pcie",
+				     "mediatek,mt8192-pcie";
+			device_type = "pci";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			reg = <0x00 0x11280000 0x00 0x4000>;
+			reg-names = "pcie-mac";
+			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+			bus-range = <0x00 0xff>;
+			ranges = <0x82000000 0x00 0x20000000 0x00
+				  0x20000000 0x00 0x10000000>;
+			clocks = <&infracfg CLK_INFRA_IPCIE_PIPE_CK>,
+				 <&infracfg CLK_INFRA_IPCIE_CK>,
+				 <&infracfg CLK_INFRA_IPCIER_CK>,
+				 <&infracfg CLK_INFRA_IPCIEB_CK>;
+			clock-names = "pl_250m", "tl_26m", "peri_26m", "top_133m";
+			status = "disabled";
+
+			phys = <&pcie_port PHY_TYPE_PCIE>;
+			phy-names = "pcie-phy";
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &pcie_intc 0>,
+					<0 0 0 2 &pcie_intc 1>,
+					<0 0 0 3 &pcie_intc 2>,
+					<0 0 0 4 &pcie_intc 3>;
+			pcie_intc: interrupt-controller {
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
+
+		pcie_phy: t-phy@11c00000 {
+			compatible = "mediatek,mt7986-tphy",
+				     "mediatek,generic-tphy-v2";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			status = "disabled";
+
+			pcie_port: pcie-phy@11c00000 {
+				reg = <0 0x11c00000 0 0x20000>;
+				clocks = <&clk40m>;
+				clock-names = "ref";
+				#phy-cells = <1>;
+			};
+		};
+
 		usb_phy: t-phy@11e10000 {
 			compatible = "mediatek,mt7986-tphy",
 				     "mediatek,generic-tphy-v2";
-- 
2.34.1

