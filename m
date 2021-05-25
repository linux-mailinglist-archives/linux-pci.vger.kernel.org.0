Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36A5390A3D
	for <lists+linux-pci@lfdr.de>; Tue, 25 May 2021 22:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbhEYUFI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 May 2021 16:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbhEYUFD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 May 2021 16:05:03 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264B7C06175F;
        Tue, 25 May 2021 13:03:32 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id v77so1264855ybi.3;
        Tue, 25 May 2021 13:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EjG4/YcUiUInF52I3SI8udsrAaIdhHacSgRDd972qfc=;
        b=snWOSXP/fQ2RaBcoTtGBdrjhSh8CXONtvb566iZwKOJty5cflo28kk3Hoc815K6EA0
         ulfnkFK8hrKxldGXo5bpoNNcFQNcVezK8R1x6fuwxdgOMRRConL5QIFsLYyT+8Marv5N
         qaRYVbAe2FPGdDJWxtdCJzXWHjO+wlDiRNTvj/eoLIPSe1v0ag/MZKvHIrleHDNHlcNk
         cRVeYnajzSKb7/GnERDMr4WB32Tp24uQlLKqVmkHx8Ykeu7QbXhkLOqqkNFxBDxeXaTJ
         np52FDhHuSnfQhcG0u3HH/91Oiypv6PgNVutcp1l318Rmzawgh5MWDpTYo6ONoVAAy71
         2qEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EjG4/YcUiUInF52I3SI8udsrAaIdhHacSgRDd972qfc=;
        b=Ez0JlrxkNiUor4i5JrGUiURpThuktZzEWtsWyx8LmTSn+yDUPEETcgbXc+4upKyxh+
         ZMnCn7ErNbph9CGP1WBzc5eCtTvmyF5OH/gO18gF5CxvG3rtQTd7Qe2CLVZF4ZvoASEo
         B67xoTakiv263zja8/Dzc0hl229tF4QUMZkLLzEGLZfDsLJYJHqU01qKKgCRTf2acGqa
         n2QfhWLijLXDxdea87WcwXN1PznFJxODMxvUpZufro16URWcie8fFJWkxcpmatZK5ilY
         dsZTFOEdCOx7sEeGRzxpXv8DfXjepVl/SzXGxi52FIPqt8T8DvpPPJr8uJKPKUqzk3Ax
         a0vA==
X-Gm-Message-State: AOAM532nefcDOqDHsL2TmBl+F3rkXpcVdrvSM0vY8jTEBHhsJE6038hO
        t74whVwm52tbEoJAO9TggtOj7dTUMAj+yxJtGbw=
X-Google-Smtp-Source: ABdhPJxD6gz64df0CaNFCYv+WmsmVsyOcBYumkbbqqHuetRBixAMPjetSMWs5TTFzHHBuwqeUE15OMrlFot8Hw6fhlE=
X-Received: by 2002:a5b:303:: with SMTP id j3mr42210666ybp.433.1621973011159;
 Tue, 25 May 2021 13:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXEBePfKDOc6eo9yjZPnVeFimX-zxR+R3As+2pP9XnZkuQ@mail.gmail.com>
 <20210525191556.GA1220872@bjorn-Precision-5520> <CAMj1kXG=dDwhNGe1tdHZH65KfcFzRHJKy6OwhWzYryZD9K9q_A@mail.gmail.com>
In-Reply-To: <CAMj1kXG=dDwhNGe1tdHZH65KfcFzRHJKy6OwhWzYryZD9K9q_A@mail.gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Tue, 25 May 2021 16:03:20 -0400
Message-ID: <CAMdYzYptcAyb3U3ZZvNL8GwdcP-a2X8MX+rji2z0nEuiw0Br5A@mail.gmail.com>
Subject: Re: [BUG] rockpro64: PCI BAR reassignment broken by commit
 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource flags for 64-bit
 memory addresses")
To:     Ard Biesheuvel <ardb@kernel.org>
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

