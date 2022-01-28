Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B12E49EF3C
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jan 2022 01:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344534AbiA1A03 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jan 2022 19:26:29 -0500
Received: from ale.deltatee.com ([204.191.154.188]:46994 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236017AbiA1A00 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Jan 2022 19:26:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=aCaIC1aGEU3aE4W87JAzdHtyIfK4Tw21zQ04iz9J0qw=; b=Z69R0PP15szxfRgF3lQdDjdoCU
        wo/mXI4lYi8n/BvLZ9xCK6yUFuAwlswjoRaY/u6opnOYHIK/Gx7JB2KPTj2h0TXcG3h5PRViuSnc/
        5j2UmCO1qqgon+0L5+MSOS7FHf0YXhTl3m1hb68GLJ52n1SG/G7AlNuIqfINyLJbCyQsJ8n5o3Mn8
        0s+EKnXr6vLLVTG3bmSE7BwIhTELu+o1NYDb7m/nmgMUPMIF3uuM6tH3PiDhzrzshKt5jlQhCA96N
        rbA+x2+ZPskhkkYf59tRpEHy8nr8UvTeXF5fapebJ/4AWBYv/BmBwrRARsMHxDbEozilNtK5aYCh5
        pEHFhSCg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nDF5r-005Oca-Ri; Thu, 27 Jan 2022 17:26:25 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nDF5p-0001dL-Jc; Thu, 27 Jan 2022 17:26:21 -0700
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
        Ralph Campbell <rcampbell@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 27 Jan 2022 17:26:10 -0700
Message-Id: <20220128002614.6136-21-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220128002614.6136-1-logang@deltatee.com>
References: <20220128002614.6136-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, jhubbard@nvidia.com, rcampbell@nvidia.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_NO_TEXT autolearn=no autolearn_force=no version=3.4.6
Subject: [PATCH v5 20/24] block: set FOLL_PCI_P2PDMA in __bio_iov_iter_get_pages()
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
 block/bio.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 055fcf159461..cb19689cf9fe 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1121,6 +1121,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
 	struct page **pages = (struct page **)bv;
 	bool same_page = false;
+	unsigned int flags = 0;
 	ssize_t size, left;
 	unsigned len, i;
 	size_t offset;
@@ -1133,7 +1134,12 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
 	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
 
-	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
+	if (bio->bi_bdev && bio->bi_bdev->bd_disk &&
+	    blk_queue_pci_p2pdma(bio->bi_bdev->bd_disk->queue))
+		flags |= FOLL_PCI_P2PDMA;
+
+	size = iov_iter_get_pages_flags(iter, pages, LONG_MAX, nr_pages,
+					&offset, flags);
 	if (unlikely(size <= 0))
 		return size ? size : -EFAULT;
 
-- 
2.30.2

