Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1D869CEE7
	for <lists+linux-pci@lfdr.de>; Mon, 20 Feb 2023 15:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjBTOHz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Feb 2023 09:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjBTOHx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Feb 2023 09:07:53 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2CD1EFF4;
        Mon, 20 Feb 2023 06:07:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIX+TSlpNVxkV5q0keA9oM6hklHGgqxqvyogzs3O0N0pJE9SrL39xQ42pPnVJPsYhXGBrT90QBjYZhDseEZ2TeG/HT5Tehi2+OqNNqkCNbQkn/O4Mb03kit53BxOWh8Kvc9y/KJKSVZB4N4dodlTJ3s5JkUebckhCW8sVyczZmbwhclIWe/Dw9ai+5LaA/XLXmnmwcu9M6WaZhivVoECLlMH8Sr64YWsykvijLF5NMhk4PtzCAm2rOQEtSbQUbFVYsyJ0TeoG+0WW3JViLTowMJyghgIOMKkbWUjzacn2tOJXpU0Sk8mtsdgxs2y27sYLog2r9UFVNL/wwBC4MRYkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yjmhbNYSe1T16AjJipljh0WoIA4BJmqSOBzwIHBCVE=;
 b=S5vZUjj8996n+WmjnoKNYyUNQmN0SzTnQvn/em1ZuYwNeNy5cTy1R8k1hGBD+tkKsgtYr3N2QeD/QNgTYP87V3N4SqAMve97YuSdytPRpwtic8Bf2d3//hPi0k3qBche/tjX7QJNw4eXnC7QDwDyBTfOSYrMHUulZ02zaa0Qz04U22AucilGs/Fj4cX1xadEjNd05dEWnxQikox5TY1BF6y9J5xV+4Gpj5jpPE6v3OxEm5xr0SEg9h4csugZ/Etm/B7fOPyqn10vRKypTqjoqVZFux3a0jrAYf4u1Av1MJ8QndiVrGezWQ2NayftrjD//5zxzsV8jYqS9dyyf9Bfvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yjmhbNYSe1T16AjJipljh0WoIA4BJmqSOBzwIHBCVE=;
 b=clJKbntxwzyhll/FBcOnNsd5V7pUFadNgUGSjMMfrxG3AjViHJ4cqL9w26+T9BslfRjtFun86+CyqwAxMiI0vB3QCzCsFrEy/AoOSe7iacDwqg9au20yL0xwE50SQlEzDuqDBq6Z1Sv319SsnCy5xxxnHQWtPVa+IkIJr/T5fll1JOh3sxuROze7H991I826rs3Bm/FVKiqIKLf/tpKzwJ7vRT32AITncwSs1QGdzjd7A+h1R5+1wQykXxE4v+2cwJKK9KaYJdFhlJsAQ4PSQ7YA3n/6YhVL5cayW9SN6KpIvxemML7aOXR43DGTlTJc30yHHinKiByRFd8PZMpPjg==
