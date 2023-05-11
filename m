Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454C86FF899
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 19:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239023AbjEKRf2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 13:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239003AbjEKRfV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 13:35:21 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421F44C20;
        Thu, 11 May 2023 10:34:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lum1AXgS2lBG9rq1twYzMrMeeZdzBnhwfdv3/0F0ra/bdE2CKYptw6Y6lqWk8bN8S2YGXEyj1Pn5sn0mD1un9NvejJlzht1Ys41WQoGnF/Nis0JyOauz6pTTerGDbEH0+JIcICgqpYxqqzgaIJcvGk9kSm7Y59Ej5YmztQa+Cm1nGtC5b3LIH1hm5j2Khin2wD3ZxgrH9NGk17yaS4Fzuv2lc8KIyq+PBk+MDLcIlwqN6JF3hJemGpINonRHFdd0lsl1LBiQKVjbxxYrTzxCaswNPZ9lQpgchxHro4ueo0M7kwIZ0PbIEwIlCkYhGSnsLYyjL6n65Q0MKeI5NeTNFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tU9N2E+O5RQMp+P6dbSfyoMriMoWwr9hXlRHae/HVZI=;
 b=O69uBO9fAcV0j/5V3wdrmVZUxOliFTkCNpqVEOwgOAxUk+9EdNiFxfLeeGGBpmiuk50PI8TpefqsL4+SdJHyxyrMxxGHh+TDLyhN3Z0YWAFcecWW+76AJrPjN2psET1wHPFa1FYJTq7P+UuXlyiHQtsrc0zMXMI8S2d9krfF7D9TXQd7x4jzbVVxFk8a7I0Ue6eTuynp5BlGvQzDoQr/9WOKTBzgpPDL9ZmIY/o+asQfnz8hA3m/eu+T8jTo03jcWSEnwvpw1/R6evBJ0/rQ6LGeOfNU9K6EiTvem8An6MTzxdb04YY0UgL0G7BYTWD8Y2Etlc7iLcWrjMK5hoceuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tU9N2E+O5RQMp+P6dbSfyoMriMoWwr9hXlRHae/HVZI=;
 b=avEaWKA7BHnkd87H5ltw/yYUAWR/dWk3RRX9RVEMGZjdkIVWVQW334kHIQa8Q3Rn6vZEJTK2yvUnXXT1s0OXJlBLfdXXT5+wqWQGrhbGsoIxjOoDVJHLSOjb2xNK/dvVJSG2pJUS9zDn6CXjaTS7ZT98qaKkYtB/9DQIpMj63cp4YqRtKlBIIESQ1NuAFi32B+8HU7Ugn2PExc119DumlyXWfwDysLK2McYMzp8ZPJrhkw3pHIIzW7LmxXjh3LIlyZBmilQD45FXdlzHOas/UmbY67JDiRRfW4rJ6KHWmLHJe5N3WqXkOhSNM0wAjDNVwbX5JlaVDFv0a9xrDENIwA==
