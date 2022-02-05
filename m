Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F124AAA16
	for <lists+linux-pci@lfdr.de>; Sat,  5 Feb 2022 17:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380413AbiBEQX0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Feb 2022 11:23:26 -0500
Received: from mail-mw2nam10on2067.outbound.protection.outlook.com ([40.107.94.67]:16064
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1380414AbiBEQXZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 5 Feb 2022 11:23:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6TwLzi/P5FJt05PhIXbAOhZK9i71XkydUz77k19XN0c3Ol0BDJxQfGtw37VeixOD8vxpAv97Ok4E3Nk5m4p8yWVKpvsDAyUYUBBnrRahqIBc1zAu8/xRtouBN2GTi2EXDAsUKc8QZ5CKXoZ6peCUVTg4fIUINl4OyersitT6swQQ7bowh+lQ5sO60bNFUS1FNGAqOHF9G6CTXNjBi1q/RX65Y55WqoYcYgvOAX0Il7Zrq1B/LJl0ngv//AgI/h+lldgiuplBazuRwHPVl/nn/T6YUqAY6mluNHyBTqftUzgy44oaf5YzroN+252o2TF9HIWTowKdTgSD1kIQMi9+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1FukLZ/tpGXBJblSG4HoYhGZIKr8V0kdxY/sG8Qz2k=;
 b=a0+lVkdfuVuQDBhr1odZkPGy9jc02lhnrk0fMMbwGMVrcI97BhVma2nQPmjdpKxEIQUHUQo4IxFGyBV/nX0nVZaI4xRiKCMPQMhHzhmW6jXex/rvktrL3ceY1wTlsQgsXC2h2EyAMqVJGbTTYBOzqZ5tqbij1Xo1l2ChgG0lFYfGJ6uWLnZIk0JVl6VmtXQsDeGYkQ4R1mpaStV6sY21OciGlmJOC6ebJyuP1Bgr+68LXDv6l8eq3FcqG3KEwB7cE/TOH87EQzjc+41/lTqwcmdLZNAqpw7cAupQUfvKvv/HUOj44bQZSmcATWs0W8QpFO4E5kC7tfaGMMC2jJ4p9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=ti.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1FukLZ/tpGXBJblSG4HoYhGZIKr8V0kdxY/sG8Qz2k=;
 b=k1GKENK2C0eneihPRzhe8+nkGe16uyCA/wD54GxlDJsxDcfeg7m/PdH9wNyzZYWOhn8QUQO8BMYaGNUMdo0DzERKj/cGTBcX56cpCvzxDWbaGnaLbMTlAohaeT1VKZkjeu4fH1xZQAI1EJG4miqRXvkP6P7ut1PrcLE+7EemX/8c7znv5LNTBje59Phrwds7JTn24W4RoFiDTUnCD/LCN02SaZNuCTQ0tuNVgA00T1BIb7DI/4NFWADaq4tzLwnmLaS+DlerGgFqwVfUb+VRvwRj2vrT5Aqwj36AImceW9SW/A3YgSZ1YIbI3jjSHx0nMTzyaWZ9xIHSPJgz3lXO/A==
Received: from MW4PR04CA0087.namprd04.prod.outlook.com (2603:10b6:303:6b::32)
 by CH2PR12MB5532.namprd12.prod.outlook.com (2603:10b6:610:6d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sat, 5 Feb
 2022 16:23:23 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::1d) by MW4PR04CA0087.outlook.office365.com
 (2603:10b6:303:6b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14 via Frontend
 Transport; Sat, 5 Feb 2022 16:23:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Sat, 5 Feb 2022 16:23:22 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sat, 5 Feb
 2022 16:23:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Sat, 5 Feb 2022
 08:23:21 -0800
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Sat, 5 Feb 2022 08:23:16 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <kishon@ti.com>, <vkoul@kernel.org>, <kw@linux.com>,
        <krzysztof.kozlowski@canonical.com>, <p.zabel@pengutronix.de>,
        <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V1 08/10] phy: tegra: Add PCIe PIPE2UPHY support for Tegra234
Date:   Sat, 5 Feb 2022 21:51:42 +0530
Message-ID: <20220205162144.30240-9-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220205162144.30240-1-vidyas@nvidia.com>
References: <20220205162144.30240-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44e9b98b-ad0a-4aa0-a3c9-08d9e8c3d43f
X-MS-TrafficTypeDiagnostic: CH2PR12MB5532:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB55322A7477604605939D2F70B82A9@CH2PR12MB5532.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wn0lw8Q0iU2vN/0KWIigl64H9nPv+SExgHO5xNltt+X+h5gT9z0rH5xNu9D/I73gi2f4JZs544rGmBbma74fMfAuT3ZPQxP87MNDWWlQJargv3L1O4W47FUh2yd3mhdqHi0aBREWo4iXO23Ouc5NkcErUeJeclHN5iHEm4COKQ3IYpxVzroh7NIqmQn3/n0JuB8IP/Je1Rdqh/ZSll//FVE7ABPvfJXBEI4yZJU07XtG55dN5iqVrCzzwQ0o4gazKKORP0Bxs604n0txixDDrchJjKS6TmjBahCr2e3FFoSYDZip90ne5s30HQVEsfu7ljvCcVTZunA/to5NE+P9ERrG5BQZFaum1IwxBlssH2WAcsPyC/BjCZ7qtJ2FGz8nPKSpCFtCb9W7aREBp90mDJpKaZh90ATRVDkVgpqMh4WhjfZeaP0JrDvnWgYVvwelveZE1iyBDA78/B640RH9LfXSEMqIolB4aFL9Kg1KT9zjMbaA0ax7fRMHar/YFlSc5EW1VUp0oqxPFmFlOxvUHInI7Tb23U4+qqbzrOFpSYB6l+rgmQQlYjAz/L4E5NNCcamBY4R3+CDl/0X6T1ZzCwIFMKXqBnoWtPq0B7kQPgFs4MnDBDe/i5T6Dd5rsA/QGPnsoAVZHNBPgaWtsRT8KXZBm5PyBT2Ib9cawMUObdcuqDVRIFauz5YrzCX/aQToIbvMCNFGHeLVmbn2Uh6Kbw==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(6666004)(36860700001)(508600001)(70206006)(70586007)(7416002)(8936002)(8676002)(4326008)(2616005)(47076005)(36756003)(2906002)(81166007)(186003)(356005)(26005)(1076003)(82310400004)(54906003)(110136005)(316002)(86362001)(426003)(336012)(83380400001)(40460700003)(6636002)(7696005)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 16:23:22.5749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e9b98b-ad0a-4aa0-a3c9-08d9e8c3d43f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5532
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

