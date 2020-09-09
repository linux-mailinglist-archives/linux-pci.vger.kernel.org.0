Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5668E263038
	for <lists+linux-pci@lfdr.de>; Wed,  9 Sep 2020 17:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgIIL7O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Sep 2020 07:59:14 -0400
Received: from foss.arm.com ([217.140.110.172]:41930 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729525AbgIILgR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Sep 2020 07:36:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8DE531B;
        Wed,  9 Sep 2020 04:36:16 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2F603F68F;
        Wed,  9 Sep 2020 04:36:15 -0700 (PDT)
Date:   Wed, 9 Sep 2020 12:36:13 +0100
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
Message-ID: <20200909113613.GB6384@e121166-lin.cambridge.arm.com>
References: <20200907104546.GC26513@gaia>
 <BYAPR18MB267959E6FE4BEF38D0A4611EC5280@BYAPR18MB2679.namprd18.prod.outlook.com>
 <20200907112118.GD26513@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907112118.GD26513@gaia>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 07, 2020 at 12:21:19PM +0100, Catalin Marinas wrote:
> + Lorenzo
> 
> On Mon, Sep 07, 2020 at 10:51:21AM +0000, George Cherian wrote:
> > Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > On Sat, Sep 05, 2020 at 10:48:11AM +0800, Yang Yingliang wrote:
> > > > diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c index
> > > > 1006ed2d7c604..ddfa1c53def48 100644
> > > > --- a/arch/arm64/kernel/pci.c
> > > > +++ b/arch/arm64/kernel/pci.c
> > > > @@ -217,4 +217,9 @@ void pcibios_remove_bus(struct pci_bus *bus)
> > > >  	acpi_pci_remove_bus(bus);
> > > >  }
> > > >
> > > > +void pci_iounmap(struct pci_dev *dev, void __iomem *addr) {
> > > > +	iounmap(addr);
> > > > +}
> > > > +EXPORT_SYMBOL(pci_iounmap);
> > > 
> > > So, what's wrong with the generic pci_iounmap() implementation?
> > > Shouldn't it call iounmap() already?
> > 
> > Since ARM64 selects CONFIG_GENERIC_PCI_IOMAP and not
> > CONFIG_GENERIC_IOMAP,  the pci_iounmap function is reduced to a NULL
> > function. Due to this, even the managed release variants or even the explicit
> > pci_iounmap calls doesn't really remove the mappings leading to leak.
> 
> Ah, I missed the fact that pci_iounmap() depends on a different
> config option.
> 
> > https://lkml.org/lkml/2020/8/20/28
> 
> So is this going to be fixed in the generic code? That would be my
> preference.
> 
> A problem with the iounmap() in the proposed patch is that the region
> may have been an I/O port, so we could end up unmapping the I/O space.

It boils down to finding a way to match a VA to a BAR resource so that
we can mirror on pci_iounmap() what's done in pci_iomap_range() (ie
check BAR resource flags to define how/if to unmap them), that would do
as a generic pci_iounmap() implementation.

In the pcim_* interface that looks easy to do, in the non-managed
case ideas welcome - at the end of the day the deal is having a way
to detect in a generic way what's behind a void __iomem *.

Lorenzo
