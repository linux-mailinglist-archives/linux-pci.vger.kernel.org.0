Return-Path: <linux-pci+bounces-1945-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D324C828BFB
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 19:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 724B71F21F48
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 18:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97F23BB4C;
	Tue,  9 Jan 2024 18:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBBZdhS6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9473B2BD;
	Tue,  9 Jan 2024 18:09:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717C6C433F1;
	Tue,  9 Jan 2024 18:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704823784;
	bh=xa3Fx62EyFYW4/AAOxEME9LtjMwoCbZ9D18izBItFgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fBBZdhS6nJWOj/dydkQRocNSg7YB8edTU7fqwsPHo6E5ZPGXU+ln5xu5xolOGh0dX
	 NERMPyqUuAoIpoSHKbXn0CB9MHfVpYcQVHaP8QZszqyFJpMAb7Xc/5o2+cEPg1q9NQ
	 ZHRJCtnZyz1V52Gxxghz6nKsH8m71KJ00bEw2EM9P0FvdwQ0R/0fzKYSn3hR7Fbsm5
	 1CvzGx7FYOie9dxqEBA5qA+lt8/cIxftsimUnOf4pmmRhxzAshQoSzgim0v/XnSHv5
	 TDYFKpBXFhh72fcWcSKS8T88Z1lepYs9LWn/n9pcPl9MXb0TTPpUTBHA1OZgCHl1Ss
	 PpqSgVdqSGepA==
Date: Tue, 9 Jan 2024 18:09:31 +0000
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
Subject: Re: [DO NOT MERGE v6 27/37] dt-bindings: ata: ata-generic: Add new
 targets
Message-ID: <20240109-twelve-conceal-3730dd6f896e@spud>
References: <cover.1704788539.git.ysato@users.sourceforge.jp>
 <06fdb2cf7927681acf3099b826390ef75ba321af.1704788539.git.ysato@users.sourceforge.jp>
 <20240109-scoured-step-9a01fa3c5ac8@spud>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="26AM8whvvcnixlKS"
Content-Disposition: inline
In-Reply-To: <20240109-scoured-step-9a01fa3c5ac8@spud>


--26AM8whvvcnixlKS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2024 at 06:07:19PM +0000, Conor Dooley wrote:
> On Tue, Jan 09, 2024 at 05:23:24PM +0900, Yoshinori Sato wrote:
> > Added new ata-generic target.
> > - iodata,usl-5p-ata
> > - renesas,rts7751r2d-ata
> >=20
> > Each boards have simple IDE Interface. Use ATA generic driver.
> >=20
> > Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

That said, a bullet point list in the commit message of what
compatibles you added isn't really achieving anything, you can drop that
=66rom the commit message if/when you resend the series.


>=20
> Cheers,
> Conor.
>=20
> > ---
> >  Documentation/devicetree/bindings/ata/ata-generic.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/ata/ata-generic.yaml b/D=
ocumentation/devicetree/bindings/ata/ata-generic.yaml
> > index 0697927f3d7e..1025b3b351d0 100644
> > --- a/Documentation/devicetree/bindings/ata/ata-generic.yaml
> > +++ b/Documentation/devicetree/bindings/ata/ata-generic.yaml
> > @@ -18,6 +18,8 @@ properties:
> >        - enum:
> >            - arm,vexpress-cf
> >            - fsl,mpc8349emitx-pata
> > +          - iodata,usl-5p-ata
> > +          - renesas,rts7751r2d-ata
> >        - const: ata-generic
> > =20
> >    reg:
> > --=20
> > 2.39.2
> >=20



--26AM8whvvcnixlKS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZ2L2wAKCRB4tDGHoIJi
0oe4APdZUl08BEzIFQmanLf93zBxnZPMk/WX4BC/2Fpb6JohAP905vgXzXkRD3jN
rc/X/PimXkM1IP1dHXhcSIjj9lV+Bg==
=ecle
-----END PGP SIGNATURE-----

--26AM8whvvcnixlKS--

