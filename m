Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4171B7B6623
	for <lists+linux-pci@lfdr.de>; Tue,  3 Oct 2023 12:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjJCKPf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Oct 2023 06:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239858AbjJCKPe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Oct 2023 06:15:34 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876A6B7
        for <linux-pci@vger.kernel.org>; Tue,  3 Oct 2023 03:15:31 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qncR8-0000Bo-0J; Tue, 03 Oct 2023 12:15:30 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qncR3-00AkLD-Cl; Tue, 03 Oct 2023 12:15:25 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qncR3-008Phf-3I; Tue, 03 Oct 2023 12:15:25 +0200
Date:   Tue, 3 Oct 2023 12:15:24 +0200
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
Message-ID: <20231003101524.cbgvdtkl5yriqcx5@pengutronix.de>
References: <20231001170254.2506508-3-u.kleine-koenig@pengutronix.de>
 <20231002221218.GA651790@bhelgaas>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="voc6ley6nyij276m"
Content-Disposition: inline
In-Reply-To: <20231002221218.GA651790@bhelgaas>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--voc6ley6nyij276m
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[dropped Kishon Vijay Abraham  from the list of recipients, their email
address doesn't work.]

On Mon, Oct 02, 2023 at 05:12:18PM -0500, Bjorn Helgaas wrote:
> On Sun, Oct 01, 2023 at 07:02:52PM +0200, Uwe Kleine-K=F6nig wrote:
> > With CONFIG_PCIE_KIRIN=3Dy and kirin_pcie_remove() marked with __exit, =
the
> > function is discarded from the driver. In this case a bound device can
> > still get unbound, e.g via sysfs. Then no cleanup code is run resulting
> > in resource leaks or worse.
>=20
> kirin_pcie_driver sets .suppress_bind_attrs =3D true.
>=20
> Doesn't that mean that we can't unbind a device via sysfs in this
> case?

Oh indeed, that's something I missed.
=20
> I don't expect modpost to know about .suppress_bind_attrs, so maybe we
> should remove the __exit annotation even if it would be safe to keep
> it in this case.  It's a tiny function anyway.

the right thing to do then is something like:
https://lore.kernel.org/linux-rtc/20231002080529.2535610-7-u.kleine-koenig@=
pengutronix.de

And then it would be consequent to also switch to
module_platform_driver_probe and move .probe to __init. Or drop
=2Esuppress_bind_attrs and keep/put .probe() and .remove() in .text.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--voc6ley6nyij276m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUb6bwACgkQj4D7WH0S
/k5Y/QgAlnx1v0ezC+RDRrAV8U02poaQdNkJ6ceQ2JU0O4p3h3QBT+wuCy9SwRaD
hkpPmLRAoDC+OSaMVFAndBaBM5gaAyQI2FVFUd8vmTW4+HuwRiAUC5uLQRp8awkC
f7YcWmeVZfkHfA1Voqzg+qcxoJbLpxyL0WQQV8dKuE5jWnKaRALKde+gcBvDEBaz
fyDpcIUnAoYegGoALwsTzFvoKRyqB6PprO5960hqj9xNAPfXgnQPSNlE7OEJnBhb
nJCte8r7zOd9+kqQ2Jn8gGmpp34Xl3+yXcld7CdKQJaUnAwO9JWCsqJM4+7PGrrm
N586+SH+M58kBWcxCfMG7NzKIaMV/Q==
=WuSS
-----END PGP SIGNATURE-----

--voc6ley6nyij276m--
