Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF3A46CDA5
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 07:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237812AbhLHGWw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 01:22:52 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:48914 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237786AbhLHGWv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 01:22:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2BF67CE2032
        for <linux-pci@vger.kernel.org>; Wed,  8 Dec 2021 06:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30989C341C8;
        Wed,  8 Dec 2021 06:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638944357;
        bh=UqbpW9Oerpj2Y97ThByxn3L9c44W3OZJNk1Xw4zSY6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XL3sgjppf9bdyYBXWknHcW+DTCNcxKUWJlnEuo2ytePmp9fuHrKeKv99uR51uO6kC
         1oeeWQsOM7uUifcaRKsvVIN9Zm+YGaKEc888sM0YsG7F+iGsCuxKvarr8J7UNgS87G
         yR/wN4pTNpQVKkNXh4N9sHhdiKyo0E/CikNdPZ+a3bduKU8G7F/bakXff7D+Rqc5uQ
         3/bNNoDvNqK6w3T20HjQnAUEFMzCeV5Kzxgto1QewIeMgqa2r5Jt+E4phsIeaXiqc4
         UE3P17eiUJkaQRDrQpPCFXdKoPe9UNuH4vCXvUD5R8CEfhjhIHmJRoseDFAP5+DAMV
         aOeElzlLN1mVQ==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-pci@vger.kernel.org, pali@kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 13/17] PCI: aardvark: Fix support for PME requester on emulated bridge
Date:   Wed,  8 Dec 2021 07:18:47 +0100
Message-Id: <20211208061851.31867-14-kabel@kernel.org>
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

Enable aardvark PME interrupt unconditionally by unmasking it and read PME
requester ID to emulated bridge config space immediately after receiving
interrupt.

PME requester ID is stored in the PCIE_MSG_LOG_REG register, which contains
the last inbound message. So when new inbound message is received by HW
(including non-PM), the content in PCIE_MSG_LOG_REG register is replaced by
a new value.

PCIe specification mandates that subsequent PMEs are kept pending until the
PME Status Register bit is cleared by software by writing a 1b.

Support for masking/unmasking PME interrupt on emulated bridge via
PCI_EXP_RTCTL_PMEIE bit is now implemented only in emulated bridge config
space, to ensure that we do not miss any aardvark PME interrupt.

Reading of PCI_EXP_RTCAP and PCI_EXP_RTSTA registers is simplified as final
value is now always stored into emulated bridge config space by the
interrupt handler, so there is no need to implement support for these
registers in read_pcie callback.

Clearing of W1C bit PCI_EXP_RTSTA_PME is now also simplified as it is done
by pci-bridge-emul.c code for emulated bridge config space. So there is no
need to implement support for clearing this bit in write_pcie callback.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 90 +++++++++++++++------------
 1 file changed, 49 insertions(+), 41 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 3cf454ddc005..bea44bd5cc0c 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -598,6 +598,11 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 	reg &= ~PCIE_ISR0_MSI_INT_PENDING;
 	advk_writel(pcie, reg, PCIE_ISR0_MASK_REG);
 
+	/* Unmask PME interrupt for processing of PME requester */
+	reg = advk_readl(pcie, PCIE_ISR0_MASK_REG);
+	reg &= ~PCIE_MSG_PM_PME_MASK;
+	advk_writel(pcie, reg, PCIE_ISR0_MASK_REG);
+
 	/* Enable summary interrupt for GIC SPI source */
 	reg = PCIE_IRQ_ALL_MASK & (~PCIE_IRQ_ENABLE_INTS_MASK);
 	advk_writel(pcie, reg, HOST_CTRL_INT_MASK_REG);
@@ -872,22 +877,11 @@ advk_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
 		*value = PCI_EXP_SLTSTA_PDS << 16;
 		return PCI_BRIDGE_EMUL_HANDLED;
 
-	case PCI_EXP_RTCTL: {
-		u32 val = advk_readl(pcie, PCIE_ISR0_MASK_REG);
-		*value = (val & PCIE_MSG_PM_PME_MASK) ? 0 : PCI_EXP_RTCTL_PMEIE;
-		*value |= le16_to_cpu(bridge->pcie_conf.rootctl) & PCI_EXP_RTCTL_CRSSVE;
-		*value |= PCI_EXP_RTCAP_CRSVIS << 16;
-		return PCI_BRIDGE_EMUL_HANDLED;
-	}
-
-	case PCI_EXP_RTSTA: {
-		u32 isr0 = advk_readl(pcie, PCIE_ISR0_REG);
-		u32 msglog = advk_readl(pcie, PCIE_MSG_LOG_REG);
-		*value = msglog >> 16;
-		if (isr0 & PCIE_MSG_PM_PME_MASK)
-			*value |= PCI_EXP_RTSTA_PME;
-		return PCI_BRIDGE_EMUL_HANDLED;
-	}
+	/*
+	 * PCI_EXP_RTCTL and PCI_EXP_RTSTA are also supported, but do not need
+	 * to be handled here, because their values are stored in emulated
+	 * config space buffer, and we read them from there when needed.
+	 */
 
 	case PCI_EXP_LNKCAP: {
 		u32 val = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + reg);
