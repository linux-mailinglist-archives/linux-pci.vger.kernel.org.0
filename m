Return-Path: <linux-pci+bounces-19553-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E482A062E5
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 18:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD173188A1B0
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 17:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4823E20102E;
	Wed,  8 Jan 2025 17:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B0ELkMwr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C9F200120;
	Wed,  8 Jan 2025 17:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736355753; cv=none; b=Mw2TKcHAFmZXZJSOqXKSSkq9CFBWcWx5ueOVec7GK1Ao2hjoMlFiTZ7Y2KseMTJs2KL535dN0EAA3mt366V8esThPMYdJ7lxSJronqDLjwxzg+5nxmhEPUYCw2Q7uGnaoXq/LrmtjGZMW00Zi4SD3x1eTNHcPvYIBkgfou/n1Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736355753; c=relaxed/simple;
	bh=drh/z7zD0+60QnFsAarTd25/+YVNvVPBhmsNBAiGhzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D7ttAsfLM4s1UsfC/jQK27ASg+Kt7ZTsZDPrKIo2Yim1tCEOCyOUBPRr8G/P5jbLH8NzsPJfuJ+K0MmtKjYyza6jLHTSzNF12H1ifFxHFyVmwhPROaVvipdNp4Iw71ibqdOzzr/Q3ZrShBFlswAz8xN3Udl7eE1rPnIFf+w6/os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B0ELkMwr; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736355752; x=1767891752;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=drh/z7zD0+60QnFsAarTd25/+YVNvVPBhmsNBAiGhzE=;
  b=B0ELkMwrjjaF/qsII6cg++CU/0QiNfuCQGm8vLvkLyOwA5xNFPDEzOVb
   NGJJBmu/BJaSnC0eQQZ7FAQCDZd/6Uf0gCjmkqkHCPRAG8xAuWSE/EHK6
   R9KswuOvUiaWE3Y2GSct7w0HL1g64yxWKsWr99AEzOR2KS9XNYzDQ6/U0
   esHjGWPhPA+VQYED0vea1KEZOe9T+Scn1tskQruljms4tWhJQH1l784Je
   7b4JrwNKig2bmdQsdIsFRVCTC4F5DY+md5t2EI7BRKfA+IpT5S6Liw4ck
   lJyYhWv2wZCysoYqeRZ+OkkqZ1K9j07mrmEr9Vk9w3wZ4s6oIPCMpp+PD
   Q==;
X-CSE-ConnectionGUID: hKIXVlp5Q/ezbjTIhyqJJQ==
X-CSE-MsgGUID: Z+jOIHa3TEyavDCAjxRzPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="35882088"
X-IronPort-AV: E=Sophos;i="6.12,298,1728975600"; 
   d="scan'208";a="35882088"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 09:02:31 -0800
X-CSE-ConnectionGUID: GOpCGP1rS0Kymde+qcaKUw==
X-CSE-MsgGUID: blRCYMpZQIyuhREvENwxEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108255846"
Received: from test2-linux-lab.an.altera.com ([10.244.156.200])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 09:02:29 -0800
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
	Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v3 3/5] arm64: dts: agilex: add dtsi for PCIe Root Port
Date: Wed,  8 Jan 2025 10:59:07 -0600
Message-Id: <20250108165909.3344354-4-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250108165909.3344354-1-matthew.gerlach@linux.intel.com>
References: <20250108165909.3344354-1-matthew.gerlach@linux.intel.com>
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


