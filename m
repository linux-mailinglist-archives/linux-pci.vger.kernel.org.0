Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D653397B6
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 20:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbhCLTrn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 14:47:43 -0500
Received: from foss.arm.com ([217.140.110.172]:59856 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234524AbhCLTrS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Mar 2021 14:47:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20D92ED1;
        Fri, 12 Mar 2021 11:47:18 -0800 (PST)
Received: from [10.57.52.136] (unknown [10.57.52.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA35E3F793;
        Fri, 12 Mar 2021 11:47:13 -0800 (PST)
Subject: Re: [RFC PATCH v2 08/11] iommu/dma: Support PCI P2PDMA pages in
 dma-iommu map_sg
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org
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
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <76cc1c82-3cf4-92d3-992f-5c876ed30523@arm.com>
Date:   Fri, 12 Mar 2021 19:47:08 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <45701356-ee41-1ad2-0e06-ca74af87b05a@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-03-12 17:03, Logan Gunthorpe wrote:
> 
> 
> On 2021-03-12 8:52 a.m., Robin Murphy wrote:
>> On 2021-03-11 23:31, Logan Gunthorpe wrote:
>>> When a PCI P2PDMA page is seen, set the IOVA length of the segment
>>> to zero so that it is not mapped into the IOVA. Then, in finalise_sg(),
>>> apply the appropriate bus address to the segment. The IOVA is not
>>> created if the scatterlist only consists of P2PDMA pages.
>>
>> This misled me at first, but I see the implementation does actually
>> appear to accomodate the case of working ACS where P2P *would* still
>> need to be mapped at the IOMMU.
> 
> Yes, that's correct.
>>>    static int __finalise_sg(struct device *dev, struct scatterlist *sg,
>>> int nents,
>>> -        dma_addr_t dma_addr)
>>> +        dma_addr_t dma_addr, unsigned long attrs)
>>>    {
>>>        struct scatterlist *s, *cur = sg;
>>>        unsigned long seg_mask = dma_get_seg_boundary(dev);
>>> @@ -864,6 +865,20 @@ static int __finalise_sg(struct device *dev,
>>> struct scatterlist *sg, int nents,
>>>            sg_dma_address(s) = DMA_MAPPING_ERROR;
>>>            sg_dma_len(s) = 0;
>>>    +        if (is_pci_p2pdma_page(sg_page(s)) && !s_iova_len) {
>>> +            if (i > 0)
>>> +                cur = sg_next(cur);
>>> +
>>> +            sg_dma_address(cur) = sg_phys(s) + s->offset -
>>
>> Are you sure about that? ;)
> 
> Do you see a bug? I don't follow you...

sg_phys() already accounts for the offset, so you're adding it twice.

>>> +                pci_p2pdma_bus_offset(sg_page(s));
>>
>> Can the bus offset make P2P addresses overlap with regions of mem space
>> that we might use for regular IOVA allocation? That would be very bad...
> 
> No. IOMMU drivers already disallow all PCI addresses from being used as
> IOVA addresses. See, for example,  dmar_init_reserved_ranges(). It would
> be a huge problem for a whole lot of other reasons if it didn't.

I know we reserve the outbound windows (largely *because* some host 
bridges will consider those addresses as attempts at unsupported P2P and 
prevent them working), I just wanted to confirm that this bus offset is 
always something small that stays within the relevant window, rather 
than something that might make a BAR appear in a completely different 
place for P2P purposes. If so, that's good.

>>> @@ -960,11 +975,12 @@ static int iommu_dma_map_sg(struct device *dev,
>>> struct scatterlist *sg,
>>>        struct iommu_dma_cookie *cookie = domain->iova_cookie;
>>>        struct iova_domain *iovad = &cookie->iovad;
>>>        struct scatterlist *s, *prev = NULL;
>>> +    struct dev_pagemap *pgmap = NULL;
>>>        int prot = dma_info_to_prot(dir, dev_is_dma_coherent(dev), attrs);
>>>        dma_addr_t iova;
>>>        size_t iova_len = 0;
>>>        unsigned long mask = dma_get_seg_boundary(dev);
>>> -    int i;
>>> +    int i, map = -1, ret = 0;
>>>          if (static_branch_unlikely(&iommu_deferred_attach_enabled) &&
>>>            iommu_deferred_attach(dev, domain))
>>> @@ -993,6 +1009,23 @@ static int iommu_dma_map_sg(struct device *dev,
>>> struct scatterlist *sg,
>>>            s_length = iova_align(iovad, s_length + s_iova_off);
>>>            s->length = s_length;
>>>    +        if (is_pci_p2pdma_page(sg_page(s))) {
>>> +            if (sg_page(s)->pgmap != pgmap) {
>>> +                pgmap = sg_page(s)->pgmap;
>>> +                map = pci_p2pdma_dma_map_type(dev, pgmap);
>>> +            }
>>> +
>>> +            if (map < 0) {
>>
>> It rather feels like it should be the job of whoever creates the list in
>> the first place not to put unusable pages in it, especially since the
>> p2pdma_map_type looks to be a fairly coarse-grained and static thing.
>> The DMA API isn't responsible for validating normal memory pages, so
>> what makes P2P special?
> 
> Yes, that would be ideal, but there's some difficulties there. For the
> driver to check the pages, it would need to loop through the entire SG
> one more time on every transaction, regardless of whether there are
> P2PDMA pages, or not. So that will have a performance impact even when
> the feature isn't being used. I don't think that'll be acceptable for
> many drivers.
> 
> The other possibility is for GUP to do it when it gets the pages from
> userspace. But GUP doesn't have all the information to do this at the
> moment. We'd have to pass the struct device that will eventually map the
> pages through all the nested functions in the GUP to do that test at
> that time. This might not be a bad option (that I half looked into), but
> I'm not sure how acceptable it would be to the GUP developers.

Urgh, yes, if a page may or may not be valid for p2p depending on which 
device is trying to map it, then it probably is most reasonable to 
figure that out at this point. It's a little unfortunate having to cope 
with failure so late, but oh well.

> But even if we do verify the pages ahead of time, we still need the same
> infrastructure in dma_map_sg(); it could only now be a BUG if the driver
> sent invalid pages instead of an error return.

The hope was that we could save doing even that - e.g. if you pass a 
dodgy page into dma_map_page(), maybe page_to_phys() will crash, maybe 
you'll just end up with a DMA address that won't work, but either way it 
doesn't care in its own right - but it seems that's moot.

>>> +                ret = -EREMOTEIO;
>>> +                goto out_restore_sg;
>>> +            }
>>> +
>>> +            if (map) {
>>> +                s->length = 0;
>>
>> I'm not really thrilled about the idea of passing zero-length segments
>> to iommu_map_sg(). Yes, it happens to trick the concatenation logic in
>> the current implementation into doing what you want, but it feels fragile.
> 
> We're not passing zero length segments to iommu_map_sg() (or any
> function). This loop is just scanning to calculate the length of the
> required IOVA. __finalise_sg() (which is intimately tied to this loop)
> then needs a way to determine which segments were P2P segments. The
> existing code already overwrites s->length with an aligned length and
> stores the original length in sg_dma_len. So we're not relying on
> tricking any logic here.

Yes, we temporarily shuffle in page-aligned quantities to satisfy the 
needs of the iommu_map_sg() call, before unpacking things again in 
__finalise_sg(). It's some disgusting trickery that I'm particularly 
proud of. My point is that if you have a mix of both p2p and normal 
segments - which seems to be a case you want to support - then the 
length of 0 that you set to flag p2p segments here will be seen by 
iommu_map_sg() (as it walks the list to map the other segments) before 
you then use it as a key to override the DMA address in the final step. 
It's not a concern if you have a p2p-only list and short-circuit 
straight to that step (in which case all the shuffling was wasted effort 
anyway), but since it's not entirely clear what a segment with zero 
length would mean in general, it seems like a good idea to avoid passing 
the list across a public boundary in that state, if possible.

Robin.

>>>    }
>>>      static void iommu_dma_unmap_sg(struct device *dev, struct
>>> scatterlist *sg,
>>>            int nents, enum dma_data_direction dir, unsigned long attrs)
>>>    {
>>> -    dma_addr_t start, end;
>>> +    dma_addr_t end, start = DMA_MAPPING_ERROR;
>>>        struct scatterlist *tmp;
>>>        int i;
>>>    @@ -1054,14 +1090,20 @@ static void iommu_dma_unmap_sg(struct device
>>> *dev, struct scatterlist *sg,
>>>         * The scatterlist segments are mapped into a single
>>>         * contiguous IOVA allocation, so this is incredibly easy.
>>>         */
>>> -    start = sg_dma_address(sg);
>>> -    for_each_sg(sg_next(sg), tmp, nents - 1, i) {
>>> +    for_each_sg(sg, tmp, nents, i) {
>>> +        if (sg_is_pci_p2pdma(tmp))
>>
>> Since the flag is associated with the DMA address which will no longer
>> be valid, shouldn't it be cleared? The circumstances in which leaving it
>> around could cause a problem are tenuous, but definitely possible.
> 
> Yes, that's a good idea.
> 
> Thanks for the review!
> 
> Logan
> 
