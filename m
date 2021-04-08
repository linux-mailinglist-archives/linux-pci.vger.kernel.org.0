Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB570358AA1
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 19:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbhDHRB7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 13:01:59 -0400
Received: from ale.deltatee.com ([204.191.154.188]:36174 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbhDHRBy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Apr 2021 13:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=tlAUAM4FKdp5C5xhf+V1g45WbBrDWzP8fEWhlnVYrUo=; b=n1bSGXMx3FYhH1wzUo2jGEZ9ak
        pQQSQeBdx02fo7qz3c0uJZbUiLQuVUKGlgrY+2MYQhQXzs4WrKFiAJJBMygOY3za0UJZjQ71S5VO7
        kLVGt+EaaqTJ6C81L9qZoZgce96ZyjCKRWGhUJ8KwGKx8hfWUZiwsrQHcmYDgFDt2vtxZCDqwWlhh
        61udMmg/gv/fOKFrrOIuICZYqlicG0YgklOkg6Gwuh5kGrGuwA7QtnvcI7CDUkzAk3dN3vMe8KRfF
        AxcImGFGm7NKynTXZqly83Br1CgSG82zQ1LfEorx0W8mYIor6QjAa0KE0ZsRAY+VaJcL6/zSF4zhh
        jNFr+nFQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1lUY2G-0002Lk-TI; Thu, 08 Apr 2021 11:01:42 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1lUY25-0002Ix-Ig; Thu, 08 Apr 2021 11:01:29 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu,  8 Apr 2021 11:01:12 -0600
Message-Id: <20210408170123.8788-6-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408170123.8788-1-logang@deltatee.com>
References: <20210408170123.8788-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_FREE,MYRULES_NO_TEXT autolearn=no autolearn_force=no
        version=3.4.2
Subject: [PATCH 05/16] dma-mapping: Introduce dma_map_sg_p2pdma()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

dma_map_sg() either returns a positive number indicating the number
of entries mapped or zero indicating that resources were not available
to create the mapping. When zero is returned, it is always safe to retry
the mapping later once resources have been freed.

Once P2PDMA pages are mixed into the SGL there may be pages that may
never be successfully mapped with a given device because that device may
not actually be able to access those pages. Thus, multiple error
conditions will need to be distinguished to determine weather a retry
is safe.

Introduce dma_map_sg_p2pdma[_attrs]() with a different calling
convention from dma_map_sg(). The function will return a positive
integer on success or a negative errno on failure.

ENOMEM will be used to indicate a resource failure and EREMOTEIO to
indicate that a P2PDMA page is not mappable.

The __DMA_ATTR_PCI_P2PDMA attribute is introduced to inform the lower
level implementations that P2PDMA pages are allowed and to warn if a
caller introduces them into the regular dma_map_sg() interface.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 include/linux/dma-mapping.h | 15 +++++++++++
 kernel/dma/mapping.c        | 52 ++++++++++++++++++++++++++++++++-----
 2 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 2a984cb4d1e0..50b8f586cf59 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -60,6 +60,12 @@
  * at least read-only at lesser-privileged levels).
  */
 #define DMA_ATTR_PRIVILEGED		(1UL << 9)
+/*
+ * __DMA_ATTR_PCI_P2PDMA: This should not be used directly, use
+ * dma_map_sg_p2pdma() instead. Used internally to indicate that the
+ * caller is using the dma_map_sg_p2pdma() interface.
+ */
+#define __DMA_ATTR_PCI_P2PDMA		(1UL << 10)
 
 /*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
@@ -107,6 +113,8 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
 		enum dma_data_direction dir, unsigned long attrs);
 int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
 		enum dma_data_direction dir, unsigned long attrs);
+int dma_map_sg_p2pdma_attrs(struct device *dev, struct scatterlist *sg,
+		int nents, enum dma_data_direction dir, unsigned long attrs);
 void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 				      int nents, enum dma_data_direction dir,
 				      unsigned long attrs);
@@ -160,6 +168,12 @@ static inline int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 {
 	return 0;
 }
+static inline int dma_map_sg_p2pdma_attrs(struct device *dev,
+		struct scatterlist *sg, int nents, enum dma_data_direction dir,
+		unsigned long attrs)
+{
+	return 0;
+}
 static inline void dma_unmap_sg_attrs(struct device *dev,
 		struct scatterlist *sg, int nents, enum dma_data_direction dir,
 		unsigned long attrs)
@@ -392,6 +406,7 @@ static inline void dma_sync_sgtable_for_device(struct device *dev,
 #define dma_map_single(d, a, s, r) dma_map_single_attrs(d, a, s, r, 0)
 #define dma_unmap_single(d, a, s, r) dma_unmap_single_attrs(d, a, s, r, 0)
 #define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
+#define dma_map_sg_p2pdma(d, s, n, r) dma_map_sg_p2pdma_attrs(d, s, n, r, 0)
 #define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
 #define dma_map_page(d, p, o, s, r) dma_map_page_attrs(d, p, o, s, r, 0)
 #define dma_unmap_page(d, a, s, r) dma_unmap_page_attrs(d, a, s, r, 0)
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index b6a633679933..923089c4267b 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -177,12 +177,8 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
 }
 EXPORT_SYMBOL(dma_unmap_page_attrs);
 
-/*
- * dma_maps_sg_attrs returns 0 on error and > 0 on success.
- * It should never return a value < 0.
- */
-int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
-		enum dma_data_direction dir, unsigned long attrs)
+static int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 	int ents;
@@ -197,6 +193,20 @@ int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
 		ents = dma_direct_map_sg(dev, sg, nents, dir, attrs);
 	else
 		ents = ops->map_sg(dev, sg, nents, dir, attrs);
+
+	return ents;
+}
+
+/*
+ * dma_maps_sg_attrs returns 0 on error and > 0 on success.
+ * It should never return a value < 0.
+ */
+int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
+		enum dma_data_direction dir, unsigned long attrs)
+{
+	int ents;
+
+	ents = __dma_map_sg_attrs(dev, sg, nents, dir, attrs);
 	BUG_ON(ents < 0);
 	debug_dma_map_sg(dev, sg, nents, ents, dir);
 
@@ -204,6 +214,36 @@ int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
 }
 EXPORT_SYMBOL(dma_map_sg_attrs);
 
+/*
+ * like dma_map_sg_attrs, but returns a negative errno on error (and > 0
+ * on success). This function must be used if PCI P2PDMA pages might
+ * be in the scatterlist.
+ *
+ * On error this function may return:
+ *    -ENOMEM indicating that there was not enough resources available and
+ *      the transfer may be retried later
+ *    -EREMOTEIO indicating that P2PDMA pages were included but cannot
+ *      be mapped by the specified device, retries will always fail
+ *
+ * The scatterlist should be unmapped with the regular dma_unmap_sg[_attrs]().
+ */
+int dma_map_sg_p2pdma_attrs(struct device *dev, struct scatterlist *sg,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
+{
+	int ents;
+
+	ents = __dma_map_sg_attrs(dev, sg, nents, dir,
+				  attrs | __DMA_ATTR_PCI_P2PDMA);
+	if (!ents)
+		ents = -ENOMEM;
+
+	if (ents > 0)
+		debug_dma_map_sg(dev, sg, nents, ents, dir);
+
+	return ents;
+}
+EXPORT_SYMBOL_GPL(dma_map_sg_p2pdma_attrs);
+
 void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 				      int nents, enum dma_data_direction dir,
 				      unsigned long attrs)
-- 
2.20.1

