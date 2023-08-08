Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6C1774947
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 21:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjHHTu7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 15:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbjHHTun (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 15:50:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385C853F12
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 09:56:38 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTHfF-00010w-4J; Tue, 08 Aug 2023 10:02:01 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTHfE-001vnq-B5; Tue, 08 Aug 2023 10:02:00 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTHfD-00BM3x-KD; Tue, 08 Aug 2023 10:01:59 +0200
Date:   Tue, 8 Aug 2023 10:01:59 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: Mark driver as BROKEN
Message-ID: <20230808080159.cjffiewenmazhrgx@pengutronix.de>
References: <ZMzicVQEyHyZzBOc@shell.armlinux.org.uk>
 <20230804170655.GA147757@bhelgaas>
 <20230808073154.bstm3xwtjalyq3qb@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mgpjqowvhmrri6dx"
Content-Disposition: inline
In-Reply-To: <20230808073154.bstm3xwtjalyq3qb@pali>
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


--mgpjqowvhmrri6dx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Pali,

On Tue, Aug 08, 2023 at 09:31:54AM +0200, Pali Roh=E1r wrote:
> On Friday 04 August 2023 12:06:55 Bjorn Helgaas wrote:
> > I queued up the revert below, including a note in the Kconfig help
> > text about the known issues.
> >=20
> > commit 814b6bb15367 ("Revert "PCI: mvebu: Mark driver as BROKEN"")
> > Author: Bjorn Helgaas <bhelgaas@google.com>
> > Date:   Fri Aug 4 11:54:43 2023 -0500
> >=20
> >     Revert "PCI: mvebu: Mark driver as BROKEN"
> >    =20
> >     b3574f579ece ("PCI: mvebu: Mark driver as BROKEN") made it impossib=
le to
> >     enable the pci-mvebu driver.  The driver does have known problems, =
but as
> >     Russell and Uwe reported, it does work in some configurations, so r=
emoving
> >     it broke some working setups.
> >    =20
> >     Revert b3574f579ece so pci-mvebu is available.  Mention the known p=
roblems
> >     in the Kconfig help text.
> >    =20
> >     Reported-by: Russell King (Oracle) <linux@armlinux.org.uk>
> >     Link: https://lore.kernel.org/r/ZMzicVQEyHyZzBOc@shell.armlinux.org=
=2Euk
> >     Reported-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >     Link: https://lore.kernel.org/r/20230804134622.pmbymxtzxj2yfhri@pen=
gutronix.de
> >     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >=20
>=20
> What you are trying to achieve with this patch now?

We all agree that there are problems with the pci-mvebu driver. But to
my knowledge it works in some configurations. So I guess the thing to
achieve here is to go from "broken for everyone" (with the driver
depending on BROKEN) to "broken for only some people". So in my view
it's an improvement.

> Do you think that it is really correct to show that everything is
> working for everybody correctly?

What makes you think Bjorn considers everything to work fine? Both the
commit log and the added help text suggest he's aware of problems.

> Now I'm starting understand why majority of HW industry say to not use
> "unsupported mainline kernel" and instead use our prepared patched
> kernels...

Yes, for a given company it's the easiest and cheapest option to just
support a single kernel version. In this regard the patch adding the
dependency on BROKEN is even worse than the commit that removes it
again. In an ideal world Marvell would care to work on the issues of
their hardware's drivers or at least provide enough documentation to the
folks who care about these drivers. I guess we both know we're not in
that ideal world.

I wonder what's your objective problem with this revert. You can just
keep PCI_MVEBU disabled, so it doesn't affect the machines you care
about.  You might get some mail with complaints that the driver is
broken in some configuration. But without this revert you might get
(more?) complaints that the driver cannot be enabled. Is that any
better?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mgpjqowvhmrri6dx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmTR9nYACgkQj4D7WH0S
/k6EsAgArknZlgr8MKKkmRRAH71tzcFrezhy1S30kumlnvqLMqcPOLTHe/HOjY1s
G9xI3WpFJ5O9Omec7KtyJ3gJdqFspwfyIHJs7s2KCBRuukrC4yyvZuND+83WbFBj
O4R6lnVrLgLSauNFhSb7hlsk4ODNiI8m8ukmc3FJvLA9+rWFZ0Df6RZmkMvVZX2u
NKTdSP6J8iUm7YMqfM5/nFCAzmBs32ABqNYFtZ9l/cYlF4cCTVpe2UuyFnojn50Z
S5ePMnmMuNx8SNfYuUWMWVuTfOFZxZ8lMVERs07ufPLnRiOaLv9KJAMTy8I/e+KN
bYXA4uSagQ+UoarA3OK1AVwvr0Ej2w==
=s6il
-----END PGP SIGNATURE-----

--mgpjqowvhmrri6dx--
