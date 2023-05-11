Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3ED6FF87A
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 19:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238836AbjEKRdL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 13:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238957AbjEKRdJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 13:33:09 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C01B40D7;
        Thu, 11 May 2023 10:32:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1HzLtfTQPonfmVkG+dHS22wsWi4xHZhHyetud7h1Bd9axo4C2YpnETfR+U7qbX4/JpsaagpQQQTWMB1skQ4ZgM+X4CICLdmhKvwREaXEwjbYxKjfZWjJHYDvl+CXgocs+QFbwwZDy0u2JSS/qmNhQ9EDXZBZUICDHrTZEB/Zxp7rLbdUdmefTNQV2X4ErdoCFaunnRIUtjaWKaTLc1Jx9AImt6O+Acq7AYsF+lSwC2Sc1RIbtHPWm2CIAHHxtxsjnGE/6GdT2ZKToNkzLkg/kh1dJCoazDrKPkUte6dr0miqH5hqaIjwXQ3KWaNQkRuRwtKNgAb22RrkzrPNe8ASA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhgReHO1FfoBnbzv/xVid+jBNy3/apmmv5LJoVhD/sw=;
 b=WAl9A4Bss4atwC1vXjSBIDgwxrEe8zVl5tmYQEutvEBHjN4ZqYCHbakJxCG9Ltm8G8YtgNGnodVKgWdE3jNl8lgYYwoZkJfH2WU86t+j8YPBb7Y6erR7oacB7RNH79QO6NTeHVWkLBSk6Z5OQAXn/mQNDh2gf3VLS1kdnw3nGAwPn1Ihiv6tXXcCXXo66BI/OCiaVIdveW0TqKSzRahNHE+6Qt9ie5hpQWwjADC4OjweuhpMwLA9/xq85XXnz/To72ntmNvgo0I3tEAjdibSxEdvBeQ/mrWP3umUHDYd5dbQUF10W1z4pyhlxt1UDBTg+0Aa1O4ZnD11aNvGb0AOBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhgReHO1FfoBnbzv/xVid+jBNy3/apmmv5LJoVhD/sw=;
 b=sgr7GAoBZnbDQgmxfAWaN9CIJ4T4H7xnzOx1QkeDUW6fVGA+hTKlejJ5DK/9K0b1nRdjZPg+Tg35ODZG9q7fTy0xIf8+DRsturJCKuUl2JC0OnqJIcaLM6USEOrrPJ98SnUeM2oxjQcfn4ZwU5BQGizGYWBhDu1NRrtbYq3GWNGaikXGMF/Sroa296L8oD2j9gySqSRA4eVtzHzNkgTH+HBzE1VHGrQ+KnIn5exJhTYG+By7984IMkK3/7wI3TbpTs7d+ik8VCNBo6GtzQ0kPqIbqfAeb+j+L5aWwlt+87aJeD1sCfaNmwXRLXGhtKyx8Nh+WNn79mXt4GpXIiNawQ==
Received: from DS7PR05CA0004.namprd05.prod.outlook.com (2603:10b6:5:3b9::9) by
 CH2PR12MB4248.namprd12.prod.outlook.com (2603:10b6:610:7a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.33; Thu, 11 May 2023 17:32:56 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::24) by DS7PR05CA0004.outlook.office365.com
 (2603:10b6:5:3b9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Thu, 11 May 2023 17:32:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.20 via Frontend Transport; Thu, 11 May 2023 17:32:56 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 11 May 2023
 10:32:48 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 11 May 2023 10:32:47 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 11 May 2023 10:32:42 -0700
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
Subject: [Patch v8 2/8] memory: tegra: add mc clients for Tegra234
Date:   Thu, 11 May 2023 23:02:05 +0530
Message-ID: <20230511173211.9127-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230511173211.9127-1-sumitg@nvidia.com>
References: <20230511173211.9127-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT010:EE_|CH2PR12MB4248:EE_
X-MS-Office365-Filtering-Correlation-Id: d80982bd-ae6c-4be3-c20b-08db5245c1e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t9p93FqfcWdzO24OO2zbYI5VfQ3Vq/EzO8h09FaCerxB5hoXIZmVM5lXeG5ctXiwI/Wwm3otWSFAcI6Eu9rc2xhrr64wBWM+dF9q/1uex4v3+4LaMSmSIUMuw+GWCQf5qUnDu3fGaBec347Q+hTz7WbLEiPu+y72NttLoClLYJABFNZJxDLAG5sUKsaV5G+aZVW0b4idx7Br5dNK9ENzLVk2se1C0p/mEhrfmYFLUUqtHe2cL/6u41MkBvldBVcU09wqsMbBvzJgekPgA6haFzE3TRUcpEHUMGRa2Mm4DKeP7KRI12kG0+OxJJhRUFDC/+cvsTbJxBJtVvn+UUuoNP6gZ+QF7hF7WX4AGyGxg4jMOW6zpUEIMijkaSK35+mkl64VeIDSV33mkA0aMJbyHk6iRRC0SfgtL8wd5TibfEE/twU1SmM6y4LwxzmDt/Yfx0XMAe9mmQiGxXFIkI6XD9JpuycOc5niNaFSJ7TZN0hMMzJLUUaWBCT5SX1S5NgtTaEm0GifBHJTmFSjONjtJnohX5vmKyF7sT9tI9dPdP5ejZHWzxFe6UqOiUAeXH1zQfxGNo0+yrW1GfVuIJ7Gdd6IodibeL9UPflWKu/MRb8pq+x6BugKr+17kLKPH4LmweI6Bgu3EcOB7Ye0YGo7I07zIdNc7v5EoqU0hn3DhVTYJRrbE39f8qdhu12WOmDdCes2pHaTzNGZpUwttgJ3PA==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(83380400001)(6666004)(316002)(41300700001)(336012)(2906002)(186003)(426003)(47076005)(110136005)(70586007)(36860700001)(4326008)(54906003)(2616005)(70206006)(7416002)(8676002)(5660300002)(1076003)(26005)(107886003)(7696005)(8936002)(40480700001)(478600001)(82310400005)(356005)(82740400003)(86362001)(7636003)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 17:32:56.0775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d80982bd-ae6c-4be3-c20b-08db5245c1e5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4248
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
index 56d911926d54..a4ea181e1090 100644
--- a/drivers/memory/tegra/tegra234.c
+++ b/drivers/memory/tegra/tegra234.c
@@ -14,6 +14,30 @@
 
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
@@ -133,6 +157,90 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
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
@@ -357,6 +465,318 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
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

