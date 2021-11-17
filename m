Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72DDF454FC1
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 22:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240968AbhKQV5g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Nov 2021 16:57:36 -0500
Received: from ale.deltatee.com ([204.191.154.188]:58734 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240843AbhKQV5Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Nov 2021 16:57:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=E9tQWtvaLICmPSoEVBJb4KTrJ+PSjHquPVLYmy++lAQ=; b=mxEXmW4OZEo8i67U5DMx5HrPbS
        AK51pgfhmTpE6vjIujjmCpY6A999ck0das6Npk9wDVBcYvnl0gbK1ZiUDlXCosy+XmIlbhUrVTAPZ
        91/bA6ba3/Cvv04qAIODBzWTtAiiSx+V26PZJhQnAs12eMgjW7W09G8nDZ3Grj/zcNnkBFe16y2/x
        3EeSCU5zQmKpyIBKL3ExEDIK8vyuN11OYMSzAtVXOmO6g9WGvL2RbrJQUL8n8Bi1fVrHh4w1bx0ZC
        jvYm0EPPRg8+gcnpY5++dLLNcWVdibi79wrXO38JGd6xsQRZfLh0GmriWFh1BXBlkfAKoiPIIxUux
        I8dRAKeA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1mnSsi-000Zo5-TA; Wed, 17 Nov 2021 14:54:17 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1mnSse-0000yr-90; Wed, 17 Nov 2021 14:54:12 -0700
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
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 17 Nov 2021 14:53:49 -0700
Message-Id: <20211117215410.3695-3-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211117215410.3695-1-logang@deltatee.com>
References: <20211117215410.3695-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_FREE autolearn=no autolearn_force=no version=3.4.6
Subject: [PATCH v4 02/23] lib/scatterlist: add flag for indicating P2PDMA segments in an SGL
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

Create a CONFIG_NEED_SG_DMA_BUS_ADDR_FLAG bool which depends on
CONFIG_64BIT (so there is space in the page link for the new flag).
CONFIG_PCI_P2PDMA will then depend on this so this means PCI P2PDMA will
require CONFIG_64BIT. This should be acceptable as the majority of P2PDMA
use cases are restricted to newer root complexes and roughly require the
extra address space for memory BARs used in the transactions.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/Kconfig         |  5 +++++
 include/linux/scatterlist.h | 44 ++++++++++++++++++++++++++++++++++++-
 kernel/dma/Kconfig          | 10 +++++++++
 3 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 43e615aa12ff..95f29601a4df 100644
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
+	select NEED_SG_DMA_BUS_ADDR_FLAG
 	select GENERIC_ALLOCATOR
 	help
 	  Enableѕ drivers to do PCI peer-to-peer transactions to and from
diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 7ff9d6386c12..917c09dcc566 100644
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
+#ifdef CONFIG_NEED_SG_DMA_BUS_ADDR_FLAG
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
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 1b02179758cb..6e5e1d8e1329 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -27,6 +27,16 @@ config ARCH_HAS_DMA_MAP_DIRECT
 config NEED_SG_DMA_LENGTH
 	bool
 
+#
+# PCI P2PDMA needs to store bus addresses in the SGL's dma_address so that the
+# dma_unmap_sg() implementations can know not to unmap those segments.
+# The flag is stored in the 3rd bit in the page_link field in the SGL
+# which means this can only be done on 64bit systems.
+#
+config NEED_SG_DMA_BUS_ADDR_FLAG
+	depends on 64BIT
+	bool
+
 config NEED_DMA_MAP_STATE
 	bool
 
-- 
2.30.2

