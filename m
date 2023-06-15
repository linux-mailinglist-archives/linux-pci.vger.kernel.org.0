Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4D3731E81
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jun 2023 18:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237799AbjFOQwn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jun 2023 12:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237788AbjFOQv3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jun 2023 12:51:29 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::61a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448142D73;
        Thu, 15 Jun 2023 09:51:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+h2V+eylJinqMMUqEfv+D3yu4iVF19nH5c3N6doHPhDIL+i5Fm5XcNl46U9no/fkeVc4/V4eBENsxQERRxIhBXfC8UMUttdUYg+yWW9i6leyedWkeGYlLDhenZucvuXojQKJm/xSTmlGO59R6XK5TpgxzZT3ymbHe+/MTtmSFhNr2Cr+9XOovvyCl0tYCUD4BRhxP0pc+msTGbbLquiwxwH3DZt8t/zGJsqKnzPbNbUx4GRl/F3iUcPYaMc9ydrIzwqpYz84IyxROWnMcwU2eaajwlyR8N2BOf5v7QnLmlkCku6gJ1PykMqoW21NE6TEtY24a1w6Z66M5Vj7MCa9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jTSUgrEOJPzz+JBGJltnntUGq0K5ay6Dtgklu6/zIc=;
 b=OVlrSSA0jxeTYjdGQbPLRhCvRXdxk9rRKVdFkXW/tfOcUg0E5jlh4cu0WTkV1244cL3f1ylttjO7XtE8fIhsU0+QMfVqaHvcZdOxQCXLpKfE3Iii+GJ16RWdxtFwRhPYY+aR4HUwNpnq6oiX/AK9t6gKizZ4U8ALFA88MTjWUjNZwIKqWq6FVpfQ33KZHKN0AZ8YTi9OUeiIa8ju29lvq9oqljziOVAJ/uR80emLxIIiQ5K3wzpSQfYrzWuKwlN/cwFcvdi0Ox9HV4FeWA3BuaShUXekX08dvtv8du+AzutlpES5r1JVoQTkgrbCWsMtCf2snqNqhUPqwyugZ27hLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jTSUgrEOJPzz+JBGJltnntUGq0K5ay6Dtgklu6/zIc=;
 b=HWoOz1Y720KS/q/Wxw1mvLowrcibjanADg6OvvGpD4ayN7o2QqZf5EKzpXci/tSy5rJZCwtqSNdflYDJmnCvpihipgYJCLpOk2SudjrjPm2a3lMIwiSWkaPPGSt21Jow9LAp+z3Rsv/dx9B/RdqH84wRvc6zidca6UTjwmGnlPI=
