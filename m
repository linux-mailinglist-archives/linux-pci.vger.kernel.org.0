Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4894C7B79E0
	for <lists+linux-pci@lfdr.de>; Wed,  4 Oct 2023 10:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjJDIQs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Oct 2023 04:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJDIQs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Oct 2023 04:16:48 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1D283
        for <linux-pci@vger.kernel.org>; Wed,  4 Oct 2023 01:16:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qnx3j-0002mw-6L; Wed, 04 Oct 2023 10:16:43 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qnx3e-00Ayys-Vp; Wed, 04 Oct 2023 10:16:38 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qnx3e-008s3A-MV; Wed, 04 Oct 2023 10:16:38 +0200
Date:   Wed, 4 Oct 2023 10:16:38 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        kernel@pengutronix.de, Xiaowei Song <songxiaowei@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/4] PCI: kirin: Don't put .remove callback in .exit.text
 section
Message-ID: <20231004081638.uirgtb2z2wgcwito@pengutronix.de>
References: <20231003202330.zsmqckgbk2wbhvos@pengutronix.de>
 <20231003204056.GA687507@bhelgaas>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l3alnz67jfv6mrxi"
Content-Disposition: inline
In-Reply-To: <20231003204056.GA687507@bhelgaas>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--l3alnz67jfv6mrxi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Bjorn,

On Tue, Oct 03, 2023 at 03:40:56PM -0500, Bjorn Helgaas wrote:
> On Tue, Oct 03, 2023 at 10:23:30PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Tue, Oct 03, 2023 at 12:15:24PM +0200, Uwe Kleine-K=F6nig wrote:
> > > On Mon, Oct 02, 2023 at 05:12:18PM -0500, Bjorn Helgaas wrote:
> > > > On Sun, Oct 01, 2023 at 07:02:52PM +0200, Uwe Kleine-K=F6nig wrote:
> > > > > With CONFIG_PCIE_KIRIN=3Dy and kirin_pcie_remove() marked with __=
exit, the
> > > > > function is discarded from the driver. In this case a bound devic=
e can
> > > > > still get unbound, e.g via sysfs. Then no cleanup code is run res=
ulting
> > > > > in resource leaks or worse.
> > > >=20
> > > > kirin_pcie_driver sets .suppress_bind_attrs =3D true.
> > > >=20
> > > > Doesn't that mean that we can't unbind a device via sysfs in this
> > > > case?
> > >=20
> > > Oh indeed, that's something I missed.
> > > =20
> > > > I don't expect modpost to know about .suppress_bind_attrs, so maybe=
 we
> > > > should remove the __exit annotation even if it would be safe to keep
> > > > it in this case.  It's a tiny function anyway.
> > >=20
> > > the right thing to do then is something like:
> > > https://lore.kernel.org/linux-rtc/20231002080529.2535610-7-u.kleine-k=
oenig@pengutronix.de
> > >=20
> > > And then it would be consequent to also switch to
> > > module_platform_driver_probe and move .probe to __init. Or drop
> > > .suppress_bind_attrs and keep/put .probe() and .remove() in .text.
> >=20
> > The other three patches in this series don't suffer from this oversight
> > and so are (from my POV) ready to go in.
>=20
> Agreed.  My first impression was that this would be v6.7 material, but
> based on
> https://lore.kernel.org/linux-kbuild/CAK7LNATyRg6Hc-fnTETERj-tdMFGaBDt0Fy=
hy9+jKCzAvzQ6Pg@mail.gmail.com/,
> I guess that modpost change must be headed for v6.6?

No, the modpost change was softend and only triggers (for now) on W=3D1
builds. There is no urge.

> And while I haven't seen problem reports, branching into the weeds
> because of a sysfs "remove" would be a pretty bad outcome, so I can
> see a case for v6.6 and stable tags as well.  Is that your thought
> process, too?

The change is obviously a fix and a crash after sysfs interaction is
bad. It depends on the usecase if this is urgent. I'd say it's not a big
deal if it doesn't make it into v6.6, the problem (in this driver)
exists since 5.19-rc1 and there are still quite a few similar issues.
I'd go for marking for stable and applying for v6.6 if it's convenient.

> > If you tell me, which option you prefer for the kirin driver, I'll
> > follow up with a matching patch. (If you don't know, my preference would
> > be to drop .suppress_bind_attrs and move .probe() and .remove() to
> > .text.)
>=20
> I agree, dropping .suppress_bind_attrs would be desirable, although I
> would hope for some kind of assurance that it's not there because of
> an issue with removal or something.

If there is a problem with removal, it's relevant for modular drivers at
rmmod time already now. I didn't check if there is a problem (and maybe
I cannot judge this objectively) but for sure such a problem would be
relevant already now. So I'd say this isn't an argument that should stop
us.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--l3alnz67jfv6mrxi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUdH2UACgkQj4D7WH0S
/k7MkwgAg5esLI8+uwUgwy1Ljf8s/G8JkGaU3vZepoggpoz1GoqLtVl4CQ/lEWUj
/qa3gBIINlXl2kOBQ7vHEGESsHMRBWuk14DGJme9OpZ3FlS/O6VUGgV9Ejpor5Xi
/8kBh62dxh1LkcMCLi3uqG4CWqn0j6YNnXpNfLJdrDZI6HN4mAv0IWHCUWCnjfGm
SfPtGm7e7c6LwwymYHG1FyrGMjTWJt0gD0CfIeDUz2gic/5ayZOhGx7S77bPD0Jp
MJwwegTzZI71KoN4IGV+///0TCqTeiUMAibkyL2e7e2s577k1DjFYa/dy4LYQsRu
n33rwO4+uWnbHnqmY334+lc0LQSp2Q==
=MmJ7
-----END PGP SIGNATURE-----

--l3alnz67jfv6mrxi--
