Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8597E324F4B
	for <lists+linux-pci@lfdr.de>; Thu, 25 Feb 2021 12:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbhBYLgL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Feb 2021 06:36:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:50190 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231160AbhBYLgL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Feb 2021 06:36:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C1514AAAE;
        Thu, 25 Feb 2021 11:35:28 +0000 (UTC)
Message-ID: <01091991523dac4c0c7e40f40e95c887af84f560.camel@suse.de>
Subject: Re: RPi4 can't deal with 64 bit PCI accesses
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Robin Murphy <robin.murphy@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Robin Murphy <robin.murphy@arm.con>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
Date:   Thu, 25 Feb 2021 12:35:27 +0100
In-Reply-To: <0cca5246-065b-b52e-7005-b1b5229922a7@arm.com>
References: <c188698ca0de3ed6c56a0cf7880e1578aa753077.camel@suse.de>
         <2220c875-f327-586c-79c7-eadff87e4b4d@arm.com>
         <6088038a-2366-2f63-0678-c65a0d2efabd@gmail.com>
         <20210224202538.GA2346950@infradead.org>
         <0142a12e-8637-5d8e-673a-20953807d0d4@gmail.com>
         <0e52b124-e5a8-cdea-9f15-11be8c20af2a@baylibre.com>
         <0cca5246-065b-b52e-7005-b1b5229922a7@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-k9sBTC5TTgICOQsKCsHi"
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-k9sBTC5TTgICOQsKCsHi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2021-02-25 at 11:10 +0000, Robin Murphy wrote:
> On 2021-02-25 10:29, Neil Armstrong wrote:
> > On 24/02/2021 21:35, Florian Fainelli wrote:
> > >=20
> > >=20
> > > On 2/24/2021 12:25 PM, Christoph Hellwig wrote:
> > > > On Wed, Feb 24, 2021 at 08:55:10AM -0800, Florian Fainelli wrote:
> > > > > > Working around kernel I/O accessors is all very well, but anoth=
er
> > > > > > concern for PCI in particular is when things like framebuffer m=
emory can
> > > > > > get mmap'ed into userspace (or even memremap'ed within the kern=
el). Even
> > > > > > in AArch32, compiled code may result in 64-bit accesses being g=
enerated
> > > > > > depending on how the CPU and interconnect handle LDRD/STRD/LDM/=
STM/etc.,
> > > > > > so it's basically not safe to ever let that happen at all.
> > > > >=20
> > > > > Agreed, this makes finding a generic solution a tiny bit harder. =
Do you
> > > > > have something in mind Nicolas?
> > > >=20
> > > > The only workable solution is a new
> > > >=20
> > > > bool 64bit_mmio_supported(void)
>=20
> Note that to be sufficiently generic this would have to be a per-device=
=20
> property - a system could have an affected PCIe root complex but still=
=20
> have other devices elsewhere in the SoC that can, or even need to, use=
=20
> 64-bit accesses.

Yes, that's what I had in mind myself. All in all, why penalize the rest of
busses in the system. What I'm planning is to introduce a '64bit-mmio-broke=
n'
DT property that'll utimately live somwhere in 'struct device.'

WRT why not defaulting to 32-bit accesses for distro images if they support
RPi4. My *un-educated* guess is that, the performance penalty of checking f=
or a
device flag is (way) lower than having to resort to two distinct write
operations with their assorted memory barriers. I'm sure you can
comment/correct me here.

> > > > check that is used like:
> > > >=20
> > > > 	if (64bit_mmio_supported())
> > > > 		readq(foodev->regs, REG_OFFSET);
> > > > 	else
> > > > 		lo_hi_readq(foodev->regs, REG_OFFSET);
> > > >=20
> > > > where 64bit_mmio_supported() return false for all 32-bit kernels,
> > > > true for all non-broken 64-bit kernels and is an actual function
> > > > for arm64 multiplatforms builds that include te RPi quirk.
> > > >=20
> > > > The above would then replace the existing magic from the
> > > > <linux/io-64-nonatomic-lo-hi.h> and <linux/io-64-nonatomic-hi-lo.h>
> > > > headers.
> > >=20
> > > That would work. The use case described by Robin is highly unlikely t=
o
> > > exist on the Pi4 given that you cannot easily access the PCIe bus and
> > > plug an arbitrary GPU, so maybe there is nothing to do for framebuffe=
r
> > > memory.
>=20
> Framebuffers are only the most obvious example - I don't feel the=20
> inclination to audit every driver/subsystem that can possibly make a=20
> non-iomem remapping or userspace mmap of a prefetchable BAR, but I'm=20
> sure there are more.

IIUC the only solution to the issue here is to disallow mmaping memory
belonging to a broken bus, right? In this case, the function above would do=
 the
trick.

> > Erf, not really, with the compute module ATX/ITX boards are being desig=
ned
> > with a full PCIe connector like:
> > https://www.indiegogo.com/projects/over-board-raspberry-pi-4-mini-itx-m=
otherboard/#/
>=20
> Right, this whole thread looks to have come about due to random=20
> endpoints getting connected to the exposed bus on compute modules. If it=
=20
> was an issue at all for the XHCI on standard Pi 4 boards I don't think=
=20
> people would just be starting to notice it now...

Indeed. For the record, here's the original complaint, although I'm sure ot=
hers
exist: https://github.com/raspberrypi/linux/issues/4158

Regards,
Nicolas


--=-k9sBTC5TTgICOQsKCsHi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmA3i38ACgkQlfZmHno8
x/7j2gf/Wm4btxu14ABJYNT9Ka0J/ZmlrryekmdEd17AzE9/GuqlekCA/N3mEpaN
Ust22YrrJ5olTC1liNOALC+MbmPL+xBHrRW1cLetXphtRAeqj/VIvF6wFFjRzQgv
pOiS+RKE8YPcJAwHKRk1ue4pGq0Uh9ukFTznUj61bSO4iy3dj0Yo7BegGailGge4
J63isBXzymXAttoggb8Yh9K0oix29FIcELTvlyajc5Zb2FbpW8xJLHJ0ZCEfBLfj
TzTC0IOCYOL5qbCHlDgxOI3UN+dprJFfbgZkAQwxng2xO5BzHB8rAEnLbFqqtIp/
0rccDhCpOcgZCHHsAO1ewWtcYT4qyw==
=fM0L
-----END PGP SIGNATURE-----

--=-k9sBTC5TTgICOQsKCsHi--

