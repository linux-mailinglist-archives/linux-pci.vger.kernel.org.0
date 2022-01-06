Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED27C4866E2
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jan 2022 16:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240563AbiAFPoy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 10:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiAFPoy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jan 2022 10:44:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17014C061245;
        Thu,  6 Jan 2022 07:44:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6A19B8224F;
        Thu,  6 Jan 2022 15:44:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23AAFC36AE0;
        Thu,  6 Jan 2022 15:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641483891;
        bh=SKGy+AHODodXaXimOBt9iqG18ZJR+nt3b+A1v5FyIjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hg92c79hinepMxjVYpZkneNPyG/6S+jyeJkq8p/L0ZahwFDoivjpVSQLSE8l1ziQW
         8YE7IPaTut7yk+EqgqEIpnSD3tItRBSMHMUN4NZ6oaB/H2zIUWECbwmtlxBB14UaK3
         uWJ+B3STbQc+GeMRynzp8VTqREg9mvFKiihhKHRY+5o9V1cPsej0At02NIHRTa7q9U
         ZQhMnPD5Cuv58DxG7h8IPXDoWmQg9pH7T9zEdLcF8W2H7hr1+hJI1dr1SNqfCe7F4B
         Lx/CTOD07tR2wISsQ1hQvKeb/aUssgfE0QVoDHAWZBprwt++6LAYK9rc9I0dfc3Ouj
         rm0SoUd+ros3w==
Received: by pali.im (Postfix)
        id 0B2E9BFF; Thu,  6 Jan 2022 16:44:47 +0100 (CET)
Date:   Thu, 6 Jan 2022 16:44:47 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 10/11] PCI: mvebu: Implement support for legacy INTx
 interrupts
Message-ID: <20220106154447.aie6taiuvav5wu6y@pali>
References: <20220105150239.9628-1-pali@kernel.org>
 <20220105150239.9628-11-pali@kernel.org>
 <87bl0ovq7f.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bl0ovq7f.wl-maz@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 06 January 2022 15:28:20 Marc Zyngier wrote:
