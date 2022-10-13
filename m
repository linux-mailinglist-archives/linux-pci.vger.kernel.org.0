Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3EC5FE1B9
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 20:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiJMSoF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 14:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbiJMSnr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 14:43:47 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on20608.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EAD3CBEB;
        Thu, 13 Oct 2022 11:41:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ag9uvhb1hVlB+XwvAsgYMA00LbnSucihHrd96OB2Bl8153py3nbbSxQlDR18MZQYIMcE7Xy93HZmsUrd5OTXaWEsaUybjo32epTDT/9dLSswNm4xkHLxk7cdQK5fvSpIDxupNbkhAEGMH6nffHnPxYhfVx7nFz/pkQn7QuzCfdtNk6SSDNmLsfZR2soS+Cvkuak0gVfwIG4u4pi1KhScCZlpw5vNyEojFwWbgGyI6Vmf0CFxLFe6XMn1GPqJ+WC/xWRoFyH/kEI+gcFFCz0ueYRv//BT55Y2/95zpsJLez9gho5l4hl/f03sYqHMb2Xmse3MW2EdwWxdLZvpkQv55Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQO+syzulpuiLINlA8pRWfiNhP9XqNn52zizQyJSPbM=;
 b=YG7pjDuywayFEMTqSte7KqUWOAM5TVowrFDueguIzcZU0E21JVzbdjNB3CDO0q3hXL9BJ49RsrD9/+NoL2aH/YDbTPYo37legjFBzmGggJ4z8XHDlKEeKNPWtGlHAbJ/rZXUIUJXTou77yUNI5ySVcSFgS8ji4yYr4hIsAejTYwzKX0/c14JVxwWHETcLZrpS8yKbBnlSoA/Zhn4D6s/L/Ouk6KX3FLyZvtrshhz7/5jjxtakLyvTJksCtxEsR4eNrindoymeowXzj/qcudCLlp6YF30wzirviUjSOKT72y9fk2LVR4Y4JJYQ0wUholxmQZp2pDLdsZvc82NdsV0Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQO+syzulpuiLINlA8pRWfiNhP9XqNn52zizQyJSPbM=;
 b=rhiQOvAqe08IiccpYWeKhCJb0aKVenPFkCoXu8kTwsfoZYomq+4X0oFlTlO0K/iwS0myXf/bQSikIXJ2LT5cLXh+pNWl6yO2IzRcB0SiQBsOtuAu8f99mNN9J0nzO5dpdGnn+X2kbL7ZnBK+QSWSpVdYxkDELVdbDC0oQ9VYRI7aIsiMpppvXg9FE6wShnpfWWApYdAKr7UI9KIdOd2lYJzmQm2mUO3V772c4hYmFMKR0sXgVOtjQ65ktwz02HC+Tn+R6VHAiTxBhT9l/MAqpkL7JZZkgecT4/PArMr1JHu5ge9oGWm9uI0Cs5oGPIje0mecAmk/00urASgTYOfqHA==
Received: from DS7PR03CA0279.namprd03.prod.outlook.com (2603:10b6:5:3ad::14)
 by CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31; Thu, 13 Oct
 2022 18:41:09 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::8e) by DS7PR03CA0279.outlook.office365.com
 (2603:10b6:5:3ad::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26 via Frontend
 Transport; Thu, 13 Oct 2022 18:41:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 18:41:09 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 13 Oct
 2022 11:41:02 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 13 Oct 2022 11:41:01 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 13 Oct 2022 11:40:57 -0700
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
Subject: [PATCH V3 18/21] PCI: tegra194: Don't force the device into the D0 state before L2
Date:   Fri, 14 Oct 2022 00:08:51 +0530
Message-ID: <20221013183854.21087-19-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221013183854.21087-1-vidyas@nvidia.com>
References: <20221013183854.21087-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT055:EE_|CY5PR12MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: a0345859-7829-4ed5-d5cd-08daad4a7ee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q3lhYvM5fULvbyVZrGe022WHAPHTnBncCULX15Gvn7D3aotdFE4Y1o/ial0fhxJj7XQOWTVaeTKF5PF5Vqr5KS6ZnoHPAVBtU0/t4v9IdoY6XGRu5c2qKMR3SNslhK0jO2CZHBgOikmPaNHinn470Nk28SvCWl6AqG42m3tYNHju1TPiTvhZvy+wsPBRdPG8Uw8AIYwNvQ5VLcyJJFyf02+J6pgLLXXgXjwz6gR1fqSn2ryG8vl/rP3QZHf+j4Lr3XpNqXoIHFIiodob1EBItTSslU0Fd+mw17Y3ReHvivaNS2xof/U1KZ1ehrsWliUqOXMmUCyxEtTNJWcqoMThr3U3HYPv4tipFv5/fCRDK6ndw5ktRbTJvj23gVEHV6kMaOfhPeXxdCtaph2tKq9d1HZtuE/OdrO4GwB0nY+XmcYY4hIgENcLioblusMdO4GByZZjYv6HPv3+eEfhb5bbRQvSPqtSCj9xk0uw2Tcu7frZJsLTFbusI4rqgVkG2+mpLgrUgT4gkLz2oRl4t5pyQIP7o50Rs3S6nsjDCg/YDSI3jWt0nCYMJHL7m9ecZyrzbW8XkCE4oYQTnx12+Cqo/kDVYiRnd+8XYVey56gT8TAAHie1GlReJX48jwFIHidwaoKuKZSsjD8GTWVuJpxnZYWLjvHkYiPVA8r5H2QWajUkLjSch9aoVb4V0baTPLqyLVzGWqwVnaB6f+5eX/v9Orwpv/U2HlIelY9txYt8yuOCuKg2ZeDbqakrQ/+mU/iVPxrkWdVYYXv6rZwZv+1tQWv/Hw4bsoQHUl4J0NlZ1OI=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199015)(46966006)(36840700001)(40470700004)(4326008)(47076005)(110136005)(40480700001)(8676002)(86362001)(70206006)(41300700001)(316002)(70586007)(478600001)(40460700003)(8936002)(426003)(5660300002)(336012)(82740400003)(36860700001)(7636003)(7416002)(7696005)(26005)(83380400001)(54906003)(2906002)(186003)(921005)(36756003)(1076003)(356005)(6666004)(82310400005)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 18:41:09.2633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0345859-7829-4ed5-d5cd-08daad4a7ee0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6179
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As per PCIe CEM spec rev 4.0 ver 1.0 sec 2.3, the PCIe endpoint device
should be in D3 state to assert wake# pin. This takes precedence over PCI
Express Base r4.0 v1.0 September 27-2017, 5.2 Link State Power Management
which states that the device can be put into D0 state before taking the
link to L2 state. So, to enable the wake functionality for endpoints, do
not force the devices to D0 state before taking the link to L2 state.
There is no functional issue with the endpoints where the link doesn't go
into L2 state (the reason why the earlier change was made in the first
place) as the root port proceeds with the usual flow post PME timeout.

Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* This is a new patch in this series

 drivers/pci/controller/dwc/pcie-tegra194.c | 41 ----------------------
 1 file changed, 41 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 7890e0c0c0d2..3baf1a26fe68 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1358,44 +1358,6 @@ static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
 	return 0;
 }
 
