Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870095FE041
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 20:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbiJMSGE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 14:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiJMSFY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 14:05:24 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::60c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641EC264A6;
        Thu, 13 Oct 2022 11:04:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyMkR/shbqvBGKd4bhzFGFW7zm3YdlzpxrUjcEHSKuK26Ad8jnUUveWKK5yBv/pJsvh5BtQdQ9TcwA7h6TpE0Oc6SauORNzRS2yGHzWc9VA5qVcz5puo5gbGvkU9ad6HqtpLFag80Sy18uh/gvMM9Ox9pbB2mB7aK8I/nON+doiHYY8Dp5TKpZWThIRi99UiThxlt7SY/V67BoJc35OhT+Mi7J9CiEePT0WO9TewRmTLV8MlNbW7Dzvp4gm7QlLQeCrcgdsO3JOxEQq3f8gKVLUZRUVVywA2/DqQcB1yiUwvjU/f221QQK6ACg6+EuIrcAXk37kueyGgKu5EZWtt+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGVlV9WdzyoUG9jAVdDrI2QRQ0mtcK9EsCPtrMRwoNE=;
 b=SBCk7iWjfhfwdmx+LUP3sDeu3XpV5DVykxPI/D5JUODoVlfy01VouBg1RrVYKRrX4Z8UqP76ET1ZQx1LUfxwboRjGzykRJvTwmeObusGCBUxbm5HJK4kJD1Vn2rU0l5H56nxz/vkBpNmlHCXM9EHnNebRVCy0q9XzjJ8w7lFfT3VAsblwywPkXyx1JivHyMtEQIjjmri0QpDkbVbpo75tP4tVTr+pzlUyju9ZbjTfSPhA15O+OAYjg/ojXIBtJnerihL0yqB/dN8pBsbz60YP7Sb5JF0PB8skUE+M/xwU6D1X4yTz2cVd9Ia2crKtTDkAn7zHQy4jXTuSmMly16zIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGVlV9WdzyoUG9jAVdDrI2QRQ0mtcK9EsCPtrMRwoNE=;
 b=HtBGM/Q4svIBKzKiua+Y0VjeirGUjpNM0XLsrvOttZfXq0HvXME712e//V5W7n3L7hkGkBNU18IaKUOAFRArqCXstA5T6v/Epqj6yKWPRe7NtBzar+LHiESwTGxPRPZHQQ/Aih8xtYe8hg3Hzl1oEulIzURZR7+A1dNqXahAX2m+KSdqrQxxNBih9O+TiR7I4YgKM9zeX50+dvYx646S8WJuxUmJlqm2xwVL/2rA++1KfSoLHetfkLS3uVMTXTil3LGsSSQt1ZyYBVpoSEzGe6brseVifvVP0K6xAhuWk1MxQkwzdUm0t+cA3ZYN6w2M185btTRx9cUUnoL5+prLjQ==
Received: from MW4PR04CA0105.namprd04.prod.outlook.com (2603:10b6:303:83::20)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 13 Oct
 2022 17:57:44 +0000
