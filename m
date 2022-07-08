Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FDC56BEE8
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jul 2022 20:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239364AbiGHQv3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jul 2022 12:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239220AbiGHQvR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2022 12:51:17 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F24735B5;
        Fri,  8 Jul 2022 09:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=rTRb+/So/4EWEZ45msTESV3Xx/IfhAVRRKsYbmWz88w=; b=boDw/T3OLLCbj221FqjfwANe11
        vAAJKxjURenUnC6LcrRQSb00rB7JUyYQbZZU4F6NG1eUTL/3c9WbUHkPIi1SwiDACiT1DiyashnUX
        tFqQM9aSfLkyMcPz0TY0PVj5P0+SABZ4KVUDbofgojU3sZNVV3D5eAhoyLwDEgZS9dNbjRk2f/LTB
        yZPC3h4+QaVQyAThd2QaTnXxWjTNFBFYTeqvb7BWSWIHCSbbKf7smx6xbURna/koL0Bgp9z9jc+BW
        xAwOl55pC1o6Ff9saZIoI/sRItIuXXcNkdabWLWkQCXBgb3N7spZ+GelJnExEgPkJfQpgen/cNs6l
        lZG+hURw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o9rCB-009xkF-SA; Fri, 08 Jul 2022 10:51:14 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o9rC9-0001Jl-1m; Fri, 08 Jul 2022 10:51:09 -0600
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
Date:   Fri,  8 Jul 2022 10:50:52 -0600
Message-Id: <20220708165104.5005-2-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220708165104.5005-1-logang@deltatee.com>
References: <20220708165104.5005-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Subject: [PATCH v8 01/13] lib/scatterlist: add flag for indicating P2PDMA segments in an SGL
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduce a dma_flags field in struct scatterlist. These flags will be
used by dma_[un]map_sg_p2pdma() to determine when a given SGL segments
dma_address points to a PCI bus address. dma_unmap_sg_p2pdma() will need
to perform different cleanup when a segment is marked as a bus address.

The dma_flags field will fit in the existing padding on 64BIT systems
(assuming CONFIG_NEED_SG_DMA_LENGTH is also set).

The new bit will only be used when CONFIG_PCI_P2PDMA is set; this means
PCI P2PDMA will require CONFIG_64BIT. This should be acceptable as the
majority of P2PDMA use cases are restricted to newer root complexes and
roughly require the extra address space for memory BARs used in the
transactions.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/Kconfig         |  5 +++
 include/linux/scatterlist.h | 69 +++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 133c73207782..5cc7cba1941f 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -164,6 +164,11 @@ config PCI_PASID
 config PCI_P2PDMA
 	bool "PCI peer-to-peer transfer support"
 	depends on ZONE_DEVICE
+	#
+	# The need for the scatterlist DMA bus address flag means PCI P2PDMA
+	# requires 64bit
+	#
+	depends on 64BIT
 	select GENERIC_ALLOCATOR
 	help
 	  Enableѕ drivers to do PCI peer-to-peer transactions to and from
diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 7ff9d6386c12..375a5e90d86a 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -16,6 +16,9 @@ struct scatterlist {
 #ifdef CONFIG_NEED_SG_DMA_LENGTH
 	unsigned int	dma_length;
 #endif
+#ifdef CONFIG_PCI_P2PDMA
+	unsigned int    dma_flags;
+#endif
 };
 
 /*
@@ -245,6 +248,72 @@ static inline void sg_unmark_end(struct scatterlist *sg)
 	sg->page_link &= ~SG_END;
 }
 
+/*
+ * CONFGI_PCI_P2PDMA depends on CONFIG_64BIT which means there is 4 bytes
+ * in struct scatterlist (assuming also CONFIG_NEED_SG_DMA_LENGTH is set).
+ * Use this padding for DMA flags bits to indicate when a specific
+ * dma address is a bus address.
+ */
+#ifdef CONFIG_PCI_P2PDMA
+
+#define SG_DMA_BUS_ADDRESS (1 << 0)
+
+/**
+ * sg_dma_is_bus address - Return whether a given segment was marked
+ *			   as a bus address
+ * @sg:		 SG entry
+ *
+ * Description:
+ *   Returns true if sg_dma_mark_bus_address() has been called on
+ *   this segment.
+ **/
+static inline bool sg_is_dma_bus_address(struct scatterlist *sg)
+{
+	return sg->dma_flags & SG_DMA_BUS_ADDRESS;
+}
+
+/**
+ * sg_dma_mark_bus address - Mark the scatterlist entry as a bus address
+ * @sg:		 SG entry
+ *
+ * Description:
+ *   Marks the passed in sg entry to indicate that the dma_address is
+ *   a bus address and doesn't need to be unmapped. This should only be
+ *   used by dma_map_sg() implementations to mark bus addresses
+ *   so they can be properly cleaned up in dma_unmap_sg().
+ **/
+static inline void sg_dma_mark_bus_address(struct scatterlist *sg)
+{
+	sg->dma_flags |= SG_DMA_BUS_ADDRESS;
+}
+
+/**
+ * sg_unmark_bus_address - Unmark the scatterlist entry as a bus address
+ * @sg:		 SG entry
+ *
+ * Description:
+ *   Clears the bus address mark.
+ **/
+static inline void sg_dma_unmark_bus_address(struct scatterlist *sg)
+{
+	sg->dma_flags &= ~SG_DMA_BUS_ADDRESS;
+}
+
+#else
+
+static inline bool sg_is_dma_bus_address(struct scatterlist *sg)
+{
+	return false;
+}
+static inline void sg_dma_mark_bus_address(struct scatterlist *sg)
+{
+}
+static inline void sg_dma_unmark_bus_address(struct scatterlist *sg)
+{
+}
+
+#endif
+
 /**
  * sg_phys - Return physical address of an sg entry
  * @sg:	     SG entry
-- 
2.30.2

