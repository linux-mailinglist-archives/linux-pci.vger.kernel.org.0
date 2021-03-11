Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57AB63381C9
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 00:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhCKXs7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Mar 2021 18:48:59 -0500
Received: from ale.deltatee.com ([204.191.154.188]:34142 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbhCKXsi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Mar 2021 18:48:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=SoJ7QXcdMSNUWNuLgYtfThq+6IS5T78F0fYqiwZNrwI=; b=QIMuZxlg4vewqu/4hC9UxXtgJ0
        o3uE3b2Nt1fxjOPIpxtlRszTvMXmqezV8xlxuXlUdnBrVDqJJ6ywk6oHVWuB7N6QbwUyvrauZn5tR
        Czn6BJRJ54+4CiKJjqMB+AUUc+4SV8kD13q7+6L1bQgUZdOQyNhmHLnvU4UEMOFa6d0AYVSr/r3OH
        zm7L3fx3qibd57BVLO4u82KL7qds64KW2ceFG8fqLRl4U00vjfuFApPj+bO2wDyf+RKaYb9lcqf4j
        pRS9wveW5+nbQBmQ6dRKJKhwWNECTH0VurPYT1q2Ew+itwn4+g7k33ZjhZ+4NnAfSBX9PK8DH1wrT
        H9so8qRw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1lKUms-0003ev-BW; Thu, 11 Mar 2021 16:32:15 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1lKUmW-00024Y-E1; Thu, 11 Mar 2021 16:31:52 -0700
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
Date:   Thu, 11 Mar 2021 16:31:35 -0700
Message-Id: <20210311233142.7900-6-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210311233142.7900-1-logang@deltatee.com>
References: <20210311233142.7900-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, dan.j.williams@intel.com, iweiny@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_FREE autolearn=no autolearn_force=no version=3.4.2
Subject: [RFC PATCH v2 05/11] lib/scatterlist: Add flag for indicating P2PDMA segments in an SGL
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Make use of the third free LSB in scatterlist's page_link on 64bit systems.

The extra bit will be used by dma_[un]map_sg() to determine when a
given SGL segments dma_address points to a PCI bus address.
dma_unmap_sg() will need to perform different cleanup when this is the
case.

Using this bit requires adding an additional dependency on CONFIG_64BIT to
CONFIG_PCI_P2PDMA. This should be acceptable as the majority of P2PDMA
use cases are restricted to newer root complexes and roughly require the
extra address space for memory BARs used in the transactions.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/Kconfig         |  2 +-
 include/linux/scatterlist.h | 49 ++++++++++++++++++++++++++++++++++---
 2 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 0c473d75e625..90b4bddb3300 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -163,7 +163,7 @@ config PCI_PASID
 
 config PCI_P2PDMA
 	bool "PCI peer-to-peer transfer support"
-	depends on ZONE_DEVICE
+	depends on ZONE_DEVICE && 64BIT
 	select GENERIC_ALLOCATOR
 	help
 	  Enableѕ drivers to do PCI peer-to-peer transactions to and from
diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 6f70572b2938..5525d3ebf36f 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -58,6 +58,21 @@ struct sg_table {
 #define SG_CHAIN	0x01UL
 #define SG_END		0x02UL
 
+/*
+ * bit 2 is the third free bit in the page_link on 64bit systems which
+ * is used by dma_unmap_sg() to determine if the dma_address is a PCI
+ * bus address when doing P2PDMA.
+ * Note: CONFIG_PCI_P2PDMA depends on CONFIG_64BIT because of this.
+ */
+
+#ifdef CONFIG_PCI_P2PDMA
+#define SG_PCI_P2PDMA	0x04UL
+#else
+#define SG_PCI_P2PDMA	0x00UL
+#endif
+
+#define SG_PAGE_LINK_MASK (SG_CHAIN | SG_END | SG_PCI_P2PDMA)
+
 /*
  * We overload the LSB of the page pointer to indicate whether it's
  * a valid sg entry, or whether it points to the start of a new scatterlist.
@@ -65,8 +80,9 @@ struct sg_table {
  */
 #define sg_is_chain(sg)		((sg)->page_link & SG_CHAIN)
 #define sg_is_last(sg)		((sg)->page_link & SG_END)
+#define sg_is_pci_p2pdma(sg)	((sg)->page_link & SG_PCI_P2PDMA)
 #define sg_chain_ptr(sg)	\
-	((struct scatterlist *) ((sg)->page_link & ~(SG_CHAIN | SG_END)))
+	((struct scatterlist *) ((sg)->page_link & ~SG_PAGE_LINK_MASK))
 
 /**
  * sg_assign_page - Assign a given page to an SG entry
@@ -80,13 +96,13 @@ struct sg_table {
  **/
 static inline void sg_assign_page(struct scatterlist *sg, struct page *page)
 {
-	unsigned long page_link = sg->page_link & (SG_CHAIN | SG_END);
+	unsigned long page_link = sg->page_link & SG_PAGE_LINK_MASK;
 
 	/*
 	 * In order for the low bit stealing approach to work, pages
 	 * must be aligned at a 32-bit boundary as a minimum.
 	 */
-	BUG_ON((unsigned long) page & (SG_CHAIN | SG_END));
+	BUG_ON((unsigned long) page & SG_PAGE_LINK_MASK);
 #ifdef CONFIG_DEBUG_SG
 	BUG_ON(sg_is_chain(sg));
 #endif
@@ -120,7 +136,7 @@ static inline struct page *sg_page(struct scatterlist *sg)
 #ifdef CONFIG_DEBUG_SG
 	BUG_ON(sg_is_chain(sg));
 #endif
-	return (struct page *)((sg)->page_link & ~(SG_CHAIN | SG_END));
+	return (struct page *)((sg)->page_link & ~SG_PAGE_LINK_MASK);
 }
 
 /**
@@ -222,6 +238,31 @@ static inline void sg_unmark_end(struct scatterlist *sg)
 	sg->page_link &= ~SG_END;
 }
 
+/**
+ * sg_mark_pci_p2pdma - Mark the scatterlist entry for PCI p2pdma
+ * @sg:		 SG entryScatterlist
+ *
+ * Description:
+ *   Marks the passed in sg entry to indicate that the dma_address is
+ *   a PCI bus address.
+ **/
+static inline void sg_mark_pci_p2pdma(struct scatterlist *sg)
+{
+	sg->page_link |= SG_PCI_P2PDMA;
+}
+
+/**
+ * sg_unmark_pci_p2pdma - Unmark the scatterlist entry for PCI p2pdma
+ * @sg:		 SG entryScatterlist
+ *
+ * Description:
+ *   Clears the PCI P2PDMA mark
+ **/
+static inline void sg_unmark_pci_p2pdma(struct scatterlist *sg)
+{
+	sg->page_link &= ~SG_PCI_P2PDMA;
+}
+
 /**
  * sg_phys - Return physical address of an sg entry
  * @sg:	     SG entry
-- 
2.20.1

