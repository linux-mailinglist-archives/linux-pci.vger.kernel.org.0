Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944846C1FDD
	for <lists+linux-pci@lfdr.de>; Mon, 20 Mar 2023 19:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjCTSel (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Mar 2023 14:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjCTSeG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2023 14:34:06 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::60f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85054B813;
        Mon, 20 Mar 2023 11:26:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2QcRhiVexnE1FLcjKzdUEuTePMBMNmT452gULI3z4XtP2AvTIAXSrB5L62Ujw6CM8OaJFu0kFPP27VMgHR7R1GErIGbCoX3pmPRucFI5nmvZyfrn2zpUEmG/bMkHp82JiIt+OYNVXF/oqwk+s0Tl+m9TkDhw8eCB16+Eb0AR/quBg8Qb/2ca0XGmDlVtC2dYgVi5gayIplktKsKGuZrQpV7sl0iIRdbAIrrUDB8v1eukc4kW1TI5kRXC1XtU1iDXavH3ske/0G9Mf0a8n4ozmJ+Sm4RBf3RWh1aUjwRroZoce5sfnIp9Pc1p6m2TBgyG7UznVfucjBLjmtVqHnRlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svHueZvVRekRKinotHkmNyJdtEVj/8ePfaOL6y6CMbA=;
 b=EttJ4yiZiosAb1MrT9OppaQGBlgV84EKwNwhnrx2L32lRAFR4RpBNsODNvU+z61FWSfsnbr6K+G8+Uruo+8ACv/szC9uo7O/BZEa2NBl/8Qe/skiNjpVWX77ra3csePLmNhx/qos23hk1zdqG1f/0DEToa/hFbpjhbYIyfhJ44w7yon/y7wbPFVtUuwbl3z08BTId8Be58FlnT8/9NBnjLsNfaWJN9Wck4dlajjWr6jqjM+lV0/JpnKUmbjix+GrATlZt7a75WMj+IM1lLzMdb8Wf6JmAhVBliSLSYkb0XmtTGUJ2fsnl7UhCe6oDqMxB4mXokQ+jEdwx5pB61vzAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svHueZvVRekRKinotHkmNyJdtEVj/8ePfaOL6y6CMbA=;
 b=kwZejcQu+UC7cIYypGJlE2TgOHfd1MhkdlXD0yUPLQ3LYxN9J92bcM+oMm/NTySuRcGfD2Otl4c2oEQT1IgxW+4ZL6TKkD8Od+UvbcP1GyJ/jQdA2tf9Qc/suxoaZ+Raz50Sv26F6gXZ8q6f9nqKWvXA7hBN83RaCtYXMbQ9tbiSuonlJsVjAxjZ21nDpuEIoDHIPFPiT4OFR3gu5v1ppJsYAzTgs1JjrCYxL7TZgr5cvyaFJ0iPJaBJymC+1g0TrhbbLZJeZFRKKNuobz9fVyouVD32tlw9BZAsuFutnwDUp3yBYXNdii3NJPGJWXegHKrKxkctP8oljtZquXvfdA==
Received: from BN9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::7)
 by MN0PR12MB5785.namprd12.prod.outlook.com (2603:10b6:208:374::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 18:25:51 +0000
Received: from BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::35) by BN9P223CA0002.outlook.office365.com
 (2603:10b6:408:10b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 18:25:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT095.mail.protection.outlook.com (10.13.176.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.15 via Frontend Transport; Mon, 20 Mar 2023 18:25:51 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 20 Mar 2023
 11:25:40 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 20 Mar 2023 11:25:39 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Mon, 20 Mar 2023 11:25:34 -0700
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
Subject: [Patch v3 04/11] memory: tegra: add software mc clients in Tegra234
Date:   Mon, 20 Mar 2023 23:54:34 +0530
Message-ID: <20230320182441.11904-5-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230320182441.11904-1-sumitg@nvidia.com>
References: <20230320182441.11904-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT095:EE_|MN0PR12MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: df2d9522-fd66-4d8e-c477-08db29708912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vSsNVKKFw3+q2qxlFhe3sE5zE/YikzcddaEok1MA1EdLFudV/+9FVubW17Z57am1HLNUFM4C1zVWybTS2sUH8HGkAq0VYcF2cL2HAr5bxLiDNQPen7blAcAaq/UPegtJuNVaRcOZCbHbhTezV5OVck3Pf8JW8eKiXSCx3SDCjO6JqC7W0Beh17tBFDqWOerdbsbjAnbmT2APUUN9L6xwTEOPSr3m2RuC9ZO83/tu57kwNG3p07HCwbLzouzqS3yu7tNwNOB8000GgBV7UWHyeAYh4W6Q4QDpQpbljn4aatrGoy/9vgcimXhCTv32YcXC5khVGwDfU922revzv+iUVXATGzqaNXsot4JVLx5ZUaYimEPGz9tw6hzn/HD2qjXxgzcBKnhz4uqi2oDO/6JXjF4lLsSb4nwkq/WsmdpXWidCK+8GQs8thNmlL6uzBJBZLtsIHAtCHarbyklJceHtVNcMKZXA1RSU0G0AeVMrPG5UETBVHbf4tWNqeCHgM2c806HHtWazSTFeRMaYTcrCwdO8vFlvGhTRfDK6yeIhh+EfSyWnVjIbDhoU1xzi1e6bJq9938/KomNVHXiK7WoqAMDqRmA8lSmwMzJo65xy3x605TJBHpsx5txq6siWqcZ29W12upo4P3z3Qe/e8cCYRY7al84X/PQMKSxMfZRHYF3dA9VMQw1Tb3vVEv/wJVuvXUErKYZiXu+Gcpyzdl14F2ZJ2eoGDjL324ayBEm2E9LaeXf4P8qTHCA7B5cuWhG1
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199018)(36840700001)(46966006)(40470700004)(47076005)(426003)(86362001)(316002)(40480700001)(110136005)(54906003)(36860700001)(8676002)(36756003)(70586007)(7416002)(41300700001)(4326008)(8936002)(5660300002)(70206006)(40460700003)(2906002)(478600001)(7636003)(7696005)(83380400001)(82310400005)(82740400003)(336012)(107886003)(356005)(2616005)(1076003)(26005)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 18:25:51.3966
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df2d9522-fd66-4d8e-c477-08db29708912
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5785
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index 7ca744036f59..0c666e52bf46 100644
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

