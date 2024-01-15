Return-Path: <linux-pci+bounces-2144-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3EE82D66B
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jan 2024 10:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24BED28206D
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jan 2024 09:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B32F4E9;
	Mon, 15 Jan 2024 09:52:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54944FC11;
	Mon, 15 Jan 2024 09:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5e76948cda7so77666167b3.3;
        Mon, 15 Jan 2024 01:52:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705312368; x=1705917168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wsMhOFSC0mxjAJYvrikbFmAm65pBG0U6QI3j9yJqaic=;
        b=NqW2mCDtcUyTwgZFAA/rkTMwmahWtBYNzWc32YZPKxNlkm0yMW0+8HOjveMxShuxBy
         CQcHx+Msh/CWIuQxKxaPkIPXMN/G+5Z2e8g8ISXK/Yjc4+w8vNr3nUS9fgey+uTk+fK2
         oZzyLlN2CaMWRWehm60qBBYaXqBTu1GEtBVOQH0QeL96x1EN+koc3aPHVxdo6atY5h3R
         LRf/i8kG84+bhDXyaHj+Lu81cV0ZSKJV8bSKDsaOSjH7n/TWEOtQPeuM8nTNKWhFKvGX
         Zo7uJl/lwyrGDQzCIk5PIReijBY10X23ny24PH0mO2I69pGmfNF7H7iMjU1mI4muKq8b
         i7qA==
X-Gm-Message-State: AOJu0YyjDcFNHqPCE7Bn5PhldVqqWrg8jbyb6Z/+i9fnqy8Rf+XHhjUe
	lVw2vQYIGyA0BD9THlzr3wSSNvnngfGL5A==
X-Google-Smtp-Source: AGHT+IEX6uvZVQqpdyFdUkuf26ZeiFhzlynOzPs10JRGhXeNHWRABsgvivhCcxnO9Zwq6nEck/W7MQ==
X-Received: by 2002:a81:7613:0:b0:5f7:b18e:9298 with SMTP id r19-20020a817613000000b005f7b18e9298mr3674121ywc.67.1705312368108;
        Mon, 15 Jan 2024 01:52:48 -0800 (PST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id l6-20020a0de206000000b005ff3b4a89a8sm271889ywe.107.2024.01.15.01.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 01:52:47 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5e76948cda7so77665967b3.3;
        Mon, 15 Jan 2024 01:52:47 -0800 (PST)
X-Received: by 2002:a81:6d41:0:b0:5f6:46b:b0be with SMTP id
 i62-20020a816d41000000b005f6046bb0bemr2963784ywc.61.1705312367679; Mon, 15
 Jan 2024 01:52:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704788539.git.ysato@users.sourceforge.jp> <9c3a9caaa1e2fc7e515cac67f07a20af071bd1be.1704788539.git.ysato@users.sourceforge.jp>
In-Reply-To: <9c3a9caaa1e2fc7e515cac67f07a20af071bd1be.1704788539.git.ysato@users.sourceforge.jp>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Jan 2024 10:52:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWSR3ikL7VZYkNOb1Y8mPU5LaUnc8+WLj-Ec99EOWxs_w@mail.gmail.com>
Message-ID: <CAMuHMdWSR3ikL7VZYkNOb1Y8mPU5LaUnc8+WLj-Ec99EOWxs_w@mail.gmail.com>
Subject: Re: [DO NOT MERGE v6 22/37] dt-bindings: display: smi,sm501: SMI
 SM501 binding json-schema
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
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

On Tue, Jan 9, 2024 at 9:24=E2=80=AFAM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> ---
>  .../bindings/display/smi,sm501.yaml           | 417 ++++++++++++++++++
>  1 file changed, 417 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/smi,sm501.y=
aml

Surely Documentation/devicetree/bindings/display/sm501fb.txt should
be removed, too?

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/smi,sm501.yaml

> +  crt:
> +    type: object
> +    description: CRT output control
> +    properties:
> +      edid:
> +        $ref: /schemas/types.yaml#/definitions/uint8-array
> +        description: |
> +          verbatim EDID data block describing attached display.
> +          Data from the detailed timing descriptor will be used to
> +          program the display controller.
> +
> +      smi,flags:
> +        $ref: /schemas/types.yaml#/definitions/string-array
> +        description: Display control flags.
> +        items:
> +          anyOf:
> +            - const: use-init-done
> +            - const: disable-at-exit
> +            - const: use-hwcursor
> +            - const: use-hwaccel

The "use-*" flags look like software policy, not hardware description,
and thus do not belong in DT?

> +            - const: panel-no-fpen
> +            - const: panel-no-vbiasen
> +            - const: panel-inv-fpen
> +            - const: panel-inv-vbiasen
> +        maxItems: 8
> +
> +      bpp:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: Color depth
> +
> +  panel:
> +    type: object
> +    description: Panel output control
> +    properties:
> +      edid:
> +        $ref: /schemas/types.yaml#/definitions/uint8-array
> +        description: |
> +          verbatim EDID data block describing attached display.
> +          Data from the detailed timing descriptor will be used to
> +          program the display controller.
> +
> +      smi,flags:
> +        $ref: /schemas/types.yaml#/definitions/string-array
> +        description: Display control flags.
> +        items:
> +          anyOf:
> +            - const: use-init-done
> +            - const: disable-at-exit
> +            - const: use-hwcursor
> +            - const: use-hwaccel

The "use-*" flags look like software policy, not hardware description,
and thus do not belong in DT?

> +            - const: panel-no-fpen
> +            - const: panel-no-vbiasen
> +            - const: panel-inv-fpen
> +            - const: panel-inv-vbiasen
> +        maxItems: 8
> +
> +      bpp:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: Color depth
> +
> +  smi,devices:
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    description: Select SM501 device functions.
> +    items:
> +      anyOf:
> +        - const: usb-host
> +        - const: usb-slave
> +        - const: ssp0
> +        - const: ssp1
> +        - const: uart0
> +        - const: uart1
> +        - const: fbaccel
> +        - const: ac97
> +        - const: i2s
> +        - const: gpio
> +    minItems: 1
> +    maxItems: 10

I think it would be better to have individual subnodes for the sub devices,
with status =3D "ok"/"disabled".

If you go that route, you do need some fallback code to handle the lack
of subnodes in the existing user in arch/powerpc/boot/dts/charon.dts.

BTW, why can sm501_pci_initdata get away with setting ".devices
=3D SM501_USE_ALL"?  Or, would it hurt to enable all subdevices
unconditionally?

> +
> +  smi,mclk:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: mclk frequency.
> +
> +  smi,m1xclk:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: m1xclk frequency.

These two should be clock specifiers (i.e. phandles pointing to clock
nodes + optional clock indices).

> +
> +  misc-timing:
> +    type: object
> +    description: Miscellaneous Timing register values.
> +    properties:
> +      ex:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: Extend bus holding time.
> +        enum: [0, 16, 32, 48, 64, 80, 96, 112, 128, 144, 160, 176, 192, =
208, 224, 240]
> +
> +      xc:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        description: Xscale clock input select.
> +        items:
> +          enum:
> +            - internal-pll
> +            - hclk
> +            - gpio33

Software policy instead of hardware description again?

I am not familiar with how the SM501 works, so I cannot comment on
the other properties, but several of them look like they need rework.

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

