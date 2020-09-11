Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074D5265949
	for <lists+linux-pci@lfdr.de>; Fri, 11 Sep 2020 08:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725613AbgIKGZR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Sep 2020 02:25:17 -0400
Received: from verein.lst.de ([213.95.11.211]:35640 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgIKGZQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Sep 2020 02:25:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9D35867373; Fri, 11 Sep 2020 08:25:12 +0200 (CEST)
Date:   Fri, 11 Sep 2020 08:25:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-sh@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        linux-pci@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] ARM/dma-mapping: move various helpers from
 dma-mapping.h to dma-direct.h
Message-ID: <20200911062512.GC21597@lst.de>
References: <20200910054038.324517-1-hch@lst.de> <20200910054038.324517-2-hch@lst.de> <42497691-ec93-1e93-d3e5-e841eaf8247a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42497691-ec93-1e93-d3e5-e841eaf8247a@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 10, 2020 at 07:02:23PM +0100, Robin Murphy wrote:
> On 2020-09-10 06:40, Christoph Hellwig wrote:
>> Move the helpers to translate to and from direct mapping DMA addresses
>> to dma-direct.h.  This not only is the most logical place, but the new
>> placement also avoids dependency loops with pending commits.
>
> For the straightforward move as it should be,
>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>
> However I do wonder how much of this could be cleaned up further...
>> +
>> +#ifdef __arch_page_to_dma
>> +#error Please update to __arch_pfn_to_dma
>> +#endif
>
> This must be long, long dead by now.

Yeah.  I had a patch to remove this which lead me into the rabbit
hole your described later.  A few patches in I decided to give up
and just do the trivial move.  But it probably makes sense to pick
up at least the two trivial dead code removal patches..

>> +static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
>> +{
>> +	unsigned long pfn = __bus_to_pfn(addr);
>> +
>> +	if (dev)
>> +		pfn += dev->dma_pfn_offset;
>> +
>> +	return pfn;
>> +}
>
> These are only overridden for OMAP1510, and it looks like it wouldn't take 
> much for the platform code or ohci-omap driver to set up a generic DMA 
> offset for the relevant device.

I sent a ping to the omap maintainers earlier this week to ask for that :)

>> +static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
>> +{
>> +	if (dev)
>> +		return pfn_to_dma(dev, virt_to_pfn(addr));
>> +
>> +	return (dma_addr_t)__virt_to_bus((unsigned long)(addr));
>> +}
>
> And this is only used for some debug prints in dmabounce.
>
> Similarly the __bus_to_*()/__*_to_bus() calls themselves only appear 
> significant to mach-footbridge any more, and could probably also be evolved 
> into regular DMA offsets now that all API calls must have a non-NULL 
> device. I think I might come back and take a closer look at all this at 
> some point in future... :)

Yes,  pretty much all of this should eventually go away.  I just don't
want to bock the ranges work on all kinds of random arm cleanups..
