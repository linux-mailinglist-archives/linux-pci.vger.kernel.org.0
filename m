Return-Path: <linux-pci+bounces-39011-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C6EBFBFB7
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 14:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44941895083
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 12:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACEB34886D;
	Wed, 22 Oct 2025 12:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kx5EUM3B"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8714C3446D0;
	Wed, 22 Oct 2025 12:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137506; cv=none; b=JzY3L7F9PCyzx9xMRQ6ojrelSkklRfVUAyLQhSX8SBaq964X5hu+4Gv5R1rX8CEEsbcg3WjoLcFNh1E/59xkQgCkqpTZF967G6Qt6KAEbNS54brPt6pbIlJtXcNmWihO/jAB0vRu1pftqQdypuU0XjwhQ0tEX60/nsY9hdzy57M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137506; c=relaxed/simple;
	bh=bHPmLF606PNrmC/BDhMWc7wjODFoA5AoV2UCEhL4p1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfyBMKK5qA1oeWx8JB0gOybK3d2ku3dFPcMQgNnOsgndyUF+gfv31Zn9KHf0TWJ9zOrK6nFC6rGzZ3aFAFG7tn6kdo/MNY1NJp2ConAcSeZUMuvhP5LlaFsLvHdYit4ZfYgB3F6FEIjc4bGMAOlQp2ZnBQ2+TNPvUmZ5mXx6dJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kx5EUM3B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38600C4CEE7;
	Wed, 22 Oct 2025 12:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761137505;
	bh=bHPmLF606PNrmC/BDhMWc7wjODFoA5AoV2UCEhL4p1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kx5EUM3Bl7+cHbDhRu3D+AndD08JXZz0dV2QDh0PLC9RYlPukFipWreKS21Vs8uIg
	 SqpwY8P75hFNTudrf9+h1y/GdDVKma3OFPBEooAQYUEQ30UnWVUvpwW/wSjk9wDP/e
	 7C6yl05qs5QxY8qiJMJoChMKdQNVx9WbNqbMMV7QhJi3QJ7bDOf02SUItEBe48S1AW
	 SjdmkRH9h0CIbKDUx7CYANoZFOF8t/90cgsI8KyLQMdnR1suYVkVnkkjRJlPi95J5v
	 uttMiwzeU1rFguVVuF59bWryoSId7MyUQhFI6UB7tLTH5U7zodTcmQaBAk8txM5I0z
	 xcKNH5lmiRb/g==
Date: Wed, 22 Oct 2025 07:51:43 -0500
From: Rob Herring <robh@kernel.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 0/3] PCI & resource: Make coalescing host bridge windows
 safer
Message-ID: <20251022125143.GA3266913-robh@kernel.org>
References: <20251010144231.15773-1-ilpo.jarvinen@linux.intel.com>
 <CAMuHMdVwAkC0XOU_SZ0HeH0+oT-j5SvKyRcFcJbbes624Yu9uQ@mail.gmail.com>
 <89a20c14-dd0f-22ae-d998-da511a94664a@linux.intel.com>
 <CAMuHMdUbseFEY8AGOxm2T8W-64qT9OSvfmvu+hyTJUT+WE2cVw@mail.gmail.com>
 <20844374-d3df-cc39-a265-44a3008a3bcb@linux.intel.com>
 <CAMuHMdWD_GJ0hpJODBNKeR77UhKMW2CuWWf-xJo2kuL514_Tpw@mail.gmail.com>
 <efebb809-cbd4-4644-750f-4b42d85102f2@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <efebb809-cbd4-4644-750f-4b42d85102f2@linux.intel.com>

