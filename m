Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F3D5FE1C4
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 20:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbiJMSoJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 14:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiJMSnD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 14:43:03 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20604.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::604])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E0018F273;
        Thu, 13 Oct 2022 11:41:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnhlqrVAgFO7eUZ7gpj33QLya7dylVDGiDLJ1m1VDMPUFFqO/JXdfwX2YUgf+uraRFoF83PyHqR7b34MTp+zj5moqxiHP5p3u6OO1zlRN/poMA8OEysDVvIowRUTkJcRX7cQGfl0ENPI5jDgsgKRXMFyHB5lJ/79oIVu/FlltusBTdCTU8Fu3/Id6+8GNxx5ujKkOcwDsz4JYL/Hw85EvCdY4jwo+X6lURhiipcsS3+c7WLxn0uG84Otre73t0Be/o4uxCkJGJ2bP3hvqGN9rYVLy7JN+QNjmHZhRj/6NQ2RsC1/Yts8Qi+9SGV1hq4Iy3WiCO1vufxp8HmR0GpE3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVum5g4iSVlMg0X000qp1jZQMVyDsz0ZHu0LASebBOg=;
 b=T1F5QU3cB6tx44CTTVH3YIF4f/c+Vo0BoZKA1MR1mIT9W53hjHnSHi5ryMriQdwVpCbsKM2Zf0PZ0nfsj0NVpz+Ym2QuhNPyxiqz2nOaLz/njzM1IasTI07VLJIFDm92gqss0HKT2n7sBw0HOEb8rz5H9+I+8W9EAzZMXFwW8c07AuH4lIjjW/d81n3uhvZMFDZPOajFCugbMHOEoPe4380eby1Y7GNXm61z3fOegChI8f5KzyI0qfAIdppffxu0AfGzS/x12jma2rV6YcyXY27Jwnm6HSmRwyltbq4UUtbr2oqaP4USp9aD6RiJswQoqPndX02H0oi7FfLxDi3yqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVum5g4iSVlMg0X000qp1jZQMVyDsz0ZHu0LASebBOg=;
 b=osA6MSIKsUfUXW1KKa9U0dlokNXFFzGQ6DLCDirz6R8v7S4m9ueDUNdixiNrcs1GBg+Qhd5+YnNKRvqDcm6cFJG1mlkbhB9SQNJkM3n4Dc7mp2RIbgSZiV3FGeLM9iNchA8lG2Jgvdsv5aa1aJEkgkClHa+Xfwhwh/SVJuQ3gpwlb+EzGWyWNsmuPSY9R1iruSagWARaSINvGnnS9LmjN+4loGWsj9LYlPxIX9N0dtOIEnwg7wr3A5uK42MGxSxCZEZWAD8f8OB362+OwrrJiZKC8lp6C2ZakCURWHEmrSdeoawF0Z2dEF9tGLrxUaGCDTdKPMYIxXbufPPGqX/egw==
Received: from DM6PR10CA0017.namprd10.prod.outlook.com (2603:10b6:5:60::30) by
 DM6PR12MB4121.namprd12.prod.outlook.com (2603:10b6:5:220::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.26; Thu, 13 Oct 2022 18:40:33 +0000
Received: from DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::5e) by DM6PR10CA0017.outlook.office365.com
 (2603:10b6:5:60::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26 via Frontend
 Transport; Thu, 13 Oct 2022 18:40:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT074.mail.protection.outlook.com (10.13.173.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 18:40:33 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 13 Oct
 2022 11:40:29 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 13 Oct 2022 11:40:29 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 13 Oct 2022 11:40:24 -0700
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
Subject: [PATCH V3 13/21] PCI: tegra194: Enable hardware hot reset mode in Endpoint
Date:   Fri, 14 Oct 2022 00:08:46 +0530
Message-ID: <20221013183854.21087-14-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221013183854.21087-1-vidyas@nvidia.com>
References: <20221013183854.21087-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT074:EE_|DM6PR12MB4121:EE_
X-MS-Office365-Filtering-Correlation-Id: f45e2618-a5fa-4631-7afb-08daad4a697a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FYfU4cqeglcAzTBMKHF6GtTFLsGeS9geP0vK3PcpSJvvppBdNZFwT3HI3XEATJ9CsA1IVDWJ7KdmtjX8TYGYDyFEsVB74X4a+Yrg4ULWRwRiYe3P9pn7iWdvz8Ka18ngPGH5rREXKY/IGzTB6ULMf/uMi6l0bzbWUi2NmWeZkbOElUeqvVOuYSX+o6sMtNKiwiossFoYORybslTPBbutlSH6GNpXj73Hsqyr+LtzxXZpZddi7df8bz/0uvCRYBJMawUjnXBcM7oIC1XVA73g6njfaOT/rlfdfsUJe2S2Bcq0J2n7tx93h6L4gE//wyhruEy+6BmNhfKwOBr1CRrF3n0OKERAKXtmO33UiyDIXYy++VFBszscXzhKssbs8y2j4Z1POHZZ9kUITCJZqFa6plK0Bj/ZA3rrgvjOE7nstQ2ORFjo0+Ps/IpMxVu4Ue0QcBPV0PW8xq1fPkdLOH+is6rVq2LYq3rjMaPn/X+7Zax+YmmSM0wnCIiQhjVrJ0WzkjEkQV5BNKPjbllBPPiGa45596f0LRHmIWJzyfGaAirbd955lmcUrYXMDfo3bm6YIsjhhdiYU+9n2DqxSYRiSq3N5TckWd99VjjgyQLDoEC3Lok47ShhAEyHr6xmeOaPrBbHQ3NeVRSwqV7q/YKruSPgNPDXIxll7bco7ZZO1+uHdMrcPtRej2xSYylkTQQIj0l6/XCo5dm/9YvlG1/JTwRgJnTr8xr1QPeSNQQ/uoX6tMDQ/3ZViWxHT87t+oMZgj9TiaNSuPmGgvAT77joHvMGY3LkuAx96DbaLebZ/uI=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199015)(36840700001)(40470700004)(46966006)(47076005)(356005)(26005)(7636003)(36756003)(86362001)(54906003)(110136005)(7696005)(8676002)(70206006)(4326008)(7416002)(70586007)(2906002)(82740400003)(6666004)(2616005)(41300700001)(5660300002)(40480700001)(8936002)(1076003)(336012)(40460700003)(186003)(316002)(426003)(921005)(82310400005)(36860700001)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 18:40:33.3760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f45e2618-a5fa-4631-7afb-08daad4a697a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4121
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When PCIe link goes down, hardware can retrain the link and try to link up.
To enable this feature, program the APPL_CTRL register with hardware hot
reset with immediate LTSSM enable mode.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* This is a new patch in this series

 drivers/pci/controller/dwc/pcie-tegra194.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index a1c3481585c9..78ee0f713e71 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1913,6 +1913,8 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	val = appl_readl(pcie, APPL_CTRL);
 	val |= APPL_CTRL_SYS_PRE_DET_STATE;
 	val |= APPL_CTRL_HW_HOT_RST_EN;
+	val &= ~(APPL_CTRL_HW_HOT_RST_MODE_MASK << APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
+	val |= (APPL_CTRL_HW_HOT_RST_MODE_IMDT_RST_LTSSM_EN << APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
 	appl_writel(pcie, val, APPL_CTRL);
 
 	val = appl_readl(pcie, APPL_CFG_MISC);
-- 
2.17.1

