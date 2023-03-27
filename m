Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1E16CAA5F
	for <lists+linux-pci@lfdr.de>; Mon, 27 Mar 2023 18:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbjC0QSW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Mar 2023 12:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbjC0QSI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Mar 2023 12:18:08 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492AC5FCD;
        Mon, 27 Mar 2023 09:17:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpQHDvFD+UWtTPszq0n7r6PZYWEjCLA4/ZNyz4jToCUlJ9VLjZZ2HEVdLBAlDKs96UHHTXGu27XiKudodlWPxsf41SkF1LFrksKO5hphtX+e6sV8Gq6bKZs+oe0D7Q37HweEUniAs6MvSXHAqjmh4KNOTcxXi4vDCgnZ8zbRBgFFeNdDS2S/f8IAGZOPLEDqLNloZOPATJQhL81uGI389yF64oklaYM/HCQ9Vj0lT+CQ630cGpzFgMESYgPpGsVMcnhQ3JG5LngH202icOHEJmtC90CkHfSmogj5GEG0Ndy7EpGzNPmpB5LJcJVB0QTWpG4RgzhFSS1JP8H+9ee4fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaD6PkZdMnITpuNZew2Idq2D7r94KCfbJmxzawpB/GI=;
 b=B7EnLszQZZ3UNxTK4hEuTeFLg6K3l9N0pwx3rhBE0PzNY7Ph+4DyIrrQ8lJ1tx/TnQ1MnyPaz3Av6heA0pbBeh1zhyE+ix80+5tcqsJa/UA/6Ls50D+uc0ZQPXcDAKJvWCjjiR+VXWC6AiKnj7O7tlKIV43MIbn1PUDeMwSfeEOVgBGrli1pIgG187Tb5r8OhEhHplHCjAnXjQyO3BoQWioAASvzRsEqT13yn1lhCVh7lBJXWlW6j+2zY1n+ZFmq7k4QlWGH8wEfsrC2x+fLDmYO+klFP0MeH1yzjfxVaflKtoX9i1ZYyZC7GPxMxtuwea1qu7nrigem7Gms8zlsDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaD6PkZdMnITpuNZew2Idq2D7r94KCfbJmxzawpB/GI=;
 b=j6e0DjjDRdC30HlNJB1u4pK9/+0BapHNqR/15uL/lf5T8MsAD7VMmJxBdTLVITzMa+B9I67fVXHX1DQcAvjkFw+MBtoStFVLdVfO80kzbXVkqp9Op9kgsa1rja2WUVQg0DLPbckbmIbhJ63qpDEYkq7avQbTkaO4Pf56A8g1AQ62cgTveubkYxyz4wI3PQd6YJNYB3bsBfcNduZvUDDn07yXLGR6KTO6L+nbu13jfhYksR8DKeGEhkfhespEpawmL1mVTsdnAXZgqke+BVSEh1TcruDsaB2ViKn1SGjBR8oHORUTKJZwssVS9jmn0xz3L6PzlPMSnd073HvykOt0ag==
Received: from DM6PR18CA0024.namprd18.prod.outlook.com (2603:10b6:5:15b::37)
 by SA1PR12MB8920.namprd12.prod.outlook.com (2603:10b6:806:38e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.42; Mon, 27 Mar
 2023 16:17:18 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::55) by DM6PR18CA0024.outlook.office365.com
 (2603:10b6:5:15b::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.42 via Frontend
 Transport; Mon, 27 Mar 2023 16:17:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.22 via Frontend Transport; Mon, 27 Mar 2023 16:17:17 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 27 Mar 2023
 09:17:09 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 27 Mar 2023 09:17:08 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Mon, 27 Mar 2023 09:17:03 -0700
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
Subject: [Patch v4 09/10] memory: tegra: make cpu cluster bw request a multiple of mc channels
Date:   Mon, 27 Mar 2023 21:44:25 +0530
Message-ID: <20230327161426.32639-10-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230327161426.32639-1-sumitg@nvidia.com>
References: <20230327161426.32639-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT012:EE_|SA1PR12MB8920:EE_
X-MS-Office365-Filtering-Correlation-Id: 615a8500-7e90-41fb-290a-08db2edebc55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +eMb+izclqrAwRzGrdBf670U9Tv/RryrCiRnO95Aj1IsxKcnAQsE4vH5HBpDbzWWmODO8LtEJiPTZvQ6m2tM6SaKimpKwHUuN0s8Wgd5in5aXgL13FpuKXoD5O5o/XsbLnNQSNLVi2hCoDZ0wEJzFzt31B3GCOfVydKd6XzbL6T0JEGfQ8sv18CXFMOpLbEzfblIWM0mm1wSdWwy+G5l/kMco0Rqc7qd6CT3TPw8y56TxSoZHml22Nx2eAvZ1o+xjVhS0vA4ymw3UgW4pNAqhiRMPzUJCODgAz7zChPSM3EBkoZUq4S97ehzouhslyGPG80maxOeA/QepcUqjAbvt6RpxHuEQgM0vUJBToVXxGlADCWES4ZnukL8jSUhJ113Z6VZFrHQA8RL4JxnH49wDp93W9ZLwo2yohG4Rs6WH7b5sYgjcdudIusR71tJ2+a+a+Eu8uMHJ0F5lGQxxTy+x3i1O0mv989mqnEQZ/g8kIK+TWk578sZt/bVsCSQjp+MBBTgf7YrFiAKzzXXoKLz5MrwxTtlA9nDxBQCREhIP3zbWPtzOkV7nVgfFq5RpkZP0NPrTWtSuJRufrwFNClroOZF4keqk/SSSSy7v/DyLKPVy1tHmNC4kDbzDxKqqRcXXENQU0oTR2TR6P/ijf/frCuVXru5Aeo52JlDGK7gy3mmvyC6gduRiWRfjvVOTQmspfTlRhtLHiXC5BwsUFlVLRdzdzs2jAYOAGn1EyAVdQsxMCR9bVlOLcLGv/J3GsIv/92KeMH56ulRqoXr1uGAAPEbzp5mB5YRD8AQMmo9VQ8=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(41300700001)(8676002)(70206006)(70586007)(4326008)(186003)(83380400001)(36756003)(34020700004)(5660300002)(2906002)(36860700001)(336012)(7416002)(47076005)(356005)(82310400005)(86362001)(426003)(82740400003)(7636003)(2616005)(8936002)(40480700001)(54906003)(316002)(7696005)(110136005)(6666004)(478600001)(107886003)(26005)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 16:17:17.8809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 615a8500-7e90-41fb-290a-08db2edebc55
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8920
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Make CPU cluster's bandwidth (BW) request a multiple of MC channels.
CPU OPP tables have BW info per MC channel. But, the actual BW depends
on the number of MC channels which can change as per the boot config.
Get the number of MC channels which are actually enabled in current
boot configuration and multiply the BW request from a CPU cluster with
the number of enabled MC channels. This is not required to be done for
other MC clients.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/tegra/mc.c       | 19 +++++++++++++++++++
 drivers/memory/tegra/mc.h       |  1 +
 drivers/memory/tegra/tegra234.c | 24 +++++++++++++++++++++++-
 include/soc/tegra/mc.h          |  1 +
 4 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 983455b1f98d..4a750da1c12a 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -843,6 +843,23 @@ static int tegra_mc_interconnect_setup(struct tegra_mc *mc)
 	return err;
 }
 
