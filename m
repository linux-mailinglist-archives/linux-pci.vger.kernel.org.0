Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0879A37576B
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 17:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbhEFPfl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 11:35:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235755AbhEFPeB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 11:34:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8FC526191A;
        Thu,  6 May 2021 15:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620315175;
        bh=xaJINrTisG+I3HDxwk8CIe8zyar1r6u5T6BaI1VDI0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tK+CMKcyNSHhKgWk2uetW7ilhmLdAZtALw4CNQm1trc6O55IcNW51XC0hhEhGsZEw
         7bAvK5prQGM9NQypqQ/E2Qf4yc2KTUUzXkoeUSlTMAr3IBXjbmjZG2dOPEW8l/0nk6
         ppMgRI7ONj8LYtqgCBwnRuyJy/Y0k38QkHsw5C4VCkiNowqyDaS+l1iTZISd6qssUR
         dHjLTIJAZuJkms3KU9H/2lo5K8R9/PXgyST4uqNQy3In/gwFJEF9+4hyX4cjD5nluQ
         34NYrhGS7sqKNIZe1HgbeQ9pTTlQUWWdg+MBt5RtyMHiNukxNKKbfhK6IO9NhtojLB
         SQLf271YPE0wQ==
Received: by pali.im (Postfix)
        id 482E38A1; Thu,  6 May 2021 17:32:55 +0200 (CEST)
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
Subject: [PATCH 38/42] PCI: aardvark: Cleanup some register macros
Date:   Thu,  6 May 2021 17:31:49 +0200
Message-Id: <20210506153153.30454-39-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506153153.30454-1-pali@kernel.org>
References: <20210506153153.30454-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Define SPEED_GEN_* macros with correct PCIE_GEN_SEL_SHIFT.

Simplify macro for setting root complex mode (use BIT instead of
MSK+SHIFT).

Rename PCIE_MSG_PM_PME_MASK to PCIE_ISR0_MSG_PM_PME to match existing
naming convention, rename PCIE_ISR0_MSI_INT_PENDING to PCIE_ISR0_MSI_INT as
it is used for both interrupt mask and pending bit.

Change the code which disables strict ordering by doing it explicitly
(instead of not specifying *_STRICT_ORDER_ENABLE macro, specify bitwise
negation of that macro).

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 34 +++++++++++++--------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 2258b9ae1084..3c18e139b095 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -63,11 +63,10 @@
 #define PCIE_CORE_CTRL0_REG			(CONTROL_BASE_ADDR + 0x0)
 #define     PCIE_GEN_SEL_MSK			0x3
 #define     PCIE_GEN_SEL_SHIFT			0x0
-#define     SPEED_GEN_1				0
-#define     SPEED_GEN_2				1
-#define     SPEED_GEN_3				2
-#define     IS_RC_MSK				1
-#define     IS_RC_SHIFT				2
+#define     SPEED_GEN_1				(0 << PCIE_GEN_SEL_SHIFT)
+#define     SPEED_GEN_2				(1 << PCIE_GEN_SEL_SHIFT)
+#define     SPEED_GEN_3				(2 << PCIE_GEN_SEL_SHIFT)
+#define     IS_RC				BIT(2)
 #define     LANE_CNT_MSK			0x18
 #define     LANE_CNT_SHIFT			0x3
 #define     LANE_COUNT_1			(0 << LANE_CNT_SHIFT)
@@ -91,15 +90,15 @@
 #define     PCIE_CORE_REF_CLK_TX_ENABLE		BIT(1)
 #define PCIE_MSG_LOG_REG			(CONTROL_BASE_ADDR + 0x30)
 #define PCIE_ISR0_REG				(CONTROL_BASE_ADDR + 0x40)
-#define PCIE_MSG_PM_PME_MASK			BIT(7)
 #define PCIE_ISR0_MASK_REG			(CONTROL_BASE_ADDR + 0x44)
-#define     PCIE_ISR0_MSI_INT_PENDING		BIT(24)
+#define     PCIE_ISR0_MSG_PM_PME		BIT(7)
 #define     PCIE_ISR0_CORR_ERR			BIT(11)
 #define     PCIE_ISR0_NFAT_ERR			BIT(12)
 #define     PCIE_ISR0_FAT_ERR			BIT(13)
 #define     PCIE_ISR0_INTX_ASSERT(val)		BIT(16 + (val))
 #define     PCIE_ISR0_INTX_DEASSERT(val)	BIT(20 + (val))
