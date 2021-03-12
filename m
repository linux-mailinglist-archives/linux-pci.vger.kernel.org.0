Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E9C3395EA
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 19:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhCLSL5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 13:11:57 -0500
Received: from foss.arm.com ([217.140.110.172]:59024 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231906AbhCLSL3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Mar 2021 13:11:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D802DED1;
        Fri, 12 Mar 2021 10:11:28 -0800 (PST)
Received: from [10.57.52.136] (unknown [10.57.52.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB8E33F7D7;
        Fri, 12 Mar 2021 10:11:23 -0800 (PST)
Subject: Re: [RFC PATCH v2 06/11] dma-direct: Support PCI P2PDMA pages in
 dma-direct map_sg
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org
Cc:     Minturn Dave B <dave.b.minturn@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        Stephen Bates <sbates@raithlin.com>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Xiong Jianxin <jianxin.xiong@intel.com>
References: <20210311233142.7900-1-logang@deltatee.com>
 <20210311233142.7900-7-logang@deltatee.com>
 <215e1472-5294-d20a-a43a-ff6dfe8cd66e@arm.com>
 <d7ead722-7356-8e0f-22de-cb9dea12b556@deltatee.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <a8205c02-a43f-d4e8-a9fe-5963df3a7b40@arm.com>
Date:   Fri, 12 Mar 2021 18:11:17 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <d7ead722-7356-8e0f-22de-cb9dea12b556@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-03-12 16:24, Logan Gunthorpe wrote:
> 
> 
> On 2021-03-12 8:52 a.m., Robin Murphy wrote:
>>> +
>>>            sg->dma_address = dma_direct_map_page(dev, sg_page(sg),
>>>                    sg->offset, sg->length, dir, attrs);
>>>            if (sg->dma_address == DMA_MAPPING_ERROR)
>>> @@ -411,7 +440,7 @@ int dma_direct_map_sg(struct device *dev, struct
>>> scatterlist *sgl, int nents,
>>>      out_unmap:
>>>        dma_direct_unmap_sg(dev, sgl, i, dir, attrs |
>>> DMA_ATTR_SKIP_CPU_SYNC);
>>> -    return 0;
>>> +    return ret;
>>>    }
>>>      dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t
>>> paddr,
>>> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
>>> index b6a633679933..adc1a83950be 100644
>>> --- a/kernel/dma/mapping.c
>>> +++ b/kernel/dma/mapping.c
>>> @@ -178,8 +178,15 @@ void dma_unmap_page_attrs(struct device *dev,
>>> dma_addr_t addr, size_t size,
>>>    EXPORT_SYMBOL(dma_unmap_page_attrs);
>>>      /*
>>> - * dma_maps_sg_attrs returns 0 on error and > 0 on success.
>>> - * It should never return a value < 0.
>>> + * dma_maps_sg_attrs returns 0 on any resource error and > 0 on success.
>>> + *
>>> + * If 0 is returned, the mapping can be retried and will succeed once
>>> + * sufficient resources are available.
>>
>> That's not a guarantee we can uphold. Retrying forever in the vain hope
>> that a device might evolve some extra address bits, or a bounce buffer
>> might magically grow big enough for a gigantic mapping, isn't
>> necessarily the best idea.
> 
> Perhaps this is just poorly worded. Returning 0 is the normal case and
> nothing has changed there. The block layer, for example, will retry if
> zero is returned as this only happens if it failed to allocate resources
> for the mapping. The reason we have to return -1 is to tell the block
> layer not to retry these requests as they will never succeed in the future.
> 
>>> + *
>>> + * If there are P2PDMA pages in the scatterlist then this function may
>>> + * return -EREMOTEIO to indicate that the pages are not mappable by the
>>> + * device. In this case, an error should be returned for the IO as it
>>> + * will never be successfully retried.
>>>     */
>>>    int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int
>>> nents,
>>>            enum dma_data_direction dir, unsigned long attrs)
>>> @@ -197,7 +204,7 @@ int dma_map_sg_attrs(struct device *dev, struct
>>> scatterlist *sg, int nents,
>>>            ents = dma_direct_map_sg(dev, sg, nents, dir, attrs);
>>>        else
>>>            ents = ops->map_sg(dev, sg, nents, dir, attrs);
>>> -    BUG_ON(ents < 0);
>>> +
>>
>> This scares me - I hesitate to imagine the amount of driver/subsystem
>> code out there that will see nonzero and merrily set off iterating a
>> negative number of segments, if we open the floodgates of allowing
>> implementations to return error codes here.
> 
> Yes, but it will never happen on existing drivers/subsystems. The only
> way it can return a negative number is if the driver passes in P2PDMA
> pages which can't happen without changes in the driver. We are careful
> about where P2PDMA pages can get into so we don't have to worry about
> all the existing driver code out there.

Sure, that's how things stand immediately after this patch. But then 
someone comes along with the perfectly reasonable argument for returning 
more expressive error information for regular mapping failures as well 
(because sometimes those can be terminal too, as above), we start to get 
divergent behaviour across architectures and random bits of old code 
subtly breaking down the line. *That* is what makes me wary of making a 
fundamental change to a long-standing "nonzero means success" interface...

Robin.
