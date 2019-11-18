Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A68C10037F
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2019 12:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfKRLEC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Nov 2019 06:04:02 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7132 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726721AbfKRLEC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Nov 2019 06:04:02 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9093E2213E598A62D702;
        Mon, 18 Nov 2019 19:04:00 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Mon, 18 Nov 2019
 19:03:54 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <thierry.reding@gmail.com>, <lorenzo.pieralisi@arm.com>,
        <andrew.murray@arm.com>, <bhelgaas@google.com>,
        <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH] PCI: tegra: Use PTR_ERR_OR_ZERO() to simplify code
Date:   Mon, 18 Nov 2019 19:11:18 +0800
Message-ID: <1574075478-41136-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fixes coccicheck warning:

drivers/pci/controller/pci-tegra.c:1365:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/pci/controller/pci-tegra.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 673a172..8503ae5 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -1362,10 +1362,7 @@ static int tegra_pcie_resets_get(struct tegra_pcie *pcie)
 		return PTR_ERR(pcie->afi_rst);

 	pcie->pcie_xrst = devm_reset_control_get_exclusive(dev, "pcie_x");
-	if (IS_ERR(pcie->pcie_xrst))
-		return PTR_ERR(pcie->pcie_xrst);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(pcie->pcie_xrst);
 }

 static int tegra_pcie_phys_get_legacy(struct tegra_pcie *pcie)
--
2.7.4

