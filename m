Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9003748EA
	for <lists+linux-pci@lfdr.de>; Wed,  5 May 2021 21:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbhEETy4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 May 2021 15:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhEETyz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 May 2021 15:54:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0E3C061574
        for <linux-pci@vger.kernel.org>; Wed,  5 May 2021 12:53:58 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1leNak-0005GD-1G; Wed, 05 May 2021 21:53:54 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1leNai-0004e9-IO; Wed, 05 May 2021 21:53:52 +0200
Date:   Wed, 5 May 2021 21:53:52 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@pengutronix.de, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: Make struct pci_epf_driver::remove return
 void
Message-ID: <20210505195352.bftxkdjixcv2kfkh@pengutronix.de>
References: <20210223090757.57604-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cp2qzfqmbhed7tas"
Content-Disposition: inline
In-Reply-To: <20210223090757.57604-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--cp2qzfqmbhed7tas
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Feb 23, 2021 at 10:07:57AM +0100, Uwe Kleine-K=F6nig wrote:
> The driver core ignores the return value of pci_epf_device_remove()
> (because there is only little it can do when a device disappears) and
> there are no pci_epf_drivers with a remove callback.
>=20
> So make it impossible for future drivers to return an unused error code
> by changing the remove prototype to return void.
>=20
> The real motivation for this change is the quest to make struct
> bus_type::remove return void, too.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

ping! I didn't hear anything on this patch. Is it still one someone's
list of patches to review?

Best regards
Uwe

> ---
>  drivers/pci/endpoint/pci-epf-core.c | 5 ++---
>  include/linux/pci-epf.h             | 2 +-
>  2 files changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/p=
ci-epf-core.c
> index 7646c8660d42..a19c375f9ec9 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -389,15 +389,14 @@ static int pci_epf_device_probe(struct device *dev)
> =20
>  static int pci_epf_device_remove(struct device *dev)
>  {
> -	int ret =3D 0;
>  	struct pci_epf *epf =3D to_pci_epf(dev);
>  	struct pci_epf_driver *driver =3D to_pci_epf_driver(dev->driver);
> =20
>  	if (driver->remove)
> -		ret =3D driver->remove(epf);
> +		driver->remove(epf);
>  	epf->driver =3D NULL;
> =20
> -	return ret;
> +	return 0;
>  }
> =20
>  static struct bus_type pci_epf_bus_type =3D {
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index 6833e2160ef1..f8a17b6b1d31 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -85,7 +85,7 @@ struct pci_epf_ops {
>   */
>  struct pci_epf_driver {
>  	int	(*probe)(struct pci_epf *epf);
> -	int	(*remove)(struct pci_epf *epf);
> +	void	(*remove)(struct pci_epf *epf);
> =20
>  	struct device_driver	driver;
>  	struct pci_epf_ops	*ops;
> --=20
> 2.30.0
>=20
>=20
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cp2qzfqmbhed7tas
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCS980ACgkQwfwUeK3K
7AmhXAf+Liqnn+913/b5s5Jo1rdHeXgrGeP66aLurxjNUqYKNTCT9KPTy+DOqLg8
kahZwdGwcnx4tmAilqyKcX70XGnu4Mt+VjTmD+6Q2yCd2RtcJnlASxhVC0SIgpf1
l+kHG4pC9dY4PDTaOVJ+kQx+BH4t1CaCUMRrsIL/172cN3f3dbuJSx6+6ASrg06m
FE9+AfFxewe52nEB23DlBrfmkGgEnDWAdWpRQm2yOZ3StawF6r2pyPzXSS2puy/N
unT5exJm2XPKGKkEPr9jsyKMpA5hVGOH2ivXpi/anffYE2J/V2UGAEnLCi1q/PHs
BpE7fRhpAftzsa8h/g7tdlmsyIy2zw==
=t4Fq
-----END PGP SIGNATURE-----

--cp2qzfqmbhed7tas--
