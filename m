Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCCF48684F
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jan 2022 18:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241668AbiAFRUz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 12:20:55 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:45684 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241633AbiAFRUz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jan 2022 12:20:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8573DCE265F;
        Thu,  6 Jan 2022 17:20:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2A7C36AE3;
        Thu,  6 Jan 2022 17:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641489651;
        bh=6hGkG8sCapfiKE5GsYhVlbIB0Sw85pSQfdIq/VJCMOY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j90KTY3hiwGxIaKHuOMWXUbepPuhljaZHQEr8eV1Z4BaoMm5W6fMj8WaRMbAcZkmm
         UO0mz98oaA8ZOqWRE9BH4dlc1gcoMvFJGN4n8qhQT5l9wbr1NvogdQauJKR3FO35HJ
         FvOQr4FdWSbD7imtIKiKjaKY2Ym6iwABwomYEPCrviGjeFz4C0LIj6+rnKO7URsj2W
         2etjKhUdx7sz1b23A9Gr5ku3MRFmJUj0zm2EpDyBBGBpPhSgEOKabx/pg02vq8NESd
         MpPeEPD2eDjMCfexrPV1s2ymNOwP6qEQPAXoOpWLVj7Mhz0l1zs0BeONKiSbB6rcr9
         sdw+mwav3CB5A==
Date:   Thu, 6 Jan 2022 18:20:44 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 10/11] PCI: mvebu: Implement support for legacy INTx
 interrupts
Message-ID: <20220106182044.3ff0828c@thinkpad>
In-Reply-To: <877dbcvngf.wl-maz@kernel.org>
References: <20220105150239.9628-1-pali@kernel.org>
        <20220105150239.9628-11-pali@kernel.org>
        <87bl0ovq7f.wl-maz@kernel.org>
        <20220106154447.aie6taiuvav5wu6y@pali>
        <878rvsvoyo.wl-maz@kernel.org>
        <20220106162047.vqykmygs75eimfgy@pali>
        <877dbcvngf.wl-maz@kernel.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 06 Jan 2022 16:27:44 +0000
Marc Zyngier <maz@kernel.org> wrote:

> On Thu, 06 Jan 2022 16:20:47 +0000,
> Pali Roh=C3=A1r <pali@kernel.org> wrote:
> >=20
> > On Thursday 06 January 2022 15:55:11 Marc Zyngier wrote: =20
> > > On Thu, 06 Jan 2022 15:44:47 +0000,
> > > Pali Roh=C3=A1r <pali@kernel.org> wrote: =20
> > > >=20
> > > > On Thursday 06 January 2022 15:28:20 Marc Zyngier wrote: =20
> > > > > On Wed, 05 Jan 2022 15:02:38 +0000,
> > > > > Pali Roh=C3=A1r <pali@kernel.org> wrote: =20
> > > > > >=20
> > > > > > This adds support for legacy INTx interrupts received from othe=
r PCIe
> > > > > > devices and which are reported by a new INTx irq chip.
> > > > > >=20
> > > > > > With this change, kernel can distinguish between INTA, INTB, IN=
TC and INTD
> > > > > > interrupts.
> > > > > >=20
> > > > > > Note that for this support, device tree files has to be properl=
y adjusted
> > > > > > to provide "interrupts" or "interrupts-extended" property with =
intx
> > > > > > interrupt source, "interrupt-names" property with "intx" string=
 and also
