Return-Path: <linux-pci+bounces-1026-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3AB813E42
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 00:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 358251F229D1
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 23:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1609A6C6EB;
	Thu, 14 Dec 2023 23:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jt8dsH/4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E517D6C6DC;
	Thu, 14 Dec 2023 23:31:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C4FC433C7;
	Thu, 14 Dec 2023 23:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702596660;
	bh=aEvT2L/cgELzDegF/stGRU2T+dVr4CYp+Iu+TJaHLIo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jt8dsH/4wzry6w62MHBAix9gx3UadwMhgl+t0h0DcALqWABUpHt0PkXHgfOawyq3j
	 AMSuQ6YpaydeZb2LvIQDBDyR/QQmbtvhVd4vIVJTgfuNlmaaU2tmn9d8vQTK5Wv2oT
	 KreaSFH84jL9HsJgejH3wqW7LTrvp7mhIYoa6xeaCKH0srsLaTbFDhQgmz9afNrn/u
	 eetHLmC9adXFnAgO57ZW9HmViGLYo7CyGWLgwpfuzOeCRpbO9CGicULHwnEeG+afNW
	 VWVT0CMw0PHfQoD0dz7q79/QUDlMtxhJqCdONyszDNz8Z+eOvkAHI0/Yui6RQwk6ON
	 v5lCtABbwQr1w==
Date: Thu, 14 Dec 2023 17:30:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>
Subject: Re: [PATCH] x86/pci: Stop requiring MMCONFIG to be declared in E820,
 ACPI or EFI for newer systems
Message-ID: <20231214233059.GA1106860@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d91910d-2676-477a-be62-5365afd199bb@amd.com>

