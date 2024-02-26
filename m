Return-Path: <linux-pci+bounces-4025-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA6D867BA6
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 17:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EC881C2A0C1
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 16:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695E212CDAE;
	Mon, 26 Feb 2024 16:21:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B85812CD8F;
	Mon, 26 Feb 2024 16:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964494; cv=none; b=GxiKgcysqFOkPLUZ1IuqCrnetpUoELtOWW0CA2OaDWNihd5GNpCPX7ykqw+HBJAEqvsp1Mu3JGsSwOdJj/pJ8/WmRqWgSgJjJHf7L54HCe9KAOZMd4aVznNAB4TwPKZwJ7DPEE8x7orlX9qNeluKcXtHbhIbPozpl06u501Zwbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964494; c=relaxed/simple;
	bh=K8Zp0ZPKDcwcP3G/KRjzFIjbZsJkztFYeVAPVMu3ls8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jaU+dAw9IG0T/+RjLslPCJ7CMFdSiuBrrhI72cj3fpSklsy21NYfI+fvGZlOvcGF68NsUMTzQpXLYKREu/FFRm2xD7HsAA8QZh6locuNSWUuiBlup6DertHPu6G7c5BnAMmRtE+uHQfYUQnA+aniDLr2OjAVlCSnxACdAS8qLNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso3012295276.3;
        Mon, 26 Feb 2024 08:21:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708964488; x=1709569288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AnNfNm5GP8AlHR3LpO3OZDALnBwQPt1VpdE5YdvyhHU=;
        b=FVnpkMWODbp4c5fW2UFshr2DOS6ND2QSWBJ96wrSUsYfNeHmiEw68PeRPLajn1WFVJ
         3A4auSk7dBLYT9PHhzXsQN3UvDp6ciDmKi+gpjZuVoypDpQLbPOdFxB3n8QjBl0k1ttZ
         4ibqSJPlm4m0oqQ4vJQLJJtJyblmBFtXOIkuXsYjKmLDsZDlZ6sD0CZrqQJg/XiI9Qrr
         XIrxk/xfYEnGoOG3yEbOQj/6XAA9Ed8zaWXYAQap8o/4yd8PLAsYJyasNfssnhMckVYb
         2ujHhjbPlrnu2jESuNXNyiPZmDgE4mWnxLZJ/HE/ZF0H6fjb1XshkNcf3wAGPjRjBjLF
         54Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXShRe8maavP53tYStEtKgKz8neu6AFmiEHZbDSs9yJtoXLB4o7X9SClhCyoRJ8rBHsWoIqbytyflsmm4zqC3O0ODnLbpceL4cufCRJHxcc85/B7dGm7yTnfiOYgmLadxLBw16O1S7b9eGVGPAtD+1cR2iEN7455fW2gxdoEbfmqy8cYw06Fys01Uyhp/G+SYxO2rNJ3XfZLWe6oXVn5qdl9ip4VrfHfUWSBMlx+W+SE7wObjWdP4ze1KdB9FFzu6/0YsoFQQEqJAyVq9jmiZyU8/TjnyBlqKDhSfz51+jBIEyqQM3aw11XR5w+cRlrnXqzg9vWD+A4KDSB25a5KVOMQBxQn5vN4ZqwPW/YX6qouFgWPMgMWeA=
X-Gm-Message-State: AOJu0Yy81+JK7ge34eIBYzpFD03VtP5Vd5q6Ycx9FBePAsB5SV3AzXcP
	JmiSQ6cvCelDrJLZTBOV3YYbvkTB8kwmYhi7qKICdWVAa00tLrnIoK5OVq5T42w=
