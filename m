Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D59389EE2
	for <lists+linux-pci@lfdr.de>; Thu, 20 May 2021 09:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhETH35 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 May 2021 03:29:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4695 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhETH35 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 May 2021 03:29:57 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fm1Vh1qPSz16PlL;
        Thu, 20 May 2021 15:25:48 +0800 (CST)
Received: from dggpemm500009.china.huawei.com (7.185.36.225) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 15:28:34 +0800
Received: from huawei.com (10.174.185.226) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 20 May
 2021 15:28:34 +0800
From:   Wang Xingang <wangxingang5@huawei.com>
To:     <robh@kernel.org>, <will@kernel.org>, <joro@8bytes.org>,
        <lorenzo.pieralisi@arm.com>, <frowand.list@gmail.com>
CC:     <robh+dt@kernel.org>, <helgaas@kernel.org>,
        <gregkh@linuxfoundation.org>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <xieyingtai@huawei.com>,
        <wangxingang5@huawei.com>
Subject: [PATCH v3] iommu/of: Fix pci_request_acs() before enumerating PCI devices
Date:   Thu, 20 May 2021 07:28:28 +0000
Message-ID: <1621495708-40364-1-git-send-email-wangxingang5@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.185.226]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Xingang Wang <wangxingang5@huawei.com>

When booting with devicetree, the pci_request_acs() is called after the
enumeration and initialization of PCI devices, thus the ACS is not
enabled. And ACS should be enabled when IOMMU is detected for the
PCI host bridge, so add check for IOMMU before probe of PCI host and call
pci_request_acs() to make sure ACS will be enabled when enumerating PCI
devices.

Fixes: 6bf6c24720d33 ("iommu/of: Request ACS from the PCI core when
configuring IOMMU linkage")
Signed-off-by: Xingang Wang <wangxingang5@huawei.com>
---
 drivers/iommu/of_iommu.c                 |  1 -
 drivers/pci/controller/pci-host-common.c | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

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
diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index d3924a44db02..5904ad0bd9ae 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -49,6 +49,21 @@ static struct pci_config_window *gen_pci_init(struct device *dev,
 	return cfg;
 }
 
+static void pci_host_enable_acs(struct pci_host_bridge *bridge)
+{
+	struct device_node *np = bridge->dev.parent->of_node;
+	static bool acs_enabled;
+
+	if (!np || acs_enabled)
+		return;
+
+	/* Detect IOMMU and make sure ACS will be enabled */
+	if (of_property_read_bool(np, "iommu-map")) {
+		acs_enabled = true;
+		pci_request_acs();
+	}
+}
+
 int pci_host_common_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -81,6 +96,8 @@ int pci_host_common_probe(struct platform_device *pdev)
 	bridge->ops = (struct pci_ops *)&ops->pci_ops;
 	bridge->msi_domain = true;
 
+	pci_host_enable_acs(bridge);
+
 	return pci_host_probe(bridge);
 }
 EXPORT_SYMBOL_GPL(pci_host_common_probe);
-- 
2.19.1

