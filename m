Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A8F5AD93A
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 20:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiIESsJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 14:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbiIESsI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 14:48:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB3C5F239;
        Mon,  5 Sep 2022 11:48:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C456B815AA;
        Mon,  5 Sep 2022 18:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85EA5C433D6;
        Mon,  5 Sep 2022 18:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662403683;
        bh=4PVibW+wXcSk+50zIr0648e8ZrfjORF0KfZ6HM81FWk=;
        h=From:To:Cc:Subject:Date:From;
        b=f3beyaSEclba5Ky/QFrArFDy0hI2Rt0QSH57yenEzRCxYd+qdGFcUuGnltYZJx1ms
         8AXCNjn+Vsc3Tcjzk+FeoaJEfmIL03nMG44VX+pJmqyeHN3zlthWpVLMK49rujSoKc
         8UzNkmkPOQd6A1/KcASVvbHs6cnOP/80FpBPaeGQeKbT0VYh4etIqfspI0q3CnYhB3
         Q7WUXQ9CdlZcEFAvMHkXdhdXIp25g8xmLaWr6eX0qY0wuZhe/++9GBMpnXq4eJEnfJ
         79bl6oG70DW2hD4jMihQo5b+IzAkpVGEznoE4cUCdnlGDXgWuM6puE8Y8cz1yl8eVb
         BZNwy9yVJVRww==
Received: by pali.im (Postfix)
        id DEE207D7; Mon,  5 Sep 2022 20:48:00 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] PCI: mvebu: Add support for PCI_EXP_SLTSTA_DLLSC via hot plug interrupt
Date:   Mon,  5 Sep 2022 20:47:37 +0200
Message-Id: <20220905184737.22080-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
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

If link up/down state is changed in mvebu_pcie_link_up() then trigger
hot plug interrupt with DLLSC state change on the emulated PCIe Root Port.

Also triggers hot plug interrupt on emulated PCIe Root Port when mvebu
reports via mvebu error interrupt Link Failure event (indicates that link
was changed from active state; with exception of Hot Reset and Link Disable
states) or TxReq No Link event (indicates that link is down while trying to
transmit PCIe transaction).

And triggers this hot plug interrupt also when explicit Link Disable or
PCIe Host Reset on emulated PCIe Root Port is issued via config space
access as mvebu HW does not signal Link Failure when dropping to Detect via
Hot Reset or Link Disable. This is because compliant hotplug-capable PCIe
Root Port should report DLLSC event via hot plug interrupt every time
when link is changed independently of the source of event change.

This new code heavily depends on kernel PCI hotplug driver, so enable it
when compiling pci-mvebu.c driver.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
This patch depends on patch:
"PCI: mvebu: Implement support for interrupts on emulated bridge"
https://lore.kernel.org/linux-pci/20220817230036.817-3-pali@kernel.org/
---
 drivers/pci/controller/Kconfig     |   3 +
 drivers/pci/controller/pci-mvebu.c | 147 ++++++++++++++++++++++++++++-
 2 files changed, 149 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index d1c5fcf00a8a..8da2efdc5177 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -10,6 +10,9 @@ config PCI_MVEBU
 	depends on ARM
 	depends on OF
 	select PCI_BRIDGE_EMUL
+	select PCIEPORTBUS
+	select HOTPLUG_PCI
+	select HOTPLUG_PCI_PCIE
 	help
 	 Add support for Marvell EBU PCIe controller. This PCIe controller
 	 is used on 32-bit Marvell ARM SoCs: Dove, Kirkwood, Armada 370,
diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index ddd5ba8b265e..8bde4727aca4 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -56,12 +56,14 @@
 #define PCIE_CONF_DATA_OFF	0x18fc
 #define PCIE_INT_CAUSE_OFF	0x1900
 #define PCIE_INT_UNMASK_OFF	0x1910
