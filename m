Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D11B4CE2BA
	for <lists+linux-pci@lfdr.de>; Sat,  5 Mar 2022 06:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiCEFNR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Mar 2022 00:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiCEFNR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Mar 2022 00:13:17 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2049.outbound.protection.outlook.com [40.107.212.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513FB248CC7;
        Fri,  4 Mar 2022 21:12:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVyIH1A2jmV4V74xehM8mOJsgmyZVwqbbCPr1vHUOcDD648pqzb0wX+8ilAVwj4kEXHIK67PjF5XdoyI2c8FnbWpS62f3gKqliYL1trpK1cTWmBfxQl2lCa1+5di+VDTJcR/Pia+sqzun78ECoHdtnqYnn6r2f7Hr9TTEcGKURTc9f/hqaW+l0RSncoeaw0AmUAev6bv7f5BhrUBoYy64gD2nwXJFU2bGvh9E7keE2fXceN5fddIKe+QT1L/lc2BjTKUWgggBMqHyR3Ir8jQjt7yBc09RAvEDR2IA+HytPsxyxjbb4xk9exsfyQoJn9j+Pz7RWgGUJCkN/Y3hTtQ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdmgBRgPiavesm0saAo05tNSNGEzTR1CbgfRdTnIAxc=;
 b=myr48c7//JBE1n1sUsw6pTG6geQzeTUaDoTd+FoUvI9mRe3/Gk1aY8I5DpfALgMwL2AqDIwsICMXRrPtgJUy5ZQ3QSoZk5KcoczUH9T2KScmjBWsb0dLBuwV/3VtPuBnORO5tcuv9o9htSPm1DFffybgnr100j/2DNJswJJr/BXl9KWsuoO0ltXR8oOWJ/IaY9zv/tIEYM/0ybwATPuMtJasGQnwKt/rw3e1IRvuBc1WoMCnt3/ngrR9zKP1Si3Sg2oEhkaAMjNRIqbrXGCL5jmNFZCijt4fRh6krZsFdHIGLxnNU1I5PY9ZVhAbafMLriLI2SOkRMPKjP4nbY8Yfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdmgBRgPiavesm0saAo05tNSNGEzTR1CbgfRdTnIAxc=;
 b=QvUPtA35806pNwVrjZb9YKdE5PWAbJz5rHVQQMBIODrkwwuLOxPd9iGMGIZM8QdJsOZzXb/+SlBdoiQOAjgC804Ge6sXhWFCdkdF8QgTLWsWU/HxdHkkkCm5IP+IvekVejvnO2D59RuiAT+w1qO8uV/CK2yYyUiAsGTGU4JnX/g=
Received: from DM5PR21CA0054.namprd21.prod.outlook.com (2603:10b6:3:129::16)
 by BYAPR02MB4102.namprd02.prod.outlook.com (2603:10b6:a02:fa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Sat, 5 Mar
 2022 05:12:23 +0000
Received: from DM3NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:129:cafe::b8) by DM5PR21CA0054.outlook.office365.com
 (2603:10b6:3:129::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.8 via Frontend
 Transport; Sat, 5 Mar 2022 05:12:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT040.mail.protection.outlook.com (10.13.5.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Sat, 5 Mar 2022 05:12:23 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 4 Mar 2022 21:11:44 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 4 Mar 2022 21:11:44 -0800
Envelope-to: dwmw2@infradead.org,
 yilun.xu@intel.com,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org
Received: from [172.19.72.93] (port=44416 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1nQMhk-000Gxx-Lt; Fri, 04 Mar 2022 21:11:44 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 6051F600196; Fri,  4 Mar 2022 21:11:08 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <yilun.xu@intel.com>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <trix@redhat.com>, <mdf@kernel.org>, <dwmw2@infradead.org>,
        Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V1 4/4] of: enhance overlay applying interface to specific target base node
Date:   Fri, 4 Mar 2022 21:11:05 -0800
Message-ID: <20220305051105.725838-5-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220305051105.725838-1-lizhi.hou@xilinx.com>
References: <20220305051105.725838-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b15bb71-4e01-4093-305c-08d9fe66bb46
X-MS-TrafficTypeDiagnostic: BYAPR02MB4102:EE_
X-Microsoft-Antispam-PRVS: <BYAPR02MB4102840FF61BAD559C75DD6CA1069@BYAPR02MB4102.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FuwNn49E9PiobLc/9JCdylZjdE2e9mXjGhQLyR73KtgIrPJaPx2n+UVJ5ksdxYmmv7tYV+jxgGPWUgfS4VWgAh033/WBadaRC9z+dLAaiw3dT+nKytxWzx14aTdnlIOe+hW14UjVAb34/6hhohnEuoFygLfPKMZmj40waaIaM5Y/X+AVRjLu5XQN8KqLosnfp59OScH9c4Og4XI7L4KRSZx4Y7+pmcFWEpZQ8nBbFuXdOAXo8636cApsUGdy0TGGB/QNwm62Gun3BR7ReA/NAj3neVLcXlx/rPRk0Oc3dsfGv4ft5ePkBqzhaJZ+rtF+AAF214rkFrDPpaGfzRI2JETX14iPF0DeLrnhw1Qe17MB4QwVH8kpL5zcv54zFL23WV06JbFc/oBtAum9f2ZcKTTMvnMX+fiLgxXO7O1W2d4NvGOdQGDNQ9Jry7R6JtOLyL5xY8EtX5288vV7JNCqOt/k2+QiZ+ezqVlUv1vjhnYqMH9FPx7Mjy57Cyk/O1z8GuV7uP2xmu9XC68xHTX8Qhx70DvMZnWxPQtihMNH2Pi9miMSYPP0VCwesf4YBXTPkmBAc27wy6GB9WYOtG/hwYbJS7EnP18DAvjBxmlqhzMs9YOWCltyGeSZjw9gY0cPYaOlosmZXxXzH+Wtgqu11Q==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(70206006)(83380400001)(8936002)(7636003)(26005)(316002)(508600001)(110136005)(42186006)(54906003)(70586007)(356005)(36860700001)(82310400004)(44832011)(2616005)(2906002)(4326008)(8676002)(6666004)(1076003)(426003)(47076005)(107886003)(5660300002)(336012)(36756003)(6266002)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2022 05:12:23.0757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b15bb71-4e01-4093-305c-08d9fe66bb46
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT040.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4102
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The self discovered device, e.g. PCIe device, may carry a device tree
overlay to describe its downstream devices. In this case, the device node
is created dynamically by device driver. And in the overlay it does not
specify a fixed target path. Instead, a relative path to the device node
is specified.
Thus, a new parameter is added to overlay applying interface. This
parameter is the pointer of target base node. Then the entire overlay
target path is target base node path plus the relative path specified in
the device tree overlay.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 drivers/fpga/xrt/mgmt/Makefile       |  1 +
 drivers/fpga/xrt/mgmt/dt-test.dts    | 15 ++++++++++
 drivers/fpga/xrt/mgmt/dt-test.h      | 15 ++++++++++
 drivers/fpga/xrt/mgmt/xmgmt-drv.c    | 41 +++++++++++++++++++++++++++-
 drivers/gpu/drm/rcar-du/rcar_du_of.c |  2 +-
 drivers/of/overlay.c                 | 37 +++++++++++++++++--------
 drivers/of/unittest.c                |  2 +-
 include/linux/of.h                   |  2 +-
 8 files changed, 100 insertions(+), 15 deletions(-)
 create mode 100644 drivers/fpga/xrt/mgmt/dt-test.dts
 create mode 100644 drivers/fpga/xrt/mgmt/dt-test.h

diff --git a/drivers/fpga/xrt/mgmt/Makefile b/drivers/fpga/xrt/mgmt/Makefile
index b893c7293d70..a87ab1f6b403 100644
--- a/drivers/fpga/xrt/mgmt/Makefile
+++ b/drivers/fpga/xrt/mgmt/Makefile
@@ -9,4 +9,5 @@
 obj-$(CONFIG_FPGA_XRT_XMGMT) += xrt-mgmt.o
 
 xrt-mgmt-objs :=		\
+	dt-test.dtb.o		\
 	xmgmt-drv.o
diff --git a/drivers/fpga/xrt/mgmt/dt-test.dts b/drivers/fpga/xrt/mgmt/dt-test.dts
new file mode 100644
index 000000000000..3bc3d0c95180
--- /dev/null
+++ b/drivers/fpga/xrt/mgmt/dt-test.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+/ {
+	fragment@0 {
+		target-path="";
+		__overlay__ {
+			pr_isolate_ulp@0,41000 {
+				compatible = "xlnx,alveo-pr-isolation";
+				reg = <0x0 0x41000 0x0 0x1000>;
+			};
+		};
+	};
+};
+
diff --git a/drivers/fpga/xrt/mgmt/dt-test.h b/drivers/fpga/xrt/mgmt/dt-test.h
new file mode 100644
index 000000000000..dee0de570c8a
--- /dev/null
+++ b/drivers/fpga/xrt/mgmt/dt-test.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Xilinx, Inc.
+ *
+ * Authors:
+ *     Lizhi Hou <lizhih@xilinx.com>
+ */
+
+#ifndef _DT_TEST_H_
+#define _DT_TEST_H_
+
+extern u8 __dtb_dt_test_begin[];
+extern u8 __dtb_dt_test_end[];
+
+#endif /* _DT_TEST_H_ */
diff --git a/drivers/fpga/xrt/mgmt/xmgmt-drv.c b/drivers/fpga/xrt/mgmt/xmgmt-drv.c
index 60742a478a43..54078ffe37fe 100644
--- a/drivers/fpga/xrt/mgmt/xmgmt-drv.c
+++ b/drivers/fpga/xrt/mgmt/xmgmt-drv.c
@@ -14,8 +14,11 @@
 #include <linux/aer.h>
 #include <linux/vmalloc.h>
 #include <linux/delay.h>
+#include <linux/of.h>
 #include <linux/of_pci.h>
 
+#include "dt-test.h"
+
 #define XMGMT_MODULE_NAME	"xrt-mgmt"
 
 /* PCI Device IDs */
@@ -25,17 +28,53 @@ static const struct pci_device_id xmgmt_pci_ids[] = {
 	{ 0, }
 };
 
+struct xmgmt {
+	int ovcs_id;
+};
+
 static int xmgmt_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
-	devm_of_pci_create_bus_endpoint(pdev);
+	struct device_node *dn;
+	struct xmgmt *xm;
+	int ret;
+
+	xm = devm_kzalloc(&pdev->dev, sizeof(*xm), GFP_KERNEL);
+	if (!xm)
+		return -ENOMEM;
+	pci_set_drvdata(pdev, xm);
+
+	ret = devm_of_pci_create_bus_endpoint(pdev);
+	if (ret)
+		return ret;
+
+	dn = of_pci_find_bus_endpoint(pdev);
+	if (!dn) {
+		dev_err(&pdev->dev, "does not find bus endpoint");
+		return -EINVAL;
+	}
+
+	ret = of_overlay_fdt_apply(__dtb_dt_test_begin,
+				   (u32)(__dtb_dt_test_end - __dtb_dt_test_begin),
+				   &xm->ovcs_id, dn);
+	of_node_put(dn);
+	if (ret)
+		return ret;
 
 	return 0;
 }
 
+static void xmgmt_remove(struct pci_dev *pdev)
+{
+	struct xmgmt *xm = pci_get_drvdata(pdev);
+
+	of_overlay_remove(&xm->ovcs_id);
+}
+
 static struct pci_driver xmgmt_driver = {
 	.name = XMGMT_MODULE_NAME,
 	.id_table = xmgmt_pci_ids,
 	.probe = xmgmt_probe,
+	.remove = xmgmt_remove,
 };
 
 static int __init xmgmt_init(void)
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_of.c b/drivers/gpu/drm/rcar-du/rcar_du_of.c
index afef69669bb4..8799ed235f83 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_of.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_of.c
@@ -60,7 +60,7 @@ static int __init rcar_du_of_apply_overlay(const struct rcar_du_of_overlay *dtbs
 
 	ovcs_id = 0;
 	return of_overlay_fdt_apply(dtb->begin, dtb->end - dtb->begin,
-				    &ovcs_id);
+				    &ovcs_id, NULL);
 }
 
 static int __init rcar_du_of_add_property(struct of_changeset *ocs,
diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index d80160cf34bb..4d192dff5055 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -686,9 +686,11 @@ static int build_changeset(struct overlay_changeset *ovcs)
  * 1) "target" property containing the phandle of the target
  * 2) "target-path" property containing the path of the target
  */
