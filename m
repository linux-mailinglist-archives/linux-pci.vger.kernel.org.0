Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F76419EA0
	for <lists+linux-pci@lfdr.de>; Mon, 27 Sep 2021 20:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbhI0Sww (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Sep 2021 14:52:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236380AbhI0Swj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Sep 2021 14:52:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9932A60FF2;
        Mon, 27 Sep 2021 18:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632768661;
        bh=k2U75S9hycwPlp5+wID80zDHl//3Y8/paTLDMvAioQM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UiGsmazF0pWnH4PJv++Pc3qoV57uOH08K5QJJNjGF1YcGUP4WV8kgU0kScvdNul0f
         wsFexhiQ+OrXnOMHfhTBDaEwOebbHwizs+TDglY/05m9tFSdRkfw2BPGq5S9irGr4v
         xKCycfmgSfp44hpQbD3NpX0spcoShILfvx6pxDN+hdnBFxmd1nG6YKflsKrINUqr/i
         mODOdQCoSyl+//BrlyHw4aFcrOIfom6oGDPjKUzjmt/OsJt3cocks7xy3gDpYABdqM
         VSiASBD1dlEDX2AtBOYNl4ixAWKOPhe5JI9ce00vwSDeE2hNqp8o8xg5e/lLNSUdSA
         JgnAJe9AfYHlA==
Date:   Mon, 27 Sep 2021 13:50:59 -0500
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
Subject: Re: [PATCH v3 13/20] PCI/P2PDMA: remove pci_p2pdma_[un]map_sg()
Message-ID: <20210927185059.GA668202@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-14-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 16, 2021 at 05:40:53PM -0600, Logan Gunthorpe wrote:
> This interface is superseded by support in dma_map_sg() which now supports
> heterogeneous scatterlists. There are no longer any users, so remove it.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Ditto.

> ---
>  drivers/pci/p2pdma.c       | 65 --------------------------------------
>  include/linux/pci-p2pdma.h | 27 ----------------
>  2 files changed, 92 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 58c34f1f1473..4478633346bd 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -878,71 +878,6 @@ enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
>  	return type;
>  }
>  
> -static int __pci_p2pdma_map_sg(struct pci_p2pdma_pagemap *p2p_pgmap,
> -		struct device *dev, struct scatterlist *sg, int nents)
> -{
> -	struct scatterlist *s;
> -	int i;
> -
> -	for_each_sg(sg, s, nents, i) {
> -		s->dma_address = sg_phys(s) - p2p_pgmap->bus_offset;
> -		sg_dma_len(s) = s->length;
> -	}
> -
> -	return nents;
> -}
> -
> -/**
> - * pci_p2pdma_map_sg_attrs - map a PCI peer-to-peer scatterlist for DMA
> - * @dev: device doing the DMA request
> - * @sg: scatter list to map
> - * @nents: elements in the scatterlist
> - * @dir: DMA direction
> - * @attrs: DMA attributes passed to dma_map_sg() (if called)
> - *
> - * Scatterlists mapped with this function should be unmapped using
> - * pci_p2pdma_unmap_sg_attrs().
> - *
> - * Returns the number of SG entries mapped or 0 on error.
> - */
> -int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
> -		int nents, enum dma_data_direction dir, unsigned long attrs)
> -{
> -	struct pci_p2pdma_pagemap *p2p_pgmap =
> -		to_p2p_pgmap(sg_page(sg)->pgmap);
> -
> -	switch (pci_p2pdma_map_type(sg_page(sg)->pgmap, dev)) {
> -	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> -		return dma_map_sg_attrs(dev, sg, nents, dir, attrs);
> -	case PCI_P2PDMA_MAP_BUS_ADDR:
> -		return __pci_p2pdma_map_sg(p2p_pgmap, dev, sg, nents);
> -	default:
> -		return 0;
> -	}
> -}
> -EXPORT_SYMBOL_GPL(pci_p2pdma_map_sg_attrs);
> -
> -/**
> - * pci_p2pdma_unmap_sg_attrs - unmap a PCI peer-to-peer scatterlist that was
> - *	mapped with pci_p2pdma_map_sg()
> - * @dev: device doing the DMA request
> - * @sg: scatter list to map
> - * @nents: number of elements returned by pci_p2pdma_map_sg()
> - * @dir: DMA direction
> - * @attrs: DMA attributes passed to dma_unmap_sg() (if called)
> - */
> -void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
> -		int nents, enum dma_data_direction dir, unsigned long attrs)
> -{
> -	enum pci_p2pdma_map_type map_type;
> -
> -	map_type = pci_p2pdma_map_type(sg_page(sg)->pgmap, dev);
> -
> -	if (map_type == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE)
> -		dma_unmap_sg_attrs(dev, sg, nents, dir, attrs);
> -}
> -EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
> -
>  /**
>   * pci_p2pdma_map_segment - map an sg segment determining the mapping type
>   * @state: State structure that should be declared outside of the for_each_sg()
> diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
> index e5a8d5bc0f51..0c33a40a86e7 100644
> --- a/include/linux/pci-p2pdma.h
> +++ b/include/linux/pci-p2pdma.h
> @@ -72,10 +72,6 @@ void pci_p2pmem_free_sgl(struct pci_dev *pdev, struct scatterlist *sgl);
>  void pci_p2pmem_publish(struct pci_dev *pdev, bool publish);
>  enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
>  					     struct device *dev);
> -int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
> -		int nents, enum dma_data_direction dir, unsigned long attrs);
> -void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
> -		int nents, enum dma_data_direction dir, unsigned long attrs);
>  enum pci_p2pdma_map_type
>  pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
>  		       struct scatterlist *sg);
> @@ -135,17 +131,6 @@ pci_p2pdma_map_type(struct dev_pagemap *pgmap, struct device *dev)
>  {
>  	return PCI_P2PDMA_MAP_NOT_SUPPORTED;
>  }
> -static inline int pci_p2pdma_map_sg_attrs(struct device *dev,
> -		struct scatterlist *sg, int nents, enum dma_data_direction dir,
> -		unsigned long attrs)
> -{
> -	return 0;
> -}
> -static inline void pci_p2pdma_unmap_sg_attrs(struct device *dev,
> -		struct scatterlist *sg, int nents, enum dma_data_direction dir,
> -		unsigned long attrs)
> -{
> -}
>  static inline enum pci_p2pdma_map_type
>  pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
>  		       struct scatterlist *sg)
> @@ -181,16 +166,4 @@ static inline struct pci_dev *pci_p2pmem_find(struct device *client)
>  	return pci_p2pmem_find_many(&client, 1);
>  }
>  
> -static inline int pci_p2pdma_map_sg(struct device *dev, struct scatterlist *sg,
> -				    int nents, enum dma_data_direction dir)
> -{
> -	return pci_p2pdma_map_sg_attrs(dev, sg, nents, dir, 0);
> -}
> -
> -static inline void pci_p2pdma_unmap_sg(struct device *dev,
> -		struct scatterlist *sg, int nents, enum dma_data_direction dir)
> -{
> -	pci_p2pdma_unmap_sg_attrs(dev, sg, nents, dir, 0);
> -}
> -
>  #endif /* _LINUX_PCI_P2P_H */
> -- 
> 2.30.2
> 
