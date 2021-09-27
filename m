Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E263419E8A
	for <lists+linux-pci@lfdr.de>; Mon, 27 Sep 2021 20:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbhI0Ss3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Sep 2021 14:48:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234211AbhI0Ss2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Sep 2021 14:48:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 351AC60F70;
        Mon, 27 Sep 2021 18:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632768410;
        bh=aAUpJLAvxQ+tHaQKvkiHUoC8zvr3SDhJ8uiCDNoeqXs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qzynkof5Gd1zNVPHo3jVrAnP115kuAFhtBukKFpONdjp87NprCm91HDbrE/owxdhZ
         xxo+KOoGVV8xi+r/xixAGATY/mdBwwFHbvwyMTntL/h4E9NIije4CwzKImO+Ft2TkT
         esRYtMPRx+sjIdI+yAhG+ZMuViJGWjFRbn/mUsDAUOmzw+aAGycJPSGKcxVsrEIzp8
         X0mn6JIfspomXpax77aqWhehi+1mnH/vQ4jhS6hEKe6Mz0SIuDNSMiJKjScDPZ41Nq
         qTUq0ayObtqPUirRQM9z42nmYatHl4UCiTIAydz4MMVW/EurQNGzuSW/wTRFFDwp+A
         k19lzCPqTmXVQ==
Date:   Mon, 27 Sep 2021 13:46:48 -0500
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
Subject: Re: [PATCH v3 03/20] PCI/P2PDMA: make pci_p2pdma_map_type()
 non-static
Message-ID: <20210927184648.GA667259@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-4-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 16, 2021 at 05:40:43PM -0600, Logan Gunthorpe wrote:
> pci_p2pdma_map_type() will be needed by the dma-iommu map_sg
> implementation because it will need to determine the mapping type
> ahead of actually doing the mapping to create the actual iommu mapping.

I don't expect this to go via the PCI tree, but if it did I would
silently:

  s/PCI/P2PDMA: make pci_p2pdma_map_type() non-static/
    PCI/P2PDMA: Expose pci_p2pdma_map_type()/
  s/iommu/IOMMU/

and mention what this patch does in the commit log (in addition to the
subject) and fix a couple minor typos below.

> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/p2pdma.c       | 24 +++++++++++++---------
>  include/linux/pci-p2pdma.h | 41 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 1192c465ba6d..b656d8c801a7 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -20,13 +20,6 @@
>  #include <linux/seq_buf.h>
>  #include <linux/xarray.h>
>  
> -enum pci_p2pdma_map_type {
> -	PCI_P2PDMA_MAP_UNKNOWN = 0,
> -	PCI_P2PDMA_MAP_NOT_SUPPORTED,
> -	PCI_P2PDMA_MAP_BUS_ADDR,
> -	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE,
> -};
> -
>  struct pci_p2pdma {
>  	struct gen_pool *pool;
>  	bool p2pmem_published;
> @@ -841,8 +834,21 @@ void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
>  }
>  EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
>  
> -static enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
> -						    struct device *dev)
> +/**
> + * pci_p2pdma_map_type - return the type of mapping that should be used for
> + *	a given device and pgmap
> + * @pgmap: the pagemap of a page to determine the mapping type for
> + * @dev: device that is mapping the page
> + *
> + * Returns one of:
> + *	PCI_P2PDMA_MAP_NOT_SUPPORTED - The mapping should not be done
> + *	PCI_P2PDMA_MAP_BUS_ADDR - The mapping should use the PCI bus address
> + *	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE - The mapping should be done normally
> + *		using the CPU physical address (in dma-direct) or an IOVA
> + *		mapping for the IOMMU.
> + */
> +enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
> +					     struct device *dev)
>  {
>  	enum pci_p2pdma_map_type type = PCI_P2PDMA_MAP_NOT_SUPPORTED;
>  	struct pci_dev *provider = to_p2p_pgmap(pgmap)->provider;
> diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
> index 8318a97c9c61..caac2d023f8f 100644
> --- a/include/linux/pci-p2pdma.h
> +++ b/include/linux/pci-p2pdma.h
> @@ -16,6 +16,40 @@
>  struct block_device;
>  struct scatterlist;
>  
> +enum pci_p2pdma_map_type {
> +	/*
> +	 * PCI_P2PDMA_MAP_UNKNOWN: Used internally for indicating the mapping
> +	 * type hasn't been calculated yet. Functions that return this enum
> +	 * never return this value.
> +	 */
> +	PCI_P2PDMA_MAP_UNKNOWN = 0,
> +
> +	/*
> +	 * PCI_P2PDMA_MAP_NOT_SUPPORTED: Indicates the transaction will
> +	 * traverse the host bridge and the host bridge is not in the
> +	 * whitelist. DMA Mapping routines should return an error when
> +	 * this is returned.
> +	 */
> +	PCI_P2PDMA_MAP_NOT_SUPPORTED,
> +
> +	/*
> +	 * PCI_P2PDMA_BUS_ADDR: Indicates that two devices can talk to
> +	 * eachother directly through a PCI switch and the transaction will
> +	 * not traverse the host bridge. Such a mapping should program
> +	 * the DMA engine with PCI bus addresses.

s/eachother/each other/

> +	 */
> +	PCI_P2PDMA_MAP_BUS_ADDR,
> +
> +	/*
> +	 * PCI_P2PDMA_MAP_THRU_HOST_BRIDGE: Indicates two devices can talk
> +	 * to eachother, but the transaction traverses a host bridge on the
> +	 * whitelist. In this case, a normal mapping either with CPU physical
> +	 * addresses (in the case of dma-direct) or IOVA addresses (in the
> +	 * case of IOMMUs) should be used to program the DMA engine.

s/eachother/each other/

> +	 */
> +	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE,
> +};
> +
>  #ifdef CONFIG_PCI_P2PDMA
>  int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
>  		u64 offset);
> @@ -30,6 +64,8 @@ struct scatterlist *pci_p2pmem_alloc_sgl(struct pci_dev *pdev,
>  					 unsigned int *nents, u32 length);
>  void pci_p2pmem_free_sgl(struct pci_dev *pdev, struct scatterlist *sgl);
>  void pci_p2pmem_publish(struct pci_dev *pdev, bool publish);
> +enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
> +					     struct device *dev);
>  int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>  		int nents, enum dma_data_direction dir, unsigned long attrs);
>  void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
> @@ -83,6 +119,11 @@ static inline void pci_p2pmem_free_sgl(struct pci_dev *pdev,
>  static inline void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
>  {
>  }
> +static inline enum pci_p2pdma_map_type
> +pci_p2pdma_map_type(struct dev_pagemap *pgmap, struct device *dev)
> +{
> +	return PCI_P2PDMA_MAP_NOT_SUPPORTED;
> +}
>  static inline int pci_p2pdma_map_sg_attrs(struct device *dev,
>  		struct scatterlist *sg, int nents, enum dma_data_direction dir,
>  		unsigned long attrs)
> -- 
> 2.30.2
> 