-static void tegra_pcie_downstream_dev_to_D0(struct tegra_pcie_dw *pcie)
-{
-	struct dw_pcie_rp *pp = &pcie->pci.pp;
-	struct pci_bus *child, *root_bus = NULL;
-	struct pci_dev *pdev;
-
-	/*
-	 * link doesn't go into L2 state with some of the endpoints with Tegra
-	 * if they are not in D0 state. So, need to make sure that immediate
-	 * downstream devices are in D0 state before sending PME_TurnOff to put
-	 * link into L2 state.
-	 * This is as per PCI Express Base r4.0 v1.0 September 27-2017,
-	 * 5.2 Link State Power Management (Page #428).
-	 */
-
-	list_for_each_entry(child, &pp->bridge->bus->children, node) {
-		/* Bring downstream devices to D0 if they are not already in */
-		if (child->parent == pp->bridge->bus) {
-			root_bus = child;
-			break;
-		}
-	}
-
-	if (!root_bus) {
-		dev_err(pcie->dev, "Failed to find downstream devices\n");
-		return;
-	}
-
-	list_for_each_entry(pdev, &root_bus->devices, bus_list) {
-		if (PCI_SLOT(pdev->devfn) == 0) {
-			if (pci_set_power_state(pdev, PCI_D0))
-				dev_err(pcie->dev,
-					"Failed to transition %s to D0 state\n",
-					dev_name(&pdev->dev));
-		}
-	}
-}
-
 static int tegra_pcie_get_slot_regulators(struct tegra_pcie_dw *pcie)
 {
 	pcie->slot_ctl_3v3 = devm_regulator_get_optional(pcie->dev, "vpcie3v3");
@@ -1725,7 +1687,6 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
 
 static void tegra_pcie_deinit_controller(struct tegra_pcie_dw *pcie)
 {
-	tegra_pcie_downstream_dev_to_D0(pcie);
 	dw_pcie_host_deinit(&pcie->pci.pp);
 	tegra_pcie_dw_pme_turnoff(pcie);
 	tegra_pcie_unconfig_controller(pcie);
@@ -2486,7 +2447,6 @@ static int tegra_pcie_dw_suspend_noirq(struct device *dev)
 	if (!pcie->link_state && !pcie->slot_pluggable)
 		return 0;
 
-	tegra_pcie_downstream_dev_to_D0(pcie);
 	tegra_pcie_dw_pme_turnoff(pcie);
 	tegra_pcie_unconfig_controller(pcie);
 
@@ -2565,7 +2525,6 @@ static void tegra_pcie_dw_shutdown(struct platform_device *pdev)
 		if (pcie->slot_pluggable)
 			unregister_gpio_hotplug_slot(&pcie->hp_slot);
 		debugfs_remove_recursive(pcie->debugfs);
-		tegra_pcie_downstream_dev_to_D0(pcie);
 
 		disable_irq(pcie->pci.pp.irq);
 		if (IS_ENABLED(CONFIG_PCI_MSI))
-- 
2.17.1

