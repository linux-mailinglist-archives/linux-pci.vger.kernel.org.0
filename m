Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F471F5832
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jun 2020 17:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730361AbgFJPtf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jun 2020 11:49:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:39862 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730351AbgFJPtd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Jun 2020 11:49:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3BCFCAD7D;
        Wed, 10 Jun 2020 15:49:35 +0000 (UTC)
Message-ID: <1f486fc41030df8c74bf021b02e59f007bf9d14e.camel@suse.de>
Subject: Re: [PATCH v2 5/9] usb: xhci-pci: Add support for reset controllers
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        gregkh@linuxfoundation.org, wahrenst@gmx.net,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     tim.gover@raspberrypi.org, mathias.nyman@linux.intel.com,
        linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
        andy.shevchenko@gmail.com, lorenzo.pieralisi@arm.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, helgaas@kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Wed, 10 Jun 2020 17:49:28 +0200
In-Reply-To: <d452ddb8-cd30-1bfc-7b72-af3412e22ed4@gmail.com>
References: <20200609175003.19793-1-nsaenzjulienne@suse.de>
         <20200609175003.19793-6-nsaenzjulienne@suse.de>
         <d452ddb8-cd30-1bfc-7b72-af3412e22ed4@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-p+TvsQpoIbGXnKb+ob9S"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-p+TvsQpoIbGXnKb+ob9S
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On Tue, 2020-06-09 at 11:13 -0700, Florian Fainelli wrote:
>=20
> On 6/9/2020 10:49 AM, Nicolas Saenz Julienne wrote:
> > Some atypical users of xhci-pci might need to manually reset their xHCI
> > controller before starting the HCD setup. Check if a reset controller
> > device is available to the PCI bus and trigger a reset.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> >=20
> > ---
> >=20
> > Changes since v1:
> >  - Use proper reset API
> >  - Make code simpler
> >=20
> >  drivers/usb/host/xhci-pci.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> > index ef513c2fb843..6e96affa4ceb 100644
> > --- a/drivers/usb/host/xhci-pci.c
> > +++ b/drivers/usb/host/xhci-pci.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/module.h>
> >  #include <linux/acpi.h>
> > +#include <linux/reset.h>
> > =20
> >  #include "xhci.h"
> >  #include "xhci-trace.h"
> > @@ -339,6 +340,7 @@ static int xhci_pci_probe(struct pci_dev *dev, cons=
t
> > struct pci_device_id *id)
> >  	struct xhci_hcd *xhci;
> >  	struct usb_hcd *hcd;
> >  	struct xhci_driver_data *driver_data;
> > +	struct reset_control *reset;
> > =20
> >  	driver_data =3D (struct xhci_driver_data *)id->driver_data;
> >  	if (driver_data && driver_data->quirks & XHCI_RENESAS_FW_QUIRK) {
> > @@ -347,6 +349,11 @@ static int xhci_pci_probe(struct pci_dev *dev, con=
st
> > struct pci_device_id *id)
> >  			return retval;
> >  	}
> > =20
> > +	reset =3D devm_reset_control_get_optional_exclusive(&dev->bus->dev, N=
ULL);
> > +	if (IS_ERR(reset))
> > +		return PTR_ERR(reset);
> > +	reset_control_reset(reset);
>=20
> Sorry for not catching this earlier, since this is a generic integration
> with the reset controller API, should not you also add a
> reset_control_reset() to hcd_pci_resume() for symmetry?

Agreed, if the RPi4 supported suspend/resume, which AFAIK doesn't, an extra
reset would be needed as pcie-brcmstb performs a fundamental reset on resum=
e
forcing us to reinitialize vl805.

Thanks!
Nicolas


--=-p+TvsQpoIbGXnKb+ob9S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7hAQgACgkQlfZmHno8
x/6Fzgf8CkpRsxb++ft8vkQZu512oFbwoacT+zoJ74u+pVjwyS77fNOhO2Guu5/b
LFcIThixpQXCsNbhbJ7ioJ+S/+ZLgITbcd9DpBFqsyWeoPGJUQU+uLpViwauaRTJ
7spzpPtmApUR5s3zC5zTT2w3DKdHyMSnco9nX1URRO6HMD1iVbm2WOzDOI/MC4w/
y8j3XjcaaFvusXOYe5J0JzFNvvLr8oqVj7gQSJQOaLbPg9nfvCQT/gjWiz/G9tqS
000fU5+zSJ1wCMw22lWR6WOppHi4/w8YIswcVeat+d6RwA/oCs1soywj1XvApDBh
6blr3s73GBC82xV02R8fcfG+AaroUQ==
=DneD
-----END PGP SIGNATURE-----

--=-p+TvsQpoIbGXnKb+ob9S--

