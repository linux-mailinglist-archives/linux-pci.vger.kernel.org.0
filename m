Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE566CAA4E
	for <lists+linux-pci@lfdr.de>; Mon, 27 Mar 2023 18:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjC0QRG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Mar 2023 12:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjC0QRD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Mar 2023 12:17:03 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502C55FC4;
        Mon, 27 Mar 2023 09:16:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZeLRiDKujfbGySFTCAoTMii+s5wtgcY2XQOIvA0Mw/XHkXnTaScIBJpFoFKYbCkgccmK3Th/V8ZQ9Bc3ybhAmS9pjj93ztU+GXzay1v+hdYHpIXPzRnX73UcTuVFHRmsMda0BBUqQu659zHvN0L+DDdHBzPxg7Gs81y+BETTtF+hdaQKv+ZfEqeGPyCVQMlksB52pOr6U9ORVIRoU42H4bkNTKYLU4VzO0Gsu7WrWUJBFPOiiI4jbPtJ7+V5srh5hbl0WD6vCRgVfdZrJhjJqlAJ5tVz7u/QtcQKSoIOnbqirPxLHOMGQEq8KlecDZaHmpMV9CagT80tw4Gbn32vmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LQKRlWl1VYSQUkJE8rTJJTE02gkh3X7VyMjYgQZn6Q=;
 b=Ckw8BpRdRFn7XO7NK9aQ97OOpSslef4la1fnVD+u8AfllSY6M3WbXj5z5ESZ2QOdfR5i1DRh28bTDKez/U3gNQxgd1wNXYuJ9pOSI1Qsi99jo30SCb4FGiO0ojAZWvMaSBJUuYyQkt3u9KjAvt1VM0hrZhzL+qrgXalLW1mHbMFF4nQRh3pdG+S0XLxrFj5yvHdMPfzM2B0YCMWKkXv6bJfu6UxHx08UBa9tIWKRxU91ksm2Vz7vyDpabgqp3S80Z4tzdl1JvlteE8iQLe1JixkFqN3ePfWDAYoz5T7m/P7Km0uEEwikKPU9TT9obpslFQhBCIMI+80BLGRkRbrD3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LQKRlWl1VYSQUkJE8rTJJTE02gkh3X7VyMjYgQZn6Q=;
 b=DlwhNaJNgMmpDu3XT4feOaI1Z8yUNFiYYwm17roqIKTinH7jP+HahA2XKUI2Orjhce06ICZBkwYYgAdP/y0BfNQOAfuwGvmIyQl993bzN8Vu8l9FEviRLr5QUHw06RlyEwMwAohiNv1tGUTo5qtJ66bJVWMZpXsz9xpiNScZHUOZKN+Lq275cbcd8dV5m3z0eipmxtKrbHv3mSYtBH0q2nNvV/d9eK/1RjbpnElAIubwLiLiY14Ui8oTWqVYYOhUTquobHTRqzeecXK1sz9NH1Z6h3RaUo+gSoYhWpw16Yq4qxFbSLO0Hql5/LBVd71AUQGMu8lRu7kCCTc/t/WL2Q==
