Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7843A455D
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jun 2021 17:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbhFKPcJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Jun 2021 11:32:09 -0400
Received: from mail-pj1-f44.google.com ([209.85.216.44]:55023 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbhFKPb5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jun 2021 11:31:57 -0400
Received: by mail-pj1-f44.google.com with SMTP id g24so5881862pji.4
        for <linux-pci@vger.kernel.org>; Fri, 11 Jun 2021 08:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zXV34JP57GpdYi7KETjy6yE9WG6lb3BfY1eExPN5D0k=;
        b=n/l5cUK61jqQlbzQONnRrSTYUM2heU0XHxLqBLodv+ZACW+eYtMX6UrtLKV+DFbDS4
         ciYFCzgOAsbkB8Yxzp2dJIy6q04U2SdNzdIuxnanEC3CRC9P9XtiJVSvAilxoKjJrOtm
         FosJPFUL7qbFgUfC4+wahlbwgRASvGZhQwnMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zXV34JP57GpdYi7KETjy6yE9WG6lb3BfY1eExPN5D0k=;
        b=APkdKFFLb/Fs80X7Hc/I2S3WiPcYDGY18VmfCivnc5tl7cXCPUjUcOgSHey99Y2kEx
         BA1B3WIZbFPZbmnYUwHGkoiUUa8FG87wm7EdIPBtCvCEU6jDcr87t8ujSkWGaiI3+tNk
         xb/qBjOlB9LmdFhhSTgRh4AjSwdjw05l6ZgcsDWv/e4gzR8BaKNwy9lhwV11Rk3wDWwu
         mSPq7Q67N1ozdLzG9YadKN7SCFk0lbMg0L8hpXJENCZHdCkjA2fw/AOmnoq6FjFuHZ6y
         fzPjBKfWgLWEgzH/h1KVu/yMCYZjsWXFtWB1bf2aD5AirWHZYJwLq8NSP7Nfx7YmBhef
         b+zw==
X-Gm-Message-State: AOAM531YstUKOOlbmKAIiWdU9NGhGZN3l7zwNWO/N53vryjxyemM0134
        z86dzRbTEWOnP7ke4nUOTZkuVw==
X-Google-Smtp-Source: ABdhPJxO4yId/BXBPVPZ3GpkGGg2f5gxH07V1pBB/gWW/cLxB2G3X66ogJG3rkzaS8olzWg6RRH4fw==
X-Received: by 2002:a17:90a:b10a:: with SMTP id z10mr5159407pjq.226.1623425339045;
        Fri, 11 Jun 2021 08:28:59 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:33c8:8e01:1161:6797])
        by smtp.gmail.com with UTF8SMTPSA id z7sm5637671pgr.28.2021.06.11.08.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 08:28:58 -0700 (PDT)
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
Subject: [PATCH v9 12/14] dma-direct: Allocate memory from restricted DMA pool if available
Date:   Fri, 11 Jun 2021 23:26:57 +0800
Message-Id: <20210611152659.2142983-13-tientzu@chromium.org>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
In-Reply-To: <20210611152659.2142983-1-tientzu@chromium.org>
References: <20210611152659.2142983-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The restricted DMA pool is preferred if available.

The restricted DMA pools provide a basic level of protection against the
DMA overwriting buffer contents at unexpected times. However, to protect
against general data leakage and system memory corruption, the system
needs to provide a way to lock down the memory access, e.g., MPU.

Note that since coherent allocation needs remapping, one must set up
another device coherent pool by shared-dma-pool and use
dma_alloc_from_dev_coherent instead for atomic coherent allocation.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 kernel/dma/direct.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index eb4098323bbc..73fc4c659ba7 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -78,6 +78,9 @@ static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 static void __dma_direct_free_pages(struct device *dev, struct page *page,
 				    size_t size)
 {
+	if (IS_ENABLED(CONFIG_DMA_RESTRICTED_POOL) &&
+	    swiotlb_free(dev, page, size))
+		return;
 	dma_free_contiguous(dev, page, size);
 }
 
@@ -92,7 +95,17 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 
 	gfp |= dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
 					   &phys_limit);
-	page = dma_alloc_contiguous(dev, size, gfp);
+	if (IS_ENABLED(CONFIG_DMA_RESTRICTED_POOL)) {
+		page = swiotlb_alloc(dev, size);
+		if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
+			__dma_direct_free_pages(dev, page, size);
+			page = NULL;
+		}
+		return page;
+	}
+
+	if (!page)
+		page = dma_alloc_contiguous(dev, size, gfp);
 	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
 		dma_free_contiguous(dev, page, size);
 		page = NULL;
@@ -148,7 +161,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		gfp |= __GFP_NOWARN;
 
 	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
-	    !force_dma_unencrypted(dev)) {
+	    !force_dma_unencrypted(dev) && !is_dev_swiotlb_force(dev)) {
 		page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO);
 		if (!page)
 			return NULL;
@@ -161,18 +174,23 @@ void *dma_direct_alloc(struct device *dev, size_t size,
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
@@ -253,15 +271,15 @@ void dma_direct_free(struct device *dev, size_t size,
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
@@ -289,7 +307,8 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 	void *ret;
 
 	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
-	    force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp))
+	    force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp) &&
+	    !is_dev_swiotlb_force(dev))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
 	page = __dma_direct_alloc_pages(dev, size, gfp);
-- 
2.32.0.272.g935e593368-goog

