Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCC4367C38
	for <lists+linux-pci@lfdr.de>; Thu, 22 Apr 2021 10:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbhDVIRR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Apr 2021 04:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbhDVIRM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Apr 2021 04:17:12 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C114C06174A
        for <linux-pci@vger.kernel.org>; Thu, 22 Apr 2021 01:16:36 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id h11so115194pfn.0
        for <linux-pci@vger.kernel.org>; Thu, 22 Apr 2021 01:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7FPvCtA3DzFKQwLvtc7p/5Cs0iswQJglZ9YXlCAqucE=;
        b=BJiX1CQYA0mEDCEpMxa1tasCbi4fI5BDOHfh/pz+QYcElN3c5mcLOcB0Yb83+oHiSf
         CPa6c0Bl1fKIPQyZ45sNz3SCPuG/ixpd5Hz2AU47wStRbg7QAx9lYNFxNqp7Kowj6Uta
         RrLSccn4gu++zPN+jOwIj5+FZ4BE7SjACELv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7FPvCtA3DzFKQwLvtc7p/5Cs0iswQJglZ9YXlCAqucE=;
        b=i5ra3wD2i6sIiLTt3xkiY4M73dc5p/OHxGTyBwFhfeRdU6NhHeSK6zOy1Cv6NlGwRX
         KSSakmGEjwY9e1/onObFx0YOK0YWEL+10WdrFLp9NXYjNlZ9lOp8C2egGe4U9Me3oMOA
         stZfoLfGzQVtfd5bSpHCBlz6l8bNRo5zEoZXUgrQOxLT/SOXyHQlz600NlAHsGlcQUWE
         ZWvAHAhY+n4Az0oPj2llYYZOQagEPEUkwQSJUzE4LiSGBfXFuQYSKn7ncNTnD/urLaFf
         cUz3yeuWcJVUwU/pCYY1LOWZ0xmNZ1RN7gsbDJFTNHOhIdeql4hhdK6L/qVWJ+oiBCaU
         m/uw==
X-Gm-Message-State: AOAM532kyQL5b6+yr3Yi8lTG3f2BcPPwcp4TUyAAo+qUBzd6sj/jQ2LS
        bFUpO/VmQXU0v3XGRgV6RmLgFQ==
X-Google-Smtp-Source: ABdhPJzoHwtUCb5BtS7uWm9jSZICs97Kt8RVlYajeU6q3WTDizEPh7yvn0zd87k0sLfHofxVgKyPGA==
X-Received: by 2002:a62:33c6:0:b029:225:5266:28df with SMTP id z189-20020a6233c60000b0290225526628dfmr2243880pfz.7.1619079395713;
        Thu, 22 Apr 2021 01:16:35 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:1a8e:1bde:f79e:c302])
        by smtp.gmail.com with UTF8SMTPSA id e6sm1489084pgh.17.2021.04.22.01.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 01:16:35 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
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
        nouveau@lists.freedesktop.org, rodrigo.vivi@intel.com,
        thomas.hellstrom@linux.intel.com
Subject: [PATCH v5 09/16] swiotlb: Bounce data from/to restricted DMA pool if available
Date:   Thu, 22 Apr 2021 16:15:01 +0800
Message-Id: <20210422081508.3942748-10-tientzu@chromium.org>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210422081508.3942748-1-tientzu@chromium.org>
References: <20210422081508.3942748-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Regardless of swiotlb setting, the restricted DMA pool is preferred if
available.

The restricted DMA pools provide a basic level of protection against the
DMA overwriting buffer contents at unexpected times. However, to protect
against general data leakage and system memory corruption, the system
needs to provide a way to lock down the memory access, e.g., MPU.

Note that is_dev_swiotlb_force doesn't check if
swiotlb_force == SWIOTLB_FORCE. Otherwise the memory allocation behavior
with default swiotlb will be changed by the following patche
("dma-direct: Allocate memory from restricted DMA pool if available").

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 include/linux/swiotlb.h | 13 +++++++++++++
 kernel/dma/direct.h     |  3 ++-
 kernel/dma/swiotlb.c    |  8 ++++----
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index c530c976d18b..0c5a18d9cf89 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -120,6 +120,15 @@ static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
 	return mem && paddr >= mem->start && paddr < mem->end;
 }
 
+static inline bool is_dev_swiotlb_force(struct device *dev)
+{
+#ifdef CONFIG_DMA_RESTRICTED_POOL
+	if (dev->dma_io_tlb_mem)
+		return true;
+#endif /* CONFIG_DMA_RESTRICTED_POOL */
+	return false;
+}
+
 void __init swiotlb_exit(void);
 unsigned int swiotlb_max_segment(void);
 size_t swiotlb_max_mapping_size(struct device *dev);
@@ -131,6 +140,10 @@ static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
 {
 	return false;
 }
+static inline bool is_dev_swiotlb_force(struct device *dev)
+{
+	return false;
+}
 static inline void swiotlb_exit(void)
 {
 }
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index 13e9e7158d94..f94813674e23 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -87,7 +87,8 @@ static inline dma_addr_t dma_direct_map_page(struct device *dev,
 	phys_addr_t phys = page_to_phys(page) + offset;
 	dma_addr_t dma_addr = phys_to_dma(dev, phys);
 
-	if (unlikely(swiotlb_force == SWIOTLB_FORCE))
+	if (unlikely(swiotlb_force == SWIOTLB_FORCE) ||
+	    is_dev_swiotlb_force(dev))
 		return swiotlb_map(dev, phys, size, dir, attrs);
 
 	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 1d221343f1c8..96ff36d8ec53 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -344,7 +344,7 @@ void __init swiotlb_exit(void)
 static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size,
 			   enum dma_data_direction dir)
 {
-	struct io_tlb_mem *mem = io_tlb_default_mem;
+	struct io_tlb_mem *mem = get_io_tlb_mem(dev);
 	int index = (tlb_addr - mem->start) >> IO_TLB_SHIFT;
 	phys_addr_t orig_addr = mem->slots[index].orig_addr;
 	size_t alloc_size = mem->slots[index].alloc_size;
@@ -426,7 +426,7 @@ static unsigned int wrap_index(struct io_tlb_mem *mem, unsigned int index)
 static int find_slots(struct device *dev, phys_addr_t orig_addr,
 		size_t alloc_size)
 {
-	struct io_tlb_mem *mem = io_tlb_default_mem;
+	struct io_tlb_mem *mem = get_io_tlb_mem(dev);
 	unsigned long boundary_mask = dma_get_seg_boundary(dev);
 	dma_addr_t tbl_dma_addr =
 		phys_to_dma_unencrypted(dev, mem->start) & boundary_mask;
@@ -503,7 +503,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		size_t mapping_size, size_t alloc_size,
 		enum dma_data_direction dir, unsigned long attrs)
 {
-	struct io_tlb_mem *mem = io_tlb_default_mem;
+	struct io_tlb_mem *mem = get_io_tlb_mem(dev);
 	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
 	unsigned int i;
 	int index;
@@ -554,7 +554,7 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 			      size_t mapping_size, enum dma_data_direction dir,
 			      unsigned long attrs)
 {
-	struct io_tlb_mem *mem = io_tlb_default_mem;
+	struct io_tlb_mem *mem = get_io_tlb_mem(hwdev);
 	unsigned long flags;
 	unsigned int offset = swiotlb_align_offset(hwdev, tlb_addr);
 	int index = (tlb_addr - offset - mem->start) >> IO_TLB_SHIFT;
-- 
2.31.1.368.gbe11c130af-goog

