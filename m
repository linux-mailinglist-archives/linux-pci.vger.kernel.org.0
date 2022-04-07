Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266F14F8623
	for <lists+linux-pci@lfdr.de>; Thu,  7 Apr 2022 19:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346264AbiDGR35 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Apr 2022 13:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346380AbiDGR1T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2022 13:27:19 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BD4E33BD;
        Thu,  7 Apr 2022 10:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=Kj/SB7arPoOJg6cQxRfaeWMDbv4G2wYTNapPOj3Wwdw=; b=NT9H+hlZ+KIP/WMXMQWNKkhN/L
        f6WTtGH3C69fwh98cKtrQOJSxMKFgb60ulndEzepoDRlaoXp2MAdZ60WhPpvGb2dLEhbM3qmNH7SI
        HjdiGVTAqIPFZxkt2rRCB51WoI27d3M3cky6msJTw7hAzx7CPaaceN+3PPA1OLUTux27R4BmZsBoJ
        xVmBFtArkFf2/a4Qn5jDJ3ifCiD7q8htyu0jAuQ6hxkAs8jPqGkcQtIwpTltjlkbiOErsHe2wW1+O
        dTE/wDwY9PpiWjzFr+beyW958mdpG8ZRAzU97p9rIhokLPvL7UXjQX82d+DPVjHNM8JAUdjDvDOy9
        NIjGFazg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ncUMM-002BBh-2c; Thu, 07 Apr 2022 09:47:46 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ncUMC-00021W-5f; Thu, 07 Apr 2022 09:47:36 -0600
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
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu,  7 Apr 2022 09:47:02 -0600
Message-Id: <20220407154717.7695-7-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220407154717.7695-1-logang@deltatee.com>
References: <20220407154717.7695-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, jhubbard@nvidia.com, rcampbell@nvidia.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Subject: [PATCH v6 06/21] dma-direct: support PCI P2PDMA pages in dma-direct map_sg
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCI P2PDMA support for dma_direct_map_sg() so that it can map
PCI P2PDMA pages directly without a hack in the callers. This allows
for heterogeneous SGLs that contain both P2PDMA and regular pages.

A P2PDMA page may have three possible outcomes when being mapped:
  1) If the data path between the two devices doesn't go through the
     root port, then it should be mapped with a PCI bus address
  2) If the data path goes through the host bridge, it should be mapped
     normally, as though it were a CPU physical address
  3) It is not possible for the two devices to communicate and thus
     the mapping operation should fail (and it will return -EREMOTEIO).

SGL segments that contain PCI bus addresses are marked with
sg_dma_mark_pci_p2pdma() and are ignored when unmapped.

P2PDMA mappings are also failed if swiotlb needs to be used on the
mapping.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 kernel/dma/direct.c | 43 +++++++++++++++++++++++++++++++++++++------
 kernel/dma/direct.h |  8 +++++++-
 2 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 9743c6ccce1a..33b838a3ccb2 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -461,29 +461,60 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
 		arch_sync_dma_for_cpu_all();
 }
 
+/*
+ * Unmaps segments, except for ones marked as pci_p2pdma which do not
+ * require any further action as they contain a bus address.
+ */
 void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
 		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
 
-	for_each_sg(sgl, sg, nents, i)
-		dma_direct_unmap_page(dev, sg->dma_address, sg_dma_len(sg), dir,
-			     attrs);
+	for_each_sg(sgl,  sg, nents, i) {
+		if (sg_is_dma_bus_address(sg))
+			sg_dma_unmark_bus_address(sg);
+		else
+			dma_direct_unmap_page(dev, sg->dma_address,
+					      sg_dma_len(sg), dir, attrs);
+	}
 }
 #endif
 
 int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 		enum dma_data_direction dir, unsigned long attrs)
 {
-	int i;
+	struct pci_p2pdma_map_state p2pdma_state = {};
+	enum pci_p2pdma_map_type map;
 	struct scatterlist *sg;
+	int i, ret;
 
 	for_each_sg(sgl, sg, nents, i) {
+		if (is_pci_p2pdma_page(sg_page(sg))) {
+			map = pci_p2pdma_map_segment(&p2pdma_state, dev, sg);
+			switch (map) {
+			case PCI_P2PDMA_MAP_BUS_ADDR:
+				continue;
+			case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
+				/*
+				 * Any P2P mapping that traverses the PCI
+				 * host bridge must be mapped with CPU physical
+				 * address and not PCI bus addresses. This is
+				 * done with dma_direct_map_page() below.
+				 */
+				break;
+			default:
+				ret = -EREMOTEIO;
+				goto out_unmap;
+			}
+		}
+
 		sg->dma_address = dma_direct_map_page(dev, sg_page(sg),
 				sg->offset, sg->length, dir, attrs);
-		if (sg->dma_address == DMA_MAPPING_ERROR)
+		if (sg->dma_address == DMA_MAPPING_ERROR) {
+			ret = -EIO;
 			goto out_unmap;
+		}
 		sg_dma_len(sg) = sg->length;
 	}
 
@@ -491,7 +522,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 
 out_unmap:
 	dma_direct_unmap_sg(dev, sgl, i, dir, attrs | DMA_ATTR_SKIP_CPU_SYNC);
-	return -EIO;
+	return ret;
 }
 
 dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index 4632b0f4f72e..81b213409ce8 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -8,6 +8,7 @@
 #define _KERNEL_DMA_DIRECT_H
 
 #include <linux/dma-direct.h>
+#include <linux/memremap.h>
 
 int dma_direct_get_sgtable(struct device *dev, struct sg_table *sgt,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
@@ -87,10 +88,15 @@ static inline dma_addr_t dma_direct_map_page(struct device *dev,
 	phys_addr_t phys = page_to_phys(page) + offset;
 	dma_addr_t dma_addr = phys_to_dma(dev, phys);
 
-	if (is_swiotlb_force_bounce(dev))
+	if (is_swiotlb_force_bounce(dev)) {
+		if (is_pci_p2pdma_page(page))
+			return DMA_MAPPING_ERROR;
 		return swiotlb_map(dev, phys, size, dir, attrs);
+	}
 
 	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
+		if (is_pci_p2pdma_page(page))
+			return DMA_MAPPING_ERROR;
 		if (swiotlb_force != SWIOTLB_NO_FORCE)
 			return swiotlb_map(dev, phys, size, dir, attrs);
 
-- 
2.30.2

