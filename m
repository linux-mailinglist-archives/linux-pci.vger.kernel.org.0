Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B74C5EA721
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 15:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbiIZN2A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 09:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbiIZN1f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 09:27:35 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E327C1D9829;
        Mon, 26 Sep 2022 04:52:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aISENHdsZjpT3wmCQApwiynAuSGzr6eNPYcw0CeQQbrP3ikBHIs6TKFU+i9uAnFzHtUMX4uiUYl9qaKEKrUJhfIbo2E4fbMVr49GQPG4EvEuWcaVbT9LHsagBmO2qzQlriBJm5N52kUkcNZApqOdsJH16cPsIp5I1VR3FL8/yrFGUoLnR/5Y0wtouBR7JA3CgaY5EzMtfbODTjj0ZcD7m1UoY2TTkWTTRCABPXFYLsG2rC32/rlOr6zSpeRs5ht9Vqktjp2F6kGUn2DhwyPoE7NIs8lw2uX5PCf2sZiZtd8gCHi7r+l/5eHaTQnvkYr2nsDkD9Lg+W5mKz6XDl1W3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7jyd9c8Z/mWeykzYgXiX6AmqcPg+Jyx6oeJz6RiZOg=;
 b=Vexp7tb63J9J/A5it8SAp/pD2biT3GE4ZsXbCXZJfFGIrLTH3fyRALVyac3Ep/KeZfFEMoLDY5IXgJxaLif5BoGuE61awqRwM2thA8wJSjfp3EOL+sdnWlPkYMgdjzsq7IIyXumTPfwGlKcrM1WV331z6fabpyWEaFUBpnIxKG6jufoz0YifZI6WMLM9yhmIbl/gnEpjdD24ZwRn6nSOZ3HmbrsOxvsuvf+kbp/JeeYQ9jWIf30wxBPI4udiVueBEEiAioR//J8M6s7nEfivom69xAMAPOjxSdyudYdIqWOfjbDZ9cBgig+p8LnsJrZnEnkdymA0xCv9zGh2R7Pkog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7jyd9c8Z/mWeykzYgXiX6AmqcPg+Jyx6oeJz6RiZOg=;
 b=IEWyGMONmwrH5hMxIuBG3B1pq3KIUMlHywJJEOMdHCMW9MZR0MRPjBqEoM5A/7Q9ku6w92MTEW5w0Gs9UAqRk0NiPwfjKai8e8507R5BQX5fMYsSN4XubisZvaChDmCTDTmpNAv/YIobmElJJC2CIPnG60CZzGr9TWnFCTPASPFlm8xZCZYF/Rsr7mWBhFSgIY5HaFP4ZfOwlKWMG0vFrnElq9nbmtA5d3Us9vapToGkY7gMZ9LUgjDUO9tL8QMVoIjIu/MwtLhYo65yiXTqqn2vqs+wgFNFtW35TXFQ6tOoE6FFZtG6bI9JkIYWJygBUq4O0WEo8/uUzM0DbWjm4A==
Received: from DM6PR17CA0013.namprd17.prod.outlook.com (2603:10b6:5:1b3::26)
 by CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Mon, 26 Sep
 2022 11:50:59 +0000
Received: from DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::76) by DM6PR17CA0013.outlook.office365.com
 (2603:10b6:5:1b3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26 via Frontend
 Transport; Mon, 26 Sep 2022 11:50:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT098.mail.protection.outlook.com (10.13.173.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 11:50:59 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 26 Sep
 2022 04:50:53 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 26 Sep
 2022 04:50:52 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 26 Sep 2022 04:50:47 -0700
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
Subject: [PATCH V2 1/9] PCI: tegra194: Use devm_gpiod_get_optional() to parse "nvidia,refclk-select"
Date:   Mon, 26 Sep 2022 17:20:30 +0530
Message-ID: <20220926115038.24727-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220926115038.24727-1-vidyas@nvidia.com>
References: <20220926115038.24727-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT098:EE_|CY5PR12MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: fa3c006e-0337-444b-77ac-08da9fb56104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wjunhXroR4DwHWWWhsPsnvCGPK+uxPJ8/pJT7Yke4+froriSqWGLOi73oBTbWk2BuR01aREgbTEH1LYa4aMyPHQqoHa/XrG6RLfthhCsEdOlRcb2W/XodbzafuaIeVfF1ct0JWfQeMNFA+qh8XeHyZt3a79OPeiwpk9u9Yg8TFTXHS1+5MgHVQUDZgSvyy0+EQrqaSABaA6doqENgt4e309xwWEJ13ZMkH3ExmB3tJYHBS7DcqsiD7w2L557URvxcTxx01i/YZRvkNvNdW/yKGpQntqc0nMtgGjS0OBn8L5YJQvfikAxJE/8QNo4536DqYHZ2tFtRgjGHdL6IpAuK6Pfz6d+ezhib2I3FeU9B1sQtoBd2dF9zIv3TnSNBUlZZ5P412xRyC9lTry9r8GRiCGf3qNCTXIOcReyvxBy9qXrwAxFIXpmz7LON5+NddUbKp+QKLIampK6kSYfs221K8iM4mY+uJCUN20Wu1YQBZIBu4oSN8JUQJRcwieQIaTaC+lLCViRJCkech3PuDS0keETMoBDLiiKz51w8WQAylD/10kaZGuL/kmI74ZSvpynhMwu445ou5SBA8sTL33/P28hB4iz3ccijH2EilQmGXOQorZMibqLYB2FHsXM4RQ0fUrDIXvTQgbLPwmWVzVx2G5veJMuoeStjgnhUnE4Dpbt5hsUniYF1fm1NxTHex/mNtajc4bAR2FgdZUcfFdsHQ4hFdcGO4ydBI+QiHN2z1EL0mnqKBC24jfPGcq8eufBln/SG64OiH9ObwhtzxN5AWdIvJhIAvZzqN5a7bZ14FQ=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199015)(46966006)(36840700001)(40470700004)(70586007)(7416002)(70206006)(4744005)(82740400003)(8936002)(5660300002)(40460700003)(36756003)(7636003)(86362001)(2906002)(921005)(356005)(26005)(1076003)(2616005)(7696005)(186003)(6666004)(336012)(83380400001)(41300700001)(478600001)(40480700001)(426003)(82310400005)(8676002)(4326008)(316002)(36860700001)(110136005)(54906003)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 11:50:59.0520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3c006e-0337-444b-77ac-08da9fb56104
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6179
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The GPIO DT property "nvidia,refclk-select" to select the PCIe reference
clock is optional. Use devm_gpiod_get_optional() to get it.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* None

 drivers/pci/controller/dwc/pcie-tegra194.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 2600304522eb..941fdb23e02f 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1176,9 +1176,9 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
 		return err;
 	}
 
-	pcie->pex_refclk_sel_gpiod = devm_gpiod_get(pcie->dev,
-						    "nvidia,refclk-select",
-						    GPIOD_OUT_HIGH);
+	pcie->pex_refclk_sel_gpiod = devm_gpiod_get_optional(pcie->dev,
+							     "nvidia,refclk-select",
+							     GPIOD_OUT_HIGH);
 	if (IS_ERR(pcie->pex_refclk_sel_gpiod)) {
 		int err = PTR_ERR(pcie->pex_refclk_sel_gpiod);
 		const char *level = KERN_ERR;
-- 
2.17.1

