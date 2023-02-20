Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA82E69CEF3
	for <lists+linux-pci@lfdr.de>; Mon, 20 Feb 2023 15:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjBTOIc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Feb 2023 09:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjBTOIa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Feb 2023 09:08:30 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2CE1040A;
        Mon, 20 Feb 2023 06:07:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYIGOnn3TpPEKXzk94Uezd/plYsIYyiXnR5auvqpIL0y+65vCltBc3LY6i30NqAfFphu3w5CJQxW89tvKA1zEON8fFUYHGmhPtJnMOc/H+KpTZEvY1B5jBUZQSxFayCL+Ahsny0ST375knrbvoufEvSdiARu75KL2Lr40yz4IE4/3C1AEzhl6N9aQbrnMft0Xy8GibIdYs8EnM5iYXfqQ+OoURMnN9YeBVnsaNmix89JO972vgzFcnhavUqV/QOLiYcxZbsbO2IH7aj2IcGNse0hCJGlOGGAvWN3eS6yvudcZWeRqn50UBHawXSqn1xYszpRBpVCfiqPpUzuC8c0aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLp4z+GGs3H4X4hg+ilCUo+bXq/mVgdmKEL2Ne6dbQ8=;
 b=mSv9F8++3GiFPacGz+fFvITRB55OsJXy3uKfkapiYQx+1SgyURfxTMhlJThoMx4FOaEPxAgmdnN8oBydqJ33loicXXb2hvtyXdYQtNWA9r8Iz8nXO+BHvJyaJu0Jq3i+RLKQP0905Kk7zleDG4ckOe/aSDHUJVJpr5eQjCYDLVgMyN1MrWow5jN2wxEDCS6DZNzh5kt6KVYhNPPA2lw/9MMY8EU6lSVzATrTLMtsQ8PSuzegy5/HtbW7atrXbz7xN//m1ZFTRT+UGiLO1eEs983TY7hbOZNAOn06W3p09yQslfwBVos7wamNFPF6HaJbawX8XDya9AIOih3voKg0KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLp4z+GGs3H4X4hg+ilCUo+bXq/mVgdmKEL2Ne6dbQ8=;
 b=iFupKxi+01fsiAKhmWCB3xqQvQUynhUPV0iFFk0e4Q6d3shFdZjSbZPXSl3LRiWcJQmiH18rv4oopSKcIfXFo+Ns4gtbpAeiu4sisKtR1RXu+5FT3zHZINdQ94L6/26DBSPjWQsOr5L0iQ0hNtn0gccZ6hj5CVCIJfL/6Z8yaPTSDDRPNkczazbu47lxyf+jRE1IdsxoLUlJigL4hE1G7E5RBvzxD0OoCXPSP/EBjBbfKlPI4rVmoNpxh0u1S9xkZiYHhCM3WiIIcShixvXMvqzE2JuSqZOpYMthhxCJWPzDUXBg8WEWSNDLYudW/NB8Zx/J+R7Oupe8I2qSUtPFoA==
Received: from DS7PR03CA0174.namprd03.prod.outlook.com (2603:10b6:5:3b2::29)
 by PH8PR12MB6843.namprd12.prod.outlook.com (2603:10b6:510:1ca::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Mon, 20 Feb
 2023 14:07:49 +0000
Received: from DM6NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::83) by DS7PR03CA0174.outlook.office365.com
 (2603:10b6:5:3b2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20 via Frontend
 Transport; Mon, 20 Feb 2023 14:07:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT108.mail.protection.outlook.com (10.13.172.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.19 via Frontend Transport; Mon, 20 Feb 2023 14:07:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 20 Feb
 2023 06:07:44 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 20 Feb
 2023 06:07:44 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Mon, 20 Feb 2023 06:07:38 -0800
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
Subject: [Patch v2 6/9] arm64: tegra: Add cpu OPP tables and interconnects property
Date:   Mon, 20 Feb 2023 19:35:56 +0530
Message-ID: <20230220140559.28289-7-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230220140559.28289-1-sumitg@nvidia.com>
References: <20230220140559.28289-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT108:EE_|PH8PR12MB6843:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e618398-ed19-4d3d-f895-08db134bd978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O3cSRjXcPEh8ZDATi4X1qeZhWuSlOeg915RW3wF2mN4S/GEMeTlZnOmXmnuvmhEa2Q4+foq0li+ix+qiGsI5uKy8OBRFXF2AOh7XzkPAlfRG8F6DhvDJ7OOkZEX5myMe3WItwY1YFyjgNDpuetn4oGi1wnThFLoGyc/+31M72ZQ4DMp8TuSUuvdAOpmDExHxQGh5YNAeR1/s4OntLalrHECURc3WXIN0c1nXeMO4ZNqHBlMvuzRT4iN+mHFfPKMqmtlu+B+/n7B7OERlOm6Ad/Ctc3wWR0NRsQHbwCjIa3xAMX8Vptqyp8NxyDn5Bk6GBqlr9scjs8dqesQMIyZW7lazejUS0z3IOSpKYbLN5R+iQZvIjBR03woMG/EGruNiBtIw82Np21mIIRnTXuRb/L6PFrZ0XfQLMN/+zxCq+NaweIAsReiwB8SUtdiX0hO9ajnDh/MO5HVTUonlizTQ1vCrkN6ZKn12Ucb89H4aN5EpRrP8bUAOBTY+x5K25nPeDqeRP5rkT4w37FFZzk/z0g88mJ5mjt5tIcPLDk5NBLDFHPLqIgmb3WajBDiVbB/wRxmQpmruZshCqMUoqfPpE31D+4dXEhUY2AeLUjmgpbZFe1Ob7dogU5PlRJXCSu/zRmNddXH7bJZBCRy/S9n4LHx9qu/Hvibtb0mPfYr330YrWTgdF+4tlqpDIkUl5QLh6DQ7OqX0q/lCERLLPLG3Iw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199018)(40470700004)(46966006)(36840700001)(186003)(26005)(4326008)(40480700001)(8676002)(7416002)(2616005)(70586007)(83380400001)(8936002)(70206006)(7696005)(6666004)(107886003)(1076003)(5660300002)(36756003)(336012)(54906003)(110136005)(47076005)(426003)(40460700003)(478600001)(356005)(41300700001)(316002)(82740400003)(86362001)(82310400005)(7636003)(36860700001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 14:07:49.3553
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e618398-ed19-4d3d-f895-08db134bd978
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6843
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
index 8fe8eda7654d..e995df13277d 100644
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