-#define	    PCIE_ISR0_ALL_MASK			GENMASK(26, 0)
+#define     PCIE_ISR0_MSI_INT			BIT(24)
+#define     PCIE_ISR0_ALL_MASK			GENMASK(26, 0)
 #define PCIE_ISR1_REG				(CONTROL_BASE_ADDR + 0x48)
 #define PCIE_ISR1_MASK_REG			(CONTROL_BASE_ADDR + 0x4C)
 #define     PCIE_ISR1_POWER_STATE_CHANGE	BIT(4)
@@ -345,7 +344,7 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 
 	/* Set PCI global control register to RC mode */
 	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
-	reg |= (IS_RC_MSK << IS_RC_SHIFT);
+	reg |= IS_RC;
 	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
 
 	/*
@@ -379,8 +378,8 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 	advk_writel(pcie, reg, PCIE_CORE_PCIEXP_CAP + PCI_EXP_DEVCTL);
 
 	/* Program PCIe Control 2 to disable strict ordering */
-	reg = PCIE_CORE_CTRL2_RESERVED |
-		PCIE_CORE_CTRL2_TD_ENABLE;
+	reg = advk_readl(pcie, PCIE_CORE_CTRL2_REG);
+	reg &= ~PCIE_CORE_CTRL2_STRICT_ORDER_ENABLE;
 	advk_writel(pcie, reg, PCIE_CORE_CTRL2_REG);
 
 	/* Set lane X1 */
@@ -412,7 +411,7 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 
 	/* Unmask summary MSI interrupt */
 	reg = advk_readl(pcie, PCIE_ISR0_MASK_REG);
-	reg &= ~PCIE_ISR0_MSI_INT_PENDING;
+	reg &= ~PCIE_ISR0_MSI_INT;
 	advk_writel(pcie, reg, PCIE_ISR0_MASK_REG);
 
 	/* Unmask bits for ERR interrupt */
@@ -422,7 +421,7 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 
 	/* Unmask PME interrupt for processing of PME requester */
 	reg = advk_readl(pcie, PCIE_ISR0_MASK_REG);
-	reg &= ~PCIE_MSG_PM_PME_MASK;
+	reg &= ~PCIE_ISR0_MSG_PM_PME;
 	advk_writel(pcie, reg, PCIE_ISR0_MASK_REG);
 
 	/* Enable summary interrupt for GIC SPI source */
@@ -1265,8 +1264,7 @@ static void advk_pcie_handle_msi(struct advk_pcie *pcie)
 			generic_handle_irq(virq);
 	}
 
-	advk_writel(pcie, PCIE_ISR0_MSI_INT_PENDING,
-		    PCIE_ISR0_REG);
+	advk_writel(pcie, PCIE_ISR0_MSI_INT, PCIE_ISR0_REG);
 }
 
 static void advk_pcie_handle_int(struct advk_pcie *pcie)
@@ -1290,8 +1288,8 @@ static void advk_pcie_handle_int(struct advk_pcie *pcie)
 		return;
 
 	/* Process PME interrupt as the first one to do not miss PME requester id */
-	if (isr0_status & PCIE_MSG_PM_PME_MASK) {
-		advk_writel(pcie, PCIE_MSG_PM_PME_MASK, PCIE_ISR0_REG);
+	if (isr0_status & PCIE_ISR0_MSG_PM_PME) {
+		advk_writel(pcie, PCIE_ISR0_MSG_PM_PME, PCIE_ISR0_REG);
 		/*
 		 * PCIE_MSG_LOG_REG contains the last inbound message,
 		 * so store requester id only when PME was not asserted yet.
@@ -1326,7 +1324,7 @@ static void advk_pcie_handle_int(struct advk_pcie *pcie)
 	}
 
 	/* Process MSI interrupts */
-	if (isr0_status & PCIE_ISR0_MSI_INT_PENDING)
+	if (isr0_status & PCIE_ISR0_MSI_INT)
 		advk_pcie_handle_msi(pcie);
 
 	/* Process legacy interrupts */
-- 
2.20.1

