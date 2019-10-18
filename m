Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3597DBD59
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2019 07:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405932AbfJRF5b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Oct 2019 01:57:31 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:33483 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392149AbfJRF5a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Oct 2019 01:57:30 -0400
Received: by mail-il1-f193.google.com with SMTP id v2so4466498ilm.0;
        Thu, 17 Oct 2019 22:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v+M2tX2DgtKA3kkMewSHY+fKTayeiYoP9LYwS9dgA14=;
        b=P9A9N1lHIJkQDetZJqEI/wavjXMt2268QXo5cJzJ6N61Xj8ANoj5Wbis1DCxMLXPgP
         Dx/tA39Bnn5JLLvaTOgqoa5n9R8MaC/1V2j5mGUkUWtkrwuKNUOuN3xdbgY455CEky+B
         /urkOfXC3787dzB5b4+1GIaUCjKRvFZ8BpWd6EukTM1IL54y1nxnTpaVJh+rhffRTRFM
         M+ovUXWac3kHz6uCjT1Gx4d9/mP1pBZ/t05EUkuTLMRvoPxTMUOB0IJ7jwDoeJWYAIat
         OqUwoBMJOPwsnWWH1vXxWb9NHnjtD7uSLl+GOlAgCuxD211lKbWaPwjNENhQFqtVUoVG
         za4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v+M2tX2DgtKA3kkMewSHY+fKTayeiYoP9LYwS9dgA14=;
        b=pxlN55qXeKLi2gByl1EO0rBjrhZFL7wInX69jnk8tybbcEsnd+91fSbTPvi+s7FZsa
         fsiELqPMzK54234Ob/ZDtbNGUF+X/9+kZChg/rqLh5LLMaAvr340ZCmYCus9CgPsLRTD
         Geiq3pHpi11s0nuFabu72spEWECVRMQ6tivmdkDxbWKBJh3al/V6GgOKLnoxElYoo1GM
         mt1GWTm/FMczbkfqS8uL72b72DB+UQKF+1ToAii/7l8/6PYjPw93W65OYLhXrmHoJ/P1
         c6jA9JUBAcsyXPG1sEHWipDPRS0sHjdTdgbBuajHZD2jDgF0Jg7DlbaiXfCdx4MERBqw
         Im3A==
X-Gm-Message-State: APjAAAVUdPS6vikWkzHmTRcTk2Qyh/Oxo5OgQifxiD/mplh7VznMTWXh
        2xsboaQnLjQmHzRuEQKpPNCkSAvE32usbUHkv+c=
X-Google-Smtp-Source: APXvYqyQXn77bw6iczt5uOGmJA6gor3JK7GCFr5x20m6CyOXahHnr/Iz5jn+emG6UsVaqNRX64tui3w76SXGFrrZiJo=
X-Received: by 2002:a92:d784:: with SMTP id d4mr8427217iln.110.1571378248806;
 Thu, 17 Oct 2019 22:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAEdQ38GUhL0R4c7ZjEZv89TmqQ0cwhnvBawxuXonSb9On=+B6A@mail.gmail.com>
 <20180416215044.GE28657@bhelgaas-glaptop.roam.corp.google.com>
 <CAEdQ38EdxHigQiH_k=+4enbHAutbWOE6Kc5C81ghfsC3pwELjw@mail.gmail.com>
 <20180417194344.GK28657@bhelgaas-glaptop.roam.corp.google.com>
 <20180418204808.GA2352@mail.rc.ru> <CAEdQ38H-SGfj5rijGv2iJYWGfwnn6iWc=xot+HFMbJSu5rEd0Q@mail.gmail.com>
 <20180423173423.GA9138@mail.rc.ru>
In-Reply-To: <20180423173423.GA9138@mail.rc.ru>
From:   Matt Turner <mattst88@gmail.com>
Date:   Thu, 17 Oct 2019 22:57:17 -0700
Message-ID: <CAEdQ38EYADrMVHS0-_N_dxnVAGaNvCbcG8T-Z39v-ne-Vc9Auw@mail.gmail.com>
Subject: Re: Some Alphas broken by f75b99d5a77d (PCI: Enforce bus address
 limits in resource allocation)
