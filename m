Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A1741C3FD
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 13:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245721AbhI2MAZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 08:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245149AbhI2MAZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 08:00:25 -0400
X-Greylist: delayed 2642 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Sep 2021 04:58:44 PDT
Received: from bues.ch (bues.ch [IPv6:2a01:138:9005::1:4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EE3C06161C;
        Wed, 29 Sep 2021 04:58:43 -0700 (PDT)
Received: by bues.ch with esmtpsa (Exim 4.92)
        (envelope-from <m@bues.ch>)
        id 1mVXXn-0002kr-6z; Wed, 29 Sep 2021 13:14:35 +0200
Date:   Wed, 29 Sep 2021 13:13:48 +0200
From:   Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Christoph Hellwig <hch@lst.de>,
        linux-pci@vger.kernel.org, kernel@pengutronix.de,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v5 06/11] ssb: Simplify determination of driver name
Message-ID: <20210929131348.4259f79d@wiggum>
In-Reply-To: <20210929085306.2203850-7-u.kleine-koenig@pengutronix.de>
References: <20210929085306.2203850-1-u.kleine-koenig@pengutronix.de>
        <20210929085306.2203850-7-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CCfYodG4Q79G07r0GK6gWqX";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--Sig_/CCfYodG4Q79G07r0GK6gWqX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 29 Sep 2021 10:53:01 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> For all drivers that make use of ssb_pcihost_probe() (i.e.
> b43_pci_bridge_driver and b44_pci_driver) the driver name is set.
> As at the time for the function is called __pci_register_driver() already
> assigned drv->driver.name to hold the same value, use
> dev_driver_string() with the same result.
>=20
> This has the upside of not requiring the driver member of struct pci_dev
> which is about to be removed and being simpler.

>  	struct ssb_bus *ssb;
>  	int err =3D -ENOMEM;
> -	const char *name;
>  	u32 val;
> =20
>  	ssb =3D kzalloc(sizeof(*ssb), GFP_KERNEL);
> @@ -78,10 +77,7 @@ static int ssb_pcihost_probe(struct pci_dev *dev,
>  	err =3D pci_enable_device(dev);
>  	if (err)
>  		goto err_kfree_ssb;
> -	name =3D dev_name(&dev->dev);
> -	if (dev->driver && dev->driver->name)
> -		name =3D dev->driver->name;
> -	err =3D pci_request_regions(dev, name);
> +	err =3D pci_request_regions(dev, dev_driver_string(&dev->dev));
>  	if (err)
>  		goto err_pci_disable;
>  	pci_set_master(dev);

Makes sense.

Acked-by: Michael B=C3=BCsch <m@bues.ch>


--=20
Michael

https://bues.ch/

--Sig_/CCfYodG4Q79G07r0GK6gWqX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmFUSmwACgkQ9TK+HZCN
iw4Lug/9HzQ/VJXDIfK8OXK9XTTMvFBkkqFYZpy1+AqlA8U7plSBraAQ7f4RyfF7
9CCwMq+pu7ufranUiqZpj8mSf+ibDZdvcl09votMb0Z2Z0/CZ9SGMI/Y1SXJHoFl
6QStGfhD3Pjc3XMYvUI6rEqzcqlN3tjieRPAE6PY2vnCf3i2UyKuQoVc0z4x7fL0
I8eOdV/nR7PR+bRYoItfi4e5sjc0XL9ZUAC2BXs5gUedQKW8KX9zvOROAxA2bHHM
/GEmIVr2kjgir0oTjs8jS44GHE9MxCQI4gli0c26IkfF4djaqOKhTSgmo05fj5QF
TyjJZj6DGaZ69Al1XUac55GbYmY4LD6bqvgeHjJ6UvazGsWWchcLP2Cf4RO+lQKZ
CxZy/Qr9IVlsMJqdyhkDtA6rsPt7UjCp+AVoX9v/fJEQbig7M8dEVAktDhgWyxq9
6mFFnypRS7k3qAfMaaLNoBeAxCPEG69HtZ4Qb/aw9rg00aYKQsN/Q+DRQdRx9NjF
S0k6EU5b88qbRlInS//JSgl/ucv16jXwadk2I9aGoXZ1HtCJcEZzYMaE7f6bg9O6
3b91zqG+Fo2Dn9vl8aFNKQF70yuDPvosyIGbH3bpQQaP5CpS2KZxDNap5+V5zeFe
4PuTkpbBnV9nDx38WVYY0rWWc7CAm6j30G4QJICxzKkbF7Y8tbo=
=IWi9
-----END PGP SIGNATURE-----

--Sig_/CCfYodG4Q79G07r0GK6gWqX--
