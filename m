Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F96537AC0C
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 18:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhEKQg4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 12:36:56 -0400
Received: from ale.deltatee.com ([204.191.154.188]:54682 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhEKQg4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 12:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=069DpYy4tqGAUWXxeulYoTNkovf/OMYcYeYg3ZMGXCs=; b=fqIGHAu2ydIVFuAMCV/+TIPbr3
        GDcSxLN3CTaD2jVFik2/89QVm6vrlQPFkQBcyFrq7IoPsou7gFYK6YhKVKc357IMSk7Z/UgqrKU/5
        yfqjxHkpm5j2ugNHp6v8blzG9SUzsYA4jFnTbzpvWVr8tU/p58UdEfAVVCbALieeoLmyf9t1z1jIj
        cFfcErE9gm+f8/IHn3DnyO31qAcnU5u8RebXKF0WzUXBViYSzhq77g2Pot/qGbcUnoA31Q2CxmJpy
        x5S7LiQUO7YR5JYPWhkPnrHy3kSZqCTGziqhXHss2s2uaUl3zPWRhHT1WHlq0S0bZGpLLh4SgWmKo
        qG6idSaA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1lgVMA-0006xp-A6; Tue, 11 May 2021 10:35:39 -0600
To:     Don Dutile <ddutile@redhat.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-12-logang@deltatee.com>
 <6003ed3d-5969-4201-3cbb-3bcf84385541@redhat.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <a8cad1ee-57c6-44ef-2539-499c13c66b5f@deltatee.com>
Date:   Tue, 11 May 2021 10:35:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <6003ed3d-5969-4201-3cbb-3bcf84385541@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, jhubbard@nvidia.com, christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, ddutile@redhat.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE,NICE_REPLY_A autolearn=ham
        autolearn_force=no version=3.4.2
Subject: Re: [PATCH 11/16] iommu/dma: Support PCI P2PDMA pages in dma-iommu
 map_sg
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-05-11 10:06 a.m., Don Dutile wrote:
> On 4/8/21 1:01 PM, Logan Gunthorpe wrote:
>> When a PCI P2PDMA page is seen, set the IOVA length of the segment
>> to zero so that it is not mapped into the IOVA. Then, in finalise_sg(),
>> apply the appropriate bus address to the segment. The IOVA is not
>> created if the scatterlist only consists of P2PDMA pages.
>>
>> Similar to dma-direct, the sg_mark_pci_p2pdma() flag is used to
>> indicate bus address segments. On unmap, P2PDMA segments are skipped
>> over when determining the start and end IOVA addresses.
>>
>> With this change, the flags variable in the dma_map_ops is
>> set to DMA_F_PCI_P2PDMA_SUPPORTED to indicate support for
>> P2PDMA pages.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> So, this code prevents use of p2pdma using an IOMMU, which wasn't checked and
> short-circuited by other checks to use dma-direct?

No, not at all. This patch is adding support for p2pdma pages for IOMMUs
that use the dma-iommu abstraction. Other arch specific IOMMUs that
don't use the dma-iommu abstraction are left unsupported. Support would
need to be added to them, or better yet; they should be ported to dma-iommu.

> 
> So my overall comment to this code & related comments is that it should be sprinkled
> with notes like "doesn't support IOMMU" and / or "TODO" when/if IOMMU is to be supported.
> Or, if IOMMU-based p2pdma isn't supported in these routines directly, where/how they will be supported?
> 
>> ---
>>   drivers/iommu/dma-iommu.c | 66 ++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 58 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index af765c813cc8..ef49635f9819 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -20,6 +20,7 @@
>>   #include <linux/mm.h>
>>   #include <linux/mutex.h>
>>   #include <linux/pci.h>
>> +#include <linux/pci-p2pdma.h>
>>   #include <linux/swiotlb.h>
>>   #include <linux/scatterlist.h>
>>   #include <linux/vmalloc.h>
>> @@ -864,6 +865,16 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
>>   		sg_dma_address(s) = DMA_MAPPING_ERROR;
>>   		sg_dma_len(s) = 0;
>>   
>> +		if (is_pci_p2pdma_page(sg_page(s)) && !s_iova_len) {
>> +			if (i > 0)
>> +				cur = sg_next(cur);
>> +
>> +			pci_p2pdma_map_bus_segment(s, cur);
>> +			count++;
>> +			cur_len = 0;
>> +			continue;
>> +		}
>> +
>>   		/*
>>   		 * Now fill in the real DMA data. If...
>>   		 * - there is a valid output segment to append to
>> @@ -961,10 +972,12 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>>   	struct iova_domain *iovad = &cookie->iovad;
>>   	struct scatterlist *s, *prev = NULL;
>>   	int prot = dma_info_to_prot(dir, dev_is_dma_coherent(dev), attrs);
>> +	struct dev_pagemap *pgmap = NULL;
>> +	enum pci_p2pdma_map_type map_type;
>>   	dma_addr_t iova;
>>   	size_t iova_len = 0;
>>   	unsigned long mask = dma_get_seg_boundary(dev);
>> -	int i;
>> +	int i, ret = 0;
>>   
>>   	if (static_branch_unlikely(&iommu_deferred_attach_enabled) &&
>>   	    iommu_deferred_attach(dev, domain))
>> @@ -993,6 +1006,31 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>>   		s_length = iova_align(iovad, s_length + s_iova_off);
>>   		s->length = s_length;
>>   
>> +		if (is_pci_p2pdma_page(sg_page(s))) {
>> +			if (sg_page(s)->pgmap != pgmap) {
>> +				pgmap = sg_page(s)->pgmap;
>> +				map_type = pci_p2pdma_map_type(pgmap, dev,
>> +							       attrs);
>> +			}
>> +
>> +			switch (map_type) {
>> +			case PCI_P2PDMA_MAP_BUS_ADDR:
>> +				/*
>> +				 * A zero length will be ignored by
>> +				 * iommu_map_sg() and then can be detected
>> +				 * in __finalise_sg() to actually map the
>> +				 * bus address.
>> +				 */
>> +				s->length = 0;
>> +				continue;
> 
>> +			case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
>> +				break;
> So, this 'short-circuits' the use of the IOMMU, silently?
> This seems ripe for users to enable IOMMU for secure computing reasons, and using/enabling p2pdma,
> and not realizing that it isn't as secure as 1+1=2  appears to be.
> If my understanding is wrong, please point me to the Documentation or code that corrects this mis-understanding.  I could have missed a warning when both are enabled in a past patch set.


Yes, you've misunderstood this. Part of this dovetails with your comment
about the documentation for PCI_P2PDMA_MAP_THRU_HOST_BRIDGE.

This does not short circuit the IOMMU in any way. THRU_HOST_BRIDGE mode
means the TLPs for this transaction will hit the CPU/HOST BRIDGE and
thus the IOMMU has to be involved. In this case the IOMMU is programmed
with the physical address of the memory (which is normal) and everything
works.

One could argue the PCI_P2PDMA_MAP_BUS_ADDR is short circuiting the
IOMMU by using PCI bus address in the DMA transaction. But this requires
the user to do special setup with the ACS bits ahead of time (not part
of this series).

For the user to use the BUS_ADDR with an IOMMU, they need to
specifically disable the ACS redirect bits on specific PCI switch bridge
ports using a kernel command line option. When they do this, the IOMMU
code will put those devices in the same IOMMU group thus making it
impossible for the user to use devices that can do P2PDMA transactions
together in different security domains.

This was all hashed out in the original P2PDMA patchset and does make sense.

>> +			default:
>> +				ret = -EREMOTEIO;
>> +				goto out_restore_sg;
>> +			}
>> +		}
>> +
>>   		/*
>>   		 * Due to the alignment of our single IOVA allocation, we can
>>   		 * depend on these assumptions about the segment boundary mask:
>> @@ -1015,6 +1053,9 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>>   		prev = s;
>>   	}
>>   
>> +	if (!iova_len)
>> +		return __finalise_sg(dev, sg, nents, 0);
>> +
>>   	iova = iommu_dma_alloc_iova(domain, iova_len, dma_get_mask(dev), dev);
>>   	if (!iova)
>>   		goto out_restore_sg;
>> @@ -1032,13 +1073,13 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>>   	iommu_dma_free_iova(cookie, iova, iova_len, NULL);
>>   out_restore_sg:
>>   	__invalidate_sg(sg, nents);
>> -	return 0;
>> +	return ret;
>>   }
>>   
>>   static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
>>   		int nents, enum dma_data_direction dir, unsigned long attrs)
>>   {
>> -	dma_addr_t start, end;
>> +	dma_addr_t end, start = DMA_MAPPING_ERROR;
>>   	struct scatterlist *tmp;
>>   	int i;
>>   
>> @@ -1054,14 +1095,22 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
>>   	 * The scatterlist segments are mapped into a single
>>   	 * contiguous IOVA allocation, so this is incredibly easy.
>>   	 */
>> -	start = sg_dma_address(sg);
>> -	for_each_sg(sg_next(sg), tmp, nents - 1, i) {
>> +	for_each_sg(sg, tmp, nents, i) {
>> +		if (sg_is_pci_p2pdma(tmp)) {
>> +			sg_unmark_pci_p2pdma(tmp);
>> +			continue;
>> +		}
>>   		if (sg_dma_len(tmp) == 0)
>>   			break;
>> -		sg = tmp;
>> +
>> +		if (start == DMA_MAPPING_ERROR)
>> +			start = sg_dma_address(tmp);
>> +
>> +		end = sg_dma_address(tmp) + sg_dma_len(tmp);
>>   	}
>> -	end = sg_dma_address(sg) + sg_dma_len(sg);
>> -	__iommu_dma_unmap(dev, start, end - start);
>> +
>> +	if (start != DMA_MAPPING_ERROR)
>> +		__iommu_dma_unmap(dev, start, end - start);
>>   }
>>   
> overall, fiddling with the generic dma-iommu code instead of using a dma-ops-based, p2pdma function that has it carved out and separated/refactored out to be cleaner seems less complicated, but I'm guessing you tried that and it was too complicated to do?

I don't think you've understood this code correctly. What it does can't
be done in the dma-ops.

>>   static const struct dma_map_ops iommu_dma_ops = {
>> +	.flags			= DMA_F_PCI_P2PDMA_SUPPORTED,
> wait, it's a const that's always turned on?
> shouldn't the define for this flag be 0 for non-p2pdma configs?

All this flag is saying is that iommu_dma_map_sg() has support for
handling P2PDMA pages. Yes this is a const. The point is to reject it
for map_sg implementations that have not done the above work (ie.
arm_iommu_map_sg).

Hopefully, more of the arch-specific implementations will convert to the
generic dma-iommu code in time but those that don't simply won't support
P2PDMA until they do (or add their own support).

Logan
