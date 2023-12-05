Return-Path: <linux-pci+bounces-502-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFE78058CE
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 16:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA2751F2178F
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 15:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D235F1DB;
	Tue,  5 Dec 2023 15:34:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F6183;
	Tue,  5 Dec 2023 07:34:08 -0800 (PST)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-58cf894544cso3805165eaf.3;
        Tue, 05 Dec 2023 07:34:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701790447; x=1702395247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmso+Pyj6M965irEbY4qayX9k2jAUb4uqdD1fkCcZ8k=;
        b=M/RKZM5r/HuKXnlC1AwALHy5A+1lNsS+ak67KBIDWzWW+e7oHEV4wYIjG0ktIvAWy4
         o9Ms/FFY8HQaR9r7wE1/rpI9mJrYtszZgS5jYBdYf4n83Xcfd2BZWcJKTnyJ2U83rg01
         9ea2Z3gl5ClaEU3zl0EHZtuVZfEe/Vg6sE9ggU2KHkH+BjlmEUDiKxFlZQ6oZK3leDFz
         GoEbykehqL9BhilkUCuvfeKW29oBuJhF1dQye6mHjCNX7nHOGCnWi7fWbAWrdR/fXa03
         hUMHXiBpFrl1oE1WoZOz3uGdIVrUmju9avN50gbykN8houelAidusLZqtEh7UFXY9oWA
         EQOQ==
X-Gm-Message-State: AOJu0YxnUAk7x2svdmMZiOnEuWFZ68xEB0XD86vs/y323StpSZmB2OFx
	3JPG85CBZO9yOSHGA3VfT+eyowbThClxrA==
X-Google-Smtp-Source: AGHT+IHN27ceI6iE1qZK+w6GzBy7WUpyNrFEpcC/23a2CRIYnX4f35zGNmGu2LTRothRE/zTzLr3Qg==
X-Received: by 2002:a05:6820:2221:b0:58d:9942:b49 with SMTP id cj33-20020a056820222100b0058d99420b49mr6327142oob.9.1701790447130;
        Tue, 05 Dec 2023 07:34:07 -0800 (PST)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com. [209.85.167.173])
        by smtp.gmail.com with ESMTPSA id 187-20020a4a14c4000000b0058a2872d1d6sm2412397ood.42.2023.12.05.07.34.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 07:34:06 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3b8b556aadbso2132370b6e.3;
        Tue, 05 Dec 2023 07:34:06 -0800 (PST)
X-Received: by 2002:a0d:df11:0:b0:5d5:c6c1:3522 with SMTP id
 i17-20020a0ddf11000000b005d5c6c13522mr2801851ywe.26.1701790046878; Tue, 05
 Dec 2023 07:27:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701768028.git.ysato@users.sourceforge.jp> <e147fd6dd7aba44a6f408c3a42076b207be862fb.1701768028.git.ysato@users.sourceforge.jp>
In-Reply-To: <e147fd6dd7aba44a6f408c3a42076b207be862fb.1701768028.git.ysato@users.sourceforge.jp>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 5 Dec 2023 16:27:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWZo5EwZZmgDC-nEwwKz5oLvjpz9iY022kv5KwbV7b_gA@mail.gmail.com>
Message-ID: <CAMuHMdWZo5EwZZmgDC-nEwwKz5oLvjpz9iY022kv5KwbV7b_gA@mail.gmail.com>
Subject: Re: [DO NOT MERGE v5 20/37] serial: sh-sci: fix SH4 OF support.
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
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

Thanks for your patch!

On Tue, Dec 5, 2023 at 10:46=E2=80=AFAM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> - fix earlycon name.
> - fix earlyprintk hung (NULL pointer reference).

- fix SERIAL_SH_SCI_EARLYCON enablement

> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -658,7 +658,7 @@ config SERIAL_SH_SCI_EARLYCON
>         depends on SERIAL_SH_SCI=3Dy
>         select SERIAL_CORE_CONSOLE
>         select SERIAL_EARLYCON
> -       default ARCH_RENESAS
> +       default ARCH_RENESAS || SUPERH
>
>  config SERIAL_SH_SCI_DMA
>         bool "DMA support" if EXPERT

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

