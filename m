Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC2F742B49
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jun 2023 19:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjF2Rb6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jun 2023 13:31:58 -0400
Received: from mail-bn8nam12on2072.outbound.protection.outlook.com ([40.107.237.72]:3168
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231989AbjF2Rbh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Jun 2023 13:31:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVVOk1mtcGw3hAgS6IeM992xx825vQU5dq2N/IRGDiiQj8g8qiHurX7sVleScNcgREh9quD0jSu7XA6v0Qu41S3SWomrXPvnoQcGk+FbEl9/FDxuOq5RySowIgLgPbBbG12K2GzsuCOGkfNLwpLz0nyu/A9Q07NsIgaFH0I0talKIW8Y/4wlfNelyofDTCtkBK++/DRbU7fuOVc24qTXB1Nroiil8E4DUF8nvPGCT4OANxbDZrEUHptH7FPU5LrPAUBCnc9h8c3xUKM1M8oBmrfDLb7jQbBDfPwHuoGUH0IUXkHjc113w+5z8WMfU/Wo06F+LUkM5XyfeEI76L8a8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnXGVADUDbzD5PUDX8Q7921oY36OEu3Owz9DxYFzUR0=;
 b=kKavPJ40VFHCC+z8gIQ60VkgBUiEMkL32vF3W7AVivXqkEQ5o9JWmqKZLYQaDk2xz9koNyFUIzw9XCr81i0IFyIFKNKRP1oAapYvaBNu2to9HrKlqiPSqyFqgQJyKa3vupfqntOBs1C8fbeHnKTHnYse55abHi3u+YSSdf/r9JSdPh7xlI4yQJYKS+Gw+dCdxiF8plK7EvAVYptN3JbQBzZ0y+KIc4rkPtfsfCZ5vGLg7vtuLTaY1Qw2o3fvYq9dF9E+eM7eMfQBqI+6HfVCYV++S1ikSvX5D96enPNtu8FSc4I+cFSnm8rG9u0Gk91H2BPTr+OZop0Vrl+DLrlIbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnXGVADUDbzD5PUDX8Q7921oY36OEu3Owz9DxYFzUR0=;
 b=yVPayezT9ePW6CCBbheTnJ5KQ5xBenDgLaasdpnZoZkvB3J4Cvf3mClL3aH9D8SswICPo431WglCdP8VGMCg3OcZVIxKxQFe1JRyzM0/IF0ZJ6rRXYVJfu6tTbNwx8ynij0ZVH6u99znhpWYC6OpbriibEcY36pW/tQB1jEAsYk=
Received: from BN9PR03CA0199.namprd03.prod.outlook.com (2603:10b6:408:f9::24)
 by BY5PR12MB4273.namprd12.prod.outlook.com (2603:10b6:a03:212::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 17:31:34 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::73) by BN9PR03CA0199.outlook.office365.com
 (2603:10b6:408:f9::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Thu, 29 Jun 2023 17:31:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.49 via Frontend Transport; Thu, 29 Jun 2023 17:31:33 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 29 Jun
 2023 12:31:33 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 29 Jun
 2023 10:31:33 -0700
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 29 Jun 2023 12:31:32 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <stefano.stabellini@xilinx.com>
Subject: [PATCH V10 5/5] of: unittest: Add pci_dt_testdrv pci driver
Date:   Thu, 29 Jun 2023 10:19:50 -0700
Message-ID: <1688059190-4225-6-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1688059190-4225-1-git-send-email-lizhi.hou@amd.com>
References: <1688059190-4225-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT041:EE_|BY5PR12MB4273:EE_
X-MS-Office365-Filtering-Correlation-Id: ef37c43e-595c-460f-7834-08db78c6af09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LneLKef9rbblLYYrbqceX8HoGJYYS5cXmbnJ35drsFITq/5+KorlfrNk8OU9EhyY5lAfDziwimPoKQ67XEhgaUJ+S5/wFzuxghyYWD5gsSRp9ZcudhZrRdJKNlnlKQ7ob7y+zL3goDfv/IsgXwGlMBnJ2HD1Sp2wASAJsVo14hl8yIN2lUSFkKQh1j6o3M8lmkO8kCiTmrq42bz61nwVXchIslT4VfMYoN+1PUyZnb7YZlkdnfBrSsgDdrKOajbqizBCrpkSrWhTgZt11Wj/zPh1U0t/eDjYuXfkDaS8+mAxEY/QDGtkZc92BDF0QlrNEXSfbYo0JgwUwk7VEWG5JyGUPalFReLB6MyZMLeuLkRiAC3WTExjl4/klZlituymShvDU1KiBW8RRm24SLUQDsjjmokyyoySSX22dgx6lvlOshoMGFTQo+ER34BUZXIpJifVZxsLTzXm5x9azoC0TVSu74SxTUZDhBZ7hA4JHiNMzcgTNC3MeypoOU9upLljYVdBeR+mahY4oMHlOraihs2jZt/Q40zQaaBW5/YCQfyc/OLidtDRpleGNeSymGhmltPada9/SAfMlemg3rHFvWStcyyf6mXFMAPKNNWBP+FJtR9x8NHgJjnxhLi9nGKvQwnhka9VHR/xKRf74w4TSsN5FxObcnupxN7e/xgeXT7EMBe1Pq6klHdy1SoSmmiUSIaBL7t1GKaM70vQBs6OMAI+H7fpBF3+tdVjCyc/d3gkKaW97LIPEma3g41W+XVJQtwC8Iv+eobtJm88O9x3rg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199021)(36840700001)(46966006)(40470700004)(36756003)(82310400005)(36860700001)(81166007)(40480700001)(70206006)(40460700003)(82740400003)(356005)(86362001)(44832011)(5660300002)(316002)(41300700001)(4326008)(8936002)(8676002)(70586007)(47076005)(478600001)(186003)(2906002)(26005)(336012)(426003)(83380400001)(110136005)(6666004)(54906003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 17:31:33.8079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef37c43e-595c-460f-7834-08db78c6af09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4273
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
 drivers/of/unittest.c                         | 189 ++++++++++++++++++
 drivers/pci/quirks.c                          |   1 +
 4 files changed, 214 insertions(+), 1 deletion(-)
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
index 4a0774954b93..ead54e47c063 100644
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
@@ -3757,6 +3760,191 @@ static inline __init void of_unittest_overlay_high_level(void) {}
 
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
+		 (u64)res->start, exp_addr);
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
+	unittest(of_unittest_pci_dev_num,
+		 "No test PCI device been found. Please run QEMU with '-device pci-testdev'\n");
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
@@ -3807,6 +3995,7 @@ static int __init of_unittest(void)
 	of_unittest_platform_populate();
 	of_unittest_overlay();
 	of_unittest_lifecycle();
+	of_unittest_pci_node();
 
 	/* Double check linkage after removing testcase data */
 	of_unittest_check_tree_linkage();
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7776012eb03f..24860e1b76d4 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6053,3 +6053,4 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
  */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
-- 
2.34.1

