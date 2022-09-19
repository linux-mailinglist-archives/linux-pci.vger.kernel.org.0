Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A305BCF08
	for <lists+linux-pci@lfdr.de>; Mon, 19 Sep 2022 16:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiISOhU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 10:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiISOhM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 10:37:12 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C5F32DA3;
        Mon, 19 Sep 2022 07:37:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdMv4Jwstg+nMl6pjLSUzBBENsntjDRW0IO8+ORNRjj1ddO7IPylmbgIx54QXPuMzqK+aV49jXFEgSSln0LTdZdHYGxsuTUwcypCtf0OigYmOdzAs7KsVRqNqeBZ6lGRymQUTgAYLndlRd4lgQHJi28qyAiVF/I+of72+KlvwS2y+cL8JEFGYoX4c7BkcIvZEEv30xUoauf+28kwE1dpPaRkeb9vnhmmJwlJBrW4j25TKopA5W8zWqCHzzHzaeOv7biWXEr8GlJURnQzuBJA84wVBI1+OXVlftHfE3O/6CsLvWpAjXsmpn/8By1Slk8X8lzqNjFRfflYBu8UVq9CEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNHGAqvjxnOQxva/eEq4B4ZohdjvB1IQWMLluNQpL1M=;
 b=isZyimlMecFRXJl4Fs/NQckliSZJiNKE721302c9IC+eLHjKAFsj076IjzbhtPHx01ZEP7QCT73e4U9t2rmnTsXh+YpuMBkrczvwysw3OhWJCEaSZd8vpnXwFQnFrliXrd4eHj4E9akrY2ayrI7iuz2412J2c9YvZ2nAwJ2oISXbQzrOiH6oOGWZB/QYrzzGkHOrCnFHrgWZ3Z+5ZhAR63r7UZ1ZFavcp6pfMgZbVAiPcDQv1WCpjmrQRlD89HUN+rL++Rszg9DDYeejJ468Hl6sRZeKttB/aeftBVsZGrP5UM7m0I76BM25hH/btRoHNtn1GmZX6O5H7g+zEjbv9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNHGAqvjxnOQxva/eEq4B4ZohdjvB1IQWMLluNQpL1M=;
 b=TSn2CxBKNF30UeA6VEQzF/LF7GDgT6TggXF0Jz2x+6bK1vO66nl7BfHPBtcZD3duy3REAY9MC7ec+/EOBybkQ7iEmV7eF791RPN8Ydf5LESindhzN95MDvZCgO03LT5futGuxGReFqiQcgrKf7Lke9AQ2oo2NR3/1d6jOT6MiQMqL98QUBEpXv5rF5lY6vTBM0ircoyfOTRLSdOoLBeMqsCAffcEz4PUnsB3DZYrL8PmaI2jxfVAIFb/75jG9Ow4v0FIvf6fWcXIQYtug+RjactZITM2/INp5Y08vTqf/GiNWz6KVxbZXRFvnRt/zHkhkd9VQz2gZh8iISModVdMUA==
Received: from CY5PR15CA0206.namprd15.prod.outlook.com (2603:10b6:930:82::20)
 by MN2PR12MB4096.namprd12.prod.outlook.com (2603:10b6:208:1dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 14:37:06 +0000
Received: from CY4PEPF0000B8EA.namprd05.prod.outlook.com
 (2603:10b6:930:82:cafe::9b) by CY5PR15CA0206.outlook.office365.com
 (2603:10b6:930:82::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Mon, 19 Sep 2022 14:37:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000B8EA.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.11 via Frontend Transport; Mon, 19 Sep 2022 14:37:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 19 Sep
 2022 07:36:45 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 19 Sep
 2022 07:36:45 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 19 Sep 2022 07:36:40 -0700
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
Subject: [PATCH V1 1/9] PCI: tegra194: Use devm_gpiod_get_optional() to parse "nvidia,refclk-select"
Date:   Mon, 19 Sep 2022 20:06:19 +0530
Message-ID: <20220919143627.13803-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220919143627.13803-1-vidyas@nvidia.com>
References: <20220919143627.13803-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EA:EE_|MN2PR12MB4096:EE_
X-MS-Office365-Filtering-Correlation-Id: e23c993f-8197-4953-2aae-08da9a4c6cff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cK9ot8+utZk+62PJ2KlrMdpDdt6C83Wg5c9h02QkX+SPU2cxO37En2glcxvZSIkxRVn6vxudlWRY2KFiW0jPR6qDQJZ7EIB3oYG+UrjwIjciffw63wjL1uL5U5CqdwfiASfaR1+56Ji/jI1KJOojU2LvjHMWj2U1wg68uXe4QX0oasq5pU/hDNJsTJZz9W0a91Vkc2IHJW2DycExtFSkykSjHCTJLrsj9yfy/vkuw8boq68y4tShoFx8gHKhtERuvhDLGz+kbEY0uB9Elr9iMeZY2YZD7SARp6VUJXlU6niJSLgEhDTv52mua/vfMcL4H5crvoXrxEzlvyqw0qE6T7VXSuPwF96GKeBtfxx+sbMMEjy+q8D4u1qL2otAEOPHuH3B41YU+v5LX0d6/u4Phvi4RPe7RYUNKFI+FeESeLYGAFQN7dKAJxFOjevb6lX0OBsi2ndFsA5gXxabl7+TaLRM9amjWzBf0jSzt0hygaJL54tU2EoXIN0wjNFwvWNdN2hYmhKTzVbFN5nkGOwV1HB/KleFpPCD3TqaSs5+zRz2IA43UDrW99WOlDGz8ezIhQTf4DsGEwxRAR61KBw5+T4658v2bgVHKLt5dfv8U7RBv7Ks/GX0mMgZ3VIH3A7tT8lkaHURrmoM+kDW6DIW48NUazVi0vwIh4JIoAodHTa5YpFFQhEyVervzBjksNPERt8lRHh/dDU1XBOA/EH60Y/Ycfjoecg9c2tJmfmUn8Z2kHtKV5mycizzR6MDk51xfGzpMEc1g53Tf8Jgu9g2WOMn1wM9zHawcfZN2VniEsU=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199015)(40470700004)(36840700001)(46966006)(7696005)(36756003)(6666004)(26005)(40460700003)(82740400003)(8676002)(4326008)(70206006)(82310400005)(110136005)(54906003)(70586007)(41300700001)(36860700001)(40480700001)(921005)(86362001)(7636003)(2616005)(83380400001)(47076005)(186003)(1076003)(336012)(426003)(478600001)(2906002)(316002)(356005)(5660300002)(4744005)(7416002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 14:37:06.1950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e23c993f-8197-4953-2aae-08da9a4c6cff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4096
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The GPIO DT property "nvidia,refclk-select" to select the PCIe reference
clock is optional. Use devm_gpiod_get_optional() to get it.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 1b6b437823d2..2631685e3315 100644
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

