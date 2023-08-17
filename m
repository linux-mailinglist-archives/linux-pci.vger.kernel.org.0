Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FBB77F61C
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 14:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350678AbjHQMLK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 08:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350746AbjHQMLH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 08:11:07 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8842D50;
        Thu, 17 Aug 2023 05:11:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLZWlQ1TL6pLJF252hW0kPgEzR5x/Bu2+nPdzgeT/l5ao8Q+13fZjItzlpO+WQHkPpnWdHbXKhvQ2xN/n+/RLAyFYh3HtkcPV/xALJ5DwfD2NnwRHUnGS4X9f3kVIdqRkDFTkoopiW2ALGQLARkj8cVleN8gXgSmmiZBPjdcQswM1kGznZ3bsceMmVbDqXulsEZoYwjvNRyNT+ILhbkZWCz1xQLLzIsCM7PqSVDuNwBLhDNpJjwWtw9oN9p6oVRzZCeu8VsvpupRWX8Yp5rv+xuQ1Z+4V2tuVcGK9fj1WTsyJYyRQwvIdtu1yHjW8ullcSHw9Di8J8I5ucDlMCtYjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+oh3lXVsbuiVcHx7e9dInhMNcxExbwf54M5xlj0TPo=;
 b=CB9mw2BJs5bt5PK995qsnNe530YlLo/+5sa5XaLlOYevPDkWE3fwXbBI9UR4aCa578NnHeKHBCxygxe9zVAUbys1Ye39JVIOf+r+sjNcgoA8ek46KuIMu5x7MzYZIBx6RfI8cao0Y2nVeSZ9xRGCbL8c3D94nI1sBtA7G1PRkIt9dTZ+hSr1G4aobE9saZuzExNGVjMO4KpJ0I6dsGohoxGWApu2bQj439IcTYpvFvUhXRh/ML5nJJ48zKghz/zWTXUZkle9PL09Hm2l1AQuD8D1rhExryMsBk9ujSBNZ+/WJ0bxFwk0XeHP/Stt9ic6uS50myb393aPGKazlgarhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+oh3lXVsbuiVcHx7e9dInhMNcxExbwf54M5xlj0TPo=;
 b=xSIif3288HdpxSyEFSXffBP7cM0iK7M/aUFP6GR2O0iT3hhaGqGI8xeFv4W6o9tov/YAa9Ni9KjXKcSibu0uS6CGzrMq3bVPr+r8jL2qP1O1VtWQ2lbB/dRbqAnuWRd84X8yoycqPOdPLPzeNF7C7Z1SLfeFgADPyircYT/njWk=
