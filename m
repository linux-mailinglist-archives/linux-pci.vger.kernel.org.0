Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001946ECCDC
	for <lists+linux-pci@lfdr.de>; Mon, 24 Apr 2023 15:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjDXNPr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Apr 2023 09:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjDXNPp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2023 09:15:45 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790ED4EFE;
        Mon, 24 Apr 2023 06:15:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocV+VoY4krVza+dS5kYBbmwbFkDynaKoPiSJbROCdbC6+6ixjDaenkDeI21UGiC3q8ilWJmAanHYouK5ymVMleuqwsfVyFB2eTaZf2CjXRsyT5+lGIdswWSGhltW4Cl4J1OgbrT+eildn7hoxKKANHgTe9UDIpid5PW/QP/Mz2Zzhxp+KFyr7CnCe9F6TjjRA/FYvQHzquzzSEa1JCA2hxBO9mEz8WMoMUY0ocbiz4y4RvOqvag/RfxJdDJz8CNDwdItBF1mk90BIytGTTyBCCfCeeBKs52UatcsJjuFOmj5OcPRysTIKLwgGyuTLRt+zrmZ3SFYyN/ohW5TS7TOqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EOLSj2IMC6AmgQP+x8WnAbrOd38Fq0L406q4vninRQ=;
 b=NvbwUOT7BL7Ah8m6O4fRn7wQ2GHWTdq9ziCek2Mh6g98xi7uheWzHYdQhA8e9C/k0uBcxfe6wZuU0KUvV/KNboXuVuzI7qoL8crI/s6Xa+Xjsdsc9tDiE68NBOEWcBvjs/PiBS8Km5CkEpX8SGZLATragWFElynv/0Cy+DQo7zTc2Hfci2HdbmZqsE48LGqRk+2e4tWfPl3mLF8epKmefUTrXkSBJxInuE1ZXdqP9f+yhvTNM8FaPDMJivtE6tBkWjPEwylTmJA26waepl6wCCYaNNYWGCyRcVww/xs21PlIuyGHUar7/aWVoqUXpRgYnOxSI0hATrXrvW8JabYwrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EOLSj2IMC6AmgQP+x8WnAbrOd38Fq0L406q4vninRQ=;
 b=kqIbZ7NDDOOHyfB7oASRumKvwWrVguCaCkDL/4pjJ48E6cUP79+2sRwRZ4Ch0BMjJ8heRDqsIXAr7zhQ6HtOk8D04Lfxo7zSyguwdelgUS1+/RRSHsk+8kgXWNjuQ+RTSt7Jz6xxsgag049RsfaLuYq2h/b1AuKIo/LKuXHQonc3LjY7VsA1kh0JeN0mtuj/PlWSiusQmFEuCE5dRJKo7abJOgHbO4wwLulkte0ki6ekztW7aNdCF7GngWt2ASN2PyeUVL2PRmdG7Ch/Ajw9lyuk2HMjNvx0n9BsEGYvABanz4arzlv86igkH96EePz734RnlVY3LpKlMHgVe3fUcQ==
Received: from DS7PR03CA0116.namprd03.prod.outlook.com (2603:10b6:5:3b7::31)
 by MN0PR12MB5812.namprd12.prod.outlook.com (2603:10b6:208:378::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 13:15:20 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::f5) by DS7PR03CA0116.outlook.office365.com
 (2603:10b6:5:3b7::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Mon, 24 Apr 2023 13:15:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.19 via Frontend Transport; Mon, 24 Apr 2023 13:15:19 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 24 Apr 2023
 06:15:11 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 24 Apr
 2023 06:15:11 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 24 Apr 2023 06:15:05 -0700
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
Subject: [Patch v7 4/8] dt-bindings: tegra: add icc ids for dummy MC clients
Date:   Mon, 24 Apr 2023 18:43:33 +0530
Message-ID: <20230424131337.20151-5-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230424131337.20151-1-sumitg@nvidia.com>
References: <20230424131337.20151-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT037:EE_|MN0PR12MB5812:EE_
X-MS-Office365-Filtering-Correlation-Id: ed94c866-ab2f-4936-0cba-08db44c5f441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9imw562LZUXWoL6yX8SDlN0Dv7jerr4+MAhFEzrJlx6zt0wVRaX7L7OucZkz47O3aZKe6TXa2k7eicxTHQaKd30meib5odnzQ05DcQcafSRDYbTOeuCsqpGdJyU1GsqLQagnLCsYsRFNrJWJXTFxa2ElzMwyQkRwScskWOhz+xl2gWLO2As2wQogtMAivcLZg8aFGSUG9tuJJTK7q4SPZNGTxJAnTNTaL3Lq1jYPUnwWlfUobccX2eYiWV57AUY9JCk2kqZBamV5DE83bzb7rsV8CzwzXOS2VDA4HRYhdOOG4EVeyibNflUqSstjWwS0FEDlI+MiE8iJuhzbv26Y+BUk2Shdopa73/xvxwd4BBMhv/w1BMS8IGjyUg5A9UZmC7k3WkVvDlba/EfnuvzmqJOWkuNP/brTe/WOl5aCXBoxIPDlD+bWxVM/HDlEQb6nZXZNo+N8vWjPrLZDxtEYma1Q/CvLobCUMIko90r/no0Q9h29xPzh2WypENsGn/5gr3RmDrRh+rMl4vq/nDMpmA6pG5WiwEyPKGi0WPaJgQ1LV4RQ6vAGWTu2QhKQM9exIAxH/86IzcQRW4IaIbfCP7u9aO5NGdzSr0PVCTXfCVzHU5kTrURGBvGemsyLwT+nTlPm/SDXNPPD1wZK7dvHte9LfkYi8dUgnjsaGK6hEtHbut0PVwR4P+K+JWl1TPYfu9pSBOkWPPWQDrqW/7mNG4HlBiDKjLTrpZCeYueyD3c=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(36756003)(8676002)(8936002)(110136005)(54906003)(40460700003)(34020700004)(478600001)(4326008)(70206006)(70586007)(7416002)(40480700001)(7636003)(356005)(316002)(41300700001)(82740400003)(4744005)(2906002)(5660300002)(2616005)(86362001)(186003)(36860700001)(336012)(426003)(26005)(1076003)(107886003)(7696005)(6666004)(47076005)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 13:15:19.8800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed94c866-ab2f-4936-0cba-08db44c5f441
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5812
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

