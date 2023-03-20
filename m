Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB396C1FCD
	for <lists+linux-pci@lfdr.de>; Mon, 20 Mar 2023 19:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjCTSeL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Mar 2023 14:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjCTSdx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2023 14:33:53 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20611.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::611])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B22A37B76;
        Mon, 20 Mar 2023 11:26:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btyrvy2TxoeJDpjwLAJtGFSSgbGyHtr8HQczImxn7l7OSfPoXu/GmY52EEzdmYiypqgTZYPTtw14pY4/9IGdO52bgcjFx+Cnfw7nvVNDOKSLlIKG4MSjGCG+xpsDxzYTpVPP7R8c48aEGy/sc//ltvqnAm0jZcK31ZFTkmz6Ux2YJX+KsZ/e+HjwEqjZervPQ+H1oAX2UQKlKKHXs470ALrbj0t2ZvK/YDivq/gk6xDqfRfQh84o9VGJIzOY7upiJ8zIrK1y8jdibLy5qJOM7OkVfGWOsG4RYNyJm5Wvaqa6ZB/kA9ozy5WFntFEKjAcFlRoN/klGzVIn4EBpuMsGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HewRol2vw9rvVIfTdmYVBC/1mQMXSvdHNc/fD3rnGM=;
 b=huecutLzswikLy0Po1OD2PAh+Ty4Yg7rHFtQbyrVLyaAOof3a19suZ621aef5147kYr7EjBMLwrd03FEXRnNWuzgHJM5qsA0eG5/Smt+eQ6zeQhfYWSulBydC8sZdH+fli2EPwt+KsNhZEVTpXgpy02PNOyF+YgbwqhTuWbJp3crSiw62b3Fc+sf/+PZlfDCtpWSgzEEtLBTLmI5qye/MRy2oIu/SUz6KyMfXi0FBe7Vg9kGzjyHFhqsJ0C3+itKGSRgIFxRRKlcPj8VSGQYqlEWh2FIOLad7ZPKfS2jrE0PN+ySWK3ck+c7Ym1R5UC/tNGeRv4FvBgWrBoYnXkUOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HewRol2vw9rvVIfTdmYVBC/1mQMXSvdHNc/fD3rnGM=;
 b=VO4kZJjnQ9er8s1YeHChuyw4riQj5/eMyItoZgPAmamPAF8KS6M6ykn01LnXvn0GkzQc0bi3IG1fOhyiVSqhFLD2z0HdgNubgcAuSWaaPOUN8v7qDrEBquZe887OtEKqcXkncBHPqFlZwIiWAd43D4TSX/Z5ZiRnVhFxJ4tjI6XzSCI+HXxxQWWmoDxlHQBbMHCcHyLt7YIemJ9RSpMZVEVaIxFQt+fShRBJVAvWo2KbfMXQGfOOPHByvOCS4mmj0kUgHXRCcofgXOmVeFu4CoPSbfE2uVvSZFHG+t52dMPFNuXoFZ/1PyKWKD88mHbJlTaVyYE8jOxiWEiJI5szYA==
