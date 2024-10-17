Return-Path: <linux-pci+bounces-14704-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E199A1830
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 03:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52BD6B24B25
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 01:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AEC20314;
	Thu, 17 Oct 2024 01:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfQeCbbx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BA5F4ED;
	Thu, 17 Oct 2024 01:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729130332; cv=none; b=uXhPUXzJ58+GijLnxSmHF8JBrMK/RVGYxA6pqAxbx7nXwVt9MeI//+Wjxu9t+fdFsUxxsUINM3L3Vx8/9IoO6IB0RD5cF/DLdyvSSHun+GfAosuPpDGlyIon+W4lrD7Yb3gffkNR3r4wqkCz9dO0L7yXUIrnief4MTYZJuPHfkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729130332; c=relaxed/simple;
	bh=lARG9evqlHd4IXGRQKdVmMfZMk2GD5Jo3kWsnqF+zLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VJNt7+4NbGtMfAkPKbTUXEFHiYGI6C39y6QxYORrtAYkyQq0ftQzrpPIi/b8dSJCpfGC55IS5ckhMSKR7Nt9U8hdxzYz/BYPStg1refMh/HpqJxdHbHpdwHRMHSt4tiWNcf7DKnjTbJLn25kQMmZ6eJgr7g5YabfwW0R2CfRFRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfQeCbbx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C879C4CEC5;
	Thu, 17 Oct 2024 01:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729130332;
	bh=lARG9evqlHd4IXGRQKdVmMfZMk2GD5Jo3kWsnqF+zLg=;
	h=From:To:Cc:Subject:Date:From;
	b=GfQeCbbxHixLrE/Vrv0Y8wpe8YmEf+CByNAuWQKPpLHKBpjBMbtHUi0XuTHYVXX6b
	 6GLBtLBZnzD7KAIBnywUvSg0GYQc9no1BKVX1xZ/SRNJ84OmXRpXhTvXGRHpJDsejF
	 PU4Rv5/ep3mvq/kif8YzbnPz0wdv80slFUs85BTxoe8tyhVixazH/dSMtXgnKsOTfD
	 RBWAtachfLbh467OUQNsr03JPFdG03uDhDmTRRYEqV9NvgEET7cjwr7cqTVhvnFMe0
	 dT/h6sD3FarCsL/VosNuhPLYC/crcSsqKwqlf1WSIL9HdCwABmxX5O1vGFTFbxi4So
	 zqCkMqloJgzqA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v5 00/14] Fix and improve the Rockchip endpoint driver
Date: Thu, 17 Oct 2024 10:58:35 +0900
Message-ID: <20241017015849.190271-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series fix the PCI address mapping handling of the Rockchip
PCI endpoint driver, refactor some of its code, improves link training
and adds handling of the PERST# signal.

This series is organized as follows:
 - Patch 1 fixes the rockchip ATU programming
 - Patch 2, 3 and 4 introduce small code improvments
 - Patch 5 implements the .align_addr() operation to make the RK3399
   endpoint controller driver fully functional with the new
   pci_epc_mem_map() function
 - Patch 6 uses the new align_addr operation function to fix the ATU
   programming for MSI IRQ data mapping
 - Patch 7, 8, 9 and 10 refactor the driver code to make it more
   readable
 - Patch 11 introduces the .stop() endpoint controller operation to
   correctly disable the endpopint controller after use
 - Patch 12 improves link training
 - Patch 13 implements handling of the #PERST signal
 - Patch 14 adds a DT overlay file to enable EP mode and define the
   PERST# GPIO (reset-gpios) property.

These patches were tested using a Pine Rockpro64 board used as an
endpoint with the test endpoint function driver and a prototype nvme
endpoint function driver.

Changes from v4:
 - Added patch 6
 - Added comments to patch 12 and 13 to clarify link training handling
   and PERST# GPIO use.
 - Added patch 14

Changes from v3:
 - Addressed Mani's comments (see mailing list for details).
 - Removed old patch 11 (dt-binding changes) and instead use in patch 12
   the already defined reset_gpios property.
 - Added patch 6
 - Added review tags

Changes from v2:
 - Split the patch series
 - Corrected patch 11 to add the missing "maxItem"

Changes from v1:
 - Changed pci_epc_check_func() to pci_epc_function_is_valid() in patch
   1.
 - Removed patch "PCI: endpoint: Improve pci_epc_mem_alloc_addr()"
   (former patch 2 of v1)
 - Various typos cleanups all over. Also fixed some blank space
   indentation.
 - Added review tags

Damien Le Moal (14):
  PCI: rockchip-ep: Fix address translation unit programming
  PCI: rockchip-ep: Use a macro to define EP controller .align feature
  PCI: rockchip-ep: Improve rockchip_pcie_ep_unmap_addr()
  PCI: rockchip-ep: Improve rockchip_pcie_ep_map_addr()
  PCI: rockchip-ep: Implement the pci_epc_ops::align_addr() operation
  PCI: rockchip-ep: Fix MSI IRQ data mapping
  PCI: rockchip-ep: Rename rockchip_pcie_parse_ep_dt()
  PCI: rockchip-ep: Refactor rockchip_pcie_ep_probe() memory allocations
  PCI: rockchip-ep: Refactor rockchip_pcie_ep_probe() MSI-X hiding
  PCI: rockchip-ep: Refactor endpoint link training enable
  PCI: rockship-ep: Implement the pci_epc_ops::stop_link() operation
  PCI: rockchip-ep: Improve link training
  PCI: rockchip-ep: Handle PERST# signal in endpoint mode
  arm64: dts: rockchip: Add rockpro64 overlay for PCIe endpoint mode

 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../rockchip/rk3399-rockpro64-pcie-ep.dtso    |  20 +
 drivers/pci/controller/pcie-rockchip-ep.c     | 432 ++++++++++++++----
 drivers/pci/controller/pcie-rockchip-host.c   |   4 +-
 drivers/pci/controller/pcie-rockchip.c        |  21 +-
 drivers/pci/controller/pcie-rockchip.h        |  24 +-
 6 files changed, 406 insertions(+), 96 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rockpro64-pcie-ep.dtso

-- 
2.47.0


