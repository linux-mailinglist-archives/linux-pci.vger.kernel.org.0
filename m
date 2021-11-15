Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C338345097F
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 17:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbhKOQXV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 11:23:21 -0500
Received: from mail-ua1-f49.google.com ([209.85.222.49]:37822 "EHLO
        mail-ua1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236711AbhKOQWn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Nov 2021 11:22:43 -0500
Received: by mail-ua1-f49.google.com with SMTP id o1so3163658uap.4;
        Mon, 15 Nov 2021 08:19:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=efm7nTUMt8rzsLA3IdyOYKyQXeHPPTB88YQ7l3tEZPU=;
        b=j1ePCDZz9pjRoBSjFPBK36Zkij+CB1qkYiXTY2Q3Wp4RBzYIuPpueipNAr4BDIT5Ge
         3SycT+nqt7zu8Fk7R5Gsrzw3syS3NENcAds96Vs2uthWNWG1lUnYXFYPMLVOriSKm7ca
         /m9xHDv/Y8S9zaBhSZIN9F7jjCjVmUd2HX20FhAeUcHNY6K4x23cQ0Fy2U+wZn7rlyrv
         RGgEOs+EcSJ3vxim8f+x87mPJ6aOU1OpyknXNv4zcV+W618oqCRqL3Lj3sVGTbPLyZ0L
         PIAxEBQTYGtMEFARIzBxLlYvhfg7JQBmYsnHjf7ZB2xN3/ljNIgblRXnJoM85m7VyW7V
         e6/Q==
X-Gm-Message-State: AOAM533Z+HIGAeIaX6iMf1CQvBtK2FuYsmKT2NsJnLTwyy62NRaCvM/D
        9JZqAwRUF2yE+MgaldzM9xMECe64xCuRWQ==
X-Google-Smtp-Source: ABdhPJylBZXFwAq5a1NpYaCzYAYvfTy5mBiEIMoNMxzm+3uw7hyEvmc0grXVvV36HYTiF4V1kFvcrw==
X-Received: by 2002:ab0:3d13:: with SMTP id f19mr80563uax.30.1636993184203;
        Mon, 15 Nov 2021 08:19:44 -0800 (PST)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id s10sm8696109vkf.9.2021.11.15.08.19.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 08:19:44 -0800 (PST)
Received: by mail-vk1-f182.google.com with SMTP id j1so2079248vkr.1;
        Mon, 15 Nov 2021 08:19:44 -0800 (PST)
X-Received: by 2002:a1f:f24f:: with SMTP id q76mr60850690vkh.11.1636992782095;
 Mon, 15 Nov 2021 08:13:02 -0800 (PST)
MIME-Version: 1.0
References: <20211115155105.3797527-1-geert@linux-m68k.org>
In-Reply-To: <20211115155105.3797527-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 15 Nov 2021 17:12:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUCsyUxaEf1Lz7+jMnur4ECwK+JoXQqmOCkRKqXdb1hTQ@mail.gmail.com>
Message-ID: <CAMuHMdUCsyUxaEf1Lz7+jMnur4ECwK+JoXQqmOCkRKqXdb1hTQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.16-rc1
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Nick Terrell <terrelln@fb.com>, Rob Clark <robdclark@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Anton Altaparmakov <anton@tuxera.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Joey Gouly <joey.gouly@arm.com>,
        Stan Skowronek <stan@corellium.com>,
        Hector Martin <marcan@marcan.st>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-ntfs-dev@lists.sourceforge.net,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 15, 2021 at 4:54 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v5.16-rc1[1] compared to v5.15[2].
>
> Summarized:
>   - build errors: +20/-13
>   - build warnings: +3/-28
>
> Happy fixing! ;-)
>
> Thanks to the linux-next team for providing the build service.
>
> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf/ (all 90 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/8bb7eca972ad531c9b149c0a51ab43a417385813/ (all 90 configs)
>
>
> *** ERRORS ***
>
> 20 error regressions:
>   + /kisskb/src/arch/parisc/include/asm/jump_label.h: error: expected ':' before '__stringify':  => 33:4, 18:4
>   + /kisskb/src/arch/parisc/include/asm/jump_label.h: error: label 'l_yes' defined but not used [-Werror=unused-label]:  => 38:1, 23:1

    due to static_branch_likely() in crypto/api.c

parisc-allmodconfig

>   + /kisskb/src/drivers/gpu/drm/msm/msm_drv.h: error: "COND" redefined [-Werror]:  => 531
>   + /kisskb/src/lib/zstd/compress/zstd_double_fast.c: error: the frame size of 3252 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]:  => 47:1
>   + /kisskb/src/lib/zstd/compress/zstd_double_fast.c: error: the frame size of 3360 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]:  => 499:1
>   + /kisskb/src/lib/zstd/compress/zstd_double_fast.c: error: the frame size of 5344 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]:  => 334:1
>   + /kisskb/src/lib/zstd/compress/zstd_double_fast.c: error: the frame size of 5380 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]:  => 354:1
>   + /kisskb/src/lib/zstd/compress/zstd_fast.c: error: the frame size of 1824 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]:  => 372:1
>   + /kisskb/src/lib/zstd/compress/zstd_fast.c: error: the frame size of 2224 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]:  => 204:1
>   + /kisskb/src/lib/zstd/compress/zstd_fast.c: error: the frame size of 3800 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]:  => 476:1

parisc-allmodconfig

>   + /kisskb/src/fs/ntfs/aops.c: error: the frame size of 2240 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]:  => 1311:1
>   + /kisskb/src/fs/ntfs/aops.c: error: the frame size of 2304 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]:  => 1311:1
>   + /kisskb/src/fs/ntfs/aops.c: error: the frame size of 2320 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]:  => 1311:1

powerpc-allmodconfig

>   + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_366' declared with attribute error: FIELD_PREP: value too large for the field:  => 335:38

    in drivers/pinctrl/pinctrl-apple-gpio.c

arm64-allmodconfig (gcc8)

>   + /kisskb/src/include/linux/fortify-string.h: error: call to '__read_overflow' declared with attribute error: detected read beyond size of object (1st parameter):  => 263:25, 277:17

    in lib/test_kasan.c

s390-all{mod,yes}config
arm64-allmodconfig (gcc11)

>   + error: modpost: "mips_cm_is64" [drivers/pci/controller/pcie-mt7621.ko] undefined!:  => N/A
>   + error: modpost: "mips_cm_lock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!:  => N/A
>   + error: modpost: "mips_cm_unlock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!:  => N/A
>   + error: modpost: "mips_cpc_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!:  => N/A
>   + error: modpost: "mips_gcr_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!:  => N/A

mips-allmodconfig

> 3 warning regressions:
>   + <stdin>: warning: #warning syscall futex_waitv not implemented [-Wcpp]:  => 1559:2

powerpc, m68k, mips, s390, parisc (and probably more)

>   + arch/m68k/configs/multi_defconfig: warning: symbol value 'm' invalid for MCTP:  => 322
>   + arch/m68k/configs/sun3_defconfig: warning: symbol value 'm' invalid for MCTP:  => 295

Yeah, that happens when symbols are changed from tristate to bool...
Will be fixed in 5.17-rc1, with the next defconfig refresh.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
