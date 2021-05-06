Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34223375754
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 17:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbhEFPeL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 11:34:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235595AbhEFPdu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 11:33:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87A2861466;
        Thu,  6 May 2021 15:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620315171;
        bh=urrwtdifV1fz+XQqM6L88XpER1LnRW6X4GCyTMrByDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IAhpZGoDLMr/XM36LpXnUhmpuYoUZemfa69scs/apqACQh8Asvic7XO+S0i337uGG
         DK1TdARfwbJny6lEsfYGdy1RdSSEhR/bw7uHhwcC8KpAek/F3+Tku2/6MhxRgl5E9S
         B2JbMXxo+u6kSPTDkEXBYaK8lAsaPQ5TsrFofh5JOjKvaeZHzMFcaofoc611m/+MgC
         FelmH4b66mUm0cvRU94SCd/dnm3n+yYWLC4APmCYOplQps7e7PJ9tDL6xaV0TWHElc
         B/rQ+nPd5mK4m2ElrKyiO7kmvRnJJhGjVbabnGOWKFIesVYwP6T/MZdI2lVk0UTSRm
         NbDcjjm9Jmy4g==
Received: by pali.im (Postfix)
        id 3DA1589A; Thu,  6 May 2021 17:32:51 +0200 (CEST)
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
Subject: [PATCH 24/42] PCI: aardvark: Fix support for PME on emulated bridge
Date:   Thu,  6 May 2021 17:31:35 +0200
Message-Id: <20210506153153.30454-25-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506153153.30454-1-pali@kernel.org>
References: <20210506153153.30454-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The emulated bridge returns incorrect value for PCI_EXP_RTSTA register
during readout in advk_pci_bridge_emul_pcie_conf_read() function. Fix it by
setting correct bit PCI_EXP_RTSTA_PME based on PCIE_MSG_PM_PME_MASK.

Currently enabling PCI_EXP_RTSTA_PME bit in PCI_EXP_RTCTL register does
nothing. This is because PCIe PME driver expects to receive PCIe interrupt
defined in PCI_EXP_FLAGS_IRQ register. But aardvark hardware does not
trigger PCIe INTx/MSI interrupt for PME event, rather it triggers custom
aardvark interrupt which this driver is not processing yet.

Fix this issue by handling PME interrupt in advk_pcie_handle_int() and
chaining it to PCIe interrupt 0 with generic_handle_irq() (since aardvark
hardware sets PCI_EXP_FLAGS_IRQ to zero). With this change PCIe PME driver
finally starts receiving PME interrupt.

To optimize advk_pci_bridge_emul_pcie_conf_write() code, touch
PCIE_ISR0_REG and PCIE_ISR0_MASK_REG registers only when it is really
needed, when processing PCI_EXP_RTCTL_PMEIE and PCI_EXP_RTSTA_PME bits.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Fixes: 8a3ebd8de328 ("PCI: aardvark: Implement emulated root PCI bridge config space")
Cc: stable@vger.kernel.org # c0f05a6ab525 ("PCI: aardvark: Fix PCI_EXP_RTCTL register configuration")
---
 drivers/pci/controller/pci-aardvark.c | 40 ++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 2ea58ba10a97..fac48797d922 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -574,7 +574,10 @@ advk_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
 	case PCI_EXP_RTSTA: {
 		u32 isr0 = advk_readl(pcie, PCIE_ISR0_REG);
 		u32 msglog = advk_readl(pcie, PCIE_MSG_LOG_REG);
-		*value = (isr0 & PCIE_MSG_PM_PME_MASK) << 16 | (msglog >> 16);
+		u32 val = msglog >> 16;
+		if (isr0 & PCIE_MSG_PM_PME_MASK)
+			val |= PCI_EXP_RTSTA_PME;
+		*value = val;
 		return PCI_BRIDGE_EMUL_HANDLED;
 	}
 
@@ -617,19 +620,21 @@ advk_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 			advk_pcie_wait_for_retrain(pcie);
 		break;
 
-	case PCI_EXP_RTCTL: {
+	case PCI_EXP_RTCTL:
 		/* Only mask/unmask PME interrupt */
-		u32 val = advk_readl(pcie, PCIE_ISR0_MASK_REG) &
-			~PCIE_MSG_PM_PME_MASK;
-		if ((new & PCI_EXP_RTCTL_PMEIE) == 0)
-			val |= PCIE_MSG_PM_PME_MASK;
-		advk_writel(pcie, val, PCIE_ISR0_MASK_REG);
+		if (mask & PCI_EXP_RTCTL_PMEIE) {
+			u32 val = advk_readl(pcie, PCIE_ISR0_MASK_REG);
+			if ((new & PCI_EXP_RTCTL_PMEIE) == 0)
+				val |= PCIE_MSG_PM_PME_MASK;
+			else
+				val &= ~PCIE_MSG_PM_PME_MASK;
+			advk_writel(pcie, val, PCIE_ISR0_MASK_REG);
+		}
 		break;
-	}
 
 	case PCI_EXP_RTSTA:
-		new = (new & PCI_EXP_RTSTA_PME) >> 9;
-		advk_writel(pcie, new, PCIE_ISR0_REG);
+		if (new & PCI_EXP_RTSTA_PME)
+			advk_writel(pcie, PCIE_MSG_PM_PME_MASK, PCIE_ISR0_REG);
 		break;
 
 	default:
@@ -1219,6 +1224,21 @@ static void advk_pcie_handle_int(struct advk_pcie *pcie)
 	if (!isr0_status && !isr1_status)
 		return;
 
+	/* Process PME interrupt */
+	if (isr0_status & PCIE_MSG_PM_PME_MASK) {
+		/*
+		 * Do not clear PME interrupt bit in ISR0, it is cleared by IRQ
+		 * receiver by writing to the PCI_EXP_RTSTA register of emulated
+		 * root bridge. Aardvark HW returns zero for PCI_EXP_FLAGS_IRQ,
+		 * so use PCIe interrupt 0.
+		 */
+		virq = irq_find_mapping(pcie->irq_domain, 0);
+		if (virq)
+			generic_handle_irq(virq);
+		else
+			dev_err(&pcie->pdev->dev, "unexpected PME IRQ\n");
+	}
+
 	/* Process ERR interrupt */
 	if (err_bits) {
 		advk_writel(pcie, err_bits, PCIE_ISR0_REG);
-- 
2.20.1

