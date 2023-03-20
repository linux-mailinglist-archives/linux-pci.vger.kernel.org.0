Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B976C2001
	for <lists+linux-pci@lfdr.de>; Mon, 20 Mar 2023 19:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjCTSgp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Mar 2023 14:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjCTSgL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2023 14:36:11 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794543645E;
        Mon, 20 Mar 2023 11:28:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzcHhSw2AC7XlQFbRoLQ5pRPSOSS9kNcraKWLzOkbznLtyexSSd3DaX05Fo2muquLrpRqL2sOE2JdUJlGC4ue4m523dIzuplXVlLrgUqDDj9pUbYWoNwtSJ/K9M6d6+SMx5DBWLid3kN12vV76l/tgFdRYobhxaORpq3F20U3wd53f4vGCzG7CO583rtSbK8qhQUquxopIaRJZRx4gUhpJC50B00D4Fu7uP3g0ep1Ar+C7pRb5PeSl+W9G8k+ChzfH35LuI/Gr+sblaXAIO9/tVyrY9huhDWZ1RuLCqgMgVLTfHMeHALQLFEfEIIe2LQq9oJbpmYZyi0GwNyJsM9yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFknPj1juTW4yd0nvS8kgtV28YxgIZKG3ZTe30gnatA=;
 b=Fx/jYw861a3R7WJw7IjuIphwq+I0mPbq916iSmzOREwrYVTOWNsC8vqc02wte5gMzBiTLWoNpooIsdyPxR4cmfUAUa8r8lSyYDi2sIqQQpEKnwn8Pn+uFRCF6p6E3Rf8+lsaVkvcIdWTKAkZZ1S/NDBxm79Wsl+E5FyueSKGI01jqp0ny41JvBmLeV8SESn/35GWBcDZukU6r1Z72wrrHgGgglDqIMrFYiF1bHdyA5H8uAU+OWh1tvMkESnDcYz8Kgmb+uy2+R4Q69fDT65Te1JpFkpQWS1QD2JardE8wHVJ7v3h0w24eO7DZYkBjVfDdTaSozUYcJ2jaQ+fK0nliw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFknPj1juTW4yd0nvS8kgtV28YxgIZKG3ZTe30gnatA=;
 b=HwZyWxMScnuOA9LGZMiebr04sPtYeSrR7SGYrZvdxtbzT1hDfrXhyGV8IHphlWd2EtQR4XkcZ0hl+JNLlBWWIrg+givrnQ32iQaE1JqGiD2Ju6smQbHfRvc+p7FHaH8Sl4cmkO4i3Sn1mr9Hl2/vewb1BYLuv7dMI8Cl7DfzmzNMS1OVALMbVh4SDngEzkXLmeWgU8efi68dHzpAEgIMfOxNfzA52EwfQ35Lt3OLOjNbDyNz6TrGWEwpQT2do6odRxqfUBBF8xl+UYcxpNFItcnSu5w4yGHIUwtJFC13KRBek4kiCcsDBZDRLBeHEjODEBLLfMF0V3aslc+ExBvRrA==
