Return-Path: <linux-pci+bounces-21163-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A510AA30F8E
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 16:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 884E0168331
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 15:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1478C255E22;
	Tue, 11 Feb 2025 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eiwITdDy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1CC253F00;
	Tue, 11 Feb 2025 15:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739287287; cv=none; b=B25fnNTccpETtL5Cc5XB2sXPDTMG00IGYx6OLruTh43Piisbg26RsK36XuNq0JjcT8Zp0j9gZCDWn0M17TSDGZA+ZvtZzT/g+7icna9qoC/rKAyxOlxuKHNcfE/p8DyrBirZn/rP7V7bbBoiU9N906h9rPm+M2I/a83KbYij258=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739287287; c=relaxed/simple;
	bh=UIt0fwEO/HX+h4BP4IKu9vIfPjxmkRM68dWnBx+trZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ILMU5ppW2YmG6oBvCcTGEy91u3DQNpiDxB26gqf3o6N6N1oVfhj8SjSsBeOt+KeYXXFr7TnPm/6xzhmcNS0e3sTF35ZbZ69tlNAYM9t+s4GoWNTueeqZcvwlRIiruu+Srx0D3azss7r8FjMA1P5CskZWGf5sI6Kc6vWXWW4D1c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eiwITdDy; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739287285; x=1770823285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UIt0fwEO/HX+h4BP4IKu9vIfPjxmkRM68dWnBx+trZ0=;
  b=eiwITdDysUg8AoIMlMX/jUPhkxse2TaLLdOpEHi5iY6JnYOYhaiDRAg3
   ijTW2DanA8x7934TMfTyk+FMgyj+1HLszy8YUPPbJ2CQ8hAeZxdDYwig5
   lIiGfcZbh2fmIjHKLqEseHJuqrUT0nCw1uI4ZC10h0mMqbb6HB7gHHr7l
   SbXoXW9yyFPGZdhs+7dAi0i36DcyVVL6t7XN8jAkvZlkTS3QBEQP02x4t
   /yKBEZvlmpm5Ygk8K+wo757QdJKZ1ki3IitfX3H8lMFhVZ8fGc9xhiyDF
   z9g/Am1wfNaO4wBwoEmG48Ljbb+sq4UeGbNxEGAMzj7bL0s2DkVhmnu0V
   g==;
X-CSE-ConnectionGUID: 1X+XvZBKSjOuMHBeeN7fKg==
X-CSE-MsgGUID: raKlpo9FTwiso/6jv/rNug==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="50548319"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="50548319"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 07:21:25 -0800
X-CSE-ConnectionGUID: 4QvvDpBISiKBiDuEZpBE6A==
X-CSE-MsgGUID: jGiK1WGhTC6q1rIxYfRm6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112392610"
Received: from test2-linux-lab.an.altera.com ([10.244.157.115])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 07:21:24 -0800
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
Subject: [PATCH v6 5/7] arm64: dts: agilex: add dtsi for PCIe Root Port
Date: Tue, 11 Feb 2025 09:17:23 -0600
Message-Id: <20250211151725.4133582-6-matthew.gerlach@linux.intel.com>
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

Add the base device tree for support of the PCIe Root Port
for the Agilex family of chips.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
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
index 000000000000..754ca7bdcc65
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
+		#interrupt-cells = <0x1>;
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


