Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20ABE7B6FE7
	for <lists+linux-pci@lfdr.de>; Tue,  3 Oct 2023 19:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240668AbjJCRg1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Oct 2023 13:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240548AbjJCRg0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Oct 2023 13:36:26 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59669B0;
        Tue,  3 Oct 2023 10:36:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzOqcpfgQOt0EPdbiOZ+nYbT6LSw86oif5O5OXknELCfK8Myn0n21g73oanfRS1VV1DL6btKdWglz7FnHAyauWCJxInCwVc6AkHHdA7Blnzaby+5BWuXaa1yphvKkmdnJY8pr/q5eBNysp4dzkLRE1yANvfrVHMjqOAibB8H3pcSrYTsPYsH4CkENDf/VU9GbykzWraZVd4vv2X9YEHXDT+O2mBuF+DNeWtRASLPUaN/NDVQXF08ipAQJlB/+qOx2vxrpKO/MmEN8X74bzyUVYNc01/VmT/iUoqndincPGLPEB8Uikq6X4oouez5Ll1KHD8MIU5E3pjUkXpIv/V9tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ou2NKQZxjbfae8mJ8/Fn95nj0yoxujD9sjWKUiPqBdQ=;
 b=ehpTNl1sonDf/NK5rEwV5sYPWRAOqv6v/qntHHeWqEqsIPh7pWeXoly8FBw33PiAid8T1x48/qNmNiS7i8hJDa2BNnbh1UbtQ9YSnBtye5mCQ/6S8+B2yqJLCwS6SUA2QNq27eqVC3J21PzV0UwKPX7ruwZgjD2HP5dflc8Qly3ZTVq7mo6lGVsOkQ9AdVt+8pzg7xUme7oO1hLzp8rbt6tvR8sRMs3iFiO2yo6SkT+cHgQkK+BBHcQnEZ5psv3l4VfBRhnjR+jLAyFZwpDZhAV9qYGXNal17xerBWcElv+73Nx/wY0tYHx1+iIdJ7RCVMADwrCwp5OkQP/CL3BNWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ou2NKQZxjbfae8mJ8/Fn95nj0yoxujD9sjWKUiPqBdQ=;
 b=kXZRHcqS8RwDlAQV9jE7UDwMG1ByfqjILV740iFJiRustaMi4bYSfQBhYAYuA9TUrMA/33Ks0L35PK+e/OqWItlgB6S1Z9Vhse0oNu2P3NJDsMzZPwtq+RVDs0Ro3SyTXTk+wh/oDERv1VHcQGBHPQQP+4tzNaAs6L/Qy+JXAoY=
