Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB634542AE
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 09:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbhKQIdq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 17 Nov 2021 03:33:46 -0500
Received: from mail-qt1-f169.google.com ([209.85.160.169]:34729 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhKQIdp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Nov 2021 03:33:45 -0500
Received: by mail-qt1-f169.google.com with SMTP id o17so1924109qtk.1;
        Wed, 17 Nov 2021 00:30:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pLki4VXVNEgH7BpAr7thCy6liKqtc8dZxgXibG/LDtU=;
        b=IUpfMS2Qsw+4vmn7I+udpusUuBdphjjcAJKehe7ijbqvhkYnwm6cTNdca+Cm0+0ma0
         xHD7AGKnQOaEiCs6xqSWURkkNCEsyjFfW5BS+qXXbqRwqmicLNGkp26r99JMfFSCO/3k
         0bWFazjujRDAHYFZe81Zf9uHbmyFG8cifydbv07Sd9hppAYW34M6QwmE5KICuNyBOc1b
         uaRJUYDVmVWNYnHKQUaNc9sX2Jn2J5I6VMJVbOUUi0zfxBoozVHwbFXJ/iQhxxdP0nJI
         UUZ2M0IUONMJ7yEaDyGm9GjG4M1JgiuAegMgBQl0bzAe7JH80skTE+4MB5PXQv0AtrMH
         PE+w==
X-Gm-Message-State: AOAM533Gmfbt9PLCNrSukClwWshSIsB1Zv0j1Rff2FGOwSGUU7Ob7m8A
        uDSnap65Q1tmO3hQD/OtlyUl2r4Dhpxyxg==
X-Google-Smtp-Source: ABdhPJwoFVUouk9QlvygqIYHdaUI5uPa2eT+UDuhCZpvADfGS5ohUE9j9fFTF1CGKB45SU6JCVVhbA==
X-Received: by 2002:a05:622a:178c:: with SMTP id s12mr14701908qtk.156.1637137846345;
        Wed, 17 Nov 2021 00:30:46 -0800 (PST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id j20sm5550905qtj.43.2021.11.17.00.30.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 00:30:46 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id n2so746118yba.2;
        Wed, 17 Nov 2021 00:30:46 -0800 (PST)
X-Received: by 2002:a9f:2431:: with SMTP id 46mr20823663uaq.114.1637137464301;
 Wed, 17 Nov 2021 00:24:24 -0800 (PST)
MIME-Version: 1.0
References: <20211115155105.3797527-1-geert@linux-m68k.org>
 <CAMuHMdUCsyUxaEf1Lz7+jMnur4ECwK+JoXQqmOCkRKqXdb1hTQ@mail.gmail.com>
 <fcdead1c-2e26-b8ca-9914-4b3718d8f6d4@gmx.de> <480CE37B-FE60-44EE-B9D2-59A88FDFE809@fb.com>
 <78b2d093-e06c-ba04-9890-69f948bfb937@infradead.org> <B57193D6-1FD4-45D3-8045-8D2DE691E24E@fb.com>
In-Reply-To: <B57193D6-1FD4-45D3-8045-8D2DE691E24E@fb.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 17 Nov 2021 09:24:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWgGz5FSidaGpp8YRRSnJfwdP4-wOkXdVx+mydXnMAXHQ@mail.gmail.com>
Message-ID: <CAMuHMdWgGz5FSidaGpp8YRRSnJfwdP4-wOkXdVx+mydXnMAXHQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.16-rc1
To:     Nick Terrell <terrelln@fb.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, Helge Deller <deller@gmx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
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
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Nick,

On Wed, Nov 17, 2021 at 3:20 AM Nick Terrell <terrelln@fb.com> wrote:
> > On Nov 16, 2021, at 6:05 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> > On 11/16/21 5:59 PM, Nick Terrell wrote:
> >> I’ll send the PR to Linus tomorrow. I’ve been informed that it
> >> isn't strictly necessary to send the patches to the mailing list
> >> for bug fixes, but its already done, so I’ll wait and see if there
> >> is any feedback.
> >
> > IMO several (or many more) people would disagree with that.
> >
> > "strictly?"  OK, it's probably possible that almost any patch
> > could be merged without being on a mailing list, but it's not
> > desirable (except in the case of "security" patches).
>
> Good to know! Thanks for the advice, I wasn’t really sure what
> the best practice is for sending patches to your own tree, as I
> didn't see anything about it in the maintainer guide.

All patches must be sent to public mailing lists for review.
You might get away with not doing that for a simple and trivial fix,
but be prepared to end up on people's "special" lists if you did get
it wrong.

We are Legion. We do not forgive. We do not forget ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
