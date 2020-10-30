Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4DA29FA99
	for <lists+linux-pci@lfdr.de>; Fri, 30 Oct 2020 02:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgJ3B2u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 21:28:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:6935 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgJ3B2q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 21:28:46 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CMl7y5LW8z6xWj;
        Fri, 30 Oct 2020 09:28:46 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Fri, 30 Oct 2020 09:28:36 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH] PCI: v3: fix missing clk_disable_unprepare() on error in v3_pci_probe
Date:   Fri, 30 Oct 2020 09:34:27 +0800
Message-ID: <20201030013427.54086-1-miaoqinglang@huawei.com>
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

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/pci/controller/pci-v3-semi.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
index 154a53986..e24abc5b4 100644
--- a/drivers/pci/controller/pci-v3-semi.c
+++ b/drivers/pci/controller/pci-v3-semi.c
@@ -739,8 +739,10 @@ static int v3_pci_probe(struct platform_device *pdev)
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	v3->base = devm_ioremap_resource(dev, regs);
-	if (IS_ERR(v3->base))
+	if (IS_ERR(v3->base)) {
+		clk_disable_unprepare(clk);
 		return PTR_ERR(v3->base);
+	}
 	/*
 	 * The hardware has a register with the physical base address
 	 * of the V3 controller itself, verify that this is the same
@@ -754,17 +756,22 @@ static int v3_pci_probe(struct platform_device *pdev)
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	if (resource_size(regs) != SZ_16M) {
 		dev_err(dev, "config mem is not 16MB!\n");
+		clk_disable_unprepare(clk);
 		return -EINVAL;
 	}
 	v3->config_mem = regs->start;
 	v3->config_base = devm_ioremap_resource(dev, regs);
-	if (IS_ERR(v3->config_base))
+	if (IS_ERR(v3->config_base)) {
+		clk_disable_unprepare(clk);
 		return PTR_ERR(v3->config_base);
+	}
 
 	/* Get and request error IRQ resource */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
+	if (irq < 0) {
+		clk_disable_unprepare(clk);
 		return irq;
+	}
 
 	ret = devm_request_irq(dev, irq, v3_irq, 0,
 			"PCIv3 error", v3);
@@ -772,6 +779,7 @@ static int v3_pci_probe(struct platform_device *pdev)
 		dev_err(dev,
 			"unable to request PCIv3 error IRQ %d (%d)\n",
 			irq, ret);
+		clk_disable_unprepare(clk);
 		return ret;
 	}
 
-- 
2.23.0

