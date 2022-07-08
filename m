Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4E756C03B
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jul 2022 20:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239289AbiGHQvT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jul 2022 12:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239059AbiGHQvQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2022 12:51:16 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444FB6EE81;
        Fri,  8 Jul 2022 09:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=3m0HqdPfpIwE9OX075f9oLJxQjZz5A8+nk0L6lYXPdw=; b=Bc6JUB9eA4q6GnWKA7t2anav0e
        DmbFi/UJHIKGLu2kJc7KTSFdMC/fmIhQG7hr6g8pc5ThIGW9THCmQW/pBla0BtWvBaPHgq64ZCIc7
        ZmKTZ+FlkaD599cdB3avSkWFRB48EmyCSG1zWVAI/D4qCGiLVHwDYyF/Oq+vtMZFMHs/b/GrNA5G6
        04YW0ju77TC3N1hXXBFNlJK/uBqH9/qEvhOxQqubOUNg8wFQZmhIC0hbaKrNFlisNBALgFL4vUWBR
        XEEhcACxZQvJOrr3Y+8xTdJcF1B5XR1UnJqJich9cKGVMGKHsv73wovZVD72Zru5i1jqS+2aexCqC
        Ow3ZhfGQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o9rCB-009xkH-SF; Fri, 08 Jul 2022 10:51:13 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o9rC9-0001Js-Bs; Fri, 08 Jul 2022 10:51:09 -0600
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
        Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri,  8 Jul 2022 10:50:54 -0600
Message-Id: <20220708165104.5005-4-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220708165104.5005-1-logang@deltatee.com>
References: <20220708165104.5005-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, iommu@lists.linux.dev, sbates@raithlin.com, hch@lst.de, jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, jhubbard@nvidia.com, rcampbell@nvidia.com, logang@deltatee.com, bhelgaas@google.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v8 03/13] PCI/P2PDMA: Introduce helpers for dma_map_sg implementations
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add pci_p2pdma_map_segment() as a helper for dma_map_sg()
implementations. It takes an scatterlist segment that must point to a
pci_p2pdma struct page and will map it if the mapping requires a bus
address.

The return value indicates whether the mapping required a bus address
or whether the caller still needs to map the segment normally. If the
segment should not be mapped, -EREMOTEIO is returned.

This helper uses a state structure to track the changes to the
pgmap across calls and avoid needing to lookup into the xarray for
every page.

The prototype for the helper is added to dma-map-ops.h as it is only
useful to dma map implementations and don't need to pollute the public
pci-p2pdma header.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/p2pdma.c        | 44 +++++++++++++++++++++++++-----
 include/linux/dma-map-ops.h | 53 +++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 4e8bc457e29a..5d2538aa0778 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -10,6 +10,7 @@
 
 #define pr_fmt(fmt) "pci-p2pdma: " fmt
 #include <linux/ctype.h>
+#include <linux/dma-map-ops.h>
 #include <linux/pci-p2pdma.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -20,13 +21,6 @@
 #include <linux/seq_buf.h>
 #include <linux/xarray.h>
 
-enum pci_p2pdma_map_type {
-	PCI_P2PDMA_MAP_UNKNOWN = 0,
-	PCI_P2PDMA_MAP_NOT_SUPPORTED,
-	PCI_P2PDMA_MAP_BUS_ADDR,
-	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE,
-};
-
 struct pci_p2pdma {
 	struct gen_pool *pool;
 	bool p2pmem_published;
@@ -944,6 +938,42 @@ void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 }
 EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
 
+/**
+ * pci_p2pdma_map_segment - map an sg segment determining the mapping type
+ * @state: State structure that should be declared outside of the for_each_sg()
+ *	loop and initialized to zero.
+ * @dev: DMA device that's doing the mapping operation
+ * @sg: scatterlist segment to map
+ *
+ * This is a helper to be used by non-IOMMU dma_map_sg() implementations where
+ * the sg segment is the same for the page_link and the dma_address.
+ *
+ * Attempt to map a single segment in an SGL with the PCI bus address.
+ * The segment must point to a PCI P2PDMA page and thus must be
+ * wrapped in a is_pci_p2pdma_page(sg_page(sg)) check.
+ *
+ * Returns the type of mapping used and maps the page if the type is
+ * PCI_P2PDMA_MAP_BUS_ADDR.
+ */
+enum pci_p2pdma_map_type
+pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
+		       struct scatterlist *sg)
+{
+	if (state->pgmap != sg_page(sg)->pgmap) {
+		state->pgmap = sg_page(sg)->pgmap;
+		state->map = pci_p2pdma_map_type(state->pgmap, dev);
+		state->bus_off = to_p2p_pgmap(state->pgmap)->bus_offset;
+	}
+
+	if (state->map == PCI_P2PDMA_MAP_BUS_ADDR) {
+		sg->dma_address = sg_phys(sg) + state->bus_off;
+		sg_dma_len(sg) = sg->length;
+		sg_dma_mark_bus_address(sg);
+	}
+
+	return state->map;
+}
+
 /**
  * pci_p2pdma_enable_store - parse a configfs/sysfs attribute store
  *		to enable p2pdma
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 0d5b06b3a4a6..df27ee3c9afc 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -379,4 +379,57 @@ static inline void debug_dma_dump_mappings(struct device *dev)
 
 extern const struct dma_map_ops dma_dummy_ops;
 
+enum pci_p2pdma_map_type {
+	/*
+	 * PCI_P2PDMA_MAP_UNKNOWN: Used internally for indicating the mapping
+	 * type hasn't been calculated yet. Functions that return this enum
+	 * never return this value.
+	 */
+	PCI_P2PDMA_MAP_UNKNOWN = 0,
+
+	/*
+	 * PCI_P2PDMA_MAP_NOT_SUPPORTED: Indicates the transaction will
+	 * traverse the host bridge and the host bridge is not in the
+	 * allowlist. DMA Mapping routines should return an error when
+	 * this is returned.
+	 */
+	PCI_P2PDMA_MAP_NOT_SUPPORTED,
+
+	/*
+	 * PCI_P2PDMA_BUS_ADDR: Indicates that two devices can talk to
+	 * each other directly through a PCI switch and the transaction will
+	 * not traverse the host bridge. Such a mapping should program
+	 * the DMA engine with PCI bus addresses.
+	 */
+	PCI_P2PDMA_MAP_BUS_ADDR,
+
+	/*
+	 * PCI_P2PDMA_MAP_THRU_HOST_BRIDGE: Indicates two devices can talk
+	 * to each other, but the transaction traverses a host bridge on the
+	 * allowlist. In this case, a normal mapping either with CPU physical
+	 * addresses (in the case of dma-direct) or IOVA addresses (in the
+	 * case of IOMMUs) should be used to program the DMA engine.
+	 */
+	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE,
+};
+
+struct pci_p2pdma_map_state {
+	struct dev_pagemap *pgmap;
+	int map;
+	u64 bus_off;
+};
+
+#ifdef CONFIG_PCI_P2PDMA
+enum pci_p2pdma_map_type
+pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
+		       struct scatterlist *sg);
+#else /* CONFIG_PCI_P2PDMA */
+static inline enum pci_p2pdma_map_type
+pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
+		       struct scatterlist *sg)
+{
+	return PCI_P2PDMA_MAP_NOT_SUPPORTED;
+}
+#endif /* CONFIG_PCI_P2PDMA */
+
 #endif /* _LINUX_DMA_MAP_OPS_H */
-- 
2.30.2