Received: from MW4P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::12)
 by SA1PR12MB8986.namprd12.prod.outlook.com (2603:10b6:806:375::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 18:25:34 +0000
Received: from CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::fe) by MW4P223CA0007.outlook.office365.com
 (2603:10b6:303:80::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 18:25:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT112.mail.protection.outlook.com (10.13.174.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.16 via Frontend Transport; Mon, 20 Mar 2023 18:25:34 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 20 Mar 2023
 11:25:31 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 20 Mar 2023 11:25:30 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Mon, 20 Mar 2023 11:25:25 -0700
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
Subject: [Patch v3 03/11] memory: tegra: add mc clients for Tegra234
Date:   Mon, 20 Mar 2023 23:54:33 +0530
Message-ID: <20230320182441.11904-4-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230320182441.11904-1-sumitg@nvidia.com>
References: <20230320182441.11904-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT112:EE_|SA1PR12MB8986:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ff521ef-2109-496c-029c-08db29707ef0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ux2b5Ws2vvUBnD5B6iKpGOVN9euXgrN1AZt9+dALTH+UmlszAKiBoCLHQW3zjSOeY9wTMzLBZC5BeVAVUH1STjgGpLyKaOO+rml8HDY46KK0IjbSitAFIeeHRIh5HrCkHPRSf6P+IALbX6XYAIF/zpHezDTC1oGCL57K49bSR8LYwT8Y4CsOTgSTIm69N4eFu3j+P7c3jIdVeb2s/fVIDojtzeK3Fjv5WMpgLPVvD2oSZDIzvHNMNwDZqAoedJl4pszs7agvbI3m8H/J7B4pce53Ql5GRmMeiEC9sXC7ARZz0haUggORTZbBkWMItOdp3WxRvPRb87Rpc/QkviSS8xIYhUAhJrPrTnJpNeR5QoTsLyAGVHx8mw6ec+ZJInBXsaaK+oWR49YzqG7eybi1u6bcwlS2Nb8jKqgJRUFic3NwB7q8FQkJhcOjsW0EopNZ9lvFJAAndkRSGDS50ai1Sl1qMWU/JejlYreBMabSTDpfoi8NeCO1QefouU8/N8VEATRfR44Z8jZ+Ha3KLPSdzMKzRhkfSE/lpPYixC8K1qWKjDxpjipKPJd+EWlkAVj4kl3nhNFz8V3JdJUddvj01Z73nmaOJjqxrEm9vRv/cihuBi5IWHWY1AdphAgbgPCJh6BfHjvD+PpDgW2KJuYByWwTX4aGM15ggSV2VsWUoFjtj5Wlz8dO9MZS2/Yw0sn7cvsrGAzR7hJ+FK/JUGm1LwZXYnO9zfcQJE0ONW7AJ7y5aNPlw6XfMrIArfFIM+7A
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199018)(40470700004)(46966006)(36840700001)(2906002)(82740400003)(7636003)(356005)(40480700001)(40460700003)(47076005)(7696005)(426003)(478600001)(83380400001)(186003)(86362001)(36756003)(82310400005)(110136005)(6666004)(2616005)(316002)(41300700001)(54906003)(70206006)(4326008)(8676002)(5660300002)(70586007)(107886003)(336012)(26005)(1076003)(8936002)(7416002)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 18:25:34.4854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff521ef-2109-496c-029c-08db29707ef0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8986
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add few Isochronous (ISO) and Non-ISO MC clients.
ISO clients have guaranteed bandwidth requirement.
PCIE clients added to the mc_clients table represent
each controller in Tegra234.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/tegra/tegra234.c | 420 ++++++++++++++++++++++++++++++++
 1 file changed, 420 insertions(+)

diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
index b40229926558..7ca744036f59 100644
--- a/drivers/memory/tegra/tegra234.c
+++ b/drivers/memory/tegra/tegra234.c
@@ -15,6 +15,30 @@
 
 static const struct tegra_mc_client tegra234_mc_clients[] = {
 	{
+		.id = TEGRA234_MEMORY_CLIENT_HDAR,
+		.name = "hdar",
+		.bpmp_id = TEGRA_ICC_BPMP_HDA,
+		.type = TEGRA_ICC_ISO_AUDIO,
+		.sid = TEGRA234_SID_HDA,
+		.regs = {
+			.sid = {
+				.override = 0xa8,
+				.security = 0xac,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_HDAW,
+		.name = "hdaw",
+		.bpmp_id = TEGRA_ICC_BPMP_HDA,
+		.type = TEGRA_ICC_ISO_AUDIO,
+		.sid = TEGRA234_SID_HDA,
+		.regs = {
+			.sid = {
+				.override = 0x1a8,
+				.security = 0x1ac,
+			},
+		},
+	}, {
 		.id = TEGRA234_MEMORY_CLIENT_MGBEARD,
 		.name = "mgbeard",
 		.bpmp_id = TEGRA_ICC_BPMP_EQOS,
@@ -134,6 +158,90 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 				.security = 0x33c,
 			},
 		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_VI2W,
+		.name = "vi2w",
+		.bpmp_id = TEGRA_ICC_BPMP_VI2,
+		.type = TEGRA_ICC_ISO_VI,
+		.sid = TEGRA234_SID_ISO_VI2,
+		.regs = {
+			.sid = {
+				.override = 0x380,
+				.security = 0x384,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_VI2FALR,
+		.name = "vi2falr",
+		.bpmp_id = TEGRA_ICC_BPMP_VI2FAL,
+		.type = TEGRA_ICC_ISO_VIFAL,
+		.sid = TEGRA234_SID_ISO_VI2FALC,
+		.regs = {
+			.sid = {
+				.override = 0x388,
+				.security = 0x38c,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_VI2FALW,
+		.name = "vi2falw",
+		.bpmp_id = TEGRA_ICC_BPMP_VI2FAL,
+		.type = TEGRA_ICC_ISO_VIFAL,
+		.sid = TEGRA234_SID_ISO_VI2FALC,
+		.regs = {
+			.sid = {
+				.override = 0x3e0,
+				.security = 0x3e4,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_APER,
+		.name = "aper",
+		.bpmp_id = TEGRA_ICC_BPMP_APE,
+		.type = TEGRA_ICC_ISO_AUDIO,
+		.sid = TEGRA234_SID_APE,
+		.regs = {
+			.sid = {
+				.override = 0x3d0,
+				.security = 0x3d4,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_APEW,
+		.name = "apew",
+		.bpmp_id = TEGRA_ICC_BPMP_APE,
+		.type = TEGRA_ICC_ISO_AUDIO,
+		.sid = TEGRA234_SID_APE,
+		.regs = {
+			.sid = {
+				.override = 0x3d8,
+				.security = 0x3dc,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_NVDISPLAYR,
+		.name = "nvdisplayr",
+		.bpmp_id = TEGRA_ICC_BPMP_DISPLAY,
+		.type = TEGRA_ICC_ISO_DISPLAY,
+		.sid = TEGRA234_SID_ISO_NVDISPLAY,
+		.regs = {
+			.sid = {
+				.override = 0x490,
+				.security = 0x494,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_NVDISPLAYR1,
+		.name = "nvdisplayr1",
+		.bpmp_id = TEGRA_ICC_BPMP_DISPLAY,
+		.type = TEGRA_ICC_ISO_DISPLAY,
+		.sid = TEGRA234_SID_ISO_NVDISPLAY,
+		.regs = {
+			.sid = {
+				.override = 0x508,
+				.security = 0x50c,
+			},
+		},
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_BPMPR,
 		.name = "bpmpr",
@@ -358,6 +466,318 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 				.security = 0x37c,
 			},
 		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_PCIE0R,
+		.name = "pcie0r",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_0,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_PCIE0,
+		.regs = {
+			.sid = {
+				.override = 0x6c0,
+				.security = 0x6c4,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_PCIE0W,
+		.name = "pcie0w",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_0,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_PCIE0,
+		.regs = {
+			.sid = {
+				.override = 0x6c8,
+				.security = 0x6cc,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_PCIE1R,
+		.name = "pcie1r",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_1,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_PCIE1,
+		.regs = {
+			.sid = {
+				.override = 0x6d0,
+				.security = 0x6d4,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_PCIE1W,
+		.name = "pcie1w",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_1,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_PCIE1,
+		.regs = {
+			.sid = {
+				.override = 0x6d8,
+				.security = 0x6dc,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_PCIE2AR,
+		.name = "pcie2ar",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_2,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_PCIE2,
+		.regs = {
+			.sid = {
+				.override = 0x6e0,
+				.security = 0x6e4,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_PCIE2AW,
+		.name = "pcie2aw",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_2,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_PCIE2,
+		.regs = {
+			.sid = {
+				.override = 0x6e8,
+				.security = 0x6ec,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_PCIE3R,
+		.name = "pcie3r",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_3,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_PCIE3,
+		.regs = {
+			.sid = {
+				.override = 0x6f0,
+				.security = 0x6f4,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_PCIE3W,
+		.name = "pcie3w",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_3,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_PCIE3,
+		.regs = {
+			.sid = {
+				.override = 0x6f8,
+				.security = 0x6fc,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_PCIE4R,
+		.name = "pcie4r",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_4,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_PCIE4,
+		.regs = {
+			.sid = {
+				.override = 0x700,
+				.security = 0x704,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_PCIE4W,
+		.name = "pcie4w",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_4,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_PCIE4,
+		.regs = {
+			.sid = {
+				.override = 0x708,
+				.security = 0x70c,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_PCIE5R,
+		.name = "pcie5r",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_5,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_PCIE5,
+		.regs = {
+			.sid = {
+				.override = 0x710,
+				.security = 0x714,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_PCIE5W,
+		.name = "pcie5w",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_5,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_PCIE5,
+		.regs = {
+			.sid = {
+				.override = 0x718,
+				.security = 0x71c,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_PCIE5R1,
+		.name = "pcie5r1",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_5,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_PCIE5,
+		.regs = {
+			.sid = {
+				.override = 0x778,
+				.security = 0x77c,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_PCIE6AR,
+		.name = "pcie6ar",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_6,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_PCIE6,
+		.regs = {
+			.sid = {
+				.override = 0x140,
+				.security = 0x144,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_PCIE6AW,
+		.name = "pcie6aw",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_6,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_PCIE6,
+		.regs = {
+			.sid = {
+				.override = 0x148,
+				.security = 0x14c,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_PCIE6AR1,
+		.name = "pcie6ar1",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_6,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_PCIE6,
+		.regs = {
+			.sid = {
+				.override = 0x1e8,
+				.security = 0x1ec,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_PCIE7AR,
+		.name = "pcie7ar",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_7,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_PCIE7,
+		.regs = {
+			.sid = {
+				.override = 0x150,
+				.security = 0x154,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_PCIE7AW,
+		.name = "pcie7aw",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_7,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_PCIE7,
+		.regs = {
+			.sid = {
+				.override = 0x180,
+				.security = 0x184,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_PCIE7AR1,
+		.name = "pcie7ar1",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_7,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_PCIE7,
+		.regs = {
+			.sid = {
+				.override = 0x248,
+				.security = 0x24c,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_PCIE8AR,
+		.name = "pcie8ar",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_8,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_PCIE8,
+		.regs = {
+			.sid = {
+				.override = 0x190,
+				.security = 0x194,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_PCIE8AW,
+		.name = "pcie8aw",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_8,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_PCIE8,
+		.regs = {
+			.sid = {
+				.override = 0x1d8,
+				.security = 0x1dc,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_PCIE9AR,
+		.name = "pcie9ar",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_9,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_PCIE9,
+		.regs = {
+			.sid = {
+				.override = 0x1e0,
+				.security = 0x1e4,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_PCIE9AW,
+		.name = "pcie9aw",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_9,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_PCIE9,
+		.regs = {
+			.sid = {
+				.override = 0x1f0,
+				.security = 0x1f4,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_PCIE10AR,
+		.name = "pcie10ar",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_10,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_PCIE10,
+		.regs = {
+			.sid = {
+				.override = 0x1f8,
+				.security = 0x1fc,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_PCIE10AW,
+		.name = "pcie10aw",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_10,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_PCIE10,
+		.regs = {
+			.sid = {
+				.override = 0x200,
+				.security = 0x204,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_PCIE10AR1,
+		.name = "pcie10ar1",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_10,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_PCIE10,
+		.regs = {
+			.sid = {
+				.override = 0x240,
+				.security = 0x244,
+			},
+		},
 	},
 };
 
-- 
2.17.1

