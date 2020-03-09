Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 809E717DE3C
	for <lists+linux-pci@lfdr.de>; Mon,  9 Mar 2020 12:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgCILJa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Mar 2020 07:09:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:43062 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbgCILJa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Mar 2020 07:09:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0D324B137;
        Mon,  9 Mar 2020 11:09:28 +0000 (UTC)
Message-ID: <72e22c655f885bf37475b4fea3a1cc4866d05a39.camel@suse.de>
Subject: Re: [PATCH v4 4/4] USB: pci-quirks: Add Raspberry Pi 4 quirk
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-kernel@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com,
        gregkh@linuxfoundation.org, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, wahrenst@gmx.net
Date:   Mon, 09 Mar 2020 12:09:26 +0100
In-Reply-To: <b4fb58f0-6d51-657b-bcf6-5f4b0c798312@cogentembedded.com>
References: <20200306114348.5172-1-nsaenzjulienne@suse.de>
         <20200306114348.5172-5-nsaenzjulienne@suse.de>
         <b4fb58f0-6d51-657b-bcf6-5f4b0c798312@cogentembedded.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-rT/H+TzAenyUAX5ny95N"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-rT/H+TzAenyUAX5ny95N
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2020-03-07 at 12:54 +0300, Sergei Shtylyov wrote:
> Hello!
>=20
> On 06.03.2020 14:43, Nicolas Saenz Julienne wrote:
>=20
> > On the Raspberry Pi 4, after a PCI reset, VL805's firmware may either b=
e
> > loaded directly from an EEPROM or, if not present, by the SoC's
> > VideCore. Inform VideCore that VL805 was just reset.
> >=20
> > Also, as this creates a dependency between XHCI_PCI and VideoCore's
> > firmware interface, reflect that on the firmware interface Kconfg.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> >=20
> > Changes since v3:
> >   - Add more complete error message.
> >   - Add braces around if statement
> >=20
> > Changes since v1:
> >   - Make RASPBERRYPI_FIRMWARE dependent on this quirk to make sure it
> >     gets compiled when needed.
> >=20
> >   drivers/firmware/Kconfig      |  1 +
> >   drivers/usb/host/pci-quirks.c | 16 ++++++++++++++++
> >   2 files changed, 17 insertions(+)
> [...]
> > diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirk=
s.c
> > index beb2efa71341..452f5f12b042 100644
> > --- a/drivers/usb/host/pci-quirks.c
> > +++ b/drivers/usb/host/pci-quirks.c
> > @@ -16,6 +16,9 @@
> >   #include <linux/export.h>
> >   #include <linux/acpi.h>
> >   #include <linux/dmi.h>
> > +
> > +#include <soc/bcm2835/raspberrypi-firmware.h>
> > +
> >   #include "pci-quirks.h"
> >   #include "xhci-ext-caps.h"
> >  =20
> > @@ -1243,11 +1246,24 @@ static void quirk_usb_handoff_xhci(struct pci_d=
ev
> > *pdev)
> >  =20
> >   static void quirk_usb_early_handoff(struct pci_dev *pdev)
> >   {
> > +	int ret;
> > +
> >   	/* Skip Netlogic mips SoC's internal PCI USB controller.
> >   	 * This device does not need/support EHCI/OHCI handoff
> >   	 */
> >   	if (pdev->vendor =3D=3D 0x184e)	/* vendor Netlogic */
> >   		return;
> > +
> > +	if (pdev->vendor =3D=3D PCI_VENDOR_ID_VIA && pdev->device =3D=3D 0x34=
83) {
> > +		ret =3D rpi_firmware_init_vl805(pdev);
> > +		if (ret) {
> > +			/* Firmware might be outdated, or something failed */
> > +			dev_warn(&pdev->dev, "Failed to load VL805's firmware:
> > %d\n", ret);
> > +			dev_warn(&pdev->dev, "Will continue to attempt to work,
> > "
> > +				 "but bad things might happen. You should fix
> > this...\n");
>=20
>     Don't break up the long kernel messages (checkpatch.pl should not
> complain=20
> about them).

I generally don't, but in this specific case IMO it went way too long, as i=
n
140 charaters long, so I figured it'd be better to split it. That said, I d=
on't
really care, so I'll happily change it for v5.

Regards,
Nicolas


--=-rT/H+TzAenyUAX5ny95N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl5mI+YACgkQlfZmHno8
x/6trAf+LCwWdCvo2mQccw8U9fpMpA9wsaVY6d49UfLKs33/4jvJGPr7q7+Zpn79
c63cuybYMkkFtxV/9KpjDEFU0MaKKUOdtHo6aQKjxv0+Z/cLlSP0nl/AdMOv/kuX
kgKqpJm+kAF2ww+Pb7gBKVs1P8/4ccOqiAGyQ/KbZrfDVWTure3/GUSRhHfNZhx8
9Ka+aXq3e+Rfq+pznocC+3Crds4mApwx+V20kL3lXb7/PKcnOL9bQY6+XG6B1ZWX
s7fN7M65qcFdS00TxXVeAuOU9CKhFWL4mS0a+Tf6cGAnTVlpqseLGG4dBBcEHEJs
4r4TKgaIeHsXngkPbS1H/BRcsCxoDw==
=o34B
-----END PGP SIGNATURE-----

--=-rT/H+TzAenyUAX5ny95N--

