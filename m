Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2DC7672E4
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jul 2023 19:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbjG1RHR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jul 2023 13:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235680AbjG1RHM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jul 2023 13:07:12 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B4235B3;
        Fri, 28 Jul 2023 10:07:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mopTpLgaOiroz8rOlFFX7y3sPp5/kOLFdvbzJ1NIkGuk3pTzHmovw33zqp7E/OS7y8nRnM7BzpTss+RVymR07naCRolTdQFkPTz3xDZowe0nwr0343ycY9t8zVzIlfVAbjW6Trdt2OqVG0XJgOxf4YthWaq7cvX8xXtIYQYxclNjh800X7BNFkRveeaNgfinMAa1xiyVPcqI+XOma+Kxsd/Nfd2azo4AyMFoKa0UA6Th+rJK7ajqJWVatW+s0ixzqQFw8kyTzL2ioxgR8iBUsZU/r7l9Fnl6+A/gTGROfsTb/ylvboE0gUC2qSZsyeOEmKAyiwwzF4NM1jvRON+e6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjXllyAyHppdTnvS6sbsaIuNb2aA8ZEh9Ydwdm5jURs=;
 b=InuHw61G6CsutH+UXg/1MWONbPG8lpBGe4v/K3aN6xmdNCuTsJGOtoS4l31y2ukVltRt5yN+43tXBElXVU8G2wuR71A2EsmXBIDvg+IN0cP6+zPYUFWKm4TOLS3nWkB0WxaeW5f/yIE3a4gisJcno0tbtIuSxU/OWIozCgE92MgtBjwj9slDXY533OHsVmR+hO6LT8NzFTqQJ3+IV7Ott+srtlPVXVOJeZbQBE/F8xkSXLFm5BBU9lcw4/xtZGho7/js+LM4uDSQBFUvViJeFga7X9mqQsNjHZI4kNn7gH98gBRZQNmwEonmZkkob3hVpU1TyJmW/pV4DyaehOqZbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjXllyAyHppdTnvS6sbsaIuNb2aA8ZEh9Ydwdm5jURs=;
 b=EFUbJG9KKRTslf9HZ4HIcX259sg24MKDsfL02Pmx6OTt9Z+Z5d80ty/N9rfexusQh6BGcYbpklxrYBf/+bRteYcZ7YBq13SzegB1F5DpfmhNLvi9DjxiLBpLlGhfQjYJ7nYuUYD75n5t7Ael2qooz/hUtUkr6m2vZlD6JsaNyCo=
