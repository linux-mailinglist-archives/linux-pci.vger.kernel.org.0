Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC8C5EC5CE
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 16:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiI0OTp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 10:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbiI0OTm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 10:19:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148614B4B5
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 07:19:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A749C619EF
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 14:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F8CC433B5;
        Tue, 27 Sep 2022 14:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664288375;
        bh=vMseaGF7YcKRjNhEJUiDiek5OZEHpO6bmBoVzrBANUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QKPycydpKppRHX1GZUWHh0MNyunc2MuOvAfkpbAgOFNf0//D4tYx8PIc9v6zHfgC2
         GGGmc8ZVrLhfBitjIR69iP4YluSTfQ5sP1A4om8RF4izHhAyv7eyutL3b+te+1GrO3
         7pg9NKZCDbONp0rrcHxHG9EekEiAgrqNhncV4S4I3W77CSOKy5oSWh3ED+YkYJyFmE
         vAdI3rDBxVQvZvR9co/AOq4p0wIMroJFhLKR+zTT1OQ0Rt2xnO0rzgFkFt4t9/OA/I
         rmyJ1gk8LVXSjpqEKuWCjbnk2xUx43xun4/q2kXp35RU5OYXJr5sDiF1J0YyaqPL1k
         H4jDoDGRUJzWA==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>, pali@kernel.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 02/10] PCI: aardvark: Add support for DLLSC and hotplug interrupt
Date:   Tue, 27 Sep 2022 16:19:18 +0200
Message-Id: <20220927141926.8895-3-kabel@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220927141926.8895-1-kabel@kernel.org>
References: <20220927141926.8895-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Add support for Data Link Layer State Change in the emulated slot
registers and hotplug interrupt via the emulated root bridge.

DLLSC is needed by the pciehp driver, which handles hotplug, but also
link state change events. AFAIK no Aardvark devices support hotplug,
but link state change events are required for graceful driver
unbinding in case of a link down event.

So with this change we achieve graceful driver unbind for example
when WiFi card PCIe link goes down (we've seen this with ath10k and
mt76 WiFi cards). Before the WiFi driver started spitting out errors,
or even taking the whole system down.

Link down state change can be implemented because Aardvark supports
Link Down event interrupt.

After the link goes down, it can come up again (if the WiFi card can
recover or if reset pin is used to reset the card). Because of this
we need to be able to recognize link up event. Since AFAIK Aardvark
does not have interrupt for link up event, the best thing we can do
is simulate it - whenever we read the link state and find it is up,
and have cached value saying it is down, we trigger the link up
event. We read link state in the advk_pcie_link_up() function, which
is called for example whenever the configuration space is read (i.e.
when writing 1 to /sys/bus/pci/rescan). We add the triggering of
Hot-Plug Interrupt from this function. Although not ideal, it is
better than nothing.

Since advk_pcie_link_up() is not called from an interrupt handler, we
cannot call generic_handle_domain_irq() from it directly. So instead
we schedule the triggering via an IRQSAFE timer as soon as possible:
at jiffies + 1. This ensures that generic_handle_domain_irq() is
called from within a safe context. (Note that the timer is not a
periodic timer - we do not call the handler every jiffy. We just
schedule the calling once, at the next jiffy.)

(We haven't been able to find any documentation for a Link Up
 interrupt on Aardvark, but it is possible there is one, in some
 undocumented register. If we manage to find this information, this
 can be rewritten.)

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
Changes since batch 6 v1:
- more explanation in commit message
Changes since batch 5:
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

