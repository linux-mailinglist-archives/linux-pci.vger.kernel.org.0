Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310043A4530
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jun 2021 17:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbhFKPan (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Jun 2021 11:30:43 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:37645 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbhFKPai (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jun 2021 11:30:38 -0400
Received: by mail-pl1-f180.google.com with SMTP id h12so3009350plf.4
        for <linux-pci@vger.kernel.org>; Fri, 11 Jun 2021 08:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N9TVmO9aGqoduxqk5pFie0IHXd8vLspLVt82aTdw2co=;
        b=fiJV4qFUiRXaxOp4vBkL4JToBkgYVY+AaQy2O2SrrY5MvO7od5oJ3tYXCIi5YBEuJh
         DGJzgMCIu0uMgBXkHJ7/7dTWoJ1FXDPZDsfDXnlYmJUO5c8ZukGBzjI7CYg/CWlag+/P
         qBP0ch5ltrmS/XxZKNv+okJuDN4vM3IFZNebE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N9TVmO9aGqoduxqk5pFie0IHXd8vLspLVt82aTdw2co=;
        b=iPQpdPeFrPXc/l2/LVz/p9Z/TSzqMQ/C/S4eHK23Ue+ekiZ742FegTHTtPjEJ0LLYR
         aTLtIwiBSB3dFjVqsH17DrlAlNMBH/YhHyYOTY6nT0EKJX5KndD4pwxp3jZOCHpYBYWM
         1y60ahirUf0HUuiEIyDhCFlQg8nqlKgR59SPu6kJL4Eiszh3hVrJG/nv03KmW8uf9bRU
         pCUA91Efvfu9YU+ltaz+4LrgueveppDr3Y2P4PAF0IFA3H0PSFutlv8m5kibE955M5PG
         smwNmrSR+9MnvMUR5fm3LJGO3l0OZXC2GA5tfwjUmpmjevrW8XRaBpPk8jba93XryL8j
         iemA==
X-Gm-Message-State: AOAM533f0GpnZtxt2QC9TKj1KWZjUPW4VnJ0ajvFv56PqVc6D2U2vuqd
        spKtRlBJBoZm7jOxP6cX3A16SQ==
X-Google-Smtp-Source: ABdhPJx0OE49qJUIllsnRRF41WCicXTNT2KzJUs20xdPS7xiVUkY/qS3IozDVpjfuVo5+5ukcDBuNQ==
X-Received: by 2002:a17:90a:5309:: with SMTP id x9mr9513136pjh.111.1623425259905;
        Fri, 11 Jun 2021 08:27:39 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:33c8:8e01:1161:6797])
        by smtp.gmail.com with UTF8SMTPSA id t143sm6505494pgb.93.2021.06.11.08.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 08:27:39 -0700 (PDT)
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
Subject: [PATCH v9 03/14] swiotlb: Set dev->dma_io_tlb_mem to the swiotlb pool used
Date:   Fri, 11 Jun 2021 23:26:48 +0800
Message-Id: <20210611152659.2142983-4-tientzu@chromium.org>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
In-Reply-To: <20210611152659.2142983-1-tientzu@chromium.org>
References: <20210611152659.2142983-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Always have the pointer to the swiotlb pool used in struct device. This
could help simplify the code for other pools.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 drivers/of/device.c     | 3 +++
 include/linux/device.h  | 4 ++++
 include/linux/swiotlb.h | 8 ++++++++
 kernel/dma/swiotlb.c    | 8 ++++----
 4 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index c5a9473a5fb1..1defdf15ba95 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -165,6 +165,9 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 
 	arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
 
+	if (IS_ENABLED(CONFIG_SWIOTLB))
+		swiotlb_set_io_tlb_default_mem(dev);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_dma_configure_id);
diff --git a/include/linux/device.h b/include/linux/device.h
index 4443e12238a0..2e9a378c9100 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -432,6 +432,7 @@ struct dev_links_info {
  * @dma_pools:	Dma pools (if dma'ble device).
  * @dma_mem:	Internal for coherent mem override.
  * @cma_area:	Contiguous memory area for dma allocations
+ * @dma_io_tlb_mem: Pointer to the swiotlb pool used.  Not for driver use.
  * @archdata:	For arch-specific additions.
  * @of_node:	Associated device tree node.
  * @fwnode:	Associated device node supplied by platform firmware.
@@ -540,6 +541,9 @@ struct device {
 #ifdef CONFIG_DMA_CMA
 	struct cma *cma_area;		/* contiguous memory area for dma
 					   allocations */
+#endif
+#ifdef CONFIG_SWIOTLB
+	struct io_tlb_mem *dma_io_tlb_mem;
 #endif
 	/* arch specific additions */
 	struct dev_archdata	archdata;
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 216854a5e513..008125ccd509 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -108,6 +108,11 @@ static inline bool is_swiotlb_buffer(phys_addr_t paddr)
 	return mem && paddr >= mem->start && paddr < mem->end;
 }
 
+static inline void swiotlb_set_io_tlb_default_mem(struct device *dev)
+{
+	dev->dma_io_tlb_mem = io_tlb_default_mem;
+}
+
 void __init swiotlb_exit(void);
 unsigned int swiotlb_max_segment(void);
 size_t swiotlb_max_mapping_size(struct device *dev);
@@ -119,6 +124,9 @@ static inline bool is_swiotlb_buffer(phys_addr_t paddr)
 {
 	return false;
 }
+static inline void swiotlb_set_io_tlb_default_mem(struct device *dev)
+{
+}
 static inline void swiotlb_exit(void)
 {
 }
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 8a3e2b3b246d..29b950ab1351 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -344,7 +344,7 @@ void __init swiotlb_exit(void)
 static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size,
 			   enum dma_data_direction dir)
 {
-	struct io_tlb_mem *mem = io_tlb_default_mem;
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 	int index = (tlb_addr - mem->start) >> IO_TLB_SHIFT;
 	phys_addr_t orig_addr = mem->slots[index].orig_addr;
 	size_t alloc_size = mem->slots[index].alloc_size;
@@ -426,7 +426,7 @@ static unsigned int wrap_index(struct io_tlb_mem *mem, unsigned int index)
 static int find_slots(struct device *dev, phys_addr_t orig_addr,
 		size_t alloc_size)
 {
-	struct io_tlb_mem *mem = io_tlb_default_mem;
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 	unsigned long boundary_mask = dma_get_seg_boundary(dev);
 	dma_addr_t tbl_dma_addr =
 		phys_to_dma_unencrypted(dev, mem->start) & boundary_mask;
@@ -503,7 +503,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		size_t mapping_size, size_t alloc_size,
 		enum dma_data_direction dir, unsigned long attrs)
 {
-	struct io_tlb_mem *mem = io_tlb_default_mem;
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
 	unsigned int i;
 	int index;
@@ -554,7 +554,7 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 			      size_t mapping_size, enum dma_data_direction dir,
 			      unsigned long attrs)
 {
-	struct io_tlb_mem *mem = io_tlb_default_mem;
+	struct io_tlb_mem *mem = hwdev->dma_io_tlb_mem;
 	unsigned long flags;
 	unsigned int offset = swiotlb_align_offset(hwdev, tlb_addr);
 	int index = (tlb_addr - offset - mem->start) >> IO_TLB_SHIFT;
-- 
2.32.0.272.g935e593368-goog

