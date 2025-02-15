Return-Path: <linux-pci+bounces-21549-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32559A36F42
	for <lists+linux-pci@lfdr.de>; Sat, 15 Feb 2025 16:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF0977A4E91
	for <lists+linux-pci@lfdr.de>; Sat, 15 Feb 2025 15:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D161FCCE4;
	Sat, 15 Feb 2025 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VchDE+x+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D5A1F416B;
	Sat, 15 Feb 2025 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739635077; cv=none; b=bue7jvdOGyClcT+N3J/Ao3BYWCq0eeULXXMnEf2s3GWTh0/8ucwKs/5iglhvH/okw4ALNbtkq/AQYEs0ZOwtbciykrH4KXm35qQ+bnCTfak+cRZnbx+oi1Iw3cWgrdVboomdfs2LzCEAlHCG4rxjHrtnZPNGp/0miPnjEU2W1sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739635077; c=relaxed/simple;
	bh=WHVAhLhb6jxB0hu1HnI6PqUfMWvrSJAYVCixxlrsUDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hpF9Yy6GBmk2q+SOol7A4C1DbojHt+YE3U6fxrqLsdocPoTIKwQE/AMgBkZ2dOHhYmAuU6UiR264s4p68rm3b4+Qt+KSiosbOlQk+ll3XPzfq2aHdAt3s4/QWAbyW7NRUrcGHdVJdugktlOMaRv9MallLRz+RR1/zvheaHCeUXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VchDE+x+; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739635075; x=1771171075;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WHVAhLhb6jxB0hu1HnI6PqUfMWvrSJAYVCixxlrsUDs=;
  b=VchDE+x+J42ZUpeSmkJWmVfSPnU0dJwzmPF47vuPSFUO47Nt1RHgugNp
   /cmSt1iTe2B+dDYnas/IJnJzF1jE3k3lYZM9KgqW4oY++8/ouHBMXGg4N
   OdGAseiHxsFGzZrNmC3qzWNBIFXm7UXyU0PDpo22+6FGMjyWguYirxhZV
   eHp5bOEGnw2Ibw+JI4bw2eXsuuikE49Rnn/eOWmZ3EdUiTOW6KHjomOvd
   uskC0ZxvyHhOrtbkDeXXwr29gtNNtN606tHjjC07SBCFSfGPSuPK0x9w0
   l9mTVbYFq8c7G++reU1d8+3looxflt34VSXZ+N/6bRNeAuC0Xn0jvdZnD
   w==;
X-CSE-ConnectionGUID: JUSIgAtvQcyAUnuiEFmopA==
X-CSE-MsgGUID: MbdP87HjQMmOy/JEE8A/cA==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40509964"
X-IronPort-AV: E=Sophos;i="6.13,289,1732608000"; 
   d="scan'208";a="40509964"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 07:57:55 -0800
X-CSE-ConnectionGUID: zZ7+15htQ4yO41Lufo/uwQ==
X-CSE-MsgGUID: CJdna+DkQliDJhCmI8psjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,289,1732608000"; 
   d="scan'208";a="113701923"
Received: from test2-linux-lab.an.altera.com ([10.244.157.115])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 07:57:53 -0800
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
Subject: [PATCH v7 5/7] arm64: dts: agilex: add dtsi for PCIe Root Port
Date: Sat, 15 Feb 2025 09:53:57 -0600
Message-Id: <20250215155359.321513-6-matthew.gerlach@linux.intel.com>
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

Add the base device tree for support of the PCIe Root Port
for the Agilex family of chips.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
v7:
 - Change value of #interrupt-cells to decimal.

v6:
 - Reference bus80000000 in socfpga_agilex.dtsi
 - Change values of #address-cells, #size-cell, and num-vectors to decimal
 - Fix SPDX header.
 - Fix checkpatch.pl line length warning.
 - Fix "address format error" from dtschema check.

v3:
 - Remove accepted patches from patch set.

v2:
 - Rename node to fix schema check error.
---
 .../intel/socfpga_agilex_pcie_root_port.dtsi  | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi
new file mode 100644
index 000000000000..5333bd3fe535
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024, Intel Corporation
+ */
+&bus80000000 {
+	ranges = <0x00000000 0x00000000 0x80000000 0x00040000>,
+		 <0x00000000 0x10000000 0x90100000 0x0ff00000>,
+		 <0x00000000 0x20000000 0xa0000000 0x00200000>,
+		 <0x00000001 0x00010000 0xf9010000 0x00008000>,
+		 <0x00000001 0x00018000 0xf9018000 0x00000080>,
+		 <0x00000001 0x00018080 0xf9018080 0x00000010>;
+
+	pcie_0_pcie_aglx: pcie@10000000 {
+		reg = <0x00000000 0x10000000 0x10000000>,
+		      <0x00000001 0x00010000 0x00008000>,
+		      <0x00000000 0x20000000 0x00200000>;
+		reg-names = "Txs", "Cra", "Hip";
+		interrupt-parent = <&intc>;
+		interrupts = <GIC_SPI 0x14 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		device_type = "pci";
+		bus-range = <0x0000000 0x000000ff>;
+		ranges = <0x82000000 0x00000000 0x00100000 0x00000000
+			  0x10000000 0x00000000 0x0ff00000>;
+		msi-parent = <&pcie_0_msi_irq>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+		interrupt-map = <0x0 0x0 0x0 0x1 &pcie_0_pcie_aglx 0 0 0 0x1>,
+				<0x0 0x0 0x0 0x2 &pcie_0_pcie_aglx 0 0 0 0x2>,
+				<0x0 0x0 0x0 0x3 &pcie_0_pcie_aglx 0 0 0 0x3>,
+				<0x0 0x0 0x0 0x4 &pcie_0_pcie_aglx 0 0 0 0x4>;
+		status = "disabled";
+	};
+
+	pcie_0_msi_irq: msi@100018080 {
+		compatible = "altr,msi-1.0";
+		reg = <0x00000001 0x00018080 0x00000010>,
+		      <0x00000001 0x00018000 0x00000080>;
+		reg-names = "csr", "vector_slave";
+		interrupt-parent = <&intc>;
+		interrupts = <GIC_SPI 0x13 IRQ_TYPE_LEVEL_HIGH>;
+		msi-controller;
+		num-vectors = <32>;
+		status = "disabled";
+	};
+};
-- 
2.34.1


