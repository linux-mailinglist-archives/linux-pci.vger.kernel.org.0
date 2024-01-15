Return-Path: <linux-pci+bounces-2143-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B54782D601
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jan 2024 10:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED351F21E1B
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jan 2024 09:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80996D275;
	Mon, 15 Jan 2024 09:29:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18989F4E3;
	Mon, 15 Jan 2024 09:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5efb0e180f0so84137307b3.1;
        Mon, 15 Jan 2024 01:29:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705310994; x=1705915794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJZ9RgNzg7VLWUx8YQuwC3dXe057PkvGB0IXNBt0r28=;
        b=dtfes5M+7LLvHlCbwZEEyxf5Qi3hJR1D3kdnXnKkzzG/eWCbzMvNID54EB2novQQ0+
         zpfggxrpOp7XhEV9BSuuqt/z4hXnDSpNAfceK9kpN6fMpfdtRrY3XsxvRHfDGunrw3h5
         GrZOV1tlPU2ufXGtaPhAehbmLmWV9tMiJqb91fIxlWX9nWpkh2TxWr1avfw6NZiBXEry
         URtSUV/CjwPzgGoTOuoBfV2tc68oNOKay62kwFGwYsZ/GuLHPaGISICOSNOAqrWhmsPQ
         kC+uRu0EDzqbLs2kZOinC/UwwAfPNs/gwz8ik5zkrAgh4WcJ1jA7r0K11E5Y7IWUOmZu
         Fd6g==
X-Gm-Message-State: AOJu0YwP+L+kp2HeVSS2w+Adod0ZZCp8MU4s1DSguDfFsUdQdoDsSYS5
	aDUa5pTVyV/ut28OKqn0Y3Dd+ziqxjLL8g==
X-Google-Smtp-Source: AGHT+IHNpy1SfNWdjqyl21eVF7EgjPpYGMelhc9v7045OlQYeXup7+ylWjrrQcklwFuBy1UkQgPi2A==
X-Received: by 2002:a81:9b0f:0:b0:5e9:d166:2438 with SMTP id s15-20020a819b0f000000b005e9d1662438mr3417304ywg.86.1705310994190;
        Mon, 15 Jan 2024 01:29:54 -0800 (PST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id s7-20020a817707000000b005e3f0da06ffsm3843909ywc.34.2024.01.15.01.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 01:29:53 -0800 (PST)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5efb0e180f0so84136827b3.1;
        Mon, 15 Jan 2024 01:29:53 -0800 (PST)
X-Received: by 2002:a81:8395:0:b0:5ca:607e:b16e with SMTP id
 t143-20020a818395000000b005ca607eb16emr3313628ywf.0.1705310992678; Mon, 15
 Jan 2024 01:29:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704788539.git.ysato@users.sourceforge.jp> <dbaaf58b50b681cf03bc5ad3eef0a546fe863bca.1704788539.git.ysato@users.sourceforge.jp>
In-Reply-To: <dbaaf58b50b681cf03bc5ad3eef0a546fe863bca.1704788539.git.ysato@users.sourceforge.jp>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Jan 2024 10:29:41 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXw=FC5EsYSHw6y2GzT9pNPNEB1iO3DRVmMLjzuPfx8nQ@mail.gmail.com>
Message-ID: <CAMuHMdXw=FC5EsYSHw6y2GzT9pNPNEB1iO3DRVmMLjzuPfx8nQ@mail.gmail.com>
Subject: Re: [DO NOT MERGE v6 21/37] dt-bindings: serial: renesas,scif: Add scif-sh7751.
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

On Tue, Jan 9, 2024 at 9:24=E2=80=AFAM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Add Renesas SH7751 SCIF.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

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

