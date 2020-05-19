Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4080C1D9A7F
	for <lists+linux-pci@lfdr.de>; Tue, 19 May 2020 16:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgESO6W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 May 2020 10:58:22 -0400
Received: from foss.arm.com ([217.140.110.172]:34576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728725AbgESO6V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 May 2020 10:58:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0505031B;
        Tue, 19 May 2020 07:58:21 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EC203F305;
        Tue, 19 May 2020 07:58:19 -0700 (PDT)
Date:   Tue, 19 May 2020 15:58:16 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        bhelgaas@google.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Alan Mikhak <alan.mikhak@sifive.com>
Subject: Re: [PATCH] PCI: dwc: Warn only for non-prefetchable memory resource
 size >4GB
Message-ID: <20200519145816.GB21261@e121166-lin.cambridge.arm.com>
References: <20200513190855.23318-1-vidyas@nvidia.com>
 <20200513223508.GA352288@bjorn-Precision-5520>
 <20200518155435.GA2299@e121166-lin.cambridge.arm.com>
 <cd62a9da-5c47-ceb2-10e7-4cf657f07801@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd62a9da-5c47-ceb2-10e7-4cf657f07801@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 19, 2020 at 07:25:02PM +0530, Vidya Sagar wrote:
> 
> 
> On 18-May-20 9:24 PM, Lorenzo Pieralisi wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Wed, May 13, 2020 at 05:35:08PM -0500, Bjorn Helgaas wrote:
> > > [+cc Alan; please cc authors of relevant commits,
> > > updated Andrew's email address]
> > > 
> > > On Thu, May 14, 2020 at 12:38:55AM +0530, Vidya Sagar wrote:
> > > > commit 9e73fa02aa009 ("PCI: dwc: Warn if MEM resource size exceeds max for
> > > > 32-bits") enables warning for MEM resources of size >4GB but prefetchable
> > > >   memory resources also come under this category where sizes can go beyond
> > > > 4GB. Avoid logging a warning for prefetchable memory resources.
> > > > 
> > > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > > ---
> > > >   drivers/pci/controller/dwc/pcie-designware-host.c | 3 ++-
> > > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > index 42fbfe2a1b8f..a29396529ea4 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > @@ -366,7 +366,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
> > > >                      pp->mem = win->res;
> > > >                      pp->mem->name = "MEM";
> > > >                      mem_size = resource_size(pp->mem);
> > > > -                   if (upper_32_bits(mem_size))
> > > > +                   if (upper_32_bits(mem_size) &&
> > > > +                       !(win->res->flags & IORESOURCE_PREFETCH))
> > > >                              dev_warn(dev, "MEM resource size exceeds max for 32 bits\n");
> > > >                      pp->mem_size = mem_size;
> > > >                      pp->mem_bus_addr = pp->mem->start - win->offset;
> > 
> > That warning was added for a reason - why should not we log legitimate
> > warnings ? AFAIU having resources larger than 4GB can lead to undefined
> > behaviour given the current ATU programming API.
> Yeah. I'm all for a warning if the size is larger than 4GB in case of
> non-prefetchable window as one of the ATU outbound translation
> channels is being used,

Is it true for all DWC host controllers ? Or there may be another
exception whereby we would be forced to disable this warning altogether
?

> but, we are not employing any ATU outbound translation channel for

What does this mean ? "we are not employing any ATU outbound...", is
this the tegra driver ? And what guarantees that this warning is not
legitimate on DWC host controllers that do use the ATU outbound
translation for prefetchable windows ?

Can DWC maintainers chime in and clarify please ?

> prefetchable window and they can be greater than 4GB in size for all
> right reasons. So, logging a warning for prefetchable region doesn't
> seem correct to me. Please let me know if my understanding is wrong.

I think your patch is wrong and it is applied on top of a patch that
is wrong too, so I won't apply yours and it is likely I will revert
Alan's because it seems to solve nothing (and warn spuriously).

It is time for people who maintain DWC please to speak up because I
don't have the HW details required to make a judgment.

Lorenzo

> - Vidya Sagar
> > 
> > Alan ? I want to understand what's the best course of action before
> > merging these patches.
> > 
> > Lorenzo
> > 