To:     Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
        linux-alpha <linux-alpha@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Jay Estabrook <jay.estabrook@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 23, 2018 at 10:34 AM Ivan Kokshaysky
<ink@jurassic.park.msu.ru> wrote:
>
> On Sun, Apr 22, 2018 at 01:07:38PM -0700, Matt Turner wrote:
> > On Wed, Apr 18, 2018 at 1:48 PM, Ivan Kokshaysky
> > <ink@jurassic.park.msu.ru> wrote:
> > > On Tue, Apr 17, 2018 at 02:43:44PM -0500, Bjorn Helgaas wrote:
> > >> On Mon, Apr 16, 2018 at 09:43:42PM -0700, Matt Turner wrote:
> > >> > On Mon, Apr 16, 2018 at 2:50 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >> > > Hi Matt,
> > >> > >
> > >> > > First of all, sorry about breaking Nautilus, and thanks very much for
> > >> > > tracking it down to this commit.
> > >> >
> > >> > It's a particularly weird case, as far as I've been able to discern :)
> > >> >
> > >> > > On Mon, Apr 16, 2018 at 07:33:57AM -0700, Matt Turner wrote:
> > >> > >> Commit f75b99d5a77d63f20e07bd276d5a427808ac8ef6 (PCI: Enforce bus
> > >> > >> address limits in resource allocation) broke Alpha systems using
> > >> > >> CONFIG_ALPHA_NAUTILUS. Alpha is 64-bit, but Nautilus systems use a
> > >> > >> 32-bit AMD 751/761 chipset. arch/alpha/kernel/sys_nautilus.c maps PCI
> > >> > >> into the upper addresses just below 4GB.
> > >> > >>
> > >> > >> I can get a working kernel by ifdef'ing out the code in
> > >> > >> drivers/pci/bus.c:pci_bus_alloc_resource. We can't tie
> > >> > >> PCI_BUS_ADDR_T_64BIT to ALPHA_NAUTILUS without breaking generic
> > >> > >> kernels.
> > >> > >>
> > >> > >> How can we get Nautilus working again?
> > >> > >
> > >> > > Can you collect a complete dmesg log, ideally both before and after
> > >> > > f75b99d5a77d?  I assume the problem is that after f75b99d5a77d? we
> > >> > > erroneously assign space for something above 4GB.  But if we know the
> > >> > > correct host bridge apertures, we shouldn't assign space outside them,
> > >> > > regardless of the PCI bus address size.
> > >> >
> > >> > I made a mistake in my initial report. Commit f75b99d5a77d is actually
> > >> > the last *working* commit. My apologies. The next commit is
> > >> > d56dbf5bab8c (PCI: Allocate 64-bit BARs above 4G when possible) and it
> > >> > breaks Nautilus I've confirmed.
> > >> >
> > >> > Please find attached dmesgs from those two commits, from the commit
> > >> > immediately before them, and another from 4.17-rc1 with my hack of #if
> > >> > 0'ing out the pci_bus_alloc_from_region(..., &pci_high) code.
> > >> >
> > >> > Thanks for having a look!
> > >>
> > >> We're telling the PCI core that the host bridge MMIO aperture is the
> > >> entire 64-bit address space, so when we assign BARs, some of them end
> > >> up above 4GB:
> > >>
> > >>   pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffffffffffff]
> > >>   pci 0000:00:09.0: BAR 0: assigned [mem 0x100000000-0x10000ffff 64bit]
> > >>
> > >> But it sounds like the MMIO aperture really ends at 0xffffffff, so
> > >> that's not going to work.
> > >
> > > Correct... This would do as a quick fix, I think:
> > >
> > > diff --git a/arch/alpha/kernel/sys_nautilus.c b/arch/alpha/kernel/sys_nautilus.c
> > > index ff4f54b..477ba65 100644
> > > --- a/arch/alpha/kernel/sys_nautilus.c
> > > +++ b/arch/alpha/kernel/sys_nautilus.c
> > > @@ -193,6 +193,8 @@ static struct resource irongate_io = {
> > >  };
> > >  static struct resource irongate_mem = {
> > >         .name   = "Irongate PCI MEM",
> > > +       .start  = 0,
> > > +       .end    = 0xffffffff,
> > >         .flags  = IORESOURCE_MEM,
> > >  };
> > >  static struct resource busn_resource = {
> > > @@ -218,7 +220,7 @@ nautilus_init_pci(void)
> > >                 return;
> > >
> > >         pci_add_resource(&bridge->windows, &ioport_resource);
> > > -       pci_add_resource(&bridge->windows, &iomem_resource);
> > > +       pci_add_resource(&bridge->windows, &irongate_mem);
> > >         pci_add_resource(&bridge->windows, &busn_resource);
> > >         bridge->dev.parent = NULL;
> > >         bridge->sysdata = hose;
> >
> > Thanks. But with that I get
> >
> > PCI host bridge to bus 0000:00
> > pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> > pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffff]
> > pci_bus 0000:00: root bus resource [bus 00-ff]
> > pci 0000:00:10.0: [Firmware Bug]: reg 0x10: invalid BAR (can't size)
> > pci 0000:00:10.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
> > pci 0000:00:10.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
> > pci 0000:00:10.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
> > pci 0000:00:10.0: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
> > pci 0000:00:10.0: legacy IDE quirk: reg 0x14: [io  0x03f6]
> > pci 0000:00:10.0: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
> > pci 0000:00:10.0: legacy IDE quirk: reg 0x1c: [io  0x0376]
> > pci 0000:00:11.0: quirk: [io  0x4000-0x403f] claimed by ali7101 ACPI
> > pci 0000:00:11.0: quirk: [io  0x5000-0x501f] claimed by ali7101 SMB
> > pci 0000:00:01.0: BAR 9: assigned [mem 0xc0000000-0xc2ffffff pref]
> > pci 0000:00:01.0: BAR 8: assigned [mem 0xc3000000-0xc3bfffff]
> > pci 0000:00:0b.0: BAR 6: assigned [mem 0xc3c00000-0xc3c3ffff pref]
> > pci 0000:00:08.0: BAR 6: assigned [mem 0xc3c40000-0xc3c5ffff pref]
> > pci 0000:00:09.0: BAR 0: assigned [mem 0xc3c60000-0xc3c6ffff 64bit]
> > pci 0000:00:03.0: BAR 0: assigned [mem 0xc3c70000-0xc3c70fff]
> > pci 0000:00:06.0: BAR 1: assigned [mem 0xc3c71000-0xc3c71fff]
> > pci 0000:00:08.0: BAR 1: assigned [mem 0xc3c72000-0xc3c72fff 64bit]
> > pci 0000:00:14.0: BAR 0: assigned [mem 0xc3c73000-0xc3c73fff]
> > pci 0000:00:0b.0: BAR 1: assigned [mem 0xc3c74000-0xc3c743ff]
> > pci 0000:00:03.0: BAR 1: assigned [io  0x8000-0x80ff]
> > pci 0000:00:06.0: BAR 0: assigned [io  0x8400-0x84ff]
> > pci 0000:00:08.0: BAR 0: assigned [io  0x8800-0x88ff]
> > pci 0000:00:0b.0: BAR 0: assigned [io  0x8c00-0x8c7f]
> > pci 0000:00:10.0: BAR 4: assigned [io  0x8c80-0x8c8f]
> > pci 0000:01:05.0: BAR 0: assigned [mem 0xc0000000-0xc1ffffff pref]
> > pci 0000:01:05.0: BAR 2: assigned [mem 0xc3000000-0xc37fffff]
> > pci 0000:01:05.0: BAR 6: assigned [mem 0xc2000000-0xc200ffff pref]
> > pci 0000:01:05.0: BAR 1: assigned [mem 0xc3800000-0xc3803fff]
> > pci 0000:00:01.0: PCI bridge to [bus 01]
> > pci 0000:00:01.0:   bridge window [mem 0xc3000000-0xc3bfffff]
> > pci 0000:00:01.0:   bridge window [mem 0xc0000000-0xc2ffffff pref]
> >
> > Looks like the bridge window is overlapping with some previously assigned BARs?
>
> No, there are no overlaps. This is AGP bridge window with AGP card BARs
> inside it.
>
> > The result is the SCSI card failing to work:
> >
> > scsi host0: Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
> >         <Adaptec 29160 Ultra160 SCSI adapter>
> >         aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
> >
> > scsi0: ahc_intr - referenced scb not valid during SELTO scb(0, 255)
> > >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
> > scsi0: Dumping Card State while idle, at SEQADDR 0x18
> > [snip endless spew]
>
> It looks like Irongate PCI memory window setting is completely wrong,
> perhaps it starts at zero, so that PCI DMA doesn't work at all.
>
> Please try the patch below. It tries to fix things properly, but if
> PCI bus sizing fails for some reason, it falls back to a "safe" PCI
> memory window placement at 3GB.
>
> Ivan.
>
> diff --git a/arch/alpha/kernel/sys_nautilus.c b/arch/alpha/kernel/sys_nautilus.c
> index ff4f54b..b1fb9fd 100644
> --- a/arch/alpha/kernel/sys_nautilus.c
> +++ b/arch/alpha/kernel/sys_nautilus.c
> @@ -187,10 +187,6 @@ nautilus_machine_check(unsigned long vector, unsigned long la_ptr)
>
>  extern void pcibios_claim_one_bus(struct pci_bus *);
>
> -static struct resource irongate_io = {
> -       .name   = "Irongate PCI IO",
> -       .flags  = IORESOURCE_IO,
> -};
>  static struct resource irongate_mem = {
>         .name   = "Irongate PCI MEM",
>         .flags  = IORESOURCE_MEM,
> @@ -218,7 +214,7 @@ nautilus_init_pci(void)
>                 return;
>
>         pci_add_resource(&bridge->windows, &ioport_resource);
> -       pci_add_resource(&bridge->windows, &iomem_resource);
> +       pci_add_resource(&bridge->windows, &irongate_mem);
>         pci_add_resource(&bridge->windows, &busn_resource);
>         bridge->dev.parent = NULL;
>         bridge->sysdata = hose;
> @@ -238,20 +234,25 @@ nautilus_init_pci(void)
>         pcibios_claim_one_bus(bus);
>
>         irongate = pci_get_domain_bus_and_slot(pci_domain_nr(bus), 0, 0);
> +       /* Pretend that it's not a root bus to allow sizing. */
> +       bus->parent = bus;
>         bus->self = irongate;
> -       bus->resource[0] = &irongate_io;
> -       bus->resource[1] = &irongate_mem;
>
>         pci_bus_size_bridges(bus);
> -
> -       /* IO port range. */
> -       bus->resource[0]->start = 0;
> -       bus->resource[0]->end = 0xffff;
> +       bus->parent = NULL;
>
>         /* Set up PCI memory range - limit is hardwired to 0xffffffff,
>            base must be at aligned to 16Mb. */
> -       bus_align = bus->resource[1]->start;
> -       bus_size = bus->resource[1]->end + 1 - bus_align;
> +       if (bus->resource[1]->end) {

Log inline below, but we get a segfault here, presumably because
bus->resource[1] is NULL.

In case it was supposed to be resource[0], I tried that as well (and
throughout) with the same result.

> +               bus_align = bus->resource[1]->start;
> +               bus_size = bus->resource[1]->end + 1 - bus_align;
> +               printk(KERN_INFO "PCI MEM size 0x%08lx, align 0x%08lx\n",
> +                       bus_size, bus_align);
> +       } else {
> +               bus_size = 0x100000000UL - memtop;
> +               bus_align = bus_size;
> +               printk(KERN_ERR "PCI MEM sizing failed, using 3GB limit\n");
> +       }
>         if (bus_align < 0x1000000UL)
>                 bus_align = 0x1000000UL;

[    0.045898] PCI host bridge to bus 0000:00
[    0.046874] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.047851] pci_bus 0000:00: root bus resource [mem 0x00000000]
[    0.048828] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.049804] pci 0000:00:00.0: [1022:700e] type 00 class 0x060000
[    0.050781] pci 0000:00:00.0: reg 0x14: [mem 0x40000000-0x40000fff pref]
[    0.051757] pci 0000:00:00.0: reg 0x18: [io  0x101f0-0x101f3]
[    0.052734] pci 0000:00:01.0: [1022:700f] type 01 class 0x060400
[    0.053710] pci 0000:00:03.0: [10b9:5457] type 00 class 0x070300
[    0.054687] pci 0000:00:03.0: reg 0x10: [mem 0x80128000-0x80128fff]
[    0.055664] pci 0000:00:03.0: reg 0x14: [io  0x1000-0x10ff]
[    0.056640] pci 0000:00:03.0: PME# supported from D3hot D3cold
[    0.057617] pci 0000:00:06.0: [10b9:5451] type 00 class 0x040100
[    0.058593] pci 0000:00:06.0: reg 0x10: [io  0x10000-0x100ff]
[    0.059570] pci 0000:00:06.0: reg 0x14: [mem 0x80129000-0x80129fff]
[    0.060546] pci 0000:00:06.0: supports D1 D2
[    0.061523] pci 0000:00:06.0: PME# supported from D2 D3hot D3cold
[    0.062499] pci 0000:00:07.0: [10b9:1533] type 00 class 0x060100
[    0.064453] pci 0000:00:09.0: [8086:107c] type 00 class 0x020000
[    0.065429] pci 0000:00:09.0: reg 0x10: [mem 0x800c0000-0x800dffff]
[    0.066406] pci 0000:00:09.0: reg 0x14: [mem 0x800e0000-0x800fffff]
[    0.067382] pci 0000:00:09.0: reg 0x18: [io  0x10180-0x101bf]
[    0.068359] pci 0000:00:09.0: reg 0x30: [mem 0x80100000-0x8011ffff pref]
[    0.069335] pci 0000:00:09.0: PME# supported from D0 D3hot D3cold
[    0.070312] pci 0000:00:0a.0: [1095:3124] type 00 class 0x010400
[    0.071289] pci 0000:00:0a.0: reg 0x10: [mem 0x8012b400-0x8012b47f 64bit]
[    0.072265] pci 0000:00:0a.0: reg 0x18: [mem 0x80120000-0x80127fff 64bit]
[    0.073242] pci 0000:00:0a.0: reg 0x20: [io  0x101c0-0x101cf]
[    0.074218] pci 0000:00:0a.0: reg 0x30: [mem 0x80000000-0x8007ffff pref]
[    0.075195] pci 0000:00:0a.0: supports D1 D2
[    0.076171] pci 0000:00:0b.0: [1011:0019] type 00 class 0x020000
[    0.077148] pci 0000:00:0b.0: reg 0x10: [io  0x10100-0x1017f]
[    0.078124] pci 0000:00:0b.0: reg 0x14: [mem 0x8012b000-0x8012b3ff]
[    0.079101] pci 0000:00:0b.0: reg 0x30: [mem 0x80080000-0x800bffff pref]
[    0.080078] pci 0000:00:10.0: [10b9:5229] type 00 class 0x0101fa
[    0.081054] pci 0000:00:10.0: [Firmware Bug]: reg 0x10: invalid BAR
(can't size)
[    0.082031] pci 0000:00:10.0: [Firmware Bug]: reg 0x14: invalid BAR
(can't size)
[    0.083007] pci 0000:00:10.0: [Firmware Bug]: reg 0x18: invalid BAR
(can't size)
[    0.083984] pci 0000:00:10.0: [Firmware Bug]: reg 0x1c: invalid BAR
(can't size)
[    0.084960] pci 0000:00:10.0: reg 0x20: [io  0x101e0-0x101ef]
[    0.085937] pci 0000:00:10.0: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.086914] pci 0000:00:10.0: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.087890] pci 0000:00:10.0: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.088867] pci 0000:00:10.0: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.089843] pci 0000:00:11.0: [10b9:7101] type 00 class 0x000000
[    0.090820] pci 0000:00:11.0: quirk: [io  0x4000-0x403f] claimed by
ali7101 ACPI
[    0.091796] pci 0000:00:11.0: quirk: [io  0x5000-0x501f] claimed by
ali7101 SMB
[    0.092773] pci 0000:00:14.0: [10b9:5237] type 00 class 0x0c0310
[    0.093749] pci 0000:00:14.0: reg 0x10: [mem 0x8012a000-0x8012afff]
[    0.094726] pci_bus 0000:01: extended config space not accessible
[    0.095703] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[    0.099609] Unable to handle kernel paging request at virtual
address 0000000000000008
[    0.100585] swapper(1): Oops 0
[    0.101562] pc = [<fffffc0000c085e0>]  ra = [<fffffc0000c085d4>]
ps = 0000    Not tainted
[    0.102539] pc is at nautilus_init_pci+0x1e0/0x3d4
[    0.103515] ra is at nautilus_init_pci+0x1d4/0x3d4
[    0.104492] v0 = 0000000000000001  t0 = 0000000000000000  t1 =
fffffc0000c40db8
[    0.105468] t2 = fffffc0000c40de0  t3 = 0000000000000062  t4 =
0000000000000001
[    0.106445] t5 = 0000000000000400  t6 = 0000000000000035  t7 =
fffffc00bf884000
[    0.107421] s0 = fffffc00bf86e400  s1 = fffffc00bf86e1b8  s2 =
00000000ffff4000
[    0.108398] s3 = fffffc0000c69638  s4 = fffffc0000d1c000  s5 =
fffffc0000c69638
[    0.109374] s6 = fffffc0000ca5cd8
[    0.110351] a0 = 0000000000000000  a1 = fffffd01fc0003f9  a2 =
0000000000000000
[    0.111328] a3 = fffffc000070c140  a4 = 0000000000000010  a5 =
0000000000000000
[    0.112304] t8 = fffffc0000ca5cd8  t9 = fffffc0000ca5cd8  t10=
0000000000000000
[    0.113281] t11= 0000000000000062  pv = fffffc0000363290  at =
0000000000000007
[    0.114257] gp = fffffc0000c95cd8  sp = (____ptrval____)
[    0.115234] Disabling lock debugging due to kernel taint
[    0.116210] Trace:
[    0.117187] [<fffffc00003101c8>] do_one_initcall+0x98/0x250
[    0.118164] [<fffffc0000a2ffc4>] kernel_init+0x20/0x17c
[    0.119140] [<fffffc0000a2ffa4>] kernel_init+0x0/0x17c
[    0.120117] [<fffffc00003117a8>] ret_from_kernel_thread+0x18/0x20
[    0.121093] [<fffffc0000a2ffa4>] kernel_init+0x0/0x17c
[    0.122070]
[    0.123046] Code:
[    0.123046]  261dffe5
[    0.124023]  2210acfc
[    0.124999]  6b5b6edf
[    0.125976]  27ba0009
[    0.126953]  a4290050
[    0.127929]  23bdd704
[    0.128906] <a4210008>
[    0.129882]  e420001a
[    0.130859]
[    0.132812] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b
