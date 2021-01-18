Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A95502FA05C
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jan 2021 13:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391821AbhARMpe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jan 2021 07:45:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:48074 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391817AbhARMp1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Jan 2021 07:45:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B66D9ACBA;
        Mon, 18 Jan 2021 12:44:45 +0000 (UTC)
Message-ID: <9c50176681925fa06a0c1c385a3ab7f88a3faec7.camel@suse.de>
Subject: Re: [PATCH v2] PCI: brcmstb: Restore initial fundamental reset
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        phil <phil@raspberrypi.org>
Cc:     Phil Elwell <phil@raspberrypi.com>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>
Date:   Mon, 18 Jan 2021 13:44:44 +0100
In-Reply-To: <20210118124003.GA12967@e121166-lin.cambridge.arm.com>
References: <20201112172709.1817-1-phil@raspberrypi.com>
         <CA+-6iNwH3v78QhQOFpsXfA4hgUo9TXJaF4hy_imA60iQ2a3bMg@mail.gmail.com>
         <20210118124003.GA12967@e121166-lin.cambridge.arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-eJY5SkGEBi10DNIzY80Y"
User-Agent: Evolution 3.38.3 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-eJY5SkGEBi10DNIzY80Y
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2021-01-18 at 12:40 +0000, Lorenzo Pieralisi wrote:
> On Thu, Nov 12, 2020 at 01:38:13PM -0500, Jim Quinlan wrote:
> > On Thu, Nov 12, 2020 at 12:27 PM Phil Elwell <phil@raspberrypi.com> wro=
te:
> > >=20
> > > Commit 04356ac30771 ("PCI: brcmstb: Add bcm7278 PERST# support")
> > > replaced a single reset function with a pointer to one of two
> > > implementations, but also removed the call asserting the reset
> > > at the start of brcm_pcie_setup. Doing so breaks Raspberry Pis with
> > > VL805 XHCI controllers lacking dedicated SPI EEPROMs, which have been
> > > used for USB booting but then need to be reset so that the kernel
> > > can reconfigure them. The lack of a reset causes the firmware's loadi=
ng
> > > of the EEPROM image to RAM to fail, breaking USB for the kernel.
> > >=20
> > > Fixes: commit 04356ac30771 ("PCI: brcmstb: Add bcm7278 PERST# support=
")
> > >=20
> > > Signed-off-by: Phil Elwell <phil@raspberrypi.com>
> > > Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > ---
> > > Changes in v2:
> > > =C2=A0=C2=A0- Exclude BCM7278 from the initial reset
> > > =C2=A0=C2=A0- Ack from Nicolas
> > > ---
> > > =C2=A0drivers/pci/controller/pcie-brcmstb.c | 5 +++++
> > > =C2=A01 file changed, 5 insertions(+)
> > >=20
> > > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/cont=
roller/pcie-brcmstb.c
> > > index bea86899bd5d..83aa85bfe8e3 100644
> > > --- a/drivers/pci/controller/pcie-brcmstb.c
> > > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > > @@ -869,6 +869,11 @@ static int brcm_pcie_setup(struct brcm_pcie *pci=
e)
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Reset the bridge *=
/
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pcie->bridge_sw_init_=
set(pcie, 1);
> > > +
> > > +       /* Assert the fundemental reset, except on BCM7278 */
> > > +       if (pcie->type !=3D BCM7278)
> > > +               pcie->perst_set(pcie, 1);
> > I'm okay with this although I  would rather it not be needed.
>=20
> Can I merge this patch as is then ?

No. IIUC the consensus was to fix this in firmware. There is a u-boot fix
available in their mailing list, and I think RPi's firmware was also patche=
d
accordingly (@Phil please confirm).

Regards,
Nicolas




--=-eJY5SkGEBi10DNIzY80Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmAFgrwACgkQlfZmHno8
x/7XZggAjT4B0Y9osLqVQMSN/W+8Xe+snGPPem/HU9kLSMga+NQFC3/Siinyd7UZ
nr5zzPudN6SxLziizoO+ZsgdPFtCQprtWan/zzvegdgUyloaEeKOb2zeWJ9qGZBL
ZRR3xzjM/k8/wgxP5CVBDviqOsrDEqhQtBWNTE/N23dRXig1zVY/qsCO9rKsulrB
5FiO6y4C+Sd+63L3LPpMHFwxWbPp1Qg1LYD2JHFRdzNUdpTf7GlQ+2M8VaxL/skm
2Etjza1LUmod3rN4XESOULe2ZiYwzdnWEvg+1V21eUw5Of3ShbRDrSNuhhHdAoP0
itUSUajd8UoKD1yAXM818FymeWEuqw==
=ah7a
-----END PGP SIGNATURE-----

--=-eJY5SkGEBi10DNIzY80Y--

