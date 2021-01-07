Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80EC2ECC34
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jan 2021 10:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbhAGJDg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jan 2021 04:03:36 -0500
Received: from mail-eopbgr00075.outbound.protection.outlook.com ([40.107.0.75]:48622
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726992AbhAGJDe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Jan 2021 04:03:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqVfACrXxsjhnzn8umIG6Mmus+pkR211/m//d7Qk+n/VO3rw25jyhKtcZerojGLjsHWROl+YYPKAZxGSJ+82lA63wld8j1Ihoy/xU8q+DW677LKjf3vNId7cFV9ZsfnbSc/emrfV+SSZizTLrB7z3KNx1t/KDXioMPy6IeZs6vL+cC/p755Cjx20f8V3yxLMMv9yCNbbZZUsK6fpXanMyT9V6zjwz1JEcy3cXdO6ijYIGHCixdHr3Fz5wRwIdun6g2GnSdN+OmHz7/sLBEqadCgev+ac/PscZrXTAYrUL2t7wuiH6oYIXxrSjADxb8Z3DH4zjlK21mUKvJgcNaQGRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njWXmtWIYlqC6XrTHOvke4uyaMFHp9xiOMLNny1pViM=;
 b=RAjfH//xZaa3hZuNEzc2yCG3YXN5Ax+iYZKAcQn1AIOC4sj82e11gRn/NjRzUcwcyxqFRBXfm3nLtYMetgNHmwnMtmdKUCcVTwOYpSIGBL5p1EF7ZvjAfTtQ/VaHhe57K3XZBpbwLT3/0hjfRDwSDE+1BkBLDV7o8ZZN2hywLucV1ZvXlwB1SQmf8EWqc3p1bQDsuUwqjXBQ1jFsgS8RwPas5Kk5ouO8ImUaWm8FUUm1o6rgwNm7RR4pjcNkEnNi2YmM8qApepCsH5L8RNQb+ClVjulNgYaeIHCrkEHVXN1OKs5P9sMtcNAKODlgRe82GA6ICt7oeSl/pV4d8j41Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njWXmtWIYlqC6XrTHOvke4uyaMFHp9xiOMLNny1pViM=;
 b=AB2jHIGx3sQ9DsOFCjd9f+9ylbRrZH3rhJxT+cPq+8nObMiMpuVapM/rh0QJluHyCZ/K4MgBUxjtI1e/CnSxJbkbnEfxPjXalgFKwGjMnIhkeIJoDf5VhLGZxolCRiIBA8pYAnz8omzL6xE0N/pZgMETHlEeG8iNo8tm/G4ZfqI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0402MB2731.eurprd04.prod.outlook.com (2603:10a6:3:d7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Thu, 7 Jan
 2021 09:02:42 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::3194:64d6:5a70:a91d]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::3194:64d6:5a70:a91d%4]) with mapi id 15.20.3721.024; Thu, 7 Jan 2021
 09:02:42 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@axis.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com
