Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09B6607DAE
	for <lists+linux-pci@lfdr.de>; Fri, 21 Oct 2022 19:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiJURlb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Oct 2022 13:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJURl3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Oct 2022 13:41:29 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C3943E47;
        Fri, 21 Oct 2022 10:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=89QTElwZFXRfggrOmp22BVYbNApHwJCc7/AtxsSaqyQ=; b=DUFJL4ob6bvKEwDSE4GWtIirYS
        X97GxPsQU/8gpPukGv4stsVhpCVMpaZfqfjtZunkmVXWQISTg/R/BOcVA3pa7CZfACS0bNB43mpI+
        c4OTnsrV1MciXZB4TbndO5a7ikBN/fz/wDgukCPrwSjCFtZ9ZyqxXcPgPcEnqgfdFeSTZyfCOy53l
        RxY+GZLkNNPiCm5OAKU8w+xesdg2eMT/Wb02k7Pdlz/yKsq/T6ahDZumCPpUSmcZ/3oCl/3HEMwwC
        cKWDtI+6VVeKGW1kms9Qbz0IR8J14E2KIWUlJDjVvyMCgYEjQLZ/KBKnSkVH95V20TixmWMKF5dVk
        bcv8KLUw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1olw1K-00DoI1-5N; Fri, 21 Oct 2022 11:41:23 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1olw1G-0001tO-8W; Fri, 21 Oct 2022 11:41:18 -0600
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
Date:   Fri, 21 Oct 2022 11:41:14 -0600
Message-Id: <20221021174116.7200-8-logang@deltatee.com>
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
Subject: [PATCH v11 7/9] block: set FOLL_PCI_P2PDMA in bio_map_user_iov()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When a bio's queue supports PCI P2PDMA, set FOLL_PCI_P2PDMA for
iov_iter_get_pages_flags(). This allows PCI P2PDMA pages to be
passed from userspace and enables the NVMe passthru requests to
use P2PDMA pages.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
---
 block/blk-map.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 34735626b00f..8750f82d7da4 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -267,6 +267,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 {
 	unsigned int max_sectors = queue_max_hw_sectors(rq->q);
 	unsigned int nr_vecs = iov_iter_npages(iter, BIO_MAX_VECS);
+	unsigned int gup_flags = 0;
 	struct bio *bio;
 	int ret;
 	int j;
@@ -278,6 +279,9 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 	if (bio == NULL)
 		return -ENOMEM;
 
+	if (blk_queue_pci_p2pdma(rq->q))
+		gup_flags |= FOLL_PCI_P2PDMA;
+
 	while (iov_iter_count(iter)) {
 		struct page **pages, *stack_pages[UIO_FASTIOV];
 		ssize_t bytes;
@@ -286,11 +290,11 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 
 		if (nr_vecs <= ARRAY_SIZE(stack_pages)) {
 			pages = stack_pages;
-			bytes = iov_iter_get_pages2(iter, pages, LONG_MAX,
-							nr_vecs, &offs);
+			bytes = iov_iter_get_pages(iter, pages, LONG_MAX,
+						   nr_vecs, &offs, gup_flags);
 		} else {
-			bytes = iov_iter_get_pages_alloc2(iter, &pages,
-							LONG_MAX, &offs);
+			bytes = iov_iter_get_pages_alloc(iter, &pages,
+						LONG_MAX, &offs, gup_flags);
 		}
 		if (unlikely(bytes <= 0)) {
 			ret = bytes ? bytes : -EFAULT;
-- 
2.30.2