Received: from CO1NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::d) by MW4PR04CA0105.outlook.office365.com
 (2603:10b6:303:83::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26 via Frontend
 Transport; Thu, 13 Oct 2022 17:57:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT072.mail.protection.outlook.com (10.13.174.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 17:57:44 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 13 Oct
 2022 10:57:26 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 13 Oct
 2022 10:57:26 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 13 Oct 2022 10:57:21 -0700
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
Subject: [PATCH V5 1/3] PCI: designware-ep: Fix DBI access before core init
Date:   Thu, 13 Oct 2022 23:27:10 +0530
Message-ID: <20221013175712.7539-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221013175712.7539-1-vidyas@nvidia.com>
References: <20221013175712.7539-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT072:EE_|DM6PR12MB4266:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f5f20a5-ddf2-4208-ea25-08daad446e24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zdFLg/2juGRZHjl/kyRIjTN7nhgEE7YGXhU9VAMeqfkyzTxgoe4U/J69HfXBP6w8fOw+vx41dHVveRSlJXjJMt/ZR3WThR+JexEvASAQZCotwcGs5NWKJvhLJwtoxVKnGOeJCttze92pz6bUzkritdMsobx5iq+KIoasqZekdTbzk9b2IsL3q1BsOxoBNaKnYPy2lznw816qHoGDajxVbSv64Im+lxIF9M/HqgjAW28GVMyCunFjN0Oj09VpX8yoNb4HH0A5zn0/bbUiDnAcIzJF4kMT4R65hBSNhccmxepT43XSPtpa9aFEDLDQSMRgnkKUVET6B0dzUOcIkKe2Xpt4+t2MvLbKx1zuw0hx13U8+7v1FKBhVqG0TJXxqgQdi5e5ZZn5l83T4T7jDVGZE+EBaM3kqd83DdvSwiwCiwmaih5GeSh5gHzcliV0yQHbLjARliJMJbqY6Y/VQuXKr4Xzl32jnX9fjbOpCvcbvtL5o1AjrQTxnkku0Z1rLSyCx6UrzNyUm8EfdjpwvXaGrhQ930eFLZ99vEixFJifEbA4PBCnOod3AhFyR1YgPcfQnvQSJ3ebl6Zls5xPOZiMTxNptxVMV+k0h3UtKqVjm4ZuxG/rNibZyp/rY82QcnDSOC6MoiDuQyGs7yzWAQbJEQ0fZ9Q8wZ5Ilt5iwvVXKqHkkVRbvNVS1uDYW3ujCfW1mx+/p3mXNizYAAPw8qWxhngJg0LCmvqlMZYJMh7F5nRFb6q8Ru08KQRY1Rglok2vBISUbRyIlqXgB/PvgtcHrerBK71ZSdP/9y0wCxCc3l4=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(86362001)(2616005)(7416002)(41300700001)(7636003)(356005)(82740400003)(5660300002)(186003)(1076003)(478600001)(40480700001)(8936002)(6666004)(36860700001)(70206006)(8676002)(4326008)(82310400005)(83380400001)(36756003)(40460700003)(336012)(26005)(54906003)(316002)(110136005)(70586007)(2906002)(426003)(921005)(47076005)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 17:57:44.1766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5f20a5-ddf2-4208-ea25-08daad446e24
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
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
V5:
* Changed dw_pcie_ep_init_complete() to dw_pcie_ep_init_late()
* Skipped memory allocation if done already. This is to avoid freeing and then
  allocating again during PERST# toggles from the host.

V4:
* Addressed review comments from Bjorn and Manivannan
* Moved dw_pcie_ep_init_complete() inside dw_pcie_ep_init_notify()
* Added .ep_init_late() ops to perform late init tasks

 .../pci/controller/dwc/pcie-designware-ep.c   | 125 +++++++++++-------
 drivers/pci/controller/dwc/pcie-designware.h  |  10 +-
 2 files changed, 80 insertions(+), 55 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 83ddb190292e..f300ea2f7bf7 100644
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
+static int dw_pcie_ep_init_late(struct dw_pcie_ep *ep)
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
 
@@ -658,6 +655,51 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 		return -EIO;
 	}
 
+	dw_pcie_version_detect(pci);
+
+	dw_pcie_iatu_detect(pci);
+
+	if (!ep->ib_window_map) {
+		ep->ib_window_map = devm_bitmap_zalloc(dev, pci->num_ib_windows,
+						       GFP_KERNEL);
+		if (!ep->ib_window_map)
+			return -ENOMEM;
+	}
+
+	if (!ep->ob_window_map) {
+		ep->ob_window_map = devm_bitmap_zalloc(dev, pci->num_ob_windows,
+						       GFP_KERNEL);
+		if (!ep->ob_window_map)
+			return -ENOMEM;
+	}
+
+	if (!ep->outbound_addr) {
+		addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
+				    GFP_KERNEL);
+		if (!addr)
+			return -ENOMEM;
+		ep->outbound_addr = addr;
+	}
+
+	for (func_no = 0; func_no < epc->max_functions; func_no++) {
+
+		ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
+		if (ep_func)
+			continue;
+
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
@@ -676,13 +718,28 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(dw_pcie_ep_init_complete);
+
+int dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
+{
+	struct pci_epc *epc = ep->epc;
+	int ret;
+
+	ret = dw_pcie_ep_init_late(ep);
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
@@ -690,7 +747,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *np = dev->of_node;
 	const struct pci_epc_features *epc_features;
-	struct dw_pcie_ep_func *ep_func;
 
 	INIT_LIST_HEAD(&ep->func_list);
 
@@ -719,26 +775,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
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
 
@@ -755,20 +791,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
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
 
@@ -793,7 +815,14 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 			return 0;
 	}
 
-	ret = dw_pcie_ep_init_complete(ep);
+	/*
+	 * NOTE:- Avoid accessing the hardware (Ex:- DBI space) before this
+	 * step as platforms that implement 'core_init_notifier' feature may
+	 * not have the hardware ready (i.e. core initialized) for access
+	 * (Ex: tegra194). Any hardware access on such platforms result
+	 * in system hard hang.
+	 */
+	ret = dw_pcie_ep_init_late(ep);
 	if (ret)
 		goto err_free_epc_mem;
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 45fcdfc8c035..7252513956b7 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -253,6 +253,7 @@ struct dw_pcie_rp {
 
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

