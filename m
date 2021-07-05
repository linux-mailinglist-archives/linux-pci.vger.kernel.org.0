Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D923BC12F
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jul 2021 17:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhGEPtf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jul 2021 11:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbhGEPtf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jul 2021 11:49:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CF9C061574
        for <linux-pci@vger.kernel.org>; Mon,  5 Jul 2021 08:46:58 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m0QoA-0005vo-Qd; Mon, 05 Jul 2021 17:46:54 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m0QoA-0003ZS-0C; Mon, 05 Jul 2021 17:46:54 +0200
Date:   Mon, 5 Jul 2021 17:46:50 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@pengutronix.de, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: Make struct pci_epf_driver::remove return
 void
Message-ID: <20210705154650.roeaqika5ptknrnt@pengutronix.de>
References: <20210223090757.57604-1-u.kleine-koenig@pengutronix.de>
 <2a12ff97-a916-d70e-9e5b-b796e9c58288@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="godrklbzgejy4bt2"
Content-Disposition: inline
In-Reply-To: <2a12ff97-a916-d70e-9e5b-b796e9c58288@ti.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--godrklbzgejy4bt2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Jun 22, 2021 at 03:29:27PM +0530, Kishon Vijay Abraham I wrote:
> On 23/02/21 2:37 pm, Uwe Kleine-K=F6nig wrote:
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
> Fine with this change!
>=20
> FWIW:
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

Thanks for the ack. How can I expect this patch to go into mainline now?
Will Bjorn pick it up now that you acked?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--godrklbzgejy4bt2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDjKWYACgkQwfwUeK3K
7Amc7QgAiIy+wjl/dynWfO5IzkjtZ4nfZppBMSMXgGWEkNZa31N47lrmmQhPV/eD
CLEW+vU6KUPVfRTdRpByaSuO9oJlbxTY1oqKMYCW1IPZPo057ExzqAc0WZqByvIV
lVqUnn22Cvua0DAMy4vgKug76CbDwDAvWNMDmGNIbwwvsYVG9/C/CuEFeWuNPoWt
JrGpRIdRWszd555oF//UMVfj5FijAPyqkF9axiVQfqC0zMtnR45GWBSzHzKLL9OM
7IeDRkyp474Qzcv+H8VranpfdRwR/8x3dVIB6utCNfDIKv7wUFPYK/xldV021/f0
RTndK+WDBA7oLKBy5paHSMyvSU7ioQ==
=S80+
-----END PGP SIGNATURE-----

--godrklbzgejy4bt2--
