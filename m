Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0206D06F2
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 15:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjC3Nfy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Mar 2023 09:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjC3Nfw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2023 09:35:52 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2083.outbound.protection.outlook.com [40.107.212.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49C5BDFF;
        Thu, 30 Mar 2023 06:35:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHJhL5CZBpH/z5oS0Zddth7r9iW07/i58XFA1hz0KsfcGqhF4JHFDtORGGPU3tFYm8/CZ2UQ2Fft/+aA3Qod36fK+Zu/nXapQ/TKKa9/e07EvpJ0yq+5Gzqz+aZ153pxG0b0LNlbqsng7tW+tZpiIax1wxyvGjoJQr17yWLgL7d0OSWrOMdRBtKZvNhUl34A5CFRBj7bb38+B3CuyID0+tAMERMuSss60JP4/0r09jCQ5PAYso50nrt1z5XHZ6nrNC/cqZLTxwZ7dFQ8fMJ40h5818z36RV2Kd3dVR4Gr21OlFINv/798tCD3vXpebxyIn9BlX09O7yUUVSh8Fr9Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujSnNtZYvpOXFvDgiegtE9Scjpidv1UphqcDnVciXG4=;
 b=Q919uEMM1qJYKZXZCHfaH9pGSNrqmsCMrl1V8yNJ6Y/+R0xQXfRlT7bX1k+Byp7HQxgnZIftLZPEKXtlhbkTwOoE6wFRPcopRjXW0BxHLeKrxnts+60lD4WghDxepcBre2xdP1N9UdMPjwh4xJpAfTFJgPQ/w7HFM8SYKwysJssBuMne/hmMHwsFbdo7qLzPXT9idAv24ztCIV+MaldIsBZ2H56y9iw6OSb7gMow0eX8hbvbpXrGBL0evuK1OlLTTa2RRBkYwXgez7Np3r8RQ1Tijtfn+bZ7b3X88PsaEooKKMCoConrKeHsJeww8XhUF+gtL07QrhDn0DM8abOz1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujSnNtZYvpOXFvDgiegtE9Scjpidv1UphqcDnVciXG4=;
 b=tzy8BRPP4uA3/jIN2SK5xkqbADyRgNrwP5pTSiJW5nHDt6WNcKu7rQe/eCX+RgFqLE2UK0C7bhs3cW4IOmY4X8SG+OXKKQBPQnSTVLxPpuhxpPnR2IH0RzujHU7SsKaKM/dnb4LYegAZV7/NpAaUVpqb2tIoixZoM+iU6QwnoZka6IQZKGooMCPuEgIAYzQtJ4iLnT5MxDzY35i91hBJ/ASlKV4WaZ/5mRtfHy7o21Rw1F3xtZucTnNlybegySCAOsgwxYC6RtmPjgYBVm71DgTf5/ovrlYnlGzd4R7dYNlss0psWSsFUGR72dF30ZmOnla++BUQbKf7E/mTczROzw==
Received: from DM6PR13CA0029.namprd13.prod.outlook.com (2603:10b6:5:bc::42) by
 SA1PR12MB8096.namprd12.prod.outlook.com (2603:10b6:806:326::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Thu, 30 Mar
 2023 13:35:18 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::1f) by DM6PR13CA0029.outlook.office365.com
 (2603:10b6:5:bc::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 13:35:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.22 via Frontend Transport; Thu, 30 Mar 2023 13:35:17 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 30 Mar 2023
 06:35:10 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 30 Mar 2023 06:35:09 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 30 Mar 2023 06:35:04 -0700
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
Subject: [Patch v5 5/8] memory: tegra: make cpu cluster bw request a multiple of mc channels
Date:   Thu, 30 Mar 2023 19:03:51 +0530
Message-ID: <20230330133354.714-6-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230330133354.714-1-sumitg@nvidia.com>
References: <20230330133354.714-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT065:EE_|SA1PR12MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: e0f6b2b3-7457-4916-9bf8-08db312399da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IlfACITujBaQzIqK7+AJekJ5foX/c/haWbBEKtMBar7aSAH26x8cETXQ72Xgl4LcK2bEGPril/LvgztC/a9Jv+X/Wg3wX+ek98oeX6FLlMPixfTISsh/IclyJbf9Zw9TJqCLtwHuo/UDPoCkEcalxnDLQUfwlt2nJf14XiurJyTPw6z05n6+Qy0M3w7rqR3LqljU6QnmVH2gA0BX+FUstlkfGKInMDfxd7gKy68cWIdGfQe7Za6yXr/puA5a5UQBoC7m6j1g0KiKJr2xR3DBzrAEB5LUlZxFyjz49R2bGmAw/vYgmVTfX1++b3lqBX/rwWKWdgDOdNk6DJ2ABZWGZhL5RTORAlodf6170yobilxlXDPzq/SZn4/mBIxee72FwTv8M4fLZd7k0CG8eXh9Lghit3Bxn4zcE6z8Bvc43aMyo4UOkQ/3NERaEc876BBga4UX3LJ3SoUqhMQHTkNjAPFeKCOFxr289VVo1FwU0D+9l+xT2NqhGgaysigzNGj5WF9Ij713aOM6T3Cfcxt6vUZWxlDmM5Bu+J1ZkwdNEVPsgwW14bGJOf2VHKtJxmtHoAA/2d7ymOu3O/3NXZkVBKMEqkzAovLXFfjeWZA/FfkCWYpP3/vyJhwgA/VpzE8WzSl1+57BoHmyEgsMvHq9R5rEsoO1naoAJ+yyYZQ9A4Aj7LHfPdj2Iq9apU0fyVzPFe1geMUDdWRTR6R0iEm7OggzMq+qpSRlmMqI3ztacEoTPqBrjUMMm/vsiCw6l/R5Qtn+Z0EgNIF0o04PL9fYMnEZmCy+f9kI2ruxoetQLG4=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199021)(36840700001)(46966006)(40470700004)(478600001)(7416002)(41300700001)(36860700001)(316002)(70206006)(34020700004)(70586007)(7636003)(82740400003)(5660300002)(8936002)(186003)(356005)(2616005)(47076005)(110136005)(54906003)(6666004)(107886003)(83380400001)(4326008)(26005)(426003)(336012)(7696005)(40460700003)(1076003)(8676002)(86362001)(36756003)(82310400005)(40480700001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 13:35:17.6508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f6b2b3-7457-4916-9bf8-08db312399da
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8096
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