-static struct device_node *find_target(struct device_node *info_node)
+static struct device_node *find_target(struct device_node *info_node,
+				       struct device_node *target_base)
 {
 	struct device_node *node;
+	char *target_path;
 	const char *path;
 	u32 val;
 	int ret;
@@ -704,10 +706,23 @@ static struct device_node *find_target(struct device_node *info_node)
 
 	ret = of_property_read_string(info_node, "target-path", &path);
 	if (!ret) {
-		node =  of_find_node_by_path(path);
-		if (!node)
-			pr_err("find target, node: %pOF, path '%s' not found\n",
-			       info_node, path);
+		if (target_base) {
+			target_path = kasprintf(GFP_KERNEL, "%pOF%s", target_base, path);
+			if (!target_path)
+				return NULL;
+			node = of_find_node_by_path(target_path);
+			if (!node) {
+				pr_err("find target, node: %pOF, path '%s' not found\n",
+				       info_node, target_path);
+			}
+			kfree(target_path);
+		} else {
+			node =  of_find_node_by_path(path);
+			if (!node) {
+				pr_err("find target, node: %pOF, path '%s' not found\n",
+				       info_node, path);
+			}
+		}
 		return node;
 	}
 
@@ -730,7 +745,7 @@ static struct device_node *find_target(struct device_node *info_node)
  * detected in @tree, or -ENOSPC if idr_alloc() error.
  */
 static int init_overlay_changeset(struct overlay_changeset *ovcs,
-		const void *fdt, struct device_node *tree)
+		const void *fdt, struct device_node *tree, struct device_node *target_base)
 {
 	struct device_node *node, *overlay_node;
 	struct fragment *fragment;
@@ -792,7 +807,7 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
 
 		fragment = &fragments[cnt];
 		fragment->overlay = overlay_node;
-		fragment->target = find_target(node);
+		fragment->target = find_target(node, target_base);
 		if (!fragment->target) {
 			of_node_put(fragment->overlay);
 			ret = -EINVAL;
@@ -914,7 +929,7 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
  */
 
 static int of_overlay_apply(const void *fdt, struct device_node *tree,
-		int *ovcs_id)
+		int *ovcs_id, struct device_node *base)
 {
 	struct overlay_changeset *ovcs;
 	int ret = 0, ret_revert, ret_tmp;
@@ -947,7 +962,7 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
 	if (ret)
 		goto err_free_tree;
 
-	ret = init_overlay_changeset(ovcs, fdt, tree);
+	ret = init_overlay_changeset(ovcs, fdt, tree, base);
 	if (ret)
 		goto err_free_tree;
 
@@ -1015,7 +1030,7 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
 }
 
 int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
-			 int *ovcs_id)
+			 int *ovcs_id, struct device_node *base)
 {
 	void *new_fdt;
 	void *new_fdt_align;
@@ -1053,7 +1068,7 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
 		goto out_free_new_fdt;
 	}
 
