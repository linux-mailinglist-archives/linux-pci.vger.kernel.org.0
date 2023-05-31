Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901E4717A4A
	for <lists+linux-pci@lfdr.de>; Wed, 31 May 2023 10:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbjEaIi7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 May 2023 04:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234145AbjEaIi5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 May 2023 04:38:57 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060d.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::60d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA6BBE;
        Wed, 31 May 2023 01:38:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l77pwLolJdLplLFjYYCFmpHmloBfCaicAbSkysfCcu18iohQst/eYEFvdW5tm9sJHRf2YiBpE9eSa5VbDA7MuyOGRtK3oFYmE3TIECj6bptOkV22HSPWAuLolM8ZkLl8/wS8TYKWlj2Ag+eD1/z12iXL8dannfv6ZFvotiDlaelilg2JzRnJnzljdHBCKfKkSf4d1NIREfxy3QrEm7CFyAiqsqpdPSId+amijo7X2xvdnIDySX1z2YXChe8bLK/shlUlPNmnp3hTjnMR2kO4Z+VA1SYj1WYRanBnED6BfVTy9njW4A8RwjuuhjoWqCZZHWf3QPopVgIFAXMG/7T26w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ex4dGX1NmePJIH6JHUf9op1FoyIeZ5/0qV3oXXYH6SE=;
 b=FoETAn5yBL6Vv59jflXdMTg0qKb6jZLixEbKs1TTpVYKVIwy8QliBA/0mFt0ewl6TUBAkI1YKp3tYzm6E0Uufb00MbUnIt2srHMMPiSliUWCyiUmRKw1SYueTo49zobc2tFZgR4bCkIj2NOwZ16xP6s9tcRVx1/5zFD2F0t9MGtHRmsvakvf5qWuhp1/jA/A2b9MWn5I+kZ1nw6gvjZgwFIhmcu6iaDHLYzLoa/F1KdNnywLHK38Nuz77Xje9pQsqvj+NwQgr2ANjGpPnKcA8KTcl1kHJyApxZJDSjIl0yQV9W0U458BOAJbuHUaucdIDmWFCmR8iTV3kRlhqm2fxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ex4dGX1NmePJIH6JHUf9op1FoyIeZ5/0qV3oXXYH6SE=;
 b=fTZypxd+hbz6AN4qCMO3OA9Ub4+FI7hPUdTgvuMfly5Df/EgNDRB5fTitkFGFKkqZGSnVAGU0bw9dbBrW4roT0EqozL5iBH3pGYa5hwxXhDzq9eaG9MOO7bGk17hPMCxEg8SEU8c6hPkL9WcHp3InjUBCxVuJe85bHDpw5edsVo=
Received: from BN9PR03CA0637.namprd03.prod.outlook.com (2603:10b6:408:13b::12)
 by DM4PR12MB6253.namprd12.prod.outlook.com (2603:10b6:8:a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 31 May
 2023 08:38:52 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::5) by BN9PR03CA0637.outlook.office365.com
 (2603:10b6:408:13b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Wed, 31 May 2023 08:38:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Wed, 31 May 2023 08:38:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 31 May
 2023 03:38:51 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 31 May 2023 03:38:48 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <krzysztof.kozlowski@linaro.org>, <bhelgaas@google.com>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>
CC:     <lorenzo.pieralisi@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <bharat.kumar.gogada@amd.com>, <michals@amd.com>,
        <nagaradhesh.yeleswarapu@amd.com>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Subject: [PATCH v4 1/3] Move and rename error interrupt bits to a common header.
Date:   Wed, 31 May 2023 14:08:23 +0530
Message-ID: <20230531083825.985584-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230531083825.985584-1-thippeswamy.havalige@amd.com>
References: <20230531083825.985584-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT024:EE_|DM4PR12MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: de412d2b-3729-4437-bd2f-08db61b2769f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xo+u0aJ4nJJsUn2PPOhnY3PfAICP2Tu/QqBKBZTkzgZAUx43qQ+2Ltc6x2YemUD/ZNvUi0/1xwLUXgFIIe5Vo2cwqksTdKID685HTerQUyKnydBKJJTr+/lEpervV7uZXfMYV11/ZEO82ioeCULsoMf4CKYN07yBoiDoOItyt0dLHtPnEYqipkVrISbmFMC0YzfpQjVQirZeggXwU4eVmWIGW4Miolos0nLOXyfcGIGH0sXRGi4N2g72ms7+fzPWBeainrR1iLlntjo1z3tP9bxfbxVyZ9BW50rHffQvr3jITbvtN+DCqAiR7HrEcAdq2NZLfv9ROUVN4ljUXTPChHdsrlBXEGC6Ra1DbPy85Pfd97CLJpnksPPGdj08WOXNl38Uh9wupgL21MyIwd04vR1kLlcvkV3Cm1XrIZHLaiTQ7YN46GA0xHsoVmtX+ErPZuhRmC6PQxT+Dt0/iGTQr9XhMQOolJzDbUeeLJFNajeiaXjttQImU1wdvOL3hJv/Wd+ybYpOmORVKMyM4xIs/6SYKFwqvSDbcaS61SEPtI0XlOgpDHhHkWVcytDc4mBPdD3hf0aR6i2JtBqQPEILVjQsVsM/Q7LQVzEiWsSo36KQsIOd59HYobnyh9QXYV8Z1eZmr6RxdlKmhL7UFz9VzzYR1ZZ2m/qqJ449mnPa02W7ANVE/cuAxOzpj3ALp6AX35cpUqR/1cCHKIeqvO20AHJsZzdxriaT+wGHeQ+klBLD3XqVJvpJip7CRzZz4/3+eAGp6X+quwygpeNRLebxqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(46966006)(36840700001)(40470700004)(47076005)(83380400001)(2616005)(86362001)(70586007)(81166007)(356005)(70206006)(41300700001)(186003)(4326008)(82740400003)(36756003)(36860700001)(44832011)(2906002)(426003)(336012)(26005)(1076003)(8936002)(8676002)(40460700003)(5660300002)(478600001)(82310400005)(40480700001)(6666004)(316002)(54906003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 08:38:52.4372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de412d2b-3729-4437-bd2f-08db61b2769f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6253
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move and rename error interrupt bit macros to a common header file for
code reusability.

Move common linux header files for reusability.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
---
changes for v3:
- changed licensing year to 2023
 drivers/pci/controller/pcie-xilinx-common.h | 30 ++++++++++++++++
 drivers/pci/controller/pcie-xilinx-cpm.c    | 38 ++++-----------------
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

