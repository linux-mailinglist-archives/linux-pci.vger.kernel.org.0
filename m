Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C012A8D93
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 04:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbgKFDhk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 22:37:40 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7152 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgKFDhk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Nov 2020 22:37:40 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CS5gF1KNyz15Rgr;
        Fri,  6 Nov 2020 11:37:29 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Fri, 6 Nov 2020 11:37:23 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH v4] PCI: v3: fix missing clk_disable_unprepare() on error in v3_pci_probe
Date:   Fri, 6 Nov 2020 11:42:49 +0800
Message-ID: <20201106034249.169996-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201106031208.160334-1-miaoqinglang@huawei.com>
References: <20201106031208.160334-1-miaoqinglang@huawei.com>
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

I also move the clock-enable function later to avoid some
fixes.

Fixes: 68a15eb7bd0c ("PCI: v3-semi: Add V3 Semiconductor PCI host driver")
Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 v2: add commit causing this problem and add more error handling
     cases which are not enough.
 v3: 1. fix the wrong 'Fixes commit'.
     2. use goto to clean up this patch.
     3. cover all error handling cases.
 v4: fix uncorresponding author name.
 drivers/pci/controller/pci-v3-semi.c | 49 +++++++++++++++++-----------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
index 154a53986..f862a56a3 100644
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
@@ -761,10 +749,24 @@ static int v3_pci_probe(struct platform_device *pdev)
 	if (IS_ERR(v3->config_base))
 		return PTR_ERR(v3->config_base);
 
+	/* Get and enable host clock */
+        clk = devm_clk_get(dev, NULL);
+        if (IS_ERR(clk)) {
+                dev_err(dev, "clock not found\n");
+                return PTR_ERR(clk);
+        }
+        ret = clk_prepare_enable(clk);
+        if (ret) {
+                dev_err(dev, "unable to enable clock\n");
+                return ret;
+        }
+
 	/* Get and request error IRQ resource */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
+	if (irq < 0) {
+		ret = irq;
+		goto err_clk;
+	}
 
 	ret = devm_request_irq(dev, irq, v3_irq, 0,
 			"PCIv3 error", v3);
@@ -772,7 +774,7 @@ static int v3_pci_probe(struct platform_device *pdev)
 		dev_err(dev,
 			"unable to request PCIv3 error IRQ %d (%d)\n",
 			irq, ret);
-		return ret;
+		goto err_clk;
 	}
 
 	/*
@@ -814,12 +816,12 @@ static int v3_pci_probe(struct platform_device *pdev)
 		ret = v3_pci_setup_resource(v3, host, win);
 		if (ret) {
 			dev_err(dev, "error setting up resources\n");
-			return ret;
+			goto err_clk;
 		}
 	}
 	ret = v3_pci_parse_map_dma_ranges(v3, np);
 	if (ret)
-		return ret;
+		goto err_clk;
 
 	/*
 	 * Disable PCI to host IO cycles, enable I/O buffers @3.3V,
@@ -863,7 +865,7 @@ static int v3_pci_probe(struct platform_device *pdev)
 	if (of_device_is_compatible(np, "arm,integrator-ap-pci")) {
 		ret = v3_integrator_init(v3);
 		if (ret)
-			return ret;
+			goto err_clk;
 	}
 
 	/* Post-init: enable PCI memory and invalidate (master already on) */
@@ -889,7 +891,16 @@ static int v3_pci_probe(struct platform_device *pdev)
 	val |= V3_SYSTEM_M_LOCK;
 	writew(val, v3->base + V3_SYSTEM);
 
-	return pci_host_probe(host);
+	ret = pci_host_probe(host);
+	if (ret < 0)
+		goto err_clk;
+
+	return 0;
+
+err_clk:
+	clk_disable_unprepare(clk);
+
+	return ret;
 }
 
 static const struct of_device_id v3_pci_of_match[] = {
-- 
2.23.0

