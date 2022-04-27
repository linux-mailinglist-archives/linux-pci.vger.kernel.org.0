Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1CD51252D
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 00:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiD0WV0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Apr 2022 18:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbiD0WVZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Apr 2022 18:21:25 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AEEEC496A8;
        Wed, 27 Apr 2022 15:18:13 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id E8A0892009E; Thu, 28 Apr 2022 00:18:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id E401D92009D;
        Wed, 27 Apr 2022 23:18:12 +0100 (BST)
Date:   Wed, 27 Apr 2022 23:18:12 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Avoid handing out address 0 to devices
In-Reply-To: <20220419033752.GA1101844@bhelgaas>
Message-ID: <alpine.DEB.2.21.2204192214310.9383@angie.orcam.me.uk>
References: <20220419033752.GA1101844@bhelgaas>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 18 Apr 2022, Bjorn Helgaas wrote:

> > Yes, just bumping up PCIBIOS_MIN_IO was my first thought and the
> > path of least resistance.  However with the strictly hierarchical
> > topology of PCIe systems the limit of 16 ranges feels so
> > frighteningly low to me already as to make me rather unwilling to
> > reduce it even further for a system that is free from PC legacy junk
> > (no southbridge let alone ISA) and therefore does not require it.
> > So I've reconsidered my initial approach and came up with this
> > proposal instead.  I think it is a good compromise.
> 
> Sorry for being dense here, I think it's finally sinking in.

 No worries, I'm glad we're on the same page now.

> The problem is that making PCIBIOS_MIN_IO greater than zero would keep
> us from assigning a [io 0x0000- ] window, so instead of 16 I/O bridge
> windows, we could only have 15 (unless bridges support 32-bit I/O
> windows).  Right?

 Yes, that's been my concern.

> Are you running into that limit?  Most devices don't need I/O port
> space, and almost all other arches define PCIBIOS_MIN_IO, so they live
> without that window today.

 I haven't run into this limit, but then whoever runs into it is likely 
not going to be someone who's able to come up with a solution like this 
proposed here or possibly understanding it.  Granted, it's only one extra 
range, but still IMHO an unnecessary extra limitation beyond one built 
into hardware.

 Also there are devices out there that have alternative MMIO and port I/O 
BARs available for mapping their CSRs, and while our drivers tend to use 
MMIO in that case those devices still claim a port I/O address range.  If 
you are unlucky they will get an allocation and a device that actually 
needs port I/O to work won't.

 Such unexpected quirks can be very frustrating to IT folk.

> Sparc uses the MMIO I/O port address directly in the struct resource,
> so it will never try to allocate [io 0x0000], and there's no problem
> with using PCI I/O port 0:
> 
>   pci_bus 0000:00: root bus resource [io  0x804000000000-0x80400fffffff] (bus address [0x0000-0xfffffff])
>   mpt2sas0: ioport(0x0000804000001000), size(256)
> 
> The sparc ioport interfaces are basically:
> 
>   ioport_map(port)  { return port; }
>   ioread8(addr)     { return readb(addr); }
>   inb(addr)         { return readb(addr); }
> 
> RISC-V uses the generic ones, i.e.,
> 
>   ioport_map(port)  { return PIO_OFFSET + port; }
>   ioread8(addr)     { if (addr) >= PIO_RESERVED)
>                         return readb(addr);
>                       else
>                         return inb(addr & PIO_MASK); }
>   inb(addr)         { return __raw_readb(PCI_IOBASE + addr); }
> 
> Obviously RISC-V gives you prettier I/O port addresses, but at the
> cost of having PCI I/O port 0 be 0 in the struct resource as well,
> which makes it basically unusable.  Is it worth it?

 Well, the SPARC port may be able to get away with that, but overall I 
think using PCI bus addresses for port I/O resources is the only sane 
thing to do.  In fact I think for MMIO resources we probably ought to do 
the same, though it may be actually more difficult to implement, because 
it's more likely there are systems out there with multiple per-bus MMIO 
address spaces.

 The reason why I think using bus addresses here is the right thing to do 
is that systems may have multiple decode windows exposed to the CPU(s) 
mapping to the same I/O bus addresses, often for specific purposes.  E.g. 
Alpha has the sparse and the dense address space and some systems (I have 
one with a MIPS CPU) have spaces with different endianness swap policies 
(for matching either bit or byte lanes) wired in the bus logic hardware.  
So the same port I/O location can be mapped at different MMIO addresses 
simultaneously in one system.

 I did some further experimentation with a parallel port option card now, 
and it seems to operate just fine at address 0, likely because plain port 
I/O accessors (`inb', `outb', and friends) have no special intepretation 
for address 0, unlike the iomap handlers:

parport_pc 0000:07:00.0: enabling device (0000 -> 0001)
PCI parallel port detected: 1415:c118, I/O at 0x0(0x8), IRQ 38
parport0: PC-style at 0x0 (0x8), irq 38, using FIFO [PCSPP,TRISTATE,COMPAT,EPP,ECP]
lp0: using parport0 (interrupt-driven).

So it seems we're quite inconsistent already.

 Since we need a way to move forward and we have a real issue with PCI BAR 
allocations that cause devices to break I have now posted a fix for RISC-V 
systems only which solves the problem at hand, however wasting one whole 
4KiB I/O address range.  If we ever have a better generic solution, either 
one proposed here or an alternative one, then we can revert the RISC-V 
change.  Cf. 
<https://lore.kernel.org/r/alpine.DEB.2.21.2204271207590.9383@angie.orcam.me.uk>.

  Maciej
