Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14586ECCCF
	for <lists+linux-pci@lfdr.de>; Mon, 24 Apr 2023 15:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjDXNO5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Apr 2023 09:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjDXNOz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2023 09:14:55 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BE549FC;
        Mon, 24 Apr 2023 06:14:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPceOyWvJeTMxociBQt7zTdr8HhH65cksLn2uX0/p5QN2OOTiO1o+1D2igy09+PWKMBwrqglaGX0MnXue0mTY9in3kZdDwDAqp10UqHfRV1QTqK6GhIZWC1pFGkIuXFSxIV0zajzLZKxdw57yTePQpa094YsFuHB1obTsIGeH0LH0ig1g6FVx+r4VInsUmnkcWGojud8dALUOI6sRZXLYWiA06dbvHnKjaJqB52vi/BZZK9yQ4f0dCGNq5vgCyT4JfCCrUXVHzGT7rZKHoBJLGMN6/BiQnGViKkzlAxlbiutqrbsH7exL6+QiNBPcy7ImzKX5nOFR1AkdWJxazbOfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWBnLuq31T5KavRmUhXxEwE8BUS4UT7sOeVtuGB5OyA=;
 b=jHHmWxFOXWxF232mdy/usfkl8jWiyxGqPzA5TJ5FxBhZwJwmIeetG7W7BCVBTaCxBSqw4Ph6E8VvdsHh14qYXSAMOKTCEwitYv0LrQ2Oi2Q5jt4S7ZaeMTVHOJPVoyqiP4ndzXbBh3hZgvFPT+kTNHii6ZFEMH7gRzg4RK/OPK3fBVCYmMVwedqDIY+ei/yi6RMr8pWvZGgS5BepzRw2mqrvmaVyD68RhKQ2U4EKXqPTQ4ozWb1aC4qMJwk1rfFaDCpct/4MaYJwLxMWdfwAZ+XNU3MaqWz0Bpz3YLQ78pnakbvfic6L4giIhGejAsYoW40Q/IqndEL+61QOfhdYfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWBnLuq31T5KavRmUhXxEwE8BUS4UT7sOeVtuGB5OyA=;
 b=BFLKUBnl6T6bdUezqqhGfYANLSaeTUOmt/dEw1HSDH1d67TMMz1Mf3Oz693pMgEDstFpmY89oUueGh8XwNerBtj6Sv5hBMtx7J6jOqjyo8eOIejpYh0q/6x6Qo72sRlpk6LvFBUiwcoOPdKqgCpb+s0zRSM81cY2X0jbS5gtZOAuW/ETSS3bYPxYH6JfjMfcU1HLOkMs72Vud0iFBxfx69Ap4IEpTGccuru2n3OmagGAXkiKmzPoxNjnbsu9io0c9xYolu2zE4ffZnXKcB8bIidBvunVmQbQ/hDaUr2ymF3OSjF5stN6M/p3YnTGtj/f/bpUaTEIQvvUuk8quspZag==
