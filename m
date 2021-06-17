Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5473ABF81
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jun 2021 01:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbhFQXdS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Jun 2021 19:33:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:49066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233077AbhFQXdP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Jun 2021 19:33:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D38066128B;
        Thu, 17 Jun 2021 23:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623972667;
        bh=fWthFoIm/YEa+gCtln1XDDJSXfB5s/xQ0jk7l7+p7+0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=QWqo3DqxQjEKowfqO/s2UKUn1DguQmxVjG6us/vFiMAFxg5HmszETvkadqrhYhjO6
         p3G1uYRBl3sgiMDwarsK7QN9GUKmY1ppQedxfXy1LWj8nRA+raX38agu6FcFdZE8rE
         u0SnAZ+syPcnB24pk3013wQUUK3otAsHcsjjDaqnsrBDVB5TZNRykVgiRAM8ftohQB
         0zL9uqU+EGZZr7X8V66FRgKnYPrnYunWMJVUC4BfgidwO8ZU2Lg4VckOSqGuRd5+zs
         mHYalEYo2PrV1TSQiwCdtdYcCgfmpjbkd2fkGoESqy5HZncim8JNKQU8S6M5JXt0Mj
         NrYdTfVkjlQUA==
Date:   Thu, 17 Jun 2021 16:31:05 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Claire Chang <tientzu@chromium.org>
cc:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
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
Subject: Re: [PATCH v13 06/12] swiotlb: Use is_swiotlb_force_bounce for
 swiotlb data bouncing
In-Reply-To: <20210617062635.1660944-7-tientzu@chromium.org>
Message-ID: <alpine.DEB.2.21.2106171433560.24906@sstabellini-ThinkPad-T480s>
References: <20210617062635.1660944-1-tientzu@chromium.org> <20210617062635.1660944-7-tientzu@chromium.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 17 Jun 2021, Claire Chang wrote:
> Propagate the swiotlb_force into io_tlb_default_mem->force_bounce and
> use it to determine whether to bounce the data or not. This will be
> useful later to allow for different pools.
> 
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Stefano Stabellini <sstabellini@kernel.org>
> Tested-by: Will Deacon <will@kernel.org>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  drivers/xen/swiotlb-xen.c |  2 +-
>  include/linux/swiotlb.h   | 11 +++++++++++
>  kernel/dma/direct.c       |  2 +-
>  kernel/dma/direct.h       |  2 +-
>  kernel/dma/swiotlb.c      |  4 ++++
>  5 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 0c6ed09f8513..4730a146fa35 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -369,7 +369,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
>  	if (dma_capable(dev, dev_addr, size, true) &&
>  	    !range_straddles_page_boundary(phys, size) &&
>  		!xen_arch_need_swiotlb(dev, phys, dev_addr) &&
> -		swiotlb_force != SWIOTLB_FORCE)
> +		!is_swiotlb_force_bounce(dev))
>  		goto done;
>  
>  	/*
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index dd1c30a83058..8d8855c77d9a 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -84,6 +84,7 @@ extern enum swiotlb_force swiotlb_force;
>   *		unmap calls.
>   * @debugfs:	The dentry to debugfs.
>   * @late_alloc:	%true if allocated using the page allocator
> + * @force_bounce: %true if swiotlb bouncing is forced
>   */
>  struct io_tlb_mem {
>  	phys_addr_t start;
> @@ -94,6 +95,7 @@ struct io_tlb_mem {
>  	spinlock_t lock;
>  	struct dentry *debugfs;
>  	bool late_alloc;
> +	bool force_bounce;
>  	struct io_tlb_slot {
>  		phys_addr_t orig_addr;
>  		size_t alloc_size;
> @@ -109,6 +111,11 @@ static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
>  	return mem && paddr >= mem->start && paddr < mem->end;
>  }
>  
> +static inline bool is_swiotlb_force_bounce(struct device *dev)
> +{
> +	return dev->dma_io_tlb_mem->force_bounce;
> +}
> +
>  void __init swiotlb_exit(void);
>  unsigned int swiotlb_max_segment(void);
>  size_t swiotlb_max_mapping_size(struct device *dev);
> @@ -120,6 +127,10 @@ static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
>  {
>  	return false;
>  }
> +static inline bool is_swiotlb_force_bounce(struct device *dev)
> +{
> +	return false;
> +}
>  static inline void swiotlb_exit(void)
>  {
>  }
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 7a88c34d0867..a92465b4eb12 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -496,7 +496,7 @@ size_t dma_direct_max_mapping_size(struct device *dev)
>  {
>  	/* If SWIOTLB is active, use its maximum mapping size */
>  	if (is_swiotlb_active(dev) &&
> -	    (dma_addressing_limited(dev) || swiotlb_force == SWIOTLB_FORCE))
> +	    (dma_addressing_limited(dev) || is_swiotlb_force_bounce(dev)))
>  		return swiotlb_max_mapping_size(dev);
>  	return SIZE_MAX;
>  }
> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
> index 13e9e7158d94..4632b0f4f72e 100644
> --- a/kernel/dma/direct.h
> +++ b/kernel/dma/direct.h
> @@ -87,7 +87,7 @@ static inline dma_addr_t dma_direct_map_page(struct device *dev,
>  	phys_addr_t phys = page_to_phys(page) + offset;
>  	dma_addr_t dma_addr = phys_to_dma(dev, phys);
>  
> -	if (unlikely(swiotlb_force == SWIOTLB_FORCE))
> +	if (is_swiotlb_force_bounce(dev))
>  		return swiotlb_map(dev, phys, size, dir, attrs);
>  
>  	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 409694d7a8ad..13891d5de8c9 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -179,6 +179,10 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
>  	mem->end = mem->start + bytes;
>  	mem->index = 0;
>  	mem->late_alloc = late_alloc;
> +
> +	if (swiotlb_force == SWIOTLB_FORCE)
> +		mem->force_bounce = true;
> +
>  	spin_lock_init(&mem->lock);
>  	for (i = 0; i < mem->nslabs; i++) {
>  		mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
> -- 
> 2.32.0.288.g62a8d224e6-goog
> 
