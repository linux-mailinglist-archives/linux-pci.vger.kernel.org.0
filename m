Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE1369CEDF
	for <lists+linux-pci@lfdr.de>; Mon, 20 Feb 2023 15:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjBTOHN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Feb 2023 09:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjBTOHM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Feb 2023 09:07:12 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20625.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::625])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7E720053;
        Mon, 20 Feb 2023 06:06:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEwpp2MvH9PnB/h7+Y1rULWuWY1BumXPmR1gx9M5xOSOgKEZfWRdxkjb02GKFhs6vydga/8C3t9GYeUNI2NZyas2BmhjRrTTX0m+DPLgcOv/efH1k/PMcarT03ZrbwuKOnt+kdUBr5LYuYheMPuiWscc1r/0BdKzlyWvA0pfGRawSFKe7qEZINPOM/8j7MyeFtJeAFOgY2wkGsk1pbb2vtXq106pxpAI+kz1zQj07qmVN9XVakj1FWtLKKcExNre0xsqW5wenWNwvFYDfxoQWQv0CJHfYDFIzASV9nZrClX8cXvmGbZWwuIgxL1f+x+2xMS8h0MTc2s4MiezDmM4hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/a9CYoyvTEdPRQpYUPnurLigAb2fENY+MpMKAIDNLs=;
 b=N+fAGNakoMv/6rxbKWlRr0j4AiDLi7t9aCDNjZQ5pTnDTx2UIbg3encVhJdXygHcFncWDZLz/QBm9cwifKErVcHVjPJaMFayTVbOazxteYd0OBHKIDFBu67/w0uZo1qB5g/TjOxI5BpNff3XNpuz5lcE7IHDb6nv948FPEVYSjzUgi9p8R8Vs2SaZ3kQLrg48cHm/tg4U+vOp6kB8tRPzyYPp+a9+Ep4hNxdiygHqWnWD0bG+kFhZu2X5IVI8zxAzZd6JzyGDIZxZSjtPFt9RRXSk+aUaB9bqLkGwy8zTqzVZ9X+S9XWwPhLIkAQyLx1iIWbPeHWIBsfUVMsODyvGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/a9CYoyvTEdPRQpYUPnurLigAb2fENY+MpMKAIDNLs=;
 b=Xduz/qFyfsrL3ouaOkjEvymZ4ROgx85QvNQ9o0axhYn6iJsNnELxq2lQkYlD0U4pCg9mY/FnUia2zAuhDMfQM3NKhrdHu6GBtFY0SMuekKLS56HUI5+asItmF89VkaqmWKnljHi/r4/Hk5qakZqHHhMKXbcrNbDx9pH7vomJNdPMJ+GhzH6pfzwQrKLQ/Kj+3wIRK5RlaaVGXIQGQ54AbCAMkOtsplR401cqhFWttzh0xlPAx7IgQSSlOLGBTJm3EKuThObiujWKxkVmK6i+gcgCOWA6O+JpRiTC7674LhurfbE+eV6qjQfj7VILtSxDbPf3+AishbyBOH/5Yb3RFA==