> > > > > > 'interrupt-controller' subnode must be defined.
> > > > > >=20
> > > > > > If device tree files do not provide these nodes then driver wou=
ld work as
> > > > > > before.
> > > > > >=20
> > > > > > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> > > > > > ---
> > > > > >  drivers/pci/controller/pci-mvebu.c | 182 +++++++++++++++++++++=
++++++--
> > > > > >  1 file changed, 174 insertions(+), 8 deletions(-)
> > > > > >=20
> > > > > > diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/c=
ontroller/pci-mvebu.c
> > > > > > index 1e90ab888075..04bcdd7b7a6d 100644
> > > > > > --- a/drivers/pci/controller/pci-mvebu.c
> > > > > > +++ b/drivers/pci/controller/pci-mvebu.c
> > > > > > @@ -54,9 +54,10 @@
> > > > > >  	 PCIE_CONF_ADDR_EN)
> > > > > >  #define PCIE_CONF_DATA_OFF	0x18fc
> > > > > >  #define PCIE_INT_CAUSE_OFF	0x1900
> > > > > > +#define PCIE_INT_UNMASK_OFF	0x1910
> > > > > > +#define  PCIE_INT_INTX(i)		BIT(24+i)
> > > > > >  #define  PCIE_INT_PM_PME		BIT(28)
> > > > > > -#define PCIE_MASK_OFF		0x1910
> > > > > > -#define  PCIE_MASK_ENABLE_INTS          0x0f000000
> > > > > > +#define  PCIE_INT_ALL_MASK		GENMASK(31, 0)
> > > > > >  #define PCIE_CTRL_OFF		0x1a00
> > > > > >  #define  PCIE_CTRL_X1_MODE		0x0001
> > > > > >  #define  PCIE_CTRL_RC_MODE		BIT(1)
> > > > > > @@ -110,6 +111,10 @@ struct mvebu_pcie_port {
> > > > > >  	struct mvebu_pcie_window iowin;
> > > > > >  	u32 saved_pcie_stat;
> > > > > >  	struct resource regs;
> > > > > > +	struct irq_domain *intx_irq_domain;
> > > > > > +	struct irq_chip intx_irq_chip; =20
> > > > >=20
> > > > > Why is this structure per port? It really should be global. Print=
ing
> > > > > the port number in the name isn't enough of a reason. =20
> > > >=20
> > > > Because each port has its own independent set of INTA-INTD
> > > > interrupts. =20
> > >=20
> > > That doesn't warrant a copy of an irq_chip structure that contains the
> > > exact same callbacks, and only differs by *a string*. And the use of
> > > this string is only to end-up in /proc/interrupts, which is totally
> > > pointless.
> > >  =20
> > > >  =20
> > > > > > +	raw_spinlock_t irq_lock;
> > > > > > +	int intx_irq;
> > > > > >  };
> > > > > > =20
> > > > > >  static inline void mvebu_writel(struct mvebu_pcie_port *port, =
u32 val, u32 reg)
> > > > > > @@ -235,7 +240,7 @@ static void mvebu_pcie_setup_wins(struct mv=
ebu_pcie_port *port)
> > > > > > =20
> > > > > >  static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
> > > > > >  {
> > > > > > -	u32 ctrl, lnkcap, cmd, dev_rev, mask;
> > > > > > +	u32 ctrl, lnkcap, cmd, dev_rev, unmask;
> > > > > > =20
> > > > > >  	/* Setup PCIe controller to Root Complex mode. */
> > > > > >  	ctrl =3D mvebu_readl(port, PCIE_CTRL_OFF);
> > > > > > @@ -288,10 +293,30 @@ static void mvebu_pcie_setup_hw(struct mv=
ebu_pcie_port *port)
> > > > > >  	/* Point PCIe unit MBUS decode windows to DRAM space. */
> > > > > >  	mvebu_pcie_setup_wins(port);
> > > > > > =20
> > > > > > -	/* Enable interrupt lines A-D. */
> > > > > > -	mask =3D mvebu_readl(port, PCIE_MASK_OFF);
> > > > > > -	mask |=3D PCIE_MASK_ENABLE_INTS;
> > > > > > -	mvebu_writel(port, mask, PCIE_MASK_OFF);
> > > > > > +	/* Mask all interrupt sources. */
> > > > > > +	mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_UNMASK_OFF);
> > > > > > +
> > > > > > +	/* Clear all interrupt causes. */
> > > > > > +	mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_CAUSE_OFF);
> > > > > > +
> > > > > > +	if (port->intx_irq <=3D 0) {
> > > > > > +		/*
> > > > > > +		 * When neither "summary" interrupt, nor "intx" interrupt was
> > > > > > +		 * specified in DT then unmask all legacy INTx interrupts as=
 in
> > > > > > +		 * this case driver does not provide a way for masking and
> > > > > > +		 * unmasking of individual legacy INTx interrupts. In this c=
ase
> > > > > > +		 * all interrupts, including legacy INTx are reported via one
> > > > > > +		 * shared GIC source and therefore kernel cannot distinguish
> > > > > > +		 * which individual legacy INTx was triggered. These interru=
pts
> > > > > > +		 * are shared, so it should not cause any issue. Just
> > > > > > +		 * performance penalty as every PCIe interrupt handler needs=
 to
> > > > > > +		 * be called when some interrupt is triggered.
> > > > > > +		 */
> > > > > > +		unmask =3D mvebu_readl(port, PCIE_INT_UNMASK_OFF);
> > > > > > +		unmask |=3D PCIE_INT_INTX(0) | PCIE_INT_INTX(1) |
> > > > > > +			  PCIE_INT_INTX(2) | PCIE_INT_INTX(3);
> > > > > > +		mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF); =20
> > > > >=20
> > > > > Maybe worth printing a warning here, so that the user knows they =
are
> > > > > on thin ice. =20
> > > >=20
> > > > Ok. I can add it here. Anyway, this is default current state without
> > > > this patch.
> > > >  =20
> > > > > > +	}
> > > > > >  }
> > > > > > =20
> > > > > >  static struct mvebu_pcie_port *mvebu_pcie_find_port(struct mve=
bu_pcie *pcie,
> > > > > > @@ -924,6 +949,109 @@ static struct pci_ops mvebu_pcie_ops =3D {
> > > > > >  	.write =3D mvebu_pcie_wr_conf,
> > > > > >  };
> > > > > > =20
> > > > > > +static void mvebu_pcie_intx_irq_mask(struct irq_data *d)
> > > > > > +{
> > > > > > +	struct mvebu_pcie_port *port =3D d->domain->host_data;
> > > > > > +	irq_hw_number_t hwirq =3D irqd_to_hwirq(d);
> > > > > > +	unsigned long flags;
> > > > > > +	u32 unmask;
> > > > > > +
> > > > > > +	raw_spin_lock_irqsave(&port->irq_lock, flags);
> > > > > > +	unmask =3D mvebu_readl(port, PCIE_INT_UNMASK_OFF);
> > > > > > +	unmask &=3D ~PCIE_INT_INTX(hwirq);
> > > > > > +	mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);
> > > > > > +	raw_spin_unlock_irqrestore(&port->irq_lock, flags);
> > > > > > +}
> > > > > > +
> > > > > > +static void mvebu_pcie_intx_irq_unmask(struct irq_data *d)
> > > > > > +{
> > > > > > +	struct mvebu_pcie_port *port =3D d->domain->host_data;
> > > > > > +	irq_hw_number_t hwirq =3D irqd_to_hwirq(d);
> > > > > > +	unsigned long flags;
> > > > > > +	u32 unmask;
> > > > > > +
> > > > > > +	raw_spin_lock_irqsave(&port->irq_lock, flags);
> > > > > > +	unmask =3D mvebu_readl(port, PCIE_INT_UNMASK_OFF);
> > > > > > +	unmask |=3D PCIE_INT_INTX(hwirq);
> > > > > > +	mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);
> > > > > > +	raw_spin_unlock_irqrestore(&port->irq_lock, flags);
> > > > > > +}
> > > > > > +
> > > > > > +static int mvebu_pcie_intx_irq_map(struct irq_domain *h,
> > > > > > +				   unsigned int virq, irq_hw_number_t hwirq)
> > > > > > +{
> > > > > > +	struct mvebu_pcie_port *port =3D h->host_data;
> > > > > > +
> > > > > > +	irq_set_status_flags(virq, IRQ_LEVEL);
> > > > > > +	irq_set_chip_and_handler(virq, &port->intx_irq_chip, handle_l=
evel_irq);
> > > > > > +	irq_set_chip_data(virq, port);
> > > > > > +
> > > > > > +	return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static const struct irq_domain_ops mvebu_pcie_intx_irq_domain_=
ops =3D {
> > > > > > +	.map =3D mvebu_pcie_intx_irq_map,
> > > > > > +	.xlate =3D irq_domain_xlate_onecell,
> > > > > > +};
> > > > > > +
> > > > > > +static int mvebu_pcie_init_irq_domain(struct mvebu_pcie_port *=
port)
> > > > > > +{
> > > > > > +	struct device *dev =3D &port->pcie->pdev->dev;
> > > > > > +	struct device_node *pcie_intc_node;
> > > > > > +
> > > > > > +	raw_spin_lock_init(&port->irq_lock);
> > > > > > +
> > > > > > +	port->intx_irq_chip.name =3D devm_kasprintf(dev, GFP_KERNEL,
> > > > > > +						  "mvebu-%s-INTx",
> > > > > > +						  port->name); =20
> > > > >=20
> > > > > That's exactly what I really don't want to see. It prevents shari=
ng of
> > > > > the irq_chip structure, and gets in the way of making it const in=
 the
> > > > > future. Yes, I know that some drivers do that. I can't fix those,
> > > > > because /proc/interrupts is ABI. But I really don't want to see m=
ore
> > > > > of these. =20
> > > >=20
> > > > Well, I do not understand why it should be shared and with who. HW =
has N
> > > > independent IRQ chips for legacy interrupts. And each one will be
> > > > specified in DT per HW layout / design. =20
> > >=20
> > > If you have multiple ports, all the ports can share the irq_chip
> > > structure. Actually scratch that. They *MUST* share the structure. The
> > > only reason you're not sharing it is to be able to print this useless
> > > string in /proc/interrupts. =20
> >=20
> > What is the point of sharing one irq chip if HW has N independent irq
> > chips (for legacy interrupts)? I do not catch it yet. And I do not care
> > here for /proc/interrupts, so also I have not caught what do you mean be
> > last sentence with "the only reason".
> >=20
> > And I still do not see how it could even work to have just one irq chip
> > and one irq domain as each irq domain needs to know to which port it
> > belongs, so it can mask/unmask interrupts from correct port. Also
> > initialization of domain is taking DT node and for each port it is
> > different.
> >=20
> > So I'm somehow confused here...
> >=20
> > The improvement in this patch is to be able to mask INTA interrupts on
> > port 1 and let INTA interrupts unmasked on port 2 if there drivers are
> > interested only for interrupts from device connected to port 2.
> >=20
> > And if all interrupts are going to be shared (again) then it does not
> > solve any problem. =20
>=20
> You are completely missing my point. I'm talking about data
> structures, you're talking about interrupts. You have this:
>=20
> struct mvebu_pcie_port {
>        // Tons of stuff
>        struct irq_chip intx_chip;
> };
>=20
> What I want you to do is:
>=20
> struct mvebu_pcie_port {
>        // Tons of stuff
> };
>=20
> static struct irq_chip intx_chip =3D {
> 	.name		=3D "INTx",
> 	.irq_mask	=3D mvebu_pcie_intx_irq_mask,
> 	.irq_unmask	=3D mvebu_pcie_intx_irq_unmask;
> };
>=20
> That's it. No more, no less.
>=20
> 	M.
>=20

Hmm, but struct irq_chip contains a dynamic member,
  struct device *parent_device;
Isn't that used? Or are you planning to kill it?

Marek