+#define  PCIE_INT_TXREQ_NOLINK		BIT(0)
 #define  PCIE_INT_DET_COR		BIT(8)
 #define  PCIE_INT_DET_NONFATAL		BIT(9)
 #define  PCIE_INT_DET_FATAL		BIT(10)
 #define  PCIE_INT_ERR_FATAL		BIT(16)
 #define  PCIE_INT_ERR_NONFATAL		BIT(17)
 #define  PCIE_INT_ERR_COR		BIT(18)
+#define  PCIE_INT_LINK_FAIL		BIT(23)
 #define  PCIE_INT_INTX(i)		BIT(24+i)
 #define  PCIE_INT_PM_PME		BIT(28)
 #define  PCIE_INT_DET_MASK		(PCIE_INT_DET_COR | PCIE_INT_DET_NONFATAL | PCIE_INT_DET_FATAL)
@@ -134,6 +136,8 @@ struct mvebu_pcie_port {
 	int error_irq;
 	int intx_irq;
 	bool pme_pending;
+	struct timer_list link_irq_timer;
+	bool link_was_up;
 };
 
 static inline void mvebu_writel(struct mvebu_pcie_port *port, u32 val, u32 reg)
@@ -153,7 +157,26 @@ static inline bool mvebu_has_ioport(struct mvebu_pcie_port *port)
 
 static bool mvebu_pcie_link_up(struct mvebu_pcie_port *port)
 {
-	return !(mvebu_readl(port, PCIE_STAT_OFF) & PCIE_STAT_LINK_DOWN);
+	bool link_is_up;
+	u16 slotsta;
+
+	link_is_up = !(mvebu_readl(port, PCIE_STAT_OFF) & PCIE_STAT_LINK_DOWN);
+
+	if (link_is_up != port->link_was_up) {
+		port->link_was_up = link_is_up;
+		/*
+		 * Link IRQ timer/handler is available only when "error"
+		 * interrupt was specified in DT.
+		 */
+		if (port->error_irq > 0) {
+			slotsta = le16_to_cpu(port->bridge.pcie_conf.slotsta);
+			port->bridge.pcie_conf.slotsta =
+				cpu_to_le16(slotsta | PCI_EXP_SLTSTA_DLLSC);
+			mod_timer(&port->link_irq_timer, jiffies + 1);
+		}
+	}
+
+	return link_is_up;
 }
 
 static u8 mvebu_pcie_get_local_bus_nr(struct mvebu_pcie_port *port)
@@ -346,6 +369,19 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 		mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);
 	}
 
+	/*
+	 * Unmask No Link and Link Failure interrupts to process Link Down
+	 * events. These events are reported as Data Link Layer State Changed
+	 * notification via Hot Plug Interrupt. Other parts of Link change
+	 * events are available only when "error" interrupt was specified in DT.
+	 * So enable these interrupts under same conditions.
+	 */
+	if (port->error_irq > 0) {
+		unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
+		unmask |= PCIE_INT_TXREQ_NOLINK | PCIE_INT_LINK_FAIL;
+		mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);
+	}
+
 	/*
 	 * Fallback code when "intx" interrupt was not specified in DT:
 	 * Unmask all legacy INTx interrupts as driver does not provide a way
@@ -692,6 +728,14 @@ mvebu_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
 			val |= slotctl & PCI_EXP_SLTCTL_ASPL_DISABLE;
 		else if (!(mvebu_readl(port, PCIE_SSPL_OFF) & PCIE_SSPL_ENABLE))
 			val |= PCI_EXP_SLTCTL_ASPL_DISABLE;
+		/*
+		 * HPIE and DLLSCE bits are stored only in emulated config
+		 * space buffer and are supported only when "error" interrupt
+		 * was specified in DT.
+		 */
+		if (port->error_irq > 0)
+			val |= slotctl & (PCI_EXP_SLTCTL_HPIE |
+					  PCI_EXP_SLTCTL_DLLSCE);
 		/* This callback is 32-bit and in high bits is slot status. */
 		val |= slotsta << 16;
 		*value = val;
