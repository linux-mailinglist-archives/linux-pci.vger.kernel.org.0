Return-Path: <linux-pci+bounces-11059-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1C9943246
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 16:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6617028515B
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 14:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833351BD036;
	Wed, 31 Jul 2024 14:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fZ/isEcX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07841BC080;
	Wed, 31 Jul 2024 14:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722436897; cv=none; b=H5GAF+DWBbp9pDnPY0xyjJS7CSWORDIPCDmydcSVnOOUNILYoYA4EyyzOaTa3RIlF9vxLd/kPGZifKjxc0JqZw3ItSzB40oT1KvwFZ9eNxIHJcsOpWejkswRcxSirfsNvWxS8ofwE4Hu1mXYSDSf4MK4+JRgiWj701Bq37+BvMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722436897; c=relaxed/simple;
	bh=/dL0oXsNLeOD9eKv13ITQFnENr5fkbxZgGJUEDxSCRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ASlF+8eWhzfmZW00aIh3ffpOwXfR52Y0nOq+QHiTqcxRiXObf7IXwob5pS0DYDinAW6Ok7m4oaA3XIFNCI0XlbO24Gu0O1gQXPrn1TYipf/dELGPf4Hwf81X/CDhNV+eR+McF7TWEp83F7kWiBfjdXCM/e2KPa4G5zZhua/DLvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fZ/isEcX; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722436896; x=1753972896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/dL0oXsNLeOD9eKv13ITQFnENr5fkbxZgGJUEDxSCRo=;
  b=fZ/isEcX5lEjm0nvxeBGozkjFGKfzP4TvAQ7uHj9RO70mjot5QT+iDtR
   Q/zaTPU15AVXPOtFrtTA2yb2EPwsBKwhWqgDlm0jXtPQkZaRQ/qD5bl63
   sXnd+bdw//8+83m8to7SdNXFU49E57FSmHRCUDHZ07p7tmOujEswXZZWo
   MRzrtxk8hyWL6SlNFXMxVvo99fMrinjURo30wap1wfYI9Bratg4VQuuoL
   fEkTIQuorqzcmCQzQhusxkRaW2sFaY5i4Jk81u19IoVNHlfCIwfPwdKFY
   HhECZS4HzFQO3T/0jykBIONjgMl9akTrqgawRO9GTzwtZ0G/3NP4Kk+4J
   Q==;
X-CSE-ConnectionGUID: KrpH+El3T42ekOA6YBGzHw==
X-CSE-MsgGUID: EV5r2rIPQe6pX8sJ+ZTPmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="20479831"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="20479831"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 07:41:27 -0700
X-CSE-ConnectionGUID: 2R3pJ+1KSyeP3d7Ja5V9Qg==
X-CSE-MsgGUID: L82t/IDSTYuzK26l2eyz6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="55295550"
Received: from test2-linux-lab.an.intel.com ([10.122.105.166])
  by orviesa007.jf.intel.com with ESMTP; 31 Jul 2024 07:41:26 -0700
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
Subject: [PATCH 5/7] arm64: dts: agilex: add dtsi for PCIe Root Port
Date: Wed, 31 Jul 2024 09:39:44 -0500
Message-Id: <20240731143946.3478057-6-matthew.gerlach@linux.intel.com>
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

Add the base device tree for support of the PCIe Root Port
for the Agilex family of chips.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
 .../intel/socfpga_agilex_pcie_root_port.dtsi  | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi
new file mode 100644
index 000000000000..510dcd1c2913
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier:     GPL-2.0
+/*
+ * Copyright (C) 2024, Intel Corporation
+ */
+&soc0 {
+	aglx_hps_bridges: bridge@80000000 {
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


