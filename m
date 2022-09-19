Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD585BD4CA
	for <lists+linux-pci@lfdr.de>; Mon, 19 Sep 2022 20:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiISSep (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 14:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiISSeb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 14:34:31 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3079D1DA;
        Mon, 19 Sep 2022 11:34:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtWQQR/gHStcAFme8k8GKnmmFYsyGqSlXFlyBcArVnZt2CzXxNqvd2BcVB+DlZWdnHhoyzf3ka2qFhRcZdymmsn26/j6EfozFvusTnizimTXLebi6Wfpe1LNEQncdSgO3Ndu3HqfZUfOUw8nJPsW0cYBdgvNvniIRJaSLVwbv509XcUc0mGOBArAOsNKC+EYlrdmspJiJUDslNehVuYiYIH9ArQQKzdZUOh7mK9bU70WCaeGaY36OmoAWrBUM5Rq/1eESPf+/cPDAt6KiSQLE1vaXhrN/yNS2mAKg+zDe4+hCYXFN7P/LuUbihjx/Oq7hICsVeKDkc116cpR2ScaQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6Lr/s4hxz5Zi4JMyQTAfhWJhlC4WnK//aCSV9R/sN8=;
 b=UIt4xTC6zy3qcqT6gur7kg+o42sEtM52zCYRVzqsCM738cL+S4QsWsKWnDOdnY+p8If+17sEs0yGzkDb9fvRrXwglsO41PnY2pz943g/ij3kdqfC2gXfxYzKRUDLpFwhjj7lYNoJXp+X2wN0oq9tPV8mrSnEqEFrEC9D2fPTBgSkxe3SVnTH0Vbzb0QAL7r0AoNKOtbNtpZcZ2TPndK7jLxhYyy44Df5LIExxngqJ0V4HrquZLLY0NSTsljpqlkJ6hjJs8f9zt2VfNnKgWKMvLl7Xa+fSZp6KVd+1iwVd2uoadQn9kV1+juMNE9t2859XAK4gQ+m+h0M7b5FND75qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6Lr/s4hxz5Zi4JMyQTAfhWJhlC4WnK//aCSV9R/sN8=;
 b=Dl5pEgIgFDGOI0zZcD4t1A2QESkIMQ2OSDFyWYQd16OvVaiadY6TYxLByM8IE+i9N49TvJuxc6ZXQWTxMDSMhU8qWbfUz43DeUwc8ZQq31zkKBLMrCx9pR4xlfoozQ7FGVdo39eAs9ZKOKhl4cSbKxEZWK+d9YF+C4xGWnsMnf3dlITDNqGsSM9Nn3Xd6ytJNgNUEhUWA5HR4zywXJQVQRCJDDiTxRNDqT1YZlpN5QT2Vu1caJvw0r2b1G4z1Uh57kyY7ubHJWT+uZ47wL05ynEzXmZ/jAP4ejYKFWwaIydqLm78Aumb0fF2tla5BpdcYZMOn0Ak8i9gMO6Ls/fp7w==
Received: from BN9PR03CA0116.namprd03.prod.outlook.com (2603:10b6:408:fd::31)
 by DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 18:34:25 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::4) by BN9PR03CA0116.outlook.office365.com
 (2603:10b6:408:fd::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Mon, 19 Sep 2022 18:34:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Mon, 19 Sep 2022 18:34:25 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 19 Sep
 2022 11:34:05 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 19 Sep
 2022 11:34:04 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 19 Sep 2022 11:34:00 -0700
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
Subject: [PATCH V4 2/3] PCI: qcom-ep: Refactor EP initialization completion
Date:   Tue, 20 Sep 2022 00:03:41 +0530
Message-ID: <20220919183342.4090-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220919183342.4090-1-vidyas@nvidia.com>
References: <20220919183342.4090-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT023:EE_|DM4PR12MB5181:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f697bc8-9217-40d0-b090-08da9a6d943c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AubVE6vaxfjll0Nbeu14bTgfu22MeXl5NmsQYqzz/BaFRgWRTeQ5iskPKhCJDGArcEGAL/+qw1njxPU+OImeVzSV4nr6DMY1LhTW/KamDmFRmDdaG2Abx67avm2jsrj6aefNsQlDHbi+rGUdOFlY+zbGvGVK81Ee0Q7/rKQgz1C/XugBGbkCs72KHTAxLg4q2UKbWXpjzrSlp6WjfI0o6loX8O40LfC0N6qplXPbJomDJnQ6tb9gXjMYkIKyPaXiLWoKQq+lg5Cbn+uilkqU7KidV2AhLFH9IFE1TTevx51vkJEuHyIrq8WeAYM5Qeq751b03UClX8+0WcRtncYnnAiPttg/S0+HdPhBNNPzqNby6BHvobXlmgDU1t0FtMGS4r8OVa8W2l+1i3xb8xrGTnDzdpLOdLi5w/EigyfVKDU0GeLJX8uqoDT/9tv43w2ssKrLMHnc21M0BROzWbstzfJC9CXtnenJcBxxnzLZhKIGTeqmm+FAxWeinIlzCsOkibqLkLcDrj3K4baIR3yA5pELnCCGbhyA31uDGD6U2l/I1F3UJAJyFu4iHVCzkhBmaLTgH7ReS5shfSVXkEUqjZKRVyz2jhPlt2bTND0lKHKCueeaHDZneWQ1Drq3s2BmnB7wf6GWsuArKEetsm+IX5FFsNHZq+i6OCe1B5YJcvza34yHDseEl/HhKycwQ+i25Pb13uVdZqBvPIHg43li/gKD3AoASwlTDvKdYb+CkkiMYlsoY7NwxSJSAPB9f4KUdKbb3inh8yFFOl4neDZdo1cwjSPCXTmGHvSE5i+fWZY=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199015)(46966006)(40470700004)(36840700001)(70586007)(70206006)(8676002)(4326008)(7416002)(5660300002)(54906003)(110136005)(86362001)(8936002)(316002)(82740400003)(47076005)(426003)(36860700001)(83380400001)(41300700001)(7696005)(6666004)(40460700003)(478600001)(2616005)(7636003)(336012)(186003)(1076003)(356005)(26005)(921005)(40480700001)(36756003)(2906002)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 18:34:25.3433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f697bc8-9217-40d0-b090-08da9a6d943c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5181
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
V4:
* New patch in this series

 drivers/pci/controller/dwc/pcie-qcom-ep.c | 27 ++++++++++++++---------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index ec99116ad05c..cc7ce470640e 100644
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
@@ -639,8 +629,23 @@ static void qcom_pcie_ep_init(struct dw_pcie_ep *ep)
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

