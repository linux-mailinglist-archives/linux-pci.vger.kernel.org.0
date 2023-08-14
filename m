Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B66677BEBE
	for <lists+linux-pci@lfdr.de>; Mon, 14 Aug 2023 19:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjHNRP3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Aug 2023 13:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjHNRPX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Aug 2023 13:15:23 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28CE10F;
        Mon, 14 Aug 2023 10:15:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UyHR16gg0VtDy7Xo4921CcR76uO4LdKCMW7bJRFXx7cQuGQhl2Uts7nIOTLSqpqDhpv3OOcFTfZoN33gzAi/1Ooo7PeWVCN/PzdvfBTubZ/MieEhsHQuE1GHv1gj9UBz7+mQP76aMLjkMe4YvZHjwh7vw/RY1hSqP12a2Otkzy14zRe3064rY70BUOv0Z62qw0Ba5OdIoY+1ygrFEFZFe6pHK1BYkxy1drBToRgeze9PhRHqlGHZlCezHdBrpcyy/jQeyhPBwD83ZtOYaHj+VISP5gbGNUPDqkUyyx+kbMpCP3cvBM1F3dAM7xu07upNiUESZpM/ln3Smc4RGxWZvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=deIE6rovC3luWUuvw9waiKbKe9xE6VjwznnRTal4t+k=;
 b=CObI0oDI+yCdu6qmTngQe8/0KPYzdlLZiXhcSnVvqM2CRg9tA44bqzYK0r2z+s8IiKK8StCS0vosXAOy3bCrvFVyd0y6RzhMeU8fK3CdIRsNzG8fZLI6+OPlQKr8ea98vATUHnZBmbcaiNpKwfvnrEbAGzV828JSb2Ar5YjUi+tw+N/VkdyeJNXPGvrGT0iA+M4P9rRiDiVDjWHNyPgT3v6CPfrJpQ8ZdLgkMhC8EzPI75uVTJo0esUjn3vJOAch6yO2QnVZ7N0WjffS/e/smwF5ZqXXtxBQ/KrNyetoCt/OsQICXz4FthRNtmJepSYTUvS2WXlvVQGOLVK/HyPNbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deIE6rovC3luWUuvw9waiKbKe9xE6VjwznnRTal4t+k=;
 b=RqFsbHOJrmVeZ1+A+XZ12TzoKh2B1g9i8gBM0+A400hccwO555JE/KFtciBUERhVSIfn8Oo16EuFIOrelMrHkle/lz4xe0LZtlWgGfI0GxLrfq8F84/rdYW7YFI/ryXTkS5nCDRkQHpP9m9gWLpZmmUVSSczIN1dYS465iJN3Lk=
Received: from CY5P221CA0104.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::32) by
 PH7PR12MB5733.namprd12.prod.outlook.com (2603:10b6:510:1e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 17:15:20 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:9:cafe::fa) by CY5P221CA0104.outlook.office365.com
 (2603:10b6:930:9::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Mon, 14 Aug 2023 17:15:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.12 via Frontend Transport; Mon, 14 Aug 2023 17:15:20 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 14 Aug
 2023 12:15:13 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 14 Aug
 2023 10:14:52 -0700
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 14 Aug 2023 12:14:49 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <krzysztof.kozlowski@linaro.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <conor+dt@kernel.org>
CC:     <lpieralisi@kernel.org>, <bharat.kumar.gogada@amd.com>,
        <michal.simek@amd.com>, <linux-arm-kernel@lists.infradead.org>,
        "Thippeswamy Havalige" <thippeswamy.havalige@amd.com>
Subject: [PATCH v4 2/3] PCI: xilinx-nwl: Rename ECAM size default macro.
Date:   Mon, 14 Aug 2023 22:44:05 +0530
Message-ID: <20230814171406.214932-4-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230814171406.214932-1-thippeswamy.havalige@amd.com>
References: <20230814171406.214932-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|PH7PR12MB5733:EE_
X-MS-Office365-Filtering-Correlation-Id: 49712f60-c32e-46eb-0071-08db9cea09c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HwGanJwkHWp6AIigJhwHnCy4b7yL10y1p7J0D92ZaBppAShzuyEellpOeylejbpogySFp43Px1lRjlYiskRUQ/WhHGInAzQ1n3MeBXNsTJhHc1Xm/suSD1cv/XRBasC+s8uRxkTP3R4PNz8Z6o8aFzeID9PL9LuZMlk15h5YedT/U9qFK/j0V3D1gtAjj7ZwWC0zVAVST2UwbjadFFhmzi5kJWraCu4vyY5xwu2Vfu9PSlPTo3+rnWQsgVJXAghcV/l6W7E1VaytEkYCcN6VvpuA42UkZK5u4pkbWWps3nvJhwq8l7K+qWBfXXjzY07FYbYomATKPtJmTjxyloOaAGVtMqlxjxA8c9Uf7pcuQyjIJtngCu32hbQ6aq9OUxGLEQsrGQeseWdE+6Nn7B+p/t5KfLSRx1/D0VpgkHE/Hc2qYhvIRuvLlYMyxaSvnwcZn+UhWdeGsKfua51GRKLZU5982rvNZc/GZOIjss2pOw/O2AeHnrx3igor+Z0BK+cyrkq9p64Ut6iCVwnUMSze9tdURYdEEV8y9F9E8Al3sQubt2kCEVSSN5rPV/DsQtg8ZUxaavit3D3Cho51hALGd0MpBNNq83keW7KGQQfU9qG7eYyDV7ntfHQwWwD/qWVM6JFbXlgtSZ84VzwT7yBef7kRGvfTJYexbYVep9Oo6Y3uSo7eC9/TM4Azdrf4/ql/aP44Qebt5D5X7Pg5uF5bJj0qlZYtViO0dO9xXFAuOdtLiVRjkwBlaRIqRx61KcUnuVF/2ujtaWIBkN1J4Ra2sg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(186006)(1800799006)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(83380400001)(36756003)(426003)(336012)(47076005)(36860700001)(86362001)(40480700001)(41300700001)(478600001)(356005)(81166007)(54906003)(70586007)(70206006)(316002)(8676002)(5660300002)(4326008)(44832011)(82740400003)(8936002)(110136005)(40460700003)(2616005)(1076003)(26005)(2906002)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 17:15:20.2567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49712f60-c32e-46eb-0071-08db9cea09c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5733
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
redundant code.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
---
changes in v4:
- Rename macro
changes in v3:
- Remove periods at end of subject line
- Update commit logs
changes in v2:
- Update this changes in a seperate patch.
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
2.17.1

