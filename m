Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783F438BCD1
	for <lists+linux-pci@lfdr.de>; Fri, 21 May 2021 05:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238789AbhEUDE5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 May 2021 23:04:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3637 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238785AbhEUDE4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 May 2021 23:04:56 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FmWZy32CnzmWcc;
        Fri, 21 May 2021 11:01:14 +0800 (CST)
Received: from dggpemm500009.china.huawei.com (7.185.36.225) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 11:03:31 +0800
Received: from huawei.com (10.174.185.226) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 21 May
 2021 11:03:30 +0800
From:   Wang Xingang <wangxingang5@huawei.com>
To:     <robh@kernel.org>, <will@kernel.org>, <joro@8bytes.org>,
        <helgaas@kernel.org>
CC:     <robh+dt@kernel.org>, <gregkh@linuxfoundation.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <xieyingtai@huawei.com>,
        <wangxingang5@huawei.com>
Subject: [PATCH v4] iommu/of: Fix pci_request_acs() before enumerating PCI devices
Date:   Fri, 21 May 2021 03:03:24 +0000
Message-ID: <1621566204-37456-1-git-send-email-wangxingang5@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.185.226]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
 drivers/iommu/of_iommu.c | 1 -
 drivers/pci/of.c         | 8 +++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

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
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index da5b414d585a..2313c3f848b0 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -581,9 +581,15 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
 
 int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
 {
-	if (!dev->of_node)
+	struct device_node *node = dev->of_node;
+
+	if (!node)
 		return 0;
 
+	/* Detect IOMMU and make sure ACS will be enabled */
+	if (of_property_read_bool(node, "iommu-map"))
+		pci_request_acs();
+
 	bridge->swizzle_irq = pci_common_swizzle;
 	bridge->map_irq = of_irq_parse_and_map_pci;
 
-- 
2.19.1

