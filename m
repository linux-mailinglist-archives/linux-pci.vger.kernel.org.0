Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60691F3975
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 13:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgFILUC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 07:20:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:60676 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbgFILUB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jun 2020 07:20:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 182F8B160;
        Tue,  9 Jun 2020 11:20:03 +0000 (UTC)
Message-ID: <582f63b8140a01e75a79c96ec569c3a68f434c61.camel@suse.de>
Subject: Re: [PATCH 5/9] usb: xhci-pci: Add support for reset controllers
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "wahrenst@gmx.net" <wahrenst@gmx.net>,
        "robh@kernel.org" <robh@kernel.org>,
        "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>,
        Eric Anholt <eric@anholt.net>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "linux-rpi-kernel@lists.infradead.org" 
        <linux-rpi-kernel@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tim.gover@raspberrypi.org" <tim.gover@raspberrypi.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
Date:   Tue, 09 Jun 2020 13:19:57 +0200
In-Reply-To: <CAHp75VdWq96SSzB1S9pM=H8=3np8-1Cep_9BqGiTCUTtCUt-yw@mail.gmail.com>
References: <20200608192701.18355-1-nsaenzjulienne@suse.de>
         <20200608192701.18355-6-nsaenzjulienne@suse.de>
         <CAHp75VdWq96SSzB1S9pM=H8=3np8-1Cep_9BqGiTCUTtCUt-yw@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-9EBI8hzXNUG3ROBaqpAE"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-9EBI8hzXNUG3ROBaqpAE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-06-08 at 22:44 +0300, Andy Shevchenko wrote:
>=20
>=20
> On Monday, June 8, 2020, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> wrote:
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
> >=20
> >  #include "xhci.h"
> >  #include "xhci-trace.h"
> > @@ -339,6 +340,7 @@ static int xhci_pci_probe(struct pci_dev *dev, cons=
t
> > struct pci_device_id *id)
> >         struct xhci_hcd *xhci;
> >         struct usb_hcd *hcd;
> >         struct xhci_driver_data *driver_data;
> > +       struct reset_control *reset;
> >=20
> >         driver_data =3D (struct xhci_driver_data *)id->driver_data;
> >         if (driver_data && driver_data->quirks & XHCI_RENESAS_FW_QUIRK)=
 {
> > @@ -347,6 +349,13 @@ static int xhci_pci_probe(struct pci_dev *dev, con=
st
> > struct pci_device_id *id)
> >                         return retval;
> >         }
> >=20
> > +       reset =3D devm_reset_control_get(&dev->bus->dev, NULL);
>=20
> =20
> > +       if (IS_ERR(reset)) {
> > +               retval =3D PTR_ERR(reset);
> > +               return retval;
> > +       }
>=20
> These four can be two, we have too many LOCs in the kernel for no reason.

Noted

> =20
> > +       reset_control_reset(reset);
> > +
> >         /* Prevent runtime suspending between USB-2 and USB-3 initializ=
ation
> > */
> >         pm_runtime_get_noresume(&dev->dev);
> > =20
> > --=20
> > 2.26.2
> >=20
> >=20
>=20
>=20


--=-9EBI8hzXNUG3ROBaqpAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7fcF0ACgkQlfZmHno8
x/5HTAgAmhR811lue01X7GYq1cj7N9zCOPoNa2ZH9QWAMqqWbHR+24haBspjEywh
jqF4feZsoD4jj1ZGrwSy+MKq2rRt+iaXPbDCcTrN/zuL38U9Zt/lZPxhvauQruKI
NaVoK8R4lJRJ7HVHxMYPGUmT1FOVmZuYi4rp/uZlRjTmedsU/6s/x5xkgsTSAga1
j9EWMT39vfMLMJeVsjynLw94bwl0nmwUxrWYi+C0W3qlrsIyTx39FOoa6HRdjwT9
KPyQPzlPsUPEmrTbDdaDztFp39r0ESQYqvDjv3wReVtp3wWBsgbe5ECwiovUcKMu
sp04DqMNxUJu/iqC8gkJkvc80XiI/Q==
=H32q
-----END PGP SIGNATURE-----

--=-9EBI8hzXNUG3ROBaqpAE--

