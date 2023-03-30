Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE6A6D06E6
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 15:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjC3NfP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Mar 2023 09:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjC3NfL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2023 09:35:11 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42536B74F;
        Thu, 30 Mar 2023 06:34:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcEXC/VkPmPRokieMe5ZhfM/LVcMmm76+qvG61AMmNFnDI7EYb1R7w5Ev/dQrQuNiXu2oJ0rTlwi7vpFGZUGwncIpbXrtr9KHMpAOfJWLQkhQKaYWlweX/OEPJedNZ9JaE4L6IWmBA/SgJSQyFaFEgFb6WTpc55QBr1v14jmbFlQk9dSSHVm/Hg2YWTf/78wmBAqnr/QiBi9kpwiz6yuWW/OlUSbKGOZPkOHVxHgb3LTITuIWIyT+OmeHLQ7P5jk1teT9Z5TZxhutW53TisG4Vugf78Z+xo0B2Q5Bwg37jc/YK++W64WDGGGTuerSq+z8vLp/MT/U5AIKRbnCS7mkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhgReHO1FfoBnbzv/xVid+jBNy3/apmmv5LJoVhD/sw=;
 b=X7QJgm8vaujgZqSExhTKVmpq7g7eLgDAeViLSC60Jhg+StTNB4+NsiwDWlkmvEfDdQvtmWJgHz2CYmDls74OYiKcDAWBdFcGaSpH/Ymexu7UQQ6unPwmuSygEsluDXsGbsgPTKn8H5f0WpKnFwst7UhSvSo7odlFwoYgPaT091A4N0fgxRq/jIdI7+l+xQ9CzpjLeixqka2Q1fm9z1FZ67Pdu2wATEechUDVUxCoplWjArjBk5Ge8YagvhB9mGc/tdyYnvO0k0enXv7W6/sXtqMpGs/QoVEnL6+wu1iylNupN4xQ7a7mFP9OM7UMTUqQ7VcrrXJ85ye4HSUhU/UCeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhgReHO1FfoBnbzv/xVid+jBNy3/apmmv5LJoVhD/sw=;
 b=qzWQczEb6EslRvPwMIr5eqW4+/JQedHurNYSr4kzV0SkIuJBLMwu+g/HM8UYNsIFHA3B6sw6p4tv7HCc0elJN5Da0pp6DMZKeGiZmhUdTB1Uad7+SblBDagG1yvQ+uk/iK9EguewLXPxqrq35Uf4ywLiSQjuW25AxQQPY/x+pmV0ruHzynjIcB2f5XnPC7NqiknPl5Aa5aGL4sj28LNGjFSvOEL3UtLTsxK6mgVMRlYu2VB5jJRwdOtDiAyw0cPbBGl/e1Ow6UCsZYrbVQjcLBab6wTMPFKbubT9TfmYB8lrNCdPMPrIfrtAFAOcRcOYk9KXTAlbpbN+EIzZhvAEEw==
Received: from MN2PR16CA0030.namprd16.prod.outlook.com (2603:10b6:208:134::43)
 by IA0PR12MB7698.namprd12.prod.outlook.com (2603:10b6:208:432::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 13:34:47 +0000
Received: from BL02EPF000100D1.namprd05.prod.outlook.com
 (2603:10b6:208:134:cafe::42) by MN2PR16CA0030.outlook.office365.com
 (2603:10b6:208:134::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 13:34:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF000100D1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 13:34:47 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 30 Mar 2023
 06:34:39 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 30 Mar 2023 06:34:39 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 30 Mar 2023 06:34:33 -0700
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
Subject: [Patch v5 2/8] memory: tegra: add mc clients for Tegra234
Date:   Thu, 30 Mar 2023 19:03:48 +0530
Message-ID: <20230330133354.714-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230330133354.714-1-sumitg@nvidia.com>
References: <20230330133354.714-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D1:EE_|IA0PR12MB7698:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b132901-882d-4027-06eb-08db3123880b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NCIHxfq6uwuIQFD2Il99i/B+oV27r2ge3n2dGSWEHFh0vB+OY+yQoYmFNChxB0VYm/Ad/xF2i+Dztgi10jVjUXhS1t0EybbIqEIE9XIplUeeEh8CCm04tEneygxKdMBXFEGM/rAIZQLj4oEIcmkJT0auAFkNWpHuudcQc/1wWEC1ZXW6uFrVDaXFfjZy9moPkW2nX2BKYnZF79/5ZK8AgGBFwdIxN+GfZxlryT8VBXOty4XJwNFlJHpUGD+vWZN/8j3ayaSNXQf1hErEHG93GvP7qFRli+VcrGXQRYPRZu51zfZACJVP3TkYaTusqqj4FTJUTxGFj7FsgLn2hppiF1L+9nGcupMcgs0SG6hIz8KidVanKEMOX5115eGiz/nT168NgNvRnOPrKYf+k2VlGf/yiWHNlvgAZGjopFnl/YPH6TA5MbXZvYEq/GVFuWfS2rUUb9LwGQ9cO8A5lKPe9sCpzK6OK7xfH6iknq2jzLYf/+MhojIk7cBIilCrqlk43bDxqLj769yqcjSpo1AmckbEKamlfqRQGLR49606BFk4Vi2tJPLpK/rxYYk1METX1Ir3w20y8IbKPlYGo5aaarBV+jRyqFhh8pnwKKj2E18aThe+QTCBnVm0zLZzGaGdxtXqmWqUYxnQ+Xv45ueTRBDw/7PeayQNFk4ndfnlK8V2xsdFsAt6lbgI93OWneWNBjMBdSh3c4U+CPFHef8IcnTYrvORq4xUCczBFn7Utpzazg9D9ItIt08Nn8WYjv4N
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199021)(40470700004)(36840700001)(46966006)(47076005)(2616005)(336012)(426003)(83380400001)(36860700001)(316002)(7696005)(478600001)(186003)(107886003)(110136005)(6666004)(26005)(1076003)(54906003)(2906002)(5660300002)(82310400005)(7416002)(8936002)(36756003)(356005)(4326008)(70586007)(7636003)(40460700003)(70206006)(82740400003)(8676002)(41300700001)(40480700001)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 13:34:47.7222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b132901-882d-4027-06eb-08db3123880b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7698
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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

