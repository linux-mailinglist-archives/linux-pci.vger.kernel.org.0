Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9380F46CD9D
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 07:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237765AbhLHGWl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 01:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237762AbhLHGWk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 01:22:40 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38925C061574
        for <linux-pci@vger.kernel.org>; Tue,  7 Dec 2021 22:19:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7C417CE2036
        for <linux-pci@vger.kernel.org>; Wed,  8 Dec 2021 06:19:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3A3C00446;
        Wed,  8 Dec 2021 06:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638944345;
        bh=S9AzuRj3zEnBPXDLtoAC5zlRtNj7u9WEjn+I97AjI3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZCS58etnGmN2EudPPTuyvxrEsveD3ZqpcLFcZrjEX40+aAm81XJCU3IILJuxMuF3d
         uQEqF8yYEaDWQCpw3gOVJcuiJCJNhTRFtTfkUSKI1uDYjNewHoYEaGh5TGfVi62nC3
         9WFziegS9UrJm3okTR5AqdUY9hwoJ6RNxBy4LUlUGbmUKx+Mn8Gi2P40T5wnbIWFq3
         odcw62H8Ope52J5GmYWd9Iv918qcJVxNfAoEasF2972mfDsR7uxOzi4+cUcCTNdJs5
         b35LcvdDrqPa/48JVhYzrAKIqzyvqgmTepLf8ekGPqd33KgElL3/4KIZr8wVhgyoaj
         YyhJ92NWGLRnQ==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-pci@vger.kernel.org, pali@kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 06/17] PCI: aardvark: Add support for masking MSI interrupts
Date:   Wed,  8 Dec 2021 07:18:40 +0100
Message-Id: <20211208061851.31867-7-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211208061851.31867-1-kabel@kernel.org>
References: <20211208061851.31867-1-kabel@kernel.org>
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

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 52 ++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index f03dd5d8213a..74b60cb2e6fd 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -281,6 +281,7 @@ struct advk_pcie {
 	struct irq_domain *msi_inner_domain;
 	struct irq_chip msi_bottom_irq_chip;
 	struct irq_chip msi_irq_chip;
+	raw_spinlock_t msi_irq_lock;
 	struct msi_domain_info msi_domain_info;
 	DECLARE_BITMAP(msi_used, MSI_IRQ_NUM);
 	struct mutex msi_used_lock;
@@ -578,12 +579,10 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
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
@@ -1205,6 +1204,46 @@ static int advk_msi_set_affinity(struct irq_data *irq_data,
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
@@ -1299,6 +1338,7 @@ static int advk_pcie_init_msi_irq_domain(struct advk_pcie *pcie)
 	struct msi_domain_info *msi_di;
 	phys_addr_t msi_msg_phys;
 
+	raw_spin_lock_init(&pcie->msi_irq_lock);
 	mutex_init(&pcie->msi_used_lock);
 
 	bottom_ic = &pcie->msi_bottom_irq_chip;
@@ -1306,9 +1346,13 @@ static int advk_pcie_init_msi_irq_domain(struct advk_pcie *pcie)
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

