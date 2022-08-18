Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75E8597F15
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 09:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243821AbiHRHTt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 03:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243810AbiHRHTq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 03:19:46 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434698E470;
        Thu, 18 Aug 2022 00:19:44 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id ED77C202EEE;
        Thu, 18 Aug 2022 09:19:42 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B788A2006AF;
        Thu, 18 Aug 2022 09:19:42 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id DA0D31820F57;
        Thu, 18 Aug 2022 15:19:40 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     p.zabel@pengutronix.de, l.stach@pengutronix.de,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        shawnguo@kernel.org, vkoul@kernel.org,
        alexander.stein@ew.tq-group.com, marex@denx.de
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v3 5/6] arm64: dts: imx8mp-evk: Add PCIe support
Date:   Thu, 18 Aug 2022 15:02:32 +0800
Message-Id: <1660806153-29001-6-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1660806153-29001-1-git-send-email-hongxing.zhu@nxp.com>
References: <1660806153-29001-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe support on i.MX8MP EVK board.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 53 ++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index f6b017ab5f53..defc92a8bb60 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/phy/phy-imx8-pcie.h>
 #include "imx8mp.dtsi"
 
 / {
@@ -33,6 +34,12 @@ memory@40000000 {
 		      <0x1 0x00000000 0 0xc0000000>;
 	};
 
+	pcie0_refclk: pcie0-refclk {
+		compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <100000000>;
+	};
+
 	reg_can1_stby: regulator-can1-stby {
 		compatible = "regulator-fixed";
 		regulator-name = "can1-stby";
@@ -55,6 +62,17 @@ reg_can2_stby: regulator-can2-stby {
 		enable-active-high;
 	};
 
+	reg_pcie0: regulator-pcie {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pcie0_reg>;
+		regulator-name = "MPCIE_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	reg_usdhc2_vmmc: regulator-usdhc2 {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -350,6 +368,28 @@ &i2c5 {
 	 */
 };
 
+&pcie_phy {
+	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
+	clocks = <&pcie0_refclk>;
+	clock-names = "ref";
+	status = "okay";
+};
+
+&pcie{
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie0>;
+	reset-gpio = <&gpio2 7 GPIO_ACTIVE_LOW>;
+	clocks = <&clk IMX8MP_CLK_HSIO_ROOT>,
+		 <&clk IMX8MP_CLK_PCIE_ROOT>,
+		 <&clk IMX8MP_CLK_HSIO_AXI>;
+	clock-names = "pcie", "pcie_aux", "pcie_bus";
+	assigned-clocks = <&clk IMX8MP_CLK_PCIE_AUX>;
+	assigned-clock-rates = <10000000>;
+	assigned-clock-parents = <&clk IMX8MP_SYS_PLL2_50M>;
+	vpcie-supply = <&reg_pcie0>;
+	status = "okay";
+};
+
 &snvs_pwrkey {
 	status = "okay";
 };
@@ -502,6 +542,19 @@ MX8MP_IOMUXC_SPDIF_TX__I2C5_SCL         0x400001c2
 		>;
 	};
 
+	pinctrl_pcie0: pcie0grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C4_SCL__PCIE_CLKREQ_B	0x61 /* open drain, pull up */
+			MX8MP_IOMUXC_SD1_DATA5__GPIO2_IO07	0x41
+		>;
+	};
+
+	pinctrl_pcie0_reg: pcie0reggrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD1_DATA4__GPIO2_IO06	0x41
+		>;
+	};
+
 	pinctrl_pmic: pmicgrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_GPIO1_IO03__GPIO1_IO03	0x000001c0
-- 
2.25.1

