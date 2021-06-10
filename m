Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058123A3316
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jun 2021 20:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhFJSai (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Jun 2021 14:30:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229823AbhFJSai (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Jun 2021 14:30:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A84466128A;
        Thu, 10 Jun 2021 18:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623349722;
        bh=wqLLoq0Rj8LsBDQW7JGx4xJ1bErblXKavjFDE05WbFQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=a4yxjoHLHsRy7EDWXZaBby5hDOgQqjThyxXtTa4hruv0HqIR17fQc++HoybVjHgAH
         3Zf70x4Jlu1+IXCcmYdYFJgdNm9PhXCBgihzd1HQJqRWA58cvOoOjAC1MehhGI/zE8
         bLdpixRKar0nq2IDTOVL0pkuaz8PJPQFsBxJEQG1Bpe6RFwX5MPoGWjEm1mDdiBux0
         wldm+Pm56rE2Zd0uMjfavHk0tyxChFBc2qmCEHzSjAKFRe+FIv1L5VkgMfrgRjTKNW
         8hfew/FnmoXuTnLmGiAEzTE/wPCJ4TDZn0JeUxZSZy2VgBhn6BrGb398y3NfpnD9LG
         0gyibgZD3T5kw==
Date:   Thu, 10 Jun 2021 13:28:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Punit Agrawal <punitagrawal@gmail.com>
Cc:     robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, alexandru.elisei@arm.com, wqu@suse.com,
        robin.murphy@arm.com, pgwipeout@gmail.com, ardb@kernel.org,
        briannorris@chromium.org, shawn.lin@rock-chips.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Leonardo Bras <leobras.c@gmail.com>
Subject: Re: [PATCH v3 1/4] PCI: of: Clear 64-bit flag for non-prefetchable
 memory below 4GB
Message-ID: <20210610182840.GA2761440@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875yyllu67.fsf@stealth>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 10, 2021 at 10:34:56PM +0900, Punit Agrawal wrote:
> Hi Bjorn,
> 
> Bjorn Helgaas <helgaas@kernel.org> writes:
> 
> > [+cc Leonardo]
> >
> > On Mon, Jun 07, 2021 at 08:28:53PM +0900, Punit Agrawal wrote:
> >> Some host bridges advertise non-prefetchable memory windows that are
> >> entirely located below 4GB but are marked as 64-bit address memory.
> >> 
> >> Since commit 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource
> >> flags for 64-bit memory addresses"), the OF PCI range parser takes a
> >> stricter view and treats 64-bit address ranges as advertised while
> >> before such ranges were treated as 32-bit.
> >> 
> >> A PCI root port modelled as a PCI-to-PCI bridge cannot forward 64-bit
> >> non-prefetchable memory ranges. As a result, the change in behaviour
> >> due to the commit causes failure to allocate 32-bit BAR from a 64-bit
> >> non-prefetchable window.
> >> 
> >> In order to not break platforms where non-prefetchable memory ranges
> >> lie entirely below 4GB, clear the 64-bit flag.
> >
> > I don't think we should care about the address width DT supplies for a
> > host bridge window.  Prior to 9d57e61bf723, I don't think we *did*
> > care because of_bus_pci_get_flags() threw away that information.
> >
> > My proposal for a commit log, including information about the problem
> > report and a "Fixes:" tag:
> >
> >   Alexandru and Qu reported this resource allocation failure on
> >   ROCKPro64 v2 and ROCK Pi 4B, both based on the RK3399:
> >
> >     pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfbdfffff 64bit]
> >     pci 0000:00:00.0: PCI bridge to [bus 01]
> >     pci 0000:00:00.0: BAR 14: no space for [mem size 0x00100000]
> >     pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
> >
> >   "BAR 14" is the PCI bridge's 32-bit non-prefetchable window, and our
> >   PCI allocation code isn't smart enough to allocate it in a host
> >   bridge window marked as 64-bit, even though this should work fine.
> >
> >   A DT host bridge description includes the windows from the CPU
> >   address space to the PCI bus space.  On a few architectures
> >   (microblaze, powerpc, sparc), the DT may also describe PCI devices
> >   themselves, including their BARs.
> >
> >   Before 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource
> >   flags for 64-bit memory addresses"), of_bus_pci_get_flags() ignored
> >   the fact that some DT addresses described 64-bit windows and BARs.
> >   That was a problem because the virtio virtual NIC has a 32-bit BAR
> >   and a 64-bit BAR, and the driver couldn't distinguish them.
> 
> Many thanks for demystifying the motivation for 9d57e61bf723. Not being
> familiar with the usage of DT to describe PCI devices I was missing this
> context.

The use of DT to describe PCI devices is a mystery to me, too.  I'm
guessing this is related to hypervisors that don't fully virtualize
PCI devices.  

> >   9d57e61bf723 set IORESOURCE_MEM_64 for those 64-bit DT ranges, which
> >   fixed the virtio driver.  But it also set IORESOURCE_MEM_64 for host
> >   bridge windows, which exposed the fact that the PCI allocator isn't
> >   smart enough to put 32-bit resources in those 64-bit windows.
> >
> >   Clear IORESOURCE_MEM_64 from host bridge windows since we don't need
> >   that information.
> >
> >   Fixes: 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource flags for 64-bit memory addresses")
> >   Reported-at: https://lore.kernel.org/lkml/7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com/
> >   Reported-by: Alexandru Elisei <alexandru.elisei@arm.com>
> >   Reported-by: Qu Wenruo <wqu@suse.com>
> 
> Thank you for commit log - without all the pieces I was struggling to
> clearly describe the details. And I missed the appropriate tags as
> well. I've updated the commit log based on your suggestion.
> 
> >> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> >> Link: https://lore.kernel.org/r/7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com
> >> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
> >> Tested-by: Alexandru Elisei <alexandru.elisei@arm.com>
> >> Cc: Bjorn Helgaas <bhelgaas@google.com>
> >> Cc: Rob Herring <robh+dt@kernel.org>
> >> ---
> >>  drivers/pci/of.c | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >> 
> >> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> >> index 85dcb7097da4..1e45186a5715 100644
> >> --- a/drivers/pci/of.c
> >> +++ b/drivers/pci/of.c
> >> @@ -353,6 +353,14 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
> >>  				dev_warn(dev, "More than one I/O resource converted for %pOF. CPU base address for old range lost!\n",
> >>  					 dev_node);
> >>  			*io_base = range.cpu_addr;
> >> +		} else if (resource_type(res) == IORESOURCE_MEM) {
> >> +			if (!(res->flags & IORESOURCE_PREFETCH)) {
> >> +				if (res->flags & IORESOURCE_MEM_64)
> >> +					if (!upper_32_bits(range.pci_addr + range.size - 1)) {
> >> +						dev_warn(dev, "Clearing 64-bit flag for non-prefetchable memory below 4GB\n");
> >> +						res->flags &= ~IORESOURCE_MEM_64;
> >> +					}
> >> +			}
> >
> > Why do we need to check IORESOURCE_PREFETCH, IORESOURCE_MEM_64, and
> > upper_32_bits()?  If I understand this correctly, prior to
> > 9d57e61bf723, IORESOURCE_MEM_64 was *never* set here.  Isn't something
> > like this sufficient?
> >
> >   } else if (resource_type(res) == IORESOURCE_MEM) {
> >     res->flags &= ~IORESOURCE_MEM_64;
> >   }
> 
> Based on the discussion in the original thread[0], I was working with
> the assumption that we don't want to lose the IORESOURCE_MEM_64 flag
> other than in the problem scenario, i.e., non-prefetchable memory below
> 4GB.
> 
> You suggestion is simpler and also solves the issue by effectively
> reverting the impact of 9d57e61bf723 on BAR allocation. If there are no
> objections I will take this approach for the next update.
> 
> To aid future readers I will also add the following comment -
> 
>     /*
>      * PCI allocation cannot correctly allocate 32-bit non-prefetchable BAR
>      * in host bridge windows marked as 64-bit.
>      */
> 
> > I'm not sure we need a warning either.  We didn't warn before
> > 9d57e61bf723, and there's nothing the user needs to do anyway.
> 
> The warning was a nudge (probably too subtle) to get the user to upgrade
> their DT to drop the 64-bit marker on the host bridge window. With your
> suggestion, the DT change is not needed anymore - though it may still be
> worth dropping the 64-bit marker.

I'm certainly not a DT expert, and Rob would know better.

The doc I'm looking at ([1]), says in sec 2.2.1.1 that for an address
in 32-bit-address Memory Space, the high-order address bits "hh...hh
must be zero" and only the 32 bits in "ll...ll" are usable.

That suggests to me that the DT probably *should* use 64-bit-address
Memory Space for things that don't fit in 32 bits.  But when we use
such an address for PCI host bridge windows, I don't think the
distinction is useful, so I think we should just drop the 64-bit
indication silently.

> [0] https://lore.kernel.org/linux-pci/CAMj1kXGF_JmuZ+rRA55-NrTQ6f20fhcHc=62AGJ71eHNU8AoBQ@mail.gmail.com/

[1] PCI Bus Binding to: IEEE Std 1275-1994 Standard for Boot
(Initialization Configuration) Firmware, Revision 2.1 [this is
ancient, and I would welcome a pointer to something better]
