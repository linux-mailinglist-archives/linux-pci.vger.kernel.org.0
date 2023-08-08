Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5B9773BAC
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 17:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjHHPx6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 11:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjHHPwH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 11:52:07 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20629.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBD65252;
        Tue,  8 Aug 2023 08:42:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OF/4fIXj6mYG8b3Kl9wxht2UDtMP5MbQQ8rsNJTUnJ/MJGmmm6pyEHx4q7En7yq6H4x7KWYhJeRRIgsb++hV8gVeVgUoBd1/82Ud+7K5NSoPc/ySV0T/xpsjTSnVndU+YQPixSZrkhRSR3qcLtgnffBuNhJD3w2w/JWxbFpjnYqJK3g/RnMHNUc12E6DmtQL2kaWvfQKzikB+IqMRnC42xmPgG8y0pHTKTtdNDd9KQ8uXdHHymk4WRJ46Q8s/+mrLKRYWHcvYRdGqWH1K9eRjnVCYcj0Dp1NnKw50M0PaMvT38wSw3bl3CEXBNxYgahdkUED3S3qKpIjwNyYBrtn4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MT727cE5n5Z7p14SKUaU8uc+4dvWAuUo0kRSN4JV8OA=;
 b=DFaJdyGrd0QuoJgMlTjspru8dWlUwQNU0oBTAWjrRakprz3LaZI8PPikGoScFvQvh0RmdZZ8KF/ykUM6xC8cGjbIDYytQ+I8TKhokGn+Q8JGHomIHSRJ4OW77ggsuFupydMk4Wh5+pAwhZaVpLPjMZNJ5VVXSenikNs5iIfXh10uryKfrCLBhebUQzooLO9TXfB6LV+S1ecjz5GmRbpPzF4vFbiYflcS92x/EPZPEk8f7Fj/3aXqda3/rMmbtVEKAhnrIAAzV8t0CF0gzXwSw+MOXYpwO7+jgxIfmTVQMzf7gaHNZndbBvLmw+Ea5yILwljvcRcVQN3jLXV5xtisAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MT727cE5n5Z7p14SKUaU8uc+4dvWAuUo0kRSN4JV8OA=;
 b=4KJ4urDVqZMSyTshzMqGjfgmvuKlw5jQ/nknjHx6DtcERQgtiGEUmUuO+P4j4yvOSdjaj59NILrAnbBnFyS0FZDwY8hu07XkdR9dHnOT00YkUh3x9cbSoBu6+ruqlQTqBuEPgxOq5P06U76PTjYrJ2ePO/rMWOHT3mBlbMfKGDI=
