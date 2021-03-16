Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC0E33CF73
	for <lists+linux-pci@lfdr.de>; Tue, 16 Mar 2021 09:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbhCPIOi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Mar 2021 04:14:38 -0400
Received: from verein.lst.de ([213.95.11.211]:59001 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231631AbhCPIOV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Mar 2021 04:14:21 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0CBD768C4E; Tue, 16 Mar 2021 09:14:17 +0100 (CET)
Date:   Tue, 16 Mar 2021 09:14:16 +0100
From:   Christoph Hellwig <hch@lst.de>
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
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>
Subject: Re: [RFC PATCH v2 04/11] PCI/P2PDMA: Introduce
 pci_p2pdma_should_map_bus() and pci_p2pdma_bus_offset()
Message-ID: <20210316081416.GB16595@lst.de>
References: <20210311233142.7900-1-logang@deltatee.com> <20210311233142.7900-5-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311233142.7900-5-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 11, 2021 at 04:31:34PM -0700, Logan Gunthorpe wrote:
> Introduce pci_p2pdma_should_map_bus() which is meant to be called by
> DMA map functions to determine how to map a given p2pdma page.
> 
> pci_p2pdma_bus_offset() is also added to allow callers to get the bus
> offset if they need to map the bus address.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/pci/p2pdma.c       | 50 ++++++++++++++++++++++++++++++++++++++
>  include/linux/pci-p2pdma.h | 11 +++++++++
>  2 files changed, 61 insertions(+)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 7f6836732bce..66d16b7eb668 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -912,6 +912,56 @@ void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>  }
>  EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
>  
> +/**
> + * pci_p2pdma_bus_offset - returns the bus offset for a given page
> + * @page: page to get the offset for
> + *
> + * Must be passed a PCI p2pdma page.
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

I don't see why this would be exported.  

> +EXPORT_SYMBOL_GPL(pci_p2pdma_dma_map_type);

Same here.  Also the two helpers don't really look very related.

I suspect you really want to move the p2p handling bits currenly added
to kernel/dma/direct.c into drivers/pci/p2pdma.c instead, as that will
allow direct access to the pci_p2pdma_pagemap and should thus simplify
things quite a bit.