On Tue, May 25, 2021 at 3:43 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 25 May 2021 at 21:15, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Tue, May 25, 2021 at 05:54:56PM +0200, Ard Biesheuvel wrote:
> > > On Tue, 25 May 2021 at 17:34, Peter Geis <pgwipeout@gmail.com> wrote:
> >
> > > > > > >> > On 2021-05-18 10:09, Alexandru Elisei wrote:
> > > > > > >> >> [..]
> > > > > > >> >> [    0.305183] rockchip-pcie f8000000.pcie: host bridge /pcie@f8000000 ranges:
> > > > > > >> >> [    0.305248] rockchip-pcie f8000000.pcie:      MEM 0x00fa000000..0x00fbdfffff -> 0x00fa000000
> > > > > > >> >> [    0.305285] rockchip-pcie f8000000.pcie:       IO 0x00fbe00000..0x00fbefffff -> 0x00fbe00000
> > > > > > >> >> [    0.373705] rockchip-pcie f8000000.pcie: PCI host bridge to bus 0000:00
> > > > > > >> >> [    0.373730] pci_bus 0000:00: root bus resource [bus 00-1f]
> > > > > > >> >> [    0.373751] pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfbdfffff 64bit]
> > > > > > >> >> [    0.373777] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff] (bus address [0xfbe00000-0xfbefffff])
> >
> > > ... For some reason, lspci translates the BAR values to CPU
> > > addresses, but the PCI side addresses are within 32-bits.
> >
> > lspci shows BARs as CPU physical addresses by default.  These are the
> > same addresses you would see in pdev->resource[n] and the same as BAR
> > values you would see in dmesg.
> >
> > A 64-bit CPU physical address can certainly be translated by the host
> > bridge to a 32-bit PCI address.  But that's not happening here because
> > this host bridge applies no translation (CPU physical 0xfa000000 maps
> > to bus address 0xfa000000).
> >
> > "lspci -b" shows the PCI bus addresses.
>
> Ah, thanks.
>
> It does seem, though, that the information overload in this thread is
> causing confusion now. Peter shared some log output where there is
> definitely MMIO translation being applied.

Yes, I've done work on the rk3399 pcie controller which is why this
caught my attention.
The original issue still seems to exist:
For some reason:
commit 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource flags for
64-bit memory addresses")
causes allocation issues now.
The original description of the issue aligned with issues I was having
bringing up the rk356x pcie controller.

>
> > > [    6.673497] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff]
> > > (bus address [0x3f700000-0x3f7fffff])
> > > [    6.674642] pci_bus 0000:00: root bus resource [mem
> > > 0x300000000-0x33f6fffff] (bus address [0x00000000-0x3f6fffff])
>
> In this case, the I/O translation definitely looks wrong. On a typical
> ARM DT system, you will see something like
>
> [    1.500324] Remapped I/O 0x0000000067f00000 to [io  0x0000-0xffff window]
> [    1.500522] pci_bus 0000:00: root bus resource [io  0x0000-0xffff window]
>
> The MMIO window looks correct, but I suspect that both 0x82000000 and
> 0x83000000 in the DT ranges are describing the resource window as
> prefetchable, preventing the allocation of non-prefetchable BARs in
> this window.

I checked with lspci -vvvbxxxxnn:

Before your changes:
00:00.0 PCI bridge [0604]: Fuzhou Rockchip Electronics Co., Ltd Device
[1d87:3566] (rev 01) (prog-if 00 [Normal decode])
        I/O behind bridge: 00001000-00001fff [size=4K]
        Memory behind bridge: 50000000-500fffff [size=1M]
        Prefetchable memory behind bridge:
0000000040000000-000000004fffffff [size=256M]
01:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc.
[AMD/ATI] Turks PRO [Radeon HD 7570] [1002:675d] (prog-if 00 [VGA
controller])
        Region 0: Memory at 40000000 (64-bit, prefetchable)
        Region 2: Memory at 50000000 (64-bit, non-prefetchable)
        Region 4: I/O ports at 7f701000
        Expansion ROM at 50020000 [disabled]

After your changes:
lspci -vvvbxxxxnn
00:00.0 PCI bridge: Fuzhou Rockchip Electronics Co., Ltd Device 3566
(rev 01) (prog-if 00 [Normal decode])
        I/O behind bridge: 00001000-00001fff [size=4K]
        Memory behind bridge: 10000000-100fffff [size=1M]
        Prefetchable memory behind bridge:
