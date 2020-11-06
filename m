Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA272A9A2F
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 18:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgKFRBC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Nov 2020 12:01:02 -0500
Received: from ale.deltatee.com ([204.191.154.188]:57750 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbgKFRBB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Nov 2020 12:01:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+uqfieveTb31l1I/WgAkJQG/BPoFvWugOcEIiwpm3kQ=; b=K/HV2BMNQ6+6v1KGlkocloGfxX
        ZWdpu/VS9RNxpNY9R/oz0jP293p4I8inagWYs5mlGH5bia7wQlzpw3FTgvAFzWEwL0ybuh3hIAXXP
        MQlIvwWcTYi0ARarXpd7S2Bc32AzGJ6la7fmqzzvGUOVG8ImW4ZkrByhDx/xok/sKn7RBnA2n2NDb
        HOxtePt42cqkRTQIomX4tiFo46PEYnrHBW/M2u8Rox2KBUqqAsXYw0D7bxoumM3wchsQq+YXQTQI7
        04zRIPfswqboFYzi35+ClwHNkXD71FRFjRylfRjcS74F/xb/qcEtUatWrnKqfrQkCIk/HCqRSQ523
        vwEV+YBQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kb56g-0002Pa-SW; Fri, 06 Nov 2020 10:01:00 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kb56V-0004tH-Aa; Fri, 06 Nov 2020 10:00:47 -0700
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
        Logan Gunthorpe <logang@deltatee.com>
Date:   Fri,  6 Nov 2020 10:00:31 -0700
Message-Id: <20201106170036.18713-11-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201106170036.18713-1-logang@deltatee.com>
References: <20201106170036.18713-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, jgg@ziepe.ca, christian.koenig@amd.com, dan.j.williams@intel.com, iweiny@intel.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE,MYRULES_NO_TEXT autolearn=ham
        autolearn_force=no version=3.4.2
Subject: [RFC PATCH 10/15] mm: Introduce FOLL_PCI_P2PDMA to gate getting PCI P2PDMA pages
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Callers that expect PCI P2PDMA pages can now set FOLL_PCI_P2PDMA to
allow obtaining P2PDMA pages. If a caller does not set this flag
and tries to map P2PDMA pages it will fail.

This is implemented by adding a flag and a check to get_dev_pagemap().

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dax/super.c      |  7 ++++---
 include/linux/memremap.h |  4 ++--
 include/linux/mm.h       |  1 +
 mm/gup.c                 | 28 +++++++++++++++++-----------
 mm/huge_memory.c         |  8 ++++----
 mm/memory-failure.c      |  4 ++--
 mm/memremap.c            | 14 ++++++++++----
 7 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index edc279be3e59..59c05839b3f8 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -132,9 +132,10 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
 	} else if (pfn_t_devmap(pfn) && pfn_t_devmap(end_pfn)) {
 		struct dev_pagemap *pgmap, *end_pgmap;
 
-		pgmap = get_dev_pagemap(pfn_t_to_pfn(pfn), NULL);
-		end_pgmap = get_dev_pagemap(pfn_t_to_pfn(end_pfn), NULL);
-		if (pgmap && pgmap == end_pgmap && pgmap->type == MEMORY_DEVICE_FS_DAX
+		pgmap = get_dev_pagemap(pfn_t_to_pfn(pfn), NULL, false);
+		end_pgmap = get_dev_pagemap(pfn_t_to_pfn(end_pfn), NULL, false);
+		if (!IS_ERR_OR_NULL(pgmap) && pgmap == end_pgmap
+				&& pgmap->type == MEMORY_DEVICE_FS_DAX
 				&& pfn_t_to_page(pfn)->pgmap == pgmap
 				&& pfn_t_to_page(end_pfn)->pgmap == pgmap
 				&& pfn_t_to_pfn(pfn) == PHYS_PFN(__pa(kaddr))
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 79c49e7f5c30..14f6d899c657 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -136,7 +136,7 @@ void memunmap_pages(struct dev_pagemap *pgmap);
 void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap);
 void devm_memunmap_pages(struct device *dev, struct dev_pagemap *pgmap);
 struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
-		struct dev_pagemap *pgmap);
+		struct dev_pagemap *pgmap, bool allow_pci_p2pdma);
 
 unsigned long vmem_altmap_offset(struct vmem_altmap *altmap);
 void vmem_altmap_free(struct vmem_altmap *altmap, unsigned long nr_pfns);
