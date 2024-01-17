Return-Path: <linux-pci+bounces-2258-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5D0830342
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 11:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48DA21C25074
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 10:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16BF14291;
	Wed, 17 Jan 2024 10:06:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0975014282;
	Wed, 17 Jan 2024 10:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705485978; cv=none; b=pQBfCZa5Xvg+AfObSRFSv6xGACocS7axxPOJkr5ptCbNWh+PyPeCVpxWlw5qNQskovfXS3DBdePfN/VsGlXbeMh/t+DPxYKX5k2vm71ED3uHvCjMhC/JeCcwgGD+VEpe+RIkciK5seXZyIcrU9/MnA6DM1rF3lhJc3k2KwU7Sqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705485978; c=relaxed/simple;
	bh=+cxx2b/N2LvNg0nWquPf/YpjQZ5mfMypJFmZWd9uQdc=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:Received:Received:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding; b=tBoWVinOOOmBbgRDjAGq9ns14o2g5VemiOeTCg7rmZ+DoPGbJT7PsjpOlWBwBENr2aJrXQo5971fe1EeRrzwYMMOSZG036+B4NiDk9DNWZ0md+jAn4unqncTkVIeRuCUTpMYFwum1WCYVKGFLnAhp38fGxhzI70iZS0sEa1ZRvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5f68af028afso92131237b3.2;
        Wed, 17 Jan 2024 02:06:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705485975; x=1706090775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktKDg1Kr1k5upORAnFgj9TjW3VLUUCKOkhGf1ZiTWq0=;
        b=mFJmS23fQc++YO/zFXRwgtK6yS1H0p2B67RZ2WrktMJuaSr5q5ZP3fK9FDOT2tjwKl
         wBxJEpMKMTENBQzLKB+5gNSc7haazIGK4bGuaz8TK6YBCOAllduQ84NTI3IvaI6++QIc
         Jn9Zw2idHIJB3te/cb2s13XR1OdnPUX5xBmcjeUJasUnKZEKoSM1XMoTPqj1T87k84UT
         qEFtmf+LnWplPEoZ65rE101grFNd28WywjsWwRenMZNh7TkKG/GcnLx82yL3LQKFCtEq
         DsVssmQvaLX2oXctuwnWlxFux+KEcdc1PABMOxRAIU8+UsGk8aJyLtw/EHJwPn7yFLKd
         dvxg==
X-Gm-Message-State: AOJu0YwyXFpO1PtvBCus81+IgUNlnvrvx4eAom/zIY7agMz4xtctefIn
	TY0sYB6u9Q8JzIdrL/VneoD5tnu31BOVvQ==
X-Google-Smtp-Source: AGHT+IGvsKro72mIsn7zC0rDold1fCYfQbqHaTRxf3TuiU8P9HI/5ZCiNSd7B6rJpaD3yJoF6v7fBw==
X-Received: by 2002:a81:e602:0:b0:5ee:65b3:f289 with SMTP id u2-20020a81e602000000b005ee65b3f289mr4814207ywl.3.1705485974739;
        Wed, 17 Jan 2024 02:06:14 -0800 (PST)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id d4-20020a0ddb04000000b005ff5fc95e34sm982467ywe.55.2024.01.17.02.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 02:06:14 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5e54d40cca2so83078567b3.3;
        Wed, 17 Jan 2024 02:06:14 -0800 (PST)
X-Received: by 2002:a05:690c:fd5:b0:5ee:7299:e2cf with SMTP id
 dg21-20020a05690c0fd500b005ee7299e2cfmr5153857ywb.52.1705485974135; Wed, 17
 Jan 2024 02:06:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704788539.git.ysato@users.sourceforge.jp>
 <bc794e2165244bd0cee81bc0106f1e2d1bef1613.1704788539.git.ysato@users.sourceforge.jp>
 <CACRpkdYLsf-uWdMCTpieji7u1-H3oTGojvC4xm7Erox97XJ6RQ@mail.gmail.com> <8734uwwavx.wl-ysato@users.sourceforge.jp>
In-Reply-To: <8734uwwavx.wl-ysato@users.sourceforge.jp>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 17 Jan 2024 11:06:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX_2Tgm2LLM1TgFrkLdokD99gAeKHJWrKy9Y2A+wtf5RA@mail.gmail.com>
Message-ID: <CAMuHMdX_2Tgm2LLM1TgFrkLdokD99gAeKHJWrKy9Y2A+wtf5RA@mail.gmail.com>
Subject: Re: [DO NOT MERGE v6 17/37] dt-bindings: interrupt-controller:
 renesas,sh7751-intc: Add json-schema
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-sh@vger.kernel.org, 
	Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
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

Hi Sato-san,

On Wed, Jan 17, 2024 at 10:46=E2=80=AFAM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> On Tue, 09 Jan 2024 21:30:34 +0900,
> Linus Walleij wrote:
> > On Tue, Jan 9, 2024 at 9:24=E2=80=AFAM Yoshinori Sato
> > <ysato@users.sourceforge.jp> wrote:
> >
> > > +  renesas,icr-irlm:
> > > +    $ref: /schemas/types.yaml#/definitions/flag
> > > +    description: If true four independent interrupt requests mode (I=
CR.IRLM is 1).
> > > +
> > > +  renesas,ipr-map:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > +    description: |
> > > +      IRQ to IPR mapping definition.
> > > +      1st - INTEVT code
> > > +      2nd - Register
> > > +      3rd - bit index
> >
> > (...)
> >
> > > +            renesas,ipr-map =3D <0x240 IPRD IPR_B12>, /* IRL0 */
> > > +                              <0x2a0 IPRD IPR_B8>,  /* IRL1 */
> > > +                              <0x300 IPRD IPR_B4>,  /* IRL2 */
> > > +                              <0x360 IPRD IPR_B0>,  /* IRL3 */
> > (...)
> >
> > Is it really necessary to have all this in the device tree?
> >
> > You know from the compatible that this is "renesas,sh7751-intc"
> > and I bet this table will be the same for any sh7751 right?
> >
> > Then just put it in a table in the driver instead and skip this from
> > the device tree and bindings. If more interrupt controllers need
> > to be supported by the driver, you can simply look up the table from
> > the compatible string.
>
> The SH interrupt controller has the same structure, only this part is dif=
ferent for each SoC.
> Currently, we are targeting only the 7751, but in the future we plan to h=
andle all SoCs.
> Is it better to differentiate SoC only by compatible?

Yes, it is better to differentiate SoC only by compatible value.

When you describe all differences explicitly using properties, you
might discover later that you missed something important, causing
backwards compatibility issues with old DTBs.
DT is a stable ABI, while you can always update a driver when needed.

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

