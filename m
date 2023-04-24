Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D206ECCF3
	for <lists+linux-pci@lfdr.de>; Mon, 24 Apr 2023 15:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjDXNRF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Apr 2023 09:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjDXNQ7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2023 09:16:59 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6092E5259;
        Mon, 24 Apr 2023 06:16:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDWvpL1OHQZ//WeGJSzYo4cygC05IS+qTCexvJZfP2koQPi0ZDtloUjgtTJGprOs77GAxOcenUl/+zgs1x3a1BZ3oykgX6HsNV1M3HnyObNtxLb/3vJCMN9/IB+QtKJSEYXm2IvElyoqhSmxo3IYEqlMNLtk3iBpmtGoJLJ0oth2xuJ6pFexT0SJQHesdb88VEb3bU3JKLbAn2NwOHGfBJP9y7+B+Yt8zkyqqlO6JYGVlNCiH6Lc2OORS7Cb1+sp4ARheIOZuugpeYi3w6wEfdlztxZz7KbIntMQyCU3LdT3pKW0EVbiMh+obCHNzhb4fFVAHir3GQZCBeQkObzgFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nsMtliVfQ4xVQKkWlDg78TRz0LuP+gntsRIi9bqP48=;
 b=CSXdf7uee0XJF2J/55SGrMEZTABgnhNrtp7qMwx0oQAM4ygssY5656a4qFAnvePEhWlDipCDmRrfaUdbCBk6AQmXun34luZJg9luJL/skBfmzRRvLH8U5kXRAgIDCfQRNPrDOdwXymvkqaxWaiYG3VIoA9c+SMDrLbFQLsFvBQE8bMRPBqBMv7230DyZuAgTWt/+u0Re19Cfw7nyXrgv2bXBLYETinUkFplDYrNGwN8riP5Dp5RCyVEv86NSjg/OgNvBjtqmwEqidp/reBJdsVSiXDTR1BHArpfBEzanFbAe79vogWNzYdjRSYmJqnysPmNzu+MBXp1HwtZBkTi3Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nsMtliVfQ4xVQKkWlDg78TRz0LuP+gntsRIi9bqP48=;
 b=ZxGYfgZEbw/iX6f0Qkhs7H05dEQSo/jadjDk+yQ/Axq6C4oIWj8+zt3+woG0rM9fiZ3IlnU+0jbvapNwLUKVd/AdU6tpsJ0OTpr/8pH5gO7pIf82fGH5CK0Db8i2gorSUCHkVu3kWZaDnJgV263l4KpY0wR6z4WEvaRdLWJfzoxs/Jv1g1UKQjpZ80M9Ig21SdzQTU7wBsjgNH1HvKWJ5gbkAAuvUmAocBv1C0JndN9d6GT62S3XxkrHRX2i9j6oxQN0hw46+KHjdhjhqBMeqrfSSQZ0T2iiXfrgQbzEGC4708lvGXwNWaS5rfFZy3T8FZ/uRjv5D3XCfE5eAF9sBg==
Received: from BL1PR13CA0400.namprd13.prod.outlook.com (2603:10b6:208:2c2::15)
 by DM6PR12MB5024.namprd12.prod.outlook.com (2603:10b6:5:20a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 13:16:01 +0000
Received: from BL02EPF000145B9.namprd05.prod.outlook.com
 (2603:10b6:208:2c2:cafe::dc) by BL1PR13CA0400.outlook.office365.com
 (2603:10b6:208:2c2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.19 via Frontend
 Transport; Mon, 24 Apr 2023 13:16:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF000145B9.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.16 via Frontend Transport; Mon, 24 Apr 2023 13:16:01 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 24 Apr 2023
 06:15:46 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 24 Apr
 2023 06:15:46 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 24 Apr 2023 06:15:40 -0700
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
Subject: [Patch v7 8/8] arm64: tegra: Add cpu OPP tables and interconnects property
Date:   Mon, 24 Apr 2023 18:43:37 +0530
Message-ID: <20230424131337.20151-9-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230424131337.20151-1-sumitg@nvidia.com>
References: <20230424131337.20151-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B9:EE_|DM6PR12MB5024:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a6b79e4-7439-4894-8e27-08db44c60cd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T4vvTfGDPDNPx8uky/m8zP5E3yNtQvaqxrqSnzYDD1ARMPHFMaImPw7rdAAZ15S2kOkBWkQeCUzBxQ1bsBlQQNR96abWYu6JkBCHun6YNFVc9OHK421Aau+PaeqUGGknuL9huDlkApZ3yWYkStyVI+tjDc7tDckBuDJo2UsOxgja1GiU+TX/nHmkIduhpSM4eR5KuhQZcI4PNDK6jjmwmEjnnvrkAnXSmsU03je1aRpqludPQCCctV6mbVFEQ6py8xwPGEfVrZxfMkagrAN93VS49RUHGMVBLJrE+ktrJelrMk5EvVqMbspCG960bb1NI9ow2n0PkNbOaOalRp3iwthSsPZCC3ZAjxKKjDTEiwsG0HXqCbYSPB0pLx+2B/bw9o4blbd8Z4ZeJwrcAZ0bOBUj5Qs5+9RLW83bepQDZw7/XrSSRON6Krc67yRoZ5VL+e1buDdjDcSyLuTS/a7EOo4U0mroPBIHfjoWNvNFuKh4LEuuIC2NWMmdS7C9+u8HK8VBzI3QzFdge+ZWJcvVMCseexJoXzZWeN2aHmMI1y8suE0rEOK/gCeSuoXh75TlkOX9qdbOH8aewGjUUbSXY4WXZhmvTRb7XvWNgELZU7ytSSalVSvN2iUoqbwdgyHCMVkAFHA1iiVBIyQN3ix0FICjZ/YByLhqL8RszyJ60SXWDk2wS4G5UDCIfOevH9i+dLTUBU/Af7rr1n/EmZT8BQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199021)(36840700001)(46966006)(40470700004)(478600001)(40460700003)(110136005)(54906003)(86362001)(36756003)(107886003)(186003)(7696005)(26005)(82310400005)(1076003)(40480700001)(6666004)(4326008)(316002)(82740400003)(83380400001)(70206006)(70586007)(36860700001)(2906002)(7636003)(336012)(356005)(426003)(41300700001)(8676002)(8936002)(5660300002)(47076005)(7416002)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 13:16:01.0455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a6b79e4-7439-4894-8e27-08db44c60cd1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5024
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 5d354f8923b4..8d0b89b5733e 100644
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
@@ -3461,4 +3497,244 @@
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

