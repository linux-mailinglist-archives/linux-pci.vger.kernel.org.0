Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47A13381CA
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 00:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhCKXs7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Mar 2021 18:48:59 -0500
Received: from ale.deltatee.com ([204.191.154.188]:37902 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbhCKXsl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Mar 2021 18:48:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=SCChKxOLna0Q8gAs6qhk6ikz9L246Zfzrk9nkrpKYb4=; b=bU1GOcegswBCC8SOec1nyEkx0A
        VZQKHaKmcKUhgfpPzKGEvZZIe9kEAjBk6aTtm++lM9s5YEqcvVhRkHXu4Eg6j1kkWzDad+es9fcIN
        QPP80CO4PXoSi9GzW8aQa0VETX9vReZ6PLOr9FSqvphL6ToAedUIMVZeOCDdeM/0sObWdc7OLjSkO
        Ywi39f+d6/GdN6wHTVvUpHYyYqIi1sTw1HqLzgLn5+CqgZlxQB3jZThIH8z5PrWHOb/9iueBJi4r+
        +uYu9XwpOBvwFnqHHB3tcvMM+kWZ8Qd+l9XxGCMttKba6dxUL/BkAoERcTXfDuijs6/MtAg862DnG
        w/IJk/9w==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1lKUmZ-0003ev-Rw; Thu, 11 Mar 2021 16:31:56 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1lKUmW-00024V-Ap; Thu, 11 Mar 2021 16:31:52 -0700
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
Date:   Thu, 11 Mar 2021 16:31:34 -0700
Message-Id: <20210311233142.7900-5-logang@deltatee.com>
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
X-Spam-Status: No, score=-6.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_FREE,MYRULES_NO_TEXT autolearn=no autolearn_force=no
        version=3.4.2
Subject: [RFC PATCH v2 04/11] PCI/P2PDMA: Introduce pci_p2pdma_should_map_bus() and pci_p2pdma_bus_offset()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduce pci_p2pdma_should_map_bus() which is meant to be called by
DMA map functions to determine how to map a given p2pdma page.

pci_p2pdma_bus_offset() is also added to allow callers to get the bus
offset if they need to map the bus address.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c       | 50 ++++++++++++++++++++++++++++++++++++++
 include/linux/pci-p2pdma.h | 11 +++++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 7f6836732bce..66d16b7eb668 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -912,6 +912,56 @@ void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 }
 EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
 
+/**
+ * pci_p2pdma_bus_offset - returns the bus offset for a given page
+ * @page: page to get the offset for
+ *
+ * Must be passed a PCI p2pdma page.
+ */
+u64 pci_p2pdma_bus_offset(struct page *page)
+{
+	struct pci_p2pdma_pagemap *p2p_pgmap = to_p2p_pgmap(page->pgmap);
+
+	WARN_ON(!is_pci_p2pdma_page(page));
+
+	return p2p_pgmap->bus_offset;
+}
+EXPORT_SYMBOL_GPL(pci_p2pdma_bus_offset);
+
+/**
+ * pci_p2pdma_dma_map_type - determine if a DMA mapping should use the
+ *	bus address, be mapped normally or fail
+ * @dev: device doing the DMA request
+ * @pgmap: dev_pagemap structure for the mapping
+ *
+ * Returns:
+ *    1 - if the page should be mapped with a bus address,
+ *    0 - if the page should be mapped normally through an IOMMU mapping or
+ *        physical address; or
+ *   -1 - if the device should not map the pages and an error should be
+ *        returned
+ */
+int pci_p2pdma_dma_map_type(struct device *dev, struct dev_pagemap *pgmap)
+{
+	struct pci_p2pdma_pagemap *p2p_pgmap = to_p2p_pgmap(pgmap);
+	struct pci_dev *client;
+
+	if (!dev_is_pci(dev))
+		return -1;
+
+	client = to_pci_dev(dev);
+
+	switch (pci_p2pdma_map_type(p2p_pgmap->provider, client)) {
+	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
+		return 0;
+	case PCI_P2PDMA_MAP_BUS_ADDR:
+		return 1;
+	default:
+		return -1;
+	}
+}
+EXPORT_SYMBOL_GPL(pci_p2pdma_dma_map_type);
+
 /**
  * pci_p2pdma_enable_store - parse a configfs/sysfs attribute store
  *		to enable p2pdma
diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
index 8318a97c9c61..3d55ad19f54c 100644
--- a/include/linux/pci-p2pdma.h
+++ b/include/linux/pci-p2pdma.h
@@ -34,6 +34,8 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction dir, unsigned long attrs);
 void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction dir, unsigned long attrs);
+u64 pci_p2pdma_bus_offset(struct page *page);
+int pci_p2pdma_dma_map_type(struct device *dev, struct dev_pagemap *pgmap);
 int pci_p2pdma_enable_store(const char *page, struct pci_dev **p2p_dev,
 			    bool *use_p2pdma);
 ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
@@ -83,6 +85,15 @@ static inline void pci_p2pmem_free_sgl(struct pci_dev *pdev,
 static inline void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
 {
 }
+static inline u64 pci_p2pdma_bus_offset(struct page *page)
+{
+	return -1;
+}
+static inline int pci_p2pdma_dma_map_type(struct device *dev,
+					  struct dev_pagemap *pgmap)
+{
+	return -1;
+}
 static inline int pci_p2pdma_map_sg_attrs(struct device *dev,
 		struct scatterlist *sg, int nents, enum dma_data_direction dir,
 		unsigned long attrs)
-- 
2.20.1

