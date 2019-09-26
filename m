Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34BFFBF417
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2019 15:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfIZNcE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Sep 2019 09:32:04 -0400
Received: from foss.arm.com ([217.140.110.172]:49750 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfIZNcE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Sep 2019 09:32:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 076E9142F;
        Thu, 26 Sep 2019 06:32:03 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73A213F70D;
        Thu, 26 Sep 2019 06:32:02 -0700 (PDT)
Date:   Thu, 26 Sep 2019 14:32:00 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 11/11] PCI: rcar: Use inbound resources for setup
Message-ID: <20190926133200.GE9720@e119886-lin.cambridge.arm.com>
References: <20190924214630.12817-1-robh@kernel.org>
 <20190924214630.12817-12-robh@kernel.org>
 <20190926084718.GA9720@e119886-lin.cambridge.arm.com>
 <CAL_Jsq+5cbPd_7Yoo6DvK9LFwf-npChWxRPMq-TtqFSALbXuDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+5cbPd_7Yoo6DvK9LFwf-npChWxRPMq-TtqFSALbXuDw@mail.gmail.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 26, 2019 at 07:53:20AM -0500, Rob Herring wrote:
> On Thu, Sep 26, 2019 at 3:47 AM Andrew Murray <andrew.murray@arm.com> wrote:
> >
> > On Tue, Sep 24, 2019 at 04:46:30PM -0500, Rob Herring wrote:
> > > Now that the helpers provide the inbound resources in the host bridge
> > > 'dma_ranges' resource list, convert Renesas R-Car PCIe host bridge to
> > > use the resource list to setup the inbound addresses.
> > >
> > > Cc: Simon Horman <horms@verge.net.au>
> > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  drivers/pci/controller/pcie-rcar.c | 45 +++++++++++-------------------
> > >  1 file changed, 16 insertions(+), 29 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
> > > index b8d6e86a5539..453c931aaf77 100644
> > > --- a/drivers/pci/controller/pcie-rcar.c
> > > +++ b/drivers/pci/controller/pcie-rcar.c
> > > @@ -1014,16 +1014,16 @@ static int rcar_pcie_get_resources(struct rcar_pcie *pcie)
> > >  }
> > >
> > >  static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
> > > -                                 struct of_pci_range *range,
> > > +                                 struct resource_entry *entry,
> > >                                   int *index)
> > >  {
> > > -     u64 restype = range->flags;
> > > -     u64 cpu_addr = range->cpu_addr;
> > > -     u64 cpu_end = range->cpu_addr + range->size;
> > > -     u64 pci_addr = range->pci_addr;
> > > +     u64 restype = entry->res->flags;
> > > +     u64 cpu_addr = entry->res->start;
> > > +     u64 cpu_end = entry->res->end;
> > > +     u64 pci_addr = entry->res->start - entry->offset;
> > >       u32 flags = LAM_64BIT | LAR_ENABLE;
> > >       u64 mask;
> > > -     u64 size;
> > > +     u64 size = resource_size(entry->res);
> > >       int idx = *index;
> > >
> > >       if (restype & IORESOURCE_PREFETCH)
> > > @@ -1037,9 +1037,7 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
> > >               unsigned long nr_zeros = __ffs64(cpu_addr);
> > >               u64 alignment = 1ULL << nr_zeros;
> > >
> > > -             size = min(range->size, alignment);
> > > -     } else {
> > > -             size = range->size;
> > > +             size = min(size, alignment);
> > >       }
> >
> > AFAICT the (if cpu_addr > 0) is here because the result of __ffs64 is undefined
> > if no bits are set (according to the comment). However by removing the else
> > statement we no longer guarantee that nr_zeros is defined.
> 
> You might want to read this again...
> 
> The 'if (cpu_addr > 0) {' is still there and nr_zeros is only under
> that condition. We just init 'size' instead of setting it in the else
> clause.

Ah yes, apologies for the noise, thanks for your patience.

Andrew Murray

> 
> Rob
