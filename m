Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09ED7808BA
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 11:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359149AbjHRJgZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 05:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359302AbjHRJgM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 05:36:12 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3003A84;
        Fri, 18 Aug 2023 02:36:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzWB7MG5ZLV1ABIbpBek1TiGkl7XAGnjI2O/RRr6nZnSR0C5iPa5eCLoznWLKeAH3dnAaNEMPICHQ233N4/2HlKt+TeJydGZ5tqJlGwA6ehz5BFXYeHELtKMEz1YH/K6dCjSmUCeuVJLuvuzteTu7y+0BoMmOzKN5EDyucbRqwhEPX7V6YOOOMFI2Bvx4jzg95gaLu7rjB+MIDsx0cqXEJPsSd2YmNq+iOz+QynlC5PkmUILcERY/B1yUHXVRkOf+MLFNPQjryYp7lxvFQyrv8yBNew/x00BG7Dr51PHspF5/oyR8IXdITH7el58H61SOfS4EdoI7/oNZ/BAnQbt7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2h3stGxfQOwSBoAhuF9LxA/pKiIAe5yXjDnp9jgcQw=;
 b=TDIBCO/q5KS7Xpvq+H41QmN4EKvzqYY1Rhfqxi2cqoqNhcf1ZuIIDmkV8+3B75doOFAyW0IfMjqktvnb5ncffNdJCrqLIgagVBxEV8PFywgA4nt9OI6R/QGzoKC5z9T0rvjAW/+Rrzb708NmaJxmN/gUYB2pPSFU0NiNhTsVP3acy4rK+ovEAxDJpFRz5x0/KB2CLphcnQn6Xq7hzLHYTIb4SGZnLFroqOgqZtvmxtxCSoa9DhlofhfuMCW7gqhcSGPVUhWNTRnogc/V676w31Jusrk9dcd0FKDGYqNtX1Om4XpRxpCk7PmA0897LR5i6fFt7fcqWowtXTdI7FEXOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2h3stGxfQOwSBoAhuF9LxA/pKiIAe5yXjDnp9jgcQw=;
 b=2MmbZaWgUG1zS24SB/n99qip8ZW0xicdOoH/ScLQZbwwS8VmLxK6BHlFiiPcZmoUGtSIT8D0KSUdkehmwx7B/+x/RFT3UcJI9t6Ki11w9NvVDTwf6uxX4jJ3TdcpcviF8RKjsW8fK4DagyE85PxEsgQpt0yVGcUTEjrwggWapMk=
Received: from BYAPR03CA0018.namprd03.prod.outlook.com (2603:10b6:a02:a8::31)
 by MW4PR12MB7465.namprd12.prod.outlook.com (2603:10b6:303:212::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 09:36:02 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::cd) by BYAPR03CA0018.outlook.office365.com
 (2603:10b6:a02:a8::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Fri, 18 Aug 2023 09:36:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 09:36:01 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 04:36:00 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 18 Aug 2023 04:35:57 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <bhelgaas@google.com>, <lpieralisi@kernel.org>, <robh@kernel.org>,
        <kw@linux.com>, <michal.simek@amd.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <bharat.kumar.gogada@amd.com>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Subject: [PATCH v6 1/3] PCI: xilinx-cpm: Move interrupt bit definitions to common header
Date:   Fri, 18 Aug 2023 15:05:05 +0530
Message-ID: <20230818093507.24435-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230818093507.24435-1-thippeswamy.havalige@amd.com>
References: <20230818093507.24435-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|MW4PR12MB7465:EE_
X-MS-Office365-Filtering-Correlation-Id: eed95d2f-6200-4057-b5e8-08db9fce895b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AZfun14RZ4SSzUdrXxZVoUbV4EqHpOKRqwEmAlLuWR8sw1Bv3xsC/l2auJSpzeMEF2xZ/ACwG+1rrj8kcBG21Cg3EcNuOnKQ0bOPO8gn6qn3NAR1Tg/+spaHQjF4cjADLa5Y2L9K6Vsmo+YlAtCePDv2ScP5bq2v13UzjhZFhTiuW+PqZXGf6Tu8J8CWQE5JF3GhF1kZlUqoUxR1u0ilRBj71RuKXyawBpKpmvyqTPF+gkmR9vj7QVt3xZL0fLq8n/WuNsKhCPcemnYxc8L3r7u609/7gWJ2RmZixlPmw+Qp+HCgnAQYtOXYfBhTuoC1KLj39D749A48d256u/Ki1r4zg2ZkYLToADwwLVwLgL5oJPqFLgMmXHAs6NfgfndyfjsX+k/DGOHfasOow4N490OZ8ihXFI6TX0k2rk67FOsfGyt6EU4qXZ1INeFRfUyXvIAeu9zIkidZ6t94ZtJX9ny5zT/5ryGjn0y3JQAjQGq86MTAhfWjh6ywZKsZsEcGPWCz3BwSuu3knHF4p1EO+OZH/LqhGURMx1Owo9QlsPSkBGmi3czpqZfBUW3cYkGlZKtRWMDi0vUDpiqM9CbTP0Pz6JMagI7lamPo4pNBNsVnKeaMeC0ZUpbGo+lJubRJc1ERtw+dEUoz+lr1vRZOig1iiaNRn6239DnFudLf93Z3ZRa1yPdrTZgg0q4P4/i+nI9AGAuLk6jOxm8HivhHEew8OYSgjRYmXHmgmWaj+sS9YD7SuK38+hC2RpZdofsWo3fURQ/GmGf4cGuD6lM7D1QYk8iXtdSBxCvhd22gYEw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(6666004)(40460700003)(86362001)(336012)(426003)(1076003)(26005)(40480700001)(83380400001)(36756003)(36860700001)(47076005)(81166007)(82740400003)(356005)(2616005)(2906002)(54906003)(316002)(41300700001)(70206006)(70586007)(110136005)(44832011)(5660300002)(8676002)(4326008)(8936002)(478600001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 09:36:01.8219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eed95d2f-6200-4057-b5e8-08db9fce895b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7465
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
index 0000000..e97d272
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
index 4a787a9..a0f5e1d 100644
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
1.8.3.1