Received: from MW4PR04CA0059.namprd04.prod.outlook.com (2603:10b6:303:6a::34)
 by PH0PR12MB8125.namprd12.prod.outlook.com (2603:10b6:510:293::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 18:27:22 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::db) by MW4PR04CA0059.outlook.office365.com
 (2603:10b6:303:6a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 18:27:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.16 via Frontend Transport; Mon, 20 Mar 2023 18:27:21 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 20 Mar 2023
 11:27:13 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 20 Mar 2023 11:27:12 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Mon, 20 Mar 2023 11:27:07 -0700
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
Subject: [Patch v3 11/11] memory: tegra186-emc: fix interconnect registration race
Date:   Mon, 20 Mar 2023 23:54:41 +0530
Message-ID: <20230320182441.11904-12-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230320182441.11904-1-sumitg@nvidia.com>
References: <20230320182441.11904-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT056:EE_|PH0PR12MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a67cb8c-72c5-40e4-4494-08db2970bf00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aNmrClQK7SYCKuVaxl43iEGAVzMwtJQJ40SWsRwk0AejLb9CXlJYZkyeiGxQdXHlcv1DGSj14ZNvWFa0EWeKmGT1Ev9pkSkBsCZ0niASgWU7zY4W1t3s4JB3IIJESzRMVsnNZsIws+ieq0UU0WlKgjLgtrUsfWg8jRQlJbkWWoxbtQkmp0BkDiCAyjgpOWpY3wALa+7rrJH/+9WE7OIjsx57dczG95Mt+P8t45mGgz4JHz0u1BsPNigZmwOMIxmEBP2wXZEKPv/VRl10Xvbm2ZN9b1ukALb00RfmkHZomj5PbmbtLFIA9EwIQB5OxAvTJFuBN0tGtO+ca8QmOn8DEeGjY4uN2vXQDOkxNuiGV8V4EJOUDz4rZMX0OHLlNbY3WMIPM+sxoLFpRCIOwVlKbADSP9InlIJgjSEJ16zjFn4VMiFMW0GkBfqXfMGZgHFGrK+WGRdsVmS60xpwwKMYjuIG+LUzcIqO+RRDY3a/2yBinR579I4nEhazids32lg9QC4l/83NWVLw3CgptF+EXAfD+2nLD6+rDsb1jXmcYcJUq5V+cT6RVOiMyZhVmomOLvmACoigImTyZR0YAWdt49kX0z4IlcpJKKu8OcdbmKGkEMtrDkXAUfM8JAHuvyCJEsBv7P6iPcVluWpcReL52B7rUGZeLr2Nv1EbvjrVtoxb+4MpxBm2bbKqiWGzsaBwzqqU+bgdSlEDXKlXffbB95ta9bHLbzYmBChdPyIcyankjxLw396pGdePDA4t7/pC
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199018)(40470700004)(36840700001)(46966006)(41300700001)(40480700001)(4326008)(8676002)(70586007)(70206006)(82740400003)(36756003)(7636003)(2906002)(36860700001)(40460700003)(8936002)(5660300002)(26005)(1076003)(7416002)(82310400005)(336012)(107886003)(6666004)(47076005)(7696005)(356005)(186003)(2616005)(426003)(86362001)(83380400001)(316002)(478600001)(110136005)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 18:27:21.9349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a67cb8c-72c5-40e4-4494-08db2970bf00
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8125
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The current interconnect provider registration interface is inherently
racy as nodes are not added until the after adding the provider. This
can specifically cause racing DT lookups to fail.

Switch to using the new API where the provider is not registered until
after it has been fully initialised.

Fixes: ("memory: tegra: add interconnect support for DRAM scaling in Tegra234")
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/memory/tegra/tegra186-emc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/memory/tegra/tegra186-emc.c b/drivers/memory/tegra/tegra186-emc.c
index 0d68a20fd376..a5a2bce01db4 100644
--- a/drivers/memory/tegra/tegra186-emc.c
+++ b/drivers/memory/tegra/tegra186-emc.c
@@ -207,15 +207,13 @@ static int tegra_emc_interconnect_init(struct tegra186_emc *emc)
 	emc->provider.xlate = tegra_emc_of_icc_xlate;
 	emc->provider.get_bw = tegra_emc_icc_get_init_bw;
 
-	err = icc_provider_add(&emc->provider);
-	if (err)
-		goto err_msg;
+	icc_provider_init(&emc->provider);
 
 	/* create External Memory Controller node */
 	node = icc_node_create(TEGRA_ICC_EMC);
 	if (IS_ERR(node)) {
 		err = PTR_ERR(node);
-		goto del_provider;
+		goto err_msg;
 	}
 
 	node->name = "External Memory Controller";
@@ -236,11 +234,13 @@ static int tegra_emc_interconnect_init(struct tegra186_emc *emc)
 	node->name = "External Memory (DRAM)";
 	icc_node_add(node, &emc->provider);
 
+	err = icc_provider_register(&emc->provider);
+	if (err)
+		goto remove_nodes;
+
 	return 0;
 remove_nodes:
 	icc_nodes_remove(&emc->provider);
-del_provider:
-	icc_provider_del(&emc->provider);
 err_msg:
 	dev_err(emc->dev, "failed to initialize ICC: %d\n", err);
 
-- 
2.17.1

