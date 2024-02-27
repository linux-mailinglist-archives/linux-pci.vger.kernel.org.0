Return-Path: <linux-pci+bounces-4138-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D49F869CA8
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 17:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5375B28288F
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 16:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4813D219ED;
	Tue, 27 Feb 2024 16:47:24 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5181DFD6;
	Tue, 27 Feb 2024 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052444; cv=none; b=WQFGZl+cuNEBwBj4IFf+kE7DCvmnubYzZIglvKeZIInJSeODIVg4cMSsh8Z3S6RI7shA6z8a3IPIUKeFNnBcxXhOGQSk3v55sLf5KysyZCRQi94AvGiIYMy6SGcMsGUzPR19dttAEa/oJCnINQEK6jeMUGmWB5eDsWL0HWwpT4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052444; c=relaxed/simple;
	bh=w+3Y27YFvPohbGAsamVSlkBcsUGcGXiVR3IZlJQZcl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rWUyPNTWnRfXdGMBpdiQ7L1T0TuxwX7CPD8J5zbeeesOq/PLcf+78q8X2DoIE8oy+7cz/q4i6WFYzWvj0gpMifiU6eh5omtxZ0FfRMpDy6JGQ856qtGvHUQvtFo33fNKMDYNwK/ctwvTS/EDdbE1g55VO7qxxzL+Ad51v8z1Ock=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6091e12b01fso17512147b3.2;
        Tue, 27 Feb 2024 08:47:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709052440; x=1709657240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZPoTNL+iADoSj5Qyix6GRoCmMKDXGJWybMxRcvYTvA=;
        b=u+PC83ET0ano0JGM0XxB7c01cKkwDPee53JedTeitWLd+m5870KxUaGFr56cxWit2W
         dknGEdZvHv5ck76TR+uTUZ6yQu2adhMe6XbHYY2A4Rb4pjAumYeqry/nASoVaUuNHlQ2
         G1E+Hdp1P5gICXX175hn9hrGTpSZE4W9vsqa7fTrB5+lB2pCPpvS6Tm3kxZYdoJ380Iv
         r0o+U0OkW/dL/wHBDMs9y/gwRNuoGb13HYC+NhZr6H2dpJce/ad2QQ9pjGKSeg4T/ENP
         6IZXWoZHc4An/jLE1t+FJQEoP5P13be870+x8tGAIxrZS7pDUVaYv0GsFsHOKhF5iBmL
         a5rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDKWiMafiu7gT7P6D8TZ4lmdb+OypLZ1F4zLrGD0b8Iucm/b4BKwv4ahodTw4Aw/N5JquCs/VcuyQ0bUAsj05BvP7Th5wlZKBGA2pNPg3PgIzNxVaXx0CNtg/n6vR+GWKO99D0tFztcqayGLZOKczGfIS70ToEOjM0epscuWd2q1p5IcbBhcotwFvzfJYenQTHP4oSEfJFbmsbvFG9FV0Ef2yTn2IgxdWiWuJ82S+DDlmtMfboAIuC9MJGoapf3YiBVVjJAVlw9149WINqSzynvyZMYZLlYPu7rCO7WyUgK+PGRc+yG4McYLBMOY2jJtDFCYKGxsQphMLB5MTRO1exQbAbPjlxIVFxY7vjr5rfVQV4lkifX7U=
X-Gm-Message-State: AOJu0YxkYPBELvroJp9EWJY6Ol4X4vIIR+LI/4MuTg9UXfqs5nGkg9fu
	w9cabhlKNQxMouDmh0z4OlcA/2nOQMAOh6ryTdgGfouFVkGNUf0fyLjw33i/QtfGFQ==
