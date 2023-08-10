Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A66177781C
	for <lists+linux-pci@lfdr.de>; Thu, 10 Aug 2023 14:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbjHJMUk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Aug 2023 08:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbjHJMUi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2023 08:20:38 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589F026AF;
        Thu, 10 Aug 2023 05:20:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxJCcAE5PsV7NTqewok0738UJX9joC6GuNyQjzsZNFv5dw4SFwlR7CBQgzkwwCn9o3hL1fV4jbdNzNCe/00SJIVdm/7Ok0U0kScAB5EsdXBLLwoXLYjl67reX1twjxK60hbN1Rnll5OmDiG6zxmdvyrprkK5cOZylESj4BEC0kYYmodbtgUwPV1ZYn5RxJeOpJLqApW2SBNFLw+qW/TmHQDhaqOC4zSJghdr9atvA3arYceqDGnQH5sQ5WjJP3lwf3oA88GZtlpKSyiQGGVsiyGvyelxpPnc9ddOlxB72JnOV5A32OOdl0fF/c6+rLqJKi65kCBuROTjs5fOt9cciQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qL+9EEhdSw2IZHmeZrle/1tGM2mf6KvizCqtGMRmV6o=;
 b=ATIisK0x4doDyyOzljthnB9LpbR/YwQB3yhq/AeauGFvU/6rd88mzn2tkbNVg5bo/hAbyI4jPfr0HAexZrTG4NLLLNNVaqk4uCzCnsYjM1w01FVmyVlE1Ojq38GgtUk1kiUScy6sohKipjcDY/oXUGH4z9+hBxx3ceQPMUX3Y3d1GOsm/nJlVNoqrlolZt9mff+NmCblYLwthqDkin7GybarloRm7zkHqLRXo7eEdxCi0l8HxTcsTuzM/UgjQGfIrDA7piLF+d1RRYJre2OznGzUb9qbjCuvBlc0PMxjpm/OB4C8ByedqiMcX5/IXTLJtMLH93PAUuN7OwPlOGTBqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qL+9EEhdSw2IZHmeZrle/1tGM2mf6KvizCqtGMRmV6o=;
 b=RT2wKPq7GanLqevK8s4WnQ0LXOvumvO4n5L7UhwHQJave2I5W+7B2ptAm5qvPDsx2n8JJr4H5pCbzIavuum3K/D2og0MTz+l5i6O2MSULR5jGv7xYN3DzC6wPVDUbMePrXhRfaxR7vQ7hx1yfnubXcOqbOTVzJAJv/YubWRJlWk=
