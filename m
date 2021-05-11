Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817EE37AB77
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 18:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhEKQHp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 12:07:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29330 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231867AbhEKQHo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 12:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620749197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XlWkZqQiA2f5P4YJIi6pLOwt0E2ferRdHsdF7okprNw=;
        b=TQ3yA/GBinwqYmKISS29ySeO+37+jjJAjW+Bf7DQXYRUNjdsaJww+R2fn+US9fgOD7jpBn
        ocTN/a0aYFkGlWztQ7Y1zt5wTSgqRqO1iTKfaWTLcvPrItmi/iFZ91Z5h+SlNdiDaIjYqt
        qLsK6/tv8TO+fhBDhV52SKRhnXerwT8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-cvtx_Gq3PWCfd3WMcpPXKw-1; Tue, 11 May 2021 12:06:33 -0400
X-MC-Unique: cvtx_Gq3PWCfd3WMcpPXKw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48C60800D62;
        Tue, 11 May 2021 16:06:31 +0000 (UTC)
Received: from [10.3.115.19] (ovpn-115-19.phx2.redhat.com [10.3.115.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5CFA614EB;
        Tue, 11 May 2021 16:06:28 +0000 (UTC)
Subject: Re: [PATCH 11/16] iommu/dma: Support PCI P2PDMA pages in dma-iommu
 map_sg
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org
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
From:   Don Dutile <ddutile@redhat.com>
Message-ID: <6003ed3d-5969-4201-3cbb-3bcf84385541@redhat.com>
Date:   Tue, 11 May 2021 12:06:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210408170123.8788-12-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/8/21 1:01 PM, Logan Gunthorpe wrote:
> When a PCI P2PDMA page is seen, set the IOVA length of the segment
> to zero so that it is not mapped into the IOVA. Then, in finalise_sg(),
> apply the appropriate bus address to the segment. The IOVA is not
> created if the scatterlist only consists of P2PDMA pages.
>
> Similar to dma-direct, the sg_mark_pci_p2pdma() flag is used to
> indicate bus address segments. On unmap, P2PDMA segments are skipped
> over when determining the start and end IOVA addresses.
>
> With this change, the flags variable in the dma_map_ops is
> set to DMA_F_PCI_P2PDMA_SUPPORTED to indicate support for
> P2PDMA pages.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
So, this code prevents use of p2pdma using an IOMMU, which wasn't checked and
short-circuited by other checks to use dma-direct?

So my overall comment to this code & related comments is that it should be sprinkled
with notes like "doesn't support IOMMU" and / or "TODO" when/if IOMMU is to be supported.
Or, if IOMMU-based p2pdma isn't supported in these routines directly, where/how they will be supported?

> ---
>   drivers/iommu/dma-iommu.c | 66 ++++++++++++++++++++++++++++++++++-----
>   1 file changed, 58 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index af765c813cc8..ef49635f9819 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -20,6 +20,7 @@
>   #include <linux/mm.h>
>   #include <linux/mutex.h>
>   #include <linux/pci.h>
> +#include <linux/pci-p2pdma.h>
>   #include <linux/swiotlb.h>
>   #include <linux/scatterlist.h>
>   #include <linux/vmalloc.h>
> @@ -864,6 +865,16 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
>   		sg_dma_address(s) = DMA_MAPPING_ERROR;
>   		sg_dma_len(s) = 0;
>   
> +		if (is_pci_p2pdma_page(sg_page(s)) && !s_iova_len) {
> +			if (i > 0)
> +				cur = sg_next(cur);
> +
> +			pci_p2pdma_map_bus_segment(s, cur);
> +			count++;
> +			cur_len = 0;
> +			continue;
> +		}
> +
>   		/*
>   		 * Now fill in the real DMA data. If...
>   		 * - there is a valid output segment to append to
> @@ -961,10 +972,12 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   	struct iova_domain *iovad = &cookie->iovad;
>   	struct scatterlist *s, *prev = NULL;
>   	int prot = dma_info_to_prot(dir, dev_is_dma_coherent(dev), attrs);
> +	struct dev_pagemap *pgmap = NULL;
> +	enum pci_p2pdma_map_type map_type;
>   	dma_addr_t iova;
>   	size_t iova_len = 0;
>   	unsigned long mask = dma_get_seg_boundary(dev);
> -	int i;
> +	int i, ret = 0;
>   
>   	if (static_branch_unlikely(&iommu_deferred_attach_enabled) &&
>   	    iommu_deferred_attach(dev, domain))
> @@ -993,6 +1006,31 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   		s_length = iova_align(iovad, s_length + s_iova_off);
>   		s->length = s_length;
>   
> +		if (is_pci_p2pdma_page(sg_page(s))) {
> +			if (sg_page(s)->pgmap != pgmap) {
> +				pgmap = sg_page(s)->pgmap;
> +				map_type = pci_p2pdma_map_type(pgmap, dev,
> +							       attrs);
> +			}
> +
> +			switch (map_type) {
> +			case PCI_P2PDMA_MAP_BUS_ADDR:
> +				/*
> +				 * A zero length will be ignored by
> +				 * iommu_map_sg() and then can be detected
> +				 * in __finalise_sg() to actually map the
> +				 * bus address.
> +				 */
> +				s->length = 0;
> +				continue;

> +			case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> +				break;
So, this 'short-circuits' the use of the IOMMU, silently?
This seems ripe for users to enable IOMMU for secure computing reasons, and using/enabling p2pdma,
and not realizing that it isn't as secure as 1+1=2  appears to be.
If my understanding is wrong, please point me to the Documentation or code that corrects this mis-understanding.  I could have missed a warning when both are enabled in a past patch set.
Thanks.
--dd
> +			default:
> +				ret = -EREMOTEIO;
> +				goto out_restore_sg;
> +			}
> +		}
> +
>   		/*
>   		 * Due to the alignment of our single IOVA allocation, we can
>   		 * depend on these assumptions about the segment boundary mask:
> @@ -1015,6 +1053,9 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   		prev = s;
>   	}
>   
> +	if (!iova_len)
> +		return __finalise_sg(dev, sg, nents, 0);
> +
>   	iova = iommu_dma_alloc_iova(domain, iova_len, dma_get_mask(dev), dev);
>   	if (!iova)
>   		goto out_restore_sg;
> @@ -1032,13 +1073,13 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   	iommu_dma_free_iova(cookie, iova, iova_len, NULL);
>   out_restore_sg:
>   	__invalidate_sg(sg, nents);
> -	return 0;
> +	return ret;
>   }
>   
>   static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
>   		int nents, enum dma_data_direction dir, unsigned long attrs)
>   {
> -	dma_addr_t start, end;
> +	dma_addr_t end, start = DMA_MAPPING_ERROR;
>   	struct scatterlist *tmp;
>   	int i;
>   
> @@ -1054,14 +1095,22 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
>   	 * The scatterlist segments are mapped into a single
>   	 * contiguous IOVA allocation, so this is incredibly easy.
>   	 */
> -	start = sg_dma_address(sg);
> -	for_each_sg(sg_next(sg), tmp, nents - 1, i) {
> +	for_each_sg(sg, tmp, nents, i) {
> +		if (sg_is_pci_p2pdma(tmp)) {
> +			sg_unmark_pci_p2pdma(tmp);
> +			continue;
> +		}
>   		if (sg_dma_len(tmp) == 0)
>   			break;
> -		sg = tmp;
> +
> +		if (start == DMA_MAPPING_ERROR)
> +			start = sg_dma_address(tmp);
> +
> +		end = sg_dma_address(tmp) + sg_dma_len(tmp);
>   	}
> -	end = sg_dma_address(sg) + sg_dma_len(sg);
> -	__iommu_dma_unmap(dev, start, end - start);
> +
> +	if (start != DMA_MAPPING_ERROR)
> +		__iommu_dma_unmap(dev, start, end - start);
>   }
>   
overall, fiddling with the generic dma-iommu code instead of using a dma-ops-based, p2pdma function that has it carved out and separated/refactored out to be cleaner seems less complicated, but I'm guessing you tried that and it was too complicated to do?
--dd

>   static dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
> @@ -1254,6 +1303,7 @@ static unsigned long iommu_dma_get_merge_boundary(struct device *dev)
>   }
>   
>   static const struct dma_map_ops iommu_dma_ops = {
> +	.flags			= DMA_F_PCI_P2PDMA_SUPPORTED,
wait, it's a const that's always turned on?
shouldn't the define for this flag be 0 for non-p2pdma configs?

>   	.alloc			= iommu_dma_alloc,
>   	.free			= iommu_dma_free,
>   	.alloc_pages		= dma_common_alloc_pages,

