Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF22770222
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 15:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjHDNql (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 09:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjHDNqk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 09:46:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E18D1
        for <linux-pci@vger.kernel.org>; Fri,  4 Aug 2023 06:46:38 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qRv8J-00076E-Sz; Fri, 04 Aug 2023 15:46:23 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qRv8I-0015KZ-Rt; Fri, 04 Aug 2023 15:46:22 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qRv8I-00AObj-6p; Fri, 04 Aug 2023 15:46:22 +0200
Date:   Fri, 4 Aug 2023 15:46:22 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: mvebu: Mark driver as BROKEN
Message-ID: <20230804134622.pmbymxtzxj2yfhri@pengutronix.de>
References: <20230114164125.1298-1-pali@kernel.org>
 <ZMzicVQEyHyZzBOc@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vfvtft5lwqnwn7zx"
Content-Disposition: inline
In-Reply-To: <ZMzicVQEyHyZzBOc@shell.armlinux.org.uk>
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


--vfvtft5lwqnwn7zx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Cc +=3D linux-arm-kernel list]

On Fri, Aug 04, 2023 at 12:35:13PM +0100, Russell King (Oracle) wrote:
> So it seems this patch got applied, but it wasn't Cc'd to
> linux-arm-kernel or anyone else, so those of us with platforms never
> had a chance to comment on it.
>=20
> *** This change causes a regression to working setups. ***
>=20
> It appears that the *only* reason this patch was proposed is to stop a
> kernel developer receiving problem reports from a set of users, but
> completely ignores that there is another group of users where this works
> fine - and thus the addition of this patch causes working setups to
> regress.
>=20
> Because one is being bothered with problem reports is not a reason to
> mark a driver broken - and especially not doing so in a way that those
> who may be affected don't get an opportunity to comment on the patch!
> Also, there is _zero_ information provided on what the reported problems
> actually are, so no one else can guess what these issues are.
>=20
> However, given that there are working setups and this change causes
> those to regress, it needs to be reverted.
>=20
> For example, I have an Atheros PCIe WiFi card in an Armada 388 Clearfog
> platform, and this works fine.
>=20
> Uwe has a SATA controller for a bunch of disks in an Armada 370 based
> NAS platform that is connected to PCIe, and removing PCIe support
> effectively makes his platform utterly useless.

While this is true there is really a problem on my platform with
accessing the hard disks via that pci controller and a 88SE9215 SATA
controller. While it seems to work in principle, it's incredible slow.

I intend to bisect that, 6.1.x is still fine. Don't know when I find the
time though, as there are a few things that are more important
currently.

+1 on some information about what is already known about the breakage.

> Please revert this patch.
>=20
> Thanks.
>=20
> On Sat, Jan 14, 2023 at 05:41:25PM +0100, Pali Roh=E1r wrote:
> > People are reporting that pci-mvebu.c driver does not work with recent
> > mainline kernel. There are more bugs which prevents its for daily usage.
> > So lets mark it as broken for now, until somebody would be able to fix =
it
> > in mainline kernel.
> >=20
> > Signed-off-by: Pali Roh=E1r <pali@kernel.org>
> >=20
> > ---
> > Bjorn: I would really appreciate if you take this change and send it in
> > pull request for v6.2 release. There is no reason to wait more longer.
> >=20
> >=20
> > I'm periodically receiving emails that driver does not work correctly
> > anymore, PCIe cards are not detected or that they crashes during boot.
> >=20
> > Some of the issues are handled in patches which are waiting on the list=
 for
> > a long time and nobody cares for them. Some others needs investigation.
> >=20
> > I'm really tired in replying to those user emails as I cannot do more in
> > this area. I have asked more people for help but either there were only
> > promises without any action for more than year or simple no direction h=
ow
> > to move forward or what to do with it.
> >=20
> > So mark this driver as broken. Users would see the real current state
> > and hopefully will stop reporting me old or new bugs.
> > ---
> >  drivers/pci/controller/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kc=
onfig
> > index 1569d9a3ada0..b4a4d84a358b 100644
> > --- a/drivers/pci/controller/Kconfig
> > +++ b/drivers/pci/controller/Kconfig
> > @@ -9,6 +9,7 @@ config PCI_MVEBU
> >  	depends on MVEBU_MBUS
> >  	depends on ARM
> >  	depends on OF
> > +	depends on BROKEN
> >  	select PCI_BRIDGE_EMUL
> >  	help
> >  	 Add support for Marvell EBU PCIe controller. This PCIe controller
> > --=20
> > 2.20.1
> >=20
>=20
> --=20
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vfvtft5lwqnwn7zx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmTNAS0ACgkQj4D7WH0S
/k6FaQf+IWYBI0N+ARbt5MrMfaItxMntOXQyrWGRYsw4fnWc5zI2d/Zefbw/MnQe
L8aJQcgPdrq7FnW+nqzaE/WfqRhWbcucXCv9BkDhkoryAdD1qUj9WA0ZbuNrD0oz
+dGBV+0A0j17vF3ucP9k8eNt8h0NM6Kunrj+3X1uz3e6TBhjtFgHglTUsJB9CCal
xgUBp4zkvtyF4FgXr1Zmgf2VX7hfeNLphwb6WoNvUUCNjzj3XlnmCSc4xOs49Dyv
l9A9vT2MdS2J9Ini4HVHUwMU4FwVJ+wYpCI0uwy/NzKzE2Z4xBs7bsucQTv1Yjh+
JAB+rDgAQ0sKPzbof7QM0wfIwlQohQ==
=C6VD
-----END PGP SIGNATURE-----

--vfvtft5lwqnwn7zx--
