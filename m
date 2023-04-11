Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D5D6DD8B4
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 13:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjDKLDU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 07:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDKLDT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 07:03:19 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8FA3C21;
        Tue, 11 Apr 2023 04:02:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2TUjNBN1P7gA5Mmcdmh53BtPzaeiv8dicCwIlPZxLyTZ2IyWEa25Q7Q5B+t6Yo/TAYYZVWlpRu73MLAGvZxg9xheTyUkkxCXSB3VVqPhrSs28TOwgivav0ny+HyWjPAvR2wt+aYZGXe00qobLLb9SH2lOo8jhwm5KHhhR+n1FP9Tg0M6bpboD4X7qFpIYnVT3LcKGnPa5GS0a9auTCnbGevzQHFUtRYUZ11Un47G6rt6Dqfwpj/sZ1jWLlCE2gyanMUFMtInygQ4efMyKeumscG5PUu0S/Fac5X5N5HqtCY3+/xZxDtK/oTwxF0at5NEL9NVZwzKhQ4LHDb3HjNPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOrM0/+XPQHdle6AoCz5JzUjexFtXrR3PF2kGKPDQzM=;
 b=PQ2hhiaWlr0kRMZqsVwd1SbFzdmDEXgf1yE9u0r6lgkucwsKGQoMVAS+46jJTwduN1QwmJ5/CUi4QCBz4rhrDxmcCLyFMQ1eht8vOvWgC+LOf5nRS0htSjyCvxW45gwWMxLGhBtGDrWebH1o8rayZrYfWLp3+oa6lUepgUx2KyjyDF7MNmAEyo6RLA6Wx84m9LNPBICiVywqUvafi1MD03fcVzamoAUs23tzKC31WSnzHnYZGY7SsIygqsJVIwotudQBDdM1hrUtWQny/8zbxHQN3N8lnfEzyh4OMQl9IogLlOXoZCJyqfdfNz+Qh1UEFCqpG5P8v/cXks6C7/5rAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOrM0/+XPQHdle6AoCz5JzUjexFtXrR3PF2kGKPDQzM=;
 b=IQovUD00AkvpSqRL9ZfWzf2vs+Uz87zBs2fqgg4l/PwqzZ9M6IMyy6y0XV/wDBScPh4U0M3tKECzNBivuz5YV1afOqCmU0KfKobxNB+RZIcd2aMLJUMoJiItbqHpNsGlUhGpjw8CDL0KVSKbFL2yTSsw6pWT8izfvgqtsH32UeRaUaO2zoGafn7YOuqpPiwpXUYx/cw5S5zvtrkWOmSppgfEh/NlYQ67anUugqCgiBfYdcNDaPrmxnW54I0fybfhQgwKyQXM9gkxHRoiRGM4k8D32Hg1cfBdPoePJE/D2/2bXnto1gejm0bybajVTa+91aAxmgIv5mu78qyB/ZDN6g==
Received: from BN9PR03CA0968.namprd03.prod.outlook.com (2603:10b6:408:109::13)
 by SN7PR12MB7909.namprd12.prod.outlook.com (2603:10b6:806:340::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 11:02:00 +0000
Received: from BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::16) by BN9PR03CA0968.outlook.office365.com
 (2603:10b6:408:109::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.28 via Frontend
 Transport; Tue, 11 Apr 2023 11:02:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT095.mail.protection.outlook.com (10.13.176.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.28 via Frontend Transport; Tue, 11 Apr 2023 11:02:00 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 11 Apr 2023
 04:01:47 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 11 Apr
 2023 04:01:47 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 11 Apr 2023 04:01:41 -0700
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
Subject: [Patch v6 7/9] PCI: tegra194: Fix possible array out of bounds access
Date:   Tue, 11 Apr 2023 16:30:00 +0530
Message-ID: <20230411110002.19824-8-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230411110002.19824-1-sumitg@nvidia.com>
References: <20230411110002.19824-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT095:EE_|SN7PR12MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: cd329891-f8f9-444e-48a2-08db3a7c2ce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3DL+W9p3GXWY11x0VK71FEzCT/ylMMfgEl3zQi2x92W9AKblFlmdxjphuO+acadisXNvXYFvff3iC4L8guHwCHThh6OoLRE2v1H2iBajEpDRZ/KRozClMeopaaB5f6it4xgJCecmvTC9UNVl3SGKjsi+UFQDSQEpuYeFgXJY/IvcMQlgm+fMSRarq3JKZyVFIdbhD+P1EZ2YKeMNsVEYLPkr0is9GrA3mpRahs5m9FUwe8MvjgthhzSufKKBNS8hg56FjCOTHnzDUm9UAuAOEo88uJWtZDB9BWP0SNOhwKHGeoGODIoAKsA/M93RmXTxyOCGyF/tN/yOZIU7HLObhMRjw9FPz37YzZW+umAyo0d863DpeUHXMAAlAV78Qw/1Zr+5rPTUjvROm1HNrRPYCaSy4y2Q1toR0NbLQKkP19YmgKrVAhtHdAPg1y+tqkgZkjVvxWh4E6NHF+cwKKzT8yV8LsTdfb23R4sdx5Qt6KEoqVQPARL2kaz2IAIt17fuLutsYcUTk3EKdnXFTg5nIfpglh3IBjM3UA2QxN+ie25vtxnekFilWj8qW7VrWsfVF3DnKiBpgOFL92T6piqXFDmn6f/8EhZuVpcZpP3doBjX5JQOURoyvivl/RVNSjUI6RqjXXyV8wTETB1Bw1tYwQ+O6ft/A39HLEEqx4txPmvvt0A10HW900jFURG0TlgDnzhSV7Yg6ZhBjYux4s7xfUbXeJiXvy6Ng3XEJ4M0JGTad+Samg+sFKv+qXioW3JULKswKoI2VngB4rjLwD349Zn2nO9yEF2vv3UbO1SkkHQ=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199021)(40470700004)(36840700001)(46966006)(478600001)(7696005)(316002)(54906003)(110136005)(1076003)(26005)(186003)(966005)(6666004)(2906002)(70586007)(4326008)(70206006)(41300700001)(7416002)(5660300002)(107886003)(8676002)(82310400005)(8936002)(7636003)(356005)(82740400003)(47076005)(40460700003)(40480700001)(36756003)(83380400001)(2616005)(336012)(36860700001)(426003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 11:02:00.4474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd329891-f8f9-444e-48a2-08db3a7c2ce3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7909
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add check to fix the possible array out of bounds violation by
making speed equal to GEN1_CORE_CLK_FREQ when its value is more
than the size of "pcie_gen_freq" array. This array has size of
four but possible speed (CLS) values are from "0 to 0xF". So,
"speed - 1" values are "-1 to 0xE". This change was suggested by
"Bjorn Helgaas" in the below link.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Link: https://lore.kernel.org/lkml/72b9168b-d4d6-4312-32ea-69358df2f2d0@nvidia.com/
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

