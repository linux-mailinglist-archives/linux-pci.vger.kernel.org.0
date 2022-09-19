Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB175BD4C8
	for <lists+linux-pci@lfdr.de>; Mon, 19 Sep 2022 20:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiISSeT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 14:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiISSeS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 14:34:18 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2084.outbound.protection.outlook.com [40.107.101.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7E036DC8;
        Mon, 19 Sep 2022 11:34:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hm8++MXOFCCVpBe7J6kHQarXJ/CZL7afsVCj2miURr+ppH+4kwCzRDWj9JPh9eInkQak74CCih4Sb9GBQPG4cn0ZCVz5hOkZYSEes++knPo86YMGUUfqyOOi+N6h8WHo0yQ39UELGLCCc/J8FEXhrULOM2m1uUYzgRJmWniJTByAknUuyqlLFWIyE5TvE2wzqZOERGD+1nTMYVMqdyjsKDlyXNdA71eGIg2dxvVY9HG4oW4abV01nl8rRCEb2/0Kvz+aMoHjiake8LkrevSavEN8A6yUgCseA5Xkw3PEMHYp4jhvHgGyPYFiXCdM/6px3+ljD4i9UDCNqgd/17BMlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyrZSZ1OeaWo83FMCyuGKkzVaHYRHndXZkpE8cMp81Q=;
 b=mFLh1uWGzzqjeOvmRriFgOw6u7UgKKYKhweGS+7p0pC1GhzeWC+fmT8+AIMZ+A02j6cpgJxk2+Rr9vHcEGZJKUBTOCBxtAP/OdMl+E2WJ6z4006hlygFcltdD0pb4KKFlK3GfoxB542yesKfeBS55DZFL9OpH00Wwu9TesY7M118ZDAasw/ymKRwU973DCEyZJLtHwMm7zjH3ElwP9lneciyr3kg3rz+D974tqv+pctpcv3cf5w5CzadymEd/KFyZWUuKcAJxsXpNCVojdiM8I4qemIAeJTw+A0DwEztcCpjhjOdeeidiXF5ik6XRnH5cMGEfTL6W9uq+dONVn7siA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyrZSZ1OeaWo83FMCyuGKkzVaHYRHndXZkpE8cMp81Q=;
 b=jC7HRpaPNG8eBnh2nfb8lcMun6eQYz05QHZpidXcXddvNE3bZXRqa/3lFeSQajzvgisHXfE66St1++xXE0M9RIdOvlWbcRDQv5bc/E9yMgom9ITQeH25nR0FzzRKp3N3d3hVXK/1n4+VqnXEeab0BNXXKkHCnJdHp11kA6LN4CUa9KuytRYGqe9E1vtlGM0sz3t2VOXdfokyeHz5kgFet8+oWXzvBZzuBKdIV0H+PXEiorLYr2jt0NiYAzqsTHJymlkbmLK3KcMDrht2FJeKgxn5lIkHVDrFL56MfKx9fSzi7v9St/DxyTjS/KX+3b3/w5fzTPi18fvs5KMmqZSLqQ==
Received: from BN8PR15CA0040.namprd15.prod.outlook.com (2603:10b6:408:80::17)
 by DM4PR12MB5087.namprd12.prod.outlook.com (2603:10b6:5:38a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 18:34:14 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::a) by BN8PR15CA0040.outlook.office365.com
 (2603:10b6:408:80::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Mon, 19 Sep 2022 18:34:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Mon, 19 Sep 2022 18:34:14 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 19 Sep
 2022 11:33:58 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 19 Sep
 2022 11:33:57 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 19 Sep 2022 11:33:53 -0700
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
Subject: [PATCH V4 1/3] PCI: designware-ep: Fix DBI access before core init
Date:   Tue, 20 Sep 2022 00:03:40 +0530
Message-ID: <20220919183342.4090-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220919183342.4090-1-vidyas@nvidia.com>
References: <20220919183342.4090-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT059:EE_|DM4PR12MB5087:EE_
X-MS-Office365-Filtering-Correlation-Id: c7edc755-fa26-4413-66ef-08da9a6d8d87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h0rgEyydnhNS+9p98SXjWVXsnmb3NfzMZH922H8Awpiw523d+SGPdXJO9zD7/CKKWkPKz9qcxQaLlEThRddLPzupOHqoN395HZ38AdIHaAktFwCTFUtzMx2vH2nG8HnRW8E2HtTEOzMryNVuZtNED3lFc6ePcTdxGcjphXTv0mx8AjhZXqXpZpSueXeBIysp6es8XS3ssdpDrF8t6qWsy1Pbbs8PuemDOpI10FXTrMvU01BhkazWzoiXqTXjnYM/pzLrfb1d6LV0K4W3PeOJXfvBNR8K7gepg2nBewP4OcTbBm9aEyf9gzvnHao9s7IvhE0d1qNqDPqFBfsO0onIgXQoNI9e8nkrxN2hR2oypK5CU6pAPDDzu6bfTHkxc5T9zJcTdENKeKioupgVOngayhjWuEu1W4GxA4W3j59g9YvJZybXDfiNYMaumv4YB85JiPZFMWhZfkULRCl/ezuCQ3Wddl36QvLcfyndftQJhM7QSLr9FDDuREUf8GUExSQS5M+iiP7qUgpVaXyqqQ/B5u6Q34JyP2wo/t7Fdv+Mz9G4lqL9WR7M5/SCxA5BH+mc5Gm9wUGnS//bjtEGbf7vm+8Pdlcc1Kmz5wAbOVhUH/IlGutlCd0X50q6pZVlBdO1GNv20KUXbFaJLPs/r7QxWcHmViiAzuFpnBX9ccrOByenfiV/aAAE0FmjjF7STKrCsFePVldniphEdxIKNJ3r8Qe+w7C3bWtU+jwWBrZ3gFf44CHqNaATPtCQtFCbpfB/FzbUWFyWrneEGUzhHfDOp2QpMFqLF+w6fmaBOg5dnQE=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(26005)(7636003)(82740400003)(40480700001)(6666004)(8676002)(4326008)(2906002)(2616005)(356005)(41300700001)(36860700001)(921005)(7696005)(47076005)(86362001)(82310400005)(186003)(7416002)(5660300002)(36756003)(478600001)(8936002)(110136005)(54906003)(426003)(70586007)(70206006)(336012)(83380400001)(316002)(1076003)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 18:34:14.0733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7edc755-fa26-4413-66ef-08da9a6d8d87
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5087
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Platforms that cannot support their core initialization without the
reference clock from the host, implement the feature 'core_init_notifier'
to indicate the DesignWare sub-system about when their core is getting
initialized. Any accesses to the core (Ex:- DBI) would the core being
ready result in system hang in such systems (Ex:- tegra194).
This patch moves any access to the core to dw_pcie_ep_init_complete() API
which is effectively called only after the core initialization.
It also introduces .ep_init_late() ops hook to be used for any post init
work that platform drivers may have to do.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V4:
* Addressed review comments from Bjorn and Manivannan
* Moved dw_pcie_ep_init_complete() inside dw_pcie_ep_init_notify()
* Added .ep_init_late() ops to perform late init tasks

 .../pci/controller/dwc/pcie-designware-ep.c   | 112 ++++++++++--------
 drivers/pci/controller/dwc/pcie-designware.h  |  10 +-
 2 files changed, 68 insertions(+), 54 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 83ddb190292e..095fb0291ec9 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -23,14 +23,6 @@ void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_linkup);
 
-void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
-{
-	struct pci_epc *epc = ep->epc;
-
-	pci_epc_init_notify(epc);
-}
-EXPORT_SYMBOL_GPL(dw_pcie_ep_init_notify);
-
 struct dw_pcie_ep_func *
 dw_pcie_ep_get_func_from_ep(struct dw_pcie_ep *ep, u8 func_no)
 {
@@ -640,12 +632,17 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
 	return 0;
 }
 
-int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
+static int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct dw_pcie_ep_func *ep_func;
+	struct device *dev = pci->dev;
+	struct pci_epc *epc = ep->epc;
 	unsigned int offset;
 	unsigned int nbars;
 	u8 hdr_type;
+	u8 func_no;
+	void *addr;
 	u32 reg;
 	int i;
 
@@ -658,6 +655,40 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 		return -EIO;
 	}
 
