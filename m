Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFDDD3907D2
	for <lists+linux-pci@lfdr.de>; Tue, 25 May 2021 19:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbhEYRga (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 May 2021 13:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234209AbhEYRgL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 May 2021 13:36:11 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A3EC061342;
        Tue, 25 May 2021 10:34:38 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id f9so44164797ybo.6;
        Tue, 25 May 2021 10:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=06IA1eNpcSLnfjmH8uISU7mktvW4RRyzaTbHrryY0Bg=;
        b=UyLOvAhzcBVrOXZ6N46upbtVKmrIg7dKGmWteRjQwESJiJFxXgYfMP5x5EGAm5H9Y4
         dRXoPZKkjx8QLOa5nRN0Qxn5DOXqyxuilPXMi4Po1tx7BW3iMCrkITJaJ2X3LWLlzPAT
         rrTId+aTVFZhOZilT1wMo/yd78xrwXnQk4AbZqe15CbH8iKAeFlpTeZxkmt4BqzWdRAU
         J7TmAGm1XrS8e1LDv3Omn6c84IuVTO+ZiSFugX5wz+MrGvIPcYiuFd2cOEKUAKFlJeh3
         9zrkhHTq+xMlu4e7KWyRwkAAy4hqPMce5elktR2ItbkEE7GbLY47qOE90EjQqCNIBaO6
         vtiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=06IA1eNpcSLnfjmH8uISU7mktvW4RRyzaTbHrryY0Bg=;
        b=oafIkSYQaGbkMSTKyrX779vs9/xWFPJwie+DdE4jxXtApnrYLq2+xCcXEUQ09zwOpz
         blW/rtdWnhJxJlxpRl/2wyuuAIp6eg56x5ie9HZbd2Np/5KzyRO/EGqvWPcZuOoGhxp3
         JnI4OmtMRafAy/AWZrRrtsDzhWnpLBoUrqbF/dWv0yfBCAHNSQYqNPqFHxE1L72x2ykb
         62sW20VrDeg60pN2snCt5+B/xOEqL65q4EiBxWDZ5BX7nztIzoOXOImADoIiCD0IEg7B
         8VXH8VPdyosOLsOcW25w+VKFWUiZIkK+AVkNl5c3j+/lqsMP0WOUbbq0v70ztRL3HCvF
         1gkw==
X-Gm-Message-State: AOAM531h0nSc9LZ8zs05wUiicv7Sll4Z2v6qPiGwc5/lwVvmDi4n7zF6
        0R//PlQ/KDmluu9AyedsVJCqRc1ReMhTNPeE5v5+aMOqFeyTNA==
X-Google-Smtp-Source: ABdhPJwlcGpj+T3QTXT17HE8BVIlUCKVv+0gPDNrhP0U3vjXyvo/Tdg6Szx/eaUBNB+S11QVqEXZoTjdUwDEqMjfETU=
X-Received: by 2002:a25:9982:: with SMTP id p2mr45548228ybo.174.1621964077250;
 Tue, 25 May 2021 10:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com> <01efd004-1c50-25ca-05e4-7e4ef96232e2@arm.com>
 <87eedxbtkn.fsf@stealth> <CAMj1kXE3U+16A6bO0UHG8=sx45DE6u0FtdSnoLDvfGnFJYTDrg@mail.gmail.com>
 <877djnaq11.fsf@stealth> <CAMj1kXFk2u=tbTYpa6Vqz5ihATFq61pCDiEbfRgXL_Rw+q_9Fg@mail.gmail.com>
 <CAMdYzYo-vdJvT_MPNTYvdveG3W8na7qMVEZFL4AjyQWqcLZi=Q@mail.gmail.com>
 <CAMj1kXEBePfKDOc6eo9yjZPnVeFimX-zxR+R3As+2pP9XnZkuQ@mail.gmail.com>
 <CAMdYzYrH_M92Pc6AqTgagtATr1TPq7Pdm57hadZeAmMBF2f0nA@mail.gmail.com>
 <CAMj1kXHsGgFedbhW2CiS5gveK3=ZxhXQ5siDeHJyttkOVKBQrQ@mail.gmail.com>
 <CAMdYzYruNYtJ8hwKPBUHPed1-=tV=CWDd_oSQtRmr4BJHp=YxA@mail.gmail.com> <92c5785a-18f6-182a-b51b-9dfc373a5c01@arm.com>
In-Reply-To: <92c5785a-18f6-182a-b51b-9dfc373a5c01@arm.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Tue, 25 May 2021 13:34:26 -0400
Message-ID: <CAMdYzYosbM8tKTzD5boSRokw6LwsAr_VUSodMANh1HtAuhh_=A@mail.gmail.com>
Subject: Re: [BUG] rockpro64: PCI BAR reassignment broken by commit
 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource flags for 64-bit
 memory addresses")
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Punit Agrawal <punitagrawal@gmail.com>,
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

On Tue, May 25, 2021 at 1:25 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-05-25 18:01, Peter Geis wrote:
> > On Tue, May 25, 2021 at 12:44 PM Ard Biesheuvel <ardb@kernel.org> wrote=
:
> >>
> >> On Tue, 25 May 2021 at 18:23, Peter Geis <pgwipeout@gmail.com> wrote:
> >>>
> >>> On Tue, May 25, 2021 at 11:55 AM Ard Biesheuvel <ardb@kernel.org> wro=
te:
> >>>>
> >>>> On Tue, 25 May 2021 at 17:34, Peter Geis <pgwipeout@gmail.com> wrote=
:
> >>>>>
> >>>>> On Tue, May 25, 2021 at 9:57 AM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
> >>>>>>
> >>>>>> On Tue, 25 May 2021 at 15:42, Punit Agrawal <punitagrawal@gmail.co=
m> wrote:
> >>>>>>>
> >>>>>>> Hi Ard,
> >>>>>>>
> >>>>>>> Ard Biesheuvel <ardb@kernel.org> writes:
> >>>>>>>
> >>>>>>>> On Sun, 23 May 2021 at 13:06, Punit Agrawal <punitagrawal@gmail.=
com> wrote:
> >>>>>>>>>
> >>>>>>>>> Robin Murphy <robin.murphy@arm.com> writes:
> >>>>>>>>>
> >>>>>>>>>> [ +linux-pci for visibility ]
> >>>>>>>>>>
> >>>>>>>>>> On 2021-05-18 10:09, Alexandru Elisei wrote:
> >>>>>>>>>>> After doing a git bisect I was able to trace the following er=
ror when booting my
> >>>>>>>>>>> rockpro64 v2 (rk3399 SoC) with a PCIE NVME expansion card:
> >>>>>>>>>>> [..]
> >>>>>>>>>>> [    0.305183] rockchip-pcie f8000000.pcie: host bridge /pcie=
@f8000000 ranges:
> >>>>>>>>>>> [    0.305248] rockchip-pcie f8000000.pcie:      MEM 0x00fa00=
0000..0x00fbdfffff ->
> >>>>>>>>>>> 0x00fa000000
> >>>>>>>>>>> [    0.305285] rockchip-pcie f8000000.pcie:       IO 0x00fbe0=
0000..0x00fbefffff ->
> >>>>>>>>>>> 0x00fbe00000
> >>>>>>>>>>> [    0.306201] rockchip-pcie f8000000.pcie: supply vpcie1v8 n=
ot found, using dummy
> >>>>>>>>>>> regulator
> >>>>>>>>>>> [    0.306334] rockchip-pcie f8000000.pcie: supply vpcie0v9 n=
ot found, using dummy
> >>>>>>>>>>> regulator
> >>>>>>>>>>> [    0.373705] rockchip-pcie f8000000.pcie: PCI host bridge t=
o bus 0000:00
> >>>>>>>>>>> [    0.373730] pci_bus 0000:00: root bus resource [bus 00-1f]
> >>>>>>>>>>> [    0.373751] pci_bus 0000:00: root bus resource [mem 0xfa00=
0000-0xfbdfffff 64bit]
> >>>>>>>>>>> [    0.373777] pci_bus 0000:00: root bus resource [io  0x0000=
-0xfffff] (bus
> >>>>>>>>>>> address [0xfbe00000-0xfbefffff])
> >>>>>>>>>>> [    0.373839] pci 0000:00:00.0: [1d87:0100] type 01 class 0x=
060400
> >>>>>>>>>>> [    0.373973] pci 0000:00:00.0: supports D1
> >>>>>>>>>>> [    0.373992] pci 0000:00:00.0: PME# supported from D0 D1 D3=
hot
> >>>>>>>>>>> [    0.378518] pci 0000:00:00.0: bridge configuration invalid=
 ([bus 00-00]),
> >>>>>>>>>>> reconfiguring
> >>>>>>>>>>> [    0.378765] pci 0000:01:00.0: [144d:a808] type 00 class 0x=
010802
> >>>>>>>>>>> [    0.378869] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x=
00003fff 64bit]
> >>>>>>>>>>> [    0.379051] pci 0000:01:00.0: Max Payload Size set to 256 =
(was 128, max 256)
> >>>>>>>>>>> [    0.379661] pci 0000:01:00.0: 8.000 Gb/s available PCIe ba=
ndwidth, limited by
> >>>>>>>>>>> 2.5 GT/s PCIe x4 link at 0000:00:00.0 (capable of 31.504 Gb/s=
 with 8.0 GT/s PCIe
> >>>>>>>>>>> x4 link)
> >>>>>>>>>>> [    0.393269] pci_bus 0000:01: busn_res: [bus 01-1f] end is =
updated to 01
> >>>>>>>>>>> [    0.393311] pci 0000:00:00.0: BAR 14: no space for [mem si=
ze 0x00100000]
> >>>>>>>>>>> [    0.393333] pci 0000:00:00.0: BAR 14: failed to assign [me=
m size 0x00100000]
> >>>>>>>>>>> [    0.393356] pci 0000:01:00.0: BAR 0: no space for [mem siz=
e 0x00004000 64bit]
> >>>>>>>>>>> [    0.393375] pci 0000:01:00.0: BAR 0: failed to assign [mem=
 size 0x00004000 64bit]
