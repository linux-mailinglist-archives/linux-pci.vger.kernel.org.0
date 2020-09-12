Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8445267849
	for <lists+linux-pci@lfdr.de>; Sat, 12 Sep 2020 08:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgILGqd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Sep 2020 02:46:33 -0400
Received: from verein.lst.de ([213.95.11.211]:39013 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbgILGqc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 12 Sep 2020 02:46:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EB2A368B02; Sat, 12 Sep 2020 08:46:24 +0200 (CEST)
Date:   Sat, 12 Sep 2020 08:46:24 +0200
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
Subject: Re: [PATCH 3/3] dma-mapping: introduce DMA range map, supplanting
 dma_pfn_offset
Message-ID: <20200912064624.GA19260@lst.de>
References: <20200910054038.324517-1-hch@lst.de> <20200910054038.324517-4-hch@lst.de> <011dea58-3714-3343-c055-57228be2a450@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <011dea58-3714-3343-c055-57228be2a450@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 11, 2020 at 05:12:36PM +0100, Robin Murphy wrote:
> (apologies to Jim - I did look through one of the previous versions since I 
> last commented and thought it looked OK, but never actually replied as 
> such)
>
> On 2020-09-10 06:40, Christoph Hellwig wrote:
>> From: Jim Quinlan <james.quinlan@broadcom.com>
>>
>> The new field 'dma_range_map' in struct device is used to facilitate the
>> use of single or multiple offsets between mapping regions of cpu addrs and
>> dma addrs.  It subsumes the role of "dev->dma_pfn_offset" which was only
>> capable of holding a single uniform offset and had no region bounds
>> checking.
>>
>> The function of_dma_get_range() has been modified so that it takes a single
>> argument -- the device node -- and returns a map, NULL, or an error code.
>> The map is an array that holds the information regarding the DMA regions.
>> Each range entry contains the address offset, the cpu_start address, the
>> dma_start address, and the size of the region.
>>
>> of_dma_configure() is the typical manner to set range offsets but there are
>> a number of ad hoc assignments to "dev->dma_pfn_offset" in the kernel
>> driver code.  These cases now invoke the function
>> dma_attach_offset_range(dev, cpu_addr, dma_addr, size).
>
> This is now called dma_direct_set_offset(), right?

Yes.

>> +		int ret = dma_direct_set_offset(dev, KEYSTONE_HIGH_PHYS_START,
>> +						KEYSTONE_LOW_PHYS_START,
>> +						KEYSTONE_HIGH_PHYS_SIZE);
>> +		dev_err(dev, "set dma_offset%08llx%s\n",
>> +			KEYSTONE_HIGH_PHYS_START - KEYSTONE_LOW_PHYS_START,
>> +			ret ? " failed" : "");
>
> FWIW I've already been thinking of some optimisations which would have the 
> happy side-effect of removing many of these allocation failure scenarios, 
> but at this point I reckon it's more practical to just get the current 
> implementation landed and working.

Given that no one deals or can easily deal with these failures we
should probably take care of that.  IMHO we could just allocate a
single static range and point all the devices to it, what would
you think of that?

>>   @@ -811,8 +812,13 @@ static int sun4i_backend_bind(struct device *dev, 
>> struct device *master,
>>   		 * because of an old DT, we need to set the DMA offset by hand
>>   		 * on our device since the RAM mapping is at 0 for the DMA bus,
>>   		 * unlike the CPU.
>> +		 *
>> +		 * XXX(hch): this has no business in a driver and needs to move
>> +		 * to the device tree.
>
> As the context implies, this has actually grown a proper DT description of 
> the funky interconnect layout (see 564d6fd611f9 and the linked patch 
> series), and this is just an ugly fallback path to prevent regressions with 
> old DTBs that are already out there. So unless you can fire up the time 
> machine to fix those, this extra comment is really just beating a dead 
> horse :(

Well, I need to beat the dead horse to avoid having to export the
function, which will really just bread new users.  So at the minimum
we'd need to move the setup to platform code that is always built in.