On Thu, Dec 14, 2023 at 03:45:43PM -0600, Mario Limonciello wrote:
> On 12/14/2023 14:43, Bjorn Helgaas wrote:
> > On Tue, Dec 05, 2023 at 12:28:44PM -0600, Mario Limonciello wrote:
> > > On 12/5/2023 11:31, Bjorn Helgaas wrote:
> > > > On Tue, Dec 05, 2023 at 11:00:31AM -0600, Mario Limonciello wrote:
> > > > > On 12/5/2023 10:17, Bjorn Helgaas wrote:
> > > > > > On Tue, Dec 05, 2023 at 09:48:45AM -0600, Mario Limonciello wrote:
> > > > > > > commit 7752d5cfe3d1 ("x86: validate against acpi motherboard
> > > > > > > resources") introduced checks for ensuring that MCFG table
> > > > > > > also has memory region reservations to ensure no conflicts
> > > > > > > were introduced from a buggy BIOS.
> > > > > > > 
> > > > > > > This has proceeded over time to add other types of
> > > > > > > reservation checks for ACPI PNP resources and EFI MMIO
> > > > > > > memory type.  The PCI firmware spec however says that these
> > > > > > > checks are only required when the operating system doesn't
> > > > > > > comprehend the firmware region:
> > > > > > > 
> > > > > > > ``` If the operating system does not natively comprehend
> > > > > > > reserving the MMCFG region, the MMCFG region must be
> > > > > > > reserved by firmware. The address range reported in the MCFG
> > > > > > > table or by _CBA method (see Section 4.1.3) must be reserved
> > > > > > > by declaring a motherboard resource. For most systems, the
> > > > > > > motherboard resource would appear at the root of the ACPI
> > > > > > > namespace (under \_SB) in a node with a _HID of EISAID
> > > > > > > (PNP0C02), and the resources in this case should not be
> > > > > > > claimed in the root PCI bus’s _CRS. The resources can
> > > > > > > optionally be returned in Int15 E820h or EFIGetMemoryMap as
> > > > > > > reserved memory but must always be reported through ACPI as
> > > > > > > a motherboard resource.  ```
> > > > > > 
> > > > > > My understanding is that native comprehension would mean Linux
> > > > > > knows how to discover and/or configure the MMCFG base address
> > > > > > and size in the hardware and that Linux would then reserve
> > > > > > that region so it's not used for anything else.
> > > > > > 
> > > > > > Linux doesn't have that, at least for x86.  It relies on the
> > > > > > MCFG table to discover the MMCFG region, and it relies on
> > > > > > PNP0C02 _CRS to reserve it.
> > > > > 
> > > > > MCFG to discover it matches the PCI firmware spec, but as I
> > > > > point out above the decision to reserve this region doesn't
> > > > > require PNP0C01/PNP0C02 _CRS.
> > > > 
> > > > Can you explain this reasoning a little more?  I claim Linux does
> > > > not natively comprehend reserving the MMCFG region, but it sounds
> > > > like you don't agree?  I think "native" comprehension would mean
> > > > Linux would not need the MCFG table.
> > > 
> > > After our thread and the spec again I think you're right Linux
> > > doesn't natively comprehend (reserve this region;) particularly
> > > because of the stance you have on "static table" vs _CRS.
> > 
> > ["My stance" refers to this:
> > 
> >    Static tables like MCFG, HPET, ECDT, etc., are *not* mechanisms for
> >    reserving address space.  The static tables are for things the OS
> >    needs to know early in boot, before it can parse the ACPI namespace.
> >    If a new table is defined, an old OS needs to operate correctly even
> >    though it ignores the table.  _CRS allows that because it is generic
> >    and understood by the old OS; a static table does not.
> > 
> > from https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/PCI/acpi-info.rst?id=v6.6#n32]
> > 
> > I don't think this is just my stance.  The ACPI spec could be clearer
> > in terms of requiring PNP0C02 devices, not static tables, to reserve
> > address space, but I think that requirement is a logical consequence
> > of the ACPI design.
> > 
> > It's a goal of ACPI that an OS we release today should run on a
> > platform released tomorrow.  If the new platform uses a static table
> > to reserve address space used by some new hardware, today's OS doesn't
> > know about it and could place another device on top of it.
> > 
> > Using _CRS of an ACPI device to reserve the new hardware address space
> > is different because it works even with today's OS.  Today's OS can't
> > *operate* tomorrow's hardware, but at least it won't create address
> > conflicts with it.
> > 
> > > I just don't want to throw the vendor under the bus as it could have
> > > been caught "sooner" and fixed by BIOS adding _CRS.
> > 
> > The MCFG requirement for PNP0C02 _CRS has been in the PCI Firmware
> > spec since r3.0 in 2005.  I'm surprised that vendors still get this
> > wrong.
> 
> Probably worth mentioning with the clairvoyance of the root cause of
> the issue that prompted this conversation I've now discovered
> another system with the exact same problem.  It's a different OEM,
> different generation of hardware and a different IBV that they use
> for their firmware.
> 
> I've also looked through the BIOS for a variety of reference designs
> and I don't see a _CRS entry in any of them.
> 
> I'm fairly certain we're just getting lucky in Linux on a lot of
> devices that the region is often overlapping with a region for EFI
> runtime services.

Ugh.  Yes, I'm sure it's not an isolated problem.

> > Vendors definitely have an interest in making shipping OSes boot
> > unchanged on new hardware.
> 
> At least the OEMs that I talk to use FWTS.  FWTS catches this issue,
> but it's marked as LOW.  Everyone fixates on the HIGH or CRITICAL.
> 
> Given the severity of what I've seen it can do to a system I'm
> proposing FWTS to move it to HIGH:
> 
> https://lists.ubuntu.com/archives/fwts-devel/2023-December/013772.html

Thanks.  I don't know anything about FWTS, but I'm a little skeptical
that it actually catches this issue.  It *looks* like FWTS builds its
idea of the memory map from a dmesg log or /sys/firmware/memmap, which
I think both come from the E820 map, which is x86-specific, of course.

I don't see anything that builds a memory map based on _CRS methods,
which I think is what we really want since the spec says:

  The resources can optionally be returned in Int15 E820h or
  EFIGetMemoryMap as reserved memory but must always be reported
  through ACPI as a motherboard resource.

(PCI Firmware spec r3.3, sec 4.1.2)

> What is the actual *harm* in just using this MCFG table to make a
> reservation when there isn't a PNP0C02 _CRS region declared?
> 
> At worst (a buggy BIOS) you would end up with hole in the memory map
> that isn't usable for devices.  At best you end up with more working
> devices without changing the firmware.

We definitely need to work around this in Linux, and your patch might
well be the right thing.

I'm a *little* hesitant because all the code in mmconfig-shared.c that
attempts to validate MCFG entries suggests that relying on them
uncritically was a problem in some cases, so I want to try to convince
myself that we really won't break something.

Bjorn

