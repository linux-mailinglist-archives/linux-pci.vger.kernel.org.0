Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3114E69CEEF
	for <lists+linux-pci@lfdr.de>; Mon, 20 Feb 2023 15:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjBTOIQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Feb 2023 09:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjBTOIP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Feb 2023 09:08:15 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1F81F90A;
        Mon, 20 Feb 2023 06:07:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IY07gR5UWF1+/gWTP2cXzZZMyXqRrGygadz0ur4Xc1RwMJvM0YUtJ7K2fxV6d8HAQcmzp/DlwRvXTldqgtTQ7nXRHhtP5wQ41CMquiE5XuCv790n740tC+TkG4AL/Cc4zl3zoHaAQ1oANUzpCgnHFS1eUawIKuo5yreo9e8ETyXrnCB9i/4Z+sT5aWeTUoxRfF7a61aDwQOgjT1ERgVHO+5JgsqKoKh9HxM4mbTgpva4WYLFMJwidJJSJd6nN01ldtpa+xWuzfo22PRfl12MjDEYuEnL365CReZ66jFraVHkOB+KHGmwu1dJYBdDZ5+7oVsSG4UUfauDKEcC9H4kvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EOLSj2IMC6AmgQP+x8WnAbrOd38Fq0L406q4vninRQ=;
 b=DMx8wG2u6W/m5kl/KPhxg09hD8p+wTMlV8TEa4r8UR2f5h//YKAEGkyNO78eEqnv9Z0gx+cB6ewD2/grnICBTfns0uC/8JYcBle2Uybt/3fbOn7e+i/z0HmW3ld9bgFTnCXq1i3VJo3TW/ajUm0+cH39Uh7UBPJKRxhXJGVOoN3lcOnzL+5y+5nGY8pnW3OjFBJLoe8VhDCoQmq6Xf0RzzGXjmzp0C3QIzwP/esvbjrHk8EWh9V8OAQEOsE2FfYmus79Ux/D4A9F56R9+QVtwds04pgDpHgW3WHCStUmNytYRSxcQ54AH9EmT6GWqfwLWrbZF5/f43oAY7gCt/ToLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EOLSj2IMC6AmgQP+x8WnAbrOd38Fq0L406q4vninRQ=;
 b=Ns9iNRrp/ooL5PjVjKFDxsESYzFrfo5mfp14yPSADNhLSOeb/LOQCNNrOGmE5TXosmHKZivqxCV8AG1IJOULdLfuvfjuHVp9dR9lhEf2qg8HjqzJIuoop+9n3CHcR5OVv1o6gQngMlh6hYASZYi6gp929fnRFWdHg26/OoNj5uE2xDKeLAQhkQSaJW5RWCAOd6c4V1r9H5VtiW8XgEjSyzhLpdkRaSF2RVQ1qAt2ydfOAZwS7pkdi/ZAIoXY2PU/BcQWuc7lDesL9s5iExtReTN1Wc4hGKmJEQG1jB731ylBgHF13n+I+7q3w1ypyZN1vg90gz7kck08S20vqBFvAg==
Received: from MN2PR03CA0026.namprd03.prod.outlook.com (2603:10b6:208:23a::31)
 by PH7PR12MB7137.namprd12.prod.outlook.com (2603:10b6:510:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Mon, 20 Feb
 2023 14:07:32 +0000
Received: from BL02EPF0000C404.namprd05.prod.outlook.com
 (2603:10b6:208:23a:cafe::8f) by MN2PR03CA0026.outlook.office365.com
 (2603:10b6:208:23a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20 via Frontend
 Transport; Mon, 20 Feb 2023 14:07:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0000C404.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.14 via Frontend Transport; Mon, 20 Feb 2023 14:07:31 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 20 Feb
 2023 06:07:14 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 20 Feb
 2023 06:07:13 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Mon, 20 Feb 2023 06:07:08 -0800
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
Subject: [Patch v2 5/9] dt-bindings: tegra: add icc ids for dummy MC clients
Date:   Mon, 20 Feb 2023 19:35:55 +0530
Message-ID: <20230220140559.28289-6-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230220140559.28289-1-sumitg@nvidia.com>
References: <20230220140559.28289-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C404:EE_|PH7PR12MB7137:EE_
X-MS-Office365-Filtering-Correlation-Id: 67c379e3-e247-44b8-a373-08db134bceee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S7aMBLSQ1YNHkaexWLDXP5r55h6C83Srj3RLjcE7gF1dzCqp7bD4D0oqoxe3oS85RcUb4VW7TY7AG1vkyJBn5nBSLsGJX6D1ABQ+1HsNUPm88ZkQMqepMemUZvzfCxD1oc5ysnkRf8vbTkdt3orlspT9TkPwDm/pO3ii545wWKscoLTX1yxz67N4cHzBo6neD07RXD2m4Tk+L/RIaAj6abXK26HTRybR45KfwetV6/XaevDgZ4r1hcfPlC6mkjLaLNbeir5u1rNup+1h2a0jmqFH0+BNEJpjXER8g3FnajPeChOzFDyvwahBifBwSEemv/ThkidATJNaoNcv/cQfRQZIJut/x75Usqz8JR2/FcDqzaAEPGPncsvZkv+pyF8nK1YglJ6rps/8PNTvEVfdBouMUAonoFI2XsNCNRgcrHZy3/1LvE64bosOQaJEurlBLpHdhjT2OqMelNF+zDGJZhFAzoUgUvA1Ab/YF9UsprPlHaR6xNTepM5eAxQrXpi7tNfdpPvn+6SrYcNCvR+4N1ItzjADHwAmWy9177S3LO3HIvrVRu9Y4k1jMOtQhQzV3ceh2iYo+0MqzAO8Un3oHtC1a+FjvA2zOlRaV2AnZNuwoe/5+Q43n56A58+VE1cLHIPrS6QiNvwRrz3v3bWORz+uve1rK47fvkvfTKExxeypDcEV9PYDVZF9wKYUHPdefE/76z2O+xy1ScY/G+xAHg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199018)(40470700004)(36840700001)(46966006)(2906002)(316002)(7636003)(82740400003)(36756003)(5660300002)(7416002)(40460700003)(4744005)(86362001)(8936002)(8676002)(70206006)(356005)(4326008)(70586007)(41300700001)(110136005)(40480700001)(54906003)(36860700001)(82310400005)(47076005)(336012)(426003)(107886003)(6666004)(26005)(1076003)(2616005)(7696005)(186003)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 14:07:31.6246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c379e3-e247-44b8-a373-08db134bceee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C404.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7137
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

