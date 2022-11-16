Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A134D62B140
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 03:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiKPCZF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 21:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKPCZD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 21:25:03 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25B2275FF;
        Tue, 15 Nov 2022 18:25:02 -0800 (PST)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NBmyS3ttLzJnm0;
        Wed, 16 Nov 2022 10:21:52 +0800 (CST)
Received: from huawei.com (10.67.175.83) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 16 Nov
 2022 10:25:00 +0800
From:   ruanjinjie <ruanjinjie@huawei.com>
To:     <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <Sergey.Semin@baikalelectronics.ru>,
        <mani@kernel.org>, <kishon@ti.com>, <naveennaidu479@gmail.com>,
        <pali@kernel.org>, <ffclaire1224@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH] PCI: dwc: add missing free_irq() in ks_pcie_remove() and error path in ks_pcie_probe()
Date:   Wed, 16 Nov 2022 10:21:47 +0800
Message-ID: <20221116022147.2636355-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.83]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

free_irq() is missing in ks_pcie_remove() and some cases of error
in ks_pcie_probe(), fix that.

Fixes: 49229238ab47 ("PCI: keystone: Cleanup PHY handling")

Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 78818853af9e..fc854ccaf155 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1179,12 +1179,16 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 		num_lanes = 1;
 
 	phy = devm_kzalloc(dev, sizeof(*phy) * num_lanes, GFP_KERNEL);
-	if (!phy)
-		return -ENOMEM;
+	if (!phy) {
+		ret = -ENOMEM;
+		goto free_irq;
+	}
 
 	link = devm_kzalloc(dev, sizeof(*link) * num_lanes, GFP_KERNEL);
-	if (!link)
-		return -ENOMEM;
+	if (!link) {
+		ret = -ENOMEM;
+		goto free_irq;
+	}
 
 	for (i = 0; i < num_lanes; i++) {
 		snprintf(name, sizeof(name), "pcie-phy%d", i);
@@ -1300,6 +1304,8 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	while (--i >= 0 && link[i])
 		device_link_del(link[i]);
 
+free_irq:
+	free_irq(irq, ks_pcie);
 	return ret;
 }
 
@@ -1315,6 +1321,7 @@ static int __exit ks_pcie_remove(struct platform_device *pdev)
 	ks_pcie_disable_phy(ks_pcie);
 	while (num_lanes--)
 		device_link_del(link[num_lanes]);
+	free_irq(irq, ks_pcie);
 
 	return 0;
 }
-- 
2.25.1

