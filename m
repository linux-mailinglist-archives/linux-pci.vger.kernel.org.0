Return-Path: <linux-pci+bounces-11548-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BA294D325
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 17:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 538A42833F1
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 15:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925F8199239;
	Fri,  9 Aug 2024 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AXC1B1xw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4A51991B1;
	Fri,  9 Aug 2024 15:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723216445; cv=none; b=ZZMbZI5iR0ZBryGaXzR7O7FASec9jvy9NUcSRLKg394Fjib1/9DZ0A2dntZCFylx9v8qwqc3U/7Aat5tcHLCw4rgYr+7vfAT6z7V8lxYCC0HqHJOWQ12Gd60hl4BXQYcRCAl/hj2Bb3cu9AEXkwfVNJG384Yn7RFtyW1t2EFBwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723216445; c=relaxed/simple;
	bh=pyCHX0eHmXM+xHEr4bbrhtQTxmEVPLXG3e5xq8xkcVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FlH5mawmnDbwGrz3SP6FESxc1cPw+pttZ79x/iBKH2+YpGgWWtdFyhiNdiCaai1MSk2IMxHMQiexUBwd6l1/xy48+CigCJqSw9u/sU6UFgsXx5X8JoD81nWBfP7SL0w66OJ0OsoRlarBb7E9Q1EVkj666eFWhnNVTzNFqLn4ecE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AXC1B1xw; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723216444; x=1754752444;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pyCHX0eHmXM+xHEr4bbrhtQTxmEVPLXG3e5xq8xkcVw=;
  b=AXC1B1xwxRe0OqOV/VDPiiBmWWqF4Lh5tJXQq0zTRdINnC5LA/QY8SVq
   oe42D5fDw8VXVnepRuYqd9w01nGFjzYyFY8PkprkJ5illtJaRKlsZqRLY
   tNseoPLDyKAQkO3xh4z2RSa62rkRXx+kqVEmWpdSOD5YpRbpw6nA4kBSt
   sIWzIMeeNHOlg0MP4y9nebqiy8x0NGJ5hOQAojS5PEb7ySeZZM+MRFm23
   B/9KYpa5f/MOsgNIef4vxcxufEl0ZR6yyDNln+aguLOROEvPk9K5EWzor
   o1rEcKFnZ4BRw16nFpuToBn9YWNQ/2g+g/WOT7lZjvdhpOlHRJZuvL0uL
   Q==;
X-CSE-ConnectionGUID: v0NCl1k4QtKRVXKUlyfXSQ==
X-CSE-MsgGUID: oLesjH3UTkqfXXW3OBDj5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="21368883"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="21368883"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 08:14:04 -0700
X-CSE-ConnectionGUID: mz0NPJmKR4SOG9fFpEGAUQ==
X-CSE-MsgGUID: bNCPxOqGS4+Q6yIwG74HfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="57485966"
Received: from test2-linux-lab.an.intel.com ([10.122.105.166])
  by orviesa010.jf.intel.com with ESMTP; 09 Aug 2024 08:14:03 -0700
From: matthew.gerlach@linux.intel.com
To: lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	joyce.ooi@intel.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v2 5/7] arm64: dts: agilex: add dtsi for PCIe Root Port
Date: Fri,  9 Aug 2024 10:12:11 -0500
Message-Id: <20240809151213.94533-6-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809151213.94533-1-matthew.gerlach@linux.intel.com>
References: <20240809151213.94533-1-matthew.gerlach@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Add the base device tree for support of the PCIe Root Port
for the Agilex family of chips.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
v2:
 - Rename node to fix schema check error.
---
 .../intel/socfpga_agilex_pcie_root_port.dtsi  | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi
new file mode 100644
index 000000000000..50f131f5791b
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier:     GPL-2.0
+/*
+ * Copyright (C) 2024, Intel Corporation
+ */
+&soc0 {
+	aglx_hps_bridges: fpga-bus@80000000 {
+		compatible = "simple-bus";
+		reg = <0x80000000 0x20200000>,
+		      <0xf9000000 0x00100000>;
+		reg-names = "axi_h2f", "axi_h2f_lw";
+		#address-cells = <0x2>;
+		#size-cells = <0x1>;
+		ranges = <0x00000000 0x00000000 0x80000000 0x00040000>,
+			 <0x00000000 0x10000000 0x90100000 0x0ff00000>,
+			 <0x00000000 0x20000000 0xa0000000 0x00200000>,
+			 <0x00000001 0x00010000 0xf9010000 0x00008000>,
+			 <0x00000001 0x00018000 0xf9018000 0x00000080>,
+			 <0x00000001 0x00018080 0xf9018080 0x00000010>;
+
+		pcie_0_pcie_aglx: pcie@200000000 {
+			reg = <0x00000000 0x10000000 0x10000000>,
+			      <0x00000001 0x00010000 0x00008000>,
+			      <0x00000000 0x20000000 0x00200000>;
+			reg-names = "Txs", "Cra", "Hip";
+			interrupt-parent = <&intc>;
+			interrupts = <GIC_SPI 0x14 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <0x1>;
+			device_type = "pci";
+			bus-range = <0x0000000 0x000000ff>;
+			ranges = <0x82000000 0x00000000 0x00100000 0x00000000 0x10000000 0x00000000 0x0ff00000>;
+			msi-parent = <&pcie_0_msi_irq>;
+			#address-cells = <0x3>;
+			#size-cells = <0x2>;
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+			interrupt-map = <0x0 0x0 0x0 0x1 &pcie_0_pcie_aglx 0 0 0 0x1>,
+					<0x0 0x0 0x0 0x2 &pcie_0_pcie_aglx 0 0 0 0x2>,
+					<0x0 0x0 0x0 0x3 &pcie_0_pcie_aglx 0 0 0 0x3>,
+					<0x0 0x0 0x0 0x4 &pcie_0_pcie_aglx 0 0 0 0x4>;
+			status = "disabled";
+		};
+
+		pcie_0_msi_irq: msi@10008080 {
+			compatible = "altr,msi-1.0";
+			reg = <0x00000001 0x00018080 0x00000010>,
+			      <0x00000001 0x00018000 0x00000080>;
+			reg-names = "csr", "vector_slave";
+			interrupt-parent = <&intc>;
+			interrupts = <GIC_SPI 0x13 IRQ_TYPE_LEVEL_HIGH>;
+			msi-controller;
+			num-vectors = <0x20>;
+			status = "disabled";
+		};
+	};
+};
-- 
2.34.1


