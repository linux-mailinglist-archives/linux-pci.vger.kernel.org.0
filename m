Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB1C392ED5
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 15:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236016AbhE0NFS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 09:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235177AbhE0NFR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 May 2021 09:05:17 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28F1C061574
        for <linux-pci@vger.kernel.org>; Thu, 27 May 2021 06:03:44 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d16so505100pfn.12
        for <linux-pci@vger.kernel.org>; Thu, 27 May 2021 06:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m7+uI7rGPgfSKn+aVdUzTy5/dZn0TD9snxYJvtDtWr8=;
        b=ftmREmcxrJM5ghdWu3uu6RoVOQmn/FmRG0fXdD0sAjbx0bczGkzwvRTurlvaYuIvJW
         x3lcL0ttraMgqRb6RQUndSyEBiGIY3jtWjTqxgCUrCG/1jwY14bstcfPs5KZ9RhvRj5W
         T2wJrb10vnObIKglZGitAlnSSqiKkQCQp8AYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m7+uI7rGPgfSKn+aVdUzTy5/dZn0TD9snxYJvtDtWr8=;
        b=E/R822uymTxYP+Er1u6l3bgHQwb8Fs2mA8VL5mm7Cx9qRp0+cTfwN8boTT5R/ApeVM
         wqJjfEd+nJorSewVaSHFFp9GXx8KZEai8fWRQhVs3geKrzq0u3QXBtwOjmtVLTthEEgu
         n6U8ncl+Z9NvWf9buKU4Jtnam58FtSLsZYy85Wk3ldSh8l6oiQgOf2CHA/+s1B2H+Htu
         txsi9iAHv5je1haKf022aNdwNcLq/enYZA5QZy3wra9ZcC09y3Ew68sN2ek7tGkrxtuy
         DHeuGfrvGsPUEdBjFtZ3kpGWV5j3qSSZpC+/oHd1b5mqn+AkF5bBq6ycFoKVc4dEc+GE
         TSfQ==
X-Gm-Message-State: AOAM531mBz2vQmBzIBCAE1TW+UIA40NDSQSlvd66A4kR8pAw9TWPc9WH
        qENztCJP9n362iwT2dcYdQCGzQ==
X-Google-Smtp-Source: ABdhPJwFMAyQyClkgtD2WU3AOT0NSiYpDWGkYsiRLX3TSIJ7iJhjuPVvZAr31+YEfks0HMDDaEOArA==
X-Received: by 2002:a05:6a00:216a:b029:2df:3461:4ac3 with SMTP id r10-20020a056a00216ab02902df34614ac3mr3590982pff.80.1622120624345;
        Thu, 27 May 2021 06:03:44 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:a93:378d:9a9e:3b70])
        by smtp.gmail.com with UTF8SMTPSA id w15sm2015155pjy.1.2021.05.27.06.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 06:03:41 -0700 (PDT)
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
Subject: [PATCH v8 11/15] dma-direct: Add a new wrapper __dma_direct_free_pages()
Date:   Thu, 27 May 2021 21:03:25 +0800
Message-Id: <20210527130329.1853588-1-tientzu@chromium.org>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a new wrapper __dma_direct_free_pages() that will be useful later
for swiotlb_free().

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 kernel/dma/direct.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 078f7087e466..eb4098323bbc 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -75,6 +75,12 @@ static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 		min_not_zero(dev->coherent_dma_mask, dev->bus_dma_limit);
 }
 
+static void __dma_direct_free_pages(struct device *dev, struct page *page,
+				    size_t size)
+{
+	dma_free_contiguous(dev, page, size);
+}
+
 static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 		gfp_t gfp)
 {
@@ -237,7 +243,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 			return NULL;
 	}
 out_free_pages:
-	dma_free_contiguous(dev, page, size);
+	__dma_direct_free_pages(dev, page, size);
 	return NULL;
 }
 
@@ -273,7 +279,7 @@ void dma_direct_free(struct device *dev, size_t size,
 	else if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_CLEAR_UNCACHED))
 		arch_dma_clear_uncached(cpu_addr, size);
 
-	dma_free_contiguous(dev, dma_direct_to_page(dev, dma_addr), size);
+	__dma_direct_free_pages(dev, dma_direct_to_page(dev, dma_addr), size);
 }
 
 struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
@@ -310,7 +316,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
 	return page;
 out_free_pages:
-	dma_free_contiguous(dev, page, size);
+	__dma_direct_free_pages(dev, page, size);
 	return NULL;
 }
 
@@ -329,7 +335,7 @@ void dma_direct_free_pages(struct device *dev, size_t size,
 	if (force_dma_unencrypted(dev))
 		set_memory_encrypted((unsigned long)vaddr, 1 << page_order);
 
-	dma_free_contiguous(dev, page, size);
+	__dma_direct_free_pages(dev, page, size);
 }
 
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
-- 
2.31.1.818.g46aad6cb9e-goog

