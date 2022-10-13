Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEA25FE1B1
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 20:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiJMSoD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 14:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbiJMSnk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 14:43:40 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on20617.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::617])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD5D2B1AB;
        Thu, 13 Oct 2022 11:41:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebt10oCNlk/VvMhtOHVY1GH33El+/SkHZee+ceq6uYT14Lra3ksKIxrsFjgEVoOixyXo7jO6tOEIvVbaSZ+CftKHpmiE4T6jPejRIGqzOIiYmDzu5sCvJTjG6V8CR9OJDZoUG/jvQ8DmT97Cl87qo7l4l3wG1De6Ox9Ki0YOsR6StYzjE+/G5Nct+jm+mbkXbbrLePB8tNfwuQH9LC/16wjuybfP5iSjo595GxsC9p0AiH/mynK4fOwZSu2rcCNbMsyDDtJYsCNVUqrE1fCD/R6H8AfFhbiS/IX3BkrW6LkqQB5iXkddQIw5PpCYUcggEyOYdLUtI4a+BYMpoMcQ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxhMeYnpGTaigWSLa7nBbJua/yYgWcM6sOMyjZ7BhdQ=;
 b=MwyU37Vy/52o1J+2o/q6FhxFzNxA9uJQZ4b6dgsU52TUDD7r0ssqx0W6wpzYH/MyZ89OcwAlb9H7u9ks4NJEBoL3YQ415ope5gZS3KCaU1WwJzcHbxo0vsJt4FiSG/z1+ZJf38lQKeJfEtc9R8X7ePXyaXpuHoeuI/dvpODG/6S/oyDqOyulJoqdlD2CH6V0oxhpeoxs4XjrMfiqSQIgLNMWH5bXLV/gmRMGqWZMKk7J0yPJBogrX4S+i++un+RUnCiGWuAnVySYPaLMf2SlL2pSKpEx3VFmA9fuTATMoWaHRGFxED4Rp3emCvRUc7+UoOenM6gFP9FhkQqAWHQpQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxhMeYnpGTaigWSLa7nBbJua/yYgWcM6sOMyjZ7BhdQ=;
 b=AexbpklnWIi71wZ2t7Istk9dZzo+cF7vmlFRMyaUmWaL35pmUEcSNM5sxartn2YpPsNUSwHY9pKevV91XvnbxHs+f60xnKc739CsGWWjYcnwr0VmOQmELOZUihjv/nByV64H/60gs2EFDXQJxE2qOGopRzDfh2xo4NnxpX+Pa5EWPJv3PyIknL2rgWikeLhfeJlHwNp6n9ZPP+f05fMWvrPV8sHSd5Gw4+bnWgHvZ4TGXr+AkvrJ1SdWQjsp7ZtJrOIGoWlabp0p7q2q02S/rk+YH5WtO9NtsgbMXmZlCCms+WSAFgrnrXCn8ZUlRFORUD1j/J9irPJ4EdFLoL9utw==
