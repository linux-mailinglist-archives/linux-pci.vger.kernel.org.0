Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3879F37AB67
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 18:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhEKQHR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 12:07:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31688 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231800AbhEKQHQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 12:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620749169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AYzMm9vNy1mQ7xlxpQxo7ktyLZlBtsEnRv4GpKCQ6cM=;
        b=bpzbCL2gMPm7iR/l+x8dW4ziWRGTHoV3LC+mF9X3bdB+JttWOceKLSHtxSrGyfKaKTAFtQ
        Mm9lmbX5Zx3NEyIu5tXqu/++KgjVHzNn4VSo0ZuCP0YDtWzOMW8ZSTyzbviSnAaqGdBSeW
        1TVTzZi4MfNVl9IkYLuvPWCfNi/tIbM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-mqNbg_zrPqi8D2Qovi2qcA-1; Tue, 11 May 2021 12:06:05 -0400
X-MC-Unique: mqNbg_zrPqi8D2Qovi2qcA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 006E2FC8E;
        Tue, 11 May 2021 16:06:01 +0000 (UTC)
Received: from [10.3.115.19] (ovpn-115-19.phx2.redhat.com [10.3.115.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FBB95C232;
        Tue, 11 May 2021 16:05:56 +0000 (UTC)
Subject: Re: [PATCH 05/16] dma-mapping: Introduce dma_map_sg_p2pdma()
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
 <20210408170123.8788-6-logang@deltatee.com>
From:   Don Dutile <ddutile@redhat.com>
Message-ID: <a59daad2-31eb-b7b6-d68f-f42d717dbc2c@redhat.com>
Date:   Tue, 11 May 2021 12:05:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210408170123.8788-6-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/8/21 1:01 PM, Logan Gunthorpe wrote:
> dma_map_sg() either returns a positive number indicating the number
> of entries mapped or zero indicating that resources were not available
> to create the mapping. When zero is returned, it is always safe to retry
> the mapping later once resources have been freed.
>
> Once P2PDMA pages are mixed into the SGL there may be pages that may
> never be successfully mapped with a given device because that device may
> not actually be able to access those pages. Thus, multiple error
> conditions will need to be distinguished to determine weather a retry
s/weather/whether/
> is safe.
>
> Introduce dma_map_sg_p2pdma[_attrs]() with a different calling
> convention from dma_map_sg(). The function will return a positive
> integer on success or a negative errno on failure.
>
> ENOMEM will be used to indicate a resource failure and EREMOTEIO to
> indicate that a P2PDMA page is not mappable.
>
> The __DMA_ATTR_PCI_P2PDMA attribute is introduced to inform the lower
> level implementations that P2PDMA pages are allowed and to warn if a
> caller introduces them into the regular dma_map_sg() interface.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
John caught any other comment I had (and more).
-dd

> ---
>   include/linux/dma-mapping.h | 15 +++++++++++
>   kernel/dma/mapping.c        | 52 ++++++++++++++++++++++++++++++++-----
>   2 files changed, 61 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 2a984cb4d1e0..50b8f586cf59 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -60,6 +60,12 @@
>    * at least read-only at lesser-privileged levels).
>    */
>   #define DMA_ATTR_PRIVILEGED		(1UL << 9)
> +/*
> + * __DMA_ATTR_PCI_P2PDMA: This should not be used directly, use
> + * dma_map_sg_p2pdma() instead. Used internally to indicate that the
> + * caller is using the dma_map_sg_p2pdma() interface.
> + */
> +#define __DMA_ATTR_PCI_P2PDMA		(1UL << 10)
>   
>   /*
>    * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
> @@ -107,6 +113,8 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
>   		enum dma_data_direction dir, unsigned long attrs);
>   int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
>   		enum dma_data_direction dir, unsigned long attrs);
> +int dma_map_sg_p2pdma_attrs(struct device *dev, struct scatterlist *sg,
> +		int nents, enum dma_data_direction dir, unsigned long attrs);
>   void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>   				      int nents, enum dma_data_direction dir,
>   				      unsigned long attrs);
> @@ -160,6 +168,12 @@ static inline int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>   {
>   	return 0;
>   }
> +static inline int dma_map_sg_p2pdma_attrs(struct device *dev,
> +		struct scatterlist *sg, int nents, enum dma_data_direction dir,
> +		unsigned long attrs)
> +{
> +	return 0;
> +}
>   static inline void dma_unmap_sg_attrs(struct device *dev,
>   		struct scatterlist *sg, int nents, enum dma_data_direction dir,
>   		unsigned long attrs)
> @@ -392,6 +406,7 @@ static inline void dma_sync_sgtable_for_device(struct device *dev,
>   #define dma_map_single(d, a, s, r) dma_map_single_attrs(d, a, s, r, 0)
>   #define dma_unmap_single(d, a, s, r) dma_unmap_single_attrs(d, a, s, r, 0)
>   #define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
> +#define dma_map_sg_p2pdma(d, s, n, r) dma_map_sg_p2pdma_attrs(d, s, n, r, 0)
>   #define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
>   #define dma_map_page(d, p, o, s, r) dma_map_page_attrs(d, p, o, s, r, 0)
>   #define dma_unmap_page(d, a, s, r) dma_unmap_page_attrs(d, a, s, r, 0)
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index b6a633679933..923089c4267b 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -177,12 +177,8 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
>   }
>   EXPORT_SYMBOL(dma_unmap_page_attrs);
>   
> -/*
> - * dma_maps_sg_attrs returns 0 on error and > 0 on success.
> - * It should never return a value < 0.
> - */
> -int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
> -		enum dma_data_direction dir, unsigned long attrs)
> +static int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
> +		int nents, enum dma_data_direction dir, unsigned long attrs)
>   {
>   	const struct dma_map_ops *ops = get_dma_ops(dev);
>   	int ents;
> @@ -197,6 +193,20 @@ int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
>   		ents = dma_direct_map_sg(dev, sg, nents, dir, attrs);
>   	else
>   		ents = ops->map_sg(dev, sg, nents, dir, attrs);
> +
> +	return ents;
> +}
> +
> +/*
> + * dma_maps_sg_attrs returns 0 on error and > 0 on success.
> + * It should never return a value < 0.
> + */
> +int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
> +		enum dma_data_direction dir, unsigned long attrs)
> +{
> +	int ents;
> +
> +	ents = __dma_map_sg_attrs(dev, sg, nents, dir, attrs);
>   	BUG_ON(ents < 0);
>   	debug_dma_map_sg(dev, sg, nents, ents, dir);
>   
> @@ -204,6 +214,36 @@ int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
>   }
>   EXPORT_SYMBOL(dma_map_sg_attrs);
>   
> +/*
> + * like dma_map_sg_attrs, but returns a negative errno on error (and > 0
> + * on success). This function must be used if PCI P2PDMA pages might
> + * be in the scatterlist.
> + *
> + * On error this function may return:
> + *    -ENOMEM indicating that there was not enough resources available and
> + *      the transfer may be retried later
> + *    -EREMOTEIO indicating that P2PDMA pages were included but cannot
> + *      be mapped by the specified device, retries will always fail
> + *
> + * The scatterlist should be unmapped with the regular dma_unmap_sg[_attrs]().
> + */
> +int dma_map_sg_p2pdma_attrs(struct device *dev, struct scatterlist *sg,
> +		int nents, enum dma_data_direction dir, unsigned long attrs)
> +{
> +	int ents;
> +
> +	ents = __dma_map_sg_attrs(dev, sg, nents, dir,
> +				  attrs | __DMA_ATTR_PCI_P2PDMA);
> +	if (!ents)
> +		ents = -ENOMEM;
> +
> +	if (ents > 0)
> +		debug_dma_map_sg(dev, sg, nents, ents, dir);
> +
> +	return ents;
> +}
> +EXPORT_SYMBOL_GPL(dma_map_sg_p2pdma_attrs);
> +
>   void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>   				      int nents, enum dma_data_direction dir,
>   				      unsigned long attrs)

