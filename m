Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7E23E9A6E
	for <lists+linux-pci@lfdr.de>; Wed, 11 Aug 2021 23:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhHKVfN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 17:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhHKVfN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Aug 2021 17:35:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2E8C0613D3
        for <linux-pci@vger.kernel.org>; Wed, 11 Aug 2021 14:34:49 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mDvs3-0005CZ-9n; Wed, 11 Aug 2021 23:34:43 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mDvrx-0001l9-Om; Wed, 11 Aug 2021 23:34:37 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mDvrx-00056u-N4; Wed, 11 Aug 2021 23:34:37 +0200
Date:   Wed, 11 Aug 2021 23:34:05 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     Fiona Trahe <fiona.trahe@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Marco Chiappero <marco.chiappero@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        qat-linux@intel.com, Bjorn Helgaas <helgaas@kernel.org>,
        linux-crypto@vger.kernel.org, kernel@pengutronix.de,
        linux-pci@vger.kernel.org, Jack Xu <jack.xu@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Tomaszx Kowalik <tomaszx.kowalik@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v3 6/8] crypto: qat - simplify adf_enable_aer()
Message-ID: <20210811213405.avihazo33irdjxic@pengutronix.de>
References: <20210811080637.2596434-1-u.kleine-koenig@pengutronix.de>
 <20210811080637.2596434-7-u.kleine-koenig@pengutronix.de>
 <YRO69xL+F/6Paj+I@silpixa00400314>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nru7sdu6ylpnbz6f"
Content-Disposition: inline
In-Reply-To: <YRO69xL+F/6Paj+I@silpixa00400314>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--nru7sdu6ylpnbz6f
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 11, 2021 at 12:56:39PM +0100, Giovanni Cabiddu wrote:
> On Wed, Aug 11, 2021 at 10:06:35AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > A struct pci_driver is supposed to be constant and assigning .err_handl=
er
> > once per bound device isn't really sensible. Also as the function retur=
ns
> > zero unconditionally let it return no value instead and simplify the
> > callers accordingly.
> >=20
> > As a side effect this removes one user of struct pci_dev::driver. This
> > member is planned to be removed.
> >=20
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Thanks Uwe for the rework.
>=20
> > ---
> >  drivers/crypto/qat/qat_4xxx/adf_drv.c          |  7 ++-----
> >  drivers/crypto/qat/qat_c3xxx/adf_drv.c         |  7 ++-----
> >  drivers/crypto/qat/qat_c62x/adf_drv.c          |  7 ++-----
> >  drivers/crypto/qat/qat_common/adf_aer.c        | 10 +++-------
> >  drivers/crypto/qat/qat_common/adf_common_drv.h |  2 +-
> >  drivers/crypto/qat/qat_dh895xcc/adf_drv.c      |  7 ++-----
> >  6 files changed, 12 insertions(+), 28 deletions(-)
> >=20
> > diff --git a/drivers/crypto/qat/qat_4xxx/adf_drv.c b/drivers/crypto/qat=
/qat_4xxx/adf_drv.c
> > index a8805c815d16..1620281a9ed8 100644
> > --- a/drivers/crypto/qat/qat_4xxx/adf_drv.c
> > +++ b/drivers/crypto/qat/qat_4xxx/adf_drv.c
> > @@ -253,11 +253,7 @@ static int adf_probe(struct pci_dev *pdev, const s=
truct pci_device_id *ent)
> > =20
> >  	pci_set_master(pdev);
> > =20
> > -	if (adf_enable_aer(accel_dev)) {
> > -		dev_err(&pdev->dev, "Failed to enable aer.\n");
> > -		ret =3D -EFAULT;
> > -		goto out_err;
> > -	}
> > +	adf_enable_aer(accel_dev);
> After seeing your patch, I'm thinking to get rid of both adf_enable_aer()
> (and adf_disable_aer()) and call directly pci_enable_pcie_error_reporting=
()
> here.
>=20
> There is another patch around this area that I reworked (but not sent
> yet - https://patchwork.kernel.org/project/linux-crypto/patch/a19132d07a6=
5dbef5e818f84b2bc971f26cc3805.1625983602.git.christophe.jaillet@wanadoo.fr/=
).
> Would you mind if your patch goes through Herbert's tree?
> If you want I can also send a reworked version.

As patch #8 of my series depends on this one I think the best option is
to create a tag and pull that into both, the pci and the crypto tree?!

@Bjorn: Would you agree to this procedure? There has to be a v4, if it
helps I can provide a signed tag for pulling?! Just tell me what would
be helpful here.

> >  	if (pci_save_state(pdev)) {
> >  		dev_err(&pdev->dev, "Failed to save pci state.\n");
> > @@ -310,6 +306,7 @@ static struct pci_driver adf_driver =3D {
> >  	.probe =3D adf_probe,
> >  	.remove =3D adf_remove,
> >  	.sriov_configure =3D adf_sriov_configure,
> > +	.err_handler =3D adf_err_handler,
> Compilation fails here:
>     drivers/crypto/qat/qat_4xxx/adf_drv.c:309:24: error: =E2=80=98adf_err=
_handler=E2=80=99 undeclared here (not in a function)
>       309 |         .err_handler =3D adf_err_handler,
>           |                        ^~~~~~~~~~~~~~~
>=20
> Were you thinking to change it this way?
>=20
> 	--- a/drivers/crypto/qat/qat_common/adf_common_drv.h
> 	+++ b/drivers/crypto/qat/qat_common/adf_common_drv.h
> 	@@ -95,8 +95,11 @@ void adf_ae_fw_release(struct adf_accel_dev *accel_de=
v);
> 	 int adf_ae_start(struct adf_accel_dev *accel_dev);
> 	 int adf_ae_stop(struct adf_accel_dev *accel_dev);
>=20
> 	+extern const struct pci_error_handlers adf_err_handler;
>=20
> 	--- a/drivers/crypto/qat/qat_4xxx/adf_drv.c
> 	+++ b/drivers/crypto/qat/qat_4xxx/adf_drv.c
> 	@@ -306,7 +306,7 @@ static struct pci_driver adf_driver =3D {
> 		.probe =3D adf_probe,
> 		.remove =3D adf_remove,
> 		.sriov_configure =3D adf_sriov_configure,
> 	-       .err_handler =3D adf_err_handler,
> 	+       .err_handler =3D &adf_err_handler,
> 	 };

Yeah, the other three drivers need an adaption, too. I will send a v4 in
the next few days. The current state is available at

	https://git.pengutronix.de/git/ukl/linux pci-dedup

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nru7sdu6ylpnbz6f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmEUQioACgkQwfwUeK3K
7Anz8Af/SM6mdzhAVZbGFRqcWvlCSsJe3IKHavBmbozr+PbkfmOULWuZXj3pogJC
fWz09VVMMi8XlJy2P/qmFoTsoNrQK5bKPsinvTj9jQk7lywLFXooSHoEveB7Q7eI
VhZUw3DUZvYDliq0l5VGcAhNkQ2pjrW6D0o1AjR8o5mYArKA8o/j5pHjNqot2TC7
QN+UFsxKCoXCiZcX1g7XT3VS25QGVMUyrgz+5JT2809GJr6cE6qC7SX2Vo5A+Bfg
MGv/U6G4b7ZPkI55NXF8PMIrSDsNikN7R48nuaF3xqWYykt/AhkocY3jStrApO/9
yPk4hbE6+SqYkrfNlnzXwWXbbPqnWA==
=iuNF
-----END PGP SIGNATURE-----

--nru7sdu6ylpnbz6f--
