Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D2238002D
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 00:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbhEMWdi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 May 2021 18:33:38 -0400
Received: from ale.deltatee.com ([204.191.154.188]:59086 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbhEMWdb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 May 2021 18:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=+6LOZREMQdKcKU9+XV49PWq6lyu+rsgxO5mlOPuR0D0=; b=gopNy0pdi7kPMUBu2VOUSrNjnr
        nDk/YrjZZaemYWUi87naDC/XBiayhz91eTft5y7LVS4LvVe9pisHmjLGpi7M8+AZFgWIyKgREdkwi
        sZQ2TgGIfQJHj62k06it7hWXTFkkLLIsRrguBUo066VTlT47L8xrg8PgwlTQ3gceFDa/mOKc5qvn6
        hvbNNdNi/06xG0iWomhRB2KDNnMFfgU/7jANjA4coPGrDzbN06hio/bAhnbInbuQ2h6YAmyKD5wkC
        E3WVjODcBj55dfJ3X6vMJWKxNwShCvY6ZWrPqq2+x2e5bY2LVDh7u7ieA2RLWabpOKcWRcEqkNnMA
        qjt+4YZw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1lhJsS-0000nC-4u; Thu, 13 May 2021 16:32:20 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1lhJsI-0001TE-3i; Thu, 13 May 2021 16:32:10 -0600
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
Date:   Thu, 13 May 2021 16:31:57 -0600
Message-Id: <20210513223203.5542-17-logang@deltatee.com>
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
X-Spam-Status: No, score=-6.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_NO_TEXT autolearn=no autolearn_force=no version=3.4.2
Subject: [PATCH v2 16/22] dma-mapping: Add flags to dma_map_ops to indicate PCI P2PDMA support
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a flags member to the dma_map_ops structure with one flag to
indicate support for PCI P2PDMA.

Also, add a helper to check if a device supports PCI P2PDMA.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 include/linux/dma-map-ops.h | 10 ++++++++++
 include/linux/dma-mapping.h |  5 +++++
 kernel/dma/mapping.c        | 18 ++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index eaa969be8284..b7b51b89b054 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -11,7 +11,17 @@
 
 struct cma;
 
+/*
+ * Values for struct dma_map_ops.flags:
+ *
+ * DMA_F_PCI_P2PDMA_SUPPORTED: Indicates the dma_map_ops implementation can
+ * handle PCI P2PDMA pages in the map_sg/unmap_sg operation.
+ */
+#define DMA_F_PCI_P2PDMA_SUPPORTED     (1 << 0)
+
 struct dma_map_ops {
+	unsigned int flags;
+
 	void *(*alloc)(struct device *dev, size_t size,
 			dma_addr_t *dma_handle, gfp_t gfp,
 			unsigned long attrs);
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 2b0ecf0aa4df..1149540e969f 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -138,6 +138,7 @@ int dma_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 		unsigned long attrs);
 bool dma_can_mmap(struct device *dev);
 int dma_supported(struct device *dev, u64 mask);
+bool dma_pci_p2pdma_supported(struct device *dev);
 int dma_set_mask(struct device *dev, u64 mask);
 int dma_set_coherent_mask(struct device *dev, u64 mask);
 u64 dma_get_required_mask(struct device *dev);
@@ -242,6 +243,10 @@ static inline int dma_supported(struct device *dev, u64 mask)
 {
 	return 0;
 }
+static inline bool dma_pci_p2pdma_supported(struct device *dev)
+{
+	return false;
+}
 static inline int dma_set_mask(struct device *dev, u64 mask)
 {
 	return -EIO;
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 700a2bb7cc9e..2940977b1030 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -658,6 +658,24 @@ int dma_supported(struct device *dev, u64 mask)
 }
 EXPORT_SYMBOL(dma_supported);
 
+bool dma_pci_p2pdma_supported(struct device *dev)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	/* if ops is not set, dma direct will be used which supports P2PDMA */
+	if (!ops)
+		return true;
+
+	/*
+	 * Note: dma_ops_bypass is not checked here because P2PDMA should
+	 * not be used with dma mapping ops that do not have support even
+	 * if the specific device is bypassing them.
+	 */
+
+	return ops->flags & DMA_F_PCI_P2PDMA_SUPPORTED;
+}
+EXPORT_SYMBOL_GPL(dma_pci_p2pdma_supported);
+
 #ifdef CONFIG_ARCH_HAS_DMA_SET_MASK
 void arch_dma_set_mask(struct device *dev, u64 mask);
 #else
-- 
2.20.1

