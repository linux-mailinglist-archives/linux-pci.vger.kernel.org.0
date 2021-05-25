Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8DA3905ED
	for <lists+linux-pci@lfdr.de>; Tue, 25 May 2021 17:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhEYP4j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 May 2021 11:56:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231918AbhEYP4j (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 May 2021 11:56:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47A1D613F4;
        Tue, 25 May 2021 15:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621958109;
        bh=rbfLFTpdS7dsvU1lnqHm0Eg6YbPN1ywTyypZbgz6f4Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=djC9Uxu2huIeUKtbihW1gQMB+QtaskgQTF2B/wDluYf7tuCI2Ix59oD5g8hjHXj7V
         YxuD3VGGmNHk/025H8A4ZgiMKwHV7C3Q6c+ynlOL/EcJmbUqDINlrtZbj62OrDe1Tm
         daH0BkwRg0L0zBfgEZW77VghYr+g7L6yFWbzdnaATDh+J9yzfSVhV7r/Mkpsjk3OZ6
         zSL1yVko44rOOzi1g9Ps58cE3yqm+e7/1mEGy2oauEeLZetQTvzR28GeALvBrhFp31
         NqFhkAR9mf7YEW/D9k9VEU73RRr1NmjEAQTmSV9TWJU2e6UErfHlB5DFgXA+hrdhHL
         PA0Qp/gaGtw/A==
Received: by mail-oi1-f176.google.com with SMTP id c196so22525333oib.9;
        Tue, 25 May 2021 08:55:09 -0700 (PDT)
X-Gm-Message-State: AOAM530ILc432lbHwxWiIIsSilJGEq67qh4wq/sMAtH7CIJO3KZjn1w3
        fdlqSFi41M3rlv5217eox9SS6su9ZLQw1rvkahQ=
X-Google-Smtp-Source: ABdhPJw39bc5cbG5JE3bIuosBNIYIZ6lKvpvmOgPOwb2LNiXtoeeIKzQdsRMOBe6wv2zt8NXpLU+d3qomwHWkXdtz+8=
X-Received: by 2002:aca:3182:: with SMTP id x124mr3327594oix.47.1621958108589;
 Tue, 25 May 2021 08:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com> <01efd004-1c50-25ca-05e4-7e4ef96232e2@arm.com>
 <87eedxbtkn.fsf@stealth> <CAMj1kXE3U+16A6bO0UHG8=sx45DE6u0FtdSnoLDvfGnFJYTDrg@mail.gmail.com>
 <877djnaq11.fsf@stealth> <CAMj1kXFk2u=tbTYpa6Vqz5ihATFq61pCDiEbfRgXL_Rw+q_9Fg@mail.gmail.com>
 <CAMdYzYo-vdJvT_MPNTYvdveG3W8na7qMVEZFL4AjyQWqcLZi=Q@mail.gmail.com>
In-Reply-To: <CAMdYzYo-vdJvT_MPNTYvdveG3W8na7qMVEZFL4AjyQWqcLZi=Q@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 25 May 2021 17:54:56 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEBePfKDOc6eo9yjZPnVeFimX-zxR+R3As+2pP9XnZkuQ@mail.gmail.com>
Message-ID: <CAMj1kXEBePfKDOc6eo9yjZPnVeFimX-zxR+R3As+2pP9XnZkuQ@mail.gmail.com>
Subject: Re: [BUG] rockpro64: PCI BAR reassignment broken by commit
 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource flags for 64-bit
 memory addresses")
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 25 May 2021 at 17:34, Peter Geis <pgwipeout@gmail.com> wrote:
>
> On Tue, May 25, 2021 at 9:57 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Tue, 25 May 2021 at 15:42, Punit Agrawal <punitagrawal@gmail.com> wr=
ote:
> > >
> > > Hi Ard,
> > >
> > > Ard Biesheuvel <ardb@kernel.org> writes:
> > >
> > > > On Sun, 23 May 2021 at 13:06, Punit Agrawal <punitagrawal@gmail.com=
> wrote:
> > > >>
> > > >> Robin Murphy <robin.murphy@arm.com> writes:
> > > >>
> > > >> > [ +linux-pci for visibility ]
> > > >> >
> > > >> > On 2021-05-18 10:09, Alexandru Elisei wrote:
> > > >> >> After doing a git bisect I was able to trace the following erro=
r when booting my
> > > >> >> rockpro64 v2 (rk3399 SoC) with a PCIE NVME expansion card:
> > > >> >> [..]
> > > >> >> [    0.305183] rockchip-pcie f8000000.pcie: host bridge /pcie@f=
8000000 ranges:
> > > >> >> [    0.305248] rockchip-pcie f8000000.pcie:      MEM 0x00fa0000=
00..0x00fbdfffff ->
> > > >> >> 0x00fa000000
> > > >> >> [    0.305285] rockchip-pcie f8000000.pcie:       IO 0x00fbe000=
00..0x00fbefffff ->
> > > >> >> 0x00fbe00000
> > > >> >> [    0.306201] rockchip-pcie f8000000.pcie: supply vpcie1v8 not=
 found, using dummy
> > > >> >> regulator
> > > >> >> [    0.306334] rockchip-pcie f8000000.pcie: supply vpcie0v9 not=
 found, using dummy
> > > >> >> regulator
> > > >> >> [    0.373705] rockchip-pcie f8000000.pcie: PCI host bridge to =
bus 0000:00
> > > >> >> [    0.373730] pci_bus 0000:00: root bus resource [bus 00-1f]
> > > >> >> [    0.373751] pci_bus 0000:00: root bus resource [mem 0xfa0000=
00-0xfbdfffff 64bit]
> > > >> >> [    0.373777] pci_bus 0000:00: root bus resource [io  0x0000-0=
xfffff] (bus
> > > >> >> address [0xfbe00000-0xfbefffff])
> > > >> >> [    0.373839] pci 0000:00:00.0: [1d87:0100] type 01 class 0x06=
0400
> > > >> >> [    0.373973] pci 0000:00:00.0: supports D1
> > > >> >> [    0.373992] pci 0000:00:00.0: PME# supported from D0 D1 D3ho=
t
> > > >> >> [    0.378518] pci 0000:00:00.0: bridge configuration invalid (=
[bus 00-00]),
> > > >> >> reconfiguring
> > > >> >> [    0.378765] pci 0000:01:00.0: [144d:a808] type 00 class 0x01=
0802
> > > >> >> [    0.378869] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00=
003fff 64bit]
> > > >> >> [    0.379051] pci 0000:01:00.0: Max Payload Size set to 256 (w=
as 128, max 256)
> > > >> >> [    0.379661] pci 0000:01:00.0: 8.000 Gb/s available PCIe band=
width, limited by
> > > >> >> 2.5 GT/s PCIe x4 link at 0000:00:00.0 (capable of 31.504 Gb/s w=
ith 8.0 GT/s PCIe
> > > >> >> x4 link)
> > > >> >> [    0.393269] pci_bus 0000:01: busn_res: [bus 01-1f] end is up=
dated to 01
> > > >> >> [    0.393311] pci 0000:00:00.0: BAR 14: no space for [mem size=
 0x00100000]
