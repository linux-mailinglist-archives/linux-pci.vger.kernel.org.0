Return-Path: <linux-pci+bounces-530-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFBF805FFC
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 22:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDA1E1C2110C
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 21:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B4E6AB8D;
	Tue,  5 Dec 2023 21:02:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F62188;
	Tue,  5 Dec 2023 13:02:03 -0800 (PST)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-58e30de3933so2124922eaf.3;
        Tue, 05 Dec 2023 13:02:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701810122; x=1702414922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdYRNh7Vlob6vHvVQj3FqYlHUzVIZf5EcZbK3xhngEg=;
        b=bmC304Ybt/lLceVWsw9hKVUQc4tT6c/EXo7VyB5kCoSkYY0yZjwiSp4NnPrF3DcVkq
         FgzKQWcJzl5meVCTC5gWPcrCLLu4UXYOug+FP9Z4IW6V8DiBGcxkRuZPBOgloLh0NFwG
         tbm/EccMFRZubUff9J/Ld8m5NI34i9Uhs2fTOXVeEZQEEwUmBXR/wO3BKzP6ZIvChgL2
         8Qm2WURSfz2w8UHNltYlX2GYG5gPSk5nj0hFgvX2XzKSuH5TMsYBKw+gNJ2ZKTByGqBs
         2VKCDlxhwtcb7SDpG5L/keprKM9Y1s8IkFGhu8G8Zde8UB8wmUL4IELj11KDuGxWCl+R
         wF7w==
X-Gm-Message-State: AOJu0Yx3jMCB6MTfbiz6YoxNEFiflpptJw8OVrDild9hhu+Qx1YWL02C
	1gISSb38dpxlUmw/K98hrQ==
X-Google-Smtp-Source: AGHT+IEELo2vI+di+qlC0rsG6Gdv4w/6prGhHS2OYuIkz413JcirnWVw4QzKEsB7bi8jrOvnQ/zU7Q==
X-Received: by 2002:a05:6870:b50e:b0:1fb:75c:3feb with SMTP id v14-20020a056870b50e00b001fb075c3febmr7677773oap.75.1701810122176;
        Tue, 05 Dec 2023 13:02:02 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ps14-20020a0568709e0e00b001fb4aaf261csm1037762oab.32.2023.12.05.13.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 13:02:01 -0800 (PST)
Received: (nullmailer pid 3792495 invoked by uid 1000);
	Tue, 05 Dec 2023 21:01:58 -0000
Date: Tue, 5 Dec 2023 15:01:58 -0600
From: Rob Herring <robh@kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
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
Subject: Re: [DO NOT MERGE v5 19/37] dt-bindings: interrupt-controller:
 renesas,sh7751-irl-ext: Add json-schema
Message-ID: <20231205210158.GA3774253-robh@kernel.org>
References: <cover.1701768028.git.ysato@users.sourceforge.jp>
 <1623383c89532994218795cd3755c37819be426b.1701768028.git.ysato@users.sourceforge.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623383c89532994218795cd3755c37819be426b.1701768028.git.ysato@users.sourceforge.jp>

On Tue, Dec 05, 2023 at 06:45:38PM +0900, Yoshinori Sato wrote:
> Renesas SH7751 external interrupt encoder json-schema.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  .../renesas,sh7751-irl-ext.yaml               | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-irl-ext.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-irl-ext.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-irl-ext.yaml
> new file mode 100644
> index 000000000000..ba4fe2e4d749
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-irl-ext.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/renesas,sh7751-irl-ext.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas SH7751 IRL external encoder with enable regs.

IRL? In Real Life?

> +
> +maintainers:
> +  - Yoshinori Sato <ysato@users.sourceforge.jp>
> +
> +description: |

Don't need '|' if no formatting to preserve.

> +  This is the generally used external interrupt encoder on SH7751 based boards.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: renesas,sh7751-irl-ext
> +
> +  reg:
> +    minItems: 1

maxItems: 1

> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 1
> +
> +  '#address-cells':
> +    const: 0
> +
> +  '#size-cells':
> +    const: 0

Don't need #size-cells.

> +
> +  renesas,width:
> +    description: Enable register width
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [8, 16, 32]

reg-io-width is the standard property for this purpose.

> +
> +  renesas,set-to-disable:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: Setting this flag to 1 disables it.

You can't set a boolean to 1. What is 'it' here? 

> +
> +  renesas,enable-bit:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array

You've described a 2 entry matrix, not an array.

> +    description: |
> +      IRL enable register bit mapping
> +      1st word IRL
> +      2nd word bit index of enable register

Needs a better description of what this is for. If it is per SoC then it 
should be implied from the compatible string.


> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-controller
> +  - '#interrupt-cells'
> +  - renesas,width
> +  - renesas,enable-bit
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    r2dintc: sh7751irl_encoder@a4000000 {

interrupt-controller@...

Drop unused labels.

> +        compatible = "renesas,sh7751-irl-ext";
> +        reg = <0xa4000000 0x02>;
> +        interrupt-controller;
> +        #address-cells = <0>;
> +        #size-cells = <0>;
> +        #interrupt-cells = <1>;
> +        renesas,width = <16>;
> +        renesas,enable-bit = <0 11>,            /* PCI INTD */
> +                             <1 9>,             /* CF IDE */
> +                             <2 8>,             /* CF CD */
> +                             <3 12>,            /* PCI INTC */
> +                             <4 10>,            /* SM501 */
> +                             <5 6>,             /* KEY */
> +                             <6 5>,             /* RTC ALARM */
> +                             <7 4>,             /* RTC T */
> +                             <8 7>,             /* SDCARD */
> +                             <9 14>,            /* PCI INTA */
> +                             <10 13>,           /* PCI INTB */
> +                             <11 0>,            /* EXT */
> +                             <12 15>;           /* TP */

Looks like the first value is just the index of the entry, so drop it 
and use the index.

But better yet, these are all per interrupt values. Put them into the 
interrupt cell values instead. For example the RTC would have something 
like:

interrupts = <6 5>, <7 4>;

Though I do wonder if you really need the first value, or that was just 
interrupt numbers you made up and then created this mapping?

Rob

