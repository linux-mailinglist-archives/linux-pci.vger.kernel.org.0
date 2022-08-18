Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF095984D1
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 15:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245059AbiHRNvy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 09:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245273AbiHRNvx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 09:51:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BB26110B
        for <linux-pci@vger.kernel.org>; Thu, 18 Aug 2022 06:51:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 960A3615FB
        for <linux-pci@vger.kernel.org>; Thu, 18 Aug 2022 13:51:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDF3C433D6;
        Thu, 18 Aug 2022 13:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660830711;
        bh=cWiFKrjn8B1g5TW9Qk+4fkbMr0616y3TR9z10rI81Hs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mcOkz4dHwq1e3ouY2wgh+BAZgSl/GMiYwvVnaS2TANd7fGKkewcq15vmtJobjfofh
         PvDmGiCHFo1HXBs2G6fHyXfGEK4du4FfAwCJIPwdyJI4TT1t17xZ88GFsws8qWlFeS
         r8CeuFUJF/vd7zxhVxKyM/E4F+V76cBnNWgGK1mtNiodCy5OUpYSakQmhXcGhCQNN9
         oRuy61xCJ/53HmuGIXFOrkE+d8+BkpfhnE2wSy/BgxWlMoNnxF+pciRJEoHU1VLD7/
         chuwyNWRn4kFcpB/t1ku6gTnab3bK7ZeBzXNWTMb3Hz/iJm5FMDVnAUXAnPKwh2oZX
         yAxunVg8Hnq3g==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        pali@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 03/11] PCI: aardvark: Add support for DLLSC and hotplug interrupt
Date:   Thu, 18 Aug 2022 15:51:32 +0200
Message-Id: <20220818135140.5996-4-kabel@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220818135140.5996-1-kabel@kernel.org>
References: <20220818135140.5996-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Add support for Data Link Layer State Change in the emulated slot
registers and hotplug interrupt via the emulated root bridge.

This is mainly useful for when an error causes link down event. With
this change, drivers can try recovery.

Link down state change can be implemented because Aardvark supports Link
Down event interrupt. Use it for signaling that Data Link Layer Link is
not active anymore via Hot-Plug Interrupt on emulated root bridge.

Link up interrupt is not available on Aardvark, but we check for whether
link is up in the advk_pcie_link_up() function. By triggering Hot-Plug
Interrupt from this function we achieve Link up event, so long as the
function is called (which it is after probe and when rescanning).
Although it is not ideal, it is better than nothing.

Since advk_pcie_link_up() is not called from interrupt handler, we
cannot call generic_handle_domain_irq() from it directly. Instead create
a TIMER_IRQSAFE timer and trigger it from advk_pcie_link_up().

(We haven't been able to find any documentation for a Link Up interrupt
 on Aardvark, but it is possible there is one, in some undocumented
 register. If we manage to find this information, this can be
 rewritten.)

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
Change since batch 5:
- changed commit message (add paragraph about why the change is needed)
- select hotplug and pcieportbus in Kconfig
---
 drivers/pci/controller/Kconfig        |   3 +
 drivers/pci/controller/pci-aardvark.c | 101 ++++++++++++++++++++++++--
 2 files changed, 99 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index d1c5fcf00a8a..5e8a84f5c654 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -21,6 +21,9 @@ config PCI_AARDVARK
 	depends on OF
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCI_BRIDGE_EMUL
+	select PCIEPORTBUS
+	select HOTPLUG_PCI
+	select HOTPLUG_PCI_PCIE
 	help
 	 Add support for Aardvark 64bit PCIe Host Controller. This
 	 controller is part of the South Bridge of the Marvel Armada
diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 966c8b48bd96..31da28ebc5d1 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -25,6 +25,7 @@
 #include <linux/of_address.h>
 #include <linux/of_gpio.h>
 #include <linux/of_pci.h>
+#include <linux/timer.h>
 
 #include "../pci.h"
 #include "../pci-bridge-emul.h"
@@ -100,6 +101,7 @@
 #define PCIE_MSG_PM_PME_MASK			BIT(7)
 #define PCIE_ISR0_MASK_REG			(CONTROL_BASE_ADDR + 0x44)
 #define     PCIE_ISR0_MSI_INT_PENDING		BIT(24)
+#define     PCIE_ISR0_LINK_DOWN			BIT(1)
 #define     PCIE_ISR0_CORR_ERR			BIT(11)
 #define     PCIE_ISR0_NFAT_ERR			BIT(12)
 #define     PCIE_ISR0_FAT_ERR			BIT(13)
