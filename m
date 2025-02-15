Return-Path: <linux-pci+bounces-21548-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F05C5A36F41
	for <lists+linux-pci@lfdr.de>; Sat, 15 Feb 2025 16:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08F447A4C46
	for <lists+linux-pci@lfdr.de>; Sat, 15 Feb 2025 15:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3585F1FC7CF;
	Sat, 15 Feb 2025 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V4pCYLqw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D151F4180;
	Sat, 15 Feb 2025 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739635077; cv=none; b=mC9YpfhUmyD8rPlZhIO4ALqQ+0gCBm7dQ+1Hoda92qEj5D30cVUtS7U6wk+03DCYmZqUNlc9KGGYIxkkTvHRg5vCJYHEyE3oVGayf3I17+Ox5a6Gw5IvRws0pUEHYNQSrdD+0rYO6u6XfLD/KhPQ9lkQXtRxHuZGCktUubWCKdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739635077; c=relaxed/simple;
	bh=JO0vaewEq7zTVjkp+U21TLHlWl4rE+aCTffT9BBgjBY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pQTsbvmZlqVzXqZ172K2iFLAPj0ahia3JsG9lN3+XcXImq//JD0Y41YeLyIAv3dGnCthvJPWkBHP/Nh/5MWKTOpggek3AUAqobGG977JcXcGboP2N9+5R4+TxlbPNfCKG8Jm0qM5TzE+ZSahI9fLg9cBdR6jzsKqONPCH1UgcB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V4pCYLqw; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739635075; x=1771171075;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JO0vaewEq7zTVjkp+U21TLHlWl4rE+aCTffT9BBgjBY=;
  b=V4pCYLqwGVhE7xPQdgxPTGCNbHwO/3bLBjPfUjUTGGJUVUmN8AY+vpnt
   wqlChyJBruFhChyiDIdHCLpynlw4BjxIB92JNS2NI95FCC1tc5PdchowO
   mcaa9M/Qih5drZSsG8F2tlNjVz3hatIgOwBmCS9OYMM9gDk7om0Ar5BP+
   3/WoayKaDhWlg7Ksz1MTdLGAD7XfRAk/Ev7wZM5BQ5BAGMPTMWFbYUNYx
   uEDt3qXP56sfhlxniiwi4LrIL4QyRoEilrCR7nZG+AjYDpbAoSx02wYGZ
   9c6PASSlrfBby8pMH1wk6h+sScDPpegR8Z3MvVEF5tA05BlX5NI4cl3KE
   w==;
X-CSE-ConnectionGUID: 6N/TQ0yTTVeOdjpjFRoSOQ==
X-CSE-MsgGUID: cepJ2F5FQom0euUDFNd6gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40509969"
X-IronPort-AV: E=Sophos;i="6.13,289,1732608000"; 
   d="scan'208";a="40509969"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 07:57:55 -0800
X-CSE-ConnectionGUID: 3dSlJ89BTCOPMOl+kSR88g==
X-CSE-MsgGUID: JYBMy+XGQGCaBwhamtHJag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,289,1732608000"; 
   d="scan'208";a="113701926"
Received: from test2-linux-lab.an.altera.com ([10.244.157.115])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 07:57:54 -0800
From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	joyce.ooi@intel.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: matthew.gerlach@altera.com,
	peter.colberg@altera.com,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v7 6/7] arm64: dts: agilex: add dts enabling PCIe Root Port
Date: Sat, 15 Feb 2025 09:53:58 -0600
Message-Id: <20250215155359.321513-7-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250215155359.321513-1-matthew.gerlach@linux.intel.com>
References: <20250215155359.321513-1-matthew.gerlach@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a device tree enabling PCIe Root Port support on an Agilex F-series
Development Kit which has the P-tile variant of the PCIe IP.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
v7:
 - Create and use appropriate board compatibility and use of model.

v6:
 - Fix SPDX header.
 - Make compatible property first.
 - Fix comment line wrapping.
 - Don't include .dts.

v3:
 - Remove accepted patches from patch set.
---
 arch/arm64/boot/dts/intel/Makefile            |   1 +
 .../socfpga_agilex7f_socdk_pcie_root_port.dts | 147 ++++++++++++++++++
 2 files changed, 148 insertions(+)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dts