@@ -823,6 +867,25 @@ mvebu_pci_bridge_emul_base_conf_write(struct pci_bridge_emul *bridge,
 			else
 				ctrl &= ~PCIE_CTRL_MASTER_HOT_RESET;
 			mvebu_writel(port, ctrl, PCIE_CTRL_OFF);
+			/*
+			 * When dropping to Detect via Hot Reset, Disable Link
+			 * or Loopback states, the Link Failure interrupt is not
+			 * asserted. So when setting Secondary Bus Reset / Hot
+			 * Reset bit, call link IRQ timer/handler manually.
+			 */
+			if ((ctrl & PCIE_CTRL_MASTER_HOT_RESET) && port->link_was_up) {
+				port->link_was_up = false;
+				/*
+				 * Link IRQ timer/handler is available only when
+				 * "error" interrupt was specified in DT.
+				 */
+				if (port->error_irq > 0) {
+					u16 slotsta = le16_to_cpu(port->bridge.pcie_conf.slotsta);
+					port->bridge.pcie_conf.slotsta =
+						cpu_to_le16(slotsta | PCI_EXP_SLTSTA_DLLSC);
+					mod_timer(&port->link_irq_timer, jiffies + 1);
+				}
+			}
 		}
 		break;
 
@@ -851,6 +914,25 @@ mvebu_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 		new &= ~PCI_EXP_LNKCTL_CLKREQ_EN;
 
 		mvebu_writel(port, new, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL);
+		/*
+		 * When dropping to Detect via Hot Reset, Disable Link
+		 * or Loopback states, the Link Failure interrupt is not
+		 * asserted. So when setting Link Disable bit, call link
+		 * IRQ timer/handler manually.
+		 */
+		if ((new & PCI_EXP_LNKCTL_LD) && port->link_was_up) {
+			port->link_was_up = false;
+			/*
+			 * Link IRQ timer/handler is available only when
+			 * "error" interrupt was specified in DT.
+			 */
+			if (port->error_irq > 0) {
+				u16 slotsta = le16_to_cpu(port->bridge.pcie_conf.slotsta);
+				port->bridge.pcie_conf.slotsta =
+					cpu_to_le16(slotsta | PCI_EXP_SLTSTA_DLLSC);
+				mod_timer(&port->link_irq_timer, jiffies + 1);
+			}
+		}
 		break;
 
 	case PCI_EXP_SLTCTL:
@@ -991,6 +1073,15 @@ static int mvebu_pci_bridge_emul_init(struct mvebu_pcie_port *port)
 	bridge->pcie_conf.cap = cpu_to_le16(pcie_cap_ver | PCI_EXP_FLAGS_SLOT);
 
 	/*
+	 * When "error" interrupt was specified in DT then driver is able to
+	 * deliver Data Link Layer State Change interrupt. So in this case mark
+	 * bridge as Hot Plug Capable as this is the way how to enable
+	 * delivering of Data Link Layer State Change interrupts.
+	 *
+	 * No Command Completed Support is set because bridge does not support
+	 * Command Completed Interrupt. Every command is executed immediately
+	 * without any delay.
+	 *
 	 * Set Presence Detect State bit permanently as there is no support for
 	 * unplugging PCIe card from the slot. Assume that PCIe card is always
 	 * connected in slot.
@@ -1002,6 +1093,8 @@ static int mvebu_pci_bridge_emul_init(struct mvebu_pcie_port *port)
 	 * Also set correct slot power limit.
 	 */
 	bridge->pcie_conf.slotcap = cpu_to_le32(
+		PCI_EXP_SLTCAP_NCCS |
+		(port->error_irq > 0 ? PCI_EXP_SLTCAP_HPC : 0) |
 		FIELD_PREP(PCI_EXP_SLTCAP_SPLV, port->slot_power_limit_value) |
 		FIELD_PREP(PCI_EXP_SLTCAP_SPLS, port->slot_power_limit_scale) |
 		FIELD_PREP(PCI_EXP_SLTCAP_PSN, port->port+1));
