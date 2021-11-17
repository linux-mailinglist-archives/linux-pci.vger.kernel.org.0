Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9F8454FD5
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 22:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241053AbhKQV5p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Nov 2021 16:57:45 -0500
Received: from ale.deltatee.com ([204.191.154.188]:58828 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240862AbhKQV50 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Nov 2021 16:57:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=l3AgzlVFISW/9ucMB3Q/AoBaOHeVal7cwU+QcbWrG+0=; b=q2Sk3ZcSlHvAbqaoJA3AELfakD
        2Ac+6J6kLxSdN+Oo7DwpMsRbK+J2ApxaONZAaovShI2VQjkWR9wLfOLHldHDYuDogNqkc2l2u4JIS
        HHW/jBkKtHPpAH4YtE577kqqLYnXuAkdH8sYYSUFfS/MTrQVxpK8Bzd4kgWJ/vMNmQi89GfuwwFH3
        jmFMxWlSBPhHG2Orw4mRzclvpH0Kwxr/F7oC+UWYPn9bjdhcbopuXkc1zcwimQPGLxqrsBUWyZTOG
        dQEC4Op01CNpDuYId4mA6OmetXCW/JeDa+SC0NRsD+ETiiXJSIZJCI8bMo8HbC+xTzfruseheDoR/
        kQfrkUrQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1mnSsp-000Zo6-BK; Wed, 17 Nov 2021 14:54:24 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1mnSsk-0000zU-02; Wed, 17 Nov 2021 14:54:18 -0700
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
        Logan Gunthorpe <logang@deltatee.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Date:   Wed, 17 Nov 2021 14:54:00 -0700
Message-Id: <20211117215410.3695-14-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211117215410.3695-1-logang@deltatee.com>
References: <20211117215410.3695-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, logang@deltatee.com, jhubbard@nvidia.com, jgg@nvidia.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_FREE,MYRULES_NO_TEXT autolearn=no autolearn_force=no
        version=3.4.6
Subject: [PATCH v4 13/23] RDMA/rw: drop pci_p2pdma_[un]map_sg()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

dma_map_sg() now supports the use of P2PDMA pages so pci_p2pdma_map_sg()
is no longer necessary and may be dropped. This means the
rdma_rw_[un]map_sg() helpers are no longer necessary. Remove it all.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/rw.c | 45 ++++++++----------------------------
 1 file changed, 9 insertions(+), 36 deletions(-)

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index 5a3bd41b331c..d4517b68d1ca 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -273,33 +273,6 @@ static int rdma_rw_init_single_wr(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 	return 1;
 }
 
-static void rdma_rw_unmap_sg(struct ib_device *dev, struct scatterlist *sg,
-			     u32 sg_cnt, enum dma_data_direction dir)
-{
-	if (is_pci_p2pdma_page(sg_page(sg)))
-		pci_p2pdma_unmap_sg(dev->dma_device, sg, sg_cnt, dir);
-	else
-		ib_dma_unmap_sg(dev, sg, sg_cnt, dir);
-}
-
-static int rdma_rw_map_sgtable(struct ib_device *dev, struct sg_table *sgt,
-			       enum dma_data_direction dir)
-{
-	int nents;
-
-	if (is_pci_p2pdma_page(sg_page(sgt->sgl))) {
-		if (WARN_ON_ONCE(ib_uses_virt_dma(dev)))
-			return 0;
-		nents = pci_p2pdma_map_sg(dev->dma_device, sgt->sgl,
-					  sgt->orig_nents, dir);
-		if (!nents)
-			return -EIO;
-		sgt->nents = nents;
-		return 0;
-	}
-	return ib_dma_map_sgtable_attrs(dev, sgt, dir, 0);
-}
-
 /**
  * rdma_rw_ctx_init - initialize a RDMA READ/WRITE context
  * @ctx:	context to initialize
@@ -326,7 +299,7 @@ int rdma_rw_ctx_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp, u32 port_num,
 	};
 	int ret;
 
-	ret = rdma_rw_map_sgtable(dev, &sgt, dir);
+	ret = ib_dma_map_sgtable_attrs(dev, &sgt, dir, 0);
 	if (ret)
 		return ret;
 	sg_cnt = sgt.nents;
@@ -365,7 +338,7 @@ int rdma_rw_ctx_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp, u32 port_num,
 	return ret;
 
 out_unmap_sg:
-	rdma_rw_unmap_sg(dev, sgt.sgl, sgt.orig_nents, dir);
+	ib_dma_unmap_sgtable_attrs(dev, &sgt, dir, 0);
 	return ret;
 }
 EXPORT_SYMBOL(rdma_rw_ctx_init);
@@ -413,12 +386,12 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 		return -EINVAL;
 	}
 
-	ret = rdma_rw_map_sgtable(dev, &sgt, dir);
+	ret = ib_dma_map_sgtable_attrs(dev, &sgt, dir, 0);
 	if (ret)
 		return ret;
 
 	if (prot_sg_cnt) {
-		ret = rdma_rw_map_sgtable(dev, &prot_sgt, dir);
+		ret = ib_dma_map_sgtable_attrs(dev, &prot_sgt, dir, 0);
 		if (ret)
 			goto out_unmap_sg;
 	}
@@ -485,9 +458,9 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 	kfree(ctx->reg);
 out_unmap_prot_sg:
 	if (prot_sgt.nents)
-		rdma_rw_unmap_sg(dev, prot_sgt.sgl, prot_sgt.orig_nents, dir);
+		ib_dma_unmap_sgtable_attrs(dev, &prot_sgt, dir, 0);
 out_unmap_sg:
-	rdma_rw_unmap_sg(dev, sgt.sgl, sgt.orig_nents, dir);
+	ib_dma_unmap_sgtable_attrs(dev, &sgt, dir, 0);
 	return ret;
 }
 EXPORT_SYMBOL(rdma_rw_ctx_signature_init);
@@ -620,7 +593,7 @@ void rdma_rw_ctx_destroy(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 		break;
 	}
 
-	rdma_rw_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
+	ib_dma_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
 }
 EXPORT_SYMBOL(rdma_rw_ctx_destroy);
 
@@ -648,8 +621,8 @@ void rdma_rw_ctx_destroy_signature(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 	kfree(ctx->reg);
 
 	if (prot_sg_cnt)
-		rdma_rw_unmap_sg(qp->pd->device, prot_sg, prot_sg_cnt, dir);
-	rdma_rw_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
+		ib_dma_unmap_sg(qp->pd->device, prot_sg, prot_sg_cnt, dir);
+	ib_dma_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
 }
 EXPORT_SYMBOL(rdma_rw_ctx_destroy_signature);
 
-- 
2.30.2

