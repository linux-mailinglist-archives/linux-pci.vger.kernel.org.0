Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE149D24B
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2019 17:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbfHZPHK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Aug 2019 11:07:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48518 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730826AbfHZPHJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Aug 2019 11:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RPqKPzaEEcJy5R1UqFTMhSXKJI3Vmmv8DkikNGnTSWU=; b=VcxgIC8Mh9aziOM1IbQEWyb6I
        mO6vxZXmzVhQVsSGjE92YUaX1kCy498Ff6ChPJSnGhPWSthqc+qp2T0kzU4Py+Y2VOC4d/Nm7b+yE
        byvT4G6ORzem64Os4w+chBDxeqkq8Uc1JJBo/rZ0Vy9bA0L3Y0wxLrQTDQGcby9wDjtg0G5X0i5dK
        i7nRnNy250w+BpZlAWE0qmS7VbAh7zs21kAlpLqQKDo27NEac8Heu/RI5Z8iwDKpjb/X/0M/yqA3P
        NPW+cXTFnKCrmrhrsXZajZ2bAdxdLbanvEZf9oP/fnihrek03kOZkQmWw7P81eBcuvDj0AL7BGKmg
        2REeRP2Ew==;
Received: from [2001:4bb8:180:3f4c:863:2ead:e9d4:da9f] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2GaA-00066Z-Ec; Mon, 26 Aug 2019 15:06:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org
Cc:     bhelgaas@google.com, dwmw2@infradead.org, joro@8bytes.org,
        keith.busch@intel.com, jonathan.derrick@intel.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vmd: Stop overriding dma_map_ops
Date:   Mon, 26 Aug 2019 17:06:52 +0200
Message-Id: <20190826150652.10316-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With a little tweak to the intel-iommu code we should be able to work
around the VMD mess for the requester IDs without having to create giant
amounts of boilerplate DMA ops wrapping code.  The other advantage of
this scheme is that we can respect the real DMA masks for the actual
devices, and I bet it will only be a matter of time until we'll see the
first DMA challeneged NVMe devices.

The only downside is that we can't offer vmd as a module given that
intel-iommu calls into it.  But the driver only has about 700 lines
of code, so this should not be a major issue.

This also removes the leftover bits of the X86_DEV_DMA_OPS dma_map_ops
registry.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/Kconfig               |   3 -
 arch/x86/include/asm/device.h  |  10 ---
 arch/x86/include/asm/pci.h     |   2 +
 arch/x86/pci/common.c          |  38 ---------
 drivers/iommu/intel-iommu.c    |  33 +++++---
 drivers/pci/controller/Kconfig |   6 +-
 drivers/pci/controller/vmd.c   | 139 +--------------------------------
 7 files changed, 27 insertions(+), 204 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 222855cc0158..35597dae38b7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2905,9 +2905,6 @@ config HAVE_ATOMIC_IOMAP
 	def_bool y
 	depends on X86_32
 
-config X86_DEV_DMA_OPS
-	bool
-
 source "drivers/firmware/Kconfig"
 
 source "arch/x86/kvm/Kconfig"
diff --git a/arch/x86/include/asm/device.h b/arch/x86/include/asm/device.h
index a8f6c809d9b1..3e6c75a6d070 100644
--- a/arch/x86/include/asm/device.h
+++ b/arch/x86/include/asm/device.h
@@ -11,16 +11,6 @@ struct dev_archdata {
 #endif
 };
 
-#if defined(CONFIG_X86_DEV_DMA_OPS) && defined(CONFIG_PCI_DOMAINS)
-struct dma_domain {
-	struct list_head node;
-	const struct dma_map_ops *dma_ops;
-	int domain_nr;
-};
-void add_dma_domain(struct dma_domain *domain);
-void del_dma_domain(struct dma_domain *domain);
-#endif
-
 struct pdev_archdata {
 };
 
diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index e662f987dfa2..f740246ea812 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -73,6 +73,8 @@ static inline bool is_vmd(struct pci_bus *bus)
 #endif
 }
 
+struct device *to_vmd_dev(struct device *dev);
+
 /* Can be used to override the logic in pci_scan_bus for skipping
    already-configured bus numbers - to be used for buggy BIOSes
    or architectures with incomplete PCI setup by the loader */
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 9acab6ac28f5..d2ac803b6c00 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -625,43 +625,6 @@ unsigned int pcibios_assign_all_busses(void)
 	return (pci_probe & PCI_ASSIGN_ALL_BUSSES) ? 1 : 0;
 }
 