Received: from SN6PR04CA0102.namprd04.prod.outlook.com (2603:10b6:805:f2::43)
 by MW4PR12MB7360.namprd12.prod.outlook.com (2603:10b6:303:22b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 12:11:03 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:805:f2:cafe::c3) by SN6PR04CA0102.outlook.office365.com
 (2603:10b6:805:f2::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Thu, 17 Aug 2023 12:11:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 17 Aug 2023 12:11:03 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 07:11:02 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 05:11:01 -0700
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 17 Aug 2023 07:10:58 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC:     <bhelgaas@google.com>, <robh@kernel.org>, <kw@linux.com>,
        <linux-kernel@vger.kernel.org>, <lpieralisi@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        "Thippeswamy Havalige" <thippeswamy.havalige@amd.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
Subject: [PATCH v5 2/3] PCI: xilinx-nwl: Rename ECAM size default macro
Date:   Thu, 17 Aug 2023 17:40:43 +0530
Message-ID: <20230817121044.8176-4-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230817121044.8176-1-thippeswamy.havalige@amd.com>
References: <20230817121044.8176-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|MW4PR12MB7360:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc9c8a0-01bf-4822-852e-08db9f1b06de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pvh4d8auXNm2FplkL/yFH8dF/0qYOlXuLmvmRUuaouY72ZeZJq87lDF/0/qNaqLqRV89YMwwXmwfvzrdlp4okAPffWFIlCqfhtEY9URq346x+TpPnlJxERxCmLl4rx75m4bpud9dej6NDiCrihIFOprqONaDNAMFphnOSAzRrOOuWDNrn6YJjxHTwpwJNbfIHyeh/WO5gP0VwqP4KC+rg7H3dxKD56R2AQdKT8vRfph1Ie5zdakL6RHA2wMnCEVWg2xmouxsKyH6FbWjZ8DmIUuj3FiwXztGAI2HgWtkfjg9txs4C/i8exON9f+KZYeWnS+2CXhm2TxfnD9tHOqLhpPZ0V63vE1VnnO38oqVKYSj9CpVONis4mvK63oy4aDkhN5QNa3u1yEqbJ0j1/X/bqc/PKquhG7ThZPToPabL+EARaHUSadraEQALanipezEzIv5FQsRUq8KeRdGFsW8VPYdN2VScSKTwTLgwAyE36TFzDzyUHZvkpkNNwyMOAkErZzspbJ9OcMBqubbOQuPD8bYW0wVMFyV6fYvQUcjHTQQHw/RDqvVsOs8adb1HcyInpIFfzhySaPrOmldisyy0gRTAgzeW/YM3znLq3ZCYL8eBymZ5tU0Qhk7HFa43PZzVy2nOZSWupYwDAyJcA7PltUj5wWQ3ikZ0GVNsfeoL5lUBTv8FtwwW+7vI1qqfz8qKFKddMHdJoJEPrqLgY+QRPPny8p9KWLMmysYov/6VMQTvOl3vz0uCyX88BUVyV+3EvmQPsPGz1r80b47yoiNxLAd9N+kbOixfSkQd6IjtFcoDaCeD9IWPu2tq5QhD8bscivQVJsFLnf7/fqqECVVGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(1800799009)(451199024)(186009)(82310400011)(46966006)(40470700004)(36840700001)(316002)(54906003)(82740400003)(356005)(110136005)(81166007)(70586007)(70206006)(5660300002)(41300700001)(36860700001)(44832011)(47076005)(4326008)(8936002)(8676002)(26005)(40460700003)(2906002)(83380400001)(40480700001)(336012)(478600001)(426003)(7416002)(86362001)(36756003)(6666004)(1076003)(2616005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 12:11:03.0611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc9c8a0-01bf-4822-852e-08db9f1b06de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7360
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rename "NWL_ECAM_VALUE_DEFAULT" to a suitable macro name and remove
redundant code

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
---
changes in v5:
Remove period at end of subject line.
--- 
 drivers/pci/controller/pcie-xilinx-nwl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index d8a3a08be1d5..8fe0e8a325b0 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -126,7 +126,7 @@
 #define E_ECAM_CR_ENABLE		BIT(0)
 #define E_ECAM_SIZE_LOC			GENMASK(20, 16)
 #define E_ECAM_SIZE_SHIFT		16
-#define NWL_ECAM_VALUE_DEFAULT		12
+#define NWL_ECAM_MAX_SIZE		12
 
 #define CFG_DMA_REG_BAR			GENMASK(2, 0)
 #define CFG_PCIE_CACHE			GENMASK(7, 0)
@@ -165,7 +165,6 @@ struct nwl_pcie {
 	u32 ecam_size;
 	int irq_intx;
 	int irq_misc;
-	u32 ecam_value;
 	struct nwl_msi msi;
 	struct irq_domain *legacy_irq_domain;
 	struct clk *clk;
@@ -674,7 +673,7 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 			  E_ECAM_CR_ENABLE, E_ECAM_CONTROL);
 
 	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, E_ECAM_CONTROL) |
-			  (pcie->ecam_value << E_ECAM_SIZE_SHIFT),
+			  (NWL_ECAM_MAX_SIZE << E_ECAM_SIZE_SHIFT),
 			  E_ECAM_CONTROL);
 
 	nwl_bridge_writel(pcie, lower_32_bits(pcie->phys_ecam_base),
@@ -782,7 +781,6 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 	pcie = pci_host_bridge_priv(bridge);
 
 	pcie->dev = dev;
-	pcie->ecam_value = NWL_ECAM_VALUE_DEFAULT;
 
 	err = nwl_pcie_parse_dt(pcie, pdev);
 	if (err) {
-- 
2.25.1

