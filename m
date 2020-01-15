Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEC5B13BE63
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 12:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbgAOL3p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jan 2020 06:29:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:33624 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729758AbgAOL3p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jan 2020 06:29:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7F209AC18;
        Wed, 15 Jan 2020 11:29:42 +0000 (UTC)
Message-ID: <be8ddb33a7360af1815cf686f77f3f0913d02be3.camel@suse.de>
Subject: Re: [PATCH v5 3/6] PCI: brcmstb: Add Broadcom STB PCIe host
 controller driver
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     andrew.murray@arm.com, maz@kernel.org,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        mbrugger@suse.com, phil@raspberrypi.org, wahrenst@gmx.net,
        jeremy.linton@arm.com, linux-pci@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
Date:   Wed, 15 Jan 2020 12:29:37 +0100
In-Reply-To: <20200115100054.GA2174@e121166-lin.cambridge.arm.com>
References: <20191216110113.30436-1-nsaenzjulienne@suse.de>
         <20191216110113.30436-4-nsaenzjulienne@suse.de>
         <20200114171101.GA11177@e121166-lin.cambridge.arm.com>
         <8a7057fe1aaf415272d28f4e690313984c3a148d.camel@suse.de>
         <20200115100054.GA2174@e121166-lin.cambridge.arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-6y7LFOR+x4F4HPXiJaWq"
User-Agent: Evolution 3.34.3 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-6y7LFOR+x4F4HPXiJaWq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-01-15 at 10:00 +0000, Lorenzo Pieralisi wrote:
> On Tue, Jan 14, 2020 at 07:18:46PM +0100, Nicolas Saenz Julienne wrote:
> > Hi Lorenzo,
> >=20
> > On Tue, 2020-01-14 at 17:11 +0000, Lorenzo Pieralisi wrote:
> > > On Mon, Dec 16, 2019 at 12:01:09PM +0100, Nicolas Saenz Julienne wrot=
e:
> > > > From: Jim Quinlan <james.quinlan@broadcom.com>
> > > >=20
> > > > This adds a basic driver for Broadcom's STB PCIe controller, for no=
w
> > > > aimed at Raspberry Pi 4's SoC, bcm2711.
> > > >=20
> > > > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > > > Co-developed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > > Reviewed-by: Andrew Murray <andrew.murray@arm.com>
> > > > Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
> > > >=20
> > > > ---
> > > >=20
> > > > Changes since v3:
> > > >   - Update commit message
> > > >   - rollback roundup_pow_two usage, it'll be updated later down the=
 line
> > > >   - Remove comment in register definition
> > > >=20
> > > > Changes since v2:
> > > >   - Correct rc_bar2_offset sign
> > >=20
> > > In relation to this change.
> > >=20
> > > [...]
> > >=20
> > > > +static inline int brcm_pcie_get_rc_bar2_size_and_offset(struct
> > > > brcm_pcie
> > > > *pcie,
> > > > +							u64
> > > > *rc_bar2_size,
> > > > +							u64
> > > > *rc_bar2_offset)
> > > > +{
> > > > +	struct pci_host_bridge *bridge =3D
> > > > pci_host_bridge_from_priv(pcie);
> > > > +	struct device *dev =3D pcie->dev;
> > > > +	struct resource_entry *entry;
> > > > +
> > > > +	entry =3D resource_list_first_type(&bridge->dma_ranges,
> > > > IORESOURCE_MEM);
> > > > +	if (!entry)
> > > > +		return -ENODEV;
> > > > +
> > > > +	*rc_bar2_offset =3D -entry->offset;
> > >=20
> > > I think this deserves a comment - I guess it has to do with how the
> > > controller expects CPU<->PCI offsets to be expressed compared to how =
it
> > > is computed in dma_ranges entries.
> >=20
> > You're right, OF code calculates it by doing:
> >=20
> > 	offset =3D cpu_start_addr - pci_start_addr (see
> > devm_of_pci_get_host_bridge_resources())
> >=20
> > While the RC_BAR2_CONFIG register expects the opposite subtraction.
> > I'll add a comment on the next revision.
>=20
> There is no need for a new posting, either write that comment here
> and I update the code or inline the patch or just resend *this* updated
> patch to the list.

OK, hope this sounds good enough:

	/*
	 * The controller expects the inbound window offset to be calculated as
	 * the difference between PCIe's address space and CPU's. The offset
	 * provided by the firmware is calculated the opposite way, so we
	 * negate it.
	 */

Regards,
Nicolas


--=-6y7LFOR+x4F4HPXiJaWq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl4e96IACgkQlfZmHno8
x/4MEgf/cet8Daq/EDQambM+OlNLvE+SC8wlpWaGDKclIGkLyfP8aBZgldzoTbKl
ScGl8Z8ZvXFpRs5ywBoyQDcFzRwwp3e1/4CKwopLwBAJXIPoMTN3jVpp6W0/XP34
8/ydNXm+FuF1SbbULl5a3/DDzB/quOrU32PpYpCN1yKqaPYEHSFCIbQuTx1vyHTZ
uLhxmCgoDoiuol+axJ1TPQ2MYwAd3ylYf3E2BvCe76p9ir6Pch7ztp3mZGBvnxsN
T3vd/jNNtjF1JQjjvdHPMmXsTzxp14GSwmemPpi0kmXhUOqVdtRK4JDF3TDY+qlA
QYFIfmj9WA/htGKe9jP/P2Ti86fNYw==
=lj1L
-----END PGP SIGNATURE-----

--=-6y7LFOR+x4F4HPXiJaWq--

