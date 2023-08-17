Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E7977F617
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 14:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350674AbjHQMLJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 08:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350732AbjHQMLF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 08:11:05 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEB52D68;
        Thu, 17 Aug 2023 05:10:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+BrVkY/VEjL4Dee20IzLo8Of8fX7C7r00OJp9Oabbvy/IpNHyZLscOa/4wcgpug5OkXRYXxnvylrCDbyhxx6NUpScImQV3pFk2NiGPfM2+FXTyO07+h9/uyU/zZuiZrs4H/ilTNnZc4czlgSGH+40m9Sgoe/RUjAMP1lRBK+y/7ah5s/Mq2OHK/quwBImry3qWwcdcKSNrnhLKfYlGp6/NHcPC//nICbKozS6AURecWC3W86728CoXlER05iCAJvps36j3sDJKv796/Nx+rTKmV4as760SBwWGCuOoLp/7TN1wDdeGrGC9l3tsA9G8TicJia/AYD4Olsk6Eb7HvLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhaIFtd40nJutx+8uNmpgV6+pnbP4bDCepGq+QR4OSs=;
 b=k83VJ3xEdC8bvxnsWZYdVdekgwBDHdNSoADZMe2DEdA2bo1pKdWmKGEclhN/Oag4RmahhyYa7ovewkUWt5yeuy7TTxIMYuzYA4DjMY3/tl2E34/zVop4quag2EksCCb4Ymh312XkBBKSuX+eVkGEPKBWPlOSYHCRJk+/lKudZfdhcJr6wp7ZaeSlKWq/RCVNx82hmu3UI4BUhepUj6g2WIxdXBv5N7THfn8Cvzoa00mgZ73fHEwN7sl5pCZeHaGE0VpQD/s3GVjBYqtCipsRtzf641dt2imHphsFFgfkhZGu0CyY6nooDGVI8KlclI2E1tOri1XaOygwlGO6C0PtLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhaIFtd40nJutx+8uNmpgV6+pnbP4bDCepGq+QR4OSs=;
 b=w6s8fUjDc+oW/1hkIOvZQ4b8ncaDsXvZEgEEDJh5z61k4ah9OiZ5ZmVIL1A30bl5fNhTqyEtilASfsEzY5kgW5Bm9ONiyckJ7GDae2ikOKpzHHwgEQ8oMW4s+XrhLqcghWTSYJ8P30POVWer9jpqpTwiAyfh008N/hMPvMM1q50=
