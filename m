Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAD025AD35
	for <lists+linux-pci@lfdr.de>; Wed,  2 Sep 2020 16:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgIBOdI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 10:33:08 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:46483 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgIBO32 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Sep 2020 10:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1599056968; x=1630592968;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nd8m5014fWYkQ7GexNBnkNwmFYTggxi2CtL4XirtgFY=;
  b=j4eSvxCTiIlK5wUvAzhHOe2RCd6SwyDfgpekvt73xjrb0hcDwFIuOyRA
   X0ivnXGcNQ0lBCf05rLIeHQjQIrTaJIS67NsNZvs6eJM8+YXL+brrd1LC
   cJgxogeN1HH6ZVG8UDavqEgcZ4Wzy9JiI5jiMHaiP6YU8hajlvzqSaTTd
   Q=;
X-IronPort-AV: E=Sophos;i="5.76,383,1592870400"; 
   d="scan'208";a="51653062"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 02 Sep 2020 14:29:25 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (Postfix) with ESMTPS id B9383A1E41;
        Wed,  2 Sep 2020 14:29:23 +0000 (UTC)
Received: from EX13d09UWC002.ant.amazon.com (10.43.162.102) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 2 Sep 2020 14:29:23 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13d09UWC002.ant.amazon.com (10.43.162.102) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 2 Sep 2020 14:29:22 +0000
Received: from dev-dsk-csbisa-2a-37939146.us-west-2.amazon.com (172.19.34.216)
 by mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 2 Sep 2020 14:29:22 +0000
Received: by dev-dsk-csbisa-2a-37939146.us-west-2.amazon.com (Postfix, from userid 800212)
        id D7B701A7; Wed,  2 Sep 2020 14:29:22 +0000 (UTC)
Date:   Wed, 2 Sep 2020 14:29:22 +0000
From:   Clint Sbisa <csbisa@amazon.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        <benh@kernel.crashing.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200902142922.xc4x6m33unkzewuh@amazon.com>
References: <20200831151827.pumm2p54fyj7fz5s@amazon.com>
 <20200902113207.GA27676@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200902113207.GA27676@e121166-lin.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 02, 2020 at 12:32:07PM +0100, Lorenzo Pieralisi wrote:
> 
> On Mon, Aug 31, 2020 at 03:18:27PM +0000, Clint Sbisa wrote:
> > Using write-combine is crucial for performance of PCI devices where
> > significant amounts of transactions go over PCI BARs.
> 
> Write-combine is an x86ism that means nothing on ARM64 platforms
> so this should be rewritten to say what you actually mean, namely,
> you want to allow prefetchable resources to be mapped with
> "write combine" semantics (which means normal non-cacheable
> memory on arm64) through proc/sysfs.
> 
> This is an outright can of worms and the PCI specs don't help in this
> respect, since we may end up mapping resources that have read
> side-effects with normal NC mappings (ie that's what "write combine" is
> in arm64 - pgprot_writecombine() and that's speculative memory).
> 
> I am referring to "Additional Guidance on the Prefetchable Bit
> in Memory Space BARs" in the PCI specifications - it does not make
> any sense and must be removed because people use it to design
> endpoints.
> 
> True - this is a problem even in kernel drivers but at least there
> the ioremap_ semantics is in the driver and can be vetted.
> 
> This patch would make it user space ABI so I am a little nervous
> about merging this code TBH.
> 

User space applications are utilizing WC already. You can see DPDK code using
resourceX_wc over the usual resourceX file at
https://github.com/DPDK/dpdk/blob/main/drivers/bus/pci/linux/pci_uio.c#L312
(commit https://github.com/DPDK/dpdk/commit/4a928ef9f61).

Given that write-combine support was added in 2008 for x86 (and is also enabled
for powerpc and ia64), I'm not sure if there'd be a downside to enabling it on
arm64 as well given how prevalent it is. Lorenzo, do you still have particular
concerns about exposing this to userspace?

I understand that my commit message is outright wrong after your explanation,
so I'll rewrite that.

> > arm64 supports write-combine PCI mappings, so the appropriate define
> > has been added which will expose write-combine mappings under sysfs
> > for prefetchable PCI resources.
> >
> > Signed-off-by: Clint Sbisa <csbisa@amazon.com>
> > ---
> >  arch/arm64/include/asm/pci.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
> > index 70b323cf8300..b33ca260e3c9 100644
> > --- a/arch/arm64/include/asm/pci.h
> > +++ b/arch/arm64/include/asm/pci.h
> > @@ -17,6 +17,7 @@
> >  #define pcibios_assign_all_busses() \
> >       (pci_has_flag(PCI_REASSIGN_ALL_BUS))
> >
> > +#define arch_can_pci_mmap_wc() 1
> 
> I am not comfortable with this blanket enable. Some existing drivers,
> eg:
> 
> drivers/infiniband/hw/mlx5
> 
> use this macro to detect WC capability which again, it is x86 specific,
> on arm64 it means nothing and can have consequences on the driver
> operations.

If that driver is fixed to check what it actually wants to check, would that
address your concern about the blanket enable? I don't see any other references
to this in kernel drivers and I think the documentation at
`filesystems/sysfs-pci.rst` outlines it pretty explicitly:

  Platforms which support write-combining maps of PCI resources must define
  arch_can_pci_mmap_wc() which shall evaluate to non-zero at runtime when
  write-combining is permitted.

It is otherwise only used by pci-sysfs to determine if a resourceX_wc file
should be exposed.

Thanks,
Clint

> 
> Thanks,
> Lorenzo
> 
> >  #define ARCH_GENERIC_PCI_MMAP_RESOURCE       1
> >
> >  extern int isa_dma_bridge_buggy;
> > --
> > 2.23.3
> >
