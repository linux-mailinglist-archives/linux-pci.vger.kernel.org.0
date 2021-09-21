Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3708C413ADC
	for <lists+linux-pci@lfdr.de>; Tue, 21 Sep 2021 21:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbhIUTkA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Sep 2021 15:40:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:49558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233197AbhIUTj7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Sep 2021 15:39:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7068960F9E;
        Tue, 21 Sep 2021 19:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632253110;
        bh=Pv7ShSr/idpVyjsfAovBxi7kcQnkZuciFINPA0Ibvbg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AdYVyudjbmk+sBCLEwnjWtxdfo0cCB5cf/nA5XOlmuMcDyvi+Si7YDnahjIYLvYEP
         FLFFGFKUHfrQVZr4C+Woauy2607Yih/OFgEOlVxKN346BL0JJlLJco/O6q36KQW+9m
         Alk9DzrbeucAgWiHr+a7n2ec035+LWQqmpsZP/bgzYapV2wYDN9SaUfXDC0QKKwimQ
         XsILcfOouNKzrDbSWriuLxKoLWV5xTHrXnd+eNSea+H3ShiFCqBsytLvZUGSlt+DVY
         ZhdgZOietFROJUZ83V1gT5OU7/Y+2fAF4C0ek+0aQhhev9OsPtQZERAtzlaBHrLUY0
         pJ54+StfqlQ7w==
Date:   Tue, 21 Sep 2021 14:38:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-staging@lists.linux.dev, NeilBrown <neil@brown.name>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Rob Herring <robh@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 2/3] PCI: fix 'pci_remap_iospace' for architectures
 with PCI_IOBASE not defined
Message-ID: <20210921193829.GA114725@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMhs-H90yvbnPN26C7P_431cYqD4=8yrCUrxUY3L5k1GdsCeiQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If you repost this, please update the subject line like:

  PCI: of: Avoid pci_remap_iospace() when PCI_IOBASE not defined

