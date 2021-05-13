Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6B7380027
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 00:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbhEMWdg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 May 2021 18:33:36 -0400
Received: from ale.deltatee.com ([204.191.154.188]:59088 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbhEMWdb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 May 2021 18:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=lWGbgyrVHCS+eDkzezPE7snTMKi1qyZNkpud4uIth9Q=; b=eT3/XZRQRvJe7oDVrGPu3gi/gQ
        ECMvkZuB1Gyn+ysL0vDzqEaS1ofAI8Dbehq+9Krrbg8PZk/7Cli68Fjf99mvcPJ0OUoIGF+15mSuk
        iTEDZhBoz5YlDr1Spu5WPHvhHbtB8ZaUIx33LG1JaBiM2lBUFv7cqn32PmJu3YZxfD24r+Ag1IJD9
        06oYmdpxbvKeQ05iIR8NVhAb9zpq51s/ZwuIrLS0jW/a29svvT2J4S9tXmgI3v4DoFcGSajBP/uK4
        xocY8ptxHIcMjNHSZyhhXxUKEe4XwWB7bG/3lx1GIXwAJXedDRkTRmRUFobzCpqBDe7fvPztFSlT/
        i7EwFpxw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1lhJsR-0000nE-Sx; Thu, 13 May 2021 16:32:20 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1lhJsI-0001TH-8a; Thu, 13 May 2021 16:32:10 -0600
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
Date:   Thu, 13 May 2021 16:31:58 -0600
Message-Id: <20210513223203.5542-18-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210513223203.5542-1-logang@deltatee.com>
References: <20210513223203.5542-1-logang@deltatee.com>
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
Subject: [PATCH v2 17/22] iommu/dma: Support PCI P2PDMA pages in dma-iommu map_sg
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When a PCI P2PDMA page is seen, set the IOVA length of the segment
to zero so that it is not mapped into the IOVA. Then, in finalise_sg(),
apply the appropriate bus address to the segment. The IOVA is not
created if the scatterlist only consists of P2PDMA pages.

A P2PDMA page may have three possible outcomes when being mapped:
  1) If the data path between the two devices doesn't go through
     the root port, then it should be mapped with a PCI bus address
  2) If the data path goes through the host bridge, it should be mapped
     normally with an IOMMU IOVA.
  3) It is not possible for the two devices to communicate and thus
     the mapping operation should fail (and it will return -EREMOTEIO).

Similar to dma-direct, the sg_dma_mark_pci_p2pdma() flag is used to
indicate bus address segments. On unmap, P2PDMA segments are skipped
over when determining the start and end IOVA addresses.

With this change, the flags variable in the dma_map_ops is set to
DMA_F_PCI_P2PDMA_SUPPORTED to indicate support for P2PDMA pages.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/iommu/dma-iommu.c | 66 +++++++++++++++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 0d69f509a95d..7cc6650e1fa5 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -20,6 +20,7 @@
 #include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
+#include <linux/pci-p2pdma.h>
 #include <linux/swiotlb.h>
 #include <linux/scatterlist.h>
 #include <linux/vmalloc.h>
@@ -891,6 +892,16 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
 		sg_dma_address(s) = DMA_MAPPING_ERROR;
 		sg_dma_len(s) = 0;
 
+		if (is_pci_p2pdma_page(sg_page(s)) && !s_iova_len) {
+			if (i > 0)
+				cur = sg_next(cur);
+
+			pci_p2pdma_map_bus_segment(s, cur);
+			count++;
+			cur_len = 0;
+			continue;
+		}
+
 		/*
 		 * Now fill in the real DMA data. If...
 		 * - there is a valid output segment to append to
@@ -988,6 +999,8 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	struct iova_domain *iovad = &cookie->iovad;
 	struct scatterlist *s, *prev = NULL;
 	int prot = dma_info_to_prot(dir, dev_is_dma_coherent(dev), attrs);
+	struct dev_pagemap *pgmap = NULL;
+	enum pci_p2pdma_map_type map_type;
 	dma_addr_t iova;
 	size_t iova_len = 0;
 	unsigned long mask = dma_get_seg_boundary(dev);
@@ -1023,6 +1036,35 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		s_length = iova_align(iovad, s_length + s_iova_off);
 		s->length = s_length;
 
+		if (is_pci_p2pdma_page(sg_page(s))) {
+			if (sg_page(s)->pgmap != pgmap) {
+				pgmap = sg_page(s)->pgmap;
+				map_type = pci_p2pdma_map_type(pgmap, dev);
+			}
+
+			switch (map_type) {
+			case PCI_P2PDMA_MAP_BUS_ADDR:
+				/*
+				 * A zero length will be ignored by
+				 * iommu_map_sg() and then can be detected
+				 * in __finalise_sg() to actually map the
+				 * bus address.
+				 */
+				s->length = 0;
+				continue;
+			case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
+				/*
+				 * Mapping through host bridge should be
+				 * mapped with regular IOVAs, thus we
+				 * do nothing here and continue below.
+				 */
+				break;
+			default:
+				ret = -EREMOTEIO;
+				goto out_restore_sg;
+			}
+		}
+
 		/*
 		 * Due to the alignment of our single IOVA allocation, we can
 		 * depend on these assumptions about the segment boundary mask:
@@ -1045,6 +1087,9 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		prev = s;
 	}
 
+	if (!iova_len)
+		return __finalise_sg(dev, sg, nents, 0);
+
 	iova = iommu_dma_alloc_iova(domain, iova_len, dma_get_mask(dev), dev);
 	if (!iova) {
 		ret = -ENOMEM;
@@ -1071,7 +1116,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
-	dma_addr_t start, end;
+	dma_addr_t end, start = DMA_MAPPING_ERROR;
 	struct scatterlist *tmp;
 	int i;
 
@@ -1087,14 +1132,22 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 	 * The scatterlist segments are mapped into a single
 	 * contiguous IOVA allocation, so this is incredibly easy.
 	 */
-	start = sg_dma_address(sg);
-	for_each_sg(sg_next(sg), tmp, nents - 1, i) {
+	for_each_sg(sg, tmp, nents, i) {
+		if (sg_is_dma_pci_p2pdma(tmp)) {
+			sg_dma_unmark_pci_p2pdma(tmp);
+			continue;
+		}
 		if (sg_dma_len(tmp) == 0)
 			break;
-		sg = tmp;
+
+		if (start == DMA_MAPPING_ERROR)
+			start = sg_dma_address(tmp);
+
+		end = sg_dma_address(tmp) + sg_dma_len(tmp);
 	}
-	end = sg_dma_address(sg) + sg_dma_len(sg);
-	__iommu_dma_unmap(dev, start, end - start);
+
+	if (start != DMA_MAPPING_ERROR)
+		__iommu_dma_unmap(dev, start, end - start);
 }
 
 static dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
@@ -1287,6 +1340,7 @@ static unsigned long iommu_dma_get_merge_boundary(struct device *dev)
 }
 
 static const struct dma_map_ops iommu_dma_ops = {
+	.flags			= DMA_F_PCI_P2PDMA_SUPPORTED,
 	.alloc			= iommu_dma_alloc,
 	.free			= iommu_dma_free,
 	.alloc_pages		= dma_common_alloc_pages,
-- 
2.20.1

