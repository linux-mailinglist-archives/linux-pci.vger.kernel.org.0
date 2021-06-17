Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7F23ABF79
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jun 2021 01:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbhFQXdL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Jun 2021 19:33:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232978AbhFQXdK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Jun 2021 19:33:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1A5961249;
        Thu, 17 Jun 2021 23:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623972662;
        bh=jaTzVmgcSfCX/j7A0Q3wWD+e8d+fiEhtBDeTOvUECQg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Vu+FVgRFo8gjxJSbcRPtU5hVDRrL1t6lz+O6xlDZMyaHlVsd0LvbSMCvtJgk20TJP
         PlQx+1Ru0/4CFPzGCZyS05uIuNhxW6cNPonigwh6cnA9SwWSLRdrB+T/t4Fqu6a6wM
         BMLE4koVKY0dZPAIyMP/wWHDeP1vXEKxcZWyMm6+3nM5SOR97ZzKQVFtQxUYkQFMiH
         bijXvEkfzsyMcHYI3Z9pagC6MT2NBZr9zSAstJZean3wmyt3vZHquCRLswFSMjfh1+
         dUjtyU5okd2qgQNfKofiP6hT4HJPkGwlQ/ddRaj111+1534wu5MlmE9XEwlp1tycWR
         dWkN61b6c9C2A==
Date:   Thu, 17 Jun 2021 16:30:59 -0700 (PDT)
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
Subject: Re: [PATCH v13 05/12] swiotlb: Update is_swiotlb_active to add a
 struct device argument
In-Reply-To: <20210617062635.1660944-6-tientzu@chromium.org>
Message-ID: <alpine.DEB.2.21.2106171448050.24906@sstabellini-ThinkPad-T480s>
References: <20210617062635.1660944-1-tientzu@chromium.org> <20210617062635.1660944-6-tientzu@chromium.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 17 Jun 2021, Claire Chang wrote:
> Update is_swiotlb_active to add a struct device argument. This will be
> useful later to allow for different pools.
> 
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Stefano Stabellini <sstabellini@kernel.org>
> Tested-by: Will Deacon <will@kernel.org>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  drivers/gpu/drm/i915/gem/i915_gem_internal.c | 2 +-
>  drivers/gpu/drm/nouveau/nouveau_ttm.c        | 2 +-
>  drivers/pci/xen-pcifront.c                   | 2 +-
>  include/linux/swiotlb.h                      | 4 ++--
>  kernel/dma/direct.c                          | 2 +-
>  kernel/dma/swiotlb.c                         | 4 ++--
>  6 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_internal.c b/drivers/gpu/drm/i915/gem/i915_gem_internal.c
> index a9d65fc8aa0e..4b7afa0fc85d 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_internal.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_internal.c
> @@ -42,7 +42,7 @@ static int i915_gem_object_get_pages_internal(struct drm_i915_gem_object *obj)
>  
>  	max_order = MAX_ORDER;
>  #ifdef CONFIG_SWIOTLB
> -	if (is_swiotlb_active()) {
> +	if (is_swiotlb_active(obj->base.dev->dev)) {
>  		unsigned int max_segment;
>  
>  		max_segment = swiotlb_max_segment();
> diff --git a/drivers/gpu/drm/nouveau/nouveau_ttm.c b/drivers/gpu/drm/nouveau/nouveau_ttm.c
> index 9662522aa066..be15bfd9e0ee 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_ttm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_ttm.c
> @@ -321,7 +321,7 @@ nouveau_ttm_init(struct nouveau_drm *drm)
>  	}
>  
>  #if IS_ENABLED(CONFIG_SWIOTLB) && IS_ENABLED(CONFIG_X86)
> -	need_swiotlb = is_swiotlb_active();
> +	need_swiotlb = is_swiotlb_active(dev->dev);
>  #endif
>  
>  	ret = ttm_bo_device_init(&drm->ttm.bdev, &nouveau_bo_driver,
> diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
> index b7a8f3a1921f..0d56985bfe81 100644
> --- a/drivers/pci/xen-pcifront.c
> +++ b/drivers/pci/xen-pcifront.c
> @@ -693,7 +693,7 @@ static int pcifront_connect_and_init_dma(struct pcifront_device *pdev)
>  
>  	spin_unlock(&pcifront_dev_lock);
>  
> -	if (!err && !is_swiotlb_active()) {
> +	if (!err && !is_swiotlb_active(&pdev->xdev->dev)) {
>  		err = pci_xen_swiotlb_init_late();
>  		if (err)
>  			dev_err(&pdev->xdev->dev, "Could not setup SWIOTLB!\n");
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index d1f3d95881cd..dd1c30a83058 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -112,7 +112,7 @@ static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
>  void __init swiotlb_exit(void);
>  unsigned int swiotlb_max_segment(void);
>  size_t swiotlb_max_mapping_size(struct device *dev);
> -bool is_swiotlb_active(void);
> +bool is_swiotlb_active(struct device *dev);
>  void __init swiotlb_adjust_size(unsigned long size);
>  #else
>  #define swiotlb_force SWIOTLB_NO_FORCE
> @@ -132,7 +132,7 @@ static inline size_t swiotlb_max_mapping_size(struct device *dev)
>  	return SIZE_MAX;
>  }
>  
> -static inline bool is_swiotlb_active(void)
> +static inline bool is_swiotlb_active(struct device *dev)
>  {
>  	return false;
>  }
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 84c9feb5474a..7a88c34d0867 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -495,7 +495,7 @@ int dma_direct_supported(struct device *dev, u64 mask)
>  size_t dma_direct_max_mapping_size(struct device *dev)
>  {
>  	/* If SWIOTLB is active, use its maximum mapping size */
> -	if (is_swiotlb_active() &&
> +	if (is_swiotlb_active(dev) &&
>  	    (dma_addressing_limited(dev) || swiotlb_force == SWIOTLB_FORCE))
>  		return swiotlb_max_mapping_size(dev);
>  	return SIZE_MAX;
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index de79e9437030..409694d7a8ad 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -664,9 +664,9 @@ size_t swiotlb_max_mapping_size(struct device *dev)
>  	return ((size_t)IO_TLB_SIZE) * IO_TLB_SEGSIZE;
>  }
>  
> -bool is_swiotlb_active(void)
> +bool is_swiotlb_active(struct device *dev)
>  {
> -	return io_tlb_default_mem != NULL;
> +	return dev->dma_io_tlb_mem != NULL;
>  }
>  EXPORT_SYMBOL_GPL(is_swiotlb_active);
>  
> -- 
> 2.32.0.288.g62a8d224e6-goog
> 
