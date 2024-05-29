Return-Path: <linux-pci+bounces-8021-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1B38D3719
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 15:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 676DF1F258C8
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 13:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D9417991;
	Wed, 29 May 2024 13:06:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0C014AA9;
	Wed, 29 May 2024 13:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716988014; cv=none; b=lt9WJjYIPNF8ZNu4S5I3VpsDLL0ho7oO473IkLAsF/N9LBJbTK0u77lkKQ8WIe2HNbKg/1Z16Rp2TF7v4LdTvhyh/VTiH3Lqb6+ugSuSeyqe8GrLAf3VUqyKJMB/a9LTMUOmN2VfIEltWQ7A2ZgerN+M879H6zAMncKtdBbUAUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716988014; c=relaxed/simple;
	bh=Gydwrm8d+mV9pgzpyR75u2RXMfJN81LViSApnAgE098=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QjGxEjre8HAncQY/BwRI0kKXb2uujyQbrQItyA2UFw9l7w3zNRgAvlURB22L9opvbwL+Llj5Zx4b76xt4kaxNclX+VnghEITybnCjixU6yL1bG/apLAcf7mqqWijVT40Uxiiz97/LNclHpZF3DJyirU3BVt5pJLvslo8aKYNo1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-62a2424ecdaso21226727b3.1;
        Wed, 29 May 2024 06:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716988011; x=1717592811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVFbPQ9StvkoNrq/0lKZWIQ4ZOA4XJTj64cZbKmwivY=;
        b=JGGSK+QdZF1tXfN7HWaizV9lCegpQN2zxXCF1VmtX/yvXJnhDhAWWlwVsXnZlokmji
         SSNp1XJQuV0+2JGyU2yoV5HswGN33ydHIdYb6sLGGdql3wSQDunxUHaLIrz/ZPqtFsaA
         KNuRRh0gzXaxlBIVUiUwFMJ5lzoYvRZTXFZHCh0H1zSX4M3STo07gydHB3jwWxSsCpID
         Z9VCrEwAz2oaTdUo6wZQJGH0tAHWorvoqksik8aO/KUgmhCByWi5375pcfA38IsWESLX
         P3RKSoDOI4o8ibqk8lyu05pZEUzoy4F//w3c7NUsKZa/SzR7VhrEFfZoEP8KNULFi3ld
         JIkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuOsYbYY50fLN+9TGuZlsLc2uiXKJTJMl0rg2saFwkp+94Xvt/Mw9+pUVmU5CbDXfEbWRe0+qjPbqZDHak0qmZE+rldpFKDw2CKQ1lqLedKFGdGkA3drftjqHD77qfQH+CrKYGWIRR+ovzMtzDrSQXR9+59utqs1HPafJvOE+i/stTrGGuGo+SacM0FvwblIWuQsHpcW0cfUPjLaN0rQj9DwS/C2eZnZi9Mgv+duBmQLx2Czctupy4SrbDzu8gh+hB83yNIZ0FfYqclUwiXVLDjECq0PQ/tfu4ccRBl8EY0z7KM+CLOczAg2m/Vwj/TOsEgLy+UlCJUQAmWSQ8eUpzRjzRHzHtPdOVHvQVl7ywwP9D5iRSxEI=
X-Gm-Message-State: AOJu0YyxSbWgAjFpzVnuqi8DYbxfz6Lap6OhBhZ1e9KfYqVyw+sG2Wm1
	KmVeOq2kdWbB+HgpJGDC7vUUjtFvJVNLarQbGHCWO6CJkUddaclVT9T+0PshNRE=
