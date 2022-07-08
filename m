Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C84156BFC3
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jul 2022 20:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239331AbiGHQv0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jul 2022 12:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239263AbiGHQvS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2022 12:51:18 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22292BB33;
        Fri,  8 Jul 2022 09:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=To6/hnd+oGMPRmHvfNjB9EEL814Z82Hk+27pmy4Q3T8=; b=rpphw6k3LrhPOVpwzssTS34XOC
        tjRNARaT9n7hv+A5PpNPAfhE/k7+5IclgTwxASD+4Az7cVpxyZnKrZdSGIwUyuNvHQ/B2hwklWOIE
        LFKyRi6oZwsyJHnVBEdLvwQtVJ47GOMgbsoRJAmm/H21xvp8dl/NXGh2t+TxNNs6p9YmA5ue9Sy31
        6jV6xm0PSTFKO0zEmJ5ushGterP4lV25KK9sPKKmD9kyD/As1pKPRgSFdTIU/XNdZZTu80wHY5MLx
        X/LLVNtU0vY+tyb/6SRyfcjpV/oabjj6VU2tqL9aOtWh2cSRLAX5/SCfiJ8vX25AcJyrqw+zB2i0I
        14BxaXug==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o9rCE-009xkE-Rd; Fri, 08 Jul 2022 10:51:15 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o9rCA-0001K8-3c; Fri, 08 Jul 2022 10:51:10 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        iommu@lists.linux.dev
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
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
Date:   Fri,  8 Jul 2022 10:50:59 -0600
Message-Id: <20220708165104.5005-9-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220708165104.5005-1-logang@deltatee.com>
References: <20220708165104.5005-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, iommu@lists.linux.dev, sbates@raithlin.com, hch@lst.de, jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, jhubbard@nvidia.com, rcampbell@nvidia.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v8 08/13] iommu/dma: support PCI P2PDMA pages in dma-iommu map_sg
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Call pci_p2pdma_map_segment() when a PCI P2PDMA page is seen so the bus
address is set in the dma address and the segment is marked with
sg_dma_mark_bus_address(). iommu_map_sg() will then skip these segments.
Then, in __finalise_sg(), copy the dma address from the input segment
to the output segment. __invalidate_sg() must also learn to skip these
segments.

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
 drivers/iommu/dma-iommu.c | 99 +++++++++++++++++++++++++++++++++------
 1 file changed, 85 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f90251572a5d..c079836ed2fc 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -21,6 +21,7 @@
 #include <linux/iova.h>
 #include <linux/irq.h>
 #include <linux/list_sort.h>
