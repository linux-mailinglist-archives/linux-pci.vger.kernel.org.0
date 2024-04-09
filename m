Return-Path: <linux-pci+bounces-5937-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DCC89DB67
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 15:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 018311F23375
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 13:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B4B12F58C;
	Tue,  9 Apr 2024 13:56:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9784E12F38D;
	Tue,  9 Apr 2024 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712671003; cv=none; b=mfZopuTpUQoQ5Bv3rs+q4wcAHhinAMtuWvXYjVB+oR6RMOgSMAxun8T/D+gRYKebROARyHZ+4GeaV+ZJqm7CtT0xuNP6p71pB4IlcuNt38xmgM3dTfGWqNLtfMUQTZMJAvYmFqTEV3xfmNM99NvPkZM9PbGSXMExvKCdJgsaniA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712671003; c=relaxed/simple;
	bh=uiUPa934IC8G79R0cHkfdU2hmpF5TUHtkMcYQceZcSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rEm/3CfL+b80IhaHFO/qyMJXKKOKIjRlRo/WFieZH0oXnSd+G49Pb2SU4V3K5ZRahGAzYuJ3GOFDptWFQfKsdthdHTMrwiEvRdd5iLKBYuf3JX795F5ZWcWCKOB/A++VLAbQICD0DZ6o4ZX6aj3BdYCvzvbnWBJZNNKF550myOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6181237230dso21065807b3.2;
        Tue, 09 Apr 2024 06:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712670997; x=1713275797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2HZbjvWyXpSYd1puM+93tZG9TcNwqCrELS7hscC5PVY=;
        b=CwEUYTOmSUBXgCsg3mYwTIIgCdg05HTnnQL2fCs5MBT3RKP8AwiaFZ5sNLrfzav40q
         eVUu9kOeot7bwJ7GNVxqpX4Nth3fcuM9cytM7ea629NX8VjvMSaxDYq0gBF25wOn8CQF
         0RySLVFl7g2g6seyOS0pem0XG1trr66o88NPt57ak4sCNFf99pRm35eaNr8neSOq+tFB
         343Hm0CeYSEQHUgtFOKALjYA2fhGfItctrW/iu2YtQmOimO0cGLzLwTuSAxys/zBiSvb
         n4c7CraPsNJs6VmZCc8gvTF5C44ThtXJ5xKTUXk/7VJS579msALTWdbwOI+NMi6IC/vl
         gGTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZXPQTK8ugJajyO2tRjyDW021M1AqDliF0ZB3j0np1Lr3RWZhAK04LnlAvOg5RO+b+lVVUYlDenHIg4Y7Y3Ykz1tdlfqHF6EOucPPdB/i2rfMFDPo/DJV5w4EVBpVx48MwIfQy24sHNrvNvwgKkBqRnfyw6+hptnRYh2vSf2KYS9kQOupv0UjB/qGrVB+ajRpR1NsOBxxKY8nYrESyBVO625P+xPSRL2I9sS2tDc71ajErHdruzLysJ1K9tCS23nCgKxcvVA/oOTNlua7eMYzNEuTohBSk6nZz9oyygvFXJf1/RexKDZvwuqGYb92zTYkMEfKGOZVPDdMB6nS2wJiByFTfPXxzZn7GGjrhsY3CVuaMP9xM0TU=
X-Gm-Message-State: AOJu0Yygj3rR9vfvqVOM/WbydP3tii9a5c8MpHdYL2DhCsR/9YcpjLFu
	KmWfN36gEdp80ziyDNvxbQJrRvHrPUfhLfpzHmEOUD19cKIKeG4G98vl0S/vlZg=
X-Google-Smtp-Source: AGHT+IGh+8mu6y5ErUruD07FecBSGrLFypzV2tzoJvfI8kksdhp9gQwcjaZ4TqEXL/3+PJzmy3leAQ==
X-Received: by 2002:a81:a10f:0:b0:611:191e:1de8 with SMTP id y15-20020a81a10f000000b00611191e1de8mr11665488ywg.18.1712670995713;
        Tue, 09 Apr 2024 06:56:35 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id dg7-20020a05690c0fc700b006144d568e98sm2171547ywb.28.2024.04.09.06.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 06:56:35 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcbef31a9dbso3624658276.1;
        Tue, 09 Apr 2024 06:56:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/48xkhiI5juYIGQ3ENYufchuOd0c2yhFKM/vDJdZH3sEqXZW6oe7juLSOt3fVSQxDCUpXNfCWEfKXphCFwTd2jjphx3LAUnXzf8HlvM4EJh240wzsz9b1JSmjAn7TCcyySnYRcxF8kMkPfrHcR/RSFk0h1gabPD+t/m3NNz361CvjWyyQVeq/VFaDnID303H06hAA/OtE2lGC80aNvYhjnVOZqmxgMwA2ly+URGBoB6eHHLcY3rxoQsj9bed73MoIdoIoAYvD1jIJ5Ec52w2P5V2ExKeyqY6opFTL7lRv2Vdoo3+zpVNysTM3zH1eVLMU9RDDfW5P3j1on91F7d1S+e2xZTnGhKRuplXyO/NsWr6xB9yXGFM=