X-Google-Smtp-Source: AGHT+IFZbNxrq1Y2GcpogkFIJxEEueLh2Pk3k4cqJqns+GErJM+NsuI+yxGgvad9/NZwUzuAxwqHqg==
X-Received: by 2002:a81:6d01:0:b0:61b:1e81:4eb8 with SMTP id 00721157ae682-62a08d74106mr138719307b3.9.1716988010153;
        Wed, 29 May 2024 06:06:50 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62a0a56c166sm23852597b3.142.2024.05.29.06.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 06:06:49 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dfa4ad7f6dfso587358276.1;
        Wed, 29 May 2024 06:06:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV3pDuDzRbDY+9yUA5NOXzVQwOp/xs7J2mlpVeZogS4DlAaO2iiIpdUmTxE1NVcHGdjY2rDo/eAmjNhn7Op1n/HTwJJc/xVBQkmofGgkMGQZWYbzA61vikHK5vopMzpJcJtYJsQNIgHvfzB/tIjWQeWGjI35ZW4fOFdNs0LzQfyJtzz++aolL7Tn4Ot+L96du9DQ1iKzxkU9pU40MjMg13tcbrakZBCKqZWVpAN3c3gafErgRWyHt0REkoYPEMoB1uukMkZgm4zkJaZx6ZK4ZO4xG+P4wD+/eZOKqeqyKYnt6OT2BgIx4Y8t/5TQ+ILeAU4+gNAeHdETDL1xzvzZPq6RP+yH8tyOUcv/u9noPa8EmE4B24/U/U=
X-Received: by 2002:a25:a565:0:b0:dfa:48ec:c4b2 with SMTP id
 3f1490d57ef6-dfa48ecc64cmr1707039276.22.1716988008813; Wed, 29 May 2024
 06:06:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716965617.git.ysato@users.sourceforge.jp> <b1fc49269919c7d6c2e5c607ae29d1a6f2ab40d2.1716965617.git.ysato@users.sourceforge.jp>
In-Reply-To: <b1fc49269919c7d6c2e5c607ae29d1a6f2ab40d2.1716965617.git.ysato@users.sourceforge.jp>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 May 2024 15:06:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWdR=SfNBFdABXRqdng8b=68mP_BnnXfpQcUvjCmvOmVA@mail.gmail.com>
Message-ID: <CAMuHMdWdR=SfNBFdABXRqdng8b=68mP_BnnXfpQcUvjCmvOmVA@mail.gmail.com>
Subject: Re: [DO NOT MERGE v8 13/36] dt-bindings: clock: sh7750-cpg: Add
 renesas,sh7750-cpg header.
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
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
	Heiko Stuebner <heiko.stuebner@cherry.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Chris Morgan <macromorgan@hotmail.com>, Sebastian Reichel <sre@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Baoquan He <bhe@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Azeem Shaikh <azeemshaikh38@gmail.com>, Guo Ren <guoren@kernel.org>, 
	Max Filippov <jcmvbkbc@gmail.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Herve Codina <herve.codina@bootlin.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Anup Patel <apatel@ventanamicro.com>, 
	Jacky Huang <ychuang3@nuvoton.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	Jonathan Corbet <corbet@lwn.net>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Sam Ravnborg <sam@ravnborg.org>, 
	Javier Martinez Canillas <javierm@redhat.com>, Sergey Shtylyov <s.shtylyov@omp.ru>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-ide@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sato-san,

Thanks for the update!

On Wed, May 29, 2024 at 10:01=E2=80=AFAM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> SH7750 CPG Clock output define.

(from my comments on v6 and v7) Please improve the patch description.

> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/renesas,sh7750-cpg.yaml
> @@ -0,0 +1,107 @@

> +examples:
> +  - |
> +    #include <dt-bindings/clock/sh7750-cpg.h>
> +    cpg: clock-controller@ffc00000 {
> +        compatible =3D "renesas,sh7751r-cpg";
> +        reg =3D <0xffc00000 20>, <0xfe0a0000 16>;
> +        reg-names =3D "FRQCR", "CLKSTP00";
> +        clocks =3D <&extal>;
> +        clock-names =3D "extal";
> +        renesas,mode =3D <0>;

Nit: please move "renesas,mode" last.

> +        #clock-cells =3D <1>;
> +        #power-domain-cells =3D <0>;
> +    };

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

