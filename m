Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12A569892D
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2019 04:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfHVCAU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Aug 2019 22:00:20 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5184 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727617AbfHVCAT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Aug 2019 22:00:19 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3422818BE44A25F8E403;
        Thu, 22 Aug 2019 10:00:10 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Thu, 22 Aug 2019 10:00:03 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Jonathan Hunter" <jonathanh@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-pci@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] PCI: tegra: Fix the error return code in tegra_pcie_dw_probe()
Date:   Thu, 22 Aug 2019 02:03:52 +0000
Message-ID: <20190822020352.35412-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix the error return code in tegra_pcie_dw_probe() by using error code
instead of PTR_ERR(NULL) which is always 0.

Fixes: 6404441c8e13 ("PCI: tegra: Add Tegra194 PCIe support")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index fc0dbeb31d78..678a6b51c7aa 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1384,7 +1384,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 						      "appl");
 	if (!pcie->appl_res) {
 		dev_err(dev, "Failed to find \"appl\" region\n");
-		return PTR_ERR(pcie->appl_res);
+		return -ENODEV;
 	}
 
 	pcie->appl_base = devm_ioremap_resource(dev, pcie->appl_res);
@@ -1400,7 +1400,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 
 	phys = devm_kcalloc(dev, pcie->phy_count, sizeof(*phys), GFP_KERNEL);
 	if (!phys)
-		return PTR_ERR(phys);
+		return -ENOMEM;
 
 	for (i = 0; i < pcie->phy_count; i++) {
 		name = kasprintf(GFP_KERNEL, "p2u-%u", i);
@@ -1422,7 +1422,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 	dbi_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
 	if (!dbi_res) {
 		dev_err(dev, "Failed to find \"dbi\" region\n");
-		return PTR_ERR(dbi_res);
+		return -ENODEV;
 	}
 	pcie->dbi_res = dbi_res;
 
@@ -1437,7 +1437,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 						   "atu_dma");
 	if (!atu_dma_res) {
 		dev_err(dev, "Failed to find \"atu_dma\" region\n");
-		return PTR_ERR(atu_dma_res);
+		return -ENODEV;
 	}
 	pcie->atu_dma_res = atu_dma_res;



