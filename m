Return-Path: <linux-pci+bounces-1011-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D97813AD0
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 20:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0BE1C20F07
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 19:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA08A6979C;
	Thu, 14 Dec 2023 19:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="YKCT6jAL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49D369791
	for <linux-pci@vger.kernel.org>; Thu, 14 Dec 2023 19:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=vJr/
	AQFE1XFRSIFd6GXXrHnQGhGkGt3dKuW9tKsM4n0=; b=YKCT6jALhYwerAmIP8og
	WvlNjpLQ/du0sxJvWarBIVAgSnDV2WcLnWlcmXD8VnqLyy8xjECjUWSy+N8spC0J
	s7U5mhqzl+IYHPIlL1OpGH2BDymKomzFllX3U/vYp4wReJ9LN48b7yK4Z2hEUlkT
	Mo+aABJ1ha9ufY5Cp37BDH50UpuNGFunPkA6Tc2uTL36NyS9aer1uxV4ODjxu8FP
	UJaqcON8fbubzXzS36zVzDvVk8N154kXrVMSo2EeXqakRQiEU3VINb7PXzvZdj1r
	PzISFrJhx8N+N0dTG7RInkn3zf/Zs9il/c9XQWF5n71isuu7lKS7wBmjtZYoCwu/
	WQ==
Received: (qmail 1023542 invoked from network); 14 Dec 2023 20:27:06 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 14 Dec 2023 20:27:06 +0100
X-UD-Smtp-Session: l3s3148p1@iI7dRH0MMtUujnuR
Date: Thu, 14 Dec 2023 20:27:05 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v5 RESEND 0/2] PCI: rcar: support regulators for PCIe
Message-ID: <ZXtXCYx2YR1of/qr@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
References: <20231105092908.3792-1-wsa+renesas@sang-engineering.com>
 <ZXske3k8CkMcGjr5@shikoro>
 <20231214191900.GB2079458@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C8Ty/fbhp+nEXecq"
Content-Disposition: inline
In-Reply-To: <20231214191900.GB2079458@rocinante>


--C8Ty/fbhp+nEXecq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Applied, so it should make it to 6.8.  Apologies for the delay.

Awesome, thank you!


--C8Ty/fbhp+nEXecq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmV7VwUACgkQFA3kzBSg
Kbav2Q//axmhe1kLHs/Li35jBoHdo2LNR2a2RGkR0AzFNJ95MgzJLCAHlmXq+lOU
Odi268gmDwriEa9ISl3a47TxgrndBrxGiMUXgKityzQh+0EAE15erWozUrdCxyel
whdEb0WSlaq0B4lETpbP6jKB4GGi5OZC9VfdFGq9Rl0MIJqYOLn40ZTzO+5+oI4z
ZaZDeTY1+8QRHquRJ97bm8+oAcuMbkf1O6yc6LahUiPTx2lTbxTbdotLFnp8z5go
rjJJ3ctZ9jse4Eqc1iXJORufrRanTtA9RWOyD1pq1difuSaSYTZG6dsPDJOsusma
i0OQ1UjPZSC+dx9MXLfJ5vmgJ89cNfrCp/lt2n2GmJ+LmS0G2wNx1QGJVcYCq2Mu
HNKOqvXLKJS8WnmfRJZeV+hH4ih3fILCzRBLF/+TQIto6bgOv2e63CfKRfvwv5Gn
nOxBPZIAkNdkBQ3birtagIy+6U4sunH6jQxzMlijcTfqks6WWzY7D294Bi3k0FxH
u/vZBvcNcCFg6mxay/tXP0Odpm08AJdMOL2iTRDyMFcYPRWVwS7fr4Tq40TAbWMF
VeBoOjl5l1U47mH6yqR4/lNqZS4LxhA8Oo/jct6e+vHgKpaTl7hEVj0nNANWJdRu
Fi9Ydikto8WBAXc/ubLUXWjDwbtO1qTiLA7xpkmAl4A5/g9JP/s=
=DwEQ
-----END PGP SIGNATURE-----

--C8Ty/fbhp+nEXecq--

