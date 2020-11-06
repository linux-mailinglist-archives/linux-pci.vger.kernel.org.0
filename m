Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E20C2A9A41
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 18:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbgKFRBg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Nov 2020 12:01:36 -0500
Received: from ale.deltatee.com ([204.191.154.188]:57756 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbgKFRBB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Nov 2020 12:01:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7ZcZGtWvTkVsTVUpkhext4YPtK8jbBrBUEsKJaygiKM=; b=E/wOw3kNyO6V3futeClVovyVEi
        0ofnTLpBwpRI12gOy55UDZsn4lgqLbjIrlVDUk5jitjZfiHHi9Uon94ml5xkCw/H9JdFFq0TAR87L
        drBag+pE3zEJ5UoXM0JywhZX7DgNTUweeo3Jp+DZGgj1gj9d3/9MmGQAvfaWLOn0vLUeAtb5X5+Zs
        M+ojMJrWn8vEzJ1QUnE2xRy+wNXpVwIkOukWFon2TazamH6LxZD9rDChqhxdoWuUXPusbmpaDrpyS
        laIGUKQxC+ZCaPc5GDRuDocCPvYNgCrSDMGr9vpm8Sj4MyggVUbqRxnvG4nlrwwCSGtib6yuVDp5S
        DpoLEf9g==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kb56h-0002PX-HK; Fri, 06 Nov 2020 10:01:00 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kb56V-0004tE-5g; Fri, 06 Nov 2020 10:00:47 -0700
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
Date:   Fri,  6 Nov 2020 10:00:30 -0700
Message-Id: <20201106170036.18713-10-logang@deltatee.com>
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
X-Spam-Status: No, score=-8.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE,MYRULES_NO_TEXT autolearn=ham
        autolearn_force=no version=3.4.2
Subject: [RFC PATCH 09/15] nvme-pci: Convert to using dma_map_sg for p2pdma pages
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Switch to using sg_dma_p2pdma_len() in places where sg_dma_len() is
used. Then replace the calls to pci_p2pdma_[un]map_sg() with calls
to dma_[un]map_sg() with DMA_ATTR_P2PDMA.

This should be equivalent, though support will be somewhat less
(only dma-direct and dma-iommu are currently supported).

Using DMA_ATTR_P2PDMA is safe because the block layer restricts
requests to be much less than 2GB, thus there's no way for a
segment to be greater than 2GB.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/host/pci.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ef7ce464a48d..26976bdf4af0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -528,12 +528,8 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 
 	WARN_ON_ONCE(!iod->nents);
 
-	if (is_pci_p2pdma_page(sg_page(iod->sg)))
-		pci_p2pdma_unmap_sg(dev->dev, iod->sg, iod->nents,
-				    rq_dma_dir(req));
-	else
-		dma_unmap_sg(dev->dev, iod->sg, iod->nents, rq_dma_dir(req));
-
+	dma_unmap_sg_attrs(dev->dev, iod->sg, iod->nents, rq_dma_dir(req),
+			   DMA_ATTR_P2PDMA);
 
 	if (iod->npages == 0)
 		dma_pool_free(dev->prp_small_pool, nvme_pci_iod_list(req)[0],
@@ -570,7 +566,7 @@ static void nvme_print_sgl(struct scatterlist *sgl, int nents)
 		pr_warn("sg[%d] phys_addr:%pad offset:%d length:%d "
 			"dma_address:%pad dma_length:%d\n",
 			i, &phys, sg->offset, sg->length, &sg_dma_address(sg),
-			sg_dma_len(sg));
+			sg_dma_p2pdma_len(sg));
 	}
 }
 
@@ -581,7 +577,7 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
 	struct dma_pool *pool;
 	int length = blk_rq_payload_bytes(req);
 	struct scatterlist *sg = iod->sg;
-	int dma_len = sg_dma_len(sg);
+	int dma_len = sg_dma_p2pdma_len(sg);
 	u64 dma_addr = sg_dma_address(sg);
 	int offset = dma_addr & (NVME_CTRL_PAGE_SIZE - 1);
 	__le64 *prp_list;
@@ -601,7 +597,7 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
 	} else {
 		sg = sg_next(sg);
 		dma_addr = sg_dma_address(sg);
-		dma_len = sg_dma_len(sg);
+		dma_len = sg_dma_p2pdma_len(sg);
 	}
 
 	if (length <= NVME_CTRL_PAGE_SIZE) {
@@ -650,7 +646,7 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
 			goto bad_sgl;
 		sg = sg_next(sg);
 		dma_addr = sg_dma_address(sg);
-		dma_len = sg_dma_len(sg);
+		dma_len = sg_dma_p2pdma_len(sg);
 	}
 
 done:
@@ -670,7 +666,7 @@ static void nvme_pci_sgl_set_data(struct nvme_sgl_desc *sge,
 		struct scatterlist *sg)
 {
 	sge->addr = cpu_to_le64(sg_dma_address(sg));
-	sge->length = cpu_to_le32(sg_dma_len(sg));
+	sge->length = cpu_to_le32(sg_dma_p2pdma_len(sg));
 	sge->type = NVME_SGL_FMT_DATA_DESC << 4;
 }
 
@@ -814,14 +810,12 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	if (!iod->nents)
 		goto out;
 
-	if (is_pci_p2pdma_page(sg_page(iod->sg)))
-		nr_mapped = pci_p2pdma_map_sg_attrs(dev->dev, iod->sg,
-				iod->nents, rq_dma_dir(req), DMA_ATTR_NO_WARN);
-	else
-		nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
-					     rq_dma_dir(req), DMA_ATTR_NO_WARN);
-	if (!nr_mapped)
+	nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
+			rq_dma_dir(req), DMA_ATTR_NO_WARN | DMA_ATTR_P2PDMA);
+	if (!nr_mapped) {
+		ret = BLK_STS_IOERR;
 		goto out;
+	}
 
 	iod->use_sgl = nvme_pci_use_sgls(dev, req);
 	if (iod->use_sgl)
-- 
2.20.1

