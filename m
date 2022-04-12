Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410334FDD2B
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 13:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239652AbiDLK6g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 06:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377400AbiDLK4h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 06:56:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0568FE65;
        Tue, 12 Apr 2022 02:50:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB204B81BE0;
        Tue, 12 Apr 2022 09:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472F4C385A5;
        Tue, 12 Apr 2022 09:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649757031;
        bh=qjB85O8DbKC3TvZDkCMMn0qt2Y9QJcIc9o8iYjgvdPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B3z/sKKRaIf4WlVMtQFgs2+uZ3KVUCYiJcROQYqjKX8aRVHI90YihGtFeyiK0wAOF
         s6cR96hKyAMd0kRyYgXDyi4HHizJ8SI4z46vGxYn4vcFIHzUsG45Qevmqj78hxsP6I
         gRC69Ui5pfhKULGjQrD0tK0RWtniMRydQu6A6SKneZYsT5D1hxtYkAVHrWQfisM6ml
         QC8Y5d9Ya5LOSyxYW0OZuXCS9JNi+F7J8cKfRquKUaHEryL/tZdTz7SdZaZRQfzo1z
         Vi4pDGxunliVwF/T2JNFAvcfUxbBoNe6W6KfipNP5X2NxvHpwVTQSiZ+xJBO7EykNv
         Ypl2A3ore+AmA==
Received: by pali.im (Postfix)
        id 268C42B53; Tue, 12 Apr 2022 11:50:29 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/4] PCI: mvebu: Add support for sending Set_Slot_Power_Limit message
Date:   Tue, 12 Apr 2022 11:49:46 +0200
Message-Id: <20220412094946.27069-5-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220412094946.27069-1-pali@kernel.org>
References: <20220412094946.27069-1-pali@kernel.org>
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

If DT supplies the 'slot-power-limit-milliwatt' property, program
the value in the Slot Power Limit in the Slot Capabilities register
and program the Root Port to send a Set_Slot_Power_Limit Message
when the Link transitions to DL_Up.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v5:
* Fix compile error due to wrong patch rebasing
Changes in v2:
* Fix handling of slot power limit with scale x1.0 (0x00 value)
* Use FIELD_PREP instead of _SHIFT macros
* Changed commit message to Bjorn's suggestion
* Changed comments in the code to match PCIe spec
* Preserve user settings of PCI_EXP_SLTCTL_ASPL_DISABLE bit
---
 drivers/pci/controller/pci-mvebu.c | 97 ++++++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index a75d2b9196f9..a9678d658c2a 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
@@ -66,6 +67,12 @@
 #define  PCIE_STAT_BUS                  0xff00
 #define  PCIE_STAT_DEV                  0x1f0000
 #define  PCIE_STAT_LINK_DOWN		BIT(0)
+#define PCIE_SSPL_OFF		0x1a0c
+#define  PCIE_SSPL_VALUE_SHIFT		0
+#define  PCIE_SSPL_VALUE_MASK		GENMASK(7, 0)
+#define  PCIE_SSPL_SCALE_SHIFT		8
+#define  PCIE_SSPL_SCALE_MASK		GENMASK(9, 8)
+#define  PCIE_SSPL_ENABLE		BIT(16)
 #define PCIE_RC_RTSTA		0x1a14
 #define PCIE_DEBUG_CTRL         0x1a60
 #define  PCIE_DEBUG_SOFT_RESET		BIT(20)
@@ -111,6 +118,8 @@ struct mvebu_pcie_port {
 	struct mvebu_pcie_window iowin;
 	u32 saved_pcie_stat;
 	struct resource regs;
+	u8 slot_power_limit_value;
+	u8 slot_power_limit_scale;
 	struct irq_domain *intx_irq_domain;
 	raw_spinlock_t irq_lock;
 	int intx_irq;
@@ -239,7 +248,7 @@ static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
 
 static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 {
-	u32 ctrl, lnkcap, cmd, dev_rev, unmask;
+	u32 ctrl, lnkcap, cmd, dev_rev, unmask, sspl;
 
 	/* Setup PCIe controller to Root Complex mode. */
 	ctrl = mvebu_readl(port, PCIE_CTRL_OFF);
@@ -292,6 +301,20 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 	/* Point PCIe unit MBUS decode windows to DRAM space. */
 	mvebu_pcie_setup_wins(port);
 
+	/*
+	 * Program Root Port to automatically send Set_Slot_Power_Limit
+	 * PCIe Message when changing status from Dl_Down to Dl_Up and valid
+	 * slot power limit was specified.
+	 */
+	sspl = mvebu_readl(port, PCIE_SSPL_OFF);
+	sspl &= ~(PCIE_SSPL_VALUE_MASK | PCIE_SSPL_SCALE_MASK | PCIE_SSPL_ENABLE);
+	if (port->slot_power_limit_value) {
+		sspl |= port->slot_power_limit_value << PCIE_SSPL_VALUE_SHIFT;
+		sspl |= port->slot_power_limit_scale << PCIE_SSPL_SCALE_SHIFT;
+		sspl |= PCIE_SSPL_ENABLE;
+	}
+	mvebu_writel(port, sspl, PCIE_SSPL_OFF);
+
 	/* Mask all interrupt sources. */
 	mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_UNMASK_OFF);
 
@@ -628,9 +651,24 @@ mvebu_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
 			  (PCI_EXP_LNKSTA_DLLLA << 16) : 0);
 		break;
 