> On Wed, 05 Jan 2022 15:02:38 +0000,
> Pali Rohár <pali@kernel.org> wrote:
> > 
> > This adds support for legacy INTx interrupts received from other PCIe
> > devices and which are reported by a new INTx irq chip.
> > 
> > With this change, kernel can distinguish between INTA, INTB, INTC and INTD
> > interrupts.
> > 
> > Note that for this support, device tree files has to be properly adjusted
> > to provide "interrupts" or "interrupts-extended" property with intx
> > interrupt source, "interrupt-names" property with "intx" string and also
> > 'interrupt-controller' subnode must be defined.
> > 
> > If device tree files do not provide these nodes then driver would work as
> > before.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  drivers/pci/controller/pci-mvebu.c | 182 +++++++++++++++++++++++++++--
> >  1 file changed, 174 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> > index 1e90ab888075..04bcdd7b7a6d 100644
> > --- a/drivers/pci/controller/pci-mvebu.c
> > +++ b/drivers/pci/controller/pci-mvebu.c
> > @@ -54,9 +54,10 @@
> >  	 PCIE_CONF_ADDR_EN)
> >  #define PCIE_CONF_DATA_OFF	0x18fc
> >  #define PCIE_INT_CAUSE_OFF	0x1900
> > +#define PCIE_INT_UNMASK_OFF	0x1910
> > +#define  PCIE_INT_INTX(i)		BIT(24+i)
> >  #define  PCIE_INT_PM_PME		BIT(28)
> > -#define PCIE_MASK_OFF		0x1910
> > -#define  PCIE_MASK_ENABLE_INTS          0x0f000000
> > +#define  PCIE_INT_ALL_MASK		GENMASK(31, 0)
> >  #define PCIE_CTRL_OFF		0x1a00
> >  #define  PCIE_CTRL_X1_MODE		0x0001
> >  #define  PCIE_CTRL_RC_MODE		BIT(1)
> > @@ -110,6 +111,10 @@ struct mvebu_pcie_port {
> >  	struct mvebu_pcie_window iowin;
> >  	u32 saved_pcie_stat;
> >  	struct resource regs;
> > +	struct irq_domain *intx_irq_domain;
> > +	struct irq_chip intx_irq_chip;
> 
> Why is this structure per port? It really should be global. Printing
> the port number in the name isn't enough of a reason.

Because each port has its own independent set of INTA-INTD interrupts.

> > +	raw_spinlock_t irq_lock;
> > +	int intx_irq;
> >  };
> >  
> >  static inline void mvebu_writel(struct mvebu_pcie_port *port, u32 val, u32 reg)
> > @@ -235,7 +240,7 @@ static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
> >  
> >  static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
> >  {
> > -	u32 ctrl, lnkcap, cmd, dev_rev, mask;
> > +	u32 ctrl, lnkcap, cmd, dev_rev, unmask;
> >  
> >  	/* Setup PCIe controller to Root Complex mode. */
> >  	ctrl = mvebu_readl(port, PCIE_CTRL_OFF);
> > @@ -288,10 +293,30 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
> >  	/* Point PCIe unit MBUS decode windows to DRAM space. */
> >  	mvebu_pcie_setup_wins(port);
> >  
> > -	/* Enable interrupt lines A-D. */
> > -	mask = mvebu_readl(port, PCIE_MASK_OFF);
> > -	mask |= PCIE_MASK_ENABLE_INTS;
> > -	mvebu_writel(port, mask, PCIE_MASK_OFF);
> > +	/* Mask all interrupt sources. */
> > +	mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_UNMASK_OFF);
> > +
> > +	/* Clear all interrupt causes. */
> > +	mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_CAUSE_OFF);
> > +
> > +	if (port->intx_irq <= 0) {
> > +		/*
> > +		 * When neither "summary" interrupt, nor "intx" interrupt was
> > +		 * specified in DT then unmask all legacy INTx interrupts as in
> > +		 * this case driver does not provide a way for masking and
> > +		 * unmasking of individual legacy INTx interrupts. In this case
> > +		 * all interrupts, including legacy INTx are reported via one
> > +		 * shared GIC source and therefore kernel cannot distinguish
> > +		 * which individual legacy INTx was triggered. These interrupts
> > +		 * are shared, so it should not cause any issue. Just
> > +		 * performance penalty as every PCIe interrupt handler needs to
> > +		 * be called when some interrupt is triggered.
> > +		 */
> > +		unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
> > +		unmask |= PCIE_INT_INTX(0) | PCIE_INT_INTX(1) |
> > +			  PCIE_INT_INTX(2) | PCIE_INT_INTX(3);
> > +		mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);
> 
> Maybe worth printing a warning here, so that the user knows they are
> on thin ice.

Ok. I can add it here. Anyway, this is default current state without
this patch.

