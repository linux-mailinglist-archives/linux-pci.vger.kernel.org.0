Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230324876CD
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 12:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347228AbiAGLu7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 06:50:59 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35262 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347221AbiAGLu6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jan 2022 06:50:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A186B825E5;
        Fri,  7 Jan 2022 11:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2115C36AE5;
        Fri,  7 Jan 2022 11:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641556256;
        bh=tlSofhkr2jzdAYuwsla28s0MjyMWwGKIHX80B/VQRrM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XNWfyA+aLJEC6aM3jDiOTBffhJ0zbs0inYpMsvPonLfCnM947+z6kMNhixvYvA8t3
         qLQxL9wWU7KuuR2m+D7Y3sZqME7ExvyezzgQ92Trad+bXjQLg55wIS5qMascwn+W51
         tO2/fTSx2tgL9ILo4IOZmK6rEIdHTDQYpPTWSrK/OUvVCLGjVyPlUTphT5gTRGuRdN
         zWZklTXgjpqCy1KKz5DUW6kPrhJ+SHEJnyOTMOJI98haCuBwTbSMqPzHvthsY5LDuu
         8yZW/ykqTzcx0wmM9vbCumnpYaENQRNh8+YHAgMMCxYTSFUswl76gJU5Et4yhNUUkl
         WKXg/8+TUyaMw==
Received: by pali.im (Postfix)
        id 44ABDB22; Fri,  7 Jan 2022 12:50:53 +0100 (CET)
Date:   Fri, 7 Jan 2022 12:50:53 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 10/11] PCI: mvebu: Implement support for legacy INTx
 interrupts
Message-ID: <20220107115053.k5d2uv7yrftrpcez@pali>
References: <20220105150239.9628-1-pali@kernel.org>
 <20220105150239.9628-11-pali@kernel.org>
 <87bl0ovq7f.wl-maz@kernel.org>
 <20220106154447.aie6taiuvav5wu6y@pali>
 <878rvsvoyo.wl-maz@kernel.org>
 <20220106162047.vqykmygs75eimfgy@pali>
 <877dbcvngf.wl-maz@kernel.org>
 <20220106182044.3ff0828c@thinkpad>
 <874k6gvkhz.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874k6gvkhz.wl-maz@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 06 January 2022 17:31:36 Marc Zyngier wrote:
> On Thu, 06 Jan 2022 17:20:44 +0000,
> Marek Behún <kabel@kernel.org> wrote:
> > 
> > On Thu, 06 Jan 2022 16:27:44 +0000
> > Marc Zyngier <maz@kernel.org> wrote:
> > > You are completely missing my point. I'm talking about data
> > > structures, you're talking about interrupts. You have this:
> > > 
> > > struct mvebu_pcie_port {
> > >        // Tons of stuff
> > >        struct irq_chip intx_chip;
> > > };
> > > 
> > > What I want you to do is:
> > > 
> > > struct mvebu_pcie_port {
> > >        // Tons of stuff
> > > };
> > > 
> > > static struct irq_chip intx_chip = {
> > > 	.name		= "INTx",
> > > 	.irq_mask	= mvebu_pcie_intx_irq_mask,
> > > 	.irq_unmask	= mvebu_pcie_intx_irq_unmask;
> > > };
> > > 
> > > That's it. No more, no less.
> > > 
> > > 	M.
> > > 
> > 
> > Hmm, but struct irq_chip contains a dynamic member,
> >   struct device *parent_device;
> > Isn't that used? Or are you planning to kill it?
> 
> Indeed, and I am definitely planning to kill it. This is the wrong
> place for this stuff, and I want it gone. There are thankfully very
> few users of this misfeature.

Ok, so what about this change?

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 1e90ab888075..5c816338a569 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -54,9 +54,10 @@
 	 PCIE_CONF_ADDR_EN)
 #define PCIE_CONF_DATA_OFF	0x18fc
 #define PCIE_INT_CAUSE_OFF	0x1900
+#define PCIE_INT_UNMASK_OFF	0x1910
+#define  PCIE_INT_INTX(i)		BIT(24+i)
 #define  PCIE_INT_PM_PME		BIT(28)
