Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A346A1F3B67
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 15:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgFINIJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 09:08:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:42134 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbgFINIJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jun 2020 09:08:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A221CAA6F;
        Tue,  9 Jun 2020 13:08:10 +0000 (UTC)
Message-ID: <5c55790c31603aed48fcd6e84ccbc4a6d8c6d1fd.camel@suse.de>
Subject: Re: [PATCH 5/9] usb: xhci-pci: Add support for reset controllers
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        gregkh@linuxfoundation.org, wahrenst@gmx.net, robh@kernel.org,
        mathias.nyman@linux.intel.com, Eric Anholt <eric@anholt.net>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     lorenzo.pieralisi@arm.com, tim.gover@raspberrypi.org,
        helgaas@kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 09 Jun 2020 15:08:04 +0200
In-Reply-To: <73fdeca7b651252f7907635e97f9f9b31e702868.camel@pengutronix.de>
References: <20200608192701.18355-1-nsaenzjulienne@suse.de>
         <20200608192701.18355-6-nsaenzjulienne@suse.de>
         <5d3200cc-17cc-026f-1dfe-c10ec949f9ad@gmail.com>
         <382b81937757de570a83ba4ff9276221c0bba547.camel@suse.de>
         <73fdeca7b651252f7907635e97f9f9b31e702868.camel@pengutronix.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-aPyaZQX6Bi+lXKb2F+qi"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-aPyaZQX6Bi+lXKb2F+qi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-06-09 at 13:59 +0200, Philipp Zabel wrote:
> Hi Nicolas,
>=20
>=20
>=20
> On Tue, 2020-06-09 at 13:18 +0200, Nicolas Saenz Julienne wrote:
>=20
> > Hi Florian, thanks for the reviews!
> > On Mon, 2020-06-08 at 12:43 -0700, Florian Fainelli wrote:
> > > On 6/8/2020 12:26 PM, Nicolas Saenz Julienne wrote:
> > > > Some atypical users of xhci-pci might need to manually reset their =
xHCI
> > > > controller before starting the HCD setup. Check if a reset controll=
er
> > > > device is available to the PCI bus and trigger a reset.
> > > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > > ---
> > > >   drivers/usb/host/xhci-pci.c | 9 +++++++++
> > > >   1 file changed, 9 insertions(+)
> > > > diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pc=
i.c
> > > > index ef513c2fb843..45f70facdfcd 100644
> > > > --- a/drivers/usb/host/xhci-pci.c
> > > > +++ b/drivers/usb/host/xhci-pci.c
>=20
> [...]
>=20
> > > > @@ -347,6 +349,13 @@ static int xhci_pci_probe(struct pci_dev *dev,
> > > > const
> > > > struct pci_device_id *id)
> > > >                    return retval;
> > > >    }
> > > >  =20
> > > > + reset =3D devm_reset_control_get(&dev->bus->dev, NULL);
> > > Should not this be devm_reset_control_get_optional()?
> > Yes, you're right.
>=20
>=20
> Please use devm_reset_control_get_optional_exclusive() while you're at
>=20
> it.
>=20

Will do!

Regards,
Nicolas


--=-aPyaZQX6Bi+lXKb2F+qi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7fibQACgkQlfZmHno8
x/4nCQf+Pu7jCPf9/NoIlTfRB7FZ4OANYt5inVdJyL5rJD2651r40FKjtZOBZzVA
WZF5fC3mPhzBuwiOY0BhQNmGczuZW7F3xzfWtitDo1ee7xMbBO6Sb+ppOQ3HD3qa
dDIcoWpQkUBSy4nF2HegV8Mk3lk1wNp5qWKhlOP9RdpI3TaMPQ6LYdjlHKXGnHfK
tW56rMzKdearm5rY/UuChAfqZgZnlTDugkE/U0PPUToNmd3HVw4I46wNgCPwxFKV
99FgNnbLiEAqYzOD32uSd8o8N+v7smGdeG8IgNMxji+01vqUH+ygdqUJt/9V3nfK
jYUgqXTX6cLyPVX9Km25skKw8UAcMw==
=bQPH
-----END PGP SIGNATURE-----

--=-aPyaZQX6Bi+lXKb2F+qi--