-#if defined(CONFIG_X86_DEV_DMA_OPS) && defined(CONFIG_PCI_DOMAINS)
-static LIST_HEAD(dma_domain_list);
-static DEFINE_SPINLOCK(dma_domain_list_lock);
-
-void add_dma_domain(struct dma_domain *domain)
-{
-	spin_lock(&dma_domain_list_lock);
-	list_add(&domain->node, &dma_domain_list);
-	spin_unlock(&dma_domain_list_lock);
-}
-EXPORT_SYMBOL_GPL(add_dma_domain);
-
-void del_dma_domain(struct dma_domain *domain)
-{
-	spin_lock(&dma_domain_list_lock);
-	list_del(&domain->node);
-	spin_unlock(&dma_domain_list_lock);
-}
-EXPORT_SYMBOL_GPL(del_dma_domain);
-
-static void set_dma_domain_ops(struct pci_dev *pdev)
-{
-	struct dma_domain *domain;
-
-	spin_lock(&dma_domain_list_lock);
-	list_for_each_entry(domain, &dma_domain_list, node) {
-		if (pci_domain_nr(pdev->bus) == domain->domain_nr) {
-			pdev->dev.dma_ops = domain->dma_ops;
-			break;
-		}
-	}
-	spin_unlock(&dma_domain_list_lock);
-}
-#else
-static void set_dma_domain_ops(struct pci_dev *pdev) {}
-#endif
-
 static void set_dev_domain_options(struct pci_dev *pdev)
 {
 	if (is_vmd(pdev->bus))
@@ -697,7 +660,6 @@ int pcibios_add_device(struct pci_dev *dev)
 		pa_data = data->next;
 		memunmap(data);
 	}
-	set_dma_domain_ops(dev);
 	set_dev_domain_options(dev);
 	return 0;
 }
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 12d094d08c0a..e8e876605d6a 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3416,9 +3416,14 @@ static struct dmar_domain *get_private_domain_for_dev(struct device *dev)
 	return domain;
 }
 
-/* Check if the dev needs to go through non-identity map and unmap process.*/
-static bool iommu_need_mapping(struct device *dev)
+/*
+ * Check if the dev needs to go through non-identity map and unmap process.
+ * Also where needed replace dev with the actual device used for the mapping
+ * process.
+ */
+static bool iommu_need_mapping(struct device **devp)
 {
+	struct device *dev = *devp;
 	int ret;
 
 	if (iommu_dummy(dev))
@@ -3456,6 +3461,14 @@ static bool iommu_need_mapping(struct device *dev)
 		dev_info(dev, "32bit DMA uses non-identity mapping\n");
 	}
 
+	/*
+	 * For VMD we need to use the VMD devices for mapping requests instead
+	 * of the actual device to get the proper PCIe requester ID.
+	 */
+#ifdef CONFIG_VMD
+	if (dev_is_pci(dev) && is_vmd(to_pci_dev(dev)->bus))
+		*devp = to_vmd_dev(dev);
+#endif
 	return true;
 }
 
