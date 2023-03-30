Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01986D0703
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 15:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjC3Ng0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Mar 2023 09:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbjC3NgZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2023 09:36:25 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC438A5B;
        Thu, 30 Mar 2023 06:35:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtTZP8Re2WuynsDln26R00dxsNqUR6MN5YetxmgWN6QgnlsuS6soZ36F6zduBq+lTV5nS4HGWRWFCZj1sK6AQidOv1Tp4G6InVEdycgUCyfmCXF2FFo8xzrspf+h2VjVJ1YxnRSoOIVF6VQGGJ8/a+f7k/a4VZ9WTP/zn6kvgE+ETiq2zee9XUz5xfgAVVSgKNf68n2wwsG3uY6drpUDWew8T60Ek+6k5aEpyuqwBhR47QUrOXu+7h3OSHxZLxqo6E+6sUuMYAM3jGC299i3d7xv+N3unm2oQTdTYvuk3Hdp4bECzhTJWxX7vvRb+TxqtIsGmUbX2NQdzXPxzvO70w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxvKHL4caozilROvR5+TnU4HO09jiXCkfL3FawQRZXI=;
 b=Mma2mtoReElBvu3n2QCadTUgL+MEgfMmrh35ljU01NO0BmbZlsLFO5FFP8uay7CW3dcTPo1BXvTlxuGFUFcVWOjrAk/TM0pRGwtRPU9QdzmpOzZww4SnqPjr3JnAkBo0YzKxn0Q+OWnnTQovEnYq0zyi1N0aFeBhog7J3GtcNJkegmgG0uIxWKisu7OEF64IQbGXNt+mNOy6+y7XkIqj+e/iX1j4k4QCVydHgd5/J+IMRdRWEHFhblh1A5dpbP8KbisbTmqNZ3HmYfHrCoM3Rp6tPyIEBLBOJ4D4ENLsWDTNaI9Rpx9x6NMc0DJ8sctF8MyBaQTIup3uTuElPAExBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxvKHL4caozilROvR5+TnU4HO09jiXCkfL3FawQRZXI=;
 b=pch9ye6YZsNFWzJkhPXRGn5ZweBVIWb42NPOVZgvyh6KRqwc5lyBO6vDR0pFlz1boje4io6hQ6RQX+NR2KwCvNn7Z8Pd3XbUoXxUuGooEyx7qNE5/3UJIiafWOalvl7gPl2X9xSFRgrBhyY5Qhtuiq2RZDFVx9EFScHSQEErf7tGP63lJRAN5rR7C5gwt+AD8TlHCoRXfagEIHrJ7GVgrBNYuNwz0r5KsBBhIY9VHFRuFlt7bahtrZtAnSeSLBXZ+LOWrLiJ4B2A/t/Kcylrc4U0m1278zXC+sMeYUDJA0VJ3sGJ4upmXOmplwPhqkkSbkYOeb+VNV8a/6Ir+Iz6bQ==
