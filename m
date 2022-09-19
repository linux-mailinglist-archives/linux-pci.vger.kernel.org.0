Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2155BCF29
	for <lists+linux-pci@lfdr.de>; Mon, 19 Sep 2022 16:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiISOjK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 10:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiISOiO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 10:38:14 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B1133340;
        Mon, 19 Sep 2022 07:37:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QayhDmnA9ApvqeJeCIGw/gL1vnxEepmr3Z67GMJ1Tk4XfVqD6WLTFakh/CeUNqKtDb+dI/fcgUNMJ0fRC9wsoRZ2b+Dy1I53wGhut8jpguzgLAPZCVc9viFP/r79MgKmnkwJNDdHUHyg3R0WEj1qHjNMB0ilHa+Tq3EwL/8vzN8phfrjpDJMv2hlxr3dbhDYNUzGntxIdUVvHtu9kub9cZov/1Q8VhETcw3MozOPnydsiZQVTmdCYSdoEV9wswdEG+xXS6/mi0rJc1+aH0MqrxjgjcuNQpdEuMEcfer8YaC4WFNTcSK7DFqVYSqR8843hLF5p0gclqlbfu920Zc/MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNEuoAkK/d/mqFwLlNd/9+V0aRMbVSREyD6fli6ZEUo=;
 b=nDnnm9Y/lOwkzeLCK49gd6fCz46QMyei7Uh4gq4OUsF9ZPKt7WdWmobzhFgRgeCr+grq6KRgx9nxitAqrktNQyKzhlENCWlFqqxZJq8I+MQB2mn/MWDEDogNuJjrpEC8CYHxW3Hct7OG14g0rjBurUksbIrIvth+fjF/tKzeCA2fjQp4hidrPdCmIybwjtA+Az3mbeKqyDoLhqoLFYBwkNPgmtl2SF6OYc73kX3t04OdHcLGQh9TneViphfhgjFxvpdeBUp0sFPlICK/pKIqyhyrLoEmKC6gGPlUSy92NnXhTxKvkuAvbrYVRQOhFVx+2IeQ9BSvxMWytO1YsHdC3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNEuoAkK/d/mqFwLlNd/9+V0aRMbVSREyD6fli6ZEUo=;
 b=klUZah37TsTmtoiPrjNFdhI1Q0C2GVJEhPvVQIQbnugWd2Yh7p7rDUlGO+G5kXY+tB2paDP1ITlzAEhCFxzjbDs4CWNKVfqhR5JFCugegvGvF3iGBCaByXKi0Tvb7ufztBcBlMh/iLrQzctNaiImXIEJ9FOckNeyJCoDTgLMtIdDzCKBrPlyywtxoh2a/AHjv3K+ilvgwydpMNm10jIR2A4u9z85aInnLW88C1HtAvtR0lk8b0zb0Rhife7T70LvlaiOpB5AvN56SQf+LrevFhNeXvP8nn2Ia7cN6FEPwK6tVlWZ8Yo+to8caweCFqvJJxYcuaFgxaA78xQI/G0xtw==
Received: from BN9P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::31)
 by DM6PR12MB4467.namprd12.prod.outlook.com (2603:10b6:5:2a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 14:37:57 +0000
Received: from BL02EPF0000C405.namprd05.prod.outlook.com
 (2603:10b6:408:10b:cafe::57) by BN9P223CA0026.outlook.office365.com
 (2603:10b6:408:10b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Mon, 19 Sep 2022 14:37:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0000C405.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.11 via Frontend Transport; Mon, 19 Sep 2022 14:37:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 19 Sep
 2022 07:37:38 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 19 Sep
 2022 07:37:37 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 19 Sep 2022 07:37:33 -0700
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
Subject: [PATCH V1 9/9] PCI: tegra194: Calibrate P2U for endpoint mode
Date:   Mon, 19 Sep 2022 20:06:27 +0530
Message-ID: <20220919143627.13803-10-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220919143627.13803-1-vidyas@nvidia.com>
References: <20220919143627.13803-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C405:EE_|DM6PR12MB4467:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dfc0250-5797-406b-def6-08da9a4c8b12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /UmuSG5VZmFKeTkCSVqiutj4X04xCHFXmqIlLteLWvAUhrcbCiw0OUrnB5+vCEzFCJozeBZqvemop9Lz6Rz+iGb6cD4OZ0As3X8v85aihsRjdQmWvVhyYpmvyAEPHwK73Ru7SM9lRxmai/+yOsu0SuIufNb9Vh6HkrpVgUfwE398awAEW4tILr5BdtKCv9zTZ9TTomlKQL9bYeosY5kySGmetz6HUzRhzHfizlr2DSBHl9XiQasAaCb2hO2jeFwyb2NHHklaCDpmeUFp1DZtsG9Sc77zU8sb3E4FTCUGWsVFN4RLShQKKfQTzKghBuXBKRMQSJBFEnDWUS2Wykp4a1BTXReEarQmxpA9mcUVIOuhfkuU5GxTJc0d0TrHFAJIu/jXieKiFMwSvStzvFcPHzmRIQviO3L9VfH3+0EFxAysvJtonztPCeHJwSu8d+IjRfcrWboDdbZM29/3trU7fnasm/bf2P9E8W3hXGQpyNxFt60JFf24NRldUGmRIxf0/mEwGhzxJp5iwW+WsdsPXl6cbrE/RKziad9zl5P5XksFegdBTyOytjvUz87Yd5ZTalYPIcMfcMsmApMXErsKam+Fdi6BgXxxRbLr2P1NitIt7uCBwYKXsJgn6UfYS2RnLRA8/QM1Ow3lcPn7g0Q3GVSu7MePslkkKWAIQJ+F7ievhL57tQQguqbzCn1QqgO/T4vb8gd+7vkDxW93oiqCFsZfneXvK+iQ8CQz/N4A6RMv+H+4lFAQHXjsuF4pmJilJDbip7OEfoAi5dnflpTcuax/8TjGDQJDFS2A9ugwuTc=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199015)(36840700001)(46966006)(40470700004)(7696005)(921005)(40480700001)(356005)(336012)(2906002)(186003)(2616005)(1076003)(47076005)(426003)(26005)(7636003)(86362001)(40460700003)(316002)(54906003)(4326008)(110136005)(41300700001)(8676002)(70586007)(70206006)(478600001)(6666004)(36756003)(82740400003)(7416002)(8936002)(5660300002)(36860700001)(83380400001)(82310400005)(4744005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 14:37:56.5776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dfc0250-5797-406b-def6-08da9a4c8b12
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C405.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4467
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Calibrate P2U for endpoint to request UPHY PLL rate change to Gen1 during
initialization.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 35d9c3ac3028..67dd97f3cd6e 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1078,6 +1078,9 @@ static int tegra_pcie_enable_phy(struct tegra_pcie_dw *pcie)
 		ret = phy_power_on(pcie->phys[i]);
 		if (ret < 0)
 			goto phy_exit;
+
+		if (pcie->of_data->mode == DW_PCIE_EP_TYPE)
+			phy_calibrate(pcie->phys[i]);
 	}
 
 	return 0;
-- 
2.17.1

