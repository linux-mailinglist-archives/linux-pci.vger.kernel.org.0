Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547EC53B3D8
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 08:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiFBGtz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 02:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiFBGty (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 02:49:54 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C85229B41;
        Wed,  1 Jun 2022 23:49:52 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LDGpV4mBKzKmHh;
        Thu,  2 Jun 2022 14:49:38 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (7.185.36.111) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 2 Jun 2022 14:49:50 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 2 Jun 2022 14:49:50 +0800
From:   Ke Liu <liuke94@huawei.com>
To:     <bhelgaas@google.com>
CC:     <nirmal.patel@linux.intel.com>, <jonathan.derrick@linux.dev>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ke Liu <liuke94@huawei.com>
Subject: [PATCH v2] drivers: pci: Directly use ida_alloc()/free()
Date:   Thu, 2 Jun 2022 07:11:15 +0000
Message-ID: <20220602071115.3833935-1-liuke94@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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
ida_simple_get()/ida_simple_remove().

Signed-off-by: Ke Liu <liuke94@huawei.com>
---
v2	fix sign-off name suggest by Bjorn Helgaas
---
 drivers/pci/controller/vmd.c   | 6 +++---
 drivers/pci/switch/switchtec.c | 7 +++----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 94a14a3d7e55..49c72c2d8fe7 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -894,7 +894,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		return -ENOMEM;
 
 	vmd->dev = dev;
-	vmd->instance = ida_simple_get(&vmd_instance_ida, 0, 0, GFP_KERNEL);
+	vmd->instance = ida_alloc(&vmd_instance_ida, GFP_KERNEL);
 	if (vmd->instance < 0)
 		return vmd->instance;
 
@@ -935,7 +935,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	return 0;
 
  out_release_instance:
-	ida_simple_remove(&vmd_instance_ida, vmd->instance);
+	ida_free(&vmd_instance_ida, vmd->instance);
 	kfree(vmd->name);
 	return err;
 }
@@ -958,7 +958,7 @@ static void vmd_remove(struct pci_dev *dev)
 	vmd_cleanup_srcu(vmd);
 	vmd_detach_resources(vmd);
 	vmd_remove_irq_domain(vmd);
-	ida_simple_remove(&vmd_instance_ida, vmd->instance);
+	ida_free(&vmd_instance_ida, vmd->instance);
 	kfree(vmd->name);
 }
 
diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index c36c1238c604..75be4fe22509 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1376,8 +1376,7 @@ static struct switchtec_dev *stdev_create(struct pci_dev *pdev)
 	dev->groups = switchtec_device_groups;
 	dev->release = stdev_release;
 
-	minor = ida_simple_get(&switchtec_minor_ida, 0, 0,
-			       GFP_KERNEL);
+	minor = ida_alloc(&switchtec_minor_ida, GFP_KERNEL);
 	if (minor < 0) {
 		rc = minor;
 		goto err_put;
@@ -1692,7 +1691,7 @@ static int switchtec_pci_probe(struct pci_dev *pdev,
 err_devadd:
 	stdev_kill(stdev);
 err_put:
-	ida_simple_remove(&switchtec_minor_ida, MINOR(stdev->dev.devt));
+	ida_free(&switchtec_minor_ida, MINOR(stdev->dev.devt));
 	put_device(&stdev->dev);
 	return rc;
 }
@@ -1704,7 +1703,7 @@ static void switchtec_pci_remove(struct pci_dev *pdev)
 	pci_set_drvdata(pdev, NULL);
 
 	cdev_device_del(&stdev->cdev, &stdev->dev);
-	ida_simple_remove(&switchtec_minor_ida, MINOR(stdev->dev.devt));
+	ida_free(&switchtec_minor_ida, MINOR(stdev->dev.devt));
 	dev_info(&stdev->dev, "unregistered.\n");
 	stdev_kill(stdev);
 	put_device(&stdev->dev);
-- 
2.25.1

