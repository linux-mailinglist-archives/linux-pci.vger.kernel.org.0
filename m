Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8B95036F9
	for <lists+linux-pci@lfdr.de>; Sat, 16 Apr 2022 16:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbiDPOFO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Apr 2022 10:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiDPOFK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Apr 2022 10:05:10 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FD1E29CB2;
        Sat, 16 Apr 2022 07:02:38 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id ED50F92009E; Sat, 16 Apr 2022 16:02:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id E061592009C;
        Sat, 16 Apr 2022 15:02:35 +0100 (BST)
Date:   Sat, 16 Apr 2022 15:02:35 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Avoid handing out address 0 to devices
In-Reply-To: <20220415183912.GA824311@bhelgaas>
Message-ID: <alpine.DEB.2.21.2204160049500.9383@angie.orcam.me.uk>
References: <20220415183912.GA824311@bhelgaas>
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

On Fri, 15 Apr 2022, Bjorn Helgaas wrote:

> > > I guess the question is whether we want to reserve port 0 and MMIO
> > > address 0 as being "invalid".  That makes the first space smaller than
> > > the others, but it's not *much* smaller and it's an unlikely
> > > configuration to begin with.
> > 
> >  Unfortunately just as IRQ 0 is considered special and barring the 8254 
> > special exception for PC-style legacy junk it means "no IRQ", similarly 
> > I/O port or MMIO address 0 is considered "no device" in several places.  
> > One I have identified as noted above is `uart_configure_port':
> > 
> > 	/*
> > 	 * If there isn't a port here, don't do anything further.
> > 	 */
> > 	if (!port->iobase && !port->mapbase && !port->membase)
> > 		return;
> > 
> > So even if we let address 0 through it will be rejected downstream here 
> > and there and the device won't work.
> 
> This is a driver question, which I think is secondary.  If necessary,
> we can fix drivers after figuring out what the PCI core should do.

 This goes back to ISA and user-supplied driver options given as kernel 
parameters, so I am fairly sure it's been a part of our user interface 
since forever.  Changing these assumptions would surely break something 
for someone out there, so I would be very wary making such changes.

> > > We do have the IORESOURCE_UNSET flag bit that could possibly be used
> > > in pci_iomap_range() instead of testing for "!start".  Or maybe
> > > there's a way to allocate address 0 instead of special-casing the
> > > allocator?  Just thinking out loud here.
> 
> Another possibility is PCIBIOS_MIN_IO.  It's also kind of an ugly
> special case, but at least it already exists.  Most arches define it
> to be non-zero, which should avoid this issue.
> 
> Defining PCIBIOS_MIN_IO would be simple; what would we lose compared
> to adding code in pci_bus_alloc_from_region()?

 As I explained in the change description:

> Especially I/O space ranges are particularly valuable, because bridges
> only decode bits from 12 up and consequently where 16-bit addressing is
> in effect, as few as 16 separate ranges can be assigned to individual
> buses only.
> 
> Therefore avoid handing out address 0, however rather than bumping the
> lowest address available to PCI via PCIBIOS_MIN_IO and PCIBIOS_MIN_MEM,
> or doing an equivalent arrangement in `__pci_assign_resource', let the
> whole range assigned to a bus start from that address and instead only
> avoid it for actual devices.  [...]

Yes, just bumping up PCIBIOS_MIN_IO was my first thought and the path of 
least resistance.  However with the strictly hierarchical topology of PCIe 
systems the limit of 16 ranges feels so frighteningly low to me already as 
to make me rather unwilling to reduce it even further for a system that is 
free from PC legacy junk (no southbridge let alone ISA) and therefore does 
not require it.  So I've reconsidered my initial approach and came up with 
this proposal instead.  I think it is a good compromise.

  Maciej
