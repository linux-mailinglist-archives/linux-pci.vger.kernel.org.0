Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7DD4157F8
	for <lists+linux-pci@lfdr.de>; Thu, 23 Sep 2021 07:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhIWFxK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Sep 2021 01:53:10 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:38365 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhIWFxK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Sep 2021 01:53:10 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MHndY-1mfwp52EfW-00Eww3; Thu, 23 Sep 2021 07:51:37 +0200
Received: by mail-wr1-f47.google.com with SMTP id t8so13726791wrq.4;
        Wed, 22 Sep 2021 22:51:37 -0700 (PDT)
X-Gm-Message-State: AOAM530JoP3fg7UVosXQOvuL9bnSZiIHkZ7PnD1o0nLsEV4OhUj+4Ohz
        TLTBLKHPoa9LufNBzrsc7RNrZfMxI67LH+Btsa8=
X-Google-Smtp-Source: ABdhPJzkTUOlS4kEZT3tzZYt8PlsmOMnXhexjU4isdYGYLh2wRHGnsmdFDp9P8R+wr45AFlj/98UMh/w3gOpZJfNzx4=
X-Received: by 2002:a1c:7413:: with SMTP id p19mr2506337wmc.98.1632376297156;
 Wed, 22 Sep 2021 22:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210922042041.16326-1-sergio.paracuellos@gmail.com>
 <CAK8P3a2WPOYS7ra_epyZ_bBBpPK8+AgEynK0pKOUZ6ajubcHew@mail.gmail.com>
 <CAMhs-H8EyBmahhLsx+a0aoy+znY=PCm4BT97UBg4xcAy3x2oXg@mail.gmail.com>
 <CAK8P3a0fQZvpNCKF7OUy_krC_YPyigtd5Ak_AMXXpx84HKMswA@mail.gmail.com>
 <CAMhs-H-OCm1p6mTTV6s=vPx7FV8+1UMzx0X00wvXkW=5OgFQBQ@mail.gmail.com>
 <CAK8P3a1iN76A5ahTTQ6rCS4LjKHz8grkNGHGehLJnd0xQSnHXA@mail.gmail.com> <CAMhs-H_hZk3hruCaWRjKjUSj6vhVE+JZfk9nT7v1=mcc-H9wnw@mail.gmail.com>
In-Reply-To: <CAMhs-H_hZk3hruCaWRjKjUSj6vhVE+JZfk9nT7v1=mcc-H9wnw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 23 Sep 2021 07:51:20 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3C0rG_JWWCU6T4B=+j2-+6S6Gq+aw_9e6XeVun9LoF0w@mail.gmail.com>
Message-ID: <CAK8P3a3C0rG_JWWCU6T4B=+j2-+6S6Gq+aw_9e6XeVun9LoF0w@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: of: Avoid pci_remap_iospace() when PCI_IOBASE not defined
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev, gregkh <gregkh@linuxfoundation.org>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Rob Herring <robh@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:xv8RrzNmREWG4GMhF/nNNp5j9QdW14KzunUs7vE2EL2E/13tKTN
 PJ0kiNwNdFT4yGitK0tG8afr3AnE2xnZsIIP/U0o8FlSu0co9Tfcw2jyEw1hEYf/cKhPNkV
 NPg5lFz+ISxvwuQVrbXdtIOsu+t66+mnAlSoOecnQkVTDgoDUCJ/F6NSrUW4fp1n8GlZ8d2
 69P1DLUycDGeT6jb7fQcQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LXtt0IuK74s=:zdz9X0yvWoKc+I7SykUiwz
 kmsmE6Ezov6KczQTaZlRZj3EProRv1LRrQ0sSGwapT18jROLGtvBzk54U7+PFp90sh/zytbyo
 vUZJPYlukYWyyM8qRfw7lClDwcWqmHFS8+gox6RZEnvM2GG92N8/L2K+eRfZeMMH241iKlyyJ
 UD4UKeahIqhA5j2Ekx2f//JADfycKUowfCbD/AaxnZjZDmkwMVgujikTvA2tiLMYRX8kkHwSj
 7Gr7aAVkJna61tFfc33RgXtMLPmRE2tQ149ys1eW3WdO65RTKg1AF5HWADw/WbVn891/W4trp
 8drAud3vmGBHy5oglwq9dUXjIULBxZdYWMTyzcYAGDxPbmxUbe2yPeU98xY6X040nsrSUrDoy
 dG5oUQ9h3826md1bk2FrBpGpgzrz4TZqGjnnATzlcOwurKHE5kyVPnBU5KSvil9EFF5iDvxcY
 /QLi60xPscNwpcBBFxZk/9GoazT6URdo48P7igT2tmTuJzOOzVgZ0FE3BbY3ng/2gn4QMqvR3
 cjwbovUtxvd24WtK6ZRzyrgA2HflGRhansx1acpWkvLe3fE7uMPmZKPojrXmxIEda/CkZ8rDI
 A/XDF/Dt+2EodgGAaXx3Caqo5mo/Ei68E3S+IWrAbZm8qwChh8C1cfbgYDx2aKOT7U2GVYJN2
 L5PN82rdnnP9XBbcH69zmotgN+w3UJwmAS6BE8+5JpLoNWoTk11SsHNpWtCLPwL3QowQWDZj9
 z/8btDtmXbB/hxkVst7HD0RQFpt197LZr7Pa6g==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

 isOn Wed, Sep 22, 2021 at 10:55 PM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
