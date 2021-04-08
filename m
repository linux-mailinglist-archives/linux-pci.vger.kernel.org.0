Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B65358A82
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 19:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbhDHRBt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 13:01:49 -0400
Received: from ale.deltatee.com ([204.191.154.188]:36038 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbhDHRBr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Apr 2021 13:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=bUsL3A+dCEfQr6IIxez1VQdWw73GOeskoig0YKnj72Q=; b=Bu3hr0GZFBUK4DwLverIv9EfSg
        co5FqA2AtRTLZUR0vTT+JeHem+nhlTcgOcx9UcZdfQypYLZ0ea+aBxsjyomKj9uhGO+G1csDiBZhd
        irYDp+sfOdy7GJo2ZRIFILIgcucZs+QqqQWHexGdLXWiLNxRuwRDaZREoYVTA/GFRTdUmFPzzwkGd
        Dy8w1QBR4EB0oVhqFAUCm0/Mh+3zMa6oNFPUshpt0mfGi1RGshHjLBm0TINsDCnfc4kApERakaf7V
        gzDHFgYMBJRwSN8dDygCmrXgoT0WtEy1HRMNCmP6t4OxYgeV+o/SuMXVQNzk+DLTfCK44NvkvUyYj
        dPSQGT2w==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1lUY2A-0002Ll-7S; Thu, 08 Apr 2021 11:01:35 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1lUY27-0002JU-79; Thu, 08 Apr 2021 11:01:31 -0600
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
Date:   Thu,  8 Apr 2021 11:01:23 -0600
Message-Id: <20210408170123.8788-17-logang@deltatee.com>
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
Subject: [PATCH 16/16] PCI/P2PDMA: Remove pci_p2pdma_[un]map_sg()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This interface is superseded by the new dma_map_sg_p2pdma() interface
which supports heterogeneous scatterlists. There are no longer
any users, so remove it.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c       | 67 --------------------------------------
 include/linux/pci-p2pdma.h | 27 ---------------
 2 files changed, 94 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 44ad7664e875..2f2adcccfa11 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -856,73 +856,6 @@ enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
 					     GFP_ATOMIC);
 }
 
-static int __pci_p2pdma_map_sg(struct pci_p2pdma_pagemap *p2p_pgmap,
-		struct device *dev, struct scatterlist *sg, int nents)
-{
-	struct scatterlist *s;
-	int i;
-
-	for_each_sg(sg, s, nents, i) {
-		s->dma_address = sg_phys(s) - p2p_pgmap->bus_offset;
-		sg_dma_len(s) = s->length;
-	}
-
-	return nents;
-}
-
-/**
- * pci_p2pdma_map_sg_attrs - map a PCI peer-to-peer scatterlist for DMA
- * @dev: device doing the DMA request
- * @sg: scatter list to map
- * @nents: elements in the scatterlist
- * @dir: DMA direction
- * @attrs: DMA attributes passed to dma_map_sg() (if called)
- *
- * Scatterlists mapped with this function should be unmapped using
- * pci_p2pdma_unmap_sg_attrs().
- *
- * Returns the number of SG entries mapped or 0 on error.
- */
-int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, unsigned long attrs)
-{
-	struct pci_p2pdma_pagemap *p2p_pgmap =
-		to_p2p_pgmap(sg_page(sg)->pgmap);
-
-	switch (pci_p2pdma_map_type(sg_page(sg)->pgmap, dev,
-				    __DMA_ATTR_PCI_P2PDMA)) {
-	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
-		return dma_map_sg_attrs(dev, sg, nents, dir, attrs);
-	case PCI_P2PDMA_MAP_BUS_ADDR:
-		return __pci_p2pdma_map_sg(p2p_pgmap, dev, sg, nents);
-	default:
-		return 0;
-	}
-}
-EXPORT_SYMBOL_GPL(pci_p2pdma_map_sg_attrs);
-
-/**
- * pci_p2pdma_unmap_sg_attrs - unmap a PCI peer-to-peer scatterlist that was
- *	mapped with pci_p2pdma_map_sg()
- * @dev: device doing the DMA request
- * @sg: scatter list to map
- * @nents: number of elements returned by pci_p2pdma_map_sg()
- * @dir: DMA direction
- * @attrs: DMA attributes passed to dma_unmap_sg() (if called)
- */
-void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, unsigned long attrs)
-{
-	enum pci_p2pdma_map_type map_type;
-
-	map_type = pci_p2pdma_map_type(sg_page(sg)->pgmap, dev,
-				       __DMA_ATTR_PCI_P2PDMA);
-
-	if (map_type == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE)
-		dma_unmap_sg_attrs(dev, sg, nents, dir, attrs);
-}
-EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
-
 /**
  * pci_p2pdma_map_segment - map an sg segment determining the mapping type
  * @state: State structure that should be declared on the stack outside of
diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
index 49e7679403cf..2ec9c75fa097 100644
--- a/include/linux/pci-p2pdma.h
+++ b/include/linux/pci-p2pdma.h
@@ -45,10 +45,6 @@ void pci_p2pmem_free_sgl(struct pci_dev *pdev, struct scatterlist *sgl);
 void pci_p2pmem_publish(struct pci_dev *pdev, bool publish);
 enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
 		struct device *dev, unsigned long dma_attrs);
-int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, unsigned long attrs);
-void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, unsigned long attrs);
 int pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state,
 		struct device *dev, struct scatterlist *sg,
 		unsigned long dma_attrs);
@@ -109,17 +105,6 @@ static inline enum pci_p2pdma_map_type pci_p2pdma_map_type(
 {
 	return PCI_P2PDMA_MAP_NOT_SUPPORTED;
 }
-static inline int pci_p2pdma_map_sg_attrs(struct device *dev,
-		struct scatterlist *sg, int nents, enum dma_data_direction dir,
-		unsigned long attrs)
-{
-	return 0;
-}
-static inline void pci_p2pdma_unmap_sg_attrs(struct device *dev,
-		struct scatterlist *sg, int nents, enum dma_data_direction dir,
-		unsigned long attrs)
-{
-}
 static inline int pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state,
 		struct device *dev, struct scatterlist *sg,
 		unsigned long dma_attrs)
@@ -155,16 +140,4 @@ static inline struct pci_dev *pci_p2pmem_find(struct device *client)
 	return pci_p2pmem_find_many(&client, 1);
 }
 
-static inline int pci_p2pdma_map_sg(struct device *dev, struct scatterlist *sg,
-				    int nents, enum dma_data_direction dir)
-{
-	return pci_p2pdma_map_sg_attrs(dev, sg, nents, dir, 0);
-}
-
-static inline void pci_p2pdma_unmap_sg(struct device *dev,
-		struct scatterlist *sg, int nents, enum dma_data_direction dir)
-{
-	pci_p2pdma_unmap_sg_attrs(dev, sg, nents, dir, 0);
-}
-
 #endif /* _LINUX_PCI_P2P_H */
-- 
2.20.1

