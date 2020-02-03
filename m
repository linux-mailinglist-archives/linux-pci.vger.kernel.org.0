Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 053CC150849
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2020 15:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgBCOV5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Feb 2020 09:21:57 -0500
Received: from verein.lst.de ([213.95.11.211]:56262 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727802AbgBCOV5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Feb 2020 09:21:57 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5621D68B20; Mon,  3 Feb 2020 15:21:55 +0100 (CET)
Date:   Mon, 3 Feb 2020 15:21:55 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: pci-usb/pci-sata broken with LPAE config after "reduce use of
 block bounce buffers"
Message-ID: <20200203142155.GA16388@lst.de>
References: <120f7c3e-363d-deb0-a347-782ac869ee0d@ti.com> <20200130075833.GC30735@lst.de> <4a41bd0d-6491-3822-172a-fbca8a6abba5@ti.com> <20200130164235.GA6705@lst.de> <f76af743-dcb5-f59d-b315-f2332a9dc906@ti.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <f76af743-dcb5-f59d-b315-f2332a9dc906@ti.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 31, 2020 at 05:14:01PM +0530, Kishon Vijay Abraham I wrote:
> > Can you throw in a little debug printk if this comes from
> > dma_direct_possible or swiotlb_map?
> 
> I could see swiotlb_tbl_map_single() returning DMA_MAPPING_ERROR.
> 
> Kernel with debug print:
> https://github.com/kishon/linux-wip.git nvm_dma_issue
> 
> Full log: https://pastebin.ubuntu.com/p/Xf2ngxc3kB/

Ok, this mostly like means we allocate a swiotlb buffer that isn't
actually addressable.  To verify that can you post the output with the
first attached patch?  If it shows the overflow message added there,
please try if the second patch fixes it.

--liOOAslEiF7prFVr
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-dma-direct-improve-swiotlb-error-reporting.patch"

From b72e7e81954c02e83f59f0caa56360d6faab0355 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Mon, 3 Feb 2020 14:44:38 +0100
Subject: dma-direct: improve swiotlb error reporting

Untangle the way how dma_direct_map_page calls into swiotlb to
be able to properly report errors where the swiotlb DMA address
overflows the mask separately from overflows in the !swiotlb case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/swiotlb.h | 11 +++--------
 kernel/dma/direct.c     | 17 ++++++++---------
 kernel/dma/swiotlb.c    | 42 +++++++++++++++++++++++------------------
 3 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index cde3dc18e21a..046bb94bd4d6 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -64,6 +64,9 @@ extern void swiotlb_tbl_sync_single(struct device *hwdev,
 				    size_t size, enum dma_data_direction dir,
 				    enum dma_sync_target target);
 
+dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
+		size_t size, enum dma_data_direction dir, unsigned long attrs);
+
 #ifdef CONFIG_SWIOTLB
 extern enum swiotlb_force swiotlb_force;
 extern phys_addr_t io_tlb_start, io_tlb_end;
@@ -73,8 +76,6 @@ static inline bool is_swiotlb_buffer(phys_addr_t paddr)
 	return paddr >= io_tlb_start && paddr < io_tlb_end;
 }
 
-bool swiotlb_map(struct device *dev, phys_addr_t *phys, dma_addr_t *dma_addr,
-		size_t size, enum dma_data_direction dir, unsigned long attrs);
 void __init swiotlb_exit(void);
 unsigned int swiotlb_max_segment(void);
 size_t swiotlb_max_mapping_size(struct device *dev);
@@ -85,12 +86,6 @@ static inline bool is_swiotlb_buffer(phys_addr_t paddr)
 {
 	return false;
 }
-static inline bool swiotlb_map(struct device *dev, phys_addr_t *phys,
-		dma_addr_t *dma_addr, size_t size, enum dma_data_direction dir,
-		unsigned long attrs)
-{
-	return false;
-}
 static inline void swiotlb_exit(void)
 {
 }
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 6af7ae83c4ad..e16baa9aa233 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -357,13 +357,6 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
 EXPORT_SYMBOL(dma_direct_unmap_sg);
 #endif
 
-static inline bool dma_direct_possible(struct device *dev, dma_addr_t dma_addr,
-		size_t size)
-{
-	return swiotlb_force != SWIOTLB_FORCE &&
-		dma_capable(dev, dma_addr, size, true);
-}
-
 dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size, enum dma_data_direction dir,
 		unsigned long attrs)
@@ -371,8 +364,14 @@ dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
 	phys_addr_t phys = page_to_phys(page) + offset;
 	dma_addr_t dma_addr = phys_to_dma(dev, phys);
 
