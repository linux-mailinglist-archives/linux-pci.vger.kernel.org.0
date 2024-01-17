Return-Path: <linux-pci+bounces-2256-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 700E58302CB
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 10:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827091C243C5
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 09:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F046514275;
	Wed, 17 Jan 2024 09:52:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C183C121;
	Wed, 17 Jan 2024 09:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=153.127.30.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705485132; cv=none; b=M4adgzi1hG1usKcyB4kqG9/kwNwRlp3nDN7PLdd1sb00XhdmRDyNSB0qvtsl6irfSqQWkCj533oBaRgQGc/y2U5rGRTq4ZY4cYj0ThEjFK2kigfMw/YqUe+eFTxR+zD9BPKFRE6aeIA9U2LYR/PkDkHFf+DZQUIbT+qodrbObzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705485132; c=relaxed/simple;
	bh=1fXBZ0F6PnMKVX2UfbVlTh+qiCRuwH+ropgNz+S7/3U=;
	h=Received:Date:Message-ID:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=FxE1DC7yEPQFQNKcmXiDnPvG9hh8Q8cvzW8JWCwkrxWo+lorRcrwqGDsNuzDswhe1doQfOYD8y/DNnQtF55GXZsQVRFJEWUdgvPpPU+dqznIOZR8M9bnNnzgfwBOz17bpCHHQF+M/swi6+1uTot+kAXpmsc6D2KkI3+3XioX8j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp; spf=fail smtp.mailfrom=users.sourceforge.jp; arc=none smtp.client-ip=153.127.30.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=users.sourceforge.jp
Received: from SIOS1075.ysato.ml (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
	by sakura.ysato.name (Postfix) with ESMTPSA id B272C1C00D1;
	Wed, 17 Jan 2024 18:46:10 +0900 (JST)
Date: Wed, 17 Jan 2024 18:46:10 +0900
Message-ID: <8734uwwavx.wl-ysato@users.sourceforge.jp>
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-sh@vger.kernel.org,	Damien Le Moal <dlemoal@kernel.org>,	Rob
 Herring <robh+dt@kernel.org>,	Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,	Michael Turquette
 <mturquette@baylibre.com>,	Stephen Boyd <sboyd@kernel.org>,	Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>,	Maxime Ripard
 <mripard@kernel.org>,	Thomas Zimmermann <tzimmermann@suse.de>,	David Airlie
 <airlied@gmail.com>,	Daniel Vetter <daniel@ffwll.ch>,	Thomas Gleixner
 <tglx@linutronix.de>,	Lorenzo Pieralisi <lpieralisi@kernel.org>,	Krzysztof
 =?ISO-8859-2?Q?Wilczy=F1ski?= <kw@linux.com>,	Bjorn Helgaas
 <bhelgaas@google.com>,	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,	Magnus Damm <magnus.damm@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,	Lee Jones
 <lee@kernel.org>,	Helge Deller <deller@gmx.de>,	Heiko Stuebner
 <heiko@sntech.de>,	Jernej Skrabec <jernej.skrabec@gmail.com>,	Chris Morgan
 <macromorgan@hotmail.com>,	Yang Xiwen <forbidden405@foxmail.com>,	Sebastian
 Reichel <sre@kernel.org>,	Randy Dunlap <rdunlap@infradead.org>,	Arnd
 Bergmann <arnd@arndb.de>,	Vlastimil Babka <vbabka@suse.cz>,	Hyeonggon Yoo
 <42.hyeyoo@gmail.com>,	David Rientjes <rientjes@google.com>,	Baoquan He
 <bhe@redhat.com>,	Andrew Morton <akpm@linux-foundation.org>,	Guenter Roeck
 <linux@roeck-us.net>,	Stephen Rothwell <sfr@canb.auug.org.au>,	Azeem Shaikh
 <azeemshaikh38@gmail.com>,	Javier Martinez Canillas <javierm@redhat.com>,
	Max Filippov <jcmvbkbc@gmail.com>,	Palmer Dabbelt <palmer@rivosinc.com>,
	Bin Meng <bmeng@tinylab.org>,	Jonathan Corbet <corbet@lwn.net>,	Jacky Huang
 <ychuang3@nuvoton.com>,	Lukas Bulwahn <lukas.bulwahn@gmail.com>,	Biju Das
 <biju.das.jz@bp.renesas.com>,	Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <u.kleine-koenig@pengutronix.de>,	Sam Ravnborg <sam@ravnborg.org>,	Sergey
 Shtylyov <s.shtylyov@omp.ru>,	Michael Karcher
 <kernel@mkarcher.dialup.fu-berlin.de>,	Laurent Pinchart
 <laurent.pinchart+renesas@ideasonboard.com>,	linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,	linux-clk@vger.kernel.org,
	dri-devel@lists.freedesktop.org,	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org,	linux-fbdev@vger.kernel.org
Subject: Re: [DO NOT MERGE v6 17/37] dt-bindings: interrupt-controller: renesas,sh7751-intc: Add json-schema
In-Reply-To: <CACRpkdYLsf-uWdMCTpieji7u1-H3oTGojvC4xm7Erox97XJ6RQ@mail.gmail.com>
References: <cover.1704788539.git.ysato@users.sourceforge.jp>
	<bc794e2165244bd0cee81bc0106f1e2d1bef1613.1704788539.git.ysato@users.sourceforge.jp>
	<CACRpkdYLsf-uWdMCTpieji7u1-H3oTGojvC4xm7Erox97XJ6RQ@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?ISO-8859-4?Q?Goj=F2?=) APEL-LB/10.8 EasyPG/1.0.0
 Emacs/28.2 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 09 Jan 2024 21:30:34 +0900,
Linus Walleij wrote:
>=20
> Hi Yoshinori,
>=20
> thanks for your patch!
>=20
> On Tue, Jan 9, 2024 at 9:24=E2=80=AFAM Yoshinori Sato
> <ysato@users.sourceforge.jp> wrote:
>=20
> > +  renesas,icr-irlm:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description: If true four independent interrupt requests mode (ICR=
.IRLM is 1).
> > +
> > +  renesas,ipr-map:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    description: |
> > +      IRQ to IPR mapping definition.
> > +      1st - INTEVT code
> > +      2nd - Register
> > +      3rd - bit index
>=20
> (...)
>=20
> > +            renesas,ipr-map =3D <0x240 IPRD IPR_B12>, /* IRL0 */
> > +                              <0x2a0 IPRD IPR_B8>,  /* IRL1 */
> > +                              <0x300 IPRD IPR_B4>,  /* IRL2 */
> > +                              <0x360 IPRD IPR_B0>,  /* IRL3 */
> (...)
>=20
> Is it really necessary to have all this in the device tree?
>=20
> You know from the compatible that this is "renesas,sh7751-intc"
> and I bet this table will be the same for any sh7751 right?
>=20
> Then just put it in a table in the driver instead and skip this from
> the device tree and bindings. If more interrupt controllers need
> to be supported by the driver, you can simply look up the table from
> the compatible string.

The SH interrupt controller has the same structure, only this part is diffe=
rent for each SoC.
Currently, we are targeting only the 7751, but in the future we plan to han=
dle all SoCs.
Is it better to differentiate SoC only by compatible?

> Yours,
> Linus Walleij
>=20

--=20
Yosinori Sato

