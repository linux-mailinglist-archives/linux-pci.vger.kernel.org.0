Return-Path: <linux-pci+bounces-21162-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A3FA30F91
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 16:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557BF3A8D10
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 15:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F37F254AE7;
	Tue, 11 Feb 2025 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NlG5G2lm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369BC253B5C;
	Tue, 11 Feb 2025 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739287286; cv=none; b=V3HyjdRNPOq+5N8sm9xLl85hVuZgv2PYDoL9UyeApItqRi20rtVIaRGrPKaKL5ZVT1HsdtvwYOvBP5d6MHbGJL+PofPndSj1hUUodX0v0+1S0b+0+0KIYdEGjaxNlt+6NM8Ap6Y45BnXvWc5g8gOBWK+W4D0cduuOQqmDiAccgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739287286; c=relaxed/simple;
	bh=lcjC45mewXt8omcJSo1g9ACO7k/9DDp9bYtwdZpLvvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QVT7QI1iiYRX9fJ6uW7eYjQJ3eaVvOwJ/U1Klki4pmC7ixtf3oKWP/q+ttOpOV0jgTaF5fdM7EoVVwBSix1snqO+lBpQEGdFCme7dcEpzzetaoL8dYt63Dddps4lzr3+LeQixGy7BtgjYCp0hjdtMiJbuzDQqGkYmU58d5Ci7Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NlG5G2lm; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739287284; x=1770823284;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lcjC45mewXt8omcJSo1g9ACO7k/9DDp9bYtwdZpLvvw=;
  b=NlG5G2lmllxLojHWele84F5WhFI7xXQ3nxAzDCNoqv9iclq/gh0Fq2dA
   jTq4iZRNsGls/DH8Xsy/TIv5sb8CZb/jnuv4OCHbrluonONtc6GC/1gdB
   GyGyofy7jP96wa09PKv0ECQkOXlR8XW2QKNBDe7sKHWT1pVB5mjkJmN+a
   8LsLqDFrMcV+Mq9rMXwNtTwMF5ak6bQwO6/NYYKT+7kyATv6npx/0dS13
   BXEIsXCGsuUEAuvdjc9AmwZABhY+BqfQiiFJff0+K1QZvqsAUgPmWiWfz
   j/O4yeszwPkSp1h6FoJSpdRqgjk+JohB/NGykLQqfp0nx60dOG2EitGaO
   A==;
X-CSE-ConnectionGUID: jnaJ5m3uS2S+lZzqPhmhFA==
X-CSE-MsgGUID: zamVVb03RZKpPhk+C6a0ug==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="50548306"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="50548306"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 07:21:24 -0800
X-CSE-ConnectionGUID: k1gy9mJZS2ON+ze5KZN/hA==
X-CSE-MsgGUID: KPlMkBMzTUaO3tJ9PmhsUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112392605"
Received: from test2-linux-lab.an.altera.com ([10.244.157.115])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 07:21:23 -0800
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
Subject: [PATCH v6 4/7] arm64: dts: agilex: refactor shared dts into dtsi
Date: Tue, 11 Feb 2025 09:17:22 -0600
Message-Id: <20250211151725.4133582-5-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211151725.4133582-1-matthew.gerlach@linux.intel.com>
References: <20250211151725.4133582-1-matthew.gerlach@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move common device tree from socfpga_agilex_socdk*.dts to
socfpga_agilex_socdk.dtsi.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
 ---
 v6:
  - New patch to series.
---
 .../boot/dts/intel/socfpga_agilex_socdk.dts   | 62 +-----------------
 .../boot/dts/intel/socfpga_agilex_socdk.dtsi  | 65 +++++++++++++++++++
 .../dts/intel/socfpga_agilex_socdk_nand.dts   | 62 +-----------------
 3 files changed, 67 insertions(+), 122 deletions(-)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dtsi

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
index b31cfa6b802d..a970f612333a 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
@@ -3,50 +3,7 @@
  * Copyright (C) 2019, Intel Corporation
  */
 #include "socfpga_agilex.dtsi"
