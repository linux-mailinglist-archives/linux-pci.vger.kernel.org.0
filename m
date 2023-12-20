Return-Path: <linux-pci+bounces-1208-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A1A819836
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 06:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D5961F260A4
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 05:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B00D312;
	Wed, 20 Dec 2023 05:38:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DB9FBE1;
	Wed, 20 Dec 2023 05:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.04,290,1695654000"; 
   d="scan'208";a="187105320"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 20 Dec 2023 14:38:39 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 63DBE416941A;
	Wed, 20 Dec 2023 14:38:39 +0900 (JST)
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
Subject: [PATCH v4 0/6] PCI: controllers: tidy code up
Date: Wed, 20 Dec 2023 14:38:23 +0900
Message-Id: <20231220053829.1921187-1-yoshihiro.shimoda.uh@renesas.com>
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

Changes from v3:
https://lore.kernel.org/linux-pci/20231215022955.3574063-1-yoshihiro.shimoda.uh@renesas.com/
 - Based on the latest pci.git / next branch. So, I modified the patch 1/6
   for pci-layerscape.c.
 - Add Reviewed-by tag in the patch 4/6.
 - Fix locations of read/write accessors by grouped for readability in
   the patch 4/6.

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
 drivers/pci/controller/dwc/pci-layerscape.c   |   6 +-
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
 30 files changed, 222 insertions(+), 194 deletions(-)

-- 
2.25.1


