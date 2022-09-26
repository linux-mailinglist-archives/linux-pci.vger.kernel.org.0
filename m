Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6D95EA730
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 15:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiIZN27 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 09:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbiIZN2V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 09:28:21 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2086.outbound.protection.outlook.com [40.107.101.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CDC1DADF1;
        Mon, 26 Sep 2022 04:52:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7ddc307nQf7nFFZecvdwgPx0HPo1/YFCkm3hs7iTu8pDPjVCWtQ12J9K64JgU5zAMcpBm6g/fH7u63Nm0x7hyodCmBeSnuMmCAFVDQR6X8mP9x9fITAFM/pt0UFlygLIZS1nViVDHqntI+JlTpN4GX3r92hErM6nvpPQbRXb4Ke5UCf6L6g5DcIDi4xmafAmAx7dOcs5hPIXgBeUN47Z6JtlwfcXImmrjFBymoow+wlgr0ZjKBYhyBQzspZA9gV5wOVmec4f8Q0IOBdDMn3iN3sVOodOk3hSBgvoiMnQDyUef/DvNlvapPRWKD8jwuTMZdsoGggK0M6SQQ+1o1lsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sY7f0tMIym9e+2K4kWMqdDUQn3UPs6bkTKSUBRttXFI=;
 b=Q9EwJitQUK3u6L5HWm6YLhpRWOc3Qdh/Gky388UWiBpRKFZJw52VM0vW8h+Z1PCZGI+VajNhoDFULo3fdIheW7uVms8ERya+MOaD52KxJWESv/9QvamaEhpxmJHCEUx1tyL6vQ87kXg0ruS5fw3etV+wlfxJbKNvKCViwVEHQKWIoCGiVLboH3+zuQB3bI0muzcHMyzj1ko+32IqUe6wsalKyGFaChcm5coRbJibGtk08EsFS82E+YlRhKDG5zwXuO+gl8Wa2XhpMIfEO4xTGVGUBnVfmJgxODVXBqjmlR1iaUKlyI94I+QqIwzSI5gjlCCLTJ1mAxSV2b5jPpBvfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sY7f0tMIym9e+2K4kWMqdDUQn3UPs6bkTKSUBRttXFI=;
 b=Og+UC3cnAR/rdLH49OSIoMigEiO/CEQEKzlaCAjtOsyDarVUUO98GuJif8ekz0hRth/TFVEBnrdfj2UZX520W6pmMRqTolxph/VuXlgRihuN78nhjLS+DSowcOr9PPisCrg/CIwEljOFSM6Ue3y0s+ErihBCnYFw11Mno8Tbl0sgjjK+tqBKkN547flcHOHk7eTmLnqx8ZU89VmosU1F+nQS5DZkirCIXVX+W9qNIx92MLOngHj+0kkUdZoq9X9l5BhCSG2UIazZc5VDb6YAOktgTY0EpL0ueMGgdsGnALLOK0TuONBgKgLCLICHws8ma7zx1gj1YyHlop25pgxBjg==
Received: from DS7PR06CA0020.namprd06.prod.outlook.com (2603:10b6:8:2a::21) by
 DM6PR12MB4482.namprd12.prod.outlook.com (2603:10b6:5:2a8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.24; Mon, 26 Sep 2022 11:51:51 +0000
Received: from DM6NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::f) by DS7PR06CA0020.outlook.office365.com
 (2603:10b6:8:2a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Mon, 26 Sep 2022 11:51:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT106.mail.protection.outlook.com (10.13.172.229) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 11:51:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 26 Sep
 2022 04:51:39 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 26 Sep
 2022 04:51:38 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 26 Sep 2022 04:51:33 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <vkoul@kernel.org>,
        <mani@kernel.org>, <Sergey.Semin@baikalelectronics.ru>,
        <ffclaire1224@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V2 8/9] phy: tegra: p2u: Set ENABLE_L2_EXIT_RATE_CHANGE in calibration
Date:   Mon, 26 Sep 2022 17:20:37 +0530
Message-ID: <20220926115038.24727-9-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220926115038.24727-1-vidyas@nvidia.com>
References: <20220926115038.24727-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT106:EE_|DM6PR12MB4482:EE_
X-MS-Office365-Filtering-Correlation-Id: c15cff72-7583-47ab-74d0-08da9fb58002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LvakI2x1ifXTEpfdgoXw3+Cy9Qr0lCXCJ/jstjlRV2Fx9PZM+G98R7fdPykbi+vaBvZYHzXRAaCEjMc22ccYGpF1rYVQwP8mHwfdveTtVAVifrivjdJEMvigGaWI4uUIbyh0DdE2gmCUrc6ixkDxhhnOVJztpckb11JMqqZdDf2mBFOCWzEmmG0dvCcoiAHiS+n88fMQugtPztwcBVXq8Gh18eocFczsiSZRxNruXqhdDRnPzFlqxQAtjpv6hcd7tr0fD4le7hZjjRJb81x5w04xiJiukIY++Hc+xaDZR9WacO71fwcpI/CiyNNAUKYKdf7mOqOr+58nrqMqYH5dAs1RjyaGXnSHQtXLU97kL4xG0pFPqsJs1BrrarGBr6xpdP1nn8KyXQW0w1lKAuByVQ2oEDRF5nj6YY69gCX2JLUGICaUkM//OASRZig/jpj4H8j3N63I+S66vfNJ9k4Y8GCn6FtHynp7WZ8YC5KR1pD/LhlskJmwOj/HU+1NHCDMWSEasOg9yPxzReIrE/pwhVIJpAoOhZtRKRcLDx0pPqwQJiDARdRKXqkcd0rGSLie7twDKD5IhDIpaOO4+Unzn1zQWFr558oKj3MX+ZKDUY1nnp+Xj2W8qv8tdqQ3XrQZJY6liF90EJGIOJabZhMGUIqKQdNOLgnlzysZCL3x/ycX6ZngVlDOhg52oSLA7lOzJwq4olMo3PAwQZowo/QDHLepf4t12ljInxpH6HRK4kNHRLXfLm3yDS+OSZkoqpIfxvZfmrgva7qumhR6b8fzjyOlobMkVgCghJuIGeKTn6g=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(47076005)(316002)(356005)(426003)(921005)(7636003)(4326008)(110136005)(40480700001)(83380400001)(54906003)(82310400005)(86362001)(70206006)(70586007)(2906002)(82740400003)(478600001)(7696005)(40460700003)(8676002)(41300700001)(8936002)(1076003)(186003)(2616005)(36860700001)(36756003)(336012)(7416002)(26005)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 11:51:51.0325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c15cff72-7583-47ab-74d0-08da9fb58002
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4482
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Set ENABLE_L2_EXIT_RATE_CHANGE to request UPHY PLL rate change to Gen1
during initialization. This helps in the below surprise down cases,
  - Surprise down happens at Gen3/Gen4 link speed
  - Surprise down happens and external REFCLK is cut off which causes
UPHY PLL rate to deviate to an invalid rate

ENABLE_L2_EXIT_RATE_CHANGE needs to be set to bring the UPHY PLL rate
back to Gen1 during controller initialization for the link up.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Reported-by: kernel test robot <lkp@intel.com>
---
V2:
* Addressed review comment from test bot and Vinod

 drivers/phy/tegra/phy-tegra194-p2u.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/phy/tegra/phy-tegra194-p2u.c b/drivers/phy/tegra/phy-tegra194-p2u.c
index 1415ca71de38..633e6b747275 100644
--- a/drivers/phy/tegra/phy-tegra194-p2u.c
+++ b/drivers/phy/tegra/phy-tegra194-p2u.c
@@ -15,6 +15,7 @@
 #include <linux/phy/phy.h>
 
 #define P2U_CONTROL_CMN			0x74
+#define P2U_CONTROL_CMN_ENABLE_L2_EXIT_RATE_CHANGE		BIT(13)
 #define P2U_CONTROL_CMN_SKP_SIZE_PROTECTION_EN			BIT(20)
 
 #define P2U_PERIODIC_EQ_CTRL_GEN3	0xc0
@@ -85,8 +86,21 @@ static int tegra_p2u_power_on(struct phy *x)
 	return 0;
 }
 
+static int tegra_p2u_calibrate(struct phy *x)
+{
+	struct tegra_p2u *phy = phy_get_drvdata(x);
+	u32 val;
+
+	val = p2u_readl(phy, P2U_CONTROL_CMN);
+	val |= P2U_CONTROL_CMN_ENABLE_L2_EXIT_RATE_CHANGE;
+	p2u_writel(phy, val, P2U_CONTROL_CMN);
+
+	return 0;
+}
+
 static const struct phy_ops ops = {
 	.power_on = tegra_p2u_power_on,
+	.calibrate = tegra_p2u_calibrate,
 	.owner = THIS_MODULE,
 };
 
-- 
2.17.1

