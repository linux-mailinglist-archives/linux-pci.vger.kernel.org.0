Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293845EA74B
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 15:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbiIZNao (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 09:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbiIZNaT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 09:30:19 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4121DB55F;
        Mon, 26 Sep 2022 04:53:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTvlX1BhhOixaKIXIJ4SSNUuQbecXLIxD6NYgjKmz4kmdwdgNxcFabfOqFHi8cwXUsF61K9uou+ZOkxnNwLFZCBp4t11oNMCK4+HWLHdwTFpTfARq67cKQNMjeQoIoBLC51HPNXezj8mfTK9v+nBAf7yezH6Drml+CEY54TFbdA+GD57blkF6qvYyj0zsalb3cHe6SI2+QWQbMEB4XhUuneZFEing8OGsDAxFJchKvGZQtZq8xwUURA7+yN3IGe4Pc5AX8DzZtAcyreK6HSxw5AMIX2bOBBHhf1E7yNeIc+NYzmNfbs8FySBxQyjys+BWVWt6luT8fFj9OqUP7Zz7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjnIl4xY2Djj39g5ptnOccC7Avtx/AF6DIaqhQtI+pA=;
 b=Hj6NdL5aR6NcThEGrnnvZPuxmjbWvFHvTbxVFoTCdsbOs4WdPCC8aBmexTDtlZB6M6IDBwnszerxsxlUFKJr2xrdkQfVgm1MsmSwkfq3/UagTWWthnCmmADl7j0Kf2WZ5r3ZK7Lh8ZDmdhJlLv/IKx5SW9V08s/Nlji3uFNomZf3bGSbTaSx4UV8kyhU7063JBUpQDxE19fwv2Mmr6rLzPEHSMSEVZ5dDwW/vNCJOYufUQ9jifEBIPLYzLZL1w62DPXQnaKk25+3J2nZsSg8wF2PJQUYM8jE0g/CnREuYnBGeNM+6Bd6LCWqJoPqIiW3ECWtx4pmkomq5A+FLiGmfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjnIl4xY2Djj39g5ptnOccC7Avtx/AF6DIaqhQtI+pA=;
 b=Tetxw8JzfXUG4OUeYhgts5euOGlDDO0sZg5ysIhlo/64Nz35QtHBs8V223P0TLKAXObbf8k9+snRtAxCs06894vQV9rHAPJ6GwCHRClLnvs69gbhzHM5tW1OfHr7zkNVVIGPMjiJYbHMVtZwjBLMSHfPO9D4YqBKRj0JF7dbMzm/vovgBoDkXllqePzLpZTKtwgjr8l0ng0VsEb/FEGc3FBDMUHCg1XaEmIdrkdkYVkA0NSEHhnwM+hd8oqIm1pd8TaZ5D9oNtLUbFHwCvF1aysyO7OSTyCLEttHWQGkqcgvUqLUvChe5AG0aFL9P9jcCbOIb9cPsk5PUgSJs0OYYw==
Received: from DS7PR03CA0004.namprd03.prod.outlook.com (2603:10b6:5:3b8::9) by
 BY5PR12MB4259.namprd12.prod.outlook.com (2603:10b6:a03:202::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 11:51:05 +0000
Received: from DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::23) by DS7PR03CA0004.outlook.office365.com
 (2603:10b6:5:3b8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Mon, 26 Sep 2022 11:51:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT082.mail.protection.outlook.com (10.13.173.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 11:51:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 26 Sep
 2022 04:50:59 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 26 Sep
 2022 04:50:59 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 26 Sep 2022 04:50:54 -0700
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
Subject: [PATCH V2 2/9] PCI: tegra194: Drive CLKREQ signal low explicitly
Date:   Mon, 26 Sep 2022 17:20:31 +0530
Message-ID: <20220926115038.24727-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220926115038.24727-1-vidyas@nvidia.com>
References: <20220926115038.24727-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT082:EE_|BY5PR12MB4259:EE_
X-MS-Office365-Filtering-Correlation-Id: 24c7c34b-8d9e-412e-920f-08da9fb564ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7OwS9TgB8y5vPecBx+JFJIe0ID2ABa968ZGuDqJABe5wCa1HTv1ZVaVhqiZl75AC0F5KdWcnPK6NVaFwmKF7XjkIN4avGgJQPh1o3dE424nb00PIP6jLH4OdoRa5yrykQozjgpAiWnGHTqe6kpAnufZIym8xFMpzXikyIUYEfkGn0B4QbOPyAyY6k3Q71R8O4w5wfncLqflBV3d8AIoZt/X3uUryzdwA+hAPAoRh9u6Sbg1SP2je7gqvKuS3sajuzw69jAVZAVE2HOiIyBTYXqAzo5KFXUdv9gh99mtmdO57KKQuZsY2gGC0DibwSOcpJc6diFPd4W+WWfbBjT9yUXVOtrFengW3F0LB8zxOaAT1cmdlB/gXmeO5fe9HFED5NWBbJuXcLUVjh0LUbprUxTCn+f62siLVl7nxpaK+4MbErhEWnL++7Ryc6DcwQb+D/XNUmkCqpCGZ/xRuEeipJkAp4/xXqbzgv7MnhoXwIbqSRaxKaylOyoiEmf3Pdn/zC4T+i7KC7e0QWP05CouifdCV/pCNkBI7yaCq/pcEyaNLU5I4CELG1/oO4w488c9bSHK0YoAhhTeThUpCfQ0gnlHU+DAVMsGiQhnG2rW5CF7C810SpLnUgWjX86C21GAB2DBO/TbYSQauJoKrwqKqEeG2R5uVeC95OBzNmsQla5vVD+EWTl2psnSg67oU6hQDnI5Af+qQiig/cogY6j/Z9b4B5VkRIwX9E8jDHjqgmTtXB947oA5OXrrj8k14um6sKP3VAfqTDk7F//afPnbuZdkmxjHSLSKQbOPNkNGoqQ4=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199015)(46966006)(36840700001)(40470700004)(7416002)(26005)(5660300002)(36756003)(2616005)(2906002)(70206006)(70586007)(4326008)(8676002)(8936002)(7696005)(6666004)(41300700001)(40480700001)(86362001)(82740400003)(36860700001)(426003)(47076005)(1076003)(186003)(336012)(7636003)(40460700003)(82310400005)(356005)(921005)(54906003)(110136005)(316002)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 11:51:05.1646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c7c34b-8d9e-412e-920f-08da9fb564ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4259
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently, the default setting is that CLKREQ signal of a Root Port
is internally overridden to '0' to enable REFCLK flowing out to the slot.
It is observed that one of the PCIe switches (case in point Broadcom PCIe
Gen4 switch) is propagating the CLKREQ signal of the root port to the
downstream side of the switch and expecting the endpoints to pull it low
so that it (PCIe switch) can give out the REFCLK although the Switch as
such doesn't support CLK-PM or ASPM-L1SS. So, as a work-around, this patch
drives the CLKREQ of the Root Port itself low to avoid link up issues
between PCIe switch downstream port and endpoints. This is not a wrong
thing to do after all the CLKREQ is anyway being overridden to '0'
internally and now it is just that the same is being propagated outside
also.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* None

 drivers/pci/controller/dwc/pcie-tegra194.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 941fdb23e02f..7721f920dd74 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -46,6 +46,7 @@
 #define APPL_PINMUX_CLKREQ_OVERRIDE		BIT(3)
 #define APPL_PINMUX_CLK_OUTPUT_IN_OVERRIDE_EN	BIT(4)
 #define APPL_PINMUX_CLK_OUTPUT_IN_OVERRIDE	BIT(5)
+#define APPL_PINMUX_CLKREQ_DEFAULT_VALUE	BIT(13)
 
 #define APPL_CTRL				0x4
 #define APPL_CTRL_SYS_PRE_DET_STATE		BIT(6)
@@ -1453,6 +1454,7 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
 		val = appl_readl(pcie, APPL_PINMUX);
 		val |= APPL_PINMUX_CLKREQ_OVERRIDE_EN;
 		val &= ~APPL_PINMUX_CLKREQ_OVERRIDE;
+		val &= ~APPL_PINMUX_CLKREQ_DEFAULT_VALUE;
 		appl_writel(pcie, val, APPL_PINMUX);
 	}
 
-- 
2.17.1

