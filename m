Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587315984CF
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 15:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245321AbiHRNwJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 09:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245316AbiHRNwI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 09:52:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F5461B0B
        for <linux-pci@vger.kernel.org>; Thu, 18 Aug 2022 06:52:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D589F616DC
        for <linux-pci@vger.kernel.org>; Thu, 18 Aug 2022 13:52:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04CFC43140;
        Thu, 18 Aug 2022 13:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660830726;
        bh=VWlDeVNSF8K5y9LwrhrOTt+8IGNO/UVbQ6FhhVMO6zE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tBLMCZCFSkhd3MF0YvDPuFdVEjDlCld1zLYdjqruPfyCxCFCJPsG5Iagf4C4rSTSx
         L5TQgiEzOXRAfqTTQqVjLWvthloBRjFRYFTTxWPvXJ8OoMHYXbNPDFOEQgaRCLkSWA
         9xVvm0Xt0Z741HFXbOGrUQ+u3VMrT7EqpG8Tb8lBfuMCiqzrGqpFCLmylp+W0E1Pdf
         0f9s6SGKAhEBdUP9er653kAAiptyyJo5Px+5SVSTdn73c5FwnaDgWIMmnysUCSTlFS
         k5gWGr21A1dsDxpdT8i8hd0PO2YmAMYvdIaITen+IBq5ja7OniJw7os0fxSlWxTiPK
         5cgous8+RQDYg==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        pali@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 11/11] PCI: aardvark: Cleanup some register macros
Date:   Thu, 18 Aug 2022 15:51:40 +0200
Message-Id: <20220818135140.5996-12-kabel@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220818135140.5996-1-kabel@kernel.org>
References: <20220818135140.5996-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Define SPEED_GEN_* macros with correct PCIE_GEN_SEL_SHIFT.

Simplify macro for setting root complex mode (use BIT instead of
MSK + SHIFT).

Rename PCIE_MSG_PM_PME_MASK to PCIE_ISR0_MSG_PM_PME to match existing
naming convention, rename PCIE_ISR0_MSI_INT_PENDING to PCIE_ISR0_MSI_INT
as it is used for both interrupt mask and pending bit.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 28 +++++++++++++--------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 73a604f70f06..11afafe71e3d 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -66,11 +66,10 @@
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
@@ -95,16 +94,16 @@
 #define     PCIE_CORE_REF_CLK_RX_ENABLE		BIT(2)
 #define PCIE_MSG_LOG_REG			(CONTROL_BASE_ADDR + 0x30)
 #define PCIE_ISR0_REG				(CONTROL_BASE_ADDR + 0x40)
-#define PCIE_MSG_PM_PME_MASK			BIT(7)
 #define PCIE_ISR0_MASK_REG			(CONTROL_BASE_ADDR + 0x44)
-#define     PCIE_ISR0_MSI_INT_PENDING		BIT(24)
 #define     PCIE_ISR0_LINK_DOWN			BIT(1)
+#define     PCIE_ISR0_MSG_PM_PME		BIT(7)
 #define     PCIE_ISR0_CORR_ERR			BIT(11)
 #define     PCIE_ISR0_NFAT_ERR			BIT(12)
 #define     PCIE_ISR0_FAT_ERR			BIT(13)
 #define     PCIE_ISR0_ERR_MASK			GENMASK(13, 11)
 #define     PCIE_ISR0_INTX_ASSERT(val)		BIT(16 + (val))
 #define     PCIE_ISR0_INTX_DEASSERT(val)	BIT(20 + (val))
+#define     PCIE_ISR0_MSI_INT			BIT(24)
 #define     PCIE_ISR0_ALL_MASK			GENMASK(31, 0)
 #define PCIE_ISR1_REG				(CONTROL_BASE_ADDR + 0x48)
 #define PCIE_ISR1_MASK_REG			(CONTROL_BASE_ADDR + 0x4C)
@@ -546,7 +545,7 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 
 	/* Set PCI global control register to RC mode */
 	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
-	reg |= (IS_RC_MSK << IS_RC_SHIFT);
+	reg |= IS_RC;
 	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
 
 	/*
@@ -633,7 +632,7 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 
 	/* Unmask summary MSI interrupt */
 	reg = advk_readl(pcie, PCIE_ISR0_MASK_REG);
-	reg &= ~PCIE_ISR0_MSI_INT_PENDING;
+	reg &= ~PCIE_ISR0_MSI_INT;
 	advk_writel(pcie, reg, PCIE_ISR0_MASK_REG);
 
 	/* Unmask Link Down interrupt */
@@ -643,7 +642,7 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 
 	/* Unmask PME interrupt for processing of PME requester */
 	reg = advk_readl(pcie, PCIE_ISR0_MASK_REG);
-	reg &= ~PCIE_MSG_PM_PME_MASK;
+	reg &= ~PCIE_ISR0_MSG_PM_PME;
 	advk_writel(pcie, reg, PCIE_ISR0_MASK_REG);
 
 	/* Enable summary interrupt for GIC SPI source */
@@ -1661,7 +1660,7 @@ static void advk_pcie_handle_pme(struct advk_pcie *pcie)
 {
 	u32 requester = advk_readl(pcie, PCIE_MSG_LOG_REG) >> 16;
 
-	advk_writel(pcie, PCIE_MSG_PM_PME_MASK, PCIE_ISR0_REG);
+	advk_writel(pcie, PCIE_ISR0_MSG_PM_PME, PCIE_ISR0_REG);
 
 	/*
 	 * PCIE_MSG_LOG_REG contains the last inbound message, so store
@@ -1700,8 +1699,7 @@ static void advk_pcie_handle_msi(struct advk_pcie *pcie)
 			dev_err_ratelimited(&pcie->pdev->dev, "unexpected MSI 0x%02x\n", msi_idx);
 	}
 
-	advk_writel(pcie, PCIE_ISR0_MSI_INT_PENDING,
-		    PCIE_ISR0_REG);
+	advk_writel(pcie, PCIE_ISR0_MSI_INT, PCIE_ISR0_REG);
 }
 
 static void advk_pcie_handle_int(struct advk_pcie *pcie)
@@ -1720,7 +1718,7 @@ static void advk_pcie_handle_int(struct advk_pcie *pcie)
 	isr1_status = isr1_val & ((~isr1_mask) & PCIE_ISR1_ALL_MASK);
 
 	/* Process PME interrupt as the first one to do not miss PME requester id */
-	if (isr0_status & PCIE_MSG_PM_PME_MASK)
+	if (isr0_status & PCIE_ISR0_MSG_PM_PME)
 		advk_pcie_handle_pme(pcie);
 
 	/* Process ERR interrupt */
@@ -1756,7 +1754,7 @@ static void advk_pcie_handle_int(struct advk_pcie *pcie)
 	}
 
 	/* Process MSI interrupts */
-	if (isr0_status & PCIE_ISR0_MSI_INT_PENDING)
+	if (isr0_status & PCIE_ISR0_MSI_INT)
 		advk_pcie_handle_msi(pcie);
 
 	/* Process legacy interrupts */
-- 
2.35.1

