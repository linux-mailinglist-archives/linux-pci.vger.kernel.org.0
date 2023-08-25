Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90BA788114
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 09:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243190AbjHYHjt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 25 Aug 2023 03:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243279AbjHYHjo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 03:39:44 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA19D1FCA;
        Fri, 25 Aug 2023 00:39:42 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5921a962adfso7750207b3.1;
        Fri, 25 Aug 2023 00:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692949182; x=1693553982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5r8bhhlGnXrx708tsGw6Ag8gm7AVkEO6BeDk4HD7tk=;
        b=WLwKyxXquJm5Xn2E5suH9Ccdce9jLlK+GauaIf0md59SIWvBfCcZk4dC06SZ0nwQ5K
         o8mlkO6FrAPPZ3xikK2nHElJNrNcLfVrv2YPtiaWl+//7MkAIb0Vy9SjeVnmpHyCYH4W
         I5mObQzFhw+m1eUuyVIrzuU9uKe9VfJqoq2WCZPHWNbvYfU/7BBGvgSdw3Aj94FOHzun
         daBwzKmfiYOEG8N743Xq7gSnARMMxTcLLRtVzpgdK587Rrb1jXfjpcGRqZ29++t0F+TH
         kPYRW1w9pwZo8+0r6gIkcz/69x/2ENZa+/qIVHSblZZT+i08RU5Os3RvT9tGC4TBTm90
         tNnA==
X-Gm-Message-State: AOJu0YzJmfhWcq6vO1UlWpwHrSuIxQLbZeRqaa3IxlV4wtuvVLN03mWl
        TT2srflCsiYRdKyAssRS2LZd8SWeNqosAGzC
X-Google-Smtp-Source: AGHT+IG5X+1N+9gN7m2P63rFzRbifScZ6dVPHHJG1DUCTreGK5Pu6Rcf3MDfyMu9eFYv5GgCMrEEDw==
X-Received: by 2002:a0d:cd45:0:b0:561:206a:ee52 with SMTP id p66-20020a0dcd45000000b00561206aee52mr20431530ywd.24.1692949181853;
        Fri, 25 Aug 2023 00:39:41 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id l132-20020a0de28a000000b0058e430889d5sm379613ywe.10.2023.08.25.00.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 00:39:40 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5924093a9b2so7680237b3.2;
        Fri, 25 Aug 2023 00:39:40 -0700 (PDT)
X-Received: by 2002:a25:34cd:0:b0:d0b:5b6:4629 with SMTP id
 b196-20020a2534cd000000b00d0b05b64629mr19382891yba.46.1692949180028; Fri, 25
 Aug 2023 00:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230810141947.1236730-1-arnd@kernel.org> <169292577153.789945.11297239773543112051.b4-ty@oracle.com>
 <3956e2a4-c545-1212-e95f-3cf61a60d6a4@gmail.com>
In-Reply-To: <3956e2a4-c545-1212-e95f-3cf61a60d6a4@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 25 Aug 2023 09:39:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWC2S330_Vb_NTHTDC=BakBsw4ouP-eFJv0erV1-jmvTQ@mail.gmail.com>
Message-ID: <CAMuHMdWC2S330_Vb_NTHTDC=BakBsw4ouP-eFJv0erV1-jmvTQ@mail.gmail.com>
Subject: Re: (subset) [PATCH 00/17] -Wmissing-prototype warning fixes
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@quicinc.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Michael,

On Fri, Aug 25, 2023 at 3:31 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> On 25/08/23 13:12, Martin K. Petersen wrote:
> > [11/17] scsi: gvp11: remove unused gvp11_setup() function
> >          https://git.kernel.org/mkp/scsi/c/bfaa4a0ce1bb
>
> I somehow missed that one ...
>
> The gvp11_setup() function was probably a relic from the times before
> module parameters.
>
> Since gvp11_xfer_mask appears to be required for some Amiga systems to
> set the DMA mask, I'd best send a patch to add such a module parameter ...
>
> Do you know any details around the use of DMA masks for Amiga WD33C93
> drivers, Geert?

Doh, it's been a while, and I never had an affected system.
Probably it's needed on A2000 with an accelerator card and GVP II SCSI,
to prevent DMA to RAM banks that do not support fast DMA cycles.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
