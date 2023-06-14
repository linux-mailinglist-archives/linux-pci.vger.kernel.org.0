Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B257308D1
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jun 2023 21:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbjFNTxZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Jun 2023 15:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbjFNTxY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Jun 2023 15:53:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09997171C
        for <linux-pci@vger.kernel.org>; Wed, 14 Jun 2023 12:53:20 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q9WYC-0000rI-PC; Wed, 14 Jun 2023 21:53:04 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q9WYB-007QQ6-O6; Wed, 14 Jun 2023 21:53:03 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q9WYA-00EI97-Gm; Wed, 14 Jun 2023 21:53:02 +0200
Date:   Wed, 14 Jun 2023 21:53:02 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     daire.mcnamara@microchip.com
Cc:     conor.dooley@microchip.com, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 3/8] PCI: microchip: enable building this driver as a
 module
Message-ID: <20230614195302.4oefoainw3bn6pmh@pengutronix.de>
References: <20230614155556.4095526-1-daire.mcnamara@microchip.com>
 <20230614155556.4095526-4-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zkk5goccekctlxud"
Content-Disposition: inline
In-Reply-To: <20230614155556.4095526-4-daire.mcnamara@microchip.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--zkk5goccekctlxud
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Daire,

On Wed, Jun 14, 2023 at 04:55:51PM +0100, daire.mcnamara@microchip.com wrot=
e:
> From: Daire McNamara <daire.mcnamara@microchip.com>
>=20
> Enable building this driver as a module. The expected use case is the
> driver is built as a module, is installed when needed, and cannot be
> removed once installed.
>=20
> The remove() callback is not implemented as removing a driver with
> INTx and MSI interrupt handling is inherently unsafe.

The relevant thing here is not that there is no .remove callback (which
doesn't make the driver non-removable) but that the driver has
=2Esuppress_bind_attrs =3D true.
=20
With that properly mentioned in the changelog, the patch is fine for me.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zkk5goccekctlxud
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSKGp0ACgkQj4D7WH0S
/k4HEwf/YK/Kh7Sjdv9pCpDMYW1gbkDfUssQC0nNSXYQDywPqo687VoR60lZCQ7L
ObykeoDwqVdJcUHQRomaMcW3tncNxLn7+1q+VVFaQgOMIvdfh7mkMmnuDyIx/sRa
JTRPN+JlC+4dur36CppUzKmCCDZvU/sJYBx8Vjb5bIXWtJlkhhGrPRI9JKH9I7xs
QCAmPlqpfGErf7b4N3oFD1ac4JWcTP4Bhh+3on09BcQEJh0kqRieH30z4A2CjJQ4
xKp1r4Tr2O2b7ks+9Y0I5mBw+dIN7QALIBzCa4PaR7605HPfQyQ49S9EbuW7NEdP
f3o2HFN/EPhZjuiQWlmr2FDRO9bOkw==
=UzMh
-----END PGP SIGNATURE-----

--zkk5goccekctlxud--