-
-/ {
-	model = "SoCFPGA Agilex SoCDK";
-	compatible = "intel,socfpga-agilex-socdk", "intel,socfpga-agilex";
-
-	aliases {
-		serial0 = &uart0;
-		ethernet0 = &gmac0;
-		ethernet1 = &gmac1;
-		ethernet2 = &gmac2;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	leds {
-		compatible = "gpio-leds";
-		led0 {
-			label = "hps_led0";
-			gpios = <&portb 20 GPIO_ACTIVE_HIGH>;
-		};
-
-		led1 {
-			label = "hps_led1";
-			gpios = <&portb 19 GPIO_ACTIVE_HIGH>;
-		};
-
-		led2 {
-			label = "hps_led2";
-			gpios = <&portb 21 GPIO_ACTIVE_HIGH>;
-		};
-	};
-
-	memory@80000000 {
-		device_type = "memory";
-		/* We expect the bootloader to fill in the reg */
-		reg = <0 0x80000000 0 0>;
-	};
-};
-
-&gpio1 {
-	status = "okay";
-};
+#include "socfpga_agilex_socdk.dtsi"
 
 &gmac0 {
 	status = "okay";
@@ -86,23 +43,6 @@ &mmc {
 	clk-phase-sd-hs = <0>, <135>;
 };
 
-&osc1 {
-	clock-frequency = <25000000>;
-};
-
-&uart0 {
-	status = "okay";
-};
-
-&usb0 {
-	status = "okay";
-	disable-over-current;
-};
-
-&watchdog0 {
-	status = "okay";
-};
-
 &qspi {
 	status = "okay";
 	flash@0 {
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dtsi
new file mode 100644
index 000000000000..e0f3ff60aa33
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dtsi
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier:     GPL-2.0
+/*
+ * Copyright (C) 2019, Intel Corporation
+ */
+
+/ {
+	model = "SoCFPGA Agilex SoCDK";
+	compatible = "intel,socfpga-agilex-socdk", "intel,socfpga-agilex";
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
+&osc1 {
+	clock-frequency = <25000000>;
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
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts
index 0f9020bd0c52..53a533cd2789 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts
@@ -3,50 +3,7 @@
  * Copyright (C) 2019, Intel Corporation
  */
 #include "socfpga_agilex.dtsi"
-
-/ {
-	model = "SoCFPGA Agilex SoCDK";
-	compatible = "intel,socfpga-agilex-socdk", "intel,socfpga-agilex";
-
-	aliases {
-		serial0 = &uart0;
-		ethernet0 = &gmac0;
-		ethernet1 = &gmac1;
-		ethernet2 = &gmac2;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	leds {
-		compatible = "gpio-leds";
-		led0 {
-			label = "hps_led0";
-			gpios = <&portb 20 GPIO_ACTIVE_HIGH>;
-		};
-
-		led1 {
-			label = "hps_led1";
-			gpios = <&portb 19 GPIO_ACTIVE_HIGH>;
-		};
-
-		led2 {
-			label = "hps_led2";
-			gpios = <&portb 21 GPIO_ACTIVE_HIGH>;
-		};
-	};
-
-	memory@80000000 {
-		device_type = "memory";
-		/* We expect the bootloader to fill in the reg */
-		reg = <0 0x80000000 0 0>;
-	};
-};
-
-&gpio1 {
-	status = "okay";
-};
+#include "socfpga_agilex_socdk.dtsi"
 
 &gmac2 {
 	status = "okay";
@@ -97,20 +54,3 @@ partition@200000 {
 		};
 	};
 };
-
-&osc1 {
-	clock-frequency = <25000000>;
-};
-
-&uart0 {
-	status = "okay";
-};
-
-&usb0 {
-	status = "okay";
-	disable-over-current;
-};
-
-&watchdog0 {
-	status = "okay";
-};
-- 
2.34.1