0000000000000000-000000000fffffff [size=256M]
01:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
[AMD/ATI] Turks PRO [Radeon HD 7570] (prog-if 00 [VGA controller])
        Region 0: Memory at <unassigned> (64-bit, prefetchable) [virtual]
        Region 2: Memory at 10000000 (64-bit, non-prefetchable) [virtual]
        Region 4: I/O ports at 1000 [virtual]
        Expansion ROM at 10020000 [disabled]

>
> Peter, for the configuration listed here, could you try something like
>
> ranges = <0x1000000 0x0 0x0 [IO base in the CPU address map] [IO size]>,
>          <0x2000000 0x0 0x0 [MMIO base in the CPU address map] [MMIO size]>;

That was similar to what I already had, removing the relocatable flag
and setting both addresses to 0x0 are the changes.

Here is the result:
[    6.410670] rockchip-dw-pcie 3c0000000.pcie: Looking up
vpcie3v3-supply from device tree
[    6.413924] rockchip-dw-pcie 3c0000000.pcie: host bridge
/pcie@fe260000 ranges:
[    6.414653] rockchip-dw-pcie 3c0000000.pcie: Parsing ranges property...
[    6.415321] rockchip-dw-pcie 3c0000000.pcie:       IO
0x033f700000..0x033f7fffff -> 0x0000000000
[    6.416375] rockchip-dw-pcie 3c0000000.pcie:      MEM
0x0300000000..0x033f6fffff -> 0x0000000000
[    6.417363] rockchip-dw-pcie 3c0000000.pcie: got 49 for legacy interrupt
[    6.418676] rockchip-dw-pcie 3c0000000.pcie: found 5 interrupts
[    6.419224] rockchip-dw-pcie 3c0000000.pcie: invalid resource
[    6.419764] rockchip-dw-pcie 3c0000000.pcie: iATU unroll: enabled
[    6.420388] rockchip-dw-pcie 3c0000000.pcie: Detected iATU regions:
8 outbound, 8 inbound
[    6.628630] rockchip-dw-pcie 3c0000000.pcie: Link up
[    6.631026] rockchip-dw-pcie 3c0000000.pcie: PCI host bridge to bus 0000:00
[    6.631734] pci_bus 0000:00: root bus resource [bus 00]
[    6.632548] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff]
[    6.633175] pci_bus 0000:00: root bus resource [mem
0x300000000-0x33f6fffff] (bus address [0x00000000-0x3f6fffff])
[    6.634170] pci_bus 0000:00: scanning bus
[    6.635052] pci 0000:00:00.0: disabling Extended Tags (this device
can't handle them)
[    6.635813] pci 0000:00:00.0: [1d87:3566] type 01 class 0x060400
[    6.636782] pci 0000:00:00.0: reg 0x38: [mem 0x300000000-0x30000ffff pref]
[    6.638302] pci 0000:00:00.0: supports D1 D2
[    6.638742] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
[    6.639432] pci 0000:00:00.0: PME# disabled
[    6.650984] pci_bus 0000:00: fixups for bus
[    6.651465] pci 0000:00:00.0: scanning [bus 01-ff] behind bridge, pass 0
[    6.653454] pci_bus 0000:01: busn_res: can not insert [bus 01-ff]
under [bus 00] (conflicts with (null) [bus 00])
[    6.654427] pci_bus 0000:01: scanning bus
[    6.655134] pci 0000:01:00.0: [1002:675d] type 00 class 0x030000
[    6.655938] pci 0000:01:00.0: reg 0x10: [mem
0x300000000-0x30fffffff 64bit pref]
[    6.656934] pci 0000:01:00.0: reg 0x18: [mem 0x300000000-0x30001ffff 64bit]
[    6.657677] pci 0000:01:00.0: reg 0x20: [io  0x0000-0x00ff]
[    6.658363] pci 0000:01:00.0: reg 0x30: [mem 0x300000000-0x30001ffff pref]
[    6.659845] pci 0000:01:00.0: supports D1 D2
[    6.660715] pci 0000:01:00.0: 2.000 Gb/s available PCIe bandwidth,
limited by 2.5 GT/s PCIe x1 link at 0000:00:00.0 (capable of 32.000
Gb/s with 2.5 GT/s PCIe x16 link)
[    6.664276] pci 0000:01:00.0: vgaarb: VGA device added:
decodes=io+mem,owns=none,locks=none
[    6.666120] pci 0000:01:00.1: [1002:aa90] type 00 class 0x040300
[    6.666922] pci 0000:01:00.1: reg 0x10: [mem 0x300000000-0x300003fff 64bit]
[    6.668888] pci 0000:01:00.1: supports D1 D2
[    6.680490] pci_bus 0000:01: fixups for bus
[    6.680941] pci_bus 0000:01: bus scan returning with max=01
[    6.681507] pci 0000:00:00.0: scanning [bus 01-ff] behind bridge, pass 1
[    6.682180] pci_bus 0000:00: bus scan returning with max=ff
[    6.682780] pci 0000:00:00.0: BAR 15: assigned [mem
0x300000000-0x30fffffff 64bit pref]
[    6.683535] pci 0000:00:00.0: BAR 14: assigned [mem 0x310000000-0x3100fffff]
[    6.684322] pci 0000:00:00.0: BAR 6: assigned [mem
0x310100000-0x31010ffff pref]
[    6.685021] pci 0000:00:00.0: BAR 13: assigned [io  0x1000-0x1fff]
[    6.685669] pci 0000:01:00.0: BAR 0: assigned [mem
0x300000000-0x30fffffff 64bit pref]
[    6.686500] pci 0000:01:00.0: BAR 2: assigned [mem
0x310000000-0x31001ffff 64bit]
[    6.687281] pci 0000:01:00.0: BAR 6: assigned [mem
0x310020000-0x31003ffff pref]
[    6.687985] pci 0000:01:00.1: BAR 0: assigned [mem
0x310040000-0x310043fff 64bit]
[    6.688872] pci 0000:01:00.0: BAR 4: assigned [io  0x1000-0x10ff]
[    6.689492] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    6.690000] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
[    6.690593] pci 0000:00:00.0:   bridge window [mem 0x310000000-0x3100fffff]
[    6.691254] pci 0000:00:00.0:   bridge window [mem
0x300000000-0x30fffffff 64bit pref]
[    6.694100] pcieport 0000:00:00.0: assign IRQ: got 95
[    6.695189] ITS ALLOCATE 2nd level WORKAROUND
[    6.727845] pcieport 0000:00:00.0: PME: Signaling with IRQ 96
[    6.729830] pcieport 0000:00:00.0: saving config space at offset
0x0 (reading 0x35661d87)
[    6.730587] pcieport 0000:00:00.0: saving config space at offset
0x4 (reading 0x100507)
[    6.731315] pcieport 0000:00:00.0: saving config space at offset
0x8 (reading 0x6040001)
[    6.732051] pcieport 0000:00:00.0: saving config space at offset
0xc (reading 0x10000)
[    6.733095] pcieport 0000:00:00.0: saving config space at offset
0x10 (reading 0x0)
[    6.733797] pcieport 0000:00:00.0: saving config space at offset
0x14 (reading 0x0)
[    6.734496] pcieport 0000:00:00.0: saving config space at offset
0x18 (reading 0xff0100)
[    6.735231] pcieport 0000:00:00.0: saving config space at offset
0x1c (reading 0x20001010)
[    6.735981] pcieport 0000:00:00.0: saving config space at offset
0x20 (reading 0x10001000)
[    6.736786] pcieport 0000:00:00.0: saving config space at offset
0x24 (reading 0xff10001)
[    6.737528] pcieport 0000:00:00.0: saving config space at offset
0x28 (reading 0x0)
[    6.738223] pcieport 0000:00:00.0: saving config space at offset
0x2c (reading 0x0)
[    6.738918] pcieport 0000:00:00.0: saving config space at offset
0x30 (reading 0x0)
[    6.739613] pcieport 0000:00:00.0: saving config space at offset
0x34 (reading 0x40)
[    6.740369] pcieport 0000:00:00.0: saving config space at offset
0x38 (reading 0x0)
[    6.741067] pcieport 0000:00:00.0: saving config space at offset
0x3c (reading 0x2015f)
[    6.742525] radeon 0000:01:00.0: assign IRQ: got 95
