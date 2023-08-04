Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF47277068D
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 19:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjHDRBB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 13:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjHDRAv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 13:00:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788B849D8
        for <linux-pci@vger.kernel.org>; Fri,  4 Aug 2023 10:00:45 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qRyAH-00078o-PJ; Fri, 04 Aug 2023 19:00:37 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qRyAH-00173P-2f; Fri, 04 Aug 2023 19:00:37 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qRyAG-00ARCi-DV; Fri, 04 Aug 2023 19:00:36 +0200
Date:   Fri, 4 Aug 2023 19:00:10 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: mvebu: Mark driver as BROKEN
Message-ID: <20230804170010.2i2cq6xobsm4v4jt@pengutronix.de>
References: <20230114164125.1298-1-pali@kernel.org>
 <ZMzicVQEyHyZzBOc@shell.armlinux.org.uk>
 <20230804134622.pmbymxtzxj2yfhri@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b4vhtzr2bw75qlff"
Content-Disposition: inline
In-Reply-To: <20230804134622.pmbymxtzxj2yfhri@pengutronix.de>
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


--b4vhtzr2bw75qlff
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Aug 04, 2023 at 03:46:22PM +0200, Uwe Kleine-K=F6nig wrote:
> On Fri, Aug 04, 2023 at 12:35:13PM +0100, Russell King (Oracle) wrote:
> > So it seems this patch got applied, but it wasn't Cc'd to
> > linux-arm-kernel or anyone else, so those of us with platforms never
> > had a chance to comment on it.
> >=20
> > *** This change causes a regression to working setups. ***
> >=20
> > It appears that the *only* reason this patch was proposed is to stop a
> > kernel developer receiving problem reports from a set of users, but
> > completely ignores that there is another group of users where this works
> > fine - and thus the addition of this patch causes working setups to
> > regress.
> >=20
> > Because one is being bothered with problem reports is not a reason to
> > mark a driver broken - and especially not doing so in a way that those
> > who may be affected don't get an opportunity to comment on the patch!
> > Also, there is _zero_ information provided on what the reported problems
> > actually are, so no one else can guess what these issues are.
> >=20
> > However, given that there are working setups and this change causes
> > those to regress, it needs to be reverted.
> >=20
> > For example, I have an Atheros PCIe WiFi card in an Armada 388 Clearfog
> > platform, and this works fine.
> >=20
> > Uwe has a SATA controller for a bunch of disks in an Armada 370 based
> > NAS platform that is connected to PCIe, and removing PCIe support
> > effectively makes his platform utterly useless.
>=20
> While this is true there is really a problem on my platform with
> accessing the hard disks via that pci controller and a 88SE9215 SATA
> controller. While it seems to work in principle, it's incredible slow.
>=20
> I intend to bisect that, 6.1.x is still fine. Don't know when I find the
> time though, as there are a few things that are more important
> currently.

I did that and found next-20230803 to be bad but next-20230804 is good.
I didn't debug that further and didn't spot anything obvious in

	git log --oneline --no-merges --left-right next-20230803...next-20230804

=2E I will just assume the problem is gone for good.

So now I'm in the position to say: For me PCI_MVEBU works fine and so I
support Russell's request to revert
b3574f579ece24439c90e9a179742c61205fbcfa.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--b4vhtzr2bw75qlff
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmTNLpYACgkQj4D7WH0S
/k47HAgApIpya8HcrHL+AOy4FTK9Q0j45I4V/WcPab0kXN2zeFfSGm2IPx5VahZA
V8oqwnqSpCNitrA60k5nK8IhmOJdmIhQfH4LSac/E6kzcoSPKFpqnLdKtmaAxYwp
B9Vk3mPhD+zQ8F3IQfK0QMs6FAJ5mnM9gewzbubv9cpBeUQDAUm4kfnDhlzBcARl
oQ3CC/EL8gKCzHQbB1uCnMte2sP/40mfvZ4cqD+IYzCbU/tcYXWqJsrroBF9jiLW
41xItFkPJaJuqDT5NLx8CgHfPzTcJJqym2cDlgGeTFAnr1GqHsHjjxfv0EzqhDO2
BdGb83WUfqzI2AK0EsvnJUN0WAsowA==
=GoYW
-----END PGP SIGNATURE-----

--b4vhtzr2bw75qlff--
