Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB23488E49
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jan 2022 02:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237996AbiAJBvD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Jan 2022 20:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238012AbiAJBu5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Jan 2022 20:50:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227E0C061748
        for <linux-pci@vger.kernel.org>; Sun,  9 Jan 2022 17:50:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6897B8111A
        for <linux-pci@vger.kernel.org>; Mon, 10 Jan 2022 01:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23038C36AEF;
        Mon, 10 Jan 2022 01:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641779454;
        bh=L5qm5GZkhw1XGmwCXWuUT/hFhgkastabpvuhld2hr2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LI31DLB782ePWiM8xYtb7v0lyr6VaiB6v4rmiolIUwwY4fG9U3IYTAtUCSK2xVOpg
         0lIc135gu76U5+CReCpiG4ux9EToyY/WcRtrHvOhxvm6HKBwjRnvIeIUMhKc+8Q9X6
         /KihXrd1VniM0md6cXdYFzEWy8tQwG0hs1UkBv3SbepTH/CI7faegXWOPuW99Stmve
         o4HcYiG713vbeWTaF9l2Q7928KGsV3+/bPnlSU8vZAN0BiE1uFZk2vvdO4CGDU8c1O
         OhlXOMulqgf5/WpuH/lQdSwKe2vQTeZp+udxs8jJa33Ubsh9xeV0uSsipcszRYG+7r
         uw12FkI4KTRYA==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 15/23] PCI: aardvark: Optimize writing PCI_EXP_RTCTL_PMEIE and PCI_EXP_RTSTA_PME on emulated bridge
Date:   Mon, 10 Jan 2022 02:50:10 +0100
Message-Id: <20220110015018.26359-16-kabel@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220110015018.26359-1-kabel@kernel.org>
References: <20220110015018.26359-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

To optimize advk_pci_bridge_emul_pcie_conf_write() code, touch
PCIE_ISR0_REG and PCIE_ISR0_MASK_REG registers only when it is really
needed, when processing PCI_EXP_RTCTL_PMEIE and PCI_EXP_RTSTA_PME bits.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 8706a5f58eb5..e7b9ca31c79c 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -934,19 +934,21 @@ advk_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 			advk_pcie_wait_for_retrain(pcie);
 		break;
 
-	case PCI_EXP_RTCTL: {
+	case PCI_EXP_RTCTL:
 		/* Only mask/unmask PME interrupt */
-		u32 val = advk_readl(pcie, PCIE_ISR0_MASK_REG) &
-			~PCIE_MSG_PM_PME_MASK;
-		if ((new & PCI_EXP_RTCTL_PMEIE) == 0)
-			val |= PCIE_MSG_PM_PME_MASK;
-		advk_writel(pcie, val, PCIE_ISR0_MASK_REG);
+		if (mask & PCI_EXP_RTCTL_PMEIE) {
+			u32 val = advk_readl(pcie, PCIE_ISR0_MASK_REG);
+			if (new & PCI_EXP_RTCTL_PMEIE)
+				val &= ~PCIE_MSG_PM_PME_MASK;
+			else
+				val |= PCIE_MSG_PM_PME_MASK;
+			advk_writel(pcie, val, PCIE_ISR0_MASK_REG);
+		}
 		break;
-	}
 
 	case PCI_EXP_RTSTA:
-		new = (new & PCI_EXP_RTSTA_PME) >> 9;
-		advk_writel(pcie, new, PCIE_ISR0_REG);
+		if (new & PCI_EXP_RTSTA_PME)
+			advk_writel(pcie, PCIE_MSG_PM_PME_MASK, PCIE_ISR0_REG);
 		break;
 
 	case PCI_EXP_DEVCTL:
-- 
2.34.1

