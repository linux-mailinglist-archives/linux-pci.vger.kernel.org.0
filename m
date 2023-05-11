Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24106FF883
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 19:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238084AbjEKRdw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 13:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238631AbjEKRdv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 13:33:51 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF26E9EC1;
        Thu, 11 May 2023 10:33:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=liFDYif52G15zm3qg2LmgHRJQBpyqtieYQexEgKYNknVbeEzfK2n9GOuJT36pktDfvFRtnH2qelYBASQm+QKfnrBO7i9I74QG2oWysuHbYyZiSjUsBWLSZyd7yHH6BZlUXfOwI+jhD7ZbvvzkpGD0KeTBVX2ud9lOOKh+3igdpj7UWWNXzy0YciWzti/7dRCjPF/PbO66XpTnyH1xsfF37EX4Z4f75TJrl6DAbwYmMTf3jc3bscxzP6P2tiLWTCmi0IVdMrWWnxPLOYR1m0hYCCweCI3mD0OXYuxgbTND70XKCGg80i/fQWPDkBzwVsJPDWRdevVN8Q4K6yGeSY4Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EOLSj2IMC6AmgQP+x8WnAbrOd38Fq0L406q4vninRQ=;
 b=eLx5PYInMOCNtlvU6VoCXrBCG/lsEFgDDO4qwUpMVSPQYzlG5Zk/at0CiT1+YfgFO0708oaC6E9bttS9CqBmO69J0+bEI+uJx0yYGcPJdp7Dspycp8DVmLnVBvhiP3Y+i57agIE0D3UBi8EheOyA2JZWUGc2JQq/CYlpEQn33zpUTayIiOIyIcZQ5p0T/H0GCnUi51QMKzBRJApDwS+YPr1b+qV14Beq17zkDvMrBidrxVre0YO6nIkvgN2i6GRvftofxDjvw3zDmnd/3tb+RxvFs+Nx9fXAgWqxoidaQejI33CDnyxA3vBCkxv69r7bZKC46jKNmkr4KrHhfwzM+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EOLSj2IMC6AmgQP+x8WnAbrOd38Fq0L406q4vninRQ=;
 b=Jmmxgb7nflBkkxkXWvzCRoVnUHdPvfuxD8tKrFqj47XkceWeiwnmf/l+BcdlhiXgCP2dauCVSnQ8KiYiXArI97wr6CZ6/3vpAzV21Y7/gXzfTMKAtMCs+qZaFG6jD7oP6e6bZdeWPEggiaYZCAPUg5OXHg2YMRVTowlGV7iNJ/1FIo6HidGH4Dnq5ZCB/ngGK/sxjXl8LJs0xiWnPCwK7b+HrtLJ+ZdxzYPs7e3/r22sp0WoihB6mCyDVE8YVpV0NSPlGkVpfSFBRjgIrJF3OI8LqzoGLOchwo/2MRJP7rOcO0XGsAwaf3NKFuyIZdVjSg2to4iwVkknC5qV026+wA==
Received: from BN9PR03CA0951.namprd03.prod.outlook.com (2603:10b6:408:108::26)
 by BL0PR12MB4914.namprd12.prod.outlook.com (2603:10b6:208:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Thu, 11 May
 2023 17:33:18 +0000
Received: from BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::d8) by BN9PR03CA0951.outlook.office365.com
 (2603:10b6:408:108::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21 via Frontend
 Transport; Thu, 11 May 2023 17:33:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT071.mail.protection.outlook.com (10.13.177.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.22 via Frontend Transport; Thu, 11 May 2023 17:33:18 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 11 May 2023
 10:33:10 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 11 May 2023 10:33:10 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 11 May 2023 10:33:04 -0700
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
Subject: [Patch v8 4/8] dt-bindings: tegra: add icc ids for dummy MC clients
Date:   Thu, 11 May 2023 23:02:07 +0530
Message-ID: <20230511173211.9127-5-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230511173211.9127-1-sumitg@nvidia.com>
References: <20230511173211.9127-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT071:EE_|BL0PR12MB4914:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f52691f-b354-4669-7ebf-08db5245cf2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 96/sCQYlzfSQwJxKDfORG7jaEOgZ0PM+jYEvG7R4JED06U4/crwEYZXeL+3BQy6AbwBQ7yDFPB9OuxGvhq7AFovzKPzP5POrePz1hBcK7ZT+nsCRU3uu+u+b6W2WWlwQUNjO8ujSw8Q46D0afBgh5A+kjdNxRqQDRfEVlFmsY5HoWAvrPiLJ7zeAbUpkDpfv8Ci/y15FYduIu2tMf8Iy9YQzk+VFXwgGFe7x3nECQ3P7iynbf0UlrQOxC4m7XLkmwZLKaI5EWvlqmi+J0MLth5hRCmoYOh+Q9S3XVGG9cNx7Q05NmkhXVBSb7Vs9CD2RwRCnV652SNp7oIsVYJd93HJASElS9mH+Ot3dY0ORIgvrFTPSeEkTSNaxs6uWjs7fcfRWapepJOSbweDFshytM8R0msb/1Fvmvsddjk+FySDD6BQZP/xQ5Buqi8Zi0fOm5aj3/+APBYh6rGyt+zm9nUPAbPg7b3sE6KSns1jhpkhgynNZEYgKI4aCMo+hOrKaV/vDM5hBFSIfSd4Ed3XH4+RGz3g1fCFl1a2Z0PBFmdUpfrHWe/HIa+RS6KMSfsgQBfqvdIyjR/CJk/DWORCGz+MZivb28PpAnqZXuJxw8umVyiU17RDQPpJqJwRNwSdIaXZlEAz72Cmkk7CMHfOOUCWoA2DIsC6k7ZD3fiWEScMrOLiRiC+dyUx06d8pg0G8FmQm0sDj1E41OZ0F2CasIhlTOYhZUkDtgDkcHfbqPGDFIIdi6nOV8D1ZVxp+pdzX
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199021)(40470700004)(46966006)(36840700001)(5660300002)(40460700003)(7416002)(4744005)(2906002)(41300700001)(8936002)(8676002)(36756003)(82310400005)(7696005)(40480700001)(86362001)(1076003)(7636003)(26005)(107886003)(36860700001)(2616005)(426003)(47076005)(336012)(478600001)(186003)(82740400003)(316002)(356005)(70206006)(110136005)(70586007)(4326008)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 17:33:18.3177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f52691f-b354-4669-7ebf-08db5245cf2e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4914
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