> > > >> >> [    0.393333] pci 0000:00:00.0: BAR 14: failed to assign [mem =
size 0x00100000]
> > > >> >> [    0.393356] pci 0000:01:00.0: BAR 0: no space for [mem size =
0x00004000 64bit]
> > > >> >> [    0.393375] pci 0000:01:00.0: BAR 0: failed to assign [mem s=
ize 0x00004000 64bit]
> > > >> >> [    0.393397] pci 0000:00:00.0: PCI bridge to [bus 01]
> > > >> >> [    0.393839] pcieport 0000:00:00.0: PME: Signaling with IRQ 7=
8
> > > >> >> [    0.394165] pcieport 0000:00:00.0: AER: enabled with IRQ 78
> > > >> >> [..]
> > > >> >> to the commit 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to
> > > >> >> resource flags for
> > > >> >> 64-bit memory addresses").
> > > >> >
> > > >> > FWFW, my hunch is that the host bridge advertising no 32-bit mem=
ory
> > > >> > resource, only only a single 64-bit non-prefetchable one (even t=
hough
> > > >> > it's entirely below 4GB) might be a bit weird and tripping somet=
hing
> > > >> > up in the resource assignment code. It certainly seems like the =
thing
> > > >> > most directly related to the offending commit.
> > > >> >
> > > >> > I'd be tempted to try fiddling with that in the DT (i.e. changin=
g
> > > >> > 0x83000000 to 0x82000000 in the PCIe node's "ranges" property) t=
o see
> > > >> > if it makes any difference. Note that even if it helps, though, =
I
> > > >> > don't know whether that's the correct fix or just a bodge around=
 a
> > > >> > corner-case bug somewhere in the resource code.
> > > >>
> > > >> From digging into this further the failure seems to be due to a mi=
smatch
> > > >> of flags when allocating resources in pci_bus_alloc_from_region() =
-
> > > >>
> > > >>     if ((res->flags ^ r->flags) & type_mask)
> > > >>             continue;
> > > >>
> > > >> Though I am also not sure why the failure is only being reported o=
n
> > > >> RK3399 - does a single 64-bit window have anything to do with it?
> > > >>
> > > >
> > > > The NVMe in the example exposes a single 64-bit non-prefetchable BA=
R.
> > > > Such BARs can not be allocated in a prefetchable host bridge window
> > > > (unlike the converse, i.e., allocating a prefetchable BAR in a
> > > > non-prefetchable host bridge window is fine)
> > > >
> > > > 64-bit non-prefetchable host bridge windows cannot be forwarded by =
PCI
> > > > to PCI bridges, they simply lack the BAR registers to describe them=
.
> > > > Therefore, non-prefetchable endpoint BARs (even 64-bit ones) need t=
o
> > > > be carved out of a host bridge's non-prefetchable 32-bit window if
> > > > they need to pass through a bridge.
> > >
> > > Thank you for the explanation. I also looked at the PCI-to-PCI Bridge
> > > spec to understand where some of the limitations are coming from.
> > >
> > > > So the error seems to be here that the host bridge's 32-bit
> > > > non-prefetchable window has the 64-bit attribute set, even though i=
t
> > > > resides below 4 GB entirely. I suppose that the resource allocation
> > > > could be made more forgiving (and it was in the past, before commit
> > > > 9d57e61bf723 was applied). However, I would strongly recommend not
> > > > deviating from common practice, and just describe the 32-bit
> > > > addressable non-prefetchable resource window as such.
> > >
> > > IIUC, the host bridge's configuration (64-bit on non-prefetchable
> > > window) is based on what the hardware advertises.
> > >
> >
> > What do you mean by 'what the hardware advertises'? The host bridge is
> > apparently configured to decode a 32-bit addressable window as MMIO,
> > and the question is why this window has the 64-bit attribute set in
> > the DT description.
> >
> > > Can you elaborate on what you have in mind to correct the
> > > non-prefetchable resource window? Are you thinking of adding a quirk
> > > somewhere to address this?
> > >
> >
> > No. Just fix the DT.
>
> Good Morning,
>
> I believe Robin is correct that there is more to this.
> While attempting to work out why dGPUs won't work with the rk356x
> series PCIe controllers, Christian K=C3=B6nig from the amd-gpu driver
> mailing list noticed the gpu was incorrectly allocated a 64bit
> non-prefetchable BAR which should instead be a 32 non-prefetchable
> BAR.
>

