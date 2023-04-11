Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1E36DD8A6
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 13:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjDKLCR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 07:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjDKLCB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 07:02:01 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD4846B1;
        Tue, 11 Apr 2023 04:01:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGg1lTVQjnRLF2+C4KdKs+h6w7WQTES3uKEVRowa5v4iVRkgoNLzHvnA2cPdjgId42IrWyusRzZQQaPWN2V/T8GjG0Ps0w1SWPcu8JhJIUjARCpkqvKa9YVMh2SmTdKhcuhXhPZU3p16xTJ/Fu+eEdSPwNiw54UsR6FS6sQIhNXLzn2wf/lx/ICIGCHABaO8IgZPOm1X4NgwjJXsgaNKnArwoKgqWat6kOXLEFviaQ9uA+9SGTRFefjblZXF49+rVGvSxPgFGJYP8hcoBeml1w14bVPk99UMbv/2xH10bZUEewwxXxTIF1m0M6iZlHEo6MAxIS58YLrx4ycrtnEdiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujSnNtZYvpOXFvDgiegtE9Scjpidv1UphqcDnVciXG4=;
 b=A5t9KQJP1uU9jm3l+Ha9WDSGAtTX9ZzgHyvAvzvkUuy1T2z3dVo0GOJI4B9NFTvvoz8S7o7ICRHabMzzm2j/PtegkovKnAaPnexBljtgr9m1/QwWV50hIOtRo5w9R9HWwqd2QDXJ6oVmfRG4JsisC7U/m+Kn+gp0P+uZVUMv2SLpWHfC27F+hq2/jQDNcqfJSn0ro4KpCKOvPQMjO9kFcTWCg1I9KSEAKyAWKZt9ojQoyk8mHXeytEyE61OrcDkNiC/Qm858x1J3b7LSkeRyr+VKHkMKLmM79uaecZMmMfem1S84Ifll7zvjOa+Exwcgkvi81xDdz0Gv1MgznCbaZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujSnNtZYvpOXFvDgiegtE9Scjpidv1UphqcDnVciXG4=;
 b=suH7B3lmENzewR+uokbQPZ0gf1CaH13eZ9SCMq2ZwT8NDNwWRWoGz5TS4/y5BoSmpwyytCAQM2lXDz0A8MFkN/nJF64CDYB36wyrMomyp7M89X+0QHLpRM0bi7fHq55Km2yEl7m5kP9W4i/3jovBOHIf+ydLKNfxcrsHVVV0FKEA5EUy2xZrIHmNrfoF1t8mM/+38MfURC2aGNmrZtdXzPvgZJEzNIGTInA1P9OQYYM1YkrZyn/RC7dxisX0SvhDjLF8s9YsExED+GJSNLba/m3kHC77V2V8tc+ApT/qT2ywhbii7G+0HkIG9mEihvXs4N6J/O+Dvy4m242TAwuBSA==
Received: from BL1PR13CA0074.namprd13.prod.outlook.com (2603:10b6:208:2b8::19)
 by BL0PR12MB4898.namprd12.prod.outlook.com (2603:10b6:208:1c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 11:01:38 +0000
Received: from BL02EPF0000C403.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::a4) by BL1PR13CA0074.outlook.office365.com
 (2603:10b6:208:2b8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.27 via Frontend
 Transport; Tue, 11 Apr 2023 11:01:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0000C403.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.25 via Frontend Transport; Tue, 11 Apr 2023 11:01:38 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 11 Apr 2023
 04:01:21 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 11 Apr
 2023 04:01:21 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 11 Apr 2023 04:01:15 -0700
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
Subject: [Patch v6 5/9] memory: tegra: make cpu cluster bw request a multiple of mc channels
Date:   Tue, 11 Apr 2023 16:29:58 +0530
Message-ID: <20230411110002.19824-6-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230411110002.19824-1-sumitg@nvidia.com>
References: <20230411110002.19824-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C403:EE_|BL0PR12MB4898:EE_
X-MS-Office365-Filtering-Correlation-Id: e6a89552-d469-4bb2-86a2-08db3a7c1fe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I2eMI46pMPBzJzJcTWFF/4RJgPL4ndu114iHH//5uZZxEj76+7NGGDHM62FXMKhv4luK8RaAOXt9SvKSDmEyfhq3af778xkJcyUVsy7/xOL6G/yPc13QAiDOqMa52w9W+/OokHLl4Dy8nUvvPWsXnNHV+vE/PGiPjh0umMd5UcfhTog3JMoiEILJXDjzkqOMQsJXHOjnEe1GOqXBy1Z6G0ID/PPIekT7raFk/vkED+H8NFpcTv3XEzQJtQvNmm1hbm46VMY4WwhM2gVfSG2AaIq9e5rPok+aPPVnHxcP+8w9ZidLOjJa6dNK41f4J+o2rxyqyu6th4X9RiFdDPG1AvGh6C3/zJ6Fznn4QVwz3nrakq0HJhMXR/NYQGaDoGj3u7CuCOKcGmlleg69G4cPloFyptYrFDvF4WL08uhcpy3FDCjxHmBAVNx4x2aJ89O4BBklubHTGTAMHk6+FDvaT7hhi7lxNtW5b/YIDL48uyIaaC4/iYxLg3oigfQNVROrmwmJ9SVcv5x/JjF8q8OSqIYhL2Jv0SBt4IyOcSB4cbZbQRy1Ja94xZymsP4RmfN+28OwtyEYczmm39XA2F+XrydcxvW+9ZDbezqZO6W9BUrROHyImHTzCwdGfmp4soCervBNqto+Y1mOUnZ0HvuNZ/UE0pL/ImF7u9rpcHPmdERbPeAXOIgnJSA4910RBOcISdXlU+/Lw3zWZNOGFqmS3I1s7XzKeRjm+KzrfJYBKxI9BQiY2xn1QZBa6OLLzRbf
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(7696005)(478600001)(1076003)(316002)(110136005)(26005)(186003)(54906003)(2906002)(5660300002)(4326008)(70206006)(70586007)(107886003)(41300700001)(8676002)(82310400005)(7416002)(6666004)(8936002)(7636003)(356005)(82740400003)(40480700001)(86362001)(83380400001)(40460700003)(36756003)(47076005)(2616005)(426003)(36860700001)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 11:01:38.6584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a89552-d469-4bb2-86a2-08db3a7c1fe6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C403.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4898
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