Received: from DM6PR21CA0013.namprd21.prod.outlook.com (2603:10b6:5:174::23)
 by PH7PR12MB5784.namprd12.prod.outlook.com (2603:10b6:510:1d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 16:16:30 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::4f) by DM6PR21CA0013.outlook.office365.com
 (2603:10b6:5:174::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.5 via Frontend
 Transport; Mon, 27 Mar 2023 16:16:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.22 via Frontend Transport; Mon, 27 Mar 2023 16:16:30 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 27 Mar 2023
 09:16:20 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 27 Mar 2023 09:16:19 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Mon, 27 Mar 2023 09:16:14 -0700
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
Subject: [Patch v4 07/10] arm64: tegra: Add cpu OPP tables and interconnects property
Date:   Mon, 27 Mar 2023 21:44:23 +0530
Message-ID: <20230327161426.32639-8-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230327161426.32639-1-sumitg@nvidia.com>
References: <20230327161426.32639-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT050:EE_|PH7PR12MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: 111dc350-f3ee-4b75-d372-08db2ede9fd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: joda81liPdmAwq8CBLK9/DqPrD/fHGT8aR4lscz+z7Lp0sLLV+lX9bthYQfjLJYTovuKPyFUE6N7lW2MGFnSECSjPzBcdHwLvxVMQz9EDenznK2ZIarAR97266Pi71tjnS8Y+NztceMHqRv0e7256RCPN1dgHu3H+jpn1KKplVfbHebubxIA2p3DE6d/VpGO5UTp5Lqfq80LoBr0RkbzoCF9N12LtzhnB8cyL9bXtZNMsnuiqRwPRWTALp7AK0YJeFpTQEcVZx6os9yt7d+p8lZ4+bablbcDaUoFnyU++MQ0mzIt1sEZnGm3Y7CFMog0wQ7rkiYZlTIiOt8ShD7YF93WYbonHZXpADRjiXEN4vJZt79A4fLiduWqi9M8CL6BOosOkLZ7QuX/0U8zBe6qC1lX4ZbA0j+j9M62tWqlBjOStV8B6rom73gELCtM3AJjmuyGYrfByk7rQoTVuIPPez4RGNVzVeQqLKdq0VfJoMhINOOtmA7I9V7aSfmrGzF0Q0Wlmk1ztClK1eOWrPd4n5A9RipyuE90YnQDceyy9pXQaOvsU8ly5k4Hq4PHR+EIy5F9Y7oV4P3DtZ3co0H4JPPj6Pz9GgJnaOLOJU2JuMx7GHUSr+dbBNjuyUPs250X46OK9FzYT/ZBrWRkRTnJoS6/FvJYLYr3CeDY37XL6DDpHSf7qu0yCyjMhPZDCHev4dZXAbm7WwflJWlUEogY+DASvVRt2x02xwKJjAjQ7HdArNW3zU4w/1AwId2/D6PotQpNcHmVBYkUmpeCcMphb1+uOfXVR34+R9B3RzOyvnA=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199021)(36840700001)(46966006)(40470700004)(26005)(186003)(7696005)(1076003)(316002)(8676002)(4326008)(70206006)(70586007)(54906003)(110136005)(2616005)(6666004)(478600001)(107886003)(41300700001)(8936002)(336012)(5660300002)(7416002)(2906002)(83380400001)(47076005)(426003)(7636003)(40460700003)(36860700001)(34020700004)(82740400003)(36756003)(86362001)(82310400005)(40480700001)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 16:16:30.0375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 111dc350-f3ee-4b75-d372-08db2ede9fd0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5784
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
index 348113b4928a..6f4aa1a93688 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -3013,6 +3013,9 @@
 
 			enable-method = "psci";
 
+			operating-points-v2 = <&cl0_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER0 &emc>;
+
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -3029,6 +3032,9 @@
 
 			enable-method = "psci";
 
+			operating-points-v2 = <&cl0_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER0 &emc>;
+
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -3045,6 +3051,9 @@
 
 			enable-method = "psci";
 
+			operating-points-v2 = <&cl0_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER0 &emc>;
+
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -3061,6 +3070,9 @@
 
 			enable-method = "psci";
 
+			operating-points-v2 = <&cl0_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER0 &emc>;
+
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -3077,6 +3089,9 @@
 
 			enable-method = "psci";
 
+			operating-points-v2 = <&cl1_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER1 &emc>;
+
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -3093,6 +3108,9 @@
 
 			enable-method = "psci";
 
+			operating-points-v2 = <&cl1_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER1 &emc>;
+
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -3109,6 +3127,9 @@
 
 			enable-method = "psci";
 
+			operating-points-v2 = <&cl1_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER1 &emc>;
+
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -3125,6 +3146,9 @@
 
 			enable-method = "psci";
 
+			operating-points-v2 = <&cl1_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER1 &emc>;
+
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -3141,6 +3165,9 @@
 
 			enable-method = "psci";
 
+			operating-points-v2 = <&cl2_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER2 &emc>;
+
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -3157,6 +3184,9 @@
 
 			enable-method = "psci";
 
+			operating-points-v2 = <&cl2_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER2 &emc>;
+
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -3173,6 +3203,9 @@
 
 			enable-method = "psci";
 
+			operating-points-v2 = <&cl2_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER2 &emc>;
+
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -3189,6 +3222,9 @@
 
 			enable-method = "psci";
 
+			operating-points-v2 = <&cl2_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER2 &emc>;
+
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -3445,4 +3481,244 @@
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

