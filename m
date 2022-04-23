Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7442350CA23
	for <lists+linux-pci@lfdr.de>; Sat, 23 Apr 2022 14:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbiDWMxJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Apr 2022 08:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235561AbiDWMwi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Apr 2022 08:52:38 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61E11A802;
        Sat, 23 Apr 2022 05:49:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHIG91skkS4N/NkDNZ+LH5fUuPejBqd28ldE3pVLerc6KVGg/tUO7QR7o1YBq8AV4Urx8xSJQGLL0Wru1lJdTSSHMu5MqijhjLU2bsCBOiZbESGtSKLJ5CxkNRfd7+P63Y3ByGwfHiDmBsQ/pM1fIeIsKSy3UERV8Yvhek70mhbn+d5Ya/bqEB2t/RyNAlCatfNwmsgWmWemjD39aa7mJRT/eMJHSY1JiMfPEgJ4zW3VQU18iJVenXbctSbvaMHOl67SSuAnmp/PhOI0eYJvS4zdCZbch39RoNGyfEkNrSEPACzMVitoV9sB4WktRqH8OWhWIb6N74pyzGneb8Sfiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nk+0uTuH9T3LpqkO6N+8YbWoaRTGgagwOJvgjCx4qE=;
 b=VCHCw3MhXbmZWnwAoHWh3LuvCiHrFo1P6ghcMHvqN4hJCf7WEE8Rod/hl5WJXWi/ryeN85rhq9Phn8Qj5kPGuZJA6jfXUlDgUBY14vGalBKdJzXYqj1p7cWtxoRFaEj8IkKlmS6YtfnoolleiR0AudjfmyADoaQ6ZFYuB3xSCauhrfHjxgo3ahnrdoRLCNVksYQwPMzapsEv1sVYZL0aYtSEUj4V94buxSO9ri/+pIbUbhW70CMt2TpgH5isqyNAA1ZMkLEduMXSUd2h7nqY2eK1tnnkZtqhbYCJTjmvzd86uirPU0FhEep4wDrRqpUeZj75S+NJB9f3pDNt81Z3cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=ti.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nk+0uTuH9T3LpqkO6N+8YbWoaRTGgagwOJvgjCx4qE=;
 b=Rca722faYqEdTUlK5kA7QUn6pAnLYU2Ql0GhMk+eJOxK5ZoVnJQWC1P3CwNwMGVRsrjop3Mjf0VyxvckFNS6NO1r2qh764xhpEyY1zE0CLsJKD/5b/sybP30Z2GO/4rtDlMmyzmmayIwPOGX9XlBH0USUjoh+vVm/95BrkfBsLS+pf12CkS6zWSUpBjJks8gMgFsAzOo5cbh7lSIMFBtwLWcxRFUwbqzu7BNRkMswTh6ztYBGT3zTSmQpuZrSCGd4ocvePqp+h0yQ7spbJLjh+rvOmy7x54cOzSFtMmcb6CJx48rXRBhAUtjTc+XimqOYFAodcUNKVSrFPz534ronA==
Received: from BN8PR16CA0032.namprd16.prod.outlook.com (2603:10b6:408:4c::45)
 by BN6PR12MB1268.namprd12.prod.outlook.com (2603:10b6:404:1a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Sat, 23 Apr
 2022 12:49:40 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::bb) by BN8PR16CA0032.outlook.office365.com
 (2603:10b6:408:4c::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.19 via Frontend
 Transport; Sat, 23 Apr 2022 12:49:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5186.14 via Frontend Transport; Sat, 23 Apr 2022 12:49:39 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Sat, 23 Apr 2022 12:49:39 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sat, 23 Apr 2022 05:49:37 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Sat, 23 Apr 2022 05:49:33 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <kishon@ti.com>, <vkoul@kernel.org>, <kw@linux.com>,
        <krzk@kernel.org>, <p.zabel@pengutronix.de>,
        <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V2 5/8] phy: tegra: Add PCIe PIPE2UPHY support for Tegra234
