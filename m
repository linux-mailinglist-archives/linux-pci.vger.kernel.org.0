Return-Path: <linux-pci+bounces-4131-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B31869AB9
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 16:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D283CB27FE4
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 15:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB3414532C;
	Tue, 27 Feb 2024 15:42:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AEE145351;
	Tue, 27 Feb 2024 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048535; cv=none; b=aE2IVL4oC/XbovkX8jmCM8tVb8Nz1v6r962UYPTzYxDQ+F4IkVT3AK0IwilGyPTFF5Tkf3oIdrE/c8/byAwY8yRJdw3SQSTuzfaaj5OsKxPHz3sWtzVAXfqCyd7zPR1QoI100Etw/OVDbUrXsAJPU/F9AGOEhUyNMYbNtu9bD0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048535; c=relaxed/simple;
	bh=8RA+fvGI7H8/KVOcw5fiLDDRe4rFaB568t+6OOKeC2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p+3x4ApVRN1NxraBXCIS33KMvabtzT2MR8CoZaM/kuuahjCX2hC3bzrKN9DATmLxIFy/7C7mo5yvopxsDp8U9LKgr7QmK4MM5TMYcC4DZe3k+ik67c7DoZXOzfiWL7uCwM5Kamql3o0SzTFvmrZidFQrakqwTJ6p4PzZdaL+T9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcbc00f6c04so4540504276.3;
        Tue, 27 Feb 2024 07:42:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709048528; x=1709653328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PepN+vzOJ7FGNHjryvCGPsAuXBvDik+gwGMOhn9mKt8=;
        b=N6wctiwwpFmbv9BAb4BDuHk+YeQStoucApHGbpiSurAtmjS+jzhQX7qlLRFr+duC6C
         i9MVPilOmUcq8Wkhp4vcwRicsn8diYVNOuWM/+J1Dt7N8ywLcHbH1vyHBRlVTFzHgl+N
         3Zx4YH7juiK/0xiQ/1GFLd5/3jJDaX3xXZE+cZPEJBRSB6kWAA59g+6AUDkdYSbW2SQo
         xfyUrt+VRUvq+nVXerSZN4F+u4+FIio/j6vboTtkFrktSGotG3Ag56K/J640SpUvZZCp
         nx0lshSzedd4PZHYdCG2snii/suD2IL6CDHIhOZf9ko6+oTv3peosKRrOoqKSQYViXzB
         iJPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXm10v4OnaK9P/TbR7VSgCjlnzcpR8Y/+Fhaml50F3CKFgjrlJf2tm0mVTOM/Y5OWgRG6jUPKQ/wiw6QsSfwEZtSDcG7RnBVE5f2EPlVmjYeYxBjB2sk5OnVR3mKGlQOh8dB/SWiknRx6kL0mQ7L4kdleIidZQBhnpW8nJH7OqR2ujunPIVVPXCjpH1wWqm3TR6eYnP7kDSzvBsZtsS6W6U0aIhNnCAXzhvR4bKqYnSYw+ZJntdfUPj3iitrnnGSW3qevnDM3LZtOh52/pwyB4S7s7bAFw5wst5Z4SSVBZjBtrMMR9YSoBbCdmeqrLAcxWEM7Ex4CxBp4Zq2NlTqyprkzNnfp0sqqOLaHZP8a8G1vqrBIAkBKc=
X-Gm-Message-State: AOJu0YxiTJXYjYkKWUAJeLrwAm230U/o2QoC7OBIVdKcytvGlV5Bt9wj
	qXKEwCo5iZu9GXXZzXzcoXdw6sosomujJt7hRfNgrWD2CxsWuIuDZhyPGR5ndmk=
X-Google-Smtp-Source: AGHT+IEUcfdqh71Dtl7eW8/tkosUi5WmMzjDNAqSGpKFhGK2wgo/gMrGDS2YM3WM69M9FP1mi9359g==
X-Received: by 2002:a25:6c8a:0:b0:dcc:b719:4e4f with SMTP id h132-20020a256c8a000000b00dccb7194e4fmr2370192ybc.53.1709048527700;
        Tue, 27 Feb 2024 07:42:07 -0800 (PST)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id g12-20020a25ef0c000000b00dcd56356c80sm1422691ybd.47.2024.02.27.07.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 07:42:07 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dbed0710c74so3987152276.1;
        Tue, 27 Feb 2024 07:42:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWfO9wEY764J3VK0NnmS+VTkQP0AFYTR2L5vMuQPjIzDvPJ6Lycky+djp5Jk3CC6Cw0GP14KSOvyzmF6Q4u2nYJmLf+xNJjeAd6qMOTYMQjcvHKzn8XrdLkadou7G68TT1YOPw9q50Tvb+RBmjt/0xtsO/lkkDan/E6aBlNur4hugmS5Su0FY1LleKIREhLOdZ3yMZ8JpX5u7jQYov4PtgeAaE1SeLQp19kxkbzwiFBHnfOugndwJ7/KcAWtpzFAeEZbb2wShKjGGbVSAqo8fLS2uY9uuou03yUNvunllulsLwD20XLvIK0cq8BtR8ATlv1bO4XlWWWkasJNTjM8GVPaRwgBc4ICsAdFpklxyiO7rE/PnIDPro=
