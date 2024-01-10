Return-Path: <linux-pci+bounces-1999-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7865B829E40
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 17:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 037DD1F22836
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 16:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B344CB2F;
	Wed, 10 Jan 2024 16:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3/tV8d/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6914CB28;
	Wed, 10 Jan 2024 16:11:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2CAC433C7;
	Wed, 10 Jan 2024 16:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704903118;
	bh=TjB+hX1j46U+CflASkOHj4zTVTFUzA+ZbdAbWk2ryio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a3/tV8d/TpSrMMPBNe5Bio2tR6BViJo6DwIaOLYJ6dXTqqXN76rzMj52xy/TIVYU7
	 YzbZtfDGI1pGi7Q//oC4Lp0Acc/UwQQCLOjmh7jQh7VaiOqDdh1HTPGwZSaIbsiby+
	 cCWurXhUDUygFH/SHOzL1xtk0z4CjUb628cwyw7KwK5NQyVn9isyvX7rtXkjU4nI6S
	 DQNgr5OzBM4Aitk1dNvvk+XrhQ2Lg0d0lHZa/o80mZ7ygooh+LXNeO/Yn7VkenHUa+
	 tA/u0+X+ndRiC+QBeR8hwS9cofweI4PMtsBo9b5Fdo2xUbrp3dUKq39pJv1WiqrCDO
	 edCMvCyR2u92g==
Date: Wed, 10 Jan 2024 16:11:44 +0000
From: Conor Dooley <conor@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
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
Subject: Re: [DO NOT MERGE v6 26/37] dt-bindings: vendor-prefixes: Add smi
Message-ID: <20240110-sincere-tripod-9d34175fcbce@spud>
References: <cover.1704788539.git.ysato@users.sourceforge.jp>
 <c8aaf67e3fcdb7e60632c53a784691aabfc7733e.1704788539.git.ysato@users.sourceforge.jp>
 <20240109-fructose-bundle-05d01033277b@spud>
 <CAMuHMdU1z64QHJOVd3jUsOfyuDApB1+khkUV8PvjoKbwsi327g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NUFAcOAItrfxYJZq"
Content-Disposition: inline
In-Reply-To: <CAMuHMdU1z64QHJOVd3jUsOfyuDApB1+khkUV8PvjoKbwsi327g@mail.gmail.com>


--NUFAcOAItrfxYJZq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 12:23:37PM +0100, Geert Uytterhoeven wrote:
> Hi Conor,
>=20
> On Tue, Jan 9, 2024 at 7:06=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
> > On Tue, Jan 09, 2024 at 05:23:23PM +0900, Yoshinori Sato wrote:
> > > Add Silicon Mortion Technology Corporation
>=20
> Motion
>=20
> > > https://www.siliconmotion.com/
> > >
> > > Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> > > ---
> > >  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b=
/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > > index 94ed63d9f7de..a338bdd743ab 100644
> > > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > > @@ -1283,6 +1283,8 @@ patternProperties:
> > >      description: Skyworks Solutions, Inc.
> > >    "^smartlabs,.*":
> > >      description: SmartLabs LLC
> > > +  "^smi,.*":
> > > +    description: Silicon Motion Technology Corporation
> >
> > How come "smi" is used for a company with this name?
> > Why is it not something like SMTC? There's probably some history here
> > that I am unaware of.
>=20
> See Documentation/devicetree/bindings/display/sm501fb.txt
> The stock ticker is "SIMO", though.
> https://www.nasdaq.com/market-activity/stocks/simo

If there's an existing user, there's little reason to stand in the way I
think.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--NUFAcOAItrfxYJZq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZ7BwAAKCRB4tDGHoIJi
0q9OAQDdFxNbk8a1RbWhCTMkuhEoMnbyCFIJrJbkoyX9CvOgjgEA+TlXk2NSR1lR
ie4wsGsQcBrpiUsYvM61XxlwsOPsRgg=
=6SO8
-----END PGP SIGNATURE-----

--NUFAcOAItrfxYJZq--

