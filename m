Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB663C6A61
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jul 2021 08:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbhGMGT3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Jul 2021 02:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbhGMGT3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Jul 2021 02:19:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EC9C0613DD
        for <linux-pci@vger.kernel.org>; Mon, 12 Jul 2021 23:16:39 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m3Bid-00046w-2t; Tue, 13 Jul 2021 08:16:35 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m3Bib-0006NK-KT; Tue, 13 Jul 2021 08:16:33 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m3Bib-0000lC-JM; Tue, 13 Jul 2021 08:16:33 +0200
Date:   Tue, 13 Jul 2021 08:16:30 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        kernel@pengutronix.de, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: endpoint: Make struct pci_epf_driver::remove return
 void
Message-ID: <20210713061630.e3krhew2wumw4b7r@pengutronix.de>
References: <20210223090757.57604-1-u.kleine-koenig@pengutronix.de>
 <20210712205149.GA1675719@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="os7n47pn6x7hle2u"
Content-Disposition: inline
In-Reply-To: <20210712205149.GA1675719@bjorn-Precision-5520>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--os7n47pn6x7hle2u
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Bjorn,

On Mon, Jul 12, 2021 at 03:51:49PM -0500, Bjorn Helgaas wrote:
> On Tue, Feb 23, 2021 at 10:07:57AM +0100, Uwe Kleine-K=F6nig wrote:
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
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>=20
> Can you just include this with the rest of your series that depends on
> it, like you did for the s390 patches, so they're all together?

Yeah sure, will resend the complete series later today. I hesitated to
include the pci patch as I didn't know your plans for it and didn't want
to create a mess by interfering with your workflow.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--os7n47pn6x7hle2u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDtL7sACgkQwfwUeK3K
7AnOcQf/TScc2DQuPQp71PJVWshMNDHN61FzDQj1bbJ/UeXaFmLHOlT7As68t7+y
wg+TRjPYRMvTlEmTD8slN526pUFtWneCgjrSXQ5L9AFRyLJr/dchKJTqHA0m0jxF
6tiBIbG0wQ+DHq8JsoGtZU468kvhl/+4j3rB9Aq5BReN4mLseswQD7MO1X/6vqVM
CN3nuMAIqkBCXnCk/sAYYUuPZ5pYk74YpHC3AkrmEQVopNQWCVmUQG2SpJeyYDiv
st7FDmR9p9XBST/XfzxMplBHYxF9BsGpmYuh2JuzG8uqNrmfTiOQRJnnlwW35lxI
SxDB13coS1vlL+xk6SD1XcRE+lwyQQ==
=5bzd
-----END PGP SIGNATURE-----

--os7n47pn6x7hle2u--
