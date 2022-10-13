Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05F25FE0CA
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 20:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiJMSPF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 14:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiJMSL4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 14:11:56 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on20624.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e83::624])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90A717C552;
        Thu, 13 Oct 2022 11:08:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eu9c8qtqO7HMHbBFGLZnVMaBEHqu7Cpn8aP+qAQLYe1CeTssuHR6SGGwn+RguquoyBpTtFThLQ7ECZnA6ovuNO/xhuxkZvCwawLQnnPV7hyw/EM8nmxMi+wxBGUwLQ5lGhhO/AENH41s/YvqQUzjVvR+xynwq/QJRTO57HMp3nBB/VWAMWDPBl1jNeLS9WyTrenLiBwH5WqZ97AdTREYnEQ4Lw0BRzT5yTMaA0MPsPGsQJs0Lbh2gUV2Jt9cyGnX0Vq2GQdBsJbWrCkmJJ6qHr0fqAiwE5o99xl/hDyKXMc5FPBAO9u8i0zBmBfq4R3rRwrDl+rDqXh3Th8S+caonw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPqZxVDy44Ylt/BXwwJLhNOt6V6VdgC5Canmy3O3ujs=;
 b=R0/v/Q9JlBL7EjqxKU9V8hHL2+yu9SD65VZ5lBqFjj144WCFTZUsAE9C9vK519wn2zkv0UErd87OiOukqHzZZSUVMQnSfyfsTELbmGVcj7nYWogCVgfsORe2fcsUBQA0TRpKdGLHU/dGgE94QrgKN3a6KM5Z11+9V8spu0lK3t5X2eK0wrAO3nSRpgVuT/Jtdxbbept/bjpIhzuJ8ctkUWI1ERrDgeWzAUPtit305R7JstWghetD5Ne/gzcEF5uMQKEa+TYM4t6uj06hSXOZBnME8X+/WSt+333v5O88BtyXY7+0OHArxYKW/NxNfaqurz5DCab/tvqgGIED00Glng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPqZxVDy44Ylt/BXwwJLhNOt6V6VdgC5Canmy3O3ujs=;
 b=s4u8hFxKafev1kqrotyW0MortcokKSqQOjnrxbXb3+J84WmA2/qHxYC1zbVDdjZv32Ay+Y3Ytl+DMhX3yD8BDdgnp3Cl3Zu8kEi+MpGU10x6JxPGyVbmqiKZ2i+FdrQMuuWkdRCelsYIl00e4Py906rahweQ34f3GzEvrUBQcq5A2dmeCaBqkHlk25P6oCBB8lBFhxW+SutBtU3I33ErnkfD9ae3VxZLq06rnXomvDq9Lw6+TO9YTAC/05RoGmshVE9l4r3A2xcsmXdXcu/vzTKBHlHgnF5r5HkroYdeg8Ze5YZD+yGR8Zbl12OycLlYOGAtve/Qhx7/rjTCb8DuCQ==
Received: from MW4PR04CA0086.namprd04.prod.outlook.com (2603:10b6:303:6b::31)
 by SN7PR12MB7227.namprd12.prod.outlook.com (2603:10b6:806:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Thu, 13 Oct
 2022 17:57:52 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::34) by MW4PR04CA0086.outlook.office365.com
 (2603:10b6:303:6b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21 via Frontend
 Transport; Thu, 13 Oct 2022 17:57:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 17:57:51 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 13 Oct
 2022 10:57:34 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 13 Oct
 2022 10:57:33 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 13 Oct 2022 10:57:29 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <mani@kernel.org>,
        <Sergey.Semin@baikalelectronics.ru>, <dmitry.baryshkov@linaro.org>,
        <linmq006@gmail.com>, <ffclaire1224@gmail.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V5 2/3] PCI: qcom-ep: Refactor EP initialization completion
