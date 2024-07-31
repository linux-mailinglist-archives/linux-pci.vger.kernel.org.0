Return-Path: <linux-pci+bounces-11060-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EA1943248
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 16:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D53EFB24742
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 14:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C691BD4E1;
	Wed, 31 Jul 2024 14:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RPWICLp1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075B11BC08C;
	Wed, 31 Jul 2024 14:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722436897; cv=none; b=D+AZyVZW+kZCRwf9E9deaB84AKpm3WaqS4Pzcnb3Cm2t6rVymXzTnOyFhuXmSDE4BUyJx/6dM/kHHY2HEa+WOrVMr0RYiIdfUMorT9r5xObUa0kkx+JPlq4xYu+khcjsjqzS5eIYAkzQvt2mSAGxQzs+svPTtmdynQrp8Zgoi60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722436897; c=relaxed/simple;
	bh=qvUWQkwJmRUXN+G/kJ1hSJKZ0bKGrK3pdK6NDsJPqK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BBurMKlAQifjEA/UZm8H//V1EUQwDvym2Fb5ADZARQFokQyzAbZZDsICYPPQwnQQSLap7Mp6mosOmbETBCUP0fOdADWPTpNCIVUPTk4p8/1uvYpj0R/ViyAkojnjQkkdWDnkQxPIB6iHeWXvRQfnMxlcZf8rbVVnxKVBVemMN8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RPWICLp1; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722436896; x=1753972896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qvUWQkwJmRUXN+G/kJ1hSJKZ0bKGrK3pdK6NDsJPqK0=;
  b=RPWICLp1ovxSCl8QHoTa/LJ2lf+xUk4IFEmsemQ1VnEJ9pi+viDLPIEP
   qKsNY3b0ZOfUkcH0U/pmDCzrT6T0uzhQfP7A65z1z60q6npfPTU4Vjvrm
   HiAe2wUYLJQ0eOb8Qv52bSMig573/P8NHan1SDi93obNA/j68OMpZ+iVj
   PlqzhB4bBaFPNRCLBkcBMsxr3FdWkR3uCnvZfr0es5nDCaaAddR4idXn5
   tw+6ZeCKpAJ9WsshWxPCGo5UkhOS4vekHcvxKi+UDEt55E7gSE+j85m6n
   DNhNFYZw3NOYeioHz2o87W/Oe+t7moHd2eb0TMqpF4nFiV4cV/OT1L1Yp
   Q==;
X-CSE-ConnectionGUID: I0ixF8sSRKm2iBoZcXAhig==
X-CSE-MsgGUID: iC2UCe//T0+A18YJqmmfXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="20479837"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="20479837"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 07:41:28 -0700
X-CSE-ConnectionGUID: +3Wd0yIDTv6FLYXTQeyB6Q==
X-CSE-MsgGUID: OsFSjWbuT7ODbwuHzirRKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="55295554"
Received: from test2-linux-lab.an.intel.com ([10.122.105.166])
  by orviesa007.jf.intel.com with ESMTP; 31 Jul 2024 07:41:27 -0700
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
Subject: [PATCH 6/7] arm64: dts: agilex: add dts enabling PCIe Root Port
Date: Wed, 31 Jul 2024 09:39:45 -0500
Message-Id: <20240731143946.3478057-7-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731143946.3478057-1-matthew.gerlach@linux.intel.com>
References: <20240731143946.3478057-1-matthew.gerlach@linux.intel.com>
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


