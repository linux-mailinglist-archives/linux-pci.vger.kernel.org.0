Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA965EA76B
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 15:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbiIZNhG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 09:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235483AbiIZNgh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 09:36:37 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2062a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7ea9::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1310CEA206;
        Mon, 26 Sep 2022 04:57:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEhoKBfZzF0XdcD7zWDmfVLehcroY3vPqdJPyj7kKPN9CMswIKD94LhW2UJGyzAAc8mqmOrLomrzVoKSBhSyFMlahLThnlzAU7E4cwHC9SeMTIqMp0dBVaaRqhQnd4R3MvwtbdUSmjV8lL2a2KYTQtIKDXvG4JSQFZM3eNV2dT7fQIr5iSw6MQolIC4Mt6uY3YlKCQSVQkAD7/3pgIM5AEZIeVxbNFkkFBhmOC3/epwLNmjpU66OO4IMuLCmjSD80oRwepjY0OyyLiMBq4vRBUj+ZjEK/DxAvz7noVHsdn0pPacStVsovnAwNXZz/GEJNo5R7jvqW+dglrWOlQwjUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fvh9ki/u0vykNOoBH3Hl74sNJuHZi2qCwUtJP5ysjj0=;
 b=K6mwaek6kNm7KtYb9FgX3UQr906/y+ZnNN3aoYKzHEjjOrxqcpfSjkuCxyyQG55oT+eDeuzaYU+AhwYlkWHhk+3USLuAyyDQKr1MTCflccnH6bR6hIO1ZvvEFQXsD8Ip6nKBsN4UrqcIxNrMSqg2BxOAwZ6gDXicOi8D57M4J/6mwB0Dni3GRWH4GJfOQ5e9dyT4uvEXlkWYvKfj1krPWa5Rm8cAlBDzo+rQPH5FeGecHb1eXPnx3RJyeiHVOLAIrheW/Em8siiS76sqe9dtKGxwhWbAEEsm/tPBYhdB4cL4pfudFV7wQhQN/2twuTz0KayUVW4eUoXigAkL1WnmCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fvh9ki/u0vykNOoBH3Hl74sNJuHZi2qCwUtJP5ysjj0=;
 b=D7VQJEUAXj1kTnVuPvYMrTbqgQ2A1+l4hDoUr04Rqh24TYf0Uu6yJkHn3TrT6aqDPKeqLdCYFVeYtRYbx0Vd9cbQR09SwBHm3xiiZzFa8QHypVlWNoHPI7T8TM1PLMwW8ZDU9zCzIq9/LVTB9h8qEsmTyD+MqajkCeZEB9ZWaiENtoQDeKdkfjP15DR8tSiq3q86Ix9bNFrElj0HKTwyQgec216xXP1JddR9oV7BhT9mBe6cqPZ5CBk2yg8ieQ6DS/a6Kwpr8Cr+RFYrtXOMIYrNAD9dkDerRmL/m5m5WYdULS5OWHutyHe8WwGw9VwylB10fk2+DoRvlKcvcW3whg==
