Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0352724BB
	for <lists+linux-pci@lfdr.de>; Mon, 21 Sep 2020 15:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgIUNKs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Sep 2020 09:10:48 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14200 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727428AbgIUNKq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Sep 2020 09:10:46 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 517EF94D4DDE6B6B7A45;
        Mon, 21 Sep 2020 21:10:40 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 21:10:30 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH -next] PCI: loongson: simplify the return expression of loongson_pci_probe()
Date:   Mon, 21 Sep 2020 21:10:54 +0800
Message-ID: <20200921131054.92797-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Simplify the return expression.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/pci/controller/pci-loongson.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index 719c19fe2..48169b1e3 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -183,7 +183,6 @@ static int loongson_pci_probe(struct platform_device *pdev)
 	struct device_node *node = dev->of_node;
 	struct pci_host_bridge *bridge;
 	struct resource *regs;
-	int err;
 
 	if (!node)
 		return -ENODEV;
@@ -222,11 +221,7 @@ static int loongson_pci_probe(struct platform_device *pdev)
 	bridge->ops = &loongson_pci_ops;
 	bridge->map_irq = loongson_map_irq;
 
-	err = pci_host_probe(bridge);
-	if (err)
-		return err;
-
-	return 0;
+	return pci_host_probe(bridge);
 }
 
 static struct platform_driver loongson_pci_driver = {
-- 
2.23.0

