Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348A8513BE5
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 20:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236810AbiD1S7Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 14:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234496AbiD1S7P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 14:59:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE9AB1AA9;
        Thu, 28 Apr 2022 11:55:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5920561903;
        Thu, 28 Apr 2022 18:55:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639D4C385A9;
        Thu, 28 Apr 2022 18:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651172158;
        bh=QbMp+TVcUkgGvq0RzONOxoY8dbfDmVzl1OJIP43ws7M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HpeeN7zKaZ0TLJoF6hwVPx/0W0Mq4blWXgdROsyvZui/gM3LRKwgPNFhaB2vhBFx8
         0OhmdsQgBYaBC9g+o4XR69PyLi9UETTgL7pSWrFDn6X/bpcBXFKCMMxd3aVmA3ZLJa
         Iy0Gkpe02uROBT0FkyRemJn334rVgOjjQNuPwg5GaUt4rSZvoo7aw6n9dOhSbegmxL
         6qtAKRbvAZqusgSk6qpuT9Ir9Ar4E2wZQaAhVISHw+t+O7DzXM8AUGL3KDYMcvu+UE
         yuTurea2T/flvU0+ZUC6bFmVZNB3FWl6Bde/Xj+rW1YFuFdFbnwHIEkmM7o2yk1Kw5
         RxA7kfdNEOlEA==
Date:   Thu, 28 Apr 2022 13:55:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Avoid handing out address 0 to devices
Message-ID: <20220428185556.GA35255@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2204192214310.9383@angie.orcam.me.uk>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 27, 2022 at 11:18:12PM +0100, Maciej W. Rozycki wrote:
> On Mon, 18 Apr 2022, Bjorn Helgaas wrote:
> ...

> > Sparc uses the MMIO I/O port address directly in the struct resource,
> > so it will never try to allocate [io 0x0000], and there's no problem
> > with using PCI I/O port 0:
> > 
> >   pci_bus 0000:00: root bus resource [io  0x804000000000-0x80400fffffff] (bus address [0x0000-0xfffffff])
> >   mpt2sas0: ioport(0x0000804000001000), size(256)
> > 
> > The sparc ioport interfaces are basically:
> > 
> >   ioport_map(port)  { return port; }
> >   ioread8(addr)     { return readb(addr); }
> >   inb(addr)         { return readb(addr); }
> > 
> > RISC-V uses the generic ones, i.e.,
> > 
> >   ioport_map(port)  { return PIO_OFFSET + port; }
> >   ioread8(addr)     { if (addr) >= PIO_RESERVED)
> >                         return readb(addr);
> >                       else
> >                         return inb(addr & PIO_MASK); }
> >   inb(addr)         { return __raw_readb(PCI_IOBASE + addr); }
> > 
> > Obviously RISC-V gives you prettier I/O port addresses, but at the
> > cost of having PCI I/O port 0 be 0 in the struct resource as well,
> > which makes it basically unusable.  Is it worth it?
> 
>  Well, the SPARC port may be able to get away with that, but overall I 
> think using PCI bus addresses for port I/O resources is the only sane 
> thing to do.

That only works if you have a single host bridge where you care about
I/O ports, or if you're willing to split up the single space across
the multiple host bridges, e.g., [io 0x0000-0x7fff] to one host
bridge, [0x8000-0xffff] to another.

> In fact I think for MMIO resources we probably ought to do 
> the same, though it may be actually more difficult to implement, because 
> it's more likely there are systems out there with multiple per-bus MMIO 
> address spaces.

I might be missing your point here, but multiple host bridges are
common on ia64, sparc, and (I think) powerpc.  It probably would be
feasible to make the struct resource address identical to the PCI bus
address for 64-bit MMIO space because they're both constrained to the
same-sized space.

But doing it for the PCI 32-bit non-prefetchable space would be an
issue because there's usually RAM in that area of CPU address space,
so we'd have to reserve a hole for PCI, put the MMIO in the hole, then
split the MMIO space across all the host bridges.  This sparc system
has 16 host bridges, so even if we had no hole, each one could only
have 256MB of identity-mapped non-prefetchable space:

  pci_bus 0000:00: root bus resource [mem 0x800000000000-0x80007effffff] (bus address [0x00000000-0x7effffff])
  pci_bus 0001:00: root bus resource [mem 0x801000000000-0x80107effffff] (bus address [0x00000000-0x7effffff])
  ...
  pci_bus 000f:00: root bus resource [mem 0x839000000000-0x83907effffff] (bus address [0x00000000-0x7effffff])

(This is from https://bugzilla.kernel.org/show_bug.cgi?id=96241)

>  The reason why I think using bus addresses here is the right thing to do 
> is that systems may have multiple decode windows exposed to the CPU(s) 
> mapping to the same I/O bus addresses, often for specific purposes. E.g. 
> Alpha has the sparse and the dense address space and some systems (I have 
> one with a MIPS CPU) have spaces with different endianness swap policies 
> (for matching either bit or byte lanes) wired in the bus logic hardware.  
> So the same port I/O location can be mapped at different MMIO addresses 
> simultaneously in one system.

Is this feature used by Linux?  I guess it would require some generic
mechanism drivers could use to get the desired endianness?  I don't
know whether such a thing exists.

Bjorn
