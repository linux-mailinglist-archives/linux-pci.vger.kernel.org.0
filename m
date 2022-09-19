Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F264B5BCEF5
	for <lists+linux-pci@lfdr.de>; Mon, 19 Sep 2022 16:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiISOeI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 10:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiISOeH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 10:34:07 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7654511149;
        Mon, 19 Sep 2022 07:34:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6Q5ZEomis0SR9VuI9u2CscNAMenwEdSmPEvRyDU6Ixw76Oo1YDD07WAqHIphe56gFZvXMELJVvYBrAtBS9LsTTznvC/qMFHVDekRKKWmro8AmdgWUEFIfnt92QzFVO1wSmv/dkPMxntlTlquMBtG62bYZLXQpPG6U7gdTS3jErOIeTmSNy+I3Zewzu0FITgVc7wzWKv63oEiJh9CSyeq7aqcdf6JI7xRpslWni1hfVBldrPF58wqNR8zZfxARDhAIPd65gWXKL2JkOwhh8Wb8JsrU5HgC07tRDG7g+G2VMuz3iQmm0fWj0R/mWqDGElsUx5lAsInHElFmN/WA94nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGER80qGocTVUkkqmZoj+WQN+e4G5ZFC8R+hUXPUq4I=;
 b=AHF62yoOfRzVo3RIWQ4bEe+oEsxZ9OpnH+OS2qEeEsgEu2bcJSAZrDPthNpn2nmDaoUL5cXSpwAbl+B8K9zsij/jl1mIzWP2X2wV4kjlsmM5glB1FaFBfNRRSkGYM+UoT/8ydSI4InjNEklh8zY9qd7T+UabzuyJioTmR3IZQTQG8oDK0L+dDgQLTz2FEl9E3VGzGVJzXp4xsBOvpqTkr7EpVOQy4bDM0VKqa2CYaEC9SLzl/WyLDQyPM5UAp6q105qjvanvhnoB4VPyk5rKcpjg/hwrCNmZ0+Gnzwul1YMlCMXloHuJW7g0xZvPkxFZyAQ5aTuilkHtV1XsCC6VWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGER80qGocTVUkkqmZoj+WQN+e4G5ZFC8R+hUXPUq4I=;
 b=MU4aaKvtIAydaVvqkEac4tMsZueWJJ+V4Rm1uuwfCmLuqnULTF4wSLsLzZzt+nimeLoAZIOzvJEKSioncS+zyYMyYLE9KluT+3UnJfyj2mQs9HMXfVyRp1LTIBdgm/CPhBldttx5aA/00WtvSFayQ9ZKIZLaXRqScVOkJ90mMvQuY2f8+yCj3BFj0JyOAHYuaewow5KIxnEDFyqph0vMKuXFlye6JDuGf397s1CMsRbmwsT7FnBtyMI7j0tEKCb74kTFyo8Ocdta2HVCCmg0YMEpiVaiEr1/6A4D4Dw4OUnNsgriXpjlK7QpnWNdlrZRih32ZZmPV0iaIu6YaVSn4A==
Received: from CY5PR16CA0028.namprd16.prod.outlook.com (2603:10b6:930:10::25)
 by CY5PR12MB6549.namprd12.prod.outlook.com (2603:10b6:930:43::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Mon, 19 Sep
 2022 14:34:05 +0000
Received: from CY4PEPF0000B8ED.namprd05.prod.outlook.com
 (2603:10b6:930:10:cafe::4e) by CY5PR16CA0028.outlook.office365.com
 (2603:10b6:930:10::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Mon, 19 Sep 2022 14:34:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000B8ED.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.11 via Frontend Transport; Mon, 19 Sep 2022 14:34:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 19 Sep
 2022 07:33:50 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 19 Sep
 2022 07:33:50 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 19 Sep 2022 07:33:47 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V1 1/2] PCI: Add PCI_PTM_CAP_RES macro
Date:   Mon, 19 Sep 2022 20:03:39 +0530
Message-ID: <20220919143340.4527-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220919143340.4527-1-vidyas@nvidia.com>
References: <20220919143340.4527-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8ED:EE_|CY5PR12MB6549:EE_
X-MS-Office365-Filtering-Correlation-Id: 32975a4c-71de-422f-d92a-08da9a4c00ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5FI8tE5yd7FsWxEok5YUnW7/HRmpbGSpK6MkpmVojSbcHE1f5ijXRxRJd1Zoye0WrqyE4lxQvRJy13fDaGFYBBZRIYc91t9eYiEp4erbkkF+NYUlwfKhgqRnbolC84oT5tGCSenrTYf/ToqSCSwvcgW81ZRs4V+mdStlTodsVqI02qTc+Ksa2OtP9VXUVPoV01mAOjqX6ZN1sG1xWinCGoCJZyUcBeP33/tSaNtxJtRewc5AwAza+4bAD9UjqZlDLhaNQzCFkNXHyXatDOgaPClbEicW5hRTljRBJbEx7ADMQw4hUvrf1D05jmneggAPYfYJOP3TT2Z32zayOA2xkHy6BWNL0Mgict7l6B1SfmgmkXypHh5Y3B9nwMA1XHQGXvPWdq1MP/3iakzRJ/OlB4hbVzdjiggqpYRKS3O1XpDjXsz2ViKYNpUmKFxQAsCrd94piQvWVzDmizWGbYcuJPQnwSo5pxE+GmsWsve+T77dg5uwoQtOmnWdXtOLmSXQjosVRqcfZI5zpRGrlxEcaiTNTBFivwsGIOzGdV9udI74T7T7Wp4yOsNZeSHAmnsuzoWqYzeU1iMCZ8T5IRXk+KjtM7u3tsE07DJtqQzkHlCt+KSfwv7L0JD6FJQ8l9CkaT3PmauuISK2hpDsGPpiekK8qxHJvgmO46nNxdrCbIrLsBbkg8SEDKQwrh7cjJwBgR7EUVptb/KdEHA5qXfmQTO2Rgh3UC6yRnfM/N4C7TDsZyqdpk7rkYrCLa+hRFQB45GShKAblXf+gkdui323wg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199015)(46966006)(36840700001)(40470700004)(8936002)(5660300002)(47076005)(26005)(70206006)(4326008)(8676002)(2616005)(36860700001)(70586007)(83380400001)(41300700001)(40460700003)(36756003)(316002)(478600001)(7696005)(336012)(6666004)(426003)(40480700001)(86362001)(4744005)(2906002)(110136005)(54906003)(356005)(82740400003)(1076003)(82310400005)(186003)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 14:34:04.9097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32975a4c-71de-422f-d92a-08da9a4c00ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6549
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add macro defining Responder capable bit in Precision Time Measurement
capability register.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 include/uapi/linux/pci_regs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 57b8e2ffb1dd..1c3591c8e09e 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1058,6 +1058,7 @@
 /* Precision Time Measurement */
 #define PCI_PTM_CAP			0x04	    /* PTM Capability */
 #define  PCI_PTM_CAP_REQ		0x00000001  /* Requester capable */
+#define  PCI_PTM_CAP_RES		0x00000002  /* Responder capable */
 #define  PCI_PTM_CAP_ROOT		0x00000004  /* Root capable */
 #define  PCI_PTM_GRANULARITY_MASK	0x0000FF00  /* Clock granularity */
 #define PCI_PTM_CTRL			0x08	    /* PTM Control */
-- 
2.17.1

