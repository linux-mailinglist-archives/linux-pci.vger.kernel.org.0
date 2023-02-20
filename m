Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC3B69CEE5
	for <lists+linux-pci@lfdr.de>; Mon, 20 Feb 2023 15:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjBTOHn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Feb 2023 09:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjBTOHm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Feb 2023 09:07:42 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641DC1F5E5;
        Mon, 20 Feb 2023 06:07:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxCVXe/CQue1rsEazUNn4teiaEJEj0438tjcoBwC6wyuXo8/BCKaWDWHUIqKAMryNsW/tcDbA1lyVdJFjLqs56bFZSZ+eA1xKz/ycIt5jygqLmGSyJkirqJ24UqiwopIA20FIIsuhCMQHsTIabhrz6oEB3tJ5cDQjw9qYwtVfv9+FWNiyW3IkNhkc4I4mcCb8f0Sv6oup00DPJqBDVTBW84qWaT4HD4yF37PQTyE3HwejZBmfvUp4znYCYwQ8ld4nu3lo5biiOjCNi97e6AZTrsjwgKJZ0HIOl28YD4b+dPVb5bLI42A7EnTEbQw7pkXuQWlXYuMXa2cFTXZBoLU3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwYcOzJ5tvPT52fAzYcd/BY0zK5qKQql0mHQwEcfs7o=;
 b=UfYo9mQ9LQgTrYvD5gMKY0iygZV7U30XSdaAt76bikbTP+s3nVS8mjgZiD5axPw8TQl5lEBu7Ojv4XJOZpVFL+SJ5QTIw4M8TrY2JFCBlXD43oCIPDupdCHMwZ28fSnJxSqw3ZMnGzqMN1yURvNUa9AFMbzQK8x6O1hNEKu1RE0iLexW4l2n/N+Hqe5RYowzLYiom4Fr0RnnjbQJdIbuEmcRafPIwF2j+PKgewUbxKTXiTDxfDIcEonRCddwPPsc6b1nuHtdGG8A4EORcHz2+Bje9peTRKsYKvLk5GYAkyczXfSF4bggtjHR1gxel7SCgO5/TuZ9Ql7kC1xhfFY7Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwYcOzJ5tvPT52fAzYcd/BY0zK5qKQql0mHQwEcfs7o=;
 b=ZgHmC73aeIx407Tdr9HgXzHKG0uWfO4UFngVx4dR8lqww98x4CPfIanQzP4yOs00V5Mnr8aeG/BO7pQ6bDeQheKqA3/wxUzvxPCfEGT8CiiAPMWhf5MQrDV3Uz5BjtD7WN9n7wGVwUI6gDC8RdbbIjNPvqIcXamBW5gnIDppsYtb9nY/RY57w7XPWdCXLBgkxY8xObwicQ4RS2Mr/mLiYAcB4LiLGOkJv7w18kHKztzBSn38Fm27ccwkVY3JL3ppuJVxLRGndabvS3BAWCsUvY7M4JbhHZGMGypwpDnLBTPNbS2JgDV4G7mZt4+YqZFoMtdrF8D7prFK+MmovJz55g==
Received: from DS7PR03CA0197.namprd03.prod.outlook.com (2603:10b6:5:3b6::22)
 by CH0PR12MB5316.namprd12.prod.outlook.com (2603:10b6:610:d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Mon, 20 Feb
 2023 14:07:06 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::9b) by DS7PR03CA0197.outlook.office365.com
 (2603:10b6:5:3b6::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20 via Frontend
 Transport; Mon, 20 Feb 2023 14:07:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.20 via Frontend Transport; Mon, 20 Feb 2023 14:07:05 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 20 Feb
 2023 06:06:59 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 20 Feb
 2023 06:06:58 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Mon, 20 Feb 2023 06:06:52 -0800
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
Subject: [Patch v2 3/9] memory: tegra: add mc clients for Tegra234
Date:   Mon, 20 Feb 2023 19:35:53 +0530
Message-ID: <20230220140559.28289-4-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230220140559.28289-1-sumitg@nvidia.com>
References: <20230220140559.28289-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT022:EE_|CH0PR12MB5316:EE_
X-MS-Office365-Filtering-Correlation-Id: 96ba6528-9594-410b-07d0-08db134bbf8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jtzNpzmzxZtPonIIqJFKYjv1iXLwRVf8gi1P3ydP3EmNIeCh9BK7DnnWAaivsBhNpjR0Cbqkivrm45+0pbqDHAk8R5KFWWsmmmRCBofBUi6mqzUnA18+8R+IfhMYuK/Ic0OHhlBQMyP+SrNnuLiZAVqu1v5+PJUKqJSOh6q9ZdqywqxL0q0lJIK51FOwhVt6/kFN2ejAPcKY4HCoJVhnG2WnS5jmThjPXVhHsdYBOntqaMjMn1zmEuS2mGlU1gf1Oi6B+appOLGKiiqrVYNAisw08/EVqWDXKszRl9BkkTRMg7oyqzbLto0C6cgpDqmrycEgX0i3bq5uXhyPM/7LLdpTSpS3V27d2FMcXw4EMfXfMjakPAAKvfqbjZNWejrKNUCGFfbF6IV3Avg/j8XN4nB88mTbP8ReJ3OsD7TWaMvnxhDpGGgIK2xJ3l10eO4rC3CJU63yi3rYn5MNYJQQ/1EeY5h0jlctYfXh9UF8/grnKEFMvpYnTQly7MoBtLZXLSK9h70OLbYd5KOuW0/ncyZmgFXq/7+74I5gS6hWzBkzWsiEV5NjekzSR6blRRg6vJXemfY/QKkTjT/LPghH2fljpVefSWeHOrMAjU2b++EJeoryhRrep4aTFIVT41PW7jURmvvz616sZ+l2y9n1dbva95+di1EoHzGL3puefocZOwV5Kbk+wDcciodWJfzmr79waHOWNCJ51khQbiyqRw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199018)(36840700001)(46966006)(40470700004)(2906002)(186003)(26005)(41300700001)(356005)(82740400003)(107886003)(1076003)(7636003)(2616005)(7416002)(5660300002)(36860700001)(8936002)(478600001)(316002)(40460700003)(86362001)(70206006)(70586007)(8676002)(4326008)(336012)(82310400005)(7696005)(47076005)(40480700001)(426003)(36756003)(110136005)(83380400001)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 14:07:05.8529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ba6528-9594-410b-07d0-08db134bbf8b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5316
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

