Return-Path: <linux-pci+bounces-5260-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 718A588E3A9
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 14:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27CCC2A3627
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 13:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2642C1836C1;
	Wed, 27 Mar 2024 12:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BE6DnJ3z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC7A181CE2;
	Wed, 27 Mar 2024 12:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542321; cv=none; b=HGIrGTL4DY5oYYjEB5kcDCVV1qq80/la0SoSXsEDp4iyS4uWARFc/mJVVHrZfFvXJ6Tua2yHwxD4kF7cYxltxq3xkDIbh6w1GRZzMPzTwDYhfNwuF4L6TFu9vqtN1Hc8Ke2YoSeUwpGc8oqLWQ2/um/qZ/B9wUob1qbjNeACfGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542321; c=relaxed/simple;
	bh=Fi5YANMykhXfh/CWBHTWx+veKXkxaKsp6BEQ+wOOAdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ru+DrK+1ywPqszQl75Gry02bMeM3zAu09Bt3i7IjaG7szMSL7XaFDGjrxwsPCMMmbP+T39cRinpkudfPqodrTvjqt90uGVECQZAl/EIJcckMcCnGo9x7kPIO1Tv/ojttANTg6Fw0aMymUaraGJWzLLmvmzO70/qPx/FYFbXFDnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BE6DnJ3z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85912C43601;
	Wed, 27 Mar 2024 12:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542320;
	bh=Fi5YANMykhXfh/CWBHTWx+veKXkxaKsp6BEQ+wOOAdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BE6DnJ3zQ940NFCKlMHYxj5eF9TXRc1Le2NrUQRMiw2Cd3KfJ5zMK/6fYjXSPVehI
	 zRm88FyCd0hBvDlr6IfDOWyRZDqCQ9OrbbR4X2mWqg4J8xhE7GuBTfh3lnwn+H1Tid
	 7r9GuyFwt4v+5KSpsnqfohxsssbGUTWCEgjpeHwT8qxGy4qj+tguWyWs/gIpDDH0F4
	 LrSu5HTLq5JRpT3mKeMjJK8NlBaZvSFW4sMqup7+wALbnXk+fOZ8oZAvt4xPxZRV37
	 Xb/by73t9T/2L8HkiO79S0/lbjKQfBOcRnKr3I3Sr6fgLFjTO9JqyXnUJq2ks2RfQn
	 r024H5GsnRovQ==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Jamie Gibbons <jamie.gibbons@microchip.com>,
	Valentina Fernandez <valentina.fernandezalanis@microchip.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v1 5/5] riscv: dts: microchip: add an initial devicetree for the BeagleV Fire
Date: Wed, 27 Mar 2024 12:24:40 +0000
Message-ID: <20240327-hurry-escapable-e3212bf3cdd8@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240327-parkway-dodgy-f0fe1fa20892@spud>
References: <20240327-parkway-dodgy-f0fe1fa20892@spud>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10766; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=VzkOrHaeB0MJo+Fuu8Q8iocE4H/HvHELUhz5DPz+Uls=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGksAmyZ0wrjJVa9PrtY7bqA8CefW9NY3iu4hUytzBRXf H6HbeG9jlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEzkRjnDP8UZWr+YD6z5dHfu miq7+znRDZkGm0xmnfxWq12yzFSX8Qwjw4VbweqZ32/0BPwI+HfhhLZV79wA/2Xck60uxmr8bA7 k5AMA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Add an initial devicetree for the BeagleV Fire. This devicetree differs
from that in the BeagleBoard BSP as it has a different memory
configuration, however it will boot on the same FPGA images. PCI is
disabled for now, as the Linux PCI driver (and the binding) assume
which root port instance is in use. This will need to be fixed before
PCI can be enabled.

