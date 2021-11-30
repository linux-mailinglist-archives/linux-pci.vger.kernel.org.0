Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3F946346C
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 13:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhK3Mjx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 07:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhK3Mjw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 07:39:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A335FC061574
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 04:36:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73727B81919
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 12:36:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB42C53FCD;
        Tue, 30 Nov 2021 12:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638275791;
        bh=Zom8OJtYEZV8oJ9yPxDBKMP/73UFTt2PWS5ADcIzuzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nGhKtsbIRAFC4CxtxE3W2DA3jS3SwIsKzI3XU8cdI812bv/Uq5Q7TeqQelLzcPOZc
         0S3AWf/x1V61DMSKPKJ+PshqnWxIMEo93OPLKPfP1b0vyK0zeUjn99mZiLtm54qEf0
         IDOeRImuTBgrgY13cyERtsavyKz8PEDJ/aPjMgPTaM+hZpNWoSiENeqNYEWSHXdnCQ
         5D1dJQqhrdL0mV3RDLw2tUZfR7XdtQKJLfs8tYzgN7TvlmEdB8QV5b+RL7FQC1EwqC
         RhRm3DjKAVbgZXhSl6rRVOIhUAyubRbvL1K/qOY+J+VUAqJwzhoZQ92l57uyrAcaKF
         XdKpfT5CINY3w==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 03/11] PCI: aardvark: Add support for DEVCAP2, DEVCTL2, LNKCAP2 and LNKCTL2 registers on emulated bridge
Date:   Tue, 30 Nov 2021 13:36:13 +0100
Message-Id: <20211130123621.23062-4-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211130123621.23062-1-kabel@kernel.org>
References: <20211130123621.23062-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

PCI aardvark hardware supports access to DEVCAP2, DEVCTL2, LNKCAP2 and
LNKCTL2 configuration registers of PCIe core via PCIE_CORE_PCIEXP_CAP.
Export them via emulated software root bridge.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index c5300d49807a..25af189a1052 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -884,8 +884,13 @@ advk_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
 	case PCI_CAP_LIST_ID:
 	case PCI_EXP_DEVCAP:
 	case PCI_EXP_DEVCTL:
+	case PCI_EXP_DEVCAP2:
+	case PCI_EXP_DEVCTL2:
+	case PCI_EXP_LNKCAP2:
+	case PCI_EXP_LNKCTL2:
 		*value = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + reg);
 		return PCI_BRIDGE_EMUL_HANDLED;
+
 	default:
 		return PCI_BRIDGE_EMUL_NOT_HANDLED;
 	}
@@ -899,10 +904,6 @@ advk_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 	struct advk_pcie *pcie = bridge->data;
 
 	switch (reg) {
-	case PCI_EXP_DEVCTL:
-		advk_writel(pcie, new, PCIE_CORE_PCIEXP_CAP + reg);
-		break;
-
 	case PCI_EXP_LNKCTL:
 		advk_writel(pcie, new, PCIE_CORE_PCIEXP_CAP + reg);
 		if (new & PCI_EXP_LNKCTL_RL)
@@ -924,6 +925,12 @@ advk_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 		advk_writel(pcie, new, PCIE_ISR0_REG);
 		break;
 
+	case PCI_EXP_DEVCTL:
+	case PCI_EXP_DEVCTL2:
+	case PCI_EXP_LNKCTL2:
+		advk_writel(pcie, new, PCIE_CORE_PCIEXP_CAP + reg);
+		break;
+
 	default:
 		break;
 	}
-- 
2.32.0

