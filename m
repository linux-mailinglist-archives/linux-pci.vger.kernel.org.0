Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB3F5FE1FC
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 20:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiJMStu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 14:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbiJMStO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 14:49:14 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20629.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA4D3B70C;
        Thu, 13 Oct 2022 11:47:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnRMxG0PDaYWbOfkv4vwyDSfolXjkde25IyRFq2hL5+edRjQHvZf/RGOrnGtqy16mto52GXmjpCSEZIWJRLsw6DCpf/7CsLU4I/FSSRClU60CxK/1saptgai+/Il8v0xM1WBGVlgPUmm9c6JVsCf+CKCUdLWMe5FXSpxdQFrtRCvs7mOWEZM2WozVKvw3F8FmXG+zXBrASF1sInQIPdmlR6TALyBtslwD4QbrZVS3kWCf8h1CBLXPohK1B/Zh2+fcUd7vkqbrSRke1Y7BXcwDzUvfub7hMmT2LzUKWWlSpuDl01zsfomLuJoG/UZDT2e4nQHZNLJPu0HcaE5ArTBmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bXebElS7MWyWIU/lLGwPuIvaTTVF7LsfxdEit/+aa8=;
 b=PgYsUmWEA2Byuf1tjTS+Wr6mU7MXtWDeFE/cABAm0LtHD/MHtgMgb9tc4M7+JtceJXo2BZ45tkTylpTrairTJCH2mwh46IvFuLg8FuJ6CV+QmmusEyjTsDei5NTVGlM7UxGQ/8opTbOgUiWupcJq4SngFjwDGsFbwhMAd+/kxsoScEQ5HtqRTfAQ6q4oesmHtHu75DS2UgGQbuODpn+tobAENO8sVAwpMqheSKruB3TeSEjNa4rR7pAb5RaHGqhcmaJ5V3lUOuRB93gy4/63HCB/h3cLp02IbIkX4jSlixt9xtnrW4HQimiZRd8cZFb74C4i727JcE7KnYYiItkIAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bXebElS7MWyWIU/lLGwPuIvaTTVF7LsfxdEit/+aa8=;
 b=r0iHytgO5kyn1aAXoAdJH7zyH7la1i5PFjNIeBSU/b8p1knRsNW97E9NNbGjSkzB3bcVcluelcW/Ea052fQyEZLzE4vTHEYAA+oSfXEvAbREQg8IgGvJLZs4IRbV1iItMXeQr4OFX5gjPcAOWK9q161noAFNCIl03Qb+dlRZGpXx/AzMqVk3kRx6Wc7XxTtqVTBAMPcNbPuothwN854sYylY3t0xK0FH5IuNdYvXX86XeiGPdjxKfcCQ1dQRvAqbgTw0FzttZeVYSHX5jXByqbXQWN393u0hSuZpdbYrEVsJM0WL0rJ8oE/K0RJxJ2iLD8hLFJRjLBBv86JzMB537g==