Date:   Thu, 13 Oct 2022 23:27:11 +0530
Message-ID: <20221013175712.7539-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221013175712.7539-1-vidyas@nvidia.com>
References: <20221013175712.7539-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT013:EE_|SN7PR12MB7227:EE_
X-MS-Office365-Filtering-Correlation-Id: 374c9b82-3c9d-4830-57eb-08daad44729e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5vjPstjsUYR7yt0M0ZMmo6gEWM7hVQBrhVJHxObEdQkq3vDp1L9CZgRRfs8S9jFnHfhbUdurYfVg5c/IGaElJwbhisPowBgEEjodiRs8T6lWvNvwnKu8galkKMFQqXyYVfx+PhqJBjcFTBWPHR7qzj5wUQAh6JHrIic/Pks3E3Vi4AarwDR3iFA0LvxRDhhT9FPPobwqh13t9KZ/UOQA3NR8h6HlNnhjn/TQp1WuuW6F+Y4a4aYrpgZFVfE2FMwMgYKpS00QhnAX/hHGeUAqOdROUxJeEAdT1PIDrVY2by+LV/PVI6JxILC/Cn4FJ96Oyiwt+Ii29WB2tysTdc6lZ97wqRlQD3Q1XUuHPpuoWAZmx6J0h0KMJQEkiOE8hBf1y9BItSX7bQvxN09s9ooB+x7yfND98WNh64SoJXyH6ANSco1O1oxj9QtAhW+qNJ5dn58GL7w+Cbf5d8HIoIEFlUg51IPB/wQujmXPYT1ZHjysCT9Wh8TSanFEwPRtN7zRMF4FgfLPJmOTGX6vFZhiKFXtLaZq+tLTmSMfzL1lUO6Yvwb+nnXa41xQORx5RhygZ/pU4zHiw2UXPelRygmUea5+bGLvbn441fATYl30IfJ52OSgC5wnlXhZOB3IMP9LOG9NbyLeawZLAhIsQPPRNvxHdsW1FShTC6/jTG3oBoka/JGXAfLQhFAPkLT+RrnHCRT8Vn7pIgAeHTCnZ71Q6CntIAm0ooUBqmL0VgJDOH2n111e0JNwueTmLRkN/45fDcsk7UYL/Wc9NCCzHVu1Q4LfAt+IIQ7oMpsSdkO/KJA=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199015)(46966006)(40470700004)(36840700001)(26005)(7696005)(316002)(82740400003)(8676002)(70586007)(36860700001)(86362001)(40460700003)(921005)(70206006)(356005)(7636003)(40480700001)(336012)(186003)(2616005)(1076003)(478600001)(6666004)(110136005)(83380400001)(36756003)(82310400005)(4326008)(2906002)(426003)(41300700001)(54906003)(47076005)(5660300002)(7416002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 17:57:51.6832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 374c9b82-3c9d-4830-57eb-08daad44729e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7227
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move the post initialization code to .ep_init_late() call back and call
only dw_pcie_ep_init_notify() which internally takes care of calling
dw_pcie_ep_init_complete().

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V5:
* None

V4:
* New patch in this series

 drivers/pci/controller/dwc/pcie-qcom-ep.c | 27 ++++++++++++++---------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index e33eb3871309..c418b20042aa 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -361,22 +361,12 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 	      PARF_INT_ALL_LINK_UP;
 	writel_relaxed(val, pcie_ep->parf + PARF_INT_ALL_MASK);
 
-	ret = dw_pcie_ep_init_complete(&pcie_ep->pci.ep);
+	ret = dw_pcie_ep_init_notify(&pcie_ep->pci.ep);
 	if (ret) {
 		dev_err(dev, "Failed to complete initialization: %d\n", ret);
 		goto err_disable_resources;
 	}
 
-	/*
-	 * The physical address of the MMIO region which is exposed as the BAR
-	 * should be written to MHI BASE registers.
-	 */
-	writel_relaxed(pcie_ep->mmio_res->start,
-		       pcie_ep->parf + PARF_MHI_BASE_ADDR_LOWER);
-	writel_relaxed(0, pcie_ep->parf + PARF_MHI_BASE_ADDR_UPPER);
-
-	dw_pcie_ep_init_notify(&pcie_ep->pci.ep);
-
 	/* Enable LTSSM */
 	val = readl_relaxed(pcie_ep->parf + PARF_LTSSM);
 	val |= BIT(8);
@@ -643,8 +633,23 @@ static void qcom_pcie_ep_init(struct dw_pcie_ep *ep)
 		dw_pcie_ep_reset_bar(pci, bar);
 }
 
+static void qcom_pcie_ep_init_late(struct dw_pcie_ep *ep)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
+
+	/*
+	 * The physical address of the MMIO region which is exposed as the BAR
+	 * should be written to MHI BASE registers.
+	 */
+	writel_relaxed(pcie_ep->mmio_res->start,
+		       pcie_ep->parf + PARF_MHI_BASE_ADDR_LOWER);
+	writel_relaxed(0, pcie_ep->parf + PARF_MHI_BASE_ADDR_UPPER);
+}
+
 static const struct dw_pcie_ep_ops pci_ep_ops = {
 	.ep_init = qcom_pcie_ep_init,
+	.ep_init_late = qcom_pcie_ep_init_late,
 	.raise_irq = qcom_pcie_ep_raise_irq,
 	.get_features = qcom_pcie_epc_get_features,
 };
-- 
2.17.1

