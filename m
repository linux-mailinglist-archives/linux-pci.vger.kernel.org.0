Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFEB61361D3
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2020 21:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgAIUdo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jan 2020 15:33:44 -0500
Received: from mga01.intel.com ([192.55.52.88]:37112 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727738AbgAIUdo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jan 2020 15:33:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 12:33:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,414,1571727600"; 
   d="scan'208";a="396206720"
Received: from unknown (HELO nsgsw-rhel7p6.lm.intel.com) ([10.232.116.226])
  by orsmga005.jf.intel.com with ESMTP; 09 Jan 2020 12:33:43 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <iommu@lists.linux-foundation.org>, <linux-pci@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v2 4/5] PCI: vmd: Stop overriding dma_map_ops
Date:   Thu,  9 Jan 2020 07:30:55 -0700
Message-Id: <1578580256-3483-5-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578580256-3483-1-git-send-email-jonathan.derrick@intel.com>
References: <1578580256-3483-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Devices on the VMD domain use the VMD endpoint's requester-id and have
been relying on the VMD endpoint's dma operations. The downside of this
was that VMD domain devices would use the VMD endpoint's attributes when
doing DMA and IOMMU mapping. We can be smarter about this by only using
the VMD endpoint when mapping and providing the correct child device's
attributes during dma operations.

This patch modifies intel-iommu to check for a 'direct dma alias' and
refer to it for mapping.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/iommu/intel-iommu.c    |  17 +++--
 drivers/pci/controller/Kconfig |   1 -
 drivers/pci/controller/vmd.c   | 150 -----------------------------------------
 3 files changed, 12 insertions(+), 156 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index b2526a4..c812594 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -773,14 +773,13 @@ static struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devf
 
 	if (dev_is_pci(dev)) {
 		struct pci_dev *pf_pdev;
+		struct device *dma_alias;
 
 		pdev = to_pci_dev(dev);
 
-#ifdef CONFIG_X86
-		/* VMD child devices currently cannot be handled individually */
-		if (is_vmd(pdev->bus))
-			return NULL;
-#endif
+		dma_alias = pci_direct_dma_alias(pdev);
+		if (dma_alias && dev_is_pci(dma_alias))
+			pdev = to_pci_dev(dma_alias);
 
 		/* VFs aren't listed in scope tables; we need to look up
 		 * the PF instead to find the IOMMU. */
@@ -2428,6 +2427,14 @@ static struct dmar_domain *find_domain(struct device *dev)
 		     dev->archdata.iommu == DUMMY_DEVICE_DOMAIN_INFO))
 		return NULL;
 
+	if (dev_is_pci(dev)) {
+		struct pci_dev *pdev = to_pci_dev(dev);
+		struct device *dma_alias = pci_direct_dma_alias(pdev);
+
+		if (dma_alias)
+			dev = dma_alias;
+	}
+
 	/* No lock here, assumes no domain exit in normal case */
 	info = dev->archdata.iommu;
 	if (likely(info))
diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index c77069c..55671429 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -239,7 +239,6 @@ config PCIE_TANGO_SMP8759
 
 config VMD
 	depends on PCI_MSI && X86_64 && SRCU
-	select X86_DEV_DMA_OPS
 	tristate "Intel Volume Management Device Driver"
 	---help---
 	  Adds support for the Intel Volume Management Device (VMD). VMD is a
diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 907b5bd..5824a39 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -98,9 +98,6 @@ struct vmd_dev {
 	struct irq_domain	*irq_domain;
 	struct pci_bus		*bus;
 	u8			busn_start;
-
-	struct dma_map_ops	dma_ops;
-	struct dma_domain	dma_domain;
 };
 
 static inline struct vmd_dev *vmd_from_bus(struct pci_bus *bus)
@@ -295,151 +292,6 @@ static void vmd_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
 	.chip		= &vmd_msi_controller,
 };
 
-/*
- * VMD replaces the requester ID with its own.  DMA mappings for devices in a
- * VMD domain need to be mapped for the VMD, not the device requiring
- * the mapping.
- */
-static struct device *to_vmd_dev(struct device *dev)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct vmd_dev *vmd = vmd_from_bus(pdev->bus);
-
-	return &vmd->dev->dev;
-}
-
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
@@ -709,7 +561,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	}
 
 	vmd_attach_resources(vmd);
-	vmd_setup_dma_ops(vmd);
 	dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
 
 	pci_scan_child_bus(vmd->bus);
@@ -824,7 +675,6 @@ static void vmd_remove(struct pci_dev *dev)
 	pci_stop_root_bus(vmd->bus);
 	pci_remove_root_bus(vmd->bus);
 	vmd_cleanup_srcu(vmd);
-	vmd_teardown_dma_ops(vmd);
 	vmd_detach_resources(vmd);
 	irq_domain_remove(vmd->irq_domain);
 }
-- 
1.8.3.1