Date:   Sat, 23 Apr 2022 18:18:55 +0530
Message-ID: <20220423124858.25946-6-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220423124858.25946-1-vidyas@nvidia.com>
References: <20220423124858.25946-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6e94b2e-f3eb-49e6-2a51-08da2527bb38
X-MS-TrafficTypeDiagnostic: BN6PR12MB1268:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB12687D89B2B85A4B543F7C7DB8F69@BN6PR12MB1268.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: blXFQCVwPuo+FQ4qtswDvvrdFlZPaw3k7ym8gVz6+eZrb7R9wXORndChvUP58L0/ObpwLU7PjoYAHjUBOxZa5GitwB6BBNuO7JKgVvCMjqlSBa0+gK6l+x/zIx7sfXWO/ZXbE2tjWvH2hXjg38fu2fD4FAtcJ0USST3neHUIQNBkTvWYWoAi+mF4NamprvHbsu6akbWdEeChseQy4YC5zV/vjlOBXb3MCe6KdiCnT7hqXjBOUmcdLA/4GXk/CLrJLbXWw7nq23aiR8GkiHz9oDCjjIOOLiM+R2q/RzqB9dy/nsOht5xFEc5tr518Jdnfe+ZFXsOIxJ6TGABTrz0dob2/gGC3OOmspadPkuiCBvpyqAvYztu2o8GY96Cr2Nf014MJd5WJ45ql08s/vnXNbWsHPploP4RsaiqKY8HqLR8pkh053LPpMGN5FGmFzXd6HBrIJFjRe8oseBMSMjxOKDQHeIV/IeAbmkoULTFg7n9SXtR1iVc3GJ4Ed7BOFfln1LAv/DdbY+tIl22RtcNJnPrFQOvdPqeVfbk6mvGxiGsXfNsTfft1Kl27XBT51058o/mbbMIUXtHrPvm6awO7R3WuYcb6Braxu/4j2VBBVPyK1egRyTVoP0pnYyL2ZvjYN9xH4yKAlq4A4d6H7jgErJZleVkZyf601CKeQlRksi3QWNMsgmk3ant91XQaIKpqkk3HIF7m5iTe2y1Z/0tsfQ==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(7416002)(356005)(40460700003)(186003)(2616005)(508600001)(70586007)(26005)(1076003)(47076005)(426003)(336012)(82310400005)(83380400001)(7696005)(36860700001)(316002)(81166007)(70206006)(6666004)(5660300002)(2906002)(54906003)(8936002)(36756003)(6636002)(110136005)(8676002)(4326008)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2022 12:49:39.9600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e94b2e-f3eb-49e6-2a51-08da2527bb38
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1268
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Synopsys DesignWare core based PCIe controllers in Tegra234 SoC
interface with Universal PHY (UPHY) module through a PIPE2UPHY (P2U)
module. For each PCIe lane of a controller, there is a P2U unit
instantiated at hardware level. This driver provides support for the
programming required for each P2U that is going to be used for a PCIe
controller.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* None

 drivers/phy/tegra/phy-tegra194-p2u.c | 48 +++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/tegra/phy-tegra194-p2u.c b/drivers/phy/tegra/phy-tegra194-p2u.c
index 3ee02b9eb04f..1415ca71de38 100644
--- a/drivers/phy/tegra/phy-tegra194-p2u.c
+++ b/drivers/phy/tegra/phy-tegra194-p2u.c
@@ -2,7 +2,7 @@
 /*
  * P2U (PIPE to UPHY) driver for Tegra T194 SoC
  *
- * Copyright (C) 2019 NVIDIA Corporation.
+ * Copyright (C) 2019-2022 NVIDIA Corporation.
  *
  * Author: Vidya Sagar <vidyas@nvidia.com>
  */
@@ -14,6 +14,9 @@
 #include <linux/of_platform.h>
 #include <linux/phy/phy.h>
 
