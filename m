Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C3957CD7B
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 16:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbiGUOXe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 10:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbiGUOXJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 10:23:09 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFC88323A;
        Thu, 21 Jul 2022 07:22:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=io4UE4tu7BsBYVqwoxFJp43xtPGWmKqZFjHNafPPDPT74S3ljJ2Nh1/SU+GqrZkZsNDPrdViSRrmALDjG/jnHTEb7XnWB4lV7W6+viVXGOW1NY9S6AgPJI7jgQedNTv/NgJp54saqIf0vH6Uh+6JZFcokhw0NG0nUFWv5uq1uH1nkL+cCPL+S0kgmrTccEvhlwQbObP5Byko54ju3nqi3vVfDovLxMvYA8Yww/HTvMPT6gOF5+9gzky2oj2AkwybTymDdy22XGyu53PZTUabSzki1bpwPn/SJJ11StxkR2h6SGtzHgubxOt7v7hNiaYZUp/YsdaebsIbCtWH0zEcrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ASHs5vc24YKfZFPToUV92rPiJU63GaVEDxaJgtbnKk=;
 b=d3eoBG+Pgs1sRCxeuEovbFoV50jzo5VZ0EJvthLdCXrIpSuoF2Cyiul4azuc4f/Tbu88nSlvHzQhwRNwUGG2dqYnsQb+RghWUXJj1DPnjxHQoJVrldkUuA5hchAipDVXcTH9+XTFGr49+kSouP+KjY4STp7jG7aUVw1dQqlwge9IKjqU9CnSDNwgW623uT0vXEvhSsRhk0K8s/3rm6jQdUKim2gg3qOr8AaV27xqUZFEVVxQDrqmn571E3QNO7R7iNTb3gwARZl4CEw0w0aFRa5c2kucgyr/TQEiweNj/Z9Yo9xBkz0QSV1bVBTeiO04JhDty0q0Yei7uhbYtsenbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ASHs5vc24YKfZFPToUV92rPiJU63GaVEDxaJgtbnKk=;
 b=IpqseRn5u23PbrYsFni0Oy2TT40SoJ5TZei0jNrE0+Xi8udMNHW87IMozzfOwYTmGu4sgVxbXzTQ5yDnB9KxUi9sYXPiK+C41E3r8a+9sf0uE5WdcNOE1qo20RmnMEaq75yd28nr6Kz5pOo0e5rIXxAI0SQoRKv2KiTSxiQUe8+g5zWeXC3NHUJEgID9WXTrZM2wRPOMFTXcGkxmNE0cJISrkH6NIpMiuxMRHzi2sT5joogrpAILuxj35oOsO1JzaDUi21KneSvUmwvwFihglTF7jAklKT3S/kyH3jolmktOAhf41F+3oKa5d9SrnaBIQmoKZXdzr1DKoJnCRfdMCA==
Received: from MW4PR03CA0036.namprd03.prod.outlook.com (2603:10b6:303:8e::11)
 by SA0PR12MB4526.namprd12.prod.outlook.com (2603:10b6:806:98::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13; Thu, 21 Jul
 2022 14:22:51 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::11) by MW4PR03CA0036.outlook.office365.com
 (2603:10b6:303:8e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23 via Frontend
 Transport; Thu, 21 Jul 2022 14:22:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 14:22:50 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 21 Jul 2022 14:22:49 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.26; Thu, 21 Jul 2022 07:22:49 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Thu, 21 Jul 2022 07:22:45 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lpieralisi@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <kw@linux.com>, <kishon@ti.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V6 15/16] PCI: tegra194: Extend endpoint mode support
