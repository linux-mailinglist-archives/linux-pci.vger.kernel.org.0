Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84262AE3FB
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 00:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732013AbgKJXZR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Nov 2020 18:25:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:37548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731234AbgKJXZQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Nov 2020 18:25:16 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC9BC20781;
        Tue, 10 Nov 2020 23:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605050715;
        bh=o6lMTu5xFOzYsPde49ClXFU1xXCgPh17zPTl4Yx9dys=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dPV32dPJxAhqlhllWUsMt1gC7dOq85ACuyi2fnWL+r9/kPB0YaAY/q+UhWjLeQo7V
         ZDoeayJFbRzQ9/aW39itkyKKH8s+us5oMd9a8UfsuIgKpGjmBDN1DXk5OlpCVC2zRi
         xPJXtoRNKmQs4fail2G1MnvjO16Ve1HVNwPMHkTo=
Date:   Tue, 10 Nov 2020 17:25:13 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Ira Weiny <iweiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [RFC PATCH 03/15] PCI/P2PDMA: Introduce
 pci_p2pdma_should_map_bus() and pci_p2pdma_bus_offset()
Message-ID: <20201110232513.GA705726@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106170036.18713-4-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 06, 2020 at 10:00:24AM -0700, Logan Gunthorpe wrote:
> Introduce pci_p2pdma_should_map_bus() which is meant to be called by
> dma map functions to determine how to map a given p2pdma page.

s/dma/DMA/ for consistency (also below in function comment)

> pci_p2pdma_bus_offset() is also added to allow callers to get the bus
> offset if they need to map the bus address.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/pci/p2pdma.c       | 46 ++++++++++++++++++++++++++++++++++++++
>  include/linux/pci-p2pdma.h | 11 +++++++++
>  2 files changed, 57 insertions(+)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index ea8472278b11..9961e779f430 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -930,6 +930,52 @@ void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>  }
>  EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
>  
> +/**
> + * pci_p2pdma_bus_offset - returns the bus offset for a given page
> + * @page: page to get the offset for
> + *
> + * Must be passed a pci p2pdma page.

s/pci/PCI/

> + */
> +u64 pci_p2pdma_bus_offset(struct page *page)
> +{
> +	struct pci_p2pdma_pagemap *p2p_pgmap = to_p2p_pgmap(page->pgmap);
> +
> +	WARN_ON(!is_pci_p2pdma_page(page));
> +
> +	return p2p_pgmap->bus_offset;
> +}
> +EXPORT_SYMBOL_GPL(pci_p2pdma_bus_offset);
> +
> +/**
> + * pci_p2pdma_should_map_bus - determine if a dma mapping should use the
> + *	bus address
> + * @dev: device doing the DMA request
> + * @pgmap: dev_pagemap structure for the mapping
> + *
> + * Returns 1 if the page should be mapped with a bus address, 0 otherwise
> + * and -1 the device should not be mapping P2PDMA pages.

I think this is missing a word.

I'm not really sure how to interpret the "should" in
pci_p2pdma_should_map_bus().  If this returns -1, does that mean the
patches *cannot* be mapped?  They *could* be mapped, but you really
*shouldn't*?  Something else?

1 means page should be mapped with bus address.  0 means ... what,
exactly?  It should be mapped with some different address?

Sorry these are naive questions because I don't know how all this
works.

> + */
> +int pci_p2pdma_should_map_bus(struct device *dev, struct dev_pagemap *pgmap)
> +{
> +	struct pci_p2pdma_pagemap *p2p_pgmap = to_p2p_pgmap(pgmap);
> +	struct pci_dev *client;
> +
> +	if (!dev_is_pci(dev))
> +		return -1;
> +
> +	client = to_pci_dev(dev);
> +
> +	switch (pci_p2pdma_map_type(p2p_pgmap->provider, client)) {
> +	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> +		return 0;
> +	case PCI_P2PDMA_MAP_BUS_ADDR:
> +		return 1;
> +	default:
> +		return -1;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(pci_p2pdma_should_map_bus);
> +
>  /**
>   * pci_p2pdma_enable_store - parse a configfs/sysfs attribute store
>   *		to enable p2pdma
> diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
> index 8318a97c9c61..fc5de47eeac4 100644
> --- a/include/linux/pci-p2pdma.h
> +++ b/include/linux/pci-p2pdma.h
> @@ -34,6 +34,8 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>  		int nents, enum dma_data_direction dir, unsigned long attrs);
>  void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>  		int nents, enum dma_data_direction dir, unsigned long attrs);
> +u64 pci_p2pdma_bus_offset(struct page *page);
> +int pci_p2pdma_should_map_bus(struct device *dev, struct dev_pagemap *pgmap);
>  int pci_p2pdma_enable_store(const char *page, struct pci_dev **p2p_dev,
>  			    bool *use_p2pdma);
>  ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
> @@ -83,6 +85,15 @@ static inline void pci_p2pmem_free_sgl(struct pci_dev *pdev,
>  static inline void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
>  {
>  }
> +static inline u64 pci_p2pdma_bus_offset(struct page *page)
> +{
> +	return -1;
> +}
> +static inline int pci_p2pdma_should_map_bus(struct device *dev,
> +					    struct dev_pagemap *pgmap)
> +{
> +	return -1;
> +}
>  static inline int pci_p2pdma_map_sg_attrs(struct device *dev,
>  		struct scatterlist *sg, int nents, enum dma_data_direction dir,
>  		unsigned long attrs)
> -- 
> 2.20.1
> 