X-Google-Smtp-Source: AGHT+IEJFJN64SqcZMHnkcdm3I6piTKl+/O4wLy59UNIzTaX9D/pCnztcN4qJmRcfE8aCJx/sq4G5Q==
X-Received: by 2002:a25:ae4f:0:b0:dcd:6722:c728 with SMTP id g15-20020a25ae4f000000b00dcd6722c728mr5196743ybe.14.1708964487740;
        Mon, 26 Feb 2024 08:21:27 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id t13-20020a25aa8d000000b00dcc620f4139sm1019289ybi.14.2024.02.26.08.21.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 08:21:27 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc23bf7e5aaso3149877276.0;
        Mon, 26 Feb 2024 08:21:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVqq+jjHfFEPR//OoVVvagRJjk2vjYlnHtyaHvCkOTs+ZFsF6i2R9w6bPoez1blin2aatCtHOQT9jQYIElkQ9XMjM9QNds8HM8FC3tlEEH9+Yi9Xgmrd9nwPw+GjrHL2P2liAGPfbKQf/35XswvsVHxtSDT/8iWz6gCPatMAF/8swgyF+Kaf15fxCjtMXc+SyGjkj04rv8XYMbPZk1keuKBa2brkuHCjSCpJvOpJhsuRu8RsF4ZbZ/3+GUzSpybSWmZSiHFZ8PUn2uIWKWeG7SID418BORxF8mxGgfXlukUXRHQRIJjgqiJWTjI5W7tkkmEpMZICjZRFqfhifFTZag09MAiRGnJus0GfeYjxe+V5h7j3PNIttU=
X-Received: by 2002:a25:360b:0:b0:dcc:35ca:aac4 with SMTP id
 d11-20020a25360b000000b00dcc35caaac4mr5201494yba.51.1708964485283; Mon, 26
 Feb 2024 08:21:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704788539.git.ysato@users.sourceforge.jp> <e5d965a1ba1447466c4a70c95b1e3aa8c1aebe4b.1704788539.git.ysato@users.sourceforge.jp>
In-Reply-To: <e5d965a1ba1447466c4a70c95b1e3aa8c1aebe4b.1704788539.git.ysato@users.sourceforge.jp>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Feb 2024 17:21:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVyz4mbExe8ZzPkVxEujYBhCBBrh88n8D6ykcZyy3=SEA@mail.gmail.com>
Message-ID: <CAMuHMdVyz4mbExe8ZzPkVxEujYBhCBBrh88n8D6ykcZyy3=SEA@mail.gmail.com>
Subject: Re: [DO NOT MERGE v6 02/37] sh: Kconfig unified OF supported targets.
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
> Targets that support OF should be treated as one board.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -710,6 +710,7 @@ choice
>         prompt "Kernel command line"
>         optional
>         default CMDLINE_OVERWRITE
> +       depends on !OF || USE_BUILTIN_DTB

This is still useful in the generic OF case.

I think it would be good to model this similar to what arm/arm64/riscv
are using (from bootloader / extend / force).

>         help
>           Setting this option allows the kernel command line arguments
>           to be set.
> diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
> index 109bec4dad94..e7e52779ef62 100644
> --- a/arch/sh/boards/Kconfig
> +++ b/arch/sh/boards/Kconfig
> @@ -19,16 +19,9 @@ config SH_DEVICE_TREE
>         select TIMER_OF
>         select COMMON_CLK
>         select GENERIC_CALIBRATE_DELAY
> -
> -config SH_JCORE_SOC
> -       bool "J-Core SoC"
> -       select SH_DEVICE_TREE
> -       select CLKSRC_JCORE_PIT
> -       select JCORE_AIC
> -       depends on CPU_J2
> -       help
> -         Select this option to include drivers core components of the
> -         J-Core SoC, including interrupt controllers and timers.
> +       select GENERIC_IRQ_CHIP
> +       select SYS_SUPPORTS_PCI
> +       select GENERIC_PCI_IOMAP if PCI
>
>  config SH_SOLUTION_ENGINE
>         bool "SolutionEngine"
> @@ -293,6 +286,7 @@ config SH_LANDISK
>         bool "LANDISK"
>         depends on CPU_SUBTYPE_SH7751R
>         select HAVE_PCI
> +       select SYS_SUPPORTS_PCI
>         help
>           I-O DATA DEVICE, INC. "LANDISK Series" support.
>
> @@ -369,6 +363,16 @@ config SH_APSH4AD0A
>         help
>           Select AP-SH4AD-0A if configuring for an ALPHAPROJECT AP-SH4AD-=
0A.
>
> +config SH_OF_BOARD
> +       bool "General Open Firmware boards"
> +       select SH_DEVICE_TREE
> +       select CLKSRC_JCORE_PIT if CPU_J2
> +       select JCORE_AIC if CPU_J2

Please move these selects to CPU_J2 instead...

> +       select HAVE_PCI if CPU_SUBTYPE_SH7751R

... and this to CPU_SUBTYPE_SH7751R, else it will become
a long unmaintainable list soon...

> +       help
> +         This board means general OF supported targets.
> +
> +

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

