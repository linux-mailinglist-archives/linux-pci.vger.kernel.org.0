Return-Path: <linux-pci+bounces-1942-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A636828BD9
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 19:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C60286F50
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 18:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9715C3C482;
	Tue,  9 Jan 2024 18:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXDY8SkG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557223BB25;
	Tue,  9 Jan 2024 18:03:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C049C433F1;
	Tue,  9 Jan 2024 18:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704823415;
	bh=0R31HLE3+ZbvwQuChH2OoUhobpCqWxAZJoF/InobdBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mXDY8SkGODZzDpOT/lBscYFSFUXcFq6OdQZmxHjeu5J6ndCS7O2be18/WyT+Pybdh
	 frZeSearhDu/qxK7xrn+iAz/LLJCiSM8uuCq+hZbkHVMtk/8jMEmae+eaU670gfjiF
	 pGwVGqXCsulrjhsafzsfmdxNBRUObccLt6Ds+6ZX8LLEHxbjUDFES3fKQHlD6pIpAR
	 wRRJgq/MCtaEzQmW6fUHSmj0YTh+R2FJAWFWVRegmteeZqsAiMmr0K6ek1NSZ2Rrkv
	 8LzfIr3wPE/EO80FCF9Pcv4ss3c+uipQN1wNPUnn6xKWhhotH5i9aickhLPipGxpDi
	 vfH1JE+2JBDhA==
Date: Tue, 9 Jan 2024 18:03:22 +0000
From: Conor Dooley <conor@kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Lee Jones <lee@kernel.org>, Helge Deller <deller@gmx.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yang Xiwen <forbidden405@foxmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	David Rientjes <rientjes@google.com>, Baoquan He <bhe@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Palmer Dabbelt <palmer@rivosinc.com>, Bin Meng <bmeng@tinylab.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [DO NOT MERGE v6 25/37] dt-bindings: vendor-prefixes: Add iodata
Message-ID: <20240109-frying-robin-e0f3e83966eb@spud>
References: <cover.1704788539.git.ysato@users.sourceforge.jp>
 <17c6381a733d34e8460fd2979f8b53804e808e04.1704788539.git.ysato@users.sourceforge.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o5q2SluoJveOoLQv"
Content-Disposition: inline
In-Reply-To: <17c6381a733d34e8460fd2979f8b53804e808e04.1704788539.git.ysato@users.sourceforge.jp>


--o5q2SluoJveOoLQv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2024 at 05:23:22PM +0900, Yoshinori Sato wrote:
> Add IO DATA DEVICE INC.
> https://www.iodata.com/
>=20
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

I think you are missing an r-b tag here from Geert:
https://lore.kernel.org/all/CAMuHMdUvNT1tDTOq4ppqn69cocAeveaXrsoL2VQ2efBQ+h=
v2aA@mail.gmail.com/

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index 309b94c328c8..94ed63d9f7de 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -671,6 +671,8 @@ patternProperties:
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

--o5q2SluoJveOoLQv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZ2KaQAKCRB4tDGHoIJi
0mETAQCgS0diIQwRpFymnYZiV1TuFr5jugc1/qE1mlVfoy18EwEA6EVpCvyk1xES
OQiPDuXqI2XKO8fupXPq+im8bF/hvwU=
=bocD
-----END PGP SIGNATURE-----

--o5q2SluoJveOoLQv--

