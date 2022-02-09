Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A264AE6AF
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 03:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241739AbiBICkM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 21:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241649AbiBICiO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 21:38:14 -0500
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2160C061355;
        Tue,  8 Feb 2022 18:38:13 -0800 (PST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 680191A0FF0;
        Wed,  9 Feb 2022 03:38:12 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2FDD51A0FEB;
        Wed,  9 Feb 2022 03:38:12 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C9A77183AC99;
        Wed,  9 Feb 2022 10:38:10 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     bhelgaas@google.com, shawnguo@kernel.org, l.stach@pengutronix.de
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v2] arm64: dts: imx8mq-evk: Add second PCIe port support
Date:   Wed,  9 Feb 2022 10:06:48 +0800
Message-Id: <1644372408-5485-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable the second PCIe port support on i.MX8MQ EVK board.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 38 ++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index a1b7582f3ecf..06f6e44da4d4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -27,6 +27,17 @@ pcie0_refclk: pcie0-refclk {
 		clock-frequency = <100000000>;
 	};
 
+	reg_pcie1: regulator-pcie {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pcie1_reg>;
+		regulator-name = "MPCIE_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio5 10 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	reg_usdhc2_vmmc: regulator-vsd-3v3 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_reg_usdhc2>;
@@ -327,6 +338,20 @@ &pcie0 {
 	status = "okay";
 };
 
+&pcie1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie1>;
+	reset-gpio = <&gpio5 12 GPIO_ACTIVE_LOW>;
+	clocks = <&clk IMX8MQ_CLK_PCIE2_ROOT>,
+		 <&clk IMX8MQ_CLK_PCIE2_AUX>,
+		 <&clk IMX8MQ_CLK_PCIE2_PHY>,
+		 <&pcie0_refclk>;
+	clock-names = "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
+	vpcie-supply = <&reg_pcie1>;
+	vph-supply = <&vgen5_reg>;
+	status = "okay";
+};
+
 &pgc_gpu {
 	power-supply = <&sw1a_reg>;
 };
@@ -482,6 +507,19 @@ MX8MQ_IOMUXC_UART4_RXD_GPIO5_IO28		0x16
 		>;
 	};
 
+	pinctrl_pcie1: pcie1grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_I2C4_SDA_PCIE2_CLKREQ_B		0x76
+			MX8MQ_IOMUXC_ECSPI2_MISO_GPIO5_IO12		0x16
+		>;
+	};
+
+	pinctrl_pcie1_reg: pcie1reggrp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_ECSPI2_SCLK_GPIO5_IO10		0x16
+		>;
+	};
+
 	pinctrl_qspi: qspigrp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_NAND_ALE_QSPI_A_SCLK	0x82
-- 
2.25.1