This is due to the translation. For some reason, lspci translates the
BAR values to CPU addresses, but the PCI side addresses are within
32-bits.

Are you sure the amdgpu driver can even deal with non-1:1 host bridges?

> The ranges currently set are:
> ranges =3D <0x81000000 0x0 0x00800000 0x3 0x00800000 0x0 0x00100000
> 0x82000000 0x0 0x00900000 0x3 0x00900000 0x0 0x3f700000>;
>

So you have two ranges here.

> but the final allocation was:
>
> lspci -v
> 00:00.0 PCI bridge: Fuzhou Rockchip Electronics Co., Ltd Device 3566
> (rev 01) (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0, IRQ 96
>         Bus: primary=3D00, secondary=3D01, subordinate=3Dff, sec-latency=
=3D0
>         I/O behind bridge: 00001000-00001fff [size=3D4K]
>         Memory behind bridge: 00900000-009fffff [size=3D1M]
>         Prefetchable memory behind bridge:
> 0000000010000000-000000001fffffff [size=3D256M]

But the host bridge/root port decodes two disjoint regions??

>         Expansion ROM at 300a00000 [virtual] [disabled] [size=3D64K]
>         Capabilities: [40] Power Management version 3
>         Capabilities: [50] MSI: Enable+ Count=3D1/32 Maskable- 64bit+
>         Capabilities: [70] Express Root Port (Slot-), MSI 00
>         Capabilities: [b0] MSI-X: Enable- Count=3D1 Masked-
>         Capabilities: [100] Advanced Error Reporting
>         Capabilities: [148] Secondary PCI Express
>         Capabilities: [160] L1 PM Substates
>         Capabilities: [170] Vendor Specific Information: ID=3D0002 Rev=3D=
4
> Len=3D100 <?>
>         Kernel driver in use: pcieport
>
> 01:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> [AMD/ATI] Turks PRO [Radeon HD 7570] (prog-if 00 [VGA controller])
>         Subsystem: Dell Turks PRO [Radeon HD 7570]
>         Flags: bus master, fast devsel, latency 0, IRQ 95
>         Memory at 310000000 (64-bit, prefetchable) [size=3D256M]
>         Memory at 300900000 (64-bit, non-prefetchable) [size=3D128K]
>         I/O ports at 1000 [size=3D256]
>         Expansion ROM at 300920000 [disabled] [size=3D128K]
>         Capabilities: [50] Power Management version 3
>         Capabilities: [58] Express Legacy Endpoint, MSI 00
>         Capabilities: [a0] MSI: Enable- Count=3D1/1 Maskable- 64bit+
>         Capabilities: [100] Vendor Specific Information: ID=3D0001 Rev=3D=
1
> Len=3D010 <?>
>         Capabilities: [150] Advanced Error Reporting
>         Kernel driver in use: radeon
>
> 01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Turks
> HDMI Audio [Radeon HD 6500/6600 / 6700M Series]
>         Subsystem: Dell Turks HDMI Audio [Radeon HD 6500/6600 / 6700M Ser=
ies]
>         Flags: bus master, fast devsel, latency 0, IRQ 98
>         Memory at 300940000 (64-bit, non-prefetchable) [size=3D16K]
>         Capabilities: [50] Power Management version 3
>         Capabilities: [58] Express Legacy Endpoint, MSI 00
>         Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
>         Capabilities: [100] Vendor Specific Information: ID=3D0001 Rev=3D=
1
> Len=3D010 <?>
>         Capabilities: [150] Advanced Error Reporting
>         Kernel driver in use: snd_hda_intel
>
> This will obviously clobber registers during writes.

I don't follow. Which writes will clobber which registers, and how is
it obvious?

> Also, if <0x82000000> (32 bit) is changed to <0x83000000> (64 bit),
> most of the allocations for the dGPU fail due to no valid regions
> available.
>

But wasn't the original problem that the resource window was 64-bit to
begin with? Are you sure we are talking about the same problem here?


> >
> > > I am happy to put something together once I understand the preferred =
way
> > > to go about it.
> > >
> > > Thanks,
> > > Punit
> > >
> > > [...]
> > >
> >
> > _______________________________________________
> > Linux-rockchip mailing list
> > Linux-rockchip@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rockchip
