Return-Path: <linux-pci+bounces-4132-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFC0869B69
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 16:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91EDF1C210C2
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 15:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5394D14690A;
	Tue, 27 Feb 2024 15:58:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E939E1386C0;
	Tue, 27 Feb 2024 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709049538; cv=none; b=DNeNXXvmYqy98cK/hqwlMpFT5Z5CKF4zPBAq+g+SxWnQT/6C1IYKDaOBXx3mTiT4qyly3rMaHXSwNaWCWBC6PdojBe1C86YliYMMM0a6yUy3Sv2A3dg30kVNM4n23qqSGB7GLbqG9pb6Q65r95A44mSG+3qykvrrErGwgq1Pi8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709049538; c=relaxed/simple;
	bh=mBSyYqleRcEXku7CRgtMvn6An1lA5+02Qx+tnSuzV+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sq8msdQU3icIJWDZ+fBSOgI7owZn6zc6qFZmGG7MkzWwOu3ovIM7rG3F4oxfqUL9F3Y4uVT+4CVr3VEclLJEjjMCUrcfmIxnIFhnoPSYrlsg5o8vqm/EmR8G/Tt2trW3ZkusGoQV0xgAcFs4N1P5oB1yBuLcEvfVEx4156cTpns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-512e1991237so3758435e87.1;
        Tue, 27 Feb 2024 07:58:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709049529; x=1709654329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IptBoEO/nbU9/WEAcwSC51BarbPlLUIodqi54T15K7k=;
        b=FkyMr3Q7pzaxQMomViT+wdKth/6hHkbpgRMuWVygnwqnPSM6UeLLp0njS570RNU6W8
         RtEtSVlCQ7ZBHSp8xOF3mh0lIzEK0LxbdS3ud/JMnjT3/GNB1g12/DYRO8pIUC+HE2pP
         siqqcMJ4GQYM+od9JPY6b+LUQ5cM16vsfdn/Ie2CF9kYe4lbUCkxprvytdQ1m1/sC72R
         FeoJWu3iaocGhnxtRK0ans8Ns/1zsoCV6P2Pd32F9PCiZ6cSdDceopxr58ts8aLa3wwX
         FrgJMgE9PcTn7UgrwXfkqQlRDAmC71zq852xKGdrKyDZ3osHBszQjsmPyjuFKGoFFvS8
         vFMA==
X-Forwarded-Encrypted: i=1; AJvYcCWAXc+Lt83Jnw2dcYBIfIffUEftzovIhbz2jMKsSMSoBP/iWwuCfxJqWoRVHnYyEMeUU5s9yShooBg1uLRJrt3QTaxwtNkJ7G6QwvtcyzzNSx/khPIUBz1tjpIiqGcsdVni3S1PIsFd9UF1yQ8Pta5UiwS4R4fSdyZUmtYLW2rCzPCNwzyG8tUWQhC/CvoMBMr39m15z8deOaH/NVXINNzoGGO51/7ucocHl9jAzALcCJMNsfvHFtXOU2WwZKb4i4WkwQeHMVR1ZWnV+S2vd89ptgLDeWmhdv0GrOA7UZ8NdwNJ7zj2+3jmnvt+v7ZKCNvHV+lA+tUnLp2Jc+N2ETr1kBgLJ3WInI8F1AkWHg6QAaXoZ5EQX6Q=
X-Gm-Message-State: AOJu0YzNTL5fd+1k7HcPNrETw3B652FFUrtMQOmQEV1h1TfBTjMY2ZQj
	Q+Quvmxo2uqjJhUJyPoaHHVQOxtzKHWd+7DNgZhA0INDSBM+jpO7iUXPnmBTRAXzXg==
X-Google-Smtp-Source: AGHT+IF2XNDa9MSeMwrVojS828vVxFODf36eJsV45noAKB63psjpU5C9g1ooL8srnPiNpOIKyfDVhw==
X-Received: by 2002:a05:6512:3b97:b0:513:9b2:5bc5 with SMTP id g23-20020a0565123b9700b0051309b25bc5mr974805lfv.13.1709049529104;
        Tue, 27 Feb 2024 07:58:49 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id r9-20020ac252a9000000b00512fcd4d6fasm818378lfm.11.2024.02.27.07.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 07:58:47 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d269dc3575so40584901fa.1;
        Tue, 27 Feb 2024 07:58:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWszVg/yTz2hdHkVnJa5E4GIf9NdCN2rYsIZBKCEe70wHtKhd0qTgisdU6pGUjZA4FiTeGs1cm4KUZDEah3ehARpJ4gNg2SjveWHdCpB/1dgTYnoeLaAYzlnoOuyS4M4+F49qkj6p1q8DFAat5PB3kmHjhhS29orIP/2rMsBYyTqbepBWaBrNuzmlT56lN86515ovpp3MvLc+T1XtlqA/j5HHtbVKh1eli/Auhon0yH1gLjy1mzqUF4hSP7Q4Xjw0blMYCRkU4wEw9g1k7ISXuv7WgkHXIyBHqfNcTBicR+h3RreTwN4QEKcUoHfbepC3VDyHnkmlL3sGEb4KwfMN2dpFIzYaRov+77oFOiQ1Osug4Ko2aiSHQ=
X-Received: by 2002:a2e:b541:0:b0:2d2:43a3:1355 with SMTP id
 a1-20020a2eb541000000b002d243a31355mr2766471ljn.15.1709049527187; Tue, 27 Feb
 2024 07:58:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704788539.git.ysato@users.sourceforge.jp> <d832abfa099355b90eba461f22116a6e426c1648.1704788539.git.ysato@users.sourceforge.jp>
In-Reply-To: <d832abfa099355b90eba461f22116a6e426c1648.1704788539.git.ysato@users.sourceforge.jp>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Feb 2024 16:58:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXMLPtO49kmxfSVEXLYOVLj+tqisYTwYqSeyJgy3bir8A@mail.gmail.com>
Message-ID: <CAMuHMdXMLPtO49kmxfSVEXLYOVLj+tqisYTwYqSeyJgy3bir8A@mail.gmail.com>
Subject: Re: [DO NOT MERGE v6 28/37] dt-bindings: soc: renesas: sh: Add SH7751
 based target
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
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/renesas/sh.yaml
> @@ -0,0 +1,32 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/renesas/sh.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas SuperH Platform
> +
> +maintainers:
> +  - Yoshinori Sato <ysato@users.sourceforge.jp>
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - description: RTS7751R2D Plus
> +        items:
> +          - enum:
> +              - renesas,rts7751r2d # Renesas SH4 2D graphics board
> +          - const: renesas,sh7751r
> +
> +      - description: Julian board
> +        items:
> +          - enum:
> +              - iodata,landisk  # LANDISK HDL-U
> +              - iodata,usl-5p   # USL-5P
> +          - const: renesas,sh7751r

As both use the same fallback compatible value, I would just merge
them into a single section for SH7751R.

> +
> +additionalProperties: true
> +
> +...

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

