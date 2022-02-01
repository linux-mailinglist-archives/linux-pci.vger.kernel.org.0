Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E058C4A6667
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 21:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiBAUx4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 15:53:56 -0500
Received: from out1.migadu.com ([91.121.223.63]:62987 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229596AbiBAUxy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Feb 2022 15:53:54 -0500
Message-ID: <6c939012-8d68-fbb5-50c6-3fe757a31b48@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1643748831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FjGXGyT9cU0n88J7maIkJMH0XpBuCFLksmeoO/eBSow=;
        b=QTVQqbWi2zRhOrtcUNxVvD5Rr3ibsGYLNahCRh6KCqybWlqpWImikBdcTwRBGh/fr30CNv
        QCTUATONgqLyqdkR0WxFdVuliEmbtGno10MNUBqi36vEqnMWRyfJ0Okw9E5DXNzvNVS5pg
        NxQV4d29alWIb4bQl861vP8Q04uHK0A=
Date:   Tue, 1 Feb 2022 13:53:45 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v5 08/24] dma-direct: support PCI P2PDMA pages in
 dma-direct map_sg
Content-Language: en-US
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
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>
References: <20220128002614.6136-1-logang@deltatee.com>
 <20220128002614.6136-9-logang@deltatee.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <20220128002614.6136-9-logang@deltatee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/27/2022 5:25 PM, Logan Gunthorpe wrote:
> Add PCI P2PDMA support for dma_direct_map_sg() so that it can map
> PCI P2PDMA pages directly without a hack in the callers. This allows
> for heterogeneous SGLs that contain both P2PDMA and regular pages.
> 
> A P2PDMA page may have three possible outcomes when being mapped:
>    1) If the data path between the two devices doesn't go through the
>       root port, then it should be mapped with a PCI bus address
>    2) If the data path goes through the host bridge, it should be mapped
>       normally, as though it were a CPU physical address
>    3) It is not possible for the two devices to communicate and thus
>       the mapping operation should fail (and it will return -EREMOTEIO).
> 
> SGL segments that contain PCI bus addresses are marked with
> sg_dma_mark_pci_p2pdma() and are ignored when unmapped.
> 
> P2PDMA mappings are also failed if swiotlb needs to be used on the
> mapping.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   kernel/dma/direct.c | 43 +++++++++++++++++++++++++++++++++++++------
>   kernel/dma/direct.h |  7 ++++++-
>   2 files changed, 43 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 50f48e9e4598..975df5f3aaf9 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -461,29 +461,60 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
>   		arch_sync_dma_for_cpu_all();
>   }
>   
> +/*
> + * Unmaps segments, except for ones marked as pci_p2pdma which do not
> + * require any further action as they contain a bus address.
> + */
>   void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
>   		int nents, enum dma_data_direction dir, unsigned long attrs)
>   {
>   	struct scatterlist *sg;
>   	int i;
>   
> -	for_each_sg(sgl, sg, nents, i)
> -		dma_direct_unmap_page(dev, sg->dma_address, sg_dma_len(sg), dir,
> -			     attrs);
> +	for_each_sg(sgl,  sg, nents, i) {
> +		if (sg_is_dma_bus_address(sg))
> +			sg_dma_unmark_bus_address(sg);
> +		else
> +			dma_direct_unmap_page(dev, sg->dma_address,
> +					      sg_dma_len(sg), dir, attrs);
> +	}
>   }
>   #endif
>   
>   int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>   		enum dma_data_direction dir, unsigned long attrs)
>   {
> -	int i;
> +	struct pci_p2pdma_map_state p2pdma_state = {};
> +	enum pci_p2pdma_map_type map;
>   	struct scatterlist *sg;
> +	int i, ret;
>   
>   	for_each_sg(sgl, sg, nents, i) {
> +		if (is_pci_p2pdma_page(sg_page(sg))) {
> +			map = pci_p2pdma_map_segment(&p2pdma_state, dev, sg);
> +			switch (map) {
> +			case PCI_P2PDMA_MAP_BUS_ADDR:
> +				continue;
> +			case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> +				/*
> +				 * Any P2P mapping that traverses the PCI
> +				 * host bridge must be mapped with CPU physical
> +				 * address and not PCI bus addresses. This is
> +				 * done with dma_direct_map_page() below.
> +				 */
> +				break;
> +			default:
> +				ret = -EREMOTEIO;
> +				goto out_unmap;
> +			}
> +		}
I'm a little confused about this code. Would there be a case where the mapping needs
to be checked for each sg in the list? And if some sg in the sgl can be mapped
differently, would we want to continue checking the rest of the sg in the sgl instead
of breaking out of the loop completely?

> +
>   		sg->dma_address = dma_direct_map_page(dev, sg_page(sg),
>   				sg->offset, sg->length, dir, attrs);
> -		if (sg->dma_address == DMA_MAPPING_ERROR)
> +		if (sg->dma_address == DMA_MAPPING_ERROR) {
> +			ret = -EIO;
>   			goto out_unmap;
> +		}
>   		sg_dma_len(sg) = sg->length;
>   	}
>   
> @@ -491,7 +522,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>   
>   out_unmap:
>   	dma_direct_unmap_sg(dev, sgl, i, dir, attrs | DMA_ATTR_SKIP_CPU_SYNC);
> -	return -EIO;
> +	return ret;
>   }
>   
>   dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
> index 4632b0f4f72e..a33152d79069 100644
> --- a/kernel/dma/direct.h
> +++ b/kernel/dma/direct.h
> @@ -87,10 +87,15 @@ static inline dma_addr_t dma_direct_map_page(struct device *dev,
>   	phys_addr_t phys = page_to_phys(page) + offset;
>   	dma_addr_t dma_addr = phys_to_dma(dev, phys);
>   
> -	if (is_swiotlb_force_bounce(dev))
> +	if (is_swiotlb_force_bounce(dev)) {
> +		if (is_pci_p2pdma_page(page))
> +			return DMA_MAPPING_ERROR;
>   		return swiotlb_map(dev, phys, size, dir, attrs);
> +	}
>   
>   	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
> +		if (is_pci_p2pdma_page(page))
> +			return DMA_MAPPING_ERROR;
>   		if (swiotlb_force != SWIOTLB_NO_FORCE)
>   			return swiotlb_map(dev, phys, size, dir, attrs);
>   