X-Google-Smtp-Source: AGHT+IE+nv3CE4y1cjaVYeX9JpQUcMNcntVQUbk+ZU6No1lwBk51gEU/n8rpgO9TkqFgRMP4P3cAnA==
X-Received: by 2002:a25:4656:0:b0:dcd:741f:490a with SMTP id t83-20020a254656000000b00dcd741f490amr47506yba.7.1709052440289;
        Tue, 27 Feb 2024 08:47:20 -0800 (PST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id g13-20020a256b0d000000b00dcd25ce965esm1453441ybc.41.2024.02.27.08.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 08:47:17 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dcbc6a6808fso3801463276.2;
        Tue, 27 Feb 2024 08:47:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUnw6ABU3AatoOzEqVzSRXCrVhNUn4LIXE7EI9/Z7g56MFmlRck9Y5cKb9GUQLh7WqGWhOs3U92R5WG4r+s8VHMw6mgrMXdZD6GMh9AsouF5gk3FL7aja7eDY3Ki8gAFb9f5GAO4CoDL1xjnMb0fKSJ+KPmBJb35nv350Yr3sj6LkDQWKtD/PUWGe8ryUMQJ3nMmjViqdpK5X8edoE3HGyHY3QtFux/zXzxDLQrZiGn0aYHHxNirbWdXak9LP2K5C86O346bzxJRkULhJav15BDZRgKhlZtqp3vdfKD8TiuW391FkcyMjpU4K6ydcnKMIr5ojICr0WEIw+6tTPSJuJwl9eMzHukH7KohBnhHIKiuCTDhKJBcRA=
X-Received: by 2002:a25:81cd:0:b0:dc7:776b:5e4a with SMTP id
 n13-20020a2581cd000000b00dc7776b5e4amr10070ybm.56.1709052436589; Tue, 27 Feb
 2024 08:47:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704788539.git.ysato@users.sourceforge.jp> <8dd000fd9040804ec520b76de1b026747e16fc2c.1704788539.git.ysato@users.sourceforge.jp>
In-Reply-To: <8dd000fd9040804ec520b76de1b026747e16fc2c.1704788539.git.ysato@users.sourceforge.jp>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Feb 2024 17:47:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVsJ+VvfcV4UncRsq6mTUcR2njFL4XC+mJuA9hZ-GJAaw@mail.gmail.com>
Message-ID: <CAMuHMdVsJ+VvfcV4UncRsq6mTUcR2njFL4XC+mJuA9hZ-GJAaw@mail.gmail.com>
Subject: Re: [DO NOT MERGE v6 13/37] dt-bindings: clock: sh7750-cpg: Add
 renesas,sh7750-cpg header.
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

Thanks for your patch!

On Tue, Jan 9, 2024 at 9:24=E2=80=AFAM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> SH7750 CPG Clock output define.

Please improve the patch description.

> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/renesas,sh7750-cpg.yaml
> @@ -0,0 +1,103 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/renesas,sh7750-cpg.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas SH7750/7751 Clock Pulse Generator (CPG)
> +
> +maintainers:
> +  - Yoshinori Sato <ysato@users.sourceforge.jp>
> +
> +description:
> +  The Clock Pulse Generator (CPG) generates core clocks for the SoC.  It
> +  includes PLLs, and variable ratio dividers.
> +
> +  The CPG may also provide a Clock Domain for SoC devices, in combinatio=
n with
> +  the CPG Module Stop (MSTP) Clocks.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - renesas,sh7750-cpg             # SH7750
> +      - renesas,sh7750s-cpg            # SH775S
> +      - renesas,sh7750r-cpg            # SH7750R
> +      - renesas,sh7751-cpg             # SH7751
> +      - renesas,sh7751r-cpg            # SH7751R
> +
> +  reg: true
> +
> +  reg-names: true
> +
> +  clocks: true

  clocks:
    maxItems: 1

> +
> +  clock-names: true

  clock-names:
      const: extal

> +examples:
> +  - |
> +    #include <dt-bindings/clock/sh7750-cpg.h>
> +    cpg: clock-controller@ffc00000 {
> +        #clock-cells =3D <1>;
> +        #power-domain-cells =3D <0>;
> +        compatible =3D "renesas,sh7751r-cpg";
> +        clocks =3D <&xtal>;
> +        clock-names =3D "xtal";

"extal"

"xtal" is an output pin, connected to a crystal resonator.
"extal" is the clock input put (either crystal resonator or exteral
clock input.

> +        reg =3D <0xffc00000 20>, <0xfe0a0000 16>;
> +        reg-names =3D "FRQCR", "CLKSTP00";
> +        renesas,mode =3D <0>;
> +    };
> diff --git a/include/dt-bindings/clock/sh7750-cpg.h b/include/dt-bindings=
/clock/sh7750-cpg.h
> new file mode 100644
> index 000000000000..17d5a8076aac
> --- /dev/null
> +++ b/include/dt-bindings/clock/sh7750-cpg.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> + *
> + * Copyright 2023 Yoshinori Sato
> + */
> +
> +#ifndef __DT_BINDINGS_CLOCK_SH7750_H__
> +#define __DT_BINDINGS_CLOCK_SH7750_H__
> +
> +#define SH7750_CPG_PLLOUT      0
> +
> +#define SH7750_CPG_FCK         1

PCK?

> +#define SH7750_CPG_BCK         2
> +#define SH7750_CPG_ICK         3

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

