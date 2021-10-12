Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0FD242A9C3
	for <lists+linux-pci@lfdr.de>; Tue, 12 Oct 2021 18:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhJLQoB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 12:44:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231671AbhJLQoB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Oct 2021 12:44:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C9C8610C9;
        Tue, 12 Oct 2021 16:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634056919;
        bh=JqILMU+QlYEBDXSATdbxuGjGipcrGzzPsX1jiWQpEfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HwT0wcrtH1vmhlc0MRL36gSSScEa9oBDEdnUFSDAD/wwAQc1qFLfxSb2r+8ux7K6b
         9vydZ5u2oaG/36SKHXG1PBdnzhSFU2/7/2VBVnVuz9rli5I3raArTqv+wuoI9GjxIu
         IeSDZZZR/9rOjlveoHF/7oeA4bj618o1e8x8brkHV1heuSVxgj3Fjw4v8J390SzQ6N
         +fAYrCc6pIHK34BmpMiSvjIV5irZ2vWVSNzDfL+RcKmVTXXFf11K3J+tDJYc3O6UAd
         I/WL5gpNRxgbQb0oY808FJciDcY7dUvgeUhKqVHVXWT9eUgr9imJrUAgROfH2ow4cM
         jmzmdTvEoVahA==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org, =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 08/14] PCI: aardvark: Fix masking MSI interrupts
Date:   Tue, 12 Oct 2021 18:41:39 +0200
Message-Id: <20211012164145.14126-9-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211012164145.14126-1-kabel@kernel.org>
References: <20211012164145.14126-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

We should not unmask MSIs at setup, but only when kernel asks for them
to be unmasked.

At setup, mask all MSIs, and implement IRQ chip callbacks for masking
and unmasking particular MSIs.

Fixes: 8c39d710363c ("PCI: aardvark: Add Aardvark PCI host controller driver")
Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
Cc: stable@vger.kernel.org # f21a8b1b6837 ("PCI: aardvark: Move to MSI handling using generic MSI support")
---
 drivers/pci/controller/pci-aardvark.c | 52 ++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index ab0a0864a300..1adb4c4b11b5 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -282,6 +282,7 @@ struct advk_pcie {
 	struct irq_domain *msi_inner_domain;
 	struct irq_chip msi_bottom_irq_chip;
 	struct irq_chip msi_irq_chip;
+	raw_spinlock_t msi_irq_lock;
 	struct msi_domain_info msi_domain_info;
 	DECLARE_BITMAP(msi_used, MSI_IRQ_NUM);
 	struct mutex msi_used_lock;
@@ -554,12 +555,10 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
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
@@ -1119,6 +1118,46 @@ static int advk_msi_set_affinity(struct irq_data *irq_data,
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
@@ -1213,6 +1252,7 @@ static int advk_pcie_init_msi_irq_domain(struct advk_pcie *pcie)
 	struct msi_domain_info *msi_di;
 	phys_addr_t msi_msg_phys;
 
+	raw_spin_lock_init(&pcie->msi_irq_lock);
 	mutex_init(&pcie->msi_used_lock);
 
 	bottom_ic = &pcie->msi_bottom_irq_chip;
@@ -1220,9 +1260,13 @@ static int advk_pcie_init_msi_irq_domain(struct advk_pcie *pcie)
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
2.32.0

