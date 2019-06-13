Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 767E943DB3
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 17:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfFMPo3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 11:44:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33544 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731820AbfFMJoS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jun 2019 05:44:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AuQMTpcqJo62VjhPIKMCZhZk+h6e6THsOZ01qDGPkX8=; b=rUn+qQErmwhgGijTtCS+CPfQfX
        C6JSAQ1wYIYTWBE1sk8wIkEnTQn0lkCbB5R+ffY6ISa5sjGbOSw0+7bEyC7m+Qij4zcVeeFUifawM
        Un1Dx3C+QCWSrqmn1w2RLX0JpvUup817a1QufBRSu4NPSt1SswH6b9wJA03REDNoLrDPDc5TclJrr
        xEr8kX7Hqw6gfUzged3ZKit4eyUFtG+CmH6acz3g27hPRgnBplRhZJoO5JRbm+/AUSeySbU2/KzoK
        i4uKJlLh0eU/1N6Uuc+zL/fMMHvYHpiCNP22jqmNO+zDGCudBxJG6+3+BI8MnXE1HOXlORblkJtCC
        FLHmz0jw==;
Received: from mpp-cp1-natpool-1-198.ethz.ch ([82.130.71.198] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbMHG-0001u9-ME; Thu, 13 Jun 2019 09:44:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     linux-mm@kvack.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 16/22] mm: remove hmm_vma_alloc_locked_page
Date:   Thu, 13 Jun 2019 11:43:19 +0200
Message-Id: <20190613094326.24093-17-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613094326.24093-1-hch@lst.de>
References: <20190613094326.24093-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The only user of it has just been removed, and there wasn't really any need
to wrap a basic memory allocator to start with.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/hmm.h |  3 ---
 mm/hmm.c            | 14 --------------
 2 files changed, 17 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 3c9a59dbfdb8..0e61d830b0a9 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -553,9 +553,6 @@ static inline void hmm_mm_init(struct mm_struct *mm) {}
 #if IS_ENABLED(CONFIG_DEVICE_PRIVATE) ||  IS_ENABLED(CONFIG_DEVICE_PUBLIC)
 struct hmm_devmem;
 
-struct page *hmm_vma_alloc_locked_page(struct vm_area_struct *vma,
-				       unsigned long addr);
-
 /*
  * struct hmm_devmem_ops - callback for ZONE_DEVICE memory events
  *
diff --git a/mm/hmm.c b/mm/hmm.c
index ff0f9568922b..c15283f9bbf0 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -1293,20 +1293,6 @@ EXPORT_SYMBOL(hmm_range_dma_unmap);
 
 
 #if IS_ENABLED(CONFIG_DEVICE_PRIVATE) ||  IS_ENABLED(CONFIG_DEVICE_PUBLIC)
-struct page *hmm_vma_alloc_locked_page(struct vm_area_struct *vma,
-				       unsigned long addr)
-{
-	struct page *page;
-
-	page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
-	if (!page)
-		return NULL;
-	lock_page(page);
-	return page;
-}
-EXPORT_SYMBOL(hmm_vma_alloc_locked_page);
-
-
 static void hmm_devmem_ref_release(struct percpu_ref *ref)
 {
 	struct hmm_devmem *devmem;
-- 
2.20.1

