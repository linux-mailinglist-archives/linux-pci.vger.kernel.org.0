Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4887EFBCA
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2019 11:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388625AbfKEKvb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Nov 2019 05:51:31 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:32613 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730715AbfKEKva (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Nov 2019 05:51:30 -0500
X-IronPort-AV: E=Sophos;i="5.68,270,1569250800"; 
   d="scan'208";a="30883390"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 05 Nov 2019 19:51:29 +0900
Received: from localhost.localdomain (unknown [10.166.17.210])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 614164005153;
        Tue,  5 Nov 2019 19:51:29 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, stable@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v4 1/2] Revert "PCI: rcar: Fix missing MACCTLR register setting in rcar_pcie_hw_init()"
Date:   Tue,  5 Nov 2019 19:51:28 +0900
Message-Id: <1572951089-19956-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572951089-19956-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1572951089-19956-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This reverts commit 175cc093888ee74a17c4dd5f99ba9a6bc86de5be.

The commit description/code don't follow the manual accurately,
it's difficult to understand. So, this patch reverts the commit.

Fixes: 175cc093888e ("PCI: rcar: Fix missing MACCTLR register setting in rcar_pcie_hw_init()"
Cc: <stable@vger.kernel.org>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pci/controller/pcie-rcar.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index 0dadccb..40d8c54 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -91,7 +91,6 @@
 #define  LINK_SPEED_2_5GTS	(1 << 16)
 #define  LINK_SPEED_5_0GTS	(2 << 16)
 #define MACCTLR			0x011058
-#define  MACCTLR_RESERVED	BIT(0)
 #define  SPEED_CHANGE		BIT(24)
 #define  SCRAMBLE_DISABLE	BIT(27)
 #define PMSR			0x01105c
@@ -614,8 +613,6 @@ static int rcar_pcie_hw_init(struct rcar_pcie *pcie)
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		rcar_pci_write_reg(pcie, 0x801f0000, PCIEMSITXR);
 
-	rcar_rmw32(pcie, MACCTLR, MACCTLR_RESERVED, 0);
-
 	/* Finish initialization - establish a PCI Express link */
 	rcar_pci_write_reg(pcie, CFINIT, PCIETCTLR);
 
@@ -1238,7 +1235,6 @@ static int rcar_pcie_resume_noirq(struct device *dev)
 		return 0;
 
 	/* Re-establish the PCIe link */
-	rcar_rmw32(pcie, MACCTLR, MACCTLR_RESERVED, 0);
 	rcar_pci_write_reg(pcie, CFINIT, PCIETCTLR);
 	return rcar_pcie_wait_for_dl(pcie);
 }
-- 
2.7.4

