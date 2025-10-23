Return-Path: <linux-pci+bounces-39209-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E5CC03BCA
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 01:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BD894E3BC7
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 23:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826AB253B66;
	Thu, 23 Oct 2025 23:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0zzLP0b"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5503A9463;
	Thu, 23 Oct 2025 23:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761260577; cv=none; b=ZGrGd6FvHyyYySb6Ngb1x8U27RDPjnBDp97ToQ0jGDIWekIh7l1jDpQvD6sA2rL0Pj7tv6bC2jJkvoJoxeFMEToFBV77Ec+b30KvV/SDe4faBGzp0rGiBORHGJuSD0cRr4cn5VItBOgFT0twqQ6aTFs7GRmDdwcg3/bRSGx1yX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761260577; c=relaxed/simple;
	bh=chuXh3IVeTR9ySfAc4RS2JacaagDlwZk3qD1gLJTsho=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uRT6Bkzl6Qg+HP3utXfLWu1cC7l0zPibRardCOdX7PPdKm862fg00nOV//EbAKfYT9+cfFK+P2EC8jB86AAFjpjyGK6BUB9RWRUE4d1KfuyIHi6uN3RzqervM4aFM0jUpQkHR9iZmdJhyY6p+BBZ6FqbstI6F0++BT3qob8slzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0zzLP0b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC251C4CEE7;
	Thu, 23 Oct 2025 23:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761260576;
	bh=chuXh3IVeTR9ySfAc4RS2JacaagDlwZk3qD1gLJTsho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=c0zzLP0bILi1ucsO8Puw3GFip0hPg4j/NjkJEK41iZCHHMGVh0v85qeziSfVpb00J
	 KQgA+1ynBkUsg2KIkrOslGMrCOQhBzAqtyY11oyrd6jEzYIknvyVO2iEG1z37b+UsJ
	 6hrQOiVdmCp8CNj1cZqReLag9tQsM1OuwbvZGBplnlcMpxWsEo063/Y6p9T3cz+VSA
	 aH2jRD5RKeUJdRDRFsuMEQLNvAymzDhzUydoA90C7MMYIZBTDNHZButbEfIATt80JU
	 l1tpAVy51ZW7Ctgcrc/+or8dVNYV1JBzPkWZPb72lNQWvSiJ2uIK9TvU/4Mxpon2en
	 qcDpUVI+i0gqg==
Date: Thu, 23 Oct 2025 18:02:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH 0/3] PCI & resource: Make coalescing host bridge windows
 safer
Message-ID: <20251023230255.GA1323283@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <efebb809-cbd4-4644-750f-4b42d85102f2@linux.intel.com>

[+cc Marek, Yoshihiro for rcar-gen2]

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

I guess this came from arch/arm/boot/dts/renesas/r8a7791.dtsi:

                pci0: pci@ee090000 {
                        compatible = "renesas,pci-r8a7791",
                                     "renesas,pci-rcar-gen2";
                        reg = <0 0xee090000 0 0xc00>,
                              <0 0xee080000 0 0x1100>;
                        ranges = <0x02000000 0 0xee080000 0 0xee080000 0 0x00010000>;
                        bus-range = <0 0>;

                pciec: pcie@fe000000 {
                        compatible = "renesas,pcie-r8a7791",
                                     "renesas,pcie-rcar-gen2";
                        dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x80000000>,
                        bus-range = <0x00 0xff>;

"reg" describes address space on a device's parent side, e.g.,
memory-mapped registers consumed by the device itself.  Since this is
a host bridge, it also has "ranges" to describe address space on its
child side, including any address translation from the parent side.

PCI devices are on the child side and should consume space from the
"ranges" child side, [mem 0xee080000-0xee08ffff] in this case.

00:00.0: BAR 0 [mem 0xee090800-0xee090bff] isn't in that child address
space so I think it's invalid per spec.  Does 00:00.0 actually respond
at whatever address is in BAR 0?  Do we care?  I don't see any driver
that claims [1033:0000].

00:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref] looks like it came
from the pcie@fe000000 "dma-ranges", which describes valid child
address space for DMA.  We need to know the DMA address space, of
course, but we get it from "dma-ranges", not from a BAR.

I think it would be nicest if pci-rcar-gen2.c could hide both BAR 0
and 1 somehow so they wouldn't confuse us.

(BTW, I don't understand how both pci@ee090000 and pcie@fe000000 say
they are bridges to bus 0.)

> It's unclear to me whether DT ranges should have included BAR0 so that 
> the root bus resources would cover that range?
> 
> I was then told the updating ranges now will not be enough due to DT 
> backwards compatibility requirements so it looks we have to resort to a 
> change like this:
> 
> https://lore.kernel.org/linux-pci/7640a03e-dfea-db9c-80f5-d80fa2c505b7@linux.intel.com/
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
> 
> 
> In addition, is there something special/non-ordinary with these BARs and 
> PCI core should treat them somehow differently? If that's the case, how 
> can I identify such BARs from "normal" ones to avoid messing with them?
> 
> 
> -- 
>  i.