Received: from DM5PR07CA0097.namprd07.prod.outlook.com (2603:10b6:4:ae::26) by
 IA0PR12MB9047.namprd12.prod.outlook.com (2603:10b6:208:402::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.33; Thu, 30 Mar 2023 13:35:45 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::bf) by DM5PR07CA0097.outlook.office365.com
 (2603:10b6:4:ae::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 13:35:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 13:35:45 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 30 Mar 2023
 06:35:43 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 30 Mar 2023 06:35:42 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 30 Mar 2023 06:35:37 -0700
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
Subject: [Patch v5 8/8] arm64: tegra: Add cpu OPP tables and interconnects property
Date:   Thu, 30 Mar 2023 19:03:54 +0530
Message-ID: <20230330133354.714-9-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230330133354.714-1-sumitg@nvidia.com>
References: <20230330133354.714-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT049:EE_|IA0PR12MB9047:EE_
X-MS-Office365-Filtering-Correlation-Id: db18f6de-1f09-41af-5aa5-08db3123aa32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +KVwLpvyYb0mWJolel677Mn27/IbpLnLJMWhOvzaVd6IVw2FLfQNk9v116RfDgZs6TwZRzcym20erpqnC4dvOcczptFwYZ40uom3FJdVQNs0QyvKsthjwxmSKIxIpXuCxRmWuO7+GPgqBxkjefYpvWwyZtuaZHVzQW2oB9vPaJxK0K6Wgfbviu9xOjqG0eyXM0AWQecfPejrM68FVMPZw991RMh4M6rPQ0snIFkeVTnnISrNDMUK8gZ1jJHep6KuZJs9djoz/BOpfdoOxnPrDyTvaoMfsSUmXUT0R/A/jHhlEcs6WENnmKWYEPTsjQHXfq6OOKIRW3UxRDHKhVH6UG0FyBUEuCCnwUEzwEaOlmzjQjjirkulR3LOd4ESe9s3FxjFavkVcjrODg+EJ5Bjj7PIIVV/vTyN9MreOYu3JLG+Y87VSD6hHdOpkY16JJvNOPM+FTBd4vyS8DKH7E3/5VTX38pOJ7EJ5B4U6Ud3gm8Mjv9jP5nqcc4/c6EjyO02lc7Gr9A9qjq+atxqu2wlnZxX1KS2ZWxPRxvsTMnlsAzvwBlhukTtHuEhmL5uebSYUCjzW/RGo81VFQ22iPo9H6kd/Ofr94wo0/9XdASGl2Tl2dnYgxGOaLy93vPGUsuJKUsV4BmUrh307+Mkh4J+blTFrDSD2TvOIqHXcMfnUdCeqIchD5Mad6gk5JTYHUpLMsiUE03lUBxVKz/ARjaTctKDSycMNjNRRGFIvVfiZVlohLNcfbjah4xI1RBlxhB6uPtxVURvs1l3zuIr2RJ/0yVDkVKfO+5nOkLVJgrdOwc=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(7696005)(70206006)(36756003)(4326008)(8676002)(356005)(34020700004)(2906002)(41300700001)(36860700001)(5660300002)(40480700001)(86362001)(82740400003)(8936002)(70586007)(7636003)(7416002)(82310400005)(316002)(110136005)(1076003)(26005)(186003)(107886003)(6666004)(478600001)(83380400001)(2616005)(54906003)(47076005)(426003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 13:35:45.0694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db18f6de-1f09-41af-5aa5-08db3123aa32
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9047
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add OPP table and interconnects property to scale DDR frequency with
CPU frequency for better performance. Each operating point entry of
the OPP table has CPU freq to per MC channel bandwidth mapping.
One table is added for each cluster even though the table data is
same because the bandwidth request is per cluster. This is done
because OPP framework creates a single icc path and hence single
bandwidth request if the table is marked as 'opp-shared' and shared
among all clusters. For us, the OPP table data is same but the MC
Client ID argument to interconnects property is different for each
cluster. So, having per cluster table makes different icc path for
each cluster and helps to make per cluster BW requests.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 276 +++++++++++++++++++++++
 1 file changed, 276 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 959d659dd5cd..d735ad2eb84f 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -3011,6 +3011,9 @@
 
 			enable-method = "psci";
 
+			operating-points-v2 = <&cl0_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER0 &emc>;
+
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -3027,6 +3030,9 @@
 
 			enable-method = "psci";
 
+			operating-points-v2 = <&cl0_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER0 &emc>;
+
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -3043,6 +3049,9 @@
 
 			enable-method = "psci";
 
+			operating-points-v2 = <&cl0_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER0 &emc>;
+
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -3059,6 +3068,9 @@
 
 			enable-method = "psci";
 
+			operating-points-v2 = <&cl0_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER0 &emc>;
+
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -3075,6 +3087,9 @@
 
 			enable-method = "psci";
 
+			operating-points-v2 = <&cl1_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER1 &emc>;
+
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -3091,6 +3106,9 @@
 
 			enable-method = "psci";
 
+			operating-points-v2 = <&cl1_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER1 &emc>;
+
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -3107,6 +3125,9 @@
 
 			enable-method = "psci";
 
+			operating-points-v2 = <&cl1_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER1 &emc>;
+
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -3123,6 +3144,9 @@
 
 			enable-method = "psci";
 
+			operating-points-v2 = <&cl1_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER1 &emc>;
+
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -3139,6 +3163,9 @@
 
 			enable-method = "psci";
 
+			operating-points-v2 = <&cl2_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER2 &emc>;
+
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -3155,6 +3182,9 @@
 
 			enable-method = "psci";
 
+			operating-points-v2 = <&cl2_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER2 &emc>;
+
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -3171,6 +3201,9 @@
 
 			enable-method = "psci";
 
+			operating-points-v2 = <&cl2_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER2 &emc>;
+
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -3187,6 +3220,9 @@
 
 			enable-method = "psci";
 
+			operating-points-v2 = <&cl2_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER2 &emc>;
+
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -3443,4 +3479,244 @@
 		interrupt-parent = <&gic>;
 		always-on;
 	};
+
+	cl0_opp_tbl: opp-table-cluster0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		cl0_ch1_opp1: opp-115200000 {
+			  opp-hz = /bits/ 64 <115200000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		cl0_ch1_opp2: opp-268800000 {
+			opp-hz = /bits/ 64 <268800000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		cl0_ch1_opp3: opp-422400000 {
+			opp-hz = /bits/ 64 <422400000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		cl0_ch1_opp4: opp-576000000 {
+			opp-hz = /bits/ 64 <576000000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		cl0_ch1_opp5: opp-729600000 {
+			opp-hz = /bits/ 64 <729600000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		cl0_ch1_opp6: opp-883200000 {
+			opp-hz = /bits/ 64 <883200000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		cl0_ch1_opp7: opp-1036800000 {
+			opp-hz = /bits/ 64 <1036800000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		cl0_ch1_opp8: opp-1190400000 {
+			opp-hz = /bits/ 64 <1190400000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		cl0_ch1_opp9: opp-1344000000 {
+			opp-hz = /bits/ 64 <1344000000>;
+			opp-peak-kBps = <1632000>;
+		};
+
+		cl0_ch1_opp10: opp-1497600000 {
+			opp-hz = /bits/ 64 <1497600000>;
+			opp-peak-kBps = <1632000>;
+		};
+
+		cl0_ch1_opp11: opp-1651200000 {
+			opp-hz = /bits/ 64 <1651200000>;
+			opp-peak-kBps = <2660000>;
+		};
+
+		cl0_ch1_opp12: opp-1804800000 {
+			opp-hz = /bits/ 64 <1804800000>;
+			opp-peak-kBps = <2660000>;
+		};
+
+		cl0_ch1_opp13: opp-1958400000 {
+			opp-hz = /bits/ 64 <1958400000>;
+			opp-peak-kBps = <3200000>;
+		};
+
+		cl0_ch1_opp14: opp-2112000000 {
+			opp-hz = /bits/ 64 <2112000000>;
+			opp-peak-kBps = <6400000>;
+		};
+
+		cl0_ch1_opp15: opp-2201600000 {
+			opp-hz = /bits/ 64 <2201600000>;
+			opp-peak-kBps = <6400000>;
+		};
+	};
+
+	cl1_opp_tbl: opp-table-cluster1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		cl1_ch1_opp1: opp-115200000 {
+			  opp-hz = /bits/ 64 <115200000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		cl1_ch1_opp2: opp-268800000 {
+			opp-hz = /bits/ 64 <268800000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		cl1_ch1_opp3: opp-422400000 {
+			opp-hz = /bits/ 64 <422400000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		cl1_ch1_opp4: opp-576000000 {
+			opp-hz = /bits/ 64 <576000000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		cl1_ch1_opp5: opp-729600000 {
+			opp-hz = /bits/ 64 <729600000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		cl1_ch1_opp6: opp-883200000 {
+			opp-hz = /bits/ 64 <883200000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		cl1_ch1_opp7: opp-1036800000 {
+			opp-hz = /bits/ 64 <1036800000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		cl1_ch1_opp8: opp-1190400000 {
+			opp-hz = /bits/ 64 <1190400000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		cl1_ch1_opp9: opp-1344000000 {
+			opp-hz = /bits/ 64 <1344000000>;
+			opp-peak-kBps = <1632000>;
+		};
+
+		cl1_ch1_opp10: opp-1497600000 {
+			opp-hz = /bits/ 64 <1497600000>;
+			opp-peak-kBps = <1632000>;
+		};
+
+		cl1_ch1_opp11: opp-1651200000 {
+			opp-hz = /bits/ 64 <1651200000>;
+			opp-peak-kBps = <2660000>;
+		};
+
+		cl1_ch1_opp12: opp-1804800000 {
+			opp-hz = /bits/ 64 <1804800000>;
+			opp-peak-kBps = <2660000>;
+		};
+
+		cl1_ch1_opp13: opp-1958400000 {
+			opp-hz = /bits/ 64 <1958400000>;
+			opp-peak-kBps = <3200000>;
+		};
+
+		cl1_ch1_opp14: opp-2112000000 {
+			opp-hz = /bits/ 64 <2112000000>;
+			opp-peak-kBps = <6400000>;
+		};
+
+		cl1_ch1_opp15: opp-2201600000 {
+			opp-hz = /bits/ 64 <2201600000>;
+			opp-peak-kBps = <6400000>;
+		};
+	};
+
+	cl2_opp_tbl: opp-table-cluster2 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		cl2_ch1_opp1: opp-115200000 {
+			  opp-hz = /bits/ 64 <115200000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		cl2_ch1_opp2: opp-268800000 {
+			opp-hz = /bits/ 64 <268800000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		cl2_ch1_opp3: opp-422400000 {
+			opp-hz = /bits/ 64 <422400000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		cl2_ch1_opp4: opp-576000000 {
+			opp-hz = /bits/ 64 <576000000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		cl2_ch1_opp5: opp-729600000 {
+			opp-hz = /bits/ 64 <729600000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		cl2_ch1_opp6: opp-883200000 {
+			opp-hz = /bits/ 64 <883200000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		cl2_ch1_opp7: opp-1036800000 {
+			opp-hz = /bits/ 64 <1036800000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		cl2_ch1_opp8: opp-1190400000 {
+			opp-hz = /bits/ 64 <1190400000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		cl2_ch1_opp9: opp-1344000000 {
+			opp-hz = /bits/ 64 <1344000000>;
+			opp-peak-kBps = <1632000>;
+		};
+
+		cl2_ch1_opp10: opp-1497600000 {
+			opp-hz = /bits/ 64 <1497600000>;
+			opp-peak-kBps = <1632000>;
+		};
+
+		cl2_ch1_opp11: opp-1651200000 {
+			opp-hz = /bits/ 64 <1651200000>;
+			opp-peak-kBps = <2660000>;
+		};
+
+		cl2_ch1_opp12: opp-1804800000 {
+			opp-hz = /bits/ 64 <1804800000>;
+			opp-peak-kBps = <2660000>;
+		};
+
+		cl2_ch1_opp13: opp-1958400000 {
+			opp-hz = /bits/ 64 <1958400000>;
+			opp-peak-kBps = <3200000>;
+		};
+
+		cl2_ch1_opp14: opp-2112000000 {
+			opp-hz = /bits/ 64 <2112000000>;
+			opp-peak-kBps = <6400000>;
+		};
+
+		cl2_ch1_opp15: opp-2201600000 {
+			opp-hz = /bits/ 64 <2201600000>;
+			opp-peak-kBps = <6400000>;
+		};
+	};
 };
-- 
2.17.1