@@ -1191,11 +1284,29 @@ static int mvebu_pcie_init_irq_domain(struct mvebu_pcie_port *port)
 	return 0;
 }
 
+static void mvebu_pcie_link_irq_handler(struct timer_list *timer)
+{
+	struct mvebu_pcie_port *port = from_timer(port, timer, link_irq_timer);
+	struct device *dev = &port->pcie->pdev->dev;
+	u16 slotctl;
+
+	dev_info(dev, "%s: link %s\n", port->name, port->link_was_up ? "up" : "down");
+
+	slotctl = le16_to_cpu(port->bridge.pcie_conf.slotctl);
+	if (!(slotctl & PCI_EXP_SLTCTL_DLLSCE) ||
+	    !(slotctl & PCI_EXP_SLTCTL_HPIE))
+		return;
+
+	if (generic_handle_domain_irq(port->rp_irq_domain, 0) == -EINVAL)
+		dev_err_ratelimited(dev, "unhandled HP IRQ\n");
+}
+
 static irqreturn_t mvebu_pcie_error_irq_handler(int irq, void *arg)
 {
 	struct mvebu_pcie_port *port = arg;
 	struct device *dev = &port->pcie->pdev->dev;
 	u32 cause, unmask, status;
+	u16 slotsta;
 
 	cause = mvebu_readl(port, PCIE_INT_CAUSE_OFF);
 	unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
@@ -1233,6 +1344,25 @@ static irqreturn_t mvebu_pcie_error_irq_handler(int irq, void *arg)
 			dev_err_ratelimited(dev, "unhandled ERR IRQ\n");
 	}
 
+	/* Process No Link and Link Failure interrupts as HP IRQ */
+	if (status & (PCIE_INT_TXREQ_NOLINK | PCIE_INT_LINK_FAIL)) {
+		mvebu_writel(port,
+			     ~(PCIE_INT_TXREQ_NOLINK | PCIE_INT_LINK_FAIL),
+			     PCIE_INT_CAUSE_OFF);
+		if (port->link_was_up) {
+			port->link_was_up = false;
+			slotsta = le16_to_cpu(port->bridge.pcie_conf.slotsta);
+			port->bridge.pcie_conf.slotsta =
+				cpu_to_le16(slotsta | PCI_EXP_SLTSTA_DLLSC);
+			/*
+			 * Deactivate timer and call mvebu_pcie_link_irq_handler()
+			 * function directly as we are in the interrupt context.
+			 */
+			del_timer_sync(&port->link_irq_timer);
+			mvebu_pcie_link_irq_handler(&port->link_irq_timer);
+		}
+	}
+
 	return status ? IRQ_HANDLED : IRQ_NONE;
 }
 
@@ -1796,6 +1926,18 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 			}
 		}
 
+		/*
+		 * Function mvebu_pcie_link_irq_handler() calls function
+		 * generic_handle_irq() and it expects local IRQs to be disabled
+		 * as normally generic_handle_irq() is called from the interrupt
+		 * context. So use TIMER_IRQSAFE flag for this link_irq_timer.
+		 * Available only if "error" interrupt was specified in DT.
+		 */
+		if (port->error_irq > 0)
+			timer_setup(&port->link_irq_timer,
+				    mvebu_pcie_link_irq_handler,
+				    TIMER_IRQSAFE);
+
 		/*
 		 * PCIe topology exported by mvebu hw is quite complicated. In
 		 * reality has something like N fully independent host bridges
@@ -1932,6 +2074,9 @@ static int mvebu_pcie_remove(struct platform_device *pdev)
 			irq_domain_remove(port->rp_irq_domain);
 		}
 
+		if (port->error_irq > 0)
+			del_timer_sync(&port->link_irq_timer);
+
 		/* Free config space for emulated root bridge. */
 		pci_bridge_emul_cleanup(&port->bridge);
 
-- 
2.20.1

