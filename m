Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19856339273
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 16:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbhCLPxi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 10:53:38 -0500
Received: from foss.arm.com ([217.140.110.172]:56354 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232164AbhCLPxI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Mar 2021 10:53:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B81B1063;
        Fri, 12 Mar 2021 07:53:07 -0800 (PST)
Received: from [10.57.52.136] (unknown [10.57.52.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 314293F7D7;
        Fri, 12 Mar 2021 07:53:03 -0800 (PST)
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
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <accd4187-7a9d-a8fc-f216-98ec24e3411a@arm.com>
Date:   Fri, 12 Mar 2021 15:52:57 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210311233142.7900-9-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-03-11 23:31, Logan Gunthorpe wrote:
> When a PCI P2PDMA page is seen, set the IOVA length of the segment
> to zero so that it is not mapped into the IOVA. Then, in finalise_sg(),
> apply the appropriate bus address to the segment. The IOVA is not
> created if the scatterlist only consists of P2PDMA pages.

This misled me at first, but I see the implementation does actually 
appear to accomodate the case of working ACS where P2P *would* still 
need to be mapped at the IOMMU.

> Similar to dma-direct, the sg_mark_pci_p2pdma() flag is used to
> indicate bus address segments. On unmap, P2PDMA segments are skipped
> over when determining the start and end IOVA addresses.
> 
> With this change, the flags variable in the dma_map_ops is
> set to DMA_F_PCI_P2PDMA_SUPPORTED to indicate support for
> P2PDMA pages.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   drivers/iommu/dma-iommu.c | 63 ++++++++++++++++++++++++++++++++-------
>   1 file changed, 53 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index af765c813cc8..c0821e9051a9 100644
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
> @@ -846,7 +847,7 @@ static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
>    * segment's start address to avoid concatenating across one.
>    */
>   static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
> -		dma_addr_t dma_addr)
> +		dma_addr_t dma_addr, unsigned long attrs)
>   {
>   	struct scatterlist *s, *cur = sg;
>   	unsigned long seg_mask = dma_get_seg_boundary(dev);
> @@ -864,6 +865,20 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
>   		sg_dma_address(s) = DMA_MAPPING_ERROR;
>   		sg_dma_len(s) = 0;
>   
> +		if (is_pci_p2pdma_page(sg_page(s)) && !s_iova_len) {
> +			if (i > 0)
> +				cur = sg_next(cur);
> +
> +			sg_dma_address(cur) = sg_phys(s) + s->offset -

Are you sure about that? ;)

> +				pci_p2pdma_bus_offset(sg_page(s));

Can the bus offset make P2P addresses overlap with regions of mem space 
that we might use for regular IOVA allocation? That would be very bad...

> +			sg_dma_len(cur) = s->length;
> +			sg_mark_pci_p2pdma(cur);
> +
> +			count++;
> +			cur_len = 0;
> +			continue;
> +		}
> +
>   		/*
>   		 * Now fill in the real DMA data. If...
>   		 * - there is a valid output segment to append to
> @@ -960,11 +975,12 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>   	struct iova_domain *iovad = &cookie->iovad;
>   	struct scatterlist *s, *prev = NULL;
> +	struct dev_pagemap *pgmap = NULL;
>   	int prot = dma_info_to_prot(dir, dev_is_dma_coherent(dev), attrs);
>   	dma_addr_t iova;
>   	size_t iova_len = 0;
>   	unsigned long mask = dma_get_seg_boundary(dev);
> -	int i;
> +	int i, map = -1, ret = 0;
>   
>   	if (static_branch_unlikely(&iommu_deferred_attach_enabled) &&
>   	    iommu_deferred_attach(dev, domain))
> @@ -993,6 +1009,23 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   		s_length = iova_align(iovad, s_length + s_iova_off);
>   		s->length = s_length;
>   
> +		if (is_pci_p2pdma_page(sg_page(s))) {
> +			if (sg_page(s)->pgmap != pgmap) {
> +				pgmap = sg_page(s)->pgmap;
> +				map = pci_p2pdma_dma_map_type(dev, pgmap);
> +			}
> +
> +			if (map < 0) {

It rather feels like it should be the job of whoever creates the list in 
the first place not to put unusable pages in it, especially since the 
p2pdma_map_type looks to be a fairly coarse-grained and static thing. 
The DMA API isn't responsible for validating normal memory pages, so 
what makes P2P special?

> +				ret = -EREMOTEIO;
> +				goto out_restore_sg;
> +			}
> +
> +			if (map) {
> +				s->length = 0;

I'm not really thrilled about the idea of passing zero-length segments 
to iommu_map_sg(). Yes, it happens to trick the concatenation logic in 
the current implementation into doing what you want, but it feels fragile.

> +				continue;
> +			}
> +		}
> +
>   		/*
>   		 * Due to the alignment of our single IOVA allocation, we can
>   		 * depend on these assumptions about the segment boundary mask:
> @@ -1015,6 +1048,9 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   		prev = s;
>   	}
>   
> +	if (!iova_len)
> +		return __finalise_sg(dev, sg, nents, 0, attrs);
> +
>   	iova = iommu_dma_alloc_iova(domain, iova_len, dma_get_mask(dev), dev);
>   	if (!iova)
>   		goto out_restore_sg;
> @@ -1026,19 +1062,19 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   	if (iommu_map_sg_atomic(domain, iova, sg, nents, prot) < iova_len)
>   		goto out_free_iova;
>   
> -	return __finalise_sg(dev, sg, nents, iova);
> +	return __finalise_sg(dev, sg, nents, iova, attrs);
>   
>   out_free_iova:
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
> @@ -1054,14 +1090,20 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
>   	 * The scatterlist segments are mapped into a single
>   	 * contiguous IOVA allocation, so this is incredibly easy.
>   	 */
> -	start = sg_dma_address(sg);
> -	for_each_sg(sg_next(sg), tmp, nents - 1, i) {
> +	for_each_sg(sg, tmp, nents, i) {
> +		if (sg_is_pci_p2pdma(tmp))

Since the flag is associated with the DMA address which will no longer 
be valid, shouldn't it be cleared? The circumstances in which leaving it 
around could cause a problem are tenuous, but definitely possible.

Robin.

> +			continue;
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
>   static dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
> @@ -1254,6 +1296,7 @@ static unsigned long iommu_dma_get_merge_boundary(struct device *dev)
>   }
>   
>   static const struct dma_map_ops iommu_dma_ops = {
> +	.flags			= DMA_F_PCI_P2PDMA_SUPPORTED,
>   	.alloc			= iommu_dma_alloc,
>   	.free			= iommu_dma_free,
>   	.alloc_pages		= dma_common_alloc_pages,
> 
