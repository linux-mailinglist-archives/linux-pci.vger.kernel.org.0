Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8A95A1591
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 17:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241937AbiHYPY4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 11:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241502AbiHYPYo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 11:24:44 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5296BB99DF;
        Thu, 25 Aug 2022 08:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=mLYWjwjaacuhTQSD3LMzZRV3Gg44uzd/+90ZlUZOo0E=; b=JlA02I9mYM/1XyzPhpPhzA8jen
        fB0btV3snf/z9KW6dTxn6u/abas7864PAvz+ynWXFzPL1rlGI2s0oRw7UP5yTir5n890MUigIrDsk
        zA3uu2g8QdinM4+B36OB6W5BEPoH1yqALmoP39OJfN4rqGUrjdfTbLcsqUme4Z8t54ow3fe5lfC/c
        Fl9hCoKvjhE1chLSEIBX9qOh/De48gdBzb/HewRblhZ8sJd79WaorHbd18g64W02PKJcBAlkL+Lii
        02q17F11RI0GEWM8Baan/tqBiUlho3AxoVa7WA6H4kQJXp8aOTGBtLmwjDzjftTk2ncaWEi5g6yYK
        Qt6fGg3Q==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oREim-0086MB-Bp; Thu, 25 Aug 2022 09:24:41 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oREie-0001ei-J0; Thu, 25 Aug 2022 09:24:32 -0600
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
Date:   Thu, 25 Aug 2022 09:24:22 -0600
Message-Id: <20220825152425.6296-6-logang@deltatee.com>
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
Subject: [PATCH v9 5/8] block: set FOLL_PCI_P2PDMA in __bio_iov_iter_get_pages()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When a bio's queue supports PCI P2PDMA, set FOLL_PCI_P2PDMA for
iov_iter_get_pages_flags(). This allows PCI P2PDMA pages to be passed
from userspace and enables the O_DIRECT path in iomap based filesystems
and direct to block devices.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 block/bio.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 969607bc1f4d..ca09d79a0683 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1200,6 +1200,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
 	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
 	struct page **pages = (struct page **)bv;
+	unsigned int flags = 0;
 	ssize_t size, left;
 	unsigned len, i = 0;
 	size_t offset, trim;
@@ -1213,6 +1214,10 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
 	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
 
+	if (bio->bi_bdev && bio->bi_bdev->bd_disk &&
+	    blk_queue_pci_p2pdma(bio->bi_bdev->bd_disk->queue))
+		flags |= FOLL_PCI_P2PDMA;
+
 	/*
 	 * Each segment in the iov is required to be a block size multiple.
 	 * However, we may not be able to get the entire segment if it spans
@@ -1220,8 +1225,9 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	 * result to ensure the bio's total size is correct. The remainder of
 	 * the iov data will be picked up in the next bio iteration.
 	 */
-	size = iov_iter_get_pages2(iter, pages, UINT_MAX - bio->bi_iter.bi_size,
-				  nr_pages, &offset);
+	size = iov_iter_get_pages_flags(iter, pages,
+					UINT_MAX - bio->bi_iter.bi_size,
+					nr_pages, &offset, flags);
 	if (unlikely(size <= 0))
 		return size ? size : -EFAULT;
 
-- 
2.30.2

