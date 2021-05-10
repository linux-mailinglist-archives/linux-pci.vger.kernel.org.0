Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7463797AF
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 21:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbhEJT1z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 15:27:55 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:37202 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbhEJT1y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 May 2021 15:27:54 -0400
Received: from antares.kleine-koenig.org (localhost [127.0.0.1])
        by antares.kleine-koenig.org (Postfix) with ESMTP id 5E5EDB92AB4;
        Mon, 10 May 2021 21:26:48 +0200 (CEST)
Received: from antares.kleine-koenig.org ([94.130.110.236])
        by antares.kleine-koenig.org (antares.kleine-koenig.org [94.130.110.236]) (amavisd-new, port 10024)
        with ESMTP id zKva0nhGS63X; Mon, 10 May 2021 21:26:47 +0200 (CEST)
Received: from taurus.defre.kleine-koenig.org (unknown [IPv6:2a02:8071:b5c8:7bfc:751d:682d:7359:e261])
        by antares.kleine-koenig.org (Postfix) with ESMTPSA;
        Mon, 10 May 2021 21:26:47 +0200 (CEST)
Subject: Re: [PATCH] PCI: endpoint: Make struct pci_epf_driver::remove return
 void
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel@pengutronix.de
References: <20210223090757.57604-1-u.kleine-koenig@pengutronix.de>
From:   =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Message-ID: <1195e3d6-e2ca-f54b-aa09-289dbebd85d7@kleine-koenig.org>
Date:   Mon, 10 May 2021 21:26:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210223090757.57604-1-u.kleine-koenig@pengutronix.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eKmgG8MDQl3zCTFoDfMWmRbzl3FI1fGxv"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eKmgG8MDQl3zCTFoDfMWmRbzl3FI1fGxv
Content-Type: multipart/mixed; boundary="lG9miLKDPwfCV9NdH4OaVuAYE7nZsIgr5";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Kishon Vijay Abraham I <kishon@ti.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 kernel@pengutronix.de
Message-ID: <1195e3d6-e2ca-f54b-aa09-289dbebd85d7@kleine-koenig.org>
Subject: Re: [PATCH] PCI: endpoint: Make struct pci_epf_driver::remove return
 void
References: <20210223090757.57604-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20210223090757.57604-1-u.kleine-koenig@pengutronix.de>

--lG9miLKDPwfCV9NdH4OaVuAYE7nZsIgr5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2/23/21 10:07 AM, Uwe Kleine-K=C3=B6nig wrote:
> The driver core ignores the return value of pci_epf_device_remove()
> (because there is only little it can do when a device disappears) and
> there are no pci_epf_drivers with a remove callback.
>=20
> So make it impossible for future drivers to return an unused error code=

> by changing the remove prototype to return void.
>=20
> The real motivation for this change is the quest to make struct
> bus_type::remove return void, too.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Ping! This patch now waits for more than 2 months on feedback (or=20
application). The 5.13 merge window just closed, this is a great=20
opportunity to apply this patch for next.

Thanks for consideration,
Uwe

> ---
>   drivers/pci/endpoint/pci-epf-core.c | 5 ++---
>   include/linux/pci-epf.h             | 2 +-
>   2 files changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint=
/pci-epf-core.c
> index 7646c8660d42..a19c375f9ec9 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -389,15 +389,14 @@ static int pci_epf_device_probe(struct device *de=
v)
>  =20
>   static int pci_epf_device_remove(struct device *dev)
>   {
> -	int ret =3D 0;
>   	struct pci_epf *epf =3D to_pci_epf(dev);
>   	struct pci_epf_driver *driver =3D to_pci_epf_driver(dev->driver);
>  =20
>   	if (driver->remove)
> -		ret =3D driver->remove(epf);
> +		driver->remove(epf);
>   	epf->driver =3D NULL;
>  =20
> -	return ret;
> +	return 0;
>   }
>  =20
>   static struct bus_type pci_epf_bus_type =3D {
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index 6833e2160ef1..f8a17b6b1d31 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -85,7 +85,7 @@ struct pci_epf_ops {
>    */
>   struct pci_epf_driver {
>   	int	(*probe)(struct pci_epf *epf);
> -	int	(*remove)(struct pci_epf *epf);
> +	void	(*remove)(struct pci_epf *epf);
>  =20
>   	struct device_driver	driver;
>   	struct pci_epf_ops	*ops;
>=20



--lG9miLKDPwfCV9NdH4OaVuAYE7nZsIgr5--

--eKmgG8MDQl3zCTFoDfMWmRbzl3FI1fGxv
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCZiO0ACgkQwfwUeK3K
7AndhQf/ZY+A9Tjf8UanAXIZC1kmpC4JjBPrhtPKxV3as6RUspWYkJZk+zsE7YOb
SgqoZNVyMBmErL9OZ52u8eR5uxHcGAgvipRJkUS6jVUrhF0lLnELMs0AAbcOQ43x
Lml8Dc72rQ1nPqUsZmDzJKLTzcc2pOOU9HsuJb3gC0J6ysU0HchgDRoUlTGCzZjc
91gu+rpTuKrmPOWVWmBw3eZrSDjI/9dYktFqSdnE/6CCqXRMeaveXCuNdAFR6TUF
SR5NrYC9giqgW/ko+QpH8VSXb17eGhduIlMMlDi7a0GyWYK8OZIGsDVutJYejM7o
zmHQeyJaMhojhMHmyRM2PoGGv4g4zQ==
=lplD
-----END PGP SIGNATURE-----

--eKmgG8MDQl3zCTFoDfMWmRbzl3FI1fGxv--
