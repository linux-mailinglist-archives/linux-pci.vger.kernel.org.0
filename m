Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83BDE339445
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 18:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbhCLREM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 12:04:12 -0500
Received: from ale.deltatee.com ([204.191.154.188]:42248 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbhCLRDz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Mar 2021 12:03:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=V/VslKJywQsa+B9YAC8dghP1OO6CVmZUKXpLzW4pIhQ=; b=hvIdFq2DAqZRf+jqWidcKj23gK
        25AAfGpLmwIThDbmmZoRtxX0b8MWQN1I83BkIkCfG35j4ZNKIf8B6ZTZ/jgdT003ovN4T5xlZVcsy
        jMqI7v7ZgfNyjIK9Y3gz/UFDtQLfV2L/5OTBbVO+4EeCF29eUe/Xs8yA4hGkodsUWqZMHjl9ObvbT
        UlWR/0K94BQ0t2VXgd4rlsJO1VCweVLuaREQlx4mCqN1D2xxRvOOd5SQUMQBcFk3W6Kuukq0HeoG5
        sUeZeX9ISQJYUCc+e8SQ1CtaHLsHhzcptg5958i8F1nX8awDpGpn036mCjZazwTrRxyKMG3rEht3H
        HLX9E1fA==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1lKlCO-0007pn-Nb; Fri, 12 Mar 2021 10:03:41 -0700
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
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <45701356-ee41-1ad2-0e06-ca74af87b05a@deltatee.com>
Date:   Fri, 12 Mar 2021 10:03:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <accd4187-7a9d-a8fc-f216-98ec24e3411a@arm.com>
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
Subject: Re: [RFC PATCH v2 08/11] iommu/dma: Support PCI P2PDMA pages in
 dma-iommu map_sg
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-03-12 8:52 a.m., Robin Murphy wrote:
> On 2021-03-11 23:31, Logan Gunthorpe wrote:
>> When a PCI P2PDMA page is seen, set the IOVA length of the segment
>> to zero so that it is not mapped into the IOVA. Then, in finalise_sg(),
>> apply the appropriate bus address to the segment. The IOVA is not
>> created if the scatterlist only consists of P2PDMA pages.
> 
> This misled me at first, but I see the implementation does actually
> appear to accomodate the case of working ACS where P2P *would* still
> need to be mapped at the IOMMU.

Yes, that's correct.
>>   static int __finalise_sg(struct device *dev, struct scatterlist *sg,
>> int nents,
>> -        dma_addr_t dma_addr)
>> +        dma_addr_t dma_addr, unsigned long attrs)
>>   {
>>       struct scatterlist *s, *cur = sg;
>>       unsigned long seg_mask = dma_get_seg_boundary(dev);
>> @@ -864,6 +865,20 @@ static int __finalise_sg(struct device *dev,
>> struct scatterlist *sg, int nents,
>>           sg_dma_address(s) = DMA_MAPPING_ERROR;
>>           sg_dma_len(s) = 0;
>>   +        if (is_pci_p2pdma_page(sg_page(s)) && !s_iova_len) {
>> +            if (i > 0)
>> +                cur = sg_next(cur);
>> +
>> +            sg_dma_address(cur) = sg_phys(s) + s->offset -
> 
> Are you sure about that? ;)

Do you see a bug? I don't follow you...

>> +                pci_p2pdma_bus_offset(sg_page(s));
> 
> Can the bus offset make P2P addresses overlap with regions of mem space
> that we might use for regular IOVA allocation? That would be very bad...

No. IOMMU drivers already disallow all PCI addresses from being used as
IOVA addresses. See, for example,  dmar_init_reserved_ranges(). It would
be a huge problem for a whole lot of other reasons if it didn't.


>> @@ -960,11 +975,12 @@ static int iommu_dma_map_sg(struct device *dev,
>> struct scatterlist *sg,
>>       struct iommu_dma_cookie *cookie = domain->iova_cookie;
>>       struct iova_domain *iovad = &cookie->iovad;
>>       struct scatterlist *s, *prev = NULL;
>> +    struct dev_pagemap *pgmap = NULL;
>>       int prot = dma_info_to_prot(dir, dev_is_dma_coherent(dev), attrs);
>>       dma_addr_t iova;
>>       size_t iova_len = 0;
>>       unsigned long mask = dma_get_seg_boundary(dev);
>> -    int i;
>> +    int i, map = -1, ret = 0;
>>         if (static_branch_unlikely(&iommu_deferred_attach_enabled) &&
>>           iommu_deferred_attach(dev, domain))
>> @@ -993,6 +1009,23 @@ static int iommu_dma_map_sg(struct device *dev,
>> struct scatterlist *sg,
>>           s_length = iova_align(iovad, s_length + s_iova_off);
>>           s->length = s_length;
>>   +        if (is_pci_p2pdma_page(sg_page(s))) {
>> +            if (sg_page(s)->pgmap != pgmap) {
>> +                pgmap = sg_page(s)->pgmap;
>> +                map = pci_p2pdma_dma_map_type(dev, pgmap);
>> +            }
>> +
>> +            if (map < 0) {
> 
> It rather feels like it should be the job of whoever creates the list in
> the first place not to put unusable pages in it, especially since the
> p2pdma_map_type looks to be a fairly coarse-grained and static thing.
> The DMA API isn't responsible for validating normal memory pages, so
> what makes P2P special?

Yes, that would be ideal, but there's some difficulties there. For the
driver to check the pages, it would need to loop through the entire SG
one more time on every transaction, regardless of whether there are
P2PDMA pages, or not. So that will have a performance impact even when
the feature isn't being used. I don't think that'll be acceptable for
many drivers.

The other possibility is for GUP to do it when it gets the pages from
userspace. But GUP doesn't have all the information to do this at the
moment. We'd have to pass the struct device that will eventually map the
pages through all the nested functions in the GUP to do that test at
that time. This might not be a bad option (that I half looked into), but
I'm not sure how acceptable it would be to the GUP developers.

But even if we do verify the pages ahead of time, we still need the same
infrastructure in dma_map_sg(); it could only now be a BUG if the driver
sent invalid pages instead of an error return.

>> +                ret = -EREMOTEIO;
>> +                goto out_restore_sg;
>> +            }
>> +
>> +            if (map) {
>> +                s->length = 0;
> 
> I'm not really thrilled about the idea of passing zero-length segments
> to iommu_map_sg(). Yes, it happens to trick the concatenation logic in
> the current implementation into doing what you want, but it feels fragile.

We're not passing zero length segments to iommu_map_sg() (or any
function). This loop is just scanning to calculate the length of the
required IOVA. __finalise_sg() (which is intimately tied to this loop)
then needs a way to determine which segments were P2P segments. The
existing code already overwrites s->length with an aligned length and
stores the original length in sg_dma_len. So we're not relying on
tricking any logic here.


>>   }
>>     static void iommu_dma_unmap_sg(struct device *dev, struct
>> scatterlist *sg,
>>           int nents, enum dma_data_direction dir, unsigned long attrs)
>>   {
>> -    dma_addr_t start, end;
>> +    dma_addr_t end, start = DMA_MAPPING_ERROR;
>>       struct scatterlist *tmp;
>>       int i;
>>   @@ -1054,14 +1090,20 @@ static void iommu_dma_unmap_sg(struct device
>> *dev, struct scatterlist *sg,
>>        * The scatterlist segments are mapped into a single
>>        * contiguous IOVA allocation, so this is incredibly easy.
>>        */
>> -    start = sg_dma_address(sg);
>> -    for_each_sg(sg_next(sg), tmp, nents - 1, i) {
>> +    for_each_sg(sg, tmp, nents, i) {
>> +        if (sg_is_pci_p2pdma(tmp))
> 
> Since the flag is associated with the DMA address which will no longer
> be valid, shouldn't it be cleared? The circumstances in which leaving it
> around could cause a problem are tenuous, but definitely possible.

Yes, that's a good idea.

Thanks for the review!

Logan
