Return-Path: <linux-pci+bounces-21164-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C63CA30F95
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 16:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970B11889537
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 15:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF886256C92;
	Tue, 11 Feb 2025 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RJCEKFxM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA9E253B78;
	Tue, 11 Feb 2025 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739287288; cv=none; b=Hu+3emQ721r4dPzDIhcce4c8TmkEfydsHMTIPrA4ADJE5D2PEs75aYbc+tVTJaIsnfpSqpwcObtVeHJYx/UgnYepZD8/zGhoRNcfMVVvz05UPWSAvb0pmMzQ/SzEYaOpQhXvCCBnJsaNjAhO40nZoDxapFiZ8tPhuRM/u/mgPDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739287288; c=relaxed/simple;
	bh=whnrhp73H+VhaPWDFcTOf6yMXEd0RGXlyLWFwNBNZVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L71sGt9tYUGvrTPUkniCi+PdEeo8peDYssFh1d2PXcNzDA7BuId9vWitQvwLQCy99VDEeWkIXIAGdBcUXzLxCfpVQ9iaNhkrnmE6vALU/yYQo753tUIy2/jyA0BKmWd0/7/7RPplQVGxJPqR4TEMvitc1MSDRjfH+XuPkHXFB7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RJCEKFxM; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739287287; x=1770823287;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=whnrhp73H+VhaPWDFcTOf6yMXEd0RGXlyLWFwNBNZVE=;
  b=RJCEKFxM6DUc9FALoKGy8eTMMXZIz+SGLqTWw0eNkirBVLxwDstBMtNm
   Jf1FY+5iQd+V7cJbDTiw5Apjy/EqqVSU8IKQHwgpMLZbPSqxeRveAjkO1
   p7wV61pIzxV0nmg2+5/esr7diSHoXi3VkQiQVniUun5LhGErgPm71dNG0
   opOOs3DyOfnq59CR1Sk6rXclkO9Ek2AxrU6O+m5Y7sNyYnzDuQpejbSSf
   u9Aj2h4QLoM6jmTz3p52LAq/VKOg0ufLJH2Yzivykt1lXkmtkWiliMr+6
   50MWhIuVC0e9/xusqvMvRmJTa1X1qdhqGlFf+NZ/sxitgsYMeWkU/A+Qv
   w==;
X-CSE-ConnectionGUID: ck0Ar001QwKXqMJsCzxi7A==
X-CSE-MsgGUID: oSgEXDGuQNiKnmgkxGfTXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="50548332"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="50548332"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 07:21:26 -0800
X-CSE-ConnectionGUID: QjHoD+ZpRLC49eSX2VtocQ==
X-CSE-MsgGUID: GsN33dXTSt6UX0cbJEshVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112392613"
Received: from test2-linux-lab.an.altera.com ([10.244.157.115])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 07:21:25 -0800
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
Subject: [PATCH v6 6/7] arm64: dts: agilex: add dts enabling PCIe Root Port
Date: Tue, 11 Feb 2025 09:17:24 -0600
Message-Id: <20250211151725.4133582-7-matthew.gerlach@linux.intel.com>
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

Add a device tree enabling PCIe Root Port support on an Agilex F-series
Development Kit which has the P-tile variant of the PCIe IP.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
v6:
 - Fix SPDX header.
 - Make compatible property first.
 - Fix comment line wrapping.
 - Don't include .dts.

v3:
 - Remove accepted patches from patch set.
---
 arch/arm64/boot/dts/intel/Makefile            |  1 +
 .../socfpga_agilex7f_socdk_pcie_root_port.dts | 87 +++++++++++++++++++
 2 files changed, 88 insertions(+)
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
index 000000000000..3588c845cf9c
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dts
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024, Intel Corporation
+ */
+
+#include "socfpga_agilex.dtsi"
+#include "socfpga_agilex_socdk.dtsi"
+#include "socfpga_agilex_pcie_root_port.dtsi"
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
+&pcie_0_pcie_aglx {
+	compatible = "altr,pcie-root-port-3.0-p-tile";
+	status = "okay";
+};
+
+&pcie_0_msi_irq {
+	status = "okay";
+};
-- 
2.34.1