> >>>>>>>>>>> [    0.393397] pci 0000:00:00.0: PCI bridge to [bus 01]
> >>>>>>>>>>> [    0.393839] pcieport 0000:00:00.0: PME: Signaling with IRQ=
 78
> >>>>>>>>>>> [    0.394165] pcieport 0000:00:00.0: AER: enabled with IRQ 7=
8
> >>>>>>>>>>> [..]
> >>>>>>>>>>> to the commit 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to
> >>>>>>>>>>> resource flags for
> >>>>>>>>>>> 64-bit memory addresses").
> >>>>>>>>>>
> >>>>>>>>>> FWFW, my hunch is that the host bridge advertising no 32-bit m=
emory
> >>>>>>>>>> resource, only only a single 64-bit non-prefetchable one (even=
 though
> >>>>>>>>>> it's entirely below 4GB) might be a bit weird and tripping som=
ething
> >>>>>>>>>> up in the resource assignment code. It certainly seems like th=
e thing
> >>>>>>>>>> most directly related to the offending commit.
> >>>>>>>>>>
> >>>>>>>>>> I'd be tempted to try fiddling with that in the DT (i.e. chang=
ing
> >>>>>>>>>> 0x83000000 to 0x82000000 in the PCIe node's "ranges" property)=
 to see
> >>>>>>>>>> if it makes any difference. Note that even if it helps, though=
, I
> >>>>>>>>>> don't know whether that's the correct fix or just a bodge arou=
nd a
> >>>>>>>>>> corner-case bug somewhere in the resource code.
> >>>>>>>>>
> >>>>>>>>>  From digging into this further the failure seems to be due to =
a mismatch
> >>>>>>>>> of flags when allocating resources in pci_bus_alloc_from_region=
() -
> >>>>>>>>>
> >>>>>>>>>      if ((res->flags ^ r->flags) & type_mask)
> >>>>>>>>>              continue;
> >>>>>>>>>
> >>>>>>>>> Though I am also not sure why the failure is only being reporte=
d on
> >>>>>>>>> RK3399 - does a single 64-bit window have anything to do with i=
t?
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> The NVMe in the example exposes a single 64-bit non-prefetchable=
 BAR.
> >>>>>>>> Such BARs can not be allocated in a prefetchable host bridge win=
dow
> >>>>>>>> (unlike the converse, i.e., allocating a prefetchable BAR in a
> >>>>>>>> non-prefetchable host bridge window is fine)
> >>>>>>>>
> >>>>>>>> 64-bit non-prefetchable host bridge windows cannot be forwarded =
by PCI
> >>>>>>>> to PCI bridges, they simply lack the BAR registers to describe t=
hem.
> >>>>>>>> Therefore, non-prefetchable endpoint BARs (even 64-bit ones) nee=
d to
> >>>>>>>> be carved out of a host bridge's non-prefetchable 32-bit window =
if
> >>>>>>>> they need to pass through a bridge.
> >>>>>>>
> >>>>>>> Thank you for the explanation. I also looked at the PCI-to-PCI Br=
idge
> >>>>>>> spec to understand where some of the limitations are coming from.
> >>>>>>>
> >>>>>>>> So the error seems to be here that the host bridge's 32-bit
> >>>>>>>> non-prefetchable window has the 64-bit attribute set, even thoug=
h it
> >>>>>>>> resides below 4 GB entirely. I suppose that the resource allocat=
ion
> >>>>>>>> could be made more forgiving (and it was in the past, before com=
mit
> >>>>>>>> 9d57e61bf723 was applied). However, I would strongly recommend n=
ot
> >>>>>>>> deviating from common practice, and just describe the 32-bit
> >>>>>>>> addressable non-prefetchable resource window as such.
> >>>>>>>
> >>>>>>> IIUC, the host bridge's configuration (64-bit on non-prefetchable
> >>>>>>> window) is based on what the hardware advertises.
> >>>>>>>
> >>>>>>
> >>>>>> What do you mean by 'what the hardware advertises'? The host bridg=
e is
> >>>>>> apparently configured to decode a 32-bit addressable window as MMI=
O,
> >>>>>> and the question is why this window has the 64-bit attribute set i=
n
> >>>>>> the DT description.
> >>>>>>
> >>>>>>> Can you elaborate on what you have in mind to correct the
> >>>>>>> non-prefetchable resource window? Are you thinking of adding a qu=
irk
> >>>>>>> somewhere to address this?
> >>>>>>>
> >>>>>>
> >>>>>> No. Just fix the DT.
> >>>>>
> >>>>> Good Morning,
> >>>>>
> >>>>> I believe Robin is correct that there is more to this.
> >>>>> While attempting to work out why dGPUs won't work with the rk356x
> >>>>> series PCIe controllers, Christian K=C3=B6nig from the amd-gpu driv=
er
> >>>>> mailing list noticed the gpu was incorrectly allocated a 64bit
> >>>>> non-prefetchable BAR which should instead be a 32 non-prefetchable
> >>>>> BAR.
> >>>>>
> >>>>
> >>>> This is due to the translation. For some reason, lspci translates th=
e
> >>>> BAR values to CPU addresses, but the PCI side addresses are within
> >>>> 32-bits.
> >>>
> >>> The kernel log reports the same thing:
> >>> [    6.662141] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x0fffffff
> >>> 64bit pref]
> >>> [    6.662963] pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x0001ffff=
 64bit]
