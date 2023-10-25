Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B357D618B
	for <lists+linux-pci@lfdr.de>; Wed, 25 Oct 2023 08:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjJYGTn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Oct 2023 02:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjJYGTm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Oct 2023 02:19:42 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A44123
        for <linux-pci@vger.kernel.org>; Tue, 24 Oct 2023 23:19:40 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qvXEo-0003gE-OM; Wed, 25 Oct 2023 08:19:30 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qvXEm-0047Gp-EH; Wed, 25 Oct 2023 08:19:28 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qvXEm-005nSU-4z; Wed, 25 Oct 2023 08:19:28 +0200
Date:   Wed, 25 Oct 2023 08:19:27 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>
Cc:     Simon Richter <sjr@debian.org>, 1015871@bugs.debian.org,
        linux-pci@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Emanuele Rocca <ema@debian.org>
Subject: Enabling PCI_P2PDMA for distro kernels?
Message-ID: <20231025061927.smn5xnwpkasctpn7@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s6rnyabjnc2dlg6y"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--s6rnyabjnc2dlg6y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

in https://bugs.debian.org/1015871 the Debian kernel team got a request
to enable PCI_P2PDMA. Given the description of the feature and also the
"If unsure, say N." I wonder if you consider it safe to enable this
option.

Assuming this option isn't completely free of security concerns, a
kernel option to explicitly enable would be nice for a distro kernel.
This way the option could be enabled (but dormant and so safe) and users
who want to benefit from it despite the concerns can still do so.

Some side information:

 - According to Emanuele Rocca this option is enabled in Fedora Server
   38 and openSUSE Tumbleweed

 - I already asked in #linux-pci for feedback, Krzysztof Wilczy=C5=84ski
   recommended there to bring this topic forward via mail and pointed
   out a (paywalled) ACM paper about this topic
   (https://dl.acm.org/doi/10.1145/3409963.3410491).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--s6rnyabjnc2dlg6y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmU4s28ACgkQj4D7WH0S
/k6JQwf9Gjjtgh2jbZsJdUB8pMaQqfBhri1KkGEz4F/WAXbIk6wjIuRmIw/iToCb
z+4iB0zsQdDMrPC4kYzYU01HVlc+ZfsFdfUWIl1pL/TaGJmufh6dccrgaWsLJ+OC
lNiyGDKSrnZeagC967U3UZaxNReHXESlADetzF6bzKB8FWiN6VLkFN6Fs1bp+z9R
qVwnzoij/LsIIRuRpr17VtAKJpZ9GteGXdu1tJmNpUVGTaMBSYCUslHvZ/1ou6CM
+1j+4J2razslVfT6lyvrock3CWGrF8leDYpRdEkv7RhZw8g19uN1qJ/RlC2UdjmT
oifDP3SYlZ1H1XjfZy4WGvKq1wjuCw==
=x5rE
-----END PGP SIGNATURE-----

--s6rnyabjnc2dlg6y--
