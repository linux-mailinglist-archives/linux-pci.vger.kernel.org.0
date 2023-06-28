Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6822740D80
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jun 2023 11:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbjF1JsH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jun 2023 05:48:07 -0400
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com ([40.107.236.41]:7425
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233268AbjF1J2g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jun 2023 05:28:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuPpd+lxfuq3/DtF28ZMNkuZvpFqhokBnzouoXknwwD/5/MSne6JyaK/tKrkzXR1CVuHYjY50Cwn5eBLTqNTjClk0JoEde8wVOMpIu7JGXTpQyTfLqPsYGRQCF604X3ojNKi3nSMqU4ODbK822VeZnT20KGvwGVLyeesWRmGqkobLZC4OWNik9KJ9m2rvedxx4WQU9f/b94awxQRiQXh0nTbk0u/gtBL8naPQQQvsveou1ozi4WKOddZtCmswVKf2pHzDMyTcuTMLJvmq/M1LRKRzdih2sS6VEHo10WPk8HdfqtMmDcbZzp/sO4MDZWONH9E+I3LhQaV0Y9OGnWaXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9rn73qYoRd32aZLwT0iLEIgwcpi91DBbZDuPq8fDOc=;
 b=EizNy0j+WOq0+FDixo8dpySRMs6pSGkFM6hLzPniZXBbJcAWCc3P/hefU0nlqa4H1LK5LTpdIaPyZYndsJdhYPQA6+FaVH7fnJPtFbyx0cC1AI90ersruUt8d23xzT4lUwe0kn+mp3NcYjg8vs5EFNipTo2AxJHkJlclcW/12khLqfG7HJTZ4jmD2fzcHf2Muvu1ZieAvIp3niMPJc8KuhVoSvvXMssiFPaUjzlrKo4fJIq2TBIDWpDEc5k97v9jMrRGWX0x+FlLtsvyDuRK7O41SksgPnqsx8fuHDW8GJSkWQBVouKh1fhPMRSG5y8TolmgwkOybbhInfWFo2FDsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9rn73qYoRd32aZLwT0iLEIgwcpi91DBbZDuPq8fDOc=;
 b=ZWMfKX3zyJ75MUJpGPaZU4vsY+l0AXw+ZjPC3US7UqpYfx8RMdQwK5DuhaYjgnm6bXF/UMBZo/YdnHQhSSdu67MR1QUjs/QGkMMqBQrLXGrniXKj/PHLRXCO2bcZGSF7RL21RXfmpRitpKT5d+YlH1EXSRJL7fUNO25Ex4LmzJM=
Received: from MW4P223CA0027.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::32)
 by CH2PR12MB4906.namprd12.prod.outlook.com (2603:10b6:610:6a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.15; Wed, 28 Jun
 2023 09:28:34 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::60) by MW4P223CA0027.outlook.office365.com
 (2603:10b6:303:80::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.20 via Frontend
 Transport; Wed, 28 Jun 2023 09:28:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.48 via Frontend Transport; Wed, 28 Jun 2023 09:28:33 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 28 Jun
 2023 04:28:27 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 28 Jun
 2023 02:28:20 -0700
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 28 Jun 2023 04:28:18 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <krzysztof.kozlowski@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <bhelgaas@google.com>
CC:     <lorenzo.pieralisi@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <bharat.kumar.gogada@amd.com>, <michals@amd.com>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Subject: [PATCH V5 1/3] Move and rename error interrupt bits to a common header.
Date:   Wed, 28 Jun 2023 14:58:10 +0530
Message-ID: <20230628092812.1592644-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230628092812.1592644-1-thippeswamy.havalige@amd.com>
References: <20230628092812.1592644-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT037:EE_|CH2PR12MB4906:EE_
X-MS-Office365-Filtering-Correlation-Id: ac37ccb8-e389-493e-7e93-08db77ba0b1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yyK3hEJ48rYIrZlVVYbnZwMmN5P9uUlM8cGYDDrJ+lb+yI+gmrO6iGk063gTcbQvG5FCovDhYIxMP1Dcz4HLguyVTZlIQPK+3AP+kAFppheFGy2MNlc0sHELGUAoYkQUOHY9LZkc62D1VwIDuNgNqiEzccZZ+3IgdJgkyZRoR6zQAXvg5dS4T90cOdJUB1nHZmk4b4yQNvik3tldFCYHOutdoWXrpwxXOm6U8XPSOxERNKenk9SlCzF6PcYaIUAEwCZnZbN0lLg2h7UmndRYjrykke7xTz63Xtil/ImIStobyOKhbUcWHpcyN1uX9Sd+qVUdTU9mPUyvAo60S2zEL8LptWywLuBAn6hUWdcRWN2mhDGczAIgHsNx2TN7vsYuwDFFwwbojACWlN2DyIKO8KYCJPCOBP34G6sdFBMLDmWaWvQG0aYXo/AjXE+scJ6z2HgCRPf210GU62iPPKiMhzC+GG03hwNaNL8HeqV/EdWJD/W3QNgwqXaptu/H1bxuEgOYxsUea+usiuznzaGbjPASAP5qjeJBCdV3zTsWEMqJGGQyg9KUBfq5nfSLFFB8rpiGQ2ik/QoftIRuCnK5ezfCmsAACqB2MJ15D7tIW/7xqDo89FhUWJkCmRQBWz08yunTkFwf7LyYpRqlPNccMDu1a3lgqhsb0PI9uDSs23yi4fpehEOO/Z/YWPcvUq2bT07S3wCgsQDluIAZZ7pMjjKfVeSfBtDIPAy4NOf4Mw/omvo4Mmh/i+qbQPQO1SQfEGIAq9hvSJ09g62zrXB7vQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199021)(40470700004)(36840700001)(46966006)(44832011)(5660300002)(4326008)(70586007)(70206006)(316002)(478600001)(2906002)(36756003)(8936002)(8676002)(40460700003)(36860700001)(41300700001)(86362001)(54906003)(110136005)(82310400005)(40480700001)(186003)(336012)(426003)(1076003)(26005)(47076005)(82740400003)(356005)(6666004)(81166007)(83380400001)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 09:28:33.5443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac37ccb8-e389-493e-7e93-08db77ba0b1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4906
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move and rename error interrupt bit macros to a common header file for
code reusability.

Move common linux header files for reusability.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
---
changes in v5:
None
changes in v4:
None
changes in v3:
- changed licensing year to 2023
 drivers/pci/controller/pcie-xilinx-common.h | 30 ++++++++++++++++
 drivers/pci/controller/pcie-xilinx-cpm.c    | 38 ++++-----------------
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

