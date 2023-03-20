Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C886C1FEA
	for <lists+linux-pci@lfdr.de>; Mon, 20 Mar 2023 19:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjCTSfq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Mar 2023 14:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbjCTSfD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2023 14:35:03 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20606.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::606])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC663598;
        Mon, 20 Mar 2023 11:27:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPN9yd6hOnaPRTajKmTctjnxg10X+xxtmCFg+O3M8hoMpSOPS7Vhr32TbDoxbP8bqCT2pd6eHEI5YJ7EKQGt2sxr2x711TO19Lz9xxNsXsYwIQSa7ao/iltD1bkH8NBLrAsiJ9GUymH7W6CencuhFvKBu37vBC2Q3drtO+fQt8jhfz8LOa16yQwxGGLL6kwT7Gw0dPXURB3DelIHJTf+ReIyArv7G6Y9CYeJShgKSXczBbWM2cbs+y0ZgIVVjW5WwGV6J43sP+5C4cPeo0s9OONN5LVEQ7aVdQX0rFx2/eeRnNj7yxyrJs5CiKG/NBGNaiWoM9HLAWqfP/A1RUSJLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVRwgFgeJYSRsGwUZ2XIMEM87v9qQMGzP1nTzHvrqW4=;
 b=HbrZfUVrPG4e9H391ggnRiosA0hjaXGdDT1qSlK0mnbofkey1NHHQWo6T4YC+yz/msND4Xnpfx9kX4kqT/HGcXrdO07qpKiJYpLB8GVip4skg+bAbq/pXqivZKYBWWgjJbaAtj2oTTW6GCxuMlWsLts6ixic1dUYmS6AaYJ+ifllZ5EQuEoaBAWuYR2EUwd1Zi+YbCOIw+GJ2VJ84iNp6uAZDDhIAWBkyI8G62eLi+y9OXuvKNCaQF/cmNMucoQPeSvTsuBMKfqyWzYnIzmHi8D3HzefgkrnZi9wKtDErAHwkCJNC1Z+6TpEtK9lQbNOhNKxOnUt7sI4QVUCJVRXjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVRwgFgeJYSRsGwUZ2XIMEM87v9qQMGzP1nTzHvrqW4=;
 b=r5hWqjepssJwnDPok+6zZ4Ykp9z7s0Xyn4soUqFahCe6fllfO/2VCD0Y6BdsOYCx9oLTSAtw5A7q3vOi4srFbDkcfauZUU+wnadwEncnjuU1SnlMTO4DFR/e24wb5C9MO/L1GK9xrisGsKultjz0jZh6TdQ/89fTMKcKC+PIVGwPxGrkt4JI0RnS1vQrpoBTHC/C/Y8LQCsU34r4w9tB/ePBhGrFo3Pt5CzzwL7J7Fs+uN0CzEhrDLW8ciGeGJB+EKSB+t331DoPqs8tzjsOzKHji5oOU+3hMQlb/w3kd4781yhTUBGmncZwnhvfybWyHwYQ6GYFeJvMzIUDAvI72g==
