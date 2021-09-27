Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0BF4419EAD
	for <lists+linux-pci@lfdr.de>; Mon, 27 Sep 2021 20:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbhI0Sz2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Sep 2021 14:55:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234507AbhI0Sz2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Sep 2021 14:55:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9428960FD7;
        Mon, 27 Sep 2021 18:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632768830;
        bh=WQXS4Y5fxYTqqCk1J2d4JT7fGZFmk/5NLpzr/2vNoXg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=j+h82KEneKoIWmmfnU8bIarGfEsel7wnR0BgUFxYi+ROqggCWKJnSfSd4xp0oxArs
         4VZ3GUIs2qvJ7umsIGdOIUVhWigEcUG6BYJSlBElcymvcmm6xrYw7j5G4DYvOaXKVv
         6dsZLPWsl0rLoNrKwUAvPv0qEObRggFeNWlDYbFZcW5Fdh2/SXwRvmg2RelqMfK2xm
         3TxFsNqMUL6jRiFjOXsLJtYmZgIJGtPeY2plkKXC9gyiSASDMWeU3hsWDDsbttu6fx
         OydU71hNxH55bR/qjyo/saP9MWkZNX264D5M9bEfYe9wPiAMA0JBosJDzbsQP19KUC
         en1lkEz7/wQUg==
Date:   Mon, 27 Sep 2021 13:53:48 -0500
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
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: Re: [PATCH v3 04/20] PCI/P2PDMA: introduce helpers for dma_map_sg
 implementations
Message-ID: <20210927185348.GA668256@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-5-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 16, 2021 at 05:40:44PM -0600, Logan Gunthorpe wrote:
> Add pci_p2pdma_map_segment() as a helper for simple dma_map_sg()
> implementations. It takes an scatterlist segment that must point to a
> pci_p2pdma struct page and will map it if the mapping requires a bus
> address.
> 
> The return value indicates whether the mapping required a bus address
> or whether the caller still needs to map the segment normally. If the
> segment should not be mapped, -EREMOTEIO is returned.
> 
> This helper uses a state structure to track the changes to the
> pgmap across calls and avoid needing to lookup into the xarray for
> every page.
> 
> Also add pci_p2pdma_map_bus_segment() which is useful for IOMMU
> dma_map_sg() implementations where the sg segment containing the page
> differs from the sg segment containing the DMA address.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Ditto.

> ---
>  drivers/pci/p2pdma.c       | 59 ++++++++++++++++++++++++++++++++++++++
>  include/linux/pci-p2pdma.h | 21 ++++++++++++++
>  2 files changed, 80 insertions(+)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index b656d8c801a7..58c34f1f1473 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -943,6 +943,65 @@ void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>  }
>  EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
>  
> +/**
> + * pci_p2pdma_map_segment - map an sg segment determining the mapping type
> + * @state: State structure that should be declared outside of the for_each_sg()
> + *	loop and initialized to zero.
> + * @dev: DMA device that's doing the mapping operation
> + * @sg: scatterlist segment to map
> + *
> + * This is a helper to be used by non-iommu dma_map_sg() implementations where
> + * the sg segment is the same for the page_link and the dma_address.

s/non-iommu/non-IOMMU/

> + *
> + * Attempt to map a single segment in an SGL with the PCI bus address.
> + * The segment must point to a PCI P2PDMA page and thus must be
> + * wrapped in a is_pci_p2pdma_page(sg_page(sg)) check.
> + *
> + * Returns the type of mapping used and maps the page if the type is
> + * PCI_P2PDMA_MAP_BUS_ADDR.
> + */
> +enum pci_p2pdma_map_type
> +pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
> +		       struct scatterlist *sg)
> +{
> +	if (state->pgmap != sg_page(sg)->pgmap) {
> +		state->pgmap = sg_page(sg)->pgmap;
> +		state->map = pci_p2pdma_map_type(state->pgmap, dev);
> +		state->bus_off = to_p2p_pgmap(state->pgmap)->bus_offset;
> +	}
> +
> +	if (state->map == PCI_P2PDMA_MAP_BUS_ADDR) {
> +		sg->dma_address = sg_phys(sg) + state->bus_off;
> +		sg_dma_len(sg) = sg->length;
> +		sg_dma_mark_pci_p2pdma(sg);
> +	}
> +
> +	return state->map;
> +}
> +
> +/**
> + * pci_p2pdma_map_bus_segment - map an sg segment pre determined to
> + *	be mapped with PCI_P2PDMA_MAP_BUS_ADDR
> + * @pg_sg: scatterlist segment with the page to map
> + * @dma_sg: scatterlist segment to assign a dma address to

s/dma address/DMA address/, also below

> + *
> + * This is a helper for iommu dma_map_sg() implementations when the
> + * segment for the dma address differs from the segment containing the
> + * source page.
> + *
> + * pci_p2pdma_map_type() must have already been called on the pg_sg and
> + * returned PCI_P2PDMA_MAP_BUS_ADDR.
> + */
> +void pci_p2pdma_map_bus_segment(struct scatterlist *pg_sg,
> +				struct scatterlist *dma_sg)
> +{
> +	struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(sg_page(pg_sg)->pgmap);
> +
> +	dma_sg->dma_address = sg_phys(pg_sg) + pgmap->bus_offset;
> +	sg_dma_len(dma_sg) = pg_sg->length;
> +	sg_dma_mark_pci_p2pdma(dma_sg);
> +}
> +
>  /**
>   * pci_p2pdma_enable_store - parse a configfs/sysfs attribute store
>   *		to enable p2pdma
> diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
> index caac2d023f8f..e5a8d5bc0f51 100644
> --- a/include/linux/pci-p2pdma.h
> +++ b/include/linux/pci-p2pdma.h
> @@ -13,6 +13,12 @@
>  
>  #include <linux/pci.h>
>  
> +struct pci_p2pdma_map_state {
> +	struct dev_pagemap *pgmap;
> +	int map;
> +	u64 bus_off;
> +};
> +
>  struct block_device;
>  struct scatterlist;
>  
> @@ -70,6 +76,11 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>  		int nents, enum dma_data_direction dir, unsigned long attrs);
>  void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>  		int nents, enum dma_data_direction dir, unsigned long attrs);
> +enum pci_p2pdma_map_type
> +pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
> +		       struct scatterlist *sg);
> +void pci_p2pdma_map_bus_segment(struct scatterlist *pg_sg,
> +				struct scatterlist *dma_sg);
>  int pci_p2pdma_enable_store(const char *page, struct pci_dev **p2p_dev,
>  			    bool *use_p2pdma);
>  ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
> @@ -135,6 +146,16 @@ static inline void pci_p2pdma_unmap_sg_attrs(struct device *dev,
>  		unsigned long attrs)
>  {
>  }
> +static inline enum pci_p2pdma_map_type
> +pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
> +		       struct scatterlist *sg)
> +{
> +	return PCI_P2PDMA_MAP_NOT_SUPPORTED;
> +}
> +static inline void pci_p2pdma_map_bus_segment(struct scatterlist *pg_sg,
> +					      struct scatterlist *dma_sg)
> +{
> +}
>  static inline int pci_p2pdma_enable_store(const char *page,
>  		struct pci_dev **p2p_dev, bool *use_p2pdma)
>  {
> -- 
> 2.30.2
> 