On Tue, Sep 21, 2021 at 08:36:07PM +0200, Sergio Paracuellos wrote:
> On Tue, Sep 21, 2021 at 7:49 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > [+cc Liviu, Rob, Catalin, Arnd, since this warning was added by
> > 8b921acfeffd ("PCI: Add pci_remap_iospace() to map bus I/O resources"),
> > https://git.kernel.org/linus/8b921acfeffd]
> >
> > On Sun, Aug 22, 2021 at 06:10:04PM +0200, Sergio Paracuellos wrote:
> > > Request for I/O resources from device tree call 'pci_remap_iospace' from
> > > 'devm_pci_remap_iospace' which is also called from device tree function
> > > 'pci_parse_request_of_pci_ranges'. if PCI_IOBASE is not defined and I/O
> > > resources are requested the following warning appears:

s/'pci_remap_iospace'/pci_remap_iospace()/
s/'devm_pci_remap_iospace'/devm_pci_remap_iospace()/
s/'pci_parse_request_of_pci_ranges'/pci_parse_request_of_pci_ranges()/
s/if PCI_IOBASE/If PCI_IOBASE/

I think you can trim the stacktrace below and keep just this:

  WARNING: CPU: 2 PID: 1 at ../drivers/pci/pci.c:4066 pci_remap_iospace+0x3c/0x54
  This architecture does not support memory mapped I/O
  mt7621-pci 1e140000.pcie: error -19: failed to map resource [io  0x1e160000-0x1e16ffff]

> > >
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 2 PID: 1 at ../drivers/pci/pci.c:4066 pci_remap_iospace+0x3c/0x54
> > > This architecture does not support memory mapped I/O
> > > Modules linked in:
> > > CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.10.1+ #1228
> > > Stack : 00000000 00000000 807fa974 00000000 827ffa80 80066b48 80710000 0000000b
> > >         00000000 00000000 81c59aac 7d06ddec 80850000 00000001 81c59a40 7d06ddec
> > >         00000000 00000000 807c909c 81c598f0 00000001 81c59904 00000000 0000000a
> > >         203a6d6d 80708880 0000000f 70617773 80850000 00000000 00000000 807d0000
> > >         807ffecc 1e160000 00000001 00000200 00000000 8054e920 00000008 815e0008
> > >         ...
> > > Call Trace:
> > > [<80008efc>] show_stack+0x8c/0x130
> > > [<806e1674>] dump_stack+0x9c/0xc8
> > > [<80024a3c>] __warn+0xc0/0xe8
> > > [<80024ad0>] warn_slowpath_fmt+0x6c/0xbc
> > > [<80410ca8>] pci_remap_iospace+0x3c/0x54
> > > [<80410d20>] devm_pci_remap_iospace+0x58/0xa4
> > > [<8042019c>] devm_of_pci_bridge_init+0x4dc/0x55c
> > > [<80408de8>] devm_pci_alloc_host_bridge+0x78/0x88
> > > [<80424e44>] mt7621_pci_probe+0x68/0x9a4
> > > [<80464804>] platform_drv_probe+0x40/0x7c
> > > [<804628bc>] really_probe+0x2fc/0x4e4
> > > [<80463214>] device_driver_attach+0x4c/0x74
> > > [<80463384>] __driver_attach+0x148/0x150
> > > [<8046047c>] bus_for_each_dev+0x6c/0xb0
> > > [<804614dc>] bus_add_driver+0x1b4/0x1fc
> > > [<80463aa0>] driver_register+0xd0/0x110
> > > [<80001714>] do_one_initcall+0x84/0x1c0
> > > [<808e7fd0>] kernel_init_freeable+0x214/0x24c
> > > [<806e4164>] kernel_init+0x14/0x118
> > > [<80003358>] ret_from_kernel_thread+0x14/0x1c
> > >
> > > ---[ end trace 1c9d4412bd51b53c ]---
> > > mt7621-pci 1e140000.pcie: error -19: failed to map resource [io  0x1e160000-0x1e16ffff]
> > >
> > > Since there are architectures (like MIPS ralink) that can request I/O
> > > resources from device tree but have not mapeable I/O space and also PCI_IOBASE
> > > not defined, avoid this warning and just return zero to make the I/O ranges
> > > assignment work.

s/have not mapeable I/O space and also PCI_IOBASE not defined/
  don't have mappable I/O space and therefore don't define PCI_IOBASE/
s/avoid this warning .../
  avoid calling devm_pci_remap_iospace() in that case/

> > > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > > ---
> > >  drivers/pci/pci.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index aacf575c15cf..10bb2191f376 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -4102,9 +4102,9 @@ unsigned long __weak pci_address_to_pio(phys_addr_t address)
> > >   * @phys_addr: physical address of range to be mapped
> > >   *
> > >   * Remap the memory mapped I/O space described by the @res and the CPU
> > > - * physical address @phys_addr into virtual address space.  Only
> > > - * architectures that have memory mapped IO functions defined (and the
> > > - * PCI_IOBASE value defined) should call this function.
> > > + * physical address @phys_addr into virtual address space. There
> > > + * are architectures that don't define PCI_IOBASE but can have not
> > > + * mapeable IO space. Return zero for those cases.
> > >   */
> > >  int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
> > >  {
> > > @@ -4122,10 +4122,10 @@ int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
> > >  #else
> > >       /*
> > >        * This architecture does not have memory mapped I/O space,
> > > -      * so this function should never be called
> > > +      * but can have not mapeable I/O space, so just return ok
> > > +      * here.
> > >        */
> > > -     WARN_ONCE(1, "This architecture does not support memory mapped I/O\n");
> > > -     return -ENODEV;
> > > +     return 0;
> >
> > This doesn't seem right to me.  pci_remap_iospace() remaps
> > memory-mapped I/O space into virtual address space.
> >
> > If the architecture doesn't support that remapping, we shouldn't claim
> > that it succeeded.
> >
> > The analogous path for ACPI is in acpi_pci_root_remap_iospace(), where
> > we only call pci_remap_iospace() if PCI_IOBASE is defined.  Maybe we
> > should use the same approach here, i.e., add the corresonding #ifdef
> > in pci_parse_request_of_pci_ranges()?
> 
> This approach you are talking here is what I did in v1 of this series
> [0] and you tell me to properly fix that in the 'pci_remap_iospace'.

Hmm, sorry, you're absolutely right.

I guess I was thinking that pci_remap_iospace() was broken because it
returns -ENODEV when the arch can't remap I/O port space into virtual
memory space.  But that doesn't seem right.  If the arch literally
cannot do that remapping, why should pci_remap_iospace() return
success and basically pretend that it can?

And the acpi_pci_root_remap_iospace() case is doing exactly the same
thing, and we live with the #ifdef there.  So I think I was just wrong
before, and we should make the DT case similar by adding the #ifdef
where you initially put it, in pci_parse_request_of_pci_ranges().

> Both of these v1 and v2 obviously end up in a working pci system for
> mt7621 ralink.
> Another option I guess would be to mark 'pci_remap_iospace' as weak
> and redefine the symbol for ralink but since it is only for one simple
> return zero maybe it makes no sense at all... Please, tell me the
> correct approach to properly fix this and make things work for this
> platform.

Making pci_remap_iospace() weak could work (and I think it was
originally that way), but seems overkill to me, unless you want a way
to make generic mips kernels that work both on ralink and other mips
platforms.

> Thanks in advance for your time,
>      Sergio Paracuellos
> 
> [0]: https://lore.kernel.org/linux-pci/20210807072409.9018-2-sergio.paracuellos@gmail.com/T/#m73c19c3b72fdf8c63e6d3fe8dc80aeee4e4adcaa
> 
> >
> > >  #endif
> > >  }
> > >  EXPORT_SYMBOL(pci_remap_iospace);
> > > --
> > > 2.25.1
> > >
