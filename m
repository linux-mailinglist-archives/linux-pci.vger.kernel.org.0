Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795CF4B2C1E
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 18:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbiBKRwJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Feb 2022 12:52:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241935AbiBKRwI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Feb 2022 12:52:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A95CD5;
        Fri, 11 Feb 2022 09:52:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 605F261B32;
        Fri, 11 Feb 2022 17:52:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A89C340E9;
        Fri, 11 Feb 2022 17:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644601925;
        bh=MDjNpMVR2AwWur2zSVObJK4AXWlCJOvrM40G50Ed4x8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TUR3RYoCgcketT/M6l+CFc4V4O0NTQjSUois1U11uStfRLAh8/aCEq4FUho29Ya8A
         exIusdg2YrIooVv55vf6CVGi2UStQzA3vMhwd73TDHXRNBz9dWe71uDpcYgYrYXu44
         DVQVOnDCvHyAr9/ZxqL2Rfs83YAAUXVuSiyfDes6YsUZAqlV0BJt3TLLhmzkViVmOg
         GSo+qFldq7imKFJCMaEg4n8PPyeg/yDBLFXPjr1ESaqrRtRQCPsWKs1WixxlC+TlIu
         d1OaBwYoaprBm3wsOyRw4AXQAZy/b2KjzVen9GhaMeaZDwyCGyljXLQGb1zHg/LEU3
         5YJtQXXonR6Gg==
Received: by pali.im (Postfix)
        id 9D6C313A8; Fri, 11 Feb 2022 18:52:02 +0100 (CET)
Date:   Fri, 11 Feb 2022 18:52:02 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     robh+dt@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 10/11] PCI: mvebu: Implement support for legacy INTx
 interrupts
Message-ID: <20220211175202.gku5pkwn5wmjo5al@pali>
References: <20220105150239.9628-1-pali@kernel.org>
 <20220112151814.24361-1-pali@kernel.org>
 <20220112151814.24361-11-pali@kernel.org>
 <20220211171917.GA740@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220211171917.GA740@lpieralisi>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 11 February 2022 17:19:17 Lorenzo Pieralisi wrote:
> On Wed, Jan 12, 2022 at 04:18:13PM +0100, Pali Rohár wrote:
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
> 
> Nit: this information is not useful. DT rules are written in DT
> bindings, not in kernel commit logs. All I am saying is that firmware
> developers should not have to read this log to write firmware.

It was not intended for firmware developers, but for reviewers of this
patch to understand, what is happening in code and that with old DT
files this patch does not change driver behavior (= work as before).

> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  drivers/pci/controller/pci-mvebu.c | 185 +++++++++++++++++++++++++++--
> >  1 file changed, 177 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> > index 1e90ab888075..dbb6ecb4cb70 100644
> > --- a/drivers/pci/controller/pci-mvebu.c
> > +++ b/drivers/pci/controller/pci-mvebu.c
> > @@ -54,9 +54,10 @@
> >  	 PCIE_CONF_ADDR_EN)
> >  #define PCIE_CONF_DATA_OFF	0x18fc
> >  #define PCIE_INT_CAUSE_OFF	0x1900
> > +#define PCIE_INT_UNMASK_OFF	0x1910
> 
> Nit: I understand it is tempting but here you are redefining or better
> giving a proper label to a register. Separate patch please.

Ok!

