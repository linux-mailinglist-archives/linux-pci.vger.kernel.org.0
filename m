Return-Path: <linux-pci+bounces-24992-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BCBA75C12
	for <lists+linux-pci@lfdr.de>; Sun, 30 Mar 2025 21:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2519168BDD
	for <lists+linux-pci@lfdr.de>; Sun, 30 Mar 2025 19:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D60D1DF269;
	Sun, 30 Mar 2025 19:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tt0WZRFw";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lFvK0FK3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDAC1DEFEC;
	Sun, 30 Mar 2025 19:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743364726; cv=none; b=RTJz7dL5cuZ+KAUmGKubyIZIk91jHJL05yaj61YhpRTpTIhXrq7dpxMnEKAA5csM03e5z9mRuucBBNsk/vKHv6XNR5CEROEf1RMz23tbAMZ4iEN8RZg8ETBgqYVzC/NUEECGDDNiCvi0X7qc0dHCvOa2dsh4m4W1VzAk9aOoKbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743364726; c=relaxed/simple;
	bh=hq7t8KsvFFT8LzsQs97IaeHj4uCm6rnu6/2Av0qljVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DQ4VacHRQk5SDxDmf2o1+gi3AcoPOJuw+MtUGgcHL5Bppa0EVqUK49vUkiv630fUxBsThu9VaPaU40DFdt+nuea/ZECx1MgSQ404sM0yAh5UzZ4YAhfgS5ZSNCUtC8jKtw7y4cNVCn+rc2dSgvIYI5ZFStRdbWXPJtV2QPFsop8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=tt0WZRFw; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=lFvK0FK3; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ZQlSd1FBGz9sX2;
	Sun, 30 Mar 2025 21:58:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1743364721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NIpGKmPTwmgH6kt4Z9N97KhuCd1YIaNH+No8Gveimbg=;
	b=tt0WZRFwe+srhexlY8zen025H0dcFS9RHFT6pviYef6DLtISO9250Qz8D3K0nGGP9JaWyb
	ta1wDhwGbOWOAsE8m9Di4pk8tRMJFiqOl3w/BUjVN72ysVs8Z+OOf3WZVieprEqkCznMYv
	Mm9FH1/kenMmUFp1jGjR+ZU9WZuXckt2xgaL7GQ8PbXhJCkFZzOlO3jppSmqEgRpjOkrQu
	plqx2UiXa8L2bQamUXUYe0HYWEk0j4R36Tal1pNC03qtz06307LYWWxnPw5qJwSJvofInH
	mY3GWoZaDqC6Vz+mjJwktbL1HS2RasR2grweDfHMq7wCuin5bfrrBrGbu9MxEw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1743364719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NIpGKmPTwmgH6kt4Z9N97KhuCd1YIaNH+No8Gveimbg=;
	b=lFvK0FK36+szTOwFt5+hDxXIEd60xGwcTfNSanK8PM24MBDr1b+6iwWyP4NOtKeYwGLISm
	alQ9YzOUYuiO/a276p6vuLXkOiG3HLy6AITy0WLMF/3P56zpFvoEeWL4o7PMUe47d76o6l
	k9zYBbocqkSWZTa+KuHlV+TcbI6U6cX0eLe9AI4WnMB6kQI8BFPt1Jxm18NxA5uMGkbW5t
	TIV+wWDJfc/SAKDsOZBV3lEt22b3jgWsqCDpRM8EgzyoTonO63nBYqnxhRMnFwvpnoraRE
	IQs+8EnYlU56FKJyBkB3Y6GQw71x6ash2IeRELizK3W3mOSko/X/NW+HgUCbnA==
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Heiko Stuebner <heiko@sntech.de>,
	Junhao Xie <bigfoot@classfun.cn>,
	Kever Yang <kever.yang@rock-chips.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH 4/4] arm64: dts: renesas: r8a779g3: Add Renesas R-Car V4H Sparrow Hawk board support
Date: Sun, 30 Mar 2025 21:56:12 +0200
Message-ID: <20250330195715.332106-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250330195715.332106-1-marek.vasut+renesas@mailbox.org>
References: <20250330195715.332106-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: s4icedicx617txbbw6skdtyr6i5c3aa4
X-MBO-RS-ID: 2614ce2625e770c9a22
X-Rspamd-Queue-Id: 4ZQlSd1FBGz9sX2

