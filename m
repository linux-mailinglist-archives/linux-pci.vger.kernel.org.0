Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23371392F99
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 15:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236442AbhE0N3C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 09:29:02 -0400
Received: from verein.lst.de ([213.95.11.211]:39063 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236455AbhE0N3B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 09:29:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BAAFB68AFE; Thu, 27 May 2021 15:27:23 +0200 (CEST)
Date:   Thu, 27 May 2021 15:27:23 +0200
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
Subject: Re: [PATCH v7 04/15] swiotlb: Add restricted DMA pool
 initialization
Message-ID: <20210527132723.GD26160@lst.de>
References: <20210518064215.2856977-1-tientzu@chromium.org> <20210518064215.2856977-5-tientzu@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518064215.2856977-5-tientzu@chromium.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I'd still much prefer to always have the pointer in struct device.
Especially as we're also looking into things like a global 64-bit bounce
buffer.  Something like this untested patch ontop of your series:


diff --git a/drivers/base/core.c b/drivers/base/core.c
index 628e33939aca..3cb95fa29f70 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -29,6 +29,7 @@
 #include <linux/sched/mm.h>
 #include <linux/sysfs.h>
 #include <linux/dma-map-ops.h> /* for dma_default_coherent */
+#include <linux/swiotlb.h>
 
 #include "base.h"
 #include "power/power.h"
@@ -2814,6 +2815,9 @@ void device_initialize(struct device *dev)
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
 	dev->dma_coherent = dma_default_coherent;
 #endif
+#ifdef CONFIG_SWIOTLB
+	dev->dma_io_tlb_mem = &io_tlb_default_mem;
+#endif
 }
 EXPORT_SYMBOL_GPL(device_initialize);
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 4987608ea4ff..6aca6fa0facc 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -416,7 +416,7 @@ struct dev_links_info {
  * @dma_pools:	Dma pools (if dma'ble device).
  * @dma_mem:	Internal for coherent mem override.
  * @cma_area:	Contiguous memory area for dma allocations
- * @dma_io_tlb_mem: Internal for swiotlb io_tlb_mem override.
+ * @dma_io_tlb_mem: Pointer to the swiotlb pool used.  Not for driver use.
  * @archdata:	For arch-specific additions.
  * @of_node:	Associated device tree node.
  * @fwnode:	Associated device node supplied by platform firmware.
@@ -523,7 +523,7 @@ struct device {
 	struct cma *cma_area;		/* contiguous memory area for dma
 					   allocations */
 #endif
-#ifdef CONFIG_DMA_RESTRICTED_POOL
+#ifdef CONFIG_SWIOTLB
 	struct io_tlb_mem *dma_io_tlb_mem;
 #endif
 	/* arch specific additions */
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index e8cf49bd90c5..c153cd0c469c 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -95,6 +95,7 @@ struct io_tlb_mem {
 	spinlock_t lock;
 	struct dentry *debugfs;
 	bool late_alloc;
+	bool force_swiotlb;
 	struct io_tlb_slot {
 		phys_addr_t orig_addr;
 		size_t alloc_size;
@@ -103,30 +104,16 @@ struct io_tlb_mem {
 };
 extern struct io_tlb_mem *io_tlb_default_mem;
 
-static inline struct io_tlb_mem *get_io_tlb_mem(struct device *dev)
-{
-#ifdef CONFIG_DMA_RESTRICTED_POOL
-	if (dev && dev->dma_io_tlb_mem)
-		return dev->dma_io_tlb_mem;
-#endif /* CONFIG_DMA_RESTRICTED_POOL */
-
-	return io_tlb_default_mem;
-}
-
 static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
 {
-	struct io_tlb_mem *mem = get_io_tlb_mem(dev);
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 
 	return mem && paddr >= mem->start && paddr < mem->end;
 }
 
 static inline bool is_dev_swiotlb_force(struct device *dev)
 {
-#ifdef CONFIG_DMA_RESTRICTED_POOL
-	if (dev->dma_io_tlb_mem)
-		return true;
-#endif /* CONFIG_DMA_RESTRICTED_POOL */
-	return false;
+	return dev->dma_io_tlb_mem->force_swiotlb;
 }
 
 void __init swiotlb_exit(void);
@@ -134,10 +121,8 @@ unsigned int swiotlb_max_segment(void);
 size_t swiotlb_max_mapping_size(struct device *dev);
 bool is_swiotlb_active(struct device *dev);
 void __init swiotlb_adjust_size(unsigned long size);
-#ifdef CONFIG_DMA_RESTRICTED_POOL
 struct page *swiotlb_alloc(struct device *dev, size_t size);
 bool swiotlb_free(struct device *dev, struct page *page, size_t size);
-#endif /* CONFIG_DMA_RESTRICTED_POOL */
 #else
 #define swiotlb_force SWIOTLB_NO_FORCE
 static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index d3fa4669229b..69d62e18f493 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -347,7 +347,7 @@ void __init swiotlb_exit(void)
 static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size,
 			   enum dma_data_direction dir)
 {
-	struct io_tlb_mem *mem = get_io_tlb_mem(dev);
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 	int index = (tlb_addr - mem->start) >> IO_TLB_SHIFT;
 	phys_addr_t orig_addr = mem->slots[index].orig_addr;
 	size_t alloc_size = mem->slots[index].alloc_size;
@@ -429,7 +429,7 @@ static unsigned int wrap_index(struct io_tlb_mem *mem, unsigned int index)
 static int find_slots(struct device *dev, phys_addr_t orig_addr,
 		size_t alloc_size)
 {
-	struct io_tlb_mem *mem = get_io_tlb_mem(dev);
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 	unsigned long boundary_mask = dma_get_seg_boundary(dev);
 	dma_addr_t tbl_dma_addr =
 		phys_to_dma_unencrypted(dev, mem->start) & boundary_mask;
@@ -510,7 +510,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		size_t mapping_size, size_t alloc_size,
 		enum dma_data_direction dir, unsigned long attrs)
 {
-	struct io_tlb_mem *mem = get_io_tlb_mem(dev);
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
 	unsigned int i;
 	int index;
@@ -553,7 +553,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 
 static void release_slots(struct device *dev, phys_addr_t tlb_addr)
 {
-	struct io_tlb_mem *mem = get_io_tlb_mem(dev);
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 	unsigned long flags;
 	unsigned int offset = swiotlb_align_offset(dev, tlb_addr);
 	int index = (tlb_addr - offset - mem->start) >> IO_TLB_SHIFT;
@@ -670,7 +670,7 @@ size_t swiotlb_max_mapping_size(struct device *dev)
 
 bool is_swiotlb_active(struct device *dev)
 {
-	return get_io_tlb_mem(dev) != NULL;
+	return dev->dma_io_tlb_mem;
 }
 EXPORT_SYMBOL_GPL(is_swiotlb_active);
 
@@ -741,7 +741,7 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 	struct io_tlb_mem *mem = rmem->priv;
 	unsigned long nslabs = rmem->size >> IO_TLB_SHIFT;
 
-	if (dev->dma_io_tlb_mem)
+	if (dev->dma_io_tlb_mem != io_tlb_default_mem)
 		return 0;
 
 	/*
@@ -760,6 +760,7 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 		}
 
 		swiotlb_init_io_tlb_mem(mem, rmem->base, nslabs, false);
+		mem->force_swiotlb = true;
 
 		rmem->priv = mem;
 
@@ -768,15 +769,13 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 	}
 
 	dev->dma_io_tlb_mem = mem;
-
 	return 0;
 }
 
 static void rmem_swiotlb_device_release(struct reserved_mem *rmem,
 					struct device *dev)
 {
-	if (dev)
-		dev->dma_io_tlb_mem = NULL;
+	dev->dma_io_tlb_mem = io_tlb_default_mem;
 }
 
 static const struct reserved_mem_ops rmem_swiotlb_ops = {