X-Received: by 2002:a5b:40c:0:b0:dc6:b779:7887 with SMTP id
 m12-20020a5b040c000000b00dc6b7797887mr8362504ybp.20.1712670994533; Tue, 09
 Apr 2024 06:56:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712207606.git.ysato@users.sourceforge.jp> <4a9b59733c7a8e7d042f3987ca6bf601eea5b30d.1712207606.git.ysato@users.sourceforge.jp>
In-Reply-To: <4a9b59733c7a8e7d042f3987ca6bf601eea5b30d.1712207606.git.ysato@users.sourceforge.jp>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 9 Apr 2024 15:56:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUVEj-TEV5iYjknTKOJ0_MBO8sMzc6-7NSAL-XoxLGn9g@mail.gmail.com>
Message-ID: <CAMuHMdUVEj-TEV5iYjknTKOJ0_MBO8sMzc6-7NSAL-XoxLGn9g@mail.gmail.com>
Subject: Re: [RESEND v7 08/37] clocksource: sh_tmu: CLOCKSOURCE support.
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
> Allows initialization as CLOCKSOURCE.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> --- a/drivers/clocksource/sh_tmu.c
> +++ b/drivers/clocksource/sh_tmu.c

> @@ -495,7 +514,12 @@ static int sh_tmu_map_memory(struct sh_tmu_device *t=
mu)
>
>  static int sh_tmu_parse_dt(struct sh_tmu_device *tmu)
>  {
> -       struct device_node *np =3D tmu->pdev->dev.of_node;
> +       struct device_node *np;

Technically, np might be used uninitialized.

> +
> +       if (tmu->pdev)
> +               np =3D tmu->pdev->dev.of_node;

If you would set up tmu->np in sh_tmu_setup_pdev()...

> +       if (tmu->np)
> +               np =3D tmu->np;

... you could just assign np =3D tmu->np unconditionally.

>
>         tmu->model =3D SH_TMU;
>         tmu->num_channels =3D 3;

> @@ -665,6 +734,7 @@ static void __exit sh_tmu_exit(void)
>         platform_driver_unregister(&sh_tmu_device_driver);
>  }
>
> +TIMER_OF_DECLARE(sh_tmu, "renesas,tmu", sh_tmu_of_register);

As there are now two entry points, the device is actually probed twice:
once from TIMER_OF_DECLARE/sh_tmu_of_register(), and a second
time from platform_driver/sh_tmu_probe().

E.g. on Armadillo-800-EVA with R-Mobile A1 (booting Linux on ARM
(not SH), and using TMU as the main clock source):

    timer@fff80000 ch0: used for clock events
    timer@fff80000 ch0: used for periodic clock events
    timer@fff80000 ch1: used as clock source
    clocksource: timer@fff80000: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 154445288668 ns
    ...
    fff80000.timer ch0: used for clock events
    genirq: Flags mismatch irq 16. 00015a04 (fff80000.timer) vs.
00015a04 (timer@fff80000)
    fff80000.timer ch0: failed to request irq 16
    fff80000.timer ch1: used as clock source
    clocksource: fff80000.timer: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 154445288668 ns

After this, the timer seems to be stuck, and the boot is blocked.

On Marzen with R-Car H1 (booting Linux on ARM (not SH), and using
arm_global_timer as the main clock source), I also see the double
timer probe, but no such lock-up.  I expect you to see the double
timer probe on SH775x, too?

The double probe can be fixed by adding a call to
of_node_set_flag(np, OF_POPULATED) at the end of sh_tmu_of_register()
in case of success, cfr. [1].

I haven't found the cause of the stuck timer on R-Mobile A1 yet;
both the TMU clock and the A4R power domain seem to be activated...

>  #ifdef CONFIG_SUPERH
>  sh_early_platform_init("earlytimer", &sh_tmu_device_driver);
>  #endif

[1] "[PATCH] clocksource/drivers/renesas-ostm: Avoid reprobe after
successful early probe"
    https://lore.kernel.org/all/bd027379713cbaafa21ffe9e848ebb7f475ca0e7.17=
10930542.git.geert+renesas@glider.be/

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