Add Renesas R-Car V4H Sparrow Hawk board based on R-Car V4H ES3.0 (R8A779G3)
SoC. This is a single-board computer with single gigabit ethernet, DSI-to-eDP
bridge, DSI and two CSI2 interfaces, audio codec, two CANFD ports, micro SD
card slot, USB PD supply, USB 3.0 ports, M.2 Key-M slot for NVMe SSD, debug
UART and JTAG.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Krzysztof Wilczyński" <kw@linux.com>
Cc: "Rafał Miłecki" <rafal@milecki.pl>
Cc: Aradhya Bhatia <a-bhatia1@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Junhao Xie <bigfoot@classfun.cn>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
 arch/arm64/boot/dts/renesas/Makefile          |   2 +
 .../dts/renesas/r8a779g3-sparrow-hawk.dts     | 671 ++++++++++++++++++
 2 files changed, 673 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index d25e665ee4bfb..8bed8069a007e 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -94,6 +94,8 @@ dtb-$(CONFIG_ARCH_R8A779G0) += r8a779g2-white-hawk-single.dtb
 r8a779g2-white-hawk-single-ard-audio-da7212-dtbs := r8a779g2-white-hawk-single.dtb white-hawk-ard-audio-da7212.dtbo
 dtb-$(CONFIG_ARCH_R8A779G0) += r8a779g2-white-hawk-single-ard-audio-da7212.dtb
 
+dtb-$(CONFIG_ARCH_R8A779G0) += r8a779g3-sparrow-hawk.dtb
+
 dtb-$(CONFIG_ARCH_R8A779G0) += r8a779g3-white-hawk-single.dtb
 r8a779g3-white-hawk-single-ard-audio-da7212-dtbs := r8a779g3-white-hawk-single.dtb white-hawk-ard-audio-da7212.dtbo
 dtb-$(CONFIG_ARCH_R8A779G0) += r8a779g3-white-hawk-single-ard-audio-da7212.dtb
