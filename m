Return-Path: <linux-pci+bounces-44747-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C9434D1FCB7
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 16:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5099C30185F1
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 15:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729F039E19F;
	Wed, 14 Jan 2026 15:35:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F367839C653;
	Wed, 14 Jan 2026 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404942; cv=none; b=qHT02ULkzSKtJpjb2GqgMnGmmyMGjvPfPBS4tCw3y3tpWMf2zJcd4+dppQjYyvzBue8xA1/cvhVJ2kVz95G5xbyn2megl/OT/qg6jGUW6W6vnHv7tsbNNiRAmiPwBMlDTlI3UTVomPepV7TIaQCXzbKcbbrxISufiB6hPGEtt4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404942; c=relaxed/simple;
	bh=9gAY3V2wbf2rLFZaoA3bjuRd6UoDK+5vIl1eJCX4BII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tNINREK2Ppy6iZIWJzg47GRSG6nD9lOdNdbbcbhbk63lwYxpPBhFVRMdZJb6RZPwKB83VB9odLMmigIR2+u/hHQDE1en3puI+D7/+m+c+cj5bjwpLiwuWBDq/qqR5wZarFJnqYn6tIabec7AIw6WcqT4gKXFEP9byVFtaJAMwlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 9PX1YUblQoO521vUhdjzIg==
X-CSE-MsgGUID: Ufgy+vKuQca/bKELF7PmAQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 15 Jan 2026 00:35:37 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.178])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6CDBC4022B3F;
	Thu, 15 Jan 2026 00:35:32 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: claudiu.beznea.uj@bp.renesas.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	geert+renesas@glider.be,
	krzk+dt@kernel.org
Cc: robh@kernel.org,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	magnus.damm@gmail.com,
	biju.das.jz@bp.renesas.com,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	john.madieu@gmail.com,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [PATCH 00/16] PCI: renesas: Add RZ/G3E PCIe controller support
Date: Wed, 14 Jan 2026 16:33:21 +0100
Message-ID: <20260114153337.46765-1-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Renesas RZ/G3E SoC features a PCIe controller that shares similarities with
the existing RZ/G3S PCIe controller, but with several key differences.
This series adds support for the RZ/G3E PCIe controller by extending the existing
RZ/G3S driver and device tree bindings.

Key differences between RZ/G3E and RZ/G3S PCIe controllers:

Link Speed Support:
 - RZ/G3E: Supports PCIe Gen3 (8.0 GT/s) alongside Gen2 (5.0 GT/s)
 - RZ/G3S: Supports PCIe Gen2 (5.0 GT/s) only

Reset Control:
 - RZ/G3E: Uses register-based reset control mechanism
 - RZ/G3S: Uses exclusively external reset control signals

Inbound Window Configuration:
 - RZ/G3E: Requires precise power-of-2 window coverage with strict address
   alignment constraints. Non-power-of-2 memory regions must be split into
   multiple windows to avoid over-mapping, ensuring proper hardware address
   decoding for DMA operations.
 - RZ/G3S: Uses a simpler approach that rounds up to the next power-of-2,
   creating single larger windows. The hardware tolerates over-mapped regions.

Class/Revision IDs:
 - RZ/G3E: Requires explicit setting of class/revision values
 - RZ/G3S: Has default values in hardware

Clock Naming:
 - RZ/G3E: Uses "clkpmu" PM control clock while CLKREQ_B is deasserting
 - RZ/G3S: Uses "clkl1pm" clock for power management

Phy Settings:
 - RZ/G3E: Does not need PHY settings as it works with default hw values
 - RZ/G3S: Requires explicit PHY settings

This series extends the existing driver to detect the SoC type from the device
tree compatible string and configure the controller appropriately. The updates
are minimal and focused on the hardware-specific differences while keeping the
common code paths unified.

Note: The clks "PCIE_0_REFCLK_IN" and "PCIE_0_CORECLKIN" are added by mistake in
hardware manual

John Madieu (16):
  PCI: rzg3s-host: Fix reset handling in probe error path
  PCI: rzg3s-host: Fix inbound window size tracking
  clk: renesas: rzv2h-cpg: Add support for init_off clocks
  clk: renesas: r9a09g047: Add PCIe clocks and reset
  dt-bindings: PCI: renesas,r9a08g045s33-pcie: Document RZ/G3E SoC
  PCI: rzg3s-host: Make SYSC register offsets SoC-specific
  PCI: rzg3s-host: Make configuration reset lines optional
  PCI: rzg3s-host: Make inbound window setup SoC-specific
  PCI: rzg3s-host: Add SoC-specific configuration and initialization
    callbacks
  PCI: rzg3s-host: Explicitly set class code for RZ/G3E compatibility
  PCI: rzg3s-host: Add PCIe Gen3 (8.0 GT/s) link speed support
  PCI: rzg3s-host: Add support for RZ/G3E PCIe controller
  arm64: dts: renesas: r9a09g047: Add PCIe node
  arm64: dts: renesas: r9a09g047e57-smarc-som: Add PCIe reference clock
  arm64: dts: renesas: r9a09g047e57-smarc: Add PCIe pincontrol
  arm64: dts: renesas: r9a09g047e57-smarc: Enable PCIe

 .../bindings/pci/renesas,r9a08g045-pcie.yaml  | 243 +++++++----
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  68 +++
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   |  11 +
 .../boot/dts/renesas/renesas-smarc2.dtsi      |   7 +
 .../boot/dts/renesas/rzg3e-smarc-som.dtsi     |  11 +
 drivers/clk/renesas/r9a09g047-cpg.c           |   5 +
 drivers/clk/renesas/rzv2h-cpg.c               |   9 +
 drivers/clk/renesas/rzv2h-cpg.h               |  18 +-
 drivers/pci/controller/pcie-rzg3s-host.c      | 393 +++++++++++++++---
 9 files changed, 632 insertions(+), 133 deletions(-)

-- 
2.25.1


