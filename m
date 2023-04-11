Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBB96DD89E
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 13:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjDKLBi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 07:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjDKLBa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 07:01:30 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE463C39;
        Tue, 11 Apr 2023 04:01:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iv1NYZbLub2g4uPl/TC4cZxZQK4OCX7AO1QBu6no1sPMN8qXBipVdleh5rD44Uw3aiiKPKAU126EIrBM3BCcPH6CIcB1oQMbTKxKeWWaGOVS0QZiFRMLT/jS1Lv/UUohGAdUnhLF99MVtaBtFQRIj6GjROnebrUcCb6LzngO3jnnsw9KNaKrNWOIBJgGWki+XYvkDdIvxaSmbh3QJuHQGAWwNaOIPTwk5Xub+C6nZ/P5OVf6yaraDKpJgugo2c4NpteaaOeTq6XOc94vN7FqGzhFtVIEXTfCbmAtK2Fx7443M+ZcZyBsGE6+Hf0RYb+tX7JFF1qTbkHoXimePS70vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EOLSj2IMC6AmgQP+x8WnAbrOd38Fq0L406q4vninRQ=;
 b=foiP0LgLb0ndmljChuRTjAyaLYs2PBBwtbGDANPm5LGTy5cuBw8ymfmxVrIZ/0j1o/fu4mzfjkvnbifowQ1O04O5/DOYgz8ixEbS4evGlLDA1ywj9p3D+x6iiN2iCZpZnql5SFd5Qwbf8ni6oXAs7vFPJNwEUA5ADBhrMJ1BJ2jTqr2mBUNLZnI4EfwQ4XtyhMtsaPjnFsBwGszw5Ec3wvyvxs1ivHexFPOws731Yy/XCZpPbQmrxxV1Jr3+MUQQnOEEtVeYq/yEmLcRr9DwoAVZ/sLr5jUCGw+Op/RmUhgAPaG14wkVkAJZ8FYkChubUta+fDCvm06Hgk3s8ZkAXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EOLSj2IMC6AmgQP+x8WnAbrOd38Fq0L406q4vninRQ=;
 b=avCmyQl17lUeAdDHI7whwR5tCEThphX2jDZ9oK5oi/fRyPkI4wBGjNWKOndhDLH0p/KkgrM/WM73qmfLA/nWA4UshjSCMN35fWyEl+2ThT0MM1FQG0c1XACpGHaK87s6EXo7hgszehG5orAYAIUv4ndbBU2PNKIKJFFkNGI+8VVTAOw4PoeJCAnr0dZk8beUKzfVYES9ItUvUejtH1TeSLyIyTXMlFvVP4SBTpAI78CwkvCq7wWamPATbdKxsEK7PrsH0LinF+I44H9T0SVZvXal1gcBpQVbBrelymESQMvZDvqiucfy14CHbZLHB2Wh1jM4ljXbMOxFU60BJ7Ea0Q==
Received: from MN2PR05CA0044.namprd05.prod.outlook.com (2603:10b6:208:236::13)
 by CH3PR12MB7618.namprd12.prod.outlook.com (2603:10b6:610:14c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Tue, 11 Apr
 2023 11:01:20 +0000
Received: from BL02EPF0000C406.namprd05.prod.outlook.com
 (2603:10b6:208:236:cafe::bc) by MN2PR05CA0044.outlook.office365.com
 (2603:10b6:208:236::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.24 via Frontend
 Transport; Tue, 11 Apr 2023 11:01:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0000C406.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.25 via Frontend Transport; Tue, 11 Apr 2023 11:01:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 11 Apr 2023
 04:01:05 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 11 Apr
 2023 04:01:05 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 11 Apr 2023 04:00:59 -0700
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
Subject: [Patch v6 4/9] dt-bindings: tegra: add icc ids for dummy MC clients
Date:   Tue, 11 Apr 2023 16:29:57 +0530
Message-ID: <20230411110002.19824-5-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230411110002.19824-1-sumitg@nvidia.com>
References: <20230411110002.19824-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C406:EE_|CH3PR12MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: bca631d3-6cea-42b5-9bce-08db3a7c1499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8fn3hz4uvPIViW6YxgzV95GhotM46GlLrMuTv2P2yNZ0Ix4K9bnTM9W+S6LPclkYN3p8eWf69gKYdhlqgXC/YHHZZEdpG6RMmWb+iRULX2Ozr7KHxa/zM9tyitGhUnUZUljFb1jbTFV3lCzsRcAZtOBTZ5ReNNjlawULcQhHrnBipaR0ysdPYb6wAIxnMZOiflyM1l9s3zTNUWY6GOxz8MDXMdkEr58tn8BTTlZnu6m32OcEMgwdKOSedXGC3/tu5GrpNnZ3TGQvJ/OFaKij8T8ArCI72vYgri50+0beYAcuLt1hb68Sq4K5BUwhHKpXOFQ7QyBZkJmNXGwSCAzslwn/DWLCwi+jhDCleSwXYXr3kR9+M/7cf2IhRpxf9NBh2vA0C3GcYpWMLDCAqjvymxFHhb+7wPYnMTerZYD8DXMk8GUoZjH/My9ZsCGg/0Wm9xUbXXyEvNtiB+TYNJZsX9tLDQP7qfazAibBs6A+CZ/T/3eY1V/3S7R/aT38uxiO2/hvsIBjY55j/mjD+awaJFz+lREg4K7jT4Y62rKAz0J8yGavxhCHQh156oYFKG6vOirVDAXqeaPNEmyVU6pKg8Q/kRSa8Jra6Uuy2qSsipM9xy3sqL6hbyFhGM4QWpcI45bnuYzlFweORdeZyLxqFprqL7KzPPlRwP6WqPMG+shQWnHX8h0M9VRX9LSa+6XkKhdY6xdNz1gwaIqHYk/2v/Q0VDN49opaFWtBFF63rkrX9m0pUX5wrjoRRHS7sUNr
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(70586007)(70206006)(4326008)(478600001)(7696005)(8676002)(41300700001)(316002)(110136005)(36756003)(54906003)(86362001)(47076005)(426003)(336012)(2616005)(26005)(1076003)(107886003)(2906002)(7416002)(8936002)(4744005)(5660300002)(40480700001)(82310400005)(7636003)(186003)(82740400003)(36860700001)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 11:01:19.6992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bca631d3-6cea-42b5-9bce-08db3a7c1499
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C406.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7618
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
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

