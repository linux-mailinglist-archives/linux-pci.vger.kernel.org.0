Return-Path: <linux-pci+bounces-21543-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49883A36F32
	for <lists+linux-pci@lfdr.de>; Sat, 15 Feb 2025 16:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE59A18925FC
	for <lists+linux-pci@lfdr.de>; Sat, 15 Feb 2025 15:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AF51DA11B;
	Sat, 15 Feb 2025 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sl+ZFgve"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6A3B672;
	Sat, 15 Feb 2025 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739635071; cv=none; b=pIFEdFi1xBXulJ2Xw+ARr//6RWMbLDJQqmLommNffpoXxqLNHR5+pZgkWfUjdXF80LybgJMBHIbZU+O+3n2nl7Cf0TD6y8cBGofjIsTqhZyP9n6NxD3aJC0Lk/uh2F23cH0Gzp9UjRrutqmsJvb7sXbet9fupL7U4XHF5ejNl3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739635071; c=relaxed/simple;
	bh=4cxnaIRCSk0B4fuAfPyf8j0yr6SHL5W0ftPhLQJviEA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oBL1I5Bxb934tRMOkvPmikF+FXkecEycj6/zzCS3PoLKK4l/qrdeRoYsnX3ws+1ZzYi1ZQzohBzwqAmKD77+YDA+SigGYWBhdgtyJq21iZoP/frzx+8geCOzEGVy+SWLdYKM3pXvYgdPS+ydI1eVAH1OUW2PBjnT0WNJjWwh8x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sl+ZFgve; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739635070; x=1771171070;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4cxnaIRCSk0B4fuAfPyf8j0yr6SHL5W0ftPhLQJviEA=;
  b=Sl+ZFgvefFggzCDZYC4B2JuxUwqVIZe5wzhNWcDjSz22FQDfs9STlx1f
   a72ts5sXxrAYEqjdLhCnS/olkD1fg//eNVlolLZ2y1cwK8EcpHZPpb4XR
   SZ23hUDZyjz+7UtaOCU9pB7ML/Zp50fNYYbkQwQ4drXSeF9bTbeTHJqOD
   kUvkOheKDwyUHtnaVIDhdnT4sQKyo70x2XU7bwxcY8svK0cmQ0qK8z5bn
   gAL+GnMwtuKzZ1r67jYcKfDVMENlK55DMPe+fWXjTCo2xC4VL70/osRLv
   /gKV2esDMB/zb4LwkuZTFATHBZ5CmFqjUk2nlqQkxdvYh3jgT/Vz5fY6u
   w==;
X-CSE-ConnectionGUID: pYOMkMHsQgKg/Y0yiA02/Q==
X-CSE-MsgGUID: 5biMeDMfTV2Ni50lffDAQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40509933"
X-IronPort-AV: E=Sophos;i="6.13,289,1732608000"; 
   d="scan'208";a="40509933"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 07:57:49 -0800
X-CSE-ConnectionGUID: lM3jTKIaRtOzDSJWrdCk6A==
X-CSE-MsgGUID: V5ucWNWxRk2CMrZhMptEXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,289,1732608000"; 
   d="scan'208";a="113701902"
Received: from test2-linux-lab.an.altera.com ([10.244.157.115])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 07:57:47 -0800
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
Subject: [PATCH v7 0/7] Add PCIe Root Port support for Agilex family of chips
Date: Sat, 15 Feb 2025 09:53:52 -0600
Message-Id: <20250215155359.321513-1-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set adds PCIe Root Port support for the Agilex family of FPGA chips.
Version 6 refactors duplicate dts snippets into dtsi's for correctness and
maintainability.

Patch 1:
  Add new compatible strings for the three variants of the Agilex PCIe controller IP.

Patch 2:
  Add new board compatible string for Agilex F-series devkit with PCIe Root Port.

Patch 3:
  Fix fixed-clock schema warnings in socfpga_agilex.dtsi before adding to it.

Patch 4:
  Move bus@80000000 dt node to socfpga_agilex.dtsi.

Patch 5:
  Add base dtsi for PCIe Root Port support of the Agilex family of chips.

Patch 6:
  Add dts enabling PCIe Root Port support on an Agilex F-series Development Kit.

Patch 7:
  Update Altera PCIe controller driver to support the Agilex family of chips.

D M, Sharath Kumar (1):
  PCI: altera: Add Agilex support

Matthew Gerlach (6):
  dt-bindings: PCI: altera: Add binding for Agilex
  dt-bindings: intel: document Agilex PCIe Root Port
  arm64: dts: agilex: Fix fixed-clock schema warnings
  arm64: dts: agilex: move bus@80000000 to socfpga_agilex.dtsi
  arm64: dts: agilex: add dtsi for PCIe Root Port
  arm64: dts: agilex: add dts enabling PCIe Root Port

 .../bindings/arm/intel,socfpga.yaml           |   1 +
 .../bindings/pci/altr,pcie-root-port.yaml     |  10 +
 arch/arm64/boot/dts/intel/Makefile            |   1 +
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi |  14 +
 .../socfpga_agilex7f_socdk_pcie_root_port.dts | 147 ++++++++++
 .../boot/dts/intel/socfpga_agilex_n6000.dts   |  31 +--
 .../intel/socfpga_agilex_pcie_root_port.dtsi  |  48 ++++
 .../boot/dts/intel/socfpga_agilex_socdk.dts   |   1 +
 .../dts/intel/socfpga_agilex_socdk_nand.dts   |   1 +
 drivers/pci/controller/pcie-altera.c          | 253 +++++++++++++++++-
 10 files changed, 479 insertions(+), 28 deletions(-)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dts
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi

-- 
2.34.1