Cc:     kishon@ti.com, minghuan.Lian@nxp.com, jesper.nilsson@axis.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        hayashi.kunihiko@socionext.com, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH 1/4] PCI: dwc: Change to use an array to store the structure of functions
Date:   Thu,  7 Jan 2021 17:11:20 +0800
Message-Id: <20210107091123.8616-2-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210107091123.8616-1-Zhiqiang.Hou@nxp.com>
References: <20210107091123.8616-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: SG2PR06CA0085.apcprd06.prod.outlook.com
 (2603:1096:3:14::11) To HE1PR0402MB3371.eurprd04.prod.outlook.com
 (2603:10a6:7:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by SG2PR06CA0085.apcprd06.prod.outlook.com (2603:1096:3:14::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Thu, 7 Jan 2021 09:02:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 288821b6-242d-48ec-9eca-08d8b2eafe14
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2731:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0402MB27315E5206D4937CE5277F4C84AF0@HE1PR0402MB2731.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Zm9cG2xHegqcGL3LztZZCLl4MAutESxNmLPwZW+wnnwJgqwVTVhLRG7yE+aGSpuwoeHxcVZGkvzSAPrLBiA7/hHXZRozp7pCrZysEdvbA4fj3HJUMEJfE9+1skRsXJ14vyS2wMWsYl+T1mbkkcc9nfsaDgqudDPJC5K77PIwyB7Uq171je7ld+BZYe+JqQ52FWoePXWByvXMerOr4XQNuTQYfAXBX9P6ly8q/Nfp46XPluFvY9VjjaFfoTk0nwhS/MlOtmwf3iwjK0FaZFymSXeZBBkoHNJOsqhF5ZlrHD817KSoPtdwhPa8S8uiaGRfhFrEhOAaK8QkiwHwOQkfzlOO7OSghKxueFPlWUhS76jn0p+04yICanpIT36eYa9BZwuCFmVshFNrRzshEMnIo8qbIveCweYDNHlbF2xhGhmlTigXKolyGewqQMtGdfg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(2616005)(66946007)(16526019)(66476007)(66556008)(186003)(52116002)(86362001)(69590400011)(478600001)(956004)(7416002)(2906002)(26005)(8676002)(316002)(6486002)(8936002)(4326008)(6506007)(6666004)(1076003)(83380400001)(5660300002)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?IiWtDNM/C4+hZk+SK/Uk7b8JRuKTse5yMpGPKgVuFy9D4vnwJuxtbWY+Rt+j?=
 =?us-ascii?Q?H3RCUoHKVKQKmvZoQlSuxI2W9Rd29VsjWAhHaSCgoms8sNoBJBBMSyZfD2jM?=
 =?us-ascii?Q?TSi5afLeAcx6Z88aM1QD3ilLS5KIoZXSZ3FyizpA5NQoWgdBLfXXbBs6aw5S?=
 =?us-ascii?Q?nEN2ELtkm/YD9H98/kDIt3lzEmTTPq9LwaSgTS650zAw5B/Mcuv2fu9Fc0l7?=
 =?us-ascii?Q?+twZ5aC161qIkBdlGOGLbOMUthcCGSvAyx/4HIwCi2i24EZu6O5/c84X4cIi?=
 =?us-ascii?Q?6vkZZV9peiAr4mBFEelZpFdrIO32X6XpbEw+6VOOtwE1kpxr7SCk1Y2UjmbI?=
 =?us-ascii?Q?gIszgr27ZvCKfAearYi8swtirOlZGaQsZJwLkbdEYLp41gbIPtKzUHgFpDNd?=
 =?us-ascii?Q?hW2/AWdWet9Q0vlnE4U2RIJPsineFSy9wvGZDL0dDk0VY4+KDe4HiCYsnl+B?=
 =?us-ascii?Q?edSi2UHaRTMHpnZTXZnCEKYlfOAaCYvbZkVUORxeki2NeTynknkPsVc7fMq6?=
 =?us-ascii?Q?PUQUozhcXHPeb8XAxhopuvypOwrwAqPHI+VjSxVECyGnyjWm17h39rSCpnZd?=
 =?us-ascii?Q?vaiQ8n0Z9aPRdBM/ckNnt8Kmf72dKYzDCISkLkgJvMfI6sIDFKaXr3q2Xs8y?=
 =?us-ascii?Q?RSqdMfMfkH8B4DF3bjtLdvFLfsJ45Ek/ne+aLHfKYG0tuY0FDHmc7IoSDLuk?=
 =?us-ascii?Q?JUtadnbzkObTkcTs1+93X9CotxYgYCcy+B83/sIdVHUBjMK1g8Hff5EN5kc+?=
 =?us-ascii?Q?rGM9z5OYvi86twyYgr8hjg4uVHWtQ8i/7JirKEubghjGX4MvTsCvvPVivMDD?=
 =?us-ascii?Q?kRZ4HzXKmf3eAJb+D18viOeayCH768VQ+fKsg7l18wjoh1EGnxkTfn2JjVtm?=
 =?us-ascii?Q?hq2JxtFKejLUWB+EZtYxfo+7Y0EJeiGlv2/4RbsiEnvCCLc8EMVmgh2zmTOc?=
 =?us-ascii?Q?5Zvza/cZiie54lWgxVB+DI02Oqbdt+PuGlhlRyXojjSr43JKIfFHP8sbnHMc?=
 =?us-ascii?Q?ly5b?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2021 09:02:42.6591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: 288821b6-242d-48ec-9eca-08d8b2eafe14
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0shk5+4n2/fOszcTICdk28rxgJL6jk5TyErWiOP8EdFL+2IxmJK94OmBBNgVUdv9AoQ6Yv6zrASK1zQNZJyGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2731
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

As there isn't dynamically adding and deleting a function's structure,
the list_head is not necessary for this case. Array is easier and
more efficient to search.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 33 ++++++++-----------
 drivers/pci/controller/dwc/pcie-designware.h  |  3 +-
 2 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index bcd1cd9ba8c8..e583700b5ba3 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -34,12 +34,8 @@ EXPORT_SYMBOL_GPL(dw_pcie_ep_init_notify);
 struct dw_pcie_ep_func *
 dw_pcie_ep_get_func_from_ep(struct dw_pcie_ep *ep, u8 func_no)
 {
-	struct dw_pcie_ep_func *ep_func;
-
-	list_for_each_entry(ep_func, &ep->func_list, list) {
-		if (ep_func->func_no == func_no)
-			return ep_func;
-	}
+	if (func_no < ep->epc->max_functions)
+		return ep->funcs + func_no;
 
 	return NULL;
 }
@@ -675,9 +671,9 @@ EXPORT_SYMBOL_GPL(dw_pcie_ep_init_complete);
 
 int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 {
+	u8 i;
 	int ret;
 	void *addr;
-	u8 func_no;
 	struct resource *res;
 	struct pci_epc *epc;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -685,9 +681,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *np = dev->of_node;
 	const struct pci_epc_features *epc_features;
-	struct dw_pcie_ep_func *ep_func;
-
-	INIT_LIST_HEAD(&ep->func_list);
+	struct dw_pcie_ep_func *funcs;
 
 	if (!pci->dbi_base) {
 		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
@@ -750,18 +744,19 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	if (ret < 0)
 		epc->max_functions = 1;
 
-	for (func_no = 0; func_no < epc->max_functions; func_no++) {
-		ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
-		if (!ep_func)
-			return -ENOMEM;
+	funcs = devm_kcalloc(dev, epc->max_functions, sizeof(*funcs),
+			     GFP_KERNEL);
+	if (!funcs)
+		return -ENOMEM;
+
+	ep->funcs = funcs;
 
-		ep_func->func_no = func_no;
-		ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
+	for (i = 0; i < epc->max_functions; i++) {
+		funcs[i].func_no = i;
+		funcs[i].msi_cap = dw_pcie_ep_find_capability(ep, i,
 							      PCI_CAP_ID_MSI);
-		ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
+		funcs[i].msix_cap = dw_pcie_ep_find_capability(ep, i,
 							       PCI_CAP_ID_MSIX);
-
-		list_add_tail(&ep_func->list, &ep->func_list);
 	}
 
 	if (ep->ops->ep_init)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 98710bf5ab0e..16d239c4d09b 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -221,7 +221,6 @@ struct dw_pcie_ep_ops {
 };
 
 struct dw_pcie_ep_func {
-	struct list_head	list;
 	u8			func_no;
 	u8			msi_cap;	/* MSI capability offset */
 	u8			msix_cap;	/* MSI-X capability offset */
@@ -229,7 +228,7 @@ struct dw_pcie_ep_func {
 
 struct dw_pcie_ep {
 	struct pci_epc		*epc;
-	struct list_head	func_list;
+	struct dw_pcie_ep_func	*funcs;
 	const struct dw_pcie_ep_ops *ops;
 	phys_addr_t		phys_base;
 	size_t			addr_size;
-- 
2.17.1

