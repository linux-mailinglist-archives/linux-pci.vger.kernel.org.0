Return-Path: <linux-pci+bounces-19554-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F850A062EB
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 18:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D947116870C
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 17:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E460E201269;
	Wed,  8 Jan 2025 17:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SUuPbWpq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C18A201259;
	Wed,  8 Jan 2025 17:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736355756; cv=none; b=EJoo5U7g0CiZ+uwoSVtqyepjJm2JPfdE/G8IsqPz6Z8IHBE1I1fbnZ9azjSpCwgDSPGou47bL7tXYt0UU5mUQgFBZG7M10xjl96P9HONIMjiA7xszJnENKwMnHsGkMOrdFsSgCQlBOyNZVuhL4a7jqDWxn5k5oklgzKwysWfe9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736355756; c=relaxed/simple;
	bh=Hbf+5ElbtpwItI2lqbfKRdUPei/cVr9Ds6K6YdIZmCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LNGFLWmUcktWOFMtTt2Sr9Ec3J0Ilapl1xo5dWQo8qxMet+ARMXPNiW4TXh6FMrqdsNBACOksy1RD7FfV9296tGXMc0Gm0Nm+lnYIyAufxPTQVpYQBR6vsLj40wKrs4LInyhqYFF3DtdtQHO2os+Gi71GvmtY2J/LAVf63Uorik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SUuPbWpq; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736355755; x=1767891755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hbf+5ElbtpwItI2lqbfKRdUPei/cVr9Ds6K6YdIZmCM=;
  b=SUuPbWpqWpXeVkqhoVGvjR2fz7nklA/ZFG0NYAZ1ApXnxmgRSeF7gEgg
   wh3q1yTn4T/lWA2JB6CrmVcpy1seynGEaJuPqTZBMWn8HX2PVkHWcTgTt
   bK4vIHOwWqcZjipng53g2VKkFRJfn4L+rAPBBYHYIExpuoozI/4xRHHwU
   WdlLc4K28XaLNlxhlGIObQqfHqiwGuYDWn/VdxJcEQnV5rpjwXfrMp5eu
   yIvRnToXCW0cwFymVbHjOmq+ipXE4zUBigj/jUJ3IaCou10lI+t/0LpTq
   6vw1OzxpgNzkcQf3JWC1frsloiRWZ06bb4b0bciK08zn6gN1mnCzQ/3zU
   Q==;
X-CSE-ConnectionGUID: xeFxysa3Sz6HUCCxk38b5A==
X-CSE-MsgGUID: nKQTx2xxQiKAqojaq/lxPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="35882098"
X-IronPort-AV: E=Sophos;i="6.12,298,1728975600"; 
   d="scan'208";a="35882098"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 09:02:32 -0800
X-CSE-ConnectionGUID: hZqgHVv8QW6ZWYw9h5H7pA==
X-CSE-MsgGUID: bDX0HatvSNikj0gcJM1cTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108255858"
Received: from test2-linux-lab.an.altera.com ([10.244.156.200])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 09:02:31 -0800
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
Subject: [PATCH v3 4/5] arm64: dts: agilex: add dts enabling PCIe Root Port
Date: Wed,  8 Jan 2025 10:59:08 -0600
Message-Id: <20250108165909.3344354-5-matthew.gerlach@linux.intel.com>
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


