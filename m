Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD16D105876
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 18:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfKURTR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 12:19:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:57616 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726279AbfKURTR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Nov 2019 12:19:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 883FFB2A5;
        Thu, 21 Nov 2019 17:19:14 +0000 (UTC)
Message-ID: <85c4a01d4991a8593a9c3b56cf04bff38cc110e5.camel@suse.de>
Subject: Re: [PATCH v2 5/6] PCI: brcmstb: add MSI capability
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <wahrenst@gmx.net>, james.quinlan@broadcom.com,
        mbrugger@suse.com, phil@raspberrypi.org, jeremy.linton@arm.com,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Date:   Thu, 21 Nov 2019 18:19:12 +0100
In-Reply-To: <20191121153842.GZ43905@e119886-lin.cambridge.arm.com>
References: <20191112155926.16476-1-nsaenzjulienne@suse.de>
         <20191112155926.16476-6-nsaenzjulienne@suse.de>
         <20191121153842.GZ43905@e119886-lin.cambridge.arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-UzSeM3n4DH+cLONL/tLo"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-UzSeM3n4DH+cLONL/tLo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-11-21 at 15:38 +0000, Andrew Murray wrote:
> >  #define PCIE_MISC_PCIE_STATUS_PCIE_PHYLINKUP_SHIFT		0x4
> >  #define PCIE_MISC_PCIE_STATUS_PCIE_LINK_IN_L23_MASK		0x40
> >  #define PCIE_MISC_PCIE_STATUS_PCIE_LINK_IN_L23_SHIFT		0x6
> > +#define PCIE_MISC_REVISION_MAJMIN_MASK				0xffff
> > +#define PCIE_MISC_REVISION_MAJMIN_SHIFT				0
>=20
> I don't think these two are used.

Yes, in brcm_pcie_setup(), when we grab the PCIe hw revision number.

[...]
> > +static struct msi_domain_info brcm_msi_domain_info =3D {
> > +	/* TODO: Multi MSI is technically supported by the controller */
>=20
> As I understand we're not supporting MSI_FLAG_MULTI_PCI_MSI, not because =
there
> is no hardware capability, but because the current use-case (RPi EPs) hav=
e no
> need for it. It wouldn't be a stretch to add this support (compare your a=
lloc
> implementation with nwl_irq_domain_alloc from pcie-xilinx-nwl.c) - though=
 I
> appreciate the difficulity you may have with testing.
>=20
> I'd probably replace the TODO line with:
>=20
> /* Multi MSI is supported by the controller, but not by this driver */

I'll replace the comment for now.

I've already seen people who unsoldered the XHCI chip on the RPi4 to then a=
dd a
proper PCI connector. If someone shows up with such setup, I'll be happy to
work out the MultiMSI support.

[...]
> > +	.flags	=3D (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> > +		   MSI_FLAG_PCI_MSIX),
>=20
> Why the MSIX flag if the commit message says "It does not add MSIX since =
that
> functionality is not in the HW." in the commit message?

That's plain wrong, sorry.

[...]
> > +	.chip	=3D &brcm_msi_irq_chip,
> > +};
> > +
> > +static void brcm_pcie_msi_isr(struct irq_desc *desc)
> > +{
> > +	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> > +	unsigned long status, virq;
> > +	struct brcm_msi *msi;
> > +	u32 mask, bit, hwirq;
> > +	struct device *dev;
> > +
> > +	chained_irq_enter(chip, desc);
> > +	msi =3D irq_desc_get_handler_data(desc);
> > +	mask =3D msi->intr_legacy_mask;
>=20
> NIT: As you only use this variable once, you could get rid of it.

OK

[...]
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
>=20
> NIT: I think we can spare a few more characters and replace intr with
> interrupt.

Of course.

[...]
> > +	/*
> > +	 * We ideally want the MSI target address to be located in the 32bit
> > +	 * addressable memory area. Some devices might depend on it. This is
> > +	 * possible either when the inbound window is located above the lower
> > +	 * 4GB or when the inbound and outbound areas fit in the lower 4GB of
> > +	 * memory.
> > +	 */
> > +	if (rc_bar2_offset >=3D SZ_4G || (rc_bar2_size + rc_bar2_offset) <=3D=
 SZ_4G)
> > +		pcie->msi_target_addr =3D BRCM_MSI_TARGET_ADDR_LT_4GB;
> > +	else
> > +		pcie->msi_target_addr =3D BRCM_MSI_TARGET_ADDR_GT_4GB;
> > +
>=20
> Can this above hunk me moved into brcm_pcie_enable_msi? You could then av=
oid
> having the pcie->msi_target_addr and just have a single msi->target_addr
> variable?

As it depends on rc_bar2_offset and rc_bar2_size it's not really possible
without having to store those values in exchange, which IMO amounts to
negative benefit.

Regards,
Nicolas


--=-UzSeM3n4DH+cLONL/tLo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl3WxxAACgkQlfZmHno8
x/4EZwf+PyAPkh0UtAsvf4S0SYBMGvE9nq5YufRa9bbo8y2gJtF99mGmDE+vaFY6
j4WKgp7o/lvfJsAgTxQPuCKJUIr5A5KyYdbhGsNKeAo9HlKbTXlLcpmYORwxcUV3
EDzMGxjS932zAl+sx2U18FpVDqll8IUwltdg0+1QPdq9r5XgYeSaj9VfVd3GDAfj
9LwSGO0lBPJtqRMHACgJfmFlgdxDo1mTPTZvmC9WguIY8wzIJId7vXDuKFOffCrU
VLZupE8IQMFDjK+q5Wxg0HXvWuHO7Hw/dnV/Jhw3o5GN6jSkxLtLBf3b/oS3n5jp
GEWb/IwLhwfAqMntETAGUczaFyZwEQ==
=GSi8
-----END PGP SIGNATURE-----

--=-UzSeM3n4DH+cLONL/tLo--