diff --git a/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts b/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts
new file mode 100644
index 0000000000000..33df5af85f551
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts
@@ -0,0 +1,671 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the R-Car V4H ES3.0 Sparrow Hawk board
+ *
+ * Copyright (C) 2025 Marek Vasut <marek.vasut+renesas@mailbox.org>
+ */
+
+/dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
+
+#include "r8a779g3.dtsi"
+
+/ {
+	model = "Retronix Sparrow Hawk board based on r8a779g3";
+	compatible = "retronix,sparrow-hawk", "renesas,r8a779g3",
+		     "renesas,r8a779g0";
+
+	aliases {
+		ethernet0 = &avb0;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
+		serial0 = &hscif0;
+		spi0 = &rpc;
+	};
+
+	chosen {
+		bootargs = "ignore_loglevel rw root=/dev/nfs ip=on";
+		stdout-path = "serial0:921600n8";
+	};
+
+	/* Page 31 / FAN */
+	fan: pwm-fan {
+		pinctrl-0 = <&irq4_pins>;
+		pinctrl-names = "default";
+		compatible = "pwm-fan";
+		#cooling-cells = <2>;
+		cooling-levels = <0 50 100 150 200 255>;
+		pwms = <&pwm0 0 50000>;
+		pulses-per-revolution = <2>;
+		interrupts-extended = <&intc_ex 4 IRQ_TYPE_EDGE_FALLING>;
+		/* No FAN connected by default. */
+		status = "disabled";
+	};
+
+	/*
+	 * Page 15 / LPDDR5
+	 *
+	 * This configuration listed below is for the 8 GiB board variant
+	 * with MT62F1G64D8EK-023 WT:C LPDDR5 part populated on the board.
+	 *
+	 * A variant with 16 GiB MT62F2G64D8EK-023 WT:C part populated on
+	 * the board is automatically handled by the bootloader, which
+	 * adjusts the correct DRAM size into the memory nodes below.
+	 */
+	memory@48000000 {
+		device_type = "memory";
+		/* first 128MB is reserved for secure area. */
+		reg = <0x0 0x48000000 0x0 0x78000000>;
+	};
+
+	memory@480000000 {
+		device_type = "memory";
+		reg = <0x4 0x80000000 0x0 0x80000000>;
+	};
+
+	memory@600000000 {
+		device_type = "memory";
+		reg = <0x6 0x00000000 0x1 0x00000000>;
+	};
+
+	/* Page 27 / DSI to Display */
+	mini-dp-con {
+		compatible = "dp-connector";
+		label = "CN6";
+		type = "full-size";
+
+		port {
+			mini_dp_con_in: endpoint {
+				remote-endpoint = <&sn65dsi86_out>;
+			};
+		};
+	};
+
+	reg_1p2v: regulator-1p2v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-1.2V";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-1.8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	/* Page 27 / DSI to Display */
+	sn65dsi86_refclk: clk-x9 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <38400000>;
+	};
+
+	/* Page 26 / PCIe.0/1 CLK */
+	pcie_refclk: clk-x8 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+	};
+
+	/* Page 17 uSD-Slot */
+	vcc_sdhi: regulator-vcc-sdhi {
+		compatible = "regulator-gpio";
+		regulator-name = "SDHI VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&gpio8 13 GPIO_ACTIVE_HIGH>;
+		gpios-states = <1>;
+		states = <3300000 0>, <1800000 1>;
+	};
+};
+
+/* Page 22 / Ether_AVB0 */
+&avb0 {
+	pinctrl-0 = <&avb0_pins>;
+	pinctrl-names = "default";
+	phy-handle = <&avb0_phy>;
+	tx-internal-delay-ps = <2000>;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		avb0_phy: ethernet-phy@0 {	/* KSZ9031RNXVB */
+			compatible = "ethernet-phy-id0022.1622",
+				     "ethernet-phy-ieee802.3-c22";
+			rxc-skew-ps = <1500>;
+			reg = <0>;
+			/* AVB0_PHY_INT_V */
+			interrupts-extended = <&gpio7 5 IRQ_TYPE_LEVEL_LOW>;
+			/* GP7_10/AVB0_RESETN_V */
+			reset-gpios = <&gpio7 10 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <300>;
+		};
+	};
+};
+
+/* Page 28 / CANFD_IF */
+&can_clk {
+	clock-frequency = <40000000>;
+};
+
+/* Page 28 / CANFD_IF */
+&canfd {
+	pinctrl-0 = <&canfd3_pins>, <&canfd4_pins>, <&can_clk_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	channel3 {
+		status = "okay";
+	};
+
+	channel4 {
+		status = "okay";
+	};
+};
+
+/* Page 27 / DSI to Display */
+&dsi1 {
+	status = "okay";
+
+	ports {
+		port@1 {
+			dsi1_out: endpoint {
+				remote-endpoint = <&sn65dsi86_in>;
+				data-lanes = <1 2 3 4>;
+			};
+		};
+	};
+};
+
+/* Page 27 / DSI to Display */
+&du {
+	status = "okay";
+};
+
+/* Page 5 / R-Car V4H_INT_I2C */
+&extal_clk {	/* X3 */
+	clock-frequency = <16666666>;
+};
+
+/* Page 5 / R-Car V4H_INT_I2C */
+&extalr_clk {	/* X2 */
+	clock-frequency = <32768>;
+};
+
+/* Page 26 / 2230 Key M M.2 */
+&gpio4 {
+	/* 9FGV0441 nOE inputs 0 and 1 */
+	pcie-m2-oe-hog {
+		gpio-hog;
+		gpios = <21 GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "PCIe-CLK-nOE-M2";
+	};
+
+	/* 9FGV0441 nOE inputs 2 and 3 */
+	pcie-usb-oe-hog {
+		gpio-hog;
+		gpios = <22 GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "PCIe-CLK-nOE-USB";
+	};
+};
+
+/* Page 23 / DEBUG */
+&hscif0 {	/* FTDI ADBUS[3:0] */
+	pinctrl-0 = <&hscif0_pins>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+	bootph-all;
+
+	status = "okay";
+};
+
+/* Page 23 / DEBUG */
+&hscif1 {	/* FTDI BDBUS[3:0] */
+	pinctrl-0 = <&hscif1_pins>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+
+	status = "okay";
+};
+
+/* Page 24 / UART */
+&hscif3 {	/* CN7 pins 8 (TX) and 10 (RX) */
+	pinctrl-0 = <&hscif3_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+/* Page 24 / I2C SWITCH */
+&i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-0 = <&i2c0_pins>;
+	pinctrl-names = "default";
+	clock-frequency = <400000>;
+	status = "okay";
+
+	mux@71 {
+		compatible = "nxp,pca9544";	/* TCA9544 */
+		reg = <0x71>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		vdd-supply = <&reg_3p3v>;
+
+		i2c0_mux0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* Page 27 / DSI to Display */
+			bridge@2c {
+				pinctrl-0 = <&irq0_pins>;
+				pinctrl-names = "default";
+
+				compatible = "ti,sn65dsi86";
+				reg = <0x2c>;
+
+				clocks = <&sn65dsi86_refclk>;
+				clock-names = "refclk";
+
+				interrupts-extended = <&intc_ex 0 IRQ_TYPE_LEVEL_HIGH>;
+
+				enable-gpios = <&gpio2 1 GPIO_ACTIVE_HIGH>;
+
+				vccio-supply = <&reg_1p8v>;
+				vpll-supply = <&reg_1p8v>;
+				vcca-supply = <&reg_1p2v>;
+				vcc-supply = <&reg_1p2v>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						sn65dsi86_in: endpoint {
+							remote-endpoint = <&dsi1_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						sn65dsi86_out: endpoint {
+							remote-endpoint = <&mini_dp_con_in>;
+						};
+					};
+				};
+			};
+		};
+
+		i2c0_mux1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c0_mux2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* Page 26 / PCIe.0/1 CLK */
+			pcie_clk: clk@68 {
+				compatible = "renesas,9fgv0441";
+				reg = <0x68>;
+				clocks = <&pcie_refclk>;
+				#clock-cells = <1>;
+			};
+		};
+
+		i2c0_mux3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+/* Page 29 / CSI_IF_CN / CAM_CN0 */
+&i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-0 = <&i2c1_pins>;
+	pinctrl-names = "default";
+};
+
+/* Page 29 / CSI_IF_CN / CAM_CN1 */
+&i2c2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-names = "default";
+};
+
+/* Page 31 / IO_CN */
+&i2c3 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-0 = <&i2c3_pins>;
+	pinctrl-names = "default";
+};
+
+/* Page 31 / IO_CN */
+&i2c4 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-0 = <&i2c4_pins>;
+	pinctrl-names = "default";
+};
+
+/* Page 18 / POWER_CORE and Page 19 / POWER_PMIC */
+&i2c5 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-0 = <&i2c5_pins>;
+	pinctrl-names = "default";
+};
+
+/* Page 17 uSD-Slot */
+&mmc0 {
+	pinctrl-0 = <&sd_pins>;
+	pinctrl-1 = <&sd_uhs_pins>;
+	pinctrl-names = "default", "state_uhs";
+	bus-width = <4>;
+	cd-gpios = <&gpio3 11 GPIO_ACTIVE_LOW>;	/* SD_CD */
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&vcc_sdhi>;
+	status = "okay";
+};
+
+/* Page 26 / 2230 Key M M.2 */
+&pcie0_clkref {
+	status = "disabled";
+};
+
+&pciec0 {
+	clocks = <&cpg CPG_MOD 624>, <&pcie_clk 0>, <&pcie_clk 1>;
+	clock-names = "core", "ref", "aux";
+	reset-gpios = <&gpio2 2 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+/* Page 25 / PCIe to USB */
+&pcie1_clkref {
+	status = "disabled";
+};
+
+&pciec1 {
+	clocks = <&cpg CPG_MOD 625>, <&pcie_clk 2>, <&pcie_clk 3>;
+	clock-names = "core", "ref", "aux";
+	/* uPD720201 is PCIe Gen2 x1 device */
+	num-lanes = <1>;
+	reset-gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&pfc {
+	pinctrl-0 = <&scif_clk_pins>;
+	pinctrl-names = "default";
+
+	/* Page 22 / Ether_AVB0 */
+	avb0_pins: avb0 {
+		mux {
+			groups = "avb0_link", "avb0_mdio", "avb0_rgmii",
+				 "avb0_txcrefclk";
+			function = "avb0";
+		};
+
+		pins_mdio {
+			groups = "avb0_mdio";
+			drive-strength = <21>;
+		};
+
+		pins_mii {
+			groups = "avb0_rgmii";
+			drive-strength = <21>;
+		};
+
+	};
+
+	/* Page 28 / CANFD_IF */
+	can_clk_pins: can-clk {
+		groups = "can_clk";
+		function = "can_clk";
+	};
+
+	/* Page 28 / CANFD_IF */
+	canfd3_pins: canfd3 {
+		groups = "canfd3_data";
+		function = "canfd3";
+	};
+
+	/* Page 28 / CANFD_IF */
+	canfd4_pins: canfd4 {
+		groups = "canfd4_data";
+		function = "canfd4";
+	};
+
+	/* Page 23 / DEBUG */
+	hscif0_pins: hscif0 {
+		groups = "hscif0_data", "hscif0_ctrl";
+		function = "hscif0";
+	};
+
+	/* Page 23 / DEBUG */
+	hscif1_pins: hscif1 {
+		groups = "hscif1_data_a", "hscif1_ctrl_a";
+		function = "hscif1";
+	};
+
+	/* Page 24 / UART */
+	hscif3_pins: hscif3 {
+		groups = "hscif3_data_a";
+		function = "hscif3";
+	};
+
+	/* Page 24 / I2C SWITCH */
+	i2c0_pins: i2c0 {
+		groups = "i2c0";
+		function = "i2c0";
+	};
+
+	/* Page 29 / CSI_IF_CN / CAM_CN0 */
+	i2c1_pins: i2c1 {
+		groups = "i2c1";
+		function = "i2c1";
+	};
+
+	/* Page 29 / CSI_IF_CN / CAM_CN1 */
+	i2c2_pins: i2c2 {
+		groups = "i2c2";
+		function = "i2c2";
+	};
+
+	/* Page 31 / IO_CN */
+	i2c3_pins: i2c3 {
+		groups = "i2c3";
+		function = "i2c3";
+	};
+
+	/* Page 31 / IO_CN */
+	i2c4_pins: i2c4 {
+		groups = "i2c4";
+		function = "i2c4";
+	};
+
+	/* Page 18 / POWER_CORE */
+	i2c5_pins: i2c5 {
+		groups = "i2c5";
+		function = "i2c5";
+	};
+
+	/* Page 27 / DSI to Display */
+	irq0_pins: irq0 {
+		groups = "intc_ex_irq0_a";
+		function = "intc_ex";
+	};
+
+	/* Page 31 / FAN */
+	irq4_pins: irq4 {
+		groups = "intc_ex_irq4_b";
+		function = "intc_ex";
+	};
+
+	/* Page 31 / FAN */
+	pwm0_pins: pwm0 {
+		groups = "pwm0";
+		function = "pwm0";
+	};
+
+	/* Page 31 / CN7 pin 12 */
+	pwm1_pins: pwm1 {
+		groups = "pwm1_b";
+		function = "pwm1";
+	};
+
+	/* Page 31 / CN7 pin 32 */
+	pwm6_pins: pwm6 {
+		groups = "pwm6";
+		function = "pwm6";
+	};
+
+	/* Page 31 / CN7 pin 33 */
+	pwm7_pins: pwm7 {
+		groups = "pwm7";
+		function = "pwm7";
+	};
+
+	/* Page 16 / QSPI_FLASH */
+	qspi0_pins: qspi0 {
+		groups = "qspi0_ctrl", "qspi0_data4";
+		function = "qspi0";
+		bootph-all;
+	};
+
+	/* Page 6 / SCIF_CLK_SOC_V */
+	scif_clk_pins: scif_clk {
+		groups = "scif_clk";
+		function = "scif_clk";
+	};
+
+	/* Page 17 uSD-Slot */
+	sd_pins: sd {
+		groups = "mmc_data4", "mmc_ctrl";
+		function = "mmc";
+		power-source = <3300>;
+	};
+
+	/* Page 17 uSD-Slot */
+	sd_uhs_pins: sd_uhs {
+		groups = "mmc_data4", "mmc_ctrl";
+		function = "mmc";
+		power-source = <1800>;
+	};
+};
+
+/* Page 31 / FAN */
+&pwm0 {
+	pinctrl-0 = <&pwm0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+/* Page 31 / CN7 pin 12 */
+&pwm1 {
+	pinctrl-0 = <&pwm1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+/* Page 31 / CN7 pin 32 */
+&pwm6 {
+	pinctrl-0 = <&pwm6_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+/* Page 31 / CN7 pin 33 */
+&pwm7 {
+	pinctrl-0 = <&pwm7_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+/* Page 16 / QSPI_FLASH */
+&rpc {
+	pinctrl-0 = <&qspi0_pins>;
+	pinctrl-names = "default";
+	bootph-all;
+
+	status = "okay";
+
+	flash@0 {
+		compatible = "spansion,s25fs512s", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <40000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
+		bootph-all;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			boot@0 {
+				reg = <0x0 0x1000000>;
+				read-only;
+			};
+
+			user@1000000 {
+				reg = <0x1000000 0x2f80000>;
+			};
+
+			env1@3f80000 {
+				reg = <0x3f80000 0x40000>;
+			};
+
+			env2@3fc0000 {
+				reg = <0x3fc0000 0x40000>;
+			};
+		};
+	};
+};
+
+&rwdt {
+	timeout-sec = <60>;
+	status = "okay";
+};
+
+/* Page 6 / SCIF_CLK_SOC_V */
+&scif_clk {	/* X12 */
+	clock-frequency = <24000000>;
+};
-- 
2.47.2


