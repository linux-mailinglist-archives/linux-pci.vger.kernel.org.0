Return-Path: <linux-pci+bounces-21158-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8C1A30F80
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 16:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56F3C3A5B8B
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 15:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13408253B41;
	Tue, 11 Feb 2025 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DFN7UHBE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFA22528FD;
	Tue, 11 Feb 2025 15:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739287282; cv=none; b=TUiNCy2WiMvl4xfCPVwWiEsZPp5Tg/hiD83oRmFXbIr+jrVJGLb/AsYrBBZZTILQl+EpFi0EwogRdbmC6C3LEhXM432q3c1mxWzLUpxT+gurmvM9JVRLVxFb4i4hj1OF+NkEp7i0EcfsBig/NA86+WTMVQMCb4azLpwkdPxay9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739287282; c=relaxed/simple;
	bh=CGSwf25guNoWZMHrRvspLqfl9GXU5HCfs6tZNoQhsKY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kIduVT96/qIyf/rzcYnlUIf9iIqRX9Wj5VYjJWo+JD4m9CR99CpHIKXkYyEyKlgvi7OkuSHuvMIkz+aeThikTJXcvbNedDgv1xQm8L8FXk56k/2w1gj11MAiQyfhFxiBF+eAzNZC/JjT4a1YUtJYnLWgxW2XZkoubxVG+VxrEhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DFN7UHBE; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739287280; x=1770823280;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CGSwf25guNoWZMHrRvspLqfl9GXU5HCfs6tZNoQhsKY=;
  b=DFN7UHBEm+m8XTQD0f8nqV7SxOmCxupKUmG1epr/pQS7GSDfl5YsEaEw
   gfz6nrcYzPqBmjb4FX0hFudDneOrwyysUFVVBv/CcngX5tEonu1qBo9en
   7HZPhD2OIa5rCdby9oKLxTMVbqlnyJFBhfA9t72ii52F22hpm71HcD4KP
   UUm/o/3w1HF9fF/2qLiXsBo+3El8fUZ4UK+d/64k3uXH6Gpfe2dcjAICS
   /TCQzSn9+E7SJbpWmDKaa/dM6QIBIkFXMNt+ckJXhUBX11XYfLjJbuQJP
   RlYK9/eph4ch97psCxxXMKe8CP0OkJX1SewjRcTA56Qw3Y9ryLthekJJm
   Q==;
X-CSE-ConnectionGUID: aju0c5aSSh+b2tQ588Y5Cg==
X-CSE-MsgGUID: Boig6RSMROGONBdz8WzOyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="50548274"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="50548274"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 07:21:20 -0800
X-CSE-ConnectionGUID: y7x9n1ezTUijlkVCFAhA1g==
X-CSE-MsgGUID: PPxH6mulSayoFZuoPkqtNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112392589"
Received: from test2-linux-lab.an.altera.com ([10.244.157.115])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 07:21:18 -0800
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
Subject: [PATCH v6 0/7] Add PCIe Root Port support for Agilex family of chips
Date: Tue, 11 Feb 2025 09:17:18 -0600
Message-Id: <20250211151725.4133582-1-matthew.gerlach@linux.intel.com>
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
  Fix fixed-clock schema warnings in socfpga_agilex.dtsi before adding to it.

Patch 3:
  Move bus@80000000 dt node to socfpga_agilex.dtsi.

Patch 4:
  Refactor duplicate dts into dtsi.

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
  arm64: dts: agilex: Fix fixed-clock schema warnings
  arm64: dts: agilex: move bus@80000000 to socfpga_agilex.dtsi
  arm64: dts: agilex: refactor shared dts into dtsi
  arm64: dts: agilex: add dtsi for PCIe Root Port
  arm64: dts: agilex: add dts enabling PCIe Root Port

 .../bindings/pci/altr,pcie-root-port.yaml     |  10 +
 arch/arm64/boot/dts/intel/Makefile            |   1 +
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi |  14 +
 .../socfpga_agilex7f_socdk_pcie_root_port.dts |  87 ++++++
 .../boot/dts/intel/socfpga_agilex_n6000.dts   |  28 +-
 .../intel/socfpga_agilex_pcie_root_port.dtsi  |  48 ++++
 .../boot/dts/intel/socfpga_agilex_socdk.dts   |  62 +----
 .../boot/dts/intel/socfpga_agilex_socdk.dtsi  |  65 +++++
 .../dts/intel/socfpga_agilex_socdk_nand.dts   |  62 +----
 drivers/pci/controller/pcie-altera.c          | 253 +++++++++++++++++-
 10 files changed, 481 insertions(+), 149 deletions(-)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dts
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dtsi

-- 
2.34.1


