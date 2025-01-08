Return-Path: <linux-pci+bounces-19550-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF644A062DD
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 18:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A964B167C52
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 17:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730241FF1BB;
	Wed,  8 Jan 2025 17:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SxCghsmN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7962418D;
	Wed,  8 Jan 2025 17:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736355750; cv=none; b=cNCM6292PJPVgWGgYPPCYm4Ol3OgbKxeVms7tWraslaFC/cRjHXVY10TbkM+NSo5f/wKEGbkOZuW+vZzDBIzv49I6bUScEEWvzkdd1uV9sZvZ+P9NEXR0GBCTF6JFeS7Q2Y5LArY0h9GQvij4eDsu+vKXb+VNtbZGJLrG2gEy+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736355750; c=relaxed/simple;
	bh=UBJk50aqPFRsYCDE6I6ZQQ4Ca3AbJ9eF3VwQyfa2yYU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k8G/8DCExONQDVYuBNC0re9QLXwMk9czx5KtGFBfSxdguERQNf5ANb2UFkyPHE0bDW0IOH1woFXAMXnt0JSCX4UtTEgFnbqTDGovkMgOZK0SHuwqLky47xKmZ79AV/nAlyik80uSW8TkttoBw+PRbgJzyatsDqfRE6IVM3OqxNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SxCghsmN; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736355748; x=1767891748;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UBJk50aqPFRsYCDE6I6ZQQ4Ca3AbJ9eF3VwQyfa2yYU=;
  b=SxCghsmNm6sIPuSSsnWUflHShtQCYdxSJ0wWj+2OS0bC1khNbKG4Oqfd
   Xs88Psofrqds5LuFNTIf2CWMepvpl5uG0MMo8VTQ3CXJYrlbSeiQ4F+Uu
   jaYoWYUI0xYajvVJqSdqYWvjMy2Kqf7JA/9DSZ8cQ4nQGtBjNdO5fEe+u
   iXTGGmu6guZwZAml6cuI/kuPmK8qtYBBbxw/tg6H7+asmeSdrfRjfV5/B
   wwsmf38ya7mZ/dvfMhdSlDPtGPb9FJIkewrTK7L77k15KVuTXZgGj+zqo
   1B2IqsfjWqd+/kza7Ggj0CSxRuv5KReN9QQ2BgiTwOV3pLH9+1bRU/TYf
   A==;
X-CSE-ConnectionGUID: kzyLEHrvTf2IPnjJ7IFe0g==
X-CSE-MsgGUID: BWy/gjpbSXSmb9dYJE++Dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="35882059"
X-IronPort-AV: E=Sophos;i="6.12,298,1728975600"; 
   d="scan'208";a="35882059"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 09:02:26 -0800
X-CSE-ConnectionGUID: sZ7gosjmQFS8U/DC0xwvQQ==
X-CSE-MsgGUID: 5Ojd4IXjTdaZ2vsoDzZPPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108255814"
Received: from test2-linux-lab.an.altera.com ([10.244.156.200])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 09:02:25 -0800
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
Subject: [PATCH v3 0/5] Add PCIe Root Port support for Agilex family of chips
Date: Wed,  8 Jan 2025 10:59:04 -0600
Message-Id: <20250108165909.3344354-1-matthew.gerlach@linux.intel.com>
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


