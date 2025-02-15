Return-Path: <linux-pci+bounces-21546-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7813A36F3A
	for <lists+linux-pci@lfdr.de>; Sat, 15 Feb 2025 16:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 143147A3F86
	for <lists+linux-pci@lfdr.de>; Sat, 15 Feb 2025 15:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086F41EA7E4;
	Sat, 15 Feb 2025 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SDYeA0F9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534081DFD9A;
	Sat, 15 Feb 2025 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739635073; cv=none; b=htNOdhN/gz7IUnPc1dA2IYzaAEUfyJXr0Okwapao4ZMClkPl1EYpqC4PJ4JShzG/JWeR9fxwu2jrxTW6Xim4WkP5ng6fgMDTxiW0Q7XL5Ifk0iqssqNc0oRtXkgXo6YEz0pWD/1z9Ig3374FOBRVJ/Hur+j0Hdh08Vvs1z6GkTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739635073; c=relaxed/simple;
	bh=RWi/vWFaxvT8Egn+ucUfKRSobJX2HcGQexcyQqrcyJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WIktn/5EnEoJ0Ymbf/7y8c3SdKxGuGs1rq0u/90zfDDxLfyRzgWAiLmybsTM71CSWGa/AdKeIEDogBQYXq/uHxFc/Q8sCH5TH9u+qX2T20jlpgBuBN9tejKut6aG4QYVew9/pwy4KZOcgdixJq9RLqm9aSa263qxnXwQ7hjJAzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SDYeA0F9; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739635072; x=1771171072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RWi/vWFaxvT8Egn+ucUfKRSobJX2HcGQexcyQqrcyJk=;
  b=SDYeA0F9PpL6P5uwqUum8PcTVYmmD6dHquhL9VVCgSPJn9wlYqDnHiDk
   t3ejQOT81eVDiHB1yIiovqLoVig2O6E4jfT5VKXqMuCA/mCBzWRygEWcy
   CHPDPCqbKh/yPTyOF4AK+2mc+00PnJ8SvXmftVrryg2RGdzy/N/ssAjYE
   rbDMNzWiKIfvXHA8aDgBdcLSeuH9Upjaysdmd4+hybjhN81it3yOkroEb
   sVxy3fgQ48oSvBH47vG2e+HzzxiQsBkT1G5z9nSZqyljAnlhiT5MH8iA3
   TQgIMyJKDmEbq83ZyoBIBQu+vltsklO+CyJl14HWxYgZLd3gJs+5V1a4l
   w==;
X-CSE-ConnectionGUID: BhSX06PVT5OcyXnSedOMYQ==
X-CSE-MsgGUID: zR6E6DXHS56Usgm9sRFBxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40509951"
X-IronPort-AV: E=Sophos;i="6.13,289,1732608000"; 
   d="scan'208";a="40509951"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 07:57:51 -0800
X-CSE-ConnectionGUID: SuJiZ2Y6TYipTRd+Yx0n0Q==
X-CSE-MsgGUID: SnVJaJEGQGKRUP/fQRjTPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,289,1732608000"; 
   d="scan'208";a="113701915"
Received: from test2-linux-lab.an.altera.com ([10.244.157.115])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 07:57:50 -0800
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
Subject: [PATCH v7 3/7] arm64: dts: agilex: Fix fixed-clock schema warnings
Date: Sat, 15 Feb 2025 09:53:55 -0600
Message-Id: <20250215155359.321513-4-matthew.gerlach@linux.intel.com>
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

All Agilex SoCs have the fixed-clocks defined in socfpga_agilex.dsti,
but the board specific DTS determines which fixed-clocks are actually
used and at what frequency. Fix the schema check warning about fixed-clock
nodes requiring a clock-frequency by disabling all the fixed-clocks in the
DTSI and enabling clocks used by a board in the board specific DTS.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
v7:
 - Disable fixed-clock in DTSI instead of setting clock-frequency = <0>;

v6:
 - New patch to series
---
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi           | 4 ++++
 arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts      | 1 +
 arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts      | 1 +
 arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts | 1 +
 4 files changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
index 1235ba5a9865..202b4404577e 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
@@ -114,21 +114,25 @@ clocks {
 		cb_intosc_hs_div2_clk: cb-intosc-hs-div2-clk {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
+			status = "disabled";
 		};
 
 		cb_intosc_ls_clk: cb-intosc-ls-clk {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
+			status = "disabled";
 		};
 
 		f2s_free_clk: f2s-free-clk {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
+			status = "disabled";
 		};
 
 		osc1: osc1 {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
+			status = "disabled";
 		};
 
 		qspi_clk: qspi-clk {
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
index d22de06e9839..55f825c5245f 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
@@ -47,6 +47,7 @@ dma-controller@0 {
 
 &osc1 {
 	clock-frequency = <25000000>;
+	status = "okay";
 };
 
 &uart0 {
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
index b31cfa6b802d..3337b19836af 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
@@ -88,6 +88,7 @@ &mmc {
 
 &osc1 {
 	clock-frequency = <25000000>;
+	status = "okay";
 };
 
 &uart0 {
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts
index 0f9020bd0c52..40be9eb41aab 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts
@@ -100,6 +100,7 @@ partition@200000 {
 
 &osc1 {
 	clock-frequency = <25000000>;
+	status = "okay";
 };
 
 &uart0 {
-- 
2.34.1


