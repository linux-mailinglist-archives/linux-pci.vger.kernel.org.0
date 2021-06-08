Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD4439F12A
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jun 2021 10:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhFHIo4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Jun 2021 04:44:56 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:4401 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbhFHIo4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jun 2021 04:44:56 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FzkDb4mplz6vZS;
        Tue,  8 Jun 2021 16:39:11 +0800 (CST)
Received: from dggemi758-chm.china.huawei.com (10.1.198.144) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 16:42:53 +0800
Received: from huawei.com (10.175.101.6) by dggemi758-chm.china.huawei.com
 (10.1.198.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 8 Jun
 2021 16:42:53 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <jonnyc@amazon.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>,
        <chenxiaosong2@huawei.com>
Subject: [PATCH -next,resend] PCI: al: Remove redundant dev_err call in al_pcie_probe()
Date:   Tue, 8 Jun 2021 16:49:13 +0800
Message-ID: <20210608084913.1046606-1-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggemi758-chm.china.huawei.com (10.1.198.144)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 drivers/pci/controller/dwc/pcie-al.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-al.c b/drivers/pci/controller/dwc/pcie-al.c
index e8afa50129a8..fb4d1eed07ce 100644
--- a/drivers/pci/controller/dwc/pcie-al.c
+++ b/drivers/pci/controller/dwc/pcie-al.c
@@ -346,11 +346,8 @@ static int al_pcie_probe(struct platform_device *pdev)
 	controller_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 						      "controller");
 	al_pcie->controller_base = devm_ioremap_resource(dev, controller_res);
-	if (IS_ERR(al_pcie->controller_base)) {
-		dev_err(dev, "couldn't remap controller base %pR\n",
-			controller_res);
+	if (IS_ERR(al_pcie->controller_base))
 		return PTR_ERR(al_pcie->controller_base);
-	}
 
 	dev_dbg(dev, "From DT: controller_base: %pR\n", controller_res);
 
-- 
2.25.4

