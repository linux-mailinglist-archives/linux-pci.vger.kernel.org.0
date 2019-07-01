Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87A2D5B498
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2019 08:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfGAGUc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jul 2019 02:20:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48138 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfGAGUa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jul 2019 02:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UlLC8XGw3CfveOE+CE9qUf9ABEe6OmzNIUUnRKazXzE=; b=mMtjeXqRDcDlmyLmrlKFtZtdRU
        1ZECHbYWTfCpkYG1u7NxycM68aGZsaYVHMGnG4IQzU0TAgr9BXvJmFLjN1uPnSkkanle0EQD+/cUS
        ysH15a0tARem1UDKd65mwKxipLWalrdQsGtNrZr4Ay04rG8pu2TsMymVBvSIJ23mdukOSrcE5tXS+
        BWHN4YZYUOMExmZHWnv83906SilXzAL2f2pgaif+KbkA2D1AQX1pNsvBi8cwWmL7Fz0f8pQe7JPnj
        XXI8WLRTzHBt3FMBIQfyW16QH39tSa/OW8ex+6Eu1UTsQsmyJMJobkLg5Jcwv6wJjHpb7mHbkiY/n
        MjKn053w==;
Received: from [46.140.178.35] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hhpfs-0002sg-H6; Mon, 01 Jul 2019 06:20:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 01/22] mm/hmm.c: suppress compilation warnings when CONFIG_HUGETLB_PAGE is not set
Date:   Mon,  1 Jul 2019 08:19:59 +0200
Message-Id: <20190701062020.19239-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701062020.19239-1-hch@lst.de>
References: <20190701062020.19239-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

gcc reports that several variables are defined but not used.

For the first hunk CONFIG_HUGETLB_PAGE the entire if block is already
protected by pud_huge() which is forced to 0.  None of the stuff under the
ifdef causes compilation problems as it is already stubbed out in the
header files.

For the second hunk the dummy huge_page_shift macro doesn't touch the
argument, so just inline the argument.

Link: http://lkml.kernel.org/r/20190522195151.GA23955@ziepe.ca
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/hmm.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index c5d840e34b28..c62ae414a3a2 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -788,7 +788,6 @@ static int hmm_vma_walk_pud(pud_t *pudp,
 			return hmm_vma_walk_hole_(addr, end, fault,
 						write_fault, walk);
 
-#ifdef CONFIG_HUGETLB_PAGE
 		pfn = pud_pfn(pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
 		for (i = 0; i < npages; ++i, ++pfn) {
 			hmm_vma_walk->pgmap = get_dev_pagemap(pfn,
@@ -804,9 +803,6 @@ static int hmm_vma_walk_pud(pud_t *pudp,
 		}
 		hmm_vma_walk->last = end;
 		return 0;
-#else
-		return -EINVAL;
-#endif
 	}
 
 	split_huge_pud(walk->vma, pudp, addr);
@@ -1015,9 +1011,8 @@ long hmm_range_snapshot(struct hmm_range *range)
 			return -EFAULT;
 
 		if (is_vm_hugetlb_page(vma)) {
-			struct hstate *h = hstate_vma(vma);
-
-			if (huge_page_shift(h) != range->page_shift &&
+			if (huge_page_shift(hstate_vma(vma)) !=
+				    range->page_shift &&
 			    range->page_shift != PAGE_SHIFT)
 				return -EINVAL;
 		} else {
-- 
2.20.1

