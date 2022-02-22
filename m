Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C39C4BFECD
	for <lists+linux-pci@lfdr.de>; Tue, 22 Feb 2022 17:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbiBVQdv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Feb 2022 11:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbiBVQcr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Feb 2022 11:32:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B96DBB091;
        Tue, 22 Feb 2022 08:32:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E90A360AC8;
        Tue, 22 Feb 2022 16:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F382EC340EB;
        Tue, 22 Feb 2022 16:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645547540;
        bh=8/bdC9IksqEvPqTzZhPSiT319NiwbJYyn6PKo0ZgPJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uYkxD0gbGh/IEja4Sz1GZLSbOoiKicNK6plE4O0wpzcKRLjV894SQOPmN8jQn4v6f
         cgi+r/Zh2VOygyZPVj5WvBfsYYd/fHO8qQskCUNq37ADEqu6IXavTPenSqvHM3kKk3
         9YsX4iS+CJOlYPrqDfNwD5T4gg6RrhF/BsVC36DK0LtQn34w7Lcd+BuH6e8S7HvkWj
         oSjMx77titZx+lgFwXO0uUfIUfWRqyFb501QVz0xgHnEasrhwvPZkxlOkRAfi6z2I4
         1a5f6z4qpl4ej6oL1PyH/mYr5aOWJh+Pq94sXNPslZWJmHzIgHFEz0Tvg+Ec6Je+Sm
         34VhHjoqqrSww==
Received: by pali.im (Postfix)
        id ABB3FFDB; Tue, 22 Feb 2022 17:32:19 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Gregory Clement <gregory.clement@bootlin.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] PCI: mvebu: Add support for sending Set_Slot_Power_Limit message
Date:   Tue, 22 Feb 2022 17:31:57 +0100
Message-Id: <20220222163158.1666-6-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220222163158.1666-1-pali@kernel.org>
References: <20220222163158.1666-1-pali@kernel.org>
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

This PCIe message is sent automatically by mvebu HW when link changes
status from down to up.

Slot power limit is read from DT property 'slot-power-limit-milliwatt' and
set to mvebu HW. When this DT property is not specified then driver treat
it as "Slot Capabilities register has not yet been initialized".

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-mvebu.c | 85 ++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index a75d2b9196f9..c786feec4d17 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -66,6 +66,12 @@
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
@@ -111,6 +117,8 @@ struct mvebu_pcie_port {
 	struct mvebu_pcie_window iowin;
 	u32 saved_pcie_stat;
 	struct resource regs;
+	u8 slot_power_limit_value;
+	u8 slot_power_limit_scale;
 	struct irq_domain *intx_irq_domain;
 	raw_spinlock_t irq_lock;
 	int intx_irq;
@@ -239,7 +247,7 @@ static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
 
 static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 {
-	u32 ctrl, lnkcap, cmd, dev_rev, unmask;
+	u32 ctrl, lnkcap, cmd, dev_rev, unmask, sspl;
 
 	/* Setup PCIe controller to Root Complex mode. */
 	ctrl = mvebu_readl(port, PCIE_CTRL_OFF);
@@ -292,6 +300,20 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 	/* Point PCIe unit MBUS decode windows to DRAM space. */
 	mvebu_pcie_setup_wins(port);
 
+	/*
+	 * Program Root Complex to automatically sends Set Slot Power Limit
+	 * PCIe Message when changing status from Dl-Down to Dl-Up and valid
+	 * slot power limit was specified.
+	 */
+	sspl = mvebu_readl(port, PCIE_SSPL_OFF);
+	sspl &= ~(PCIE_SSPL_VALUE_MASK | PCIE_SSPL_SCALE_MASK | PCIE_SSPL_ENABLE);
+	if (port->slot_power_limit_value && port->slot_power_limit_scale) {
+		sspl |= port->slot_power_limit_value << PCIE_SSPL_VALUE_SHIFT;
+		sspl |= port->slot_power_limit_scale << PCIE_SSPL_SCALE_SHIFT;
+		sspl |= PCIE_SSPL_ENABLE;
+	}
+	mvebu_writel(port, sspl, PCIE_SSPL_OFF);
+
 	/* Mask all interrupt sources. */
 	mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_UNMASK_OFF);
 
@@ -628,9 +650,16 @@ mvebu_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
 			  (PCI_EXP_LNKSTA_DLLLA << 16) : 0);
 		break;
 
-	case PCI_EXP_SLTCTL:
-		*value = PCI_EXP_SLTSTA_PDS << 16;
+	case PCI_EXP_SLTCTL: {
+		u16 slotsta = le16_to_cpu(bridge->pcie_conf.slotsta);
+		u32 val = 0;
+		if (!(mvebu_readl(port, PCIE_SSPL_OFF) & PCIE_SSPL_ENABLE))
+			val |= PCI_EXP_SLTCTL_ASPL_DISABLE;
+		/* PCI_EXP_SLTCTL is 32-bit and contains also slot status bits */
+		val |= slotsta << 16;
+		*value = val;
 		break;
+	}
 
 	case PCI_EXP_RTSTA:
 		*value = mvebu_readl(port, PCIE_RC_RTSTA);
@@ -774,6 +803,19 @@ mvebu_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 		mvebu_writel(port, new, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL);
 		break;
 
+	case PCI_EXP_SLTCTL:
+		if ((mask & PCI_EXP_SLTCTL_ASPL_DISABLE) &&
+		    port->slot_power_limit_value &&
+		    port->slot_power_limit_scale) {
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
@@ -868,8 +910,26 @@ static int mvebu_pci_bridge_emul_init(struct mvebu_pcie_port *port)
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
+		(port->slot_power_limit_value << PCI_EXP_SLTCAP_SPLV_SHIFT) |
+		(port->slot_power_limit_scale << PCI_EXP_SLTCAP_SPLS_SHIFT) |
+		((port->port+1) << PCI_EXP_SLTCAP_PSN_SHIFT));
+	bridge->pcie_conf.slotsta = cpu_to_le16(PCI_EXP_SLTSTA_PDS);
 
 	bridge->subsystem_vendor_id = ssdev_id & 0xffff;
 	bridge->subsystem_id = ssdev_id >> 16;
@@ -1191,6 +1251,7 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
 {
 	struct device *dev = &pcie->pdev->dev;
 	enum of_gpio_flags flags;
+	u32 slot_power_limit;
 	int reset_gpio, ret;
 	u32 num_lanes;
 
@@ -1291,6 +1352,15 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
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
@@ -1587,7 +1657,7 @@ static int mvebu_pcie_remove(struct platform_device *pdev)
 {
 	struct mvebu_pcie *pcie = platform_get_drvdata(pdev);
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
-	u32 cmd;
+	u32 cmd, sspl;
 	int i;
 
 	/* Remove PCI bus with all devices. */
@@ -1624,6 +1694,11 @@ static int mvebu_pcie_remove(struct platform_device *pdev)
 		/* Free config space for emulated root bridge. */
 		pci_bridge_emul_cleanup(&port->bridge);
 
+		/* Disable sending Set Slot Power Limit PCIe Message. */
+		sspl = mvebu_readl(port, PCIE_SSPL_OFF);
+		sspl &= ~(PCIE_SSPL_VALUE_MASK | PCIE_SSPL_SCALE_MASK | PCIE_SSPL_ENABLE);
+		mvebu_writel(port, sspl, PCIE_SSPL_OFF);
+
 		/* Disable and clear BARs and windows. */
 		mvebu_pcie_disable_wins(port);
 
-- 
2.20.1

