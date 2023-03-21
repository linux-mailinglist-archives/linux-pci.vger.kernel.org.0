Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE946C3C70
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 22:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjCUVIk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 17:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjCUVIj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 17:08:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF7E10A88
        for <linux-pci@vger.kernel.org>; Tue, 21 Mar 2023 14:08:38 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pejDg-0005Lj-E5; Tue, 21 Mar 2023 22:08:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pejDd-005lnH-9C; Tue, 21 Mar 2023 22:08:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pejDc-006rts-GH; Tue, 21 Mar 2023 22:08:32 +0100
Date:   Tue, 21 Mar 2023 22:08:31 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        kernel@pengutronix.de, Rob Herring <robh@kernel.org>,
        linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/15] PCI: aardvark: Convert to platform remove callback
 returning void
Message-ID: <20230321210831.h2asxfs5h7deh6eo@pengutronix.de>
References: <20230321193208.366561-1-u.kleine-koenig@pengutronix.de>
 <20230321193208.366561-2-u.kleine-koenig@pengutronix.de>
 <20230321193604.7iopueamqtaqrlfi@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xx7x3gdaqvj4xhmh"
Content-Disposition: inline
In-Reply-To: <20230321193604.7iopueamqtaqrlfi@pali>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--xx7x3gdaqvj4xhmh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 21, 2023 at 08:36:04PM +0100, Pali Roh=E1r wrote:
> On Tuesday 21 March 2023 20:31:54 Uwe Kleine-K=F6nig wrote:
> > The .remove() callback for a platform driver returns an int which makes
> > many driver authors wrongly assume it's possible to do error handling by
> > returning an error code. However the value returned is (mostly) ignored
> > and this typically results in resource leaks. To improve here there is a
> > quest to make the remove callback return void. In the first step of this
> > quest all drivers are converted to .remove_new() which already returns
> > void.
> >=20
> > Trivially convert this driver from always returning zero in the remove
> > callback to the void returning variant.
>=20
> There are more important fixes for this driver waiting on the list, so I
> do not see reason for sending such unimportant change for this driver
> which does not fix any issue. I would suggest to put this change at the
> end of the pending queue of aardvark patches to prevent any rebasing of
> the important fixes patches and possible merge conflicts.

I read some frustration out of your reply. However I don't think I'm to
blame for anything here. A recommendation to check floating patches on
the respective mailing list before sending out a patch would be news to
me, and I'd consider such a requirement a too big burden on submitters.

Browsing a bit in the linux-pci archives I see I'm not the first to get
a similar reply by you[1]. For me as a contributor who rarely does PCI
stuff such a feedback is not exactly welcoming and I'd wish for me and
others a more friendly interaction. Instead of calling other people's
patches unimportant and blaming them for sending cleanup patches, I
suggest you resend the patches you care about and highlight why they are
important. At least if I were the responsible maintainer, you'd have
more success with such a strategy.

Having said that, I don't have a problem if the aardvark patch is
postponed in favour of some more important changes. If a conflict occurs
during application, I happily adapt my patch and send it at a later
time. In such a case, just tell me, ideally by making the problem
reproduce on next.

Best regards
Uwe

[1] I found:
	https://lore.kernel.org/linux-pci/20221207075750.6usm4mgejtpcrktw@pali/
	https://lore.kernel.org/linux-pci/20221216182524.s6a4uihgavji7bti@pali/

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xx7x3gdaqvj4xhmh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQaHM4ACgkQj4D7WH0S
/k4Yggf/bwi0GO0DkiYoYsjFRx0e2Y7so/J1VCmitipBVN3mSusygJR3QOFlnD+y
P8tEFFNVhZsT3Oqw69qgnkuIMHmJ0+Z3zkjpWVtSKtH5+55M7EO1PQqetBOGqWIE
0SlWPr9shwLMTE0SbsYxOAgA6tQvo2MjLJznbHi66exPZo4k0BIARMZt5+bNmO8O
QJSBPpfeYxqfJJN20Krn7lsRNvAmm6XlhOBB+p3v0vH9Eciwf75Y+OXc3TvlMGFR
nqzU9Kj0f44Rw7hkJmjjPoKChZusSIfFTTs8IAJ380vtTFp9FTPQ8VeaSNyXrgSH
Bg79hoLWYQZyFfKlUghtn1jLJaPdfg==
=7fdZ
-----END PGP SIGNATURE-----

--xx7x3gdaqvj4xhmh--
