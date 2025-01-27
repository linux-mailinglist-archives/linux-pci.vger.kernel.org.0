Return-Path: <linux-pci+bounces-20415-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FDAA1DB73
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 18:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3500F1669FD
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 17:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2871917D9;
	Mon, 27 Jan 2025 17:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ts3vVJFF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5993C18CBFC;
	Mon, 27 Jan 2025 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737999566; cv=none; b=aur1A8LUTiMq7cJva9cpafNhP8FYZlOW375AV5t5k5zD9YR9JvnAndgIf5V7ZejYOSy6cJoAlT5bdoFrD7LWHvT9wUT1MCL110ps45V4cxNtHBeui5gWpWxEr/oSm1pZS05tNhCzCUDaDD4CO4trjZdK7AsNv/Ze9EtmoaC7u18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737999566; c=relaxed/simple;
	bh=drh/z7zD0+60QnFsAarTd25/+YVNvVPBhmsNBAiGhzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BT0/E2ZGbJxKihZAej9Nt3c92AWtA6h3PrHzV0YVpMqV/fmNIEv4l8gy7yeIAwXGNTJ25p2k8cC2C62Lf6snaCxtLeLVcBN4AfAtn7z++eS1pQxtEB3WIY2Xp+Rfbece42LTMphF1lfz84Vzocf7oiyjjrTNZUtv76JFJrVtuXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ts3vVJFF; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737999564; x=1769535564;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=drh/z7zD0+60QnFsAarTd25/+YVNvVPBhmsNBAiGhzE=;
  b=Ts3vVJFFYlw9a92t+9rm1laI18wtBdI00BV3pIkz8G7gw/pxmHVHAO3u
   lhPSa/FGmf7RNqiD/9hxnZPyW0aAcZ0u2UV+fFgGTpNjAoFJkwi7QPEvP
   qeDX4J9bBcziCveaoOwbMt5Ok6E05JIj0Bngn6y3qWtmUE3RP4IQNnnny
   pEZXnm5+XTt+n6BJk3/5SGChYfDfu8W7GVAel+b0hh1N0yP/FH7PkXpIt
   77kdOcsVW2enKpC+PFmxl/WEXN0cewtrMh+2ReolnM2yNlH8l8D3wzjZj
   Qeov9mkkrUVl5Wz+DsCHzZAiYk9LKM5fUyGeyEy6RkJB6luSZq30Xmsaf
   A==;
X-CSE-ConnectionGUID: HYk+CV4rQKm2mPn06uVWiA==
X-CSE-MsgGUID: 9LDFJT7iRhy2SqosMxOrnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="26069485"
X-IronPort-AV: E=Sophos;i="6.13,239,1732608000"; 
   d="scan'208";a="26069485"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 09:39:23 -0800
X-CSE-ConnectionGUID: WxxciDePQaqGtyJ5+Vg/Gg==
X-CSE-MsgGUID: kQxnzb5lSh6vCgjQj027QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113124911"
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
Subject: [PATCH v5 3/5] arm64: dts: agilex: add dtsi for PCIe Root Port
Date: Mon, 27 Jan 2025 11:35:48 -0600
Message-Id: <20250127173550.1222427-4-matthew.gerlach@linux.intel.com>
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


