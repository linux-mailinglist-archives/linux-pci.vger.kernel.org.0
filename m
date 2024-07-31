Return-Path: <linux-pci+bounces-11055-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 793AF943239
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 16:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ACC3281C69
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 14:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0971BBBFD;
	Wed, 31 Jul 2024 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cH1b+leP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB2D1BBBD3;
	Wed, 31 Jul 2024 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722436894; cv=none; b=ct7P/4FpswZJAc8fvqZdTZeGEiq2i4/ejlbtbbScJ/4jGaW1bThj/Yx0Hn/RhmVl1YGus2/mNYkjzJyW+37t9WuAH+NhFq/NIJY8o+T3kQ8bP0CrcxiT3nYRgDE4+AzycBAgqiUGyGxc2mHZhL9IKu9/IEuxDgU/cEolBFc+1EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722436894; c=relaxed/simple;
	bh=a6d9dkpDgRFGTxkNNcnx2adCgffjKzKz347yLU5nbIE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TE7lA0tp92AW0DfwYYKhnNLusVPZiS1tKSuNCbxWFiZMzd1YmLHHzO//9LK2Fe0hdCyFEWbUE2C+bvapumApFEJlJLB7mZRoQFNCkuqUi5UmIlefGIfHtAYY5+y9ezLWa93IY05yDr5qM3i1BO6oRtl2XCk5McwTE9+yH/gKbGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cH1b+leP; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722436893; x=1753972893;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a6d9dkpDgRFGTxkNNcnx2adCgffjKzKz347yLU5nbIE=;
  b=cH1b+lePJmwbmFpJJLPryPrY/Jr8WaoosD+EOGNJ/IDZRTM1rmKaYUrV
   RuzBQ9eGsxkDp5kG044nLRuIPpMieStRXRJ8zMGaehc836AzxAKd2I6xG
   MzZNXpHLHBSs+Hz3AMu++AOufCN1oOqJ1M/Prf4Sqjbd8XN2fahE2Q8Nd
   gHbBdMG9wwN4zLoOBpysEUyijg9elFWgFQf7yOtL4AbwJ0zmHSzfRW6WX
   mgRo3yeN3EMNIjQDwUc4Tdo3rf4mkJx83Sg+/EQNCwY7eGS7ftMz2iKxG
   hJ820o5XIQ/Cmhx+k35mceq8POE4fBnudqGEeWCHu+ckA7SNU4Hbfs0s7
   A==;
X-CSE-ConnectionGUID: yAMSmLrST3CXSs/iS1g2oA==
X-CSE-MsgGUID: jRrPMwgBS2G/fsz8rCVGeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="20479799"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="20479799"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 07:41:22 -0700
X-CSE-ConnectionGUID: l35uENETTZuSqeYZKaJ8NQ==
X-CSE-MsgGUID: IAgz6FMFQ++jt7b51wgCrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="55295528"
Received: from test2-linux-lab.an.intel.com ([10.122.105.166])
  by orviesa007.jf.intel.com with ESMTP; 31 Jul 2024 07:41:21 -0700
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
Subject: [PATCH 0/7] Add PCIe Root Port support for Agilex family of chips
Date: Wed, 31 Jul 2024 09:39:39 -0500
Message-Id: <20240731143946.3478057-1-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

This patch set adds PCIe Root Port support for the Agilex family of FPGA chips.
Patches 1 and 2 have been reviewed previously and individually on the mailing
list and are included here with their revision history and Reviewed-by: tags
for convenience and completeness.

Patch 1: 
  Convert text device tree binding for Altera Root Port PCIe controller to YAML.

Patch 2:
  Convert text device tree binding for Altera PCIe MSI controller to YAML.

Patch 3:
  Add new compatible strings for the three variants of the Agilex PCIe controller IP.

Patch 4:
  Add a label to the soc@0 device tree node to be used by patch 5.

Patch 5:
  Add base dtsi for PCIe Root Port support of the Agilex family of chips.

Patch 6:
  Add dts enabling PCIe Root Port support on an Agilex F-series Development Kit.

Patch 7:
  Update Altera PCIe controller driver to support the Agilex family of chips.

D M, Sharath Kumar (1):
  pci: controller: pcie-altera: Add support for Agilex

Matthew Gerlach (6):
  dt-bindings: PCI: altera: Convert to YAML
  dt-bindings: PCI: altera: msi: Convert to YAML
  dt-bindings: PCI: altera: Add binding for Agilex
  arm64: dts: agilex: add soc0 label
  arm64: dts: agilex: add dtsi for PCIe Root Port
  arm64: dts: agilex: add dts enabling PCIe Root Port

 .../bindings/pci/altera-pcie-msi.txt          |  27 --
 .../devicetree/bindings/pci/altera-pcie.txt   |  50 ----
 .../bindings/pci/altr,msi-controller.yaml     |  65 +++++
 .../bindings/pci/altr,pcie-root-port.yaml     | 123 +++++++++
 MAINTAINERS                                   |   4 +-
 arch/arm64/boot/dts/intel/Makefile            |   1 +
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi |   2 +-
 .../socfpga_agilex7f_socdk_pcie_root_port.dts |  16 ++
 .../intel/socfpga_agilex_pcie_root_port.dtsi  |  55 ++++
 drivers/pci/controller/pcie-altera.c          | 260 ++++++++++++++++--
 10 files changed, 507 insertions(+), 96 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/altera-pcie-msi.txt
 delete mode 100644 Documentation/devicetree/bindings/pci/altera-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/altr,msi-controller.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dts
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi

-- 
2.34.1


