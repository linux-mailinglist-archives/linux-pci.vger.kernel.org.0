Return-Path: <linux-pci+bounces-20412-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCA9A1DB69
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 18:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF3E1663D2
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 17:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129BA18B476;
	Mon, 27 Jan 2025 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EXo0scUS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A36E186E26;
	Mon, 27 Jan 2025 17:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737999563; cv=none; b=uEeaPD5YMhUVxD81HCLEExTGLXYE4xIlPeGQ5si43IQ2M8V1KkXfaHV2SkRiMmvNwrg2wjc4rpYATyid60wqVlExkvK0ywZtM0yGqSgAA3vmJ1r3cknI3P0Kav9r2xrjR6mU/UxM5GAN9PSblL4RuMWTcvDUAlVS0wvM8OByNTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737999563; c=relaxed/simple;
	bh=vUl3BBblF1TpZhv6GejNg8E3VUJoE5Ss3qGOnHYq+yg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jtsTUUvDPlL/qhZWKS2TNRTESgfBGU8cEjW3Js0alrDbMEVeJF+tWY6KwxoMH5P2/GVOdYGikWabIOaXWJbNVT6PlSxaieb4axETf36sUWEbMJHL2fGSE6FH6ZKCM9P9tngquFCy+QsvfPU2jHeZkz/igIyGXaBqT+odwLrt2zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EXo0scUS; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737999561; x=1769535561;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vUl3BBblF1TpZhv6GejNg8E3VUJoE5Ss3qGOnHYq+yg=;
  b=EXo0scUSVRIPdQeLp5DrNqd1eI6xAE0ZOcHtFlfAgIluUhrfBfa8iIU2
   doeCoo9ATmb01FB1L/5vNvIU8RI4Rs1OHiqPq/Qz1hPbAaVA0+BpjucQC
   /QcJsYLt6VbCw+MgDwPpdy2Swwgdms3U3wLVo7bwn0CLmsUIRfmyrAM6x
   AuegvZzkq8cpHvETQcW3F4IVrRSaOkayY3bVnhlW4GgIMz34MYQHff95t
   hXXw5uw4NtMtXLoXuawKAXGBdqUVo5LjFv3EqQx5IVmVgY9bxI7UbpWbv
   zdOpgonIi36ffyxiP6pAlXqhUXA5kE4H/MjMcZAAGnMLlXOwlnHD6mROX
   Q==;
X-CSE-ConnectionGUID: GowW+wz5SRaZSrfAquZ6rA==
X-CSE-MsgGUID: ab+op6geTcmOlqP20KRZiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="26069464"
X-IronPort-AV: E=Sophos;i="6.13,239,1732608000"; 
   d="scan'208";a="26069464"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 09:39:20 -0800
X-CSE-ConnectionGUID: ln/ONh/aQbaIIl+GU7Zb1w==
X-CSE-MsgGUID: valmFYn6QiyBo2t3dMPTFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113124887"
Received: from test2-linux-lab.an.altera.com ([10.244.156.200])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 09:39:19 -0800
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
Subject: [PATCH v5 0/5] Add PCIe Root Port support for Agilex family of chips
Date: Mon, 27 Jan 2025 11:35:45 -0600
Message-Id: <20250127173550.1222427-1-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set adds PCIe Root Port support for the Agilex family of FPGA chips.
Version 3 of this patch set removes patches that have been accepted.

Patch 1:
  Add new compatible strings for the three variants of the Agilex PCIe controller IP.

Patch 2:
  Add a label to the soc@0 device tree node to be used by patch 3.

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
 drivers/pci/controller/pcie-altera.c          | 253 +++++++++++++++++-
 6 files changed, 326 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dts
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi

-- 
2.34.1


