Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3592A3DA6
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 08:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgKCH2P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 02:28:15 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7408 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgKCH2P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Nov 2020 02:28:15 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CQLwp4JMFz71P0;
        Tue,  3 Nov 2020 15:28:10 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Tue, 3 Nov 2020 15:28:04 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH v2] PCI: v3: fix missing clk_disable_unprepare() on error in v3_pci_probe
Date:   Tue, 3 Nov 2020 15:33:38 +0800
Message-ID: <20201103073338.144465-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix the missing clk_disable_unprepare() before return
from v3_pci_probe() in the error handling case.

Moving the clock enable later to avoid some fixes.

Fixes: 6e0832fa432e (" PCI: Collect all native drivers under drivers/pci/controller/")
Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/pci/controller/pci-v3-semi.c | 40 ++++++++++++++++------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
index 154a53986..90520555b 100644
--- a/drivers/pci/controller/pci-v3-semi.c
+++ b/drivers/pci/controller/pci-v3-semi.c
@@ -725,18 +725,6 @@ static int v3_pci_probe(struct platform_device *pdev)
 	host->sysdata = v3;
 	v3->dev = dev;
 
-	/* Get and enable host clock */
-	clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(clk)) {
-		dev_err(dev, "clock not found\n");
-		return PTR_ERR(clk);
-	}
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		dev_err(dev, "unable to enable clock\n");
-		return ret;
-	}
-
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	v3->base = devm_ioremap_resource(dev, regs);
 	if (IS_ERR(v3->base))
@@ -761,17 +749,31 @@ static int v3_pci_probe(struct platform_device *pdev)
 	if (IS_ERR(v3->config_base))
 		return PTR_ERR(v3->config_base);
 
+	/* Get and enable host clock */
+	clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(clk)) {
+		dev_err(dev, "clock not found\n");
+		return PTR_ERR(clk);
+	}
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		dev_err(dev, "unable to enable clock\n");
+		return ret;
+	}
+
 	/* Get and request error IRQ resource */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
+	if (irq < 0) {
+		clk_disable_unprepare(clk);
 		return irq;
-
+	}
 	ret = devm_request_irq(dev, irq, v3_irq, 0,
 			"PCIv3 error", v3);
 	if (ret < 0) {
 		dev_err(dev,
 			"unable to request PCIv3 error IRQ %d (%d)\n",
 			irq, ret);
+		clk_disable_unprepare(clk);
 		return ret;
 	}
 
@@ -814,13 +816,15 @@ static int v3_pci_probe(struct platform_device *pdev)
 		ret = v3_pci_setup_resource(v3, host, win);
 		if (ret) {
 			dev_err(dev, "error setting up resources\n");
+			clk_disable_unprepare(clk);
 			return ret;
 		}
 	}
 	ret = v3_pci_parse_map_dma_ranges(v3, np);
-	if (ret)
+	if (ret) {
+		clk_disable_unprepare(clk);
 		return ret;
-
+	}
 	/*
 	 * Disable PCI to host IO cycles, enable I/O buffers @3.3V,
 	 * set AD_LOW0 to 1 if one of the LB_MAP registers choose
@@ -862,8 +866,10 @@ static int v3_pci_probe(struct platform_device *pdev)
 	/* Special Integrator initialization */
 	if (of_device_is_compatible(np, "arm,integrator-ap-pci")) {
 		ret = v3_integrator_init(v3);
-		if (ret)
+		if (ret) {
+			clk_disable_unprepare(clk);
 			return ret;
+		}
 	}
 
 	/* Post-init: enable PCI memory and invalidate (master already on) */
-- 
2.23.0

