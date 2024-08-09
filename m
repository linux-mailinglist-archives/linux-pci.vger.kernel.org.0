Return-Path: <linux-pci+bounces-11543-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1412194D316
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 17:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A9FFB21208
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 15:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265E919884C;
	Fri,  9 Aug 2024 15:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fh5fYrpd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F368197A98;
	Fri,  9 Aug 2024 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723216439; cv=none; b=e7CsiZ9Xq6mb+P5/+zT3q7k47SS9GOMeNhfHEeLhCRRxujQk+qmfgxU3sLsSlHJBpw2jM4l+wdn31THpmKrO97Li6ewOUwJk5iAjUPLE9H9gxxvNF4cglRnkdtQx3QCi6ggcVIcaR35LqJVmpAoTBG8Ocdpf1oftwZ/kslVC46E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723216439; c=relaxed/simple;
	bh=D+pasby3J1PHqwqxgv+stEbpUy6ZzK+yu1bVwENWPQU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QKiubQoCFo1+ykLAL7VblCv4kyAn8kP570ANM9jORYfxUYh3rYEn6B2cPlzxsvd3O2BrNho1fgwyjLi7/PXW1TpUoUoDR+UYQmWzftNcegl71MGeY7ZGSos4ix0jWVe8LyCZ7oERwvF/f9QfkCAOnpe/DUmMX5jgC6PQ3/hRcVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fh5fYrpd; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723216438; x=1754752438;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D+pasby3J1PHqwqxgv+stEbpUy6ZzK+yu1bVwENWPQU=;
  b=fh5fYrpdnJ4Q+SWra19WQKjycqxiEmZOn7zbwumMjp+ohEIrIFfj1iQ/
   2a5tw8g+NT4O6zyRJW7+8tq+DLZbo4K09cfTqyagURA4b8IfYEuHyBn8Z
   MnqRNq9Z+kV+LAm/pQ2yFl5x25ePIhbqJ6IOYDTYoHRztWbU1Uvf0bNOr
   jN6gK43el/gNuD9nRxH6r3Zy+1gfIbKLuuQIDZPXjaCkLrvSqAqrgPFyG
   XrQF5dnO4nAseq3VPGgcV/dViZgeVjUUN/FVbskxEupzkh6LmecZuYERh
   6N/mVnOlJIyZqgHkDvSUdcHt/9rvKyUPJXPX3TTCBFaHjrbxlmarosgtO
   A==;
X-CSE-ConnectionGUID: K2ZbecpPRtCs6qgbAngcmw==
X-CSE-MsgGUID: EGIx6IFJS2KhV+SmlEupug==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="21368854"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="21368854"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 08:13:57 -0700
X-CSE-ConnectionGUID: XVzNPc3bTQKj1bqhDHWuyQ==
X-CSE-MsgGUID: LPxKuIqaSkK4t3EiEThIGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="57485945"
Received: from test2-linux-lab.an.intel.com ([10.122.105.166])
  by orviesa010.jf.intel.com with ESMTP; 09 Aug 2024 08:13:56 -0700
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
Subject: [PATCH v2 0/7] Add PCIe Root Port support for Agilex family of chips
Date: Fri,  9 Aug 2024 10:12:06 -0500
Message-Id: <20240809151213.94533-1-matthew.gerlach@linux.intel.com>
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
  No change from previous submission.

Patch 2:
  Convert text device tree binding for Altera PCIe MSI controller to YAML.
  No change from previous submission.

Patch 3:
  Add new compatible strings for the three variants of the Agilex PCIe controller IP.
  Added Reviewed-by: tag.

Patch 4:
  Add a label to the soc@0 device tree node to be used by patch 5.
  No change from previous submission.

Patch 5:
  Add base dtsi for PCIe Root Port support of the Agilex family of chips.
  Rename node name to fix device tree schema check error.

Patch 6:
  Add dts enabling PCIe Root Port support on an Agilex F-series Development Kit.
  No change from previous submission.

Patch 7:
  Update Altera PCIe controller driver to support the Agilex family of chips.
  Address feedback from Bjorn Helgaas <helgaas@kernel.org>.

D M, Sharath Kumar (1):
  PCI: altera: Add Agilex support

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
 drivers/pci/controller/pcie-altera.c          | 246 +++++++++++++++++-
 10 files changed, 500 insertions(+), 89 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/altera-pcie-msi.txt
 delete mode 100644 Documentation/devicetree/bindings/pci/altera-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/altr,msi-controller.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dts
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi

-- 
2.34.1


