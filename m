Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10BD54CDFB
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jun 2022 18:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349010AbiFOQM6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 12:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242285AbiFOQMx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 12:12:53 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980FA22513;
        Wed, 15 Jun 2022 09:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=mtQBRhKAuvCwGThlB7Jvwgfm5H5uDyU50loVdVNL23w=; b=KVDw0upQ0XsQg5ld50QmMKqfuM
        zK5MPimorBAJ7iSWd598AK9ReJelJZFlnTySPkRItKhv7bP/HLKFr/t74fjhCUYg2gosfFc/HpmfB
        /uDGsntT1kxL72jImNb/UFODuVrXKC9lsUDvZ4UW5a1rUSzX/wh1e4Cuh51xRK/zxRoNtJ7Qs6Zqh
        IjXnp4C6Sg+k/XB8LDO0bepfPKYmoHBQPGetKwzkk3PCzYugXToX+2mSw7D2NB4FuIQBaIkTSVgJZ
        3Zgh2D3yclSbrwsgN2LqB5pxvwNkF+q+9SbeJz1ou8WOXyUkPkBbBVzH357TzDa2nL3X4nlBJrqGE
        5gcc3BzA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o1VdN-0084iQ-L4; Wed, 15 Jun 2022 10:12:46 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o1VdG-0004Zr-RR; Wed, 15 Jun 2022 10:12:38 -0600
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
        Chaitanya Kulkarni <kch@nvidia.com>
Date:   Wed, 15 Jun 2022 10:12:13 -0600
Message-Id: <20220615161233.17527-2-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220615161233.17527-1-logang@deltatee.com>
References: <20220615161233.17527-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, logang@deltatee.com, jhubbard@nvidia.com, rcampbell@nvidia.com, kch@nvidia.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v7 01/21] lib/scatterlist: add flag for indicating P2PDMA segments in an SGL
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Make use of the third free LSB in scatterlist's page_link on 64bit systems.

The extra bit will be used by dma_[un]map_sg_p2pdma() to determine when a
given SGL segments dma_address points to a PCI bus address.
dma_unmap_sg_p2pdma() will need to perform different cleanup when a
segment is marked as a bus address.

The new bit will only be used when CONFIG_PCI_P2PDMA is set; this means
PCI P2PDMA will require CONFIG_64BIT. This should be acceptable as the
majority of P2PDMA use cases are restricted to newer root complexes and
roughly require the extra address space for memory BARs used in the
transactions.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/pci/Kconfig         |  5 +++++
 include/linux/scatterlist.h | 44 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 48 insertions(+), 1 deletion(-)

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
index 7ff9d6386c12..6561ca8aead8 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -64,12 +64,24 @@ struct sg_append_table {
 #define SG_CHAIN	0x01UL
 #define SG_END		0x02UL
 
+/*
+ * bit 2 is the third free bit in the page_link on 64bit systems which
+ * is used by dma_unmap_sg() to determine if the dma_address is a
+ * bus address when doing P2PDMA.
+ */
+#ifdef CONFIG_PCI_P2PDMA
+#define SG_DMA_BUS_ADDRESS	0x04UL
+static_assert(__alignof__(struct page) >= 8);
+#else
+#define SG_DMA_BUS_ADDRESS	0x00UL
+#endif
+
 /*
  * We overload the LSB of the page pointer to indicate whether it's
  * a valid sg entry, or whether it points to the start of a new scatterlist.
  * Those low bits are there for everyone! (thanks mason :-)
  */
-#define SG_PAGE_LINK_MASK (SG_CHAIN | SG_END)
+#define SG_PAGE_LINK_MASK (SG_CHAIN | SG_END | SG_DMA_BUS_ADDRESS)
 
 static inline unsigned int __sg_flags(struct scatterlist *sg)
 {
@@ -91,6 +103,11 @@ static inline bool sg_is_last(struct scatterlist *sg)
 	return __sg_flags(sg) & SG_END;
 }
 
+static inline bool sg_is_dma_bus_address(struct scatterlist *sg)
+{
+	return __sg_flags(sg) & SG_DMA_BUS_ADDRESS;
+}
+
 /**
  * sg_assign_page - Assign a given page to an SG entry
  * @sg:		    SG entry
@@ -245,6 +262,31 @@ static inline void sg_unmark_end(struct scatterlist *sg)
 	sg->page_link &= ~SG_END;
 }
 
+/**
+ * sg_dma_mark_bus address - Mark the scatterlist entry as a bus address
+ * @sg:		 SG entryScatterlist
+ *
+ * Description:
+ *   Marks the passed in sg entry to indicate that the dma_address is
+ *   a bus address and doesn't need to be unmapped.
+ **/
+static inline void sg_dma_mark_bus_address(struct scatterlist *sg)
+{
+	sg->page_link |= SG_DMA_BUS_ADDRESS;
+}
+
+/**
+ * sg_unmark_pci_p2pdma - Unmark the scatterlist entry as a bus address
+ * @sg:		 SG entryScatterlist
+ *
+ * Description:
+ *   Clears the bus address mark.
+ **/
+static inline void sg_dma_unmark_bus_address(struct scatterlist *sg)
+{
+	sg->page_link &= ~SG_DMA_BUS_ADDRESS;
+}
+
 /**
  * sg_phys - Return physical address of an sg entry
  * @sg:	     SG entry
-- 
2.30.2