@@ -3520,7 +3533,7 @@ static dma_addr_t intel_map_page(struct device *dev, struct page *page,
 				 enum dma_data_direction dir,
 				 unsigned long attrs)
 {
-	if (iommu_need_mapping(dev))
+	if (iommu_need_mapping(&dev))
 		return __intel_map_single(dev, page_to_phys(page) + offset,
 				size, dir, *dev->dma_mask);
 	return dma_direct_map_page(dev, page, offset, size, dir, attrs);
@@ -3530,7 +3543,7 @@ static dma_addr_t intel_map_resource(struct device *dev, phys_addr_t phys_addr,
 				     size_t size, enum dma_data_direction dir,
 				     unsigned long attrs)
 {
-	if (iommu_need_mapping(dev))
+	if (iommu_need_mapping(&dev))
 		return __intel_map_single(dev, phys_addr, size, dir,
 				*dev->dma_mask);
 	return dma_direct_map_resource(dev, phys_addr, size, dir, attrs);
@@ -3585,7 +3598,7 @@ static void intel_unmap_page(struct device *dev, dma_addr_t dev_addr,
 			     size_t size, enum dma_data_direction dir,
 			     unsigned long attrs)
 {
-	if (iommu_need_mapping(dev))
+	if (iommu_need_mapping(&dev))
 		intel_unmap(dev, dev_addr, size);
 	else
 		dma_direct_unmap_page(dev, dev_addr, size, dir, attrs);
@@ -3594,7 +3607,7 @@ static void intel_unmap_page(struct device *dev, dma_addr_t dev_addr,
 static void intel_unmap_resource(struct device *dev, dma_addr_t dev_addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	if (iommu_need_mapping(dev))
+	if (iommu_need_mapping(&dev))
 		intel_unmap(dev, dev_addr, size);
 }
 
@@ -3605,7 +3618,7 @@ static void *intel_alloc_coherent(struct device *dev, size_t size,
 	struct page *page = NULL;
 	int order;
 
-	if (!iommu_need_mapping(dev))
+	if (!iommu_need_mapping(&dev))
 		return dma_direct_alloc(dev, size, dma_handle, flags, attrs);
 
 	size = PAGE_ALIGN(size);
@@ -3641,7 +3654,7 @@ static void intel_free_coherent(struct device *dev, size_t size, void *vaddr,
 	int order;
 	struct page *page = virt_to_page(vaddr);
 
-	if (!iommu_need_mapping(dev))
+	if (!iommu_need_mapping(&dev))
 		return dma_direct_free(dev, size, vaddr, dma_handle, attrs);
 
 	size = PAGE_ALIGN(size);
@@ -3661,7 +3674,7 @@ static void intel_unmap_sg(struct device *dev, struct scatterlist *sglist,
 	struct scatterlist *sg;
 	int i;
 
-	if (!iommu_need_mapping(dev))
+	if (!iommu_need_mapping(&dev))
 		return dma_direct_unmap_sg(dev, sglist, nelems, dir, attrs);
 
 	for_each_sg(sglist, sg, nelems, i) {
@@ -3685,7 +3698,7 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 	struct intel_iommu *iommu;
 
 	BUG_ON(dir == DMA_NONE);
-	if (!iommu_need_mapping(dev))
+	if (!iommu_need_mapping(&dev))
 		return dma_direct_map_sg(dev, sglist, nelems, dir, attrs);
 
 	domain = find_domain(dev);
diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index fe9f9f13ce11..a3a140c7abaf 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -267,8 +267,7 @@ config PCIE_TANGO_SMP8759
 
 config VMD
 	depends on PCI_MSI && X86_64 && SRCU
-	select X86_DEV_DMA_OPS
-	tristate "Intel Volume Management Device Driver"
+	bool "Intel Volume Management Device Driver"
 	---help---
 	  Adds support for the Intel Volume Management Device (VMD). VMD is a
 	  secondary PCI host bridge that allows PCI Express root ports,
@@ -278,8 +277,5 @@ config VMD
 	  single domain. If you know your system provides one of these and
 	  has devices attached to it, say Y; if you are not sure, say N.
 
-	  To compile this driver as a module, choose M here: the
-	  module will be called vmd.
-
 source "drivers/pci/controller/dwc/Kconfig"
 endmenu
diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 4575e0c6dc4b..45c471c48756 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -94,9 +94,6 @@ struct vmd_dev {
 	struct resource		resources[3];
 	struct irq_domain	*irq_domain;
 	struct pci_bus		*bus;
-
-	struct dma_map_ops	dma_ops;
-	struct dma_domain	dma_domain;
 };
 
 static inline struct vmd_dev *vmd_from_bus(struct pci_bus *bus)
@@ -296,7 +293,7 @@ static struct msi_domain_info vmd_msi_domain_info = {
  * VMD domain need to be mapped for the VMD, not the device requiring
  * the mapping.
  */
-static struct device *to_vmd_dev(struct device *dev)
+struct device *to_vmd_dev(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct vmd_dev *vmd = vmd_from_bus(pdev->bus);
@@ -304,138 +301,6 @@ static struct device *to_vmd_dev(struct device *dev)
 	return &vmd->dev->dev;
 }
 
-static void *vmd_alloc(struct device *dev, size_t size, dma_addr_t *addr,
-		       gfp_t flag, unsigned long attrs)
-{
-	return dma_alloc_attrs(to_vmd_dev(dev), size, addr, flag, attrs);
-}
-
-static void vmd_free(struct device *dev, size_t size, void *vaddr,
-		     dma_addr_t addr, unsigned long attrs)
-{
-	return dma_free_attrs(to_vmd_dev(dev), size, vaddr, addr, attrs);
-}
-
-static int vmd_mmap(struct device *dev, struct vm_area_struct *vma,
-		    void *cpu_addr, dma_addr_t addr, size_t size,
-		    unsigned long attrs)
-{
-	return dma_mmap_attrs(to_vmd_dev(dev), vma, cpu_addr, addr, size,
-			attrs);
-}
-
-static int vmd_get_sgtable(struct device *dev, struct sg_table *sgt,
-			   void *cpu_addr, dma_addr_t addr, size_t size,
-			   unsigned long attrs)
-{
-	return dma_get_sgtable_attrs(to_vmd_dev(dev), sgt, cpu_addr, addr, size,
-			attrs);
-}
-
-static dma_addr_t vmd_map_page(struct device *dev, struct page *page,
-			       unsigned long offset, size_t size,
-			       enum dma_data_direction dir,
-			       unsigned long attrs)
-{
-	return dma_map_page_attrs(to_vmd_dev(dev), page, offset, size, dir,
-			attrs);
-}
-
-static void vmd_unmap_page(struct device *dev, dma_addr_t addr, size_t size,
-			   enum dma_data_direction dir, unsigned long attrs)
-{
-	dma_unmap_page_attrs(to_vmd_dev(dev), addr, size, dir, attrs);
-}
-
-static int vmd_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-		      enum dma_data_direction dir, unsigned long attrs)
-{
-	return dma_map_sg_attrs(to_vmd_dev(dev), sg, nents, dir, attrs);
-}
-
-static void vmd_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
-			 enum dma_data_direction dir, unsigned long attrs)
-{
-	dma_unmap_sg_attrs(to_vmd_dev(dev), sg, nents, dir, attrs);
-}
-
-static void vmd_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
-				    size_t size, enum dma_data_direction dir)
-{
-	dma_sync_single_for_cpu(to_vmd_dev(dev), addr, size, dir);
-}
-
-static void vmd_sync_single_for_device(struct device *dev, dma_addr_t addr,
-				       size_t size, enum dma_data_direction dir)
-{
-	dma_sync_single_for_device(to_vmd_dev(dev), addr, size, dir);
-}
-
-static void vmd_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
-				int nents, enum dma_data_direction dir)
-{
-	dma_sync_sg_for_cpu(to_vmd_dev(dev), sg, nents, dir);
-}
-
-static void vmd_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
-				   int nents, enum dma_data_direction dir)
-{
-	dma_sync_sg_for_device(to_vmd_dev(dev), sg, nents, dir);
-}
-
-static int vmd_dma_supported(struct device *dev, u64 mask)
-{
-	return dma_supported(to_vmd_dev(dev), mask);
-}
-
-static u64 vmd_get_required_mask(struct device *dev)
-{
-	return dma_get_required_mask(to_vmd_dev(dev));
-}
-
-static void vmd_teardown_dma_ops(struct vmd_dev *vmd)
-{
-	struct dma_domain *domain = &vmd->dma_domain;
-
-	if (get_dma_ops(&vmd->dev->dev))
-		del_dma_domain(domain);
-}
-
-#define ASSIGN_VMD_DMA_OPS(source, dest, fn)	\
-	do {					\
-		if (source->fn)			\
-			dest->fn = vmd_##fn;	\
-	} while (0)
-
-static void vmd_setup_dma_ops(struct vmd_dev *vmd)
-{
-	const struct dma_map_ops *source = get_dma_ops(&vmd->dev->dev);
-	struct dma_map_ops *dest = &vmd->dma_ops;
-	struct dma_domain *domain = &vmd->dma_domain;
-
-	domain->domain_nr = vmd->sysdata.domain;
-	domain->dma_ops = dest;
-
-	if (!source)
-		return;
-	ASSIGN_VMD_DMA_OPS(source, dest, alloc);
-	ASSIGN_VMD_DMA_OPS(source, dest, free);
-	ASSIGN_VMD_DMA_OPS(source, dest, mmap);
-	ASSIGN_VMD_DMA_OPS(source, dest, get_sgtable);
-	ASSIGN_VMD_DMA_OPS(source, dest, map_page);
-	ASSIGN_VMD_DMA_OPS(source, dest, unmap_page);
-	ASSIGN_VMD_DMA_OPS(source, dest, map_sg);
-	ASSIGN_VMD_DMA_OPS(source, dest, unmap_sg);
-	ASSIGN_VMD_DMA_OPS(source, dest, sync_single_for_cpu);
-	ASSIGN_VMD_DMA_OPS(source, dest, sync_single_for_device);
-	ASSIGN_VMD_DMA_OPS(source, dest, sync_sg_for_cpu);
-	ASSIGN_VMD_DMA_OPS(source, dest, sync_sg_for_device);
-	ASSIGN_VMD_DMA_OPS(source, dest, dma_supported);
-	ASSIGN_VMD_DMA_OPS(source, dest, get_required_mask);
-	add_dma_domain(domain);
-}
-#undef ASSIGN_VMD_DMA_OPS
-
 static char __iomem *vmd_cfg_addr(struct vmd_dev *vmd, struct pci_bus *bus,
 				  unsigned int devfn, int reg, int len)
 {
@@ -690,7 +555,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	}
 
 	vmd_attach_resources(vmd);
-	vmd_setup_dma_ops(vmd);
 	dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
 
 	pci_scan_child_bus(vmd->bus);
@@ -805,7 +669,6 @@ static void vmd_remove(struct pci_dev *dev)
 	pci_stop_root_bus(vmd->bus);
 	pci_remove_root_bus(vmd->bus);
 	vmd_cleanup_srcu(vmd);
-	vmd_teardown_dma_ops(vmd);
 	vmd_detach_resources(vmd);
 	irq_domain_remove(vmd->irq_domain);
 }
-- 
2.20.1

