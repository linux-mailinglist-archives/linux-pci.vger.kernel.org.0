Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F647382D22
	for <lists+linux-pci@lfdr.de>; Mon, 17 May 2021 15:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbhEQNSb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 09:18:31 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2999 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbhEQNSb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 May 2021 09:18:31 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FkKMY25FrzQnvD;
        Mon, 17 May 2021 21:13:45 +0800 (CST)
Received: from dggpemm500009.china.huawei.com (7.185.36.225) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 21:17:13 +0800
Received: from huawei.com (10.174.185.226) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 17 May
 2021 21:17:12 +0800
From:   Wang Xingang <wangxingang5@huawei.com>
To:     <will@kernel.org>, <joro@8bytes.org>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>
CC:     <helgaas@kernel.org>, <gregkh@linuxfoundation.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <xieyingtai@huawei.com>, <wangxingang5@huawei.com>
Subject: [PATCH v2] iommu/of: Fix pci_request_acs() before enumerating PCI devices
Date:   Mon, 17 May 2021 13:17:05 +0000
Message-ID: <1621257425-37856-1-git-send-email-wangxingang5@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.185.226]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Xingang Wang <wangxingang5@huawei.com>

When booting with devicetree, the pci_request_acs() is called after the
enumeration and initialization of PCI devices, thus the ACS is not
enabled. This patch add check for IOMMU in of_core_init(), and call
pci_request_acs() when iommu is detected, making sure that the ACS will
be enabled.

Fixes: 6bf6c24720d33 ("iommu/of: Request ACS from the PCI core when
configuring IOMMU linkage")
Signed-off-by: Xingang Wang <wangxingang5@huawei.com>
---
 drivers/iommu/of_iommu.c | 1 -
 drivers/of/base.c        | 9 ++++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

Change log:
v1->v2:
 - remove pci_request_acs() in of_iommu_configure
 - check and call pci_request_acs() in of_core_init()

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index a9d2df001149..54a14da242cc 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -205,7 +205,6 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 			.np = master_np,
 		};
 
-		pci_request_acs();
 		err = pci_for_each_dma_alias(to_pci_dev(dev),
 					     of_pci_iommu_init, &info);
 	} else {
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 48e941f99558..95cd8f0e5435 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -24,6 +24,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_graph.h>
+#include <linux/pci.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -166,7 +167,7 @@ void __of_phandle_cache_inv_entry(phandle handle)
 void __init of_core_init(void)
 {
 	struct device_node *np;
-
+	bool of_iommu_detect = false;
 
 	/* Create the kset, and register existing nodes */
 	mutex_lock(&of_mutex);
@@ -180,6 +181,12 @@ void __init of_core_init(void)
 		__of_attach_node_sysfs(np);
 		if (np->phandle && !phandle_cache[of_phandle_cache_hash(np->phandle)])
 			phandle_cache[of_phandle_cache_hash(np->phandle)] = np;
+
+		/* Detect IOMMU and make sure ACS will be enabled */
+		if (!of_iommu_detect && of_get_property(np, "iommu-map", NULL)) {
+			of_iommu_detect = true;
+			pci_request_acs();
+		}
 	}
 	mutex_unlock(&of_mutex);
 
-- 
2.19.1

