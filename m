Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A09F35836F
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 14:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhDHMjo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 08:39:44 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16408 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbhDHMjo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Apr 2021 08:39:44 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FGLQ00JCvzkhqs;
        Thu,  8 Apr 2021 20:37:44 +0800 (CST)
Received: from code-website.localdomain (10.175.127.227) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 20:39:21 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <toan@os.amperecomputing.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>
Subject: [PATCH] PCI: xgene-msi: Remove redundant dev_err call in xgene_msi_probe()
Date:   Thu, 8 Apr 2021 20:47:45 +0800
Message-ID: <20210408124745.1108948-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: ErKun Yang <yangerkun@huawei.com>

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Erkun Yang<yangerkun@huawei.com>
---
 drivers/pci/controller/pci-xgene-msi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
index 1c34c897a7e2..369b50f626fd 100644
--- a/drivers/pci/controller/pci-xgene-msi.c
+++ b/drivers/pci/controller/pci-xgene-msi.c
@@ -451,7 +451,6 @@ static int xgene_msi_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	xgene_msi->msi_regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(xgene_msi->msi_regs)) {
-		dev_err(&pdev->dev, "no reg space\n");
 		rc = PTR_ERR(xgene_msi->msi_regs);
 		goto error;
 	}
-- 
2.25.4

