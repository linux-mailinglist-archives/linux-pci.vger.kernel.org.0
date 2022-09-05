Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19565ACCA3
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 09:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237357AbiIEHTp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 03:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236739AbiIEHTO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 03:19:14 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D43926408;
        Mon,  5 Sep 2022 00:14:31 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,290,1654527600"; 
   d="scan'208";a="131687316"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 05 Sep 2022 16:13:10 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 699B74004461;
        Mon,  5 Sep 2022 16:13:10 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, krzk+dt@kernel.org, geert+renesas@glider.be,
        magnus.damm@gmail.com
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v5 12/12] arm64: dts: renesas: r8a779f0: spider: Enable PCIe Host ch0
Date:   Mon,  5 Sep 2022 16:12:57 +0900
Message-Id: <20220905071257.1059436-13-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220905071257.1059436-1-yoshihiro.shimoda.uh@renesas.com>
References: <20220905071257.1059436-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable PCIe Host controller channel 0 on R-Car S4-8 Spider board.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 .../boot/dts/renesas/r8a779f0-spider-cpu.dtsi | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a779f0-spider-cpu.dtsi b/arch/arm64/boot/dts/renesas/r8a779f0-spider-cpu.dtsi
index 4a876d47f59b..b1d0f7c4fd6b 100644
--- a/arch/arm64/boot/dts/renesas/r8a779f0-spider-cpu.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779f0-spider-cpu.dtsi
@@ -5,6 +5,7 @@
  * Copyright (C) 2021 Renesas Electronics Corp.
  */
 
+#include <dt-bindings/gpio/gpio.h>
 #include "r8a779f0.dtsi"
 
 / {
@@ -49,6 +50,28 @@ &extalr_clk {
 	clock-frequency = <32768>;
 };
 
+&i2c0 {
+	pinctrl-0 = <&i2c0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+	clock-frequency = <400000>;
+
+	gpio_exp_20: gpio@20 {
+		compatible = "ti,tca9554";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		pcie-perst-hog {
+			gpio-hog;
+			gpios = <0 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "PCIE_PERSTn";
+		};
+	};
+};
+
 &i2c4 {
 	pinctrl-0 = <&i2c4_pins>;
 	pinctrl-names = "default";
@@ -85,10 +108,21 @@ &mmc0 {
 	status = "okay";
 };
 
+&pciec0 {
+	pinctrl-0 = <&pcie0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &pfc {
 	pinctrl-0 = <&scif_clk_pins>;
 	pinctrl-names = "default";
 
+	i2c0_pins: i2c0 {
+		groups = "i2c0";
+		function = "i2c0";
+	};
+
 	i2c4_pins: i2c4 {
 		groups = "i2c4";
 		function = "i2c4";
@@ -100,6 +134,11 @@ mmc_pins: mmc {
 		power-source = <1800>;
 	};
 
+	pcie0_pins: pcie0 {
+		groups = "pcie0_clkreq_n";
+		function = "pcie";
+	};
+
 	scif0_pins: scif0 {
 		groups = "scif0_data", "scif0_ctrl";
 		function = "scif0";
-- 
2.25.1

