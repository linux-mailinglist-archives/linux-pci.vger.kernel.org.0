Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8A977493F
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 21:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjHHTuh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 15:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjHHTuW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 15:50:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D971EA2B9
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 09:56:47 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTHIO-0006g7-0w; Tue, 08 Aug 2023 09:38:24 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTHIM-001vlU-W3; Tue, 08 Aug 2023 09:38:23 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTHIM-00BLuB-9u; Tue, 08 Aug 2023 09:38:22 +0200
Date:   Tue, 8 Aug 2023 09:38:22 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: mvebu: Mark driver as BROKEN
Message-ID: <20230808073822.35vlao5bs6bo2b2n@pengutronix.de>
References: <20230114164125.1298-1-pali@kernel.org>
 <ZMzicVQEyHyZzBOc@shell.armlinux.org.uk>
 <20230804134622.pmbymxtzxj2yfhri@pengutronix.de>
 <20230808072701.gx6apjnnrppv7sit@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mfde7qneidzydtp6"
Content-Disposition: inline
In-Reply-To: <20230808072701.gx6apjnnrppv7sit@pali>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--mfde7qneidzydtp6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Pali,

On Tue, Aug 08, 2023 at 09:27:01AM +0200, Pali Roh=E1r wrote:
> On Friday 04 August 2023 15:46:22 Uwe Kleine-K=F6nig wrote:
> > On Fri, Aug 04, 2023 at 12:35:13PM +0100, Russell King (Oracle) wrote:
> > > Uwe has a SATA controller for a bunch of disks in an Armada 370 based
> > > NAS platform that is connected to PCIe, and removing PCIe support
> > > effectively makes his platform utterly useless.
> >=20
> > While this is true there is really a problem on my platform with
> > accessing the hard disks via that pci controller and a 88SE9215 SATA
> > controller. While it seems to work in principle, it's incredible slow.
>=20
> Exactly those are things which randomly does not work.

I had this slow behaviour consistently on next-20230803 and
next-20230804 was fine. I thought that meant that there was something
fixed between these two trees. Do you suggest this is worth to
investigate as it might just be some butterfly effect that made the
problem go away?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mfde7qneidzydtp6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmTR8O0ACgkQj4D7WH0S
/k6I7ggAkvBg/yZHZHb90BJ38qJPf5cSgepg4MYV9kJ6MpxCNencGfuxH7UEFM7t
IWKYzkNKBdz1eKskT5A4CHUoTJuiyNeZWNtarbL+DN8i4T2M7boyF5DjXlkYQvP9
aFxs85BvugFvSaU1GqvxR1y5SgZZg7oJyGh+h6jFL4nS1NRokAwjAYh42zDROVfF
EtxhrulOZjHx+qJDMb6Xow4BCyidTl7JJqW76jSvhu4lT5yn0HkOFWLr9VhF/bcY
t0H/tnjggfbMqIOaOTAseZ4BN3Tsify5M4Jfjkql/1r0B+xC13pxF7Z1IfbNOoVa
e2x5Pnr7y3dnC4VYsBBD9LjPbp4plw==
=xwD8
-----END PGP SIGNATURE-----

--mfde7qneidzydtp6--
