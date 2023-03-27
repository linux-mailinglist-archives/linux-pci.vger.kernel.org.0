Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4806CAA38
	for <lists+linux-pci@lfdr.de>; Mon, 27 Mar 2023 18:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjC0QQV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Mar 2023 12:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbjC0QQS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Mar 2023 12:16:18 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA95019BF;
        Mon, 27 Mar 2023 09:16:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+EWTG3iY3kI5lssKWIUJzhiiuO6d6mxrbmyl7DB/Ou2T93Is8qO+K7t8yH2HkEpIWtychL+GPOr+nXQYWPQVERoz9WeEhC20J0pXoo8nq37Jk0gLZroCSNpQetH30+IW3nDvzU7EctKRGIi/0O/A8bGjRzN9PQxaE5N8TpufBwMeRikVWgh9rDXKeqF4rvV/uu6U4XmW+PtnHWQYOUcDpkZ7PhvEZw2NKLGlmB1u56i2ckLoyTVSzcxbF5kmpEEXHByJ/ASBEZPtIZjb9vfkUx7XNLm//NZDf99nw4Rssm/oUDmmZeOohecoBX7rjm1wikyULrx6fScgE8+OUuRDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zK1/rGgZRQEz33770HYZfksNwVrQ+jTSrI/RTeIWVxM=;
 b=bQ3f/QQ54RYXjendqWgXZXzG4wfqmE6ijPXRqMyyrW0/3CRA5MUV8JUM0q5cfFaVLm5QzytICUioYct5OJs3p5vkkw8WTl/S82QXa7QU1v/zBHdmpe5f7ex+bjfqhK7+1cBY8Ju/4As+ODxrbkHFfyLYqsDIodjvZtJtOEJykp8Pbhgpgm6CO2862kpvu7brP6ySxbghgcb1KZSGFzJw5p8wWRrh0pLUiAZ+fT8NMwI4fpBoXpAXnRZ4wBe0NobOWVqTpNZVmAaePtpfg8og0+3IfiU/Du2P2vZAShS35ImAHmZlhvnbLLTrOQK33zYNDcyhd2LZJk7hQ610R1NXWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zK1/rGgZRQEz33770HYZfksNwVrQ+jTSrI/RTeIWVxM=;
 b=F+qRGaB2z5QfDV08upGRXwPdl1jEN36nfANUoZ/bhsSUg6BicLBM/lHalHgS83DgtNXPXFjwVijdU51fdlEQdG21Zmc8/JIjqIrl93KhBBetkL4egLiKqv47sndH+tBM6jmWQ1/rt1sGkLMLCCT/k0X7cLHiJ6HBis6vP3xHzmJ7s32ctpgcp7IACPh0vBS5vl6L3aB1SOq3zTw38hIb9AOmLataY6jp1loqskVsYPkYIQLXb7t/ddUR3c0l+cuh6abS/cwEqDPcQdf/J4svJsETReJHdYsLFeCnSm7q8mE/cvWQbjFe9hQxDYGXqb8wOFBCms7AqB8Eb5Er+nHMeQ==
Received: from DM6PR08CA0034.namprd08.prod.outlook.com (2603:10b6:5:80::47) by
 LV2PR12MB5845.namprd12.prod.outlook.com (2603:10b6:408:176::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 16:15:58 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::14) by DM6PR08CA0034.outlook.office365.com
 (2603:10b6:5:80::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Mon, 27 Mar 2023 16:15:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.22 via Frontend Transport; Mon, 27 Mar 2023 16:15:58 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 27 Mar 2023
 09:15:49 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 27 Mar 2023 09:15:49 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Mon, 27 Mar 2023 09:15:44 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <treding@nvidia.com>, <krzysztof.kozlowski@linaro.org>,
        <dmitry.osipenko@collabora.com>, <viresh.kumar@linaro.org>,
        <rafael@kernel.org>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <lpieralisi@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <mmaddireddy@nvidia.com>,
        <kw@linux.com>, <bhelgaas@google.com>, <vidyas@nvidia.com>,
        <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>, <ishah@nvidia.com>,
        <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch v4 05/10] memory: tegra: add software mc clients in Tegra234