Link: https://www.beagleboard.org/boards/beaglev-fire
Co-developed-by: Jamie Gibbons <jamie.gibbons@microchip.com>
Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/microchip/Makefile        |   1 +
 .../microchip/mpfs-beaglev-fire-fabric.dtsi   | 124 ++++++++++
 .../boot/dts/microchip/mpfs-beaglev-fire.dts  | 223 ++++++++++++++++++
 3 files changed, 348 insertions(+)
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-beaglev-fire-fabric.dtsi
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-beaglev-fire.dts

diff --git a/arch/riscv/boot/dts/microchip/Makefile b/arch/riscv/boot/dts/microchip/Makefile
index e177815bf1a2..f51aeeb9fd3b 100644
--- a/arch/riscv/boot/dts/microchip/Makefile
+++ b/arch/riscv/boot/dts/microchip/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-beaglev-fire.dtb
 dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-icicle-kit.dtb
 dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-m100pfsevp.dtb
 dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-polarberry.dtb
diff --git a/arch/riscv/boot/dts/microchip/mpfs-beaglev-fire-fabric.dtsi b/arch/riscv/boot/dts/microchip/mpfs-beaglev-fire-fabric.dtsi
new file mode 100644
index 000000000000..0abd0dc540be
--- /dev/null
+++ b/arch/riscv/boot/dts/microchip/mpfs-beaglev-fire-fabric.dtsi
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+/ {
+	fabric_clk3: fabric-clk3 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <50000000>;
+	};
+
+	fabric_clk1: fabric-clk1 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+	};
+
+	fabric-bus@40000000 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x0 0x40000000 0x0 0x40000000 0x0 0x20000000>, /* FIC3-FAB */
+			 <0x0 0x60000000 0x0 0x60000000 0x0 0x20000000>, /* FIC0, LO */
+			 <0x0 0xe0000000 0x0 0xe0000000 0x0 0x20000000>, /* FIC1, LO */
+			 <0x20 0x0 0x20 0x0 0x10 0x0>, /* FIC0,HI */
+			 <0x30 0x0 0x30 0x0 0x10 0x0>; /* FIC1,HI */
+
+		cape_gpios_p8: gpio@41100000 {
+			compatible = "microchip,coregpio-rtl-v3";
+			reg = <0x0 0x41100000 0x0 0x1000>;
+			clocks = <&fabric_clk3>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			ngpios = <16>;
+			gpio-line-names = "P8_PIN31", "P8_PIN32", "P8_PIN33", "P8_PIN34",
+					  "P8_PIN35", "P8_PIN36", "P8_PIN37", "P8_PIN38",
+					  "P8_PIN39", "P8_PIN40", "P8_PIN41", "P8_PIN42",
+					  "P8_PIN43", "P8_PIN44", "P8_PIN45", "P8_PIN46";
+		};
+
+		cape_gpios_p9: gpio@41200000 {
+			compatible = "microchip,coregpio-rtl-v3";
+			reg = <0x0 0x41200000 0x0 0x1000>;
+			clocks = <&fabric_clk3>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			ngpios = <20>;
+			gpio-line-names = "P9_PIN11", "P9_PIN12", "P9_PIN13", "P9_PIN14",
+					  "P9_PIN15", "P9_PIN16", "P9_PIN17", "P9_PIN18",
+					  "P9_PIN21", "P9_PIN22", "P9_PIN23", "P9_PIN24",
+					  "P9_PIN25", "P9_PIN26", "P9_PIN27", "P9_PIN28",
+					  "P9_PIN29", "P9_PIN31", "P9_PIN41", "P9_PIN42";
+		};
+
+		hsi_gpios: gpio@44000000 {
+			compatible = "microchip,coregpio-rtl-v3";
+			reg = <0x0 0x44000000 0x0 0x1000>;
+			clocks = <&fabric_clk3>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			ngpios = <20>;
+			gpio-line-names = "B0_HSIO70N", "B0_HSIO71N", "B0_HSIO83N",
+					  "B0_HSIO73N_C2P_CLKN", "B0_HSIO70P", "B0_HSIO71P",
+					  "B0_HSIO83P", "B0_HSIO73N_C2P_CLKP", "XCVR1_RX_VALID",
+					  "XCVR1_LOCK", "XCVR1_ERROR", "XCVR2_RX_VALID",
+					  "XCVR2_LOCK", "XCVR2_ERROR", "XCVR3_RX_VALID",
+					  "XCVR3_LOCK", "XCVR3_ERROR", "XCVR_0B_REF_CLK_PLL_LOCK",
+					  "XCVR_0C_REF_CLK_PLL_LOCK", "B0_HSIO81N";
+		};
+	};
+
+	fabric-pcie-bus@3000000000 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x0 0x40000000 0x0 0x40000000 0x0 0x20000000>,
+			 <0x30 0x0 0x30 0x0 0x10 0x0>;
+
+		pcie: pcie@3000000000 {
+			compatible = "microchip,pcie-host-1.0";
+			#address-cells = <0x3>;
+			#interrupt-cells = <0x1>;
+			#size-cells = <0x2>;
+			device_type = "pci";
+			reg = <0x30 0x0 0x0 0x8000000>,
+			      <0x0 0x43000000 0x0 0x10000>;
+			reg-names = "cfg", "apb";
+			bus-range = <0x0 0x7f>;
+			interrupt-parent = <&plic>;
+			interrupts = <119>;
+			interrupt-map = <0 0 0 1 &pcie_intc 0>,
+					<0 0 0 2 &pcie_intc 1>,
+					<0 0 0 3 &pcie_intc 2>,
+					<0 0 0 4 &pcie_intc 3>;
+			interrupt-map-mask = <0 0 0 7>;
+			clocks = <&ccc_nw CLK_CCC_PLL0_OUT1>,
+				 <&ccc_nw CLK_CCC_PLL0_OUT3>;
+			clock-names = "fic1", "fic3";
+			ranges = <0x43000000 0x0 0x9000000 0x30 0x9000000 0x0 0xf000000>,
+				 <0x1000000 0x0 0x8000000 0x30 0x8000000 0x0 0x1000000>,
+				 <0x3000000 0x0 0x18000000 0x30 0x18000000 0x0 0x70000000>;
+			msi-parent = <&pcie>;
+			msi-controller;
+			status = "disabled";
+
+			pcie_intc: interrupt-controller {
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
+	};
+
+	refclk_ccc: cccrefclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+	};
+};
+
+&ccc_nw {
+	clocks = <&refclk_ccc>, <&refclk_ccc>, <&refclk_ccc>, <&refclk_ccc>,
+		 <&refclk_ccc>, <&refclk_ccc>;
+	clock-names = "pll0_ref0", "pll0_ref1", "pll1_ref0", "pll1_ref1",
+		      "dll0_ref", "dll1_ref";
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/microchip/mpfs-beaglev-fire.dts b/arch/riscv/boot/dts/microchip/mpfs-beaglev-fire.dts
new file mode 100644
index 000000000000..47cf693beb68
--- /dev/null
+++ b/arch/riscv/boot/dts/microchip/mpfs-beaglev-fire.dts
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* Copyright (c) 2020-2021 Microchip Technology Inc */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include "mpfs.dtsi"
+#include "mpfs-beaglev-fire-fabric.dtsi"
+
+/* Clock frequency (in Hz) of MTIMER */
+#define MTIMER_FREQ		1000000
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	model = "BeagleBoard BeagleV-Fire";
+	compatible = "beagle,beaglev-fire", "microchip,mpfs";
+
+	aliases {
+		serial0 = &mmuart0;
+		serial1 = &mmuart1;
+		serial2 = &mmuart2;
+		serial3 = &mmuart3;
+		serial4 = &mmuart4;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	cpus {
+		timebase-frequency = <MTIMER_FREQ>;
+	};
+
+	ddrc_cache_lo: memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x40000000>;
+		status = "okay";
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		hss: hss-buffer@103fc00000 {
+			compatible = "shared-dma-pool";
+			reg = <0x10 0x3fc00000 0x0 0x400000>;
+			no-map;
+		};
+	};
+
+	imx219_clk: camera-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+	};
+
+	imx219_vana: fixedregulator-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "imx219_vana";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+	};
+
+	imx219_vdig: fixedregulator-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "imx219_vdig";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	imx219_vddl: fixedregulator-2 {
+		compatible = "regulator-fixed";
+		regulator-name = "imx219_vddl";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+	};
+
+};
+
+&gpio2 {
+	interrupts = <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>;
+	ngpios=<32>;
+	gpio-line-names = "P8_PIN3_USER_LED_0", "P8_PIN4_USER_LED_1", "P8_PIN5_USER_LED_2",
+			  "P8_PIN6_USER_LED_3", "P8_PIN7_USER_LED_4", "P8_PIN8_USER_LED_5",
+			  "P8_PIN9_USER_LED_6", "P8_PIN10_USER_LED_7", "P8_PIN11_USER_LED_8",
+			  "P8_PIN12_USER_LED_9", "P8_PIN13_USER_LED_10", "P8_PIN14_USER_LED_11",
+			  "P8_PIN15", "P8_PIN16", "P8_PIN17", "P8_PIN18", "P8_PIN19", "P8_PIN20",
+			  "P8_PIN21", "P8_PIN22", "P8_PIN23", "P8_PIN24", "P8_PIN25", "P8_PIN26",
+			  "P8_PIN27", "P8_PIN28", "P8_PIN29", "P8_PIN30", "M2_W_DISABLE1",
+			  "M2_W_DISABLE2", "VIO_ENABLE", "SD_DET";
+	status = "okay";
+
+	vio-enable-hog {
+		gpio-hog;
+		gpios = <30 30>;
+		output-high;
+		line-name = "VIO_ENABLE";
+	};
+
+	sd-det-hog {
+		gpio-hog;
+		gpios = <31 31>;
+		input;
+		line-name = "SD_DET";
+	};
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+
+	eeprom: eeprom@50 {
+		compatible = "atmel,24c32";
+		reg = <0x50>;
+	};
+
+	imx219: sensor@10 {
+		compatible = "sony,imx219";
+		reg = <0x10>;
+		clocks = <&imx219_clk>;
+		VANA-supply = <&imx219_vana>;   /* 2.8v */
+		VDIG-supply = <&imx219_vdig>;   /* 1.8v */
+		VDDL-supply = <&imx219_vddl>;   /* 1.2v */
+
+		port {
+			imx219_0: endpoint {
+				data-lanes = <1 2>;
+				clock-noncontinuous;
+				link-frequencies = /bits/ 64 <456000000>;
+			};
+		};
+	};
+};
+
+&mac0 {
+	status = "okay";
+	phy-mode = "sgmii";
+	phy-handle = <&phy0>;
+	phy0: ethernet-phy@0 {
+		reg = <0>;
+	};
+};
+
+&mbox {
+	status = "okay";
+};
+
+&mmc {
+	bus-width = <4>;
+	disable-wp;
+	cap-sd-highspeed;
+	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	status = "okay";
+};
+
+&mmuart0 {
+	status = "okay";
+};
+
+&mmuart1 {
+	status = "okay";
+};
+
+&refclk {
+	clock-frequency = <125000000>;
+};
+
+&refclk_ccc {
+	clock-frequency = <50000000>;
+};
+
+&rtc {
+	status = "okay";
+};
+
+&spi0 {
+	status = "okay";
+};
+
+&spi1 {
+	status = "okay";
+};
+
+&syscontroller {
+	microchip,bitstream-flash = <&sys_ctrl_flash>;
+	status = "okay";
+};
+
+&syscontroller_qspi {
+	status = "okay";
+
+	sys_ctrl_flash: flash@0 { // MT25QL01GBBB8ESF-0SIT
+		compatible = "jedec,spi-nor";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <20000000>;
+		spi-rx-bus-width = <1>;
+		reg = <0>;
+	};
+};
+
+&usb {
+	status = "okay";
+	dr_mode = "otg";
+};
-- 
2.43.0


