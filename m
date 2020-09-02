Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB8325B339
	for <lists+linux-pci@lfdr.de>; Wed,  2 Sep 2020 19:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgIBRy6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 13:54:58 -0400
Received: from foss.arm.com ([217.140.110.172]:43784 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgIBRy6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Sep 2020 13:54:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EC43D6E;
        Wed,  2 Sep 2020 10:54:56 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D2CB3F66F;
        Wed,  2 Sep 2020 10:54:50 -0700 (PDT)
Date:   Wed, 2 Sep 2020 18:54:45 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Clint Sbisa <csbisa@amazon.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>, benh@kernel.crashing.org,
        linux-arm-kernel@lists.infradead.org, will@kernel.org
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200902175445.GA31706@e121166-lin.cambridge.arm.com>
References: <20200831151827.pumm2p54fyj7fz5s@amazon.com>
 <20200902113207.GA27676@e121166-lin.cambridge.arm.com>
 <20200902142922.xc4x6m33unkzewuh@amazon.com>
 <20200902164702.GA30611@e121166-lin.cambridge.arm.com>
 <20200902172156.GD16673@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902172156.GD16673@gaia>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 02, 2020 at 06:21:57PM +0100, Catalin Marinas wrote:
> On Wed, Sep 02, 2020 at 05:47:02PM +0100, Lorenzo Pieralisi wrote:
> > On Wed, Sep 02, 2020 at 02:29:22PM +0000, Clint Sbisa wrote:
> > > On Wed, Sep 02, 2020 at 12:32:07PM +0100, Lorenzo Pieralisi wrote:
> > > > On Mon, Aug 31, 2020 at 03:18:27PM +0000, Clint Sbisa wrote:
> > > > > arm64 supports write-combine PCI mappings, so the appropriate define
> > > > > has been added which will expose write-combine mappings under sysfs
> > > > > for prefetchable PCI resources.
> > > > >
> > > > > Signed-off-by: Clint Sbisa <csbisa@amazon.com>
> > > > > ---
> > > > >  arch/arm64/include/asm/pci.h | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >
> > > > > diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
> > > > > index 70b323cf8300..b33ca260e3c9 100644
> > > > > --- a/arch/arm64/include/asm/pci.h
> > > > > +++ b/arch/arm64/include/asm/pci.h
> > > > > @@ -17,6 +17,7 @@
> > > > >  #define pcibios_assign_all_busses() \
> > > > >       (pci_has_flag(PCI_REASSIGN_ALL_BUS))
> > > > >
> > > > > +#define arch_can_pci_mmap_wc() 1
> > > > 
> > > > I am not comfortable with this blanket enable. Some existing drivers,
> > > > eg:
> > > > 
> > > > drivers/infiniband/hw/mlx5
> > > > 
> > > > use this macro to detect WC capability which again, it is x86 specific,
> > > > on arm64 it means nothing and can have consequences on the driver
> > > > operations.
> > > 
> > > If that driver is fixed to check what it actually wants to check, would that
> > > address your concern about the blanket enable? I don't see any other references
> > > to this in kernel drivers and I think the documentation at
> > > `filesystems/sysfs-pci.rst` outlines it pretty explicitly:
> > > 
> > >   Platforms which support write-combining maps of PCI resources must define
> > >   arch_can_pci_mmap_wc() which shall evaluate to non-zero at runtime when
> > >   write-combining is permitted.
> > 
> > That's exactly the problem. I am asking you: what does "write-combining
> > maps of PCI resources" mean ?
> > 
> > I understand we do want weak ordering for prefetchable BAR mappings
> > but my worry is that by exposing the resources as WC to user space
> > we are giving user space the impression that those mappings mirror
> > x86 WC mappings behaviour that is not true on ARM64.
> 
> Would Device_GRE be close to the x86 WC better? It won't allow unaligned
> accesses and that can be problematic for the user. OTOH, it doesn't
> speculate reads, so it's safer from the hardware perspective.

Thanks Catalin for chiming in, it may yes but I need to figure out
the precise semantics of WC on x86 first.

Actually *if* I read x86 specs correctly WC mappings allow speculative
reads, which then would shift the issue on the PCI specs that allow
marking read side effects BARs as prefetchable; in other words if
an endpoint is designed with a prefetchable BAR that has read side
effects this is already an issue on x86 in the current kernel.

There is that, plus the usage of arch_can_pci_mmap_wc() in mellanox
drivers which I suspect it is yet another interpretation of x86 write
combine - I don't know what happens if we let arch_can_pci_mmap_wc() == 1
on both normalNC or deviceGRE mappings for pgprot_writecombine.

I think it is worth getting to the bottom of this before applying
this patch.

Thanks,
Lorenzo