Received: from MW4PR03CA0293.namprd03.prod.outlook.com (2603:10b6:303:b5::28)
 by SJ2PR12MB9138.namprd12.prod.outlook.com (2603:10b6:a03:565::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Tue, 3 Oct
 2023 17:36:20 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:303:b5:cafe::a7) by MW4PR03CA0293.outlook.office365.com
 (2603:10b6:303:b5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Tue, 3 Oct 2023 17:36:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 3 Oct 2023 17:36:20 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 12:36:18 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 3 Oct 2023 12:36:15 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <thippeswamy.havalige@amd.com>,
        <michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>
Subject: [PATCH v7 RESEND 1/3] PCI: xilinx-cpm: Move interrupt bit definitions to common header
Date:   Tue, 3 Oct 2023 23:04:51 +0530
Message-ID: <20231003173453.938190-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231003173453.938190-1-thippeswamy.havalige@amd.com>
References: <20231003173453.938190-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|SJ2PR12MB9138:EE_
X-MS-Office365-Filtering-Correlation-Id: afa8c486-f285-4fbc-b241-08dbc437415c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mfl1JmmViUzN198KFdix1SqejICRFls+QSxl2RReV6ZlfzQMJlXqRYKsdbUKaNpR2B8gjS44WvEqOHV3JuoS22T0PBM0+DEo89tQy2zIUdX21YxEHFi27RQoUlq8v5m84FyHOXJJ6qX5kJUE+3pVoaZEL8WpKQrSZkI6woPOUFxsHes31BqbgCPEUFMBjTIeJMy6Agn/KNGegwEZ0POwcicQpsDevxGpFsQGtedtkD2XTwNdDi42fo3/AGofC63rKKw8ZiMCBxKXl1oAC0mP09Mv1GUifbij4X38orQumouu3VxomN0kWsFvoedhubk5uv6lRbpEG6NsBBs25+AWQyDjZYNYiQ9YRO7nRJYyA2e/oQ0TvSPcFE9L5paNjDEyJoysf9ePBkUW04zYkqcyxwdi0pa34LIpATVwtQb7xdLzy4cZyc05GN+k2GCMPmsGctQH4q4kQ9RbOpwizdaN5R6IuC+UAma1+UsTPNEW47IrCzN7SuEOCw+7Lr6d6o1cVuKewwsGzY6X/M3mvyXfW5Kb05QcUsZlforiKiIgt64sbxOJ2rkCYROSxHXy4sZFbS7LvHcPnrqXBx3AXPeyxgpS4OAxU/qRFi1zbRxcj3v5DMlQHJOTie+sNSc0NqOvmgLplynpPFfo/2N5+oPlWcos0px2eLG/8IG+NL9UPDT6W9vqWxUUiIlo5Qz/oQiCVNC1gF8ZiQzebuBdLr5UP9jNHNzNn2WfXLhK5WJdExMrPLZKCsjkphaYyGVwLrZKxDqxX8pOXOmzfm8c9x7MIkVQijwaOpDE0/LkG0txswo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(1800799009)(186009)(451199024)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(316002)(426003)(336012)(1076003)(36860700001)(2616005)(26005)(81166007)(356005)(83380400001)(86362001)(36756003)(40480700001)(82740400003)(40460700003)(47076005)(8676002)(70586007)(54906003)(4326008)(5660300002)(41300700001)(44832011)(8936002)(110136005)(70206006)(2906002)(7416002)(6666004)(478600001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 17:36:20.0177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afa8c486-f285-4fbc-b241-08dbc437415c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9138
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rename Xilinx interrupt bit definitions so they are not CPM-specific. Move
the definitions to pcie-xilinx-common.h where they can be shared between
pcie-xilinx-cpm and the new xilinx-xdma driver.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
---
changes in v7:
- None
changes in v6:
-  subject line and commit message
changes in v5:
- None
changes in v4:
- None
changes in v3:
- changed licensing year to 2023
---
 drivers/pci/controller/pcie-xilinx-common.h | 30 +++++++++++++++++++++++
 drivers/pci/controller/pcie-xilinx-cpm.c    | 38 ++++++-----------------------
 2 files changed, 37 insertions(+), 31 deletions(-)
 create mode 100644 drivers/pci/controller/pcie-xilinx-common.h

diff --git a/drivers/pci/controller/pcie-xilinx-common.h b/drivers/pci/controller/pcie-xilinx-common.h
new file mode 100644
index 000000000000..e97d27252a08
--- /dev/null
+++ b/drivers/pci/controller/pcie-xilinx-common.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * (C) Copyright 2023, Xilinx, Inc.
+ */
+
+#include <linux/pci.h>
+#include <linux/pci-ecam.h>
+#include <linux/platform_device.h>
+
+/* Interrupt registers definitions */
+#define XILINX_PCIE_INTR_LINK_DOWN		0
+#define XILINX_PCIE_INTR_HOT_RESET		3
+#define XILINX_PCIE_INTR_CFG_PCIE_TIMEOUT	4
+#define XILINX_PCIE_INTR_CFG_TIMEOUT		8
+#define XILINX_PCIE_INTR_CORRECTABLE		9
+#define XILINX_PCIE_INTR_NONFATAL		10
+#define XILINX_PCIE_INTR_FATAL			11
+#define XILINX_PCIE_INTR_CFG_ERR_POISON		12
+#define XILINX_PCIE_INTR_PME_TO_ACK_RCVD	15
+#define XILINX_PCIE_INTR_INTX			16
+#define XILINX_PCIE_INTR_PM_PME_RCVD		17
+#define XILINX_PCIE_INTR_SLV_UNSUPP		20
+#define XILINX_PCIE_INTR_SLV_UNEXP		21
+#define XILINX_PCIE_INTR_SLV_COMPL		22
+#define XILINX_PCIE_INTR_SLV_ERRP		23
+#define XILINX_PCIE_INTR_SLV_CMPABT		24
+#define XILINX_PCIE_INTR_SLV_ILLBUR		25
+#define XILINX_PCIE_INTR_MST_DECERR		26
+#define XILINX_PCIE_INTR_MST_SLVERR		27
+#define XILINX_PCIE_INTR_SLV_PCIE_TIMEOUT	28
diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
index 4a787a941674..a0f5e1d67b04 100644
--- a/drivers/pci/controller/pcie-xilinx-cpm.c
+++ b/drivers/pci/controller/pcie-xilinx-cpm.c
@@ -16,11 +16,9 @@
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
-#include <linux/pci.h>
-#include <linux/platform_device.h>
-#include <linux/pci-ecam.h>
 
 #include "../pci.h"
+#include "pcie-xilinx-common.h"
 
 /* Register definitions */
 #define XILINX_CPM_PCIE_REG_IDR		0x00000E10
@@ -38,29 +36,7 @@
 #define XILINX_CPM_PCIE_IR_ENABLE       0x000002A8
 #define XILINX_CPM_PCIE_IR_LOCAL        BIT(0)
 
-/* Interrupt registers definitions */
-#define XILINX_CPM_PCIE_INTR_LINK_DOWN		0
-#define XILINX_CPM_PCIE_INTR_HOT_RESET		3
-#define XILINX_CPM_PCIE_INTR_CFG_PCIE_TIMEOUT	4
-#define XILINX_CPM_PCIE_INTR_CFG_TIMEOUT	8
-#define XILINX_CPM_PCIE_INTR_CORRECTABLE	9
-#define XILINX_CPM_PCIE_INTR_NONFATAL		10
-#define XILINX_CPM_PCIE_INTR_FATAL		11
-#define XILINX_CPM_PCIE_INTR_CFG_ERR_POISON	12
-#define XILINX_CPM_PCIE_INTR_PME_TO_ACK_RCVD	15
-#define XILINX_CPM_PCIE_INTR_INTX		16
-#define XILINX_CPM_PCIE_INTR_PM_PME_RCVD	17
-#define XILINX_CPM_PCIE_INTR_SLV_UNSUPP		20
-#define XILINX_CPM_PCIE_INTR_SLV_UNEXP		21
-#define XILINX_CPM_PCIE_INTR_SLV_COMPL		22
-#define XILINX_CPM_PCIE_INTR_SLV_ERRP		23
-#define XILINX_CPM_PCIE_INTR_SLV_CMPABT		24
-#define XILINX_CPM_PCIE_INTR_SLV_ILLBUR		25
-#define XILINX_CPM_PCIE_INTR_MST_DECERR		26
-#define XILINX_CPM_PCIE_INTR_MST_SLVERR		27
-#define XILINX_CPM_PCIE_INTR_SLV_PCIE_TIMEOUT	28
-
-#define IMR(x) BIT(XILINX_CPM_PCIE_INTR_ ##x)
+#define IMR(x) BIT(XILINX_PCIE_INTR_ ##x)
 
 #define XILINX_CPM_PCIE_IMR_ALL_MASK			\
 	(						\
@@ -323,7 +299,7 @@ static void xilinx_cpm_pcie_event_flow(struct irq_desc *desc)
 }
 
 #define _IC(x, s)                              \
-	[XILINX_CPM_PCIE_INTR_ ## x] = { __stringify(x), s }
+	[XILINX_PCIE_INTR_ ## x] = { __stringify(x), s }
 
 static const struct {
 	const char      *sym;
@@ -359,9 +335,9 @@ static irqreturn_t xilinx_cpm_pcie_intr_handler(int irq, void *dev_id)
 	d = irq_domain_get_irq_data(port->cpm_domain, irq);
 
 	switch (d->hwirq) {
-	case XILINX_CPM_PCIE_INTR_CORRECTABLE:
-	case XILINX_CPM_PCIE_INTR_NONFATAL:
-	case XILINX_CPM_PCIE_INTR_FATAL:
+	case XILINX_PCIE_INTR_CORRECTABLE:
+	case XILINX_PCIE_INTR_NONFATAL:
+	case XILINX_PCIE_INTR_FATAL:
 		cpm_pcie_clear_err_interrupts(port);
 		fallthrough;
 
@@ -466,7 +442,7 @@ static int xilinx_cpm_setup_irq(struct xilinx_cpm_pcie *port)
 	}
 
 	port->intx_irq = irq_create_mapping(port->cpm_domain,
-					    XILINX_CPM_PCIE_INTR_INTX);
+					    XILINX_PCIE_INTR_INTX);
 	if (!port->intx_irq) {
 		dev_err(dev, "Failed to map INTx interrupt\n");
 		return -ENXIO;
-- 
2.25.1