@@ -284,6 +286,8 @@ struct advk_pcie {
 	DECLARE_BITMAP(msi_used, MSI_IRQ_NUM);
 	struct mutex msi_used_lock;
 	int link_gen;
+	bool link_was_up;
+	struct timer_list link_irq_timer;
 	struct pci_bridge_emul bridge;
 	struct gpio_desc *reset_gpio;
 	struct phy *phy;
@@ -313,7 +317,24 @@ static inline bool advk_pcie_link_up(struct advk_pcie *pcie)
 {
 	/* check if LTSSM is in normal operation - some L* state */
 	u8 ltssm_state = advk_pcie_ltssm_state(pcie);
-	return ltssm_state >= LTSSM_L0 && ltssm_state < LTSSM_DISABLED;
+	bool link_is_up;
+	u16 slotsta;
+
+	link_is_up = ltssm_state >= LTSSM_L0 && ltssm_state < LTSSM_DISABLED;
+
+	if (link_is_up && !pcie->link_was_up) {
+		dev_info(&pcie->pdev->dev, "link up\n");
+
+		pcie->link_was_up = true;
+
+		slotsta = le16_to_cpu(pcie->bridge.pcie_conf.slotsta);
+		slotsta |= PCI_EXP_SLTSTA_DLLSC;
+		pcie->bridge.pcie_conf.slotsta = cpu_to_le16(slotsta);
+
+		mod_timer(&pcie->link_irq_timer, jiffies + 1);
+	}
+
+	return link_is_up;
 }
 
 static inline bool advk_pcie_link_active(struct advk_pcie *pcie)
@@ -442,8 +463,6 @@ static void advk_pcie_train_link(struct advk_pcie *pcie)
 	ret = advk_pcie_wait_for_link(pcie);
 	if (ret < 0)
 		dev_err(dev, "link never came up\n");
-	else
-		dev_info(dev, "link up\n");
 }
 
 /*
@@ -592,6 +611,11 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 	reg &= ~PCIE_ISR0_MSI_INT_PENDING;
 	advk_writel(pcie, reg, PCIE_ISR0_MASK_REG);
 
+	/* Unmask Link Down interrupt */
+	reg = advk_readl(pcie, PCIE_ISR0_MASK_REG);
+	reg &= ~PCIE_ISR0_LINK_DOWN;
+	advk_writel(pcie, reg, PCIE_ISR0_MASK_REG);
+
 	/* Unmask PME interrupt for processing of PME requester */
 	reg = advk_readl(pcie, PCIE_ISR0_MASK_REG);
 	reg &= ~PCIE_MSG_PM_PME_MASK;
@@ -918,6 +942,14 @@ advk_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 			advk_pcie_wait_for_retrain(pcie);
 		break;
 
