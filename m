Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24CAE3A7FA2
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jun 2021 15:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbhFONbA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Jun 2021 09:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbhFONa4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Jun 2021 09:30:56 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3A4C0613A3
        for <linux-pci@vger.kernel.org>; Tue, 15 Jun 2021 06:28:51 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso2213298pjp.2
        for <linux-pci@vger.kernel.org>; Tue, 15 Jun 2021 06:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wqtfx6cy1Jtw2X0SInQsIQVX1lEuTH1kldxYY4/ko84=;
        b=PyPCb31nwqkas7zJi0U/cW8hKJbIyQRt3KSrT1/9LLelrXTmEmiBCd+NQ0T4Qz5xHZ
         5HLb/yCfBcSDKsc6Y3LcfI3tZ4lyRELs8jQ7mMR0sANKJ2Wj/vLJQSOMlV3VfujnvwxB
         uh1bUfi3nbDNpER9cQm/+5boAFyFENHa50RCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wqtfx6cy1Jtw2X0SInQsIQVX1lEuTH1kldxYY4/ko84=;
        b=Q4fT893HEMoiwzf3bnw+rjNX/rvM2IF/9sF/0fatsPUejfXMNrLI9V7c/j+oEcHAS2
         icYXXuP5iM4gCfILALgBpzEJ+wxYKPFWKggm6CK/IA1VkStwasbZOoYXi3csqIjzX5LJ
         W5t+Wm3sgPVnnHf4fhfkT/OSDkKzb11h74FGbTvPW0C8YtJlkbsm+4MUfauatV237jH/
         Nf/WCPsMZoFvapdrAawO2b9p6d56XwKNizjmLrqc401pSL7HMK4gcmYnDmseZozWkV7N
         hKNcNiHlJ9tYtBBFz/FP8ACC1NpTbT1BR9xriZoI9IOYJsmlCkxd/BR86G6K5EDcHM+H
         7alg==
X-Gm-Message-State: AOAM531Y9e4R2VfAcR8/mFeeDcZ0dgtc0fA0crycp434n1gyaQQgkPTR
        HjBQRJupmcnsaDSbezhLQosGmg==
X-Google-Smtp-Source: ABdhPJyjg0/RR4SKMggFs51q0JksjVaDIqi9tLaQaLjRDeZX7ai5CONlJW5WV7csxUkV0QoMXbG+hQ==
X-Received: by 2002:a17:90a:10d0:: with SMTP id b16mr15680796pje.23.1623763730811;
        Tue, 15 Jun 2021 06:28:50 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:1846:5274:e444:139e])
        by smtp.gmail.com with UTF8SMTPSA id k63sm2609312pjh.13.2021.06.15.06.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 06:28:50 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     benh@kernel.crashing.org, paulus@samba.org,
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
        tientzu@chromium.org, daniel@ffwll.ch, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, jxgao@google.com,
        joonas.lahtinen@linux.intel.com, linux-pci@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, matthew.auld@intel.com,
        rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com
Subject: [PATCH v10 10/12] swiotlb: Add restricted DMA alloc/free support
Date:   Tue, 15 Jun 2021 21:27:09 +0800
Message-Id: <20210615132711.553451-11-tientzu@chromium.org>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
In-Reply-To: <20210615132711.553451-1-tientzu@chromium.org>
References: <20210615132711.553451-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the functions, swiotlb_{alloc,free} to support the memory allocation
from restricted DMA pool.

The restricted DMA pool is preferred if available.

Note that since coherent allocation needs remapping, one must set up
another device coherent pool by shared-dma-pool and use
dma_alloc_from_dev_coherent instead for atomic coherent allocation.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 include/linux/swiotlb.h | 15 +++++++++++++
 kernel/dma/direct.c     | 50 ++++++++++++++++++++++++++++++-----------
 kernel/dma/swiotlb.c    | 42 ++++++++++++++++++++++++++++++++--
 3 files changed, 92 insertions(+), 15 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index e76ac46ffff9..9616346b727f 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -157,4 +157,19 @@ static inline void swiotlb_adjust_size(unsigned long size)
 extern void swiotlb_print_info(void);
 extern void swiotlb_set_max_segment(unsigned int);
 
+#ifdef CONFIG_DMA_RESTRICTED_POOL
+struct page *swiotlb_alloc(struct device *dev, size_t size);
+bool swiotlb_free(struct device *dev, struct page *page, size_t size);
+#else
+static inline struct page *swiotlb_alloc(struct device *dev, size_t size)
+{
+	return NULL;
+}
+static inline bool swiotlb_free(struct device *dev, struct page *page,
+				size_t size)
+{
+	return false;
+}
+#endif /* CONFIG_DMA_RESTRICTED_POOL */
+
 #endif /* __LINUX_SWIOTLB_H */
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 3713461d6fe0..da0e09621230 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -75,6 +75,15 @@ static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 		min_not_zero(dev->coherent_dma_mask, dev->bus_dma_limit);
 }
 
+static void __dma_direct_free_pages(struct device *dev, struct page *page,
+				    size_t size)
+{
+	if (IS_ENABLED(CONFIG_DMA_RESTRICTED_POOL) &&
+	    swiotlb_free(dev, page, size))
+		return;
+	dma_free_contiguous(dev, page, size);
+}
+
 static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 		gfp_t gfp)
 {
@@ -86,7 +95,16 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 
 	gfp |= dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
 					   &phys_limit);
-	page = dma_alloc_contiguous(dev, size, gfp);
+	if (IS_ENABLED(CONFIG_DMA_RESTRICTED_POOL)) {
+		page = swiotlb_alloc(dev, size);
+		if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
+			__dma_direct_free_pages(dev, page, size);
+			return NULL;
+		}
+	}
+
+	if (!page)
+		page = dma_alloc_contiguous(dev, size, gfp);
 	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
 		dma_free_contiguous(dev, page, size);
 		page = NULL;
