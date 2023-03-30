Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC266D06F0
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 15:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjC3Nfw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Mar 2023 09:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbjC3Nfv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2023 09:35:51 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702B7BDF2;
        Thu, 30 Mar 2023 06:35:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnGK53pB2e77mIEwW+lvsLEa/tevhkRRczH+dCj5YtUsa88OS9mN7JSKz1ccmmcf5YKLTI3UMMy+7myaJSzBEvJjz1p3CoOXzVFtSoAUiOIS/RNcbR8cjXBlvpknXt85vyFT2WOVKf5c0Wtohqk80r/O8YCt/dd+YDHWHaBYqOoO7k51afa8SP3XEas2msdufj6YwCYwx+HgOhC9PoYpxKi8te273epPRdKCqjCw6pOb7C8ImbIEzjtRwK5Hw1hFFiInimiopRyjlgeeuRabqvkhgaqZxAmelUsS0zF3SCDm9i1dGaai/trTiE/ZcyC0/DMBNw3IFg4Fe/2vWcCatA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EOLSj2IMC6AmgQP+x8WnAbrOd38Fq0L406q4vninRQ=;
 b=O0yDZ3v+HeflGPxTeAuRnRnOFmQsiNcNa/bQskNL2BInXELCpt/mRgm1n/hbavJ3JZmTskkHbKtuEU1tq8PBpLvb2ZOXueYko+s4siDsWCVTe2eVlCPpRp4shgiBFXMOzRP9CiJMnJhCI71l3XS/HKQANDKzujX60chvKOJqqYhx3cA7EYVIH8c8dPc5YvawfqM5crrJn1p4qu3XVpRvItheKgirT+NFCSSFKIeQqj97PAEiqBlo34ejveQS2Mx3cG1kXujlRxYDIuQ6BAjvLtUdomm+m4hi56+71kxLR7wu68AD38/h/Rugm6ZTFwIf/ONugUa/7DcY59nHlxf+Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EOLSj2IMC6AmgQP+x8WnAbrOd38Fq0L406q4vninRQ=;
 b=Pi9e+lNcN2ThNzlAKBZOYs8xYXyXTlu7mCoWEmX+rUPnbH/tMCZsVk7eVmG7cK7PkiQcJQl9KQFKHi0/osoLB0XnZa8hZbmfrn0iuKFVD0tXwrLXjA2VR/wqxWOEAKGRmUOdO58OMFLSbROLND1Q1m+YkeR/EjKFEzI8Fedk1Xa29vQHaSPGRWA+rhIFvaf/AFhDTnh6400hsVu4qWSywhay0Ox3pMxK+PWP0qVWmJ7JplekJK0fb2oe6CeeAceN8IVVBvBUr6LJfKNK8EmANkPjchv+2snx/dTCxXfDxtGxvCP4V4MQGm4e0KN8bJ5VDhUCBMXGwzG8OfyPamGSAg==
Received: from BL1P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::29)
 by MW4PR12MB7143.namprd12.prod.outlook.com (2603:10b6:303:222::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 13:35:17 +0000
Received: from BL02EPF000100D0.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::3c) by BL1P222CA0024.outlook.office365.com
 (2603:10b6:208:2c7::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 13:35:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF000100D0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 13:35:16 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 30 Mar 2023
 06:35:03 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 30 Mar 2023 06:35:02 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 30 Mar 2023 06:34:57 -0700
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
Subject: [Patch v5 4/8] dt-bindings: tegra: add icc ids for dummy MC clients
Date:   Thu, 30 Mar 2023 19:03:50 +0530
Message-ID: <20230330133354.714-5-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230330133354.714-1-sumitg@nvidia.com>
References: <20230330133354.714-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D0:EE_|MW4PR12MB7143:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca0a3bc-95d9-4fda-616e-08db3123991b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JwZh+kJNY8puH9CYtiflL1QbxIFgc/Rjee7g0rsa2Mh4lik7E62+J6teWLiWKj0SF2HsMdJkFnyx3qzqbPdIZiuo2ckQP9OnTEGY6/0riB4vSBUNpnKXYT9zGKIrRvLVkLgfXXL8QkyJtVak3ZijErJzzfItQApETL77iptP8sI6BXw/ah6Jsu6SIor5GRcbkLxBVxTyOFBoQuyRB/1aFtKgplIyTtVdiq7/F2BVdAIJBSdRXMRpxrw+rfBzXxyhtNoNsvaH3pROY6udpw9Zfc0kc2fuTL/ez2fNDe/E05rWwnVH58WBuRJ8o/25cvshG5Q32PKj1UsONNRzTP5KtyAh3m+wc6XEvqzhBpkX4megbM8QnvSKt6An+ptABIe1JvHxcDX68fRGqScWx6yeM3J1chXeb+4DzcPUOxfN9dLJvgzprUIVNJO9R9PF2/nmoOhEBUHGGLPoRliFollR7TzTqr/J3t/DeB/0soQ3Mc32sW5COEnpS4OhF08VpLzvi0MYUVGovfKZmsnt/JJXn4zhTbUiH8uKCiGj43A/u9UZsiMSTqKRxrMt11py9qtCwd452MLfCDkrIw/+EFUdStvL37k2eichepoBQQpPTy/gdkcgrCzH9llz/ARoX8LcRqOH5gLmxi8sNE5m2XIC8GRtpXW5YDJMyFRVG0yMvLJ93+FWhQPX2m28+DpTtB0VSev+JJi0k4SUvnNLD0buz+JpGcdyaQP/qy69iWdcFsLn3KPP+YjYU2ykiqTJsvMa
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(46966006)(36840700001)(40470700004)(26005)(8676002)(40460700003)(7696005)(4326008)(82740400003)(41300700001)(70586007)(70206006)(7636003)(356005)(2906002)(36860700001)(36756003)(86362001)(5660300002)(478600001)(8936002)(4744005)(7416002)(82310400005)(316002)(54906003)(110136005)(40480700001)(2616005)(107886003)(6666004)(47076005)(186003)(1076003)(426003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 13:35:16.3506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca0a3bc-95d9-4fda-616e-08db3123991b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7143
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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

