Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0714BF67F
	for <lists+linux-pci@lfdr.de>; Tue, 22 Feb 2022 11:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiBVKr2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Feb 2022 05:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbiBVKrZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Feb 2022 05:47:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286AAB253C;
        Tue, 22 Feb 2022 02:46:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96067B8198D;
        Tue, 22 Feb 2022 10:46:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E88DC340E8;
        Tue, 22 Feb 2022 10:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645526815;
        bh=5JE+CZpiQaXGemTI2iXuqCZ64BgIb6LL1x3CKnRiKds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ia1l5PiGwR8kAselMDTyV/evRrXmQ54KWqwci1lU3B/0kOBG6p6UQ3kggcuOv/OAq
         AEiC0PzZW9yCdrNqCe7S9m0gydCkX8wBgoiPbUgZdajvy+ffDA+pbjOnkBWmd4Pr+z
         zGrsZ0ZPElqPkZsRbxtQRxLlzn9yMdQfbmtrfqgNUiLR3gR1T7+P/cSRie+8yDgc2K
         zElOsZiOf8mPDRKN7/8l4W129/90wf5/VeBBClKuj7yBgbw8JsNOWaxVfQzygxX50e
         OSk6+iw0xh3r6OjgvQpxfsJdZRW2gPyCmJ88HNZ0yzWuw9RTwSZZC6fprfvKkOhdIT
         VPM6cx+mCNJPw==
Received: by pali.im (Postfix)
        id BB49CFDB; Tue, 22 Feb 2022 11:46:54 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 11/12] PCI: mvebu: Implement support for legacy INTx interrupts
Date:   Tue, 22 Feb 2022 11:46:24 +0100
Message-Id: <20220222104625.28461-12-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220222104625.28461-1-pali@kernel.org>
References: <20220222104625.28461-1-pali@kernel.org>
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

This adds support for legacy INTx interrupts received from other PCIe
devices and which are reported by a new INTx irq chip.

With this change, kernel can distinguish between INTA, INTB, INTC and INTD
interrupts.

Note that for this support, device tree files has to be properly adjusted
to provide "interrupts" or "interrupts-extended" property with intx
interrupt source, "interrupt-names" property with "intx" string and also
'interrupt-controller' subnode must be defined.

If device tree files do not provide these nodes then driver would work as
before.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-mvebu.c | 159 +++++++++++++++++++++++++++++
 1 file changed, 159 insertions(+)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 5f8b8b4ddbea..c9311829dfe3 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -111,6 +111,9 @@ struct mvebu_pcie_port {
 	struct mvebu_pcie_window iowin;
 	u32 saved_pcie_stat;
 	struct resource regs;
+	struct irq_domain *intx_irq_domain;
+	raw_spinlock_t irq_lock;
+	int intx_irq;
 };
 
 static inline void mvebu_writel(struct mvebu_pcie_port *port, u32 val, u32 reg)
@@ -289,7 +292,18 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 	/* Point PCIe unit MBUS decode windows to DRAM space. */
 	mvebu_pcie_setup_wins(port);
 
