Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC708A48A
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 19:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfHLRbw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 13:31:52 -0400
Received: from ale.deltatee.com ([207.54.116.67]:37740 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbfHLRa6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 13:30:58 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hxE9l-0002sc-OC; Mon, 12 Aug 2019 11:30:56 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hxE9j-0002PX-Hv; Mon, 12 Aug 2019 11:30:51 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Pilmore <epilmore@gigaio.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Mon, 12 Aug 2019 11:30:43 -0600
Message-Id: <20190812173048.9186-10-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190812173048.9186-1-logang@deltatee.com>
References: <20190812173048.9186-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, bhelgaas@google.com, hch@lst.de, Christian.Koenig@amd.com, jgg@mellanox.com, sagi@grimberg.me, kbusch@kernel.org, axboe@fb.com, dan.j.williams@intel.com, epilmore@gigaio.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_FREE,MYRULES_NO_TEXT autolearn=no autolearn_force=no
        version=3.4.2
Subject: [PATCH v3 09/14] PCI/P2PDMA: Introduce pci_p2pdma_unmap_sg()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add pci_p2pdma_unmap_sg() to the two places that call pci_p2pdma_map_sg().

This is a prep patch to introduce correct mappings for p2pdma transactions
that go through the root complex.

Link: https://lore.kernel.org/r/20190730163545.4915-10-logang@deltatee.com
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/infiniband/core/rw.c |  6 ++++--
 drivers/nvme/host/pci.c      |  6 ++++--
 drivers/pci/p2pdma.c         | 18 +++++++++++++++++-
 include/linux/pci-p2pdma.h   | 13 +++++++++++++
 4 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index dce06108c8c3..5337393d4dfe 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -583,8 +583,10 @@ void rdma_rw_ctx_destroy(struct rdma_rw_ctx *ctx, struct ib_qp *qp, u8 port_num,
 		break;
 	}
 
-	/* P2PDMA contexts do not need to be unmapped */
-	if (!is_pci_p2pdma_page(sg_page(sg)))
+	if (is_pci_p2pdma_page(sg_page(sg)))
+		pci_p2pdma_unmap_sg(qp->pd->device->dma_device, sg,
+				    sg_cnt, dir);
+	else
 		ib_dma_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
 }
 EXPORT_SYMBOL(rdma_rw_ctx_destroy);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f97bb031228a..0f92cca7a860 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -547,8 +547,10 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 
 	WARN_ON_ONCE(!iod->nents);
 
-	/* P2PDMA requests do not need to be unmapped */
-	if (!is_pci_p2pdma_page(sg_page(iod->sg)))
+	if (is_pci_p2pdma_page(sg_page(iod->sg)))
+		pci_p2pdma_unmap_sg(dev->dev, iod->sg, iod->nents,
+				    rq_dma_dir(req));
+	else
 		dma_unmap_sg(dev->dev, iod->sg, iod->nents, rq_dma_dir(req));
 
 
diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 94fbacbcbbd0..1eec7a5ec27e 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -800,7 +800,8 @@ EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
  * @dir: DMA direction
  * @attrs: DMA attributes passed to dma_map_sg() (if called)
  *
- * Scatterlists mapped with this function should not be unmapped in any way.
+ * Scatterlists mapped with this function should be unmapped using
+ * pci_p2pdma_unmap_sg_attrs().
  *
  * Returns the number of SG entries mapped or 0 on error.
  */
@@ -834,6 +835,21 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 }
 EXPORT_SYMBOL_GPL(pci_p2pdma_map_sg_attrs);
 
+/**
+ * pci_p2pdma_unmap_sg - unmap a PCI peer-to-peer scatterlist that was
+ *	mapped with pci_p2pdma_map_sg()
+ * @dev: device doing the DMA request
+ * @sg: scatter list to map
+ * @nents: number of elements returned by pci_p2pdma_map_sg()
+ * @dir: DMA direction
+ * @attrs: DMA attributes passed to dma_unmap_sg() (if called)
+ */
+void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
+{
+}
+EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
+
 /**
  * pci_p2pdma_enable_store - parse a configfs/sysfs attribute store
  *		to enable p2pdma
diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
index 7fd51954f93a..8318a97c9c61 100644
--- a/include/linux/pci-p2pdma.h
+++ b/include/linux/pci-p2pdma.h
@@ -32,6 +32,8 @@ void pci_p2pmem_free_sgl(struct pci_dev *pdev, struct scatterlist *sgl);
 void pci_p2pmem_publish(struct pci_dev *pdev, bool publish);
 int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction dir, unsigned long attrs);
+void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
+		int nents, enum dma_data_direction dir, unsigned long attrs);
 int pci_p2pdma_enable_store(const char *page, struct pci_dev **p2p_dev,
 			    bool *use_p2pdma);
 ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
@@ -87,6 +89,11 @@ static inline int pci_p2pdma_map_sg_attrs(struct device *dev,
 {
 	return 0;
 }
+static inline void pci_p2pdma_unmap_sg_attrs(struct device *dev,
+		struct scatterlist *sg, int nents, enum dma_data_direction dir,
+		unsigned long attrs)
+{
+}
 static inline int pci_p2pdma_enable_store(const char *page,
 		struct pci_dev **p2p_dev, bool *use_p2pdma)
 {
@@ -118,4 +125,10 @@ static inline int pci_p2pdma_map_sg(struct device *dev, struct scatterlist *sg,
 	return pci_p2pdma_map_sg_attrs(dev, sg, nents, dir, 0);
 }
 
+static inline void pci_p2pdma_unmap_sg(struct device *dev,
+		struct scatterlist *sg, int nents, enum dma_data_direction dir)
+{
+	pci_p2pdma_unmap_sg_attrs(dev, sg, nents, dir, 0);
+}
+
 #endif /* _LINUX_PCI_P2P_H */
-- 
2.20.1