X-Received: by 2002:a05:6902:2412:b0:dc7:4cb1:6817 with SMTP id
 dr18-20020a056902241200b00dc74cb16817mr2901377ybb.22.1709048525820; Tue, 27
 Feb 2024 07:42:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704788539.git.ysato@users.sourceforge.jp> <222dd134b5e1c8cc5baa7afc64a3441a8174e979.1704788539.git.ysato@users.sourceforge.jp>
In-Reply-To: <222dd134b5e1c8cc5baa7afc64a3441a8174e979.1704788539.git.ysato@users.sourceforge.jp>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Feb 2024 16:41:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVxWrrKT8H_47EPjZ61QnEvvtrZYXFo=FmozhVeYf=4Bw@mail.gmail.com>
Message-ID: <CAMuHMdVxWrrKT8H_47EPjZ61QnEvvtrZYXFo=FmozhVeYf=4Bw@mail.gmail.com>
Subject: Re: [DO NOT MERGE v6 14/37] clk: Compatible with narrow registers
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

On Tue, Jan 9, 2024 at 9:24=E2=80=AFAM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> divider and gate only support 32-bit registers.
> Older hardware uses narrower registers, so I want to be able to handle
> 8-bit and 16-bit wide registers.
>
> Seven clk_divider flags are used, and if I add flags for 8bit access and
> 16bit access, 8bit will not be enough, so I expanded it to u16.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> --- a/drivers/clk/clk-gate.c
> +++ b/drivers/clk/clk-gate.c
> @@ -143,6 +161,18 @@ struct clk_hw *__clk_hw_register_gate(struct device =
*dev,
>                         return ERR_PTR(-EINVAL);
>                 }

Please add a check for invalid CLK_GATE_HIWORD_MASK
and register width combinations:

                if (clk_gate_flags & (CLK_GATE_REG_16BIT | CLK_GATE_REG_8BI=
T)) {
                        pr_err("HIWORD_MASK needs 32-bit registers\n");
                        return ERR_PTR(-EINVAL);
                }

>         }
> +       if (clk_gate_flags & CLK_GATE_REG_16BIT) {
> +               if (bit_idx > 15) {
> +                       pr_err("gate bit exceeds 16 bits\n");
> +                       return ERR_PTR(-EINVAL);
> +               }
> +       }
> +       if (clk_gate_flags & CLK_GATE_REG_8BIT) {
> +               if (bit_idx > 7) {
> +                       pr_err("gate bit exceeds 8 bits\n");
> +                       return ERR_PTR(-EINVAL);
> +               }
> +       }
>
>         /* allocate the gate */
>         gate =3D kzalloc(sizeof(*gate), GFP_KERNEL);
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index ace3a4ce2fc9..e2dfc1f083f4 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -508,12 +508,16 @@ void of_fixed_clk_setup(struct device_node *np);
>   * CLK_GATE_BIG_ENDIAN - by default little endian register accesses are =
used for
>   *     the gate register.  Setting this flag makes the register accesses=
 big
>   *     endian.
> + * CLK_GATE_REG_8BIT - by default 32bit register accesses are used for
> + *     the gate register.  Setting this flag makes the register accesses=
 8bit.
> + * CLK_GATE_REG_16BIT - by default 32bit register accesses are used for
> + *     the gate register.  Setting this flag makes the register accesses=
 16bit.
>   */
>  struct clk_gate {
>         struct clk_hw hw;
>         void __iomem    *reg;
>         u8              bit_idx;
> -       u8              flags;
> +       u32             flags;

There is no need to increase the size of the flags field for the gate clock=
.

>         spinlock_t      *lock;
>  };
>
> @@ -522,6 +526,8 @@ struct clk_gate {
>  #define CLK_GATE_SET_TO_DISABLE                BIT(0)
>  #define CLK_GATE_HIWORD_MASK           BIT(1)
>  #define CLK_GATE_BIG_ENDIAN            BIT(2)
> +#define CLK_GATE_REG_8BIT              BIT(3)
> +#define CLK_GATE_REG_16BIT             BIT(4)
>
>  extern const struct clk_ops clk_gate_ops;
>  struct clk_hw *__clk_hw_register_gate(struct device *dev,

The rest LGTM.

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

