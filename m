Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465F3321D1F
	for <lists+linux-pci@lfdr.de>; Mon, 22 Feb 2021 17:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhBVQhH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Feb 2021 11:37:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:42228 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230371AbhBVQhF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Feb 2021 11:37:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BCC89AD6B;
        Mon, 22 Feb 2021 16:36:21 +0000 (UTC)
Message-ID: <59614491333fde94da880aed328a22f9ca49171a.camel@suse.de>
Subject: Re: RPi4 can't deal with 64 bit PCI accesses
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Robin Murphy <robin.murphy@arm.con>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
Date:   Mon, 22 Feb 2021 17:36:20 +0100
In-Reply-To: <CAMj1kXG9ALnJcdzgv9805A91x-decqS1eq9oWi7Bb+pa3f6ErQ@mail.gmail.com>
References: <c188698ca0de3ed6c56a0cf7880e1578aa753077.camel@suse.de>
         <CAMj1kXG9ALnJcdzgv9805A91x-decqS1eq9oWi7Bb+pa3f6ErQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-/3eUJ0qgyJIjoTnHixDm"
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-/3eUJ0qgyJIjoTnHixDm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2021-02-22 at 17:18 +0100, Ard Biesheuvel wrote:
> On Mon, 22 Feb 2021 at 16:48, Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> >=20
> > Hi everyone,
> > Raspberry Pi 4, a 64bit arm system on chip, contains a PCIe bus that ca=
n't
> > handle 64bit accesses to its MMIO address space, in other words, writeq=
() has
> > to be split into two distinct writel() operations. This isn't ideal, as=
 it
> > misrepresents PCI's promise of being able to treat device memory as reg=
ular
> > memory, ultimately breaking a bunch of PCI device drivers[1].
> >=20
> > I'd like to have a go at fixing this in a way that can be distributed i=
n a
> > generic distro without prejudice to other users.
> >=20
> > AFAIK there is no way to detect this limitation through generic PCIe
> > capabilities, so one solution would be to expose it through firmware
> > (devicetree in this case), and pass the limitations through 'struct dev=
ice' so
> > as for the drivers to choose the right access method in a way that does=
n't
> > affect performance much[2]. All in all, most of this doesn't need to be
> > PCI-centric as the property could be applied to any MMIO bus.
> >=20
> > Thoughts? Opinions? Is it overkill just for a single SoC?
> >=20
>=20
> Hi Nicolas,
>=20
> How does this issue manifest itself? There are other PCIe RC

Only the low bits would get written/read, as for the high bits I can't reca=
ll
if they were corrupted or simply ignored (I experienced this some time ago
while bringing up RPi's PCIe in u-boot).

> implementations suffering from the same issue, and some of the drivers
> in Linux already work around this, by using split accesses. Look at
> this one, for instance:
>=20
> a310acd7a7ea ("NVMe: use split lo_hi_{read,write}q")
>=20
> which switches NVMe to lo_hi_readq, which appears to be used in quite
> a few other places as well.

Indeed, XHCI does this unanimously too. But I figured forcing the split on =
all
drivers woudln't be a very popular solution just for RPi's 'faulty' bus. Bu=
t if
it turns out to be a common problem, I guess it isn't such a bad idea.

Regards,
Nicolas


--=-/3eUJ0qgyJIjoTnHixDm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmAz3YQACgkQlfZmHno8
x/6+bwgAtQQB7BFFx626W9Zk5QszVH6YZxzZrDGwB2TG4Xkgh0ixcftzjjugP1ZD
AVQ/i6vKhhSHkWi4iZTQZ6TVoH799j6+yc3B3UxPbbKvnz0Raz4VBnn+3MfvIdet
IkiPada9iNO9PpiAayopcctVcXSm9Fy7joq9fecDNkf3ze6iBxU+0kawi+j2CLAW
oTjTFCkoHoI0kh/EHAkjjbsVoouewn/J+p8x3UBJpkINv91xoao/FCslwkNuK+cn
gKO6/MCzbUUFSsC/l3wMRSIwvZSPMNKaInv8f8Ly0Ur6zgbne4uhpSHe31MHMVFB
rWUfPfsjzF9qXD2E0H9mw72AODji0A==
=h3kV
-----END PGP SIGNATURE-----

--=-/3eUJ0qgyJIjoTnHixDm--

