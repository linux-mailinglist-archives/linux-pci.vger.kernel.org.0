Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A5057CD73
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 16:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiGUOXT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 10:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiGUOW5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 10:22:57 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38DF7BE1D;
        Thu, 21 Jul 2022 07:22:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2K0Fpv5vAoMLGO67UZU0T6+oXA9ozLTZN2KTa0gOd+nhCn9bRn0Wct3gFsbE8zZoyNEtvGlgJNiL/GlfxWeR457/JsDW/dptBkqQllCjWqtmtlbwoB0WyDDIg5f1+xdvO4QyDNt9PVAle88oE5I4uGfUjMcjyMYa3aYxldEyy8NeBCqLvCjJqXskbeXfsk+Spk+uqsufbJFSTjgCRLcJegfAxCJEaIcCrmUEWM0wZ1iKSndU5ZMEq3NX+ZA3lcH6XylAf8G15OQ/OnWe3e4x3kAma2RRueDA0EKy2Fo3RY8aZYouotqm2p8D25kr/fzpSUv/foT7jbT3W39bfNTxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZHVh8rmUUOdwQx82D2EHEIpEw7mhWenRW0FcBpksmQ=;
 b=LkSH+RMmM/R+wps+Z0W4FKNf/SGmrbZr7TZfm1bDx4SVebyzOR2gicP4qAd0or8QqbCZVBjnVMrJMtTzmFizlAxTEj/Uw4lleTwkO+wF5e7GgK4qoKQ92qSwUMgffMnCdeuVlQUAOvseR3VK36ZRJ3qYlljjUnxxqhEEp/O71osg0trIeZQQfJB4poxPldcnu2XP/CHqlKL3gXas5eOsUWh+UNWSAIr00ahxgoXoF5+fSzv4P2vVIC0V0I3X9UaS/Y73QC7pH+KL25nBSug5L0QG689FMhHLCIZDppWaS6BeluWhc8l39s35PmkDcfDny9qUlIgwvJPqkeRUIcgMLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZHVh8rmUUOdwQx82D2EHEIpEw7mhWenRW0FcBpksmQ=;
 b=HBPRoCGmJ+QqFw3HSGASy8eoF3cZ3ZQUrb++DDdtOTTYDZEpVKcyfdgpSjPM0oGy1og9l70YqYl0O6R+kOxxIKBN1fgHI0JS+F42x6ArXDfk68ArcrMLFQMcZI7ivBj0jVQ6vIx2VuFGhn9ch7lgUgkQ8Wmg8KKTjcJ1eZf86PNda0j8qA+MZVVz6nQX1fMQTpTXjMfHsT0e/N3V1VWhnudYR5Wls1wULGJjXODoti3OvkIQuIiwDZxSLrvIkjc77V4LZmmjJPFzNo7CoLFW2aDw/H13Ge0IIvQFifm3zvzDEsyvckHCeqeSkvQE+HlYP8Zsj5uPt+FpCf9+jzCrdQ==
Received: from CH2PR02CA0007.namprd02.prod.outlook.com (2603:10b6:610:4e::17)
 by DS0PR12MB6535.namprd12.prod.outlook.com (2603:10b6:8:c0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Thu, 21 Jul
 2022 14:22:39 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:610:4e:cafe::9f) by CH2PR02CA0007.outlook.office365.com
 (2603:10b6:610:4e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18 via Frontend
 Transport; Thu, 21 Jul 2022 14:22:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 14:22:39 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 21 Jul 2022 14:22:38 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.26; Thu, 21 Jul 2022 07:22:37 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Thu, 21 Jul 2022 07:22:33 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lpieralisi@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <kw@linux.com>, <kishon@ti.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V6 13/16] PCI: tegra194: Cleanup the exit path for endpoint mode
