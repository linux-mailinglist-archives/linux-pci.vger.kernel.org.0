Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EBA60DDF0
	for <lists+linux-pci@lfdr.de>; Wed, 26 Oct 2022 11:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbiJZJWG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Oct 2022 05:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbiJZJV6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Oct 2022 05:21:58 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D219BA3AB3
        for <linux-pci@vger.kernel.org>; Wed, 26 Oct 2022 02:21:55 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4My3Cb3lSXzJn4W;
        Wed, 26 Oct 2022 17:19:07 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 17:21:54 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 26 Oct
 2022 17:21:53 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-pci@vger.kernel.org>
CC:     <bhelgaas@google.com>, <rafael.j.wysocki@intel.com>,
        <yinghai@kernel.org>, <yangyingliang@huawei.com>
Subject: [PATCH] PCI: fix possible null-ptr-deref in device_attach()
Date:   Wed, 26 Oct 2022 17:21:01 +0800
Message-ID: <20221026092101.619888-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

After commit 4f535093cf8f ("PCI: Put pci_dev in device tree as early
as possible"), pcibios_add_device() and device_add() are moved to
pci_device_add(), and it never return error code in error cases.

If pcibios_device_add() or device_add() returns error in pci_device_add(),
the 'dev->p' is not set which will lead null-ptr-deref in device_attach()
called by pci_bus_add_device().

Change return type of pci_device_add() to int, and handle error in it
if pcibios_device_add() or device_add() fails. So callers can check the
return value and handle it.

Fixes: 4f535093cf8f ("PCI: Put pci_dev in device tree as early as possible")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/pci/probe.c | 21 +++++++++++++++++----
 include/linux/pci.h |  2 +-
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 03b926d7c7ec..792dfee9cfd7 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2517,7 +2517,7 @@ static void pci_set_msi_domain(struct pci_dev *dev)
 	dev_set_msi_domain(&dev->dev, d);
 }
 
-void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
+int pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 {
 	int ret;
 
@@ -2552,7 +2552,8 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	up_write(&pci_bus_sem);
 
 	ret = pcibios_device_add(dev);
-	WARN_ON(ret < 0);
+	if (WARN_ON(ret < 0))
+		goto err;
 
 	/* Set up MSI IRQ domain */
 	pci_set_msi_domain(dev);
@@ -2560,7 +2561,16 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	/* Notifier could use PCI capabilities */
 	dev->match_driver = false;
 	ret = device_add(&dev->dev);
-	WARN_ON(ret < 0);
+	if (WARN_ON(ret < 0))
+		goto err;
+
+	return 0;
+
+err:
+	down_write(&pci_bus_sem);
+	list_del(&dev->bus_list);
+	up_write(&pci_bus_sem);
+	return ret;
 }
 
 struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn)
@@ -2577,7 +2587,10 @@ struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn)
 	if (!dev)
 		return NULL;
 
-	pci_device_add(dev, bus);
+	if (pci_device_add(dev, bus)) {
+		pci_dev_put(dev);
+		return NULL;
+	}
 
 	return dev;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2bda4a4e47e8..3292261ea9c8 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1124,7 +1124,7 @@ static inline void pci_dev_assign_slot(struct pci_dev *dev) { }
 #endif
 int pci_scan_slot(struct pci_bus *bus, int devfn);
 struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn);
-void pci_device_add(struct pci_dev *dev, struct pci_bus *bus);
+int pci_device_add(struct pci_dev *dev, struct pci_bus *bus);
 unsigned int pci_scan_child_bus(struct pci_bus *bus);
 void pci_bus_add_device(struct pci_dev *dev);
 void pci_read_bridge_bases(struct pci_bus *child);
-- 
2.25.1

