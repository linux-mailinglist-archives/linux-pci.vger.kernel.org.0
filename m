Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6D85D55A
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2019 19:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfGBRfs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jul 2019 13:35:48 -0400
Received: from ale.deltatee.com ([207.54.116.67]:41680 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbfGBRfs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jul 2019 13:35:48 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hiMh0-0005wc-LA; Tue, 02 Jul 2019 11:35:47 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hiMh0-0005ik-9k; Tue, 02 Jul 2019 11:35:46 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Tue,  2 Jul 2019 11:35:44 -0600
Message-Id: <20190702173544.21950-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, helgaas@kernel.org, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH] PCI/P2PDMA: Fix missing check for dma_virt_ops
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Drivers that use dma_virt_ops were meant to be rejected when testing
compatibility for P2PDMA.

This check got inadvertantly dropped in one of the later versions of the
original patchset, so add it back.

Fixes: 52916982af48 ("PCI/P2PDMA: Support peer-to-peer memory")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index a4994aa3acc0..ab48babdf214 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -487,6 +487,14 @@ int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
 		return -1;
 
 	for (i = 0; i < num_clients; i++) {
+		if (IS_ENABLED(CONFIG_DMA_VIRT_OPS) &&
+		    clients[i]->dma_ops == &dma_virt_ops) {
+			if (verbose)
+				dev_warn(clients[i],
+					 "cannot be used for peer-to-peer DMA because the driver makes use of dma_virt_ops\n");
+			return -1;
+		}
+
 		pci_client = find_parent_pci_dev(clients[i]);
 		if (!pci_client) {
 			if (verbose)
@@ -765,7 +773,7 @@ int pci_p2pdma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 	 * p2pdma mappings are not compatible with devices that use
 	 * dma_virt_ops. If the upper layers do the right thing
 	 * this should never happen because it will be prevented
-	 * by the check in pci_p2pdma_add_client()
+	 * by the check in pci_p2pdma_distance_many()
 	 */
 	if (WARN_ON_ONCE(IS_ENABLED(CONFIG_DMA_VIRT_OPS) &&
 			 dev->dma_ops == &dma_virt_ops))
-- 
2.20.1