Date:   Thu, 21 Jul 2022 19:50:51 +0530
Message-ID: <20220721142052.25971-16-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220721142052.25971-1-vidyas@nvidia.com>
References: <20220721142052.25971-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1409ad5d-848e-4803-f994-08da6b247e1c
X-MS-TrafficTypeDiagnostic: SA0PR12MB4526:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZZCTOxjcnkXz9a1AjBd97qMCXo1KdR6lX0ywIvPTDOb6F2JNl8dPSvYRBJWxrsIjmQ/xScL4Pboyk020K6ULd7/aXUAfC73e82SYqpxkKFj81YsLJTo4NekMSPvwkZjnjmR8EjVJL6wgDToK+bUqYVNzkaa+vjuneaNjVnAgu+jWB5qgG7+vNdzeOtV7zvyRBYso9mg7kCybXiE7xd69wivv3yqjvScY5H5botQA1WD1QOkHYufXMiY3Ka8yIAaRJ1avgu1V4+Q/wiLkGF24gxixN2U/pMUoCMbG0DLO3POQZVl7j0/Wz72zr43qFzeFjeu4H7jCsBxrAuHdEov0tuubCYtQ/efBq/syJOUAa3bDkjTnIeBma5mnLbJF/ZkZRR6bxyrRwWaCuUPfOBP73AdRTyBl5yaIEc1R9LNbmNg6xfecsrLqj3mxvsTtJtMN52kE/ulhJaAW7Ssf7nkkMLqylyluk0vKBkmMKBgb+Uw9byUPI3Z0EPnnSHIhvSzn3A7DoH8qbbjwMQgqqyTFzQIRmfBnPV7qmardVThubiD7u7KS2n2mAkKDGI4PgcaG52LtWOP1m/EUTrRWSAZQFII9NIW5UOl/7fT4SgmiwkwiDRbUCtIVLMuDQPNdll4FGzUtYhy4Rnyzb0ysSF/k2gVeunQ+7ETdHcGPI/YKSzng6rQxocIeDd1SsHa5dWcg2/GAf4Gy9innAWGtslBf/6v8t2P4JFQETlyyKNyGmpwG3as4GhY3Sp10gK9PnZEyDKjaY7TNnsyOkhgO/R5GPnMcbmvevG2kYOxO5Q4Ur/oaiaOk9NSWyS60Tw7Kb6vWMT1ZcKk8hC69kE37Sy8y8/Q1WHkfe4yPJQKPz7kIWh8=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39860400002)(136003)(346002)(40470700004)(36840700001)(46966006)(81166007)(86362001)(82740400003)(36860700001)(8676002)(40460700003)(4326008)(316002)(110136005)(36756003)(82310400005)(356005)(54906003)(70586007)(1076003)(47076005)(5660300002)(336012)(40480700001)(70206006)(2616005)(426003)(478600001)(8936002)(186003)(7696005)(41300700001)(7416002)(6666004)(2906002)(26005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 14:22:50.3919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1409ad5d-848e-4803-f994-08da6b247e1c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4526
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since only Controller-5 can be used in the endpoint mode in P2972-0000
platform, support is available only for Controller-5. This patch extends
that support by enabling the endpoint mode capable controller during
initialization phase which otherwise is not required if it is only
Controller-5.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V6:
* New addition in V6 based on Bjorn's review comment

 drivers/pci/controller/dwc/pcie-tegra194.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index bac2e1ad0a29..fc373b6efd00 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1650,6 +1650,13 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 		return;
 	}
 
+	ret = tegra_pcie_bpmp_set_ctrl_state(pcie, true);
+	if (ret) {
+		dev_err(pcie->dev, "Failed to enable controller %u: %d\n",
+			pcie->cid, ret);
+		goto fail_set_ctrl_state;
+	}
+
 	ret = tegra_pcie_bpmp_set_pll_state(pcie, true);
 	if (ret) {
 		dev_err(dev, "Failed to init UPHY for PCIe EP: %d\n", ret);
@@ -1798,6 +1805,8 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 fail_core_clk_enable:
 	tegra_pcie_bpmp_set_pll_state(pcie, false);
 fail_pll_init:
+	tegra_pcie_bpmp_set_ctrl_state(pcie, false);
+fail_set_ctrl_state:
 	pm_runtime_put_sync(dev);
 }
 
-- 
2.17.1

