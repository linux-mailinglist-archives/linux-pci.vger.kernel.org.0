Return-Path: <linux-pci+bounces-147-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D0C7F64F5
	for <lists+linux-pci@lfdr.de>; Thu, 23 Nov 2023 18:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7BCCB20F7C
	for <lists+linux-pci@lfdr.de>; Thu, 23 Nov 2023 17:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8950035F11;
	Thu, 23 Nov 2023 17:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pci@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FE5D42
	for <linux-pci@vger.kernel.org>; Thu, 23 Nov 2023 09:12:45 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6DFm-0002Px-2m; Thu, 23 Nov 2023 18:12:38 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6DFl-00B5YB-DJ; Thu, 23 Nov 2023 18:12:37 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6DFl-006pjL-3z; Thu, 23 Nov 2023 18:12:37 +0100
Date: Thu, 23 Nov 2023 18:12:36 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Will Deacon <will@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	kernel@pengutronix.de, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: host-generic: Convert to platform remove callback
 returning void
Message-ID: <20231123171236.tksz4lhpj5jbwfxm@pengutronix.de>
References: <20231020092107.2148311-1-u.kleine-koenig@pengutronix.de>
 <170051728317.217544.2195167252059868427.b4-ty@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g3hogphixdkg5kc5"
Content-Disposition: inline
In-Reply-To: <170051728317.217544.2195167252059868427.b4-ty@google.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org


--g3hogphixdkg5kc5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 03:56:18PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>=20
>=20
> On Fri, 20 Oct 2023 11:21:07 +0200, Uwe Kleine-K=F6nig wrote:
> > The .remove() callback for a platform driver returns an int which makes
> > many driver authors wrongly assume it's possible to do error handling by
> > returning an error code.  However the value returned is (mostly) ignored
> > and this typically results in resource leaks. To improve here there is a
> > quest to make the remove callback return void. In the first step of this
> > quest all drivers are converted to .remove_new() which already returns
> > void.
> >=20
> > [...]
>=20
> Applied to "enumeration" for v6.8, thanks!
>=20
> [1/1] PCI: host-generic: Convert to platform remove callback returning vo=
id
>       commit: d9dcdb4531fe39ce48919ef8c2c9369ee49f3ad2

Thanks! This branch isn't included in next. Is this on purpose?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--g3hogphixdkg5kc5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVfiAQACgkQj4D7WH0S
/k6z+wgApVLfxkOyQRKmyop27mydI6ZhVxsXVoZ4lRwk4j2Q5E8L3nIUv3zMBU8/
4oDTF9rHJ7IzRkiKHEXzKMEmWS/yz2vhr8YFOpVQJdd20wbrKdyWh5FW5aevc9pZ
AQ8v00pW+xZC+VbE1ESfJJGoW1RZnRT0GAmYs9HONntECkJWRyF90IyBpDnCoCns
LMLqnhBdp6C1Rs4mCam4QtO7/S+HfKD4LQ4Sx+L2S5KxTXyS3omcq78TnpogkgoW
48Jb6ztIEpMO5dL9DzNdmHTJLadJle0aXc5we2qRspKPKUoOAXQCPXHYaTYaooMW
vTxjEnf+JDQjatax2ACvFCflvxAiCw==
=yxnt
-----END PGP SIGNATURE-----

--g3hogphixdkg5kc5--

