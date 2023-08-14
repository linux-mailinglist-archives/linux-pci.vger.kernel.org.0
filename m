Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F9C77BEB9
	for <lists+linux-pci@lfdr.de>; Mon, 14 Aug 2023 19:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjHNRO6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Aug 2023 13:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjHNROq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Aug 2023 13:14:46 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E728E63;
        Mon, 14 Aug 2023 10:14:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdxCP293cAgv8l6kqyQ8mnqqQEzjpn/s6PP+TurV2VoIe96S3Y6WgkKiK4BM0O2ZdGJfb700EhrsLBze/k5mVgtxoz0aMkNrbHbjbDzOkjbvuyoKBaBQoJloapBwbCUW7uaUB0s4/fWNUWdGRl/LgiWwryYSVw2mNm+aBU28jDn6Kc9/uiUZBls/oIV6RuhEeHoSVsIb8NmvfHzuCIyGDnBXnbaRq/cxE9h+mWcN3J23CJ9A/iuNZp2pOi8bQFrnWosJg3tGS/Ubic72pRLgbak1s1O0vT4X47vocjklGaNQerx3wA94+cFU+Jq1cPwGeB8VuQ7l24YZ371Qh68d0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLKCUOlMcYSFJZi58UF8osoKqjMoCLKxbiWIaGUOu10=;
 b=LMnu4mCty9WuTQqhw3iNGMA+5TskuA6cNDAZ0N8RZ5fzLRaA4BrqWAs48sj6IY2p+yckBYI4RyGWcZaLGevQ/TVrRO3W/qz5ACkbnU4NNlK/lamgOngWx3VIW0uet9umUED7w8RkTnduMDEJW2/owTNLDuo1ORD9Z2btivF4hWMLJig2XGwkNuhzArVPlMpWbMdC0a41mDn5z8OprQCCDNZh4qwVdKTVGOF/cwbftMNIJCZDOTCt4epJs8BrmzKb3LkWRQ2tRsFBYdlUxB1rLY0ApNqsQg2eezD0iqgP8fNiKijt8+N9/gJyiFZuGyWz0b2npADRxZui6GlMXdBjfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLKCUOlMcYSFJZi58UF8osoKqjMoCLKxbiWIaGUOu10=;
 b=coFFCGFO8+bpVJZSOvDm/6UOaQtTwCE1IBoae5rFBjbjAgd1E5RSU3/8JAQ3iU7KKK3lQREv4b2DPmJ5EkNyjf2Gh2zNb9OxXzokR6WNcOQH890wbI5lRV1WAXJV6My6aaok6pX1wyz5dSaDLQu7oGqR4w7Ft5xEZJL/igQkvnI=
Received: from CYXPR02CA0068.namprd02.prod.outlook.com (2603:10b6:930:cd::28)
 by DM6PR12MB4300.namprd12.prod.outlook.com (2603:10b6:5:21a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 17:14:42 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:cd:cafe::ff) by CYXPR02CA0068.outlook.office365.com
 (2603:10b6:930:cd::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Mon, 14 Aug 2023 17:14:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.12 via Frontend Transport; Mon, 14 Aug 2023 17:14:42 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 14 Aug
 2023 12:14:41 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 14 Aug
 2023 10:14:38 -0700
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 14 Aug 2023 12:14:35 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <krzysztof.kozlowski@linaro.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <conor+dt@kernel.org>
CC:     <lpieralisi@kernel.org>, <bharat.kumar.gogada@amd.com>,
        <michal.simek@amd.com>, <linux-arm-kernel@lists.infradead.org>,
        "Thippeswamy Havalige" <thippeswamy.havalige@amd.com>
Subject: [PATCH v3] PCI: xilinx-nwl: Remove unnecessary code which updates primary, secondary and sub-ordinate bus numbers
Date:   Mon, 14 Aug 2023 22:44:02 +0530
Message-ID: <20230814171406.214932-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|DM6PR12MB4300:EE_
X-MS-Office365-Filtering-Correlation-Id: 914f0fc6-3fe6-4c1b-a6d4-08db9ce9f35c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z7QaGKuEgVuMUuo93HeU8h8cRmzFaUUnPygnfGyBBZxuehyC6QqWr+GMsqBYEKK9wcMsu0xMN2w7TklKmK8JZ2YM/yKx68XaSx7MA8yWFP/cuFhiPNkq7asYn5IU9tIe3uDcyHajaozCA4dP9q39Do2QB5X7D9QSBswOvtm2mfi7ovT4WDMxyIDiHJC9mJwiTPBEH8bawM+kAwryIoIT+RQM4zjqiSkEHKhhIOfbA/UA3oz3Gm+V/fuwloLOBhnbEitcSGRJhiClT708sGU1fudHfLt1lr4MZUn+hBOA2LY+Xh5f0h7+6moWljr/0nfnhleR5MexSTyiKeu+Wx5qKcIAEZW3WnqPJN34Cx39bggprs1ce907Cp4LGJR4TJv5NOm10Edahy8VOnT9ZmHRoUh/+Qmsa/fC3qDjMJ92WkrnqoSDtguiI44X5ZZY35AGh094tIkJ6rEuNmMocz7RlNyz0zvLvWN4pwVXAuakyPuyCOMkKcyl4zcFwoUVZjCSR8bb7vYS4+Oq/po+ESbpWfBI2KptTAsdvtR2DOEWQiZl+r4LdXEeYjERHOeSoU53gQNTXzBK1JR2oQV4tOS8nnLvqNwPdx1MgAUidIF39x5gmiUhgnGoajxpq/APhzrfkQQVVzxPkEP/PTlMNfx+BoULT8qVSZlwXcV8Oqj89tXcj975uQwiDX3iyMSNQw56k4X4l/0c8LpdmJOpeEN6K6Cknu0m/Zxyu0xMzv0XKsJ+DXi3DxGw9eabL0D4dF/8FH6dhLsint6Wdx88IAl2HA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(82310400008)(451199021)(186006)(1800799006)(36840700001)(40470700004)(46966006)(36756003)(5660300002)(86362001)(2906002)(44832011)(15650500001)(40460700003)(40480700001)(83380400001)(36860700001)(4326008)(316002)(54906003)(70206006)(70586007)(110136005)(41300700001)(426003)(26005)(1076003)(2616005)(336012)(47076005)(8936002)(8676002)(6666004)(356005)(82740400003)(478600001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 17:14:42.6211
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 914f0fc6-3fe6-4c1b-a6d4-08db9ce9f35c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4300
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
changes in v4:
- None
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

