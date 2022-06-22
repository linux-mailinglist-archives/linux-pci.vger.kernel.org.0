Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E3055411B
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jun 2022 06:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356471AbiFVEBq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jun 2022 00:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356174AbiFVEBp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jun 2022 00:01:45 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B6E33EB7;
        Tue, 21 Jun 2022 21:01:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1TTTB/51fBH6zuGkp+p53V0bcNaqstHn3xmhhhuQPOKn5aeD0okrc75JO19Pa4/NywG2GKLPmyzZNZQ1wYUxwY1cSYpe5jaqeSU/9vpM34zD+t6Urqkv9orEatEXuFn5CjWXWTILloJE2vepqQn0cBqBPdNwQD8lcJYedkY5ZD+yEOqY77zWOZjEudGdNxzWGtaEtGqI7ZWUkdmmnj2nVFS1Obh87gZLToI3bVO6Hs+JyBsTiMAR3dQzN9gK3kijLy3QJsUDr8IQqMBajNl1jz8iltFL2Ma77FZ9fErlBDvZIpTaT93AIL/Quo9+j2Vtp41UbAyfnCeqwc3mJKGzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLXxJHdnZ5UKv5LpKGNOGKZBq9l1QBQ+oguMRw3JgwM=;
 b=Ym9MSPgwplDHFxNvVvfdYEb68TQCsPn5J/9+FvVsv3t32tN3nMb5eMXNZamiadDfK/6ZeFjnG3TtBGXD+YlGTifnWgRXDmMt2LvKQi2DKd1cRjJ2qRJL4TXBpqwVWsM5JImr0PRXF6Ja74Ojx1cOgL2Mx8HwI6tR1RaBom2TWvO/y046o+iY1YzYFGXXdWyEeqYvD6Aj9zlFLdXSdxTYPKTdao+n/5RKEMdmlvESrW0E+V+2ZcpAaB2pQyD3AlUkk9b6hEJhmWGKe1izU9qKFf28+9K1240GH7iK7CRXY2lrgpMIvAFAreKvoyDpSMjWxdID3VcnvSmwRwgdFtoACg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLXxJHdnZ5UKv5LpKGNOGKZBq9l1QBQ+oguMRw3JgwM=;
 b=YPyKKKgCekD6BjBvmexmHHYdTM2qVrbh3a22ATxPt3uCKD9uFJr6nzLwMbYve3quJyNmFl9xkq+FodSPZ7b1mLoNE5nQ4viPekvOz7YMJDunJgIcL7l8X1h31vlTq0i4sPWlYw7mZ++ZZDumzjcdIDF/wS+BlvD9F9+uDgJS19LwI35ga9TcuXIwbRPe9rY9jwrnW3OExDJunfsaGBovniwH3p0fJv0syxkC8yafzxRh7x1633rWqgXgqvQRL+T+N+LaIWyhAZSnKrcqFxMRx/hM4MJs1Mn5EniyMaAedKsNa/eJTUI/bfYn83Q43bx4wsW9C+mfy/fAYVYjrRaYIA==
Received: from BN8PR15CA0002.namprd15.prod.outlook.com (2603:10b6:408:c0::15)
 by CY5PR12MB6526.namprd12.prod.outlook.com (2603:10b6:930:31::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Wed, 22 Jun
 2022 04:01:42 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::a2) by BN8PR15CA0002.outlook.office365.com
 (2603:10b6:408:c0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22 via Frontend
 Transport; Wed, 22 Jun 2022 04:01:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5373.15 via Frontend Transport; Wed, 22 Jun 2022 04:01:41 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 22 Jun
 2022 04:01:41 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 21 Jun
 2022 21:01:40 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Tue, 21 Jun 2022 21:01:37 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V1] PCI: designware-ep: Fix DBI access before core init
