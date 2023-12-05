Return-Path: <linux-pci+bounces-500-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F04E4805834
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 16:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F7A31C21163
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 15:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF1C67E89;
	Tue,  5 Dec 2023 15:08:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BC4B2;
	Tue,  5 Dec 2023 07:08:07 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-daf7ed42ea6so4004130276.0;
        Tue, 05 Dec 2023 07:08:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701788886; x=1702393686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBiG9HxZoSdr8SoEZSK/a3wB0uDxAZ7A8FUVFW1eSbA=;
        b=jmaSdfBLnfanc+fvhAc727DyclHbcR+HhYT0BXD3ovjghZiqqHi3UAHZhHnH3CQ+XV
         CQ0MVThhZbCmV0H30kOUqmFElOVBeyOfzr900OpWkh9z5vtEO5W9/Z1Md7t9uOe2qoQv
         y6g5j1uFgvUS2xC/7vvv15Fzz0BDL2xR4ScA+6gP7neBlBFbvJtqdfGJH8kFFhnBd8KI
         khOmSCEH4MjBB3lSRmWQBrmQicdjcIpsdBZKOCxObLQ1CkEU7pqPgz/0JY6FR/H3ieN0
         DnPuciBZjfSBf6+YZVQh0AzZ+mRHwj2HspJlgQ9YlExcBqtxso75/x4KwwbKTKsrosFf
         7oXQ==
X-Gm-Message-State: AOJu0Yx1d8HIuHkFyHDNlsL8Lc/+QXCYFsb7i3jh0cdVan5GiSZaS/X5
	W+cr2pqL4oDreiUfrS9FWfetganM8vH6aA==
X-Google-Smtp-Source: AGHT+IEpci/bJCZF6vWZg8QX/uhC7FNTI3x/3y2x+SHPMWiqo9h3XjYpfU8cdqKo+4eY90A/TKbIow==
X-Received: by 2002:a5b:4c1:0:b0:db7:dacf:61f0 with SMTP id u1-20020a5b04c1000000b00db7dacf61f0mr4341088ybp.66.1701788886420;
        Tue, 05 Dec 2023 07:08:06 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id 64-20020a250d43000000b00da041da21e7sm3123981ybn.65.2023.12.05.07.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 07:08:04 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5d4f71f7e9fso45021387b3.0;
        Tue, 05 Dec 2023 07:08:04 -0800 (PST)
X-Received: by 2002:a05:690c:b9a:b0:5d3:ec19:d067 with SMTP id
 ck26-20020a05690c0b9a00b005d3ec19d067mr3373868ywb.35.1701788884398; Tue, 05
 Dec 2023 07:08:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701768028.git.ysato@users.sourceforge.jp> <c796ca5adc21c55f92968070e7f13201fe5b3f4a.1701768028.git.ysato@users.sourceforge.jp>
In-Reply-To: <c796ca5adc21c55f92968070e7f13201fe5b3f4a.1701768028.git.ysato@users.sourceforge.jp>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 5 Dec 2023 16:07:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWZadFO6TF_X_H2aRdGvePLhREvwWfEP==Mm-Ah5BkC3Q@mail.gmail.com>
Message-ID: <CAMuHMdWZadFO6TF_X_H2aRdGvePLhREvwWfEP==Mm-Ah5BkC3Q@mail.gmail.com>
Subject: Re: [DO NOT MERGE v5 24/37] dt-binding: sh: cpus: Add SH CPUs json-schema
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Lee Jones <lee@kernel.org>, 
	Helge Deller <deller@gmx.de>, Heiko Stuebner <heiko@sntech.de>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Arnd Bergmann <arnd@arndb.de>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, Baoquan He <bhe@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Guo Ren <guoren@kernel.org>, 
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
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sato-san,

On Tue, Dec 5, 2023 at 10:46=E2=80=AFAM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Renesas SH series and compatible ISA CPUs.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sh/cpus.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sh/cpus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas SuperH CPUs
> +
> +maintainers:
> +  - Yoshinori Sato <ysato@users.sourceforge.jp>
> +
> +description: |+
> +  The device tree allows to describe the layout of CPUs in a system thro=
ugh
> +  the "cpus" node, which in turn contains a number of subnodes (ie "cpu"=
)
> +  defining properties for every cpu.
> +
> +  Bindings for CPU nodes follow the Devicetree Specification, available =
from:
> +
> +  https://www.devicetree.org/specifications/
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - renesas,sh2a
> +          - renesas,sh3
> +          - renesas,sh4
> +          - renesas,sh4a
> +          - jcore,j2
> +      - const: renesas,sh2

Plain "renesas,sh2" should be accepted, too.

> +
> +  clock-frequency:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      CPU core clock freqency.

frequency

Although clocks below is more flexible.

> +
> +  clocks: true

maxItems: 1

> +
> +  clock-names: true
> +
> +  reg:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    const: 0

Some SH systems are SMP, so non-zero values should be accepted.

> +
> +  device_type: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - device_type
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/sh7750.h>

fatal error: dt-bindings/clock/sh7750.h: No such file or directory

sh7750-cpg.h


> +    cpus {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        cpu: cpu@0 {
> +            compatible =3D "renesas,sh4", "renesas,sh2";
> +            device_type =3D "cpu";
> +            reg =3D <0>;
> +            clocks =3D <&cpg SH7750_CPG_ICK>;
> +            clock-names =3D "ick";
> +            icache-size =3D <16384>;
> +            icache-line-size =3D <32>;
> +            dcache-size =3D <32768>;
> +            dcache-line-size =3D <32>;
> +        };
> +    };
> +...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

