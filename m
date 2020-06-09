Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B65F1F3968
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 13:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbgFILSo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 07:18:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:59602 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbgFILSn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jun 2020 07:18:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7B218ACF2;
        Tue,  9 Jun 2020 11:18:44 +0000 (UTC)
Message-ID: <382b81937757de570a83ba4ff9276221c0bba547.camel@suse.de>
Subject: Re: [PATCH 5/9] usb: xhci-pci: Add support for reset controllers
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        gregkh@linuxfoundation.org, wahrenst@gmx.net, robh@kernel.org,
        mathias.nyman@linux.intel.com, Eric Anholt <eric@anholt.net>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     lorenzo.pieralisi@arm.com, tim.gover@raspberrypi.org,
        helgaas@kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 09 Jun 2020 13:18:38 +0200
In-Reply-To: <5d3200cc-17cc-026f-1dfe-c10ec949f9ad@gmail.com>
References: <20200608192701.18355-1-nsaenzjulienne@suse.de>
         <20200608192701.18355-6-nsaenzjulienne@suse.de>
         <5d3200cc-17cc-026f-1dfe-c10ec949f9ad@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-NVYfO6rea++DlkfIypsN"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-NVYfO6rea++DlkfIypsN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Florian, thanks for the reviews!

On Mon, 2020-06-08 at 12:43 -0700, Florian Fainelli wrote:
>=20
> On 6/8/2020 12:26 PM, Nicolas Saenz Julienne wrote:
> > Some atypical users of xhci-pci might need to manually reset their xHCI
> > controller before starting the HCD setup. Check if a reset controller
> > device is available to the PCI bus and trigger a reset.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> >  drivers/usb/host/xhci-pci.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >=20
> > diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> > index ef513c2fb843..45f70facdfcd 100644
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
> > @@ -347,6 +349,13 @@ static int xhci_pci_probe(struct pci_dev *dev, con=
st
> > struct pci_device_id *id)
> >  			return retval;
> >  	}
> > =20
> > +	reset =3D devm_reset_control_get(&dev->bus->dev, NULL);
>=20
> Should not this be devm_reset_control_get_optional()?

Yes, you're right.

Regards,
Nicolas

> > +	if (IS_ERR(reset)) {
> > +		retval =3D PTR_ERR(reset);
> > +		return retval;
> > +	}
> > +	reset_control_reset(reset);
> > +
> >  	/* Prevent runtime suspending between USB-2 and USB-3 initialization =
*/
> >  	pm_runtime_get_noresume(&dev->dev);
> > =20
> >=20


--=-NVYfO6rea++DlkfIypsN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7fcA4ACgkQlfZmHno8
x/42lggAr4gRLoLdRsOhuBSqjjZLdGcfoxGXMXDpXwxrRsd71lmv+/LtQABORuU3
Y4M35yyADqBeIuOMtzBSNCxGdLhCxhz4oRZwlAZMO2BRmbv5nVYbesB4JGCeGQ6j
Kac2Fhfb5aBF7KhISqp7HGN5cH6fQQAgjiPebWDmCNqg0k/kC82VQgJ+JfB3uL3t
3IuTyHni/9N/xdxeLwZDMjASxQGWRwCq0U+7uGJmsP1lYFB0ucjHa9egEzdeNbui
DgOvWHSrBjNS3t3bcSpaG5IUspjT+zCYVUOr24zhW7k2WurtDGlkx5Oeh3+/Pipf
+z7kYFcTP0uYL6kbSA4G7CdRzBFWHw==
=WpCe
-----END PGP SIGNATURE-----

--=-NVYfO6rea++DlkfIypsN--