diff --git a/arch/arm64/boot/dts/intel/Makefile b/arch/arm64/boot/dts/intel/Makefile
index d39cfb723f5b..737e81c3c3f7 100644
--- a/arch/arm64/boot/dts/intel/Makefile
+++ b/arch/arm64/boot/dts/intel/Makefile
@@ -2,6 +2,7 @@
 dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_agilex_n6000.dtb \
 				socfpga_agilex_socdk.dtb \
 				socfpga_agilex_socdk_nand.dtb \
+				socfpga_agilex7f_socdk_pcie_root_port.dtb \
 				socfpga_agilex5_socdk.dtb \
 				socfpga_n5x_socdk.dtb
 dtb-$(CONFIG_ARCH_KEEMBAY) += keembay-evm.dtb
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dts b/arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dts
new file mode 100644
index 000000000000..19b14f88e32d
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dts
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024, Intel Corporation
+ */
+#include "socfpga_agilex.dtsi"
+#include "socfpga_agilex_pcie_root_port.dtsi"
+
+/ {
+	model = "SoCFPGA Agilex SoCDK";
+	compatible = "intel,socfpga-agilex7f-socdk-pcie-root-port", "intel,socfpga-agilex";
+
+	aliases {
+		serial0 = &uart0;
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
+		ethernet2 = &gmac2;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		led0 {
+			label = "hps_led0";
+			gpios = <&portb 20 GPIO_ACTIVE_HIGH>;
+		};
+
+		led1 {
+			label = "hps_led1";
+			gpios = <&portb 19 GPIO_ACTIVE_HIGH>;
+		};
+
+		led2 {
+			label = "hps_led2";
+			gpios = <&portb 21 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the reg */
+		reg = <0 0x80000000 0 0>;
+	};
+};
+
+&gpio1 {
+	status = "okay";
+};
+
+&gmac0 {
+	status = "okay";
+	phy-mode = "rgmii";
+	phy-handle = <&phy0>;
+
+	max-frame-size = <9000>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+		phy0: ethernet-phy@0 {
+			reg = <4>;
+
+			txd0-skew-ps = <0>; /* -420ps */
+			txd1-skew-ps = <0>; /* -420ps */
+			txd2-skew-ps = <0>; /* -420ps */
+			txd3-skew-ps = <0>; /* -420ps */
+			rxd0-skew-ps = <420>; /* 0ps */
+			rxd1-skew-ps = <420>; /* 0ps */
+			rxd2-skew-ps = <420>; /* 0ps */
+			rxd3-skew-ps = <420>; /* 0ps */
+			txen-skew-ps = <0>; /* -420ps */
+			txc-skew-ps = <900>; /* 0ps */
+			rxdv-skew-ps = <420>; /* 0ps */
+			rxc-skew-ps = <1680>; /* 780ps */
+		};
+	};
+};
+
+&mmc {
+	status = "okay";
+	cap-sd-highspeed;
+	broken-cd;
+	bus-width = <4>;
+	clk-phase-sd-hs = <0>, <135>;
+};
+
+&osc1 {
+	clock-frequency = <25000000>;
+	status = "okay";
+};
+
+&pcie_0_msi_irq {
+	status = "okay";
+};
+
+&pcie_0_pcie_aglx {
+	compatible = "altr,pcie-root-port-3.0-p-tile";
+	status = "okay";
+};
+
+&qspi {
+	status = "okay";
+	flash@0 {
+		compatible = "micron,mt25qu02g", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <100000000>;
+
+		m25p,fast-read;
+		cdns,read-delay = <2>;
+		cdns,tshsl-ns = <50>;
+		cdns,tsd2d-ns = <50>;
+		cdns,tchsh-ns = <4>;
+		cdns,tslch-ns = <4>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			qspi_boot: partition@0 {
+				label = "Boot and fpga data";
+				reg = <0x0 0x04200000>;
+			};
+
+			root: partition@4200000 {
+				label = "Root Filesystem - UBIFS";
+				reg = <0x04200000 0x0BE00000>;
+			};
+		};
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+	disable-over-current;
+};
+
+&watchdog0 {
+	status = "okay";
+};
-- 
2.34.1