-#define PCIE_MASK_OFF		0x1910
-#define  PCIE_MASK_ENABLE_INTS          0x0f000000
+#define  PCIE_INT_ALL_MASK		GENMASK(31, 0)
 #define PCIE_CTRL_OFF		0x1a00
 #define  PCIE_CTRL_X1_MODE		0x0001
 #define  PCIE_CTRL_RC_MODE		BIT(1)
@@ -110,6 +111,9 @@ struct mvebu_pcie_port {
 	struct mvebu_pcie_window iowin;
 	u32 saved_pcie_stat;
 	struct resource regs;
+	struct irq_domain *intx_irq_domain;
+	raw_spinlock_t irq_lock;
+	int intx_irq;
 };
 
 static inline void mvebu_writel(struct mvebu_pcie_port *port, u32 val, u32 reg)
@@ -235,7 +239,7 @@ static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
 
 static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 {
-	u32 ctrl, lnkcap, cmd, dev_rev, mask;
+	u32 ctrl, lnkcap, cmd, dev_rev, unmask;
 
 	/* Setup PCIe controller to Root Complex mode. */
 	ctrl = mvebu_readl(port, PCIE_CTRL_OFF);
@@ -288,10 +292,30 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 	/* Point PCIe unit MBUS decode windows to DRAM space. */
 	mvebu_pcie_setup_wins(port);
 
-	/* Enable interrupt lines A-D. */
-	mask = mvebu_readl(port, PCIE_MASK_OFF);
-	mask |= PCIE_MASK_ENABLE_INTS;
-	mvebu_writel(port, mask, PCIE_MASK_OFF);
+	/* Mask all interrupt sources. */
+	mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_UNMASK_OFF);
+
+	/* Clear all interrupt causes. */
+	mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_CAUSE_OFF);
+
+	if (port->intx_irq <= 0) {
+		/*
+		 * When neither "summary" interrupt, nor "intx" interrupt was
+		 * specified in DT then unmask all legacy INTx interrupts as in
+		 * this case driver does not provide a way for masking and
+		 * unmasking of individual legacy INTx interrupts. In this case
+		 * all interrupts, including legacy INTx are reported via one
+		 * shared GIC source and therefore kernel cannot distinguish
+		 * which individual legacy INTx was triggered. These interrupts
+		 * are shared, so it should not cause any issue. Just
+		 * performance penalty as every PCIe interrupt handler needs to
+		 * be called when some interrupt is triggered.
+		 */
+		unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
+		unmask |= PCIE_INT_INTX(0) | PCIE_INT_INTX(1) |
+			  PCIE_INT_INTX(2) | PCIE_INT_INTX(3);
+		mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);
+	}
 }
 
 static struct mvebu_pcie_port *mvebu_pcie_find_port(struct mvebu_pcie *pcie,
@@ -924,6 +948,108 @@ static struct pci_ops mvebu_pcie_ops = {
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
@@ -1121,6 +1247,21 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
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
@@ -1317,6 +1458,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 
 	for (i = 0; i < pcie->nports; i++) {
 		struct mvebu_pcie_port *port = &pcie->ports[i];
+		int irq = port->intx_irq;
 
 		child = port->dn;
 		if (!child)
@@ -1344,6 +1486,22 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
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
@@ -1448,6 +1606,7 @@ static int mvebu_pcie_remove(struct platform_device *pdev)
 
 	for (i = 0; i < pcie->nports; i++) {
 		struct mvebu_pcie_port *port = &pcie->ports[i];
+		int irq = port->intx_irq;
 
 		if (!port->base)
 			continue;
@@ -1458,7 +1617,17 @@ static int mvebu_pcie_remove(struct platform_device *pdev)
 		mvebu_writel(port, cmd, PCIE_CMD_OFF);
 
 		/* Mask all interrupt sources. */
-		mvebu_writel(port, 0, PCIE_MASK_OFF);
+		mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_UNMASK_OFF);
+
+		/* Clear all interrupt causes. */
+		mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_CAUSE_OFF);
+
+		/* Remove IRQ domains. */
+		if (port->intx_irq_domain)
+			irq_domain_remove(port->intx_irq_domain);
+
+		if (irq > 0)
+			irq_set_chained_handler_and_data(irq, NULL, NULL);
 
 		/* Free config space for emulated root bridge. */
 		pci_bridge_emul_cleanup(&port->bridge);
-- 
2.20.1