On Wed, Oct 22, 2025 at 03:14:12PM +0300, Ilpo Järvinen wrote:
> On Wed, 22 Oct 2025, Geert Uytterhoeven wrote:
> > On Tue, 21 Oct 2025 at 13:54, Ilpo Järvinen
> > <ilpo.jarvinen@linux.intel.com> wrote:
> > > On Tue, 21 Oct 2025, Geert Uytterhoeven wrote:
> > > > On Mon, 20 Oct 2025 at 18:20, Ilpo Järvinen
> > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > On Mon, 20 Oct 2025, Geert Uytterhoeven wrote:
> > > > > > On Fri, 10 Oct 2025 at 16:42, Ilpo Järvinen
> > > > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > > > Here's a series for Geert to test if this fixes the improper coalescing
> > > > > > > of resources as was experienced with the pci_add_resource() change (I
> > > > > > > know the breaking change was pulled before 6.18 main PR but I'd want to
> > > > > > > retry it later once the known issues have been addressed). The expected
> > > > > > > result is there'll be two adjacent host bridge resources in the
> > > > > > > resource tree as the different name should disallow coalescing them
> > > > > > > together, and therefore BAR0 has a window into which it belongs to.
> > > > > > >
> > > > > > > Generic info for the series:
> > > > > > >
> > > > > > > PCI host bridge windows were coalesced in place into one of the structs
> > > > > > > on the resources list. The host bridge window coalescing code does not
> > > > > > > know who holds references and still needs the struct resource it's
> > > > > > > coalescing from/to so it is safer to perform coalescing into entirely
> > > > > > > a new struct resource instead and leave the old resource addresses as
> > > > > > > they were.
> > > > > > >
> > > > > > > The checks when coalescing is allowed are also made stricter so that
> > > > > > > only resources that have identical the metadata can be coalesced.
> > > > > > >
> > > > > > > As a bonus, there's also a bit of framework to easily create kunit
> > > > > > > tests for resource tree functions (beyond just resource_coalesce()).
> > > > > > >
> > > > > > > Ilpo Järvinen (3):
> > > > > > >   PCI: Refactor host bridge window coalescing loop to use prev
> > > > > > >   PCI: Do not coalesce host bridge resource structs in place
> > > > > > >   resource, kunit: add test case for resource_coalesce()
> > > > > >
> > > > > > Thanks for your series!
> > > > > >
> > > > > > I have applied this on top of commit 06b77d5647a4d6a7 ("PCI:
> > > > > > Mark resources IORESOURCE_UNSET when outside bridge windows"), and
> > > > > > gave it a a try on Koelsch (R-Car M2-W).
> > > > >
> > > > > So the pci_bus_add_resource() patch to rcar_pci_probe() was not included?
> > > > > No coalescing would be attempted without that change.
> > > >
> > > > Sorry, I didn't realize you wanted that (and anything else) to be
> > > > included, too.  Please tell me the exact base I should use for testing,
> > > > and I will give it another run.
> > >
> > > I'm sorry, it's indeed a bit confusing as some of these patches never
> > > have been in Linus' tree.
> > >
> > > So I'm interested on what's the result with these changes/series together:
> > >
> > > [PATCH 1/2] PCI: Setup bridge resources earlier
> > > [PATCH 2/2] PCI: Resources outside their window must set IORESOURCE_UNSET
> > > [PATCH 1/1] PCI: rcar-gen2: Add BAR0 into host bridge resources
> > > [PATCH 1/3] PCI: Refactor host bridge window coalescing loop to use prev
> > > [PATCH 2/3] PCI: Do not coalesce host bridge resource structs in place
> > > [PATCH 3/3] resource, kunit: add test case for resource_coalesce()
> > >
> > > You might also want to change that pci_dbg() in the IORESOURCE_UNSET patch
> > > to pci_info() (as otherwise dyndbg is necessary to make it visible).
> > 
> > Thanks, all done:
> > 
> >     $ git cherry -v --abbrev=1 v6.18-rc2^
> >     + 211ddde0 Linux 6.18-rc2
> >     + 3fdaf2 PCI: Setup bridge resources earlier
> >     + 5be02e5 PCI: Resources outside their window must set IORESOURCE_UNSET
> >     + adf6f11 PCI: rcar-gen2: Add BAR0 into host bridge resources
> >     + eecb500 PCI: Refactor host bridge window coalescing loop to use prev
> >     + 60470b3 PCI: Do not coalesce host bridge resource structs in place
> >     + afe3ec resource, kunit: add test case for resource_coalesce()
> >     + 487c98 Use dev_info() in drivers/pci/probe.c:__pci_read_base()
> > IORESOURCE_UNSET path
> > 
> > Compared to v6.18-rc2, dmesg changed (for the first PCI/USB instance)
> > like:
> > 
> >      pci-rcar-gen2 ee090000.pci: host bridge /soc/pci@ee090000 ranges:
> >      pci-rcar-gen2 ee090000.pci:      MEM 0x00ee080000..0x00ee08ffff
> > -> 0x00ee080000
> >      pci-rcar-gen2 ee090000.pci: PCI: revision 11
> >      pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
> >      pci_bus 0000:00: root bus resource [bus 00]
> >      pci_bus 0000:00: root bus resource [mem 0xee080000-0xee08ffff]
> >     +pci_bus 0000:00: root bus resource [mem 0xee090000-0xee090bff]
> >      pci 0000:00:00.0: [1033:0000] type 00 class 0x060000 conventional
> > PCI endpoint
> >      pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]
> >     -pci 0000:00:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]
> >     +pci 0000:00:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]: no
> > initial claim (no window)
> >     +pci 0000:00:00.0: BAR 1 [mem size 0x40000000 pref]
> >      pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310 conventional
> > PCI endpoint
> >     -pci 0000:00:01.0: BAR 0 [mem 0x00000000-0x00000fff]
> >     +pci 0000:00:01.0: BAR 0 [mem 0x00000000-0x00000fff]: no initial
> > claim (no window)
> >     +pci 0000:00:01.0: BAR 0 [mem size 0x00001000]
> >      pci 0000:00:01.0: supports D1 D2
> >      pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
> >      pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320 conventional
> > PCI endpoint
> >     -pci 0000:00:02.0: BAR 0 [mem 0x00000000-0x000000ff]
> >     +pci 0000:00:02.0: BAR 0 [mem 0x00000000-0x000000ff]: no initial
> > claim (no window)
> >     +pci 0000:00:02.0: BAR 0 [mem size 0x00000100]
> >      pci 0000:00:02.0: supports D1 D2
> >      pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
> >      PCI: bus0: Fast back to back transfers disabled
> >      pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee080fff]: assigned
> >      pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee0810ff]: assigned
> >      pci_bus 0000:00: resource 4 [mem 0xee080000-0xee08ffff]
> >     +pci_bus 0000:00: resource 5 [mem 0xee090000-0xee090bff]
> >      pci 0000:00:01.0: enabling device (0140 -> 0142)
> >      pci 0000:00:02.0: enabling device (0140 -> 0142)
> > 
> > > The expected result is that those usb resources are properly parented and
> > > the ee080000-ee08ffff and ee090000-ee090bff are not coalesced together (as
> > > that would destroy information). So something along the lines of:
> > >
> > >     ee080000-ee08ffff : pci@ee090000
> > >       ee080000-ee080fff : 0000:00:01.0
> > >         ee080000-ee080fff : ohci_hcd
> > >       ee081000-ee0810ff : 0000:00:02.0
> > >         ee081000-ee0810ff : ehci_hcd
> > >     ee090000-ee090bff : ee090000.pci pci@ee090000
> > 
> > Compared to v6.18-rc2, the output of "lspci -v" or "cat /proc/iomem"
> > did not change.  Hence for the two PCI/USB instances:
> > 
> >     ee080000-ee08ffff : pci@ee090000
> >       ee080000-ee080fff : 0000:00:01.0
> >         ee080000-ee080fff : ohci_hcd
> >       ee081000-ee0810ff : 0000:00:02.0
> >         ee081000-ee0810ff : ehci_hcd
> >     ee090000-ee090bff : ee090000.pci pci@ee090000
> >     ee0c0000-ee0cffff : pci@ee0d0000
> >       ee0c0000-ee0c0fff : 0001:01:01.0
> >         ee0c0000-ee0c0fff : ohci_hcd
> >       ee0c1000-ee0c10ff : 0001:01:02.0
> >         ee0c1000-ee0c10ff : ehci_hcd
> >     ee0d0000-ee0d0bff : ee0d0000.pci pci@ee0d0000
> 
> Hi Rob,
> 
> I'd want to hear your opinion on the solutions me and Geert tried and
> discussed in the subthread starting from this:
> 
> https://lore.kernel.org/linux-pci/CAMuHMdVtVzcL3AX0uetNhKr-gLij37Ww+fcWXxnYpO3xRAOthA@mail.gmail.com/
>    
> A short history/summary of the problem and solution space:
> 
> I made "PCI: Resources outside their window must set IORESOURCE_UNSET"
> change that checks at the init time whether BARs belong to an upstream
> window or not. If not, the resource is marked wit IORESOURCE_UNSET to 
> indicate FW/platform didn't provide working addressing for those BARs.
> 
> On Geert's R-Car M2-W, it caused some BARs to be detected as not having a
> an upstream window where they belong to:
> 
>      pci-rcar-gen2 ee090000.pci: host bridge /soc/pci@ee090000 ranges:
>      pci-rcar-gen2 ee090000.pci:      MEM 0x00ee080000..0x00ee08ffff -> 0x00ee080000
>      pci-rcar-gen2 ee090000.pci: PCI: revision 11
>      pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
>      pci_bus 0000:00: root bus resource [bus 00]
>      pci_bus 0000:00: root bus resource [mem 0xee080000-0xee08ffff]
>      pci 0000:00:00.0: [1033:0000] type 00 class 0x060000 conventional PCI endpoint
>     -pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]
>     -pci 0000:00:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]
>     +pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]: no initial claim (no window)
>     +pci 0000:00:00.0: BAR 0 [mem size 0x00000400]
>     +pci 0000:00:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]: no initial claim (no window)
>     +pci 0000:00:00.0: BAR 1 [mem size 0x40000000 pref]
> 
> ...In the log above, there's no root bus resource that covers
> BAR0's 0xee090800-0xee090bff address range (which itself comes from DT 
> "reg"), and thus it got marked IORESOURCE_UNSET with as it does not 
> have window where it belongs to.
> 
> It's unclear to me whether DT ranges should have included BAR0 so that 
> the root bus resources would cover that range?

