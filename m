Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A7E4866B4
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jan 2022 16:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240444AbiAFP21 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 10:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240432AbiAFP20 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jan 2022 10:28:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5280BC061245;
        Thu,  6 Jan 2022 07:28:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC1F8B82202;
        Thu,  6 Jan 2022 15:28:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D58C36AE3;
        Thu,  6 Jan 2022 15:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641482903;
        bh=gfZwgbxIfXJ7FOML0P8Y3zm7pmv4Wj/QAfnSTAvGnvU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FDqKR90ERkOmBPIGWrpv/KbtqmwnKYLRKuyrx3kdVe6P7eq9Y8dIfzWEzJMh1JrGy
         +HunOYdmRdAuqlw9lIcgRNPvoMZE28ZtoppoFXBJJowQ7PNGRkkthYuU+DGIz2J4p8
         xPJzW8mstEIct0MBjybDun9MnhYJPDaOlCt8fce1ASfYNm6Vs/gKMoUy+ICsgd+XRF
         DTjoC2yNJ+DougIcb+LKkRRwPJilLW7rYwMry7nsPiaCSsqIm2gaofGBqluIjRipMe
         DZUHq9ko7IvgU1DJ/subjfB/uRouoz7VCJ3aWTViLTXDTxs/egCwjPSErDTNoBd3BQ
         nbXaV7CWGIA8w==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1n5Ugf-00GNTe-5W; Thu, 06 Jan 2022 15:28:21 +0000
Date:   Thu, 06 Jan 2022 15:28:20 +0000
Message-ID: <87bl0ovq7f.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 10/11] PCI: mvebu: Implement support for legacy INTx interrupts
In-Reply-To: <20220105150239.9628-11-pali@kernel.org>
References: <20220105150239.9628-1-pali@kernel.org>
        <20220105150239.9628-11-pali@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: pali@kernel.org, lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org, thomas.petazzoni@bootlin.com, kw@linux.com, kabel@kernel.org, rmk+kernel@armlinux.org.uk, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 05 Jan 2022 15:02:38 +0000,
Pali Roh=C3=A1r <pali@kernel.org> wrote:
>=20
> This adds support for legacy INTx interrupts received from other PCIe
> devices and which are reported by a new INTx irq chip.
>=20
> With this change, kernel can distinguish between INTA, INTB, INTC and INTD
> interrupts.
>=20
> Note that for this support, device tree files has to be properly adjusted
> to provide "interrupts" or "interrupts-extended" property with intx
> interrupt source, "interrupt-names" property with "intx" string and also
> 'interrupt-controller' subnode must be defined.
>=20
> If device tree files do not provide these nodes then driver would work as
> before.
>=20
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> ---
>  drivers/pci/controller/pci-mvebu.c | 182 +++++++++++++++++++++++++++--
>  1 file changed, 174 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/=
pci-mvebu.c
> index 1e90ab888075..04bcdd7b7a6d 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -54,9 +54,10 @@
>  	 PCIE_CONF_ADDR_EN)
>  #define PCIE_CONF_DATA_OFF	0x18fc
>  #define PCIE_INT_CAUSE_OFF	0x1900
> +#define PCIE_INT_UNMASK_OFF	0x1910
> +#define  PCIE_INT_INTX(i)		BIT(24+i)
>  #define  PCIE_INT_PM_PME		BIT(28)
> -#define PCIE_MASK_OFF		0x1910
> -#define  PCIE_MASK_ENABLE_INTS          0x0f000000
> +#define  PCIE_INT_ALL_MASK		GENMASK(31, 0)
>  #define PCIE_CTRL_OFF		0x1a00
>  #define  PCIE_CTRL_X1_MODE		0x0001
>  #define  PCIE_CTRL_RC_MODE		BIT(1)
> @@ -110,6 +111,10 @@ struct mvebu_pcie_port {
>  	struct mvebu_pcie_window iowin;
>  	u32 saved_pcie_stat;
>  	struct resource regs;
> +	struct irq_domain *intx_irq_domain;
> +	struct irq_chip intx_irq_chip;

Why is this structure per port? It really should be global. Printing
the port number in the name isn't enough of a reason.

> +	raw_spinlock_t irq_lock;
> +	int intx_irq;
>  };
> =20
>  static inline void mvebu_writel(struct mvebu_pcie_port *port, u32 val, u=
32 reg)
> @@ -235,7 +240,7 @@ static void mvebu_pcie_setup_wins(struct mvebu_pcie_p=
ort *port)
> =20
>  static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
>  {
> -	u32 ctrl, lnkcap, cmd, dev_rev, mask;
> +	u32 ctrl, lnkcap, cmd, dev_rev, unmask;
> =20
>  	/* Setup PCIe controller to Root Complex mode. */
>  	ctrl =3D mvebu_readl(port, PCIE_CTRL_OFF);
> @@ -288,10 +293,30 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_p=
ort *port)
>  	/* Point PCIe unit MBUS decode windows to DRAM space. */
>  	mvebu_pcie_setup_wins(port);
> =20
> -	/* Enable interrupt lines A-D. */
> -	mask =3D mvebu_readl(port, PCIE_MASK_OFF);
> -	mask |=3D PCIE_MASK_ENABLE_INTS;
> -	mvebu_writel(port, mask, PCIE_MASK_OFF);
> +	/* Mask all interrupt sources. */
> +	mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_UNMASK_OFF);
> +
> +	/* Clear all interrupt causes. */
> +	mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_CAUSE_OFF);
> +
> +	if (port->intx_irq <=3D 0) {
> +		/*
> +		 * When neither "summary" interrupt, nor "intx" interrupt was
> +		 * specified in DT then unmask all legacy INTx interrupts as in
> +		 * this case driver does not provide a way for masking and
> +		 * unmasking of individual legacy INTx interrupts. In this case
> +		 * all interrupts, including legacy INTx are reported via one
> +		 * shared GIC source and therefore kernel cannot distinguish
> +		 * which individual legacy INTx was triggered. These interrupts
> +		 * are shared, so it should not cause any issue. Just
> +		 * performance penalty as every PCIe interrupt handler needs to
> +		 * be called when some interrupt is triggered.
> +		 */
> +		unmask =3D mvebu_readl(port, PCIE_INT_UNMASK_OFF);
> +		unmask |=3D PCIE_INT_INTX(0) | PCIE_INT_INTX(1) |
> +			  PCIE_INT_INTX(2) | PCIE_INT_INTX(3);
> +		mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);

