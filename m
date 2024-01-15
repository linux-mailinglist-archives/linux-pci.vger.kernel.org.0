Return-Path: <linux-pci+bounces-2150-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F58282DAC1
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jan 2024 14:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AED61F227DE
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jan 2024 13:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07E317577;
	Mon, 15 Jan 2024 13:59:24 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE90C17584;
	Mon, 15 Jan 2024 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dbedb1ee3e4so7115395276.3;
        Mon, 15 Jan 2024 05:59:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705327161; x=1705931961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCoI6wmXQhas4p+QHjRACvDabiOp6RlTb///RFp+bYk=;
        b=tiSTZFK9+adD4pS2CiBp3H8TjNvhxoFkiEeyDJM3qLno8Xx43Uvjdy/whJLepRGP40
         f/JUNxXcbwBC1NiMKrPQ5O6mjxsEMayOZw+l7hP+OGkvJ0cIlp9/xrESL6ud2rc14k5c
         +g4LU/CdOIf1P42IpSu7NCDGmFEWWr8a34O/gElzv6KrM0MO5K/Qxo1/E4zAPazwrvcz
         iAzMy4H6DJ4l8hwdexcGGRgmLQxnHtYDmYYfHnlNJC6S723bxAXTI6frA3GfAEDGGtJ0
         idx+3WYRQKDVqknRh6cJB2Lh44m1MIyWNgsSDwT+H0KWkJS4ugZ3/y4ecfpbQ2cOsGwi
         VyKw==
X-Gm-Message-State: AOJu0Yw+ysJ8APvGt4ir1qpo8FTztilyNSmmUF09L5UA6NgCR2jYtVdT
	g/D3hUPw+w1FiPxLKxUmpTfNug4I8TlWKw==
X-Google-Smtp-Source: AGHT+IE88cEfoMkTPLs3uXh1bjP2h2ZDA1PqvxGd+SApFuHgdVhtMFJ+iBdwagRwRd4K9ubiXU6JRg==
X-Received: by 2002:a05:6902:2687:b0:db5:c77d:1fae with SMTP id dx7-20020a056902268700b00db5c77d1faemr2834232ybb.29.1705327161525;
        Mon, 15 Jan 2024 05:59:21 -0800 (PST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id c6-20020a25a2c6000000b00d9caecd5c86sm3481218ybn.62.2024.01.15.05.59.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 05:59:20 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dbed5d2ad18so7074363276.0;
        Mon, 15 Jan 2024 05:59:20 -0800 (PST)
X-Received: by 2002:a25:ad8b:0:b0:dbe:e4d3:bbb7 with SMTP id
 z11-20020a25ad8b000000b00dbee4d3bbb7mr2479427ybi.99.1705327159968; Mon, 15
 Jan 2024 05:59:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704788539.git.ysato@users.sourceforge.jp> <183bc01316cab97a7ae96df525a5a450c477210d.1704788539.git.ysato@users.sourceforge.jp>
In-Reply-To: <183bc01316cab97a7ae96df525a5a450c477210d.1704788539.git.ysato@users.sourceforge.jp>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Jan 2024 14:59:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW-Ak6P3nFH7cdomSYec9=WZf8mZaVwmG=qoYHz1thLMQ@mail.gmail.com>
Message-ID: <CAMuHMdW-Ak6P3nFH7cdomSYec9=WZf8mZaVwmG=qoYHz1thLMQ@mail.gmail.com>
Subject: Re: [DO NOT MERGE v6 09/37] dt-bindings: timer: renesas,tmu: add renesas,tmu-sh7750
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
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

Hi Sato-san,

On Tue, Jan 9, 2024 at 9:23=E2=80=AFAM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Add SH7750 TMU entry.
>
> I wanted to replace interrupts and interrupt-names in the if compatible i=
s
> "renesas,tmu-7750", but it seems that I can't rewrite it as expected.
> This resulted in a redundant conditional statement.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
> +++ b/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
> @@ -39,14 +39,15 @@ properties:
>            - renesas,tmu-r8a779a0 # R-Car V3U
>            - renesas,tmu-r8a779f0 # R-Car S4-8
>            - renesas,tmu-r8a779g0 # R-Car V4H
> +          - renesas,tmu-sh7750   # SH7750

OK

>        - const: renesas,tmu
>
>    reg:
>      maxItems: 1
>
> -  interrupts:
> -    minItems: 2
> -    maxItems: 3
> +  interrupts: true
> +
> +  interrupt-names: true

I would drop this change (see below).

>
>    clocks:
>      maxItems: 1
> @@ -75,21 +76,55 @@ required:
>    - clock-names
>    - power-domains
>
> -if:
> -  not:
> -    properties:
> -      compatible:
> -        contains:
> -          enum:
> -            - renesas,tmu-r8a7740
> -            - renesas,tmu-r8a7778
> -            - renesas,tmu-r8a7779
> -then:
> -  required:
> -    - resets
> -
>  additionalProperties: false
>
> +allOf:
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              enum:
> +                - renesas,tmu-r8a7740
> +                - renesas,tmu-r8a7778
> +                - renesas,tmu-r8a7779
> +                - renesas,tmu-sh7750

Adding renesas,tmu-sh7750 to this list is OK.

> +
> +    then:
> +      required:
> +        - resets
> +
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              enum:
> +                - renesas,tmu-sh7750
> +
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 2
> +          maxItems: 3
> +        interrupt-names:
> +          items:
> +            - const: tuni0
> +            - const: tuni1
> +            - const: tuni2
> +
> +    else:
> +      properties:
> +        interrupts:
> +          minItems: 2
> +          maxItems: 4
> +        interrupt-names:
> +          items:
> +            - const: tuni0
> +            - const: tuni1
> +            - const: tuni2
> +            - const: ticpi2
> +
>  examples:
>    - |
>      #include <dt-bindings/clock/r8a7779-clock.h>

The new interrupt logic is not really correct: several TMU instances
on other SoCs do support the fourth interrupt.  It just was not
documented before, or supported by the driver.

I have sent a patch to document the fourth interrupt[1].  Once that
patch has been applied, adding support for sh7751 involves adding just
two new lines.

[1] "PATCH] dt-bindings: timer: renesas,tmu: Document input capture
     interrupt"
    https://lore.kernel.org/r/fb1e38c93e62221f94304edd980a2fb79c1f2995.1705=
325608.git.geert+renesas@glider.be

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