> > +#define  PCIE_INT_INTX(i)		BIT(24+i)
> >  #define  PCIE_INT_PM_PME		BIT(28)
> > -#define PCIE_MASK_OFF		0x1910
> 
> See above.
> 
> > -#define  PCIE_MASK_ENABLE_INTS          0x0f000000
> > +#define  PCIE_INT_ALL_MASK		GENMASK(31, 0)
> >  #define PCIE_CTRL_OFF		0x1a00
> >  #define  PCIE_CTRL_X1_MODE		0x0001
> >  #define  PCIE_CTRL_RC_MODE		BIT(1)
> > @@ -110,6 +111,9 @@ struct mvebu_pcie_port {
> >  	struct mvebu_pcie_window iowin;
> >  	u32 saved_pcie_stat;
> >  	struct resource regs;
> > +	struct irq_domain *intx_irq_domain;
> > +	raw_spinlock_t irq_lock;
> > +	int intx_irq;
> >  };
> >  
> >  static inline void mvebu_writel(struct mvebu_pcie_port *port, u32 val, u32 reg)
> > @@ -235,7 +239,7 @@ static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
> >  
> >  static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
> >  {
> > -	u32 ctrl, lnkcap, cmd, dev_rev, mask;
> > +	u32 ctrl, lnkcap, cmd, dev_rev, unmask;
> >  
> >  	/* Setup PCIe controller to Root Complex mode. */
> >  	ctrl = mvebu_readl(port, PCIE_CTRL_OFF);
> > @@ -288,10 +292,30 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
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
> 
> This comment applies to current mainline right (ie it describes how
> current mainline handles INTx) ? IMO you should split it out in a
> separate patch.

This above comment describe what happens in if-branch when intx_irq is
not set (as written in comment "when intx interrupt was not specified in
DT"). You are right that this is also the behavior in the current
mainline.

I'm not sure if this comment can be split out as support for "intx"
interrupt is in this patch.

> I understand it is hard but a patch is a logical _change_, this
> comment is a change per se, it is a clarification on current
> behaviour.

Ok, I could try to split this comment into two patches, but part about
if-branch comment needs to stay in "this" patch.

> > +		unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
> > +		unmask |= PCIE_INT_INTX(0) | PCIE_INT_INTX(1) |
> > +			  PCIE_INT_INTX(2) | PCIE_INT_INTX(3);
> > +		mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);
> > +	}
> >  }
> >  
> >  static struct mvebu_pcie_port *mvebu_pcie_find_port(struct mvebu_pcie *pcie,
> > @@ -924,6 +948,108 @@ static struct pci_ops mvebu_pcie_ops = {
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
> > +static struct irq_chip intx_irq_chip = {
> > +	.name = "mvebu-INTx",
> > +	.irq_mask = mvebu_pcie_intx_irq_mask,
> > +	.irq_unmask = mvebu_pcie_intx_irq_unmask,
> > +};
> > +
> > +static int mvebu_pcie_intx_irq_map(struct irq_domain *h,
> > +				   unsigned int virq, irq_hw_number_t hwirq)
> > +{
> > +	struct mvebu_pcie_port *port = h->host_data;
> > +
> > +	irq_set_status_flags(virq, IRQ_LEVEL);
> > +	irq_set_chip_and_handler(virq, &intx_irq_chip, handle_level_irq);
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
> > @@ -1121,6 +1247,21 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
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
> > +	if (port->intx_irq <= 0) {
> > +		dev_warn(dev, "%s: legacy INTx interrupts cannot be masked individually, "
> > +			      "%pOF does not contain intx interrupt\n",
> > +			 port->name, child);
> 
> Here you end up with a new warning on existing firmware. Is it
> legitimate ? I would remove the dev_warn().

I added this warning in v2 because Marc wanted it.

Should I (again) remove it in v3?

> Rob certainly has more insightful advice on this.
> 
> Thanks,
> Lorenzo
> 
> > +	}
> > +
> >  	reset_gpio = of_get_named_gpio_flags(child, "reset-gpios", 0, &flags);
> >  	if (reset_gpio == -EPROBE_DEFER) {
> >  		ret = reset_gpio;
> > @@ -1317,6 +1458,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
> >  
> >  	for (i = 0; i < pcie->nports; i++) {
> >  		struct mvebu_pcie_port *port = &pcie->ports[i];
> > +		int irq = port->intx_irq;
> >  
> >  		child = port->dn;
> >  		if (!child)
> > @@ -1344,6 +1486,22 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
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
> > @@ -1448,6 +1606,7 @@ static int mvebu_pcie_remove(struct platform_device *pdev)
> >  
> >  	for (i = 0; i < pcie->nports; i++) {
> >  		struct mvebu_pcie_port *port = &pcie->ports[i];
> > +		int irq = port->intx_irq;
> >  
> >  		if (!port->base)
> >  			continue;
> > @@ -1458,7 +1617,17 @@ static int mvebu_pcie_remove(struct platform_device *pdev)
> >  		mvebu_writel(port, cmd, PCIE_CMD_OFF);
> >  
> >  		/* Mask all interrupt sources. */
> > -		mvebu_writel(port, 0, PCIE_MASK_OFF);
> > +		mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_UNMASK_OFF);
> > +
> > +		/* Clear all interrupt causes. */
> > +		mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_CAUSE_OFF);
> > +
> > +		if (irq > 0)
> > +			irq_set_chained_handler_and_data(irq, NULL, NULL);
> > +
> > +		/* Remove IRQ domains. */
> > +		if (port->intx_irq_domain)
> > +			irq_domain_remove(port->intx_irq_domain);
> >  
> >  		/* Free config space for emulated root bridge. */
> >  		pci_bridge_emul_cleanup(&port->bridge);
> > -- 
> > 2.20.1
> > 
