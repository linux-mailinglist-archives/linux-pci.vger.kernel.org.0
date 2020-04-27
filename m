Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F851BA1F2
	for <lists+linux-pci@lfdr.de>; Mon, 27 Apr 2020 13:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgD0LJe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 07:09:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43044 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726604AbgD0LJe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Apr 2020 07:09:34 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B77BD70DE93E6557A0F7;
        Mon, 27 Apr 2020 19:09:30 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Mon, 27 Apr 2020 19:09:24 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] PCI: dwc: pci-dra7xx: Fix potential NULL dereference in dra7xx_pcie_probe()
Date:   Mon, 27 Apr 2020 11:10:44 +0000
Message-ID: <20200427111044.162618-1-weiyongjun1@huawei.com>
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

platform_get_resource() may fail and return NULL, so we should
better check it's return value to avoid a NULL pointer dereference
a bit later in the code.

This is detected by Coccinelle semantic patch.

@@
expression pdev, res, n, t, e, e1, e2;
@@

res = \(platform_get_resource\|platform_get_resource_byname\)(pdev, t, n);
+ if (!res)
+   return -EINVAL;
... when != res == NULL
e = devm_ioremap(e1, res->start, e2);

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 3b0e58f2de58..7a3d12f7e7d9 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -878,6 +878,9 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ti_conf");
+	if (!res)
+		return -EINVAL;
+
 	base = devm_ioremap(dev, res->start, resource_size(res));
 	if (!base)
 		return -ENOMEM;