+	dw_pcie_version_detect(pci);
+
+	dw_pcie_iatu_detect(pci);
+
+	ep->ib_window_map = devm_bitmap_zalloc(dev, pci->num_ib_windows,
+					       GFP_KERNEL);
+	if (!ep->ib_window_map)
+		return -ENOMEM;
+
+	ep->ob_window_map = devm_bitmap_zalloc(dev, pci->num_ob_windows,
+					       GFP_KERNEL);
+	if (!ep->ob_window_map)
+		return -ENOMEM;
+
+	addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
+			    GFP_KERNEL);
+	if (!addr)
+		return -ENOMEM;
+	ep->outbound_addr = addr;
+
+	for (func_no = 0; func_no < epc->max_functions; func_no++) {
+		ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
+		if (!ep_func)
+			return -ENOMEM;
+
+		ep_func->func_no = func_no;
+		ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
+							      PCI_CAP_ID_MSI);
+		ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
+							       PCI_CAP_ID_MSIX);
+
+		list_add_tail(&ep_func->list, &ep->func_list);
+	}
+
 	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
 
 	dw_pcie_dbi_ro_wr_en(pci);
@@ -676,13 +707,28 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(dw_pcie_ep_init_complete);
+
+int dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
+{
+	struct pci_epc *epc = ep->epc;
+	int ret;
+
+	ret = dw_pcie_ep_init_complete(ep);
+	if (ret)
+		return ret;
+
+	if (ep->ops->ep_init_late)
+		ep->ops->ep_init_late(ep);
+
+	pci_epc_init_notify(epc);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dw_pcie_ep_init_notify);
 
 int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 {
 	int ret;
-	void *addr;
-	u8 func_no;
 	struct resource *res;
 	struct pci_epc *epc;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -690,7 +736,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *np = dev->of_node;
 	const struct pci_epc_features *epc_features;
-	struct dw_pcie_ep_func *ep_func;
 
 	INIT_LIST_HEAD(&ep->func_list);
 
@@ -719,26 +764,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	ep->phys_base = res->start;
 	ep->addr_size = resource_size(res);
 
-	dw_pcie_version_detect(pci);
-
-	dw_pcie_iatu_detect(pci);
-
-	ep->ib_window_map = devm_bitmap_zalloc(dev, pci->num_ib_windows,
-					       GFP_KERNEL);
-	if (!ep->ib_window_map)
-		return -ENOMEM;
-
-	ep->ob_window_map = devm_bitmap_zalloc(dev, pci->num_ob_windows,
-					       GFP_KERNEL);
-	if (!ep->ob_window_map)
-		return -ENOMEM;
-
-	addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
-			    GFP_KERNEL);
-	if (!addr)
-		return -ENOMEM;
-	ep->outbound_addr = addr;
-
 	if (pci->link_gen < 1)
 		pci->link_gen = of_pci_get_max_link_speed(np);
 
