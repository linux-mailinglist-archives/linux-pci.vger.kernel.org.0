Return-Path: <linux-pci+bounces-1943-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9893E828C45
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 19:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE2431F2605C
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 18:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CE53BB33;
	Tue,  9 Jan 2024 18:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcp7JAxN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3038537144;
	Tue,  9 Jan 2024 18:06:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8AAC433C7;
	Tue,  9 Jan 2024 18:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704823565;
	bh=NN/FbWiRX53UohMXPf7fLJZkdhyGG0EUcymSjVK7DwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kcp7JAxN3AiJT/zSfbaoA2+7fPC3A0ZWVvSpRFAXx0sFyslV297XJ83IYJOjo4WAv
	 RUdWxNZ+T4f+tX8USIS62YD32DyNu8gWf/EukR9JAZCISzWgu8dBFDlcQVcUef3Qz+
	 qkeRllPXAqI8/+i1uMFcsFAVDEyFdefmurq958sF8q6Q1EDAqkZtVovABFy0M4KCPP
	 /3SbdOHFNikwrWGa3c8z8h8x3ZkVs4szS72knM0ROeuCbSWYF8N/GbynYZCQraVBub
	 IdFyuk+hxImNfwll+1mwS83rquldTk9ZtxZiCRx01zOHozYZdd8m+oaJLcGS5nFK5t
	 kPz07I2XU00Bw==
Date: Tue, 9 Jan 2024 18:05:51 +0000
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
Subject: Re: [DO NOT MERGE v6 26/37] dt-bindings: vendor-prefixes:  Add smi
Message-ID: <20240109-fructose-bundle-05d01033277b@spud>
References: <cover.1704788539.git.ysato@users.sourceforge.jp>
 <c8aaf67e3fcdb7e60632c53a784691aabfc7733e.1704788539.git.ysato@users.sourceforge.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6n8cYfu9ndq1dxnc"
Content-Disposition: inline
In-Reply-To: <c8aaf67e3fcdb7e60632c53a784691aabfc7733e.1704788539.git.ysato@users.sourceforge.jp>


--6n8cYfu9ndq1dxnc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2024 at 05:23:23PM +0900, Yoshinori Sato wrote:
> Add Silicon Mortion Technology Corporation
> https://www.siliconmotion.com/
>=20
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index 94ed63d9f7de..a338bdd743ab 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1283,6 +1283,8 @@ patternProperties:
>      description: Skyworks Solutions, Inc.
>    "^smartlabs,.*":
>      description: SmartLabs LLC
> +  "^smi,.*":
> +    description: Silicon Motion Technology Corporation

How come "smi" is used for a company with this name?
Why is it not something like SMTC? There's probably some history here
that I am unaware of.

Cheers,
Conor.

>    "^smsc,.*":
>      description: Standard Microsystems Corporation
>    "^snps,.*":
> --=20
> 2.39.2
>=20

--6n8cYfu9ndq1dxnc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZ2K/wAKCRB4tDGHoIJi
0s/8APwPEbHULafVMSeaB1GSkVcjbGMU9USLjp1+xwbzkhRskwEA53VXD7JPeCRu
EW9RzYohxhrQuLlQKIa6cMs0R07nowg=
=ftc0
-----END PGP SIGNATURE-----

--6n8cYfu9ndq1dxnc--

