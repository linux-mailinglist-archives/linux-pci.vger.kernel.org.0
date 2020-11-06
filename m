Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA552A9A21
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 18:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgKFRAx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Nov 2020 12:00:53 -0500
Received: from ale.deltatee.com ([204.191.154.188]:57604 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgKFRAx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Nov 2020 12:00:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zgGEpEC881xygcChLUzP5MM+TPIgCL+RooeJy/MEFvk=; b=soNcve2wKJLNlkdIcwhFKrP00x
        UXFJJhudsSkX2SoBn5CzMojAj0uyR2/WZqlCmQ/roDA/tjn6xVSzQu+640oHm0jxA9uJO+KPDZB2G
        Oq2rKjg3PcmQ6QJuv02gmSnlDR6+W0FJ6I7CDF1vKR8DUcOpumtVWqKYU3Q/xYP3DNgg/KR7V8uUp
        Sjtqu2gdb19JzmLSGzPhptvO846Ick13R0oTl58IwEn9Oipv/GhF9Np9hw63jsKDkQlT4dpJYLiPQ
        3KZ01uvW3ys592KHNx+H/xFfQw/zHmxKjSRmJL0sZrzTcbmwZJDE7aGagChRGvl6uO9r0hehlSsVR
        mhF6EdYw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kb56Z-0002Pa-5l; Fri, 06 Nov 2020 10:00:52 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kb56U-0004sz-Hw; Fri, 06 Nov 2020 10:00:46 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Ira Weiny <iweiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Fri,  6 Nov 2020 10:00:25 -0700
Message-Id: <20201106170036.18713-5-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201106170036.18713-1-logang@deltatee.com>
References: <20201106170036.18713-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, jgg@ziepe.ca, christian.koenig@amd.com, dan.j.williams@intel.com, iweiny@intel.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [RFC PATCH 04/15] lib/scatterlist: Add flag for indicating P2PDMA segments in an SGL
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We make use of the top bit of the dma_length to indicate a P2PDMA
segment. Code that uses this will need to use sg_dma_p2pdma_len() to
get the length and ensure no lengths exceed 2GB.

An sg_dma_is_p2pdma() helper is included to check if a particular
segment is p2pdma().

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 include/linux/scatterlist.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 36c47e7e66a2..e738159d56f9 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -39,6 +39,10 @@ struct scatterlist {
 #define sg_dma_len(sg)		((sg)->length)
 #endif
 
+#define SG_P2PDMA_FLAG	(1U << 31)
+#define sg_dma_p2pdma_len(sg)	(sg_dma_len(sg) & ~SG_P2PDMA_FLAG)
+#define sg_dma_is_p2pdma(sg)	(sg_dma_len(sg) & SG_P2PDMA_FLAG)
+
 struct sg_table {
 	struct scatterlist *sgl;	/* the list */
 	unsigned int nents;		/* number of mapped entries */
-- 
2.20.1

