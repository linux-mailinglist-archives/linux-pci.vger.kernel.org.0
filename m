Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B4540EDFF
	for <lists+linux-pci@lfdr.de>; Fri, 17 Sep 2021 01:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241750AbhIPXmj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Sep 2021 19:42:39 -0400
Received: from ale.deltatee.com ([204.191.154.188]:40626 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241524AbhIPXmd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Sep 2021 19:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=arFH99DUJr+fdx0HX30kUMhVmfvBEqDMbTFnSE8uGj4=; b=rHiKsZcHqS4EhFRroMROAw2Pu4
        xHfwQcVMyC7BHVmoKd7MdS77sOlaZDPrPSaUpK4Aq1gLSbGFHGq03bk0TeqpPTifgOcedNtIz4WqZ
        dLcnbgGd9KriuZ/2wv4aigasIe78FBTuF+HS/XG1WAv4s5F+HaD94PD5f1qVodHtS3Ff4SrimDh2O
        Hhs8WWSaLSQgBrpUQ8M9v0uaDc0zgoHhlq50KEy+SdHt+SFWC0WQxUKXYgdWr7qp+ZKRq+THTg1gs
        y5FIPkdfLsxOwARUU/DYmAHgVaHGwaCWuy177iaVbJ/1odXcLvy9x1+9CNdA7eTb6g2Njg+EvOEfz
        8KKfQcrA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1mR10B-0008I0-Cr; Thu, 16 Sep 2021 17:41:12 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1mR105-000Vre-So; Thu, 16 Sep 2021 17:41:05 -0600
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
Date:   Thu, 16 Sep 2021 17:40:55 -0600
Message-Id: <20210916234100.122368-16-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210916234100.122368-1-logang@deltatee.com>
References: <20210916234100.122368-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_FREE,MYRULES_NO_TEXT autolearn=no autolearn_force=no
        version=3.4.2
Subject: [PATCH v3 15/20] iov_iter: introduce iov_iter_get_pages_[alloc_]flags()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add iov_iter_get_pages_flags() and iov_iter_get_pages_alloc_flags()
which take a flags argument that is passed to get_user_pages_fast().

This is so that FOLL_PCI_P2PDMA can be passed when appropriate.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 include/linux/uio.h | 21 +++++++++++++++++----
 lib/iov_iter.c      | 28 ++++++++++++++++------------
 2 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 5265024e8b90..d4ce252db728 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -228,10 +228,23 @@ void iov_iter_pipe(struct iov_iter *i, unsigned int direction, struct pipe_inode
 void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count);
 void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *xarray,
 		     loff_t start, size_t count);
-ssize_t iov_iter_get_pages(struct iov_iter *i, struct page **pages,
-			size_t maxsize, unsigned maxpages, size_t *start);
-ssize_t iov_iter_get_pages_alloc(struct iov_iter *i, struct page ***pages,
-			size_t maxsize, size_t *start);
+ssize_t iov_iter_get_pages_flags(struct iov_iter *i, struct page **pages,
+		size_t maxsize, unsigned maxpages, size_t *start,
+		unsigned int gup_flags);
+ssize_t iov_iter_get_pages_alloc_flags(struct iov_iter *i,
+		struct page ***pages, size_t maxsize, size_t *start,
+		unsigned int gup_flags);
+static inline ssize_t iov_iter_get_pages(struct iov_iter *i,
+		struct page **pages, size_t maxsize, unsigned maxpages,
+		size_t *start)
+{
+	return iov_iter_get_pages_flags(i, pages, maxsize, maxpages, start, 0);
+}
+static inline ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
+		struct page ***pages, size_t maxsize, size_t *start)
+{
+	return iov_iter_get_pages_alloc_flags(i, pages, maxsize, start, 0);
+}
 int iov_iter_npages(const struct iov_iter *i, int maxpages);
 
 const void *dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index f2d50d69a6c3..bbf0fb6736a9 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1468,9 +1468,9 @@ static struct page *first_bvec_segment(const struct iov_iter *i,
 	return page;
 }
 
-ssize_t iov_iter_get_pages(struct iov_iter *i,
+ssize_t iov_iter_get_pages_flags(struct iov_iter *i,
 		   struct page **pages, size_t maxsize, unsigned maxpages,
-		   size_t *start)
+		   size_t *start, unsigned int gup_flags)
 {
 	size_t len;
 	int n, res;
@@ -1485,9 +1485,11 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 
 		addr = first_iovec_segment(i, &len, start, maxsize, maxpages);
 		n = DIV_ROUND_UP(len, PAGE_SIZE);
-		res = get_user_pages_fast(addr, n,
-				iov_iter_rw(i) != WRITE ?  FOLL_WRITE : 0,
-				pages);
+
+		if (iov_iter_rw(i) != WRITE)
+			gup_flags |= FOLL_WRITE;
+
+		res = get_user_pages_fast(addr, n, gup_flags, pages);
 		if (unlikely(res < 0))
 			return res;
 		return (res == n ? len : res * PAGE_SIZE) - *start;
@@ -1507,7 +1509,7 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 		return iter_xarray_get_pages(i, pages, maxsize, maxpages, start);
 	return -EFAULT;
 }
-EXPORT_SYMBOL(iov_iter_get_pages);
+EXPORT_SYMBOL(iov_iter_get_pages_flags);
 
 static struct page **get_pages_array(size_t n)
 {
@@ -1589,9 +1591,9 @@ static ssize_t iter_xarray_get_pages_alloc(struct iov_iter *i,
 	return actual;
 }
 
-ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
+ssize_t iov_iter_get_pages_alloc_flags(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
-		   size_t *start)
+		   size_t *start, unsigned int gup_flags)
 {
 	struct page **p;
 	size_t len;
@@ -1604,14 +1606,16 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 
 	if (likely(iter_is_iovec(i))) {
 		unsigned long addr;
-
 		addr = first_iovec_segment(i, &len, start, maxsize, ~0U);
 		n = DIV_ROUND_UP(len, PAGE_SIZE);
 		p = get_pages_array(n);
 		if (!p)
 			return -ENOMEM;
-		res = get_user_pages_fast(addr, n,
-				iov_iter_rw(i) != WRITE ?  FOLL_WRITE : 0, p);
+
+		if (iov_iter_rw(i) != WRITE)
+			gup_flags |= FOLL_WRITE;
+
+		res = get_user_pages_fast(addr, n, gup_flags, p);
 		if (unlikely(res < 0)) {
 			kvfree(p);
 			return res;
@@ -1637,7 +1641,7 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 		return iter_xarray_get_pages_alloc(i, pages, maxsize, start);
 	return -EFAULT;
 }
-EXPORT_SYMBOL(iov_iter_get_pages_alloc);
+EXPORT_SYMBOL(iov_iter_get_pages_alloc_flags);
 
 size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 			       struct iov_iter *i)
-- 
2.30.2

