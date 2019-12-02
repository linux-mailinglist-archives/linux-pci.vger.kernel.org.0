Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD45510EA04
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2019 13:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfLBMWP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Dec 2019 07:22:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:35802 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727354AbfLBMWP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Dec 2019 07:22:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 57ED8B3A9;
        Mon,  2 Dec 2019 12:22:12 +0000 (UTC)
Message-ID: <c63647bb1b13cc05c9cecdd7f25e497ab9416e4f.camel@suse.de>
Subject: Re: [PATCH v3 5/7] PCI: brcmstb: add MSI capability
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, mbrugger@suse.com,
        maz@kernel.org, phil@raspberrypi.org, linux-kernel@vger.kernel.org,
        jeremy.linton@arm.com, Eric Anholt <eric@anholt.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Stefan Wahren <wahrenst@gmx.net>, james.quinlan@broadcom.com,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org
Date:   Mon, 02 Dec 2019 13:22:09 +0100
In-Reply-To: <20191202122050.GA18399@e119886-lin.cambridge.arm.com>
References: <20191126091946.7970-1-nsaenzjulienne@suse.de>
         <20191126091946.7970-6-nsaenzjulienne@suse.de>
         <20191129154629.GF43905@e119886-lin.cambridge.arm.com>
         <2820f3fb9abc69d54df0dee1b6233eaf3cb63834.camel@suse.de>
         <20191202122050.GA18399@e119886-lin.cambridge.arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-NzVbf7bNfje0MokF6jK8"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-NzVbf7bNfje0MokF6jK8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-12-02 at 12:20 +0000, Andrew Murray wrote:
> On Mon, Dec 02, 2019 at 10:59:36AM +0100, Nicolas Saenz Julienne wrote:
> > Hi Andrew,
> >=20
> > On Fri, 2019-11-29 at 15:46 +0000, Andrew Murray wrote:
> > > On Tue, Nov 26, 2019 at 10:19:43AM +0100, Nicolas Saenz Julienne wrot=
e:
> > > > From: Jim Quinlan <james.quinlan@broadcom.com>
> > > >=20
> > > > This adds MSI support to the Broadcom STB PCIe host controller. The=
 MSI
> > > > controller is physically located within the PCIe block, however, th=
ere
> > > > is no reason why the MSI controller could not be moved elsewhere in=
 the
> > > > future. MSIX is not supported by the HW.
> > > >=20
> > > > Since the internal Brcmstb MSI controller is intertwined with the P=
CIe
> > > > controller, it is not its own platform device but rather part of th=
e
> > > > PCIe platform device.
> > > >=20
> > > > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > > > Co-developed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > > Reviewed-by: Marc Zyngier <maz@kernel.org>
> > > >=20
> > > > ---
> > > >=20
> > > > Changes since v2 (kept Marc's Reviewed-by as changes didn't affect =
irq
> > > > subsystem stuff or seem petty enough):
> > > >   - Use standard APIs on register operations
> > > >   - Get rid of revision code
> > >=20
> > > Do any RPI4's have a HW revision of less than 33?
> >=20
> > No, IIRC it's actually revision 34. I had left that bit of code in,
> > following
> > the same train of thought as with the of_data on the device-tree part o=
f the
> > driver: "It's harmless and should make accomodating other devices easie=
r."
> > It
> > turned out not to be such a great approach. Lesson's learned. So I deci=
ded
> > to
> > remove it.
>=20
> OK you can add my:
>=20
> Reviewed-by: Andrew Murray <andrew.murray@arm.com>
>=20
> Thanks,
>=20
> Andrew Murray

Thanks!


--=-NzVbf7bNfje0MokF6jK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl3lAfEACgkQlfZmHno8
x/7l3wf+KA81gHEGBFGfNHE8rju8uZ8OgP4N968EIm5vkR4PT4s7PdSjcrGBzcjg
25Vb581Thmdr/qOfPARI3DHCsAa03D6+/mugzFho54yTbHagqr5tV2iHHvkTcnFx
l0/j2eJ5s4FMW6G4cmvkuJNUz8ZTX98V4e9bWiwAhAXKQG3cTAZntmc1/mhqcvme
ba7YOMykf1auwSWtE12VIOCb80iFBF8PfWMW5KBQ3jqQ/0n2+r4Ov5qYRrBYj3b/
suKogbQcADjTRSf84HH57xGDBTTb6hpSm5NDyHMAa7+82kP4JdhKdwJo+brTQ0/X
JE7JgkxNISdvCaNJmtpscdI/FI6f7g==
=TEyC
-----END PGP SIGNATURE-----

--=-NzVbf7bNfje0MokF6jK8--

