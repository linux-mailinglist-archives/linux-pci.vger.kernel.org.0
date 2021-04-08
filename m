Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79DD335847A
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 15:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhDHNTv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 09:19:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16419 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhDHNTv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Apr 2021 09:19:51 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FGMJH0G9jzkjfs;
        Thu,  8 Apr 2021 21:17:51 +0800 (CST)
Received: from code-website.localdomain (10.175.127.227) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 21:19:28 +0800
From:   ErKun Yang <yangerkun@huawei.com>
To:     <toan@os.amperecomputing.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>
Subject: [PATCH v2] PCI: xgene-msi: Remove redundant dev_err call in xgene_msi_probe()
Date:   Thu, 8 Apr 2021 21:27:51 +0800
Message-ID: <20210408132751.1198171-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

devm_ioremap_resource() internally calls __devm_ioremap_resource() which
is where error checking and handling is actually having place. So the
dev_err in xgene_msi_probe() seems redundant and remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
Signed-off-by: ErKun Yang <yangerkun@huawei.com>
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

