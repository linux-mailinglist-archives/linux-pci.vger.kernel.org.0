Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281015A15A6
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 17:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242056AbiHYPY5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 11:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241459AbiHYPYo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 11:24:44 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C6EB95B4;
        Thu, 25 Aug 2022 08:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=JQ3qiW538t9ABcApNKq4W32OZxdHmb0EGXdVRgOkT1A=; b=mL1bcL2m3muagTl7k/hmjjD2sd
        WrGCiFwORUktHwhS6nJWPH2C/y3bRvzX6UhnbrEhLzyM3G7AGiNs7WpJfduS4yQ+TtLr3MyMHs5yL
        CWSJb9tMAb1GLhvJnfHKYifj41RK8KGr2qzUpybsOPuSQrV+eVgrLR6i1x2CbEKZtW3TREUfNc84H
        lxZYhh2cVE1+0Ja1vSY+HqqjdBAp/XLEhAVhSdmPse6kUBbQxwXI6q2R3hTK7ZJGQjXp9zHOAijYS
        GSTBGpijJgtCqQWh8U65wMlklqsAnSfTM+W1+Sh/d9x1x5cE8wNn9k8Ry2JK+22T576pcjmcyhi4i
        Epk0iVoQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oREij-0086MA-QV; Thu, 25 Aug 2022 09:24:39 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oREie-0001eY-4B; Thu, 25 Aug 2022 09:24:32 -0600
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
Date:   Thu, 25 Aug 2022 09:24:19 -0600
Message-Id: <20220825152425.6296-3-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220825152425.6296-1-logang@deltatee.com>
References: <20220825152425.6296-1-logang@deltatee.com>
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
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Subject: [PATCH v9 2/8] iov_iter: introduce iov_iter_get_pages_[alloc_]flags()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add iov_iter_get_pages_flags() and iov_iter_get_pages_alloc_flags()
which take a flags argument that is passed to get_user_pages_fast().

This is so that FOLL_PCI_P2PDMA can be passed when appropriate.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 include/linux/uio.h |  6 ++++++
 lib/iov_iter.c      | 40 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 5896af36199c..76ba69edb8c5 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -247,8 +247,14 @@ void iov_iter_pipe(struct iov_iter *i, unsigned int direction, struct pipe_inode
 void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count);
 void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *xarray,
 		     loff_t start, size_t count);
+ssize_t iov_iter_get_pages_flags(struct iov_iter *i, struct page **pages,
+		size_t maxsize, unsigned maxpages, size_t *start,
+		unsigned int gup_flags);
 ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
 			size_t maxsize, unsigned maxpages, size_t *start);
+ssize_t iov_iter_get_pages_alloc_flags(struct iov_iter *i,
+		struct page ***pages, size_t maxsize, size_t *start,
+		unsigned int gup_flags);
 ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i, struct page ***pages,
 			size_t maxsize, size_t *start);
 int iov_iter_npages(const struct iov_iter *i, int maxpages);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 4b7fce72e3e5..dedb78f3c655 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1427,7 +1427,8 @@ static struct page *first_bvec_segment(const struct iov_iter *i,
 
 static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
-		   unsigned int maxpages, size_t *start)
+		   unsigned int maxpages, size_t *start,
+		   unsigned int gup_flags)
 {
 	unsigned int n;
 
@@ -1439,7 +1440,6 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		maxsize = MAX_RW_COUNT;
 
 	if (likely(user_backed_iter(i))) {
-		unsigned int gup_flags = 0;
 		unsigned long addr;
 		int res;
 
@@ -1497,10 +1497,24 @@ ssize_t iov_iter_get_pages2(struct iov_iter *i,
 		return 0;
 	BUG_ON(!pages);
 
-	return __iov_iter_get_pages_alloc(i, &pages, maxsize, maxpages, start);
+	return __iov_iter_get_pages_alloc(i, &pages, maxsize, maxpages,
+					  start, 0);
 }
 EXPORT_SYMBOL(iov_iter_get_pages2);
 
+ssize_t iov_iter_get_pages_flags(struct iov_iter *i, struct page **pages,
+		size_t maxsize, unsigned maxpages, size_t *start,
+		unsigned int gup_flags)
+{
+	if (!maxpages)
+		return 0;
+	BUG_ON(!pages);
+
+	return __iov_iter_get_pages_alloc(i, &pages, maxsize, maxpages,
+					  start, gup_flags);
+}
+EXPORT_SYMBOL_GPL(iov_iter_get_pages_flags);
+
 ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
 		   size_t *start)
@@ -1509,7 +1523,7 @@ ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i,
 
 	*pages = NULL;
 
-	len = __iov_iter_get_pages_alloc(i, pages, maxsize, ~0U, start);
+	len = __iov_iter_get_pages_alloc(i, pages, maxsize, ~0U, start, 0);
 	if (len <= 0) {
 		kvfree(*pages);
 		*pages = NULL;
@@ -1518,6 +1532,24 @@ ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i,
 }
 EXPORT_SYMBOL(iov_iter_get_pages_alloc2);
 
+ssize_t iov_iter_get_pages_alloc_flags(struct iov_iter *i,
+		struct page ***pages, size_t maxsize,
+		size_t *start, unsigned int gup_flags)
+{
+	ssize_t len;
+
+	*pages = NULL;
+
+	len = __iov_iter_get_pages_alloc(i, pages, maxsize, ~0U, start,
+					 gup_flags);
+	if (len <= 0) {
+		kvfree(*pages);
+		*pages = NULL;
+	}
+	return len;
+}
+EXPORT_SYMBOL_GPL(iov_iter_get_pages_alloc_flags);
+
 size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 			       struct iov_iter *i)
 {
-- 
2.30.2

