Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2064C7AE10
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2019 18:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbfG3Qgx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Jul 2019 12:36:53 -0400
Received: from ale.deltatee.com ([207.54.116.67]:34164 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728968AbfG3QgH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jul 2019 12:36:07 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hsV6V-0003yK-5m; Tue, 30 Jul 2019 10:36:05 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hsV6S-0001Im-Bk; Tue, 30 Jul 2019 10:35:56 -0600
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
Date:   Tue, 30 Jul 2019 10:35:43 -0600
Message-Id: <20190730163545.4915-13-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190730163545.4915-1-logang@deltatee.com>
References: <20190730163545.4915-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, bhelgaas@google.com, hch@lst.de, Christian.Koenig@amd.com, jgg@mellanox.com, sagi@grimberg.me, kbusch@kernel.org, axboe@fb.com, dan.j.williams@intel.com, epilmore@gigaio.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v2 12/14] PCI/P2PDMA: dma_map P2PDMA map requests that traverse the host bridge
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Any requests that traverse the host bridge will need to be mapped into
the IOMMU, so call dma_map_sg() inside pci_p2pdma_map_sg() when
appropriate.

Similarly, call dma_unmap_sg() inside pci_p2pdma_unmap_sg().

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 010aa8742bec..b86a1c0c11a0 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -812,6 +812,16 @@ void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
 }
 EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
 
+static enum pci_p2pdma_map_type pci_p2pdma_map_type(struct pci_dev *provider,
+						    struct pci_dev *client)
+{
+	if (!provider->p2pdma)
+		return PCI_P2PDMA_MAP_NOT_SUPPORTED;
+
+	return xa_to_value(xa_load(&provider->p2pdma->map_types,
+				   map_types_idx(client)));
+}
+
 static int __pci_p2pdma_map_sg(struct pci_p2pdma_pagemap *p2p_pgmap,
 		struct device *dev, struct scatterlist *sg, int nents)
 {
@@ -857,8 +867,22 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 {
 	struct pci_p2pdma_pagemap *p2p_pgmap =
 		to_p2p_pgmap(sg_page(sg)->pgmap);
+	struct pci_dev *client;
 
-	return __pci_p2pdma_map_sg(p2p_pgmap, dev, sg, nents);
+	if (WARN_ON_ONCE(!dev_is_pci(dev)))
+		return 0;
+
+	client = to_pci_dev(dev);
+
+	switch (pci_p2pdma_map_type(p2p_pgmap->provider, client)) {
+	case PCI_P2PDMA_MAP_THRU_IOMMU:
+		return dma_map_sg_attrs(dev, sg, nents, dir, attrs);
+	case PCI_P2PDMA_MAP_BUS_ADDR:
+		return __pci_p2pdma_map_sg(p2p_pgmap, dev, sg, nents);
+	default:
+		WARN_ON_ONCE(1);
+		return 0;
+	}
 }
 EXPORT_SYMBOL_GPL(pci_p2pdma_map_sg_attrs);
 
@@ -874,6 +898,20 @@ EXPORT_SYMBOL_GPL(pci_p2pdma_map_sg_attrs);
 void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
+	struct pci_p2pdma_pagemap *p2p_pgmap =
+		to_p2p_pgmap(sg_page(sg)->pgmap);
+	enum pci_p2pdma_map_type map_type;
+	struct pci_dev *client;
+
+	if (WARN_ON_ONCE(!dev_is_pci(dev)))
+		return;
+
+	client = to_pci_dev(dev);
+
+	map_type = pci_p2pdma_map_type(p2p_pgmap->provider, client);
+
+	if (map_type == PCI_P2PDMA_MAP_THRU_IOMMU)
+		dma_unmap_sg_attrs(dev, sg, nents, dir, attrs);
 }
 EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
 
-- 
2.20.1

