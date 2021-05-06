Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40642375753
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 17:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbhEFPeL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 11:34:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235591AbhEFPdt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 11:33:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3FFB261444;
        Thu,  6 May 2021 15:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620315171;
        bh=BNybo/imm7XJtoxFMKGPLmZE6NxN+kmKnZtaTUumbOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VwIB4YyNY1qalXOuifdY/OX5Lr5ZidlVIaCsWkaCvH96DGZoQbfGYIf5ISVob5+KE
         pN5GegVfTHQ1KT+VK+tlRGJMH8onCaGV4sPkRiymB1JxdF2H12vBvuw8IyfyNhFnWK
         QQ1/Bq9NXvpvj3yTVBhL1YsuZoK3IFcSTj+QDJuiKxl5qfBxrGd0ezg4Pu0T1tgbZz
         ROZm4n41SXYyFFZKCXb+TobGeOc3oPmtIGKt1TT4TGXxWT/2XYAlY9+rQU/gaKm/Kf
         kodHF+9TrPMtie4G61xkoDnbSsIrBWB2+yeujXWJKQrX4r6MSm4hwczG3Zem8DCd2f
         JvTrdf6qptqMQ==
Received: by pali.im (Postfix)
        id E76C08A1; Thu,  6 May 2021 17:32:50 +0200 (CEST)
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
Subject: [PATCH 23/42] PCI: aardvark: Fix support for ERR interrupt on emulated bridge
Date:   Thu,  6 May 2021 17:31:34 +0200
Message-Id: <20210506153153.30454-24-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506153153.30454-1-pali@kernel.org>
References: <20210506153153.30454-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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
on GIC. Chain this interrupt to PCIe interrupt 0 with generic_handle_irq()
to allow processing of ERR interrupts.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Fixes: 8a3ebd8de328 ("PCI: aardvark: Implement emulated root PCI bridge config space")
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-aardvark.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 8a5133226e41..2ea58ba10a97 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -104,6 +104,9 @@
 #define PCIE_MSG_PM_PME_MASK			BIT(7)
 #define PCIE_ISR0_MASK_REG			(CONTROL_BASE_ADDR + 0x44)
 #define     PCIE_ISR0_MSI_INT_PENDING		BIT(24)
+#define     PCIE_ISR0_CORR_ERR			BIT(11)
+#define     PCIE_ISR0_NFAT_ERR			BIT(12)
+#define     PCIE_ISR0_FAT_ERR			BIT(13)
 #define     PCIE_ISR0_INTX_ASSERT(val)		BIT(16 + (val))
 #define     PCIE_ISR0_INTX_DEASSERT(val)	BIT(20 + (val))
 #define	    PCIE_ISR0_ALL_MASK			GENMASK(26, 0)
@@ -416,6 +419,11 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 	reg &= ~PCIE_ISR0_MSI_INT_PENDING;
 	advk_writel(pcie, reg, PCIE_ISR0_MASK_REG);
 
+	/* Unmask bits for ERR interrupt */
+	reg = advk_readl(pcie, PCIE_ISR0_MASK_REG);
+	reg &= ~(PCIE_ISR0_FAT_ERR | PCIE_ISR0_NFAT_ERR | PCIE_ISR0_CORR_ERR);
+	advk_writel(pcie, reg, PCIE_ISR0_MASK_REG);
+
 	/* Enable summary interrupt for GIC SPI source */
 	reg = PCIE_IRQ_ALL_MASK & (~PCIE_IRQ_ENABLE_INTS_MASK);
 	advk_writel(pcie, reg, HOST_CTRL_INT_MASK_REG);
@@ -1195,6 +1203,7 @@ static void advk_pcie_handle_int(struct advk_pcie *pcie)
 {
 	u32 isr0_val, isr0_mask, isr0_status;
 	u32 isr1_val, isr1_mask, isr1_status;
+	u32 err_bits;
 	int i, virq;
 
 	isr0_val = advk_readl(pcie, PCIE_ISR0_REG);
@@ -1205,9 +1214,22 @@ static void advk_pcie_handle_int(struct advk_pcie *pcie)
 	isr1_mask = advk_readl(pcie, PCIE_ISR1_MASK_REG);
 	isr1_status = isr1_val & ((~isr1_mask) & PCIE_ISR1_ALL_MASK);
 
+	err_bits = isr0_status & (PCIE_ISR0_FAT_ERR | PCIE_ISR0_NFAT_ERR | PCIE_ISR0_CORR_ERR);
+
 	if (!isr0_status && !isr1_status)
 		return;
 
+	/* Process ERR interrupt */
+	if (err_bits) {
+		advk_writel(pcie, err_bits, PCIE_ISR0_REG);
+		/* Aardvark HW returns zero for PCI_ERR_ROOT_AER_IRQ, so use PCIe interrupt 0 */
+		virq = irq_find_mapping(pcie->irq_domain, 0);
+		if (virq)
+			generic_handle_irq(virq);
+		else
+			dev_err(&pcie->pdev->dev, "unexpected ERR IRQ\n");
+	}
+
 	/* Process MSI interrupts */
 	if (isr0_status & PCIE_ISR0_MSI_INT_PENDING)
 		advk_pcie_handle_msi(pcie);
-- 
2.20.1

