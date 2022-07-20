Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1853357BCE6
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 19:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbiGTRkc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jul 2022 13:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbiGTRka (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 13:40:30 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BF92A241;
        Wed, 20 Jul 2022 10:40:29 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id u12so1649231qtk.0;
        Wed, 20 Jul 2022 10:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PmcZJKXW5L1h76Y7jDvbkfD3n85Nfb/cTZUz3jaZfpo=;
        b=IPjEJxNrYKP/bAlPgxKrn9FRbVKtzEunsywWgj6Ah5b2RkACwEAkC9UR3zFDDBuGCf
         DmR2Tria1RLN9CtkfNsyxYmmIVc7LqeCC0PPw1ie4atvpQKIws0vBKhVN2NoXwCo6Iu3
         6pi3IWLHoNY++xp3S8EJdXkRSrg6SCZne70H354F+qWvVyz12PztKFB0AJuVKzwXQC6z
         W+9/NatlcBA6ngOBQsGZU905K0CGJEHQbKn+mm7DAuE38BJhiKHkfqulCvF7CfYYoscW
         zDt6uR/kHv/q8ff5orI6JiHpXMzqXg6L6dPJvNNSMLU/ozAufiz2HcHBxZ3e11S4Uilw
         xljA==
X-Gm-Message-State: AJIora/NodvMzBgl4OHy4tqkS3vMy+2Yvabf/5xoRajZ1W9oiDUaFc08
        ZKDwIcI85P7lvk6Xz5nMMjd4wW++ToamFa1M
X-Google-Smtp-Source: AGRyM1s9l8OS7ZCQgfbMTab10+PGIrLc1fxawXk5LNRiK0T4+LYGriYHhmB3sDRnu/Jk9uLMG6tKGA==
X-Received: by 2002:ac8:5a41:0:b0:31f:280:b7ca with SMTP id o1-20020ac85a41000000b0031f0280b7camr6179579qta.518.1658338828709;
        Wed, 20 Jul 2022 10:40:28 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id bq7-20020a05620a468700b006b578ff5dfasm5045912qkb.41.2022.07.20.10.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 10:40:28 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 75so33323451ybf.4;
        Wed, 20 Jul 2022 10:40:28 -0700 (PDT)
X-Received: by 2002:a5b:6c1:0:b0:669:a7c3:4c33 with SMTP id
 r1-20020a5b06c1000000b00669a7c34c33mr36151263ybq.543.1658338827759; Wed, 20
 Jul 2022 10:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220720131934.373932-1-shorne@gmail.com> <20220720131934.373932-3-shorne@gmail.com>
In-Reply-To: <20220720131934.373932-3-shorne@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 Jul 2022 19:40:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX7_CSQd14tGPfL7R7V0h6AwNi7bVDCWhcdNoZV_md4bw@mail.gmail.com>
Message-ID: <CAMuHMdX7_CSQd14tGPfL7R7V0h6AwNi7bVDCWhcdNoZV_md4bw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] PCI: Move isa_dma_bridge_buggy out of dma.h
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alpha <linux-alpha@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 20, 2022 at 3:20 PM Stafford Horne <shorne@gmail.com> wrote:
> During recent PCI cleanups we noticed that the isa_dma_bridge_buggy
> symbol supported by all architectures is actually only used for x86_32.
>
> This patch moves the symbol out of all architectures limiting usage to
> only x86_32.  This is possible because only x86_32 platforms or quirks
> existing in PCI devices supported on x86_32 ever set this.  A new global
> header linux/isa-dma.h is added to provide a common place to maintain
> the definition.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
> Since v3:
>  - New patch.

>  arch/m68k/include/asm/dma.h            |  6 ------

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