Received: from BN9PR03CA0240.namprd03.prod.outlook.com (2603:10b6:408:f8::35)
 by SN7PR12MB7369.namprd12.prod.outlook.com (2603:10b6:806:298::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 12:20:30 +0000
Received: from BN8NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::7d) by BN9PR03CA0240.outlook.office365.com
 (2603:10b6:408:f8::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Thu, 10 Aug 2023 12:20:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT103.mail.protection.outlook.com (10.13.176.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6678.18 via Frontend Transport; Thu, 10 Aug 2023 12:20:30 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 07:20:20 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 07:20:19 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 10 Aug 2023 07:20:16 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <krzysztof.kozlowski@linaro.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <conor+dt@kernel.org>
CC:     <lpieralisi@kernel.org>, <bharat.kumar.gogada@amd.com>,
        <michal.simek@amd.com>, <linux-arm-kernel@lists.infradead.org>,
        "Thippeswamy Havalige" <thippeswamy.havalige@amd.com>
Subject: [PATCH v3 2/2] PCI: xilinx-nwl: Increase ECAM size to accommodate 256 buses
Date:   Thu, 10 Aug 2023 17:50:02 +0530
Message-ID: <20230810122002.133531-4-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230810122002.133531-1-thippeswamy.havalige@amd.com>
References: <20230810122002.133531-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT103:EE_|SN7PR12MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: 24a4a6bb-4661-4109-bf4f-08db999c2fe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 67zpsX3/Z3mnXSkhrPRdOobXGT6Uu3j2BbnJMQWxEIVZSSR1rdGRTTkw4FlgfGhPZFwZGH7zxwlljKdhhElLU63898ON4jWIpNjiPvgzj4QD8tfsg0zN5/UshPYnvtATgTWZUGEtIajfWs+uBH51quCdnoVQaOEChrQv7i/d3ONgw6RktGMj70Ojp6+DhqnmSRnF3I8izbXZ6VmjqTLX/mwjR4wWPCixyBqU62/bsyuMTa5w/qdW0O3Y0ltcCNceMuQPgMWgv8TqGcceiYSoM+DJAWE7HSO8h8t7WhtOKtVJMTVp8VG+c+SdoLuoeEzs2XZAS/r1AA9/dzHgO/FnnCmQDMQS2cbywuKTKOrgryboSLtJ4t5AazFq1fpoTDGqDT0hdhM/QczI3+9Ct8SxEo5+KCIMun/aTr+GG1Jmbr0c2VCcBw953OcU6hezKgzVUTo7YuFUx1A0k7gBlsCsqXrwj6cJXUli+dl6KO8ualwhw+vQPr0oz/d8eh7GJ5+tlIiy86zYXHvCU4/d5SQA203NizW3VmhRFEzXbYczfu6bI6zI92l9bGRlkI8Muh7Fjzoz9Kf3nMHqhflOCpmPnTUPOhUkY7C2M/Ou6EGje+/HZQFI9E1coBSIsDmz37wzvFkPCvJ1sK9nYIGDs0DZ51T4aRNpjDlGsKlXcVSdv00L2s7cNEMvnUzD04Kz8Gpx9+uv0P9nCMJMbVN0pdZgTnHFGRJG2uqhxuFkclNnqDbHAq6IJhA8keXXwrraD2LdeVq7PeIdAuW0Rbpl6yfnEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(186006)(451199021)(1800799006)(82310400008)(46966006)(36840700001)(40470700004)(316002)(81166007)(356005)(70586007)(70206006)(4326008)(82740400003)(41300700001)(8676002)(8936002)(110136005)(54906003)(36860700001)(47076005)(5660300002)(83380400001)(336012)(40480700001)(2616005)(478600001)(426003)(86362001)(44832011)(26005)(40460700003)(1076003)(36756003)(2906002)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 12:20:30.0278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a4a6bb-4661-4109-bf4f-08db999c2fe5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7369
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Our controller is expecting ECAM size to be programmed by software. By
programming "NWL_ECAM_VALUE_DEFAULT  12" controller can access up to 16MB
ECAM region which is used to detect 16 buses, so by updating
"NWL_ECAM_VALUE_DEFAULT" to 16 so that controller can access up to 256MB
ECAM region to detect 256 buses.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
---
changes in v3:
- Remove unnecessary period at end of subject line.
changes in v2:
- Update this changes in a seperate patch.
---
 drivers/pci/controller/pcie-xilinx-nwl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index d8a3a08be1d5..b51501921d3b 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -126,7 +126,7 @@
 #define E_ECAM_CR_ENABLE		BIT(0)
 #define E_ECAM_SIZE_LOC			GENMASK(20, 16)
 #define E_ECAM_SIZE_SHIFT		16
-#define NWL_ECAM_VALUE_DEFAULT		12
+#define NWL_ECAM_VALUE_DEFAULT		16
 
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
+			  (NWL_ECAM_VALUE_DEFAULT << E_ECAM_SIZE_SHIFT),
 			  E_ECAM_CONTROL);
 
 	nwl_bridge_writel(pcie, lower_32_bits(pcie->phys_ecam_base),
@@ -782,7 +781,6 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 	pcie = pci_host_bridge_priv(bridge);
 
 	pcie->dev = dev;
-	pcie->ecam_value = NWL_ECAM_VALUE_DEFAULT;
 
 	err = nwl_pcie_parse_dt(pcie, pdev);
 	if (err) {
-- 
2.17.1

