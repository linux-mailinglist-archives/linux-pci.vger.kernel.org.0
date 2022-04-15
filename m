Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D755502EC2
	for <lists+linux-pci@lfdr.de>; Fri, 15 Apr 2022 20:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345617AbiDOSlr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Apr 2022 14:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243945AbiDOSlq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Apr 2022 14:41:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CC13A5C9;
        Fri, 15 Apr 2022 11:39:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17E89B82E24;
        Fri, 15 Apr 2022 18:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DD3C385A4;
        Fri, 15 Apr 2022 18:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650047954;
        bh=7T0xS++I3tvwGRoViLxJskdG1aYYZ190NPkHiUOxuIs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=R19Mh2fNbJ+hxXWciTrvlzQQlrOeN+BffGYx5ogsVo4b4MOiTpJz9ZCX7w9BwtW6Y
         smXjx5h6Gg3q+/QwuugnSjHrAYt17nlasBaUCopLmJShQjsaXt+5A4k4r36TrQEq4k
         d6bwMZJtfRu5/X4wUTClaoT0f8DgcmptdeykwWC+r4iH7CsxCfxGl75O5NYibZ3M+D
         XgqiuWZWs22JFfTLTZ3bM3Tpd0uwonXbWvacxrklaXy+poHFYR8hWqqLclcdzVhcS/
         TBjLIH2uUY+je7PIL69F8Cj3o1srT5dyspPhymBNsv1sT3r/V7XWjTb2A6ZkmOf62A
         UZvmyoKB2Glog==
Date:   Fri, 15 Apr 2022 13:39:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Avoid handing out address 0 to devices
Message-ID: <20220415183912.GA824311@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2204150118240.9383@angie.orcam.me.uk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 15, 2022 at 01:27:17PM +0100, Maciej W. Rozycki wrote:
> On Thu, 14 Apr 2022, Bjorn Helgaas wrote:
> 
> > > > > > > Address 0 is treated specially however in many places, for
> > > > > > > example in `pci_iomap_range' and `pci_iomap_wc_range' we
> > > > > > > require that the start address is non-zero, and even if we
> > > > > > > let such an address through, then individual device drivers
> > > > > > > could reject a request to handle a device at such an
> > > > > > > address, such as in `uart_configure_port'.  Consequently
> > > > > > > given devices configured as shown above only one is actually
> > > > > > > usable:
> > > > > > 
> > > > > > pci_iomap_range() tests the resource start, i.e., the CPU
> > > > > > address.  I guess the implication is that on RISC-V, the
> > > > > > CPU-side port address is the same as the PCI bus port address?
> > > > > 
> > > > >  Umm, for all systems I came across except x86, which have
> > > > >  native port I/O access machine instructions, a port I/O
> > > > >  resource records PCI bus addresses of the device rather than
> > > > >  its CPU addresses, which encode the location of an MMIO window
> > > > >  the PCI port I/O space is accessed through.
> > > > 
> > > > My point is only that it is not necessary for the PCI bus address
> > > > and the struct resource address, i.e., the argument to inb(), to
> > > > be the same.
> > > 
> > >  Sure, but I have yet to see a system where it is the case.
> > > 
> > >  Also in principle peer PCI buses could have their own port I/O
> > >  address spaces each mapped via distinct MMIO windows in the CPU
> > >  address space, but I haven't heard of such a system.  That of
> > >  course doesn't mean there's no such system in existence.
> > 
> > They do exist, but are probably rare.  Even on x86 where multiple host
> > bridges are now fairly common, and the hardware probably supports a
> > separate 64K port space for each, the ones I've seen split up a single
> > 64K I/O port space so each bridge only gets a fraction of it.  I'm not
> > sure Linux would even support multiple spaces.  I do know ia64
> > supports multiple port spaces (see __ia64_mk_io_addr()), so we could
> > have something like this:
> > 
> >   pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> >   pci_bus 0001:00: root bus resource [io  0x10000-0x1ffff] (bus address [0x0000-0xffff])
> 
>  Yeah, I guess if anything, it *had* to be IA64!

:)

>  Conversely Alpha systems decode the full 32-bit address range for port 
> I/O and happily assign I/O bars beyond 64K in their firmware, however as 
> a uniform address space even across several peer PCI buses.
> 
>  As to x86 systems as I mentioned they have native port I/O access machine
> instructions and they only support 16-bit addressing, so I wouldn't expect 
> more than one 64K of port I/O space implemented with them.  There is no 
> problem at the CPU bus level of course with presenting port I/O addresses 
> beyond 64K and as a matter of interest the original 80386 CPU did make use 
> of them internally for communicating with the 80387 FPU, just because they 
> cannot be produced with machine code and therefore a programmer could not 
> interfere with the CPU-to-FPU communication protocol.  Port I/O locations
> 0x800000f8 through 0x800000ff were actually used in that protocol[1][2].

> > I guess the question is whether we want to reserve port 0 and MMIO
> > address 0 as being "invalid".  That makes the first space smaller than
> > the others, but it's not *much* smaller and it's an unlikely
> > configuration to begin with.
> 
>  Unfortunately just as IRQ 0 is considered special and barring the 8254 
> special exception for PC-style legacy junk it means "no IRQ", similarly 
> I/O port or MMIO address 0 is considered "no device" in several places.  
> One I have identified as noted above is `uart_configure_port':
> 
> 	/*
> 	 * If there isn't a port here, don't do anything further.
> 	 */
> 	if (!port->iobase && !port->mapbase && !port->membase)
> 		return;
> 
> So even if we let address 0 through it will be rejected downstream here 
> and there and the device won't work.

This is a driver question, which I think is secondary.  If necessary,
we can fix drivers after figuring out what the PCI core should do.

> > We do have the IORESOURCE_UNSET flag bit that could possibly be used
> > in pci_iomap_range() instead of testing for "!start".  Or maybe
> > there's a way to allocate address 0 instead of special-casing the
> > allocator?  Just thinking out loud here.

Another possibility is PCIBIOS_MIN_IO.  It's also kind of an ugly
special case, but at least it already exists.  Most arches define it
to be non-zero, which should avoid this issue.

Defining PCIBIOS_MIN_IO would be simple; what would we lose compared
to adding code in pci_bus_alloc_from_region()?

Bjorn
