Return-Path: <linux-pci+bounces-20294-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E3CA1A98C
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 19:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B3517A1648
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 18:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060BA14A4D1;
	Thu, 23 Jan 2025 18:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U95CNjgz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672E615746B;
	Thu, 23 Jan 2025 18:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737656583; cv=none; b=KM+w7sNAOE1yI0b+PEAFYjv13QktVrfjiianhobvGKEXxWR13flQ880AUSg4KvCSP330digcmj2xM7WOnbJi1eR+3dtlBpRC494qS/JI8mcNus+yyCkA6D/MKbZ+meut7TqPjRBn6WJI+cZaxX+CFvf9ugSoLVFDIEYFZYOcjx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737656583; c=relaxed/simple;
	bh=+vsdEJNW8UNjRvF7UCIpNPWK3eCwP5zuKBoxgzzvYBU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pouiQXCp1pUUkRPk3hLAxtPNfe7fXamTl9wuEqOmHfTQXQNpCwRGHdD48HCfZp+ekSdEbThLq88wKsRI49Wq7+TvTreXylEkJ3spD3rPvEiShHa7rtTXA58s/W8rrTufQ5EZJwGwGWp0fq5cmxeYO3eQJIWQxVWgLjlEl8M6E7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U95CNjgz; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737656583; x=1769192583;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+vsdEJNW8UNjRvF7UCIpNPWK3eCwP5zuKBoxgzzvYBU=;
  b=U95CNjgz7OaTSTGAPLZnNUjnupNSs0qcyIvsCcWPjYUXwaamlf8/t7Q+
   lOCeMaUV+7CFawWUQvPetmn6TzOAGB9Qaa6doCX7/wyp9Ri3GcnYeP7uY
   PNtSpeKwPvyfIIrFegAg60s0IvGQ9uFukEkVu4qLFw+gfgx6Xn7u4kxJA
   yAxfjFE8JhHnOeMzchBmDVKiHO9Q/Sdrl+JfLvzkP1pTzCB2whE2t/sRB
   pEMHjGjfP790vRlSgmYeUcBIR0hFRQ9m4qsGaZdfI9zVh2ePUg/LmyL22
   Q205gACcPPmzKUKCZov3bnCPLZq+gS16fwi6vZ7xsPI5tWMYEDpnSScS0
   g==;
X-CSE-ConnectionGUID: FbaVP699SlWKIvFwvLittQ==
X-CSE-MsgGUID: QexcVjVuRB+ZYp1GBRAfHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="49573232"
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="49573232"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 10:23:02 -0800
X-CSE-ConnectionGUID: Hb0NhblZS2q88NF00ARGww==
X-CSE-MsgGUID: Qg2w+YxHSJOYJNo700G6uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111574792"
Received: from test2-linux-lab.an.altera.com ([10.244.156.200])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 10:23:01 -0800
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
	peter.colberg@altera.com
Subject: [PATCH v4 0/5] Add PCIe Root Port support for Agilex family of chips
Date: Thu, 23 Jan 2025 12:19:27 -0600
Message-Id: <20250123181932.935870-1-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthew Gerlach <matthew.gerlach@altera.com>

This patch set adds PCIe Root Port support for the Agilex family of FPGA chips.
Version 3 of this patch set removes patches that have been accepted.

Patch 1:
  Add new compatible strings for the three variants of the Agilex PCIe controller IP.

Patch 2:
  Add a label to the soc@0 device tree node to be used by patch 5.

Patch 3:
  Add base dtsi for PCIe Root Port support of the Agilex family of chips.

Patch 4:
  Add dts enabling PCIe Root Port support on an Agilex F-series Development Kit.

Patch 5:
  Update Altera PCIe controller driver to support the Agilex family of chips.
D M, Sharath Kumar (1):
  PCI: altera: Add Agilex support

Matthew Gerlach (4):
  dt-bindings: PCI: altera: Add binding for Agilex
  arm64: dts: agilex: add soc0 label
  arm64: dts: agilex: add dtsi for PCIe Root Port
  arm64: dts: agilex: add dts enabling PCIe Root Port

 .../bindings/pci/altr,pcie-root-port.yaml     |   9 +
 arch/arm64/boot/dts/intel/Makefile            |   1 +
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi |   2 +-
 .../socfpga_agilex7f_socdk_pcie_root_port.dts |  16 ++
 .../intel/socfpga_agilex_pcie_root_port.dtsi  |  55 ++++
 drivers/pci/controller/pcie-altera.c          | 246 +++++++++++++++++-
 6 files changed, 319 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dts
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi

-- 
2.34.1