Received: from DM6PR08CA0020.namprd08.prod.outlook.com (2603:10b6:5:80::33) by
 DM4PR12MB6087.namprd12.prod.outlook.com (2603:10b6:8:b1::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.15; Thu, 13 Oct 2022 18:40:48 +0000
Received: from DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::a9) by DM6PR08CA0020.outlook.office365.com
 (2603:10b6:5:80::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Thu, 13 Oct 2022 18:40:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT081.mail.protection.outlook.com (10.13.172.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 18:40:48 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 13 Oct
 2022 11:40:43 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 13 Oct 2022 11:40:42 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 13 Oct 2022 11:40:38 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <vkoul@kernel.org>,
        <mani@kernel.org>, <Sergey.Semin@baikalelectronics.ru>,
        <ffclaire1224@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V3 15/21] PCI: tegra194: Disable L1.2 capability of Tegra234 EP
Date:   Fri, 14 Oct 2022 00:08:48 +0530
Message-ID: <20221013183854.21087-16-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221013183854.21087-1-vidyas@nvidia.com>
References: <20221013183854.21087-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT081:EE_|DM4PR12MB6087:EE_
X-MS-Office365-Filtering-Correlation-Id: febfad2c-a646-48ad-0091-08daad4a7258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9B877wshN5K0e30wFa9Oq7T2VX5j74eq7lnBOuD3WcIiHj7oq+NLAoUqKzcjYNYaZ3+V6ghtijzQJIjoPIDZXOtuHixZKucUIVWi78RvKzbbuf0cG6yFHSo6BJbqzNdYljiPoCJHl09Bso2NomxdRg71B7PGNxzZTJRWsREu071vS+AFOIAxewpyq9acAs+UDJFGwGD3ZJ01fITE+4YSngOM/u+JJ1ojQ6xfLnrvx0y7V9XEiszXsT0je+ObRycexBccgVfJaFYiordiBbja0xNKIfkDuc6RK4Lx5aYLt6FCy76LKzAGSxqW6PxN2VGXc7FgQoem1fAaWc6+G25eLOTttzBcK6UxkdI5OWK2MmP3OZDSHqkacrSzeLZ5coj3imWS/OGAuWPpSwGpdg9c0mwvJzFWQSk36jkoXmAo5fP27et+kdSlGkfAJ8tnnZQUA3YkK4i5iidG8BtAn8exP+RjZfRNeHDIHMWPhmT3oelb98EhSutnF9mmbxV9yhPU+ZDtPsI0c2P/bEaqojkAyUZ/He425dYOuuXsG+Bgw8qDz0fqdMKEPfIGLTSzFv7qffs2uE2FEiecKm9hlCGL/kO4t3CD/BnXxkkrG6D+iOgFFfVoytTS3rtKGRvJltYYfpBXRzMlMaF1V4Y+vtw2FjOc6BbYMH3pz6WkGXZFoPWJ8kON614ijDUlTFaIZ6Ie4bvziHRZ1SfLy3xSXe9S6K0Gotz1hmRHoDPoX6imfR53zPzpZDcNd1+/rZUG8dh3TsLMlrrLQW5l2janmjo6LAhbM2yEtZ8MeGv8MrOXJa0=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(186003)(5660300002)(36860700001)(54906003)(41300700001)(47076005)(86362001)(426003)(2616005)(40460700003)(40480700001)(83380400001)(478600001)(7416002)(336012)(2906002)(1076003)(316002)(6666004)(36756003)(110136005)(356005)(7696005)(82310400005)(7636003)(82740400003)(921005)(70206006)(26005)(8936002)(70586007)(4326008)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 18:40:48.2339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: febfad2c-a646-48ad-0091-08daad4a7258
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6087
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When Tegra234 is operating in the endpoint mode with L1.2 enabled, PCIe
link goes down during L1.2 exit. This is because Tegra234 is powering up
UPHY PLL immediately without making sure that the REFCLK is stable.
This is causing UPHY PLL to not lock to the correct frequency and leading
to link going down. There is no hardware fix for this, hence do not
advertise the L1.2 capability in the endpoint mode.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* This is a new patch in this series

 drivers/pci/controller/dwc/pcie-tegra194.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index e6fd713e9868..d592cf68b02c 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -246,6 +246,7 @@ struct tegra_pcie_dw_of_data {
 	bool has_sbr_reset_fix;
 	bool has_l1ss_exit_fix;
 	bool has_ltr_req_fix;
+	bool disable_l1_2;
 	u32 cdm_chk_int_en_bit;
 	u32 gen4_preset_vec;
 	u8 n_fts[2];
@@ -1967,10 +1968,11 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	init_host_aspm(pcie);
 
 	/* Disable ASPM-L1SS advertisement if there is no CLKREQ routing */
-	if (!pcie->supports_clkreq) {
+	if (!pcie->supports_clkreq)
 		disable_aspm_l11(pcie);
+
+	if (!pcie->supports_clkreq || pcie->of_data->disable_l1_2)
 		disable_aspm_l12(pcie);
-	}
 
 	if (!pcie->of_data->has_l1ss_exit_fix) {
 		val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
@@ -2589,6 +2591,7 @@ static const struct tegra_pcie_dw_of_data tegra234_pcie_dw_ep_of_data = {
 	.mode = DW_PCIE_EP_TYPE,
 	.has_l1ss_exit_fix = true,
 	.has_ltr_req_fix = true,
+	.disable_l1_2 = true,
 	.cdm_chk_int_en_bit = BIT(18),
 	/* Gen4 - 6, 8 and 9 presets enabled */
 	.gen4_preset_vec = 0x340,
-- 
2.17.1

