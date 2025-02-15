Return-Path: <linux-pci+bounces-21547-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FC3A36F3D
	for <lists+linux-pci@lfdr.de>; Sat, 15 Feb 2025 16:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B2C77A4AEA
	for <lists+linux-pci@lfdr.de>; Sat, 15 Feb 2025 15:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008C31EDA31;
	Sat, 15 Feb 2025 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GKHdC1bp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D27F1EA7C5;
	Sat, 15 Feb 2025 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739635074; cv=none; b=FE5OhcfO0FXA+U3J5Assyk5PLzUSlPtQnCCcqcg5itnDqGV97ZKiTAX6+o+CF3GaTL/i9a8sOGsTTAi//Xkm1zEt799OiEM9nMxM4IGV5cnOgp0mZ+PVGNYa5OlMNd+xVYfdJaeqaAoQFqKUaAXX9ilp4RJYYRb9Fuje41droyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739635074; c=relaxed/simple;
	bh=eDNlZG/w9nCuNU8UVVXnccH+Z27uAz+eU6RX3mnrLBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gcbuThu/h1tlQf+kWeRVfx0cnxkbhLedOPdOG+9Ouzy38Dk563wGdz8YuBStjgNfXsqEMRdgpWf/S2OlAMSAYaOepA3NV62EfjlNbEn3/6pxBOGexAr1y0srjFexTV9C764omwBc/Vg7a7cdvjPPfnGmmvFNe8u2SI5B0OQUWtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GKHdC1bp; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739635073; x=1771171073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eDNlZG/w9nCuNU8UVVXnccH+Z27uAz+eU6RX3mnrLBo=;
  b=GKHdC1bpLvrbfFXuS1cB9E/uSJFEQEafdbOD2bvieesssUOzjHJI+MpW
   T2cv7fzAhMrPfpp3M5sAVRRwXqMKHOzlNcXOAmclToSfynCHkVu+iw/Np
   oC8RLLs6+Nz6LQVPXEDOO7ubJNrBxhKppKV8Zqe4WZXmwTX/4xr5txKMJ
   B0x6hxoO9JZIniQkISH5d0Ec0Lw2evZrQVzsPubYm/dipUrmDrbC9N3Bk
   HnGpllVgZ04rIbkYKhelWg9j/4mP7quKMXyrDDtg2A+4PFWQ6eD4fsIC9
   EZckJg6OojTpwWom8P5NCHYlkQbbf0MUGhMVOWIdDIzAitpV5a19+mYps
   w==;
X-CSE-ConnectionGUID: nhEg1OoRQo6IrDqgebq+Pg==
X-CSE-MsgGUID: RwmbDnwhT1qRfN949SZERQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40509957"
X-IronPort-AV: E=Sophos;i="6.13,289,1732608000"; 
   d="scan'208";a="40509957"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 07:57:53 -0800
X-CSE-ConnectionGUID: YVykTnQURTaFmf/CX3jZVQ==
X-CSE-MsgGUID: i4fGr/53Qky3SDro4iblrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,289,1732608000"; 
   d="scan'208";a="113701919"
Received: from test2-linux-lab.an.altera.com ([10.244.157.115])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 07:57:51 -0800
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
Subject: [PATCH v7 4/7] arm64: dts: agilex: move bus@80000000 to socfpga_agilex.dtsi
Date: Sat, 15 Feb 2025 09:53:56 -0600
Message-Id: <20250215155359.321513-5-matthew.gerlach@linux.intel.com>
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

The bus from HPS to the FPGA is part of the SoC. Move its
device tree node to socfpga_agilex.dtsi to allow it to be
referenced by any board.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
v7:
 - Fix sorting of nodes.

v6:
 - New patch to series.
---
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 10 +++++++
 .../boot/dts/intel/socfpga_agilex_n6000.dts   | 30 +++++++------------
 2 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
index 202b4404577e..3f4fb9cb312f 100644
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
index 55f825c5245f..62d2b3febbdd 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
@@ -25,26 +25,22 @@ memory@80000000 {
 		/* We expect the bootloader to fill in the reg */
 		reg = <0 0x80000000 0 0>;
 	};
+};
 
-	soc@0 {
-		bus@80000000 {
-			compatible = "simple-bus";
-			reg = <0x80000000 0x60000000>,
-				<0xf9000000 0x00100000>;
-			reg-names = "axi_h2f", "axi_h2f_lw";
-			#address-cells = <2>;
-			#size-cells = <1>;
-			ranges = <0x00000000 0x00000000 0xf9000000 0x00001000>;
+&bus80000000 {
+	ranges = <0x00000000 0x00000000 0xf9000000 0x00001000>;
 
-			dma-controller@0 {
-				compatible = "intel,hps-copy-engine";
-				reg = <0x00000000 0x00000000 0x00001000>;
-				#dma-cells = <1>;
-			};
-		};
+	dma-controller@0 {
+		compatible = "intel,hps-copy-engine";
+		reg = <0x00000000 0x00000000 0x00001000>;
+		#dma-cells = <1>;
 	};
 };
 
+&fpga_mgr {
+	status = "disabled";
+};
+
 &osc1 {
 	clock-frequency = <25000000>;
 	status = "okay";
@@ -61,7 +57,3 @@ &uart1 {
 &watchdog0 {
 	status = "okay";
 };
-
-&fpga_mgr {
-	status = "disabled";
-};
-- 
2.34.1


