Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327DF3A301C
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jun 2021 18:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhFJQIQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Jun 2021 12:08:16 -0400
Received: from ale.deltatee.com ([204.191.154.188]:60150 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbhFJQIP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Jun 2021 12:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=ecVQN1myFhNKBV+atAyPDZ6lDFiBiAGm9A4aOtek3/g=; b=O+RUxQEfumKDvQ0B/Ew/JdU8fV
        gBmRlklFWe0xIg+xEL1m4vstjByraehGmTPmMDiUlcKVCqK6G8hCf+PjrQiKMPsf9JcjH2zhwXsSe
        ld58irkzM5Vkwnmaf+hvdCHWPBqiJPq06Xz1oITkmaeOPRQ3xraYco0wtXAJJq4XZV5Yx0BTaAwYk
        W+s1DmIieVPH+bQ+2O4NsAw1GaVX4F+YAlZUKxpvvD2Mo57kMyJycD+HfuMRX87OB+u5nojpcWszA
        b5uLvU12UnNcc+huth0rX4dAY534WDeUtFrr+geWUMJBVRQWksTNJ9pCRz/lqZGkswmDS5d5b40ar
        +DpgoGAw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1lrNCD-0000Jh-Lb; Thu, 10 Jun 2021 10:06:18 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1lrNC8-0007Ps-Uk; Thu, 10 Jun 2021 10:06:12 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 10 Jun 2021 10:06:08 -0600
Message-Id: <20210610160609.28447-6-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210610160609.28447-1-logang@deltatee.com>
References: <20210610160609.28447-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, helgaas@kernel.org, sbates@raithlin.com, hch@lst.de, dan.j.williams@intel.com, jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_NO_TEXT autolearn=no autolearn_force=no version=3.4.2
Subject: [PATCH v1 5/6] PCI/P2PDMA: Refactor pci_p2pdma_map_type() to take pagemap and device
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

All callers of pci_p2pdma_map_type() have a struct dev_pgmap and a
struct device (of the client doing the DMA transfer). Thus move the
conversion to struct pci_devs for the provider and client into this
function.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 2de4a9e2da58..5dc1f9f62a93 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -814,12 +814,20 @@ void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
 }
 EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
 
-static enum pci_p2pdma_map_type pci_p2pdma_map_type(struct pci_dev *provider,
-						    struct pci_dev *client)
+static enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
+						    struct device *dev)
 {
+	struct pci_dev *provider = to_p2p_pgmap(pgmap)->provider;
+	struct pci_dev *client;
+
 	if (!provider->p2pdma)
 		return PCI_P2PDMA_MAP_NOT_SUPPORTED;
 
+	if (!dev_is_pci(dev))
+		return PCI_P2PDMA_MAP_NOT_SUPPORTED;
+
+	client = to_pci_dev(dev);
+
 	return xa_to_value(xa_load(&provider->p2pdma->map_types,
 				   map_types_idx(client)));
 }
@@ -856,14 +864,8 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 {
 	struct pci_p2pdma_pagemap *p2p_pgmap =
 		to_p2p_pgmap(sg_page(sg)->pgmap);
-	struct pci_dev *client;
-
-	if (WARN_ON_ONCE(!dev_is_pci(dev)))
-		return 0;
 
-	client = to_pci_dev(dev);
-
-	switch (pci_p2pdma_map_type(p2p_pgmap->provider, client)) {
+	switch (pci_p2pdma_map_type(sg_page(sg)->pgmap, dev)) {
 	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
 		return dma_map_sg_attrs(dev, sg, nents, dir, attrs);
 	case PCI_P2PDMA_MAP_BUS_ADDR:
@@ -887,17 +889,9 @@ EXPORT_SYMBOL_GPL(pci_p2pdma_map_sg_attrs);
 void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
-	struct pci_p2pdma_pagemap *p2p_pgmap =
-		to_p2p_pgmap(sg_page(sg)->pgmap);
 	enum pci_p2pdma_map_type map_type;
-	struct pci_dev *client;
-
-	if (WARN_ON_ONCE(!dev_is_pci(dev)))
-		return;
-
-	client = to_pci_dev(dev);
 
-	map_type = pci_p2pdma_map_type(p2p_pgmap->provider, client);
+	map_type = pci_p2pdma_map_type(sg_page(sg)->pgmap, dev);
 
 	if (map_type == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE)
 		dma_unmap_sg_attrs(dev, sg, nents, dir, attrs);
-- 
2.20.1

