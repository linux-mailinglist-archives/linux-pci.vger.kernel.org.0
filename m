Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDB2607DB0
	for <lists+linux-pci@lfdr.de>; Fri, 21 Oct 2022 19:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiJURlc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Oct 2022 13:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiJURl3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Oct 2022 13:41:29 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3ED824AE35;
        Fri, 21 Oct 2022 10:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=OC676xm4n+4quUWve6+HSNFg0hwcXHADJsbuIB5KOEM=; b=Wsxq4q38mUEjvwfxvFF14IWzOU
        5VlOWiPn8393f1dAxy8toKeXn6XeHrR/IUTe8OpAg2VL4FONatGB0R5rvYnwFWE1BTojlUpH2WfJW
        8Z6THGFo+tIqoM5h4LswsjbKqa5dblgAGUcLcNNggZITwNoKaKq9alo493IKjoWM+/9ZiXHbXPtJY
        LAA7yWQZpTmCk1DJ2q0L2uYXuCNRSifxnQTC8AFv5l/wsP3k9oTTSC9OAUUZPtZWy3uAjMtFP1FCF
        tQWboeFYCJfBd8htw5d0X8tTLHSMTbe/6E3W00wy5pRWsT/5+JCkf47fjtvYawICHeGbAdpz+t893
        wKG7s7/g==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1olw1I-00DoHz-T8; Fri, 21 Oct 2022 11:41:21 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1olw1F-0001t9-OW; Fri, 21 Oct 2022 11:41:17 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Fri, 21 Oct 2022 11:41:09 -0600
Message-Id: <20221021174116.7200-3-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221021174116.7200-1-logang@deltatee.com>
References: <20221021174116.7200-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, hch@lst.de, gregkh@linuxfoundation.org, jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, jhubbard@nvidia.com, rcampbell@nvidia.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v11 2/9] mm: introduce FOLL_PCI_P2PDMA to gate getting PCI P2PDMA pages
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

GUP Callers that expect PCI P2PDMA pages can now set FOLL_PCI_P2PDMA to
allow obtaining P2PDMA pages. If GUP is called without the flag and a
P2PDMA page is found, it will return an error in try_grab_page() or
try_grab_folio().

The check is safe to do before taking the reference to the page in both
cases seeing the page should be protected by either the appropriate
ptl or mmap_lock; or the gup fast guarantees preventing TLB flushes.

try_grab_folio() has one call site that WARNs on failure and cannot
actually deal with the failure of this function (it seems it will
get into an infinite loop). Expand the comment there to document a
couple more conditions on why it will not fail.

FOLL_PCI_P2PDMA cannot be set if FOLL_LONGTERM is set. This is to copy
fsdax until pgmap refcounts are fixed (see the link below for more
information).

Link: https://lkml.kernel.org/r/Yy4Ot5MoOhsgYLTQ@ziepe.ca
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 include/linux/mm.h |  1 +
 mm/gup.c           | 19 ++++++++++++++++++-
 mm/hugetlb.c       |  6 ++++--
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 62a91dc1272b..6b081a8dcf88 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2958,6 +2958,7 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 #define FOLL_SPLIT_PMD	0x20000	/* split huge pmd before returning */
 #define FOLL_PIN	0x40000	/* pages must be released via unpin_user_page */
 #define FOLL_FAST_ONLY	0x80000	/* gup_fast: prevent fall-back to slow gup */
+#define FOLL_PCI_P2PDMA	0x100000 /* allow returning PCI P2PDMA pages */
 
 /*
  * FOLL_PIN and FOLL_LONGTERM may be used in various combinations with each
diff --git a/mm/gup.c b/mm/gup.c
index e2f447446384..29e28f020f0b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -123,6 +123,9 @@ static inline struct folio *try_get_folio(struct page *page, int refs)
  */
 struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
 {
+	if (unlikely(!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page)))
+		return NULL;
+
 	if (flags & FOLL_GET)
 		return try_get_folio(page, refs);
 	else if (flags & FOLL_PIN) {
@@ -216,6 +219,9 @@ int __must_check try_grab_page(struct page *page, unsigned int flags)
 	if (WARN_ON_ONCE(folio_ref_count(folio) <= 0))
 		return -ENOMEM;
 
+	if (unlikely(!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page)))
+		return -EREMOTEIO;
+
 	if (flags & FOLL_GET)
 		folio_ref_inc(folio);
 	else if (flags & FOLL_PIN) {
@@ -631,6 +637,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		page = ERR_PTR(ret);
 		goto out;
 	}
+
 	/*
 	 * We need to make the page accessible if and only if we are going
 	 * to access its content (the FOLL_PIN case).  Please see
@@ -1060,6 +1067,9 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 	if ((gup_flags & FOLL_LONGTERM) && vma_is_fsdax(vma))
 		return -EOPNOTSUPP;
 
+	if ((gup_flags & FOLL_LONGTERM) && (gup_flags & FOLL_PCI_P2PDMA))
+		return -EOPNOTSUPP;
+
 	if (vma_is_secretmem(vma))
 		return -EFAULT;
 
@@ -2536,6 +2546,12 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
 			undo_dev_pagemap(nr, nr_start, flags, pages);
 			break;
 		}
+
+		if (!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page)) {
+			undo_dev_pagemap(nr, nr_start, flags, pages);
+			break;
+		}
+
 		SetPageReferenced(page);
 		pages[*nr] = page;
 		if (unlikely(try_grab_page(page, flags))) {
@@ -3020,7 +3036,8 @@ static int internal_get_user_pages_fast(unsigned long start,
 
 	if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM |
 				       FOLL_FORCE | FOLL_PIN | FOLL_GET |
-				       FOLL_FAST_ONLY | FOLL_NOFAULT)))
+				       FOLL_FAST_ONLY | FOLL_NOFAULT |
+				       FOLL_PCI_P2PDMA)))
 		return -EINVAL;
 
 	if (gup_flags & FOLL_PIN)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e8d01a19ce46..a55adfbacedb 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6342,8 +6342,10 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			 * tables. If the huge page is present, then the tail
 			 * pages must also be present. The ptl prevents the
 			 * head page and tail pages from being rearranged in
-			 * any way. So this page must be available at this
-			 * point, unless the page refcount overflowed:
+			 * any way. As this is hugetlb, the pages will never
+			 * be p2pdma or not longterm pinable. So this page
+			 * must be available at this point, unless the page
+			 * refcount overflowed:
 			 */
 			if (WARN_ON_ONCE(!try_grab_folio(pages[i], refs,
 							 flags))) {
-- 
2.30.2

