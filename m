Return-Path: <linux-pci+bounces-40644-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C271C4351E
	for <lists+linux-pci@lfdr.de>; Sat, 08 Nov 2025 23:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9721A3A9CF0
	for <lists+linux-pci@lfdr.de>; Sat,  8 Nov 2025 22:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7C927703E;
	Sat,  8 Nov 2025 22:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="GgvaFjo7"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EF13D6F;
	Sat,  8 Nov 2025 22:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762640013; cv=pass; b=Gwlx3Jl+hZH2WyKctdruUzx3wMkHuFNswrHBhFjivVWtQ8Y10hcIr/9lG6bCHSfaIHfzKR3O1rhkHCPMGm3GXsu66W3c0Q3lEeS8Fblb8IQr7owlSNvmQVMzUpGkvlFGz3tn4V82hOsCzhQnnpQkvurwNzoqWu2eDpMEonQNbso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762640013; c=relaxed/simple;
	bh=/EnJRHX3Zqz6axFfo+FDPZ1n1cGF7U6KIPo/wJJDz6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bl0tAbQRk2rZTPtjq9xPlj98WHaL+UkilN8hwbV/896LEI4VnrWBgq5+Qrcu3eynwvqIcAmLGHLeWrv36wWhsc9NRLLW1p8DPRSVq/y4caDVXWZQsXOt9bFxTjLn5Bli+KsdYMoqKbroBUdefp89klg2qeoGVbmWJub5K7zY7TI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=GgvaFjo7; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1762639989; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cHKQixeSbiQYgFr/nIMungXoozpc+I+XHBYAKYLIOMCBZoPMuiZ9juvWVCCIfB2Q/4tDXJ7Gzfwk6r7KVnxNZJ9qTtSiFHH2sYUbgoMesswY18rneR+me7pX011K+SopAoRMsd6CItg/WFC6tEBlyJNxmlCBX5m+7hvnrYyvwVI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762639989; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VMIv9AGq780AijX5IiGXZgy94EnHSeQu6sTSzhiMxek=; 
	b=CoRS3XCRJtH5n/+F/hNiC4IUbAVjxoO9cRZG+aD8QfvIMk9gSRfOpcsSUPvFHzVbvTEz53jtm+pXYeZgjwgKyWWdwBFWZZqAdPEYA7NG0peepJ7HeHrJBE2H07Pwv+XPXWi9HiUVCENSXWOCTiRwEKhuoYx4Gz++AO13RSCHMH8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762639989;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=VMIv9AGq780AijX5IiGXZgy94EnHSeQu6sTSzhiMxek=;
	b=GgvaFjo7eVdA72Ou0P0SfF46EBvPLHLMhqhIPO5oG++ndoVBg4X+fymn97HzeZ5o
	0OdtbgGC3fILokPh6Lh3y7261vKyjmiTvp5vPHPszkGqgodAM6Dm+xtw2TugzX1NVg1
	vwizaabpSi0/U9lZ9vR8VJEZbTF5zDgE2DHJq6UY=
Received: by mx.zohomail.com with SMTPS id 1762639987433151.93053330001715;
	Sat, 8 Nov 2025 14:13:07 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 7A8E61801B3; Sat, 08 Nov 2025 23:12:54 +0100 (CET)
Date: Sat, 8 Nov 2025 23:12:54 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Geraldo Nascimento <geraldogabriel@gmail.com>, 
	Ye Zhang <ye.zhang@rock-chips.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johan Jonker <jbx6244@gmail.com>, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: align bindings to PCIe spec
Message-ID: <sbulnlwz3vxyk3yw2c2tcsdvyu57cdvyixkpeq2okh4vn6yyod@4o4kltfb5u6n>
References: <4b5ffcccfef2a61838aa563521672a171acb27b2.1762321976.git.geraldogabriel@gmail.com>
 <ba120577-42da-424d-8102-9d085c1494c8@rock-chips.com>
 <aQsIXcQzeYop6a0B@geday>
 <67b605b0-7046-448a-bc9b-d3ac56333809@rock-chips.com>
 <aQ1c7ZDycxiOIy8Y@geday>
 <d9e257bd-806c-48b4-bb22-f1342e9fc15a@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="npjyxqdavydus2a6"
Content-Disposition: inline
In-Reply-To: <d9e257bd-806c-48b4-bb22-f1342e9fc15a@rock-chips.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.5.1/262.598.13
X-ZohoMailClient: External


