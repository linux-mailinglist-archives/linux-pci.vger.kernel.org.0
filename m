Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F6A3AFEA6
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jun 2021 10:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhFVIFN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Jun 2021 04:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbhFVIFL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Jun 2021 04:05:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D61C061756
        for <linux-pci@vger.kernel.org>; Tue, 22 Jun 2021 01:02:55 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lvbMx-0007w7-Lf; Tue, 22 Jun 2021 10:02:51 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lvbMw-0008Cs-OP; Tue, 22 Jun 2021 10:02:50 +0200
Date:   Tue, 22 Jun 2021 10:02:50 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@pengutronix.de, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: Make struct pci_epf_driver::remove return
 void
Message-ID: <20210622080250.wav54n2tfb2m5w3r@pengutronix.de>
References: <20210223090757.57604-1-u.kleine-koenig@pengutronix.de>
 <1195e3d6-e2ca-f54b-aa09-289dbebd85d7@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hnmwjub76jnjkr44"
Content-Disposition: inline
In-Reply-To: <1195e3d6-e2ca-f54b-aa09-289dbebd85d7@kleine-koenig.org>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--hnmwjub76jnjkr44
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Bjorn,

On Mon, May 10, 2021 at 09:26:37PM +0200, Uwe Kleine-K=F6nig wrote:
> On 2/23/21 10:07 AM, Uwe Kleine-K=F6nig wrote:
> > The driver core ignores the return value of pci_epf_device_remove()
> > (because there is only little it can do when a device disappears) and
> > there are no pci_epf_drivers with a remove callback.
> >=20
> > So make it impossible for future drivers to return an unused error code
> > by changing the remove prototype to return void.
> >=20
> > The real motivation for this change is the quest to make struct
> > bus_type::remove return void, too.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> Ping! This patch now waits for more than 2 months on feedback (or
> application). The 5.13 merge window just closed, this is a great opportun=
ity
> to apply this patch for next.

It seems I don't get feedback from Kishon and Lorenzo. This is one of
the last patches I need to actually change bus_type::remove. Would you
be willing to take the patch without them reacting? Or do you have a way
to trigger them that is more effective than I have?

Best regards
Uwe

> > ---
> >   drivers/pci/endpoint/pci-epf-core.c | 5 ++---
> >   include/linux/pci-epf.h             | 2 +-
> >   2 files changed, 3 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint=
/pci-epf-core.c
> > index 7646c8660d42..a19c375f9ec9 100644
> > --- a/drivers/pci/endpoint/pci-epf-core.c
> > +++ b/drivers/pci/endpoint/pci-epf-core.c
> > @@ -389,15 +389,14 @@ static int pci_epf_device_probe(struct device *de=
v)
> >   static int pci_epf_device_remove(struct device *dev)
> >   {
> > -	int ret =3D 0;
> >   	struct pci_epf *epf =3D to_pci_epf(dev);
> >   	struct pci_epf_driver *driver =3D to_pci_epf_driver(dev->driver);
> >   	if (driver->remove)
> > -		ret =3D driver->remove(epf);
> > +		driver->remove(epf);
> >   	epf->driver =3D NULL;
> > -	return ret;
> > +	return 0;
> >   }
> >   static struct bus_type pci_epf_bus_type =3D {
> > diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> > index 6833e2160ef1..f8a17b6b1d31 100644
> > --- a/include/linux/pci-epf.h
> > +++ b/include/linux/pci-epf.h
> > @@ -85,7 +85,7 @@ struct pci_epf_ops {
> >    */
> >   struct pci_epf_driver {
> >   	int	(*probe)(struct pci_epf *epf);
> > -	int	(*remove)(struct pci_epf *epf);
> > +	void	(*remove)(struct pci_epf *epf);
> >   	struct device_driver	driver;
> >   	struct pci_epf_ops	*ops;
> >=20
>=20
>=20




--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hnmwjub76jnjkr44
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDRmScACgkQwfwUeK3K
7An5Lwf/V8DlYfQdyPie1tJXpiC1CGs+B1Ccefs865ffeGXygquLhhtljoxRD6uS
TUzhR94CWfudkvaS6GgiPbPwGWxXj+j+wA6tiOw+qPU1fbmmkC9BZMq2FjEmdzv1
zWdim5thQlBjxtEttGEdSrY2ca75gUmlyIIKItVibI10VkPHsx5/Qd/4yaOfUXcg
CkxmRE6ugygWP/ZTnn4lN0bc0TfPitMFCCxjIVBBmTuvJJCaxCm96rBUgdtKH7LS
9QjAUe4FyhRevK6+zlTP93gt6xHt1ZzHBR2fd9p02VT1CGrDn9uCk9kSolrlEAKi
GBWgTBjPWvO30setu9I8+x7c2UxE2w==
=cgzf
-----END PGP SIGNATURE-----

--hnmwjub76jnjkr44--
