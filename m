Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9547DB31D
	for <lists+linux-pci@lfdr.de>; Mon, 30 Oct 2023 07:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjJ3GMz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Oct 2023 02:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjJ3GMy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Oct 2023 02:12:54 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF2FA9;
        Sun, 29 Oct 2023 23:12:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Vv6phb3_1698646362;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Vv6phb3_1698646362)
          by smtp.aliyun-inc.com;
          Mon, 30 Oct 2023 14:12:43 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, michal.simek@amd.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] PCI: xilinx-xdma: Remove redundant dev_err()
Date:   Mon, 30 Oct 2023 14:12:42 +0800
Message-Id: <20231030061242.51475-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There is no need to call the dev_err() function directly to print a
custom message when handling an error from either the platform_get_irq()
or platform_get_irq_byname() functions as both are going to display an
appropriate error message in case of a failure.

./drivers/pci/controller/pcie-xilinx-dma-pl.c:688:2-9: line 688 is redundant because platform_get_irq() already prints an error
./drivers/pci/controller/pcie-xilinx-dma-pl.c:702:2-9: line 702 is redundant because platform_get_irq() already prints an error

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7074
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/pci/controller/pcie-xilinx-dma-pl.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-dma-pl.c b/drivers/pci/controller/pcie-xilinx-dma-pl.c
index 2f7d676c683c..4e49b12a2e2a 100644
--- a/drivers/pci/controller/pcie-xilinx-dma-pl.c
+++ b/drivers/pci/controller/pcie-xilinx-dma-pl.c
@@ -684,10 +684,8 @@ static int xilinx_request_msi_irq(struct pl_dma_pcie *port)
 	int ret;
 
 	port->msi.irq_msi0 = platform_get_irq_byname(pdev, "msi0");
-	if (port->msi.irq_msi0 <= 0) {
-		dev_err(dev, "Unable to find msi0 IRQ line\n");
+	if (port->msi.irq_msi0 <= 0)
 		return port->msi.irq_msi0;
-	}
 
 	ret = devm_request_irq(dev, port->msi.irq_msi0, xilinx_pl_dma_pcie_msi_handler_low,
 			       IRQF_SHARED | IRQF_NO_THREAD, "xlnx-pcie-dma-pl",
@@ -698,10 +696,8 @@ static int xilinx_request_msi_irq(struct pl_dma_pcie *port)
 	}
 
 	port->msi.irq_msi1 = platform_get_irq_byname(pdev, "msi1");
-	if (port->msi.irq_msi1 <= 0) {
-		dev_err(dev, "Unable to find msi1 IRQ line\n");
+	if (port->msi.irq_msi1 <= 0)
 		return port->msi.irq_msi1;
-	}
 
 	ret = devm_request_irq(dev, port->msi.irq_msi1, xilinx_pl_dma_pcie_msi_handler_high,
 			       IRQF_SHARED | IRQF_NO_THREAD, "xlnx-pcie-dma-pl",
-- 
2.20.1.7.g153144c

