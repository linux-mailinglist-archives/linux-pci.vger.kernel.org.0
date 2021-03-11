Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CA03381CF
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 00:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbhCKXtA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Mar 2021 18:49:00 -0500
Received: from ale.deltatee.com ([204.191.154.188]:45208 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhCKXsp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Mar 2021 18:48:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=5m+PzWqUWnOR3YxadyZCg0MfweU6UruMUlqYZWYNYZM=; b=HV/kvTIN+l3Mjh5BJT+0f0JjD8
        P6NqH+K5UqG4RHUSkRXS55CWxhlfN8E2lcAnezcnbPCxPgqjSDCeptqojK/JrP65f6TtoiSv+NLzp
        i6CTfLrDVHkXIL8Jm++pnpKOzRx64R6plr4lmBgo2J86KWpIa5RUob7/lMB/i+2tMsw3mKATtPvU7
        k5xJoWpB3bmKp16E0VOC+RoakdJYP+xRQUbJZopKLN8frZh+KI0iyApQnWSi0ByDGcKuFpu1/qnh7
        5Pa7/Ot9X9cYqQbjRcHQ+GxkViOGRZhbHsZ8W+7xZ3B0JN6TLomzW1Z4Z5QoUjYegFZVnsHaWnImv
        uJfSt0Bw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1lKUmp-0003ev-A4; Thu, 11 Mar 2021 16:32:12 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1lKUmW-00024b-Hp; Thu, 11 Mar 2021 16:31:52 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Ira Weiny <iweiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 11 Mar 2021 16:31:36 -0700
Message-Id: <20210311233142.7900-7-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210311233142.7900-1-logang@deltatee.com>
References: <20210311233142.7900-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, dan.j.williams@intel.com, iweiny@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_NO_TEXT autolearn=no autolearn_force=no version=3.4.2
Subject: [RFC PATCH v2 06/11] dma-direct: Support PCI P2PDMA pages in dma-direct map_sg
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCI P2PDMA support for dma_direct_map_sg() so that it can map
PCI P2PDMA pages directly without a hack in the callers. This allows
for heterogeneous SGLs that contain both P2PDMA and regular pages.

SGL segments that contain PCI bus addresses are marked with
sg_mark_pci_p2pdma() and are ignored when unmapped.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 kernel/dma/direct.c  | 35 ++++++++++++++++++++++++++++++++---
 kernel/dma/mapping.c | 13 ++++++++++---
 2 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 002268262c9a..f326d32062dd 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -13,6 +13,7 @@
 #include <linux/vmalloc.h>
 #include <linux/set_memory.h>
 #include <linux/slab.h>
+#include <linux/pci-p2pdma.h>
 #include "direct.h"
 
 /*
@@ -387,19 +388,47 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
 	struct scatterlist *sg;
 	int i;
 
-	for_each_sg(sgl, sg, nents, i)
+	for_each_sg(sgl, sg, nents, i) {
+		if (sg_is_pci_p2pdma(sg))
+			continue;
+
 		dma_direct_unmap_page(dev, sg->dma_address, sg_dma_len(sg), dir,
 			     attrs);
+	}
 }
 #endif
 
 int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 		enum dma_data_direction dir, unsigned long attrs)
 {
-	int i;
+	struct dev_pagemap *pgmap = NULL;
+	int i, map = -1, ret = 0;
 	struct scatterlist *sg;
+	u64 bus_off;
 
 	for_each_sg(sgl, sg, nents, i) {
+		if (is_pci_p2pdma_page(sg_page(sg))) {
+			if (sg_page(sg)->pgmap != pgmap) {
+				pgmap = sg_page(sg)->pgmap;
+				map = pci_p2pdma_dma_map_type(dev, pgmap);
+				bus_off = pci_p2pdma_bus_offset(sg_page(sg));
+			}
+
+			if (map < 0) {
+				sg->dma_address = DMA_MAPPING_ERROR;
+				ret = -EREMOTEIO;
+				goto out_unmap;
+			}
+
+			if (map) {
+				sg->dma_address = sg_phys(sg) + sg->offset -
+					bus_off;
+				sg_dma_len(sg) = sg->length;
+				sg_mark_pci_p2pdma(sg);
+				continue;
+			}
+		}
+
 		sg->dma_address = dma_direct_map_page(dev, sg_page(sg),
 				sg->offset, sg->length, dir, attrs);
 		if (sg->dma_address == DMA_MAPPING_ERROR)
@@ -411,7 +440,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 
 out_unmap:
 	dma_direct_unmap_sg(dev, sgl, i, dir, attrs | DMA_ATTR_SKIP_CPU_SYNC);
-	return 0;
+	return ret;
 }
 
 dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index b6a633679933..adc1a83950be 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -178,8 +178,15 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
 EXPORT_SYMBOL(dma_unmap_page_attrs);
 
 /*
- * dma_maps_sg_attrs returns 0 on error and > 0 on success.
- * It should never return a value < 0.
+ * dma_maps_sg_attrs returns 0 on any resource error and > 0 on success.
+ *
+ * If 0 is returned, the mapping can be retried and will succeed once
+ * sufficient resources are available.
+ *
+ * If there are P2PDMA pages in the scatterlist then this function may
+ * return -EREMOTEIO to indicate that the pages are not mappable by the
+ * device. In this case, an error should be returned for the IO as it
+ * will never be successfully retried.
  */
 int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
 		enum dma_data_direction dir, unsigned long attrs)
@@ -197,7 +204,7 @@ int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
 		ents = dma_direct_map_sg(dev, sg, nents, dir, attrs);
 	else
 		ents = ops->map_sg(dev, sg, nents, dir, attrs);
-	BUG_ON(ents < 0);
+
 	debug_dma_map_sg(dev, sg, nents, ents, dir);
 
 	return ents;
-- 
2.20.1

