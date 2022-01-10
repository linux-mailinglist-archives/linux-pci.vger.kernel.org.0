Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2BA488E43
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jan 2022 02:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237992AbiAJBuq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Jan 2022 20:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237996AbiAJBuq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Jan 2022 20:50:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9559BC06173F
        for <linux-pci@vger.kernel.org>; Sun,  9 Jan 2022 17:50:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CC4560F55
        for <linux-pci@vger.kernel.org>; Mon, 10 Jan 2022 01:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF32C36AEF;
        Mon, 10 Jan 2022 01:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641779444;
        bh=ERQmAU7MrPTBRzQ0rEyO1Wp0w9GsgejBo78GbfwYwuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JaC7gjLqZwfzO6uSmJDq+wHFxuKSG138m2ailZHNjnJcJ0cm1h7sXrhhSbqjGRatO
         3TJuATLcMPPBbeW1sGFnergngHS7JZkuH/Sm/3pwKbG10hEEwyOj7xcVqB04icbuzY
         gPRQMzMv4+Md5rQ5ECpyhzQAkbxYthbCgC1mI8Sntfizidn4xHtQngvgy5935Jnw4B
         GlAjQeKF8cqItIeuotUI15BUfGXBtcNUuf3pbyU2k9lRt705DJU7qstNBLOOovSr9b
         +QGqV1VjpTikmuq9zJ8q5hw4CP5l4s4sUdqYH4FnpL45HXgidkAUbBmfGdqBKJ4YsG
         arzKDBgXhzQTQ==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 10/23] PCI: aardvark: Add support for masking MSI interrupts
Date:   Mon, 10 Jan 2022 02:50:05 +0100
Message-Id: <20220110015018.26359-11-kabel@kernel.org>
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

We should not unmask MSIs at setup, but only when kernel asks for them
to be unmasked.

At setup, mask all MSIs, and implement IRQ chip callbacks for masking
and unmasking particular MSIs.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 54 ++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 9d2462f076c1..51fedbcb41fb 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -275,6 +275,7 @@ struct advk_pcie {
 	raw_spinlock_t irq_lock;
 	struct irq_domain *msi_domain;
 	struct irq_domain *msi_inner_domain;
+	raw_spinlock_t msi_irq_lock;
 	DECLARE_BITMAP(msi_used, MSI_IRQ_NUM);
 	struct mutex msi_used_lock;
 	u16 msi_msg;
@@ -571,12 +572,10 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
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
@@ -1198,10 +1197,52 @@ static int advk_msi_set_affinity(struct irq_data *irq_data,
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
 static struct irq_chip advk_msi_bottom_irq_chip = {
 	.name			= "MSI",
 	.irq_compose_msi_msg	= advk_msi_irq_compose_msi_msg,
 	.irq_set_affinity	= advk_msi_set_affinity,
+	.irq_mask		= advk_msi_irq_mask,
+	.irq_unmask		= advk_msi_irq_unmask,
 };
 
 static int advk_msi_irq_domain_alloc(struct irq_domain *domain,
@@ -1291,7 +1332,9 @@ static const struct irq_domain_ops advk_pcie_irq_domain_ops = {
 };
 
 static struct irq_chip advk_msi_irq_chip = {
-	.name = "advk-MSI",
+	.name		= "advk-MSI",
+	.irq_mask	= advk_msi_top_irq_mask,
+	.irq_unmask	= advk_msi_top_irq_unmask,
 };
 
 static struct msi_domain_info advk_msi_domain_info = {
@@ -1305,6 +1348,7 @@ static int advk_pcie_init_msi_irq_domain(struct advk_pcie *pcie)
 	struct device *dev = &pcie->pdev->dev;
 	phys_addr_t msi_msg_phys;
 
+	raw_spin_lock_init(&pcie->msi_irq_lock);
 	mutex_init(&pcie->msi_used_lock);
 
 	msi_msg_phys = virt_to_phys(&pcie->msi_msg);
-- 
2.34.1