Received: from SA1PR03CA0018.namprd03.prod.outlook.com (2603:10b6:806:2d3::29)
 by MN6PR12MB8471.namprd12.prod.outlook.com (2603:10b6:208:473::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Thu, 17 Aug
 2023 12:10:52 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:2d3:cafe::57) by SA1PR03CA0018.outlook.office365.com
 (2603:10b6:806:2d3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Thu, 17 Aug 2023 12:10:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 17 Aug 2023 12:10:51 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 07:10:51 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 07:10:51 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 17 Aug 2023 07:10:48 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC:     <bhelgaas@google.com>, <robh@kernel.org>, <kw@linux.com>,
        <linux-kernel@vger.kernel.org>, <lpieralisi@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        "Thippeswamy Havalige" <thippeswamy.havalige@amd.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
Subject: [PATCH v3] PCI: xilinx-nwl: Remove unnecessary code which updates primary, secondary and sub-ordinate bus numbers
Date:   Thu, 17 Aug 2023 17:40:40 +0530
Message-ID: <20230817121044.8176-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|MN6PR12MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: cedc233e-fff9-40d1-e8da-08db9f1b0040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bL2Pl2AZ4U0IOcMBPog231G/fHJ7AZKiuJALzoSndtFNGspFK/C9U16KXJYC0zikguWWNXqWQ9jN1V4vaGkN6Dpp7BlrdC7F8/SQk1Y75qptJxD7KAbAmTJdxljcp60iejV9Fxwc5l5r4AXmOMcpGH/WzSz/FlPWITgX9PWKU7g69LgN//+mXV3PPuv1RMCUG3JJ3l4JV0b8PEaFhQKIclb9z3nMTUqmwS85s6t1tgHAYAWWzsEDgFZvAcX58BWVo1osTmBZ+AyHWyuzItjRsKJ3GXKucqq3MMzsC01t5OXi+j7UIMbnASBfAIwJ51lLDx5Xcr5ZhY+qA/bChNNcxAWkHz/C4mEAyYaSM463zfWISooTO8f3tyu56IY1kJbDuhtD96+89IpRJVINKPPrW0jxtjZL8N4pdQO7iLLXWS1tmj/7LoDIN0CRCna8OOAEF4TZhvc45jHqjyJmGUAyanokghrqE6JkeAdGVEveHt0Ja2INfHTUroKqJfjRBZwP1/8TxbwByDLRLz3UX+DkK+6/TUC3TdlK8AL42/yGivN6HY4B/vvWzgGRAwL0X+2POn23do16G7qmn9Q4NBaVSDwkxTuavqEcGWQ03x02UaTL5wgD3OHSN7PDy2b+vj0/Eza8WcZ3aK7dlI78Xr/a/jth2p1D/CRQhv7sMT9fEzPk446UoqOmdoSTwVeBSgb0Lah3sl/AIfo5Rp0rLJyNJsySWlE5TC4PAJKiZqIUAwYyQHa99FUD5h62wX71nsh5FGhDL2ydjHltmnO1XjGQbIBQV50L9p38vMNJ+yKkBKY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(1800799009)(451199024)(186009)(82310400011)(46966006)(40470700004)(36840700001)(316002)(54906003)(82740400003)(356005)(110136005)(81166007)(70586007)(70206006)(5660300002)(41300700001)(36860700001)(44832011)(47076005)(4326008)(8936002)(8676002)(26005)(40460700003)(2906002)(15650500001)(83380400001)(40480700001)(336012)(478600001)(426003)(7416002)(86362001)(36756003)(6666004)(1076003)(2616005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 12:10:51.9775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cedc233e-fff9-40d1-e8da-08db9f1b0040
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8471
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The primary,secondary and sub-ordinate bus number registers are updated by
Linux PCI core, so remove code which updates respective fields of type 1
header.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
---
changes in v3:
- Remove unnecessary period at end of subject line.
- Updated commit message.
changes in v2:
- Code increasing ECAM Size value is added into a seperate patch.
- Modified commit messages.
changes in v1:
- Modified commit messages.
---
 drivers/pci/controller/pcie-xilinx-nwl.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 176686bdb15c..d8a3a08be1d5 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -166,7 +166,6 @@ struct nwl_pcie {
 	int irq_intx;
 	int irq_misc;
 	u32 ecam_value;
-	u8 last_busno;
 	struct nwl_msi msi;
 	struct irq_domain *legacy_irq_domain;
 	struct clk *clk;
@@ -625,7 +624,7 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 	struct platform_device *pdev = to_platform_device(dev);
-	u32 breg_val, ecam_val, first_busno = 0;
+	u32 breg_val, ecam_val;
 	int err;
 
 	breg_val = nwl_bridge_readl(pcie, E_BREG_CAPABILITIES) & BREG_PRESENT;
@@ -683,15 +682,6 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 	nwl_bridge_writel(pcie, upper_32_bits(pcie->phys_ecam_base),
 			  E_ECAM_BASE_HI);
 
-	/* Get bus range */
-	ecam_val = nwl_bridge_readl(pcie, E_ECAM_CONTROL);
-	pcie->last_busno = (ecam_val & E_ECAM_SIZE_LOC) >> E_ECAM_SIZE_SHIFT;
-	/* Write primary, secondary and subordinate bus numbers */
-	ecam_val = first_busno;
-	ecam_val |= (first_busno + 1) << 8;
-	ecam_val |= (pcie->last_busno << E_ECAM_SIZE_SHIFT);
-	writel(ecam_val, (pcie->ecam_base + PCI_PRIMARY_BUS));
-
 	if (nwl_pcie_link_up(pcie))
 		dev_info(dev, "Link is UP\n");
 	else
-- 
2.17.1

