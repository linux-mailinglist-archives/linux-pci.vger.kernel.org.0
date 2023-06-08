Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D62A727B91
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jun 2023 11:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbjFHJhN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jun 2023 05:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjFHJhM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jun 2023 05:37:12 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82C7E4E;
        Thu,  8 Jun 2023 02:37:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8iI16nho+7ze1AkFkWi7Jt8tjg57+CadoNnYTbefW42b5FU7vMiblo071CWlIKXqmanTow3Kkp6TAP5xkU1F6SyR0eOoqaVritA9VeiolU3UZb1tu9jqMhc3d4nUkx3scvjbxG18Iviyc4cCzq3a9PN4lJvwqZzxVW7urLOQqA17PRU6iV+2ryGAIjx0gwoLRqGm6eV4V9g3yBspvhartI0Yqn+EmhrIMOznvClhiKZzBIJbhtmCIRiSo6St4uqiz8mWTq8qcCvVxJ6k2lGOKZLYWBqo7nVrEgwuwriZPofSKz1cHcBE23tEWqQzEIYPAtxkbZEbd466TI1NnZcaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fl5G5HVh3aPVzpaNZoJRVqEuSii6FEWHaQozl8QYNXk=;
 b=mtl2vuoa6wMGhnIVQEI0m5pPoqM0kXlgoN791grtz9r7r2tB7JnTbVdnOnhvzp9mlL6f3r9mT5VRVDc0akmPSo7xlQCjI92UHxCelRHnldIuzvEHS9nIGwW7Ncp6sTgCS2RO9u3GZFdnpZSfXNW2g01GqPlzH0c2suH9mPCrhGfuNIZ6y/N/+phThg9quIJyYcKr+HVmSwg8Lj5jr142NlMoNznb4Z5+4N/puhv9Zvz2XqC2GfitraAS9uCyOtL7mm1+EWNtQVdOEiGieEWZrF7TaQAyjIDTYW6QCgwER8DxXGJQjcZCVSTh2ZlBbdXg+b9mGOJnxDr35iEGuHOYSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fl5G5HVh3aPVzpaNZoJRVqEuSii6FEWHaQozl8QYNXk=;
 b=juRQcz1p1xURX1zjn6KDahsIChs6fvUJK0rNxRcgEJdUc7Dp+VP7NtXAeHLsJ8qA5Z6iYYd5/gADrWGIcjEv/AWFwpqzLGqBE97epXpG1ClPNLjdWWhZNoO6zv3r0kPrZZVvB33VuuQhqxgmZfZKNoyn1U6eGsjEN+n9K/j8FrOX4mBGV0FgHEJh4r4mLPfybLtclOIowj0iWiMrW32gbTg3P2PVGcKbSmIgke+WzQ26tnJpkoi9Ama3N4caf4pgsovcv2B4z58soDH9wFfWFW59i95izC6Rll2i/agOewKlM9CcDUHA6l4sVwsZBxWaRZ6m1raBCkm0eQ6gk/2mgw==
Received: from DS7PR05CA0077.namprd05.prod.outlook.com (2603:10b6:8:57::17) by
 PH0PR12MB7080.namprd12.prod.outlook.com (2603:10b6:510:21d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 09:37:08 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:8:57:cafe::92) by DS7PR05CA0077.outlook.office365.com
 (2603:10b6:8:57::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.12 via Frontend
 Transport; Thu, 8 Jun 2023 09:37:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.13 via Frontend Transport; Thu, 8 Jun 2023 09:37:07 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 8 Jun 2023
 02:37:00 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 8 Jun 2023 02:36:59 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 8 Jun 2023 02:36:56 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <Sergey.Semin@baikalelectronics.ru>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V1] Revert "PCI: tegra194: Enable support for 256 Byte payload"
Date:   Thu, 8 Jun 2023 15:06:52 +0530
Message-ID: <20230608093652.1409485-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|PH0PR12MB7080:EE_
X-MS-Office365-Filtering-Correlation-Id: 035b6a95-6aed-4c89-8bfb-08db6803ed57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B5d+qXFdztGIQ1GP/833l0mN7b/obWcZK2TSTFnYL2+d9kFXTiBcVDwdtevzm9hzVu4kH94iJ5tgWcwdrfhQQdQxIlDqBZFR5cVzPu7E4KOzoDzOYf38/2ogG9UBvPn9i79FNM0bLDPs3rXOFDbevwZGeijFEs9Wv48d/XUVHWxurihoJ7kL+j/WE97BmE+7HNIYi9chZGs8tIvRAg9WiiJlISZdPmW0L4Pkvl70u7/xNdc6TEDZ3l2FH4abeme0jnz/fpzD5tRdUKHuTzmMIUtZn3BkWQuwKbPhmC2j8OILdGMKvlzjpQpFJj/nhMY6T9+s+/iuiQcDUlsgh/oat7oRQHM867gjb3eDO3HkykuumsmuzbWD89y+vWyKTV0zGpX42Z3hnHgf73BQadLTROFyGT65zo6AGCjts5JQyWmyhssaFeC1tSsCWAxXTX7Nrp+PsU7rK/vKFdj9YEtuFkB9dcvBlGhWFsPoA9PB2WB1hZxUnyjo3dFAYwO8MhTfOCLeUqEA8F++lxtBghF5GD3dA4NhJlOHh7bVbLvuQlXlAAsnMnaXHtWGUshqv0B3O0NytKUfq01Y6CPNVkZ2C2HqN4jNX36Ohk91c3UOZuUAfTjfAsmBQ/Yq5ku0ap9yo1f8B2O01lblmyjz4vUCaJNKGFzeEIqI9YQRaPint+SSSo+ikcizgec6CWYSjADohxfvspNOBLYtXj9BEDH6eaGjYvx+gNHSUwgXNFUDyWy1h5mYdEbjgedx8Hz5w7mU
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(36756003)(5660300002)(2906002)(82310400005)(86362001)(7416002)(40480700001)(6666004)(1076003)(83380400001)(40460700003)(36860700001)(336012)(426003)(7636003)(26005)(316002)(356005)(478600001)(54906003)(7696005)(110136005)(70586007)(82740400003)(4326008)(41300700001)(2616005)(186003)(70206006)(8936002)(47076005)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 09:37:07.7935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 035b6a95-6aed-4c89-8bfb-08db6803ed57
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7080
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This reverts commit 4fb8e46c1bc4 ("PCI: tegra194: Enable
support for 256 Byte payload")

Consider a PCIe hierarchy with a PCIe switch and a device connected
downstream of the switch that has support for MPS which is the minimum
in the hierarchy, and root port programmed with an MPS in its DevCtl
register that is greater than the minimum. In this scenario, the default
bus configuration of the kernel i.e. "PCIE_BUS_DEFAULT" doesn't
configure the MPS settings in the hierarchy correctly resulting in the
device with support for minimum MPS in the hierarchy receiving the TLPs
of size more than that. Although this can be addresed by appending
"pci=pcie_bus_safe" to the kernel command line, it doesn't seem to be a
good idea to always have this commandline argument even for the basic
functionality to work.
Reverting commit 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256
Byte payload") avoids this requirement and ensures that the basic
functionality of the devices irrespective of the hierarchy and the MPS of
the devices in the hierarchy.
To reap the benefits of having support for higher MPS, optionally, one can
always append the kernel command line with "pci=pcie_bus_perf".

Fixes: 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256 Byte payload")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
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