@@ -755,20 +780,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	if (ret < 0)
 		epc->max_functions = 1;
 
-	for (func_no = 0; func_no < epc->max_functions; func_no++) {
-		ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
-		if (!ep_func)
-			return -ENOMEM;
-
-		ep_func->func_no = func_no;
-		ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
-							      PCI_CAP_ID_MSI);
-		ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
-							       PCI_CAP_ID_MSIX);
-
-		list_add_tail(&ep_func->list, &ep->func_list);
-	}
-
 	if (ep->ops->ep_init)
 		ep->ops->ep_init(ep);
 
@@ -793,6 +804,13 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 			return 0;
 	}
 
+	/*
+	 * NOTE:- Avoid accessing the hardware (Ex:- DBI space) before this
+	 * step as platforms that implement 'core_init_notifier' feature may
+	 * not have the hardware ready (i.e. core initialized) for access
+	 * (Ex: tegra194). Any hardware access on such platforms result
+	 * in system hard hang.
+	 */
 	ret = dw_pcie_ep_init_complete(ep);
 	if (ret)
 		goto err_free_epc_mem;
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 09b887093a84..7222717afa33 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -254,6 +254,7 @@ struct dw_pcie_rp {
 
 struct dw_pcie_ep_ops {
 	void	(*ep_init)(struct dw_pcie_ep *ep);
+	void	(*ep_init_late)(struct dw_pcie_ep *ep);
 	int	(*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
 			     enum pci_epc_irq_type type, u16 interrupt_num);
 	const struct pci_epc_features* (*get_features)(struct dw_pcie_ep *ep);
@@ -467,8 +468,7 @@ static inline void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus,
 #ifdef CONFIG_PCIE_DW_EP
 void dw_pcie_ep_linkup(struct dw_pcie_ep *ep);
 int dw_pcie_ep_init(struct dw_pcie_ep *ep);
-int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep);
-void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep);
+int dw_pcie_ep_init_notify(struct dw_pcie_ep *ep);
 void dw_pcie_ep_exit(struct dw_pcie_ep *ep);
 int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no);
 int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
@@ -490,15 +490,11 @@ static inline int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	return 0;
 }
 
-static inline int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
+static inline int dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
 {
 	return 0;
 }
 
-static inline void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
-{
-}
-
 static inline void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
 {
 }
-- 
2.17.1

