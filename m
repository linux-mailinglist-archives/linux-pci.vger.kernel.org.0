Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DADE63397FE
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 21:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbhCLUHY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 15:07:24 -0500
Received: from ale.deltatee.com ([204.191.154.188]:59886 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234596AbhCLUGx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Mar 2021 15:06:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=/dKXn2MTgnalq4INDTL+cUYvr798DsS+qKv7RTLo0q8=; b=da62C93BS1h63ogYf0+1s+anR6
        jE7LGT3lzTTjYIIqb+PgW/fdS/Tx6fEntgD51NJlTprHY0a60/LT/QP4Fc5Ai6ePuzSg+5NF+L6py
        nRbrs8LRxsjgEQ3bbreB2q1tcLRZSbwiR6N63c8IPAj25MKLjTff5d3tDmA5GNH69iLyo75HdTRQL
        icsGfRW5L4uGM435GQLPMFZysIjMtxvto4KAjvE2O5c0vlurrQcxvNGeRxzpZnms87a0en6OmRz0y
        4VE4+Oyatorjzq2kdC3StQcBh4Yfq+TM0mZnbCUm+7sKjhSlsjY53WT5kVLKDNyivZA8UJ6mwJmxv
        bJOEOTPw==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1lKo3U-00023x-1V; Fri, 12 Mar 2021 13:06:41 -0700
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
 <20210311233142.7900-9-logang@deltatee.com>
 <accd4187-7a9d-a8fc-f216-98ec24e3411a@arm.com>
 <45701356-ee41-1ad2-0e06-ca74af87b05a@deltatee.com>
 <76cc1c82-3cf4-92d3-992f-5c876ed30523@arm.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <6dd679b3-e38b-2c18-1990-bfc96bb4d971@deltatee.com>
Date:   Fri, 12 Mar 2021 13:06:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <76cc1c82-3cf4-92d3-992f-5c876ed30523@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: jianxin.xiong@intel.com, hch@lst.de, andrzej.jakowski@intel.com, sbates@raithlin.com, dan.j.williams@intel.com, daniel.vetter@ffwll.ch, jason@jlekstrand.net, jgg@ziepe.ca, christian.koenig@amd.com, willy@infradead.org, iweiny@intel.com, dave.hansen@linux.intel.com, jhubbard@nvidia.com, dave.b.minturn@intel.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, robin.murphy@arm.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [RFC PATCH v2 08/11] iommu/dma: Support PCI P2PDMA pages in
 dma-iommu map_sg
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-03-12 12:47 p.m., Robin Murphy wrote:
>>>>    {
>>>>        struct scatterlist *s, *cur = sg;
>>>>        unsigned long seg_mask = dma_get_seg_boundary(dev);
>>>> @@ -864,6 +865,20 @@ static int __finalise_sg(struct device *dev,
>>>> struct scatterlist *sg, int nents,
>>>>            sg_dma_address(s) = DMA_MAPPING_ERROR;
>>>>            sg_dma_len(s) = 0;
>>>>    +        if (is_pci_p2pdma_page(sg_page(s)) && !s_iova_len) {
>>>> +            if (i > 0)
>>>> +                cur = sg_next(cur);
>>>> +
>>>> +            sg_dma_address(cur) = sg_phys(s) + s->offset -
>>>
>>> Are you sure about that? ;)
>>
>> Do you see a bug? I don't follow you...
> 
> sg_phys() already accounts for the offset, so you're adding it twice.

Ah, oops. Nice catch. I missed that.

> 
>>>> +                pci_p2pdma_bus_offset(sg_page(s));
>>>
>>> Can the bus offset make P2P addresses overlap with regions of mem space
>>> that we might use for regular IOVA allocation? That would be very bad...
>>
>> No. IOMMU drivers already disallow all PCI addresses from being used as
>> IOVA addresses. See, for example,  dmar_init_reserved_ranges(). It would
>> be a huge problem for a whole lot of other reasons if it didn't.
> 
> I know we reserve the outbound windows (largely *because* some host 
> bridges will consider those addresses as attempts at unsupported P2P and 
> prevent them working), I just wanted to confirm that this bus offset is 
> always something small that stays within the relevant window, rather 
> than something that might make a BAR appear in a completely different 
> place for P2P purposes. If so, that's good.

Yes, well if an IOVA overlaps with any PCI bus address there's going to 
be some difficult brokenness because when the IOVA is used it might be 
directed to the a PCI device and not the IOMMU. I fixed a bug like that 
once.
>>> I'm not really thrilled about the idea of passing zero-length segments
>>> to iommu_map_sg(). Yes, it happens to trick the concatenation logic in
>>> the current implementation into doing what you want, but it feels 
>>> fragile.
>>
>> We're not passing zero length segments to iommu_map_sg() (or any
>> function). This loop is just scanning to calculate the length of the
>> required IOVA. __finalise_sg() (which is intimately tied to this loop)
>> then needs a way to determine which segments were P2P segments. The
>> existing code already overwrites s->length with an aligned length and
>> stores the original length in sg_dma_len. So we're not relying on
>> tricking any logic here.
> 
> Yes, we temporarily shuffle in page-aligned quantities to satisfy the 
> needs of the iommu_map_sg() call, before unpacking things again in 
> __finalise_sg(). It's some disgusting trickery that I'm particularly 
> proud of. My point is that if you have a mix of both p2p and normal 
> segments - which seems to be a case you want to support - then the 
> length of 0 that you set to flag p2p segments here will be seen by 
> iommu_map_sg() (as it walks the list to map the other segments) before 
> you then use it as a key to override the DMA address in the final step. 
> It's not a concern if you have a p2p-only list and short-circuit 
> straight to that step (in which case all the shuffling was wasted effort 
> anyway), but since it's not entirely clear what a segment with zero 
> length would mean in general, it seems like a good idea to avoid passing 
> the list across a public boundary in that state, if possible.

Ok, well, I mean the iommu_map_sg() does the right thing as is without 
changing it and IMO sg->length set to zero does make sense. Supporting 
mixed P2P and normal segments is really the whole point of this series 
(the current kernel supports homogeneous SGLs with a specialized path -- 
see pci_p2pdma_unmap_sg_attrs()). But do you have an alternate solution 
for sg->length?

Logan
