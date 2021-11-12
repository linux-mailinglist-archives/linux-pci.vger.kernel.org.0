Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D959944E28E
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 08:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbhKLHru (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Nov 2021 02:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbhKLHru (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Nov 2021 02:47:50 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE81C061766
        for <linux-pci@vger.kernel.org>; Thu, 11 Nov 2021 23:44:59 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mlREz-0000eC-Mx; Fri, 12 Nov 2021 08:44:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mlREy-0008Ig-PA; Fri, 12 Nov 2021 08:44:52 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mlREx-0008W8-Ki; Fri, 12 Nov 2021 08:44:51 +0100
Date:   Fri, 12 Nov 2021 08:44:43 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org, helgaas@kernel.org,
        kernel@pengutronix.de,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [Bug][5.16-rc0] Between commits 7ddb58cb0eca and d2f38a3c6507,
 the kernel stops loading on my devices.
Message-ID: <20211112074443.funercihpmmwu5mj@pengutronix.de>
References: <CABXGCsMFn2mTDmf0Jvw7UWasdrSLTe4JC-hi2BbsgGt-mJ_vkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tdgv4dzvrc73jikz"
Content-Disposition: inline
In-Reply-To: <CABXGCsMFn2mTDmf0Jvw7UWasdrSLTe4JC-hi2BbsgGt-mJ_vkA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--tdgv4dzvrc73jikz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Nov 12, 2021 at 11:34:32AM +0500, Mikhail Gavrilov wrote:
> # first bad commit: [2a4d9408c9e8b6f6fc150c66f3fef755c9e20d4a] PCI: Use t=
o_pci_driver() instead of pci_dev->driver
>=20
> [...]
>=20
> Can anyone help fix this problem, please?

Probably:

	https://lore.kernel.org/r/20211111195040.GA1345641@bhelgaas

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--tdgv4dzvrc73jikz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGOG2gACgkQwfwUeK3K
7AnDNwgAguuF/dp79nXm0TO2mdWx53SKAY2GueKeieYkk98R6Xap8FY6dJBop9cD
c6AxL3x/I8b9ftVpZW1Zpv0QpycLgtQvSdyDhfpLshKzBz179VOecBrlErDrJp9e
XzkVnAlNDJkPe0kwxc5WRUFcpJcVKByi1Kszf6ma+R3JYpuJQ6dqugOF9dNC0ugA
2pdxCld0e9pxA2AW0X70CMgSOMaeg0Vvz/u+F5pZKbkp18DxAE5tiipWW3Kzomny
3nAxkMgKJPMobzBpsZoyPgx/I57C2nCozXpUx1MR1QKdq2EQSx0fGKjIQSWcBxjr
NliBrAlr6M9XVNPlmIktusZ6QRtavg==
=6HcA
-----END PGP SIGNATURE-----

--tdgv4dzvrc73jikz--
