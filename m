Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE79F25B2DF
	for <lists+linux-pci@lfdr.de>; Wed,  2 Sep 2020 19:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgIBRWC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 13:22:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgIBRWC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Sep 2020 13:22:02 -0400
Received: from gaia (unknown [46.69.195.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04B2B20684;
        Wed,  2 Sep 2020 17:21:59 +0000 (UTC)
Date:   Wed, 2 Sep 2020 18:21:57 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Clint Sbisa <csbisa@amazon.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>, benh@kernel.crashing.org,
        linux-arm-kernel@lists.infradead.org, will@kernel.org
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200902172156.GD16673@gaia>
References: <20200831151827.pumm2p54fyj7fz5s@amazon.com>
 <20200902113207.GA27676@e121166-lin.cambridge.arm.com>
 <20200902142922.xc4x6m33unkzewuh@amazon.com>
 <20200902164702.GA30611@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902164702.GA30611@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 02, 2020 at 05:47:02PM +0100, Lorenzo Pieralisi wrote:
> On Wed, Sep 02, 2020 at 02:29:22PM +0000, Clint Sbisa wrote:
> > On Wed, Sep 02, 2020 at 12:32:07PM +0100, Lorenzo Pieralisi wrote:
> > > On Mon, Aug 31, 2020 at 03:18:27PM +0000, Clint Sbisa wrote:
> > > > arm64 supports write-combine PCI mappings, so the appropriate define
> > > > has been added which will expose write-combine mappings under sysfs
> > > > for prefetchable PCI resources.
> > > >
> > > > Signed-off-by: Clint Sbisa <csbisa@amazon.com>
> > > > ---
> > > >  arch/arm64/include/asm/pci.h | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
> > > > index 70b323cf8300..b33ca260e3c9 100644
> > > > --- a/arch/arm64/include/asm/pci.h
> > > > +++ b/arch/arm64/include/asm/pci.h
> > > > @@ -17,6 +17,7 @@
> > > >  #define pcibios_assign_all_busses() \
> > > >       (pci_has_flag(PCI_REASSIGN_ALL_BUS))
> > > >
> > > > +#define arch_can_pci_mmap_wc() 1
> > > 
> > > I am not comfortable with this blanket enable. Some existing drivers,
> > > eg:
> > > 
> > > drivers/infiniband/hw/mlx5
> > > 
> > > use this macro to detect WC capability which again, it is x86 specific,
> > > on arm64 it means nothing and can have consequences on the driver
> > > operations.
> > 
> > If that driver is fixed to check what it actually wants to check, would that
> > address your concern about the blanket enable? I don't see any other references
> > to this in kernel drivers and I think the documentation at
> > `filesystems/sysfs-pci.rst` outlines it pretty explicitly:
> > 
> >   Platforms which support write-combining maps of PCI resources must define
> >   arch_can_pci_mmap_wc() which shall evaluate to non-zero at runtime when
> >   write-combining is permitted.
> 
> That's exactly the problem. I am asking you: what does "write-combining
> maps of PCI resources" mean ?
> 
> I understand we do want weak ordering for prefetchable BAR mappings
> but my worry is that by exposing the resources as WC to user space
> we are giving user space the impression that those mappings mirror
> x86 WC mappings behaviour that is not true on ARM64.

Would Device_GRE be close to the x86 WC better? It won't allow unaligned
accesses and that can be problematic for the user. OTOH, it doesn't
speculate reads, so it's safer from the hardware perspective.

-- 
Catalin