I think it should. Otherwise, how do you know if the region is 32 or 64 
bit or prefetchable or not?

> 
> I was then told the updaing ranges now will not be enough due to DT 
> backwards compatibility requirements so it looks we have to resort to a 
> change like this:
> 
> https://lore.kernel.org/linux-pci/7640a03e-dfea-db9c-80f5-d80fa2c505b7@linux.intel.com/

You aren't adding 'BAR0 region', but something else. Based on the name, 
cfg_res, that is config space? That seems wrong both in requiring it to 
be registered and that you would assign BAR0 to config space. How would 
that device operate when config space is not memory mapped?

For compatibility, the change itself doesn't look so bad. However, we 
could also fixup the DT itself. That's not done too much on Arm systems, 
but there's all sorts of fixups in powerpc. I have some initial 
infrastructure to support that if we need to go down that path.

> 
> (+ a few supporting changes as that change exposed brokenness in PCI core.)
> 
> Does that look correct solution? That is, should these be added on 
> case-by-case basis as additional root bus resources or should there be 
> something more generic in the OF PCI code to do it?
> 
> There's also that BAR1 which seems to be related to dma_ranges and I don't 
> know what to make of it. This resource comes with the added complication 
> that this same address appears more than once (in the full log there's 
> more than one PCI/USB instance). Again, this BAR1 is not covered by any 
> root bus resource and thus gets flagged with IORESOURCE_UNSET. 
> 
> So I'm interested what is the "correct" solution for these resources that 
> appear as BARs but do not have a backing root bus resource, is it having 
> DT "ranges" cover them (I'm ignoring backwards compatibility aspect here) 
> or something else?

If it is config space, no, I don't think ranges should cover that. 
'ranges' should have all the memory and io spaces.

> In addition, is there something special/non-ordinary with these BARs and 
> PCI core should treat them somehow differently? If that's the case, how 
> can I identify such BARs from "normal" ones to avoid messing with them?

You've exceeded my PCI knowledge on this...

Rob

