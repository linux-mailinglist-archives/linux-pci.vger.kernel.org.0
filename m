Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA10E6661EA
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 18:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238088AbjAKRao (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 12:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239785AbjAKR3C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 12:29:02 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102DD18693
        for <linux-pci@vger.kernel.org>; Wed, 11 Jan 2023 09:26:11 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pFer9-0002Xh-6S; Wed, 11 Jan 2023 18:25:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pFer6-005M1d-0J; Wed, 11 Jan 2023 18:25:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pFer5-00C1Yo-7Q; Wed, 11 Jan 2023 18:25:39 +0100
Date:   Wed, 11 Jan 2023 18:25:39 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     daire.mcnamara@microchip.com
Cc:     conor.dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, lpieralisi@kernel.org,
        kw@linux.com, bhelgaas@google.com, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 03/11] PCI: microchip: enable building this driver as
 a module
Message-ID: <20230111172539.syrrxnghl5qwdcg6@pengutronix.de>
References: <20230111125323.1911373-1-daire.mcnamara@microchip.com>
 <20230111125323.1911373-4-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qdzkzcp4mrdjbo6i"
Content-Disposition: inline
In-Reply-To: <20230111125323.1911373-4-daire.mcnamara@microchip.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--qdzkzcp4mrdjbo6i
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Jan 11, 2023 at 12:53:15PM +0000, daire.mcnamara@microchip.com wrot=
e:
> From: Daire McNamara <daire.mcnamara@microchip.com>
>=20
> Enable building this driver as a module. The expected use case is the
> driver is built as a module, is installed when needed, and cannot be
> removed once installed.
>=20
> The remove() callback is not implemented as removing a driver with
> INTx and MSI interrupt handling is inherently unsafe.

Note this is a misconception. Not providing a remove callback doesn't
prevent the driver from being unbound.

However the driver has

	.suppress_bind_attrs =3D true,

which prevents unbinding. (So the patch looks fine to me, just the
commit log could be improved.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qdzkzcp4mrdjbo6i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmO+8RAACgkQwfwUeK3K
7AkkbAf/X4viZiqE5wwHL4ML0OPl/vMba9lkh/d9F46mYh4tI/PTfLHXZevkebHH
bmTsNEqtMFwTNarNuMy6GGyJ5om5kStbfhOMaSHEI1xA12sSNydmD0Nb7kwfL5Fy
Y1fIPQ+cKRRN95qa1FO/mwZMeRDEkQWPG99jsylhCyw9odHdWwSPkkMf3Yt7NtaG
LtFTTCzSs5tKxyidItAxYxZsGSVAV5kaUC5KK9b/cLQVbcjJhjakxyOgxeadq2rP
8Twqr+zrx+8T834mlssCzvfKGauVfY8bm1yNBDLXEl+A26W5NYHNBb7PuzT48v1m
ukKeE5nVQLK3EvU8AMcppOG5i1TGnQ==
=syYC
-----END PGP SIGNATURE-----

--qdzkzcp4mrdjbo6i--
