Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECC65E689D
	for <lists+linux-pci@lfdr.de>; Thu, 22 Sep 2022 18:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbiIVQjs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Sep 2022 12:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiIVQjo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2022 12:39:44 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AC04C634;
        Thu, 22 Sep 2022 09:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=5j6xtapvwUdhGQNeqeFIKOu/eta4czgVaM1iHN6JS40=; b=j0vqgm/DwRC8SWD3vRC35kKrKn
        uvfa2jRx/R29IzSGfeppQ2WS0arvUBbIfqu5Mbzep3uO08icfhEwzYXuMcyZJ6a9MbcDWKyM9ONge
        KnhFVA3Erg/CMa9dY3fHmXaXT40ijCcVrA0FGTQ7gskqRHdBGdOkAguEuSrZ/gCkRYOdHMFS6BCHp
        C82hZtdx5yNbWQnnYvFDBUS0FT9AN1oMnLoTYzUabH8HebiHHmkWw1VrhX46zKsdKwC69CfclGnG3
        QwnTjPgVlg810r2MiXFKgPMZjvKoAtA1kHUc/ELqK/faE/mQAd4mZVFap16DC6VLzpevIorfii6eJ
        /1/Jr2rg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1obPEf-00862e-HK; Thu, 22 Sep 2022 10:39:38 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1obPEb-0001rs-As; Thu, 22 Sep 2022 10:39:33 -0600
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
Date:   Thu, 22 Sep 2022 10:39:22 -0600
Message-Id: <20220922163926.7077-5-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220922163926.7077-1-logang@deltatee.com>
References: <20220922163926.7077-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, hch@lst.de, gregkh@linuxfoundation.org, jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, jhubbard@nvidia.com, rcampbell@nvidia.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v10 4/8] lib/scatterlist: add check when merging zone device pages
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Consecutive zone device pages should not be merged into the same sgl
or bvec segment with other types of pages or if they belong to different
pgmaps. Otherwise getting the pgmap of a given segment is not possible
without scanning the entire segment. This helper returns true either if
both pages are not zone device pages or both pages are zone device
pages with the same pgmap.

Factor out the check for page mergability into a pages_are_mergable()
helper and add a check with zone_device_pages_are_mergeable().

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 lib/scatterlist.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index c8c3d675845c..a0ad2a7959b5 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -410,6 +410,15 @@ static struct scatterlist *get_next_sg(struct sg_append_table *table,
 	return new_sg;
 }
 
+static bool pages_are_mergeable(struct page *a, struct page *b)
+{
+	if (page_to_pfn(a) != page_to_pfn(b) + 1)
+		return false;
+	if (!zone_device_pages_have_same_pgmap(a, b))
+		return false;
+	return true;
+}
+
 /**
  * sg_alloc_append_table_from_pages - Allocate and initialize an append sg
  *                                    table from an array of pages
@@ -447,6 +456,7 @@ int sg_alloc_append_table_from_pages(struct sg_append_table *sgt_append,
 	unsigned int chunks, cur_page, seg_len, i, prv_len = 0;
 	unsigned int added_nents = 0;
 	struct scatterlist *s = sgt_append->prv;
+	struct page *last_pg;
 
 	/*
 	 * The algorithm below requires max_segment to be aligned to PAGE_SIZE
@@ -460,21 +470,17 @@ int sg_alloc_append_table_from_pages(struct sg_append_table *sgt_append,
 		return -EOPNOTSUPP;
 
 	if (sgt_append->prv) {
-		unsigned long paddr =
-			(page_to_pfn(sg_page(sgt_append->prv)) * PAGE_SIZE +
-			 sgt_append->prv->offset + sgt_append->prv->length) /
-			PAGE_SIZE;
-
 		if (WARN_ON(offset))
 			return -EINVAL;
 
 		/* Merge contiguous pages into the last SG */
 		prv_len = sgt_append->prv->length;
-		while (n_pages && page_to_pfn(pages[0]) == paddr) {
+		last_pg = sg_page(sgt_append->prv);
+		while (n_pages && pages_are_mergeable(last_pg, pages[0])) {
 			if (sgt_append->prv->length + PAGE_SIZE > max_segment)
 				break;
 			sgt_append->prv->length += PAGE_SIZE;
-			paddr++;
+			last_pg = pages[0];
 			pages++;
 			n_pages--;
 		}
@@ -488,7 +494,7 @@ int sg_alloc_append_table_from_pages(struct sg_append_table *sgt_append,
 	for (i = 1; i < n_pages; i++) {
 		seg_len += PAGE_SIZE;
 		if (seg_len >= max_segment ||
-		    page_to_pfn(pages[i]) != page_to_pfn(pages[i - 1]) + 1) {
+		    !pages_are_mergeable(pages[i], pages[i - 1])) {
 			chunks++;
 			seg_len = 0;
 		}
@@ -504,8 +510,7 @@ int sg_alloc_append_table_from_pages(struct sg_append_table *sgt_append,
 		for (j = cur_page + 1; j < n_pages; j++) {
 			seg_len += PAGE_SIZE;
 			if (seg_len >= max_segment ||
-			    page_to_pfn(pages[j]) !=
-			    page_to_pfn(pages[j - 1]) + 1)
+			    !pages_are_mergeable(pages[j], pages[j - 1]))
 				break;
 		}
 
-- 
2.30.2