-	ret = of_overlay_apply(new_fdt, overlay_root, ovcs_id);
+	ret = of_overlay_apply(new_fdt, overlay_root, ovcs_id, base);
 	if (ret < 0) {
 		/*
 		 * new_fdt and overlay_root now belong to the overlay
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 70992103c07d..471bf6f2ec9a 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -3010,7 +3010,7 @@ static int __init overlay_data_apply(const char *overlay_name, int *ovcs_id)
 	if (!size)
 		pr_err("no overlay data for %s\n", overlay_name);
 
-	ret = of_overlay_fdt_apply(info->dtb_begin, size, &info->ovcs_id);
+	ret = of_overlay_fdt_apply(info->dtb_begin, size, &info->ovcs_id, NULL);
 	if (ovcs_id)
 		*ovcs_id = info->ovcs_id;
 	if (ret < 0)
diff --git a/include/linux/of.h b/include/linux/of.h
index 2dc77430a91a..7c5ecafb98c8 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1567,7 +1567,7 @@ struct of_overlay_notify_data {
 #ifdef CONFIG_OF_OVERLAY
 
 int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
-			 int *ovcs_id);
+			 int *ovcs_id, struct device_node *target_base);
 int of_overlay_remove(int *ovcs_id);
 int of_overlay_remove_all(void);
 
-- 
2.27.0

