Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D246DD895
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 13:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjDKLBd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 07:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjDKLBZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 07:01:25 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01981421B;
        Tue, 11 Apr 2023 04:01:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPAFaM29zOeuNQR5SbQXb4DRWD+2GU58snEQtoYW3bjXkdkQk0n08QXDm5we/E+jPEPoakFj3zgTk9CH/9NljXkYtLCsT8PIEIYmnzFLUziDe21MPtfmTjojD1JDIFKvimRUey5xT8Hl7/ADWqs85eZdijXhcuh7PoejN6rN4hbrUMQFCR4C8zh3ZG+xuANOAXvDjVm9IPATjhQmj5+5ztDlWEARuRenGuVH/p21syfrk7JbkuX4ye2shJdq6ZN2jhLZKzbrpZkez9Mj0LUKKAB4W9pAURdh8J9BZJmNfpUagbNWoWFgqmndM+X82/5PUBGu0X3CVZdOIANJS63fBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EdIUYc+1VOETrwAvPfeu9lyIxD+P3dgHCVjxbEq8t4=;
 b=Mi86mISZm4rxnL8KpxRs2Om2SP88Tod6TX/amH2GYsfF2OmYE4TqXn3cCvA1iYUN0Xz23javw/+Yxfo8/PAJhsir33X2VZsu4HU2HlRfHsdkfRAf7I8lJeRVM8vK5Cmx9nc+CYsVT/fPgVaP0ELAdjXH1jim+xNAk8poSi71OiGCyZSCgvKvhFstMF8+236fxh/XJ1LlaFYXtz/CISUgbGXLSFXNl50NroAmuCAyEe8A/O3pwqiTHyNrDPj0ctG/YP5TDdB0cVQBmgoJ8nFen793aTfdXuAlzmILZ/GMi4XNdiQw/YrM6/sYbejPzN8Zrb0mHWXkrb3XPU2kf2A8og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EdIUYc+1VOETrwAvPfeu9lyIxD+P3dgHCVjxbEq8t4=;
 b=sB04BYNPJEMgyV4MEYCaitPhB2jpopy/p6hQ+qZfeooPIRcJ8IJIFGytAAJQ1uj2I590kpfCYzs5AaJc9TEbY4G03A+c/MeDEeHZ/ODD59iWsRJ1g1rIgUeLw5hfZqEpFzN0O0o1rDuk7enLDLdnS9Oti8uZV3Iwsh31nKMlO9dzW4L/z3bC8wjBFBS0bFJC1/0JZ1vHoi57prjrEMcb8OMvQUPokAvfvsZMBacu+gEXYjsdZfgf9F/DfRPVpXCmytJs5u5+rUgmqh8rco23OBTNoTOumrCsIntVZT+vbgCd2lB1cJATbyl5noxk2fXXLL8CoI+YXV9rNKPK1yjYwA==
Received: from BN9PR03CA0190.namprd03.prod.outlook.com (2603:10b6:408:f9::15)
 by BY5PR12MB4129.namprd12.prod.outlook.com (2603:10b6:a03:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Tue, 11 Apr
 2023 11:01:08 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::c4) by BN9PR03CA0190.outlook.office365.com
 (2603:10b6:408:f9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.40 via Frontend
 Transport; Tue, 11 Apr 2023 11:01:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.28 via Frontend Transport; Tue, 11 Apr 2023 11:01:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 11 Apr 2023
 04:00:54 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 11 Apr
 2023 04:00:54 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 11 Apr 2023 04:00:48 -0700
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
Subject: [Patch v6 3/9] memory: tegra: add software mc clients in Tegra234
Date:   Tue, 11 Apr 2023 16:29:56 +0530
Message-ID: <20230411110002.19824-4-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230411110002.19824-1-sumitg@nvidia.com>
References: <20230411110002.19824-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT011:EE_|BY5PR12MB4129:EE_
X-MS-Office365-Filtering-Correlation-Id: 94e9d585-466d-407c-564f-08db3a7c0da4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gzw3z0WubcSeJ1/1qeJftWJRSJnouOKKTOZlEjYVR74HYwzAtuQ5wuuPDDo94oL8sYFl5l6nQYWgKrbnUyL6Kuh3F6orqQPyERGcgU0uObuyPJHYVbrXwYaORff7rkQuxHsl3+pRsYmNp6v9j9IYhCrQ/xPTlisPPDLE+WUPNPkSSuWzSEjh17aQZ4fmKLqlpic6lPOnsUIlT2XyvDrcqz47TJjygtK+mQV/TyLTJylRNEAXcJ+JqNwvhbrrdQdkQyemMVxGVxxGli+90y6UziGmaCMArj8BmAuHHy/cF7jjQbOvHvp8Mx+JHnFffe0JFSE8AMkK9DTPQ1KgiPYZ+krszYoBNwnmMCFQAT/WoIuCE+pSIaxjlyMMl0tsvlVbphsccA2DpwOnKRdkkHXwbQYK1Cpb134oz8MKOXxa9mP2VnchXTgU49dVxuDbeOuu+ecw/qSwoBr1DdLs2El+hcRo8Y8EcKDnm3l4AlH/YYUNij/1JNJVX8otKHiMw4C7PONHiFzCWL1SJf9dqDQ29QoE+ny4JjrED9s9Y29bwTdqoe/qJBgMFL4Ee9HRaYyCVHoaWUC4CR1N8UL4xra+LXa0+i+qZIC4su80fWm+wynS5VleCb6Y7xNpS9CuNiknYQWQ3CdStxhgvIs4dZDDMVJTEkzknF5T6gXIakQX+u8KCgEPPraZB0x/2lunGCwU7KpT3sIVUKzfL2MSh9ZUHlEvqY+PxAMJJft+EG2MA0EpTufBz7+dL6w+DRRhCkmR
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199021)(46966006)(40470700004)(36840700001)(7696005)(478600001)(40480700001)(86362001)(47076005)(36756003)(40460700003)(83380400001)(7636003)(356005)(82740400003)(426003)(2616005)(2906002)(316002)(110136005)(1076003)(336012)(36860700001)(54906003)(7416002)(26005)(186003)(107886003)(8676002)(8936002)(6666004)(5660300002)(41300700001)(82310400005)(4326008)(70586007)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 11:01:08.0099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e9d585-466d-407c-564f-08db3a7c0da4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4129
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

