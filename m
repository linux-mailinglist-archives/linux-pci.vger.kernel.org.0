Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4FA6C1FD9
	for <lists+linux-pci@lfdr.de>; Mon, 20 Mar 2023 19:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjCTSee (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Mar 2023 14:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjCTSeA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2023 14:34:00 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF584AFE1;
        Mon, 20 Mar 2023 11:26:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4z5dsAV4hihEw9XHeZw6dbiRf1rXEbCaiJPjvSTh0z92lwimMm8hz22v8Ydwq+mHcA8CGGuZmhWlnx+KAiunUgouJ/RaDwZW8UW7KmgQcmaE2s7x4mLIn0DkfOkuXVpYA9wrbT+BG42jyRYrkxUAk2md0tqyepMzxqMguJKNUHFxTgWoAQjKekDvCSpphXITer8kRKGIhaiuavt4x38lWv51t9JQ5Z9ijDkRlZAqvGEyRMxIE4YnBvdTEuvzD5pzvmyfJ6ZZ8b+4kM9KO3YHpOAnr+f+D0yrockbYzexBVmRGzkOlBPevfXUSxXq6GNfikDin2wXXbH8Ld510Xbsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EOLSj2IMC6AmgQP+x8WnAbrOd38Fq0L406q4vninRQ=;
 b=E3NCiZka0h6nArlSQXrsUVlX1NAdeXklFVryBBJRcfZZT04jjYnZQpdWp4aBwVMcySzqF76OSVmq0q9FuOZpeG7/JNcD70xThsz7yhEX9BakyrURE5NnqgRWkVlPqtAFcYs6lNXIgvDmB9X68GsM87j7rZJoHyUD/tZmWZ1vUSqRKGBHpY4Y8QAXdOa8bd4w1Dewll8wjY9RCK1+nug5CqhnZy7sWGcsASGA3abwr1itamLvhSXxGCofvaHd8WdcXo16bhLklJPnPkMMxZW/h8V0sX5pTRtGig/M2cLYvKL+VK29mBOexWk05ORmZxS4cOpsLPXc1etZ56BUF+ihvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EOLSj2IMC6AmgQP+x8WnAbrOd38Fq0L406q4vninRQ=;
 b=unI0W+bB6n3M9w/WRVbR0P6AOXgcD4eVrXDU4BjUMBXYBwXCLtmzGlyvWUJMCIEqnxcE0uyDLMPZ8ivqtEPVfr7BnsUSqWPAn/zblvxxJFUJsREw4XfIoar5dV/5W+TcVMbBNLCNXhJagFwzwzBH4UudkN5o2fpy9cccb1JGT1p1SQ+yybEV3w9GJcBklj7SIh+tMQ1PpQVB3rjh/o5IhdrIURmkXoUpQUT3rPhCr/DnQvQyCVQvlwq2aHs7uYkttSi8BgNcPnClkMEm2RyMwifEu09durT2issE/RtGb8s69UvHP+8RCBYO2xrjwSIchf4zg103V5TfmlaFuNEHng==
Received: from MW4PR03CA0116.namprd03.prod.outlook.com (2603:10b6:303:b7::31)
 by DM6PR12MB4186.namprd12.prod.outlook.com (2603:10b6:5:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 18:25:47 +0000
Received: from CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::46) by MW4PR03CA0116.outlook.office365.com
 (2603:10b6:303:b7::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 18:25:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT085.mail.protection.outlook.com (10.13.174.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.15 via Frontend Transport; Mon, 20 Mar 2023 18:25:47 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 20 Mar 2023
 11:25:46 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 20 Mar 2023 11:25:46 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Mon, 20 Mar 2023 11:25:41 -0700
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
Subject: [Patch v3 05/11] dt-bindings: tegra: add icc ids for dummy MC clients
Date:   Mon, 20 Mar 2023 23:54:35 +0530
Message-ID: <20230320182441.11904-6-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230320182441.11904-1-sumitg@nvidia.com>
References: <20230320182441.11904-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT085:EE_|DM6PR12MB4186:EE_
X-MS-Office365-Filtering-Correlation-Id: aad7287b-1ae3-420d-96e8-08db2970869d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TKv3wSuCicyBdvUiFIYQ7a6HEMv1m9wbSHVUQ3SgBDMeD1Th4ywa6CKnuto7SVBC/63hhzJQvoQuoLhvCXNE5hNjmla9fJw6VE/5lZlaCTUezhqdnVqEFAuw7tA6Cd83E2YNm/a0wA4/4iTTZ3qbaWNGq0RJVPK2HZGFONF4biqXThv8Tkozi8PjjZStJW8v1wExa/1UXLVenhLVtii8G/vnay1NvFQPmL3uAUo+UUG7dQn+CNjmsv+TPnQTYgM1WEcSAIf/FCCn2JZWxD+93tNqesRVg/UaTVZFkll466dNQ+YAzNpPgt0ebjuTgMUe1L9BjCMxUt2uKA50tYIEOv14YCwXjku1T87Sr6aMSJSxATrEHA2sikaC40KFA0E6ymdpvgEi5PrPbtLnvUDrE4O71IbXo+pz4vmU0ZNcZQi6nDrwbEO1li9p4GkAV4fUqQvXN9SOmLWIP5VXMuKGCy6Of1Pa6bKWDxfE0cVezvfJ5wtKqr0BjlcSj71KOaWPn/Af8AHk3qQFF/5viiMJmgnVYF+5KsgeVHwml2QDbWRN7PhL8pYa+k6iZpg/KOu2feqgZLkYoiyscK+2iECrA583X98ftMQrFZlBADKw6ShlTEMGVv6q82LpPQ9XTouonPUypgOrE0w1T3BfQUQa09xGMKq4dLhMouLh5tMU+phVv1QdkDnwgN5S5e+pGuLEUhLRRMAtE7ho6XThgdIIIrE57P7nIMLzjvCqj+bu18/F55HpyxKK+/sxyjKka+tJ
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199018)(40470700004)(46966006)(36840700001)(47076005)(2616005)(82310400005)(478600001)(426003)(316002)(54906003)(26005)(186003)(110136005)(6666004)(1076003)(7696005)(7416002)(107886003)(8936002)(356005)(7636003)(40460700003)(336012)(86362001)(36860700001)(2906002)(4744005)(70206006)(70586007)(5660300002)(4326008)(82740400003)(40480700001)(41300700001)(8676002)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 18:25:47.3670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aad7287b-1ae3-420d-96e8-08db2970869d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4186
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add ICC id's for dummy software clients representing CCPLEX clusters.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/dt-bindings/memory/tegra234-mc.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/dt-bindings/memory/tegra234-mc.h b/include/dt-bindings/memory/tegra234-mc.h
index 347e55e89a2a..6e60d55491b3 100644
--- a/include/dt-bindings/memory/tegra234-mc.h
+++ b/include/dt-bindings/memory/tegra234-mc.h
@@ -536,4 +536,9 @@
 #define TEGRA234_MEMORY_CLIENT_NVJPG1SRD 0x123
 #define TEGRA234_MEMORY_CLIENT_NVJPG1SWR 0x124
 
+/* ICC ID's for dummy MC clients used to represent CPU Clusters */
+#define TEGRA_ICC_MC_CPU_CLUSTER0       1003
+#define TEGRA_ICC_MC_CPU_CLUSTER1       1004
+#define TEGRA_ICC_MC_CPU_CLUSTER2       1005
+
 #endif
-- 
2.17.1

