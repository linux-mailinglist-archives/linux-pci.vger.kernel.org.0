Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCFD6D06EB
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 15:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjC3Nff (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Mar 2023 09:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbjC3Nfe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2023 09:35:34 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5EBBBAE;
        Thu, 30 Mar 2023 06:35:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lm1XjmYQXu5SDllFQRlzd74jGMrLQnRTlFAw3ZtmT1BqeaRfZLRIAI6WxHs7vftQ0miSG545bpsKL/afeTaD6uvayBIHXdRGqTXghRAO4RJVyYCKA22Y7psx2FwMU2fASYGxoR00Dfg1r6Lk9kzaIEEHSqgTlCGiRIubKSC1l+kiRz5JPnWr39UrWw8PPy6ZtCeLHK1OiARfsw39Em3kqpRN1imNrLMdpfhRSIKNPkgSMktgVxiW5SJLcakGvNmd6deCBgiu7+Ow9jXzTcpSlmj2z0dTtYVFAriKeeYQgx6On8g/RC5h4xpW/MomuyBoRX08IEZMYp0L9wFCbdw7pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EdIUYc+1VOETrwAvPfeu9lyIxD+P3dgHCVjxbEq8t4=;
 b=NRKAenlogGV3Ap5NTXk3mO8GeD28XEXJ8pe5EWJJTDoafNXuRanPZLK+FjnnRQKHms7qFN420mrTAu5Xq8+WgjgGKeh435nmSzV3tmq5bC/2jUTiqofEyVC0U8FDEscnRd5GhXzpmoq9F/PSqkDnuWjdomfdVmirGqOhhJ9FVFizlgYXw/AngF7KqpGX78O+yzCunFGfn0BGjis+dJA9gKJYnbu7QEXDmpns5+q58B3Ll/YwWcu7i0QmChVO2x36XfSKusOZP9Mtto5Z7WH0KTdIYwtRZLIAhzx4Zszwyh89RnbR8yxdCznFpfztGCj8uSNFdIGvOyokIrukhD8hOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EdIUYc+1VOETrwAvPfeu9lyIxD+P3dgHCVjxbEq8t4=;
 b=EMaYQukJhlg65tMxdiX30qAKfhDt9DIW6BJ60mnbrK/nQthpPVePnSeZh6NqaEtoOo40h2+HOinZwavVnPvBAUQ3cn1pvBEDBNE6s2o4w9xzyioi52cVYD8JsH5mEHYBE+5688kESF5akriJEZ085LER4RcP6i8q1Gq7fpoc62kmyFfz94VTAhRPpH11Vd1uyE5dp11sHG76wa3Rx6f11Y3zpMaGsepKXfFShwNahTMXkVe6G+4lR+ZQq7wXTt+4T3aEiozzf1RhiDw1T/AYl6qxW/re7FCDuRu6HJA04n36+6FKf00z1oL0KAeUGXnWkDY8tQp1QzcFeMGTuu1TWA==
Received: from MN2PR16CA0005.namprd16.prod.outlook.com (2603:10b6:208:134::18)
 by BY5PR12MB4194.namprd12.prod.outlook.com (2603:10b6:a03:210::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 13:35:02 +0000
Received: from BL02EPF000100D1.namprd05.prod.outlook.com
 (2603:10b6:208:134:cafe::56) by MN2PR16CA0005.outlook.office365.com
 (2603:10b6:208:134::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 13:35:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF000100D1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 13:35:02 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 30 Mar 2023
 06:34:55 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 30 Mar 2023 06:34:54 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 30 Mar 2023 06:34:49 -0700
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
Subject: [Patch v5 3/8] memory: tegra: add software mc clients in Tegra234
Date:   Thu, 30 Mar 2023 19:03:49 +0530
Message-ID: <20230330133354.714-4-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230330133354.714-1-sumitg@nvidia.com>
References: <20230330133354.714-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D1:EE_|BY5PR12MB4194:EE_
X-MS-Office365-Filtering-Correlation-Id: 21a45881-36e7-4e3d-5cdc-08db31239095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qu6DrmUPvbIbNgYpM+Tt+mObrrzqQnNpPyBqIu+Kc40eqrDHYPbDl/fVziB+3X7nM56H0cEhj1W95mqXH6Z4j32URbQFwMbq31Pi/73bVCLurEn9t3eDxa4QphppwnJ3tXHS4TzCAMLFS4ld+pQATv1dZvUVYexncU2F3BDKVLuG7UNYbGSYdV6xge2egleP82A9E+Od0k//v2rioO1ebYFCm7HY+Rdp+0DXUR4qh9wMh4ASOJ/0fAOpa3r6DUIC65qgE6kx8Dxd0K9pYKTy0h43+Wkpf5zGUb4HPzJvbWwEjmYlC9sCWFwrEL/ryz8i2Ma5xVXTw2PrGr+JDBbGR09ghvuYrh9xQkf2OdnT1FrEPsGo1dQmDOw2jVbUXmFaiIDEpuPdxgM19rruWzAA43d8aEfBdjrRPYvHE8ZJb8vXMGIpEycvbperTAtjAGEJY9jLGUvqymyFaVHI23mH7MUHeosQyJRsOauZ10EBKceX/gb88bVA59dgSgYEH9K374c6FGLK4y5f/2gVkNL6LcozOsF1g6+7yWOYNC+twqU9RlCn1rs2LIn+v6wbwdoJQ5mVAFFkInPIoNiE610iMpJsVJ+OHMltHIQDYMJ7OvPkz8O3m/crIB1QwWVtItgRH8iUhTe4xuZJYP5TCDBL/ZQ6YwM4yp/HkcyiD+AjIDiM7ixtmdDXRyCHTKdKVPafmP4jf1INRijQ7C4lvRuhZuaeC6o+0/8QO3bZZXAObpE=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(46966006)(36840700001)(83380400001)(107886003)(26005)(7636003)(356005)(1076003)(316002)(54906003)(110136005)(7696005)(40480700001)(70206006)(8676002)(70586007)(82740400003)(478600001)(36860700001)(4326008)(36756003)(82310400005)(86362001)(41300700001)(7416002)(5660300002)(2616005)(47076005)(426003)(336012)(8936002)(2906002)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 13:35:02.0349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a45881-36e7-4e3d-5cdc-08db31239095
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4194
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add dummy Memory Controller clients to represent CPU clusters.
They will be used by the CPUFREQ driver to scale DRAM FREQ
with the CPU FREQ.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/tegra/tegra234.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
index a4ea181e1090..0fa68862749f 100644
--- a/drivers/memory/tegra/tegra234.c
+++ b/drivers/memory/tegra/tegra234.c
@@ -777,6 +777,21 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
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

