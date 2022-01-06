Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD9F486787
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jan 2022 17:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241139AbiAFQU6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 11:20:58 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38058 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241118AbiAFQUv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jan 2022 11:20:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EE6D61ADE;
        Thu,  6 Jan 2022 16:20:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8CAC36AEB;
        Thu,  6 Jan 2022 16:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641486050;
        bh=tEtW2h+2Lml3QZ0awOJ4+V2sW+V5FDCEQIaq2JbAx0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n4X4ukKFQf952HWj5iECZCl5uLe4XzoulaI9hdKT2MdnvMADMHd/YT7YbBZhhX2Rq
         zkKwiyNyZoNtWz6OApbp8yrImV2OE+wn0o97HFRqOcNVkzY9orQT38mQsUFw8HeNYy
         +yWKqkMNKmucsEUUB/lVDq+tnz5ZCh0xRxOS+1QZ2Fz0mcJp3ZErzWAiIfm9EXq+YZ
         LvNW8V+JisCaCdQjh2GZl7JKB917EkjJdaFEASA7+vAkYiWrOTI+9I23Rmug/DRebY
         OMrpvISDlaDFRQqeTVEl/3S7lVZpYkJdZWOpWIkJzNhMudrNPG79gLLQSEseobCttc
         2vw11mqcUSUCg==
Received: by pali.im (Postfix)
        id A4959BFF; Thu,  6 Jan 2022 17:20:47 +0100 (CET)
Date:   Thu, 6 Jan 2022 17:20:47 +0100
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
Message-ID: <20220106162047.vqykmygs75eimfgy@pali>
References: <20220105150239.9628-1-pali@kernel.org>
 <20220105150239.9628-11-pali@kernel.org>
 <87bl0ovq7f.wl-maz@kernel.org>
 <20220106154447.aie6taiuvav5wu6y@pali>
 <878rvsvoyo.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878rvsvoyo.wl-maz@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 06 January 2022 15:55:11 Marc Zyngier wrote:
> On Thu, 06 Jan 2022 15:44:47 +0000,
> Pali Rohár <pali@kernel.org> wrote:
> > 
> > On Thursday 06 January 2022 15:28:20 Marc Zyngier wrote:
> > > On Wed, 05 Jan 2022 15:02:38 +0000,
> > > Pali Rohár <pali@kernel.org> wrote:
> > > > 
> > > > This adds support for legacy INTx interrupts received from other PCIe
> > > > devices and which are reported by a new INTx irq chip.
> > > > 
> > > > With this change, kernel can distinguish between INTA, INTB, INTC and INTD
> > > > interrupts.
> > > > 
> > > > Note that for this support, device tree files has to be properly adjusted
> > > > to provide "interrupts" or "interrupts-extended" property with intx
> > > > interrupt source, "interrupt-names" property with "intx" string and also
> > > > 'interrupt-controller' subnode must be defined.
> > > > 
> > > > If device tree files do not provide these nodes then driver would work as
> > > > before.
> > > > 
> > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > > ---
> > > >  drivers/pci/controller/pci-mvebu.c | 182 +++++++++++++++++++++++++++--
> > > >  1 file changed, 174 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> > > > index 1e90ab888075..04bcdd7b7a6d 100644
> > > > --- a/drivers/pci/controller/pci-mvebu.c
> > > > +++ b/drivers/pci/controller/pci-mvebu.c
> > > > @@ -54,9 +54,10 @@
> > > >  	 PCIE_CONF_ADDR_EN)
> > > >  #define PCIE_CONF_DATA_OFF	0x18fc
> > > >  #define PCIE_INT_CAUSE_OFF	0x1900
> > > > +#define PCIE_INT_UNMASK_OFF	0x1910
> > > > +#define  PCIE_INT_INTX(i)		BIT(24+i)
> > > >  #define  PCIE_INT_PM_PME		BIT(28)
> > > > -#define PCIE_MASK_OFF		0x1910
> > > > -#define  PCIE_MASK_ENABLE_INTS          0x0f000000
> > > > +#define  PCIE_INT_ALL_MASK		GENMASK(31, 0)
> > > >  #define PCIE_CTRL_OFF		0x1a00
> > > >  #define  PCIE_CTRL_X1_MODE		0x0001
> > > >  #define  PCIE_CTRL_RC_MODE		BIT(1)
> > > > @@ -110,6 +111,10 @@ struct mvebu_pcie_port {
> > > >  	struct mvebu_pcie_window iowin;
> > > >  	u32 saved_pcie_stat;
> > > >  	struct resource regs;
> > > > +	struct irq_domain *intx_irq_domain;
> > > > +	struct irq_chip intx_irq_chip;
> > > 
> > > Why is this structure per port? It really should be global. Printing
> > > the port number in the name isn't enough of a reason.
> > 
> > Because each port has its own independent set of INTA-INTD
> > interrupts.
> 
> That doesn't warrant a copy of an irq_chip structure that contains the
> exact same callbacks, and only differs by *a string*. And the use of
> this string is only to end-up in /proc/interrupts, which is totally
> pointless.
> 
> > 
> > > > +	raw_spinlock_t irq_lock;
> > > > +	int intx_irq;
> > > >  };
> > > >  
> > > >  static inline void mvebu_writel(struct mvebu_pcie_port *port, u32 val, u32 reg)
> > > > @@ -235,7 +240,7 @@ static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
> > > >  
> > > >  static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
> > > >  {
> > > > -	u32 ctrl, lnkcap, cmd, dev_rev, mask;
> > > > +	u32 ctrl, lnkcap, cmd, dev_rev, unmask;
> > > >  
> > > >  	/* Setup PCIe controller to Root Complex mode. */
> > > >  	ctrl = mvebu_readl(port, PCIE_CTRL_OFF);
> > > > @@ -288,10 +293,30 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
> > > >  	/* Point PCIe unit MBUS decode windows to DRAM space. */
> > > >  	mvebu_pcie_setup_wins(port);
> > > >  
> > > > -	/* Enable interrupt lines A-D. */
> > > > -	mask = mvebu_readl(port, PCIE_MASK_OFF);
> > > > -	mask |= PCIE_MASK_ENABLE_INTS;
> > > > -	mvebu_writel(port, mask, PCIE_MASK_OFF);
> > > > +	/* Mask all interrupt sources. */
> > > > +	mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_UNMASK_OFF);
> > > > +
> > > > +	/* Clear all interrupt causes. */
> > > > +	mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_CAUSE_OFF);
> > > > +
> > > > +	if (port->intx_irq <= 0) {
> > > > +		/*
> > > > +		 * When neither "summary" interrupt, nor "intx" interrupt was
> > > > +		 * specified in DT then unmask all legacy INTx interrupts as in
> > > > +		 * this case driver does not provide a way for masking and
> > > > +		 * unmasking of individual legacy INTx interrupts. In this case
> > > > +		 * all interrupts, including legacy INTx are reported via one
> > > > +		 * shared GIC source and therefore kernel cannot distinguish
> > > > +		 * which individual legacy INTx was triggered. These interrupts
> > > > +		 * are shared, so it should not cause any issue. Just
> > > > +		 * performance penalty as every PCIe interrupt handler needs to
> > > > +		 * be called when some interrupt is triggered.
> > > > +		 */
> > > > +		unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
> > > > +		unmask |= PCIE_INT_INTX(0) | PCIE_INT_INTX(1) |
> > > > +			  PCIE_INT_INTX(2) | PCIE_INT_INTX(3);
> > > > +		mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);
> > > 
> > > Maybe worth printing a warning here, so that the user knows they are
> > > on thin ice.
> > 
> > Ok. I can add it here. Anyway, this is default current state without
> > this patch.
> > 
> > > > +	}
> > > >  }
> > > >  
> > > >  static struct mvebu_pcie_port *mvebu_pcie_find_port(struct mvebu_pcie *pcie,
> > > > @@ -924,6 +949,109 @@ static struct pci_ops mvebu_pcie_ops = {
> > > >  	.write = mvebu_pcie_wr_conf,
> > > >  };
> > > >  
> > > > +static void mvebu_pcie_intx_irq_mask(struct irq_data *d)
> > > > +{
> > > > +	struct mvebu_pcie_port *port = d->domain->host_data;
> > > > +	irq_hw_number_t hwirq = irqd_to_hwirq(d);
> > > > +	unsigned long flags;
> > > > +	u32 unmask;
> > > > +
> > > > +	raw_spin_lock_irqsave(&port->irq_lock, flags);
> > > > +	unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
> > > > +	unmask &= ~PCIE_INT_INTX(hwirq);
> > > > +	mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);
> > > > +	raw_spin_unlock_irqrestore(&port->irq_lock, flags);
> > > > +}
> > > > +
> > > > +static void mvebu_pcie_intx_irq_unmask(struct irq_data *d)
> > > > +{
> > > > +	struct mvebu_pcie_port *port = d->domain->host_data;
> > > > +	irq_hw_number_t hwirq = irqd_to_hwirq(d);
> > > > +	unsigned long flags;
> > > > +	u32 unmask;
> > > > +
> > > > +	raw_spin_lock_irqsave(&port->irq_lock, flags);
> > > > +	unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
> > > > +	unmask |= PCIE_INT_INTX(hwirq);
> > > > +	mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);
> > > > +	raw_spin_unlock_irqrestore(&port->irq_lock, flags);
> > > > +}
> > > > +
> > > > +static int mvebu_pcie_intx_irq_map(struct irq_domain *h,
> > > > +				   unsigned int virq, irq_hw_number_t hwirq)
> > > > +{
> > > > +	struct mvebu_pcie_port *port = h->host_data;
> > > > +
> > > > +	irq_set_status_flags(virq, IRQ_LEVEL);
> > > > +	irq_set_chip_and_handler(virq, &port->intx_irq_chip, handle_level_irq);
> > > > +	irq_set_chip_data(virq, port);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static const struct irq_domain_ops mvebu_pcie_intx_irq_domain_ops = {
> > > > +	.map = mvebu_pcie_intx_irq_map,
> > > > +	.xlate = irq_domain_xlate_onecell,
> > > > +};
> > > > +
> > > > +static int mvebu_pcie_init_irq_domain(struct mvebu_pcie_port *port)
> > > > +{
> > > > +	struct device *dev = &port->pcie->pdev->dev;
> > > > +	struct device_node *pcie_intc_node;
> > > > +
> > > > +	raw_spin_lock_init(&port->irq_lock);
> > > > +
> > > > +	port->intx_irq_chip.name = devm_kasprintf(dev, GFP_KERNEL,
> > > > +						  "mvebu-%s-INTx",
> > > > +						  port->name);
> > > 
> > > That's exactly what I really don't want to see. It prevents sharing of
> > > the irq_chip structure, and gets in the way of making it const in the
> > > future. Yes, I know that some drivers do that. I can't fix those,
> > > because /proc/interrupts is ABI. But I really don't want to see more
> > > of these.
> > 
> > Well, I do not understand why it should be shared and with who. HW has N
> > independent IRQ chips for legacy interrupts. And each one will be
> > specified in DT per HW layout / design.
> 
> If you have multiple ports, all the ports can share the irq_chip
> structure. Actually scratch that. They *MUST* share the structure. The
> only reason you're not sharing it is to be able to print this useless
> string in /proc/interrupts.

What is the point of sharing one irq chip if HW has N independent irq
chips (for legacy interrupts)? I do not catch it yet. And I do not care
here for /proc/interrupts, so also I have not caught what do you mean be
last sentence with "the only reason".

And I still do not see how it could even work to have just one irq chip
and one irq domain as each irq domain needs to know to which port it
belongs, so it can mask/unmask interrupts from correct port. Also
initialization of domain is taking DT node and for each port it is
different.

So I'm somehow confused here...

The improvement in this patch is to be able to mask INTA interrupts on
port 1 and let INTA interrupts unmasked on port 2 if there drivers are
interested only for interrupts from device connected to port 2.

And if all interrupts are going to be shared (again) then it does not
solve any problem.
