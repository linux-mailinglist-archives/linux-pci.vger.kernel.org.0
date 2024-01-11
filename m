Return-Path: <linux-pci+bounces-2058-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8525382B12F
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 15:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2410E1F23B4C
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 14:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B47B4A9B0;
	Thu, 11 Jan 2024 14:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHYalyDO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D6E390;
	Thu, 11 Jan 2024 14:59:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F65AC43390;
	Thu, 11 Jan 2024 14:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704985170;
	bh=obzljcLiJ4GpVaa5SSKo4cJxW9OvkYGDmnjlyQfIlZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nHYalyDOvAOPCXFghAM1koa8SyyhhJbx2NS7oaSccjGMgH7hd8K6PgCbgUYNNxNlV
	 RmGKdU8H/qelbOpHbdK6lY3z94gtQDkXFLwmXpIo6se2QKdb2/eJHuEYRWwCvqRZqz
	 d6c/2VhyfKTHc2AOeMEj2o2oEeAhfzNCGN+6T/O6RApd1aGtGh6rdqf/jl/505e4yX
	 2vkmubzDVpwuYZ5TSUe6C8cnpmoESUorVaftbQJbcjgGD8ONaUd6KceQOl+dy+Jwil
	 R5sfhQjmbOfzkWmuihvw8I2rFw5SlSma30PRhfosHts/KPzeyEknOc/usqeCbKIhN0
	 6Aj8MjPf72M2w==
Date: Thu, 11 Jan 2024 08:59:28 -0600
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-sh@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
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
Message-ID: <20240111145928.GA538344-robh@kernel.org>
References: <cover.1704788539.git.ysato@users.sourceforge.jp>
 <c8aaf67e3fcdb7e60632c53a784691aabfc7733e.1704788539.git.ysato@users.sourceforge.jp>
 <20240109-fructose-bundle-05d01033277b@spud>
 <CAMuHMdU1z64QHJOVd3jUsOfyuDApB1+khkUV8PvjoKbwsi327g@mail.gmail.com>
 <20240110-sincere-tripod-9d34175fcbce@spud>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240110-sincere-tripod-9d34175fcbce@spud>

On Wed, Jan 10, 2024 at 04:11:44PM +0000, Conor Dooley wrote:
> On Wed, Jan 10, 2024 at 12:23:37PM +0100, Geert Uytterhoeven wrote:
> > Hi Conor,
> > 
> > On Tue, Jan 9, 2024 at 7:06 PM Conor Dooley <conor@kernel.org> wrote:
> > > On Tue, Jan 09, 2024 at 05:23:23PM +0900, Yoshinori Sato wrote:
> > > > Add Silicon Mortion Technology Corporation
> > 
> > Motion
> > 
> > > > https://www.siliconmotion.com/
> > > >
> > > > Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> > > > ---
> > > >  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > > > index 94ed63d9f7de..a338bdd743ab 100644
> > > > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > > > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > > > @@ -1283,6 +1283,8 @@ patternProperties:
> > > >      description: Skyworks Solutions, Inc.
> > > >    "^smartlabs,.*":
> > > >      description: SmartLabs LLC
> > > > +  "^smi,.*":
> > > > +    description: Silicon Motion Technology Corporation
> > >
> > > How come "smi" is used for a company with this name?
> > > Why is it not something like SMTC? There's probably some history here
> > > that I am unaware of.
> > 
> > See Documentation/devicetree/bindings/display/sm501fb.txt
> > The stock ticker is "SIMO", though.
> > https://www.nasdaq.com/market-activity/stocks/simo
> 
> If there's an existing user, there's little reason to stand in the way I
> think.
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Or reason not to apply, so I'm applying this.

BTW, 'RFC' is the standard way to say 'DO NOT MERGE'.

Rob

