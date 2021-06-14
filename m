Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224853A5D02
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jun 2021 08:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhFNG1h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Jun 2021 02:27:37 -0400
Received: from verein.lst.de ([213.95.11.211]:42794 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232134AbhFNG1f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Jun 2021 02:27:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BF02567373; Mon, 14 Jun 2021 08:25:30 +0200 (CEST)
Date:   Mon, 14 Jun 2021 08:25:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Claire Chang <tientzu@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        sstabellini@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        grant.likely@arm.com, xypron.glpk@gmx.de,
        Thierry Reding <treding@nvidia.com>, mingo@kernel.org,
        bauerman@linux.ibm.com, peterz@infradead.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        heikki.krogerus@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, xen-devel@lists.xenproject.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jim Quinlan <james.quinlan@broadcom.com>, tfiga@chromium.org,
        bskeggs@redhat.com, bhelgaas@google.com, chris@chris-wilson.co.uk,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
        jxgao@google.com, joonas.lahtinen@linux.intel.com,
        linux-pci@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        matthew.auld@intel.com, rodrigo.vivi@intel.com,
        thomas.hellstrom@linux.intel.com
Subject: Re: [PATCH v9 07/14] swiotlb: Bounce data from/to restricted DMA
 pool if available
Message-ID: <20210614062530.GG28343@lst.de>
References: <20210611152659.2142983-1-tientzu@chromium.org> <20210611152659.2142983-8-tientzu@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611152659.2142983-8-tientzu@chromium.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 11, 2021 at 11:26:52PM +0800, Claire Chang wrote:
> Regardless of swiotlb setting, the restricted DMA pool is preferred if
> available.
> 
> The restricted DMA pools provide a basic level of protection against the
> DMA overwriting buffer contents at unexpected times. However, to protect
> against general data leakage and system memory corruption, the system
> needs to provide a way to lock down the memory access, e.g., MPU.
> 
> Note that is_dev_swiotlb_force doesn't check if
> swiotlb_force == SWIOTLB_FORCE. Otherwise the memory allocation behavior
> with default swiotlb will be changed by the following patche
> ("dma-direct: Allocate memory from restricted DMA pool if available").
> 
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> ---
>  include/linux/swiotlb.h | 10 +++++++++-
>  kernel/dma/direct.c     |  3 ++-
>  kernel/dma/direct.h     |  3 ++-
>  kernel/dma/swiotlb.c    |  1 +
>  4 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 06cf17a80f5c..8200c100fe10 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -85,6 +85,7 @@ extern enum swiotlb_force swiotlb_force;
>   *		unmap calls.
>   * @debugfs:	The dentry to debugfs.
>   * @late_alloc:	%true if allocated using the page allocator
> + * @force_swiotlb: %true if swiotlb is forced
>   */
>  struct io_tlb_mem {
>  	phys_addr_t start;
> @@ -95,6 +96,7 @@ struct io_tlb_mem {
>  	spinlock_t lock;
>  	struct dentry *debugfs;
>  	bool late_alloc;
> +	bool force_swiotlb;
>  	struct io_tlb_slot {
>  		phys_addr_t orig_addr;
>  		size_t alloc_size;
> @@ -115,6 +117,11 @@ static inline void swiotlb_set_io_tlb_default_mem(struct device *dev)
>  	dev->dma_io_tlb_mem = io_tlb_default_mem;
>  }
>  
> +static inline bool is_dev_swiotlb_force(struct device *dev)
> +{
> +	return dev->dma_io_tlb_mem->force_swiotlb;
> +}
> +
>  void __init swiotlb_exit(void);
>  unsigned int swiotlb_max_segment(void);
>  size_t swiotlb_max_mapping_size(struct device *dev);
> @@ -126,8 +133,9 @@ static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
>  {
>  	return false;
>  }
> -static inline void swiotlb_set_io_tlb_default_mem(struct device *dev)
> +static inline bool is_dev_swiotlb_force(struct device *dev)
>  {
> +	return false;
>  }
>  static inline void swiotlb_exit(void)
>  {
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 7a88c34d0867..078f7087e466 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -496,7 +496,8 @@ size_t dma_direct_max_mapping_size(struct device *dev)
>  {
>  	/* If SWIOTLB is active, use its maximum mapping size */
>  	if (is_swiotlb_active(dev) &&
> -	    (dma_addressing_limited(dev) || swiotlb_force == SWIOTLB_FORCE))
> +	    (dma_addressing_limited(dev) || swiotlb_force == SWIOTLB_FORCE ||
> +	     is_dev_swiotlb_force(dev)))

I think we can remove the extra swiotlb_force check here if the
swiotlb_force setting is propagated into io_tlb_default_mem->force
when that is initialized. This avoids an extra check in the fast path.

> -	if (unlikely(swiotlb_force == SWIOTLB_FORCE))
> +	if (unlikely(swiotlb_force == SWIOTLB_FORCE) ||
> +	    is_dev_swiotlb_force(dev))

Same here.
