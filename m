Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0427F37A683
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 14:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhEKM0P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 08:26:15 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2697 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbhEKM0P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 08:26:15 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FfcW73mDnz1BLKg;
        Tue, 11 May 2021 20:22:27 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Tue, 11 May 2021 20:24:58 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] PCI: mediatek: Remove redundant error printing in mtk_pcie_subsys_powerup()
Date:   Tue, 11 May 2021 20:24:53 +0800
Message-ID: <20210511122453.6052-1-thunder.leizhen@huawei.com>
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
 drivers/pci/controller/pcie-mediatek.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 62a042e75d9a2f4..25bee693834f95e 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -991,10 +991,8 @@ static int mtk_pcie_subsys_powerup(struct mtk_pcie *pcie)
 	regs = platform_get_resource_byname(pdev, IORESOURCE_MEM, "subsys");
 	if (regs) {
 		pcie->base = devm_ioremap_resource(dev, regs);
-		if (IS_ERR(pcie->base)) {
-			dev_err(dev, "failed to map shared register\n");
+		if (IS_ERR(pcie->base))
 			return PTR_ERR(pcie->base);
-		}
 	}
 
 	pcie->free_ck = devm_clk_get(dev, "free_ck");
-- 
2.26.0.106.g9fadedd