Received: from BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14)
 by PH0PR12MB5607.namprd12.prod.outlook.com (2603:10b6:510:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Mon, 20 Feb
 2023 14:07:21 +0000
Received: from BL02EPF0000C409.namprd05.prod.outlook.com
 (2603:10b6:208:2bd:cafe::49) by BL1PR13CA0159.outlook.office365.com
 (2603:10b6:208:2bd::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.16 via Frontend
 Transport; Mon, 20 Feb 2023 14:07:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0000C409.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.14 via Frontend Transport; Mon, 20 Feb 2023 14:07:21 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 20 Feb
 2023 06:07:06 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 20 Feb
 2023 06:07:06 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Mon, 20 Feb 2023 06:07:00 -0800
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
Subject: [Patch v2 4/9] memory: tegra: add software mc clients in Tegra234
Date:   Mon, 20 Feb 2023 19:35:54 +0530
Message-ID: <20230220140559.28289-5-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230220140559.28289-1-sumitg@nvidia.com>
References: <20230220140559.28289-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C409:EE_|PH0PR12MB5607:EE_
X-MS-Office365-Filtering-Correlation-Id: 8979c855-a06e-43e3-a375-08db134bc89b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /y8kVl8wXkpDLk/WAbSvWafVon7QLeVD+/SLBoG40j+XU4eKX9SSp23rX/Kw4bcppyduFlFclZIpM2NzWP7gzoCb/bq8X/0XEVjQ7n2vkZijjmdeVtY8wykyjOceXFCG3wKpl9JYhIFmg4qTyajfq08VAvm/mbWuCL8lUQgFVLKM8UCUNbIqgxIAFDmnvc258j/xK431CFgZkvCRinn/oJyb25+Ct1DGaAKcZ/adZP7TvortX0XTraifx1lFq5wXSYwh45cXXBSgFc/boEPmJ84DpWIAfThmL5ZdbnFmSyAw5izUSLHSeJ9GDx9k2uxKw8xHte8uGDaIkkLj4WA4zYAkWbIsY6ubhQkC2pCXc8DIs0cJ3INgEBKKm4PRq33aT7j+VMyYAwA/72p9JOVbG9C578Q54t0c1GYamlxnubKMs/exe0KulstCj9nZfLhSQ4OP+ZKvE597ldVKEG4hdo68dHCOrRY4MeHYc+v5emzckmjC7b80bhfm1Vs9Bj5vIb2cjh7Qus+xAa272chchHKx1L2nnVYj7Q0IhT+TgqOqOC7OeJ489yiMEYzroZFQmzxiGKwFJKaoJ863o/jk4gz68u+3mxNOIJTdceFnfku1LKqgseIubLy8V6+/euh4gdKTWyxmMauulYq7RmwPpzVkppn59zYoM9TQ6zqsJmMPuiK2NKGBra15G0MSAY6EvtHDxN5oklivRwtEN1iaXw==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199018)(36840700001)(40470700004)(46966006)(82740400003)(7636003)(82310400005)(36756003)(356005)(36860700001)(40460700003)(40480700001)(6666004)(186003)(26005)(70206006)(7696005)(107886003)(1076003)(316002)(2906002)(110136005)(478600001)(2616005)(54906003)(70586007)(336012)(4326008)(8676002)(8936002)(5660300002)(4744005)(83380400001)(86362001)(7416002)(41300700001)(426003)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 14:07:21.0300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8979c855-a06e-43e3-a375-08db134bc89b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C409.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5607
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add dummy Memory Controller clients to represent CPU clusters.
They will be used by the CPUFREQ driver to scale DRAM FREQ
with the CPU FREQ.
---
 drivers/memory/tegra/tegra234.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
index 7ca744036f59..0c666e52bf46 100644
--- a/drivers/memory/tegra/tegra234.c
+++ b/drivers/memory/tegra/tegra234.c
@@ -778,6 +778,21 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 				.security = 0x244,
 			},
 		},
+	}, {
+		.id = TEGRA_ICC_MC_CPU_CLUSTER0,
+		.name = "sw_cluster0",
+		.bpmp_id = TEGRA_ICC_BPMP_CPU_CLUSTER0,
+		.type = TEGRA_ICC_NISO,
+	}, {
+		.id = TEGRA_ICC_MC_CPU_CLUSTER1,
+		.name = "sw_cluster1",
+		.bpmp_id = TEGRA_ICC_BPMP_CPU_CLUSTER1,
+		.type = TEGRA_ICC_NISO,
+	}, {
+		.id = TEGRA_ICC_MC_CPU_CLUSTER2,
+		.name = "sw_cluster2",
+		.bpmp_id = TEGRA_ICC_BPMP_CPU_CLUSTER2,
+		.type = TEGRA_ICC_NISO,
 	},
 };
 
-- 
2.17.1

