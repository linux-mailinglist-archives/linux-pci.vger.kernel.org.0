Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87AE422FB5
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 20:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbhJESMB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 14:12:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234520AbhJESMA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 14:12:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF63E613D5;
        Tue,  5 Oct 2021 18:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633457409;
        bh=24tK6YBrzQUPnQLTUn9EdpSgpfoELTWdGABWlWvso8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lKoVBMzlMTgkTDHEiEvpC6qgLp1Ff1byHKY4tdg2OhYyDPm1S9DccWuhOKWbj7sc1
         pgh2Q7qL/muP2caNXQ2BKkTKscuRq36OwIerhpgCPUlFoicFP7xJr3nycDUizMQ0kj
         KVaAGeNs5rlxH0DWDz54gQcWVDOaMxJDLeca9fUt8gyBapEJNlB1Q84V9bkZGSM1s4
         pIGcSdrqCWV0kNV0F+L+fTJNrJdGVPaWyVyRyC6S71UdrqVPrp9B/n9EKWgD4GFOmI
         FzV/KX1NyDYALUssnUnNPmdF3PWJdCpEBSD1b0MEvp/dR9p4NGIvJlaG9iHBrPf2Ya
         z/MfoSJNxlkHQ==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org, =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 10/13] PCI: aardvark: Simplify initialization of rootcap on virtual bridge
Date:   Tue,  5 Oct 2021 20:09:49 +0200
Message-Id: <20211005180952.6812-11-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211005180952.6812-1-kabel@kernel.org>
References: <20211005180952.6812-1-kabel@kernel.org>
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

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index efe8b5f7bf8c..9c509d5a9afa 100644
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