+#define P2U_CONTROL_CMN			0x74
+#define P2U_CONTROL_CMN_SKP_SIZE_PROTECTION_EN			BIT(20)
+
 #define P2U_PERIODIC_EQ_CTRL_GEN3	0xc0
 #define P2U_PERIODIC_EQ_CTRL_GEN3_PERIODIC_EQ_EN		BIT(0)
 #define P2U_PERIODIC_EQ_CTRL_GEN3_INIT_PRESET_EQ_TRAIN_EN	BIT(1)
@@ -24,8 +27,17 @@
 #define P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_MASK	0xffff
 #define P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_VAL		160
 
+#define P2U_DIR_SEARCH_CTRL				0xd4
+#define P2U_DIR_SEARCH_CTRL_GEN4_FINE_GRAIN_SEARCH_TWICE	BIT(18)
+
+struct tegra_p2u_of_data {
+	bool one_dir_search;
+};
+
 struct tegra_p2u {
 	void __iomem *base;
+	bool skip_sz_protection_en; /* Needed to support two retimers */
+	struct tegra_p2u_of_data *of_data;
 };
 
 static inline void p2u_writel(struct tegra_p2u *phy, const u32 value,
@@ -44,6 +56,12 @@ static int tegra_p2u_power_on(struct phy *x)
 	struct tegra_p2u *phy = phy_get_drvdata(x);
 	u32 val;
 
+	if (phy->skip_sz_protection_en) {
+		val = p2u_readl(phy, P2U_CONTROL_CMN);
+		val |= P2U_CONTROL_CMN_SKP_SIZE_PROTECTION_EN;
+		p2u_writel(phy, val, P2U_CONTROL_CMN);
+	}
+
 	val = p2u_readl(phy, P2U_PERIODIC_EQ_CTRL_GEN3);
 	val &= ~P2U_PERIODIC_EQ_CTRL_GEN3_PERIODIC_EQ_EN;
 	val |= P2U_PERIODIC_EQ_CTRL_GEN3_INIT_PRESET_EQ_TRAIN_EN;
@@ -58,6 +76,12 @@ static int tegra_p2u_power_on(struct phy *x)
 	val |= P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_VAL;
 	p2u_writel(phy, val, P2U_RX_DEBOUNCE_TIME);
 
+	if (phy->of_data->one_dir_search) {
+		val = p2u_readl(phy, P2U_DIR_SEARCH_CTRL);
+		val &= ~P2U_DIR_SEARCH_CTRL_GEN4_FINE_GRAIN_SEARCH_TWICE;
+		p2u_writel(phy, val, P2U_DIR_SEARCH_CTRL);
+	}
+
 	return 0;
 }
 
@@ -77,10 +101,19 @@ static int tegra_p2u_probe(struct platform_device *pdev)
 	if (!phy)
 		return -ENOMEM;
 
+	phy->of_data =
+		(struct tegra_p2u_of_data *)of_device_get_match_data(dev);
+	if (!phy->of_data)
+		return -EINVAL;
+
 	phy->base = devm_platform_ioremap_resource_byname(pdev, "ctl");
 	if (IS_ERR(phy->base))
 		return PTR_ERR(phy->base);
 
+	phy->skip_sz_protection_en =
+		of_property_read_bool(dev->of_node,
+				      "nvidia,skip-sz-protect-en");
+
 	platform_set_drvdata(pdev, phy);
 
 	generic_phy = devm_phy_create(dev, NULL, &ops);
@@ -96,9 +129,22 @@ static int tegra_p2u_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct tegra_p2u_of_data tegra194_p2u_of_data = {
+	.one_dir_search = false,
+};
+
+static const struct tegra_p2u_of_data tegra234_p2u_of_data = {
+	.one_dir_search = true,
+};
+
 static const struct of_device_id tegra_p2u_id_table[] = {
 	{
 		.compatible = "nvidia,tegra194-p2u",
+		.data = &tegra194_p2u_of_data,
+	},
+	{
+		.compatible = "nvidia,tegra234-p2u",
+		.data = &tegra234_p2u_of_data,
 	},
 	{}
 };
-- 
2.17.1