-	case PCI_EXP_SLTCTL:
-		*value = PCI_EXP_SLTSTA_PDS << 16;
+	case PCI_EXP_SLTCTL: {
+		u16 slotctl = le16_to_cpu(bridge->pcie_conf.slotctl);
+		u16 slotsta = le16_to_cpu(bridge->pcie_conf.slotsta);
+		u32 val = 0;
+		/*
+		 * When slot power limit was not specified in DT then
+		 * ASPL_DISABLE bit is stored only in emulated config space.
+		 * Otherwise reflect status of PCIE_SSPL_ENABLE bit in HW.
+		 */
+		if (!port->slot_power_limit_value)
+			val |= slotctl & PCI_EXP_SLTCTL_ASPL_DISABLE;
+		else if (!(mvebu_readl(port, PCIE_SSPL_OFF) & PCIE_SSPL_ENABLE))
+			val |= PCI_EXP_SLTCTL_ASPL_DISABLE;
+		/* This callback is 32-bit and in high bits is slot status. */
+		val |= slotsta << 16;
+		*value = val;
 		break;
+	}
 
 	case PCI_EXP_RTSTA:
 		*value = mvebu_readl(port, PCIE_RC_RTSTA);
@@ -774,6 +812,22 @@ mvebu_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 		mvebu_writel(port, new, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL);
 		break;
 
+	case PCI_EXP_SLTCTL:
+		/*
+		 * Allow to change PCIE_SSPL_ENABLE bit only when slot power
+		 * limit was specified in DT and configured into HW.
+		 */
+		if ((mask & PCI_EXP_SLTCTL_ASPL_DISABLE) &&
+		    port->slot_power_limit_value) {
+			u32 sspl = mvebu_readl(port, PCIE_SSPL_OFF);
+			if (new & PCI_EXP_SLTCTL_ASPL_DISABLE)
+				sspl &= ~PCIE_SSPL_ENABLE;
+			else
+				sspl |= PCIE_SSPL_ENABLE;
+			mvebu_writel(port, sspl, PCIE_SSPL_OFF);
+		}
+		break;
+
 	case PCI_EXP_RTSTA:
 		/*
 		 * PME Status bit in Root Status Register (PCIE_RC_RTSTA)
@@ -868,8 +922,26 @@ static int mvebu_pci_bridge_emul_init(struct mvebu_pcie_port *port)
 	/*
 	 * Older mvebu hardware provides PCIe Capability structure only in
 	 * version 1. New hardware provides it in version 2.
+	 * Enable slot support which is emulated.
 	 */
-	bridge->pcie_conf.cap = cpu_to_le16(pcie_cap_ver);
+	bridge->pcie_conf.cap = cpu_to_le16(pcie_cap_ver | PCI_EXP_FLAGS_SLOT);
+
+	/*
+	 * Set Presence Detect State bit permanently as there is no support for
+	 * unplugging PCIe card from the slot. Assume that PCIe card is always
+	 * connected in slot.
+	 *
+	 * Set physical slot number to port+1 as mvebu ports are indexed from
+	 * zero and zero value is reserved for ports within the same silicon
+	 * as Root Port which is not mvebu case.
+	 *
+	 * Also set correct slot power limit.
+	 */
+	bridge->pcie_conf.slotcap = cpu_to_le32(
+		FIELD_PREP(PCI_EXP_SLTCAP_SPLV, port->slot_power_limit_value) |
+		FIELD_PREP(PCI_EXP_SLTCAP_SPLS, port->slot_power_limit_scale) |
+		FIELD_PREP(PCI_EXP_SLTCAP_PSN, port->port+1));
+	bridge->pcie_conf.slotsta = cpu_to_le16(PCI_EXP_SLTSTA_PDS);
 
 	bridge->subsystem_vendor_id = ssdev_id & 0xffff;
 	bridge->subsystem_id = ssdev_id >> 16;
@@ -1191,6 +1263,7 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
 {
 	struct device *dev = &pcie->pdev->dev;
 	enum of_gpio_flags flags;
+	u32 slot_power_limit;
 	int reset_gpio, ret;
 	u32 num_lanes;
 
@@ -1291,6 +1364,15 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
 		port->reset_gpio = gpio_to_desc(reset_gpio);
 	}
 
+	slot_power_limit = of_pci_get_slot_power_limit(child,
+				&port->slot_power_limit_value,
+				&port->slot_power_limit_scale);
+	if (slot_power_limit)
+		dev_info(dev, "%s: Slot power limit %u.%uW\n",
+			 port->name,
+			 slot_power_limit / 1000,
+			 (slot_power_limit / 100) % 10);
+
 	port->clk = of_clk_get_by_name(child, NULL);
 	if (IS_ERR(port->clk)) {
 		dev_err(dev, "%s: cannot get clock\n", port->name);
@@ -1587,7 +1669,7 @@ static int mvebu_pcie_remove(struct platform_device *pdev)
 {
 	struct mvebu_pcie *pcie = platform_get_drvdata(pdev);
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
-	u32 cmd;
+	u32 cmd, sspl;
 	int i;
 
 	/* Remove PCI bus with all devices. */
@@ -1624,6 +1706,11 @@ static int mvebu_pcie_remove(struct platform_device *pdev)
 		/* Free config space for emulated root bridge. */
 		pci_bridge_emul_cleanup(&port->bridge);
 
+		/* Disable sending Set_Slot_Power_Limit PCIe Message. */
+		sspl = mvebu_readl(port, PCIE_SSPL_OFF);
+		sspl &= ~(PCIE_SSPL_VALUE_MASK | PCIE_SSPL_SCALE_MASK | PCIE_SSPL_ENABLE);
+		mvebu_writel(port, sspl, PCIE_SSPL_OFF);
+
 		/* Disable and clear BARs and windows. */
 		mvebu_pcie_disable_wins(port);
 
-- 
2.20.1

