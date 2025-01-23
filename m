Return-Path: <linux-pci+bounces-20297-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6542EA1A994
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 19:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D679188DEF3
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 18:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E7F1ADC67;
	Thu, 23 Jan 2025 18:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TwdYqWt6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DDF187859;
	Thu, 23 Jan 2025 18:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737656586; cv=none; b=kuSAsRLXnQv2NX+NZQTi9LybH0kuNFkAxIjtFBYeH+lUgNWhGdu/Yd7XgL7V8Jo171vQFi1NK/dxJmHbnBlV7HlS9CNXFTy0bNidbCGQkW9kQgDgFAOczUNTUp7Yb3mpVAIFI+2ZdftAs1dz+WSL3eox3ixiLZOEN1eHeDPQbm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737656586; c=relaxed/simple;
	bh=drh/z7zD0+60QnFsAarTd25/+YVNvVPBhmsNBAiGhzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WpVyyTt+YNwKlGxWiBtJ5WyTYMtyKUQvRhZFxk2rPt+XsULrJM02WqDQlOa7aJgJF+GhYnx/26sL1Stfu/d7/M3Tnx5aGtDe708LtEZ2rlufaN07s6XUDMGIfRRSgI4qh5HWwOyl2oQaGoVjOcdMkmXQnlM+WXxW6kBtv+pDczw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TwdYqWt6; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737656585; x=1769192585;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=drh/z7zD0+60QnFsAarTd25/+YVNvVPBhmsNBAiGhzE=;
  b=TwdYqWt6LsjMwLOBhcJsnGaCy4mlGjyMwUdLNEL5MjUK92YPkcVMrlIb
   eymg0N6Cbyb5F+xonScpDfO9V0oNj6wUP6zUyGaaOia++fjrSmbGO19G+
   W+fBFVEEUhxneKrXopXt5JHneZAizJjL/9grzQtfdO0VlqlJra+pkwpwi
   jdk+DptKIjFjL9ADEZAe0r7yQID8+tSCWKcHXyNpwr6ONwQPIF0LyVICt
   8eTWnarvjI0Qo4/L7P1ckPytqnkyos52OpvR4NS+T+sFvWhoYCrdNTG1u
   1ilgZz1SSL+EZUUoSKY9O5HWNBxSipwDQ/CdA6YQWY00AzuYZ4Mt7uMc4
   Q==;
X-CSE-ConnectionGUID: bg9HRrm6Q6KQIdlfmHp+HA==
X-CSE-MsgGUID: R4XvHf8YT0G0Qljljay0YA==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="49573254"
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="49573254"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 10:23:04 -0800
X-CSE-ConnectionGUID: xnrFRXH4TdaCi4W7OzmEvg==
X-CSE-MsgGUID: OhqhNaG3SbuWG+JqsLsGAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111574823"
Received: from test2-linux-lab.an.altera.com ([10.244.156.200])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 10:23:03 -0800
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
Subject: [PATCH v4 3/5] arm64: dts: agilex: add dtsi for PCIe Root Port
Date: Thu, 23 Jan 2025 12:19:30 -0600
Message-Id: <20250123181932.935870-4-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250123181932.935870-1-matthew.gerlach@linux.intel.com>
References: <20250123181932.935870-1-matthew.gerlach@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the base device tree for support of the PCIe Root Port
for the Agilex family of chips.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
v3:
 - Remove accepted patches from patch set.

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


