Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD82012DD61
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jan 2020 03:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgAAC1E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Dec 2019 21:27:04 -0500
Received: from mga14.intel.com ([192.55.52.115]:65216 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbgAAC1E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Dec 2019 21:27:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Dec 2019 18:27:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,381,1571727600"; 
   d="scan'208";a="221068079"
Received: from unknown (HELO nsgsw-rhel7p6.lm.intel.com) ([10.232.116.83])
  by orsmga006.jf.intel.com with ESMTP; 31 Dec 2019 18:27:02 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <iommu@lists.linux-foundation.org>, <linux-pci@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [RFC 4/5] PCI: vmd: Stop overriding dma_map_ops
Date:   Tue, 31 Dec 2019 13:24:22 -0700
Message-Id: <1577823863-3303-5-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1577823863-3303-1-git-send-email-jonathan.derrick@intel.com>
References: <1577823863-3303-1-git-send-email-jonathan.derrick@intel.com>
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

This patch adds a new dma alias mechanism by adding a hint to a pci_dev
to point to a singular DMA requester's pci_dev. This integrates into the
existing dma alias infrastructure to reduce the impact of the changes
required to support this mode.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 arch/x86/pci/common.c          |   6 +-
 drivers/iommu/intel-iommu.c    |  13 ++--
 drivers/pci/controller/Kconfig |   1 -
 drivers/pci/controller/vmd.c   | 150 -----------------------------------------
 drivers/pci/pci.c              |   4 +-
 drivers/pci/search.c           |   6 ++
 include/linux/pci.h            |   1 +
 7 files changed, 23 insertions(+), 158 deletions(-)

diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 1e59df0..4022609 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -664,8 +664,12 @@ static void set_dma_domain_ops(struct pci_dev *pdev) {}
 
 static void set_dev_domain_options(struct pci_dev *pdev)
 {
-	if (is_vmd(pdev->bus))
+	if (is_vmd(pdev->bus)) {
+		struct pci_sysdata *sd = pdev->bus->sysdata;
+
+		pdev->dma_parent = to_pci_dev(sd->vmd_dev);
 		pdev->hotplug_user_indicators = 1;
+	}
 }
 
 int pcibios_add_device(struct pci_dev *dev)
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 978d502..5aee648 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -776,11 +776,8 @@ static struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devf
 
 		pdev = to_pci_dev(dev);
 
-#ifdef CONFIG_X86
-		/* VMD child devices currently cannot be handled individually */
-		if (is_vmd(pdev->bus))
-			return NULL;
-#endif
+		if (pdev->dma_parent)
+			pdev = pdev->dma_parent;
 
 		/* VFs aren't listed in scope tables; we need to look up
 		 * the PF instead to find the IOMMU. */
@@ -2428,6 +2425,12 @@ static struct dmar_domain *find_domain(struct device *dev)
 		     dev->archdata.iommu == DUMMY_DEVICE_DOMAIN_INFO))
 		return NULL;
 
+	if (dev_is_pci(dev)) {
+		struct pci_dev *pdev = to_pci_dev(dev);
+		if (pdev->dma_parent)
+			dev = &pdev->dma_parent->dev;
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
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ad746d9..ef7f219 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6034,7 +6034,9 @@ bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev *dev2)
 	return (dev1->dma_alias_mask &&
 		test_bit(dev2->devfn, dev1->dma_alias_mask)) ||
 	       (dev2->dma_alias_mask &&
-		test_bit(dev1->devfn, dev2->dma_alias_mask));
+		test_bit(dev1->devfn, dev2->dma_alias_mask)) ||
+	       (dev1->dma_parent && dev1->dma_parent == dev2) ||
+	       (dev2->dma_parent && dev2->dma_parent == dev1);
 }
 
 bool pci_device_is_present(struct pci_dev *pdev)
diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index bade140..a1d4899 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -32,6 +32,12 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
 	struct pci_bus *bus;
 	int ret;
 
+	if (unlikely(pdev->dma_parent)) {
+		pdev = pdev->dma_parent;
+		return fn(pdev, PCI_DEVID(pdev->bus->number, pdev->devfn),
+			  data);
+	}
+
 	ret = fn(pdev, pci_dev_id(pdev), data);
 	if (ret)
 		return ret;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c393dff..0a10d1e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -316,6 +316,7 @@ struct pci_dev {
 	u8		pin;		/* Interrupt pin this device uses */
 	u16		pcie_flags_reg;	/* Cached PCIe Capabilities Register */
 	unsigned long	*dma_alias_mask;/* Mask of enabled devfn aliases */
+	struct pci_dev	*dma_parent;	/* DMA requester on another bus */
 
 	struct pci_driver *driver;	/* Driver bound to this device */
 	u64		dma_mask;	/* Mask of the bits of bus address this
-- 
1.8.3.1