Date:   Wed, 22 Jun 2022 09:31:33 +0530
Message-ID: <20220622040133.31058-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa864e8d-7be9-4714-4bf5-08da5403ea76
X-MS-TrafficTypeDiagnostic: CY5PR12MB6526:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB6526814608D1015CEA5290B0B8B29@CY5PR12MB6526.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gYHVDsv4vKog1BB+5kouoOj+0Cz2E9ZdrK67IFHAZNyNJetCs25B/4n2a+pgEKeCSXw8oAz9bXlTIikzxMmIbimqNsI8V12dwravGtwGZf6HW7OEFk8UGcwSImS6CSjAn1g529GjKRLpBXGyPhMznHiv9fuyFHiLEFW2mrKjkR5kyZ63S4+z2p9qlZ6D//7iU2VMmbw5xVp8RlN7+n2myOHx48kCDlnvAm6gXKD7Ldwgi2vxNbqiwUC1jO+Z4dSEFpwnpOhVEsM5ZQYfjSFO9ZAvQ5JUlA+xkfiQ+m/Vq227xhQ1dcjQVUF8BO+Mpw/G8gsVRH2QalSmnHyK13Sai59tt1M+LSUqtQK0oNYHstL8zWGzFyR3CIOM7NEUYnurUV4NKZgfvJWH1tcEK9m2rSXs6eNOfI8DqY093m+/s9P2yjt04pKfeZ8k/lbqf4YeTl+FF7LZNPfo18S6uxNF3nDnqyh9xhMSBRcp9NJjkGmdrPQOX81Fi8u3Ua62LfDdccXYru0D/NbBa9w8Z9RKQuzhF4me38f64Nma9bf9ZkLXjJu+G6umFyJTmYlXxHE2J2EL79flEw0WXDjnTdsLfh7Q/3anOhyWCqPIqnrRgaS12zvEHq5pygHKO+OAA/HYHux4WoP7bDekLSZUdUfzzFYWyR+Pw8zvgTbmold99azRjsSj7TuD+a/wn3F/N7a/6DEyuEGPrOXSqP8spBx85MqAfKKI5ze1uTc8pf0BvJT9qfBq4L81xQ+2yN5yEcoV
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(376002)(136003)(39860400002)(46966006)(40470700004)(36840700001)(82310400005)(40480700001)(4326008)(36756003)(8676002)(70586007)(40460700003)(316002)(5660300002)(7696005)(8936002)(70206006)(6666004)(2906002)(86362001)(83380400001)(186003)(478600001)(41300700001)(110136005)(2616005)(54906003)(47076005)(36860700001)(356005)(336012)(1076003)(426003)(26005)(82740400003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 04:01:41.9884
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa864e8d-7be9-4714-4bf5-08da5403ea76
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6526
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Platforms that cannot support their core initialization without the
reference clock from the host, implement the feature 'core_init_notifier'
to indicate the DesignWare sub-system about when their core is getting
initialized. Any accesses to the core (Ex:- DBI) would result in system
hang in such systems (Ex:- tegra194). This patch moves any access to the
core to dw_pcie_ep_init_complete() API which is effectively called only
after the core initialization.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 88 +++++++++++--------
 1 file changed, 49 insertions(+), 39 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 0eda8236c125..9feec720175f 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -639,9 +639,14 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
 int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
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
 
@@ -654,6 +659,42 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 		return -EIO;
 	}
 
+	dw_pcie_iatu_detect(pci);
+
+	ep->ib_window_map = devm_kcalloc(dev,
+					 BITS_TO_LONGS(pci->num_ib_windows),
+					 sizeof(long),
+					 GFP_KERNEL);
+	if (!ep->ib_window_map)
+		return -ENOMEM;
+
+	ep->ob_window_map = devm_kcalloc(dev,
+					 BITS_TO_LONGS(pci->num_ob_windows),
+					 sizeof(long),
+					 GFP_KERNEL);
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
@@ -677,8 +718,6 @@ EXPORT_SYMBOL_GPL(dw_pcie_ep_init_complete);
 int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 {
 	int ret;
-	void *addr;
-	u8 func_no;
 	struct resource *res;
 	struct pci_epc *epc;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -686,7 +725,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *np = dev->of_node;
 	const struct pci_epc_features *epc_features;
-	struct dw_pcie_ep_func *ep_func;
 
 	INIT_LIST_HEAD(&ep->func_list);
 
@@ -708,8 +746,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		}
 	}
 
-	dw_pcie_iatu_detect(pci);
-
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
 	if (!res)
 		return -EINVAL;
@@ -717,26 +753,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	ep->phys_base = res->start;
 	ep->addr_size = resource_size(res);
 
-	ep->ib_window_map = devm_kcalloc(dev,
-					 BITS_TO_LONGS(pci->num_ib_windows),
-					 sizeof(long),
-					 GFP_KERNEL);
-	if (!ep->ib_window_map)
-		return -ENOMEM;
-
-	ep->ob_window_map = devm_kcalloc(dev,
-					 BITS_TO_LONGS(pci->num_ob_windows),
-					 sizeof(long),
-					 GFP_KERNEL);
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
 
@@ -753,20 +769,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
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
 
@@ -790,6 +792,14 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 			return 0;
 	}
 
+	/*
+	 * NOTE:- Avoid accessing the hardware (Ex:- DBI space) before this
+	 * step as platforms that implement 'core_init_notifier' feature may
+	 * not have the hardware ready (i.e. core initialized) for access
+	 * (Ex: tegra194). Any hardware access on such platforms result
+	 * in system hard hang.
+	 */
+
 	return dw_pcie_ep_init_complete(ep);
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_init);
-- 
2.17.1

