Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C1F3F4E99
	for <lists+linux-pci@lfdr.de>; Mon, 23 Aug 2021 18:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhHWQls (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Aug 2021 12:41:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230281AbhHWQlr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Aug 2021 12:41:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 502D1613E6;
        Mon, 23 Aug 2021 16:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629736864;
        bh=dWR4jlQ/UFvfKF+DH7OfQ3Tzq7QBMMw9jwa5eR2m/yw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DVuEaKjjwiaY8IQIO9HhckEcFM/XaPdtH15ouR2HfdjA0tTVakL0pf5etfwK0boWE
         uoALyMIce31Qsn3yNWdqdUmeMMTIy/Hw0ie2LMFypZ+7UyvfOARosdu1zl7oWLiMlq
         m7TYoqIf1Qu/1AmcVQXpsv0UJVPZKwGlR9dZzW+EadrSJw0WRjJM31Biu9936mzGqU
         q9kOzftLnKw3XPvIJebpYGR7j08/IvfFOFWjz2iKFFJ82f04VZ7HuLwbAPZ8JjsNDg
         Wo0ZtHG5A5msHTPPLT9pQU1A6yKIZ4CNllHLxODxcsotwT8VwRoqRI4lSbngW2ZBx1
         nY18djZKoF4yA==
Received: by pali.im (Postfix)
        id 6831F251F; Mon, 23 Aug 2021 18:41:02 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        "Marc Zyngier" <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] PCI: aardvark: Fix masking MSI interrupts
Date:   Mon, 23 Aug 2021 18:40:32 +0200
Message-Id: <20210823164033.27491-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210823164033.27491-1-pali@kernel.org>
References: <20210815103624.19528-1-pali@kernel.org>
 <20210823164033.27491-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Masking of individual MSI interrupts is done via PCIE_MSI_MASK_REG
register. At the driver probe time mask all MSI interrupts and then let
kernel IRQ chip code to unmask particular MSI interrupt when needed.

Signed-off-by: Pali Rohár <pali@kernel.org>
Cc: stable@vger.kernel.org # f21a8b1b6837 ("PCI: aardvark: Move to MSI handling using generic MSI support")

---
Changes in v2:
* Guard register updates by raw spin lock
---
 drivers/pci/controller/pci-aardvark.c | 52 ++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 81c4a9ff91a3..0e81d7f37465 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -241,6 +241,7 @@ struct advk_pcie {
 	struct irq_domain *msi_inner_domain;
 	struct irq_chip msi_bottom_irq_chip;
 	struct irq_chip msi_irq_chip;
+	raw_spinlock_t msi_irq_lock;
 	struct msi_domain_info msi_domain_info;
 	DECLARE_BITMAP(msi_used, MSI_IRQ_NUM);
 	struct mutex msi_used_lock;
@@ -481,12 +482,10 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
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
@@ -1051,6 +1050,46 @@ static int advk_msi_set_affinity(struct irq_data *irq_data,
 	return -EINVAL;
 }
 
+static void advk_msi_irq_mask(struct irq_data *d)
+{
+	struct advk_pcie *pcie = d->domain->host_data;
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	unsigned long flags;
+	u32 mask;
+
+	raw_spin_lock_irqsave(&pcie->msi_irq_lock, flags);
+	mask = advk_readl(pcie, PCIE_MSI_MASK_REG);
+	mask |= BIT(hwirq);
+	advk_writel(pcie, mask, PCIE_MSI_MASK_REG);
+	raw_spin_unlock_irqrestore(&pcie->msi_irq_lock, flags);
+}
+
+static void advk_msi_irq_unmask(struct irq_data *d)
+{
+	struct advk_pcie *pcie = d->domain->host_data;
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	unsigned long flags;
+	u32 mask;
+
+	raw_spin_lock_irqsave(&pcie->msi_irq_lock, flags);
+	mask = advk_readl(pcie, PCIE_MSI_MASK_REG);
+	mask &= ~BIT(hwirq);
+	advk_writel(pcie, mask, PCIE_MSI_MASK_REG);
+	raw_spin_unlock_irqrestore(&pcie->msi_irq_lock, flags);
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
@@ -1143,6 +1182,7 @@ static int advk_pcie_init_msi_irq_domain(struct advk_pcie *pcie)
 	struct irq_chip *bottom_ic, *msi_ic;
 	struct msi_domain_info *msi_di;
 
+	raw_spin_lock_init(&pcie->msi_irq_lock);
 	mutex_init(&pcie->msi_used_lock);
 
 	bottom_ic = &pcie->msi_bottom_irq_chip;
@@ -1150,9 +1190,13 @@ static int advk_pcie_init_msi_irq_domain(struct advk_pcie *pcie)
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
-- 
2.20.1