> >>>
> >>> You are saying this is a display only issue?
> >>>
> >>
> >> Yes. What do the 'root bus resource' log lines say for these regions?
> >> Those should give you both the CPU address as well as the bus address.
> >
> > [    6.673497] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff]
> > (bus address [0x3f700000-0x3f7fffff])
> > [    6.674642] pci_bus 0000:00: root bus resource [mem
> > 0x300000000-0x33f6fffff] (bus address [0x00000000-0x3f6fffff])
>
> Assuming RK356x has a similar memory map to other Rockchip SoCs, I
> suspect you may have a larger issue with your mem space window shadowing
> a significant chunk of your RAM.
>
> Robin.

Delightfully they seem to have learned a thing or two.
The 1GB window resides outside the system ram space.
Though the mmio devices do still take up the tail end of the 4G space
at 0xf0000000 - 0xffffffff.
The system ram covers up to 0x2 0x00000000, the rk356x supports 8G of
ram (I know, on a 32 bit bus, I've raged about it already).
Then the PCIe controllers start at 0x3 0x00000000.
This makes it seem the controllers have dedicated on chip ram which
doesn't have direct access to system ram, though I don't know the
implications of this (if I'm even interpreting it correctly).

>
> >
> > I tweaked the original Rockchip values to place the non-prefetchable
> > memory first with the configuration and io later in this boot.
> >
> >>
> >>
> >>>>
> >>>> Are you sure the amdgpu driver can even deal with non-1:1 host bridg=
es?
> >>>
> >>> I cannot answer this as I'm not an amdgpu dev.
> >>>
> >>>>
> >>>>> The ranges currently set are:
> >>>>> ranges =3D <0x81000000 0x0 0x00800000 0x3 0x00800000 0x0 0x00100000
> >>>>> 0x82000000 0x0 0x00900000 0x3 0x00900000 0x0 0x3f700000>;
> >>>>>
> >>>>
> >>>> So you have two ranges here.
> >>>
> >>> The IO and PCI memory ranges.
> >>>
> >>> There is a third range, the configuration range, which is defined in
> >>> the reg block:
> >>> <0x3 0x00000000 0x0 0x800000>
> >>> All three are shared in the same 1GB window on the rk356x.
> >>>
> >>
> >> But the reg block is not a resource window, it is a configuration
> >> range to program the host bridge.
> >>
> >>> https://elixir.bootlin.com/linux/v5.13-rc3/source/Documentation/devic=
etree/bindings/pci/designware-pcie.txt#L12
> >>>
> >>>>
> >>>>> but the final allocation was:
> >>>>>
> >>>>> lspci -v
> >>>>> 00:00.0 PCI bridge: Fuzhou Rockchip Electronics Co., Ltd Device 356=
6
> >>>>> (rev 01) (prog-if 00 [Normal decode])
> >>>>>          Flags: bus master, fast devsel, latency 0, IRQ 96
> >>>>>          Bus: primary=3D00, secondary=3D01, subordinate=3Dff, sec-l=
atency=3D0
> >>>>>          I/O behind bridge: 00001000-00001fff [size=3D4K]
> >>>>>          Memory behind bridge: 00900000-009fffff [size=3D1M]
> >>>>>          Prefetchable memory behind bridge:
> >>>>> 0000000010000000-000000001fffffff [size=3D256M]
> >>>>
> >>>> But the host bridge/root port decodes two disjoint regions??
> >>>>
> >>>>>          Expansion ROM at 300a00000 [virtual] [disabled] [size=3D64=
K]
> >>>>>          Capabilities: [40] Power Management version 3
> >>>>>          Capabilities: [50] MSI: Enable+ Count=3D1/32 Maskable- 64b=
it+
> >>>>>          Capabilities: [70] Express Root Port (Slot-), MSI 00
> >>>>>          Capabilities: [b0] MSI-X: Enable- Count=3D1 Masked-
> >>>>>          Capabilities: [100] Advanced Error Reporting
> >>>>>          Capabilities: [148] Secondary PCI Express
> >>>>>          Capabilities: [160] L1 PM Substates
> >>>>>          Capabilities: [170] Vendor Specific Information: ID=3D0002=
 Rev=3D4
> >>>>> Len=3D100 <?>
> >>>>>          Kernel driver in use: pcieport
> >>>>>
> >>>>> 01:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> >>>>> [AMD/ATI] Turks PRO [Radeon HD 7570] (prog-if 00 [VGA controller])
> >>>>>          Subsystem: Dell Turks PRO [Radeon HD 7570]
> >>>>>          Flags: bus master, fast devsel, latency 0, IRQ 95
> >>>>>          Memory at 310000000 (64-bit, prefetchable) [size=3D256M]
> >>>>>          Memory at 300900000 (64-bit, non-prefetchable) [size=3D128=
K]
> >>>>>          I/O ports at 1000 [size=3D256]
> >>>>>          Expansion ROM at 300920000 [disabled] [size=3D128K]
> >>>>>          Capabilities: [50] Power Management version 3
> >>>>>          Capabilities: [58] Express Legacy Endpoint, MSI 00
> >>>>>          Capabilities: [a0] MSI: Enable- Count=3D1/1 Maskable- 64bi=
t+
> >>>>>          Capabilities: [100] Vendor Specific Information: ID=3D0001=
 Rev=3D1
> >>>>> Len=3D010 <?>
> >>>>>          Capabilities: [150] Advanced Error Reporting
> >>>>>          Kernel driver in use: radeon
> >>>>>
> >>>>> 01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Turks
> >>>>> HDMI Audio [Radeon HD 6500/6600 / 6700M Series]
> >>>>>          Subsystem: Dell Turks HDMI Audio [Radeon HD 6500/6600 / 67=
00M Series]
> >>>>>          Flags: bus master, fast devsel, latency 0, IRQ 98
> >>>>>          Memory at 300940000 (64-bit, non-prefetchable) [size=3D16K=
]
> >>>>>          Capabilities: [50] Power Management version 3
> >>>>>          Capabilities: [58] Express Legacy Endpoint, MSI 00
> >>>>>          Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bi=
t+
> >>>>>          Capabilities: [100] Vendor Specific Information: ID=3D0001=
 Rev=3D1
> >>>>> Len=3D010 <?>
> >>>>>          Capabilities: [150] Advanced Error Reporting
> >>>>>          Kernel driver in use: snd_hda_intel
> >>>>>
> >>>>> This will obviously clobber registers during writes.
> >>>>
> >>>> I don't follow. Which writes will clobber which registers, and how i=
s
> >>>> it obvious?
> >>>
> >>> Writing a 64 bit word into a 32 bit register will either clobber the
> >>> next higher 32 bit register.
> >>> Quoting Christian:
> >>> "When you program a 32bit BAR as 64bit you overwrite the register beh=
ind
> >>> the BAR address with the upper 32bits of the 64bit address value.
> >>> So even if the allocation fits into 32bits, the extra register write
> >>> will certainly put your device into a banana state."
> >>>
> >>> https://lists.freedesktop.org/archives/amd-gfx/2021-May/064232.html
> >>>
> >>
> >> I seriously doubt that this is what is going on here.
> >>
> >> lspci -x will give you the bare BAR values - I suspect that those are
> >> probably fine.
> >
> > lspci -x
> > 00:00.0 PCI bridge: Fuzhou Rockchip Electronics Co., Ltd Device 3566 (r=
ev 01)
> > 00: 87 1d 66 35 07 05 10 40 01 00 04 06 00 00 01 00
> > 10: 00 00 00 00 00 00 00 00 00 01 ff 00 10 10 00 20
> > 20: 00 10 00 10 01 00 f1 0f 00 00 00 00 00 00 00 00
> > 30: 00 00 00 00 40 00 00 00 00 00 00 00 5f 01 02 00
> >
> > 01:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> > [AMD/ATI] Turks PRO [Radeon HD 7570]
> > 00: 02 10 5d 67 07 00 10 20 00 00 00 03 00 00 80 00
> > 10: 0c 00 00 00 00 00 00 00 04 00 00 10 00 00 00 00
> > 20: 01 10 70 3f 00 00 00 00 00 00 00 00 28 10 20 2b
> > 30: 00 00 02 10 50 00 00 00 00 00 00 00 5f 01 00 00
> >
> > 01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Turks
> > HDMI Audio [Radeon HD 6500/6600 / 6700M Series]
> > 00: 02 10 90 aa 06 00 10 20 00 00 03 04 00 00 80 00
> > 10: 04 00 04 10 00 00 00 00 00 00 00 00 00 00 00 00
> > 20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 90 aa
> > 30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 02 00 00
> >
> >>
> >>
> >>>>
> >>>>> Also, if <0x82000000> (32 bit) is changed to <0x83000000> (64 bit),
> >>>>> most of the allocations for the dGPU fail due to no valid regions
> >>>>> available.
> >>>>>
> >>>>
> >>>> But wasn't the original problem that the resource window was 64-bit =
to
> >>>> begin with? Are you sure we are talking about the same problem here?
> >>>
> >>> The rk3399 in the original report has a 32MB memory window in the
> >>> upper end of the 4GB range.
> >>> The rk356x has a similar layout, or it can use a 1GB window available
> >>> at <0x3 0x00000000>.
> >>> Rockchip's default windows are defined as 64bit.
> >>>
> >>> The rk3399 doesn't have enough space to reasonably define two windows=
,
> >>> one 32bit, one 64bit, to work around an allocation bug.
> >>> These are the defined regions in the rk3399:
> >>> ranges =3D <0x83000000 0x0 0xfa000000 0x0 0xfa000000 0x0 0x1e00000>,
> >>> <0x81000000 0x0 0xfbe00000 0x0 0xfbe00000 0x0 0x100000>;
> >>>
> >>
> >> All you really need is a 32-bit non-prefetchable resource window: any
> >> BAR can be allocated from that. A 64-bit BAR can carry a 32-bit number
> >> (just add zeroes at the top), and a prefetchable BAR can happily live
> >> in a non-prefetchable window, with a theoretical performance impact if
> >> the OS actually does use different memory attributes for the
> >> prefetchable window (but I don't think Linux ever handles it this way)
> >
> > So is the IO range necessary as well or will it be automatically
> > allocated as well?
> >
> >>
> >>
> >>>
> >>>>
> >>>>
> >>>>>>
> >>>>>>> I am happy to put something together once I understand the prefer=
red way
> >>>>>>> to go about it.
> >>>>>>>
> >>>>>>> Thanks,
> >>>>>>> Punit
> >>>>>>>
> >>>>>>> [...]
> >>>>>>>
> >>>>>>
> >>>>>> _______________________________________________
> >>>>>> Linux-rockchip mailing list
> >>>>>> Linux-rockchip@lists.infradead.org
> >>>>>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
