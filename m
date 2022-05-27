Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC59535B45
	for <lists+linux-pci@lfdr.de>; Fri, 27 May 2022 10:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243751AbiE0IS3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 May 2022 04:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbiE0IS2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 May 2022 04:18:28 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42361EC3F6;
        Fri, 27 May 2022 01:18:27 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L8d1w49BGz1JCR4;
        Fri, 27 May 2022 16:16:52 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (7.185.36.111) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 16:18:25 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 16:18:24 +0800
From:   keliu <liuke94@huawei.com>
To:     <scott.branden@broadcom.com>,
        <bcm-kernel-feedback-list@broadcom.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <gustavo.pimentel@synopsys.com>,
        <kishon@ti.com>, <lorenzo.pieralisi@arm.com>, <kw@linux.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     keliu <liuke94@huawei.com>
Subject: [PATCH] drivers: misc: Directly use ida_alloc()/free()
Date:   Fri, 27 May 2022 08:39:53 +0000
Message-ID: <20220527083953.2636843-1-liuke94@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500018.china.huawei.com (7.185.36.111)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use ida_alloc()/ida_free() instead of deprecated
ida_simple_get()/ida_simple_remove() .

Signed-off-by: keliu <liuke94@huawei.com>
---
 drivers/misc/bcm-vk/bcm_vk_dev.c | 6 +++---
 drivers/misc/dw-xdata-pcie.c     | 6 +++---
 drivers/misc/pci_endpoint_test.c | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
index a16b99bdaa13..a3a82ebbc699 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -1401,7 +1401,7 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		bcm_vk_tty_set_irq_enabled(vk, i);
 	}
 
-	id = ida_simple_get(&bcm_vk_ida, 0, 0, GFP_KERNEL);
+	id = ida_alloc(&bcm_vk_ida, GFP_KERNEL);
 	if (id < 0) {
 		err = id;
 		dev_err(dev, "unable to get id\n");
@@ -1500,7 +1500,7 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	misc_device->name = NULL;
 
 err_ida_remove:
-	ida_simple_remove(&bcm_vk_ida, id);
+	ida_free(&bcm_vk_ida, id);
 
 err_irq:
 	for (i = 0; i < vk->num_irqs; i++)
@@ -1573,7 +1573,7 @@ static void bcm_vk_remove(struct pci_dev *pdev)
 	if (misc_device->name) {
 		misc_deregister(misc_device);
 		kfree(misc_device->name);
-		ida_simple_remove(&bcm_vk_ida, vk->devid);
+		ida_free(&bcm_vk_ida, vk->devid);
 	}
 	for (i = 0; i < vk->num_irqs; i++)
 		devm_free_irq(&pdev->dev, pci_irq_vector(pdev, i), vk);
diff --git a/drivers/misc/dw-xdata-pcie.c b/drivers/misc/dw-xdata-pcie.c
index 257c25da5199..59617d92a0a3 100644
--- a/drivers/misc/dw-xdata-pcie.c
+++ b/drivers/misc/dw-xdata-pcie.c
@@ -333,7 +333,7 @@ static int dw_xdata_pcie_probe(struct pci_dev *pdev,
 
 	dw->pdev = pdev;
 
-	id = ida_simple_get(&xdata_ida, 0, 0, GFP_KERNEL);
+	id = ida_(&xdata_ida, GFP_KERNEL);
 	if (id < 0) {
 		dev_err(dev, "xData: unable to get id\n");
 		return id;
@@ -377,7 +377,7 @@ static int dw_xdata_pcie_probe(struct pci_dev *pdev,
 	kfree(dw->misc_dev.name);
 
 err_ida_remove:
-	ida_simple_remove(&xdata_ida, id);
+	ida_free(&xdata_ida, id);
 
 	return err;
 }
@@ -396,7 +396,7 @@ static void dw_xdata_pcie_remove(struct pci_dev *pdev)
 	dw_xdata_stop(dw);
 	misc_deregister(&dw->misc_dev);
 	kfree(dw->misc_dev.name);
-	ida_simple_remove(&xdata_ida, id);
+	ida_free(&xdata_ida, id);
 }
 
 static const struct pci_device_id dw_xdata_pcie_id_table[] = {
diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 8f786a225dcf..d909a3f94566 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -838,7 +838,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 
 	pci_set_drvdata(pdev, test);
 
-	id = ida_simple_get(&pci_endpoint_test_ida, 0, 0, GFP_KERNEL);
+	id = ida_alloc(&pci_endpoint_test_ida, GFP_KERNEL);
 	if (id < 0) {
 		err = id;
 		dev_err(dev, "Unable to get id\n");
@@ -885,7 +885,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	kfree(test->name);
 
 err_ida_remove:
-	ida_simple_remove(&pci_endpoint_test_ida, id);
+	ida_free(&pci_endpoint_test_ida, id);
 
 err_iounmap:
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
@@ -918,7 +918,7 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 	misc_deregister(&test->miscdev);
 	kfree(misc_device->name);
 	kfree(test->name);
-	ida_simple_remove(&pci_endpoint_test_ida, id);
+	ida_free(&pci_endpoint_test_ida, id);
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
 		if (test->bar[bar])
 			pci_iounmap(pdev, test->bar[bar]);
-- 
2.25.1

