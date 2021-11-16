Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D0F452DB8
	for <lists+linux-pci@lfdr.de>; Tue, 16 Nov 2021 10:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbhKPJTE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Nov 2021 04:19:04 -0500
Received: from elvis.franken.de ([193.175.24.41]:53000 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232784AbhKPJTB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Nov 2021 04:19:01 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mmuZJ-0006sq-00; Tue, 16 Nov 2021 10:15:57 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 5D232C2D9C; Tue, 16 Nov 2021 10:15:42 +0100 (CET)
Date:   Tue, 16 Nov 2021 10:15:42 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        Rob Clark <robdclark@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Anton Altaparmakov <anton@tuxera.com>,
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
Message-ID: <20211116091542.GA21775@alpha.franken.de>
References: <20211115155105.3797527-1-geert@linux-m68k.org>
 <CAMuHMdUCsyUxaEf1Lz7+jMnur4ECwK+JoXQqmOCkRKqXdb1hTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUCsyUxaEf1Lz7+jMnur4ECwK+JoXQqmOCkRKqXdb1hTQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 15, 2021 at 05:12:50PM +0100, Geert Uytterhoeven wrote:
> >   + error: modpost: "mips_cm_is64" [drivers/pci/controller/pcie-mt7621.ko] undefined!:  => N/A
> >   + error: modpost: "mips_cm_lock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!:  => N/A
> >   + error: modpost: "mips_cm_unlock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!:  => N/A
> >   + error: modpost: "mips_cpc_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!:  => N/A
> >   + error: modpost: "mips_gcr_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!:  => N/A
> 
> mips-allmodconfig

there is a patchset fixing this

https://lore.kernel.org/all/20211115070809.15529-1-sergio.paracuellos@gmail.com/

> > 3 warning regressions:
> >   + <stdin>: warning: #warning syscall futex_waitv not implemented [-Wcpp]:  => 1559:2
> 
> powerpc, m68k, mips, s390, parisc (and probably more)

I've queued a patch to fix this for mips.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
