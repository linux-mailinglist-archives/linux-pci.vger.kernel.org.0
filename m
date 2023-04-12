Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332EA6DEBDB
	for <lists+linux-pci@lfdr.de>; Wed, 12 Apr 2023 08:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjDLGfM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Apr 2023 02:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDLGfL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2023 02:35:11 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E65AD3ABC;
        Tue, 11 Apr 2023 23:35:09 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.98,338,1673881200"; 
   d="scan'208";a="159142066"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 12 Apr 2023 15:35:09 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4429B400F7A0;
        Wed, 12 Apr 2023 15:35:09 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     lpieralisi@kernel.org, kw@linux.com, mani@kernel.org,
        kishon@kernel.org, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Frank Li <Frank.Li@nxp.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v12] PCI: endpoint: functions/pci-epf-test: Fix dma_chan direction
Date:   Wed, 12 Apr 2023 15:34:47 +0900
Message-Id: <20230412063447.2841177-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
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
results of pcitest with enabled DMA will be "NOT OKAY" on eDMA
environment.

Fixes: 8353813c88ef ("PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 Patch history:
 v1: https://lore.kernel.org/linux-pci/20230221100949.3530608-1-yoshihiro.shimoda.uh@renesas.com/
 v1 resend: https://lore.kernel.org/linux-pci/20230221101706.3530869-1-yoshihiro.shimoda.uh@renesas.com/
 v2: https://lore.kernel.org/linux-pci/20230222015327.3585691-1-yoshihiro.shimoda.uh@renesas.com/
 v10 [1]: https://lore.kernel.org/linux-pci/20230308082352.491561-3-yoshihiro.shimoda.uh@renesas.com/
 v11 [1]: https://lore.kernel.org/linux-pci/20230310123510.675685-3-yoshihiro.shimoda.uh@renesas.com/
 v12: This patch.

 Changes from v11:
 - Add Tested-by (Thanks Hayashi-san!).

[1] Include this patch into R-Car S4 support patch series. However, I need
    more time to fix the R-Car patches. So, I send this fix patch independently.

 drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 0f9d2ec822ac..172e5ac0bd96 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -112,7 +112,7 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 				      size_t len, dma_addr_t dma_remote,
 				      enum dma_transfer_direction dir)
 {
-	struct dma_chan *chan = (dir == DMA_DEV_TO_MEM) ?
+	struct dma_chan *chan = (dir == DMA_MEM_TO_DEV) ?
 				 epf_test->dma_chan_tx : epf_test->dma_chan_rx;
 	dma_addr_t dma_local = (dir == DMA_MEM_TO_DEV) ? dma_src : dma_dst;
 	enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
-- 
2.25.1

