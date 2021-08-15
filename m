Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44F63EC8A0
	for <lists+linux-pci@lfdr.de>; Sun, 15 Aug 2021 12:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237761AbhHOKhw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Aug 2021 06:37:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237637AbhHOKhY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 15 Aug 2021 06:37:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 150BE610CF;
        Sun, 15 Aug 2021 10:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629023814;
        bh=9LHHpQCvXqnA3Oe4ulBmqQhmwBb38lyNPdIXfguJNT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Flv1lqxWJO7vn0x1qSIfn6POYanQ9b1J2uVqjwiVy5kZ+MAaBHk078HZ5ph5nCINM
         xEAVMCUU6cO8U6IMTtT4a5VtSLssZ5kkx/bCT6I4QcgSjdhmLqmDLyBkcZTiWK8OLY
         D5gdObT4UVdsZQpzRzsbHkBN8xYD8wYtSuSjOHA20vBNYTZDOecoXTU1lZmRJG5MRF
         0DWkVpFLTCbqEygxyOvduYRQTiudOBPXGOpBJlKmtx5QrUdtgftNWg1J/KhtF9VgR/
         PiNSMTNHlnzESvD39pvzzuyX0+bV0s8gZDpWLzqKe546ILaYCBGQ4JvHO35QHKMfig
         RONFA3FLARaUw==
Received: by pali.im (Postfix)
        id 46D752824; Sun, 15 Aug 2021 12:36:52 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] PCI: aardvark: Fix masking MSI interrupts
Date:   Sun, 15 Aug 2021 12:36:23 +0200
Message-Id: <20210815103624.19528-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210815103624.19528-1-pali@kernel.org>
References: <20210815103624.19528-1-pali@kernel.org>
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
 drivers/pci/controller/pci-aardvark.c | 44 ++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index bacfccee44fe..96580e1e4539 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -480,12 +480,10 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
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
@@ -1026,6 +1024,40 @@ static int advk_msi_set_affinity(struct irq_data *irq_data,
 	return -EINVAL;
 }
 
+static void advk_msi_irq_mask(struct irq_data *d)
+{
+	struct advk_pcie *pcie = d->domain->host_data;
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	u32 mask;
+
+	mask = advk_readl(pcie, PCIE_MSI_MASK_REG);
+	mask |= BIT(hwirq);
+	advk_writel(pcie, mask, PCIE_MSI_MASK_REG);
+}
+
+static void advk_msi_irq_unmask(struct irq_data *d)
+{
+	struct advk_pcie *pcie = d->domain->host_data;
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	u32 mask;
+
+	mask = advk_readl(pcie, PCIE_MSI_MASK_REG);
+	mask &= ~BIT(hwirq);
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
@@ -1119,9 +1151,13 @@ static int advk_pcie_init_msi_irq_domain(struct advk_pcie *pcie)
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

