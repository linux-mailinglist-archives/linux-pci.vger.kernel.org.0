Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDDEA11035A
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2019 18:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfLCRXI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Dec 2019 12:23:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:51018 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726422AbfLCRXI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Dec 2019 12:23:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 83641B2074;
        Tue,  3 Dec 2019 17:23:05 +0000 (UTC)
Message-ID: <dd0d91b74853d1afa9bcb8a56a3ddbfa744ae116.camel@suse.de>
Subject: Re: [PATCH v3 4/7] PCI: brcmstb: add Broadcom STB PCIe host
 controller driver
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Jeremy Linton <jeremy.linton@arm.com>, andrew.murray@arm.com,
        maz@kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <wahrenst@gmx.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     james.quinlan@broadcom.com, mbrugger@suse.com,
        phil@raspberrypi.org, linux-pci@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 03 Dec 2019 18:23:03 +0100
In-Reply-To: <ddab6abd-68fb-543d-bb8e-057d92ac15ed@arm.com>
References: <20191126091946.7970-1-nsaenzjulienne@suse.de>
         <20191126091946.7970-5-nsaenzjulienne@suse.de>
         <ddab6abd-68fb-543d-bb8e-057d92ac15ed@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-tiQfYVDELUAGwVd1u8VU"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-tiQfYVDELUAGwVd1u8VU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-12-03 at 10:31 -0600, Jeremy Linton wrote:
> Hi,
>=20
> On 11/26/19 3:19 AM, Nicolas Saenz Julienne wrote:
> > From: Jim Quinlan <james.quinlan@broadcom.com>
> >=20
> > This adds a basic driver for Broadcom's STB PCIe controller, for now
> > aimed at Raspberry Pi 4's SoC, bcm2711.
> >=20
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > Co-developed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> >=20
> > ---
> >=20
> > Changes since v2:
> >    - Correct rc_bar2_offset sign
> >    - Invert IRQ clear and masking in setup code
> >    - Use bitfield.h, redo all register ops while keeping the register
> >      names intact
> >    - Remove all SHIFT register definitions
> >    - Get rid of all _RB writes
> >    - Get rid of of_data
> >    - Don't iterate over inexisting dma-ranges
> >    - Add comment regarding dma-ranges validation
> >    - Small cosmetic cleanups
> >    - Fix license mismatch
> >    - Set driver Kconfig tristate
> >    - Didn't add any comment about the controller not being I/O coherent
> >      for now as I wait for Jeremy's reply
>=20
> I guess its fine.. In answer to the original query. It seems that this=
=20
> PCIe bridge requires explicit cache operations for DMA from PCIe=20
> endpoints. This wasn't obvious to me at first reading because I was=20
> assuming the custom DMA ops were strictly to deal with the stated DMA=20
> limits.

Thanks, I now see what you meant.

> So if you end up respinning, it still might be worthy mentioning=20
> somewhere that this is a non-coherent PCIe implementation. I still hold=
=20
> much of my original reservations about pieces of this driver.=20
> Particularly, how it might look if someone wanted to boot the RPi using=
=20
> ACPI on linux. But, I was shown a clever bit of AML recently, which=20
> solves those problems for the RPi and the attached XHCI.

I don't know much about ACPI, but ultimately if you're booting trough ACPI,
you're unlikely to use device-tree at all, right? And if you where and this
driver clashed with your ACPI implementation you'd simply have to disable i=
t on
the device-tree.

> So, given how much time I've looked at the root port configuration/etc=
=20
> sections of this driver and I've not found a serious bug:
>=20
> Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>

Thanks!

Regards,
Nicolas


--=-tiQfYVDELUAGwVd1u8VU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl3mmfcACgkQlfZmHno8
x/526wf/dHShet63is8+wboQUSa9Ik3p1r5FrbuSercRQWbob00Roa1615tbyVSg
vJvel1G4DtTT/bDzL7xsp4eixx0NeInNcuJvv9bBveOzD5U1TAFdlHu4o2wVtFVF
oqQevC+iJoMb4NX9qECr8NHoRgyBaw9fakVjgMRZ/xhqHQ1edsqJVjHcUHBVv6D8
w4r5CbB3AYmidDDOCx62CO6xKq+zHWg6yAVbDbCnisIc/zWA/F+Lq7U0ukqEP1aF
vthC/OvlaQXB7c9ui7cXtklRXL00yGBgpShG5TOQrNP1WInlUG5IkheQm3kdKYob
4k2yRLGOlwt8fOiPz3s2RCWt6NtXRg==
=ByNX
-----END PGP SIGNATURE-----

--=-tiQfYVDELUAGwVd1u8VU--

