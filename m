Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160CA4528C6
	for <lists+linux-pci@lfdr.de>; Tue, 16 Nov 2021 04:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbhKPDyp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 22:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235504AbhKPDyn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Nov 2021 22:54:43 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C7CC1A2990
        for <linux-pci@vger.kernel.org>; Mon, 15 Nov 2021 16:31:10 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id q12so4327609pgh.5
        for <linux-pci@vger.kernel.org>; Mon, 15 Nov 2021 16:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zUAbk3pYDxq1bSuJItD74NAh/MbYUz0fiMi2jjsqIPc=;
        b=jkN0+anUkVZEafZbns3mnQH3BOzdPE6stTt8SrDHZFGkz5SQGDyxTuScjmOkAtjtG9
         AT2XFauNYqbJ3Hv+WUTHMAUTNsTes+od+8KqsU/GEVyVgjrYYw/xt4G0TAF8HM1LcPVm
         2WJe85H3kQUjZSV8Rb5yVnjCooZk+xWNu9wek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zUAbk3pYDxq1bSuJItD74NAh/MbYUz0fiMi2jjsqIPc=;
        b=UvfjphONlJbi98EhzxOrFg/mNbVZhocazjRWd1bEwxzt3BUnGC19bT33FTtb8KgUdy
         UI1qTqhu84mTy8Ok7iWuvvNxl150dBGYLihEVBi8I6CVFF+RsykBY4M7w0xJkWUUAPCS
         PPosFXd2wmna4GmfRRtrXB6AoK5jc/K4oMUu2YSY2PkE9FfVQk+NBHtkHsIFFKBJelBa
         kcEW3ibe5gPp3IT3CgcJGT9c+63KC4jC7folo/UPE2QPuC2Kgc9xVHWN+/GTtQwB/pq9
         j9gBQkqHNeboD34/DoSTyPt+3V03JOaOdJ39p2ttpI/HAsBOpL3wQ0eDG/qzM4E4zKAk
         Yh6Q==
X-Gm-Message-State: AOAM532Nph3W0P8/4G567ll4fM5Wo34F06u3Tb+/N3k3lGtCFWmFZO6i
        er9zY86iBZQkZE8KvsKClFxLtA==
X-Google-Smtp-Source: ABdhPJxDrEb7NedduOiss/lXzBJfLpYZT+5k0kObH71YXHTZztaI+VVMmjTV988TJQv8GS02GfUMPA==
X-Received: by 2002:a05:6a00:1945:b0:44c:a955:35ea with SMTP id s5-20020a056a00194500b0044ca95535eamr36094903pfk.85.1637022670112;
        Mon, 15 Nov 2021 16:31:10 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h21sm12755848pgk.74.2021.11.15.16.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 16:31:09 -0800 (PST)
Date:   Mon, 15 Nov 2021 16:31:09 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Marco Elver <elver@google.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        Rob Clark <robdclark@gmail.com>,
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
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>,
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
Subject: Re: Build regressions/improvements in v5.16-rc1
Message-ID: <202111151624.91EDCFF7@keescook>
References: <20211115155105.3797527-1-geert@linux-m68k.org>
 <CAMuHMdUCsyUxaEf1Lz7+jMnur4ECwK+JoXQqmOCkRKqXdb1hTQ@mail.gmail.com>
 <YZKOce4XhAU49+Yn@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZKOce4XhAU49+Yn@elver.google.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 15, 2021 at 05:44:33PM +0100, Marco Elver wrote:
> On Mon, Nov 15, 2021 at 05:12PM +0100, Geert Uytterhoeven wrote:
> [...]
> > >   + /kisskb/src/include/linux/fortify-string.h: error: call to '__read_overflow' declared with attribute error: detected read beyond size of object (1st parameter):  => 263:25, 277:17
> > 
> >     in lib/test_kasan.c
> > 
> > s390-all{mod,yes}config
> > arm64-allmodconfig (gcc11)
> 
> Kees, wasn't that what [1] was meant to fix?
> [1] https://lkml.kernel.org/r/20211006181544.1670992-1-keescook@chromium.org

[1] fixed the ones I found when scanning for __write_overflow(). [2]
fixed some others, so it's possible there are yet more to fix?

Taking a look at Linus's tree, though, the "263" and "277" lines don't
line up correctly. I'll go see if I can reproduce this. Is this with
W=1?

-Kees

[2] https://www.ozlabs.org/~akpm/mmotm/broken-out/kasan-test-consolidate-workarounds-for-unwanted-__alloc_size-protection.patch


-- 
Kees Cook
