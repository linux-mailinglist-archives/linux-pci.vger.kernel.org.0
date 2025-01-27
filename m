Return-Path: <linux-pci+bounces-20416-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E447BA1DB75
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 18:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADC6F3A87A6
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 17:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B585A1925A0;
	Mon, 27 Jan 2025 17:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CMHkUQCf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED8A18DF7C;
	Mon, 27 Jan 2025 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737999566; cv=none; b=bBdCKstgrszkNpPskvYmYvLxzLkoSxlk0thqLPyLNjS7ID2B0APngdvsZSyU9DpflKXjqsUbVImmem/3JxfH+fRXEUOprA0S1WtA6PHvZZJ2vwAQvY/gJTqFNneQeQfnHkv+zFSBjYQAggB7AaNgZ313qjdc3EAhtIxaaJkaqXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737999566; c=relaxed/simple;
	bh=Hbf+5ElbtpwItI2lqbfKRdUPei/cVr9Ds6K6YdIZmCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jakv62AxxPNX4OoWnGy+t7kfGhVvwPLpOweNJRYWHVDOqPOr/lziOgW8Slqgy5K2BDoZmocqkENn2T9sFYR4xdmWByLwWtDNvqgJ8iW5cLmxwXbxkCRpZlOCtnsmNgsyvJY+xN2+V2Ion2WQ9ynDE3TeWWeiqHRzHIifw/mL+VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CMHkUQCf; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737999565; x=1769535565;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hbf+5ElbtpwItI2lqbfKRdUPei/cVr9Ds6K6YdIZmCM=;
  b=CMHkUQCfxslOPdD6pn14FvxM7nL/FhopNlj1P6z8tXiGmj6fnMBHyJsY
   LKZ50O4GTZo8Fv1Hp/KPTghFrViDEDkSbKf7Ub3Nn1QE4aKl+e0twsskA
   mtTkR1/nCNBvBnhsCfptO9eHKjsYSdji+l2qxtm76wHwb2ZBsYmpGSwJh
   RodTICiTZ4ZPXnJSPwAC5fW4h0HnJdN9CjDcB7E7gxEWAR74qdnj6znu6
   iPt6kFcSNdn4vpPt+LM8P9FXDNWjSUTv64t08a7imO10Q/DBb2Xx5D+nf
   PGbeFAZ525Sl1FxKznz/LxzRwlYmQEe1WXYhvMtCG/JzqH5hgNd76/FRD
   A==;
X-CSE-ConnectionGUID: bbd3JxiSRcGrzUjcEd43SQ==
X-CSE-MsgGUID: biy4emelQtWyraqW40w7VA==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="26069491"
X-IronPort-AV: E=Sophos;i="6.13,239,1732608000"; 
   d="scan'208";a="26069491"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 09:39:23 -0800
X-CSE-ConnectionGUID: S2+oxvnMR2235uM3I78JKA==
X-CSE-MsgGUID: WZaw1X1xRTWx+b6moUisEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113124915"
Received: from test2-linux-lab.an.altera.com ([10.244.156.200])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 09:39:22 -0800
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
Subject: [PATCH v5 4/5] arm64: dts: agilex: add dts enabling PCIe Root Port
Date: Mon, 27 Jan 2025 11:35:49 -0600
Message-Id: <20250127173550.1222427-5-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250127173550.1222427-1-matthew.gerlach@linux.intel.com>
References: <20250127173550.1222427-1-matthew.gerlach@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a device tree enabling PCIe Root Port support on
an Agilex F-series Development Kit which has the
P-tile variant PCIe IP.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
v3:
 - Remove accepted patches from patch set.
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