> On Wed, Sep 22, 2021 at 9:57 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Wed, Sep 22, 2021 at 8:40 PM Sergio Paracuellos
> > <sergio.paracuellos@gmail.com> wrote:
> > > On Wed, Sep 22, 2021 at 8:07 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Wed, Sep 22, 2021 at 7:42 PM Sergio Paracuellos
> > > > Ok, thank you for the detailed explanation.
> > > >
> > > > I suppose you can use the generic infrastructure in asm-generic/io.h
> > > > if you "#define PCI_IOBASE mips_io_port_base". In this case, you
> > > > should have an architecture specific implementation of
> > > > pci_remap_iospace() that assigns mips_io_port_base.
> > >
> > > No, that is what I tried originally defining PCI_IOBASE as
> > > _AC(0xa0000000, UL) [0] which is the same as KSEG1 [1] that ends in
> > > 'mips_io_port_base'.
> >
> > Defining it as KSEG1 would be problematic because that means that
> > the Linux-visible port numbers are offset from the bus-visible ones.
> >
> > You really want PCI_IOBASE to point to the address of port 0.
>
> Do you mean that doing
>
> #define PCI_IOBASE mips_io_port_base
>
> would have different result that doing what I did
>
> #define PCI_IOBASE _AC(0xa0000000, UL)
>
> ?
>
> I am not really understanding this yet (I think I need a bit of sleep
> time :)), but I will test this tomorrow and come back to you again
> with results.

Both would let devices access the registers, but they are different
regarding the bus translations you have to program into the
host bridge, and how to access the hardcoded port numbers.

> > > > pci_remap_iospace() was originally meant as an architecture
> > > > specific helper, but it moved into generic code after all architectures
> > > > had the same requirements. If MIPS has different requirements,
> > > > then it should not be shared.
> > >
> > > I see. So, if it can not be shared, would defining 'pci_remap_iospace'
> > > as 'weak' acceptable? Doing in this way I guess I can redefine the
> > > symbol for mips to have the same I currently have but without the
> > > ifdef in the core APIs...
> >
> > I would hope to kill off the __weak functions, and prefer using an #ifdef
> > around the generic implementation. One way to do it is to define
> > a macro with the same name, such as
> >
> > #define pci_remap_iospace pci_remap_iospace
>
> I guess this should be defined in arch/mips/include/asm/pci.h?

Yes, that would be a good place for that, possibly next to
the (static inline) definition.

> > and then use #ifdef around the C function to see if that's already defined.
>
> I see. That would work, I guess. But I don't really understand why
> this approach would be better than this patch changes itself. Looks
> more hacky to me. As Bjorn pointed out in a previous version of this
> patch [0], this case is the same as the one in
> 'acpi_pci_root_remap_iospace' and the same approach is used there...

The acpi_pci_root_remap_iospace() does this because on that code is
shared with x86 and ia64, where the port numbers are accessed using
separate instructions that do not translate into MMIO addresses at all.

On MIPS, the port access eventually does translate into MMIO, and
you need a way to communicate the mapping between the host
bridge and the architecture specific code.

This is particularly important since we want the host bridge driver
to be portable. If you set up the mapping differently between e.g.
mt7621 and mt7623, they are not able to use the same driver
code for setting pci_host_bridge->io_offset and for programming
the inbound translation registers.

> > I only see one host bridge here though, and it has a single
> > I/O port range, so maybe all three ports are inside of
> > a single PCI domain?
>
> See this cover letter [1] with a fantastic ascii art :) to a better
> understanding of this pci topology. Yes, there is one host bridge and
> from here three virtual bridges where at most three endpoints can be
> connected.

Ok, so you don't have the problem I was referring to. A lot of
SoCs actually have multiple host bridges, but only one root
port per host bridge, because they are based on licensed IP
blocks that don't support a normal topology like the one you have.

> > Having high numbers for the I/O ports is definitely a
> > problem as I mentioned. Anything that tries to access
> > PC-style legacy devices on the low port numbers
> > will now directly go on the bus accessing MMIO
> > registers that it shouldn't, either causing a CPU exception
> > or (worse) undefined behavior from random register
> > accesses.
>
> All I/O port addresses for ralink SoCs are in higher addresses than
> default IO_SPACE_LIMIT 0xFFFF, that's why we have to also change this
> limit together with this patch changes. Nothing to do with this, is an
> architectural thing of these SoCs.

I don't understand. What I see above is that the host bridge
has the region 1e160000-1e16ffff registered, so presumably
1e160000 is actually the start of the window into the host bridge.
If you set PCI_IOBASE to that location, the highest port number
would become 0x2027, which is under 0xffff.

       Arnd
