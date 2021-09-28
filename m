Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A228741B167
	for <lists+linux-pci@lfdr.de>; Tue, 28 Sep 2021 15:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241193AbhI1N6x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 09:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241014AbhI1N6x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Sep 2021 09:58:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9112C06161C
        for <linux-pci@vger.kernel.org>; Tue, 28 Sep 2021 06:57:13 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mVDbZ-0006bj-Na; Tue, 28 Sep 2021 15:57:09 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mVDbU-00039U-I2; Tue, 28 Sep 2021 15:57:04 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mVDbU-0004fU-Gf; Tue, 28 Sep 2021 15:57:04 +0200
Date:   Tue, 28 Sep 2021 15:57:04 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     Fiona Trahe <fiona.trahe@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Marco Chiappero <marco.chiappero@intel.com>,
        linux-pci@vger.kernel.org, qat-linux@intel.com,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-crypto@vger.kernel.org, kernel@pengutronix.de,
        Jack Xu <jack.xu@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Tomaszx Kowalik <tomaszx.kowalik@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v4 6/8] crypto: qat - simplify adf_enable_aer()
Message-ID: <20210928135704.oqyffwwt4lvmmlx3@pengutronix.de>
References: <20210927204326.612555-1-uwe@kleine-koenig.org>
 <20210927204326.612555-7-uwe@kleine-koenig.org>
 <YVL4aoKjUT2kvHip@silpixa00400314>
 <20210928112637.kolit6fusme7g2qf@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="apvqrcqw3egzs47r"
Content-Disposition: inline
In-Reply-To: <20210928112637.kolit6fusme7g2qf@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--apvqrcqw3egzs47r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Sep 28, 2021 at 01:26:37PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Tue, Sep 28, 2021 at 12:11:38PM +0100, Giovanni Cabiddu wrote:
> > On Mon, Sep 27, 2021 at 10:43:24PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > >=20
> > > A struct pci_driver is supposed to be constant and assigning .err_han=
dler
> > > once per bound device isn't really sensible. Also as the function ret=
urns
> > > zero unconditionally let it return no value instead and simplify the
> > > callers accordingly.
> > >=20
> > > As a side effect this removes one user of struct pci_dev::driver. This
> > > member is planned to be removed.
> > >=20
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > > ---
> >=20
> > this patch does not build.
> >=20
> > drivers/crypto/qat/qat_c3xxx/adf_drv.c:36:24: error: =E2=80=98adf_err_h=
andler=E2=80=99 undeclared here (not in a function)
> >    36 |         .err_handler =3D adf_err_handler,
> >       |                        ^~~~~~~~~~~~~~~
> > drivers/crypto/qat/qat_4xxx/adf_drv.c:303:24: error: =E2=80=98adf_err_h=
andler=E2=80=99 undeclared here (not in a function)
> >   303 |         .err_handler =3D adf_err_handler,
> >       |                        ^~~~~~~~~~~~~~~
> > drivers/crypto/qat/qat_c62x/adf_drv.c:36:24: error: =E2=80=98adf_err_ha=
ndler=E2=80=99 undeclared here (not in a function)
> >    36 |         .err_handler =3D adf_err_handler,
> >       |                        ^~~~~~~~~~~~~~~
> > drivers/crypto/qat/qat_dh895xcc/adf_drv.c:36:24: error: =E2=80=98adf_er=
r_handler=E2=80=99 undeclared here (not in a function)
> >    36 |         .err_handler =3D adf_err_handler,
> >       |                        ^~~~~~~~~~~~~~~
> > make[2]: *** [scripts/Makefile.build:277: drivers/crypto/qat/qat_c3xxx/=
adf_drv.o] Error 1
>=20
> Hmm, I thought that was one of the things I actually tested after
> rebasing. Will recheck.

I fixed it now, comparing with your patch the only thing I did
differently is ordering in the header file.

I pushed the fixed series to

	https://git.pengutronix.de/git/ukl/linux pci-dedup

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--apvqrcqw3egzs47r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFTHy0ACgkQwfwUeK3K
7AkFrggAllDiubJuF+ASqh0qKozM8Cz38KFhLmvfAIndUs/P6V5ob4TlWSuAsmzj
Bml1dlpDGTCEh0ocGFdDaT8RrptIrzwj7LJ9S3VRkuvL9OYlX8JG8HcKegYt8g44
aYu0Zzb5pklbLRs3juFBZ5gnGOJ6IaaRdRbzF9yM31wQVqYaXLhRae65lFDXmasu
JF8eJ9rMEIOL6io/WUM8OeocyE4clkw9XgSnrKBHeOAQZNsJoyQONkBkAN72pWeZ
ZP+pJICLTaBcoPUvOALZ9cWnazKxPHxAYPaF5JZWZs8T+JzfjInDD4DwYFFGjyA+
x2F7QAmL/BBslfeeDOu6BguemuYzQw==
=qq0w
-----END PGP SIGNATURE-----

--apvqrcqw3egzs47r--
