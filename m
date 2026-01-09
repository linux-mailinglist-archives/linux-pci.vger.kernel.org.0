Return-Path: <linux-pci+bounces-44370-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51229D0AE6B
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 16:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 335503033B8A
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 15:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002DC363C62;
	Fri,  9 Jan 2026 15:25:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81883624DB;
	Fri,  9 Jan 2026 15:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972343; cv=none; b=lae9FXm87PU/0LNOaCVw18d2dznntSoosr+QRwjp8EVEDGQhLbh/3vlcR0LQH6N+wWF8b+YBf4xQYgh9sTc4w9QlFLmAK0PXnPS1gDi3wY1y/VoXIbH9+TluGRKEpJXfR/3Uu5pRMRvaZfZQVUicRKCIIMpStFG5igHdBa7J6Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972343; c=relaxed/simple;
	bh=DQhi6la5qtIbbZNjZF6+GY6+LVAAEOKrep257/IWtI8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Sr9Ff4aeHd1V1xGq1PXyeQPbvgtYSKIaTyAjkagjXv37pMTfcHKnE9sl+38GLQilCZsY7Zh75aI6W700WwOy+7cPTE5wYrl+AhoXVE1I8jVSJ2BoBWE85LN2HNRWvqsuZ8LLJUt+2UYoDD2kvaU3c4lHqzNu7+rabUoKq1Rl8Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id A780892009E; Fri,  9 Jan 2026 16:25:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id A063892009D;
	Fri,  9 Jan 2026 15:25:35 +0000 (GMT)
Date: Fri, 9 Jan 2026 15:25:35 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: David Laight <david.laight.linux@gmail.com>
cc: Ziming Du <duziming2@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>, 
    linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
    liuyongqiang13@huawei.com
Subject: Re: [PATCH v3 3/3] PCI/sysfs: Prohibit unaligned access to I/O port
 on non-x86
In-Reply-To: <20260109125337.62466956@pumpkin>
Message-ID: <alpine.DEB.2.21.2601091457150.30566@angie.orcam.me.uk>
References: <20260108015944.3520719-1-duziming2@huawei.com> <20260108015944.3520719-4-duziming2@huawei.com> <20260108085611.0f07816d@pumpkin> <alpine.DEB.2.21.2601082358370.30566@angie.orcam.me.uk> <20260109125337.62466956@pumpkin>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 9 Jan 2026, David Laight wrote:

> > > IIRC io space is just like memory space, so a 16bit io access looks the
> > > same as two 8bit accesses to an 8bit device (some put the 'data fifo' on
> > > addresses 0 and 1 so the code could use 16bit io accesses to speed things up).  
> > 
> >  Huh?  A 16-bit port I/O access will have the byte enables set accordingly 
> > on PCI and the target device's data lines are driven accordingly in the 
> > data cycle.  Just as with MMIO; it's just a different bus command (or TLP 
> > type for PCIe).
> 
> I was going back to the historic implementations - like 8086 and 8088.

 Historical systems had various odd bus designs that are out of scope for 
our consideration.  Even the 80386, but that was never interfaced to PCI, 
perhaps for this very reason.

> >  Misaligned accesses may or may not have to be split depending on whether 
> > they span the data bus width boundary or not.  E.g. a 16-bit access to 
> > port I/O location 1 won't be split on 32-bit PCI as it fits on the bus: 
> > byte enables #1 and #2 will be driven active and byte enables #0 and #3 
> > will be left inactive.  Conversely such an access to location 3 needs to 
> > be split into two cycles, with byte enables #3 and #0 only driven active 
> > respectively in the first and the second cycle.
> 
> And on PCIe (which is 64bit) a misaligned transfer that crosses a 64bit
> boundary generates a single 16 byte TLP (not sure about page boundaries).

 Which is also what is covered (without diving into exact details) by my 
observation that a transfer may have to be split downstream, e.g. by a 
PCIe-to-PCI bridge, or internally by the target device.

> >  The x86 BIU will do the split automatically for port I/O instructions as 
> > will some other CPU architectures that use memory access instructions to 
> > reach the PCI port I/O decoding window in their memory address space (this 
> > is a simplified view, as the split may have to be done in the chipset when 
> > passing the boundary between data buses of a different width each).
> 
> Yes, and I don't understand the HAS_IOPORT option.
> Pretty much only x86 has separate instructions, but a lot of others will
> have PCI/PCIe interface logic that can convert cpu memory accesses into
> 'io' accesses - so the pci_map_bar() should be able to transparently map
> an io bar into kernel address space.
> So x86 should be the outlier because it can't do that!
> 
> Even the strongarm system I used years ago has an address window that
> generated 'io' cycles on a pcmcia bus.
> 
> I think a host PCI/PCIe interface could do io accesses for the bottom
> 64k of its memory window - but I don't know any that work that way.

 Only x86 (and its predecessors such as 8080, Z80, etc.) has the port I/O
space defined at the CPU bus level.  All the other architectures do define 
the port I/O space, but only in the chipset at the PCI/e bus/interconnect 
level where implemented.  It is where the HAS_IOPORT option is concerned.

 Several contemporary systems have no way to produce port I/O cycles on 
PCIe owing to the lack of support for the required TLP types in the host 
bridge.  There's simply no way to produce a transaction that would match 
an I/O BAR in a target device.  I own such a system myself, it's a POWER9 
machine[1][2].  I'm told numerous ARM systems also have such a limitation.  
FWIW port I/O TLP types have been deprecated from the beginning of PCIe.

References:

[1] "Power Systems Host Bridge 4 (PHB4) Specification", Version 1.0,
    International Business Machines Corporation, 27 July 2018, Table 3-2. 
    "PCIe TLP command summary", p. 29.

[2] "pcmcia: add HAS_IOPORT dependencies", 
    <https://lore.kernel.org/r/alpine.DEB.2.21.2205041311280.9548@angie.orcam.me.uk/>.

  Maciej

