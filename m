Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C634E78DB44
	for <lists+linux-pci@lfdr.de>; Wed, 30 Aug 2023 20:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbjH3Siv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Aug 2023 14:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242586AbjH3JHf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Aug 2023 05:07:35 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2053.outbound.protection.outlook.com [40.107.96.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64635CC9;
        Wed, 30 Aug 2023 02:07:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G30pgLoPXmz2zF0cc43X7md0wN1GlymmuCeFG9ViELGUkA5xqXDfZKwhWfpLDuAbPJuOsDJb5aSBTGarWS1ZuYYHQO/gsN7Pjcxd1P7OJ6jWXq9ecegssI9uAUvisXORTek4VnUNsL6LDK048LvJGoFABedC13+nG+kKjDsKJmQhTQkbcimL2IYF0xdHdwmPxGb/Hw+GkkFZ2eL6RxoKdqGOgmEyw8ggnFoo9fEqXCXsfdhhtuvHTegpK7/ocyyLSAx+PEYza14QittzYqVWY0VvsARENOIADjwAQbBToXwWrtGf5NslCX1Mvk9x+3KPHyGUqSQPcvELlS7HM2vcaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAbkvIe69FMDae2BUpYkQ0M5PoDlaMvTCWU8xv05jCU=;
 b=Fxw7GfetvVLAyn+G/Gcf+O+rW5hJ/04bUWlfHjI48u5KPWCsMmSiKphPIKyjiOtIubdk387GkWwkKSE0ZFBwZWz84x/1GA/OUrU/ztINUeMBLouxtviEuXRBsWFTlEbr1HTyWBebCAgqe+tx+6S54f5vmHECH3R0lCkFe0itEljHpGp5hsQ7SAO7x0MmVw5bpfqWhPN3rF31XrSF21UENfz1y5OVKfuReGegnSgMQ64mXS/KeQ21Yg5A7+KZjTgIkfx98kEuvDsejiVB1xtJdT2Pf0fxDOLDQhlkP57mxkntiG+p69zjusrSf7Oc4s4qlklrKr22mD14t6U2mVyvAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAbkvIe69FMDae2BUpYkQ0M5PoDlaMvTCWU8xv05jCU=;
 b=yQSM2oosRVNo3kde4GQQ+imuE9pykmWN+NKthKAgxq4MDZ0cs5uyUIu0SprV0DUAcEnxVQz1iXCZ+Yhx8UJBTggYBIYD2NOAjnY5qQcZOFX62kjMYrcqmwXnsG27wQTHJ/9QmUmibyIW+T7+ogqDClKBAAPYLZN61rcvKWaNgu4=
Received: from PH7PR17CA0069.namprd17.prod.outlook.com (2603:10b6:510:325::29)
 by BL1PR12MB5779.namprd12.prod.outlook.com (2603:10b6:208:392::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 09:07:30 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:510:325:cafe::f9) by PH7PR17CA0069.outlook.office365.com
 (2603:10b6:510:325::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18 via Frontend
 Transport; Wed, 30 Aug 2023 09:07:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Wed, 30 Aug 2023 09:07:29 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 30 Aug
 2023 04:07:29 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 30 Aug
 2023 04:07:28 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 30 Aug 2023 04:07:25 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <bhelgaas@google.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
CC:     <lpieralisi@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Subject: [PATCH v7 1/3] PCI: xilinx-cpm: Move interrupt bit definitions to common header
Date:   Wed, 30 Aug 2023 14:37:05 +0530
Message-ID: <20230830090707.278136-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230830090707.278136-1-thippeswamy.havalige@amd.com>
References: <20230830090707.278136-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|BL1PR12MB5779:EE_
X-MS-Office365-Filtering-Correlation-Id: cdf51cb5-0762-4894-dd2b-08dba93889c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: if/in1Xva2ns+EzV52iilHpj2fxOlI0SLINiCeqsMsEY44Z7zKLKBydn9GvgnQDEmS6lDYTAH/LzgmZ5aO4FbUVfIvLjhxiEALE1uziL9JxoYr46PR3KLJ3mSDWRkP1I171i5RUfKFm7e82h1TfZdSzZiWj0eijOYJAmZ+1NnOmj3ejv77TMykt+bqGkTDEdBVNALPu/A//cbqhvgF0yftMHMW1MSynwzyFDdDLtDoJ1w6zJ7ekCmot5pGDDtWAjCnTzGlMnq3oFX9qj9Zn3oX/Vn/1jaLHQ/414iMmGmJkskmf4JyL5qqHxfxhQWsgJoU3MzyfeZxKVWka6opYMCeoAspS6VqKJ6Gjy0M+wi1W2WDF2ZVA3GyMxzITXkedF7DQCBkk8GA5Kg/otufoXr3AwlfzdH76YQZoOiTMbKGzLFlzdLxhUN434yfZdKcciAIfy6gNMAD5xxMsmOZzVLYzbWPlSz2mtaL97oUtdALvMDw3gl5gqSmjmnyg/ekyzd0DtIBglbd+hLABvJlHnAUrKDS1GJUZTj6jW1Jv61DO+onl6VliiwV/xQaVbkngwChxzUUCJFhRwuK917eG5qGFE8KAtUbqAu2bcjv91b87JIkoqAwxtyKVNK5r9TX/d6ueMhnVqQDhXcsxtVjlkxfQMRNlKyfK0r7KHXGGgSrhfjbB6oyAI0Wlb25nSLQQTqnfFGFoosviej2/2T8/6AagIwv+cTX3zCbcAtLK6Q53w/UgpLRvYHT9cVFR0PzIqbpBueKvkIkYHJC4eOHAJu/zpq3JI5GQ4NrqXgBzGwHA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(376002)(136003)(82310400011)(186009)(1800799009)(451199024)(36840700001)(46966006)(40470700004)(82740400003)(6666004)(4326008)(47076005)(40460700003)(86362001)(40480700001)(36756003)(356005)(81166007)(2906002)(36860700001)(426003)(83380400001)(336012)(1076003)(26005)(478600001)(110136005)(8676002)(41300700001)(70586007)(44832011)(8936002)(5660300002)(70206006)(54906003)(316002)(2616005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 09:07:29.6944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf51cb5-0762-4894-dd2b-08dba93889c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5779
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

