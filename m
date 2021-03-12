Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD410339333
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 17:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbhCLQZe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 11:25:34 -0500
Received: from ale.deltatee.com ([204.191.154.188]:46686 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbhCLQZI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Mar 2021 11:25:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=z71Dy4S8XtDaYoM2XRkuE2wAHe2/+OE53EIe7Kw+TNU=; b=HqXLStXu7JHag3wGbK3mOgF/M8
        gsYjKlyGMCNs6Kp2trWSjJWEdoTTL7l0upjMGEke4ssz2qv6SN3QkQZ8mcg+a143IC5xIOM3SURoN
        lw4HuqO4LhNWzh1WAKj6/9SxZhr2mvmmvBMwjW/oqcvFMPefmD+CQ/sZD2cfS3DQ9XdARnulhX379
        XEmUxtLccrt+N+K+iBiVDqkj/U2P4KyQUA3p6kqQsHQwLLUNipLb7OSQ8YfLEh8+nzalEco/na8NL
        WnrW6BHAXcHt9X8Oyt7VfthZmCHT2QggtvHtaFRpzf4jqY5LDY0Xy1Vgj3qD6rJy+XfYFYP5DTIA3
        2H01sjhg==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1lKkar-0007E2-BR; Fri, 12 Mar 2021 09:24:54 -0700
To:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org
Cc:     Minturn Dave B <dave.b.minturn@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ira Weiny <iweiny@intel.com>,
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
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d7ead722-7356-8e0f-22de-cb9dea12b556@deltatee.com>
Date:   Fri, 12 Mar 2021 09:24:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <215e1472-5294-d20a-a43a-ff6dfe8cd66e@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: jianxin.xiong@intel.com, hch@lst.de, andrzej.jakowski@intel.com, sbates@raithlin.com, dan.j.williams@intel.com, daniel.vetter@ffwll.ch, jason@jlekstrand.net, jgg@ziepe.ca, christian.koenig@amd.com, willy@infradead.org, iweiny@intel.com, dave.hansen@linux.intel.com, jhubbard@nvidia.com, dave.b.minturn@intel.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, robin.murphy@arm.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [RFC PATCH v2 06/11] dma-direct: Support PCI P2PDMA pages in
 dma-direct map_sg
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-03-12 8:52 a.m., Robin Murphy wrote:
>> +
>>           sg->dma_address = dma_direct_map_page(dev, sg_page(sg),
>>                   sg->offset, sg->length, dir, attrs);
>>           if (sg->dma_address == DMA_MAPPING_ERROR)
>> @@ -411,7 +440,7 @@ int dma_direct_map_sg(struct device *dev, struct
>> scatterlist *sgl, int nents,
>>     out_unmap:
>>       dma_direct_unmap_sg(dev, sgl, i, dir, attrs |
>> DMA_ATTR_SKIP_CPU_SYNC);
>> -    return 0;
>> +    return ret;
>>   }
>>     dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t
>> paddr,
>> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
>> index b6a633679933..adc1a83950be 100644
>> --- a/kernel/dma/mapping.c
>> +++ b/kernel/dma/mapping.c
>> @@ -178,8 +178,15 @@ void dma_unmap_page_attrs(struct device *dev,
>> dma_addr_t addr, size_t size,
>>   EXPORT_SYMBOL(dma_unmap_page_attrs);
>>     /*
>> - * dma_maps_sg_attrs returns 0 on error and > 0 on success.
>> - * It should never return a value < 0.
>> + * dma_maps_sg_attrs returns 0 on any resource error and > 0 on success.
>> + *
>> + * If 0 is returned, the mapping can be retried and will succeed once
>> + * sufficient resources are available.
> 
> That's not a guarantee we can uphold. Retrying forever in the vain hope
> that a device might evolve some extra address bits, or a bounce buffer
> might magically grow big enough for a gigantic mapping, isn't
> necessarily the best idea.

Perhaps this is just poorly worded. Returning 0 is the normal case and
nothing has changed there. The block layer, for example, will retry if
zero is returned as this only happens if it failed to allocate resources
for the mapping. The reason we have to return -1 is to tell the block
layer not to retry these requests as they will never succeed in the future.

>> + *
>> + * If there are P2PDMA pages in the scatterlist then this function may
>> + * return -EREMOTEIO to indicate that the pages are not mappable by the
>> + * device. In this case, an error should be returned for the IO as it
>> + * will never be successfully retried.
>>    */
>>   int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int
>> nents,
>>           enum dma_data_direction dir, unsigned long attrs)
>> @@ -197,7 +204,7 @@ int dma_map_sg_attrs(struct device *dev, struct
>> scatterlist *sg, int nents,
>>           ents = dma_direct_map_sg(dev, sg, nents, dir, attrs);
>>       else
>>           ents = ops->map_sg(dev, sg, nents, dir, attrs);
>> -    BUG_ON(ents < 0);
>> +
> 
> This scares me - I hesitate to imagine the amount of driver/subsystem
> code out there that will see nonzero and merrily set off iterating a
> negative number of segments, if we open the floodgates of allowing
> implementations to return error codes here.

Yes, but it will never happen on existing drivers/subsystems. The only
way it can return a negative number is if the driver passes in P2PDMA
pages which can't happen without changes in the driver. We are careful
about where P2PDMA pages can get into so we don't have to worry about
all the existing driver code out there.

Logan
