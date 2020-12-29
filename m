Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73DFA2E7281
	for <lists+linux-pci@lfdr.de>; Tue, 29 Dec 2020 18:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgL2RJx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Dec 2020 12:09:53 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:53412 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726240AbgL2RJx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Dec 2020 12:09:53 -0500
X-IronPort-AV: E=Sophos;i="5.78,458,1599490800"; 
   d="scan'208";a="67216729"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 30 Dec 2020 02:09:01 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 632A340065D9;
        Wed, 30 Dec 2020 02:08:59 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] PCI: Drop PCIE_RCAR config option
Date:   Tue, 29 Dec 2020 17:08:48 +0000
Message-Id: <20201229170848.18482-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

All the defconfig files have replaced PCIE_RCAR config option with
PCIE_RCAR_HOST config option which built the same driver, so we can
now safely drop PCIE_RCAR config option.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Hi All,

This patch is exact similar to [1], as all the defconfig files enabling
PCIE_RCAR have switched to PCIE_RCAR_HOST and is part of v5.10. PCIE_RCAR
can now be safely dropped.

[1] http://patchwork.ozlabs.org/project/linux-pci/patch/
    1585856319-4380-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar
---
 drivers/pci/controller/Kconfig | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 64e2f5e379aa..0d98d8dd448b 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -55,15 +55,6 @@ config PCI_RCAR_GEN2
 	  There are 3 internal PCI controllers available with a single
 	  built-in EHCI/OHCI host controller present on each one.
 
-config PCIE_RCAR
-	bool "Renesas R-Car PCIe controller"
-	depends on ARCH_RENESAS || COMPILE_TEST
-	depends on PCI_MSI_IRQ_DOMAIN
-	select PCIE_RCAR_HOST
-	help
-	  Say Y here if you want PCIe controller support on R-Car SoCs.
-	  This option will be removed after arm64 defconfig is updated.
-
 config PCIE_RCAR_HOST
 	bool "Renesas R-Car PCIe host controller"
 	depends on ARCH_RENESAS || COMPILE_TEST
-- 
2.17.1

