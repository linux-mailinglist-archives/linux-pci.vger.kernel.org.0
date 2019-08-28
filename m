Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAD4DA0584
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 17:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfH1PCx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 11:02:53 -0400
Received: from mga04.intel.com ([192.55.52.120]:2266 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbfH1PCx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Aug 2019 11:02:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 08:02:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,441,1559545200"; 
   d="scan'208";a="171567015"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga007.jf.intel.com with ESMTP; 28 Aug 2019 08:02:51 -0700
Date:   Wed, 28 Aug 2019 09:01:06 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Derrick, Jonathan" <jonathan.derrick@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] PCI/vmd: Stop overriding dma_map_ops
Message-ID: <20190828150106.GD23412@localhost.localdomain>
References: <20190828141443.5253-1-hch@lst.de>
 <20190828141443.5253-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828141443.5253-5-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 28, 2019 at 07:14:42AM -0700, Christoph Hellwig wrote:
> With a little tweak to the intel-iommu code we should be able to work
> around the VMD mess for the requester IDs without having to create giant
> amounts of boilerplate DMA ops wrapping code.  The other advantage of
> this scheme is that we can respect the real DMA masks for the actual
> devices, and I bet it will only be a matter of time until we'll see the
> first DMA challeneged NVMe devices.

This tests out fine on VMD hardware, but it's quite different than the
previous patch. In v1, the original dev was used in iommu_need_mapping(),
but this time it's the vmd device. Is this still using the actual device's
DMA mask then?


> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/iommu/intel-iommu.c    |  25 ++++++
>  drivers/pci/controller/Kconfig |   1 -
>  drivers/pci/controller/vmd.c   | 150 ---------------------------------
>  3 files changed, 25 insertions(+), 151 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 12d094d08c0a..aaa35ac73956 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -373,6 +373,23 @@ EXPORT_SYMBOL_GPL(intel_iommu_gfx_mapped);
>  static DEFINE_SPINLOCK(device_domain_lock);
>  static LIST_HEAD(device_domain_list);
>  
> +/*
> + * For VMD we need to use the VMD devices for mapping requests instead of the
> + * actual device to get the proper PCIe requester ID.
> + */
> +static inline struct device *vmd_real_dev(struct device *dev)
> +{
> +#if IS_ENABLED(CONFIG_VMD)
> +	if (dev_is_pci(dev)) {
> +		struct pci_sysdata *sd = to_pci_dev(dev)->bus->sysdata;
> +
> +		if (sd->vmd_dev)
> +			return sd->vmd_dev;
> +	}
> +#endif
> +	return dev;
> +}
> +
>  /*
>   * Iterate over elements in device_domain_list and call the specified
>   * callback @fn against each element.
> @@ -3520,6 +3537,7 @@ static dma_addr_t intel_map_page(struct device *dev, struct page *page,
>  				 enum dma_data_direction dir,
>  				 unsigned long attrs)
>  {
> +	dev = vmd_real_dev(dev);
>  	if (iommu_need_mapping(dev))
>  		return __intel_map_single(dev, page_to_phys(page) + offset,
>  				size, dir, *dev->dma_mask);
> @@ -3530,6 +3548,7 @@ static dma_addr_t intel_map_resource(struct device *dev, phys_addr_t phys_addr,
>  				     size_t size, enum dma_data_direction dir,
>  				     unsigned long attrs)
>  {
> +	dev = vmd_real_dev(dev);
>  	if (iommu_need_mapping(dev))
>  		return __intel_map_single(dev, phys_addr, size, dir,
>  				*dev->dma_mask);
> @@ -3585,6 +3604,7 @@ static void intel_unmap_page(struct device *dev, dma_addr_t dev_addr,
>  			     size_t size, enum dma_data_direction dir,
>  			     unsigned long attrs)
>  {
> +	dev = vmd_real_dev(dev);
>  	if (iommu_need_mapping(dev))
>  		intel_unmap(dev, dev_addr, size);
>  	else
> @@ -3594,6 +3614,7 @@ static void intel_unmap_page(struct device *dev, dma_addr_t dev_addr,
>  static void intel_unmap_resource(struct device *dev, dma_addr_t dev_addr,
>  		size_t size, enum dma_data_direction dir, unsigned long attrs)
>  {
> +	dev = vmd_real_dev(dev);
>  	if (iommu_need_mapping(dev))
>  		intel_unmap(dev, dev_addr, size);
>  }
> @@ -3605,6 +3626,7 @@ static void *intel_alloc_coherent(struct device *dev, size_t size,
>  	struct page *page = NULL;
>  	int order;
>  
> +	dev = vmd_real_dev(dev);
>  	if (!iommu_need_mapping(dev))
>  		return dma_direct_alloc(dev, size, dma_handle, flags, attrs);
>  
> @@ -3641,6 +3663,7 @@ static void intel_free_coherent(struct device *dev, size_t size, void *vaddr,
>  	int order;
>  	struct page *page = virt_to_page(vaddr);
>  
> +	dev = vmd_real_dev(dev);
>  	if (!iommu_need_mapping(dev))
>  		return dma_direct_free(dev, size, vaddr, dma_handle, attrs);
>  
> @@ -3661,6 +3684,7 @@ static void intel_unmap_sg(struct device *dev, struct scatterlist *sglist,
>  	struct scatterlist *sg;
>  	int i;
>  
> +	dev = vmd_real_dev(dev);
>  	if (!iommu_need_mapping(dev))
>  		return dma_direct_unmap_sg(dev, sglist, nelems, dir, attrs);
>  
> @@ -3685,6 +3709,7 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
>  	struct intel_iommu *iommu;
>  
>  	BUG_ON(dir == DMA_NONE);
> +	dev = vmd_real_dev(dev);
>  	if (!iommu_need_mapping(dev))
>  		return dma_direct_map_sg(dev, sglist, nelems, dir, attrs);
>  
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index fe9f9f13ce11..920546cb84e2 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -267,7 +267,6 @@ config PCIE_TANGO_SMP8759
>  
>  config VMD
>  	depends on PCI_MSI && X86_64 && SRCU
> -	select X86_DEV_DMA_OPS
>  	tristate "Intel Volume Management Device Driver"
>  	---help---
>  	  Adds support for the Intel Volume Management Device (VMD). VMD is a
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 785cb657c8c2..ba017ebba6a7 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -94,9 +94,6 @@ struct vmd_dev {
>  	struct resource		resources[3];
>  	struct irq_domain	*irq_domain;
>  	struct pci_bus		*bus;
> -
> -	struct dma_map_ops	dma_ops;
> -	struct dma_domain	dma_domain;
>  };
>  
>  static inline struct vmd_dev *vmd_from_bus(struct pci_bus *bus)
> @@ -291,151 +288,6 @@ static struct msi_domain_info vmd_msi_domain_info = {
>  	.chip		= &vmd_msi_controller,
>  };
>  
> -/*
> - * VMD replaces the requester ID with its own.  DMA mappings for devices in a
> - * VMD domain need to be mapped for the VMD, not the device requiring
> - * the mapping.
> - */
> -static struct device *to_vmd_dev(struct device *dev)
> -{
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -	struct vmd_dev *vmd = vmd_from_bus(pdev->bus);
> -
> -	return &vmd->dev->dev;
> -}
> -
> -static void *vmd_alloc(struct device *dev, size_t size, dma_addr_t *addr,
> -		       gfp_t flag, unsigned long attrs)
> -{
> -	return dma_alloc_attrs(to_vmd_dev(dev), size, addr, flag, attrs);
> -}
> -
> -static void vmd_free(struct device *dev, size_t size, void *vaddr,
> -		     dma_addr_t addr, unsigned long attrs)
> -{
> -	return dma_free_attrs(to_vmd_dev(dev), size, vaddr, addr, attrs);
> -}
> -
> -static int vmd_mmap(struct device *dev, struct vm_area_struct *vma,
> -		    void *cpu_addr, dma_addr_t addr, size_t size,
> -		    unsigned long attrs)
> -{
> -	return dma_mmap_attrs(to_vmd_dev(dev), vma, cpu_addr, addr, size,
> -			attrs);
> -}
> -
> -static int vmd_get_sgtable(struct device *dev, struct sg_table *sgt,
> -			   void *cpu_addr, dma_addr_t addr, size_t size,
> -			   unsigned long attrs)
> -{
> -	return dma_get_sgtable_attrs(to_vmd_dev(dev), sgt, cpu_addr, addr, size,
> -			attrs);
> -}
> -
> -static dma_addr_t vmd_map_page(struct device *dev, struct page *page,
> -			       unsigned long offset, size_t size,
> -			       enum dma_data_direction dir,
> -			       unsigned long attrs)
> -{
> -	return dma_map_page_attrs(to_vmd_dev(dev), page, offset, size, dir,
> -			attrs);
> -}
> -
> -static void vmd_unmap_page(struct device *dev, dma_addr_t addr, size_t size,
> -			   enum dma_data_direction dir, unsigned long attrs)
> -{
> -	dma_unmap_page_attrs(to_vmd_dev(dev), addr, size, dir, attrs);
> -}
> -
> -static int vmd_map_sg(struct device *dev, struct scatterlist *sg, int nents,
> -		      enum dma_data_direction dir, unsigned long attrs)
> -{
> -	return dma_map_sg_attrs(to_vmd_dev(dev), sg, nents, dir, attrs);
> -}
> -
> -static void vmd_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
> -			 enum dma_data_direction dir, unsigned long attrs)
> -{
> -	dma_unmap_sg_attrs(to_vmd_dev(dev), sg, nents, dir, attrs);
> -}
> -
> -static void vmd_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
> -				    size_t size, enum dma_data_direction dir)
> -{
> -	dma_sync_single_for_cpu(to_vmd_dev(dev), addr, size, dir);
> -}
> -
> -static void vmd_sync_single_for_device(struct device *dev, dma_addr_t addr,
> -				       size_t size, enum dma_data_direction dir)
> -{
> -	dma_sync_single_for_device(to_vmd_dev(dev), addr, size, dir);
> -}
> -
> -static void vmd_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
> -				int nents, enum dma_data_direction dir)
> -{
> -	dma_sync_sg_for_cpu(to_vmd_dev(dev), sg, nents, dir);
> -}
> -
> -static void vmd_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
> -				   int nents, enum dma_data_direction dir)
> -{
> -	dma_sync_sg_for_device(to_vmd_dev(dev), sg, nents, dir);
> -}
> -
> -static int vmd_dma_supported(struct device *dev, u64 mask)
> -{
> -	return dma_supported(to_vmd_dev(dev), mask);
> -}
> -
> -static u64 vmd_get_required_mask(struct device *dev)
> -{
> -	return dma_get_required_mask(to_vmd_dev(dev));
> -}
> -
> -static void vmd_teardown_dma_ops(struct vmd_dev *vmd)
> -{
> -	struct dma_domain *domain = &vmd->dma_domain;
> -
> -	if (get_dma_ops(&vmd->dev->dev))
> -		del_dma_domain(domain);
> -}
> -
> -#define ASSIGN_VMD_DMA_OPS(source, dest, fn)	\
> -	do {					\
> -		if (source->fn)			\
> -			dest->fn = vmd_##fn;	\
> -	} while (0)
> -
> -static void vmd_setup_dma_ops(struct vmd_dev *vmd)
> -{
> -	const struct dma_map_ops *source = get_dma_ops(&vmd->dev->dev);
> -	struct dma_map_ops *dest = &vmd->dma_ops;
> -	struct dma_domain *domain = &vmd->dma_domain;
> -
> -	domain->domain_nr = vmd->sysdata.domain;
> -	domain->dma_ops = dest;
> -
> -	if (!source)
> -		return;
> -	ASSIGN_VMD_DMA_OPS(source, dest, alloc);
> -	ASSIGN_VMD_DMA_OPS(source, dest, free);
> -	ASSIGN_VMD_DMA_OPS(source, dest, mmap);
> -	ASSIGN_VMD_DMA_OPS(source, dest, get_sgtable);
> -	ASSIGN_VMD_DMA_OPS(source, dest, map_page);
> -	ASSIGN_VMD_DMA_OPS(source, dest, unmap_page);
> -	ASSIGN_VMD_DMA_OPS(source, dest, map_sg);
> -	ASSIGN_VMD_DMA_OPS(source, dest, unmap_sg);
> -	ASSIGN_VMD_DMA_OPS(source, dest, sync_single_for_cpu);
> -	ASSIGN_VMD_DMA_OPS(source, dest, sync_single_for_device);
> -	ASSIGN_VMD_DMA_OPS(source, dest, sync_sg_for_cpu);
> -	ASSIGN_VMD_DMA_OPS(source, dest, sync_sg_for_device);
> -	ASSIGN_VMD_DMA_OPS(source, dest, dma_supported);
> -	ASSIGN_VMD_DMA_OPS(source, dest, get_required_mask);
> -	add_dma_domain(domain);
> -}
> -#undef ASSIGN_VMD_DMA_OPS
> -
>  static char __iomem *vmd_cfg_addr(struct vmd_dev *vmd, struct pci_bus *bus,
>  				  unsigned int devfn, int reg, int len)
>  {
> @@ -690,7 +542,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	}
>  
>  	vmd_attach_resources(vmd);
> -	vmd_setup_dma_ops(vmd);
>  	dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
>  
>  	pci_scan_child_bus(vmd->bus);
> @@ -805,7 +656,6 @@ static void vmd_remove(struct pci_dev *dev)
>  	pci_stop_root_bus(vmd->bus);
>  	pci_remove_root_bus(vmd->bus);
>  	vmd_cleanup_srcu(vmd);
> -	vmd_teardown_dma_ops(vmd);
>  	vmd_detach_resources(vmd);
>  	irq_domain_remove(vmd->irq_domain);
>  }
> -- 
> 2.20.1
> 
