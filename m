Return-Path: <linux-pci+bounces-11549-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E8F94D328
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 17:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1683D1F23958
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 15:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F6F199389;
	Fri,  9 Aug 2024 15:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RQ26WB8m"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A6F19884D;
	Fri,  9 Aug 2024 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723216446; cv=none; b=pFTfDW0q2FkeLCo/vHD3/Au+9CBQN2x8DoIJTyLkk3sq66aX8Hd6kALr8Liun5idK2DFAdPFiBva6NXyI629cqjs4fMtYFTFpT5WiYfaN6eiwllnAmMGqpdI5OCUuIZHZvITaEQaDX0xO31XZQfRMPsc6B46DRilkzOlVSJgg0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723216446; c=relaxed/simple;
	bh=qvUWQkwJmRUXN+G/kJ1hSJKZ0bKGrK3pdK6NDsJPqK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WOwouVUtD26h7RYPqp+4D5UREDMfy4Z82xflCV9EdRGNgAm4n9jtRN4qTUF2cv7nWXC/1YkD0/wRRBcnU6vLY/TyxBeumj//JY1ffZdYnuKpgNIq+/jO5wk2S0uUMF6vNM+plmyOq4W3/qhPlocSJvyuoYQEpPg0pdOtJcMeeiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RQ26WB8m; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723216445; x=1754752445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qvUWQkwJmRUXN+G/kJ1hSJKZ0bKGrK3pdK6NDsJPqK0=;
  b=RQ26WB8m9s7fjlpUrXagm3nKYcGLRNqOIFUmc311K8k7WHQfwQzt7w+Q
   Sa8vp3bFnqj5/Dn1GwNutTUMyjB4zmFJTMNV6DPzlj7Zqoc+OJsdrety5
   hdoRNKHbO0UtJcee9kqxcSSiIkwqnlVfm+d1tZ7U5BrX03gtqoscs2aFx
   voQDd+r2FNFRdVvCZ6J/AuVn3PEwASmwCVGY/UdNiC1pkt5XBi55So+bu
   OUcXzzMXHSF30igznUAKHxh6ttubMph8lBQS983p+/beB6UM6RqVbmK6S
   GuSD0LVgPNbapNsPtFn9wLJMdgZ4qZycITvQqcyR7nQ3qWDci4VzfJ+FV
   A==;
X-CSE-ConnectionGUID: Pqg5lRnrTjGwkmzVOvMINg==
X-CSE-MsgGUID: wF9tWSd7R6eFB05DLMsprA==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="21368890"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="21368890"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 08:14:05 -0700
X-CSE-ConnectionGUID: 9xvmIFktQbm1fFWpSAE/2A==
X-CSE-MsgGUID: OTjUcCJgQt6WNr7TmSfHMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="57485971"
Received: from test2-linux-lab.an.intel.com ([10.122.105.166])
  by orviesa010.jf.intel.com with ESMTP; 09 Aug 2024 08:14:04 -0700
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
Subject: [PATCH v2 6/7] arm64: dts: agilex: add dts enabling PCIe Root Port
Date: Fri,  9 Aug 2024 10:12:12 -0500
Message-Id: <20240809151213.94533-7-matthew.gerlach@linux.intel.com>
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

Add a device tree enabling PCIe Root Port support on
an Agilex F-series Development Kit which has the
P-tile variant PCIe IP.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
 arch/arm64/boot/dts/intel/Makefile               |  1 +
 .../socfpga_agilex7f_socdk_pcie_root_port.dts    | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)
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
index 000000000000..76a989ba6a44
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier:     GPL-2.0
+/*
+ * Copyright (C) 2024, Intel Corporation
+ */
+
+#include "socfpga_agilex_socdk.dts"
+#include "socfpga_agilex_pcie_root_port.dtsi"
+
+&pcie_0_pcie_aglx {
+	status = "okay";
+	compatible = "altr,pcie-root-port-3.0-p-tile";
+};
+
+&pcie_0_msi_irq {
+	status = "okay";
+};
-- 
2.34.1