Date:   Thu, 21 Jul 2022 19:50:49 +0530
Message-ID: <20220721142052.25971-14-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220721142052.25971-1-vidyas@nvidia.com>
References: <20220721142052.25971-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d24dedde-cfc8-45bd-5f90-08da6b24775b
X-MS-TrafficTypeDiagnostic: DS0PR12MB6535:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z7vRkDopD06mtsyb409uZ77eY1UE9oRvIyQqln7o/0hOQpk+WSraSb4Nw3BMSQTnwn/Or8safkCTFP8NQiuj3D0Pjf5Ots/hjSOJdgHH/kv1BGHzf1GwnNzB3/wHqpVy4m6pRh7zBMF+pJ9F4hNusBqNbtrSZgAwkMrz8r8uIz2EAKdqMYXk7O/JrJu/PxK2V3cggwkGEKk1hbfrVq+bAXn2L/DpRzUeoaiTCXMr/gt+psDp6VPA8pDAUxHD/FKvxO3hDPKyS13j7aUyYec9DRsxZyWdQVB7J/mlEAdwLSrktMJ67ol1Ub1y8eVInbsSPyOu9qjBgsuUdObF+21OkwZ2KQ+7I8A6xlFUSnOHqzwpBmEKhRJ6FJYAj7xrvuL4gRF0dQlRrpvvDNJ52b5RPgL2xvOpf2lNzTu8L7p3ohDjKVps9a+SZnRNx5SuqsCjRxbsyRpzyIeMsMb/2CaxVaWnI/Ff2PkGfT7d0zaPgAtrENU7DbyJgF632nlKSII0qGHumi09Fupw5GYHLXm6gd8NoGs/f5zU7XOx208HXjqwEfeah8/kb0mRJYy/pNTX4zXwxSMEQWCVtPdJhs3L2W/Kk/2T23uaAv7zSstDGqnxMYfJThwpRdSInaFd6oJ3G5YgJPE7jxbqi949WrcF/peEF3G8iHcM1H5siThXspYX2bSu4Vw/8FN8DWmfqHa/ECzO3oCvGwZ5t6CSjAicu0Sj555Yt0BdvfJsV/ipIMFbaKuznAwl/59+qLo+iF7UwtBEC35yzqciNfawLXoRFoWabAHnn16EuWFfbD/0IkN2jxcC1shsDtWHB7y3s9LfEaBPRcR/X+5DpulXIsjSTFWKzyflNv22O/jMIzQQBuQ=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(396003)(346002)(39860400002)(36840700001)(46966006)(40470700004)(426003)(8936002)(26005)(36860700001)(4326008)(40480700001)(54906003)(110136005)(5660300002)(82310400005)(2906002)(70206006)(40460700003)(316002)(70586007)(47076005)(83380400001)(8676002)(7416002)(356005)(86362001)(41300700001)(36756003)(6666004)(82740400003)(81166007)(336012)(7696005)(2616005)(1076003)(478600001)(186003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 14:22:39.0568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d24dedde-cfc8-45bd-5f90-08da6b24775b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6535
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cleanup the exit path during remove, shutdown calls for the endpoint
mode.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V6:
* New addition in V6 based on Bjorn's review comment

 drivers/pci/controller/dwc/pcie-tegra194.c | 45 +++++++++++++++-------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index f82c70be72ef..39f7ae61fdc6 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2145,12 +2145,18 @@ static int tegra_pcie_dw_remove(struct platform_device *pdev)
 {
 	struct tegra_pcie_dw *pcie = platform_get_drvdata(pdev);
 
-	if (!pcie->link_state)
-		return 0;
+	if (pcie->mode == DW_PCIE_RC_TYPE) {
+		if (!pcie->link_state)
+			return 0;
+
+		debugfs_remove_recursive(pcie->debugfs);
+		tegra_pcie_deinit_controller(pcie);
+		pm_runtime_put_sync(pcie->dev);
+	} else {
+		disable_irq(pcie->pex_rst_irq);
+		pex_ep_event_pex_rst_assert(pcie);
+	}
 
-	debugfs_remove_recursive(pcie->debugfs);
-	tegra_pcie_deinit_controller(pcie);
-	pm_runtime_put_sync(pcie->dev);
 	pm_runtime_disable(pcie->dev);
 	tegra_bpmp_put(pcie->bpmp);
 	if (pcie->pex_refclk_sel_gpiod)
@@ -2164,6 +2170,11 @@ static int tegra_pcie_dw_suspend_late(struct device *dev)
 	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
 	u32 val;
 
+	if (pcie->mode == DW_PCIE_EP_TYPE) {
+		dev_err(dev, "Failed to Suspend as Tegra PCIe is in EP mode\n");
+		return -EPERM;
+	}
+
 	if (!pcie->link_state)
 		return 0;
 
@@ -2251,18 +2262,24 @@ static void tegra_pcie_dw_shutdown(struct platform_device *pdev)
 {
 	struct tegra_pcie_dw *pcie = platform_get_drvdata(pdev);
 
-	if (!pcie->link_state)
-		return;
+	if (pcie->mode == DW_PCIE_RC_TYPE) {
+		if (!pcie->link_state)
+			return;
 
-	debugfs_remove_recursive(pcie->debugfs);
-	tegra_pcie_downstream_dev_to_D0(pcie);
+		debugfs_remove_recursive(pcie->debugfs);
+		tegra_pcie_downstream_dev_to_D0(pcie);
 
-	disable_irq(pcie->pci.pp.irq);
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		disable_irq(pcie->pci.pp.msi_irq);
+		disable_irq(pcie->pci.pp.irq);
+		if (IS_ENABLED(CONFIG_PCI_MSI))
+			disable_irq(pcie->pci.pp.msi_irq);
 
-	tegra_pcie_dw_pme_turnoff(pcie);
-	tegra_pcie_unconfig_controller(pcie);
+		tegra_pcie_dw_pme_turnoff(pcie);
+		tegra_pcie_unconfig_controller(pcie);
+		pm_runtime_put_sync(pcie->dev);
+	} else {
+		disable_irq(pcie->pex_rst_irq);
+		pex_ep_event_pex_rst_assert(pcie);
+	}
 }
 
 static const struct tegra_pcie_dw_of_data tegra_pcie_dw_rc_of_data = {
-- 
2.17.1

