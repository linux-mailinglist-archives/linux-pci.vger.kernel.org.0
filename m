Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 029A0DC21A
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2019 12:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfJRKHV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Oct 2019 06:07:21 -0400
Received: from [217.140.110.172] ([217.140.110.172]:60632 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1727249AbfJRKHV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Oct 2019 06:07:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EAC9494;
        Fri, 18 Oct 2019 03:06:57 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 252F13F6C4;
        Fri, 18 Oct 2019 03:06:57 -0700 (PDT)
Date:   Fri, 18 Oct 2019 11:06:55 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH V3 2/3] PCI: rcar: Do not abort on too many inbound
 dma-ranges
Message-ID: <20191018100655.GA47056@e119886-lin.cambridge.arm.com>
References: <c4353d63-6f78-92b3-91c9-acc9327e1d80@gmail.com>
 <20191016152601.GB7457@e121166-lin.cambridge.arm.com>
 <75fb3519-80eb-fec2-d3eb-cc1b884fef25@gmail.com>
 <20191016161846.GC7457@e121166-lin.cambridge.arm.com>
 <CAL_JsqL2c-ODMkOo1tAJh8JeF0VRXahCq2zF2fX8dZV8wpQj+Q@mail.gmail.com>
 <c835701d-ff0e-f1b8-af16-fe53febe5519@gmail.com>
 <CAL_Jsq+4uaFJzk5jUPw+KssZvnji0WDh+QcFMok99XXntEhNTQ@mail.gmail.com>
 <88099c4f-4fb4-626e-f66f-3eb8861dfb2c@gmail.com>
 <CAL_JsqLzmk5dfn0Re3y7VjY5ehE29vKLOV-2tM5B_jPbB2YiPQ@mail.gmail.com>
 <06d093b2-dcc2-a01f-fce0-5db0bc47325e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06d093b2-dcc2-a01f-fce0-5db0bc47325e@gmail.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 17, 2019 at 12:33:24AM +0200, Marek Vasut wrote:
> On 10/17/19 12:26 AM, Rob Herring wrote:
> [...]
> >>>> You can have multiple non-continuous DRAM banks for example. And an
> >>>> entry for SRAM optionally. Each DRAM bank and/or the SRAM should have a
> >>>> separate dma-ranges entry, right ?
> >>>
> >>> Not necessarily. We really only want to define the minimum we have to.
> >>> The ideal system is no dma-ranges. Is each bank at a different
> >>> relative position compared to the CPU's view of the system. That would
> >>> seem doubtful for just DRAM banks. Perhaps DRAM and SRAM could change.
> >>
> >> Is that a question ? Anyway, yes, there is a bit of DRAM below the 32bit
> >> boundary and some more above the 32bit boundary. These two banks don't
> >> need to be continuous. And then you could add the SRAM into the mix.
> > 
> > Continuous is irrelevant. My question was in more specific terms is
> > (bank1 addr - bank0 addr) different for CPU's view (i.e phys addr) vs.
> > PCI host view (i.e. bus addr)? If not, then that is 1 translation and
> > 1 dma-ranges entry.
> 
> I don't think it's different in that aspect. Except the bus has this
> 32bit limitation, where it only sees subset of the DRAM.
> 
> Why should the DMA ranges incorrectly cover also the DRAM which is not
> present ?

I think this is where there is a difference in understanding.

If I understand correctly, the job of the dma-ranges property isn't to
describe *what* ranges the PCI device can access - it's there to describe
*how*, i.e. the mapping between PCI and CPU-visible memory.

The dma-ranges property is a side-effect of how the busses are wired up
between the CPU and PCI controller - and so it doesn't matter what is or
isn't on those buses.

It's the job of other parts of the system to ensure that PCI devices are
told the correct addresses to write to, e.g. the enumerating software
referring to a valid CPU visible address correctly translated for the view
of the PCI device, ATS etc. And any IOMMU to enforce that.

It sounds like there is a 1:1 mapping between CPU and PCI - in which case
there isn't a reason for a dma-ranges.

Thanks,

Andrew Murray

> 
> >>> I suppose if your intent is to use inbound windows as a poor man's
> >>> IOMMU to prevent accesses to the holes, then yes you would list them
> >>> out. But I think that's wrong and difficult to maintain. You'd also
> >>> need to deal with reserved-memory regions too.
> >>
> >> What's the problem with that? The bootloader has all that information
> >> and can patch the DT correctly. In fact, in my specific case, I have
> >> platform which can be populated with differently sized DRAM, so the
> >> holes are also dynamically calculated ; there is no one DT then, the
> >> bootloader is responsible to generate the dma-ranges accordingly.
> > 
> > The problems are it doesn't work:
> > 
> > Your dma-mask and offset are not going to be correct.
> > 
> > You are running out of inbound windows. Your patch does nothing to
> > solve that. The solution would be merging multiple dma-ranges entries
> > to a single inbound window. We'd have to do that both for dma-mask and
> > inbound windows. The former would also have to figure out which
> > entries apply to setting up dma-mask. I'm simply suggesting just do
> > that up front and avoid any pointless splits.
> 
> But then the PCI device can trigger a transaction to non-existent DRAM
> and cause undefined behavior. Surely we do not want that ?
> 
> > You are setting up random inbound windows. The bootloader can't assume
> > what order the OS parses dma-ranges, and the OS can't assume what
> > order the bootloader writes the entries.
> 
> But the OS can assume the ranges are correct and cover only valid
> memory, right ? That is, memory into which the PCI controller can safely
> access.
> 
> -- 
> Best regards,
> Marek Vasut