Received: from BN9PR03CA0361.namprd03.prod.outlook.com (2603:10b6:408:f7::6)
 by PH7PR12MB9255.namprd12.prod.outlook.com (2603:10b6:510:30c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Thu, 11 May
 2023 17:34:07 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::71) by BN9PR03CA0361.outlook.office365.com
 (2603:10b6:408:f7::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21 via Frontend
 Transport; Thu, 11 May 2023 17:34:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.22 via Frontend Transport; Thu, 11 May 2023 17:34:07 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 11 May 2023
 10:33:58 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 11 May 2023 10:33:58 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 11 May 2023 10:33:52 -0700
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
Subject: [Patch v8 8/8] arm64: tegra: Add cpu OPP tables and interconnects property
Date:   Thu, 11 May 2023 23:02:11 +0530
Message-ID: <20230511173211.9127-9-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230511173211.9127-1-sumitg@nvidia.com>
References: <20230511173211.9127-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT066:EE_|PH7PR12MB9255:EE_
X-MS-Office365-Filtering-Correlation-Id: bea1db65-0569-4891-1a33-08db5245ec84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9DCfQiYXaX2rh48D151N9WZJRJ3G+QLQKCpWUa28CAtT9YGHCLwJRo/VuEa3+witFTE9yTHKLol6TKy+5W7b39OyZt6csEtbFkbqcL/qAKGSGobZ1QcXCLXdmPyBRm3wsnTYfxDbM0eBfLvAAmTSO6XjLf0UH5qL6vyUzaoC4EVOI5DPopP88SUkEZXuQS1znFqXcwmJktM3iUeuU7m+e5hH1hVz5BXc351QVflOA32t/8b+A2yr066x3h/j93Zmf33UF4qyMBzlmlSi14w8ZCO4jVZ6mCtxru5d+J3FIex1RLQV4NPLawT2Ol5JEu3AXgtAhyDmO0ClfZpUwkQDBfM8rBjkExe95L9Lacvm8vcFM8kaAwbA+wT1nc4msZK7ug2k/+vlefHz5mf+viTGFJYnW0WRejrI8X4BYwH+g881Xhd84UYp2qLMDDVsP0V9+BNFPdAP/fWZvDUxoWCr2Ii7VcTdfsHrjS0Szl8B9HU3RjP+xDJkOxQ6hBPdO9pa2LzFkI/S3pZkjLXZIUKkOT83xkqyM27TseAz7nhfnsZy8y98+Vl5X1Q1r1JCXnOSgFFjTjzWwm8y68A5NTHTGiKiY2vhk5hb8diHhHGBj4AKGRhrrB7DK9n+U2fMe+A6EiPeESMOKmJKUBjhTbrefyEUE5mNbEW10vw+tIsZto1iCJgDNB6FIcz7z4PdenjmvKkjJiSf6jDFR38/s6lEzSUIm8KyQ3Vr1FsZBvJKyZ1jqvN1UzvWXcPyGbf9HvJG
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(83380400001)(54906003)(107886003)(110136005)(47076005)(36860700001)(40480700001)(7636003)(316002)(356005)(82740400003)(26005)(1076003)(41300700001)(426003)(5660300002)(8676002)(8936002)(70586007)(70206006)(4326008)(86362001)(336012)(40460700003)(186003)(6666004)(2616005)(7416002)(478600001)(2906002)(7696005)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 17:34:07.5483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bea1db65-0569-4891-1a33-08db5245ec84
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9255
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
index 18b4c2b2c42c..97ed3e0d892a 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -3028,6 +3028,9 @@
 
 			enable-method = "psci";
 
+			operating-points-v2 = <&cl0_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER0 &emc>;
+
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -3044,6 +3047,9 @@
 
 			enable-method = "psci";
 
+			operating-points-v2 = <&cl0_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER0 &emc>;
+
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -3060,6 +3066,9 @@
 
 			enable-method = "psci";
 
+			operating-points-v2 = <&cl0_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER0 &emc>;
+
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -3076,6 +3085,9 @@
 
 			enable-method = "psci";
 
+			operating-points-v2 = <&cl0_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER0 &emc>;
+
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -3092,6 +3104,9 @@
 
 			enable-method = "psci";
 
+			operating-points-v2 = <&cl1_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER1 &emc>;
+
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -3108,6 +3123,9 @@
 
 			enable-method = "psci";
 
+			operating-points-v2 = <&cl1_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER1 &emc>;
+
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -3124,6 +3142,9 @@
 
 			enable-method = "psci";
 
+			operating-points-v2 = <&cl1_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER1 &emc>;
+
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -3140,6 +3161,9 @@
 
 			enable-method = "psci";
 
+			operating-points-v2 = <&cl1_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER1 &emc>;
+
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -3156,6 +3180,9 @@
 
 			enable-method = "psci";
 
+			operating-points-v2 = <&cl2_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER2 &emc>;
+
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -3172,6 +3199,9 @@
 
 			enable-method = "psci";
 
+			operating-points-v2 = <&cl2_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER2 &emc>;
+
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -3188,6 +3218,9 @@
 
 			enable-method = "psci";
 
+			operating-points-v2 = <&cl2_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER2 &emc>;
+
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -3204,6 +3237,9 @@
 
 			enable-method = "psci";
 
+			operating-points-v2 = <&cl2_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER2 &emc>;
+
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -3478,4 +3514,244 @@
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