+static void tegra_mc_num_channel_enabled(struct tegra_mc *mc)
+{
+	unsigned int i;
+	u32 value;
+
+	value = mc_ch_readl(mc, 0, MC_EMEM_ADR_CFG_CHANNEL_ENABLE);
+	if (value <= 0) {
+		mc->num_channels = mc->soc->num_channels;
+		return;
+	}
+
+	for (i = 0; i < 32; i++) {
+		if (value & BIT(i))
+			mc->num_channels++;
+	}
+}
+
 static int tegra_mc_probe(struct platform_device *pdev)
 {
 	struct tegra_mc *mc;
@@ -881,6 +898,8 @@ static int tegra_mc_probe(struct platform_device *pdev)
 			return err;
 	}
 
+	tegra_mc_num_channel_enabled(mc);
+
 	if (mc->soc->ops && mc->soc->ops->handle_irq) {
 		mc->irq = platform_get_irq(pdev, 0);
 		if (mc->irq < 0)
diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
index bc01586b6560..c3f6655bec60 100644
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -53,6 +53,7 @@
 #define MC_ERR_ROUTE_SANITY_ADR				0x9c4
 #define MC_ERR_GENERALIZED_CARVEOUT_STATUS		0xc00
 #define MC_ERR_GENERALIZED_CARVEOUT_ADR			0xc04
+#define MC_EMEM_ADR_CFG_CHANNEL_ENABLE			0xdf8
 #define MC_GLOBAL_INTSTATUS				0xf24
 #define MC_ERR_ADR_HI					0x11fc
 
diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
index 4c8929a88778..23597e3c2d28 100644
--- a/drivers/memory/tegra/tegra234.c
+++ b/drivers/memory/tegra/tegra234.c
@@ -872,6 +872,28 @@ static int tegra234_mc_icc_set(struct icc_node *src, struct icc_node *dst)
 	return ret;
 }
 
+static int tegra234_mc_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
+				     u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
+{
+	struct icc_provider *p = node->provider;
+	struct tegra_mc *mc = icc_provider_to_tegra_mc(p);
+
+	if (!mc->bwmgr_mrq_supported)
+		return -EINVAL;
+
+	if (node->id == TEGRA_ICC_MC_CPU_CLUSTER0 ||
+	    node->id == TEGRA_ICC_MC_CPU_CLUSTER1 ||
+	    node->id == TEGRA_ICC_MC_CPU_CLUSTER2) {
+		if (mc)
+			peak_bw = peak_bw * mc->num_channels;
+	}
+
+	*agg_avg += avg_bw;
+	*agg_peak = max(*agg_peak, peak_bw);
+
+	return 0;
+}
+
 static struct icc_node*
 tegra234_mc_of_icc_xlate(struct of_phandle_args *spec, void *data)
 {
@@ -903,7 +925,7 @@ static int tegra234_mc_icc_get_init_bw(struct icc_node *node, u32 *avg, u32 *pea
 
 static const struct tegra_mc_icc_ops tegra234_mc_icc_ops = {
 	.xlate = tegra234_mc_of_icc_xlate,
-	.aggregate = icc_std_aggregate,
+	.aggregate = tegra234_mc_icc_aggregate,
 	.get_bw = tegra234_mc_icc_get_init_bw,
 	.set = tegra234_mc_icc_set,
 };
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index 900d88b26fae..fc3001483e62 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -234,6 +234,7 @@ struct tegra_mc {
 
 	struct tegra_mc_timing *timings;
 	unsigned int num_timings;
+	unsigned int num_channels;
 
 	bool bwmgr_mrq_supported;
 	struct reset_controller_dev reset;
-- 
2.17.1