Received: from DS7PR03CA0294.namprd03.prod.outlook.com (2603:10b6:5:3ad::29)
 by MN0PR12MB6053.namprd12.prod.outlook.com (2603:10b6:208:3cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.18; Mon, 20 Feb
 2023 14:06:45 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::ae) by DS7PR03CA0294.outlook.office365.com
 (2603:10b6:5:3ad::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20 via Frontend
 Transport; Mon, 20 Feb 2023 14:06:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.19 via Frontend Transport; Mon, 20 Feb 2023 14:06:45 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 20 Feb
 2023 06:06:36 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 20 Feb
 2023 06:06:35 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Mon, 20 Feb 2023 06:06:30 -0800
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
Subject: [Patch v2 2/9] memory: tegra: add interconnect support for DRAM scaling in Tegra234
Date:   Mon, 20 Feb 2023 19:35:52 +0530
Message-ID: <20230220140559.28289-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230220140559.28289-1-sumitg@nvidia.com>
References: <20230220140559.28289-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT009:EE_|MN0PR12MB6053:EE_
X-MS-Office365-Filtering-Correlation-Id: 61f116f5-a43c-46d3-5688-08db134bb381
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LMwB9vklEB447xZUTS8j6vW9JWxLgWDb7IDQLfKcwov/x92cUNZ1MOoj/Hv57JE/QYMchV4xMnZEZByJoLnjGOOMqM/nKw1Tw4sBz83WEt3DdhQ7OyHponC7n101KZ49bTO6JFPwqnrZhUGJiPU7fwSnqefBdEKp/BxEfGHoUGdlXyXgsHoQB4dMLQoDd/z3JASfytcas+++G0nj5wrhkZQPnM6gn+/uqojFp4Z21Dyw9gm86j1lcCgZ9ZSnXUlkMKbbiHS9lb/kdEM4vKkaxKIEKfJKuMCFwcBc8UfY8hHRW+Gv/AZ9F4b+ZX1vTMtfgfgEpUY5olDNieHDnzMxHzO0XAfvsH+psxQYAwOg3Hse6IOM5mZApVcjFpjO5ibiMYHFxivzEDWQXZUo97qBBrEr7bMX5c+wlYaGoAQ1MaAbtB4/zYBxUAu92xvLqXUTQ4hdUwn8ZiY7eCJmXndwIVECB1k+jE8/7C+MjvbCvjwM0UzJDth5mPxLZtUb4jVOMSbz5QWDHHRA2b2vGXpnyfs/FTV/kPVfe725KQl/zvDZ6dCZ376RHXgHoxauXENMOgLHAuMNnOdlglH3aqQdHlKFgTWyk1F6MRs68RBWRntEpRo49+muaS6xD9PuDMdIJsb8L787X45NJiRcJ73/p38aWD0jzT1/mjTpAbAVeu5FWjPK73WgNEK9qmMxuW3ybHSZhim6ww+BAia2I5ZTRg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199018)(46966006)(36840700001)(40470700004)(1076003)(8676002)(26005)(356005)(186003)(4326008)(70586007)(70206006)(36756003)(83380400001)(86362001)(47076005)(40480700001)(336012)(2906002)(426003)(7636003)(2616005)(36860700001)(107886003)(6666004)(8936002)(82310400005)(30864003)(5660300002)(7416002)(41300700001)(40460700003)(7696005)(110136005)(316002)(54906003)(82740400003)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 14:06:45.6567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f116f5-a43c-46d3-5688-08db134bb381
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6053
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
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
 drivers/memory/tegra/tegra186-emc.c | 117 +++++++++++++++++++++++
 drivers/memory/tegra/tegra234.c     | 139 +++++++++++++++++++++++++++-
 include/linux/tegra-icc.h           |  65 +++++++++++++
 include/soc/tegra/mc.h              |   5 +
 5 files changed, 330 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/tegra-icc.h

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 592907546ee6..7318eaa3819c 100644
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
 
 	err = icc_provider_add(&mc->provider);
@@ -828,6 +831,8 @@ static int tegra_mc_interconnect_setup(struct tegra_mc *mc)
 		err = icc_link_create(node, TEGRA_ICC_MC);
 		if (err)
 			goto remove_nodes;
+
+		node->data = (char *)&(mc->soc->clients[i]);
 	}
 
 	return 0;