@@ -142,7 +160,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		gfp |= __GFP_NOWARN;
 
 	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
-	    !force_dma_unencrypted(dev)) {
+	    !force_dma_unencrypted(dev) && !is_dev_swiotlb_force(dev)) {
 		page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO);
 		if (!page)
 			return NULL;
@@ -155,18 +173,23 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	}
 
 	if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
-	    !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
-	    !dev_is_dma_coherent(dev))
+	    !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) && !dev_is_dma_coherent(dev) &&
+	    !is_dev_swiotlb_force(dev))
 		return arch_dma_alloc(dev, size, dma_handle, gfp, attrs);
 
 	/*
 	 * Remapping or decrypting memory may block. If either is required and
 	 * we can't block, allocate the memory from the atomic pools.
+	 * If restricted DMA (i.e., is_dev_swiotlb_force) is required, one must
+	 * set up another device coherent pool by shared-dma-pool and use
+	 * dma_alloc_from_dev_coherent instead.
 	 */
 	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
 	    !gfpflags_allow_blocking(gfp) &&
 	    (force_dma_unencrypted(dev) ||
-	     (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) && !dev_is_dma_coherent(dev))))
+	     (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
+	      !dev_is_dma_coherent(dev))) &&
+	    !is_dev_swiotlb_force(dev))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
 	/* we always manually zero the memory once we are done */
@@ -237,7 +260,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 			return NULL;
 	}
 out_free_pages:
-	dma_free_contiguous(dev, page, size);
+	__dma_direct_free_pages(dev, page, size);
 	return NULL;
 }
 
@@ -247,15 +270,15 @@ void dma_direct_free(struct device *dev, size_t size,
 	unsigned int page_order = get_order(size);
 
 	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
-	    !force_dma_unencrypted(dev)) {
+	    !force_dma_unencrypted(dev) && !is_dev_swiotlb_force(dev)) {
 		/* cpu_addr is a struct page cookie, not a kernel address */
 		dma_free_contiguous(dev, cpu_addr, size);
 		return;
 	}
 
 	if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
-	    !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
-	    !dev_is_dma_coherent(dev)) {
+	    !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) && !dev_is_dma_coherent(dev) &&
+	    !is_dev_swiotlb_force(dev)) {
 		arch_dma_free(dev, size, cpu_addr, dma_addr, attrs);
 		return;
 	}
@@ -273,7 +296,7 @@ void dma_direct_free(struct device *dev, size_t size,
 	else if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_CLEAR_UNCACHED))
 		arch_dma_clear_uncached(cpu_addr, size);
 
-	dma_free_contiguous(dev, dma_direct_to_page(dev, dma_addr), size);
+	__dma_direct_free_pages(dev, dma_direct_to_page(dev, dma_addr), size);
 }
 
 struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
@@ -283,7 +306,8 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 	void *ret;
 
 	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
-	    force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp))
+	    force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp) &&
+	    !is_dev_swiotlb_force(dev))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
 	page = __dma_direct_alloc_pages(dev, size, gfp);
@@ -310,7 +334,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
 	return page;
 out_free_pages:
-	dma_free_contiguous(dev, page, size);
+	__dma_direct_free_pages(dev, page, size);
 	return NULL;
 }
 
@@ -329,7 +353,7 @@ void dma_direct_free_pages(struct device *dev, size_t size,
 	if (force_dma_unencrypted(dev))
 		set_memory_encrypted((unsigned long)vaddr, 1 << page_order);
 
-	dma_free_contiguous(dev, page, size);
+	__dma_direct_free_pages(dev, page, size);
 }
 
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index ef1ccd63534d..5e277eb65f92 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -460,8 +460,9 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 
 	index = wrap = wrap_index(mem, ALIGN(mem->index, stride));
 	do {
-		if ((slot_addr(tbl_dma_addr, index) & iotlb_align_mask) !=
-		    (orig_addr & iotlb_align_mask)) {
+		if (orig_addr &&
+		    (slot_addr(tbl_dma_addr, index) & iotlb_align_mask) !=
+			    (orig_addr & iotlb_align_mask)) {
 			index = wrap_index(mem, index + 1);
 			continue;
 		}
@@ -702,6 +703,43 @@ late_initcall(swiotlb_create_default_debugfs);
 #endif
 
 #ifdef CONFIG_DMA_RESTRICTED_POOL
+struct page *swiotlb_alloc(struct device *dev, size_t size)
+{
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
+	phys_addr_t tlb_addr;
+	int index;
+
+	/*
+	 * Skip io_tlb_default_mem since swiotlb_alloc doesn't support atomic
+	 * coherent allocation. Otherwise might break existing devices.
+	 * One must set up another device coherent pool by shared-dma-pool and
+	 * use dma_alloc_from_dev_coherent instead for atomic coherent
+	 * allocation to avoid mempry remapping.
+	 */
+	if (!mem || mem == io_tlb_default_mem)
+		return NULL;
+
+	index = swiotlb_find_slots(dev, 0, size);
+	if (index == -1)
+		return NULL;
+
+	tlb_addr = slot_addr(mem->start, index);
+
+	return pfn_to_page(PFN_DOWN(tlb_addr));
+}
+
+bool swiotlb_free(struct device *dev, struct page *page, size_t size)
+{
+	phys_addr_t tlb_addr = page_to_phys(page);
+
+	if (!is_swiotlb_buffer(dev, tlb_addr))
+		return false;
+
+	swiotlb_release_slots(dev, tlb_addr);
+
+	return true;
+}
+
 static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 				    struct device *dev)
 {
-- 
2.32.0.272.g935e593368-goog