+	/* Mask all interrupt sources. */
+	mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_UNMASK_OFF);
+
+	/* Clear all interrupt causes. */
+	mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_CAUSE_OFF);
+
+	/* Check if "intx" interrupt was specified in DT. */
+	if (port->intx_irq > 0)
+		return;
+
 	/*
+	 * Fallback code when "intx" interrupt was not specified in DT:
 	 * Unmask all legacy INTx interrupts as driver does not provide a way
 	 * for masking and unmasking of individual legacy INTx interrupts.
 	 * Legacy INTx are reported via one shared GIC source and therefore
@@ -934,6 +948,108 @@ static struct pci_ops mvebu_pcie_ops = {
 	.write = mvebu_pcie_wr_conf,
 };
 
+static void mvebu_pcie_intx_irq_mask(struct irq_data *d)
+{
+	struct mvebu_pcie_port *port = d->domain->host_data;
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	unsigned long flags;
+	u32 unmask;
+
+	raw_spin_lock_irqsave(&port->irq_lock, flags);
+	unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
+	unmask &= ~PCIE_INT_INTX(hwirq);
+	mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);
+	raw_spin_unlock_irqrestore(&port->irq_lock, flags);
+}
+
+static void mvebu_pcie_intx_irq_unmask(struct irq_data *d)
+{
+	struct mvebu_pcie_port *port = d->domain->host_data;
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	unsigned long flags;
+	u32 unmask;
+
+	raw_spin_lock_irqsave(&port->irq_lock, flags);
+	unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
+	unmask |= PCIE_INT_INTX(hwirq);
+	mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);
+	raw_spin_unlock_irqrestore(&port->irq_lock, flags);
+}
+
+static struct irq_chip intx_irq_chip = {
+	.name = "mvebu-INTx",
+	.irq_mask = mvebu_pcie_intx_irq_mask,
+	.irq_unmask = mvebu_pcie_intx_irq_unmask,
+};
+
+static int mvebu_pcie_intx_irq_map(struct irq_domain *h,
+				   unsigned int virq, irq_hw_number_t hwirq)
+{
+	struct mvebu_pcie_port *port = h->host_data;
+
+	irq_set_status_flags(virq, IRQ_LEVEL);
+	irq_set_chip_and_handler(virq, &intx_irq_chip, handle_level_irq);
+	irq_set_chip_data(virq, port);
+
+	return 0;
+}
+
+static const struct irq_domain_ops mvebu_pcie_intx_irq_domain_ops = {
+	.map = mvebu_pcie_intx_irq_map,
+	.xlate = irq_domain_xlate_onecell,
+};
+
+static int mvebu_pcie_init_irq_domain(struct mvebu_pcie_port *port)
+{
+	struct device *dev = &port->pcie->pdev->dev;
+	struct device_node *pcie_intc_node;
+
+	raw_spin_lock_init(&port->irq_lock);
+
+	pcie_intc_node = of_get_next_child(port->dn, NULL);
+	if (!pcie_intc_node) {
+		dev_err(dev, "No PCIe Intc node found for %s\n", port->name);
+		return -ENODEV;
+	}
+
+	port->intx_irq_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
+						      &mvebu_pcie_intx_irq_domain_ops,
+						      port);
+	of_node_put(pcie_intc_node);
+	if (!port->intx_irq_domain) {
+		dev_err(dev, "Failed to get INTx IRQ domain for %s\n", port->name);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void mvebu_pcie_irq_handler(struct irq_desc *desc)
+{
+	struct mvebu_pcie_port *port = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct device *dev = &port->pcie->pdev->dev;
+	u32 cause, unmask, status;
+	int i;
+
+	chained_irq_enter(chip, desc);
+
+	cause = mvebu_readl(port, PCIE_INT_CAUSE_OFF);
+	unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
+	status = cause & unmask;
+
+	/* Process legacy INTx interrupts */
+	for (i = 0; i < PCI_NUM_INTX; i++) {
+		if (!(status & PCIE_INT_INTX(i)))
+			continue;
+
+		if (generic_handle_domain_irq(port->intx_irq_domain, i) == -EINVAL)
+			dev_err_ratelimited(dev, "unexpected INT%c IRQ\n", (char)i+'A');
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
 static int mvebu_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	/* Interrupt support on mvebu emulated bridges is not implemented yet */
@@ -1131,6 +1247,21 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
 		port->io_attr = -1;
 	}
 
+	/*
+	 * Old DT bindings do not contain "intx" interrupt
+	 * so do not fail probing driver when interrupt does not exist.
+	 */
+	port->intx_irq = of_irq_get_byname(child, "intx");
+	if (port->intx_irq == -EPROBE_DEFER) {
+		ret = port->intx_irq;
+		goto err;
+	}
+	if (port->intx_irq <= 0) {
+		dev_warn(dev, "%s: legacy INTx interrupts cannot be masked individually, "
+			      "%pOF does not contain intx interrupt\n",
+			 port->name, child);
+	}
+
 	reset_gpio = of_get_named_gpio_flags(child, "reset-gpios", 0, &flags);
 	if (reset_gpio == -EPROBE_DEFER) {
 		ret = reset_gpio;
@@ -1327,6 +1458,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 
 	for (i = 0; i < pcie->nports; i++) {
 		struct mvebu_pcie_port *port = &pcie->ports[i];
+		int irq = port->intx_irq;
 
 		child = port->dn;
 		if (!child)
@@ -1354,6 +1486,22 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 			continue;
 		}
 
+		if (irq > 0) {
+			ret = mvebu_pcie_init_irq_domain(port);
+			if (ret) {
+				dev_err(dev, "%s: cannot init irq domain\n",
+					port->name);
+				pci_bridge_emul_cleanup(&port->bridge);
+				devm_iounmap(dev, port->base);
+				port->base = NULL;
+				mvebu_pcie_powerdown(port);
+				continue;
+			}
+			irq_set_chained_handler_and_data(irq,
+							 mvebu_pcie_irq_handler,
+							 port);
+		}
+
 		/*
 		 * PCIe topology exported by mvebu hw is quite complicated. In
 		 * reality has something like N fully independent host bridges
@@ -1458,6 +1606,7 @@ static int mvebu_pcie_remove(struct platform_device *pdev)
 
 	for (i = 0; i < pcie->nports; i++) {
 		struct mvebu_pcie_port *port = &pcie->ports[i];
+		int irq = port->intx_irq;
 
 		if (!port->base)
 			continue;
@@ -1470,6 +1619,16 @@ static int mvebu_pcie_remove(struct platform_device *pdev)
 		/* Mask all interrupt sources. */
 		mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_UNMASK_OFF);
 
+		/* Clear all interrupt causes. */
+		mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_CAUSE_OFF);
+
+		if (irq > 0)
+			irq_set_chained_handler_and_data(irq, NULL, NULL);
+
+		/* Remove IRQ domains. */
+		if (port->intx_irq_domain)
+			irq_domain_remove(port->intx_irq_domain);
+
 		/* Free config space for emulated root bridge. */
 		pci_bridge_emul_cleanup(&port->bridge);
 
-- 
2.20.1