+	case PCI_EXP_SLTCTL: {
+		u16 slotctl = le16_to_cpu(bridge->pcie_conf.slotctl);
+		/* Only emulation of HPIE and DLLSCE bits is provided */
+		slotctl &= PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_DLLSCE;
+		bridge->pcie_conf.slotctl = cpu_to_le16(slotctl);
+		break;
+	}
+
 	case PCI_EXP_RTCTL: {
 		u16 rootctl = le16_to_cpu(bridge->pcie_conf.rootctl);
 		/* Only emulation of PMEIE and CRSSVE bits is provided */
@@ -1035,6 +1067,7 @@ static const struct pci_bridge_emul_ops advk_pci_bridge_emul_ops = {
 static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
 {
 	struct pci_bridge_emul *bridge = &pcie->bridge;
+	u32 slotcap;
 
 	bridge->conf.vendor =
 		cpu_to_le16(advk_readl(pcie, PCIE_CORE_DEV_ID_REG) & 0xffff);
@@ -1061,6 +1094,13 @@ static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
 	bridge->pcie_conf.cap = cpu_to_le16(2 | PCI_EXP_FLAGS_SLOT);
 
 	/*
+	 * Mark bridge as Hot Plug Capable since this is the way how to enable
+	 * delivering of Data Link Layer State Change interrupts.
+	 *
+	 * Set No Command Completed Support because bridge does not support
+	 * Command Completed Interrupt. Every command is executed immediately
+	 * without any delay.
+	 *
 	 * Set Presence Detect State bit permanently since there is no support
 	 * for unplugging the card nor detecting whether it is plugged. (If a
 	 * platform exists in the future that supports it, via a GPIO for
@@ -1070,8 +1110,9 @@ static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
 	 * value is reserved for ports within the same silicon as Root Port
 	 * which is not our case.
 	 */
-	bridge->pcie_conf.slotcap = cpu_to_le32(FIELD_PREP(PCI_EXP_SLTCAP_PSN,
-							   1));
+	slotcap = PCI_EXP_SLTCAP_NCCS | PCI_EXP_SLTCAP_HPC |
+		  FIELD_PREP(PCI_EXP_SLTCAP_PSN, 1);
+	bridge->pcie_conf.slotcap = cpu_to_le32(slotcap);
 	bridge->pcie_conf.slotsta = cpu_to_le16(PCI_EXP_SLTSTA_PDS);
 
 	/* Indicates supports for Completion Retry Status */
@@ -1568,6 +1609,24 @@ static void advk_pcie_remove_rp_irq_domain(struct advk_pcie *pcie)
 	irq_domain_remove(pcie->rp_irq_domain);
 }
 
+static void advk_pcie_link_irq_handler(struct timer_list *timer)
+{
+	struct advk_pcie *pcie = from_timer(pcie, timer, link_irq_timer);
+	u16 slotctl;
+
+	slotctl = le16_to_cpu(pcie->bridge.pcie_conf.slotctl);
+	if (!(slotctl & PCI_EXP_SLTCTL_DLLSCE) ||
+	    !(slotctl & PCI_EXP_SLTCTL_HPIE))
+		return;
+
+	/*
+	 * Aardvark HW returns zero for PCI_EXP_FLAGS_IRQ, so use PCIe
+	 * interrupt 0
+	 */
+	if (generic_handle_domain_irq(pcie->rp_irq_domain, 0) == -EINVAL)
+		dev_err_ratelimited(&pcie->pdev->dev, "unhandled HP IRQ\n");
+}
+
 static void advk_pcie_handle_pme(struct advk_pcie *pcie)
 {
 	u32 requester = advk_readl(pcie, PCIE_MSG_LOG_REG) >> 16;
@@ -1619,6 +1678,7 @@ static void advk_pcie_handle_int(struct advk_pcie *pcie)
 {
 	u32 isr0_val, isr0_mask, isr0_status;
 	u32 isr1_val, isr1_mask, isr1_status;
+	u16 slotsta;
 	int i;
 
 	isr0_val = advk_readl(pcie, PCIE_ISR0_REG);
@@ -1645,6 +1705,26 @@ static void advk_pcie_handle_int(struct advk_pcie *pcie)
 			dev_err_ratelimited(&pcie->pdev->dev, "unhandled ERR IRQ\n");
 	}
 
+	/* Process Link Down interrupt as HP IRQ */
+	if (isr0_status & PCIE_ISR0_LINK_DOWN) {
+		advk_writel(pcie, PCIE_ISR0_LINK_DOWN, PCIE_ISR0_REG);
+
+		dev_info(&pcie->pdev->dev, "link down\n");
+
+		pcie->link_was_up = false;
+
+		slotsta = le16_to_cpu(pcie->bridge.pcie_conf.slotsta);
+		slotsta |= PCI_EXP_SLTSTA_DLLSC;
+		pcie->bridge.pcie_conf.slotsta = cpu_to_le16(slotsta);
+
+		/*
+		 * Deactivate timer and call advk_pcie_link_irq_handler()
+		 * function directly as we are in the interrupt context.
+		 */
+		del_timer_sync(&pcie->link_irq_timer);
+		advk_pcie_link_irq_handler(&pcie->link_irq_timer);
+	}
+
 	/* Process MSI interrupts */
 	if (isr0_status & PCIE_ISR0_MSI_INT_PENDING)
 		advk_pcie_handle_msi(pcie);
@@ -1881,6 +1961,14 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/*
+	 * generic_handle_domain_irq() expects local IRQs to be disabled since
+	 * normally it is called from interrupt context, so use TIMER_IRQSAFE
+	 * flag for this link_irq_timer.
+	 */
+	timer_setup(&pcie->link_irq_timer, advk_pcie_link_irq_handler,
+		    TIMER_IRQSAFE);
+
 	advk_pcie_setup_hw(pcie);
 
 	ret = advk_sw_pci_bridge_init(pcie);
@@ -1969,6 +2057,9 @@ static int advk_pcie_remove(struct platform_device *pdev)
 	advk_pcie_remove_msi_irq_domain(pcie);
 	advk_pcie_remove_irq_domain(pcie);
 
+	/* Deactivate link event timer */
+	del_timer_sync(&pcie->link_irq_timer);
+
 	/* Free config space for emulated root bridge */
 	pci_bridge_emul_cleanup(&pcie->bridge);
 
-- 
2.35.1