+#include <linux/memremap.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
@@ -1053,15 +1054,30 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
 
 	for_each_sg(sg, s, nents, i) {
 		/* Restore this segment's original unaligned fields first */
+		dma_addr_t s_dma_addr = sg_dma_address(s);
 		unsigned int s_iova_off = sg_dma_address(s);
 		unsigned int s_length = sg_dma_len(s);
 		unsigned int s_iova_len = s->length;
 
-		s->offset += s_iova_off;
-		s->length = s_length;
 		sg_dma_address(s) = DMA_MAPPING_ERROR;
 		sg_dma_len(s) = 0;
 
+		if (sg_is_dma_bus_address(s)) {
+			if (i > 0)
+				cur = sg_next(cur);
+
+			sg_dma_unmark_bus_address(s);
+			sg_dma_address(cur) = s_dma_addr;
+			sg_dma_len(cur) = s_length;
+			sg_dma_mark_bus_address(cur);
+			count++;
+			cur_len = 0;
+			continue;
+		}
+
+		s->offset += s_iova_off;
+		s->length = s_length;
+
 		/*
 		 * Now fill in the real DMA data. If...
 		 * - there is a valid output segment to append to
@@ -1102,10 +1118,14 @@ static void __invalidate_sg(struct scatterlist *sg, int nents)
 	int i;
 
 	for_each_sg(sg, s, nents, i) {
-		if (sg_dma_address(s) != DMA_MAPPING_ERROR)
-			s->offset += sg_dma_address(s);
-		if (sg_dma_len(s))
-			s->length = sg_dma_len(s);
+		if (sg_is_dma_bus_address(s)) {
+			sg_dma_unmark_bus_address(s);
+		} else {
+			if (sg_dma_address(s) != DMA_MAPPING_ERROR)
+				s->offset += sg_dma_address(s);
+			if (sg_dma_len(s))
+				s->length = sg_dma_len(s);
+		}
 		sg_dma_address(s) = DMA_MAPPING_ERROR;
 		sg_dma_len(s) = 0;
 	}
@@ -1158,6 +1178,8 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	struct iova_domain *iovad = &cookie->iovad;
 	struct scatterlist *s, *prev = NULL;
 	int prot = dma_info_to_prot(dir, dev_is_dma_coherent(dev), attrs);
+	struct pci_p2pdma_map_state p2pdma_state = {};
+	enum pci_p2pdma_map_type map;
 	dma_addr_t iova;
 	size_t iova_len = 0;
 	unsigned long mask = dma_get_seg_boundary(dev);
@@ -1187,6 +1209,30 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		size_t s_length = s->length;
 		size_t pad_len = (mask - iova_len + 1) & mask;
 
+		if (is_pci_p2pdma_page(sg_page(s))) {
+			map = pci_p2pdma_map_segment(&p2pdma_state, dev, s);
+			switch (map) {
+			case PCI_P2PDMA_MAP_BUS_ADDR:
+				/*
+				 * iommu_map_sg() will skip this segment as
+				 * it is marked as a bus address,
+				 * __finalise_sg() will copy the dma address
+				 * into the output segment.
+				 */
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
 		sg_dma_address(s) = s_iova_off;
 		sg_dma_len(s) = s_length;
 		s->offset -= s_iova_off;
@@ -1215,6 +1261,9 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		prev = s;
 	}
 
+	if (!iova_len)
+		return __finalise_sg(dev, sg, nents, 0);
+
 	iova = iommu_dma_alloc_iova(domain, iova_len, dma_get_mask(dev), dev);
 	if (!iova) {
 		ret = -ENOMEM;
@@ -1236,7 +1285,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 out_restore_sg:
 	__invalidate_sg(sg, nents);
 out:
-	if (ret != -ENOMEM)
+	if (ret != -ENOMEM && ret != -EREMOTEIO)
 		return -EINVAL;
 	return ret;
 }
@@ -1244,7 +1293,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
-	dma_addr_t start, end;
+	dma_addr_t end = 0, start;
 	struct scatterlist *tmp;
 	int i;
 
@@ -1258,16 +1307,37 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 
 	/*
 	 * The scatterlist segments are mapped into a single
-	 * contiguous IOVA allocation, so this is incredibly easy.
+	 * contiguous IOVA allocation, the start and end points
+	 * just have to be determined.
 	 */
-	start = sg_dma_address(sg);
-	for_each_sg(sg_next(sg), tmp, nents - 1, i) {
+	for_each_sg(sg, tmp, nents, i) {
+		if (sg_is_dma_bus_address(tmp)) {
+			sg_dma_unmark_bus_address(tmp);
+			continue;
+		}
+
+		if (sg_dma_len(tmp) == 0)
+			break;
+
+		start = sg_dma_address(tmp);
+		break;
+	}
+
+	nents -= i;
+	for_each_sg(tmp, tmp, nents, i) {
+		if (sg_is_dma_bus_address(tmp)) {
+			sg_dma_unmark_bus_address(tmp);
+			continue;
+		}
+
 		if (sg_dma_len(tmp) == 0)
 			break;
-		sg = tmp;
+
+		end = sg_dma_address(tmp) + sg_dma_len(tmp);
 	}
-	end = sg_dma_address(sg) + sg_dma_len(sg);
-	__iommu_dma_unmap(dev, start, end - start);
+
+	if (end)
+		__iommu_dma_unmap(dev, start, end - start);
 }
 
 static dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
@@ -1460,6 +1530,7 @@ static unsigned long iommu_dma_get_merge_boundary(struct device *dev)
 }
 
 static const struct dma_map_ops iommu_dma_ops = {
+	.flags			= DMA_F_PCI_P2PDMA_SUPPORTED,
 	.alloc			= iommu_dma_alloc,
 	.free			= iommu_dma_free,
 	.alloc_pages		= dma_common_alloc_pages,
-- 
2.30.2