@@ -942,22 +936,19 @@ advk_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 			advk_pcie_wait_for_retrain(pcie);
 		break;
 
-	case PCI_EXP_RTCTL:
-		/* Only mask/unmask PME interrupt */
-		if (mask & PCI_EXP_RTCTL_PMEIE) {
-			u32 val = advk_readl(pcie, PCIE_ISR0_MASK_REG);
-			if (new & PCI_EXP_RTCTL_PMEIE)
-				val &= ~PCIE_MSG_PM_PME_MASK;
-			else
-				val |= PCIE_MSG_PM_PME_MASK;
-			advk_writel(pcie, val, PCIE_ISR0_MASK_REG);
-		}
+	case PCI_EXP_RTCTL: {
+		u16 rootctl = le16_to_cpu(bridge->pcie_conf.rootctl);
+		/* Only emulation of PMEIE and CRSSVE bits is provided */
+		rootctl &= PCI_EXP_RTCTL_PMEIE | PCI_EXP_RTCTL_CRSSVE;
+		bridge->pcie_conf.rootctl = cpu_to_le16(rootctl);
 		break;
+	}
 
-	case PCI_EXP_RTSTA:
-		if (new & PCI_EXP_RTSTA_PME)
-			advk_writel(pcie, PCIE_MSG_PM_PME_MASK, PCIE_ISR0_REG);
-		break;
+	/*
+	 * PCI_EXP_RTSTA is also supported, but does not need to be handled
+	 * here, because its value is stored in emulated config space buffer,
+	 * and we write it there when needed.
+	 */
 
 	case PCI_EXP_DEVCTL:
 	case PCI_EXP_DEVCTL2:
@@ -1459,6 +1450,31 @@ static void advk_pcie_remove_irq_domain(struct advk_pcie *pcie)
 	irq_domain_remove(pcie->irq_domain);
 }
 
+static void advk_pcie_handle_pme(struct advk_pcie *pcie)
+{
+	u32 requester = advk_readl(pcie, PCIE_MSG_LOG_REG) >> 16;
+
+	advk_writel(pcie, PCIE_MSG_PM_PME_MASK, PCIE_ISR0_REG);
+
+	/*
+	 * PCIE_MSG_LOG_REG contains the last inbound message, so store
+	 * the requester ID only when PME was not asserted yet.
+	 * Also do not trigger PME interrupt when PME is still asserted.
+	 */
+	if (!(le32_to_cpu(pcie->bridge.pcie_conf.rootsta) & PCI_EXP_RTSTA_PME)) {
+		pcie->bridge.pcie_conf.rootsta = cpu_to_le32(requester | PCI_EXP_RTSTA_PME);
+
+		/*
+		 * Trigger PME interrupt only if PMEIE bit in Root Control is set.
+		 * Aardvark HW returns zero for PCI_EXP_FLAGS_IRQ, so use PCIe interrupt 0.
+		 */
+		if (le16_to_cpu(pcie->bridge.pcie_conf.rootctl) & PCI_EXP_RTCTL_PMEIE) {
+			if (generic_handle_domain_irq(pcie->irq_domain, 0) == -EINVAL)
+				dev_err_ratelimited(&pcie->pdev->dev, "unhandled ERR IRQ\n");
+		}
+	}
+}
+
 static void advk_pcie_handle_msi(struct advk_pcie *pcie)
 {
 	u32 msi_val, msi_mask, msi_status, msi_idx;
@@ -1495,17 +1511,9 @@ static void advk_pcie_handle_int(struct advk_pcie *pcie)
 	isr1_mask = advk_readl(pcie, PCIE_ISR1_MASK_REG);
 	isr1_status = isr1_val & ((~isr1_mask) & PCIE_ISR1_ALL_MASK);
 
-	/* Process PME interrupt */
-	if (isr0_status & PCIE_MSG_PM_PME_MASK) {
-		/*
-		 * Do not clear PME interrupt bit in ISR0, it is cleared by IRQ
-		 * receiver by writing to the PCI_EXP_RTSTA register of emulated
-		 * root bridge. Aardvark HW returns zero for PCI_EXP_FLAGS_IRQ,
-		 * so use PCIe interrupt 0.
-		 */
-		if (generic_handle_domain_irq(pcie->irq_domain, 0) == -EINVAL)
-			dev_err_ratelimited(&pcie->pdev->dev, "unhandled PME IRQ\n");
-	}
+	/* Process PME interrupt as the first one to do not miss PME requester id */
+	if (isr0_status & PCIE_MSG_PM_PME_MASK)
+		advk_pcie_handle_pme(pcie);
 
 	/* Process ERR interrupt */
 	if (isr0_status & PCIE_ISR0_ERR_MASK) {
-- 
2.32.0

