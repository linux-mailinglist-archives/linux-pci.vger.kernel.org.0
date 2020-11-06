Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457FF2A9A33
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 18:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbgKFRBN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Nov 2020 12:01:13 -0500
Received: from ale.deltatee.com ([204.191.154.188]:57914 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgKFRBG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Nov 2020 12:01:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SXfy4s8hoEPUTYM9kHHNonZmUe909URW6TTsyKH/U90=; b=BHzl7brWOE/xtPuLFhRTe7TuHr
        CCuWDnC47LTjBL2g1BoQKbHUoik8thlIDKyGFVrzXe/dGQN/+q/AWwhzkDSG6NdRqMWTmAk7orOgm
        KZqZo4YCrM1c5gq6KJoBazV729nnyG74Kar8Gv8V0vLg66n2prPHvabelgflf6qaiTIOa9nfeH69h
        ftQrsd9dF9OF9hUH3f7nuXp5nYN33gwIU7KdPW/+hieD4Z1ZUvgHpBdGlk2kU5ZtnPCHRdTHe98Ai
        4V4Av/tH/K18dDGBupBS5yz0N4oKJW3RHAb9dz2rzhTisd+rpgJpzqbgkHksBZ2JSO2NF4fo9vQ3a
        9Yf47kmw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kb56k-0002Pa-Ak; Fri, 06 Nov 2020 10:01:05 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kb56U-0004t2-LB; Fri, 06 Nov 2020 10:00:46 -0700
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
        Logan Gunthorpe <logang@deltatee.com>
Date:   Fri,  6 Nov 2020 10:00:26 -0700
Message-Id: <20201106170036.18713-6-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201106170036.18713-1-logang@deltatee.com>
References: <20201106170036.18713-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, jgg@ziepe.ca, christian.koenig@amd.com, dan.j.williams@intel.com, iweiny@intel.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [RFC PATCH 05/15] dma-direct: Support PCI P2PDMA pages in dma-direct map_sg
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCI P2PDMA support for dma_direct_map_sg() so that it can map
PCI P2PDMA pages directly without a hack in the callers. This allows
for heterogeneous SGLs that contain both P2PDMA and regular pages.

The DMA_ATTR_P2PDMA flag is added to allow callers to indicate support
for P2PDMA pages. In order for a caller to support P2PDMA pages they
must ensure no segment is greater than 2GB such that the high bit
of the dma length can be used as a flag to indicate a P2PDMA segment.
Such code must then ensure to use sg_dma_p2pdma_len() instead of
sg_dma_len() to filter out the flag.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 include/linux/dma-mapping.h | 11 +++++++++++
 kernel/dma/direct.c         | 33 +++++++++++++++++++++++++++++++--
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 956151052d45..8d028e15b531 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -61,6 +61,17 @@
  */
 #define DMA_ATTR_PRIVILEGED		(1UL << 9)
 
+/*
+ * DMA_ATTR_P2PDMA: specifies that dma_map_sg() may return p2pdma
+ * bus addresses. Code that specifies this must ensure to
+ * use sg_dma_p2pdma_len() instead of sg_dma_len() as the high
+ * bit of the length will indicate a P2PDMA bus address.
+ *
+ * If this attribute is not set and P2PDMA pages are encountered,
+ * dma_map_sg() will return an error.
+ */
+#define DMA_ATTR_P2PDMA			(1UL << 10)
+
 /*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
  * be given to a device to use as a DMA source or target.  It is specific to a
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 06c111544f61..2fcb31789436 100644
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
+		if (attrs & DMA_ATTR_P2PDMA && sg_dma_is_p2pdma(sg)) {
+			sg_dma_len(sg) &= ~SG_P2PDMA_FLAG;
+			continue;
+		}
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
+	int i, map = -1;
 	struct scatterlist *sg;
+	u64 bus_off;
 
 	for_each_sg(sgl, sg, nents, i) {
+		if (is_pci_p2pdma_page(sg_page(sg))) {
+			if (sg_page(sg)->pgmap != pgmap) {
+				pgmap = sg_page(sg)->pgmap;
+				map = pci_p2pdma_should_map_bus(dev, pgmap);
+				bus_off = pci_p2pdma_bus_offset(sg_page(sg));
+			}
+
+			if (map < 0 || !(attrs & DMA_ATTR_P2PDMA)) {
+				sg->dma_address = DMA_MAPPING_ERROR;
+				goto out_unmap;
+			}
+
+			if (map) {
+				sg->dma_address = sg_phys(sg) + sg->offset -
+					bus_off;
+				sg_dma_len(sg) = sg->length | SG_P2PDMA_FLAG;
+				continue;
+			}
+		}
+
 		sg->dma_address = dma_direct_map_page(dev, sg_page(sg),
 				sg->offset, sg->length, dir, attrs);
 		if (sg->dma_address == DMA_MAPPING_ERROR)
-- 
2.20.1

