Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD391428A6
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2020 11:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgATK67 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jan 2020 05:58:59 -0500
Received: from foss.arm.com ([217.140.110.172]:58424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgATK66 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Jan 2020 05:58:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEFF730E;
        Mon, 20 Jan 2020 02:58:57 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A4163F68E;
        Mon, 20 Jan 2020 02:58:56 -0800 (PST)
Date:   Mon, 20 Jan 2020 10:58:51 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 6/7] PCI: vmd: Stop overriding dma_map_ops
Message-ID: <20200120105851.GA17267@e121166-lin.cambridge.arm.com>
References: <1579278449-174098-1-git-send-email-jonathan.derrick@intel.com>
 <1579278449-174098-7-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579278449-174098-7-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 17, 2020 at 09:27:28AM -0700, Jon Derrick wrote:
> Devices on the VMD domain use the VMD endpoint's requester ID and have
> been relying on the VMD endpoint's DMA operations. The problem with this
> was that VMD domain devices would use the VMD endpoint's attributes when
> doing DMA and IOMMU mapping. We can be smarter about this by only using
> the VMD endpoint when mapping and providing the correct child device's
> attributes during DMA operations.
> 
> This patch removes the dma_map_ops redirect.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/pci/controller/Kconfig |   1 -
>  drivers/pci/controller/vmd.c   | 150 -----------------------------------------
>  2 files changed, 151 deletions(-)

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 918e283..20bf00f 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -239,7 +239,6 @@ config PCIE_TANGO_SMP8759
>  
>  config VMD
>  	depends on PCI_MSI && X86_64 && SRCU
> -	select X86_DEV_DMA_OPS
>  	tristate "Intel Volume Management Device Driver"
>  	---help---
>  	  Adds support for the Intel Volume Management Device (VMD). VMD is a
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index d67ad56..fe1acb0 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -98,9 +98,6 @@ struct vmd_dev {
>  	struct irq_domain	*irq_domain;
>  	struct pci_bus		*bus;
>  	u8			busn_start;
> -
> -	struct dma_map_ops	dma_ops;
> -	struct dma_domain	dma_domain;
>  };
>  
>  static inline struct vmd_dev *vmd_from_bus(struct pci_bus *bus)
> @@ -295,151 +292,6 @@ static void vmd_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
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
> @@ -709,7 +561,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	}
>  
>  	vmd_attach_resources(vmd);
> -	vmd_setup_dma_ops(vmd);
>  	dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
>  
>  	pci_scan_child_bus(vmd->bus);
> @@ -824,7 +675,6 @@ static void vmd_remove(struct pci_dev *dev)
>  	pci_stop_root_bus(vmd->bus);
>  	pci_remove_root_bus(vmd->bus);
>  	vmd_cleanup_srcu(vmd);
> -	vmd_teardown_dma_ops(vmd);
>  	vmd_detach_resources(vmd);
>  	irq_domain_remove(vmd->irq_domain);
>  }
> -- 
> 1.8.3.1
> 
