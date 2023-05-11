Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A2A6FF88D
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 19:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238682AbjEKRew (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 13:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238957AbjEKRer (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 13:34:47 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23BF8A72;
        Thu, 11 May 2023 10:34:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwLnv7Mu6Cjc6SXSBO6kBfmjrgmsIHdtTqfg7njA4Rm8XdOnw82fbjt/93IdMaNNXq+C1HBh0CIuNf690t52xqfrwG2EDi4fMEDQnVtMolwutz8AhiNxiENepG40ipUlTXYJIba9C6xrn/8T4oSN62CyyIg/KGij/azBP6dMxisdxk+UIU3X7YLtHhZibKa22ma+GOiMF2dqcFlsn945Asjas4lEE8eIW6WHMhgPp7B4LfnkCDsfwAYavd4p64R1Fzs+nyH1lIo5A1aaIf0VkJTYPkEd02JG2nPmGY64xfLxO+rb+9QV3TbwsP27RY4oX3KOmhbvjEKwFywCYqoNwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoLxQ/aoqkolqX/Bc5Ghr9wWeKjvVcGBxx3jPRPmbH4=;
 b=jHXlVYppm1YAnYmLdY+COH3qsVGIUK2QYL2a0dSvXl0fjyAGiYcBANBfNS3ZwSRiffoBc8SqiUBIR8axzErx0OKq4Xk8npXoJLIWDHl2IGl8ARry89uvKpN+2avDhBhWinoiZFJQqiIkf5tuQRFEtZj6mW0bw4zvvvx1X3FydX4vZatwEzsMS2RXy805tOaurZg9gehgH5dxKNfTp5puC4DKoRBaC3h2ohFg5K2RCvoy+jQ0DMledOTjPfeNLiKUDECNXAzq6EYw7WpgzYG4iiHHfaD/pjfSpYv5TLuSdJvx8Dl6BJWf8smTrdJe6eZJz+wso44JNA2OSE0niZaUAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoLxQ/aoqkolqX/Bc5Ghr9wWeKjvVcGBxx3jPRPmbH4=;
 b=f3zIPLDpktHCfEtD2esweIWVUth4KDCdCIHtGN4uIjk3frPcQvep9o8cYGJb4ymOdL48QMinV2CehQrQ0T045WT0CUMVOONsP10jmJLtSseYlsgH0MfWB+HyRhXcb2uH5AgjG/zR17ATMkz+G/te+qEtiWwh/LazicE0ITZvU7pR+M7Yip+qTlZpDWVmH13jlDrDxJWCVRr5rpDd0v9ppKBmRv0dYAr6WuhP4SVqNwPPx2QBbJYHv3n/5VQfZhJL4JwRd0s6bBHK7Jyw1dNgTA+OtiOZFlFROb157OE4KVgSPe8bfTQujsUvWotwq+UfXiyd9C+PDFoe9sapnv+glQ==
Received: from DM6PR13CA0024.namprd13.prod.outlook.com (2603:10b6:5:bc::37) by
 PH7PR12MB9150.namprd12.prod.outlook.com (2603:10b6:510:2eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22; Thu, 11 May
 2023 17:33:44 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::f7) by DM6PR13CA0024.outlook.office365.com
 (2603:10b6:5:bc::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.7 via Frontend
 Transport; Thu, 11 May 2023 17:33:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.22 via Frontend Transport; Thu, 11 May 2023 17:33:43 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 11 May 2023
 10:33:31 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 11 May 2023 10:33:31 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 11 May 2023 10:33:25 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <treding@nvidia.com>, <krzysztof.kozlowski@linaro.org>,
        <dmitry.osipenko@collabora.com>, <viresh.kumar@linaro.org>,
        <rafael@kernel.org>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <lpieralisi@kernel.org>, <helgaas@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <mmaddireddy@nvidia.com>,
        <kw@linux.com>, <bhelgaas@google.com>, <vidyas@nvidia.com>,
        <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>, <ishah@nvidia.com>,
        <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch v8 6/8] PCI: tegra194: Fix possible array out of bounds access
Date:   Thu, 11 May 2023 23:02:09 +0530
Message-ID: <20230511173211.9127-7-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230511173211.9127-1-sumitg@nvidia.com>
References: <20230511173211.9127-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT036:EE_|PH7PR12MB9150:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b3d4958-3f7e-4928-f66f-08db5245de30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +TAqTmfmpUUqwSspbprF/6SiVNdgJlaSitm5ESFliUfhq1e305RUDrT4duE8kvYL/JAZNpTJlzfUOaXGN0w+HtEWzoQ9KsotyCobzIKETmEj53xfrQq94sz9f1wcBQMgUAaCbCZJSUqn2TqVTvbmro6i6JDqZjsCVwypJp973TTKUyfv2asw8BUvms0hZGjFm0nn0hK/eBSZ5OPruA/ddPyod5RxxBdgQNZRddU2TdL4N5Li1coao+vUnhCQSQjkF4IktAsuIgWrYm66nQBnUqbLO9PPbwNXSawTyavHCCAuMtX/VDFsF7OvN3cb94PMvDDJHQkAWhGvhqJfasqAVfj1UDov68gpd7wwgBhrxo2Us0MiMw26t1w145P6JBtsWs6oApRUOmn9wXnkGvUri+im/59iH33z6GNO4CCmIEXlXEknciHPWfnl28SFoGOpnSp+As4he99GrrnnziDB0DAyRI/e88QmrDLZ9jexSikkytYUNji/ptR5tON4qzPsh8l6zP/JPFvzUZa5to1sHVTx9vXueWoi5Is36JDLw9qzJZQjqRw4WRfUopsUuL6QJun4SWfYEhZuCJYpbs52kQ4GQiRsmgTmPNqgFu+E/UAOvukCesJb1RgJIgHKy8rjBlIU0NtoHSSV9qPLy4TojNsItm0Au97PBQ6Xbmr7ph1fZ/w9u3MYtOrtp5BVhg5cCLecpLlHy0xfX5xOYyHjMkD3fpvEYw59zW7VY12o3v/p7RSQbvfHVKlA2OiM1HxsV3ia7+TV63hHAMy65VRD2F7pVsago+Ka48q0Opy9QPE=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199021)(46966006)(40470700004)(36840700001)(86362001)(36756003)(54906003)(316002)(110136005)(4326008)(70206006)(70586007)(966005)(478600001)(7696005)(6666004)(82310400005)(40480700001)(5660300002)(8676002)(8936002)(2906002)(7416002)(7636003)(41300700001)(356005)(82740400003)(2616005)(186003)(107886003)(36860700001)(1076003)(26005)(426003)(336012)(83380400001)(47076005)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 17:33:43.5622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3d4958-3f7e-4928-f66f-08db5245de30
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9150
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add check to fix the possible array out of bounds violation by
making speed equal to GEN1_CORE_CLK_FREQ when its value is more
than the size of "pcie_gen_freq" array. This array has size of
four but possible speed (CLS) values are from "0 to 0xF". So,
"speed - 1" values are "-1 to 0xE".

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Link: https://lore.kernel.org/lkml/72b9168b-d4d6-4312-32ea-69358df2f2d0@nvidia.com/
Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 09825b4a075e..e6eec85480ca 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -223,6 +223,7 @@
 #define EP_STATE_ENABLED	1
 
 static const unsigned int pcie_gen_freq[] = {
+	GEN1_CORE_CLK_FREQ,	/* PCI_EXP_LNKSTA_CLS == 0; undefined */
 	GEN1_CORE_CLK_FREQ,
 	GEN2_CORE_CLK_FREQ,
 	GEN3_CORE_CLK_FREQ,
@@ -459,7 +460,11 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
 
 	speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
 		PCI_EXP_LNKSTA_CLS;
-	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
+
+	if (speed >= ARRAY_SIZE(pcie_gen_freq))
+		speed = 0;
+
+	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed]);
 
 	if (pcie->of_data->has_ltr_req_fix)
 		return IRQ_HANDLED;
@@ -1020,7 +1025,11 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
 
 	speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
 		PCI_EXP_LNKSTA_CLS;
-	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
+
+	if (speed >= ARRAY_SIZE(pcie_gen_freq))
+		speed = 0;
+
+	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed]);
 
 	tegra_pcie_enable_interrupts(pp);
 
-- 
2.17.1

