Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079F15FE1B5
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 20:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiJMSoE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 14:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbiJMSn0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 14:43:26 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4439D1CB0E;
        Thu, 13 Oct 2022 11:41:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVPNHbfpUWJnbyA9gVQ8zX27G2FZ4hXOztIe40AMwbKciVPZ4F0P/cIMM01qC6tfR2POBDGzLfNYq4E8jhySNsGf9p7RzODOHqZDHvloGSvMUpTv9NnMjVw8HuwLMjZUURcqjtvgiO1qEitRd5w6wsLpWZyU4Hxfto7Y6raY7yVmY7yqcN+RNP5S+ewWOo2bojqr609zyktUcnYg7p+O7aB2Z9nSeEkRRcN8NZ38kmw0kWAeNzq8WiV6kCsRSOVo2p43sg+HKl1Z+XOE8AL0iJwP5GhCQ8JxgJ1dpltc8CZI6go6Oc67h06sfOvYtgL5ya9TiP3zT56JfyLW4emk6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVuYUqRhNPYBMdQehhp7uCUQLfpn9tioYb4AOYBLaCo=;
 b=ltMM5aNkgkueRAf832ev0oNGZfk8U+8p0DWA8QJ1f+WM5mntfT48n2q6Qor1Ely5xpq1quvTy9qaWahh46O7qlb5b6fsUJZjds/5Pws4CG8VTW7IpNWSO3lxmv7tkWQvdrU2I6cNiM/bfKo8v4zLZ4X4lNKKe6xAqCaP0ojBnLSTSnZFgVAQmwQIKFrrCRGR6YPp4c1pTc//iv+qbm1Lo7pEwgKkqRETGdAgO8hGgFXOL/fbVDhuMHbUasToOwQKYap8yulbuNCuxEfE4ROuczK+8DZjJTbYwDoPY1by8vRJPl92Yhk7ICz9c6XryvRes8e7VXPpOK/VAdvo6aoxDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVuYUqRhNPYBMdQehhp7uCUQLfpn9tioYb4AOYBLaCo=;
 b=XfEm2AaNAial9klqjFtroIXls89CGaLgmwjbgnygr1X/ZMzLP6a/Ic/Ek/4oUk9m437xlxZ5SsUoOzPUnueELj8N3hDX42KHhO4zG6RPqVdt1ApiqiFjCVxfeqzwf9ntDduv7GZ1iggQA22MH/TiUFxJtdAWe+ZLAo1o3ELws9RT0MBtRvkHbcCVPXCAutYketI8LiS4WIe0A7tHZSv0CSvijSHuRyrYbFM5vTrZCeDbMOiQqxYWb7YXuNzVRTJhNJU79BoR7YVtZaoQ+ZCNrIQ3pAWcfvAxMgYpaV0O1VNQmM7P69U76J3eg3GtKooNcmqvEH6bvNRjOP3yqbQJKA==
Received: from BN9PR03CA0500.namprd03.prod.outlook.com (2603:10b6:408:130::25)
 by BL1PR12MB5363.namprd12.prod.outlook.com (2603:10b6:208:317::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 13 Oct
 2022 18:40:25 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::f1) by BN9PR03CA0500.outlook.office365.com
 (2603:10b6:408:130::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.28 via Frontend
 Transport; Thu, 13 Oct 2022 18:40:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 18:40:25 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 13 Oct
 2022 11:40:16 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 13 Oct 2022 11:40:16 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 13 Oct 2022 11:40:12 -0700
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
Subject: [PATCH V3 11/21] PCI: tegra194: Remove IRQF_ONESHOT flag during Endpoint interrupt registration
Date:   Fri, 14 Oct 2022 00:08:44 +0530
Message-ID: <20221013183854.21087-12-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221013183854.21087-1-vidyas@nvidia.com>
References: <20221013183854.21087-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT051:EE_|BL1PR12MB5363:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a27a0a5-6cfa-41e7-6a96-08daad4a64bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bhx0jkYdVo6kBP2mJy8iVbRXgADkH2qKf/gju/KAkWwXUw9lhexqAzpdHwK0rBXgxeZNCD1W5E1RB/E0NIHEUO8BGw2dEl8XoAmre3ZOnyNIpHJcBUgSEyX2CGWXEfe67BJvLJJEhnKNvbfcREbZR8wOhbwcV0YVwhJ393nvD1aaFzaphuFhRoQiU8g8RTcO7ZHj84/BmRvQtzp9XODTznpiWhlltVEQSkbshx/e2PetksF55q6WR4D7NLmsG6pj8I4wX1X/5ONBPkZsDWl4AXEKOF2dkvFOESaQm6e63AwAbiOaROlIYCocoxFpRJZP8esxiCs0wM6/cNq+0fGopdvuzSJ1pd9qBStnhAq/x2L7rUXWF9En+bZK2kLZoN+HEJeD2b+vGJpk8kb/NVpGvdHHOmOFd80gk8QaCMM3wOs4A77HQIV5qc4j/CqdTWOjqSLT+HSiRcoI32/RU+WR/xmv7tgyHf1VNS81RP52BYigMbLcjIXvoL1XEuWXpVE8WL7H3H3elCXaLPusFpWwqloyuJfoskNgypvB9N4KGTZjcr+NvA2o3c1UchVeJddc8TIz3OFJ/K004u4tMw3bHj61eESM+2EyGamjaFf5w/V7GLPi/Bft96SOS1o1gntIw82BNRlYQZoytY9GNAFvgeGQCTpna92XIKCPWD8V7zGgY1T0WLqbiZbuJs8DuXFIrlvnDQoRBWmOjdv09cElLfsrvnuirF5eL7nJ0+aKSywPn1mTISb3MVvH4rLRVhkheTufVW9R+shVGsVTzkTyT3leOApWhtABBSQ5lOL2a1Y=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199015)(36840700001)(40470700004)(46966006)(5660300002)(7416002)(1076003)(186003)(336012)(2616005)(7636003)(2906002)(356005)(41300700001)(26005)(8936002)(7696005)(921005)(82310400005)(86362001)(40460700003)(426003)(36756003)(83380400001)(47076005)(40480700001)(82740400003)(36860700001)(478600001)(316002)(110136005)(54906003)(8676002)(4326008)(70206006)(70586007)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 18:40:25.3635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a27a0a5-6cfa-41e7-6a96-08daad4a64bd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5363
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Tegra PCIe endpoint has a common interrupt that notifies hardware events
like link up, LTR send, etc. DMA completion event is also notified over
this interrupt. Remove IRQF_ONESHOT flag from interrupt registration and
allow DMA driver to share this interrupt.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* This is a new patch in this series

 drivers/pci/controller/dwc/pcie-tegra194.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 7820bf4b9786..786e5d5f43b9 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2354,7 +2354,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 		ret = devm_request_threaded_irq(dev, pp->irq,
 						tegra_pcie_ep_hard_irq,
 						tegra_pcie_ep_irq_thread,
-						IRQF_SHARED | IRQF_ONESHOT,
+						IRQF_SHARED,
 						"tegra-pcie-ep-intr", pcie);
 		if (ret) {
 			dev_err(dev, "Failed to request IRQ %d: %d\n", pp->irq,
-- 
2.17.1