Received: from BYAPR07CA0073.namprd07.prod.outlook.com (2603:10b6:a03:12b::14)
 by SN7PR12MB8129.namprd12.prod.outlook.com (2603:10b6:806:323::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 16:51:20 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:12b:cafe::6d) by BYAPR07CA0073.outlook.office365.com
 (2603:10b6:a03:12b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25 via Frontend
 Transport; Thu, 15 Jun 2023 16:51:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.27 via Frontend Transport; Thu, 15 Jun 2023 16:51:19 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 11:51:18 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 15 Jun
 2023 09:51:18 -0700
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 15 Jun 2023 11:51:17 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <stefano.stabellini@xilinx.com>
Subject: [PATCH V9 6/6] of: unittest: Add pci_dt_testdrv pci driver
Date:   Thu, 15 Jun 2023 09:50:42 -0700
Message-ID: <1686847842-33780-7-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1686847842-33780-1-git-send-email-lizhi.hou@amd.com>
References: <1686847842-33780-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|SN7PR12MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: caaa430e-f37b-4d88-927f-08db6dc0be09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NARltVF1U18P5Hg6A0hXFSx9gya8NwG93i/FtAfp3xONR1wBr1aYgrXzh9qSopgryBbWMvxk1lAjnVApC3aTI25P98kn7dgab9WEAKulVsNHcQQ9Mcn5AFvLhZa1uYx7X/nYz0IYzlGz/u9M9f1PBJjbloG5Sv6ORVNwRteO6do1x0z0oqcYBsD0eAKCz54Fn9tGsiU7bnHRw73/NsWFlw4l5CbJdU3EHCeosOJk52tR42rRdrkmEyQL5n0n43Pw2W45EwDVz8e8Qi0M4bNj+QpSvBMdU379SZl6cadcCiJYYYPoIuNsRawI+muIGgoHxk9gmhyFnbY4UXHBqdlROBUvMjsj7tAYJT0Fgh9kDwXkMiSQoWLK1fPpf6yXp0lqWG4BekqjBkxBvkHBXD1IPIJ30QItWc1wyV/Y1CJahj2axtAbhtybzA/Z7dqPFZALs10JT1f+KKTj/m+gHOpAI304kf2YqQiAI2DmiER4OCJcSW95XHCEQxPS5lIpfjehO2MHkl/8FIUypSd/6P6o3pFdeHc84yIhR1Qo2OKEalcb6ed9sRaZi2zDhvi8bCaabhDIFt/ucjvDUUvhDv6XokhvJ7L8Gku/YqkMMG339gzf7LmpTE3gJuwq5b6KBsAVV0u4gMbUh/tTKlJebhcDFabUeSLKn1Hi0PLSRNkRW+GwLZKLJdf3RKXeKfOT9Bu5NsbZusskm777popAWfQ9obMjLDiciHpowyCkQLTH/rUX06/2ftzj8shMi1iT7r9OxkkDUJldT5BJw2NcFvl7Qw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199021)(40470700004)(46966006)(36840700001)(44832011)(40480700001)(70586007)(70206006)(36756003)(4326008)(316002)(2906002)(5660300002)(40460700003)(8936002)(8676002)(41300700001)(110136005)(47076005)(54906003)(86362001)(82310400005)(478600001)(6666004)(26005)(36860700001)(186003)(82740400003)(81166007)(356005)(336012)(83380400001)(426003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 16:51:19.0941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caaa430e-f37b-4d88-927f-08db6dc0be09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8129
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_dt_testdrv is bound to QEMU PCI Test Device. It reads
overlay_pci_node fdt fragment and apply it to Test Device. Then it
calls of_platform_default_populate() to populate the platform
devices.

Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/of/unittest-data/Makefile             |   3 +-
 .../of/unittest-data/overlay_pci_node.dtso    |  22 ++
 drivers/of/unittest.c                         | 188 ++++++++++++++++++
 3 files changed, 212 insertions(+), 1 deletion(-)
 create mode 100644 drivers/of/unittest-data/overlay_pci_node.dtso

diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
index ea5f4da68e23..1aa875088159 100644
--- a/drivers/of/unittest-data/Makefile
+++ b/drivers/of/unittest-data/Makefile
@@ -32,7 +32,8 @@ obj-$(CONFIG_OF_OVERLAY) += overlay.dtbo.o \
 			    overlay_gpio_02b.dtbo.o \
 			    overlay_gpio_03.dtbo.o \
 			    overlay_gpio_04a.dtbo.o \
-			    overlay_gpio_04b.dtbo.o
+			    overlay_gpio_04b.dtbo.o \
+			    overlay_pci_node.dtbo.o
 
 # enable creation of __symbols__ node
 DTC_FLAGS_overlay += -@
diff --git a/drivers/of/unittest-data/overlay_pci_node.dtso b/drivers/of/unittest-data/overlay_pci_node.dtso
new file mode 100644
index 000000000000..c05e52e9e44a
--- /dev/null
+++ b/drivers/of/unittest-data/overlay_pci_node.dtso
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/ {
+	fragment@0 {
+		target-path="";
+		__overlay__ {
+			#address-cells = <3>;
+			#size-cells = <2>;
+			pci-ep-bus@0 {
+				compatible = "simple-bus";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0x0 0x0 0x0 0x1000>;
+				reg = <0 0 0 0 0>;
+				unittest-pci@100 {
+					compatible = "unittest-pci";
+					reg = <0x100 0x200>;
+				};
+			};
+		};
+	};
+};
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 4a0774954b93..e21f0bdc1b85 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
+#include <linux/pci.h>
 #include <linux/kernel.h>
 
 #include <linux/i2c.h>
@@ -3352,6 +3353,7 @@ OVERLAY_INFO_EXTERN(overlay_gpio_02b);
 OVERLAY_INFO_EXTERN(overlay_gpio_03);
 OVERLAY_INFO_EXTERN(overlay_gpio_04a);
 OVERLAY_INFO_EXTERN(overlay_gpio_04b);
+OVERLAY_INFO_EXTERN(overlay_pci_node);
 OVERLAY_INFO_EXTERN(overlay_bad_add_dup_node);
 OVERLAY_INFO_EXTERN(overlay_bad_add_dup_prop);
 OVERLAY_INFO_EXTERN(overlay_bad_phandle);
@@ -3387,6 +3389,7 @@ static struct overlay_info overlays[] = {
 	OVERLAY_INFO(overlay_gpio_03, 0),
 	OVERLAY_INFO(overlay_gpio_04a, 0),
 	OVERLAY_INFO(overlay_gpio_04b, 0),
+	OVERLAY_INFO(overlay_pci_node, 0),
 	OVERLAY_INFO(overlay_bad_add_dup_node, -EINVAL),
 	OVERLAY_INFO(overlay_bad_add_dup_prop, -EINVAL),
 	OVERLAY_INFO(overlay_bad_phandle, -EINVAL),
@@ -3757,6 +3760,190 @@ static inline __init void of_unittest_overlay_high_level(void) {}
 
 #endif
 
+#ifdef CONFIG_PCI_DYNAMIC_OF_NODES
+
+int of_unittest_pci_dev_num;
+int of_unittest_pci_child_num;
+
+/*
+ * PCI device tree node test driver
+ */
+static const struct pci_device_id testdrv_pci_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT, 0x5), }, /* PCI_VENDOR_ID_REDHAT */
+	{ 0, }
+};
+
+static int testdrv_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct overlay_info *info;
+	struct device_node *dn;
+	int ret, ovcs_id;
+	u32 size;
+
+	dn = pdev->dev.of_node;
+	if (!dn) {
+		dev_err(&pdev->dev, "does not find bus endpoint");
+		return -EINVAL;
+	}
+
+	for (info = overlays; info && info->name; info++) {
+		if (!strcmp(info->name, "overlay_pci_node"))
+			break;
+	}
+	if (!info || !info->name) {
+		dev_err(&pdev->dev, "no overlay data for overlay_pci_node");
+		return -ENODEV;
+	}
+
+	size = info->dtbo_end - info->dtbo_begin;
+	ret = of_overlay_fdt_apply(info->dtbo_begin, size, &ovcs_id, dn);
+	of_node_put(dn);
+	if (ret)
+		return ret;
+
+	of_platform_default_populate(dn, NULL, &pdev->dev);
+	pci_set_drvdata(pdev, (void *)(uintptr_t)ovcs_id);
+
+	return 0;
+}
+
+static void testdrv_remove(struct pci_dev *pdev)
+{
+	int ovcs_id = (int)(uintptr_t)pci_get_drvdata(pdev);
+
+	of_platform_depopulate(&pdev->dev);
+	of_overlay_remove(&ovcs_id);
+}
+
+static struct pci_driver testdrv_driver = {
+	.name = "pci_dt_testdrv",
+	.id_table = testdrv_pci_ids,
+	.probe = testdrv_probe,
+	.remove = testdrv_remove,
+};
+
+static int unittest_pci_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct device *dev;
+	u64 exp_addr;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	dev = &pdev->dev;
+	while (dev && !dev_is_pci(dev))
+		dev = dev->parent;
+	if (!dev) {
+		pr_err("unable to find parent device\n");
+		return -ENODEV;
+	}
+
+	exp_addr = pci_resource_start(to_pci_dev(dev), 0) + 0x100;
+	unittest(res->start == exp_addr, "Incorrect translated address %llx, expected %llx\n",
+		 res->start, exp_addr);
+
+	of_unittest_pci_child_num++;
+
+	return 0;
+}
+
+static const struct of_device_id unittest_pci_of_match[] = {
+	{ .compatible = "unittest-pci" },
+	{ }
+};
+
+static struct platform_driver unittest_pci_driver = {
+	.probe = unittest_pci_probe,
+	.driver = {
+		.name = "unittest-pci",
+		.of_match_table = unittest_pci_of_match,
+	},
+};
+
+static int of_unittest_pci_node_verify(struct pci_dev *pdev, bool add)
+{
+	struct device_node *pnp, *np = NULL;
+	struct device *child_dev;
+	char *path = NULL;
+	const __be32 *reg;
+	int rc = 0;
+
+	pnp = pdev->dev.of_node;
+	unittest(pnp, "Failed creating PCI dt node\n");
+	if (!pnp)
+		return -ENODEV;
+
+	if (add) {
+		path = kasprintf(GFP_KERNEL, "%pOF/pci-ep-bus@0/unittest-pci@100", pnp);
+		np = of_find_node_by_path(path);
+		unittest(np, "Failed to get unittest-pci node under PCI node\n");
+		if (!np) {
+			rc = -ENODEV;
+			goto failed;
+		}
+
+		reg = of_get_property(np, "reg", NULL);
+		unittest(reg, "Failed to get reg property\n");
+		if (!reg)
+			rc = -ENODEV;
+	} else {
+		path = kasprintf(GFP_KERNEL, "%pOF/pci-ep-bus@0", pnp);
+		np = of_find_node_by_path(path);
+		unittest(!np, "Child device tree node is not removed\n");
+		child_dev = device_find_any_child(&pdev->dev);
+		unittest(!child_dev, "Child device is not removed\n");
+	}
+
+failed:
+	kfree(path);
+	if (np)
+		of_node_put(np);
+
+	return rc;
+}
+
+static void __init of_unittest_pci_node(void)
+{
+	struct pci_dev *pdev = NULL;
+	int rc;
+
+	rc = pci_register_driver(&testdrv_driver);
+	unittest(!rc, "Failed to register pci test driver; rc = %d\n", rc);
+	if (rc)
+		return;
+
+	rc = platform_driver_register(&unittest_pci_driver);
+	if (unittest(!rc, "Failed to register unittest pci driver\n")) {
+		pci_unregister_driver(&testdrv_driver);
+		return;
+	}
+
+	while ((pdev = pci_get_device(PCI_VENDOR_ID_REDHAT, 0x5, pdev)) != NULL) {
+		of_unittest_pci_node_verify(pdev, true);
+		of_unittest_pci_dev_num++;
+	}
+	if (pdev)
+		pci_dev_put(pdev);
+
+	unittest(of_unittest_pci_dev_num, "No test PCI device been found\n");
+	unittest(of_unittest_pci_dev_num == of_unittest_pci_child_num,
+		 "Child device number %d is not expected %d", of_unittest_pci_child_num,
+		 of_unittest_pci_dev_num);
+
+	platform_driver_unregister(&unittest_pci_driver);
+	pci_unregister_driver(&testdrv_driver);
+
+	while ((pdev = pci_get_device(PCI_VENDOR_ID_REDHAT, 0x5, pdev)) != NULL)
+		of_unittest_pci_node_verify(pdev, false);
+	if (pdev)
+		pci_dev_put(pdev);
+}
+#else
+static void __init of_unittest_pci_node(void) { }
+#endif
+
 static int __init of_unittest(void)
 {
 	struct device_node *np;
@@ -3807,6 +3994,7 @@ static int __init of_unittest(void)
 	of_unittest_platform_populate();
 	of_unittest_overlay();
 	of_unittest_lifecycle();
+	of_unittest_pci_node();
 
 	/* Double check linkage after removing testcase data */
 	of_unittest_check_tree_linkage();
-- 
2.34.1

