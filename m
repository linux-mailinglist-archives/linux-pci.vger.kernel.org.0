Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A114E339276
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 16:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbhCLPyL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 10:54:11 -0500
Received: from foss.arm.com ([217.140.110.172]:56294 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232553AbhCLPwI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Mar 2021 10:52:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8D0211B3;
        Fri, 12 Mar 2021 07:52:07 -0800 (PST)
Received: from [10.57.52.136] (unknown [10.57.52.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DA3A3F7D7;
        Fri, 12 Mar 2021 07:52:04 -0800 (PST)
Subject: Re: [RFC PATCH v2 06/11] dma-direct: Support PCI P2PDMA pages in
 dma-direct map_sg
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
 <20210311233142.7900-7-logang@deltatee.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <215e1472-5294-d20a-a43a-ff6dfe8cd66e@arm.com>
Date:   Fri, 12 Mar 2021 15:52:02 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210311233142.7900-7-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-03-11 23:31, Logan Gunthorpe wrote:
> Add PCI P2PDMA support for dma_direct_map_sg() so that it can map
> PCI P2PDMA pages directly without a hack in the callers. This allows
> for heterogeneous SGLs that contain both P2PDMA and regular pages.
> 
> SGL segments that contain PCI bus addresses are marked with
> sg_mark_pci_p2pdma() and are ignored when unmapped.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   kernel/dma/direct.c  | 35 ++++++++++++++++++++++++++++++++---
>   kernel/dma/mapping.c | 13 ++++++++++---
>   2 files changed, 42 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 002268262c9a..f326d32062dd 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -13,6 +13,7 @@
>   #include <linux/vmalloc.h>
>   #include <linux/set_memory.h>
>   #include <linux/slab.h>
> +#include <linux/pci-p2pdma.h>
>   #include "direct.h"
>   
>   /*
> @@ -387,19 +388,47 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
>   	struct scatterlist *sg;
>   	int i;
>   
> -	for_each_sg(sgl, sg, nents, i)
> +	for_each_sg(sgl, sg, nents, i) {
> +		if (sg_is_pci_p2pdma(sg))
> +			continue;
> +
>   		dma_direct_unmap_page(dev, sg->dma_address, sg_dma_len(sg), dir,
>   			     attrs);
> +	}
>   }
>   #endif
>   
>   int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>   		enum dma_data_direction dir, unsigned long attrs)
>   {
> -	int i;
> +	struct dev_pagemap *pgmap = NULL;
> +	int i, map = -1, ret = 0;
>   	struct scatterlist *sg;
> +	u64 bus_off;
>   
>   	for_each_sg(sgl, sg, nents, i) {
> +		if (is_pci_p2pdma_page(sg_page(sg))) {
> +			if (sg_page(sg)->pgmap != pgmap) {
> +				pgmap = sg_page(sg)->pgmap;
> +				map = pci_p2pdma_dma_map_type(dev, pgmap);
> +				bus_off = pci_p2pdma_bus_offset(sg_page(sg));
> +			}
> +
> +			if (map < 0) {
> +				sg->dma_address = DMA_MAPPING_ERROR;
> +				ret = -EREMOTEIO;
> +				goto out_unmap;
> +			}
> +
> +			if (map) {
> +				sg->dma_address = sg_phys(sg) + sg->offset -
> +					bus_off;
> +				sg_dma_len(sg) = sg->length;
> +				sg_mark_pci_p2pdma(sg);
> +				continue;
> +			}
> +		}
> +
>   		sg->dma_address = dma_direct_map_page(dev, sg_page(sg),
>   				sg->offset, sg->length, dir, attrs);
>   		if (sg->dma_address == DMA_MAPPING_ERROR)
> @@ -411,7 +440,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>   
>   out_unmap:
>   	dma_direct_unmap_sg(dev, sgl, i, dir, attrs | DMA_ATTR_SKIP_CPU_SYNC);
> -	return 0;
> +	return ret;
>   }
>   
>   dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index b6a633679933..adc1a83950be 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -178,8 +178,15 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
>   EXPORT_SYMBOL(dma_unmap_page_attrs);
>   
>   /*
> - * dma_maps_sg_attrs returns 0 on error and > 0 on success.
> - * It should never return a value < 0.
> + * dma_maps_sg_attrs returns 0 on any resource error and > 0 on success.
> + *
> + * If 0 is returned, the mapping can be retried and will succeed once
> + * sufficient resources are available.

That's not a guarantee we can uphold. Retrying forever in the vain hope 
that a device might evolve some extra address bits, or a bounce buffer 
might magically grow big enough for a gigantic mapping, isn't 
necessarily the best idea.

> + *
> + * If there are P2PDMA pages in the scatterlist then this function may
> + * return -EREMOTEIO to indicate that the pages are not mappable by the
> + * device. In this case, an error should be returned for the IO as it
> + * will never be successfully retried.
>    */
>   int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
>   		enum dma_data_direction dir, unsigned long attrs)
> @@ -197,7 +204,7 @@ int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
>   		ents = dma_direct_map_sg(dev, sg, nents, dir, attrs);
>   	else
>   		ents = ops->map_sg(dev, sg, nents, dir, attrs);
> -	BUG_ON(ents < 0);
> +

This scares me - I hesitate to imagine the amount of driver/subsystem 
code out there that will see nonzero and merrily set off iterating a 
negative number of segments, if we open the floodgates of allowing 
implementations to return error codes here.

Robin.

>   	debug_dma_map_sg(dev, sg, nents, ents, dir);
>   
>   	return ents;
> 
