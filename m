Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B27375758
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 17:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbhEFPeM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 11:34:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235610AbhEFPdu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 11:33:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4DD86147E;
        Thu,  6 May 2021 15:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620315172;
        bh=XSMv0I/QDrKbiP+dMRWG7vUJ6CvFhsuNwavmAeULpqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W0WyADJSXGoh3a/vZpkVZmGTpx4WLbcZqMo/v639+04vX8rWMvDQXbYkg0TXzAUBn
         B15MK53F7ZuNJCOEI5a081bbpsPLqGA4Oq6uM3RjF+2ONctil1h8eQJINed8lIdr5F
         xDhbeV7ccDSas1j5+F5Wn6RA4B8VLo+q8SjQuP0xzzuWIS927jct2O6HGjfkrk39SR
         PPgUh1GbhdCDHLGrCXaRzBt+YM/eRBGskj9068CfMqDxCQYWDhB5Gt6sMttrz2Uf5U
         eNXArkP/BtiIab3AHvXOcUCLNpianEY3PmEZePpNH+fQtuJPtPee8cQqE8L+iN1hCz
         bop5pwirNZi9Q==
Received: by pali.im (Postfix)
        id 8A6CA732; Thu,  6 May 2021 17:32:51 +0200 (CEST)
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
Subject: [PATCH 25/42] PCI: aardvark: Fix support for PME requester on emulated bridge
Date:   Thu,  6 May 2021 17:31:36 +0200
Message-Id: <20210506153153.30454-26-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506153153.30454-1-pali@kernel.org>
References: <20210506153153.30454-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PME requester id is stored in the PCIE_MSG_LOG_REG register, which contains
the last inbound message. So when new inbound message is received by HW
(including non-PM), the content in PCIE_MSG_LOG_REG register is replaced by
a new value.

PCIe specification mandates that subsequent PMEs are kept pending until the
PME Status Register bit is cleared by software by writing a 1b.

Enable aardvark PME interrupt unconditionally by unmasking it and read PME
requester id from PCIE_MSG_LOG_REG register to emulated bridge config space
immediately after receiving interrupt.

Support for masking/unmasking PME interrupt on emulated bridge via
PCI_EXP_RTCTL_PMEIE bit is now implemented only in emulated bridge config
space, to ensure that we do not miss any aardvark PME interrupt.

Reading of PCI_EXP_RTCAP and PCI_EXP_RTSTA registers is simplified as final
value is now always stored into emulated bridge config space by the
interrupt handler, so there is no need to implement support for these
registers in read_pcie callback.

Clearing of W1C bit PCI_EXP_RTSTA_PME is now also simplified as it is done
by pci-bridge-emul.c code for emulated bridge config space. So there is no
need to implement support for clearing this bit in write_pcie callback.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Fixes: 8a3ebd8de328 ("PCI: aardvark: Implement emulated root PCI bridge config space")
Cc: stable@vger.kernel.org # c0f05a6ab525 ("PCI: aardvark: Fix PCI_EXP_RTCTL register configuration")
---
 drivers/pci/controller/pci-aardvark.c | 81 ++++++++++++---------------
 1 file changed, 36 insertions(+), 45 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index fac48797d922..6c860e67e5a2 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -424,6 +424,11 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 	reg &= ~(PCIE_ISR0_FAT_ERR | PCIE_ISR0_NFAT_ERR | PCIE_ISR0_CORR_ERR);
 	advk_writel(pcie, reg, PCIE_ISR0_MASK_REG);
 
+	/* Unmask PME interrupt for processing of PME requester */
+	reg = advk_readl(pcie, PCIE_ISR0_MASK_REG);
+	reg &= ~PCIE_MSG_PM_PME_MASK;
+	advk_writel(pcie, reg, PCIE_ISR0_MASK_REG);
+
 	/* Enable summary interrupt for GIC SPI source */
 	reg = PCIE_IRQ_ALL_MASK & (~PCIE_IRQ_ENABLE_INTS_MASK);
 	advk_writel(pcie, reg, HOST_CTRL_INT_MASK_REG);
