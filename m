Return-Path: <linux-pci+bounces-21161-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE83A30F88
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 16:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A372188869D
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 15:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E9D253F09;
	Tue, 11 Feb 2025 15:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JLyT9ZaD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85490253B51;
	Tue, 11 Feb 2025 15:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739287285; cv=none; b=hcDyVe3axyFGLenxTWM45gQuei6G0lle93vuJ1S91IhJ8f/hr7boTVOmHJ9KtBehkPbm6eEAQuQCT4X8fa6HBp8vXnRttsi8i/EjCaweVfuW1cGG+Z02MTMgPGIKN+Lw9v/WUIGiUioKghb/2blSJmDJmXAyI9cNeE4sZ6HLDPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739287285; c=relaxed/simple;
	bh=ctTq5BRLs+o9FnBtFUZnUQS/ChX580fupR6zXcS++y0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dt33GRah2zM5ovNu1WonhTULllvgW5kOeniaQmh2DDS8DT0S6LWPUAkpi+FFuveXCXsuYr7kgqBdGIo/Z2l2HlGh9ydPSzoar933TEQX29CO/fyJmPMUfDQZZwP6mHY0cWhe5dmpwZmm1OsOirGcCEOYV0xsM7cOvbhIeRtrakw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JLyT9ZaD; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739287284; x=1770823284;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ctTq5BRLs+o9FnBtFUZnUQS/ChX580fupR6zXcS++y0=;
  b=JLyT9ZaDC2REkG1+aL09luv8QtbGFIqLWPKiK261PuA8py5gAOYaoGx0
   YpAl/yKHUY0vqcENbqrL6jA73PPtgjGdAcTrXJfHx8c7B0i4xvIcOtDK4
   cuzfHxFMWay3AbZQ6SMeEqQ1keOjuXhEVe1zljMMAkf+s7Jp0QpwFZsal
   R8xVMclGAeishkXbhz24KW0skcABmqslUOX0zVNwKpzY7v2DAnEZnWJ1s
   UKQynG+82GALWXSFVSEYgwzQDQKr3SctMPKLOapbTccrmX90NWuo019Fk
   YnkqtIVGLXi6/SGlzZkfvz4u1fayefrZCr4aKrI/o9Ppbh5y0e2316coN
   g==;
X-CSE-ConnectionGUID: IwvLqR0BS6OHgTOnN80KZQ==
X-CSE-MsgGUID: r447q/laQJ6sjIihBJgMPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="50548296"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="50548296"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 07:21:23 -0800
X-CSE-ConnectionGUID: kHRRItJ4QUGSJ9LuUW7Icg==
X-CSE-MsgGUID: y5N60rCIT2+o9J3/hgus8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112392601"
Received: from test2-linux-lab.an.altera.com ([10.244.157.115])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 07:21:22 -0800
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
Subject: [PATCH v6 3/7] arm64: dts: agilex: move bus@80000000 to socfpga_agilex.dtsi
Date: Tue, 11 Feb 2025 09:17:21 -0600
Message-Id: <20250211151725.4133582-4-matthew.gerlach@linux.intel.com>
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

The bus from HPS to the FPGA is part of the SoC. Move its
device tree node to socfpga_agilex.dtsi to allow it to be
referenced by any board.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
v6:
 - New patch to series.
---
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 10 +++++++
 .../boot/dts/intel/socfpga_agilex_n6000.dts   | 28 +++++++------------
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
index 42cb24cfa6da..26ccdf042281 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
@@ -678,5 +678,15 @@ qspi: spi@ff8d2000 {
 
 			status = "disabled";
 		};
+
+		bus80000000: bus@80000000 {
+			compatible = "simple-bus";
+			reg = <0x80000000 0x60000000>,
+			      <0xf9000000 0x00100000>;
+			reg-names = "axi_h2f", "axi_h2f_lw";
+			#address-cells = <2>;
+			#size-cells = <1>;
+			ranges = <0x00000000 0x00000000 0x00000000 0x00000000>;
+		};
 	};
 };
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
index d22de06e9839..350c040ce9fe 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
@@ -25,24 +25,6 @@ memory@80000000 {
 		/* We expect the bootloader to fill in the reg */
 		reg = <0 0x80000000 0 0>;
 	};
-
-	soc@0 {
-		bus@80000000 {
-			compatible = "simple-bus";
-			reg = <0x80000000 0x60000000>,
-				<0xf9000000 0x00100000>;
-			reg-names = "axi_h2f", "axi_h2f_lw";
-			#address-cells = <2>;
-			#size-cells = <1>;
-			ranges = <0x00000000 0x00000000 0xf9000000 0x00001000>;
-
-			dma-controller@0 {
-				compatible = "intel,hps-copy-engine";
-				reg = <0x00000000 0x00000000 0x00001000>;
-				#dma-cells = <1>;
-			};
-		};
-	};
 };
 
 &osc1 {
@@ -64,3 +46,13 @@ &watchdog0 {
 &fpga_mgr {
 	status = "disabled";
 };
+
+&bus80000000 {
+	ranges = <0x00000000 0x00000000 0xf9000000 0x00001000>;
+
+	dma-controller@0 {
+		compatible = "intel,hps-copy-engine";
+		reg = <0x00000000 0x00000000 0x00001000>;
+		#dma-cells = <1>;
+	};
+};
-- 
2.34.1


