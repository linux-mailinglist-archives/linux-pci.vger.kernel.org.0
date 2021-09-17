Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B1140EDF7
	for <lists+linux-pci@lfdr.de>; Fri, 17 Sep 2021 01:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241792AbhIPXmk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Sep 2021 19:42:40 -0400
Received: from ale.deltatee.com ([204.191.154.188]:40650 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241589AbhIPXmf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Sep 2021 19:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=UZWdSRypms7IYS+cRNewb5j8DUKgue0ixiEYd+ytkK0=; b=dI2wFqH8itmU9Tb2ks13oW9X74
        svf6rjiYbYDxHBosN1+8ljTsntt82C0W1U5Cgg4/t4ktnpOhVBukqvw9QbsacRFM0ACfLyevXpOPs
        H9kCyu7DUbkTBSoPvsxGJFeQ+89ib7rLeymZ8i71ou2lsH8c0GchHPEMQA2UHIkeCUmD/Tz6LWP5O
        i9ciwsDTh4QRDAE9a5uvYvPcFjkgLhn8XMILmCaeLBQ4bkb9Z93KeRZTN/fEZsxefmbf8kGtweSHj
        v15/uDCUTRDwjieYZBzOwyGJcUkhrsa1/meVzmj1xeK0nJ44LWqEKQRM2wmZ5In9GopkB4Uw/al1m
        43LnBXQQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1mR10C-0008I1-QS; Thu, 16 Sep 2021 17:41:13 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1mR105-000VrS-BF; Thu, 16 Sep 2021 17:41:05 -0600
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
Date:   Thu, 16 Sep 2021 17:40:52 -0600
Message-Id: <20210916234100.122368-13-logang@deltatee.com>
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
Subject: [PATCH v3 12/20] RDMA/rw: use dma_map_sgtable()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

dma_map_sg() now supports the use of P2PDMA pages so pci_p2pdma_map_sg()
is no longer necessary and may be dropped.

Switch to the dma_map_sgtable() interface which will allow for better
error reporting if the P2PDMA pages are unsupported.

The change to sgtable also appears to fix a couple subtle error path
bugs:

  - In rdma_rw_ctx_init(), dma_unmap would be called with an sg
    that could have been incremented from the original call, as
    well as an nents that was not the original number of nents
    called when mapped.
  - Similarly in rdma_rw_ctx_signature_init, both sg and prot_sg
    were unmapped with the incorrect number of nents.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/infiniband/core/rw.c | 75 +++++++++++++++---------------------
 include/rdma/ib_verbs.h      | 19 +++++++++
 2 files changed, 51 insertions(+), 43 deletions(-)

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index 5221cce65675..1bdb56380764 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -273,26 +273,6 @@ static int rdma_rw_init_single_wr(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
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
-static int rdma_rw_map_sg(struct ib_device *dev, struct scatterlist *sg,
-			  u32 sg_cnt, enum dma_data_direction dir)
-{
-	if (is_pci_p2pdma_page(sg_page(sg))) {
-		if (WARN_ON_ONCE(ib_uses_virt_dma(dev)))
-			return 0;
-		return pci_p2pdma_map_sg(dev->dma_device, sg, sg_cnt, dir);
-	}
-	return ib_dma_map_sg(dev, sg, sg_cnt, dir);
-}
-
 /**
  * rdma_rw_ctx_init - initialize a RDMA READ/WRITE context
  * @ctx:	context to initialize
@@ -313,12 +293,16 @@ int rdma_rw_ctx_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp, u32 port_num,
 		u64 remote_addr, u32 rkey, enum dma_data_direction dir)
 {
 	struct ib_device *dev = qp->pd->device;
+	struct sg_table sgt = {
+		.sgl = sg,
+		.orig_nents = sg_cnt,
+	};
 	int ret;
 
-	ret = rdma_rw_map_sg(dev, sg, sg_cnt, dir);
-	if (!ret)
-		return -ENOMEM;
-	sg_cnt = ret;
+	ret = ib_dma_map_sgtable(dev, &sgt, dir, 0);
+	if (ret)
+		return ret;
+	sg_cnt = sgt.nents;
 
 	/*
 	 * Skip to the S/G entry that sg_offset falls into:
@@ -354,7 +338,7 @@ int rdma_rw_ctx_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp, u32 port_num,
 	return ret;
 
 out_unmap_sg:
-	rdma_rw_unmap_sg(dev, sg, sg_cnt, dir);
+	ib_dma_unmap_sgtable(dev, &sgt, dir, 0);
 	return ret;
 }
 EXPORT_SYMBOL(rdma_rw_ctx_init);
@@ -387,6 +371,14 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 						    qp->integrity_en);
 	struct ib_rdma_wr *rdma_wr;
 	int count = 0, ret;
+	struct sg_table sgt = {
+		.sgl = sg,
+		.orig_nents = sg_cnt,
+	};
+	struct sg_table prot_sgt = {
+		.sgl = prot_sg,
+		.orig_nents = prot_sg_cnt,
+	};
 
 	if (sg_cnt > pages_per_mr || prot_sg_cnt > pages_per_mr) {
 		pr_err("SG count too large: sg_cnt=%u, prot_sg_cnt=%u, pages_per_mr=%u\n",
@@ -394,18 +386,14 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 		return -EINVAL;
 	}
 
-	ret = rdma_rw_map_sg(dev, sg, sg_cnt, dir);
-	if (!ret)
-		return -ENOMEM;
-	sg_cnt = ret;
+	ret = ib_dma_map_sgtable(dev, &sgt, dir, 0);
+	if (ret)
+		return ret;
 
 	if (prot_sg_cnt) {
-		ret = rdma_rw_map_sg(dev, prot_sg, prot_sg_cnt, dir);
-		if (!ret) {
-			ret = -ENOMEM;
+		ret = ib_dma_map_sgtable(dev, &prot_sgt, dir, 0);
+		if (ret)
 			goto out_unmap_sg;
-		}
-		prot_sg_cnt = ret;
 	}
 
 	ctx->type = RDMA_RW_SIG_MR;
@@ -426,10 +414,11 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 
 	memcpy(ctx->reg->mr->sig_attrs, sig_attrs, sizeof(struct ib_sig_attrs));
 
-	ret = ib_map_mr_sg_pi(ctx->reg->mr, sg, sg_cnt, NULL, prot_sg,
-			      prot_sg_cnt, NULL, SZ_4K);
+	ret = ib_map_mr_sg_pi(ctx->reg->mr, sg, sgt.nents, NULL, prot_sg,
+			      prot_sgt.nents, NULL, SZ_4K);
 	if (unlikely(ret)) {
-		pr_err("failed to map PI sg (%u)\n", sg_cnt + prot_sg_cnt);
+		pr_err("failed to map PI sg (%u)\n",
+		       sgt.nents + prot_sgt.nents);
 		goto out_destroy_sig_mr;
 	}
 
@@ -468,10 +457,10 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 out_free_ctx:
 	kfree(ctx->reg);
 out_unmap_prot_sg:
-	if (prot_sg_cnt)
-		rdma_rw_unmap_sg(dev, prot_sg, prot_sg_cnt, dir);
+	if (prot_sgt.nents)
+		ib_dma_unmap_sgtable(dev, &prot_sgt, dir, 0);
 out_unmap_sg:
-	rdma_rw_unmap_sg(dev, sg, sg_cnt, dir);
+	ib_dma_unmap_sgtable(dev, &sgt, dir, 0);
 	return ret;
 }
 EXPORT_SYMBOL(rdma_rw_ctx_signature_init);
@@ -604,7 +593,7 @@ void rdma_rw_ctx_destroy(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 		break;
 	}
 
-	rdma_rw_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
+	ib_dma_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
 }
 EXPORT_SYMBOL(rdma_rw_ctx_destroy);
 
@@ -632,8 +621,8 @@ void rdma_rw_ctx_destroy_signature(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 	kfree(ctx->reg);
 
 	if (prot_sg_cnt)
-		rdma_rw_unmap_sg(qp->pd->device, prot_sg, prot_sg_cnt, dir);
-	rdma_rw_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
+		ib_dma_unmap_sg(qp->pd->device, prot_sg, prot_sg_cnt, dir);
+	ib_dma_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
 }
 EXPORT_SYMBOL(rdma_rw_ctx_destroy_signature);
 
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 2b71c9ca2186..d04f07ab4d1a 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4096,6 +4096,25 @@ static inline void ib_dma_unmap_sg_attrs(struct ib_device *dev,
 				   dma_attrs);
 }
 
+static inline int ib_dma_map_sgtable(struct ib_device *dev,
+				     struct sg_table *sgt,
+				     enum dma_data_direction direction,
+				     unsigned long dma_attrs)
+{
+	if (ib_uses_virt_dma(dev))
+		return ib_dma_virt_map_sg(dev, sgt->sgl, sgt->orig_nents);
+	return dma_map_sgtable(dev->dma_device, sgt, direction, dma_attrs);
+}
+
+static inline void ib_dma_unmap_sgtable(struct ib_device *dev,
+					struct sg_table *sgt,
+					enum dma_data_direction direction,
+					unsigned long dma_attrs)
+{
+	if (!ib_uses_virt_dma(dev))
+		dma_unmap_sgtable(dev->dma_device, sgt, direction, dma_attrs);
+}
+
 /**
  * ib_dma_map_sgtable_attrs - Map a scatter/gather table to DMA addresses
  * @dev: The device for which the DMA addresses are to be created
-- 
2.30.2

