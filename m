Return-Path: <linux-pci+bounces-491-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E041805616
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 14:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ABB3281BB5
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 13:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1EC5D903;
	Tue,  5 Dec 2023 13:35:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52F71AB;
	Tue,  5 Dec 2023 05:34:57 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-da7ea62e76cso4131655276.3;
        Tue, 05 Dec 2023 05:34:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701783297; x=1702388097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRBQrJMVxE74uMXuNQQqL8IIVVzyGsSzO2s+5zIiPV0=;
        b=A0lZMQ1jFbKkhWWutDWrcWz7KFIlSeDMWb1jPQCJENqyjmXg0wY/2Kn2MPaK0MRxqS
         A94Ly5u1RVRKpEUDu8eckDuiBnTaYa7yKMceKQZMc80C+yuzJSs4linVi+x+fJN6DZdc
         /TRoWqhZh/u+jlHS0V8IYZqUbwS3qTK8lJButkwMA8q9ZienD7LOGgoh6b1iIAN2fRMI
         aNL+GDzB0ANlNKqviqB85g4opF69Jcbvweq/A++LhAk4UR7R4gZK38VWrRtblXSXjBYJ
         waRGGIxdCAtPGGQvAzbq+QACoZCHDwY3QedHaxNi5MWWtTHraPCwlyNLqWIGbpGMPx16
         4dZw==
X-Gm-Message-State: AOJu0YxZ1wQ3AEYlphbshfxy+Xh/RPffxu2FOhnIFNalr5wdTUGjcB5b
	KP5vxfEevjecCE2pqbEfzqGunisHbMU5OQ==
X-Google-Smtp-Source: AGHT+IGyLaLTwPahXKI2ENXiTAFxqP6MFZUyHT+uzxy1jFrdayp+/7ksG2rXpEX81TvsKl4xBj/nxg==
X-Received: by 2002:a25:ae8c:0:b0:db7:dacf:eda1 with SMTP id b12-20020a25ae8c000000b00db7dacfeda1mr3881355ybj.130.1701783297125;
        Tue, 05 Dec 2023 05:34:57 -0800 (PST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id z28-20020a25ad9c000000b00d9ca7c2c8e2sm3098327ybi.11.2023.12.05.05.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 05:34:56 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-db549f869a3so4132947276.1;
        Tue, 05 Dec 2023 05:34:56 -0800 (PST)
X-Received: by 2002:a25:cc01:0:b0:db7:dacf:ed92 with SMTP id
 l1-20020a25cc01000000b00db7dacfed92mr4614162ybf.115.1701783296324; Tue, 05
 Dec 2023 05:34:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701768028.git.ysato@users.sourceforge.jp>
 <602e1ba4f02489fcbc47e8f9904f3c1db1c9f14a.1701768028.git.ysato@users.sourceforge.jp>
 <2ef81211-9525-4f96-a6b2-3fcfbed0c6e5@app.fastmail.com>
In-Reply-To: <2ef81211-9525-4f96-a6b2-3fcfbed0c6e5@app.fastmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 5 Dec 2023 14:34:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVPO13i8n=QZDnbds1=iMPtfZDcvmFZdst3r+Xf+82U_w@mail.gmail.com>
Message-ID: <CAMuHMdVPO13i8n=QZDnbds1=iMPtfZDcvmFZdst3r+Xf+82U_w@mail.gmail.com>
Subject: Re: [DO NOT MERGE v5 11/37] pci: pci-sh7751: Add SH7751 PCI driver
To: Arnd Bergmann <arnd@arndb.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, 
	Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Dave Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Lee Jones <lee@kernel.org>, 
	Helge Deller <deller@gmx.de>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, David Rientjes <rientjes@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Baoquan He <bhe@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, guoren <guoren@kernel.org>, 
	Javier Martinez Canillas <javierm@redhat.com>, Azeem Shaikh <azeemshaikh38@gmail.com>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Bin Meng <bmeng@tinylab.org>, 
	Max Filippov <jcmvbkbc@gmail.com>, Tom Rix <trix@redhat.com>, 
	Herve Codina <herve.codina@bootlin.com>, Jacky Huang <ychuang3@nuvoton.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Sam Ravnborg <sam@ravnborg.org>, Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, 
	Sergey Shtylyov <s.shtylyov@omp.ru>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-ide@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-clk@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Tue, Dec 5, 2023 at 2:26=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Dec 5, 2023, at 10:45, Yoshinori Sato wrote:
> > +     bscres =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > +     bsc =3D devm_ioremap_resource(&pdev->dev, bscres);
> > +     if (IS_ERR(bsc))
> > +             return PTR_ERR(bsc);
> > +
> > +     if (of_property_read_u32_array(pdev->dev.of_node,
> > +                                    "renesas,memory", memory, 2) < 0) =
{
> > +             /*
> > +              * If no memory range is specified,
> > +              *  the entire main memory will be targeted for DMA.
> > +              */
> > +             memory[0] =3D memory_start;
> > +             memory[1] =3D memory_end - memory_start;
> > +     }
>
> There is a generic "dma-ranges" proerty for describing
> which memory is visible by a bus.

I was just going to give that comment on the bindings patch ;-)

> > --- /dev/null
> > +++ b/drivers/pci/controller/pci-sh7751.h
> > @@ -0,0 +1,76 @@
>
> If the header is only included from one file, just removed
> it and add the register definitions to the driver directly.

$ git grep pci-sh7751.h
arch/sh/drivers/pci/pci-sh4.h:#include "pci-sh7751.h"
drivers/pci/controller/pci-sh7751.c:#include "pci-sh7751.h"

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