Received: from MN2PR20CA0002.namprd20.prod.outlook.com (2603:10b6:208:e8::15)
 by MW4PR12MB6827.namprd12.prod.outlook.com (2603:10b6:303:20b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Mon, 24 Apr
 2023 13:14:34 +0000
Received: from BL02EPF000145BA.namprd05.prod.outlook.com
 (2603:10b6:208:e8:cafe::f4) by MN2PR20CA0002.outlook.office365.com
 (2603:10b6:208:e8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Mon, 24 Apr 2023 13:14:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF000145BA.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.16 via Frontend Transport; Mon, 24 Apr 2023 13:14:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 24 Apr 2023
 06:14:20 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 24 Apr
 2023 06:14:19 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 24 Apr 2023 06:14:13 -0700
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
Subject: [Patch v7 1/8] memory: tegra: add interconnect support for DRAM scaling in Tegra234
Date:   Mon, 24 Apr 2023 18:43:30 +0530
Message-ID: <20230424131337.20151-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230424131337.20151-1-sumitg@nvidia.com>
References: <20230424131337.20151-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145BA:EE_|MW4PR12MB6827:EE_
X-MS-Office365-Filtering-Correlation-Id: ee13d6b3-9d49-48a3-9b6f-08db44c5d8a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VM2oqYnXh/Am6zd7vr0ghSTr9MzSEToss+AiPCu6eInbOwOsYoaww45h5zyfbHxeHalBbc2vrIvsrB0ewIoc+K7HgyxkGsKg8ZA7PU9KPBEtK2Ty2chSUHXkT40u5ZxGv/o0aOcO9MxgVOR1XIAk5SD+aIUius+dWMyECoCVlgyqujfUk3CVYh1aJqrdz8AsQTyV2RqOno0EPh6HtlWco1wmfg7CDtT4HQyT5QZI/O1j7ke/w+JecbBgGvma6P/fEwaJ9n6/1gRPI1SDFh5jwM7BDXzOoeyps0KWlFWh+dlM8B6Yd+j3HguGpvKKNGJUVwfW0DGG3KBXbmTJd1oooovsVjB3o55t7SZd+BzeMAggsTI0c1J8LitVGAmLXR2tm9Vt4zaaRw1uvQIwYCkNiV9F6phTJ8gT4TktOf7SMBurNNLd48eETmZ/MinJuPZhFNKYsqiqmvsRaOxwm7yXx6ACM/xi0YM+T5BAtdj5AYRQueP9aszly4/l2muaEx1JpxbnjKleLbxrb+d97ql3nR8vtbVj1KHdNjZf1wNs8T33jWEGSDDr6E0/le8Fkk1msWFvsrD3LlhLbk8QUUTqYtxEicBKE8wX3aCaRTtb+t+IjKBHAwTa2+Ak6v/HFY0GqbFxAigRx692dzJRmEmkIY3600diWrnOh+KJQooQilCs5XXY7hT2r63rIkkxlSexhBnV1s92zXdgffRNQoKAJQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(30864003)(186003)(26005)(1076003)(7696005)(6666004)(426003)(107886003)(40480700001)(47076005)(5660300002)(70586007)(336012)(2616005)(41300700001)(4326008)(7416002)(8676002)(8936002)(70206006)(54906003)(110136005)(478600001)(82740400003)(2906002)(316002)(356005)(40460700003)(86362001)(83380400001)(36756003)(36860700001)(7636003)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 13:14:33.5422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee13d6b3-9d49-48a3-9b6f-08db44c5d8a9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145BA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6827
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Interconnect framework support to dynamically set the DRAM
bandwidth from different clients. Both the MC and EMC drivers are
added as ICC providers. The path for any request is:
 MC-Client[1-n] -> MC -> EMC -> EMEM/DRAM

MC client's request for bandwidth will go to the MC driver which
passes the client request info like BPMP Client ID, Client type
and the Bandwidth to the BPMP-FW. The final DRAM freq to achieve
the requested bandwidth is set by the BPMP-FW based on the passed
parameters.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/memory/tegra/mc.c           |   5 +
 drivers/memory/tegra/tegra186-emc.c | 130 ++++++++++++++++++++++++++
 drivers/memory/tegra/tegra234.c     | 138 +++++++++++++++++++++++++++-
 include/linux/tegra-icc.h           |  65 +++++++++++++
 include/soc/tegra/mc.h              |   7 ++
 5 files changed, 344 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/tegra-icc.h

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 9082b6c3763d..983455b1f98d 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/sort.h>
+#include <linux/tegra-icc.h>
 
 #include <soc/tegra/fuse.h>
 
@@ -792,6 +793,8 @@ static int tegra_mc_interconnect_setup(struct tegra_mc *mc)
 	mc->provider.data = &mc->provider;
 	mc->provider.set = mc->soc->icc_ops->set;
 	mc->provider.aggregate = mc->soc->icc_ops->aggregate;
+	mc->provider.get_bw = mc->soc->icc_ops->get_bw;
+	mc->provider.xlate = mc->soc->icc_ops->xlate;
 	mc->provider.xlate_extended = mc->soc->icc_ops->xlate_extended;
 
 	icc_provider_init(&mc->provider);
@@ -824,6 +827,8 @@ static int tegra_mc_interconnect_setup(struct tegra_mc *mc)
 		err = icc_link_create(node, TEGRA_ICC_MC);
 		if (err)
 			goto remove_nodes;
+
+		node->data = (struct tegra_mc_client *)&(mc->soc->clients[i]);
 	}
 
 	err = icc_provider_register(&mc->provider);
diff --git a/drivers/memory/tegra/tegra186-emc.c b/drivers/memory/tegra/tegra186-emc.c
index e935ad4e95b6..0aa6c049aa43 100644
--- a/drivers/memory/tegra/tegra186-emc.c
+++ b/drivers/memory/tegra/tegra186-emc.c
@@ -7,9 +7,11 @@
 #include <linux/debugfs.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 
 #include <soc/tegra/bpmp.h>
+#include "mc.h"
 
 struct tegra186_emc_dvfs {
 	unsigned long latency;
@@ -29,8 +31,15 @@ struct tegra186_emc {
 		unsigned long min_rate;
 		unsigned long max_rate;
 	} debugfs;
+
+	struct icc_provider provider;
 };
 
+static inline struct tegra186_emc *to_tegra186_emc(struct icc_provider *provider)
+{
+	return container_of(provider, struct tegra186_emc, provider);
+}
+
 /*
  * debugfs interface
  *
@@ -146,8 +155,102 @@ DEFINE_DEBUGFS_ATTRIBUTE(tegra186_emc_debug_max_rate_fops,
 			  tegra186_emc_debug_max_rate_get,
 			  tegra186_emc_debug_max_rate_set, "%llu\n");
 
+/*
+ * tegra_emc_icc_set_bw() - Set BW api for EMC provider
+ * @src: ICC node for External Memory Controller (EMC)
+ * @dst: ICC node for External Memory (DRAM)
+ *
+ * Do nothing here as info to BPMP-FW is now passed in the BW set function
+ * of the MC driver. BPMP-FW sets the final Freq based on the passed values.
+ */
+static int tegra_emc_icc_set_bw(struct icc_node *src, struct icc_node *dst)
+{
+	return 0;
+}
+
+static struct icc_node *
+tegra_emc_of_icc_xlate(struct of_phandle_args *spec, void *data)
+{
+	struct icc_provider *provider = data;
+	struct icc_node *node;
+
+	/* External Memory is the only possible ICC route */
+	list_for_each_entry(node, &provider->nodes, node_list) {
+		if (node->id != TEGRA_ICC_EMEM)
+			continue;
+
+		return node;
+	}
+
+	return ERR_PTR(-EPROBE_DEFER);
+}
+
+static int tegra_emc_icc_get_init_bw(struct icc_node *node, u32 *avg, u32 *peak)
+{
+	*avg = 0;
+	*peak = 0;
+
+	return 0;
+}
+
+static int tegra_emc_interconnect_init(struct tegra186_emc *emc)
+{
+	struct tegra_mc *mc = dev_get_drvdata(emc->dev->parent);
+	const struct tegra_mc_soc *soc = mc->soc;
+	struct icc_node *node;
+	int err;
+
+	emc->provider.dev = emc->dev;
+	emc->provider.set = tegra_emc_icc_set_bw;
+	emc->provider.data = &emc->provider;
+	emc->provider.aggregate = soc->icc_ops->aggregate;
+	emc->provider.xlate = tegra_emc_of_icc_xlate;
+	emc->provider.get_bw = tegra_emc_icc_get_init_bw;
+
+	icc_provider_init(&emc->provider);
+
+	/* create External Memory Controller node */
+	node = icc_node_create(TEGRA_ICC_EMC);
+	if (IS_ERR(node)) {
+		err = PTR_ERR(node);
+		goto err_msg;
+	}
+
+	node->name = "External Memory Controller";
+	icc_node_add(node, &emc->provider);
+
+	/* link External Memory Controller to External Memory (DRAM) */
+	err = icc_link_create(node, TEGRA_ICC_EMEM);
+	if (err)
+		goto remove_nodes;
+
+	/* create External Memory node */
+	node = icc_node_create(TEGRA_ICC_EMEM);
+	if (IS_ERR(node)) {
+		err = PTR_ERR(node);
+		goto remove_nodes;
+	}
+
+	node->name = "External Memory (DRAM)";
+	icc_node_add(node, &emc->provider);
+
+	err = icc_provider_register(&emc->provider);
+	if (err)
+		goto remove_nodes;
+
+	return 0;
+
+remove_nodes:
+	icc_nodes_remove(&emc->provider);
+err_msg:
+	dev_err(emc->dev, "failed to initialize ICC: %d\n", err);
+
+	return err;
+}
+
 static int tegra186_emc_probe(struct platform_device *pdev)
 {
+	struct tegra_mc *mc = dev_get_drvdata(pdev->dev.parent);
 	struct mrq_emc_dvfs_latency_response response;
 	struct tegra_bpmp_message msg;
 	struct tegra186_emc *emc;
@@ -236,6 +339,29 @@ static int tegra186_emc_probe(struct platform_device *pdev)
 	debugfs_create_file("max_rate", S_IRUGO | S_IWUSR, emc->debugfs.root,
 			    emc, &tegra186_emc_debug_max_rate_fops);
 
+	if (mc && mc->soc->icc_ops) {
+		/*
+		 * Initialize the ICC even if BPMP-FW doesn't support 'MRQ_BWMGR_INT'.
+		 * Use the flag 'mc->bwmgr_mrq_supported' within MC driver and return
+		 * EINVAL instead of passing the request to BPMP-FW later when the BW
+		 * request is made by client with 'icc_set_bw()' call.
+		 */
+		err = tegra_emc_interconnect_init(emc);
+		if (err)
+			goto put_bpmp;
+
+		if (tegra_bpmp_mrq_is_supported(emc->bpmp, MRQ_BWMGR_INT)) {
+			mc->bwmgr_mrq_supported = true;
+
+			/*
+			 * MC driver probe can't get BPMP reference as it gets probed
+			 * earlier than BPMP. So, save the BPMP ref got from the EMC
+			 * DT node in the mc->bpmp and use it in MC's icc_set hook.
+			 */
+			mc->bpmp = emc->bpmp;
+		}
+	}
+
 	return 0;
 
 put_bpmp:
@@ -245,9 +371,12 @@ static int tegra186_emc_probe(struct platform_device *pdev)
 
 static int tegra186_emc_remove(struct platform_device *pdev)
 {
+	struct tegra_mc *mc = dev_get_drvdata(pdev->dev.parent);
 	struct tegra186_emc *emc = platform_get_drvdata(pdev);
 
 	debugfs_remove_recursive(emc->debugfs.root);
+
+	mc->bpmp = NULL;
 	tegra_bpmp_put(emc->bpmp);
 
 	return 0;
@@ -272,6 +401,7 @@ static struct platform_driver tegra186_emc_driver = {
 		.name = "tegra186-emc",
 		.of_match_table = tegra186_emc_of_match,
 		.suppress_bind_attrs = true,
+		.sync_state = icc_sync_state,
 	},
 	.probe = tegra186_emc_probe,
 	.remove = tegra186_emc_remove,
diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
index 02dcc5748bba..56d911926d54 100644
--- a/drivers/memory/tegra/tegra234.c
+++ b/drivers/memory/tegra/tegra234.c
@@ -1,18 +1,23 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2021-2022, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (C) 2022-2023, NVIDIA CORPORATION.  All rights reserved.
  */
 
 #include <soc/tegra/mc.h>
 
 #include <dt-bindings/memory/tegra234-mc.h>
+#include <linux/interconnect.h>
+#include <linux/tegra-icc.h>
 
+#include <soc/tegra/bpmp.h>
 #include "mc.h"
 
 static const struct tegra_mc_client tegra234_mc_clients[] = {
 	{
 		.id = TEGRA234_MEMORY_CLIENT_MGBEARD,
 		.name = "mgbeard",
+		.bpmp_id = TEGRA_ICC_BPMP_EQOS,
+		.type = TEGRA_ICC_NISO,
 		.sid = TEGRA234_SID_MGBE,
 		.regs = {
 			.sid = {
@@ -23,6 +28,8 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_MGBEBRD,
 		.name = "mgbebrd",
+		.bpmp_id = TEGRA_ICC_BPMP_EQOS,
+		.type = TEGRA_ICC_NISO,
 		.sid = TEGRA234_SID_MGBE_VF1,
 		.regs = {
 			.sid = {
@@ -33,6 +40,8 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_MGBECRD,
 		.name = "mgbecrd",
+		.bpmp_id = TEGRA_ICC_BPMP_EQOS,
+		.type = TEGRA_ICC_NISO,
 		.sid = TEGRA234_SID_MGBE_VF2,
 		.regs = {
 			.sid = {
@@ -43,6 +52,8 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_MGBEDRD,
 		.name = "mgbedrd",
+		.bpmp_id = TEGRA_ICC_BPMP_EQOS,
+		.type = TEGRA_ICC_NISO,
 		.sid = TEGRA234_SID_MGBE_VF3,
 		.regs = {
 			.sid = {
@@ -52,6 +63,8 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 		},
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_MGBEAWR,
+		.bpmp_id = TEGRA_ICC_BPMP_EQOS,
+		.type = TEGRA_ICC_NISO,
 		.name = "mgbeawr",
 		.sid = TEGRA234_SID_MGBE,
 		.regs = {
@@ -63,6 +76,8 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_MGBEBWR,
 		.name = "mgbebwr",
+		.bpmp_id = TEGRA_ICC_BPMP_EQOS,
+		.type = TEGRA_ICC_NISO,
 		.sid = TEGRA234_SID_MGBE_VF1,
 		.regs = {
 			.sid = {
@@ -73,6 +88,8 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_MGBECWR,
 		.name = "mgbecwr",
+		.bpmp_id = TEGRA_ICC_BPMP_EQOS,
+		.type = TEGRA_ICC_NISO,
 		.sid = TEGRA234_SID_MGBE_VF2,
 		.regs = {
 			.sid = {
@@ -83,6 +100,8 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_SDMMCRAB,
 		.name = "sdmmcrab",
+		.bpmp_id = TEGRA_ICC_BPMP_SDMMC_4,
+		.type = TEGRA_ICC_NISO,
 		.sid = TEGRA234_SID_SDMMC4,
 		.regs = {
 			.sid = {
@@ -93,6 +112,8 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_MGBEDWR,
 		.name = "mgbedwr",
+		.bpmp_id = TEGRA_ICC_BPMP_EQOS,
+		.type = TEGRA_ICC_NISO,
 		.sid = TEGRA234_SID_MGBE_VF3,
 		.regs = {
 			.sid = {
@@ -103,6 +124,8 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_SDMMCWAB,
 		.name = "sdmmcwab",
+		.bpmp_id = TEGRA_ICC_BPMP_SDMMC_4,
+		.type = TEGRA_ICC_NISO,
 		.sid = TEGRA234_SID_SDMMC4,
 		.regs = {
 			.sid = {
@@ -153,6 +176,8 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_APEDMAR,
 		.name = "apedmar",
+		.bpmp_id = TEGRA_ICC_BPMP_APEDMA,
+		.type = TEGRA_ICC_ISO_AUDIO,
 		.sid = TEGRA234_SID_APE,
 		.regs = {
 			.sid = {
@@ -163,6 +188,8 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_APEDMAW,
 		.name = "apedmaw",
+		.bpmp_id = TEGRA_ICC_BPMP_APEDMA,
+		.type = TEGRA_ICC_ISO_AUDIO,
 		.sid = TEGRA234_SID_APE,
 		.regs = {
 			.sid = {
@@ -333,6 +360,114 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 	},
 };
 
+/*
+ * tegra234_mc_icc_set() - Pass MC client info to the BPMP-FW
+ * @src: ICC node for Memory Controller's (MC) Client
+ * @dst: ICC node for Memory Controller (MC)
+ *
+ * Passing the current request info from the MC to the BPMP-FW where
+ * LA and PTSA registers are accessed and the final EMC freq is set
+ * based on client_id, type, latency and bandwidth.
+ * icc_set_bw() makes set_bw calls for both MC and EMC providers in
+ * sequence. Both the calls are protected by 'mutex_lock(&icc_lock)'.
+ * So, the data passed won't be updated by concurrent set calls from
+ * other clients.
+ */
+static int tegra234_mc_icc_set(struct icc_node *src, struct icc_node *dst)
+{
+	struct tegra_mc *mc = icc_provider_to_tegra_mc(dst->provider);
+	struct mrq_bwmgr_int_request bwmgr_req = { 0 };
+	struct mrq_bwmgr_int_response bwmgr_resp = { 0 };
+	const struct tegra_mc_client *pclient = src->data;
+	struct tegra_bpmp_message msg;
+	int ret;
+
+	/*
+	 * Same Src and Dst node will happen during boot from icc_node_add().
+	 * This can be used to pre-initialize and set bandwidth for all clients
+	 * before their drivers are loaded. We are skipping this case as for us,
+	 * the pre-initialization already happened in Bootloader(MB2) and BPMP-FW.
+	 */
+	if (src->id == dst->id)
+		return 0;
+
+	if (!mc->bwmgr_mrq_supported)
+		return -EINVAL;
+
+	if (!mc->bpmp) {
+		dev_err(mc->dev, "BPMP reference NULL\n");
+		return -ENOENT;
+	}
+
+	if (pclient->type == TEGRA_ICC_NISO)
+		bwmgr_req.bwmgr_calc_set_req.niso_bw = src->avg_bw;
+	else
+		bwmgr_req.bwmgr_calc_set_req.iso_bw = src->avg_bw;
+
+	bwmgr_req.bwmgr_calc_set_req.client_id = pclient->bpmp_id;
+
+	bwmgr_req.cmd = CMD_BWMGR_INT_CALC_AND_SET;
+	bwmgr_req.bwmgr_calc_set_req.mc_floor = src->peak_bw;
+	bwmgr_req.bwmgr_calc_set_req.floor_unit = BWMGR_INT_UNIT_KBPS;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.mrq = MRQ_BWMGR_INT;
+	msg.tx.data = &bwmgr_req;
+	msg.tx.size = sizeof(bwmgr_req);
+	msg.rx.data = &bwmgr_resp;
+	msg.rx.size = sizeof(bwmgr_resp);
+
+	ret = tegra_bpmp_transfer(mc->bpmp, &msg);
+	if (ret < 0) {
+		dev_err(mc->dev, "BPMP transfer failed: %d\n", ret);
+		goto error;
+	}
+	if (msg.rx.ret < 0) {
+		pr_err("failed to set bandwidth for %u: %d\n",
+		       bwmgr_req.bwmgr_calc_set_req.client_id, msg.rx.ret);
+		ret = -EINVAL;
+	}
+
+error:
+	return ret;
+}
+
+static struct icc_node*
+tegra234_mc_of_icc_xlate(struct of_phandle_args *spec, void *data)
+{
+	struct tegra_mc *mc = icc_provider_to_tegra_mc(data);
+	unsigned int cl_id = spec->args[0];
+	struct icc_node *node;
+
+	list_for_each_entry(node, &mc->provider.nodes, node_list) {
+		if (node->id != cl_id)
+			continue;
+
+		return node;
+	}
+
+	/*
+	 * If a client driver calls devm_of_icc_get() before the MC driver
+	 * is probed, then return EPROBE_DEFER to the client driver.
+	 */
+	return ERR_PTR(-EPROBE_DEFER);
+}
+
+static int tegra234_mc_icc_get_init_bw(struct icc_node *node, u32 *avg, u32 *peak)
+{
+	*avg = 0;
+	*peak = 0;
+
+	return 0;
+}
+
+static const struct tegra_mc_icc_ops tegra234_mc_icc_ops = {
+	.xlate = tegra234_mc_of_icc_xlate,
+	.aggregate = icc_std_aggregate,
+	.get_bw = tegra234_mc_icc_get_init_bw,
+	.set = tegra234_mc_icc_set,
+};
+
 const struct tegra_mc_soc tegra234_mc_soc = {
 	.num_clients = ARRAY_SIZE(tegra234_mc_clients),
 	.clients = tegra234_mc_clients,
@@ -345,6 +480,7 @@ const struct tegra_mc_soc tegra234_mc_soc = {
 		   MC_INT_SECURITY_VIOLATION | MC_INT_DECERR_EMEM,
 	.has_addr_hi_reg = true,
 	.ops = &tegra186_mc_ops,
+	.icc_ops = &tegra234_mc_icc_ops,
 	.ch_intmask = 0x0000ff00,
 	.global_intstatus_channel_shift = 8,
 	/*
diff --git a/include/linux/tegra-icc.h b/include/linux/tegra-icc.h
new file mode 100644
index 000000000000..4b4d4bee290c
--- /dev/null
+++ b/include/linux/tegra-icc.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2022-2023 NVIDIA CORPORATION.  All rights reserved.
+ */
+
+#ifndef LINUX_TEGRA_ICC_H
+#define LINUX_TEGRA_ICC_H
+
+enum tegra_icc_client_type {
+	TEGRA_ICC_NONE,
+	TEGRA_ICC_NISO,
+	TEGRA_ICC_ISO_DISPLAY,
+	TEGRA_ICC_ISO_VI,
+	TEGRA_ICC_ISO_AUDIO,
+	TEGRA_ICC_ISO_VIFAL,
+};
+
+/* ICC ID's for MC client's used in BPMP */
+#define TEGRA_ICC_BPMP_DEBUG		1
+#define TEGRA_ICC_BPMP_CPU_CLUSTER0	2
+#define TEGRA_ICC_BPMP_CPU_CLUSTER1	3
+#define TEGRA_ICC_BPMP_CPU_CLUSTER2	4
+#define TEGRA_ICC_BPMP_GPU		5
+#define TEGRA_ICC_BPMP_CACTMON		6
+#define TEGRA_ICC_BPMP_DISPLAY		7
+#define TEGRA_ICC_BPMP_VI		8
+#define TEGRA_ICC_BPMP_EQOS		9
+#define TEGRA_ICC_BPMP_PCIE_0		10
+#define TEGRA_ICC_BPMP_PCIE_1		11
+#define TEGRA_ICC_BPMP_PCIE_2		12
+#define TEGRA_ICC_BPMP_PCIE_3		13
+#define TEGRA_ICC_BPMP_PCIE_4		14
+#define TEGRA_ICC_BPMP_PCIE_5		15
+#define TEGRA_ICC_BPMP_PCIE_6		16
+#define TEGRA_ICC_BPMP_PCIE_7		17
+#define TEGRA_ICC_BPMP_PCIE_8		18
+#define TEGRA_ICC_BPMP_PCIE_9		19
+#define TEGRA_ICC_BPMP_PCIE_10		20
+#define TEGRA_ICC_BPMP_DLA_0		21
+#define TEGRA_ICC_BPMP_DLA_1		22
+#define TEGRA_ICC_BPMP_SDMMC_1		23
+#define TEGRA_ICC_BPMP_SDMMC_2		24
+#define TEGRA_ICC_BPMP_SDMMC_3		25
+#define TEGRA_ICC_BPMP_SDMMC_4		26
+#define TEGRA_ICC_BPMP_NVDEC		27
+#define TEGRA_ICC_BPMP_NVENC		28
+#define TEGRA_ICC_BPMP_NVJPG_0		29
+#define TEGRA_ICC_BPMP_NVJPG_1		30
+#define TEGRA_ICC_BPMP_OFAA		31
+#define TEGRA_ICC_BPMP_XUSB_HOST	32
+#define TEGRA_ICC_BPMP_XUSB_DEV		33
+#define TEGRA_ICC_BPMP_TSEC		34
+#define TEGRA_ICC_BPMP_VIC		35
+#define TEGRA_ICC_BPMP_APE		36
+#define TEGRA_ICC_BPMP_APEDMA		37
+#define TEGRA_ICC_BPMP_SE		38
+#define TEGRA_ICC_BPMP_ISP		39
+#define TEGRA_ICC_BPMP_HDA		40
+#define TEGRA_ICC_BPMP_VIFAL		41
+#define TEGRA_ICC_BPMP_VI2FAL		42
+#define TEGRA_ICC_BPMP_VI2		43
+#define TEGRA_ICC_BPMP_RCE		44
+#define TEGRA_ICC_BPMP_PVA		45
+
+#endif /* LINUX_TEGRA_ICC_H */
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index 51a2263e1bc5..900d88b26fae 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -13,6 +13,7 @@
 #include <linux/irq.h>
 #include <linux/reset-controller.h>
 #include <linux/types.h>
+#include <linux/tegra-icc.h>
 
 struct clk;
 struct device;
@@ -26,6 +27,8 @@ struct tegra_mc_timing {
 
 struct tegra_mc_client {
 	unsigned int id;
+	unsigned int bpmp_id;
+	enum tegra_icc_client_type type;
 	const char *name;
 	/*
 	 * For Tegra210 and earlier, this is the SWGROUP ID used for IOVA translations in the
@@ -166,8 +169,10 @@ struct tegra_mc_icc_ops {
 	int (*set)(struct icc_node *src, struct icc_node *dst);
 	int (*aggregate)(struct icc_node *node, u32 tag, u32 avg_bw,
 			 u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
+	struct icc_node* (*xlate)(struct of_phandle_args *spec, void *data);
 	struct icc_node_data *(*xlate_extended)(struct of_phandle_args *spec,
 						void *data);
+	int (*get_bw)(struct icc_node *node, u32 *avg, u32 *peak);
 };
 
 struct tegra_mc_ops {
@@ -214,6 +219,7 @@ struct tegra_mc_soc {
 };
 
 struct tegra_mc {
+	struct tegra_bpmp *bpmp;
 	struct device *dev;
 	struct tegra_smmu *smmu;
 	struct gart_device *gart;
@@ -229,6 +235,7 @@ struct tegra_mc {
 	struct tegra_mc_timing *timings;
 	unsigned int num_timings;
 
+	bool bwmgr_mrq_supported;
 	struct reset_controller_dev reset;
 
 	struct icc_provider provider;
-- 
2.17.1

