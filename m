Return-Path: <linux-pci+bounces-1017-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAC6813BE9
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 21:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFF88281F13
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 20:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343E8282E5;
	Thu, 14 Dec 2023 20:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQMaD5t2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D59B2112;
	Thu, 14 Dec 2023 20:43:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C08C433C7;
	Thu, 14 Dec 2023 20:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702586625;
	bh=N0jbTbJWofRtfABZuOELLa0zwrB/SPbXjOelFyq+jlI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pQMaD5t2Lco04xJa7WMNhSEOnvghmKF9zfOXMukHIbOJ22CDXDYVJLF1QGVd2Cic2
	 TAWx8i4xsBlEVL6X9Pn3jaCrx6BenJX7O7/6A5GZFuQMXe3XjQP+MK7kcCpw+zTB30
	 pbXGDpasOEHxxWziULcUdOMXifFZD1wnvBEySSJIX84fVjP7AHCQHHwSjzkQiEjSZd
	 Sx3bzUux11CKWXetTilrBXSyG0P1aZ10k2mVDRgm6Im7kho6cMN/HerwDl1bBjT6rH
	 dJgOLq5EBGYgUSEOgdgq4HgWLmaqR4PobhZu3xYJ/7fu44P+M6mlmdCtGRIfuULx08
	 A5ZGqk/ZlOpug==
Date: Thu, 14 Dec 2023 14:43:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>
Subject: Re: [PATCH] x86/pci: Stop requiring MMCONFIG to be declared in E820,
 ACPI or EFI for newer systems
Message-ID: <20231214204341.GA835486@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e730edc-2251-4f98-afc9-c8278157c894@amd.com>

[+cc Len, Robert in case I'm missing something about static tables
reserving address space]

On Tue, Dec 05, 2023 at 12:28:44PM -0600, Mario Limonciello wrote:
> On 12/5/2023 11:31, Bjorn Helgaas wrote:
> > On Tue, Dec 05, 2023 at 11:00:31AM -0600, Mario Limonciello wrote:
> > > On 12/5/2023 10:17, Bjorn Helgaas wrote:
> > > > On Tue, Dec 05, 2023 at 09:48:45AM -0600, Mario Limonciello wrote:
> > > > > commit 7752d5cfe3d1 ("x86: validate against acpi motherboard
> > > > > resources") introduced checks for ensuring that MCFG table
> > > > > also has memory region reservations to ensure no conflicts
> > > > > were introduced from a buggy BIOS.
> > > > > 
> > > > > This has proceeded over time to add other types of
> > > > > reservation checks for ACPI PNP resources and EFI MMIO
> > > > > memory type.  The PCI firmware spec however says that these
> > > > > checks are only required when the operating system doesn't
> > > > > comprehend the firmware region:
> > > > > 
> > > > > ``` If the operating system does not natively comprehend
> > > > > reserving the MMCFG region, the MMCFG region must be
> > > > > reserved by firmware. The address range reported in the MCFG
> > > > > table or by _CBA method (see Section 4.1.3) must be reserved
> > > > > by declaring a motherboard resource. For most systems, the
> > > > > motherboard resource would appear at the root of the ACPI
> > > > > namespace (under \_SB) in a node with a _HID of EISAID
> > > > > (PNP0C02), and the resources in this case should not be
> > > > > claimed in the root PCI bus’s _CRS. The resources can
> > > > > optionally be returned in Int15 E820h or EFIGetMemoryMap as
> > > > > reserved memory but must always be reported through ACPI as
> > > > > a motherboard resource.  ```
> > > > 
> > > > My understanding is that native comprehension would mean Linux
> > > > knows how to discover and/or configure the MMCFG base address
> > > > and size in the hardware and that Linux would then reserve
> > > > that region so it's not used for anything else.
> > > > 
> > > > Linux doesn't have that, at least for x86.  It relies on the
> > > > MCFG table to discover the MMCFG region, and it relies on
> > > > PNP0C02 _CRS to reserve it.
> > > 
> > > MCFG to discover it matches the PCI firmware spec, but as I
> > > point out above the decision to reserve this region doesn't
> > > require PNP0C01/PNP0C02 _CRS.
> > 
> > Can you explain this reasoning a little more?  I claim Linux does
> > not natively comprehend reserving the MMCFG region, but it sounds
> > like you don't agree?  I think "native" comprehension would mean
> > Linux would not need the MCFG table.
> 
> After our thread and the spec again I think you're right Linux
> doesn't natively comprehend (reserve this region;) particularly
> because of the stance you have on "static table" vs _CRS.

["My stance" refers to this:

  Static tables like MCFG, HPET, ECDT, etc., are *not* mechanisms for
  reserving address space.  The static tables are for things the OS
  needs to know early in boot, before it can parse the ACPI namespace.
  If a new table is defined, an old OS needs to operate correctly even
  though it ignores the table.  _CRS allows that because it is generic
  and understood by the old OS; a static table does not.

from https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/PCI/acpi-info.rst?id=v6.6#n32]

I don't think this is just my stance.  The ACPI spec could be clearer
in terms of requiring PNP0C02 devices, not static tables, to reserve
address space, but I think that requirement is a logical consequence
of the ACPI design.

It's a goal of ACPI that an OS we release today should run on a
platform released tomorrow.  If the new platform uses a static table
to reserve address space used by some new hardware, today's OS doesn't
know about it and could place another device on top of it.

Using _CRS of an ACPI device to reserve the new hardware address space
is different because it works even with today's OS.  Today's OS can't
*operate* tomorrow's hardware, but at least it won't create address
conflicts with it.

> I just don't want to throw the vendor under the bus as it could have
> been caught "sooner" and fixed by BIOS adding _CRS.

The MCFG requirement for PNP0C02 _CRS has been in the PCI Firmware
spec since r3.0 in 2005.  I'm surprised that vendors still get this
wrong.  Vendors definitely have an interest in making shipping OSes
boot unchanged on new hardware.

> > > Knowing Windows works without it I feel this is still something that we
> > > should be looking at fixing from an upstream perspective though which is
> > > what prompted my patch and discussion.

The fact that Windows works doesn't mean the firmware is correct.
Linux assigns PCI BARs from the bottom up, and ECAM is often at the
bottom of a host bridge aperture.

Windows assigns PCI BARs from the top down, so even without a _CRS
reservation for the ECAM space, Windows is much less likely to put
something on top of it.

Bjorn

