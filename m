Return-Path: <linux-pci+bounces-1034-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63816813FD3
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 03:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FAF2282E94
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 02:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708DA805;
	Fri, 15 Dec 2023 02:35:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125AD18F;
	Fri, 15 Dec 2023 02:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.04,277,1695654000"; 
   d="scan'208";a="186553897"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 15 Dec 2023 11:30:03 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id BFF5A40121A3;
	Fri, 15 Dec 2023 11:30:03 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	gustavo.pimentel@synopsys.com,
	mani@kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v3 0/6] PCI: controllers: tidy code up
Date: Fri, 15 Dec 2023 11:29:49 +0900
Message-Id: <20231215022955.3574063-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series tidies the code of PCIe dwc controllers and some
controllers up.

Changes from v2:
https://lore.kernel.org/linux-pci/20231114055456.2231990-1-yoshihiro.shimoda.uh@renesas.com/
 - Based on the latest pci.git / next branch.
 - Add Suggestion-by and Reviewed-by tags.
 - Move read/write accessors to the header file in the patch 4/6.
 - Revise the commit description in the patch 5/6.

Changes from v1:
https://lore.kernel.org/linux-pci/20231113013300.2132152-1-yoshihiro.shimoda.uh@renesas.com/
 - Based on the latest pci.git / next branch.
 - Add a new patch to drop host prefix of members from dw_pcie_host_ops
   in the patch 1/6.
 - Add Reviewed-by tag in the patch 3/6.
 - Drop unneeded local variable in the patch 4/6.
 - Add new patches to resolve issues of clang warnings in the patch [56]/6.

Justin Stitt (1):
  PCI: iproc: fix -Wvoid-pointer-to-enum-cast warning

Yoshihiro Shimoda (5):
  PCI: dwc: Drop host prefix from struct dw_pcie_host_ops
  PCI: dwc: Rename to .init in struct dw_pcie_ep_ops
  PCI: dwc: Rename to .get_dbi_offset in struct dw_pcie_ep_ops
  PCI: dwc: Add dw_pcie_ep_{read,write}_dbi[2] helpers
  PCI: rcar-gen4: fix -Wvoid-pointer-to-enum-cast warning

 drivers/pci/controller/dwc/pci-dra7xx.c       |   4 +-
 drivers/pci/controller/dwc/pci-exynos.c       |   2 +-
 drivers/pci/controller/dwc/pci-imx6.c         |   6 +-
 drivers/pci/controller/dwc/pci-keystone.c     |   8 +-
 .../pci/controller/dwc/pci-layerscape-ep.c    |   7 +-
 drivers/pci/controller/dwc/pci-layerscape.c   |   2 +-
 drivers/pci/controller/dwc/pci-meson.c        |   2 +-
 drivers/pci/controller/dwc/pcie-al.c          |   2 +-
 drivers/pci/controller/dwc/pcie-armada8k.c    |   2 +-
 drivers/pci/controller/dwc/pcie-artpec6.c     |   4 +-
 drivers/pci/controller/dwc/pcie-bt1.c         |   4 +-
 .../pci/controller/dwc/pcie-designware-ep.c   | 188 ++++++------------
 .../pci/controller/dwc/pcie-designware-host.c |  30 +--
 .../pci/controller/dwc/pcie-designware-plat.c |   2 +-
 drivers/pci/controller/dwc/pcie-designware.h  | 105 +++++++++-
 drivers/pci/controller/dwc/pcie-dw-rockchip.c |   2 +-
 drivers/pci/controller/dwc/pcie-fu740.c       |   2 +-
 drivers/pci/controller/dwc/pcie-histb.c       |   2 +-
 drivers/pci/controller/dwc/pcie-intel-gw.c    |   2 +-
 drivers/pci/controller/dwc/pcie-keembay.c     |   2 +-
 drivers/pci/controller/dwc/pcie-kirin.c       |   2 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |   2 +-
 drivers/pci/controller/dwc/pcie-qcom.c        |   6 +-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   |  12 +-
 drivers/pci/controller/dwc/pcie-spear13xx.c   |   2 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    |   2 +-
 drivers/pci/controller/dwc/pcie-uniphier-ep.c |   2 +-
 drivers/pci/controller/dwc/pcie-uniphier.c    |   2 +-
 drivers/pci/controller/dwc/pcie-visconti.c    |   2 +-
 drivers/pci/controller/pcie-iproc-platform.c  |   2 +-
 30 files changed, 220 insertions(+), 192 deletions(-)

-- 
2.34.1


