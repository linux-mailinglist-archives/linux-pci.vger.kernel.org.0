Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E5F358A99
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 19:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbhDHRB4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 13:01:56 -0400
Received: from ale.deltatee.com ([204.191.154.188]:36160 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbhDHRBx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Apr 2021 13:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=flK7AVROsAWPTBpHhkc1ioOIaxg1QDUQbObkXE3xVRk=; b=iHt+tHjpDCqThUdOdXRF9HfSfw
        KNXlTyqVkvY8G7kKWMV9DPMmPD/5B3Sw6SR3woTsOwnCmhXrGeo9I6Po3h2QXY7qCYMB4wnnYBxzu
        m2BDsINQbkc1hRwfeeYKXrD7GUMW7IcGe6tBW0QEVLkA+FNLz2wdG8585h+SPTrMvjL/5fy3tDnXz
        0G8kBwrsSkDDxVGJ0mDBkCzQRWDSKp2jRqXPUd9o0wXmbrKaWnqFA2ZixJXebw//4RWMfqZJ6v4EO
        +Lu2+psTmv0g/Irh2zayIgHNMU5ljvAP97EqEX3L+3DwX3aDzdv+6WeM1oenKyKx24Ev5seQhunPn
        sIQICdGg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1lUY2G-0002Ll-Lh; Thu, 08 Apr 2021 11:01:41 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1lUY26-0002J6-0C; Thu, 08 Apr 2021 11:01:30 -0600
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
Date:   Thu,  8 Apr 2021 11:01:15 -0600
Message-Id: <20210408170123.8788-9-logang@deltatee.com>
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
X-Spam-Status: No, score=-6.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_NO_TEXT autolearn=no autolearn_force=no version=3.4.2
Subject: [PATCH 08/16] PCI/P2PDMA: Introduce helpers for dma_map_sg implementations
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add pci_p2pdma_map_segment() as a helper for simple dma_map_sg()
implementations. It takes an scatterlist segment that must point to a
pci_p2pdma struct page and will map it if the mapping requires a bus
address.

The return value indicates whether the mapping required a bus address
or whether the caller still needs to map the segment normally. If the
segment should not be mapped, -EREMOTEIO is returned.

This helper uses a state structure to track the changes to the
pgmap across calls and avoid needing to lookup into the xarray for
every page.

Also add pci_p2pdma_map_bus_segment() which is useful for IOMMU
dma_map_sg() implementations where the sg segment containing the page
differs from the sg segment containing the DMA address.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c       | 65 ++++++++++++++++++++++++++++++++++++++
 include/linux/pci-p2pdma.h | 21 ++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 38c93f57a941..44ad7664e875 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -923,6 +923,71 @@ void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 }
 EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
 
+/**
+ * pci_p2pdma_map_segment - map an sg segment determining the mapping type
+ * @state: State structure that should be declared on the stack outside of
+ *	the for_each_sg() loop and initialized to zero.
+ * @dev: DMA device that's doing the mapping operation
+ * @sg: scatterlist segment to map
+ * @attrs: dma mapping attributes
+ *
+ * This is a helper to be used by non-iommu dma_map_sg() implementations where
+ * the sg segment is the same for the page_link and the dma_address.
+ *
+ * Attempt to map a single segment in an SGL with the PCI bus address.
+ * The segment must point to a PCI P2PDMA page and thus must be
+ * wrapped in a is_pci_p2pdma_page(sg_page(sg)) check.
+ *
+ * Returns 1 if the segment was mapped, 0 if the segment should be mapped
+ * directly (or through the IOMMU) and -EREMOTEIO if the segment should not
+ * be mapped at all.
+ */
+int pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state,
+			   struct device *dev, struct scatterlist *sg,
+			   unsigned long dma_attrs)
+{
+	if (state->pgmap != sg_page(sg)->pgmap) {
+		state->pgmap = sg_page(sg)->pgmap;
+		state->map = pci_p2pdma_map_type(state->pgmap, dev, dma_attrs);
+		state->bus_off = to_p2p_pgmap(state->pgmap)->bus_offset;
+	}
+
+	switch (state->map) {
+	case PCI_P2PDMA_MAP_BUS_ADDR:
+		sg->dma_address = sg_phys(sg) + state->bus_off;
+		sg_dma_len(sg) = sg->length;
+		sg_mark_pci_p2pdma(sg);
+		return 1;
+	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
+		return 0;
+	default:
+		return -EREMOTEIO;
+	}
+}
+
+/**
+ * pci_p2pdma_map_bus_segment - map an sg segment pre determined to
+ *	be mapped with PCI_P2PDMA_MAP_BUS_ADDR
+ * @pg_sg: scatterlist segment with the page to map
+ * @dma_sg: scatterlist segment to assign a dma address to
+ *
+ * This is a helper for iommu dma_map_sg() implementations when the
+ * segment for the dma address differs from the segment containing the
+ * source page.
+ *
+ * pci_p2pdma_map_type() must have already been called on the pg_sg and
+ * returned PCI_P2PDMA_MAP_BUS_ADDR.
+ */
+void pci_p2pdma_map_bus_segment(struct scatterlist *pg_sg,
+				struct scatterlist *dma_sg)
+{
+	struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(sg_page(pg_sg)->pgmap);
+
+	dma_sg->dma_address = sg_phys(pg_sg) + pgmap->bus_offset;
+	sg_dma_len(dma_sg) = pg_sg->length;
+	sg_mark_pci_p2pdma(dma_sg);
+}
+
 /**
  * pci_p2pdma_enable_store - parse a configfs/sysfs attribute store
  *		to enable p2pdma
diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
index a06072ac3a52..49e7679403cf 100644
--- a/include/linux/pci-p2pdma.h
+++ b/include/linux/pci-p2pdma.h
@@ -13,6 +13,12 @@
 
 #include <linux/pci.h>
 
+struct pci_p2pdma_map_state {
+	struct dev_pagemap *pgmap;
+	int map;
+	u64 bus_off;
+};
+
 struct block_device;
 struct scatterlist;
 
@@ -43,6 +49,11 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction dir, unsigned long attrs);
 void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction dir, unsigned long attrs);
+int pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state,
+		struct device *dev, struct scatterlist *sg,
+		unsigned long dma_attrs);
+void pci_p2pdma_map_bus_segment(struct scatterlist *pg_sg,
+				struct scatterlist *dma_sg);
 int pci_p2pdma_enable_store(const char *page, struct pci_dev **p2p_dev,
 			    bool *use_p2pdma);
 ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
@@ -109,6 +120,16 @@ static inline void pci_p2pdma_unmap_sg_attrs(struct device *dev,
 		unsigned long attrs)
 {
 }
+static inline int pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state,
+		struct device *dev, struct scatterlist *sg,
+		unsigned long dma_attrs)
+{
+	return 0;
+}
+static inline void pci_p2pdma_map_bus_segment(struct scatterlist *pg_sg,
+					      struct scatterlist *dma_sg)
+{
+}
 static inline int pci_p2pdma_enable_store(const char *page,
 		struct pci_dev **p2p_dev, bool *use_p2pdma)
 {
-- 
2.20.1

