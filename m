Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81DBE37A5F5
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 13:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhEKLrQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 07:47:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2442 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbhEKLrP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 07:47:15 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Ffbf71KxkzCqv0;
        Tue, 11 May 2021 19:43:27 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Tue, 11 May 2021 19:45:58 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] PCI: dwc/imx6: Remove redundant error printing in imx6_pcie_probe()
Date:   Tue, 11 May 2021 19:45:47 +0800
Message-ID: <20210511114547.5601-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When devm_ioremap_resource() fails, a clear enough error message will be
printed by its subfunction __devm_ioremap_resource(). The error
information contains the device name, failure cause, and possibly resource
information.

Therefore, remove the error printing here to simplify code and reduce the
binary size.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 0cf1333c044032f..035fb622cafafcd 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1002,10 +1002,8 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 			return ret;
 		}
 		imx6_pcie->phy_base = devm_ioremap_resource(dev, &res);
-		if (IS_ERR(imx6_pcie->phy_base)) {
-			dev_err(dev, "Unable to map PCIe PHY\n");
+		if (IS_ERR(imx6_pcie->phy_base))
 			return PTR_ERR(imx6_pcie->phy_base);
-		}
 	}
 
 	dbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.26.0.106.g9fadedd


