Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829B03EB26C
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 10:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239802AbhHMIQb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 04:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239798AbhHMIQa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Aug 2021 04:16:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4840C061756
        for <linux-pci@vger.kernel.org>; Fri, 13 Aug 2021 01:16:03 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mESM7-0008Fh-LI; Fri, 13 Aug 2021 10:15:55 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mESM3-0004xx-Ej; Fri, 13 Aug 2021 10:15:51 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mESM3-0001fU-DV; Fri, 13 Aug 2021 10:15:51 +0200
Date:   Fri, 13 Aug 2021 10:15:51 +0200
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
Message-ID: <20210813081551.7tmg777dmu34qkqz@pengutronix.de>
References: <20210811080637.2596434-1-u.kleine-koenig@pengutronix.de>
 <20210811080637.2596434-7-u.kleine-koenig@pengutronix.de>
 <YRO69xL+F/6Paj+I@silpixa00400314>
 <20210811213405.avihazo33irdjxic@pengutronix.de>
 <YRUzfQCLOtRmXyCr@silpixa00400314>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ex3zxap4roafumc2"
Content-Disposition: inline
In-Reply-To: <YRUzfQCLOtRmXyCr@silpixa00400314>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--ex3zxap4roafumc2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Giovanni,

On Thu, Aug 12, 2021 at 03:43:09PM +0100, Giovanni Cabiddu wrote:
> On Wed, Aug 11, 2021 at 11:34:05PM +0200, Uwe Kleine-K=F6nig wrote:
> > Yeah, the other three drivers need an adaption, too. I will send a v4 in
> > the next few days. The current state is available at
> >=20
> > 	https://git.pengutronix.de/git/ukl/linux pci-dedup
>=20
> I fixed that and tested on c62x. Here is an updated patch:

Apart from ordering in drivers/crypto/qat/qat_common/adf_common_drv.h
and some whitespace differences there is already an equivalent commit in
my branch.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ex3zxap4roafumc2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmEWKjMACgkQwfwUeK3K
7AndRgf/cKoQv7/fVI1Jac3BVBv5zRjbb2ti4Havmsg/+TC1QMk6me1V0uJnjyDb
XW+R229ldw7rn5JfyX/8iYacpsbWQOWozhJtqudZXTUHN8FBbQTnoI6RwQqIcfty
intHRB9m2b9s1RQRgGSvYH2m34dGVNDjwMyg/1qMXbdoC5CM9zcf4V1f3BEyCJge
Qkf1dSikH/c7X6eh7zQP/q9VTeNNQy1BR8uHJNThAp4LWukQ/zhpTjvRrFuobKLG
ZfdjtbLi4rwBfO6HaXbLOOizJpC08QB7rXNEPqR7H1gDcyTmFkcs17mZc3hl8x0B
Jq+RgGp4pzOt7Y1lmzVwHu116wXjTQ==
=P/nS
-----END PGP SIGNATURE-----

--ex3zxap4roafumc2--
