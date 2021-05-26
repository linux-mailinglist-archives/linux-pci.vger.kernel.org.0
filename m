Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB353919CC
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 16:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbhEZOTt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 10:19:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:46238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233656AbhEZOTr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 May 2021 10:19:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5232613EC;
        Wed, 26 May 2021 14:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622038694;
        bh=/mrMnRJMtVpcPfaQNOqXW592yaxmSLc2ufg5spt3+VQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MX/ygqxAFw2J+DjyYoVo6pjCineqLtwJKliO4HCjGylTv21K9Mo9xcREh/RNn7GAt
         /jKTogqPHyC5ww7mV6oI9SQRjkI+LHaRU7m9kQRwFJAVPNwwBNyrlCqgxOBgFUkMQ0
         ooyXlRYvUKzAC9qmS7oRfssCJPw+Yt0YCulSBOj7KqsEbAVFKC50Sc5qkcN5o2VNut
         QgQ3gQG8OtQj/6eYNwBdm7YKQPL/3LbDa75WpKQzigNegqk6wgenNGQjKkJ9IKdvRw
         tHQ2+28jdl1YVq3UNKbHyTam+57+NJddXP/Y+1zHsf2vAgCSo2+3EEbinZj5oQJ/1G
         vcAy6f35I6J9A==
Received: by mail-oo1-f48.google.com with SMTP id j26-20020a4adf5a0000b029020eac899f76so320225oou.7;
        Wed, 26 May 2021 07:18:14 -0700 (PDT)
X-Gm-Message-State: AOAM533olJj1QPzR6tiFSnNQ6AMJFrfQl+SkJxkiGstolPIykesCKTdX
        UD9NWO/o9t90wD3fs9zW34jok3RN4qVaAo0x8e8=
X-Google-Smtp-Source: ABdhPJzuXaQfBghkHVGIgesa2CXDpQU1Sx4OrMSZo9IeDeyVGaz4cU9Kh2fedoUg7wOW8h8mDqEOQqF+bO1JgM2k7UQ=
X-Received: by 2002:a4a:8706:: with SMTP id z6mr2482481ooh.41.1622038694029;
 Wed, 26 May 2021 07:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXEBePfKDOc6eo9yjZPnVeFimX-zxR+R3As+2pP9XnZkuQ@mail.gmail.com>
 <20210525191556.GA1220872@bjorn-Precision-5520> <CAMj1kXG=dDwhNGe1tdHZH65KfcFzRHJKy6OwhWzYryZD9K9q_A@mail.gmail.com>
 <CAMdYzYptcAyb3U3ZZvNL8GwdcP-a2X8MX+rji2z0nEuiw0Br5A@mail.gmail.com>
In-Reply-To: <CAMdYzYptcAyb3U3ZZvNL8GwdcP-a2X8MX+rji2z0nEuiw0Br5A@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 26 May 2021 16:18:02 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF0Gh+CNJ+Y=Xv_1Z1gRpubBQLL81pUHgZ0DXNUO-MYqQ@mail.gmail.com>
Message-ID: <CAMj1kXF0Gh+CNJ+Y=Xv_1Z1gRpubBQLL81pUHgZ0DXNUO-MYqQ@mail.gmail.com>
Subject: Re: [BUG] rockpro64: PCI BAR reassignment broken by commit
 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource flags for 64-bit
 memory addresses")
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Leonardo Bras <leobras.c@gmail.com>,
        Rob Herring <robh@kernel.org>, PCI <linux-pci@vger.kernel.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 25 May 2021 at 22:03, Peter Geis <pgwipeout@gmail.com> wrote:
>
> On Tue, May 25, 2021 at 3:43 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Tue, 25 May 2021 at 21:15, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > On Tue, May 25, 2021 at 05:54:56PM +0200, Ard Biesheuvel wrote:
> > > > On Tue, 25 May 2021 at 17:34, Peter Geis <pgwipeout@gmail.com> wrote:
> > >
> > > > > > > >> > On 2021-05-18 10:09, Alexandru Elisei wrote:
> > > > > > > >> >> [..]
> > > > > > > >> >> [    0.305183] rockchip-pcie f8000000.pcie: host bridge /pcie@f8000000 ranges:
> > > > > > > >> >> [    0.305248] rockchip-pcie f8000000.pcie:      MEM 0x00fa000000..0x00fbdfffff -> 0x00fa000000
> > > > > > > >> >> [    0.305285] rockchip-pcie f8000000.pcie:       IO 0x00fbe00000..0x00fbefffff -> 0x00fbe00000
> > > > > > > >> >> [    0.373705] rockchip-pcie f8000000.pcie: PCI host bridge to bus 0000:00
> > > > > > > >> >> [    0.373730] pci_bus 0000:00: root bus resource [bus 00-1f]
> > > > > > > >> >> [    0.373751] pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfbdfffff 64bit]
> > > > > > > >> >> [    0.373777] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff] (bus address [0xfbe00000-0xfbefffff])
> > >
> > > > ... For some reason, lspci translates the BAR values to CPU
> > > > addresses, but the PCI side addresses are within 32-bits.
> > >
> > > lspci shows BARs as CPU physical addresses by default.  These are the
> > > same addresses you would see in pdev->resource[n] and the same as BAR
> > > values you would see in dmesg.
> > >
> > > A 64-bit CPU physical address can certainly be translated by the host
> > > bridge to a 32-bit PCI address.  But that's not happening here because
> > > this host bridge applies no translation (CPU physical 0xfa000000 maps
> > > to bus address 0xfa000000).
> > >
> > > "lspci -b" shows the PCI bus addresses.
> >
> > Ah, thanks.
> >
> > It does seem, though, that the information overload in this thread is
> > causing confusion now. Peter shared some log output where there is
> > definitely MMIO translation being applied.
>
> Yes, I've done work on the rk3399 pcie controller which is why this
> caught my attention.
> The original issue still seems to exist:
> For some reason:
> commit 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource flags for
> 64-bit memory addresses")
> causes allocation issues now.
> The original description of the issue aligned with issues I was having
> bringing up the rk356x pcie controller.
>
> >
> > > > [    6.673497] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff]
> > > > (bus address [0x3f700000-0x3f7fffff])
> > > > [    6.674642] pci_bus 0000:00: root bus resource [mem
> > > > 0x300000000-0x33f6fffff] (bus address [0x00000000-0x3f6fffff])
> >
> > In this case, the I/O translation definitely looks wrong. On a typical
> > ARM DT system, you will see something like
> >
> > [    1.500324] Remapped I/O 0x0000000067f00000 to [io  0x0000-0xffff window]
> > [    1.500522] pci_bus 0000:00: root bus resource [io  0x0000-0xffff window]
> >
> > The MMIO window looks correct, but I suspect that both 0x82000000 and
> > 0x83000000 in the DT ranges are describing the resource window as
> > prefetchable, preventing the allocation of non-prefetchable BARs in
> > this window.
>
> I checked with lspci -vvvbxxxxnn:
>
> Before your changes:
> 00:00.0 PCI bridge [0604]: Fuzhou Rockchip Electronics Co., Ltd Device
> [1d87:3566] (rev 01) (prog-if 00 [Normal decode])
>         I/O behind bridge: 00001000-00001fff [size=4K]
>         Memory behind bridge: 50000000-500fffff [size=1M]
>         Prefetchable memory behind bridge:
> 0000000040000000-000000004fffffff [size=256M]
> 01:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc.
> [AMD/ATI] Turks PRO [Radeon HD 7570] [1002:675d] (prog-if 00 [VGA
> controller])
>         Region 0: Memory at 40000000 (64-bit, prefetchable)
>         Region 2: Memory at 50000000 (64-bit, non-prefetchable)
>         Region 4: I/O ports at 7f701000
>         Expansion ROM at 50020000 [disabled]
>
> After your changes:
> lspci -vvvbxxxxnn
> 00:00.0 PCI bridge: Fuzhou Rockchip Electronics Co., Ltd Device 3566
> (rev 01) (prog-if 00 [Normal decode])
>         I/O behind bridge: 00001000-00001fff [size=4K]
>         Memory behind bridge: 10000000-100fffff [size=1M]
>         Prefetchable memory behind bridge:
> 0000000000000000-000000000fffffff [size=256M]
> 01:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> [AMD/ATI] Turks PRO [Radeon HD 7570] (prog-if 00 [VGA controller])
>         Region 0: Memory at <unassigned> (64-bit, prefetchable) [virtual]
>         Region 2: Memory at 10000000 (64-bit, non-prefetchable) [virtual]
>         Region 4: I/O ports at 1000 [virtual]
>         Expansion ROM at 10020000 [disabled]
>
> >
> > Peter, for the configuration listed here, could you try something like
> >
> > ranges = <0x1000000 0x0 0x0 [IO base in the CPU address map] [IO size]>,
> >          <0x2000000 0x0 0x0 [MMIO base in the CPU address map] [MMIO size]>;
>
> That was similar to what I already had, removing the relocatable flag
> and setting both addresses to 0x0 are the changes.
>
> Here is the result:

<snip>

I'm not sure which conclusion I am supposed to draw from that output.

Are you saying the output looks ok but the GPU card does not work?

Is your system DMA coherent? I would not be very optimistic about
these drivers working out of the box on non-coherent systems.
