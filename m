Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509116FF87C
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 19:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238965AbjEKRda (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 13:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238964AbjEKRdY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 13:33:24 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7474959E2;
        Thu, 11 May 2023 10:33:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKL2G6PaKL2N/AT5hj9mlEcW8hNF5x24LADyS1zqS5xgTIO/EStErI6H7yrYHuEcfAnaST84kZfMUkJ6XyKMw93avYgbSpZS6U7mIsd5YlbEy3yoDNvbgNJA6VyGCttuI4x/hq8rrYxzQsWOZpppI1Y5kFOJj3pwli0I3dtfmzB/o4yofyhaZHcFemxI6HOOstPxU3QOTxr69uwIwYcgoBulUBWMCb1PuZxoFPSekeLCfMcoczjTQKY+QpcNhZYZ4AYgOM8j+St6vZzGdEiKyb2znQOGehUseMAhexbrLINPp9ghwt6ZHdUrpWmKWa7ZxfNWeDzqmtiArPBtdTD32A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EdIUYc+1VOETrwAvPfeu9lyIxD+P3dgHCVjxbEq8t4=;
 b=gRfv5vj/edZzzKRvKe44s6ZWFddLzuodb2Ibl2AfuU3UAAOvTp2LeGe23usB5npY8QVNGt3GBapFVhgjZ2UHsp+CObeU3itmMywvcrlLyzjEjiiFC4NNXslq4A/dY6gFCIfzlPtbxqfxVwW2IJtkCLtEoq7ru/2uQpapVxpcX4//snfq4ZD0Ttj6OBfvAEMLh4cu8VLNimqXWec9BueazTbU1IJKTo42yNDNejC93DOx+gWJLiFhLN+MebwkpuMw0Ti8aX9cZr09nzxZ1ljcbz/FpJ4cRlBlg7eMqCMN3r58hlNmEw4JZFjwWbo0gg7I+n2HmqnEuMl3OxdaVduDnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EdIUYc+1VOETrwAvPfeu9lyIxD+P3dgHCVjxbEq8t4=;
 b=urcFQPin3C6XLtAezx3xIs0+yEeg7GmxIKEQ9dwEdYRntOComd7RqsnJsWy+98hKl5Q5J+Rji98jRRBnLl1xXI/K+O+ChAgFJydjFv9+EqV6zSODAgLcViVE9CF52J0IUBgKTfWDwbvBS7LtGlrSWVwRqSjqBx2eT3aMxqj1L8jEe5OpA/9H/rsDcdZDoHYfzFZdaRw+yg6aM2xGNd8IYM0GYzWFtqCT340+bP6U0GYW6zP3ohZioFeiehsUEtk9QHHvlHX2deNNOZGwbuxd39H4TcSJL6OH9oFR68eTqpwjTk3zAegijfKrRgOAsqtblN/mdxNxcBUn/XhQcRJBCw==
Received: from BN8PR04CA0036.namprd04.prod.outlook.com (2603:10b6:408:70::49)
 by DM6PR12MB4562.namprd12.prod.outlook.com (2603:10b6:5:2aa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22; Thu, 11 May
 2023 17:33:09 +0000
Received: from BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::de) by BN8PR04CA0036.outlook.office365.com
 (2603:10b6:408:70::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22 via Frontend
 Transport; Thu, 11 May 2023 17:33:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT086.mail.protection.outlook.com (10.13.176.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.21 via Frontend Transport; Thu, 11 May 2023 17:33:08 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 11 May 2023
 10:32:59 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 11 May 2023 10:32:59 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 11 May 2023 10:32:54 -0700
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
Subject: [Patch v8 3/8] memory: tegra: add software mc clients in Tegra234
Date:   Thu, 11 May 2023 23:02:06 +0530
Message-ID: <20230511173211.9127-4-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230511173211.9127-1-sumitg@nvidia.com>
References: <20230511173211.9127-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT086:EE_|DM6PR12MB4562:EE_
X-MS-Office365-Filtering-Correlation-Id: abf468c0-8008-4525-85d1-08db5245c98c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RjAa675nykWpyv1TeDLbSSgvFhe14Dhwd2ZQZtmRiN+LGD/XbAKg5K2ALINhvNoMKsZYRD1UdEiMI8796s5LrDYeNDRJKTNlgZBLDSYzVc5VyjKMRb4z1XO48usezW2vVGh1rmjXiwNUbDmzWad2M6sluj1z3ZEIniNx1EHGr/vtUxQIJpxzyTo9zE4W3hodraWYM3QaV5HpGMLixtO95mL1Wkin2ZhwBBH8sVxKliJHIR1o3bIcoX3hcpUj7KN7d/OfvI/Pw+PeV4h1ZQ56Smwg2lrLvcF0nplxltUU6ZWd38HLlzr0fI8s9AyIZQztFO4SHTFPV3BWCqz3+Vi7yok16eVFO1c9vQHd1+9frZsIlcqr8QMY0wibq1V+rfkQ6wi7uTqwStJiFlCeFCCXoOoKHo/6fCRJyxII5P19mG3RLLqRRyPtEuwicDUcMcCCvXUJVJFjoc7qDFQvGiL8ggYAZQvVCnPA5YAfe5NutZX8dhvuuHSN1NWHOAaH1XQwROGSjYE1q6FEw7ivBeFF9WuUOmDOkBlyxJkaQGrWfgJRBAkXWYq5z6n+VheYF1sEGTg2v3OOYHmOL3SsCMtjoQYg/OgE8Nq++EeTB8UiW4Xk/NHpNoamSSxC+PclzFnNXST4aW7YnGZ7nZDLZHvzJl/W+QtJqgbhm1Y/zp3i4acO9TuC7Y0o/ToPifGlsTLUsf5Joj8K5we9wbHgYePStDSw1GBXsvNIzLE0xiFxXRBqGLJwGwlRUle6L7qS+xxo
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199021)(36840700001)(40470700004)(46966006)(86362001)(2616005)(2906002)(336012)(6666004)(41300700001)(7636003)(356005)(426003)(36860700001)(47076005)(26005)(1076003)(83380400001)(186003)(107886003)(110136005)(54906003)(8676002)(5660300002)(8936002)(40460700003)(82310400005)(7696005)(478600001)(36756003)(7416002)(82740400003)(316002)(4326008)(70586007)(40480700001)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 17:33:08.8833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abf468c0-8008-4525-85d1-08db5245c98c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4562
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
index a4ea181e1090..0fa68862749f 100644
--- a/drivers/memory/tegra/tegra234.c
+++ b/drivers/memory/tegra/tegra234.c
@@ -777,6 +777,21 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
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

