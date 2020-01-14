Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 060DE13B1E6
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2020 19:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgANSSv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jan 2020 13:18:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:42980 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgANSSu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jan 2020 13:18:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9CB5AAC5C;
        Tue, 14 Jan 2020 18:18:48 +0000 (UTC)
Message-ID: <8a7057fe1aaf415272d28f4e690313984c3a148d.camel@suse.de>
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
Date:   Tue, 14 Jan 2020 19:18:46 +0100
In-Reply-To: <20200114171101.GA11177@e121166-lin.cambridge.arm.com>
References: <20191216110113.30436-1-nsaenzjulienne@suse.de>
         <20191216110113.30436-4-nsaenzjulienne@suse.de>
         <20200114171101.GA11177@e121166-lin.cambridge.arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-aT8Qvga/f/1E/yJbYhHH"
User-Agent: Evolution 3.34.3 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-aT8Qvga/f/1E/yJbYhHH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lorenzo,

On Tue, 2020-01-14 at 17:11 +0000, Lorenzo Pieralisi wrote:
> On Mon, Dec 16, 2019 at 12:01:09PM +0100, Nicolas Saenz Julienne wrote:
> > From: Jim Quinlan <james.quinlan@broadcom.com>
> >=20
> > This adds a basic driver for Broadcom's STB PCIe controller, for now
> > aimed at Raspberry Pi 4's SoC, bcm2711.
> >=20
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > Co-developed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > Reviewed-by: Andrew Murray <andrew.murray@arm.com>
> > Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
> >=20
> > ---
> >=20
> > Changes since v3:
> >   - Update commit message
> >   - rollback roundup_pow_two usage, it'll be updated later down the lin=
e
> >   - Remove comment in register definition
> >=20
> > Changes since v2:
> >   - Correct rc_bar2_offset sign
>=20
> In relation to this change.
>=20
> [...]
>=20
> > +static inline int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pc=
ie
> > *pcie,
> > +							u64 *rc_bar2_size,
> > +							u64 *rc_bar2_offset)
> > +{
> > +	struct pci_host_bridge *bridge =3D pci_host_bridge_from_priv(pcie);
> > +	struct device *dev =3D pcie->dev;
> > +	struct resource_entry *entry;
> > +
> > +	entry =3D resource_list_first_type(&bridge->dma_ranges, IORESOURCE_ME=
M);
> > +	if (!entry)
> > +		return -ENODEV;
> > +
> > +	*rc_bar2_offset =3D -entry->offset;
>=20
> I think this deserves a comment - I guess it has to do with how the
> controller expects CPU<->PCI offsets to be expressed compared to how it
> is computed in dma_ranges entries.

You're right, OF code calculates it by doing:

	offset =3D cpu_start_addr - pci_start_addr (see
devm_of_pci_get_host_bridge_resources())

While the RC_BAR2_CONFIG register expects the opposite subtraction. I'll ad=
d a
comment on the next revision.

> I will try to complete the review shortly and try to apply it given
> that it has already been reviewed by others.

Thanks!

Regards,
Nicolas

> Lorenzo
>=20


--=-aT8Qvga/f/1E/yJbYhHH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl4eBgYACgkQlfZmHno8
x/5eqQf9E0hAW+zHpUgu0m0lqOFYwXeP3hO0XVERD2rmERkNOwvehWM7LhMdsfRA
jtDJJSpC5itlAY7Oz8bi0SfTTRzt8XjaF7eSR6EfkCgwPpvMlw2pJIFlGEKYhv0k
+NEwi+dOPllYZXC656nAKXI0c5CAt7B4P373ByV7fNjw9ULWv04O58QWh3mTAyBO
x9nWW6d8ZGwD8SQcsGY9RRjpr/XaZ85LDxxbvYCKC7JXCuW1CfyetICSveZ1R22v
ysutXh0PlbPP8+jvTFfYrkPnc6SIytq0tdqr+Rma/BBF/lGvvi1uF2rUc5HYXZ+g
gAkFA1hv1HEEr2m4IXDi96GBnimNnw==
=EJpg
-----END PGP SIGNATURE-----

--=-aT8Qvga/f/1E/yJbYhHH--

