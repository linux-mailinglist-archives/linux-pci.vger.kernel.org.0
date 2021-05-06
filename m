Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76638375751
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 17:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235782AbhEFPeH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 11:34:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235561AbhEFPdt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 11:33:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9EF3D6141A;
        Thu,  6 May 2021 15:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620315171;
        bh=yxzpn2O/vp9ZZpPVLIJ+HQxJFsDjVUX2z2EPhOuwt1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KEyqYxHdE7ZKmqjuMa/tEldb+IFNCvdsnbMTcFJDpDGF7POsd9s6fhKcJUwDgPT/C
         3f0Z+T0MNS32RTBEk0NTQvVoHdkQloqQxVrw05z3izZJJENXMswtI+eUYPmcgduWNS
         QywErnFwoTp2UfCkgt0j2HApyfl+hDCBrh3gqnwNbgAyQ/m3Wb+YSUO5HiWGd1YPtH
         oi+4BaBU1AKU3EISacHwGauI0j3g8fUx9d+C/AjaUBbUJRDKnu8jnwHpD/N48j6uWT
         usMapfP502CQ3KBtQyqsxnP4N/7Q1w3DhggOMHQxw70zNll/qekFxqJ2zeidVorYDL
         KlHt+MTfZ2q1g==
Received: by pali.im (Postfix)
        id 56A2A89A; Thu,  6 May 2021 17:32:50 +0200 (CEST)
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
Subject: [PATCH 21/42] PCI: aardvark: Add support for masking MSI interrupts
Date:   Thu,  6 May 2021 17:31:32 +0200
Message-Id: <20210506153153.30454-22-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506153153.30454-1-pali@kernel.org>
References: <20210506153153.30454-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Aardvark HW does not support masking individual MSI interrupts. It supports
masking only whole equivalence classes which consist of MSI interrupts with
same lower 5 bits. So mask a whole equivalence class only if all interrupts
in this class are masked.

