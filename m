Return-Path: <linux-pci+bounces-1926-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A12A828629
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 13:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 331781C23A87
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 12:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096E5381D6;
	Tue,  9 Jan 2024 12:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QeIOoMPx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BEA381D1
	for <linux-pci@vger.kernel.org>; Tue,  9 Jan 2024 12:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5ebca94cf74so24318597b3.0
        for <linux-pci@vger.kernel.org>; Tue, 09 Jan 2024 04:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704804184; x=1705408984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRdzfj7JEW1eBQjWfVgccO0cPj0nGjhcrGXH3osu83E=;
        b=QeIOoMPxJmnP7J6Ahz9RoFYBBAyFE1JBl58mDEbiOpjOXlXa4xctkyQ4nrjf58hZKM
         UXAqgSfKfhBETJo7a6hI3NqYN/e/itjolyWBN7FXOOc1GVl4LoyzphSDupJkrBa6CcUx
         uhg8+zb05cg3wX8odOqH1lntKqpAMgurMrtZCrBQHowdaKJVPOJ+e0AXNkXtdjlgelGx
         e+KH88M4t756B0qSvZN4tKYQFQflFf4mg2QDBHbjdVtjW53sR3LDi55rkiBQ0f84/fuJ
         bjjACC4hup/9yntLNcJlH8FzrZr8+C15ucKIwwVU8w2GBCAXJrzU3XiImhpFHY+eE/Ve
         zvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704804184; x=1705408984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YRdzfj7JEW1eBQjWfVgccO0cPj0nGjhcrGXH3osu83E=;
        b=KJIVwWzqyDfKs16rp4ywErNidptxsZUhmOQHW4eSmgzBSiMPmfbA/BMm8p755p+SD6
         IH4WCraWYNDzMEdqeExgnqj04p9O9//2YjMq3LjqrEoeC+4zhbLsFezBGuF/JQpOgfcA
         JbIIapun1dHh4CX8OxQvqHWnn1D2fSDrnAKDXA68vyE0OrxjLrKferTT3CMXOrbdudqC
         XvCi89ItNr1Auwbt2bG4ygYHo5PVyr9wypvOIuGCUMIQRx7ybtqXvPIKpLQ7jK08ZgVk
         EmPe5WL4pEPP1KqhIa7A2/akySIqqsX8MeeFM8DhiBMRhsda3dinuMpjmqUHXZDA4HS3
         PNvg==
X-Gm-Message-State: AOJu0YxO/8nWL1HzN15yFM+zGEzIhcSzH+rgiMObjh5Urtvqk8pLp1fG
	RqIsfySua1LKYuMfY3YC+rTnRHqK3gSlKUmoUCqf8cwn+1Vi6Q==
X-Google-Smtp-Source: AGHT+IGP2TpOD/2aQljjLpEh7rgxkZ1rPK7JLdhb+SJI4gzWB4npHJxZY6IBNmQ0p0RFR21+Q3sEEaYhEw7pDx3EeW0=
X-Received: by 2002:a0d:cb85:0:b0:5f1:7189:b9d with SMTP id
 n127-20020a0dcb85000000b005f171890b9dmr2932736ywd.82.1704804184379; Tue, 09
 Jan 2024 04:43:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704788539.git.ysato@users.sourceforge.jp> <160ee086771703c951c5522d997662aeac122a28.1704788539.git.ysato@users.sourceforge.jp>
In-Reply-To: <160ee086771703c951c5522d997662aeac122a28.1704788539.git.ysato@users.sourceforge.jp>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 9 Jan 2024 13:42:53 +0100
Message-ID: <CACRpkdZMkyJdkFt_x-6iubLZ-KzewvmT0zi4HAas0Xy9DpPn3g@mail.gmail.com>
Subject: Re: [DO NOT MERGE v6 12/37] dt-bindings: pci: pci-sh7751: Add SH7751 PCI
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
	Randy Dunlap <rdunlap@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka <vbabka@suse.cz>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, David Rientjes <rientjes@google.com>, Baoquan He <bhe@redhat.com>, 
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

Hi Yoshinori,

thanks for your patch!

On Tue, Jan 9, 2024 at 9:24=E2=80=AFAM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:

> Renesas SH7751 PCI Controller json-schema.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
(...)
> +  renesas,bus-arbit-round-robin:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      Set DMA bus arbitration to round robin.
> +
> +  pci-command-reg-fast-back-to-back:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      Set for PCI command register Fast Back-to-Back enable bit.
> +
> +  pci-command-reg-serr:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      Set for PCI command register SERR# enable.
> +
> +  pci-command-reg-wait-cycle-control:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      Set for PCI command register Wait cycle control bit.
> +
> +  pci-command-reg-parity-error-response:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      Set for PCI Command register Parity error response bit.
> +
> +  pci-command-reg-vga-snoop:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      Set for PCI Command register VGA palette snoop bit.
> +
> +  pci-command-reg-write-invalidate:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      Set for PCI Command register Memory write and invaldate enable bit=
.
> +
> +  pci-command-reg-special-cycle:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      Set for PCI Command register Special cycle bit.
> +
> +  pci-command-reg-bus-master:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      Set for PCI Command register Bus master bit.
> +
> +  pci-command-reg-memory-space:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      Set for PCI Command register Memory space bit.
> +
> +  pci-command-reg-io-space:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      Set for PCI Command register I/O space bit.

Do you really need to configure all these things? It seems they are
just set to default values anyway?

Can't you just look at the compatible "renesas,sh7751-pci" and
set it to the values you know are needed for that compatible?

> +  pci-bar:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    description: Overwrite to  PCI CONFIG Base Address Registers value.
> +    items:
> +      items:
> +        - description: BAR register number
> +        - description: BAR register value
> +    minItems: 1
> +    maxItems: 6

Same with this, isn't this always the same (hardcoded) values
for "renesas,sh7751-pci" if used?

> +            interrupt-map =3D <0x0000 0 0 1 &julianintc 5>,
> +                            <0x0000 0 0 2 &julianintc 6>,
> +                            <0x0000 0 0 3 &julianintc 7>,
> +                            <0x0000 0 0 4 &julianintc 8>,
> +                            <0x0800 0 0 1 &julianintc 6>,
> +                            <0x0800 0 0 2 &julianintc 7>,
> +                            <0x0800 0 0 3 &julianintc 8>,
> +                            <0x0800 0 0 4 &julianintc 5>,
> +                            <0x1000 0 0 1 &julianintc 7>,
> +                            <0x1000 0 0 2 &julianintc 8>,
> +                            <0x1000 0 0 3 &julianintc 5>,
> +                            <0x1000 0 0 4 &julianintc 6>;

This interrupt-map looks very strange, usually the last cell is the polarit=
y
flag and here it is omitted? I would expect something like:

<0x0000 0 0 1 &julianintc 5 IRQ_TYPE_LEVEL_LOW>, (...)

The interrupt-map schema in dtschema isn't really looking at this
so it is easy to get it wrong.

Yours,
Linus Walleij

