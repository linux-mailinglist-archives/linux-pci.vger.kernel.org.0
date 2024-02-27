Return-Path: <linux-pci+bounces-4150-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C108869F65
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 19:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EB2DB25756
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 18:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64525103E;
	Tue, 27 Feb 2024 18:48:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2264D4F896;
	Tue, 27 Feb 2024 18:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709059706; cv=none; b=YLLPKGjvNGtfqe6En1Kt+QT7ZvIeHAagE5BGVTtXnb9ExDYIMKWy9AEbsE2C3YQ0drXkx1Zf6jyr2POqTxY+DmzDlyAVq8OnhCJRNBDelHB+6lXl5NOWmi13jWShWUwFUZUauDL5BbboNP/AdIczO37ygYyfBmc8SVfl72wEbiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709059706; c=relaxed/simple;
	bh=K6sBGdbZzNVAu30o0m9zj5R6b0ZvSIScFMAacNUig9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A9L8f+yCZiWrsb9KFzREKfCR9sCKBAgVji3Y2ouVkSSIBu0BUatdVNH9K9JNvfIRINxvuaQIgo2se0RQ792Ypy7pa3E16+nSKk/XZuY0a5/lQCcxA1qSJo8gYWpsgic6ATP7+KIQZTo8eRsXxOGZI3zThVdxV1vOSmVtfYxmZ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-607e54b6cf5so636757b3.0;
        Tue, 27 Feb 2024 10:48:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709059703; x=1709664503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBLgqi5po9yo82z/olqeDeT73/ia9ZIG/TwGXRPLny8=;
        b=duqhZPgkWmeoxbNs7ktjq+XRA1m9gLxuWC99Ub1nfIbCpbiohp88opEaFLo/haU3L7
         7pAMS52PDb6kwRYcmk2P0EckVMrTw58qhZZN1Mkd0kV8c9YOUJjQfkqBVm+v9ZnMa01c
         sGO3Dxtsn4FGRxpEkt4VTt3f8SIQRqZPk1ClMCh4wF2Z4rbJl9Ch5jb3hVIlN6hUK9QX
         bb1VnYXh42KcjJrvk/c0uPVLDjMzDPETwrERa4M629O0LrPufFbIa+zK5Ljov/wdR1MW
         yBkTU9jFYsZXa62aukcdgsO3ty5ulYVMxwLQ40FsZJg2pS8tAgyvhuPxVCXEzPw0qmWk
         rCmw==
X-Forwarded-Encrypted: i=1; AJvYcCWu7F2I90K4SWitxrjT90gyrCacDx0G9zUeRvajk8JusIFZj3CT2sDk0VgoVSZk7u8zUf4EXpZTpmFxVVcu4BuofNYWplGVMeeauFIxmTiEIFh2b69Y94WZzFtpWJOQKv8MXduGzS5mugpVsq1WA4n1302hVeS08nxRo33RXV1xNuivKJwVoRc1XwyjZYttQNQTiJy8CH+GhVfZiHJKq+B5mfiPWV4U42WEofHVe8CD6wjENqnVKJCNRSbDRUzyphPveQwpqtdUTlpEDsILjKXGedwCJpJKB2k0Lb4nfBaDjlUaqN0JvpX0xWLZa5kkbcoK1gAeFzg7YjEjvTODzNis7AlCNH88bEuZ6qwcyUsz6OEGEwMEbGo=
X-Gm-Message-State: AOJu0YxW6cXm9QGzKfil3bq9p9KV44qxAz2yeSDQBprfSlR+t0INSkIm
	KtJgkItIbKgqdA9Ys0846GGIF4vMxK9hah65qk2QLV3enx+p2+A2M9JiojLThQc9ww==
X-Google-Smtp-Source: AGHT+IHp4ttFqyGxEuYRKTECeut2dpV2OBGlwHOfXPHFmeefIycTWfO9rwvdcCsBB23ujkYLAW1KtA==
X-Received: by 2002:a81:84d7:0:b0:609:106b:5bbb with SMTP id u206-20020a8184d7000000b00609106b5bbbmr183556ywf.9.1709059703123;
        Tue, 27 Feb 2024 10:48:23 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id d199-20020a0ddbd0000000b0060867d09de2sm1909370ywe.29.2024.02.27.10.48.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 10:48:23 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dbed179f0faso56062276.1;
        Tue, 27 Feb 2024 10:48:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXfuBPDJb2rm861gPTQwoiwXHdP1paOOqnalj+4pZEw0ubdMsjI0JKEuYXJAFnyQ2XOAP78A2M/j3AFM9Q5B8oIvzRfTIXTy1F0rQ0YDw4VsHPad8VRXx8jN+A682GpBQgC7XVuF+IbnX7hx3ttVRqvdWzvWnTZIxlpJPrr8nscLSlTl9/EsRNtQWA3eRh9aZjC8VODywahcnXGX2hmNJItGTEgMFjravnW2YOdwmgHitMo8EIL2JeGyE6KYFH/YIJZXQM96KLW9LXWrGoxzmuvVf4ny74n3JEasqbyXWws0UKPeFp6IDnqfOSTORYkzcNDilElpLtNSuwOvuVBIx0/ZL2jN0dXSh9cDdNthCM39asos+vE2mc=
X-Received: by 2002:a25:414a:0:b0:dc7:494e:ff33 with SMTP id
 o71-20020a25414a000000b00dc7494eff33mr220625yba.7.1709059702806; Tue, 27 Feb
 2024 10:48:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704788539.git.ysato@users.sourceforge.jp> <f1f58604dd76520005c12479fada0b70ac210f89.1704788539.git.ysato@users.sourceforge.jp>
In-Reply-To: <f1f58604dd76520005c12479fada0b70ac210f89.1704788539.git.ysato@users.sourceforge.jp>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Feb 2024 19:48:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUxZzBD0WRhx07MYdLvamg+1twRvAxGMRM5+4-pYeDTRQ@mail.gmail.com>
Message-ID: <CAMuHMdUxZzBD0WRhx07MYdLvamg+1twRvAxGMRM5+4-pYeDTRQ@mail.gmail.com>
Subject: Re: [DO NOT MERGE v6 34/37] sh: Add dtbs target support.
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

