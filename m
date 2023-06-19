Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499837349BF
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jun 2023 03:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjFSBmk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 18 Jun 2023 21:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjFSBmj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 18 Jun 2023 21:42:39 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456BAE40;
        Sun, 18 Jun 2023 18:42:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UndI3Xo7Kxr9yjya37pwS3nAn+WpdT8MuiOns86yJQMU+4/J8jYGpBj6YdMOvfXEptsFxgF2t7r6ag5PvcN9BWTtmy/crlQo3YKtNEKL+Vkc/GWbqehb4keQ3fmR71Si+fbp+iGjRVS0LXq0mgAZa0B6Hb664NVGQ0NheZBbpmVKA5ORYaOxDS/rDEIS7LSOjgasEQWBCcdJHAL6wRR6EhUdatRKyRwN3LOJACQLZC9+j6dHwq7fHtSAqsj04VfRggMyXD0CDYQHMifxOTsEy1/XY375LpOyk5wpMdvW3hIiBpvtJ/xIrJLz7gD+eCNfbBwW/vPFqz2KgvjxHRhFzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0KgOFdU+2QRvS+LOfYoZJCRwGhWrVw64/ps01v5B1Y=;
 b=DSGs8AMHO7azZyUZu/vzlxXK5L+GkpY/TJtbXnPHWqLgNw10hScSaJ/MvzZodMox6qAizPeLYBP0coEFkoxm9437bG/PlPvCTHNts7gZ/Qsinhggpo5YjjDfemT2a5ZIO7A1zMLf4en68ErgBK34+0g7rKfRzD86Wdhv0mbj03i6roF3fUw5ofmdbrQ3PfYNAaHFRjmoOXJOa2s14bsK5h3kLDfBNlQSds2Cu0/PUzDMEdZYjlAECksF4hGRbkJqbA6wYY8xPUDG7QSC1lPPtGYx5x74/bzDYUzFGkkyCiEAuKruIHKiFUa4YV/nD5OK+cd9MODAiTPBYm7M0cKaXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0KgOFdU+2QRvS+LOfYoZJCRwGhWrVw64/ps01v5B1Y=;
 b=uY+vM1gxKvm1YrRcPz4OPyTuHtDSuqVtNtCJPMshSN8dcP0hCGn9x6Do/OwcdimOPC2f1ttnDbenjZPdT6/T/qlugnqbsxOMzuNKm8HnmrKZVnVjmMfv0SMMhXQ65DKu1jkBQOZIYlUniuAbu+PYTkUbZtR8XC+x0ae9CRYde4xpmEHfZvP1R6xa9nXGA0yLBsA7oND//enr7+b5xhfewBXtMyazI7xANnt/p9OrUm0eGujzcMOLTk/WPJNpsvFc20UL5PqFm9hGPp7M9RTBc+OQsWYMNDm7LgCjHBIY2sJBNEtwB0OddMdRM1DxIn2UJUTjR6Jfr4bcJcEGe2KM5Q==
Received: from MW4PR04CA0118.namprd04.prod.outlook.com (2603:10b6:303:83::33)
 by DM6PR12MB4910.namprd12.prod.outlook.com (2603:10b6:5:1bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Mon, 19 Jun
 2023 01:42:33 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:303:83:cafe::81) by MW4PR04CA0118.outlook.office365.com
 (2603:10b6:303:83::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36 via Frontend
 Transport; Mon, 19 Jun 2023 01:42:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.17 via Frontend Transport; Mon, 19 Jun 2023 01:42:32 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 18 Jun 2023
 18:42:27 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Sun, 18 Jun 2023 18:42:26 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Sun, 18 Jun 2023 18:42:23 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <Sergey.Semin@baikalelectronics.ru>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V2] Revert "PCI: tegra194: Enable support for 256 Byte payload"
