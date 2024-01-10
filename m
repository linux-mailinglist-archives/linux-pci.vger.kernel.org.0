Return-Path: <linux-pci+bounces-1990-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A422829926
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 12:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF394285FA1
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 11:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDA647F5D;
	Wed, 10 Jan 2024 11:31:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5964347A7C;
	Wed, 10 Jan 2024 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3606ad581a5so18766875ab.1;
        Wed, 10 Jan 2024 03:31:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704886287; x=1705491087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rp53vQ2ebf1f54OIMX+oacHnmEBZZdohJKcQphr0pdo=;
        b=rEpdbTsX+4AcHrZztMQXm/lIvZD+rvzOXMS8LYDwxJaMzEi+XDrl9c9dq+fNHkCeQK
         vDY7sXlbMKQzxTSkZAmuNDpYxvuheK247POrSrC2/witgEa53HjeMsbmk/tdkF3TudAE
         pWiVUCH0qXuAk1hyfbJqnKBqNOjDnWB9UCd0lTyEgk+lM6ol11QDzJpjCHiSYH/nz78b
         rBvIu0qrFIeGBeVAQTwzscWRkmhqkwxmZj4qcnPFt50g91P2TWjJGn2CWkH5Xc9jel7K
         k5tsEPHNOKWqjThcsQZmaydIH+sJPDAlvO3hfNsYz7JxdKaosUeijs7YCM6U73AVnWg+
         2kCQ==
X-Gm-Message-State: AOJu0YyHOmjVGl85PPY1OKOUpiNMRq/oTOAha3txHbN3aVqEDnJrQB5Y
	DO4twqeLR9wV9vSzfD3rKCJsIV6i2E354Vc7
X-Google-Smtp-Source: AGHT+IE4ykJgcq2BqiHgDY8T/mT9u8cCQfTLL2octH67MqlQMtVdHLymoA4Q65ngu5TSMaJ1EcyFXg==
X-Received: by 2002:a05:6e02:1885:b0:360:a195:a142 with SMTP id o5-20020a056e02188500b00360a195a142mr1273026ilu.65.1704886285326;
        Wed, 10 Jan 2024 03:31:25 -0800 (PST)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com. [209.85.166.50])
        by smtp.gmail.com with ESMTPSA id bz4-20020a056e02268400b003606ef496c4sm1215421ilb.63.2024.01.10.03.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 03:31:25 -0800 (PST)
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7bee8f7df35so49536239f.3;
        Wed, 10 Jan 2024 03:31:25 -0800 (PST)
X-Received: by 2002:a81:9295:0:b0:5f0:5816:f339 with SMTP id
 j143-20020a819295000000b005f05816f339mr802434ywg.46.1704885831172; Wed, 10
 Jan 2024 03:23:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704788539.git.ysato@users.sourceforge.jp>
 <c8aaf67e3fcdb7e60632c53a784691aabfc7733e.1704788539.git.ysato@users.sourceforge.jp>
 <20240109-fructose-bundle-05d01033277b@spud>
In-Reply-To: <20240109-fructose-bundle-05d01033277b@spud>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 10 Jan 2024 12:23:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU1z64QHJOVd3jUsOfyuDApB1+khkUV8PvjoKbwsi327g@mail.gmail.com>
Message-ID: <CAMuHMdU1z64QHJOVd3jUsOfyuDApB1+khkUV8PvjoKbwsi327g@mail.gmail.com>
Subject: Re: [DO NOT MERGE v6 26/37] dt-bindings: vendor-prefixes: Add smi
To: Conor Dooley <conor@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, 
	Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Thomas Gleixner <tglx@linutronix.de>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Lee Jones <lee@kernel.org>, 
	Helge Deller <deller@gmx.de>, Heiko Stuebner <heiko@sntech.de>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, 
	Yang Xiwen <forbidden405@foxmail.com>, Sebastian Reichel <sre@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka <vbabka@suse.cz>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	David Rientjes <rientjes@google.com>, Baoquan He <bhe@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Azeem Shaikh <azeemshaikh38@gmail.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Bin Meng <bmeng@tinylab.org>, 
	Jonathan Corbet <corbet@lwn.net>, Jacky Huang <ychuang3@nuvoton.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Sam Ravnborg <sam@ravnborg.org>, Sergey Shtylyov <s.shtylyov@omp.ru>, 
	Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-ide@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Conor,

On Tue, Jan 9, 2024 at 7:06=E2=80=AFPM Conor Dooley <conor@kernel.org> wrot=
e:
> On Tue, Jan 09, 2024 at 05:23:23PM +0900, Yoshinori Sato wrote:
> > Add Silicon Mortion Technology Corporation

Motion

> > https://www.siliconmotion.com/
> >
> > Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/D=
ocumentation/devicetree/bindings/vendor-prefixes.yaml
> > index 94ed63d9f7de..a338bdd743ab 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > @@ -1283,6 +1283,8 @@ patternProperties:
> >      description: Skyworks Solutions, Inc.
> >    "^smartlabs,.*":
> >      description: SmartLabs LLC
> > +  "^smi,.*":
> > +    description: Silicon Motion Technology Corporation
>
> How come "smi" is used for a company with this name?
> Why is it not something like SMTC? There's probably some history here
> that I am unaware of.

See Documentation/devicetree/bindings/display/sm501fb.txt
The stock ticker is "SIMO", though.
https://www.nasdaq.com/market-activity/stocks/simo

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

