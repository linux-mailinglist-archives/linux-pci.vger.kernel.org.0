Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB995359B9
	for <lists+linux-pci@lfdr.de>; Fri, 27 May 2022 08:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344648AbiE0G6k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 May 2022 02:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239313AbiE0G6k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 May 2022 02:58:40 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C409C5D93;
        Thu, 26 May 2022 23:58:38 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L8bFq3ml5z1JCPd;
        Fri, 27 May 2022 14:57:03 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (7.185.36.111) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 14:58:36 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 14:58:35 +0800
From:   keliu <liuke94@huawei.com>
To:     <nirmal.patel@linux.intel.com>, <jonathan.derrick@linux.dev>,
        <lorenzo.pieralisi@arm.com>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <kurt.schwemmer@microsemi.com>,
        <logang@deltatee.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     keliu <liuke94@huawei.com>
Subject: [PATCH] drivers: pci: Directly use ida_alloc()/free()
Date:   Fri, 27 May 2022 07:20:05 +0000
Message-ID: <20220527072005.2360176-1-liuke94@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
 drivers/pci/controller/vmd.c   | 6 +++---
 drivers/pci/switch/switchtec.c | 7 +++----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index eb05cceab964..efcb3a3ca65e 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -893,7 +893,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		return -ENOMEM;
 
 	vmd->dev = dev;
-	vmd->instance = ida_simple_get(&vmd_instance_ida, 0, 0, GFP_KERNEL);
+	vmd->instance = ida_alloc(&vmd_instance_ida, GFP_KERNEL);
 	if (vmd->instance < 0)
 		return vmd->instance;
 
@@ -934,7 +934,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	return 0;
 
  out_release_instance:
-	ida_simple_remove(&vmd_instance_ida, vmd->instance);
+	ida_free(&vmd_instance_ida, vmd->instance);
 	kfree(vmd->name);
 	return err;
 }
@@ -957,7 +957,7 @@ static void vmd_remove(struct pci_dev *dev)
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

