Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B839441F60D
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 21:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354455AbhJAUBB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 16:01:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354071AbhJAUBA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Oct 2021 16:01:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39DC761AD1;
        Fri,  1 Oct 2021 19:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633118356;
        bh=utIctZlSySMehDp4Ujo7qokOLj0aVQ+Dbqrl4itN7lc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=frYXY4sdTQqCDpno1CvQ+5LmDkcsefquN7ftqX3WE4hH5htSHgaZiegwO6Mvm+fxf
         bQwpdWxtqdgw3vyMZbIHAXhQT0ZBLF7mAhtW5EggZkpJfQf+EC6xBpGxkSdnCbGK9d
         WeQ0GnYG5Bhtc+C2+3NUbf9ikL2uQSvvIrlWeCnXNxOIu0NBp/rYkfCFdMpkQNgjyL
         kfs2HfS/0fCBWIGV98EyUR/XPaJliShLY+zm96ycJELbRjKIHOF4UxQiYD60idcaTz
         RidPqYw0UPp1LhfZ7DwHFjz13wMtcUAc+p2icfvxs59N0F/8nxzdXiM4MUTX0bSWfl
         e8Nwn3FTGuGDQ==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org, =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 10/13] PCI: aardvark: Simplify initialization of rootcap on virtual bridge
Date:   Fri,  1 Oct 2021 21:58:53 +0200
Message-Id: <20211001195856.10081-11-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211001195856.10081-1-kabel@kernel.org>
References: <20211001195856.10081-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

PCIe config space can be initialized also before pci_bridge_emul_init()
call, so move rootcap initialization after PCI config space initialization.

This simplifies the function a little since it removes one if (ret < 0)
check.

Fixes: 43f5c77bcbd2 ("PCI: aardvark: Fix reporting CRS value")
Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 7b9870d0b81f..74d1ec7eff16 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -822,7 +822,6 @@ static struct pci_bridge_emul_ops advk_pci_bridge_emul_ops = {
 static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
 {
 	struct pci_bridge_emul *bridge = &pcie->bridge;
-	int ret;
 
 	bridge->conf.vendor =
 		cpu_to_le16(advk_readl(pcie, PCIE_CORE_DEV_ID_REG) & 0xffff);
@@ -842,19 +841,14 @@ static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
 	/* Support interrupt A for MSI feature */
 	bridge->conf.intpin = PCIE_CORE_INT_A_ASSERT_ENABLE;
 
+	/* Indicates supports for Completion Retry Status */
+	bridge->pcie_conf.rootcap = cpu_to_le16(PCI_EXP_RTCAP_CRSVIS);
+
 	bridge->has_pcie = true;
 	bridge->data = pcie;
 	bridge->ops = &advk_pci_bridge_emul_ops;
 
-	/* PCIe config space can be initialized after pci_bridge_emul_init() */
-	ret = pci_bridge_emul_init(bridge, 0);
-	if (ret < 0)
-		return ret;
-
-	/* Indicates supports for Completion Retry Status */
-	bridge->pcie_conf.rootcap = cpu_to_le16(PCI_EXP_RTCAP_CRSVIS);
-
-	return 0;
+	return pci_bridge_emul_init(bridge, 0);
 }
 
 static bool advk_pcie_valid_device(struct advk_pcie *pcie, struct pci_bus *bus,
-- 
2.32.0