@@ -160,7 +160,7 @@ static inline void devm_memunmap_pages(struct device *dev,
 }
 
 static inline struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
-		struct dev_pagemap *pgmap)
+		struct dev_pagemap *pgmap, bool allow_pci_p2pdma)
 {
 	return NULL;
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ef360fe70aaf..c405af966a4e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2790,6 +2790,7 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 #define FOLL_SPLIT_PMD	0x20000	/* split huge pmd before returning */
 #define FOLL_PIN	0x40000	/* pages must be released via unpin_user_page */
 #define FOLL_FAST_ONLY	0x80000	/* gup_fast: prevent fall-back to slow gup */
+#define FOLL_PCI_P2PDMA	0x100000 /* allow returning PCI P2PDMA pages */
 
 /*
  * FOLL_PIN and FOLL_LONGTERM may be used in various combinations with each
diff --git a/mm/gup.c b/mm/gup.c
index 102877ed77a4..abbc0a06d241 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -449,11 +449,16 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		 * case since they are only valid while holding the pgmap
 		 * reference.
 		 */
-		*pgmap = get_dev_pagemap(pte_pfn(pte), *pgmap);
-		if (*pgmap)
+		*pgmap = get_dev_pagemap(pte_pfn(pte), *pgmap,
+					 flags & FOLL_PCI_P2PDMA);
+		if (IS_ERR(*pgmap)) {
+			page = ERR_CAST(*pgmap);
+			goto out;
+		} else if (*pgmap) {
 			page = pte_page(pte);
-		else
+		} else {
 			goto no_page;
+		}
 	} else if (unlikely(!page)) {
 		if (flags & FOLL_DUMP) {
 			/* Avoid special (like zero) pages in core dumps */
@@ -794,7 +799,7 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 	struct page *page;
 
 	page = follow_page_mask(vma, address, foll_flags, &ctx);
-	if (ctx.pgmap)
+	if (!IS_ERR_OR_NULL(ctx.pgmap))
 		put_dev_pagemap(ctx.pgmap);
 	return page;
 }
@@ -1138,7 +1143,7 @@ static long __get_user_pages(struct mm_struct *mm,
 		nr_pages -= page_increm;
 	} while (nr_pages);
 out:
-	if (ctx.pgmap)
+	if (!IS_ERR_OR_NULL(ctx.pgmap))
 		put_dev_pagemap(ctx.pgmap);
 	return i ? i : ret;
 }
@@ -2177,8 +2182,9 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 			if (unlikely(flags & FOLL_LONGTERM))
 				goto pte_unmap;
 
-			pgmap = get_dev_pagemap(pte_pfn(pte), pgmap);
-			if (unlikely(!pgmap)) {
+			pgmap = get_dev_pagemap(pte_pfn(pte), pgmap,
+						flags & FOLL_PCI_P2PDMA);
+			if (IS_ERR_OR_NULL(pgmap)) {
 				undo_dev_pagemap(nr, nr_start, flags, pages);
 				goto pte_unmap;
 			}
@@ -2221,7 +2227,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 	ret = 1;
 
 pte_unmap:
-	if (pgmap)
+	if (!IS_ERR_OR_NULL(pgmap))
 		put_dev_pagemap(pgmap);
 	pte_unmap(ptem);
 	return ret;
@@ -2255,8 +2261,8 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
 	do {
 		struct page *page = pfn_to_page(pfn);
 
-		pgmap = get_dev_pagemap(pfn, pgmap);
-		if (unlikely(!pgmap)) {
+		pgmap = get_dev_pagemap(pfn, pgmap, flags & FOLL_PCI_P2PDMA);
+		if (IS_ERR_OR_NULL(pgmap)) {
 			undo_dev_pagemap(nr, nr_start, flags, pages);
 			return 0;
 		}
@@ -2681,7 +2687,7 @@ static int internal_get_user_pages_fast(unsigned long start, int nr_pages,
 
 	if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM |
 				       FOLL_FORCE | FOLL_PIN | FOLL_GET |
-				       FOLL_FAST_ONLY)))
+				       FOLL_FAST_ONLY | FOLL_PCI_P2PDMA)))
 		return -EINVAL;
 
 	if (gup_flags & FOLL_PIN)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9474dbc150ed..3030548dc007 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -985,8 +985,8 @@ struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
 		return ERR_PTR(-EEXIST);
 
 	pfn += (addr & ~PMD_MASK) >> PAGE_SHIFT;