Received: from BN0PR04CA0125.namprd04.prod.outlook.com (2603:10b6:408:ed::10)
 by BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 18:26:41 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::9e) by BN0PR04CA0125.outlook.office365.com
 (2603:10b6:408:ed::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 18:26:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.16 via Frontend Transport; Mon, 20 Mar 2023 18:26:40 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 20 Mar 2023
 11:26:33 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 20 Mar 2023 11:26:32 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Mon, 20 Mar 2023 11:26:27 -0700
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
Subject: [Patch v3 08/11] memory: tegra: make cpu cluster bw request a multiple of mc channels
Date:   Mon, 20 Mar 2023 23:54:38 +0530
Message-ID: <20230320182441.11904-9-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230320182441.11904-1-sumitg@nvidia.com>
References: <20230320182441.11904-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT023:EE_|BL1PR12MB5112:EE_
X-MS-Office365-Filtering-Correlation-Id: 43e773a7-e4d4-4335-74c0-08db2970a694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yGeIDYM1rQW51KCOI1zNHcUqclzU1MzRxaJTuoIC5lhfpRFWEx+MwJe8naDfL/ND0MrW4mkjtvLjIyOb8+sErNoXR/NjA32lTKP0ZkfmU61uvhROTjiEP40vr340LV1D6zpx1cT/X37ZvD8dnA3JNQBhFkbVA5hZUJtgeFUeaeRTCxnl9UH9DG+cj5QOmfEtIxeiz3NcUk5kWhU7yv3SFSFBm3NPXlk2CNBNMst+12N7UlDksy9z/JPsX4CvRqaAnqEty49IHgs2FplfjO8qJ17aezrY4lxEZFSFSWDKvNGpOjMaMYng5JGqy2bye2udr5LDG0hULktrL8dXFh/GQrNeTsEnVdyoy0oT5KdsvrtRsWzUY2yQBo5uJj5bNftQG4lmNSxbZYjquib/xeVxyxPfuAcgCX5/1rn0vCsbP0PoHGciEl2SoPPX4Gw5aQq1i1wlMsBXVPDpvt/b9TP1fPpp7YHgKOapy+sOKesqNtQNIu45OPGnGXxPtAadoNy/l7nNPThTJvOVe6IeuHst0uK2Gl6AaZaPNgn1yckHdDD4Cl/uZzBnv5qEAawwfJ5q1AjCFW8HbRXvZIEWzVS+k213AMEcsWHqT14VEVMVvoFR9A9dxYxuzh5TPYTWSqgRby2ONzxCBfnS5c6mUuU5GWR9NPOlqE5vUpoCpJ+CketpF2AHUDUWtmkIBlXXX9K8823CMrX95YEWlowbKrFCkUWV5RszhRpWMY0WBqsb/c8BnPKHVZmSdkU7osIFKf4h
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199018)(36840700001)(40470700004)(46966006)(47076005)(426003)(2616005)(83380400001)(82310400005)(54906003)(6666004)(107886003)(1076003)(478600001)(316002)(5660300002)(186003)(26005)(7416002)(7696005)(7636003)(110136005)(36860700001)(40460700003)(356005)(86362001)(336012)(82740400003)(8936002)(2906002)(41300700001)(40480700001)(70586007)(70206006)(4326008)(8676002)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 18:26:40.8849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e773a7-e4d4-4335-74c0-08db2970a694
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5112
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/memory/tegra/tegra234.c | 21 ++++++++++++++++++++-
 include/soc/tegra/mc.h          |  1 +
 4 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index bbd27d754fef..77346125dea6 100644
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
index 0c666e52bf46..0b608b820b28 100644
--- a/drivers/memory/tegra/tegra234.c
+++ b/drivers/memory/tegra/tegra234.c
@@ -868,6 +868,25 @@ static int tegra234_mc_icc_set(struct icc_node *src, struct icc_node *dst)
 	return ret;
 }
 
+static int tegra234_mc_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
+				     u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
+{
+	struct icc_provider *p = node->provider;
+	struct tegra_mc *mc = icc_provider_to_tegra_mc(p);
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
@@ -899,7 +918,7 @@ static int tegra234_mc_icc_get_init_bw(struct icc_node *node, u32 *avg, u32 *pea
 
 static const struct tegra_mc_icc_ops tegra234_mc_icc_ops = {
 	.xlate = tegra234_mc_of_icc_xlate,
-	.aggregate = icc_std_aggregate,
+	.aggregate = tegra234_mc_icc_aggregate,
 	.get_bw = tegra234_mc_icc_get_init_bw,
 	.set = tegra234_mc_icc_set,
 };
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index fefac9622987..2fe6f0217a39 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -233,6 +233,7 @@ struct tegra_mc {
 
 	struct tegra_mc_timing *timings;
 	unsigned int num_timings;
+	unsigned int num_channels;
 
 	struct reset_controller_dev reset;
 
-- 
2.17.1