Date:   Mon, 19 Jun 2023 07:12:18 +0530
Message-ID: <20230619014218.1970846-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230608093652.1409485-1-vidyas@nvidia.com>
References: <20230608093652.1409485-1-vidyas@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|DM6PR12MB4910:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eda875a-0bd9-4e80-948a-08db70667379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8xh8OoDCTUgnPNKzuv5i3AjpJtRpJQ25dvdp35ewLqTPKKg8uSH5+9+/q6MjAIZR/8QO4DV2Y+Lk0/nzTGET5UiOzlG+ke2shtT539ofJuRYTHUuEb5fIKfR2Y6s77E2Bn05h0VTBOATAQycNvdggj58FyK5+xFg0OfqfVn/Zx3zbxBJB9A8AotUYU3NrDS04MBGWZBrzSSpUQiAxOWo/6Jxb85X/3qbMZNrfo934MRceMNhsvnoBhuMTDToobCSjXz8PcvDT7XHic+p20O4x+3iZj+qYd4LiabJTAMPqEIFGnjsqjJ5eHLZAIpsj8Q7oTwZpbApDVeKpFSdUT0s8ETK2m2S/npe0eLSDf2CbntQLe8+8rMlZrbAjnR8hvl5/7b6rPjiOUGMoq8egcTFC6SjWjV5Vf0TMRvpVeWQgzjRnabK6DTAlq2TJYVVLBPKXr8ot1YrVYKrzHQbrDC7eINFwc2B0wcHa0VqeeM5TrXLb4UucLXMR9f7ft7Iyx14Ufe9uhZ6rFg/vUWbJfpnjXlkrDmQc2fPnXUTTz+HkFN5t3qbQia6R10veypuqItHmvJ1hTnNx6hK0EUDLG49OF4AFZtJ17bz0BQj8+BHwbExcwPeLvXTICMUI/eO7/WU3WGw6zzfen5aogWdbhRhCe5WmfVQZbgBNh3Rl8SPu8yEJHPE7/q4yYikz/kBdRsZoX1K7DIq1JXfOw5ab8qXxooIX+ZtElKWrRtxMWQZaQdn+2Lxr6NBC+8pO+ZFGlVv
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(4326008)(316002)(70586007)(70206006)(5660300002)(8676002)(7416002)(8936002)(41300700001)(82310400005)(36756003)(86362001)(2906002)(40480700001)(7696005)(6666004)(7636003)(356005)(47076005)(2616005)(426003)(336012)(36860700001)(1076003)(186003)(26005)(54906003)(110136005)(478600001)(82740400003)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 01:42:32.8598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eda875a-0bd9-4e80-948a-08db70667379
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4910
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This reverts commit 4fb8e46c1bc4 ("PCI: tegra194: Enable
support for 256 Byte payload").

Consider a PCIe hierarchy with a PCIe switch and a device connected
downstream of the switch that has support for MPS which is the minimum in
the hierarchy, and root port programmed with an MPS in its DevCtl register
that is greater than the minimum. In this scenario, the default bus
configuration of the kernel i.e. "PCIE_BUS_DEFAULT" doesn't configure the
MPS settings in the hierarchy correctly resulting in the device with
support for minimum MPS in the hierarchy receiving the TLPs of size more
than that. Although this can be addressed by appending "pci=pcie_bus_safe"
to the kernel command line, it doesn't seem to be a good idea to always
have this commandline argument even for the basic functionality to work.

Reverting commit 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256
Byte payload") avoids this requirement and ensures that the basic
functionality of the devices irrespective of the hierarchy and the MPS of
the devices in the hierarchy.

To reap the benefits of having support for higher MPS, optionally, one can
always append the kernel command line with "pci=pcie_bus_perf".

Fixes: 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256 Byte payload")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* Addressed review comments from Bjorn

 drivers/pci/controller/dwc/pcie-tegra194.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 4fdadc7b045f..877d81b13334 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -892,7 +892,6 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
 	u32 val;
-	u16 val_16;
 
 	pp->bridge->ops = &tegra_pci_ops;
 
@@ -900,11 +899,6 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
 		pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
 							      PCI_CAP_ID_EXP);
 
-	val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL);
-	val_16 &= ~PCI_EXP_DEVCTL_PAYLOAD;
-	val_16 |= PCI_EXP_DEVCTL_PAYLOAD_256B;
-	dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL, val_16);
-
 	val = dw_pcie_readl_dbi(pci, PCI_IO_BASE);
 	val &= ~(IO_BASE_IO_DECODE | IO_BASE_IO_DECODE_BIT8);
 	dw_pcie_writel_dbi(pci, PCI_IO_BASE, val);
@@ -1756,7 +1750,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	struct device *dev = pcie->dev;
 	u32 val;
 	int ret;
-	u16 val_16;
 
 	if (pcie->ep_state == EP_STATE_ENABLED)
 		return;
@@ -1887,11 +1880,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
 						      PCI_CAP_ID_EXP);
 
-	val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL);
-	val_16 &= ~PCI_EXP_DEVCTL_PAYLOAD;
-	val_16 |= PCI_EXP_DEVCTL_PAYLOAD_256B;
-	dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL, val_16);
-
 	/* Clear Slot Clock Configuration bit if SRNS configuration */
 	if (pcie->enable_srns) {
 		val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base +
@@ -1900,7 +1888,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 		dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA,
 				   val_16);
 	}
-
 	clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
 
 	val = (ep->msi_mem_phys & MSIX_ADDR_MATCH_LOW_OFF_MASK);
-- 
2.25.1

