Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1F47BA71B
	for <lists+linux-pci@lfdr.de>; Thu,  5 Oct 2023 18:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjJEQuP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Oct 2023 12:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjJEQtM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Oct 2023 12:49:12 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6281BDC;
        Thu,  5 Oct 2023 09:42:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sy/kIddQI1eINZvHit6xMVt3mmp4QK6U7W/FAvobDVbK8uskUyp7DUR/sJJM8VfNfeEmdtZileDHnz1b+aOndsRnSPRH1D729y9vkG1Eav/07I+SxuwEsIWvTny8Bl4oOiucSxpldSfJEnDk+hNVwYRZLVwvrT+PSPAgiQHGmjPvJJca8Q4KpTscW33YtRFz/raIg9xE1/F8JgjRS9YCNaMexCxMYes+xrxGwOtb0hrOefD89ywhyJ3/Ahto39y0laFJwUTbBaXxjO36wBdWqKvlRwCPbxanxwgOH6n3fcyXl5JL/ykwJWCeh4v2AzXZEjXJvdPPOfwrSyjBL9HWCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ESYLK1Re4VerwS7kWjWSjaIYrADQbJMwrXP7iIWn9w=;
 b=CxXb3sqseGA3yRebSbnzRZ9nN6kGxcm9/dsU5nysVVd1hKSBcARvOCluZY+MnIgSdpiWJbrCHCWpUwL8HffjwoYcWTtvp9aohH1c3sQaVlanDe8/jJpMJfHTBGb/OlorBR+zZZelmDbwnswkr7rC+UbXNBZP74M7ECfP7nuK4IZGRSQmHcrYYP3vlQJCalf5E7nGMbUCE/2YExwgrHXygmJlGeQ0lKZQEN6dHYQc9Q2CBitFXhkHK65WSCRbmz06IIAUNjg/kMf7Xj/vSOytBPYRRQNt2nDgFw919Ab/cXTmM7gNpiF4habW2KVPYdlc2QtgHuMmD3vy4CWt+3UeZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ESYLK1Re4VerwS7kWjWSjaIYrADQbJMwrXP7iIWn9w=;
 b=qDt03ihS3CyTaFNg+tUuYLIZCoW1n3dFlBo0mlHKDgDN7HMEuB8/lmApTXFWE/WZAdicE2aTB1anOt6vj+HRKgMT4NBHK/Qv3q2sHEnUwgT6DTiLcMky2QgbBfZrWq7icfh6zOEvPDhVYSBuETtw4SCGGDrN+xIESuAW6q+OFxs=
Received: from DS7PR03CA0205.namprd03.prod.outlook.com (2603:10b6:5:3b6::30)
 by SA0PR12MB4384.namprd12.prod.outlook.com (2603:10b6:806:9f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Thu, 5 Oct
 2023 16:42:04 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:5:3b6:cafe::c9) by DS7PR03CA0205.outlook.office365.com
 (2603:10b6:5:3b6::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31 via Frontend
 Transport; Thu, 5 Oct 2023 16:42:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 5 Oct 2023 16:42:04 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 11:42:03 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 09:42:03 -0700
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 5 Oct 2023 11:41:59 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <michal.simek@amd.com>,
        <bharat.kumar.gogada@amd.com>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Subject: [PATCH v5 RESEND 3/4] PCI: xilinx-nwl: Rename ECAM size default macro
Date:   Thu, 5 Oct 2023 22:10:50 +0530
Message-ID: <20231005164051.984254-4-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231005164051.984254-1-thippeswamy.havalige@amd.com>
References: <20231005164051.984254-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|SA0PR12MB4384:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d55d85f-2eee-49f1-420f-08dbc5c20166
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d0yNuT0WGXFRawv6JgctPLFoRFyYM4DCebTwYnFbsb10ejEn9AV3fCk3QE0HmNITnoN5tVxFECu6y09c0EdgJlhvj9OG1kcsmApxvijrREKFByqlNzTvqPLsCZIROFlE4O51XALG66B6s6yHfO3ZAItcObmuNkcYXDh9SfEKbw+y2IyYFF/6PggVMwqgdhkaJj6ZM+wetYRSRzGO9wyZUlZPZx8ZMpW/Ga1c8l33JJ4aY9+VO4U3wRL2IUUvWS+GsU0zy2++ro7YS6Ig4NZ/9zysZ5BWEDj8udsDfEDvJG80BnE+4k+xEd5s1V6EMO6yVqyiXO+fCaPfC91dLDzxADQFXAJXMfaKpFBZ4d6gzQ0J3CW2AsfKzHTgvAvCJ+p7z8kNsDJtAuuiLFmcx/hY8AJgqJ0nAr8BtrIZOd5AEsbYjZaBbod6srKaMISgsqh0n01co7mOh7ZVHt9oZWLdesrvkdk09x3UCzF6hlyvqQLXpFUq+ktP23TBagD14lBCgzLsj+Z6qhTD0hKm1UbLnt3fZD6unLPYUPAb6mq4VodqDDgr6nslDsQHvBW2jvkPKIrkAVszit5torqLz0J9fprxKsyIdZDWgF6w9ZN4QTNcdu0K+A84C5zXOve+q9GlKzJ3Bl6kNc70Ak9cUt+FZDZFoQw8tQ2aPQtK0t39Ng7aVLzb4fZs0yi9EQri3je7CfCXuNL0H9JS+dDWaOCGaXz93Nwjzw90whCNHHlu7vSn/yOvi8hCnOtO4ukF6Xer5uVo0LSZh+9HRiwIs8AMjf6x5cLMPAkmD33KwhSbozg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(82310400011)(451199024)(1800799009)(64100799003)(186009)(46966006)(40470700004)(36840700001)(7416002)(44832011)(5660300002)(8936002)(2906002)(8676002)(4326008)(41300700001)(70206006)(70586007)(2616005)(316002)(40460700003)(54906003)(110136005)(36860700001)(40480700001)(26005)(336012)(426003)(6666004)(36756003)(1076003)(86362001)(356005)(81166007)(82740400003)(83380400001)(47076005)(478600001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 16:42:04.0082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d55d85f-2eee-49f1-420f-08dbc5c20166
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4384
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rename "NWL_ECAM_VALUE_DEFAULT" to a suitable macro name and remove
redundant code

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
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