diff --git a/drivers/memory/tegra/tegra186-emc.c b/drivers/memory/tegra/tegra186-emc.c
index 26e763bde92a..756a5fefb383 100644
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
@@ -146,11 +155,104 @@ DEFINE_DEBUGFS_ATTRIBUTE(tegra186_emc_debug_max_rate_fops,
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
+	err = icc_provider_add(&emc->provider);
+	if (err)
+		goto err_msg;
+
+	/* create External Memory Controller node */
+	node = icc_node_create(TEGRA_ICC_EMC);
+	if (IS_ERR(node)) {
+		err = PTR_ERR(node);
+		goto del_provider;
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
+	return 0;
+remove_nodes:
+	icc_nodes_remove(&emc->provider);
+del_provider:
+	icc_provider_del(&emc->provider);
+err_msg:
+	dev_err(emc->dev, "failed to initialize ICC: %d\n", err);
+
+	return err;
+}
+
 static int tegra186_emc_probe(struct platform_device *pdev)
 {
 	struct mrq_emc_dvfs_latency_response response;
 	struct tegra_bpmp_message msg;
 	struct tegra186_emc *emc;
+	struct tegra_mc *mc;
 	unsigned int i;
 	int err;
 
@@ -158,6 +260,9 @@ static int tegra186_emc_probe(struct platform_device *pdev)
 	if (!emc)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, emc);
+	emc->dev = &pdev->dev;
+
 	emc->bpmp = tegra_bpmp_get(&pdev->dev);
 	if (IS_ERR(emc->bpmp))
 		return dev_err_probe(&pdev->dev, PTR_ERR(emc->bpmp), "failed to get BPMP\n");
@@ -236,6 +341,17 @@ static int tegra186_emc_probe(struct platform_device *pdev)
 	debugfs_create_file("max_rate", S_IRUGO | S_IWUSR, emc->debugfs.root,
 			    emc, &tegra186_emc_debug_max_rate_fops);
 
+	mc = dev_get_drvdata(emc->dev->parent);
+	if (mc && mc->soc->icc_ops) {
+		if (tegra_bpmp_mrq_is_supported(emc->bpmp, MRQ_BWMGR_INT)) {
+			err = tegra_emc_interconnect_init(emc);
+			if (err)
+				goto put_bpmp;
+		} else {
+			dev_info(&pdev->dev, "MRQ_BWMGR_INT not present\n");
+		}
+	}
+
 	return 0;
 
 put_bpmp:
@@ -272,6 +388,7 @@ static struct platform_driver tegra186_emc_driver = {
 		.name = "tegra186-emc",
 		.of_match_table = tegra186_emc_of_match,
 		.suppress_bind_attrs = true,
+		.sync_state = icc_sync_state,
 	},
 	.probe = tegra186_emc_probe,
 	.remove = tegra186_emc_remove,
diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
index 02dcc5748bba..b40229926558 100644
--- a/drivers/memory/tegra/tegra234.c
+++ b/drivers/memory/tegra/tegra234.c
@@ -1,18 +1,24 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2021-2022, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (C) 20212-2023, NVIDIA CORPORATION.  All rights reserved.
  */
 
 #include <soc/tegra/mc.h>
 
 #include <dt-bindings/memory/tegra234-mc.h>
+#include <linux/interconnect.h>
+#include <linux/of_device.h>
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
@@ -23,6 +29,8 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_MGBEBRD,
 		.name = "mgbebrd",
+		.bpmp_id = TEGRA_ICC_BPMP_EQOS,
+		.type = TEGRA_ICC_NISO,
 		.sid = TEGRA234_SID_MGBE_VF1,
 		.regs = {
 			.sid = {
@@ -33,6 +41,8 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_MGBECRD,
 		.name = "mgbecrd",
+		.bpmp_id = TEGRA_ICC_BPMP_EQOS,
+		.type = TEGRA_ICC_NISO,
 		.sid = TEGRA234_SID_MGBE_VF2,
 		.regs = {
 			.sid = {
@@ -43,6 +53,8 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_MGBEDRD,
 		.name = "mgbedrd",
+		.bpmp_id = TEGRA_ICC_BPMP_EQOS,
+		.type = TEGRA_ICC_NISO,
 		.sid = TEGRA234_SID_MGBE_VF3,
 		.regs = {
 			.sid = {
@@ -52,6 +64,8 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 		},
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_MGBEAWR,
+		.bpmp_id = TEGRA_ICC_BPMP_EQOS,
+		.type = TEGRA_ICC_NISO,
 		.name = "mgbeawr",
 		.sid = TEGRA234_SID_MGBE,
 		.regs = {
@@ -63,6 +77,8 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_MGBEBWR,
 		.name = "mgbebwr",
+		.bpmp_id = TEGRA_ICC_BPMP_EQOS,
+		.type = TEGRA_ICC_NISO,
 		.sid = TEGRA234_SID_MGBE_VF1,
 		.regs = {
 			.sid = {
@@ -73,6 +89,8 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_MGBECWR,
 		.name = "mgbecwr",
+		.bpmp_id = TEGRA_ICC_BPMP_EQOS,
+		.type = TEGRA_ICC_NISO,
 		.sid = TEGRA234_SID_MGBE_VF2,
 		.regs = {
 			.sid = {
@@ -83,6 +101,8 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_SDMMCRAB,
 		.name = "sdmmcrab",
+		.bpmp_id = TEGRA_ICC_BPMP_SDMMC_4,
+		.type = TEGRA_ICC_NISO,
 		.sid = TEGRA234_SID_SDMMC4,
 		.regs = {
 			.sid = {
@@ -93,6 +113,8 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_MGBEDWR,
 		.name = "mgbedwr",
+		.bpmp_id = TEGRA_ICC_BPMP_EQOS,
+		.type = TEGRA_ICC_NISO,
 		.sid = TEGRA234_SID_MGBE_VF3,
 		.regs = {
 			.sid = {
@@ -103,6 +125,8 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_SDMMCWAB,
 		.name = "sdmmcwab",
+		.bpmp_id = TEGRA_ICC_BPMP_SDMMC_4,
+		.type = TEGRA_ICC_NISO,
 		.sid = TEGRA234_SID_SDMMC4,
 		.regs = {
 			.sid = {
@@ -153,6 +177,8 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_APEDMAR,
 		.name = "apedmar",
+		.bpmp_id = TEGRA_ICC_BPMP_APEDMA,
+		.type = TEGRA_ICC_ISO_AUDIO,
 		.sid = TEGRA234_SID_APE,
 		.regs = {
 			.sid = {
@@ -163,6 +189,8 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_APEDMAW,
 		.name = "apedmaw",
+		.bpmp_id = TEGRA_ICC_BPMP_APEDMA,
+		.type = TEGRA_ICC_ISO_AUDIO,
 		.sid = TEGRA234_SID_APE,
 		.regs = {
 			.sid = {
@@ -333,6 +361,114 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
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
+	struct tegra_bpmp *bpmp;
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
+	bpmp = of_tegra_bpmp_get();
+	if (IS_ERR(bpmp)) {
+		ret = PTR_ERR(bpmp);
+		return ret;
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
+	ret = tegra_bpmp_transfer(bpmp, &msg);
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
+	tegra_bpmp_put(bpmp);
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
@@ -345,6 +481,7 @@ const struct tegra_mc_soc tegra234_mc_soc = {
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
index 51a2263e1bc5..fefac9622987 100644
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
-- 
2.17.1

