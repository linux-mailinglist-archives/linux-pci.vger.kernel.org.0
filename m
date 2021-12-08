Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C748446CDA1
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 07:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237631AbhLHGWo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 01:22:44 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48372 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237762AbhLHGWo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 01:22:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1CBA2B81F77
        for <linux-pci@vger.kernel.org>; Wed,  8 Dec 2021 06:19:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B137BC00446;
        Wed,  8 Dec 2021 06:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638944350;
        bh=U0X3JCQcgY3UlCAvbPs+REhcx1k/K6JfqqcquZP7DbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B1oekkJmoqg3OtZR4IL9EbVGxAciqx5CMcuMesttaigpp5m+dngYJnquV2Lg+xMFb
         Z3oLZXSqYaZmJ8PzYcV/zEj3i/E+MkjMUTNm20d7ZFPghsAxwNrtBlRXoYjVmpbUNN
         xEefgFUN+f+f8m4sX0J9ZDuTNtE7642L2GuglBHiWVIV8CqZ09i5MTzuPBLZb3ssNt
         BGPC2XTREcMAmp9M+HrtoFVR6PSDgR4oli/hlWvZQsTrYbFHUJxG3hbEYE7iFMUBCG
         qVx3jh0P4FZ+SsjyyuQKRGhKXZLolSKISTT5O/77fTbj54ZvO64Ljf7NXl6HDRMPhO
         n7iT62fBt0/KQ==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-pci@vger.kernel.org, pali@kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 09/17] PCI: aardvark: Add support for ERR interrupt on emulated bridge
Date:   Wed,  8 Dec 2021 07:18:43 +0100
Message-Id: <20211208061851.31867-10-kabel@kernel.org>
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

ERR interrupt is triggered when corresponding bit is unmasked in both ISR0
and PCI_EXP_DEVCTL registers. Unmasking ERR bits in PCI_EXP_DEVCTL register
is not enough. This means that currently the ERR interrupt is never
triggered.

Unmask ERR bits in ISR0 register at driver probe time. ERR interrupt is not
triggered until ERR bits are unmasked also in PCI_EXP_DEVCTL register,
which is done by AER driver. So it is safe to unconditionally unmask all
ERR bits in aardvark probe.

Aardvark HW sets PCI_ERR_ROOT_AER_IRQ to zero and when corresponding bits
in ISR0 and PCI_EXP_DEVCTL are enabled, the HW triggers a generic interrupt
on GIC. Chain this interrupt to PCIe interrupt 0 with
generic_handle_domain_irq() to allow processing of ERR interrupts.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 35 ++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 24c67dc983e5..d5dcb3322d56 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -103,6 +103,10 @@
 #define PCIE_MSG_PM_PME_MASK			BIT(7)
 #define PCIE_ISR0_MASK_REG			(CONTROL_BASE_ADDR + 0x44)
 #define     PCIE_ISR0_MSI_INT_PENDING		BIT(24)
+#define     PCIE_ISR0_CORR_ERR			BIT(11)
+#define     PCIE_ISR0_NFAT_ERR			BIT(12)
+#define     PCIE_ISR0_FAT_ERR			BIT(13)
+#define     PCIE_ISR0_ERR_MASK			GENMASK(13, 11)
 #define     PCIE_ISR0_INTX_ASSERT(val)		BIT(16 + (val))
 #define     PCIE_ISR0_INTX_DEASSERT(val)	BIT(20 + (val))
 #define     PCIE_ISR0_ALL_MASK			GENMASK(31, 0)
@@ -790,11 +794,15 @@ advk_pci_bridge_emul_base_conf_read(struct pci_bridge_emul *bridge,
 	case PCI_INTERRUPT_LINE: {
 		/*
 		 * From the whole 32bit register we support reading from HW only
-		 * one bit: PCI_BRIDGE_CTL_BUS_RESET.
+		 * two bits: PCI_BRIDGE_CTL_BUS_RESET and PCI_BRIDGE_CTL_SERR.
 		 * Other bits are retrieved only from emulated config buffer.
 		 */
 		__le32 *cfgspace = (__le32 *)&bridge->conf;
 		u32 val = le32_to_cpu(cfgspace[PCI_INTERRUPT_LINE / 4]);
+		if (advk_readl(pcie, PCIE_ISR0_MASK_REG) & PCIE_ISR0_ERR_MASK)
+			val &= ~(PCI_BRIDGE_CTL_SERR << 16);
+		else
+			val |= PCI_BRIDGE_CTL_SERR << 16;
 		if (advk_readl(pcie, PCIE_CORE_CTRL1_REG) & HOT_RESET_GEN)
 			val |= PCI_BRIDGE_CTL_BUS_RESET << 16;
 		else
@@ -824,6 +832,19 @@ advk_pci_bridge_emul_base_conf_write(struct pci_bridge_emul *bridge,
 		break;
 
 	case PCI_INTERRUPT_LINE:
+		/*
+		 * According to Figure 6-3: Pseudo Logic Diagram for Error
+		 * Message Controls in PCIe base specification, SERR# Enable bit
+		 * in Bridge Control register enable receiving of ERR_* messages
+		 */
+		if (mask & (PCI_BRIDGE_CTL_SERR << 16)) {
+			u32 val = advk_readl(pcie, PCIE_ISR0_MASK_REG);
+			if (new & (PCI_BRIDGE_CTL_SERR << 16))
+				val &= ~PCIE_ISR0_ERR_MASK;
+			else
+				val |= PCIE_ISR0_ERR_MASK;
+			advk_writel(pcie, val, PCIE_ISR0_MASK_REG);
+		}
 		if (mask & (PCI_BRIDGE_CTL_BUS_RESET << 16)) {
 			u32 val = advk_readl(pcie, PCIE_CORE_CTRL1_REG);
 			if (new & (PCI_BRIDGE_CTL_BUS_RESET << 16))
@@ -1470,6 +1491,18 @@ static void advk_pcie_handle_int(struct advk_pcie *pcie)
 	isr1_mask = advk_readl(pcie, PCIE_ISR1_MASK_REG);
 	isr1_status = isr1_val & ((~isr1_mask) & PCIE_ISR1_ALL_MASK);
 
+	/* Process ERR interrupt */
+	if (isr0_status & PCIE_ISR0_ERR_MASK) {
+		advk_writel(pcie, PCIE_ISR0_ERR_MASK, PCIE_ISR0_REG);
+
+		/*
+		 * Aardvark HW returns zero for PCI_ERR_ROOT_AER_IRQ, so use
+		 * PCIe interrupt 0
+		 */
+		if (generic_handle_domain_irq(pcie->irq_domain, 0) == -EINVAL)
+			dev_err_ratelimited(&pcie->pdev->dev, "unhandled ERR IRQ\n");
+	}
+
 	/* Process MSI interrupts */
 	if (isr0_status & PCIE_ISR0_MSI_INT_PENDING)
 		advk_pcie_handle_msi(pcie);
-- 
2.32.0