Received: from BN6PR17CA0047.namprd17.prod.outlook.com (2603:10b6:405:75::36)
 by DS7PR12MB5935.namprd12.prod.outlook.com (2603:10b6:8:7e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 17:07:06 +0000
Received: from BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::c) by BN6PR17CA0047.outlook.office365.com
 (2603:10b6:405:75::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 17:07:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT086.mail.protection.outlook.com (10.13.176.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 17:07:06 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 12:07:05 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 12:07:05 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 28 Jul 2023 12:07:04 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <stefano.stabellini@xilinx.com>
Subject: [PATCH V12 5/5] of: unittest: Add pci_dt_testdrv pci driver
Date:   Fri, 28 Jul 2023 10:06:58 -0700
Message-ID: <1690564018-11142-6-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1690564018-11142-1-git-send-email-lizhi.hou@amd.com>
References: <1690564018-11142-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT086:EE_|DS7PR12MB5935:EE_
X-MS-Office365-Filtering-Correlation-Id: ac3f8f50-99ce-458c-b70c-08db8f8d124a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N6v/B8iZJXozmoDHTLqBYRwwLsmSLFwwhVdDQvrVx3ydQw0hZ2CfkygFz/ydA1a8OH082ffx/42P9gf6286fmRSfHdEaKnPIo+h8t45KE1TVjRoLFYN/6m0SPiVyulNCHk1fruvCM5RZGr81C/8yhASJvd1xIWwcO/EPp7NgUmC/PfT6A70a7oD3Kl8ZW+vX+7tP1ssoVOvkQmYFhi+WoI3p0ac136eTAd2gxzqS3SE1KMjT3jgWhpkvlcZURZ8cE0r3upyelTzQkqZ0uuj3CcPzx1HNp2luEDHEvyuGrelZ4ZtFWHhEzhY1+XocW9e+hgqp5Bu6v2Bx0bEBkgDnGbFejUvZuwuU9waGjHNo4qv34aUm+ZVRx2+yF4z31mqvhBtNpz3ZLmLzY4iX7T8Q2RgoPUHyFPwkAclJOC7MATchc0haYWy+dbS1Jfq1m+MYb4LoZvvJ6fee4wmenEqkxPquCRbtYQtEvg6qVSmXKBod8GUjazNwdxWZomFhP1qL/6UCW4i/jcWSGE/KE3XAIBoSfoR2kSbN/i70mUJtzPrF9tikXq9m2WgQT7T+en52cvkHkmFsQyEvUuhNE5SrPHtwJ2WmTe13VSUqTPygrgCtp/TTLrF8o4U7DL91QjPkXCNxKecTDpgpDUAlpnywpizr5P2yKR8KeXLgY5KIFDUJ7a9SoWHNygteJ8V2W/3bKB4qlZ460Fzc2E5LvFRWApLsPefChoNlE2JAHZKAMAACAogq3YLrAPaCJm5RZHeFDABHHIp7JBD1HuHCpVwtVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(110136005)(54906003)(6666004)(478600001)(83380400001)(36860700001)(40480700001)(36756003)(86362001)(40460700003)(2906002)(47076005)(336012)(2616005)(82740400003)(186003)(26005)(70206006)(426003)(70586007)(81166007)(316002)(5660300002)(44832011)(41300700001)(8936002)(8676002)(356005)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 17:07:06.2635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3f8f50-99ce-458c-b70c-08db8f8d124a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5935
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
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

Tested-by: Herve Codina <herve.codina@bootlin.com>
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
index 7bff6c4cb653..f9895ea832f3 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
+#include <linux/pci.h>
 #include <linux/kernel.h>
 
 #include <linux/i2c.h>
@@ -3324,6 +3325,7 @@ OVERLAY_INFO_EXTERN(overlay_gpio_02b);
 OVERLAY_INFO_EXTERN(overlay_gpio_03);
 OVERLAY_INFO_EXTERN(overlay_gpio_04a);
 OVERLAY_INFO_EXTERN(overlay_gpio_04b);
+OVERLAY_INFO_EXTERN(overlay_pci_node);
 OVERLAY_INFO_EXTERN(overlay_bad_add_dup_node);
 OVERLAY_INFO_EXTERN(overlay_bad_add_dup_prop);
 OVERLAY_INFO_EXTERN(overlay_bad_phandle);
@@ -3359,6 +3361,7 @@ static struct overlay_info overlays[] = {
 	OVERLAY_INFO(overlay_gpio_03, 0),
 	OVERLAY_INFO(overlay_gpio_04a, 0),
 	OVERLAY_INFO(overlay_gpio_04b, 0),
+	OVERLAY_INFO(overlay_pci_node, 0),
 	OVERLAY_INFO(overlay_bad_add_dup_node, -EINVAL),
 	OVERLAY_INFO(overlay_bad_add_dup_prop, -EINVAL),
 	OVERLAY_INFO(overlay_bad_phandle, -EINVAL),
@@ -3729,6 +3732,191 @@ static inline __init void of_unittest_overlay_high_level(void) {}
 
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
@@ -3779,6 +3967,7 @@ static int __init of_unittest(void)
 	of_unittest_platform_populate();
 	of_unittest_overlay();
 	of_unittest_lifecycle();
+	of_unittest_pci_node();
 
 	/* Double check linkage after removing testcase data */
 	of_unittest_check_tree_linkage();
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 6c0e7b6bbdd1..a8223ff52939 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6149,3 +6149,4 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
  */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
-- 
2.34.1