For each equivalence class store a reference counter to indicate how many
unmasked interrupts are in this class. Use this counter to decide when this
class of MSI interrupts can be masked.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 77 ++++++++++++++++++++++++---
 1 file changed, 69 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index d74e84b0e689..376f0666becc 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -202,6 +202,7 @@ struct advk_pcie {
 	struct msi_domain_info msi_domain_info;
 	DECLARE_BITMAP(msi_used_linear, MSI_IRQ_LINEAR_COUNT);
 	struct list_head msi_used_radix;
+	u16 msi_used_ec_refcnt[32];
 	struct mutex msi_used_lock;
 	int link_gen;
 	struct pci_bridge_emul bridge;
@@ -405,12 +406,10 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 	advk_writel(pcie, PCIE_ISR1_ALL_MASK, PCIE_ISR1_REG);
 	advk_writel(pcie, PCIE_IRQ_ALL_MASK, HOST_CTRL_INT_STATUS_REG);
 
-	/* Disable All ISR0/1 Sources */
+	/* Disable All ISR0/1 and MSI Sources */
 	advk_writel(pcie, PCIE_ISR0_ALL_MASK, PCIE_ISR0_MASK_REG);
 	advk_writel(pcie, PCIE_ISR1_ALL_MASK, PCIE_ISR1_MASK_REG);
-
-	/* Unmask all MSIs */
-	advk_writel(pcie, ~(u32)PCIE_MSI_ALL_MASK, PCIE_MSI_MASK_REG);
+	advk_writel(pcie, PCIE_MSI_ALL_MASK, PCIE_MSI_MASK_REG);
 
 	/* Unmask summary MSI interrupt */
 	reg = advk_readl(pcie, PCIE_ISR0_MASK_REG);
@@ -888,6 +887,54 @@ static int advk_msi_set_affinity(struct irq_data *irq_data,
 	return -EINVAL;
 }
 
+static void advk_msi_irq_mask(struct irq_data *d)
+{
+	struct advk_pcie *pcie = d->domain->host_data;
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	u8 idx = hwirq & 31;
+	u32 mask;
+
+	/*
+	 * Aardvark HW does not support masking individual MSI interrupts. It
+	 * supports masking only whole equivalence class idx which consist of
+	 * MSI interrupts with same low 5 bits. So mask equivalence class idx
+	 * only in case there is no used (unmasked) interrupt in this class.
+	 */
+
+	if (--pcie->msi_used_ec_refcnt[idx] > 0)
+		return;
+
+	mask = advk_readl(pcie, PCIE_MSI_MASK_REG);
+	mask |= BIT(idx);
+	advk_writel(pcie, mask, PCIE_MSI_MASK_REG);
+}
+
+static void advk_msi_irq_unmask(struct irq_data *d)
+{
+	struct advk_pcie *pcie = d->domain->host_data;
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	u8 idx = hwirq & 31;
+	u32 mask;
+
+	pcie->msi_used_ec_refcnt[idx]++;
+
+	mask = advk_readl(pcie, PCIE_MSI_MASK_REG);
+	mask &= ~BIT(idx);
+	advk_writel(pcie, mask, PCIE_MSI_MASK_REG);
+}
+
+static void advk_msi_top_irq_mask(struct irq_data *d)
+{
+	pci_msi_mask_irq(d);
+	irq_chip_mask_parent(d);
+}
+
+static void advk_msi_top_irq_unmask(struct irq_data *d)
+{
+	pci_msi_unmask_irq(d);
+	irq_chip_unmask_parent(d);
+}
+
 static int advk_msi_irq_domain_alloc(struct irq_domain *domain,
 				     unsigned int virq,
 				     unsigned int nr_irqs, void *args)
@@ -1025,9 +1072,13 @@ static int advk_pcie_init_msi_irq_domain(struct advk_pcie *pcie)
 	bottom_ic->name = "MSI";
 	bottom_ic->irq_compose_msi_msg = advk_msi_irq_compose_msi_msg;
 	bottom_ic->irq_set_affinity = advk_msi_set_affinity;
+	bottom_ic->irq_mask = advk_msi_irq_mask;
+	bottom_ic->irq_unmask = advk_msi_irq_unmask;
 
 	msi_ic = &pcie->msi_irq_chip;
 	msi_ic->name = "advk-MSI";
+	msi_ic->irq_mask = advk_msi_top_irq_mask;
+	msi_ic->irq_unmask = advk_msi_top_irq_unmask;
 
 	msi_di = &pcie->msi_domain_info;
 	msi_di->flags = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
@@ -1101,8 +1152,10 @@ static void advk_pcie_remove_irq_domain(struct advk_pcie *pcie)
 
 static void advk_pcie_handle_msi(struct advk_pcie *pcie)
 {
-	u32 msi_val, msi_mask, msi_status, msi_idx;
+	struct irq_data *irq_data;
+	u32 msi_val, msi_mask, msi_status;
 	u16 msi_data;
+	u8 msi_idx;
 	int virq;
 
 	msi_mask = advk_readl(pcie, PCIE_MSI_MASK_REG);
@@ -1119,11 +1172,19 @@ static void advk_pcie_handle_msi(struct advk_pcie *pcie)
 		 */
 		advk_writel(pcie, BIT(msi_idx), PCIE_MSI_STATUS_REG);
 		msi_data = advk_readl(pcie, PCIE_MSI_PAYLOAD_REG) & PCIE_MSI_DATA_MASK;
+
+		/*
+		 * Aardvark HW does not support masking individual MSI interrupts.
+		 * So call generic_handle_irq() only in case kernel has not masked
+		 * received MSI interrupt.
+		 */
 		virq = irq_find_mapping(pcie->msi_inner_domain, msi_data);
-		if (virq)
-			generic_handle_irq(virq);
-		else
+		irq_data = virq ? irq_get_irq_data(virq) : NULL;
+
+		if (!irq_data)
 			dev_err(&pcie->pdev->dev, "unexpected MSI 0x%04hx\n", msi_data);
+		else if (!irqd_irq_masked(irq_data))
+			generic_handle_irq(virq);
 	}
 
 	advk_writel(pcie, PCIE_ISR0_MSI_INT_PENDING,
-- 
2.20.1

