Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAA95F1270
	for <lists+linux-pci@lfdr.de>; Fri, 30 Sep 2022 21:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbiI3T2c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Sep 2022 15:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbiI3T2a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Sep 2022 15:28:30 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7C6CA2A1;
        Fri, 30 Sep 2022 12:28:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Be6hs9ozze4yj7oGpun+fcdWmotb8SLhUEb84rlQdqAXxb8HSEJahD0h8M5YgHRILNnoox26eXX4pUw42cEppOAin/8vxIc4gyuB0wvldd75l+mrbaSZ9rhNPPHzD6KuIycUqzBw6zkVYJPaFkwcKaxNc/gmg/rqwdxmOFMukJwNZQKTEcKwaTM5AUnt3lHzxy/vYnLVtVpvu3Wh8j9mHlfvtflh5kWaBgbU0gH7fMOn0R+bC8JHhkNZ/bdNwbnOyKb3/XTyCMKKLEC8DBYDnrjES2OuK5ObJyXsM20w3cLh1OBowPOrggyUHd+XRls1xYt8RVMb+E0+kH7ulOEnzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9V11z5POxBJRG9oVx5Yk2A3NwduT/zS1hVEHVANrSo=;
 b=T4iukL62MaiG+9UKOGEF1p83fekeN9/ouUuikdIlb4j+6CjGuVGs4n28NwmoEaNG0IXtSS2Q76enN/PrNap/PkC+kh8vr40pFzs/AZygzgBuGtFlCZTrGM3QX4x26Jh0n6/pkqimLvLg3RkoBUXGadzQt9TrUxh8F9ZvInvHpSuKBG7UNwSLvmCMO2rGNXEGJlG58etZHM3KqlCHraXJT78FBjEQiSIINIm/a1vKqdulbkRCDuM+ZogIdXgz15J1jZjs0/K1YVFaqy5e0HeJa8jRj0YnmfYFr3eOvsauHk3E+fStSSg/+VyYD0xztYu3pcdMQrQrGx1iQD5h+y/C/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9V11z5POxBJRG9oVx5Yk2A3NwduT/zS1hVEHVANrSo=;
 b=Svaa/r8RBiqZY5kXq9To3sCmzuL/nnBXZcalcWiMOAT2dZOX8fieSwZ6qna8/L80D5jI6qY4a7N2BQWfMIJPJ/LGm02vK3ziWAu1csIRVHcD+gCdrI44imL8ZGyZAKrKpd/m+1TGG+41UCerDNh6zagQ2AgcHoez6jmA7D/5ED8uUpsorm6CTz25AWusgYOddKxstoKF6eDr4XLpW0hce7lPVogexdHuPydFfRp8plCLjKSgcRIWoj2coqJxvFt6+wJskRhAQq+UWLy8BXwm+tbMd/VlIlTVFf3ZLrXTThIuDmHKV6W4JptgPq4FSRRa4a4bVhIAcVYiFEEW0U3ZUA==
Received: from BN0PR04CA0183.namprd04.prod.outlook.com (2603:10b6:408:e9::8)
 by DS0PR12MB6535.namprd12.prod.outlook.com (2603:10b6:8:c0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Fri, 30 Sep
 2022 19:28:26 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::6f) by BN0PR04CA0183.outlook.office365.com
 (2603:10b6:408:e9::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23 via Frontend
 Transport; Fri, 30 Sep 2022 19:28:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Fri, 30 Sep 2022 19:28:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 30 Sep
 2022 12:28:18 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 30 Sep
 2022 12:28:17 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 30 Sep 2022 12:28:13 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mani@kernel.org>, <Sergey.Semin@baikalelectronics.ru>,
        <jszhang@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V1 3/4] PCI: tegra194: Add support to configure a pluggable slot
