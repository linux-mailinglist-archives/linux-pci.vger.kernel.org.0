Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847FB5BCF26
	for <lists+linux-pci@lfdr.de>; Mon, 19 Sep 2022 16:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiISOjJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 10:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiISOiL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 10:38:11 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B5332ED8;
        Mon, 19 Sep 2022 07:37:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7DqxgRVfBMiJIArFHL31SF0q4sCDkcafnXHNOYx394D+SF8TFjsPuWJR1mliN0L6XGNXnEheraThXQ82tDZ7ZCC1NMaB1I7xg2OYpASYj5lwS0Q1vz76y8AVAbvSAX3itGIP2UjP/Iud4i3ui+49Wbxf8qwMb5qcUgZ7yMl44ub/dbLsK372YcU9praWjbiUiR4VERI9e95knVcKGf8JFbi/FnFGB/sVPbNdSQC/27aLJvgnzrWYkp2dgJiOawS/PVm9sr+a2jEnx/PVUbfBR/9qZhKrh/I56TxTLjQBwJdC0XgpqhpDLDXSrVuJXrN2JM7UQnxuFdLOcBk3q9nyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnAtwekcHHDRLavcRXog0C9Oubk7okQrTs+/jrqPwcA=;
 b=MkjfwDdzX8GN5hSXnyqyBEIJXB+TYDitGEJJoa637VkwooA/T54Jfhypxd/OtOG31oN0Lz8doRuiMtMSnPxGFUhPXcNem1ZfKgH0kv5RipcfifB6KLbRuGawEy2vajT76MHQfbGLQ3XsUSy9b1y44CfzhdGv+CSBXUpl1B+9NF6r9O1CipAegXm/aZs7d0w9DG7FNzRaxw8XYDEsR62CZn28+hnbgRVAyhGSmsm7EcBvrUlp5x+LG2JSMzM4sP6EzAXrDeYQPkQ+ChfbxRl8n5E/vyKJoczvKVbpENE7l7N/QFadE2f43A18BvruBXQJq56bt9st54HlWWwq+s50+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnAtwekcHHDRLavcRXog0C9Oubk7okQrTs+/jrqPwcA=;
 b=TPTYYjXF4bPfeS/8Pc8u4O5JtnKfe8xB1Bj2dRtGChZERHiekW+5DvFoyLDIxntaJbwW/7yCSACFbi9HFC27/gjunTu1HjRLPv6BmC4Ze1pXlgI4oeZrq6aWC7OVenElAWzy0YQ315H817AgZXtaw4CYb2/aqUIoi0GGeuFgawFaahY0xgLmvIt/DOp8GJZxh9Ns+Lhu+Oq/zC+jRo1CJst5hIYbfgyQ4HrYQGsoZE8b+ZK+Lx1XZuE94fCJ/rHkJL3tNyFbteT7jAfePZpT1LKL/H7Yf6x3HDaZEyjlkXRcLMPK55nUosHfseBD9FbConge7Wbvvvq6smtAwrUQWA==
Received: from BN9P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::23)
 by DS7PR12MB5912.namprd12.prod.outlook.com (2603:10b6:8:7d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 14:37:52 +0000
Received: from BL02EPF0000C405.namprd05.prod.outlook.com
 (2603:10b6:408:10b:cafe::ae) by BN9P223CA0018.outlook.office365.com
 (2603:10b6:408:10b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16 via Frontend
 Transport; Mon, 19 Sep 2022 14:37:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0000C405.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.11 via Frontend Transport; Mon, 19 Sep 2022 14:37:52 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 19 Sep
 2022 07:37:31 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 19 Sep
 2022 07:37:31 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 19 Sep 2022 07:37:26 -0700
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
Subject: [PATCH V1 8/9] phy: tegra: p2u: Set ENABLE_L2_EXIT_RATE_CHANGE in calibration
Date:   Mon, 19 Sep 2022 20:06:26 +0530
Message-ID: <20220919143627.13803-9-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220919143627.13803-1-vidyas@nvidia.com>
References: <20220919143627.13803-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C405:EE_|DS7PR12MB5912:EE_
X-MS-Office365-Filtering-Correlation-Id: 420b6c38-0515-45be-3523-08da9a4c8883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p1PIbaYo65j6rE1UQyDj/rn7kdWoPrMkVo1Nf+wR75F8TzXXlbgFaXlx4Zp8AI4hj6FZGJdFqcIgb1L5IMmCwj5FIFIw4L+8MUzd+/pV8ZdwB42IEDzGWhPi9ZEB26kOi9/5DP8VgSirL03SR8fTiAlgnNZWCHHYZWlkysCqT4NDOmWvyUEKJYFSoGCa0XOe+ZOBjCvVOaKbQlM/Om9rW2GePXD2wosIwNFSF/0X2VMbcQQVyqDEYzB8++KJMpycRbIBP6DT0Q7qMPXW+Y7GahfVzaWfvSv/fRlyvkjNlhXSN4CtzbyI9PE7Wr2wYUPqZoHdUF3gu9dzrVfQbldlso7E94LKGG/+jA5GBXNTJkXJ8H5V1fFHiFWykUqYc/LC71QmkCEMxRQbrrwkfMOW1a1bcDKU9uqGfZ1+cZ1jCVBy/euKJ4oxM8LHEOcocQVsP2tbDwQhwnt3H9JcPkMGoda+FhGL77/+drYfNkiKDwy+G92CWR2jgPpXkMMI44UsEEVndEnDUYwfn7NjdQLaJVoianJcEaWSy0eSgrC+cL+7T5IaRcM/JhjTwYejlEvANIfhp7Jrr7Dr8dJLoFWSQwr79EXJvvB3+2g6a2Ctu+dvsjeJAqNyHLFV8Q+ENo7hKKJzyI+wCVOLqpHv9cVGw5mAQuCajT0PBAlQyPbTsHNRtmvOyLbJ24qrHuiM82KJb1pnUS8QdqtKwyH4SiHUb1rIxrL1C0WBZSNBdGDmt02I8OfhOKTs9TAjfGXbYqJnsYyybzF8LWaORy5LPGWaSyuFYuyXBab9o0bAC2i+gac=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199015)(40470700004)(36840700001)(46966006)(36860700001)(921005)(40480700001)(7636003)(86362001)(40460700003)(4326008)(82740400003)(110136005)(356005)(41300700001)(70586007)(82310400005)(70206006)(54906003)(2906002)(316002)(8936002)(5660300002)(7416002)(1076003)(186003)(47076005)(8676002)(426003)(2616005)(83380400001)(478600001)(336012)(26005)(36756003)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 14:37:52.2338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 420b6c38-0515-45be-3523-08da9a4c8883
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C405.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5912
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
---
 drivers/phy/tegra/phy-tegra194-p2u.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/phy/tegra/phy-tegra194-p2u.c b/drivers/phy/tegra/phy-tegra194-p2u.c
index 1415ca71de38..fb710e89acac 100644
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
 
+int tegra_p2u_calibrate(struct phy *x)
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

