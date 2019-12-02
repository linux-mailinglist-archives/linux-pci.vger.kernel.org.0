Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D44FC10E810
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2019 11:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfLBKAJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Dec 2019 05:00:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:60354 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726115AbfLBKAJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Dec 2019 05:00:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D8DE5ADD9;
        Mon,  2 Dec 2019 10:00:05 +0000 (UTC)
Message-ID: <2820f3fb9abc69d54df0dee1b6233eaf3cb63834.camel@suse.de>
Subject: Re: [PATCH v3 5/7] PCI: brcmstb: add MSI capability
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <wahrenst@gmx.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        mbrugger@suse.com, phil@raspberrypi.org, jeremy.linton@arm.com,
        linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
Date:   Mon, 02 Dec 2019 10:59:36 +0100
In-Reply-To: <20191129154629.GF43905@e119886-lin.cambridge.arm.com>
References: <20191126091946.7970-1-nsaenzjulienne@suse.de>
         <20191126091946.7970-6-nsaenzjulienne@suse.de>
         <20191129154629.GF43905@e119886-lin.cambridge.arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-K6gbtw6TubZyS8Q2Q2nd"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-K6gbtw6TubZyS8Q2Q2nd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Fri, 2019-11-29 at 15:46 +0000, Andrew Murray wrote:
> On Tue, Nov 26, 2019 at 10:19:43AM +0100, Nicolas Saenz Julienne wrote:
> > From: Jim Quinlan <james.quinlan@broadcom.com>
> >=20
> > This adds MSI support to the Broadcom STB PCIe host controller. The MSI
> > controller is physically located within the PCIe block, however, there
> > is no reason why the MSI controller could not be moved elsewhere in the
> > future. MSIX is not supported by the HW.
> >=20
> > Since the internal Brcmstb MSI controller is intertwined with the PCIe
> > controller, it is not its own platform device but rather part of the
> > PCIe platform device.
> >=20
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > Co-developed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > Reviewed-by: Marc Zyngier <maz@kernel.org>
> >=20
> > ---
> >=20
> > Changes since v2 (kept Marc's Reviewed-by as changes didn't affect irq
> > subsystem stuff or seem petty enough):
> >   - Use standard APIs on register operations
> >   - Get rid of revision code
>=20
> Do any RPI4's have a HW revision of less than 33?

No, IIRC it's actually revision 34. I had left that bit of code in, followi=
ng
the same train of thought as with the of_data on the device-tree part of th=
e
driver: "It's harmless and should make accomodating other devices easier." =
It
turned out not to be such a great approach. Lesson's learned. So I decided =
to
remove it.

> >   - Update rules to msi_target_addr selection
> >   - Remove unwarranted MSI_FLAG_PCI_MSIX
> >   - Small cosmetic changes
> >=20
> > Changes since v1:cuando ten=C3=ADas tu vacaciones?
> >   - Move revision code and some registers to this patch
> >   - Use PCIE_MSI_IRQ_DOMAIN in Kconfig
> >   - Remove redundant register read from ISR
> >   - Fail probe on MSI init error
> >   - Get rid of msi_internal
> >   - Use bitmap family of functions
> >   - Use edge triggered setup
> >   - Add comment regarding MultiMSI
> >   - Simplify compose_msi_msg to avoid reg read
> >=20
> > This is based on Jim's original submission[1] with some slight changes
> > regarding how pcie->msi_target_addr is decided.
> >=20
> > [1] https://patchwork.kernel.org/patch/10605955/
> >=20
> >  drivers/pci/controller/Kconfig        |   1 +
> >  drivers/pci/controller/pcie-brcmstb.c | 261 +++++++++++++++++++++++++-
> >  2 files changed, 261 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kc=
onfig
> > index 27504f108ee5..918e283bbff1 100644
> > +
> > +static void brcm_msi_compose_msi_msg(struct irq_data *data, struct msi=
_msg
> > *msg)
> > +{
> > +	struct brcm_msi *msi =3D irq_data_get_irq_chip_data(data);
> > +
> > +	msg->address_lo =3D lower_32_bits(msi->target_addr);
> > +	msg->address_hi =3D upper_32_bits(msi->target_addr);
> > +	msg->data =3D 0x6540 | data->hwirq;
>=20
> NIT: Perhaps this 0x6540 can be a define - just in the same way we have a
> define
> for PCIE_MISC_MSI_DATA_CONFIG_VAL.

Noted

Regards,
Nicolas


--=-K6gbtw6TubZyS8Q2Q2nd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl3k4IgACgkQlfZmHno8
x/6oLAf/ZrjxvdunJzn4AYQQQ3YqnEVeLonAfG7NdyTmIPouYioWmuAJeWWycG9Z
w9LJ5HQWtb34zAbKgJL9oznp+tlE/SKI+BoIxJt3HnNC44bQvYP9D2mVuC3khAMQ
6wsSY7nKOQ84BC1wNhhsTxVOrR4TqAaCXG+Qh+rP5Vu/4tcH5CDJCg1+NpsTN1Lh
/skKo6q+DbjQxyRUwXp0CpTm0VpSQpbhu9BDRAFUNT9VKY0zptPGFF1CiDaV+dsU
WJENZ1GM/PaynUdZFbUE/y+uRf0JyvJeXyq6h7tsX0ORPvBHSR/mqSw70UregaH6
c+jSMYmGSBOe+KRNM9w/TLdcRBa6Qw==
=Z/P8
-----END PGP SIGNATURE-----

--=-K6gbtw6TubZyS8Q2Q2nd--

