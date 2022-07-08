Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5793256C0CC
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jul 2022 20:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239311AbiGHQvU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jul 2022 12:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239166AbiGHQvR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2022 12:51:17 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7131735AD;
        Fri,  8 Jul 2022 09:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=p1Q1VXg+Jy1H75sqLZVkb8A4672Zu2mqnpu6BoFgGwc=; b=fBfGbE/HSPbwP+biWkFZdZz+Lz
        GDbB9EAu/xgE3ZrMl4+NiYj/+yEiq1Rz0av7K19oYhg5BHqXUaV7xg3qVhoVE4KexWBmEKPwXz5i1
        KhHDBRgHCNl9T3X5gnKVn9kyJQOEp+MghgcGmluebAxQE/oKYuZfvt28oAmFi7yjM+z+H9G+MP0J/
        IO9EIAzkkGSEX64O+VEu0wuUGd3QN4nRYQ6W6aDlptQ4j3ww5iefmoo1Egpf7tuxCwuioKLa19mrW
        QAHxcrtpXTPJqPU1wTig0dNCXhCL/d+YrrGxICUL6R7FoMlzGrozOkLiiod01D28VJvp+GWBFXF/M
        px9sOZFQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o9rCD-009xkE-EU; Fri, 08 Jul 2022 10:51:14 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o9rCA-0001KP-VA; Fri, 08 Jul 2022 10:51:11 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        iommu@lists.linux.dev
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
        Logan Gunthorpe <logang@deltatee.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Date:   Fri,  8 Jul 2022 10:51:03 -0600
Message-Id: <20220708165104.5005-13-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220708165104.5005-1-logang@deltatee.com>
References: <20220708165104.5005-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, iommu@lists.linux.dev, sbates@raithlin.com, hch@lst.de, jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, logang@deltatee.com, jhubbard@nvidia.com, rcampbell@nvidia.com, jgg@nvidia.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v8 12/13] RDMA/rw: drop pci_p2pdma_[un]map_sg()
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/infiniband/core/rw.c | 45 ++++++++----------------------------
 1 file changed, 9 insertions(+), 36 deletions(-)

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index 4d98f931a13d..8367974b7998 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -274,33 +274,6 @@ static int rdma_rw_init_single_wr(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
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
@@ -327,7 +300,7 @@ int rdma_rw_ctx_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp, u32 port_num,
 	};
 	int ret;
 
-	ret = rdma_rw_map_sgtable(dev, &sgt, dir);
+	ret = ib_dma_map_sgtable_attrs(dev, &sgt, dir, 0);
 	if (ret)
 		return ret;
 	sg_cnt = sgt.nents;
@@ -366,7 +339,7 @@ int rdma_rw_ctx_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp, u32 port_num,
 	return ret;
 
 out_unmap_sg:
-	rdma_rw_unmap_sg(dev, sgt.sgl, sgt.orig_nents, dir);
+	ib_dma_unmap_sgtable_attrs(dev, &sgt, dir, 0);
 	return ret;
 }
 EXPORT_SYMBOL(rdma_rw_ctx_init);
@@ -414,12 +387,12 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
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
@@ -486,9 +459,9 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
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
@@ -621,7 +594,7 @@ void rdma_rw_ctx_destroy(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 		break;
 	}
 
-	rdma_rw_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
+	ib_dma_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
 }
 EXPORT_SYMBOL(rdma_rw_ctx_destroy);
 
@@ -649,8 +622,8 @@ void rdma_rw_ctx_destroy_signature(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
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

