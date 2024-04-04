Return-Path: <linux-pci+bounces-5737-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF79D898C8C
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 18:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A306D284A23
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 16:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC25F12C7FB;
	Thu,  4 Apr 2024 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6ovYBBY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6625337B;
	Thu,  4 Apr 2024 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712249327; cv=none; b=EHhKHln7ScCbeZ8fiZTyuojfILqzfORIZBN6KiQ7/bmISRSYB/LFhwrqwy8CKmXHXYFw3OogxYUp/2X3fdM6aQ+pSmPYotkjhT3guwM6hWVmR2oIIyOHLycBn4Gu3qShs68wAkVvX1SKEyvmPUMKvSNdMntSiSYGpJ1RPmxrULg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712249327; c=relaxed/simple;
	bh=f0ZUc9cVkTYbWSm7SlkoyeQqtebVeW+MGfGHY9LAnds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XkIv6zwE50hT+qH/4962mP55oKdMlopZnvJYnZQJIW8Qyl4IlaQdkQx1KLzxF4bNjxGb4IenYuop5uRB+Nz6/2IBGpdpcXZovcNLQdxmOD+jXUugf88bhrxYz6OqcbZC1cda4j4VzASQ7742PPTmqG+w+56byOifBfuiOEHwpVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6ovYBBY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DCEC433B2;
	Thu,  4 Apr 2024 16:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712249327;
	bh=f0ZUc9cVkTYbWSm7SlkoyeQqtebVeW+MGfGHY9LAnds=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=K6ovYBBYue9PM8NYfR7YR7xtB4whDjLcBUCl3DhZaB6oF3Hh1QGo6IYwTa/jtb5IV
	 SJSicYDiRwiOCN8IdaRtBdQgTDx1J53CG/bVCcE3xEegd0umAbjISGW/i47PcRqajk
	 6GusCggLy9XxctVsC27cT9gPXSN68HdIomjHPQqEf7MGLpTX2J+GA02Jhv3z9sEIcu
	 65JnbqsBAWB829JqkRYC/EjjscXNWSQN7HrbuoEawtyWxiSONajpsAJrveIvGHapUV
	 T0bVd8ses2r9LgZR3jSv8xmzMpBeq97ITtsq+hOSE3+YFElkoStrsuFrGW0OOHCGyw
	 eNETT5AZQt1Sg==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d700beb60bso21464621fa.1;
        Thu, 04 Apr 2024 09:48:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5vi4+zUMV6D5P1DLp9/oBQeYc8fDZQwMNZxiHvpIU8X+ReWTEGqfwm6JgE3WJjgUlOEflw+ryKJrOHcmZ0d7tNkzhB0TnTEQTrxnv3dWBJ7EwjjX5CPTuc5z6Ap1nLZvfQ2Csv0fges0Nrie0tWpWLyq4kWMjgXO4EKTK8OHSPaXxSJY6NSizB0zTohkmCxK8Zic54tKt2htiT/32VgeVT9JrUV3MI+x37YXulmkrZjqNP+SBcyEh/EkLJ9NY9VKhlaw9tvV7GpSpCzC+iBB7tesmAJ9MLgBliq/F2y53ur5CQ565Y6eLWF457YUeShDvFa0eY76UfQf0apUGLlQLIuWv/Bss9+5q0nWAOi5WMbnGkW9XevQ=
X-Gm-Message-State: AOJu0YxjASAg226CYO0YGGxy83/2ltWxPq0Yd3EvARdsCK4UioKa9Osm
	KmdUIrhjqXxJ1Li0oJTe4xui4IUoUvrC9ypOBsfDT1FOCZOuhBBfEOCqfTdb2MNcb4s/Ob7e6eK
	7Hdr5WqFTc3lMorIieHg6Kx3wxg==
X-Google-Smtp-Source: AGHT+IGA/B0Olc8HVdDCHlF8+fjMTjFHUiVbJhjDnxrx6ejO3lXuUhtHy5hp5vmBhc80/3eocgT9w6rQF0BvJQeGA5M=
X-Received: by 2002:a05:651c:1417:b0:2d3:8c1f:c0ff with SMTP id
 u23-20020a05651c141700b002d38c1fc0ffmr2449840lje.16.1712249325311; Thu, 04
 Apr 2024 09:48:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712207606.git.ysato@users.sourceforge.jp> <a4ce7771faec761b9bbb91ff6694a99e5bc293b6.1712207606.git.ysato@users.sourceforge.jp>
In-Reply-To: <a4ce7771faec761b9bbb91ff6694a99e5bc293b6.1712207606.git.ysato@users.sourceforge.jp>
From: Rob Herring <robh@kernel.org>
Date: Thu, 4 Apr 2024 11:48:32 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLG+v1ujhMM45dQcMXiQkCvjif3pAWZxgeAcKFMe9Sy9Q@mail.gmail.com>
Message-ID: <CAL_JsqLG+v1ujhMM45dQcMXiQkCvjif3pAWZxgeAcKFMe9Sy9Q@mail.gmail.com>
Subject: Re: [RESEND v7 06/37] sh: kernel/setup Update DT support.
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
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

On Thu, Apr 4, 2024 at 12:15=E2=80=AFAM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
>
> Fix extrnal fdt initialize and bootargs.

What is the problem you are trying to solve?

And a typo.

>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  arch/sh/Kconfig             | 23 +++++++++++------------
>  arch/sh/include/asm/setup.h |  1 +
>  arch/sh/kernel/setup.c      | 36 +++++++++++++++++++++++-------------
>  3 files changed, 35 insertions(+), 25 deletions(-)
>
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index 6711cde0d973..242cf30e704d 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -708,17 +708,22 @@ config ROMIMAGE_MMCIF
>           first part of the romImage which in turn loads the rest the ker=
nel
>           image to RAM using the MMCIF hardware block.
>
> +config CMDLINE
> +       string "Kernel command line arguments string"
> +       default "console=3DttySC1,115200"
> +
>  choice
>         prompt "Kernel command line"
> -       optional
> -       default CMDLINE_OVERWRITE
> -       depends on !OF || USE_BUILTIN_DTB
> +       default CMDLINE_BOOTLOADER
> +
> +config CMDLINE_BOOTLOADER
> +       bool "Use bootloader kernel arguments"

This should be the preferred, normal, default way. So why is it a user
visible option?

>         help
> -         Setting this option allows the kernel command line arguments
> -         to be set.
> +         Uses the command-line options passed by the boot loader.
> +         If boot loader dosen't provide kernel argments, Use built-in ar=
gments.

typos

bootloader in some spots, "boot loader" in others. Go with the former.

>
>  config CMDLINE_OVERWRITE
> -       bool "Overwrite bootloader kernel arguments"
> +       bool "Overwrite built-in kernel arguments"

The original made more sense to me. The default should be to use
bootloader args. Any built-in kernel command line should be prepend,
append (extend), or overwrite/replace.

Rob

