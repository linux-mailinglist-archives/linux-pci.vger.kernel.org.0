Return-Path: <linux-pci+bounces-20298-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33529A1A997
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 19:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D296516AF9F
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 18:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBD51B4132;
	Thu, 23 Jan 2025 18:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YLnBEVTZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3002318453E;
	Thu, 23 Jan 2025 18:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737656588; cv=none; b=dWnyKi2eM27DRtDSM+bihY0bsR3lYHW6FSWQ3//BpV5rJAAgPqkg7W1pjc8M8iQ2LdUdh1d5jW0RJiqJuFwc1fp/PJINfsbQ95ic7fY1EuKDOF0Q5sLF7iOd8KCh3hEJy0Vs+KYVRlPi3NxBrmcWUW0GXMIgudXyCharQXqIRw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737656588; c=relaxed/simple;
	bh=Hbf+5ElbtpwItI2lqbfKRdUPei/cVr9Ds6K6YdIZmCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R7YXs4Q1nP8rspNAPvFH5mPcqtsjKAWcodHR2eE/169eh0BUwQdikTIvAJLzdqJmnz3gqVC2T61NAx5r9oKXhbf1IqIg2OK5iSl8NwNAQwXy8mvOay2jlF/ul0ll8LJucmEgYKvcm0LS+1lM5pQaRvYfrfSz3Sb34UJeZy+JTI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YLnBEVTZ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737656585; x=1769192585;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hbf+5ElbtpwItI2lqbfKRdUPei/cVr9Ds6K6YdIZmCM=;
  b=YLnBEVTZIoiHuPjzpMKgv1pV5Ezq8DcvQaaf9fT65SCQCixXEgwH2HDO
   A16TOxe79DaKwH+7fVArWIgIuDd2AMWhsZ+n1/bCKTPccKSygLbq/M6AG
   80ccouaPYuN1ZMq4wyLGlsA7ZfvmpZgP7eH4HJe0BJPj5oW/NiQWObxkn
   9J00DSno8LL94a0XkLlQCxzsRayLIGbGQ7I00pHUwPO4WVa9rc4voQ62r
   SM/Sc4ePthbpZu7sT0k4J6tMEPtkJD/6zWqCQacqQH6GpmwuTlwTQJWbH
   DIkvZzJamJQwYtXfPNA+sQca/LI7kx2RscvNWvdYOkopiu4Ehzao2z3/+
   Q==;
X-CSE-ConnectionGUID: 93imPO1QTSSQtC05MqJH3g==
X-CSE-MsgGUID: jpZJL6FHSQ2YAfiqT0Ht4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="49573264"
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="49573264"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 10:23:05 -0800
X-CSE-ConnectionGUID: OzAi1EeuSEidNUt1l8CfaA==
X-CSE-MsgGUID: IMlHBfiIR2ecYo4cOmxXcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111574830"
Received: from test2-linux-lab.an.altera.com ([10.244.156.200])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 10:23:04 -0800
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
Subject: [PATCH v4 4/5] arm64: dts: agilex: add dts enabling PCIe Root Port
Date: Thu, 23 Jan 2025 12:19:31 -0600
Message-Id: <20250123181932.935870-5-matthew.gerlach@linux.intel.com>
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


