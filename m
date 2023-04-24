Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702C76ECCD6
	for <lists+linux-pci@lfdr.de>; Mon, 24 Apr 2023 15:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjDXNPQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Apr 2023 09:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjDXNPN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2023 09:15:13 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062c.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5380249DA;
        Mon, 24 Apr 2023 06:15:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9MwjaAq+Y/gRvix4aTIBf/NJs2lu6vbOw+WM1S99yGZPAu/AUnXpIiOhQE0Y8PrbR2dCEucXVz6M7w7bXXBF7FHRkzA3s2npXz++wpPXnZb9i+awHPIo/cQSjg2qOgKFXRcsZlIUBv076/xgHXYHDj5Wn9UZzCF1QGNy44PnXysHQt7s7fMZ/jWNa3w+vzYRq5M5RQOjUf9yyppxyjXHIkrL3ykYpi8t1WecsnsKKtVxjs4N73QqffuW6EGtpWIGsfTYKa02HR251vaGJJNlF7DnJgKvtOnmdsxpyZieUjjt2uv5joJZYChEkTGa80EnlADrZ4phl+M5zFhHf4uXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EdIUYc+1VOETrwAvPfeu9lyIxD+P3dgHCVjxbEq8t4=;
 b=DK5u165upBAcIAmBlbA/79evdmvE4tIGPT+G72iJdZCOXXDLjm3V7xsSH04hdUs/AhgdKzeuDDCrbBBRGGrVSDFvWSQ92zbVeYlu5IUVjnpYKfJLBVaOX11YbqMxriEM6t48yFe3EuizDZJE4pe87vE+7Jj3uUhbZD3G2q0sq8CZU9JPn8jNSQsuYZurkYq5AW5vPG2/N1xj7jBwiUE6MYcYYEB095/st4GcSR9g7Mi0uL2CfDjO60gNzIB79t8FkvDbFOURmg0y3WruYPUudFZso/nS6Dwg+gnENgKJzMgbAsCIfGKgFf5VtIPtv1nMuvE2ymqXyYmilj7w9ZkCTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EdIUYc+1VOETrwAvPfeu9lyIxD+P3dgHCVjxbEq8t4=;
 b=smEg+zLEyifAV7FN6YtPDdu7jGbbTWXx5ZMQ8+bJEIvia3kxU8m+fmfVncr+aZlEgR5c6jIB4ZQTHVFVP1oGQVZdXD8sHMjNWR86tcDFAB1TxSsXGZ2D553L6RUBLLDbPF4LN4pMIs/HOV/Dg564COLOrrtsivtSZ5Q1u8TzcFM/o8ppO9o2lkM4Z+xjSKauNxkf5pEYMqmOsN343pC+igqAbuyUjiJebef+zKKfzdI7N9LjeRN00FaKVpn0taCPom+rYJca2mH+ITUG/x5wEKdQG499iPNsIB0Aadv2Gh59amM7/gsLz2GqIuKK0puGZ2jKdQfHbS+aGZPN9itmeg==
Received: from DM6PR03CA0011.namprd03.prod.outlook.com (2603:10b6:5:40::24) by
 PH7PR12MB7281.namprd12.prod.outlook.com (2603:10b6:510:208::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.22; Mon, 24 Apr 2023 13:15:02 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::64) by DM6PR03CA0011.outlook.office365.com
 (2603:10b6:5:40::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Mon, 24 Apr 2023 13:15:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.19 via Frontend Transport; Mon, 24 Apr 2023 13:15:02 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 24 Apr 2023
 06:14:53 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 24 Apr
 2023 06:14:53 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 24 Apr 2023 06:14:47 -0700
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
Subject: [Patch v7 3/8] memory: tegra: add software mc clients in Tegra234
Date:   Mon, 24 Apr 2023 18:43:32 +0530
Message-ID: <20230424131337.20151-4-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230424131337.20151-1-sumitg@nvidia.com>
References: <20230424131337.20151-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT038:EE_|PH7PR12MB7281:EE_
X-MS-Office365-Filtering-Correlation-Id: 42f0c54f-0664-41ff-6aae-08db44c5e9aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +OHLsL1zHmB7wmjTKRpeEHQEkOQbxG6bCu7Pxd+/rg4ghQHVZDVhQzlMqQTz6jM1XXx/ZAFv1s1KBzPbqWcJDaQqI4vfh8gR2CqsVJ0YWSkyhmlMRw60YzPAgD+ioj/VLXV67rJ91Uw++hcnU5fPv8SsG1SuMukK2I1J0y0Tw0FHFCgZAeZslGZLMH/wwt8HtwtjWwxhj/X430H5qegEKx6Jl6KF5DzpzrKi0Pi5HM53d3c2D7cIfyZurb83bFsPWm5JeeyXKIDaTi4SGPXxgHLvEmV6hPMCkhFJ5c+TVptqzOUdQYe4aX9TEuUi1Zp5q1biwzU9hIdjrycwTGmhhVh2KvTjX0SnBMFLCsOTPuNPeEoaTexG1AEdC6xKkOTqYskvuKaw/hdENcQvOQennsUBZTO+RWYB3Q5yWPQbnOj+BpmpncXlwzdUsFwswo7YQaWq8FvpUyt2bs6tzJYFQlevDZEgyQC3ix5deftKkBRyu6zeOGA0NqKUOPGK2bRRgiX1qSkH7U50puB8/DuImCCsX2gw8Yv7EirG8JGn+kBMNGjQoYD3n82lG9dwKXJM1+cWKFlqwksd8Ffe9AGMWa1Jh2pYkY0JZhjk/ImZJWSCe2pJq5pQbS7FJ//jiqArJq9kq4Sjz6zZEGRisZ9yCOR/TMNvZGJfNQfync8lxnkdUHQHZZw1OIoF8PQ+HBishc3UpNMW/sIfED2dV7xklOODeYuDpZ5hx1Lz+0JVdV4=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199021)(36840700001)(46966006)(40470700004)(107886003)(4326008)(70586007)(40460700003)(70206006)(316002)(40480700001)(110136005)(7696005)(6666004)(86362001)(54906003)(82310400005)(478600001)(34020700004)(5660300002)(36756003)(7416002)(2616005)(8676002)(8936002)(356005)(7636003)(82740400003)(83380400001)(2906002)(47076005)(336012)(426003)(36860700001)(41300700001)(1076003)(186003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 13:15:02.1156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f0c54f-0664-41ff-6aae-08db44c5e9aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7281
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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

