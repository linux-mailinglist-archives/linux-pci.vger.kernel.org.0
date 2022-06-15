Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9BA54CDFF
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jun 2022 18:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349187AbiFOQM7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 12:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244662AbiFOQMx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 12:12:53 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7C32253E;
        Wed, 15 Jun 2022 09:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=UO35KE8YVx2v+yNTFMhmKCQE8ptUbM1lG6ODy8MFD4U=; b=TsE9W15o3EM/nOeQHIurouy/XA
        2Y3+/BjdySgEMcfs9J9Xr3aFaFURXmsv3E6ylJDixGSN9s7g2SYY6k8/grdKUKTBmAaXttKXHKYId
        8Tb8qzTHtupqDS54U8Ua402SNJp9CGGyjD4uUAGFAN4fPKqrYTUUiS57TgSmpYDH1NktW0RN014IT
        1aacZVnPSkai9pTda7rEsqYo57R6/USD4Uj1WtQp3fMnHUD6mrnWJjmK6OMB8WlszyclZBg/9qMB0
        U/N8B4+j8XWxbDNGEOQzbKXjwS85TBLNUeTFC5Ec5ZIE0ZIWESQ/C1jGVncnz+JbORAazZSyWmpZa
        xZImoPPw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o1VdP-0084iQ-Un; Wed, 15 Jun 2022 10:12:49 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o1VdJ-0004ao-5d; Wed, 15 Jun 2022 10:12:41 -0600
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
Date:   Wed, 15 Jun 2022 10:12:29 -0600
Message-Id: <20220615161233.17527-18-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220615161233.17527-1-logang@deltatee.com>
References: <20220615161233.17527-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, jhubbard@nvidia.com, rcampbell@nvidia.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v7 17/21] lib/scatterlist: add check when merging zone device pages
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
---
 lib/scatterlist.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index d5e82e4a57ad..af53a0984f76 100644
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

