Return-Path: <linux-pci+bounces-2152-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB1B82DB03
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jan 2024 15:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79F0A1C21A17
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jan 2024 14:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1951758B;
	Mon, 15 Jan 2024 14:09:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB0E17584;
	Mon, 15 Jan 2024 14:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6ddf1e88e51so3758154a34.0;
        Mon, 15 Jan 2024 06:09:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705327748; x=1705932548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I77TmnyBV7p1SE2Y2oqkytZuiHCFq9qru4QC+6Q3tDs=;
        b=U9uViIBqH/AD4sbOTMV4ejA7ZX48hzG2GZFhd3N9cyB1saPhD1AMagV8rvq8mmFon6
         uffWvqTWQ1Jj701Ne24vHN7Z5l9sMieIl7CChOOEjwFp6xohyXagu3pPBkbU/oljpWXo
         BktDfjEbVaDzx8J1vIJKEJkETen+XJAOyoPmMA3LL+zUb7pKNZdBGs3jLw6kzdptPQGj
         7lSyc1rREr2Tdr440cx+8etRAJ8ziyPy9myQkaeL1vcZV1Z5rNGwK+1yqA02zMHKhzSH
         NVnU0NrXQ9bj4d25PuIi9JaFH+QT/HR9JwrE6r5cVf78ICP90k+61KPc5UphkIF8GhOi
         vrcQ==
X-Gm-Message-State: AOJu0YxSjoeYcjX8phln59nx8gSkG/Mr4l/EOE6qxLlHg9xqPaE+Yl25
	eAPTTggoUURnAoaTRQUYWkvm/K5jYKIzyQ==
X-Google-Smtp-Source: AGHT+IGUhcozFviZ+UpZqAISh6crRPgTFd8RXsYdibuZdgCpNvHjXlQTJgtyNeXSh97xjtJwlnqQWA==
X-Received: by 2002:a05:6870:c085:b0:1fb:75a:de6f with SMTP id c5-20020a056870c08500b001fb075ade6fmr7377850oad.93.1705327748372;
        Mon, 15 Jan 2024 06:09:08 -0800 (PST)
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com. [209.85.160.48])
        by smtp.gmail.com with ESMTPSA id so11-20020a056871818b00b001fb42001fa7sm2478078oab.36.2024.01.15.06.09.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 06:09:08 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2044ecf7035so6013496fac.0;
        Mon, 15 Jan 2024 06:09:08 -0800 (PST)
X-Received: by 2002:a81:410d:0:b0:5f4:a5ab:4105 with SMTP id
 o13-20020a81410d000000b005f4a5ab4105mr2813928ywa.8.1705327425927; Mon, 15 Jan
 2024 06:03:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704788539.git.ysato@users.sourceforge.jp> <edd42bb5aa30ac3eb26a9e08b1dc6fc9041aa3b1.1704788539.git.ysato@users.sourceforge.jp>
In-Reply-To: <edd42bb5aa30ac3eb26a9e08b1dc6fc9041aa3b1.1704788539.git.ysato@users.sourceforge.jp>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Jan 2024 15:03:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU=CZVSc16FeVDc6YmTKw=xa71RUzOE3bappLwH2W8Z4w@mail.gmail.com>
Message-ID: <CAMuHMdU=CZVSc16FeVDc6YmTKw=xa71RUzOE3bappLwH2W8Z4w@mail.gmail.com>
Subject: Re: [DO NOT MERGE v6 01/37] sh: passing FDT address to kernel startup.
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

On Tue, Jan 9, 2024 at 9:23=E2=80=AFAM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> R4 is caller saved in SH ABI.
> Save it so it doesn't get corrupted until it's needed for initialization.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

My
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
on v3 is still valid.

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

