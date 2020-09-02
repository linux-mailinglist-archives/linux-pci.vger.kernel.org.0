Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E76E25B1FF
	for <lists+linux-pci@lfdr.de>; Wed,  2 Sep 2020 18:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgIBQrK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 12:47:10 -0400
Received: from foss.arm.com ([217.140.110.172]:42414 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727088AbgIBQrJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Sep 2020 12:47:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99C481045;
        Wed,  2 Sep 2020 09:47:08 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99F153F66F;
        Wed,  2 Sep 2020 09:47:07 -0700 (PDT)
Date:   Wed, 2 Sep 2020 17:47:02 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Clint Sbisa <csbisa@amazon.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        benh@kernel.crashing.org, linux-arm-kernel@lists.infradead.org,
        will@kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200902164702.GA30611@e121166-lin.cambridge.arm.com>
References: <20200831151827.pumm2p54fyj7fz5s@amazon.com>
 <20200902113207.GA27676@e121166-lin.cambridge.arm.com>
 <20200902142922.xc4x6m33unkzewuh@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902142922.xc4x6m33unkzewuh@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+LAKML, Will, Catalin]

This is an ARM64 arch discussion so please keep the above CCed from
now onwards.

On Wed, Sep 02, 2020 at 02:29:22PM +0000, Clint Sbisa wrote:
> On Wed, Sep 02, 2020 at 12:32:07PM +0100, Lorenzo Pieralisi wrote:
> > 
> > On Mon, Aug 31, 2020 at 03:18:27PM +0000, Clint Sbisa wrote:
> > > Using write-combine is crucial for performance of PCI devices where
> > > significant amounts of transactions go over PCI BARs.
> > 
> > Write-combine is an x86ism that means nothing on ARM64 platforms
> > so this should be rewritten to say what you actually mean, namely,
> > you want to allow prefetchable resources to be mapped with
> > "write combine" semantics (which means normal non-cacheable
> > memory on arm64) through proc/sysfs.
> > 
> > This is an outright can of worms and the PCI specs don't help in this
> > respect, since we may end up mapping resources that have read
> > side-effects with normal NC mappings (ie that's what "write combine" is
> > in arm64 - pgprot_writecombine() and that's speculative memory).
> > 
> > I am referring to "Additional Guidance on the Prefetchable Bit
> > in Memory Space BARs" in the PCI specifications - it does not make
> > any sense and must be removed because people use it to design
> > endpoints.
> > 
> > True - this is a problem even in kernel drivers but at least there
> > the ioremap_ semantics is in the driver and can be vetted.
> > 
> > This patch would make it user space ABI so I am a little nervous
> > about merging this code TBH.
> > 
> 
> User space applications are utilizing WC already. You can see DPDK code using
> resourceX_wc over the usual resourceX file at
> https://github.com/DPDK/dpdk/blob/main/drivers/bus/pci/linux/pci_uio.c#L312
> (commit https://github.com/DPDK/dpdk/commit/4a928ef9f61).

I know.

> Given that write-combine support was added in 2008 for x86 (and is
> also enabled for powerpc and ia64), I'm not sure if there'd be a
> downside to enabling it on arm64 as well given how prevalent it is.

I explained to you the reasons why this can have downsides and write
combine is a concept that does not exist in the ARM64 world, actually
it would be good if Ben can chime in to define how this works on power.

>Lorenzo, do you still have particular concerns about exposing this to
>userspace?

Yes I do and I expressed them.

The first concern is the WC ambiguity on non-x86 systems, it looks
like write combinining means everything and nothing at the same time
on != x86 arches.

On x86 prefetchable BAR == WC mapping (still conditional on arch
features ie PAT, not a blanket enable). On ARM64 WC mapping currently
corresponds to normal NC memory and the PCIe specs allow read
side-effects BAR to be marked as prefetchable, I need to force PCI sig
to remove the section I mentioned from the specifications because there
is NO way it can be detected if a prefetchable BAR maps to read
side-effects memory.

A kernel device driver would (hopefully) know, sysfs code that just
checks the prefetchable attribute and exports resource_WC does not.

As I mentioned, if the mapping is done in a device specific driver it
can be vetted and there are not many drivers mapping BARs as
ioremap_wc().

> I understand that my commit message is outright wrong after your explanation,
> so I'll rewrite that.
> 
> > > arm64 supports write-combine PCI mappings, so the appropriate define
> > > has been added which will expose write-combine mappings under sysfs
> > > for prefetchable PCI resources.
> > >
> > > Signed-off-by: Clint Sbisa <csbisa@amazon.com>
> > > ---
> > >  arch/arm64/include/asm/pci.h | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
> > > index 70b323cf8300..b33ca260e3c9 100644
> > > --- a/arch/arm64/include/asm/pci.h
> > > +++ b/arch/arm64/include/asm/pci.h
> > > @@ -17,6 +17,7 @@
> > >  #define pcibios_assign_all_busses() \
> > >       (pci_has_flag(PCI_REASSIGN_ALL_BUS))
> > >
> > > +#define arch_can_pci_mmap_wc() 1
> > 
> > I am not comfortable with this blanket enable. Some existing drivers,
> > eg:
> > 
> > drivers/infiniband/hw/mlx5
> > 
> > use this macro to detect WC capability which again, it is x86 specific,
> > on arm64 it means nothing and can have consequences on the driver
> > operations.
> 
> If that driver is fixed to check what it actually wants to check, would that
> address your concern about the blanket enable? I don't see any other references
> to this in kernel drivers and I think the documentation at
> `filesystems/sysfs-pci.rst` outlines it pretty explicitly:
> 
>   Platforms which support write-combining maps of PCI resources must define
>   arch_can_pci_mmap_wc() which shall evaluate to non-zero at runtime when
>   write-combining is permitted.

That's exactly the problem. I am asking you: what does "write-combining
maps of PCI resources" mean ?

I understand we do want weak ordering for prefetchable BAR mappings
but my worry is that by exposing the resources as WC to user space
we are giving user space the impression that those mappings mirror
x86 WC mappings behaviour that is not true on ARM64.

Again - Ben has extensive experience on this on power I would be happy
to get his point of view before proceeding, it is important to undestand
how this work on non-x86 systems.

> It is otherwise only used by pci-sysfs to determine if a resourceX_wc
> file should be exposed.

I know - that's understood.

Thanks,
Lorenzo
