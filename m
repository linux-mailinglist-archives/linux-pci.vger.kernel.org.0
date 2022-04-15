Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF855029B4
	for <lists+linux-pci@lfdr.de>; Fri, 15 Apr 2022 14:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346065AbiDOM3s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Apr 2022 08:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbiDOM3q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Apr 2022 08:29:46 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB70BC1C9D;
        Fri, 15 Apr 2022 05:27:18 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 14F649200B3; Fri, 15 Apr 2022 14:27:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 10D1692009E;
        Fri, 15 Apr 2022 13:27:18 +0100 (BST)
Date:   Fri, 15 Apr 2022 13:27:17 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     a@bhelgaas, Palmer Dabbelt <palmer@dabbelt.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Avoid handing out address 0 to devices
In-Reply-To: <20220414232328.GA770621@bhelgaas>
Message-ID: <alpine.DEB.2.21.2204150118240.9383@angie.orcam.me.uk>
References: <20220414232328.GA770621@bhelgaas>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 14 Apr 2022, Bjorn Helgaas wrote:

> > > > > > Address 0 is treated specially however in many places, for
> > > > > > example in `pci_iomap_range' and `pci_iomap_wc_range' we
> > > > > > require that the start address is non-zero, and even if we
> > > > > > let such an address through, then individual device drivers
> > > > > > could reject a request to handle a device at such an
> > > > > > address, such as in `uart_configure_port'.  Consequently
> > > > > > given devices configured as shown above only one is actually
> > > > > > usable:
> > > > > 
> > > > > pci_iomap_range() tests the resource start, i.e., the CPU
> > > > > address.  I guess the implication is that on RISC-V, the
> > > > > CPU-side port address is the same as the PCI bus port address?
> > > > 
> > > >  Umm, for all systems I came across except x86, which have
> > > >  native port I/O access machine instructions, a port I/O
> > > >  resource records PCI bus addresses of the device rather than
> > > >  its CPU addresses, which encode the location of an MMIO window
> > > >  the PCI port I/O space is accessed through.
> > > 
> > > My point is only that it is not necessary for the PCI bus address
> > > and the struct resource address, i.e., the argument to inb(), to
> > > be the same.
> > 
> >  Sure, but I have yet to see a system where it is the case.
> > 
> >  Also in principle peer PCI buses could have their own port I/O
> >  address spaces each mapped via distinct MMIO windows in the CPU
> >  address space, but I haven't heard of such a system.  That of
> >  course doesn't mean there's no such system in existence.
> 
> They do exist, but are probably rare.  Even on x86 where multiple host
> bridges are now fairly common, and the hardware probably supports a
> separate 64K port space for each, the ones I've seen split up a single
> 64K I/O port space so each bridge only gets a fraction of it.  I'm not
> sure Linux would even support multiple spaces.  I do know ia64
> supports multiple port spaces (see __ia64_mk_io_addr()), so we could
> have something like this:
> 
>   pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
>   pci_bus 0001:00: root bus resource [io  0x10000-0x1ffff] (bus address [0x0000-0xffff])

 Yeah, I guess if anything, it *had* to be IA64!

 Conversely Alpha systems decode the full 32-bit address range for port 
I/O and happily assign I/O bars beyond 64K in their firmware, however as 
a uniform address space even across several peer PCI buses.

 As to x86 systems as I mentioned they have native port I/O access machine
instructions and they only support 16-bit addressing, so I wouldn't expect 
more than one 64K of port I/O space implemented with them.  There is no 
problem at the CPU bus level of course with presenting port I/O addresses 
beyond 64K and as a matter of interest the original 80386 CPU did make use 
of them internally for communicating with the 80387 FPU, just because they 
cannot be produced with machine code and therefore a programmer could not 
interfere with the CPU-to-FPU communication protocol.  Port I/O locations
0x800000f8 through 0x800000ff were actually used in that protocol[1][2].

> I guess the question is whether we want to reserve port 0 and MMIO
> address 0 as being "invalid".  That makes the first space smaller than
> the others, but it's not *much* smaller and it's an unlikely
> configuration to begin with.

 Unfortunately just as IRQ 0 is considered special and barring the 8254 
special exception for PC-style legacy junk it means "no IRQ", similarly 
I/O port or MMIO address 0 is considered "no device" in several places.  
One I have identified as noted above is `uart_configure_port':

	/*
	 * If there isn't a port here, don't do anything further.
	 */
	if (!port->iobase && !port->mapbase && !port->membase)
		return;

So even if we let address 0 through it will be rejected downstream here 
and there and the device won't work.

> But at the same time, it adds another slightly weird special case in
> the already full-of-special-cases alloc code, and I'm somewhat averse
> to things like that.

 I can sympathise with that.

> We do have the IORESOURCE_UNSET flag bit that could possibly be used
> in pci_iomap_range() instead of testing for "!start".  Or maybe
> there's a way to allocate address 0 instead of special-casing the
> allocator?  Just thinking out loud here.

 I have discovered it with an 8250-compatible UART option card and when I 
patched up `pci_iomap_range' to let address 0 through, I have learnt the 
hard way it is not going to work, as described above.  And I think the 
special semantics of bus address 0 has been there with us since forever, 
so I dare not change it as people surely have relied on it.

 I could see if the parport_pc driver for the parallel port option card I
now have installed instead would be happy with one of its decode ranges 
set to 0, but I'm not sure if there's any value in such a check given my 
observation.

 We're still doing better with my proposal than systems that have a legacy 
southbridge do, as we're only losing one increment of the BAR decode range 
rather than 4K of the I/O port address space that those systems do.

References:

[1] "Intel386 DX Microprocessor High Performance 32-bit CHMOS
    Microprocessor with Integrated Memory Management", Intel Corporation, 
    Order Number: 231630-010, December 1992, Section 5.2.4 "Address Bus 
    (BE0# through BE3#, A2 through A31)", p.63

[2] same, Table 5-11 "Numeric Coprocessor Port Addresses", p.94

  Maciej