--npjyxqdavydus2a6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] arm64: dts: rockchip: align bindings to PCIe spec
MIME-Version: 1.0

Hi,

On Fri, Nov 07, 2025 at 11:01:04AM +0800, Shawn Lin wrote:
> + Ye Zhang
>=20
> =E5=9C=A8 2025/11/07 =E6=98=9F=E6=9C=9F=E4=BA=94 10:43, Geraldo Nasciment=
o =E5=86=99=E9=81=93:
> > On Wed, Nov 05, 2025 at 04:56:36PM +0800, Shawn Lin wrote:
> > > =E5=9C=A8 2025/11/05 =E6=98=9F=E6=9C=9F=E4=B8=89 16:18, Geraldo Nasci=
mento =E5=86=99=E9=81=93:
> > > > Hi Shawn, glad to hear from you.
> > > >=20
> > > > Perhaps the following change is better? It resolves the issue
> > > > without the added complication of open drain. After you questioned
> > > > if open drain is actually part of the spec, I remembered that
> > > > GPIO_OPEN_DRAIN is actually (GPIO_SINGLE_ENDED | GPIO_LINE_OPEN_DRA=
IN)
> > > > so I decided to test with just GPIO_SINGLE_ENDED and it works.
> >=20
> > Shawn,
> >=20
> > I quote from the PCIe Mini Card Electromechanical Specification Rev 1.2
> >=20
> > "3.4.1. Logic Signal Requirements
> >=20
> > The 3.3V card logic levels for single-ended digital signals (WAKE#,
> > CLKREQ#, PERST#, and W_DISABLE#) are given in Table 3-7. [...]"
> >=20
> > So while you are correct that PERST# is most definitely not Open Drain,
> > there's evidence on the spec that defines this signal as Single-Ended.
> >=20
>=20
> This's true. But I couldn't find any user in dts using either
> GPIO_SINGLE_ENDED or GPIO_OPEN_DRAIN for PCIe PERST#. I'm curious
> how these two flags affect actual behavior of chips. Ye, could you
> please help check it?

FWIW I assume single-ended in the spec means it's not differential
like all the highspeed signals on the PCIe connection. This says
nothing about open-drain, open-source or push-pull being used. The
kernel on the other hand has a very specific understanding of
GPIO_SINGLE_ENDED:

	if (flags & OF_GPIO_SINGLE_ENDED) {
		if (flags & OF_GPIO_OPEN_DRAIN)
			lflags |=3D GPIO_OPEN_DRAIN;
		else
			lflags |=3D GPIO_OPEN_SOURCE;
	}

I.e. it is the same as configuring open-source ;)

Greetings,

-- Sebastian

--npjyxqdavydus2a6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmkPwGIACgkQ2O7X88g7
+pph/w/9EGXoEnn09vOlQ9Hk9Y4BurUJ0BtpcYyw58obAh4TBxpw6qpl2pEmL+ZA
7R2h2AlQm3O5wuHTtOwRaiTJsRSIBNOFebqwSZO7lY3OpuOTknFfhUKR98tcuAlQ
DJD0nQMupT6x3GJ0GzKyI1kn6jbV98BhQsqXnoL5Digupn89Z5XvaCHTsUG9quRn
fy1iZlLtgTvpTHOHXoAZkPn0RWznH3hLTlELwwkhEayvdCAGP5m0igUMbO8WWryY
J6358C7Q88GcSffavbmhJYmBsqCoadgN4A2hPwQEgmuIBgwlrgkefaP2dZG0qD5v
GpTSYGiWdLw/bDEW87lq4sav9F+lOPiYJJ+MvhdjZWpLWMuVOJbJpGw/kTrZRTTN
TfElFYQ+7ZWnJUhkCTlebraB8SzjwDA7nc2zIDMXeijIH9++NzAP2XzU48yqllsG
gTlLKhi1Vva7XcPhwEHof6X2IJvUZGp4fwJF7VhI8j+uD90Sb30ZFD/665vrIfZb
vUnY3qTY8Ypo2ITcF//tyeHV8xz5N9kWar8CWYpZcuHxl8/ea7PZYh0L1eDLHQxs
vEOBqezfUI49QVEawDqFFXNflM63IoWyHFb7/VJ7r95O0WJvm9DmyfIWgBhGesXs
hYHvk73EY+0JKzpK+rx/Jn88tD5LOlAG/b4AvYtrTIVIacxtDIk=
=5sqv
-----END PGP SIGNATURE-----

--npjyxqdavydus2a6--

