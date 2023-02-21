Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56F269DD94
	for <lists+linux-pci@lfdr.de>; Tue, 21 Feb 2023 11:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbjBUKKP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Feb 2023 05:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjBUKKO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Feb 2023 05:10:14 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1035E23126
        for <linux-pci@vger.kernel.org>; Tue, 21 Feb 2023 02:10:07 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.97,315,1669042800"; 
   d="scan'208";a="150316634"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 21 Feb 2023 19:10:07 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id EF8DD400755B;
        Tue, 21 Feb 2023 19:10:06 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     lpieralisi@kernel.org, kw@linux.com, mani@kernel.org,
        kishon@ti.com, bhelgaas@google.com, Frank.Li@nxp.com
Cc:     linux-pci@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH] PCI: endpoint: functions/pci-epf-test: Fix dma_chan direction
Date:   Tue, 21 Feb 2023 19:09:49 +0900
Message-Id: <20230221100949.3530608-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In the pci_epf_test_init_dma_chan(), epf_test->dma_chan_rx
is assigned from dma_request_channel() with DMA_DEV_TO_MEM as
filter.dma_mask. However, in the pci_epf_test_data_transfer(),
if the dir is DMA_DEV_TO_MEM, it should use epf->dma_chan_rx,
but it used epf_test->dma_chan_tx. So, fix it. Otherwise,
results of pcitest with enabled DMA will be NG on eDMA
environment.

Fixes: 8353813c88ef ("PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 55283d2379a6..3a720ed4655e 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -113,7 +113,7 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 				      enum dma_transfer_direction dir)
 {
 	struct dma_chan *chan = (dir == DMA_DEV_TO_MEM) ?
-				 epf_test->dma_chan_tx : epf_test->dma_chan_rx;
+				 epf_test->dma_chan_rx : epf_test->dma_chan_tx;
 	dma_addr_t dma_local = (dir == DMA_MEM_TO_DEV) ? dma_src : dma_dst;
 	enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
 	struct pci_epf *epf = epf_test->epf;
-- 
2.25.1

