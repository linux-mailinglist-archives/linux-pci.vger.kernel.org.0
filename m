Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73B16FF888
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 19:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238783AbjEKReb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 13:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238312AbjEKRea (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 13:34:30 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33DF93C1;
        Thu, 11 May 2023 10:33:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eu6LMLOhnVaw8ucCaCCVz+Y1t2v0o5l2YEwtO3gQl6hnrhX6Lo1UDYSx4U6AvaDNJXPzfTrMxIho+P5R3GAICu1Eq99KAFBkndnzk6PJ6ym7xVKrbO+kGWk2ed9gEFbMzKzEm5zuHgfU0Zc8ENyJmaogaWgJ71juhcRk4ana9uemQvN59NFlRQvK8DV9bX8TzBMaAwut3FpsLcHY6JKdNKRfvcSvv2BnV36RIlHgvCv28PjZMyU7EapcvsEdF+BJboUTYh76JMBO/adSWW0KngIMsTpXPQLLvhwc/F7rXGniK9exPVlmsjsTooPF4VLqjvCa2SGMORbXLgU29zln1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujSnNtZYvpOXFvDgiegtE9Scjpidv1UphqcDnVciXG4=;
 b=lTX72BOkr0UqFAoynDuYpwHJLITgNg6YF2jFrJfcNJgPID+chnRlZobRhTP9NlBXG/fS1lo4BQ8iK6Sozd1YtHLMxqRliNWDHWTLTB80vweW0CxxZPsAwOuF+kPP3yPdVkdlXRSGfmGi3wJYJH6zUkCq4lpJSdfVI5pVnB3i/n9+YXSpWvttECPa3CE7uiHtz5FhY7Rljt/7ueEmYeiskOcXtG5ovKTe9+Qljkgj5RVbRjfFahYye+IyXUHI4mRYUiKOnICdwK6Pwt2WkCQ7G0j0P1d6BYBwpr43WOw1c3hqNk+tAaVg7Kcue4PbD8UslIO0AmUqcljETboVFlPuow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujSnNtZYvpOXFvDgiegtE9Scjpidv1UphqcDnVciXG4=;
 b=EcKQkBvub749ae83NXD5EiMfH6H/LeoWKCv6BupQyeluNijRrD/yP4wT7N9S3Ej/+WAfKe+dVI8NM+CqsqW94S6pBbczKOBpyZrOJ+khSrav2vjRhQ+6Gb6zkgVLcTUrP49xg3kyh3c5ThGZoFNesbMRels8LKO3Yc+Qrc01f0jLZYDZfftQ+81/2tJfBtMYOK37dGrhthOwqI+C2YkNanm222eKIfzW7PjbtOcYav2XDOMRjdv40VHcf3FPbtvxgPC2yQAPA+qOFbA495UB+mkfOg51TGsDxBciVuOiG1DmLlZLpItIzQCPv2LbobddB1m5KuoehJqTao0BaFF4FQ==
Received: from SJ0PR05CA0032.namprd05.prod.outlook.com (2603:10b6:a03:33f::7)
 by DM4PR12MB6159.namprd12.prod.outlook.com (2603:10b6:8:a8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.33; Thu, 11 May 2023 17:33:35 +0000
Received: from DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33f:cafe::eb) by SJ0PR05CA0032.outlook.office365.com
 (2603:10b6:a03:33f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.7 via Frontend
 Transport; Thu, 11 May 2023 17:33:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT096.mail.protection.outlook.com (10.13.173.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.22 via Frontend Transport; Thu, 11 May 2023 17:33:35 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 11 May 2023
 10:33:24 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 11 May 2023 10:33:23 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 11 May 2023 10:33:18 -0700
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
Subject: [Patch v8 5/8] memory: tegra: make cpu cluster bw request a multiple of mc channels
Date:   Thu, 11 May 2023 23:02:08 +0530
Message-ID: <20230511173211.9127-6-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230511173211.9127-1-sumitg@nvidia.com>
References: <20230511173211.9127-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT096:EE_|DM4PR12MB6159:EE_
X-MS-Office365-Filtering-Correlation-Id: f0755c4c-e4fc-4f72-777e-08db5245d916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MMOOwS8aNh+oj/Pq4qzx/nz/7Fj2HaChj/Jpo+AuUFFjZuFLzD9qEwD3LtqyZB8SH50fAmgoeCrL6tX7HIx35D9nW7U0anXpHXRnKPdTuYL3PdmFjLrxEMY2oNSe4fn6Ns/LImfS/YNufRCRTkmXhuNRPikPkZ/uLubVXpnxqqxhOcVZksLkpodpt4e7b0SnFG+D48i5mci3WxsdXU5yWyfghn7hKsOtp7t8KlXdcM1Hus3wRkW3Ouy3jhE6GlY76Ph+QdvrRlYRW70hN43jo2igq6ADU62V0qaiWa9ti5W7jt0eFkzxm2kOOnqJ2aTzTrzpNNVQvC8dgACGosG/jvDH7lh1xP8JnQv28qKKChiYHL1tZ/vzzAvg1pq3KqNxzV9gcim0ScqJ8zNSygdQDzxKdE582FPNIDs9Nk5RALLXdeZvesq4pVWRkgZmfutM6YsQYWgrEy7Ryy/Ho+yqca5Pro/ZFZb4z2/p1Xf+GL6CxORWfUnN2DgwyyIZfK9T3KSTgpuMXa4+ox2a8wdeqbzx25ztysEsFeKtH1i5SvkzEXCRNVT4t2u++zu2ijoTv8eIeEbLfFa50SAzgYkHLc5mJMNUmn0alPMVOSMP9wDrS/LE7kYEU1BpirnSdYBwcEHZiMQdXZpneS3iHZljxczvVCl/cdSYo/gvl1pwGCF/TGXmsDg+S6njAxWYBcu22dEl7UhQaiNIbgeMxnyZRA==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199021)(46966006)(40470700004)(36840700001)(70586007)(70206006)(6666004)(41300700001)(4326008)(5660300002)(8676002)(7416002)(8936002)(1076003)(54906003)(26005)(110136005)(478600001)(316002)(7696005)(107886003)(83380400001)(40460700003)(47076005)(2906002)(426003)(336012)(2616005)(186003)(356005)(7636003)(82740400003)(36860700001)(40480700001)(82310400005)(36756003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 17:33:35.0000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0755c4c-e4fc-4f72-777e-08db5245d916
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6159
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

