Return-Path: <linux-pci+bounces-7704-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150548CA91E
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 09:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38E901C212D9
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 07:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C1250A77;
	Tue, 21 May 2024 07:41:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5ED256A;
	Tue, 21 May 2024 07:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716277295; cv=none; b=EvFzVjXabgvQjvKYgcGihKQzAdbuTi8492Au87MxqFg7BUpQiKhdKgTOO32t90c84lgs1w5UguAiSnji7nTEgLx3c96iVbffKcAq3ONcPM4Iq9Vp+XFZy0QqhdJif2Tz3dT/kD5IotsQp4S2bf2o6Ybpz6IcrVmDEBfdxfAddlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716277295; c=relaxed/simple;
	bh=sQGLxa8ogX8RYZzuIg3igjIdlDpi7EPN50nm5hGFykw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EHNRS0VbNtkC9gzLBOiDY4htvo0Mvisd1/Ma7gv4sd0laIkysIySX2ebuDebqsLYOUIzbkfZeckxeZkQJoTkTKnM7WOzWTIcM51d0oeUGBRgPsrfWf6dS+6T5Y/k0BsLj9N0imuOmlpvL0l/k8valF4u8nCjsPv6gTXqVgd70C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-61816fc256dso34082977b3.0;
        Tue, 21 May 2024 00:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716277291; x=1716882091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WETFSWDeBrd8hie/jL0FRiOzrF4PlBR3z9DNDu6qHzE=;
        b=NzXOGItKNwuea+/+Tx+c9QHL4w3WMhoKgCDhoDgZS5pNrisCiwJfO+nwsfFwk32iqh
         RJ2No4X+xQ03kYnNp34TUD5jXp5YNP0Y/sJ4N9Qvh1RtDGvZHJqykJDYituAPR291zg4
         s3OwQcIac+wxy7OUOq6kekB/vqvyK4q+RrMe9ODORqkPfU5vRF3UX7H33CDzSgQQryzB
         0/dbz4C9Jz1/iJGyBBvtJLruJdggVJK49EI8Dqv447nZetmu/zAi0V4s0mnvnFZLtWX4
         fh1OhqYRQuJP89INEZGewJdGcJcKM4MHn2/mTPqZkgOAGn6eztFhFqm+ibN756fSiNkm
         3Kvg==
X-Forwarded-Encrypted: i=1; AJvYcCUitpllR0WMFEV48tBzT3Dz4fkXOwVl1rWIJe9PrBMqCuc5NOOoHOAlK3nMlzuGCN7UYWw72LlukEVVKmvKDNM+CLs2md3oT3QId4bC9HCUALjLgxL6L/6lJM0Ec1G42H3hm4asnZWmDK3OtZ2isNv+8JRwGVTZvNxCY6Gwq99nZ6H9LRaMwLNavKFVv76fEPA3NON/tj4hhA7lS1JZZ10wHV1JaCud7NDRQI8TeoNdQLxniCds7nBKakGDTVHF1vHedu8HVIbyA1kxG6B9pWhSPdfNMIgN2uzNsEifvL3GbeatSe+IfhtyRdBuA+wEmQMmvl3T4HxWntHqd1hwTN5j9qL4l+8lqxxJkPzA32QylEWyU2vCfE0=
X-Gm-Message-State: AOJu0YwD+N3/mY6UTJ74Y/rpGzWRKs0YrrtJxenVHhWN29FGeL7MYcVx
	1e3M7ajXVD580sX333Uk0AAqmY57AW3d79Fs/w9QgnkfqT9ubfMiYhysG/bN