> > +	}
> >  }
> >  
> >  static struct mvebu_pcie_port *mvebu_pcie_find_port(struct mvebu_pcie *pcie,
> > @@ -924,6 +949,109 @@ static struct pci_ops mvebu_pcie_ops = {
> >  	.write = mvebu_pcie_wr_conf,
> >  };
> >  
> > +static void mvebu_pcie_intx_irq_mask(struct irq_data *d)
> > +{
> > +	struct mvebu_pcie_port *port = d->domain->host_data;
> > +	irq_hw_number_t hwirq = irqd_to_hwirq(d);
> > +	unsigned long flags;
> > +	u32 unmask;
> > +
> > +	raw_spin_lock_irqsave(&port->irq_lock, flags);
> > +	unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
> > +	unmask &= ~PCIE_INT_INTX(hwirq);
> > +	mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);
> > +	raw_spin_unlock_irqrestore(&port->irq_lock, flags);
> > +}
> > +
> > +static void mvebu_pcie_intx_irq_unmask(struct irq_data *d)
> > +{
> > +	struct mvebu_pcie_port *port = d->domain->host_data;
> > +	irq_hw_number_t hwirq = irqd_to_hwirq(d);
> > +	unsigned long flags;
> > +	u32 unmask;
> > +
> > +	raw_spin_lock_irqsave(&port->irq_lock, flags);
> > +	unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
> > +	unmask |= PCIE_INT_INTX(hwirq);
> > +	mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);
> > +	raw_spin_unlock_irqrestore(&port->irq_lock, flags);
> > +}
> > +
> > +static int mvebu_pcie_intx_irq_map(struct irq_domain *h,
> > +				   unsigned int virq, irq_hw_number_t hwirq)
> > +{
> > +	struct mvebu_pcie_port *port = h->host_data;
> > +
> > +	irq_set_status_flags(virq, IRQ_LEVEL);
> > +	irq_set_chip_and_handler(virq, &port->intx_irq_chip, handle_level_irq);
> > +	irq_set_chip_data(virq, port);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct irq_domain_ops mvebu_pcie_intx_irq_domain_ops = {
> > +	.map = mvebu_pcie_intx_irq_map,
> > +	.xlate = irq_domain_xlate_onecell,
> > +};
> > +
> > +static int mvebu_pcie_init_irq_domain(struct mvebu_pcie_port *port)
> > +{
> > +	struct device *dev = &port->pcie->pdev->dev;
> > +	struct device_node *pcie_intc_node;
> > +
> > +	raw_spin_lock_init(&port->irq_lock);
> > +
> > +	port->intx_irq_chip.name = devm_kasprintf(dev, GFP_KERNEL,
> > +						  "mvebu-%s-INTx",
> > +						  port->name);
> 
> That's exactly what I really don't want to see. It prevents sharing of
> the irq_chip structure, and gets in the way of making it const in the
> future. Yes, I know that some drivers do that. I can't fix those,
> because /proc/interrupts is ABI. But I really don't want to see more
> of these.

Well, I do not understand why it should be shared and with who. HW has N
independent IRQ chips for legacy interrupts. And each one will be
specified in DT per HW layout / design.

> /sys/kernel/debug/irqs already has all the information you need, as it
> will happily give you the domain name and the interrupt topology.
> 
> > +	port->intx_irq_chip.irq_mask = mvebu_pcie_intx_irq_mask;
> > +	port->intx_irq_chip.irq_unmask = mvebu_pcie_intx_irq_unmask;
> > +
> > +	pcie_intc_node = of_get_next_child(port->dn, NULL);
> > +	if (!pcie_intc_node) {
> > +		dev_err(dev, "No PCIe Intc node found for %s\n", port->name);
> > +		return -ENODEV;
> > +	}
> > +
> > +	port->intx_irq_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
> > +						      &mvebu_pcie_intx_irq_domain_ops,
> > +						      port);
> > +	of_node_put(pcie_intc_node);
> > +	if (!port->intx_irq_domain) {
> > +		devm_kfree(dev, port->intx_irq_chip.name);
> > +		dev_err(dev, "Failed to get INTx IRQ domain for %s\n", port->name);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void mvebu_pcie_irq_handler(struct irq_desc *desc)
> > +{
> > +	struct mvebu_pcie_port *port = irq_desc_get_handler_data(desc);
> > +	struct irq_chip *chip = irq_desc_get_chip(desc);
> > +	struct device *dev = &port->pcie->pdev->dev;
> > +	u32 cause, unmask, status;
> > +	int i;
> > +
> > +	chained_irq_enter(chip, desc);
> > +
> > +	cause = mvebu_readl(port, PCIE_INT_CAUSE_OFF);
> > +	unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
> 
> Why do you need to read this? If the CAUSE register also returns the
> masked interrupts that are pending,

Yes, it returns all interrupts, even those which are masked for which is
not system interested.

> it may be worth keeping a shadow
> copy of the this register, as you end-up having an extra MMIO read on
> each and every interrupt, which can't be great for performance.

Ok. I can set shadow copy of unmask register into port structure. But it
has really performance impact when reading directly unmask register from
hw and when reading it from port shadow copy structure?

> > +	status = cause & unmask;
> > +
> > +	/* Process legacy INTx interrupts */
> > +	for (i = 0; i < PCI_NUM_INTX; i++) {
> > +		if (!(status & PCIE_INT_INTX(i)))
> > +			continue;
> > +
> > +		if (generic_handle_domain_irq(port->intx_irq_domain, i) == -EINVAL)
> > +			dev_err_ratelimited(dev, "unexpected INT%c IRQ\n", (char)i+'A');
> > +	}
> > +
> > +	chained_irq_exit(chip, desc);
> > +}
> > +
> >  static int mvebu_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> >  {
> >  	/* Interrupt support on mvebu emulated bridges is not implemented yet */
> > @@ -1121,6 +1249,16 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
> >  		port->io_attr = -1;
> >  	}
> >  
> > +	/*
> > +	 * Old DT bindings do not contain "intx" interrupt
> > +	 * so do not fail probing driver when interrupt does not exist.
> > +	 */
> > +	port->intx_irq = of_irq_get_byname(child, "intx");
> > +	if (port->intx_irq == -EPROBE_DEFER) {
> > +		ret = port->intx_irq;
> > +		goto err;
> > +	}
> > +
> >  	reset_gpio = of_get_named_gpio_flags(child, "reset-gpios", 0, &flags);
> >  	if (reset_gpio == -EPROBE_DEFER) {
> >  		ret = reset_gpio;
> > @@ -1317,6 +1455,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
> >  
> >  	for (i = 0; i < pcie->nports; i++) {
> >  		struct mvebu_pcie_port *port = &pcie->ports[i];
> > +		int irq = port->intx_irq;
> >  
> >  		child = port->dn;
> >  		if (!child)
> > @@ -1344,6 +1483,22 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
> >  			continue;
> >  		}
> >  
> > +		if (irq > 0) {
> > +			ret = mvebu_pcie_init_irq_domain(port);
> > +			if (ret) {
> > +				dev_err(dev, "%s: cannot init irq domain\n",
> > +					port->name);
> > +				pci_bridge_emul_cleanup(&port->bridge);
> > +				devm_iounmap(dev, port->base);
> > +				port->base = NULL;
> > +				mvebu_pcie_powerdown(port);
> > +				continue;
> > +			}
> > +			irq_set_chained_handler_and_data(irq,
> > +							 mvebu_pcie_irq_handler,
> > +							 port);
> > +		}
> > +
> >  		/*
> >  		 * PCIe topology exported by mvebu hw is quite complicated. In
> >  		 * reality has something like N fully independent host bridges
> > @@ -1448,6 +1603,7 @@ static int mvebu_pcie_remove(struct platform_device *pdev)
> >  
> >  	for (i = 0; i < pcie->nports; i++) {
> >  		struct mvebu_pcie_port *port = &pcie->ports[i];
> > +		int irq = port->intx_irq;
> >  
> >  		if (!port->base)
> >  			continue;
> > @@ -1458,7 +1614,17 @@ static int mvebu_pcie_remove(struct platform_device *pdev)
> >  		mvebu_writel(port, cmd, PCIE_CMD_OFF);
> >  
> >  		/* Mask all interrupt sources. */
> > -		mvebu_writel(port, 0, PCIE_MASK_OFF);
> > +		mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_UNMASK_OFF);
> > +
> > +		/* Clear all interrupt causes. */
> > +		mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_CAUSE_OFF);
> > +
> > +		/* Remove IRQ domains. */
> > +		if (port->intx_irq_domain)
> > +			irq_domain_remove(port->intx_irq_domain);
> > +
> > +		if (irq > 0)
> > +			irq_set_chained_handler_and_data(irq, NULL, NULL);
> >  
> >  		/* Free config space for emulated root bridge. */
> >  		pci_bridge_emul_cleanup(&port->bridge);
> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
