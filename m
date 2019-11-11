Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 750F2F72FF
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2019 12:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfKKLVw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Nov 2019 06:21:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:40212 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726791AbfKKLVw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Nov 2019 06:21:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A729EB490;
        Mon, 11 Nov 2019 11:21:48 +0000 (UTC)
Message-ID: <86aeec16bc04d17372db5e33ffec0d5621973116.camel@suse.de>
Subject: Re: [PATCH 4/4] PCI: brcmstb: add MSI capability
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     maz@kernel.org
Cc:     Andrew Murray <andrew.murray@arm.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>, mbrugger@suse.com,
        phil@raspberrypi.org, linux-kernel@vger.kernel.org,
        wahrenst@gmx.net, james.quinlan@broadcom.com,
        Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon, 11 Nov 2019 12:21:41 +0100
In-Reply-To: <f1154b65d422e2e37e3b320e662d4268@www.loen.fr>
References: <20191106214527.18736-1-nsaenzjulienne@suse.de>
         <20191106214527.18736-5-nsaenzjulienne@suse.de>
         <f1154b65d422e2e37e3b320e662d4268@www.loen.fr>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Aeotz4Kz86JAeSXZZo/i"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-Aeotz4Kz86JAeSXZZo/i
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marc,
thanks for the review!

On Thu, 2019-11-07 at 16:49 +0109, Marc Zyngier wrote:
> On 2019-11-06 22:54, Nicolas Saenz Julienne wrote:
> > From: Jim Quinlan <james.quinlan@broadcom.com>
> >=20
> > This commit adds MSI to the Broadcom STB PCIe host controller. It=20
> > does
> > not add MSIX since that functionality is not in the HW.  The MSI
> > controller is physically located within the PCIe block, however,=20
> > there
> > is no reason why the MSI controller could not be moved elsewhere in
> > the future.
> >=20
> > Since the internal Brcmstb MSI controller is intertwined with the=20
> > PCIe
> > controller, it is not its own platform device but rather part of the
> > PCIe platform device.
> >=20
> > This is based on Jim's original submission[1] with some slight=20
> > changes
> > regarding how pcie->msi_target_addr is decided.
> >=20
> > [1] https://patchwork.kernel.org/patch/10605955/
> >=20
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > Co-developed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> >  drivers/pci/controller/Kconfig        |   2 +-
> >  drivers/pci/controller/pcie-brcmstb.c | 333=20
> > +++++++++++++++++++++++++-
> >  2 files changed, 332 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/pci/controller/Kconfig=20
> > b/drivers/pci/controller/Kconfig
> > index 8b3aae91d8af..99b972ad3f2f 100644
> > --- a/drivers/pci/controller/Kconfig
> > +++ b/drivers/pci/controller/Kconfig
> > @@ -284,7 +284,7 @@ config VMD
> >  config PCIE_BRCMSTB
> >  	bool "Broadcom Brcmstb PCIe host controller"
> >  	depends on ARCH_BRCMSTB || BMIPS_GENERIC
> > -	depends on OF
> > +	depends on OF && PCI_MSI
> >  	depends on SOC_BRCMSTB
> >  	default ARCH_BRCMSTB || BMIPS_GENERIC
> >  	help
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c
> > b/drivers/pci/controller/pcie-brcmstb.c
> > index 880ec11d06a1..26053e69b95f 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /* Copyright (C) 2009 - 2019 Broadcom */
> >=20
> > +#include <linux/bitops.h>
> >  #include <linux/clk.h>
> >  #include <linux/compiler.h>
> >  #include <linux/delay.h>
> > @@ -8,11 +9,13 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/io.h>
> >  #include <linux/ioport.h>
> > +#include <linux/irqchip/chained_irq.h>
> >  #include <linux/irqdomain.h>
> >  #include <linux/kernel.h>
> >  #include <linux/list.h>
> >  #include <linux/log2.h>
> >  #include <linux/module.h>
> > +#include <linux/msi.h>
> >  #include <linux/of_address.h>
> >  #include <linux/of_irq.h>
> >  #include <linux/of_pci.h>
> > @@ -46,6 +49,9 @@
> >  #define PCIE_MISC_RC_BAR2_CONFIG_LO			0x4034
> >  #define PCIE_MISC_RC_BAR2_CONFIG_HI			0x4038
> >  #define PCIE_MISC_RC_BAR3_CONFIG_LO			0x403c
> > +#define PCIE_MISC_MSI_BAR_CONFIG_LO			0x4044
> > +#define PCIE_MISC_MSI_BAR_CONFIG_HI			0x4048
> > +#define PCIE_MISC_MSI_DATA_CONFIG			0x404c
> >  #define PCIE_MISC_PCIE_CTRL				0x4064
> >  #define PCIE_MISC_PCIE_STATUS				0x4068
> >  #define PCIE_MISC_REVISION				0x406c
> > @@ -54,6 +60,7 @@
> >  #define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI		0x4084
> >  #define PCIE_MISC_HARD_PCIE_HARD_DEBUG			0x4204
> >  #define PCIE_INTR2_CPU_BASE				0x4300
> > +#define PCIE_MSI_INTR2_BASE				0x4500
> >=20
> >  /*
> >   * Broadcom Settop Box PCIe Register Field shift and mask info. The
> > @@ -114,6 +121,8 @@
> >=20
> >  #define BRCM_NUM_PCIE_OUT_WINS		0x4
> >  #define BRCM_MAX_SCB			0x4
> > +#define BRCM_INT_PCI_MSI_NR		32
> > +#define BRCM_PCIE_HW_REV_33		0x0303
> >=20
> >  #define BRCM_MSI_TARGET_ADDR_LT_4GB	0x0fffffffcULL
> >  #define BRCM_MSI_TARGET_ADDR_GT_4GB	0xffffffffcULL
> > @@ -199,6 +208,33 @@ struct brcm_window {
> >  	dma_addr_t size;
> >  };
> >=20
> > +struct brcm_msi {
> > +	struct device		*dev;
> > +	void __iomem		*base;
> > +	struct device_node	*dn;
> > +	struct irq_domain	*msi_domain;
> > +	struct irq_domain	*inner_domain;
> > +	struct mutex		lock; /* guards the alloc/free operations */
> > +	u64			target_addr;
> > +	int			irq;
> > +
> > +	/* intr_base is the base pointer for interrupt status/set/clr regs=
=20
> > */
> > +	void __iomem		*intr_base;
> > +
> > +	/* intr_legacy_mask indicates how many bits are MSI interrupts */
> > +	u32			intr_legacy_mask;
> > +
> > +	/*
> > +	 * intr_legacy_offset indicates bit position of MSI_01. It is
> > +	 * to map the register bit position to a hwirq that starts at 0.
> > +	 */
> > +	u32			intr_legacy_offset;
> > +
> > +	/* used indicates which MSI interrupts have been alloc'd */
> > +	unsigned long		used;
> > +	unsigned int		rev;
> > +};
> > +
> >  /* Internal PCIe Host Controller Information.*/
> >  struct brcm_pcie {
> >  	struct device		*dev;
> > @@ -211,7 +247,10 @@ struct brcm_pcie {
> >  	bool			suspended;
> >  	bool			ssc;
> >  	int			gen;
> > +	u64			msi_target_addr;
> >  	struct brcm_window	out_wins[BRCM_NUM_PCIE_OUT_WINS];
> > +	struct brcm_msi		*msi;
> > +	bool			msi_internal;
>=20
> Do you need both of these fields? Is there any case where msi is valid
> and msi_internal is false?

You're right, got rid of msi_internal.

>=20
> >  	unsigned int		rev;
> >  	const int		*reg_offsets;
> >  	const int		*reg_field_info;
> > @@ -477,6 +516,267 @@ static void brcm_pcie_set_outbound_win(struct
> > brcm_pcie *pcie,
> >  			   LIMIT, tmp);
> >  }
> >=20
> > +static struct irq_chip brcm_msi_irq_chip =3D {
> > +	.name =3D "Brcm_MSI",
> > +	.irq_mask =3D pci_msi_mask_irq,
> > +	.irq_unmask =3D pci_msi_unmask_irq,
> > +};
> > +
> > +static struct msi_domain_info brcm_msi_domain_info =3D {
> > +	.flags	=3D (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> > +		   MSI_FLAG_PCI_MSIX),
>=20
> Is there a particular reason for not supporting MultiMSI? I won't miss
> it, but it might be worth documenting the restriction if the HW cannot
> support it (though I can't immediately see why).

There is no actual restriction. As Jim tells me, there never was the need f=
or
it. If it's fine with you, we'll leave that as an enhancement for the futur=
e,
specially since the RPi's XHCI device only uses one MSI interrupt.

> > +	.chip	=3D &brcm_msi_irq_chip,
> > +};
> > +
> > +static void brcm_pcie_msi_isr(struct irq_desc *desc)
> > +{
> > +	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> > +	struct brcm_msi *msi;
> > +	unsigned long status, virq;
> > +	u32 mask, bit, hwirq;
> > +	struct device *dev;
> > +
> > +	chained_irq_enter(chip, desc);
> > +	msi =3D irq_desc_get_handler_data(desc);
> > +	mask =3D msi->intr_legacy_mask;
> > +	dev =3D msi->dev;
> > +
> > +	while ((status =3D bcm_readl(msi->intr_base + STATUS) & mask)) {
>=20
> Is this loop really worth it? If, as I imagine, this register is at the
> end of a wet piece of string, this additional read (likely to return=20
> zero)
> will have a measurable latency impact...

I think this one was cargo-culted, TBH this pattern is all over the place.
Though, now that you point it out, I can't really provide a justification f=
or
it. Maybe Jim can contradict me here, but It's working fine without it.

> > +		for_each_set_bit(bit, &status, BRCM_INT_PCI_MSI_NR) {
> > +			/* clear the interrupt */
> > +			bcm_writel(1 << bit, msi->intr_base + CLR);
> > +
> > +			/* Account for legacy interrupt offset */
> > +			hwirq =3D bit - msi->intr_legacy_offset;
> > +
> > +			virq =3D irq_find_mapping(msi->inner_domain, hwirq);
> > +			if (virq) {
> > +				if (msi->used & (1 << hwirq))
> > +					generic_handle_irq(virq);
> > +				else
> > +					dev_info(dev, "unhandled MSI %d\n",
> > +						 hwirq);
>=20
> Can this ever happen? If you've found the mapping in the irqdomain,
> the MSI obviously has been allocated. Or am I missing something?

Agree, I'll get rid of it.

> > +			} else {
> > +				/* Unknown MSI, just clear it */
> > +				dev_dbg(dev, "unexpected MSI\n");
> > +			}
> > +		}
> > +	}
> > +	chained_irq_exit(chip, desc);
> > +}
> > +
> > +static void brcm_compose_msi_msg(struct irq_data *data, struct=20
> > msi_msg *msg)
> > +{
> > +	struct brcm_msi *msi =3D irq_data_get_irq_chip_data(data);
> > +	u32 temp;
> > +
> > +	msg->address_lo =3D lower_32_bits(msi->target_addr);
> > +	msg->address_hi =3D upper_32_bits(msi->target_addr);
> > +	temp =3D bcm_readl(msi->base + PCIE_MISC_MSI_DATA_CONFIG);

Well as far as the RPi is concerned I can do without it. I don't know if th=
ere
is an odd case on STB devices where we need it, maybe Jim can shine some li=
ght
into it. Regardless I think I'll remove it for now, we can then fix it once=
 we
enable other users for the controller.

> > +	msg->data =3D ((temp >> 16) & (temp & 0xffff)) | data->hwirq;
> > +}
> > +
> > +static int brcm_msi_set_affinity(struct irq_data *irq_data,
> > +				 const struct cpumask *mask, bool force)
> > +{
> > +	return -EINVAL;
> > +}
> > +
> > +static struct irq_chip brcm_msi_bottom_irq_chip =3D {
> > +	.name			=3D "Brcm_MSI",
> > +	.irq_compose_msi_msg	=3D brcm_compose_msi_msg,
> > +	.irq_set_affinity	=3D brcm_msi_set_affinity,
> > +};
> > +
> > +static int brcm_msi_alloc(struct brcm_msi *msi)
> > +{
> > +	int bit, hwirq;
> > +
> > +	mutex_lock(&msi->lock);
> > +	bit =3D ~msi->used ? ffz(msi->used) : -1;
> > +
> > +	if (bit >=3D 0 && bit < BRCM_INT_PCI_MSI_NR) {
> > +		msi->used |=3D (1 << bit);
> > +		hwirq =3D bit - msi->intr_legacy_offset;
> > +	} else {
> > +		hwirq =3D -ENOSPC;
> > +	}
>=20
> Please consider using bitmap_find_free_region() and co, instead of
> open coding your allocator.

Noted.

> > +
> > +	mutex_unlock(&msi->lock);
> > +	return hwirq;
> > +}
> > +
> > +static void brcm_msi_free(struct brcm_msi *msi, unsigned long hwirq)
> > +{
> > +	mutex_lock(&msi->lock);
> > +	msi->used &=3D ~(1 << (hwirq + msi->intr_legacy_offset));
> > +	mutex_unlock(&msi->lock);
> > +}
> > +
> > +static int brcm_irq_domain_alloc(struct irq_domain *domain, unsigned
> > int virq,
> > +				 unsigned int nr_irqs, void *args)
> > +{
> > +	struct brcm_msi *msi =3D domain->host_data;
> > +	int hwirq;
> > +
> > +	hwirq =3D brcm_msi_alloc(msi);
> > +
> > +	if (hwirq < 0)
> > +		return hwirq;
> > +
> > +	irq_domain_set_info(domain, virq, (irq_hw_number_t)hwirq,
> > +			    &brcm_msi_bottom_irq_chip, domain->host_data,
> > +			    handle_simple_irq, NULL, NULL);
>=20
> simple_irq doesn't quite match what this does. This really should
> use an edge flow.

Ok, I'll look into it.

> > +	return 0;
> > +}
> > +
> > +static void brcm_irq_domain_free(struct irq_domain *domain,
> > +				 unsigned int virq, unsigned int nr_irqs)
> > +{
> > +	struct irq_data *d =3D irq_domain_get_irq_data(domain, virq);
> > +	struct brcm_msi *msi =3D irq_data_get_irq_chip_data(d);
> > +
> > +	brcm_msi_free(msi, d->hwirq);
> > +}
> > +
> > +static void brcm_msi_set_regs(struct brcm_msi *msi)
> > +{
> > +	u32 data_val, msi_lo, msi_hi;
> > +
> > +	if (msi->rev >=3D BRCM_PCIE_HW_REV_33) {
> > +		/*
> > +		 * ffe0 -- least sig 5 bits are 0 indicating 32 msgs
> > +		 * 6540 -- this is our arbitrary unique data value
> > +		 */
> > +		data_val =3D 0xffe06540;
> > +	} else {
> > +		/*
> > +		 * fff8 -- least sig 3 bits are 0 indicating 8 msgs
> > +		 * 6540 -- this is our arbitrary unique data value
> > +		 */
> > +		data_val =3D 0xfff86540;
> > +	}
> > +
> > +	/*
> > +	 * Make sure we are not masking MSIs.  Note that MSIs can be=20
> > masked,
> > +	 * but that occurs on the PCIe EP device
>=20
> That's not a guarantee, specially with plain MultiMSI. I'm actually
> minded to move the masking to be purely local on the MSI controllers
> I maintain.

Sorry, I'm a little lost here. The way I understand it after reset, even wi=
th
multiMSI, on the EP side all vectors are umasked. So it would make sense to=
 do
the same on the controller.

The way I see it, we want to avoid using this register anyway, as with mult=
iMSI
we'd only get function wide masking, which I guess is not all that useful.

> > +	 */
> > +	bcm_writel(0xffffffff & msi->intr_legacy_mask,
> > +		   msi->intr_base + MASK_CLR);
> > +
> > +	msi_lo =3D lower_32_bits(msi->target_addr);
> > +	msi_hi =3D upper_32_bits(msi->target_addr);
> > +	/*
> > +	 * The 0 bit of PCIE_MISC_MSI_BAR_CONFIG_LO is repurposed to MSI
> > +	 * enable, which we set to 1.
> > +	 */
> > +	bcm_writel(msi_lo | 1, msi->base + PCIE_MISC_MSI_BAR_CONFIG_LO);
> > +	bcm_writel(msi_hi, msi->base + PCIE_MISC_MSI_BAR_CONFIG_HI);
> > +	bcm_writel(data_val, msi->base + PCIE_MISC_MSI_DATA_CONFIG);
> > +}
> > +
> > +static const struct irq_domain_ops msi_domain_ops =3D {
> > +	.alloc	=3D brcm_irq_domain_alloc,
> > +	.free	=3D brcm_irq_domain_free,
> > +};
> > +
> > +static int brcm_allocate_domains(struct brcm_msi *msi)
> > +{
> > +	struct fwnode_handle *fwnode =3D of_node_to_fwnode(msi->dn);
> > +	struct device *dev =3D msi->dev;
> > +
> > +	msi->inner_domain =3D irq_domain_add_linear(NULL,=20
> > BRCM_INT_PCI_MSI_NR,
> > +						  &msi_domain_ops, msi);
> > +	if (!msi->inner_domain) {
> > +		dev_err(dev, "failed to create IRQ domain\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	msi->msi_domain =3D pci_msi_create_irq_domain(fwnode,
> > +						    &brcm_msi_domain_info,
> > +						    msi->inner_domain);
> > +	if (!msi->msi_domain) {
> > +		dev_err(dev, "failed to create MSI domain\n");
> > +		irq_domain_remove(msi->inner_domain);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void brcm_free_domains(struct brcm_msi *msi)
> > +{
> > +	irq_domain_remove(msi->msi_domain);
> > +	irq_domain_remove(msi->inner_domain);
> > +}
> > +
> > +static void brcm_msi_remove(struct brcm_pcie *pcie)
> > +{
> > +	struct brcm_msi *msi =3D pcie->msi;
> > +
> > +	if (!msi)
> > +		return;
> > +	irq_set_chained_handler(msi->irq, NULL);
> > +	irq_set_handler_data(msi->irq, NULL);
> > +	brcm_free_domains(msi);
> > +}
> > +
> > +static int brcm_pcie_enable_msi(struct brcm_pcie *pcie)
> > +{
> > +	struct brcm_msi *msi;
> > +	int irq, ret;
> > +	struct device *dev =3D pcie->dev;
> > +
> > +	irq =3D irq_of_parse_and_map(dev->of_node, 1);
> > +	if (irq <=3D 0) {
> > +		dev_err(dev, "cannot map msi intr\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	msi =3D devm_kzalloc(dev, sizeof(struct brcm_msi), GFP_KERNEL);
> > +	if (!msi)
> > +		return -ENOMEM;
> > +
> > +	msi->dev =3D dev;
> > +	msi->base =3D pcie->base;
> > +	msi->rev =3D  pcie->rev;
> > +	msi->dn =3D pcie->dn;
> > +	msi->target_addr =3D pcie->msi_target_addr;
> > +	msi->irq =3D irq;
> > +
> > +	ret =3D brcm_allocate_domains(msi);
> > +	if (ret)
> > +		return ret;
>=20
> You seem to rely on the devm_* allocators to cleanup on failure. But as=
=20
> far
> as I can see, failing to initialize the MSI subsystem doesn't translate=
=20
> in
> a PCIe init failure, hence keeping the memory around.

Indeed, I see what you mean. I say let's fail.

Regards,
Nicolas


--=-Aeotz4Kz86JAeSXZZo/i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl3JREUACgkQlfZmHno8
x/7HtwgAiw7mjaGYhpREVRGzDS2lLIGWEJRDREBdmOKifd4x5JIdnD+ZVlRc7exC
IZaQ1foJyz3txz36UbHwEEW9aaPhzYXjRCuXX7ggcBqs7DnYQvvoKjZsXVw2T+lB
x/x2Ia1DUjovDov/ddkxn8Ajau2MBU2dPJ5Bzrn0g4ubwDoBF6BXiltNhfuqV/fx
kvmVaduDLIP27kT3xh9GGFZ/5EO/hM0QtUtAO7DJ1DG0Q/A08GKtcW6eo7TMDxPk
MmnfdRWiAwvtpH+t+vTxHKtH+xYgbdfiJNJobTsaq8+n+yuBdfuIS/ATeVsOMaiS
uf1+WQb5gmI13ndurPIqw2HBmUCZQA==
=9Ztr
-----END PGP SIGNATURE-----

--=-Aeotz4Kz86JAeSXZZo/i--