Maybe worth printing a warning here, so that the user knows they are
on thin ice.

> +	}
>  }
> =20
>  static struct mvebu_pcie_port *mvebu_pcie_find_port(struct mvebu_pcie *p=
cie,
> @@ -924,6 +949,109 @@ static struct pci_ops mvebu_pcie_ops =3D {
>  	.write =3D mvebu_pcie_wr_conf,
>  };
> =20
> +static void mvebu_pcie_intx_irq_mask(struct irq_data *d)
> +{
> +	struct mvebu_pcie_port *port =3D d->domain->host_data;
> +	irq_hw_number_t hwirq =3D irqd_to_hwirq(d);
> +	unsigned long flags;
> +	u32 unmask;
> +
> +	raw_spin_lock_irqsave(&port->irq_lock, flags);
> +	unmask =3D mvebu_readl(port, PCIE_INT_UNMASK_OFF);
> +	unmask &=3D ~PCIE_INT_INTX(hwirq);
> +	mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);
> +	raw_spin_unlock_irqrestore(&port->irq_lock, flags);
> +}
> +
> +static void mvebu_pcie_intx_irq_unmask(struct irq_data *d)
> +{
> +	struct mvebu_pcie_port *port =3D d->domain->host_data;
> +	irq_hw_number_t hwirq =3D irqd_to_hwirq(d);
> +	unsigned long flags;
> +	u32 unmask;
> +
> +	raw_spin_lock_irqsave(&port->irq_lock, flags);
> +	unmask =3D mvebu_readl(port, PCIE_INT_UNMASK_OFF);
> +	unmask |=3D PCIE_INT_INTX(hwirq);
> +	mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);
> +	raw_spin_unlock_irqrestore(&port->irq_lock, flags);
> +}
> +
> +static int mvebu_pcie_intx_irq_map(struct irq_domain *h,
> +				   unsigned int virq, irq_hw_number_t hwirq)
> +{
> +	struct mvebu_pcie_port *port =3D h->host_data;
> +
> +	irq_set_status_flags(virq, IRQ_LEVEL);
> +	irq_set_chip_and_handler(virq, &port->intx_irq_chip, handle_level_irq);
> +	irq_set_chip_data(virq, port);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops mvebu_pcie_intx_irq_domain_ops =3D {
> +	.map =3D mvebu_pcie_intx_irq_map,
> +	.xlate =3D irq_domain_xlate_onecell,
> +};
> +
> +static int mvebu_pcie_init_irq_domain(struct mvebu_pcie_port *port)
> +{
> +	struct device *dev =3D &port->pcie->pdev->dev;
> +	struct device_node *pcie_intc_node;
> +
> +	raw_spin_lock_init(&port->irq_lock);
> +
> +	port->intx_irq_chip.name =3D devm_kasprintf(dev, GFP_KERNEL,
> +						  "mvebu-%s-INTx",
> +						  port->name);

That's exactly what I really don't want to see. It prevents sharing of
the irq_chip structure, and gets in the way of making it const in the
future. Yes, I know that some drivers do that. I can't fix those,
because /proc/interrupts is ABI. But I really don't want to see more
of these.

/sys/kernel/debug/irqs already has all the information you need, as it
will happily give you the domain name and the interrupt topology.

> +	port->intx_irq_chip.irq_mask =3D mvebu_pcie_intx_irq_mask;
> +	port->intx_irq_chip.irq_unmask =3D mvebu_pcie_intx_irq_unmask;
> +
> +	pcie_intc_node =3D of_get_next_child(port->dn, NULL);
> +	if (!pcie_intc_node) {
> +		dev_err(dev, "No PCIe Intc node found for %s\n", port->name);
> +		return -ENODEV;
> +	}
> +
> +	port->intx_irq_domain =3D irq_domain_add_linear(pcie_intc_node, PCI_NUM=
_INTX,
> +						      &mvebu_pcie_intx_irq_domain_ops,
> +						      port);
> +	of_node_put(pcie_intc_node);
> +	if (!port->intx_irq_domain) {
> +		devm_kfree(dev, port->intx_irq_chip.name);
> +		dev_err(dev, "Failed to get INTx IRQ domain for %s\n", port->name);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static void mvebu_pcie_irq_handler(struct irq_desc *desc)
> +{
> +	struct mvebu_pcie_port *port =3D irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> +	struct device *dev =3D &port->pcie->pdev->dev;
> +	u32 cause, unmask, status;
> +	int i;
> +
> +	chained_irq_enter(chip, desc);
> +
> +	cause =3D mvebu_readl(port, PCIE_INT_CAUSE_OFF);
> +	unmask =3D mvebu_readl(port, PCIE_INT_UNMASK_OFF);

Why do you need to read this? If the CAUSE register also returns the
masked interrupts that are pending, it may be worth keeping a shadow
copy of the this register, as you end-up having an extra MMIO read on
each and every interrupt, which can't be great for performance.

> +	status =3D cause & unmask;
> +
> +	/* Process legacy INTx interrupts */
> +	for (i =3D 0; i < PCI_NUM_INTX; i++) {
> +		if (!(status & PCIE_INT_INTX(i)))
> +			continue;
> +
> +		if (generic_handle_domain_irq(port->intx_irq_domain, i) =3D=3D -EINVAL)
> +			dev_err_ratelimited(dev, "unexpected INT%c IRQ\n", (char)i+'A');
> +	}
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
>  static int mvebu_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
>  {
>  	/* Interrupt support on mvebu emulated bridges is not implemented yet */
> @@ -1121,6 +1249,16 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie=
 *pcie,
>  		port->io_attr =3D -1;
>  	}
> =20
> +	/*
> +	 * Old DT bindings do not contain "intx" interrupt
> +	 * so do not fail probing driver when interrupt does not exist.
> +	 */
> +	port->intx_irq =3D of_irq_get_byname(child, "intx");
> +	if (port->intx_irq =3D=3D -EPROBE_DEFER) {
> +		ret =3D port->intx_irq;
> +		goto err;
> +	}
> +
>  	reset_gpio =3D of_get_named_gpio_flags(child, "reset-gpios", 0, &flags);
>  	if (reset_gpio =3D=3D -EPROBE_DEFER) {
>  		ret =3D reset_gpio;
> @@ -1317,6 +1455,7 @@ static int mvebu_pcie_probe(struct platform_device =
*pdev)
> =20
>  	for (i =3D 0; i < pcie->nports; i++) {
>  		struct mvebu_pcie_port *port =3D &pcie->ports[i];
> +		int irq =3D port->intx_irq;
> =20
>  		child =3D port->dn;
>  		if (!child)
> @@ -1344,6 +1483,22 @@ static int mvebu_pcie_probe(struct platform_device=
 *pdev)
>  			continue;
>  		}
> =20
> +		if (irq > 0) {
> +			ret =3D mvebu_pcie_init_irq_domain(port);
> +			if (ret) {
> +				dev_err(dev, "%s: cannot init irq domain\n",
> +					port->name);
> +				pci_bridge_emul_cleanup(&port->bridge);
> +				devm_iounmap(dev, port->base);
> +				port->base =3D NULL;
> +				mvebu_pcie_powerdown(port);
> +				continue;
> +			}
> +			irq_set_chained_handler_and_data(irq,
> +							 mvebu_pcie_irq_handler,
> +							 port);
> +		}
> +
>  		/*
>  		 * PCIe topology exported by mvebu hw is quite complicated. In
>  		 * reality has something like N fully independent host bridges
> @@ -1448,6 +1603,7 @@ static int mvebu_pcie_remove(struct platform_device=
 *pdev)
> =20
>  	for (i =3D 0; i < pcie->nports; i++) {
>  		struct mvebu_pcie_port *port =3D &pcie->ports[i];
> +		int irq =3D port->intx_irq;
> =20
>  		if (!port->base)
>  			continue;
> @@ -1458,7 +1614,17 @@ static int mvebu_pcie_remove(struct platform_devic=
e *pdev)
>  		mvebu_writel(port, cmd, PCIE_CMD_OFF);
> =20
>  		/* Mask all interrupt sources. */
> -		mvebu_writel(port, 0, PCIE_MASK_OFF);
> +		mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_UNMASK_OFF);
> +
> +		/* Clear all interrupt causes. */
> +		mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_CAUSE_OFF);
> +
> +		/* Remove IRQ domains. */
> +		if (port->intx_irq_domain)
> +			irq_domain_remove(port->intx_irq_domain);
> +
> +		if (irq > 0)
> +			irq_set_chained_handler_and_data(irq, NULL, NULL);
> =20
>  		/* Free config space for emulated root bridge. */
>  		pci_bridge_emul_cleanup(&port->bridge);

Thanks,

	M.

--=20
Without deviation from the norm, progress is not possible.
