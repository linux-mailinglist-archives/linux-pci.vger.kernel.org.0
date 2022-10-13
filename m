Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1036D5FE1A1
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 20:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbiJMSm7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 14:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiJMSmZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 14:42:25 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on20602.outbound.protection.outlook.com [IPv6:2a01:111:f400:7ea9::602])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BB8182C40;
        Thu, 13 Oct 2022 11:40:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvIMfJWWwGYAJm5w/6Byg9NSz5Qyjv3U+K/N9e1pU8Asx/la2mSqufYstheKVjVb/nRtv5Jk+LyOTE+725cPah+B4JGNXQRXWBRDDQ+grJJA9lCUkgMNXqYbBg4qb44e6LWMT9sHSB2DGNpOyTbkpSJsI2yhVD+6q206aXBm7lJ51M8KKV88jCLi8DDo4CwgIskUXCLfOo0XzXQkq75nZST8TqS6aeC4W44oR5RAcctftmcLLngrL574BRRLo4+M2AKQNjl07/QigUX9CZVsPI8yXm4jqnPT0EG9sycA2zwil/w92UlyjLzbH4TY+QnYnDyLVzmNRk0PI6Z6gwjmsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1h7DH9QivaaRrlV63quENGYaC9GelpiOJdLiPP0ha7o=;
 b=MtkZMRm/b04hlNUP0plsqH3Ic7F9ArvpNxg6UWS++LJsfYA5S8Rf4E6UOsAqaaP9Fq9KaYJ/7MWthDcpZkFp/wC5tyWmtepyMQp/hYb/GRsBSJUWoM8ydFPzbwRWFTD1rkPUopvV9mo4h5qI3nYyn23i0QIIlI8J5rKHvSdLfGlGAOJm8nOaCL5B06cwYUqDVysWE1kNl6mQZ/RHa9rx83uAso9GihsNX2hVTFENv4MXanPAXcQHoBVV1YbgWzRPSWo5RMZEbpk2tZZjfL9ape12Pq/vsudjVU6kbLoPOSAmz2wzUOZphCZHtegk2ZonODeYFPc8OSfkowq1V/F8Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1h7DH9QivaaRrlV63quENGYaC9GelpiOJdLiPP0ha7o=;
 b=AOk5CwuhvOvDnj4DcnFSH+23KrKueBpzHoJSimn2Fypi5keyPeiaNE/suTAlTxMi0clWIsL629yKPgOdDkRDfLa1CyZ8OrN3HhlOx/gaTxP5eT/Wv7XlGM0rk4IUDEUhqfaPC8Z85yLfx4DzTfS1DprdOT++BEBj7z/7u0FRPIlBpYTffpcXVofXLHNRCJ4A7AIZ+weu5zRPUB1rwFer+D14kaHoOc3INO73nET7DmVPMymJguogz1qNVSr5oaFoLZCFeaCvnO465Id29hYupEqko8zT41eloe/P/H5CYLDAbz+lxLyj16xHjDj5mnQkZJbm3dawVJkY/8P8TcesNQ==
Received: from BN9PR03CA0340.namprd03.prod.outlook.com (2603:10b6:408:f6::15)
 by MW4PR12MB7334.namprd12.prod.outlook.com (2603:10b6:303:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 13 Oct
 2022 18:40:07 +0000
Received: from BN8NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::b4) by BN9PR03CA0340.outlook.office365.com
 (2603:10b6:408:f6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26 via Frontend
 Transport; Thu, 13 Oct 2022 18:40:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT076.mail.protection.outlook.com (10.13.176.174) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 18:40:06 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 13 Oct
 2022 11:39:56 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 13 Oct 2022 11:39:56 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 13 Oct 2022 11:39:51 -0700
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
Subject: [PATCH V3 08/21] phy: tegra: p2u: Set ENABLE_L2_EXIT_RATE_CHANGE in calibration
Date:   Fri, 14 Oct 2022 00:08:41 +0530
Message-ID: <20221013183854.21087-9-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221013183854.21087-1-vidyas@nvidia.com>
References: <20221013183854.21087-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT076:EE_|MW4PR12MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: df9accda-60ec-4ee7-375d-08daad4a59d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gc0KjmIvxlROgoN238165KtSuw4LlDvCjJTp6QDGXw55GQLQXEPME2gFgggGp0P9ldJ0qziQOuxGmLmtrE7VX2ZObGKOUtveMaayywg7OGwZeBMqCa5SIrZzintVdsWz7WkMiIL1zIRNQDmdx+ZvtE42G2pUfSl3PYdddm/aJObAEOm0L7zZ37VTITviozxPvVLYvbpGBHiQG5gqc2hNWKBc4ouG0dgymM5GfRfu0hEhw2n2hrDHY5MP/Xeq+5g7k8Uprw0GW+wVLxWGYoJIuPz0LBgJy4cbLSmrKPZX1xVeH54pguoFiESrDHSUdYD1pX6K9rY9OE/GU51RambpbBrXIbtVt1rMFycneM44GMN11InvNJQ7nKQ3PFrb0zt+6FQJcMGpJbT4Ep3yYIUIep/M2k9UhST4XK9oreFIRRIk4OHyPUubAJt+Tq42Xm/Gar1Z2PQx16ncarh7ODjUhulFP8xZzKT3mxGiY8UIsiOJZYdZ4BaGYqIiYsYrrm/V5AcM6huRtxynHWZR648NDgifHKqCr96bLVCoUhomK4GlezH9hcm/REUApqNm1AGmtdSyx8k75vdYemaJaeMEd9WE0tuQfYcLteb6pNdCu5Z5RkPsZl4kXN3Y+Szp4FLWcntEpAg2wtkOGfTQehsimEIDuYJFDAGPKAiGk451EWbX59nP5UrQtX5uheZXXX+onYMvGSJixj6leYQXDTOlG3V7xdG+2lIbkoWteQWJLY3n/debTHZSK7jV77COzNV2ZhH3dMriA4hjAUwhTdqW7afEBTGZem8+2je8BxYx6o4=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199015)(40470700004)(46966006)(36840700001)(336012)(7416002)(5660300002)(7696005)(1076003)(186003)(2616005)(7636003)(2906002)(356005)(41300700001)(26005)(8936002)(82740400003)(82310400005)(921005)(86362001)(40480700001)(426003)(36756003)(83380400001)(36860700001)(47076005)(40460700003)(478600001)(316002)(110136005)(54906003)(70206006)(8676002)(70586007)(4326008)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 18:40:06.9033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df9accda-60ec-4ee7-375d-08daad4a59d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7334
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Set ENABLE_L2_EXIT_RATE_CHANGE register bit to request UPHY PLL rate change
to Gen1 during initialization. This helps in the below surprise link down
cases,
  - Surprise link down happens at Gen3/Gen4 link speed.
  - Surprise link down happens and external REFCLK is cut off, which causes
UPHY PLL rate to deviate to an invalid rate.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* Removed "Reported-by: kernel test robot <lkp@intel.com>" based on Bjorn's review comment
* Reworded the commit message

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