Date:   Sat, 1 Oct 2022 00:57:46 +0530
Message-ID: <20220930192747.21471-4-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220930192747.21471-1-vidyas@nvidia.com>
References: <20220930192747.21471-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT020:EE_|DS0PR12MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: ee1c7464-b0e0-4e90-cb8a-08daa319f2a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AA5Mt1l7wZr4InOR3E2LI1sqkZA2AW/8YFgd8jKNsdaPyOqKX4zOoq+vjgv2CoUlUbFNiP7OgScWUsKQAoJjbIG01U/HqHfEWZEYB9a8AK1OzQIBPkLUtAYPg02kPam0vneIE/0lvcXGEULqBgYHstLRyedwNuc7RRdOQWo4dWMDy++HvHlY6mv1WMI450Bd64VMQMQmIyjFrU5Nw3DYqscYcYmNYXJuJN4mDUeg1RRIHOnEVttRCC1m5xULPUrj+3eX8ywnzHY5fcIPramqlE2w51p0FsbqJdwJdsWDRBuV7HXGD0VDdn479nBxyl1sfHQfjKAo9MAlVsmC2KmUnF12AXnPdQ2BBaTEpXI9d0vA0lFJeSzva3FsXV5QVPlKdWk3aKn3R4KloZH02Awlq+ZZxxKq0EsaWeDt0BIrGAPFWvsAJ9jMP9CpbJmzQxV+6BtKNOYNBuO8DsdQnecnyPTvBpzO3vmwWy6K2RqbseZFJGouzVPdoFfiGva7Q4cCbBVyyy2t2WOaFKYXfpT1lsZZUf4fWcVTPCBETahSLE/9QhTJnyQkq6TUr3WCnMWDo5qG37Ik8KQ8uAnrIb/3PFwWoQ60ic5spNLT2Jzh/k79WAOpkF4Haj1WMWXKnFG01YMJ/JpQ3Sau57ghImUUvFc1iBc+8aBH7ToK3sX0at5hS2C1rR7bOL5iSUZHd0tTNl3jsunjyFpVSPoi6v8eTtvx9TSi5ZP0f/Ct3ujwWE2uBLb9Hbg/oGeZAOy7U7/6LdFAPd+sqOk9ZRm+zMBxD86Cs/6Ecb4xF74wfht5PwE=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199015)(36840700001)(40470700004)(46966006)(36860700001)(82740400003)(921005)(356005)(40480700001)(82310400005)(7636003)(316002)(36756003)(86362001)(40460700003)(6666004)(1076003)(426003)(336012)(186003)(70586007)(26005)(70206006)(2616005)(47076005)(7416002)(5660300002)(7696005)(4326008)(2906002)(478600001)(110136005)(8936002)(54906003)(83380400001)(41300700001)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 19:28:26.4711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1c7464-b0e0-4e90-cb8a-08daa319f2a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6535
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to configure a slot as a pluggable slot by not power-gating
the respective controller based on the DT property "hotplug-gpios".

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 2600304522eb..0370e881422d 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -280,6 +280,8 @@ struct tegra_pcie_dw {
 	unsigned int phy_count;
 	struct phy **phys;
 
+	bool slot_pluggable;
+
 	struct dentry *debugfs;
 
 	/* Endpoint mode specific */
@@ -1089,6 +1091,7 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
 {
 	struct platform_device *pdev = to_platform_device(pcie->dev);
 	struct device_node *np = pcie->dev->of_node;
+	struct property *prop;
 	int ret;
 
 	pcie->dbi_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
@@ -1158,6 +1161,10 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
 		pcie->enable_srns =
 			of_property_read_bool(np, "nvidia,enable-srns");
 
+	prop = of_find_property(np, "hotplug-gpios", NULL);
+	if (prop)
+		pcie->slot_pluggable = true;
+
 	if (pcie->of_data->mode == DW_PCIE_RC_TYPE)
 		return 0;
 
@@ -1655,7 +1662,7 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
 	}
 
 	pcie->link_state = tegra_pcie_dw_link_up(&pcie->pci);
-	if (!pcie->link_state) {
+	if (!pcie->link_state && !pcie->slot_pluggable) {
 		ret = -ENOMEDIUM;
 		goto fail_host_init;
 	}
@@ -2267,7 +2274,7 @@ static int tegra_pcie_dw_remove(struct platform_device *pdev)
 	struct tegra_pcie_dw *pcie = platform_get_drvdata(pdev);
 
 	if (pcie->of_data->mode == DW_PCIE_RC_TYPE) {
-		if (!pcie->link_state)
+		if (!pcie->link_state && !pcie->slot_pluggable)
 			return 0;
 
 		debugfs_remove_recursive(pcie->debugfs);
@@ -2296,7 +2303,7 @@ static int tegra_pcie_dw_suspend_late(struct device *dev)
 		return -EPERM;
 	}
 
-	if (!pcie->link_state)
+	if (!pcie->link_state && !pcie->slot_pluggable)
 		return 0;
 
 	/* Enable HW_HOT_RST mode */
@@ -2315,7 +2322,7 @@ static int tegra_pcie_dw_suspend_noirq(struct device *dev)
 {
 	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
 
-	if (!pcie->link_state)
+	if (!pcie->link_state && !pcie->slot_pluggable)
 		return 0;
 
 	tegra_pcie_downstream_dev_to_D0(pcie);
@@ -2330,7 +2337,7 @@ static int tegra_pcie_dw_resume_noirq(struct device *dev)
 	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
 	int ret;
 
-	if (!pcie->link_state)
+	if (!pcie->link_state && !pcie->slot_pluggable)
 		return 0;
 
 	ret = tegra_pcie_config_controller(pcie, true);
@@ -2366,7 +2373,7 @@ static int tegra_pcie_dw_resume_early(struct device *dev)
 		return -ENOTSUPP;
 	}
 
-	if (!pcie->link_state)
+	if (!pcie->link_state && !pcie->slot_pluggable)
 		return 0;
 
 	/* Disable HW_HOT_RST mode */
@@ -2388,7 +2395,7 @@ static void tegra_pcie_dw_shutdown(struct platform_device *pdev)
 	struct tegra_pcie_dw *pcie = platform_get_drvdata(pdev);
 
 	if (pcie->of_data->mode == DW_PCIE_RC_TYPE) {
-		if (!pcie->link_state)
+		if (!pcie->link_state && !pcie->slot_pluggable)
 			return;
 
 		debugfs_remove_recursive(pcie->debugfs);
-- 
2.17.1

