Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F9C37574A
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 17:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbhEFPdy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 11:33:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235490AbhEFPds (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 11:33:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A474961439;
        Thu,  6 May 2021 15:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620315169;
        bh=AxtlbVze2/56soOpmOZjWWVJpGnSFZmHfFNbsihLoxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aKpwx1CoP71JDjHNRDbH+3h6wN2p7jbAI/JP5RUUzSkxEaiHAsx6ovSiOuVl4e1qH
         pLUe24gdAwSbGU2MEi8Tmp/GPzMKGH05M9LuO0b2DQCxnyVPc2cFpLA062kk/0HkO9
         songOon0mZo2YlLiL8FSnN1uePXX6w2N6UnGv0PhvfwY/+HQHxcMgcjEZXHm9PC08Y
         VmCYh/R4UBp7e66goyLmgOQVOiZPVYFgXF/Vfzk5V77tho2W6m+XpTY0e2PtHfGgER
         5T6bIe7B1GijDTBzYhzqhV2r9OuNQVIr7S6VKcQkQiZERk39PxTU0C8sbdoGnGggRQ
         vd9W1qCxtIGtw==
Received: by pali.im (Postfix)
        id 5DE678A1; Thu,  6 May 2021 17:32:49 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 18/42] PCI: aardvark: Correctly clear and unmask all MSI interrupts
Date:   Thu,  6 May 2021 17:31:29 +0200
Message-Id: <20210506153153.30454-19-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506153153.30454-1-pali@kernel.org>
References: <20210506153153.30454-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Define a new macro PCIE_MSI_ALL_MASK and use it for masking, unmasking and
clearing all MSI interrupts.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-aardvark.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 498810c00b6d..5e0243b2c473 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -117,6 +117,7 @@
 #define PCIE_MSI_ADDR_HIGH_REG			(CONTROL_BASE_ADDR + 0x54)
 #define PCIE_MSI_STATUS_REG			(CONTROL_BASE_ADDR + 0x58)
 #define PCIE_MSI_MASK_REG			(CONTROL_BASE_ADDR + 0x5C)
+#define     PCIE_MSI_ALL_MASK			GENMASK(31, 0)
 #define PCIE_MSI_PAYLOAD_REG			(CONTROL_BASE_ADDR + 0x9C)
 #define     PCIE_MSI_DATA_MASK			GENMASK(15, 0)
 
@@ -386,19 +387,22 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 	advk_writel(pcie, reg, PCIE_CORE_CTRL2_REG);
 
 	/* Clear all interrupts */
+	advk_writel(pcie, PCIE_MSI_ALL_MASK, PCIE_MSI_STATUS_REG);
 	advk_writel(pcie, PCIE_ISR0_ALL_MASK, PCIE_ISR0_REG);
 	advk_writel(pcie, PCIE_ISR1_ALL_MASK, PCIE_ISR1_REG);
 	advk_writel(pcie, PCIE_IRQ_ALL_MASK, HOST_CTRL_INT_STATUS_REG);
 
 	/* Disable All ISR0/1 Sources */
-	reg = PCIE_ISR0_ALL_MASK;
-	reg &= ~PCIE_ISR0_MSI_INT_PENDING;
-	advk_writel(pcie, reg, PCIE_ISR0_MASK_REG);
-
+	advk_writel(pcie, PCIE_ISR0_ALL_MASK, PCIE_ISR0_MASK_REG);
 	advk_writel(pcie, PCIE_ISR1_ALL_MASK, PCIE_ISR1_MASK_REG);
 
 	/* Unmask all MSIs */
-	advk_writel(pcie, 0, PCIE_MSI_MASK_REG);
+	advk_writel(pcie, ~(u32)PCIE_MSI_ALL_MASK, PCIE_MSI_MASK_REG);
+
+	/* Unmask summary MSI interrupt */
+	reg = advk_readl(pcie, PCIE_ISR0_MASK_REG);
+	reg &= ~PCIE_ISR0_MSI_INT_PENDING;
+	advk_writel(pcie, reg, PCIE_ISR0_MASK_REG);
 
 	/* Enable summary interrupt for GIC SPI source */
 	reg = PCIE_IRQ_ALL_MASK & (~PCIE_IRQ_ENABLE_INTS_MASK);
@@ -1049,7 +1053,7 @@ static void advk_pcie_handle_msi(struct advk_pcie *pcie)
 
 	msi_mask = advk_readl(pcie, PCIE_MSI_MASK_REG);
 	msi_val = advk_readl(pcie, PCIE_MSI_STATUS_REG);
-	msi_status = msi_val & ~msi_mask;
+	msi_status = msi_val & ((~msi_mask) & PCIE_MSI_ALL_MASK);
 
 	for (msi_idx = 0; msi_idx < MSI_IRQ_NUM; msi_idx++) {
 		if (!(BIT(msi_idx) & msi_status))
-- 
2.20.1