-	if (unlikely(!dma_direct_possible(dev, dma_addr, size)) &&
-	    !swiotlb_map(dev, &phys, &dma_addr, size, dir, attrs)) {
+	if (unlikely(swiotlb_force == SWIOTLB_FORCE))
+		return swiotlb_map(dev, phys, size, dir, attrs);
+
+	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
+		if (IS_ENABLED(CONFIG_SWIOTLB) &&
+		    swiotlb_force != SWIOTLB_NO_FORCE)
+			return swiotlb_map(dev, phys, size, dir, attrs);
+
 		report_addr(dev, dma_addr, size);
 		return DMA_MAPPING_ERROR;
 	}
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 9280d6f8271e..0341d01e4614 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -22,6 +22,7 @@
 
 #include <linux/cache.h>
 #include <linux/dma-direct.h>
+#include <linux/dma-noncoherent.h>
 #include <linux/mm.h>
 #include <linux/export.h>
 #include <linux/spinlock.h>
@@ -656,35 +657,40 @@ void swiotlb_tbl_sync_single(struct device *hwdev, phys_addr_t tlb_addr,
 }
 
 /*
- * Create a swiotlb mapping for the buffer at @phys, and in case of DMAing
+ * Create a swiotlb mapping for the buffer at @page, and in case of DMAing
  * to the device copy the data into it as well.
  */
-bool swiotlb_map(struct device *dev, phys_addr_t *phys, dma_addr_t *dma_addr,
-		size_t size, enum dma_data_direction dir, unsigned long attrs)
+dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir, unsigned long attrs)
 {
-	trace_swiotlb_bounced(dev, *dma_addr, size, swiotlb_force);
+	phys_addr_t swiotlb_addr;
+	dma_addr_t dma_addr;
 
-	if (unlikely(swiotlb_force == SWIOTLB_NO_FORCE)) {
-		dev_warn_ratelimited(dev,
-			"Cannot do DMA to address %pa\n", phys);
-		return false;
-	}
+	trace_swiotlb_bounced(dev, phys_to_dma(dev, paddr), size,
+			      swiotlb_force);
 
 	/* Oh well, have to allocate and map a bounce buffer. */
-	*phys = swiotlb_tbl_map_single(dev, __phys_to_dma(dev, io_tlb_start),
-			*phys, size, size, dir, attrs);
-	if (*phys == (phys_addr_t)DMA_MAPPING_ERROR)
-		return false;
+	swiotlb_addr = swiotlb_tbl_map_single(dev,
+			__phys_to_dma(dev, io_tlb_start),
+			paddr, size, size, dir, attrs);
+	if (swiotlb_addr == (phys_addr_t)DMA_MAPPING_ERROR)
+		return DMA_MAPPING_ERROR;
 
 	/* Ensure that the address returned is DMA'ble */
-	*dma_addr = __phys_to_dma(dev, *phys);
-	if (unlikely(!dma_capable(dev, *dma_addr, size, true))) {
-		swiotlb_tbl_unmap_single(dev, *phys, size, size, dir,
+	dma_addr = __phys_to_dma(dev, swiotlb_addr);
+	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
+		swiotlb_tbl_unmap_single(dev, swiotlb_addr, size, size, dir,
 			attrs | DMA_ATTR_SKIP_CPU_SYNC);
-		return false;
+		dev_err_once(dev,
+			"swiotlb addr %pad+%zu overflow (mask %llx, bus limit %llx).\n",
+			&dma_addr, size, *dev->dma_mask, dev->bus_dma_limit);
+		WARN_ON_ONCE(1);
+		return DMA_MAPPING_ERROR;
 	}
 
-	return true;
+	if (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		arch_sync_dma_for_device(swiotlb_addr, size, dir);
+	return dma_addr;
 }
 
 size_t swiotlb_max_mapping_size(struct device *dev)
-- 
2.24.1


--liOOAslEiF7prFVr
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0003-arm-dma-mapping-allocate-swiotlb-bottom-up.patch"

From d15217ee1e1f361ab064dfed82252b4124dd6b36 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Mon, 3 Feb 2020 14:57:57 +0100
Subject: arm/dma-mapping: allocate swiotlb bottom up

Allocate the swiotlb buffer as low as possible to increase the chance
of it to be actually addressable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/mm/init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 3ef204137e73..3951fcd560ff 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -471,7 +471,9 @@ static void __init free_highpages(void)
 void __init mem_init(void)
 {
 #ifdef CONFIG_ARM_LPAE
+	memblock_set_bottom_up(true);
 	swiotlb_init(1);
+	memblock_set_bottom_up(false);
 #endif
 
 	set_max_mapnr(pfn_to_page(max_pfn) - mem_map);
-- 
2.24.1


--liOOAslEiF7prFVr--
