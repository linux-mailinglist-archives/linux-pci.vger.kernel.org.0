Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D541BD1DD
	for <lists+linux-pci@lfdr.de>; Wed, 29 Apr 2020 03:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgD2BtY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Apr 2020 21:49:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56330 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726158AbgD2BtX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Apr 2020 21:49:23 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9CF2E9EA2F8716380393;
        Wed, 29 Apr 2020 09:49:21 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Wed, 29 Apr 2020 09:49:12 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next  v2] PCI: dwc: pci-dra7xx: use devm_platform_ioremap_resource_byname()
Date:   Wed, 29 Apr 2020 01:50:27 +0000
Message-ID: <20200429015027.134485-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200427111044.162618-1-weiyongjun1@huawei.com>
References: <20200427111044.162618-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

platform_get_resource() may fail and return NULL, so we should better
check it's return value to avoid a NULL pointer dereference a bit later
in the code. Fix it to use devm_platform_ioremap_resource_byname()
instead of calling platform_get_resource_byname() and devm_ioremap().

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
v1 -> v2: use devm_platform_ioremap_resource_byname, suggest by Vignesh
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 3b0e58f2de58..6184ebc9392d 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -840,7 +840,6 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	struct phy **phy;
 	struct device_link **link;
 	void __iomem *base;
-	struct resource *res;
 	struct dw_pcie *pci;
 	struct dra7xx_pcie *dra7xx;
 	struct device *dev = &pdev->dev;
@@ -877,10 +876,9 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 		return irq;
 	}
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ti_conf");
-	base = devm_ioremap(dev, res->start, resource_size(res));
-	if (!base)
-		return -ENOMEM;
+	base = devm_platform_ioremap_resource_byname(pdev, "ti_conf");
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 
 	phy_count = of_property_count_strings(np, "phy-names");
 	if (phy_count < 0) {