@@ -557,30 +562,17 @@ advk_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
 {
 	struct advk_pcie *pcie = bridge->data;
 
+	/*
+	 * PCI_EXP_RTCTL and PCI_EXP_RTSTA registers are fully supported
+	 * but their values are stored only in emulated config space buffer.
+	 * So there is no need to handle them in read_pcie callback.
+	 */
 
 	switch (reg) {
 	case PCI_EXP_SLTCTL:
 		*value = PCI_EXP_SLTSTA_PDS << 16;
 		return PCI_BRIDGE_EMUL_HANDLED;
 
-	case PCI_EXP_RTCTL: {
-		u32 val = advk_readl(pcie, PCIE_ISR0_MASK_REG);
-		*value = (val & PCIE_MSG_PM_PME_MASK) ? 0 : PCI_EXP_RTCTL_PMEIE;
-		*value |= PCI_EXP_RTCTL_CRSSVE;
-		*value |= PCI_EXP_RTCAP_CRSVIS << 16;
-		return PCI_BRIDGE_EMUL_HANDLED;
-	}
-
-	case PCI_EXP_RTSTA: {
-		u32 isr0 = advk_readl(pcie, PCIE_ISR0_REG);
-		u32 msglog = advk_readl(pcie, PCIE_MSG_LOG_REG);
-		u32 val = msglog >> 16;
-		if (isr0 & PCIE_MSG_PM_PME_MASK)
-			val |= PCI_EXP_RTSTA_PME;
-		*value = val;
-		return PCI_BRIDGE_EMUL_HANDLED;
-	}
-
 	case PCI_EXP_LNKCTL: {
 		/* u32 contains both PCI_EXP_LNKCTL and PCI_EXP_LNKSTA */
 		u32 val = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + reg) &
@@ -609,6 +601,12 @@ advk_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 {
 	struct advk_pcie *pcie = bridge->data;
 
+	/*
+	 * PCI_EXP_RTCTL and PCI_EXP_RTSTA registers are fully supported
+	 * but their values are stored only in emulated config space buffer.
+	 * So there is no need to handle them in write_pcie callback.
+	 */
+
 	switch (reg) {
 	case PCI_EXP_DEVCTL:
 		advk_writel(pcie, new, PCIE_CORE_PCIEXP_CAP + reg);
@@ -620,23 +618,6 @@ advk_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 			advk_pcie_wait_for_retrain(pcie);
 		break;
 
-	case PCI_EXP_RTCTL:
-		/* Only mask/unmask PME interrupt */
-		if (mask & PCI_EXP_RTCTL_PMEIE) {
-			u32 val = advk_readl(pcie, PCIE_ISR0_MASK_REG);
-			if ((new & PCI_EXP_RTCTL_PMEIE) == 0)
-				val |= PCIE_MSG_PM_PME_MASK;
-			else
-				val &= ~PCIE_MSG_PM_PME_MASK;
-			advk_writel(pcie, val, PCIE_ISR0_MASK_REG);
-		}
-		break;
-
-	case PCI_EXP_RTSTA:
-		if (new & PCI_EXP_RTSTA_PME)
-			advk_writel(pcie, PCIE_MSG_PM_PME_MASK, PCIE_ISR0_REG);
-		break;
-
 	default:
 		break;
 	}
@@ -1224,19 +1205,29 @@ static void advk_pcie_handle_int(struct advk_pcie *pcie)
 	if (!isr0_status && !isr1_status)
 		return;
 
-	/* Process PME interrupt */
+	/* Process PME interrupt as the first one to do not miss PME requester id */
 	if (isr0_status & PCIE_MSG_PM_PME_MASK) {
+		advk_writel(pcie, PCIE_MSG_PM_PME_MASK, PCIE_ISR0_REG);
 		/*
-		 * Do not clear PME interrupt bit in ISR0, it is cleared by IRQ
-		 * receiver by writing to the PCI_EXP_RTSTA register of emulated
-		 * root bridge. Aardvark HW returns zero for PCI_EXP_FLAGS_IRQ,
-		 * so use PCIe interrupt 0.
+		 * PCIE_MSG_LOG_REG contains the last inbound message,
+		 * so store requester id only when PME was not asserted yet.
+		 * Also do not trigger PME interrupt when PME is still asserted.
 		 */
-		virq = irq_find_mapping(pcie->irq_domain, 0);
-		if (virq)
-			generic_handle_irq(virq);
-		else
-			dev_err(&pcie->pdev->dev, "unexpected PME IRQ\n");
+		if (!(le32_to_cpu(pcie->bridge.pcie_conf.rootsta) & PCI_EXP_RTSTA_PME)) {
+			u32 requester = advk_readl(pcie, PCIE_MSG_LOG_REG) >> 16;
+			pcie->bridge.pcie_conf.rootsta = cpu_to_le32(requester | PCI_EXP_RTSTA_PME);
+			/*
+			 * Trigger PME interrupt only in case when PMEIE bit in Root Control is set.
+			 * Aardvark HW returns zero for PCI_EXP_FLAGS_IRQ, so use PCIe interrupt 0.
+			 */
+			if (le16_to_cpu(pcie->bridge.pcie_conf.rootctl) & PCI_EXP_RTCTL_PMEIE) {
+				virq = irq_find_mapping(pcie->irq_domain, 0);
+				if (virq)
+					generic_handle_irq(virq);
+				else
+					dev_err(&pcie->pdev->dev, "unexpected PME IRQ\n");
+			}
+		}
 	}
 
 	/* Process ERR interrupt */
-- 
2.20.1

