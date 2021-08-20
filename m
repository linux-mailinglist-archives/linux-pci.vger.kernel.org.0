Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E1A3F3023
	for <lists+linux-pci@lfdr.de>; Fri, 20 Aug 2021 17:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241078AbhHTPvR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Aug 2021 11:51:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238296AbhHTPvR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Aug 2021 11:51:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 356EB610FF;
        Fri, 20 Aug 2021 15:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629474639;
        bh=8CvVTyQLgyT4k1b1Kry/k0Zwq3bTzm48hEVEPj2TyQA=;
        h=From:To:Cc:Subject:Date:From;
        b=RrWyjeSbC8KF61Yxd8M5euzkXKYvhVUG9Rh0Q0CaEbPG0wjEAJ8a2hq2p7nrbHFL+
         O2bBCmrc394BgCoVDLKPTvasV/tKQikzIVV6OhJvn2545N2hWRpXS2b1j7u3KNHwqW
         A/vDSNB9xSs7EW41z32uXmlAEioP278nPKVBFbLLffmrsTk5wNjr88Shxvijsp6g6m
         tjyLBSf2W5TjsV5BtHZNB7Ngfg7/R/1i62TbhGtOQ8tnLHxPWKWxrbeYlZcyRXru8V
         tK4l2f837YRsIUz5I7n6L2O1Xet7vt01WEGbowpuhif7fRgiFhvp872+oUKji5xG4f
         MZ0E+W2OLL7QA==
Received: by pali.im (Postfix)
        id ADE627C5; Fri, 20 Aug 2021 17:50:36 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: aardvark: Fix masking and unmasking legacy INTx interrupts
Date:   Fri, 20 Aug 2021 17:50:20 +0200
Message-Id: <20210820155020.3000-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

irq_mask and irq_unmask callbacks need to be properly guarded by raw spin
locks as masking/unmasking procedure needs atomic read-modify-write
operation on hardware register.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reported-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-aardvark.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index fb8060160251..a49e8bad9f4f 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -234,6 +234,7 @@ struct advk_pcie {
 	u8 wins_count;
 	struct irq_domain *irq_domain;
 	struct irq_chip irq_chip;
+	raw_spinlock_t irq_lock;
 	struct irq_domain *msi_domain;
 	struct irq_domain *msi_inner_domain;
 	struct irq_chip msi_bottom_irq_chip;
@@ -1087,22 +1088,28 @@ static void advk_pcie_irq_mask(struct irq_data *d)
 {
 	struct advk_pcie *pcie = d->domain->host_data;
 	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	unsigned long flags;
 	u32 mask;
 
+	raw_spin_lock_irqsave(&pcie->irq_lock, flags);
 	mask = advk_readl(pcie, PCIE_ISR1_MASK_REG);
 	mask |= PCIE_ISR1_INTX_ASSERT(hwirq);
 	advk_writel(pcie, mask, PCIE_ISR1_MASK_REG);
+	raw_spin_unlock_irqrestore(&pcie->irq_lock, flags);
 }
 
 static void advk_pcie_irq_unmask(struct irq_data *d)
 {
 	struct advk_pcie *pcie = d->domain->host_data;
 	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	unsigned long flags;
 	u32 mask;
 
+	raw_spin_lock_irqsave(&pcie->irq_lock, flags);
 	mask = advk_readl(pcie, PCIE_ISR1_MASK_REG);
 	mask &= ~PCIE_ISR1_INTX_ASSERT(hwirq);
 	advk_writel(pcie, mask, PCIE_ISR1_MASK_REG);
+	raw_spin_unlock_irqrestore(&pcie->irq_lock, flags);
 }
 
 static int advk_pcie_irq_map(struct irq_domain *h,
@@ -1186,6 +1193,8 @@ static int advk_pcie_init_irq_domain(struct advk_pcie *pcie)
 	struct irq_chip *irq_chip;
 	int ret = 0;
 
+	raw_spin_lock_init(&pcie->irq_lock);
+
 	pcie_intc_node =  of_get_next_child(node, NULL);
 	if (!pcie_intc_node) {
 		dev_err(dev, "No PCIe Intc node found\n");
-- 
2.20.1