X-Google-Smtp-Source: AGHT+IGftlXaBmin9/8SVBcXlvn4iHcTs6DhlgBwChGLMxTccq7qrPkzijral7e9b9QrvepOUqlBIQ==
X-Received: by 2002:a81:7b09:0:b0:618:b08:2ab6 with SMTP id 00721157ae682-627b5c795f7mr37818117b3.47.1716277290360;
        Tue, 21 May 2024 00:41:30 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e3792f0sm53026447b3.123.2024.05.21.00.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 00:41:29 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dee9943a293so3333622276.0;
        Tue, 21 May 2024 00:41:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUaR4ygibIAFqqaP3i98l+aX47/ywwBtnzyjST6haD+R5cmAqJJqK3DoRShPs+2O9hrPjgVg6btjOCouHTLAUr4sCcLAqdbCLko5DNOQj7xkOnQAE1mX70RoymksFWgrWBkqQupCdBwea4ic/+WGUsWdWb65dLIW/PD+e6fAZVUQHFQ5q6+KAUYGzqyQgGH3PnXGlRddWb73LbGkDj0p+urQeSziE7Nm8kfG053huC+kASso7oT8Bq+qVCFknEadUnzZD3K21Vvl/OgHB6JqlVBpF32y7T7RoJMzxu0rHHiuTNjQRLBcM4xbqIEPQiHPJc9cLHIEnUL0wliTOTyyxwfPYRA7aMtEJzbUNuuquim1gvkEeZAlSk=
X-Received: by 2002:a05:6902:220c:b0:de8:a770:4812 with SMTP id
 3f1490d57ef6-df4a41d6187mr6078081276.40.1716277288715; Tue, 21 May 2024
 00:41:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712207606.git.ysato@users.sourceforge.jp> <0a30dbe6d096c38d612279349293162a2ccca149.1712207606.git.ysato@users.sourceforge.jp>
In-Reply-To: <0a30dbe6d096c38d612279349293162a2ccca149.1712207606.git.ysato@users.sourceforge.jp>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 21 May 2024 09:41:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUQ4u2yiDbEobVqD5y_MtU+XU19cx_kWT66yv1jGZMk6Q@mail.gmail.com>
Message-ID: <CAMuHMdUQ4u2yiDbEobVqD5y_MtU+XU19cx_kWT66yv1jGZMk6Q@mail.gmail.com>
Subject: Re: [RESEND v7 15/37] clk: renesas: Add SH7750/7751 CPG Driver
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Lee Jones <lee@kernel.org>, Helge Deller <deller@gmx.de>, 
	Heiko Stuebner <heiko.stuebner@cherry.de>, Shawn Guo <shawnguo@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	David Rientjes <rientjes@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Baoquan He <bhe@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Javier Martinez Canillas <javierm@redhat.com>, Guo Ren <guoren@kernel.org>, 
	Azeem Shaikh <azeemshaikh38@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jacky Huang <ychuang3@nuvoton.com>, 
	Herve Codina <herve.codina@bootlin.com>, 
	Manikanta Guntupalli <manikanta.guntupalli@amd.com>, Anup Patel <apatel@ventanamicro.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Sam Ravnborg <sam@ravnborg.org>, Sergey Shtylyov <s.shtylyov@omp.ru>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-ide@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sato-san,

On Thu, Apr 4, 2024 at 7:15=E2=80=AFAM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Renesas SH7750 and SH7751 series CPG driver.
> This driver supported frequency control and clock gating.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for the update!

As you plan to send a v8 soon, I'm sending you a comment from the
(incomplete) review I started a while ago...

> --- /dev/null
> +++ b/drivers/clk/renesas/clk-sh7750.c

> +static int register_pll(struct device_node *node, struct cpg_priv *cpg)
> +{
> +       const char *clk_name =3D node->name;
> +       const char *parent_name;
> +       struct clk_init_data init =3D {
> +               .name =3D PLLOUT,
> +               .ops =3D &pll_ops,
> +               .flags =3D 0,
> +               .num_parents =3D 1,
> +       };
> +       int ret;
> +
> +       parent_name =3D of_clk_get_parent_name(node, 0);
> +       init.parent_names =3D &parent_name;
> +       cpg->hw.init =3D &init;
> +
> +       ret =3D of_clk_hw_register(node, &cpg->hw);
> +       if (ret < 0)
> +               pr_err("%pOF: failed to add provider %s (%d)\n",

I think you retained the wrong error message?
"%s: failed to register %s pll clock (%d)\n" sounds more suitable to me.

> +                      node, clk_name, ret);
> +       return ret;
> +}

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