Received: from DM6PR06CA0032.namprd06.prod.outlook.com (2603:10b6:5:120::45)
 by SJ1PR12MB6051.namprd12.prod.outlook.com (2603:10b6:a03:48a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 11:51:15 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::9a) by DM6PR06CA0032.outlook.office365.com
 (2603:10b6:5:120::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Mon, 26 Sep 2022 11:51:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 11:51:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 26 Sep
 2022 04:51:06 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 26 Sep
 2022 04:51:05 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 26 Sep 2022 04:51:00 -0700
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
Subject: [PATCH V2 3/9] PCI: tegra194: Fix polling delay for L2 state
Date:   Mon, 26 Sep 2022 17:20:32 +0530
Message-ID: <20220926115038.24727-4-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220926115038.24727-1-vidyas@nvidia.com>
References: <20220926115038.24727-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT017:EE_|SJ1PR12MB6051:EE_
X-MS-Office365-Filtering-Correlation-Id: e5c4d0a9-b7fa-4fd6-fd06-08da9fb56a52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gIWvtGvubWUtM3Kb0Gny7FlFLUdsI3AVbdMAunSvR/2h9zJjFkzoDZToQa9+/QHotrfVRGT8ZUHHWKRa9yv4iW7zLjoe301Li/GKTbdFVzgAGw/0nK0XJMkFfmMbNu8f65SaOkB2/xH+jtuB+sq+MrdlnWN1Pq9hacwobxiVbYkmYVOsjV395YGzylgkfabmSEFWhFbZQo3bAa09pwhYH6WNQvSSmTjYOLJduUSBBS1X0yXOvOdQ+uTPGFpW3MZrGQy7cIUfj6+qSZa65dbp+ERHigBKAW4CdPUmiOleMTjS8+sK3MOuBWL7wVZiFrd0gBUKsWsDqJFs9vGCkDR1xSMLVv1rhA6Prz6V0p3Qomd6SWUaJoIBK67TSDOk7SD70gnSzmVjRPie7qzkZE8Ew3OTEZFKHHWt6SDisXX4YqAnrcPR8dPgcV0Mg4Wc19CjnMvoE+G0nnqG7RmUBIc54zXwPfJFh6DdClrqo1rcIi4r7dZSwbyeyrIUVhTWQK2Sg3Fb5NQ++iaD9VSpg8iA+vL57TCtzamcedrg1wRCsvzlzLMkEV9AD36URyiW559BrkYgLhHeLKl6/0hbV+XcfZ5GkPWdtuajZlhRLKBrMc7uy/sjTlcNfC1jh8eJMI01OW+D5JyqsemchuiUu5lp8kraT12FQQIuGSbWbTP2itx3kaafpmhaxcv3lnit7MSemnoXyywZ3l/C542KvzyOgpkpEhq5gcFHfqp2SyLbLqVMX+c1Q6efciCOgu20EQFc7QlNU1TD8rI4UlfUJ8IwPz7lX5/O7dQwjPAHRHqAedE=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199015)(36840700001)(40470700004)(46966006)(40480700001)(110136005)(54906003)(70586007)(86362001)(478600001)(316002)(70206006)(8676002)(4326008)(6666004)(82740400003)(36860700001)(40460700003)(41300700001)(83380400001)(26005)(7416002)(5660300002)(8936002)(7696005)(7636003)(2906002)(921005)(356005)(426003)(336012)(47076005)(82310400005)(1076003)(36756003)(186003)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 11:51:14.6660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c4d0a9-b7fa-4fd6-fd06-08da9fb56a52
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6051
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Current L2 state polling with 1us interval is too aggressive. Based on
the experiments with different endpoints, LTSSM state transisition to L2
is happening between 6us ~ 40us. Hence, update the polling delay for L2
state from 1us to 100us for a better utilization of CPU cycles.

Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* None

 drivers/pci/controller/dwc/pcie-tegra194.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 7721f920dd74..7d6e54a12eff 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -206,7 +206,8 @@
 #define CAP_SPCIE_CAP_OFF_USP_TX_PRESET0_MASK	GENMASK(11, 8)
 #define CAP_SPCIE_CAP_OFF_USP_TX_PRESET0_SHIFT	8
 
-#define PME_ACK_TIMEOUT 10000
+#define PME_ACK_DELAY		100   /* 100 us */
+#define PME_ACK_TIMEOUT		10000 /* 10 ms */
 
 #define LTSSM_TIMEOUT 50000	/* 50ms */
 
@@ -1556,7 +1557,7 @@ static int tegra_pcie_try_link_l2(struct tegra_pcie_dw *pcie)
 
 	return readl_poll_timeout_atomic(pcie->appl_base + APPL_DEBUG, val,
 				 val & APPL_DEBUG_PM_LINKST_IN_L2_LAT,
-				 1, PME_ACK_TIMEOUT);
+				 PME_ACK_DELAY, PME_ACK_TIMEOUT);
 }
 
 static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
-- 
2.17.1