-	*pgmap = get_dev_pagemap(pfn, *pgmap);
-	if (!*pgmap)
+	*pgmap = get_dev_pagemap(pfn, *pgmap, flags & FOLL_PCI_P2PDMA);
+	if (IS_ERR_OR_NULL(*pgmap))
 		return ERR_PTR(-EFAULT);
 	page = pfn_to_page(pfn);
 	if (!try_grab_page(page, flags))
@@ -1159,8 +1159,8 @@ struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
 		return ERR_PTR(-EEXIST);
 
 	pfn += (addr & ~PUD_MASK) >> PAGE_SHIFT;
-	*pgmap = get_dev_pagemap(pfn, *pgmap);
-	if (!*pgmap)
+	*pgmap = get_dev_pagemap(pfn, *pgmap, flags & FOLL_PCI_P2PDMA);
+	if (IS_ERR_OR_NULL(*pgmap))
 		return ERR_PTR(-EFAULT);
 	page = pfn_to_page(pfn);
 	if (!try_grab_page(page, flags))
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index c0bb186bba62..44fdad77f06a 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1328,8 +1328,8 @@ int memory_failure(unsigned long pfn, int flags)
 	p = pfn_to_online_page(pfn);
 	if (!p) {
 		if (pfn_valid(pfn)) {
-			pgmap = get_dev_pagemap(pfn, NULL);
-			if (pgmap)
+			pgmap = get_dev_pagemap(pfn, NULL, false);
+			if (!IS_ERR_OR_NULL(pgmap))
 				return memory_failure_dev_pagemap(pfn, flags,
 								  pgmap);
 		}
diff --git a/mm/memremap.c b/mm/memremap.c
index 73a206d0f645..5f0284c3a3c3 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -197,14 +197,14 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
 				"altmap not supported for multiple ranges\n"))
 		return -EINVAL;
 
-	conflict_pgmap = get_dev_pagemap(PHYS_PFN(range->start), NULL);
+	conflict_pgmap = get_dev_pagemap(PHYS_PFN(range->start), NULL, true);
 	if (conflict_pgmap) {
 		WARN(1, "Conflicting mapping in same section\n");
 		put_dev_pagemap(conflict_pgmap);
 		return -ENOMEM;
 	}
 
-	conflict_pgmap = get_dev_pagemap(PHYS_PFN(range->end), NULL);
+	conflict_pgmap = get_dev_pagemap(PHYS_PFN(range->end), NULL, true);
 	if (conflict_pgmap) {
 		WARN(1, "Conflicting mapping in same section\n");
 		put_dev_pagemap(conflict_pgmap);
@@ -454,19 +454,20 @@ void vmem_altmap_free(struct vmem_altmap *altmap, unsigned long nr_pfns)
  * get_dev_pagemap() - take a new live reference on the dev_pagemap for @pfn
  * @pfn: page frame number to lookup page_map
  * @pgmap: optional known pgmap that already has a reference
+ * @allow_pci_p2pdma: allow getting a pgmap with the PCI P2PDMA type
  *
  * If @pgmap is non-NULL and covers @pfn it will be returned as-is.  If @pgmap
  * is non-NULL but does not cover @pfn the reference to it will be released.
  */
 struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
-		struct dev_pagemap *pgmap)
+		struct dev_pagemap *pgmap, bool allow_pci_p2pdma)
 {
 	resource_size_t phys = PFN_PHYS(pfn);
 
 	/*
 	 * In the cached case we're already holding a live reference.
 	 */
-	if (pgmap) {
+	if (!IS_ERR_OR_NULL(pgmap)) {
 		if (phys >= pgmap->range.start && phys <= pgmap->range.end)
 			return pgmap;
 		put_dev_pagemap(pgmap);
@@ -479,6 +480,11 @@ struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
 		pgmap = NULL;
 	rcu_read_unlock();
 
+	if (!allow_pci_p2pdma && pgmap->type == MEMORY_DEVICE_PCI_P2PDMA) {
+		put_dev_pagemap(pgmap);
+		return ERR_PTR(-EINVAL);
+	}
+
 	return pgmap;
 }
 EXPORT_SYMBOL_GPL(get_dev_pagemap);
-- 
2.20.1

