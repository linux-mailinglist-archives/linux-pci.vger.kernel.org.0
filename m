Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA102634C4
	for <lists+linux-pci@lfdr.de>; Wed,  9 Sep 2020 19:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgIIRiC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Sep 2020 13:38:02 -0400
Received: from foss.arm.com ([217.140.110.172]:45962 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727856AbgIIRh5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Sep 2020 13:37:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D80F0101E;
        Wed,  9 Sep 2020 10:37:56 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A28B23F68F;
        Wed,  9 Sep 2020 10:37:55 -0700 (PDT)
Date:   Wed, 9 Sep 2020 18:37:49 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     George Cherian <gcherian@marvell.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>
Subject: Re: [PATCH] arm64: PCI: fix memleak when calling pci_iomap/unmap()
Message-ID: <20200909173749.GA11781@e121166-lin.cambridge.arm.com>
References: <20200907104546.GC26513@gaia>
 <BYAPR18MB267959E6FE4BEF38D0A4611EC5280@BYAPR18MB2679.namprd18.prod.outlook.com>
 <20200907112118.GD26513@gaia>
 <20200909113613.GB6384@e121166-lin.cambridge.arm.com>
 <20200909135400.GB13047@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909135400.GB13047@gaia>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 09, 2020 at 02:54:01PM +0100, Catalin Marinas wrote:
> On Wed, Sep 09, 2020 at 12:36:13PM +0100, Lorenzo Pieralisi wrote:
> > On Mon, Sep 07, 2020 at 12:21:19PM +0100, Catalin Marinas wrote:
> > > On Mon, Sep 07, 2020 at 10:51:21AM +0000, George Cherian wrote:
> > > > Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > > On Sat, Sep 05, 2020 at 10:48:11AM +0800, Yang Yingliang wrote:
> > > > > > diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c index
> > > > > > 1006ed2d7c604..ddfa1c53def48 100644
> > > > > > --- a/arch/arm64/kernel/pci.c
> > > > > > +++ b/arch/arm64/kernel/pci.c
> > > > > > @@ -217,4 +217,9 @@ void pcibios_remove_bus(struct pci_bus *bus)
> > > > > >  	acpi_pci_remove_bus(bus);
> > > > > >  }
> > > > > >
> > > > > > +void pci_iounmap(struct pci_dev *dev, void __iomem *addr) {
> > > > > > +	iounmap(addr);
> > > > > > +}
> > > > > > +EXPORT_SYMBOL(pci_iounmap);
> > > > > 
> > > > > So, what's wrong with the generic pci_iounmap() implementation?
> > > > > Shouldn't it call iounmap() already?
> > > > 
> > > > Since ARM64 selects CONFIG_GENERIC_PCI_IOMAP and not
> > > > CONFIG_GENERIC_IOMAP,  the pci_iounmap function is reduced to a NULL
> > > > function. Due to this, even the managed release variants or even the explicit
> > > > pci_iounmap calls doesn't really remove the mappings leading to leak.
> > > 
> > > Ah, I missed the fact that pci_iounmap() depends on a different
> > > config option.
> > > 
> > > > https://lkml.org/lkml/2020/8/20/28
> > > 
> > > So is this going to be fixed in the generic code? That would be my
> > > preference.
> > > 
> > > A problem with the iounmap() in the proposed patch is that the region
> > > may have been an I/O port, so we could end up unmapping the I/O space.
> > 
> > It boils down to finding a way to match a VA to a BAR resource so that
> > we can mirror on pci_iounmap() what's done in pci_iomap_range() (ie
> > check BAR resource flags to define how/if to unmap them), that would do
> > as a generic pci_iounmap() implementation.
> 
> In the !CONFIG_GENERIC_IOMAP case (arm64), for IORESOURCE_IO,
> pci_iomap_range() calls __pci_ioport_map() which, with the default
> ioport_map(), it ends up with a simple PCI_IOBASE + (port &
> IO_SPACE_LIMIT).
> 
> pci_iounmap() could check whether the pointer is in the PCI_IOBASE -
> PCI_IOBASE+IO_SPACE_LIMIT range before calling ioremap(), unless the
> arch code re-defined ioport_map. Something like below (not even
> compiled):

I gave it some thought - with the current state of affairs (which is not
ideal - this *_IOMAP stuff is ways too complex) it is likely to be the
safest/only way we can have this in generic code, short of implementing
what I mentioned (but that implies keeping track of BAR VA mappings)
or cleaning up this nest of defines.

Lorenzo

> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index dabf8cb7203b..fada420c9cd6 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -919,6 +919,11 @@ extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
>  #define pci_iounmap pci_iounmap
>  static inline void pci_iounmap(struct pci_dev *dev, void __iomem *p)
>  {
> +#ifndef ARCH_HAS_IOPORT_MAP
> +	if (p >= PCI_IOBASE && p < PCI_IOBASE + IO_SPACE_LIMIT)
> +		return;
> +	iounmap(p);
> +#endif
>  }
>  #endif
>  #endif /* CONFIG_GENERIC_IOMAP */
> @@ -1009,7 +1014,9 @@ static inline void __iomem *ioremap_uc(phys_addr_t offset, size_t size)
>  
>  #ifdef CONFIG_HAS_IOPORT_MAP
>  #ifndef CONFIG_GENERIC_IOMAP
> -#ifndef ioport_map
> +#ifdef ioport_map
> +#define ARCH_HAS_IOPORT_MAP
> +#else
>  #define ioport_map ioport_map
>  static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
>  {
> 
> -- 
> Catalin
