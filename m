Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C78C37AB6B
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 18:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhEKQH3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 12:07:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31583 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231800AbhEKQH1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 12:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620749179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tMAIqc3ynAUjVNMmJZyA97GO/AXkgEpCMde9bMg3dSI=;
        b=RsQdAGC4JcZuadUAtxVg3eoYYvp9gOjVAEvD7/yZhxEIO+mdxXtivVxwDiVLYz+FQIUmqj
        e/CrFI1Yj2qdOd6vPbUUlJBbqxzFWStquW61n/PvJEqWCipBi3UmA7eAAxr54B9a8PfT5B
        ioe97Vm5Aqn/SvsluJpkQNdgMVsaL9A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-qB9XlPV8NbqOjRN04e3B5A-1; Tue, 11 May 2021 12:06:16 -0400
X-MC-Unique: qB9XlPV8NbqOjRN04e3B5A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F7ED8C8640;
        Tue, 11 May 2021 16:06:12 +0000 (UTC)
Received: from [10.3.115.19] (ovpn-115-19.phx2.redhat.com [10.3.115.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 30ECA6E53E;
        Tue, 11 May 2021 16:06:08 +0000 (UTC)
Subject: Re: [PATCH 07/16] PCI/P2PDMA: Make pci_p2pdma_map_type() non-static
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
 <20210408170123.8788-8-logang@deltatee.com>
From:   Don Dutile <ddutile@redhat.com>
Message-ID: <a2da7566-7e0d-6a3a-055d-4d324deba4af@redhat.com>
Date:   Tue, 11 May 2021 12:06:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210408170123.8788-8-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/8/21 1:01 PM, Logan Gunthorpe wrote:
> pci_p2pdma_map_type() will be needed by the dma-iommu map_sg
> implementation because it will need to determine the mapping type
> ahead of actually doing the mapping to create the actual iommu mapping.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   drivers/pci/p2pdma.c       | 34 +++++++++++++++++++++++-----------
>   include/linux/pci-p2pdma.h | 15 +++++++++++++++
>   2 files changed, 38 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index bcb1a6d6119d..38c93f57a941 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -20,13 +20,6 @@
>   #include <linux/seq_buf.h>
>   #include <linux/xarray.h>
>   
> -enum pci_p2pdma_map_type {
> -	PCI_P2PDMA_MAP_UNKNOWN = 0,
> -	PCI_P2PDMA_MAP_NOT_SUPPORTED,
> -	PCI_P2PDMA_MAP_BUS_ADDR,
> -	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE,
> -};
> -
>   struct pci_p2pdma {
>   	struct gen_pool *pool;
>   	bool p2pmem_published;
> @@ -822,13 +815,30 @@ void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
>   }
>   EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
>   
> -static enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
> -						    struct device *dev)
> +/**
> + * pci_p2pdma_map_type - return the type of mapping that should be used for
> + *	a given device and pgmap
> + * @pgmap: the pagemap of a page to determine the mapping type for
> + * @dev: device that is mapping the page
> + * @dma_attrs: the attributes passed to the dma_map operation --
> + *	this is so they can be checked to ensure P2PDMA pages were not
> + *	introduced into an incorrect interface (like dma_map_sg). *
> + *
> + * Returns one of:
> + *	PCI_P2PDMA_MAP_NOT_SUPPORTED - The mapping should not be done
> + *	PCI_P2PDMA_MAP_BUS_ADDR - The mapping should use the PCI bus address
> + *	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE - The mapping should be done directly
> + */
I'd recommend putting these descriptions in the enum's in pci-p2pdma.h .
Also, can you use a better description for THRU_HOST_BRIDGE -- it leaves the reader wondering what 'done directly' means.

Thanks.
-dd

> +enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
> +		struct device *dev, unsigned long dma_attrs)
>   {
>   	struct pci_dev *provider = to_p2p_pgmap(pgmap)->provider;
>   	enum pci_p2pdma_map_type ret;
>   	struct pci_dev *client;
>   
> +	WARN_ONCE(!(dma_attrs & __DMA_ATTR_PCI_P2PDMA),
> +		  "PCI P2PDMA pages were mapped with dma_map_sg!");
> +
>   	if (!provider->p2pdma)
>   		return PCI_P2PDMA_MAP_NOT_SUPPORTED;
>   
> @@ -879,7 +889,8 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>   	struct pci_p2pdma_pagemap *p2p_pgmap =
>   		to_p2p_pgmap(sg_page(sg)->pgmap);
>   
> -	switch (pci_p2pdma_map_type(sg_page(sg)->pgmap, dev)) {
> +	switch (pci_p2pdma_map_type(sg_page(sg)->pgmap, dev,
> +				    __DMA_ATTR_PCI_P2PDMA)) {
>   	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
>   		return dma_map_sg_attrs(dev, sg, nents, dir, attrs);
>   	case PCI_P2PDMA_MAP_BUS_ADDR:
> @@ -904,7 +915,8 @@ void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>   {
>   	enum pci_p2pdma_map_type map_type;
>   
> -	map_type = pci_p2pdma_map_type(sg_page(sg)->pgmap, dev);
> +	map_type = pci_p2pdma_map_type(sg_page(sg)->pgmap, dev,
> +				       __DMA_ATTR_PCI_P2PDMA);
>   
>   	if (map_type == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE)
>   		dma_unmap_sg_attrs(dev, sg, nents, dir, attrs);
> diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
> index 8318a97c9c61..a06072ac3a52 100644
> --- a/include/linux/pci-p2pdma.h
> +++ b/include/linux/pci-p2pdma.h
> @@ -16,6 +16,13 @@
>   struct block_device;
>   struct scatterlist;
>   
> +enum pci_p2pdma_map_type {
> +	PCI_P2PDMA_MAP_UNKNOWN = 0,
> +	PCI_P2PDMA_MAP_NOT_SUPPORTED,
> +	PCI_P2PDMA_MAP_BUS_ADDR,
> +	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE,
> +};
> +
>   #ifdef CONFIG_PCI_P2PDMA
>   int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
>   		u64 offset);
> @@ -30,6 +37,8 @@ struct scatterlist *pci_p2pmem_alloc_sgl(struct pci_dev *pdev,
>   					 unsigned int *nents, u32 length);
>   void pci_p2pmem_free_sgl(struct pci_dev *pdev, struct scatterlist *sgl);
>   void pci_p2pmem_publish(struct pci_dev *pdev, bool publish);
> +enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
> +		struct device *dev, unsigned long dma_attrs);
>   int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>   		int nents, enum dma_data_direction dir, unsigned long attrs);
>   void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
> @@ -83,6 +92,12 @@ static inline void pci_p2pmem_free_sgl(struct pci_dev *pdev,
>   static inline void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
>   {
>   }
> +static inline enum pci_p2pdma_map_type pci_p2pdma_map_type(
> +		struct dev_pagemap *pgmap, struct device *dev,
> +		unsigned long dma_attrs)
> +{
> +	return PCI_P2PDMA_MAP_NOT_SUPPORTED;
> +}
>   static inline int pci_p2pdma_map_sg_attrs(struct device *dev,
>   		struct scatterlist *sg, int nents, enum dma_data_direction dir,
>   		unsigned long attrs)

