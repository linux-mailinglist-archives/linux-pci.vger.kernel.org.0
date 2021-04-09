Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E823596F9
	for <lists+linux-pci@lfdr.de>; Fri,  9 Apr 2021 09:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhDIH56 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Apr 2021 03:57:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15645 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhDIH55 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Apr 2021 03:57:57 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGr5D1rZNzpWs2;
        Fri,  9 Apr 2021 15:54:56 +0800 (CST)
Received: from huawei.com (10.67.174.37) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Fri, 9 Apr 2021
 15:57:42 +0800
From:   Chen Hui <clare.chenhui@huawei.com>
To:     <ley.foon.tan@intel.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <bhelgaas@google.com>
CC:     <rfi@lists.rocketboards.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] PCI: altera-msi: Remove redundant dev_err call in altera_msi_probe()
Date:   Fri, 9 Apr 2021 15:57:48 +0800
Message-ID: <20210409075748.226141-1-clare.chenhui@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Signed-off-by: Chen Hui <clare.chenhui@huawei.com>
---
 drivers/pci/controller/pcie-altera-msi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-altera-msi.c b/drivers/pci/controller/pcie-altera-msi.c
index 42691dd8ebef..98aa1dccc6e6 100644
--- a/drivers/pci/controller/pcie-altera-msi.c
+++ b/drivers/pci/controller/pcie-altera-msi.c
@@ -236,10 +236,8 @@ static int altera_msi_probe(struct platform_device *pdev)
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 					   "vector_slave");
 	msi->vector_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(msi->vector_base)) {
-		dev_err(&pdev->dev, "failed to map vector_slave memory\n");
+	if (IS_ERR(msi->vector_base))
 		return PTR_ERR(msi->vector_base);
-	}
 
 	msi->vector_phy = res->start;
 
-- 
2.17.1

