Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9CB7F1FBC
	for <lists+linux-pci@lfdr.de>; Mon, 20 Nov 2023 22:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjKTVtg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Nov 2023 16:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbjKTVtV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Nov 2023 16:49:21 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28961BD6
        for <linux-pci@vger.kernel.org>; Mon, 20 Nov 2023 13:47:02 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r5C6e-0000vs-If; Mon, 20 Nov 2023 22:47:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r5C6e-00ARDp-2d; Mon, 20 Nov 2023 22:47:00 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r5C6d-004ekA-PB; Mon, 20 Nov 2023 22:46:59 +0100
Date:   Mon, 20 Nov 2023 22:46:59 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        kernel@pengutronix.de, Bjorn Helgaas <bhelgaas@google.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] PCI: host-generic: Convert to platform remove callback
 returning void
Message-ID: <20231120214659.2k46266jk2xg564p@pengutronix.de>
References: <20231120212224.txokceaqze76zqjd@pengutronix.de>
 <20231120213007.GA216418@bhelgaas>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ekra2d2foet446rq"
Content-Disposition: inline
In-Reply-To: <20231120213007.GA216418@bhelgaas>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--ekra2d2foet446rq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Bjorn,

On Mon, Nov 20, 2023 at 03:30:07PM -0600, Bjorn Helgaas wrote:
> On Mon, Nov 20, 2023 at 10:22:24PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Fri, Oct 20, 2023 at 11:21:07AM +0200, Uwe Kleine-K=F6nig wrote:
> > > The .remove() callback for a platform driver returns an int which mak=
es
> > > many driver authors wrongly assume it's possible to do error handling=
 by
> > > returning an error code.  However the value returned is (mostly) igno=
red
> > > and this typically results in resource leaks. To improve here there i=
s a
> > > quest to make the remove callback return void. In the first step of t=
his
> > > quest all drivers are converted to .remove_new() which already returns
> > > void.
> > >=20
> > > pci_host_common_remove() returned zero unconditionally. With that
> > > converted to return void instead, the generic pci host driver can be
> > > switched to .remove_new trivially.
> > >=20
> > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >=20
> > who feels responsible to apply this patch?
>=20
> If you're ready to rename .remove_new() back to .remove(), you can
> include this as part of that series with my ack:
>=20
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>=20
> Or we can take it via the PCI tree for v6.8.

The idea is that all drivers are converted to .remove_new() before
changing .remove() to return void. This way the commit changing struct
platform_driver doesn't has to touch the 1000+ platform drivers. So if
you take this patch via pci in the next merge window, that would be
good.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ekra2d2foet446rq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVb09IACgkQj4D7WH0S
/k7xagf+KTmBKRd8APlTYzALLv9Mdfwh6oAfCKVUFGDmk/QC1hL/ZjwaD6SXoJrI
uimyZz9+TBZ7zEr83ZwkIuFqNmqWFH53hyIkUuD4eU3YToYD3/wPzUwm9qvnZ3Np
V60QETtsFCOv5yGDgRAtwXBe0hxNcoSX5c89H+SiUVW4BYyD/Mmp8lZcg7yb7xqO
dygpeRTPtAWS3Yg38TKaRAonFBGSYtZocnffy5ZSFy6ovN6ms10gp2mI8usEhPqd
9M6nQAbGl+srBXrepCJztGWsI2XvoUTAWPdQ/9NUPY9bWeuzpvNRIofvoAwRVkVF
UTUOQT3vJXY4FZ+sl5jpDsCSGalKnw==
=48Dq
-----END PGP SIGNATURE-----

--ekra2d2foet446rq--
