Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B776392EF6
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 15:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236297AbhE0NFz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 09:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235896AbhE0NFu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 May 2021 09:05:50 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E614C06138D
        for <linux-pci@vger.kernel.org>; Thu, 27 May 2021 06:04:03 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 29so3628557pgu.11
        for <linux-pci@vger.kernel.org>; Thu, 27 May 2021 06:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MYsbpvk1elzDffjY4lVqlSBet3lNsQF2QtHREtnNje4=;
        b=IyvYtT1AB6E4xwxKSFDYkZ5n98xR0l1LZiUkJW0MW5CgH/i5aGIsnRF/JPxxLV994w
         6zBxh1X3gHavrt/AsvfReKnILPfzC/l6kkFOeK3VrBIogUw16ui2Ro+3Hw3QPFy2pWGM
         +/sNzLuWK+E6zh1p0Gxt9RmiN+wGdEuT6cNDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MYsbpvk1elzDffjY4lVqlSBet3lNsQF2QtHREtnNje4=;
        b=cRR1ht0jsrneSUhe138Fpzy95UAfdNegMd5r2HMLtWsawcn+gz48SVJVWsVXhxeJfP
         Qg/flYwLmxPl9Sry4IkQPSndLxN19INsiHruH6G9+n5SG57teW2nSSouxA+rUK7dJAam
         Q2RComVEizNz8tNf7Ft9kxG8AqyEoC73a2LKIOIuPYBVJprDf26B/ubcDBS6JUb+Uww9
         DEiKeTEWoQiEiFPRbChaPlmQkiT69+c8i2wv51fvb/7MpQuaombRom0R5HBTe5zv2PA1
         YY4n1XB/iq5uq3LKnyCkfgE9M8s2C6j1yly/P+oxLFf29uXbwe0y7Uj5GgXBCGLdMZ5X
         QdPA==
X-Gm-Message-State: AOAM531x70I0kC8AVvdIqZCyk8cOoBTgtnZZ5optt3RO7IscxyF1B8q9
        t+Ks9wtP4acfwCoAt4yZYJBNnQ==
X-Google-Smtp-Source: ABdhPJxiOdBGPcWtjBuPQLZxflfz/miVWdNfGLJRIpkM261jkyasjOonUIh30AqgExiX3771SeFH4Q==
X-Received: by 2002:a63:4d11:: with SMTP id a17mr3584089pgb.266.1622120642890;
        Thu, 27 May 2021 06:04:02 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:a93:378d:9a9e:3b70])
        by smtp.gmail.com with UTF8SMTPSA id n1sm1934646pjv.40.2021.05.27.06.03.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 06:04:02 -0700 (PDT)
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
Subject: [PATCH v8 13/15] dma-direct: Allocate memory from restricted DMA pool if available
Date:   Thu, 27 May 2021 21:03:27 +0800
Message-Id: <20210527130329.1853588-3-tientzu@chromium.org>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
In-Reply-To: <20210527130329.1853588-1-tientzu@chromium.org>
References: <20210527130329.1853588-1-tientzu@chromium.org>
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
 kernel/dma/direct.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index eb4098323bbc..0d521f78c7b9 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -78,6 +78,10 @@ static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 static void __dma_direct_free_pages(struct device *dev, struct page *page,
 				    size_t size)
 {
+#ifdef CONFIG_DMA_RESTRICTED_POOL
+	if (swiotlb_free(dev, page, size))
+		return;
+#endif
 	dma_free_contiguous(dev, page, size);
 }
 
@@ -92,7 +96,17 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 
 	gfp |= dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
 					   &phys_limit);
-	page = dma_alloc_contiguous(dev, size, gfp);
+
+#ifdef CONFIG_DMA_RESTRICTED_POOL
+	page = swiotlb_alloc(dev, size);
+	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
+		__dma_direct_free_pages(dev, page, size);
+		page = NULL;
+	}
+#endif
+
+	if (!page)
+		page = dma_alloc_contiguous(dev, size, gfp);
 	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
 		dma_free_contiguous(dev, page, size);
 		page = NULL;
@@ -148,7 +162,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		gfp |= __GFP_NOWARN;
 
 	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
-	    !force_dma_unencrypted(dev)) {
+	    !force_dma_unencrypted(dev) && !is_dev_swiotlb_force(dev)) {
 		page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO);
 		if (!page)
 			return NULL;
@@ -161,18 +175,23 @@ void *dma_direct_alloc(struct device *dev, size_t size,
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
@@ -253,15 +272,15 @@ void dma_direct_free(struct device *dev, size_t size,
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
@@ -289,7 +308,8 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 	void *ret;
 
 	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
-	    force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp))
+	    force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp) &&
+	    !is_dev_swiotlb_force(dev))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
 	page = __dma_direct_alloc_pages(dev, size, gfp);
-- 
2.31.1.818.g46aad6cb9e-goog

