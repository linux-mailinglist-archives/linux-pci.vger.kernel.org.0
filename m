Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D803DB2C1
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 07:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhG3FYh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jul 2021 01:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhG3FYh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jul 2021 01:24:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDAAC061765
        for <linux-pci@vger.kernel.org>; Thu, 29 Jul 2021 22:24:32 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m9L0Y-0003kE-Bu; Fri, 30 Jul 2021 07:24:30 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m9L0X-0004Ug-8e; Fri, 30 Jul 2021 07:24:29 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m9L0X-0005HG-7Y; Fri, 30 Jul 2021 07:24:29 +0200
Date:   Fri, 30 Jul 2021 07:24:26 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel@pengutronix.de
Subject: Re: [PATCH v1 5/5] PCI: Drop duplicated tracking of a pci_dev's
 bound driver
Message-ID: <20210730052426.2zmjy62y3ipanad6@pengutronix.de>
References: <20210729203740.1377045-1-u.kleine-koenig@pengutronix.de>
 <20210729203740.1377045-6-u.kleine-koenig@pengutronix.de>
 <YQOKs8Lsk8Rej5W2@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="phlwxzdds552wtgf"
Content-Disposition: inline
In-Reply-To: <YQOKs8Lsk8Rej5W2@kroah.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--phlwxzdds552wtgf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 30, 2021 at 07:14:27AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Jul 29, 2021 at 10:37:40PM +0200, Uwe Kleine-K=F6nig wrote:
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> I know I can not take patches without any changelog text, maybe other
> maintainers are more lax :(

Ah right, I admit to not invest much car here, mainly because I
didn't expect that this patch makes it in very soon as there are many
maintainers involved in the patches this one depends on.

I'd write something like:

Currently it's tracked twice which driver is bound to a given pci
device. Now that all users of the pci specific one (struct
pci_dev::driver) are updated to use an access macro
(pci_driver_of_dev()), change the macro to use the information from the
driver core and remove the driver member from struct pci_dev.

Best regards
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--phlwxzdds552wtgf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmEDjQcACgkQwfwUeK3K
7AkIAwgAg5coNmR58cADfISGJ2q9chA4KGnvJrW5luj5JQ6RdOA4vnjM5Jb86f/F
dvHD4ylapg3jilgHW+RjuZkFZnl2MmS0lKRtUt534HIftI8/v3OelklzmGW4r5us
JkUx0G12V2HCiHaVIkk3sUAnk/ufnK590GcIG/DuXRmBIyNG5o7O0jePaDxEQHEK
0NDXz/lx+dGxqpAhrPschr/QjW14IL+VkZ0u1vwHK6bjw0uV/ZHUwg9oJJt60+fs
0uh7S+X47T2G7ymQlbst4gTCDAeISEoqz6d0AjC4auULJ/vt1qQJekGIvZpk3LTq
pbYfa1pQwoce2U8yVUzlF/up6Ln0XA==
=uAqJ
-----END PGP SIGNATURE-----

--phlwxzdds552wtgf--
