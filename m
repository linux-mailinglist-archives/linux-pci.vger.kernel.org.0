Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8666ECCE2
	for <lists+linux-pci@lfdr.de>; Mon, 24 Apr 2023 15:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjDXNQd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Apr 2023 09:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjDXNQb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2023 09:16:31 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B664C33;
        Mon, 24 Apr 2023 06:15:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YR+P5ai1KOGNksJHWfCHvBha3Gup6POaWDOP67FJIkf6IwMQxvAhQsYBkKu2+37XuxwHr+fGBF9PW0fG7nedDmMCx4bYfLa1d8zatMdWVRQfWFzIi5q47gP3LQwRJyA9i7WSWWQd1Y00oloaKyLOAnxdBCpqa3ZPeRP5b5fBKo9w90prnra8cFvY5nFDUXWw/gpqUG7zVfi22LxeRAz1vF3eo35cMWWb5vZ2GCoVpxv2Kk2cWxbQhrc59GTZjLfrd4Gn9xwEg28f/7wBny8jwpj2Jv9l+yK8avgcWR9PuTR8gGnAT5Bm5qZRKIPNpnPWvpyAVEiUAcNcYNSS31araQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujSnNtZYvpOXFvDgiegtE9Scjpidv1UphqcDnVciXG4=;
 b=RRAARlpQAeg7zHjEzNtMxdbQpyIPZWKzFFhmHW+Udw+EXYvRxw/DttwWY5G9tJCrjr75pl21Z+1XPQBNWxjL5AIvVU0gQyW21Fyoet1zMsMjK1Ir37fE+OtqnoFxX80QiD8w98AMaWu4LQn9AYJm7w32ATmlzpx6Jtyl4YCz+3RP0VXvKfQtsplyS6oI209S25b3+C0EgEKDIIxZA4G9tZniIuRqKaYJCiHi25OZ60Kno50z0M60ARmjyga7aqJLTRQAP8xAABg1v1PmXHSC8qYu1+OAWLufeZgXEnsq7BJ9SJOCkigoOb8j6JsJ+6ddiKLaGQsIqQxeH7WZgoVMDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujSnNtZYvpOXFvDgiegtE9Scjpidv1UphqcDnVciXG4=;
 b=s8xy71Q8yaeKPNgnK8sqIRPctD4HFqFPkxxImSsifTtyPlNM+AFwliXYYiy87HzWy0lF4iJqS3QZKXxPef2iknCK7z8D26gYqygpMGarZttguGQ1VJnMWKVUnc1Hoc6nWKSBfdtRBf3Rg+yeJ4o76Ye3U2Q0U17Zib/yF1qglstMMBWq2fuMSVxMy0Sl6wIRshH5Ug75zFb/ZmjWAY9BAskgHZIUjiXssEqLG/vQ4X4FJWd0xiD0oDFhzAzf88RkT6msYF5dA30VeHKeQIQWnuqQwe1gd1ujzETF2lZn47rYfA1t6Zs/6+8Loj8yj4X6Zrq6BghZFuBRqS4AwsSpsg==
Received: from MN2PR01CA0035.prod.exchangelabs.com (2603:10b6:208:10c::48) by
 DM4PR12MB5325.namprd12.prod.outlook.com (2603:10b6:5:390::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.33; Mon, 24 Apr 2023 13:15:35 +0000
Received: from BL02EPF000145BB.namprd05.prod.outlook.com
 (2603:10b6:208:10c:cafe::fe) by MN2PR01CA0035.outlook.office365.com
 (2603:10b6:208:10c::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Mon, 24 Apr 2023 13:15:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF000145BB.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.15 via Frontend Transport; Mon, 24 Apr 2023 13:15:34 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 24 Apr 2023
 06:15:19 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 24 Apr
 2023 06:15:19 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 24 Apr 2023 06:15:13 -0700
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
Subject: [Patch v7 5/8] memory: tegra: make cpu cluster bw request a multiple of mc channels
Date:   Mon, 24 Apr 2023 18:43:34 +0530
Message-ID: <20230424131337.20151-6-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230424131337.20151-1-sumitg@nvidia.com>
References: <20230424131337.20151-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145BB:EE_|DM4PR12MB5325:EE_
X-MS-Office365-Filtering-Correlation-Id: a622a823-a022-4168-ea58-08db44c5fd25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NIXGPJ/84ccc6/d4OErGBjOfWm4Qi3KGxt8E8GVr7o8ZxjzNbFxfYB8WCxI/Gp6vL9U3duWDohuwgUoMIXDl9bT0sVz0Wos8uNmoAHXDxgcSy04WumWiSJ7/Bom615APM2CwzgDWgymPJRRkvDqA6Sys5hIk4jyD1Io3EdSqV1+2o+JJvNv/iV8pW0c4X0tOgmQ8nClwvCcBaaGu9OLl0vxML0mjwZxMcts1vo7uHsbj2VEEmmQmzgqcxhfdCDX335FjJ71CzBh4+p7O2HuUwsxFFVh5aHF9prmos6BLy3ivbAaoYGPvaUaeTbwSrhushzfrZTGoJtV3rSYLNZKwJ2qR1P5T06Y1PJxOcQhirGtEhaEhMdW008i/ibC8+Zko7R+amv9mw6X+ue78QI6qoqZrkRDkDyJIuKl2pZGMFjb8DU09EU2yxMSf4KTEAtX68K4V/0BAX2h2JoIVt2eM8epsD3rtAr3TMpOjaHjlsfvIo/Sh0UQBAWlfL1SEjXjQIeRqfMouio/GDGqdNDmoSpWqZJhCQJ9xfLL1bD+G5mvXOslthfNF7s1iQ/tJYhx7M7aFYpTk1HQCxykkwSxxS3mYhrAi+pGQ+5NdtyZtFJdycY+KQgv2LFIoaFEqHnulv1YRZGxkZmkZUTYKMHiL8ZI8ZoZwI1jr+QNnofCLEM7BnQ3knr04WSG7u90sWETbmQ6oLzLGQi82HjHd+pQASw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199021)(36840700001)(46966006)(40470700004)(478600001)(40460700003)(110136005)(54906003)(86362001)(36756003)(107886003)(186003)(7696005)(26005)(82310400005)(1076003)(40480700001)(6666004)(4326008)(316002)(82740400003)(83380400001)(70206006)(70586007)(36860700001)(2906002)(7636003)(336012)(356005)(426003)(41300700001)(8676002)(8936002)(5660300002)(47076005)(7416002)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 13:15:34.7548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a622a823-a022-4168-ea58-08db44c5fd25
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145BB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5325
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
index 0fa68862749f..8e873a7bc34f 100644
--- a/drivers/memory/tegra/tegra234.c
+++ b/drivers/memory/tegra/tegra234.c
@@ -867,6 +867,28 @@ static int tegra234_mc_icc_set(struct icc_node *src, struct icc_node *dst)
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
@@ -898,7 +920,7 @@ static int tegra234_mc_icc_get_init_bw(struct icc_node *node, u32 *avg, u32 *pea
 
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