Received: from CY5PR15CA0041.namprd15.prod.outlook.com (2603:10b6:930:1b::31)
 by CY8PR12MB7513.namprd12.prod.outlook.com (2603:10b6:930:91::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 10:37:46 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:930:1b:cafe::a4) by CY5PR15CA0041.outlook.office365.com
 (2603:10b6:930:1b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 10:37:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 10:37:46 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 05:37:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 03:37:45 -0700
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 8 Aug 2023 05:37:42 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <krzysztof.kozlowski@linaro.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <lpieralisi@kernel.org>, <bharat.kumar.gogada@amd.com>,
        <michal.simek@amd.com>, <linux-arm-kernel@lists.infradead.org>,
        "Thippeswamy Havalige" <thippeswamy.havalige@amd.com>
Subject: [PATCH v2] PCI: xilinx-nwl: Remove unnecessary code which updates primary,secondary and sub-ordinate bus numbers.
Date:   Tue, 8 Aug 2023 16:07:30 +0530
Message-ID: <20230808103733.93707-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|CY8PR12MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: 3169b7c3-bdca-4510-006c-08db97fb814f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BfQWTNRt9puot0FeQ/fZwxHzvDmMEyoZ1fLvguHUGoJHIglTSukc0lD1ZvRHfAnce/jAuptIR16YscS1gkY4YR2ApOw3ovvLELgf+At1ccx9ndnfkgs1BnjKQDbBZupJzV17qurkBYyQajSLed6uqUtHqsw07+5hYnkqHP7a158w1F1h08tXp86FaM46kMt/OWLx8fO6aU2gmrT6iPdIebffPAgEybaaYYLbcFOiwOviJxR8Bn7FvXO+TOlipD8t/97kB/CfZOZoShk0JVatUWBegvf5RZFBp9Hsb9wPtn2ffETiaAg3kGknR6hexn6oCglYLt8brM0YXsGizXx3f2CzGSuuyFO+MvuivOS6IV12EPotfS/SQ11loQyuUjUVfozXBfkJdsebOM9gGxQ9Oz3Xdus8LX8ohpUJbc4pjpyPzB1gs57rrzK6Xi1ZWaL2/e4xT2IVE+Vq9lRulcXLn8TbLzsK2F+uuWJLnGgp9CmcI5Ir8aALe10+/w1tkSCioAOmhoXKAkzNI6glqFeZgZ2uk0TjoGfWndv5JDP7gbg9mnb04XfRbyBYbdhjSpeCfdCxf/ElAeGdVf7I3lRCL1wTfovYt45wfzg0pVL+rqztbizCXWtKWpzkal0JV+gDSC/CDeCCFld2wnOdmQ6wNzbHh3kVvq2mnmG+h0anYxbf+1Xu+wedemo1jC3ACixXmypfBvM6wePublRT/VBUGvroEMQv97k55VsNTzcWWMRcDVg4dnVKPkKycxavMb9Evk0kb4LE8Iy54Zz5pxGZ5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199021)(186006)(82310400008)(1800799003)(36840700001)(46966006)(40470700004)(81166007)(40480700001)(40460700003)(2616005)(6666004)(86362001)(82740400003)(54906003)(478600001)(26005)(36756003)(356005)(1076003)(15650500001)(4326008)(316002)(5660300002)(8676002)(44832011)(8936002)(2906002)(41300700001)(70206006)(110136005)(70586007)(336012)(47076005)(83380400001)(36860700001)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 10:37:46.3987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3169b7c3-bdca-4510-006c-08db97fb814f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7513
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The primary,secondary and sub-ordinate bus number registers are updated by
Linux PCI core, so remove code which updates repective fields of type 1
header 18th offset of Root Port configuration space.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
---
changes in v2:
- Code increasing ECAM Size value is added into a seperate patch.
- Modified commit messages.
changes in v1:
- Modified commit messages.
---
 drivers/pci/controller/pcie-xilinx-nwl.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 176686b..a73554e 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -165,8 +165,6 @@ struct nwl_pcie {
 	u32 ecam_size;
 	int irq_intx;
 	int irq_misc;
-	u32 ecam_value;
-	u8 last_busno;
 	struct nwl_msi msi;
 	struct irq_domain *legacy_irq_domain;
 	struct clk *clk;
@@ -625,7 +623,7 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 	struct platform_device *pdev = to_platform_device(dev);
-	u32 breg_val, ecam_val, first_busno = 0;
+	u32 breg_val, ecam_val;
 	int err;
 
 	breg_val = nwl_bridge_readl(pcie, E_BREG_CAPABILITIES) & BREG_PRESENT;
@@ -675,7 +673,7 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 			  E_ECAM_CR_ENABLE, E_ECAM_CONTROL);
 
 	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, E_ECAM_CONTROL) |
-			  (pcie->ecam_value << E_ECAM_SIZE_SHIFT),
+			  (NWL_ECAM_VALUE_DEFAULT << E_ECAM_SIZE_SHIFT),
 			  E_ECAM_CONTROL);
 
 	nwl_bridge_writel(pcie, lower_32_bits(pcie->phys_ecam_base),
@@ -683,15 +681,6 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
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
@@ -792,7 +781,6 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 	pcie = pci_host_bridge_priv(bridge);
 
 	pcie->dev = dev;
-	pcie->ecam_value = NWL_ECAM_VALUE_DEFAULT;
 
 	err = nwl_pcie_parse_dt(pcie, pdev);
 	if (err) {
-- 
1.8.3.1