Received: from BN9PR03CA0943.namprd03.prod.outlook.com (2603:10b6:408:108::18)
 by BN9PR12MB5147.namprd12.prod.outlook.com (2603:10b6:408:118::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 13 Oct
 2022 18:40:47 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::f5) by BN9PR03CA0943.outlook.office365.com
 (2603:10b6:408:108::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26 via Frontend
 Transport; Thu, 13 Oct 2022 18:40:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 18:40:46 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 13 Oct
 2022 11:40:36 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 13 Oct 2022 11:40:35 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 13 Oct 2022 11:40:31 -0700
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
Subject: [PATCH V3 14/21] PCI: tegra194: Allow system suspend when the Endpoint link is not up
Date:   Fri, 14 Oct 2022 00:08:47 +0530
Message-ID: <20221013183854.21087-15-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221013183854.21087-1-vidyas@nvidia.com>
References: <20221013183854.21087-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT027:EE_|BN9PR12MB5147:EE_
X-MS-Office365-Filtering-Correlation-Id: f5492732-131d-41d9-da2f-08daad4a7193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: weHfSMUYOIFpHsz2RS1b+Vy93QLGuPxdmvqhYqwO3qqyCkX4gyYQ0jMbeH+/c9FnOyqFhNelu57lSu4DdmHxYC5DTWWZgC4nFIswjRy7rewTUHADrHp4WW/p0eQ6UwaPDJqvs2yJcaprlrtCeRbSJ1Q3pt9GFWqIbeHi9Azfgm9xD2gmND8lFr15gFxjWpE7NLQmZbwLui6t8GIdD1AGnPrHMy+pAvvAse77xb8Zjp4wb1AcV11mcUVPoihWr1VRUBII965ay2UYPEz8RFElQlqSqanG7fHySyykmk+99YTPrfq8z8iPUMaBk/ToW/DiflADLIltUal21Ewh0EZVZYKTrHRXdAg5XFj0Al80pX2mB5GSPQVitDNRm3drehf9cGOTh1KWNcetDJJK8gNWwPGpLwm4d/ol6ZECydiabwL7GNoVoTNOO33sfiB1OTXvdNCzwQmy9/8wJoqoMpmPtbiq0Gxdd6AMYtPVw2QCj5ZspMFRLXtPlB8Fvk13ulo5MRjJtoFT61HA9Obt9HHnFfN6BtKFZtSLjiwpq/Vn7qg7RWjG0Thfkya9uFVZYzsUbUj1hBF8h7QpniDs+R940yKkeiezdcIDEemI+Ig2RFFFVDj3+kvhZdrLWzLGysFS/znMC7IAZkzVQvfkX9ZpbjQXsvyQ0SHYRgX5Yq69CYOqZNZkAb3HmAYFuzkbmrupX3OlwL7tdyWiEBAWyKnDFTCzL5Na/55Gmu7F62/7d0A87doHnQUWGuh4bQEDm9XewTlhDZuLfIcBlysC5IId0zl/lx/ik0EpWdksXK0lpTk=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199015)(40470700004)(36840700001)(46966006)(336012)(186003)(2616005)(47076005)(1076003)(83380400001)(7636003)(921005)(356005)(86362001)(7416002)(36860700001)(82740400003)(426003)(2906002)(5660300002)(41300700001)(40460700003)(4326008)(15650500001)(8936002)(40480700001)(82310400005)(110136005)(8676002)(6666004)(478600001)(26005)(7696005)(316002)(54906003)(70206006)(70586007)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 18:40:46.8859
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5492732-131d-41d9-da2f-08daad4a7193
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5147
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Only a Root port initiates the L2 sequence. PCIe link is kept in L2 state
during suspend. If Endpoint mode is enabled and the link is up, the
software cannot proceed with suspend. However, when the PCIe Endpoint
driver is probed, but the PCIe link is not up, Tegra can go into suspend
state. So, allow system to suspend in this case.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* This is a new patch in this series

 drivers/pci/controller/dwc/pcie-tegra194.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 78ee0f713e71..e6fd713e9868 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2425,8 +2425,14 @@ static int tegra_pcie_dw_suspend_late(struct device *dev)
 	u32 val;
 
 	if (pcie->of_data->mode == DW_PCIE_EP_TYPE) {
-		dev_err(dev, "Failed to Suspend as Tegra PCIe is in EP mode\n");
-		return -EPERM;
+		disable_irq(pcie->pex_rst_irq);
+
+		if (pcie->ep_state == EP_STATE_ENABLED) {
+			dev_err(dev, "Tegra PCIe is in EP mode, suspend not allowed");
+			return -EPERM;
+		} else {
+			return 0;
+		}
 	}
 
 	if (!pcie->link_state && !pcie->slot_pluggable)
@@ -2448,6 +2454,9 @@ static int tegra_pcie_dw_suspend_noirq(struct device *dev)
 {
 	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
 
+	if (pcie->of_data->mode == DW_PCIE_EP_TYPE)
+		return 0;
+
 	if (!pcie->link_state && !pcie->slot_pluggable)
 		return 0;
 
@@ -2463,6 +2472,9 @@ static int tegra_pcie_dw_resume_noirq(struct device *dev)
 	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
 	int ret;
 
+	if (pcie->of_data->mode == DW_PCIE_EP_TYPE)
+		return 0;
+
 	if (!pcie->link_state && !pcie->slot_pluggable)
 		return 0;
 
@@ -2495,8 +2507,8 @@ static int tegra_pcie_dw_resume_early(struct device *dev)
 	u32 val;
 
 	if (pcie->of_data->mode == DW_PCIE_EP_TYPE) {
-		dev_err(dev, "Suspend is not supported in EP mode");
-		return -ENOTSUPP;
+		enable_irq(pcie->pex_rst_irq);
+		return 0;
 	}
 
 	if (!pcie->link_state && !pcie->slot_pluggable)
-- 
2.17.1

