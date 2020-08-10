Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18BA7240623
	for <lists+linux-pci@lfdr.de>; Mon, 10 Aug 2020 14:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgHJMst (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Aug 2020 08:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgHJMss (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Aug 2020 08:48:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDA0C061756
        for <linux-pci@vger.kernel.org>; Mon, 10 Aug 2020 05:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=t+csojCNqg5EFlnTFsTFMvWsaON2fdiMbVsMLKa0fLs=; b=elknGK+8kVpfTuPJG9QGFoDJhz
        7JQu5jdl2ki62rlZ2aPStzhLaAew1vzDNdVlhDRpJCTdFZ5TdUmGG7KFpL58ZempxeKiYoFC8rmf5
        xnhhG62xmKnvrg7NZLfKdE997tBe1qDyjV09dDjHJoURJ/7myi5elvo/FazLm9U9/FC53eDDdfLr/
        edgM1axQv3pq306ZIFPyJuOEnAg70c+VaGvPeiMxYCRRD0Uk6PMk60s2n3RQiZW29RL2mdoSMaFXI
        OOvg8fc6gDswxw6sVH1BGNC4ZJqGQXb3Yy2GRUfrd1kKU3d4wobfETGxZl1Gr5riqyyNc6xFZhMEo
        l9zfsa/Q==;
Received: from [2001:4bb8:18c:29c:3742:758b:3638:ce12] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k57EK-0006xe-4g; Mon, 10 Aug 2020 12:48:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     logang@deltatee.com, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] PCI/P2PDMA: fix build without dma ops
Date:   Mon, 10 Aug 2020 14:48:43 +0200
Message-Id: <20200810124843.1532738-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

My commit to make dma ops support optional missed the reference in
the p2pdma code.  And while the build bot didn't manage to find a config
where this can happen, Matthew did.  Fix this by replacing two IS_ENABLED
checks with ifdefs.

Fixes: 2f9237d4f6d ("dma-mapping: make support for dma ops optional")
Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/p2pdma.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 64ebed129dbf5f..f357f9a32b3a57 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -556,13 +556,14 @@ int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
 		return -1;
 
 	for (i = 0; i < num_clients; i++) {
-		if (IS_ENABLED(CONFIG_DMA_VIRT_OPS) &&
-		    clients[i]->dma_ops == &dma_virt_ops) {
+#ifdef CONFIG_DMA_VIRT_OPS
+		if (clients[i]->dma_ops == &dma_virt_ops) {
 			if (verbose)
 				dev_warn(clients[i],
 					 "cannot be used for peer-to-peer DMA because the driver makes use of dma_virt_ops\n");
 			return -1;
 		}
+#endif
 
 		pci_client = find_parent_pci_dev(clients[i]);
 		if (!pci_client) {
@@ -842,9 +843,10 @@ static int __pci_p2pdma_map_sg(struct pci_p2pdma_pagemap *p2p_pgmap,
 	 * this should never happen because it will be prevented
 	 * by the check in pci_p2pdma_distance_many()
 	 */
-	if (WARN_ON_ONCE(IS_ENABLED(CONFIG_DMA_VIRT_OPS) &&
-			 dev->dma_ops == &dma_virt_ops))
+#ifdef CONFIG_DMA_VIRT_OPS
+	if (WARN_ON_ONCE(dev->dma_ops == &dma_virt_ops))
 		return 0;
+#endif
 
 	for_each_sg(sg, s, nents, i) {
 		paddr = sg_phys(s);
-- 
2.28.0

