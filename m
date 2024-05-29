Return-Path: <linux-pci+bounces-8042-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E427D8D3C52
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 18:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BD041C208C3
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 16:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E87B18410F;
	Wed, 29 May 2024 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCXHerGs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5271836E0;
	Wed, 29 May 2024 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000040; cv=none; b=T8fvT86fxgb20IgHqJXk06dJ/DRfndBvXUzayMQfu7EEWiAd0o6sOAMnlnH7NtqQw5EH3HvUeJ6Xihkne3+j6tNJ7vyR2ZDsCEHjX3b6/DT2X39diOUN1Y17r/iFuLhL8zIiBZcn+Nm9OTmj+38Us6dpbUsx1EYCqPRYXua2CPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000040; c=relaxed/simple;
	bh=lgIJYBj3mBkbZaZC1FImJA04nZav55O5a7FH5lk9I50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCBOJtvBLvzkSTPccjbu77L558+5frvtreMmfzSBBC+Bb90q1HrFVLxQ8bTrDH5PreSXYPIs3BlFgewSOZ/Q1O0rG1ZFl4WjkgFQeOpJXfh4BgorJHbJYRy3DS+L/O+sYTXVRBpqdFbSpnpo+80V9PHsuHYwbmadcqwsv6FaFYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCXHerGs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2504EC116B1;
	Wed, 29 May 2024 16:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717000039;
	bh=lgIJYBj3mBkbZaZC1FImJA04nZav55O5a7FH5lk9I50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mCXHerGs2ObtKn0UKLsAM9dZ6g3iQSxtf2PHTMzQ7jpFipnk4lGi6y+aQeci5BT6H
	 Hyg1ZNDENMzfs+rf53B8MQqEfSK0Y3cvLpgU8604ks0bob/T7pw5BNUSkKAtJ1ub46
	 h4RDaSf1jAHDYbq4UI5M767YQRxU4H9cYkUXJWND0cg33K7Jdhavo3x2/ZUYKY4yGh
	 ounh4lSRrj9cO41BDPp1M7Be6cJyJwa3dQehMnlfX+Hp+vGTQexILTBHCkrVlqRusv
	 hYkNogzfo5A2FdJX8+Jigeugpxc9jUMAAbBKsAE1/RiZV4X70frvNpx9trbO8i/D9z
	 FPF3KIPFcVV3Q==
Date: Wed, 29 May 2024 17:27:06 +0100
From: Conor Dooley <conor@kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Lee Jones <lee@kernel.org>, Helge Deller <deller@gmx.de>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Masahiro Yamada <masahiroy@kernel.org>, Baoquan He <bhe@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Azeem Shaikh <azeemshaikh38@gmail.com>, Guo Ren <guoren@kernel.org>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sam Ravnborg <sam@ravnborg.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [DO NOT MERGE v8 25/36] dt-bindings: vendor-prefixes: Add iodata
Message-ID: <20240529-cobweb-styling-2f4dafd8b2bc@spud>
References: <cover.1716965617.git.ysato@users.sourceforge.jp>
 <a84653d4c369a57a00011c8c86447096026a0330.1716965617.git.ysato@users.sourceforge.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HZu5E32Wqoezu/cY"
Content-Disposition: inline
In-Reply-To: <a84653d4c369a57a00011c8c86447096026a0330.1716965617.git.ysato@users.sourceforge.jp>


--HZu5E32Wqoezu/cY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Wed, May 29, 2024 at 05:01:11PM +0900, Yoshinori Sato wrote:
> Add IO DATA DEVICE INC.
> https://www.iodata.com/
>=20
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

This one is missing an ack:
https://lore.kernel.org/all/20240109-frying-robin-e0f3e83966eb@spud/

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index fbf47f0bacf1..66cf68139f07 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -716,6 +716,8 @@ patternProperties:
>      description: Inventec
>    "^inversepath,.*":
>      description: Inverse Path
> +  "^iodata,.*":
> +    description: IO DATA DEVICE Inc.
>    "^iom,.*":
>      description: Iomega Corporation
>    "^irondevice,.*":
> --=20
> 2.39.2
>=20

--HZu5E32Wqoezu/cY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZldXWQAKCRB4tDGHoIJi
0hWFAP9m/SQUazFt1Tlt8RyErIrj9VApLRgBd8L2vfvH/pp05gD/Yb0fItGZbPj5
XKV9AI6qjNwnstXymMs1/xs/YbPrcg0=
=xYYk
-----END PGP SIGNATURE-----

--HZu5E32Wqoezu/cY--