Date:   Mon, 27 Mar 2023 21:44:21 +0530
Message-ID: <20230327161426.32639-6-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230327161426.32639-1-sumitg@nvidia.com>
References: <20230327161426.32639-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT017:EE_|LV2PR12MB5845:EE_
X-MS-Office365-Filtering-Correlation-Id: 352d1ef7-b3ba-4daf-773c-08db2ede8ccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6C4JJTfDKdNjkt5zaeb+JsY/guiE551j/KFTJOhmElPv/fa4/uti17nhMddzARW7jqzRtui1fl3DkfU/HL4Py2jYrEc7WNL0REsAK8mXUGDVyuL4Fe7mJmY/IAxuFrCXVbCcVDSsO4RpVkIsuR8eGbGjfcyPHHonoDlIds+3+s2Th4y488XK08YJVExVfp2eABeR/LkH9ylcVxQayz/qWAbXAKZewqPc/V1ceNK2InWPpuHq/9P1sxRXoMpn7SAJ92v52yLVMysRs+ZhOH8p0UUDNf5Trh+vv3PTcK/hEodkpDhaeTmK2A/341xqR6klGxwNEV0uYHRE455Q5mV+llpIWhgZFl0M98PCWxE5NUzufSJTGkD3SrQGkwrFZIfdisneCGzBQJZF8d4sgdRLOTYoXw33M3lFa/SYnzfBpRMuFLOs7lWmLpMaumg9wgxexgok9yrCBt7zw2yjbr6O0Ks+wnRhCnY1SUAtkZlWTLSAmtcx0raT4FowVV6IUAhq9HubkjdnGVyEOdY/RgvMEPMxx0dg0r0sum/BWE4FnKRNlooRZP+MJxlj+D6HD8qNnS5fyeSnRf/ZWWainDui+bTaiNnImlBudE0JYEMiFwz96uPvPeqU3ChIZv9nZSChaHbZIqiCczwk0SCho32eTF7jdqrNKUewUvCkclLEOfz98TN2SlS1q5UoIXIRfqw1JaWkoaZY90T7mmUqA0wa1J8rstNZflZ/UFKaCYmsGn9mvBE+tKQFiMWnDhR/gj7cxDiTo6F8XGH5HjW9EQJ7i8yTHLk3k6INRsi8t7j32tk=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199021)(40470700004)(36840700001)(46966006)(47076005)(426003)(36756003)(2616005)(478600001)(336012)(7696005)(83380400001)(34020700004)(316002)(36860700001)(110136005)(54906003)(6666004)(107886003)(26005)(186003)(2906002)(1076003)(5660300002)(7416002)(82310400005)(8936002)(86362001)(82740400003)(356005)(41300700001)(40480700001)(7636003)(70586007)(70206006)(8676002)(4326008)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 16:15:58.1544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 352d1ef7-b3ba-4daf-773c-08db2ede8ccd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5845
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add dummy Memory Controller clients to represent CPU clusters.
They will be used by the CPUFREQ driver to scale DRAM FREQ
with the CPU FREQ.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/tegra/tegra234.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
index 353f5ef688b2..4c8929a88778 100644
--- a/drivers/memory/tegra/tegra234.c
+++ b/drivers/memory/tegra/tegra234.c
@@ -778,6 +778,21 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 				.security = 0x244,
 			},
 		},
+	}, {
+		.id = TEGRA_ICC_MC_CPU_CLUSTER0,
+		.name = "sw_cluster0",
+		.bpmp_id = TEGRA_ICC_BPMP_CPU_CLUSTER0,
+		.type = TEGRA_ICC_NISO,
+	}, {
+		.id = TEGRA_ICC_MC_CPU_CLUSTER1,
+		.name = "sw_cluster1",
+		.bpmp_id = TEGRA_ICC_BPMP_CPU_CLUSTER1,
+		.type = TEGRA_ICC_NISO,
+	}, {
+		.id = TEGRA_ICC_MC_CPU_CLUSTER2,
+		.name = "sw_cluster2",
+		.bpmp_id = TEGRA_ICC_BPMP_CPU_CLUSTER2,
+		.type = TEGRA_ICC_NISO,
 	},
 };
 
-- 
2.17.1

