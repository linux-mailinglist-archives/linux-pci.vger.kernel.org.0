Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC98B5BCF1D
	for <lists+linux-pci@lfdr.de>; Mon, 19 Sep 2022 16:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiISOiK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 10:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiISOhx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 10:37:53 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2068.outbound.protection.outlook.com [40.107.96.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C421D2D1D9;
        Mon, 19 Sep 2022 07:37:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5gexPYIBmcDznPpb7/aMEfXRJ0XG9HTYg06oC/mChwayQVcyyqyQgLjdHjLK2/CKb0HmejZJ1qkRWEzJcBcEDsVV91H+p1SD+yNgA+x7wQrKS9pfz4+86Q5R354ptOqmPv5iZo7mXVZephDb/AXeOENeGjrdQBDYzsurbP3lpomCgju29JgTdLPcLspxsXxvFlysW7Z/xReisYBCFXgcyQj9D2/hz1Vj8xAVWxRidBIGlQ/2mnT6bzG5hObwxbPTz3yWAJms9k6r1FrPWMQtavjZxkZ44fo44heGJqRc4AL/tsjCv5wvrwHvawpH5F9f6CYK5qcOga0VnfdBu9A1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tiEWsj+YiHB9L3CBMDKpcgIRxlNDTdm7uNs1Ay51CS4=;
 b=iWxSKGI2rq1pQI2tr27FaPhqPSmVW78pCe4dxk3Ou7p0fnAWWS9aMV7gajxdAC4GlPoEwa4qBnv5T0YlQpAzShz7KTAdsEdAysPsMEtxeL8xkMoyziDigW0ILDcM3Cj/KZEQ/jU2J4npAnNSVxGTHAI+o9LOzA36MItn4F348XJoq+jUTgo1S4pyb/eXEHYi0trtDvTjDZAyvwyx3YyCbgKEcPuACt2kC8iq7bqFKRhO3MCuaNxhqe/niDO0v2N+jYOUgEr8H8BfhVkw53BHgGGfWTFsClihoxjURtH2IG8OuFi3rz3DXqadbKaIOxHVPAwf2rsNJg/Nfep3RXJKiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tiEWsj+YiHB9L3CBMDKpcgIRxlNDTdm7uNs1Ay51CS4=;
 b=cPUzrLknniN8anJGrGnsv1IxJAWZo+7xgOwWyaK/uankNqbYVnpxr6/KpHkSq8oX4RJFm/kSYdTay1vEdVFT2tcydtrtBLwUwdhVOeKHdrUdRvILN15SQwlqcW32Pmr9eVdlIhqMzSTUHS/8jQewXxUjGxkggBaa68LPbBZeUDb0L2TztV33Ppvb1b+PaaSpo10FJkqBgqRxPRjO8stQgvDZLb9s83NsIHRBL2oDtYjq1QzZx9tj9CluJ9tcNr8LBWBnBH25NCEuo+xP8tBjrpsnCHwFXEw9GXrE4q3L8ooSk2Fkpu0kJ1QXo8A/NQY6YNboj0nCjsyu+nE3/OXXtw==
Received: from MW4PR04CA0098.namprd04.prod.outlook.com (2603:10b6:303:83::13)
 by DS0PR12MB7511.namprd12.prod.outlook.com (2603:10b6:8:139::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Mon, 19 Sep
 2022 14:37:39 +0000
Received: from CO1NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::90) by MW4PR04CA0098.outlook.office365.com
 (2603:10b6:303:83::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Mon, 19 Sep 2022 14:37:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT092.mail.protection.outlook.com (10.13.175.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Mon, 19 Sep 2022 14:37:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 19 Sep
 2022 07:37:25 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 19 Sep
 2022 07:37:24 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 19 Sep 2022 07:37:20 -0700
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
Subject: [PATCH V1 7/9] PCI: tegra194: Disable direct speed change for EP
Date:   Mon, 19 Sep 2022 20:06:25 +0530
Message-ID: <20220919143627.13803-8-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220919143627.13803-1-vidyas@nvidia.com>
References: <20220919143627.13803-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT092:EE_|DS0PR12MB7511:EE_
X-MS-Office365-Filtering-Correlation-Id: ac3e12c3-62d6-464c-e392-08da9a4c8087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ruofb9VR2/O4wmUBo88sMT+5U3IRjNo4TLl/OVdMPDiqdq8Zf7Gb6gGL7Ik2d+xcW3GMSZshMLa73l2vy1OFfoejrFLHqdI85F4qi83Itz7VYo7Bq3l+38dlMPfVHodJn3w31iEyaltOPmvBwytKoeNA6wAHVa0WQK7fi9dDK0waHa54uq7G9HX4DasywqHgu3bruv2jsY+3UIsMCQt6g56TSKg57GdtMXKWtMz5dg1fLy9yPytOSX2Om7093EsMEx5F9e+h/BTXgMLyE203CDJf6mR9BhdK9RVNuKE+XvQuKjq8A6hiZKQggYgiq0K5dzWf9lo1FA52f/pydCcuQNqbD5+MYxuH3VNeCMSDMfQNr/H2dVK9filBB+GYKhInTZ+5fIuhG1J+mhehIZIiDmDsstTOGRuiHCk2mYzFPR5jIRcz07pH9IvFJAg2F3L5MNRfBI78egVXYdVWJgKl9HjoGoeuMzD4kGIn4Zi6PwCBusH2+lO6sw9ITiy5n/ANUhqI3cHn8Koa/boetONCety8wavD04ouI4dmHw0QW46mSds1LdMlgx3Fg2DB1whwe+2tH23u25sy504DGy8FkXcoZ8XrD95GDYHQC7jsvzMJKI4uINGRlJG0G9GVxYz3Kz/HvQ6l6pcbG7FTmgxGEKyP19FZIHSbp0MP7LFWfr/qUbWQrnFhjEB2Xw4seJQmS09qbhRVfzKPJDvLwwC2Ih66YNi8UzgjMlSJkNuDsCIT2fVtwyw83BohcpLEuNeGDGLLWr9AvnAfpHlzexzQrrQR3sqcFYYaDBuSAxFOIkU=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199015)(36840700001)(46966006)(40470700004)(2906002)(8676002)(26005)(7696005)(82740400003)(478600001)(110136005)(40460700003)(921005)(7636003)(356005)(316002)(54906003)(1076003)(7416002)(5660300002)(186003)(336012)(83380400001)(4744005)(47076005)(426003)(70206006)(41300700001)(4326008)(70586007)(36860700001)(2616005)(8936002)(36756003)(86362001)(82310400005)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 14:37:38.9365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3e12c3-62d6-464c-e392-08da9a4c8087
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7511
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Disable direct speed change for endpoint to prevent it from doing
speed change by itself post physical layer link up at gen1 and also
to leave link speed in control of the host.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index e38fedd42034..35d9c3ac3028 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1872,6 +1872,10 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 
 	reset_control_deassert(pcie->core_rst);
 
+	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
+	val &= ~PORT_LOGIC_SPEED_CHANGE;
+	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
+
 	if (pcie->update_fc_fixup) {
 		val = dw_pcie_readl_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF);
 		val |= 0x1 << CFG_TIMER_CTRL_ACK_NAK_SHIFT;
-- 
2.17.1

