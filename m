Return-Path: <linux-pci+bounces-34289-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C523B2C258
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 13:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 053F71B609B7
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 11:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5474D3375A6;
	Tue, 19 Aug 2025 11:55:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022083.outbound.protection.outlook.com [40.107.75.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48C732C33D;
	Tue, 19 Aug 2025 11:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755604519; cv=fail; b=d8LPrf1t9tio3uZ7vPvDwzkzK2hrxnwyHNVa/TyPOLD1f3Cpti5HU2+s/00O9MAiGlDf0E1FPxZemGgY9LkTbvkjGemVM5d7Vnxvm5XdumKw6/TQ6fxJQbKg3jhplabNq8qoltwgG7Qmcv1gHkcr98qt7yFlXhOybfqnjOnrTzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755604519; c=relaxed/simple;
	bh=xH+h7wR81o76PSY/8akGLfFZ5GI7ckp/sL0Wslo1YXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XBOlLPM31wY8PZqJeSXBlS+3CyxwJuPrKDkwuQ8xijjRAdRJK5fiE4Q4AjR6VFiHFkqnmE1hGaaQ6xNjQEd9alzeud8Ts3K4dXbIn+SIbPQQCAfuVhBEfCePMdlXZtIfdXHy7q8J7OtSYHqI9tzfEZJRJfVADvWJdRrfHu2K5mU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufEo3mvcwNeTtVOawfANw/3eONpiFcgWko1fXYexcsx0ihAY2SqiCoG75fxxHBSd3PM+PkBRxJzGyGE2SR1JDd+QIaLWDIZ4jB+S2f+OW/SBVnWlbF+IgaK5x82+iLBbeeEsaC8DBNrK6wdXBk5bt+kMfJOX3Lxoov10LiGOazcuWqK7VqpLdJ0FO8G1TjchVzLUd3PyCBE5VyP8IcyjL0W916hupWnKBX1Mz2CB1K+ZMB01zQStuh78LxcoGZOSbHc7HAI+dZIpkgYM8T6N8fv9pOSFpvzU0iv2AxOWvwJScncnL7A6lzARlE2h1ohOMYNg/ZOHGNl+KkGFrgWJkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoM/4edsix7/iCnDKeon+dl5r0KhsE4oO0PbbhIr2Gc=;
 b=cPRdEpvBGx86r8hz2SgeTwldK89vIkmYPlVDn5MYpycflk1rwSm6amyujk5BEoPeKszNNafaquQtB7wJkj5JG9XWm4veiQ+bsBB/n+SElnV3PToMvCfoGR1QHHXjY5vP6L1W9Muf87s0TqD/lnQVA+eGfeOl/PFFGStLKa4Pn2jg8h6zb/UNNffZgKwW3bC6XY3rP+A3cJQ3qe3aFWXg0hQLnqFNiiw5peIxeN08noYLEJpdjWkAdV2ZXoYYcN5HEE6/X4PYQy6tEmDLcrDM4r5TynZBrEEUvHajnNeBRLXMQY4VNaoFuagUGsNah6Gkq0txSTSLQBUr7y9E7CoHCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCPR01CA0173.jpnprd01.prod.outlook.com (2603:1096:400:2b2::11)
 by KL1PR06MB7085.apcprd06.prod.outlook.com (2603:1096:820:120::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 11:55:11 +0000
Received: from TY2PEPF0000AB89.apcprd03.prod.outlook.com
 (2603:1096:400:2b2:cafe::18) by TYCPR01CA0173.outlook.office365.com
 (2603:1096:400:2b2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.13 via Frontend Transport; Tue,
 19 Aug 2025 11:55:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB89.mail.protection.outlook.com (10.167.253.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 11:55:10 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id A844541604EB;
	Tue, 19 Aug 2025 19:55:09 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	mani@kernel.org,
	robh@kernel.org,
	kwilczynski@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: mpillai@cadence.com,
	fugang.duan@cixtech.com,
	guoyin.chen@cixtech.com,
	peter.chen@cixtech.com,
	cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <hans.zhang@cixtech.com>
Subject: [PATCH v8 07/15] PCI: cadence: Move PCIe controller common functions as a separate file
Date: Tue, 19 Aug 2025 19:52:31 +0800
Message-ID: <20250819115239.4170604-8-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250819115239.4170604-1-hans.zhang@cixtech.com>
References: <20250819115239.4170604-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB89:EE_|KL1PR06MB7085:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ee36fc53-3297-4cda-16fb-08dddf174001
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MY31c29aJfOYjEK+7sk5pD+liWD8/MvFQbLD7a97t2SYBykAD9TJRxn95bFf?=
 =?us-ascii?Q?+7yTZnNe6Qxngct1n52KFoCrEU7W+UY5XRIGq8AcnG03V73rmV3VJBOhu72K?=
 =?us-ascii?Q?tptCy3MrwmihjttFKfBK3KM3GDroDrU5vXwKGnQ3ejl//lsUjsH6/pcMl+MW?=
 =?us-ascii?Q?MLlNOvcAfy2paG5hcFuW526x5tV3xksSEoxyK0gRbUMqud6AMtKK9hpe+gLn?=
 =?us-ascii?Q?P2sjK9AoEE5V/3ryvrr8xonfeC2XZRg/x2xL7IOOMbHlhVKLXtCE3e5B+6lH?=
 =?us-ascii?Q?ltsQRLzJBaM7Yth3sEYsWWDMgwH1WYZkXEQzw6xBhPj/E0NOPch/gg8wiUZi?=
 =?us-ascii?Q?T7P3m4EGLTc8kh+y2KCeJcK2uM6gaezmIl9nLXnUdpWQLrfk/fwt6Koq+dGa?=
 =?us-ascii?Q?HQ0waab9nZmXW9CdDSIwQDse/FX8LFBSCl4pzpmHJWrInXV19AP1uhYwRopr?=
 =?us-ascii?Q?OMjPW35cfyij0zU+xjuBJenrMknEXJxtvFpdkDYTHfXlwZN9Ka0+hNyyVdAI?=
 =?us-ascii?Q?33l8/OIX9UM2NvI45Gu5ckjSvknpzbz8IMdqJD/ih6aIeTCwLRz5Am9K8pBi?=
 =?us-ascii?Q?yU25yZqKFRG+UEAxjMtsHb4TFsOaBU0BpUTT/ARNSWbmTa+3uM5Fx/6ejT71?=
 =?us-ascii?Q?z4rLqBDLpvSpkIqHXpnYlhaB4guM0QAcrPBiB2tTT8MR+ymp5liKNyp7CDRB?=
 =?us-ascii?Q?qcycCUjGZNLNk58xu0lhj6b6i/0FhqE/vRCY2lCl1/8hQG2KJ+HqWrbvcXgt?=
 =?us-ascii?Q?IdSPmcpBShPEKDptb19mHoGUzgOwRb//K8ZfuW+Rk39Du5LhdxTLG2MQVyj3?=
 =?us-ascii?Q?UxmfyEEzACyB+mJ9gHIpyvcjUS05gq4O4ELxhjOWDlge6MMnt4LQbUovVr8k?=
 =?us-ascii?Q?xbUy3vsTh1ua8B5o2eP1v4VmEGwvTjsWH/Mqp9FkY9MV6q3YK++DTkgb7UU8?=
 =?us-ascii?Q?M7CMBS0++xtnSOOx2rC1eb3jE06Tv7EHhQjoLtiQmnpFmJzyfRdQcswM7ObO?=
 =?us-ascii?Q?iG/AskJs7FtGnwJlneMqftqsTEt87gPdf4B3rMqmMcBk9H6ePmWwBvzZmA3p?=
 =?us-ascii?Q?/1ZzG9nHVFzknrjO++Jd3AB7XErJxGRDKwhO22p5VoD6XpiAXLtkIZAceuKC?=
 =?us-ascii?Q?Jmgva7z6fXGKq5XZec1+eFtIjTYgHeOWBRBHWLhddfPR2e9Ve0T+EEq1PhfI?=
 =?us-ascii?Q?HbPanhXukGulLxVsUVYTeaYKr0gXdJhmOz0xumH5WYF30620Fx2bfN2a9Mf0?=
 =?us-ascii?Q?i6013M61l8cdZvcjLlvb1zQlWZhN4sWNhAOM/+ny+mPhAjpp5M3+D/1Db59/?=
 =?us-ascii?Q?9RG8QhbERFcok6hplRdgbGQB6ByoquLHWU8ly/bfbXfGJ0VlAiF1WEar86rW?=
 =?us-ascii?Q?xqxMsIVwYph2PjId7/M9oeo9v8B+KXUIuQf3aKrXJYzRObMCXG1TMbTl9570?=
 =?us-ascii?Q?VZ92WNvh7F0pqFVsXApjh0g43+FD32G4tUhNILwbSyyj+1CnEk9uU/85y/sv?=
 =?us-ascii?Q?HN/F5jTB9YTQvdcZfyXg7Nf8aGEZzjmLvx+v?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 11:55:10.5250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee36fc53-3297-4cda-16fb-08dddf174001
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB89.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7085

From: Manikandan K Pillai <mpillai@cadence.com>

Move the functions for platform common tasks to a separate file. The
common library functions and functions specific to platform are
now in different files.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
Co-developed-by: Hans Zhang <hans.zhang@cixtech.com>
Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 drivers/pci/controller/cadence/Makefile       |   2 +-
 .../controller/cadence/pcie-cadence-common.c  | 141 ++++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.c | 129 ----------------
 3 files changed, 142 insertions(+), 130 deletions(-)
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-common.c

diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
index e45f72388bbb..b104562fb86a 100644
--- a/drivers/pci/controller/cadence/Makefile
+++ b/drivers/pci/controller/cadence/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence.o
+obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence-common.o pcie-cadence.o
 obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host-common.o pcie-cadence-host.o
 obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep-common.o pcie-cadence-ep.o
 obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
diff --git a/drivers/pci/controller/cadence/pcie-cadence-common.c b/drivers/pci/controller/cadence/pcie-cadence-common.c
new file mode 100644
index 000000000000..e14d53d64bf1
--- /dev/null
+++ b/drivers/pci/controller/cadence/pcie-cadence-common.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2017 Cadence
+// Cadence PCIe controller driver.
+// Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
+
+#include <linux/kernel.h>
+#include <linux/of.h>
+
+#include "pcie-cadence.h"
+
+void cdns_pcie_disable_phy(struct cdns_pcie *pcie)
+{
+	int i = pcie->phy_count;
+
+	while (i--) {
+		phy_power_off(pcie->phy[i]);
+		phy_exit(pcie->phy[i]);
+	}
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_disable_phy);
+
+int cdns_pcie_enable_phy(struct cdns_pcie *pcie)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < pcie->phy_count; i++) {
+		ret = phy_init(pcie->phy[i]);
+		if (ret < 0)
+			goto err_phy;
+
+		ret = phy_power_on(pcie->phy[i]);
+		if (ret < 0) {
+			phy_exit(pcie->phy[i]);
+			goto err_phy;
+		}
+	}
+
+	return 0;
+
+err_phy:
+	while (--i >= 0) {
+		phy_power_off(pcie->phy[i]);
+		phy_exit(pcie->phy[i]);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_enable_phy);
+
+int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
+{
+	struct device_node *np = dev->of_node;
+	int phy_count;
+	struct phy **phy;
+	struct device_link **link;
+	int i;
+	int ret;
+	const char *name;
+
+	phy_count = of_property_count_strings(np, "phy-names");
+	if (phy_count < 1) {
+		dev_info(dev, "no \"phy-names\" property found; PHY will not be initialized\n");
+		pcie->phy_count = 0;
+		return 0;
+	}
+
+	phy = devm_kcalloc(dev, phy_count, sizeof(*phy), GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+
+	link = devm_kcalloc(dev, phy_count, sizeof(*link), GFP_KERNEL);
+	if (!link)
+		return -ENOMEM;
+
+	for (i = 0; i < phy_count; i++) {
+		of_property_read_string_index(np, "phy-names", i, &name);
+		phy[i] = devm_phy_get(dev, name);
+		if (IS_ERR(phy[i])) {
+			ret = PTR_ERR(phy[i]);
+			goto err_phy;
+		}
+		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
+		if (!link[i]) {
+			devm_phy_put(dev, phy[i]);
+			ret = -EINVAL;
+			goto err_phy;
+		}
+	}
+
+	pcie->phy_count = phy_count;
+	pcie->phy = phy;
+	pcie->link = link;
+
+	ret =  cdns_pcie_enable_phy(pcie);
+	if (ret)
+		goto err_phy;
+
+	return 0;
+
+err_phy:
+	while (--i >= 0) {
+		device_link_del(link[i]);
+		devm_phy_put(dev, phy[i]);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_init_phy);
+
+static int cdns_pcie_suspend_noirq(struct device *dev)
+{
+	struct cdns_pcie *pcie = dev_get_drvdata(dev);
+
+	cdns_pcie_disable_phy(pcie);
+
+	return 0;
+}
+
+static int cdns_pcie_resume_noirq(struct device *dev)
+{
+	struct cdns_pcie *pcie = dev_get_drvdata(dev);
+	int ret;
+
+	ret = cdns_pcie_enable_phy(pcie);
+	if (ret) {
+		dev_err(dev, "failed to enable PHY\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+const struct dev_pm_ops cdns_pcie_pm_ops = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(cdns_pcie_suspend_noirq,
+				  cdns_pcie_resume_noirq)
+};
+EXPORT_SYMBOL_GPL(cdns_pcie_pm_ops);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Cadence PCIe controller driver");
diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index 5603f214f4c7..51c9bc4eb174 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -152,135 +152,6 @@ void cdns_pcie_reset_outbound_region(struct cdns_pcie *pcie, u32 r)
 }
 EXPORT_SYMBOL_GPL(cdns_pcie_reset_outbound_region);
 
-void cdns_pcie_disable_phy(struct cdns_pcie *pcie)
-{
-	int i = pcie->phy_count;
-
-	while (i--) {
-		phy_power_off(pcie->phy[i]);
-		phy_exit(pcie->phy[i]);
-	}
-}
-EXPORT_SYMBOL_GPL(cdns_pcie_disable_phy);
-
-int cdns_pcie_enable_phy(struct cdns_pcie *pcie)
-{
-	int ret;
-	int i;
-
-	for (i = 0; i < pcie->phy_count; i++) {
-		ret = phy_init(pcie->phy[i]);
-		if (ret < 0)
-			goto err_phy;
-
-		ret = phy_power_on(pcie->phy[i]);
-		if (ret < 0) {
-			phy_exit(pcie->phy[i]);
-			goto err_phy;
-		}
-	}
-
-	return 0;
-
-err_phy:
-	while (--i >= 0) {
-		phy_power_off(pcie->phy[i]);
-		phy_exit(pcie->phy[i]);
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(cdns_pcie_enable_phy);
-
-int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
-{
-	struct device_node *np = dev->of_node;
-	int phy_count;
-	struct phy **phy;
-	struct device_link **link;
-	int i;
-	int ret;
-	const char *name;
-
-	phy_count = of_property_count_strings(np, "phy-names");
-	if (phy_count < 1) {
-		dev_info(dev, "no \"phy-names\" property found; PHY will not be initialized\n");
-		pcie->phy_count = 0;
-		return 0;
-	}
-
-	phy = devm_kcalloc(dev, phy_count, sizeof(*phy), GFP_KERNEL);
-	if (!phy)
-		return -ENOMEM;
-
-	link = devm_kcalloc(dev, phy_count, sizeof(*link), GFP_KERNEL);
-	if (!link)
-		return -ENOMEM;
-
-	for (i = 0; i < phy_count; i++) {
-		of_property_read_string_index(np, "phy-names", i, &name);
-		phy[i] = devm_phy_get(dev, name);
-		if (IS_ERR(phy[i])) {
-			ret = PTR_ERR(phy[i]);
-			goto err_phy;
-		}
-		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
-		if (!link[i]) {
-			devm_phy_put(dev, phy[i]);
-			ret = -EINVAL;
-			goto err_phy;
-		}
-	}
-
-	pcie->phy_count = phy_count;
-	pcie->phy = phy;
-	pcie->link = link;
-
-	ret =  cdns_pcie_enable_phy(pcie);
-	if (ret)
-		goto err_phy;
-
-	return 0;
-
-err_phy:
-	while (--i >= 0) {
-		device_link_del(link[i]);
-		devm_phy_put(dev, phy[i]);
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(cdns_pcie_init_phy);
-
-static int cdns_pcie_suspend_noirq(struct device *dev)
-{
-	struct cdns_pcie *pcie = dev_get_drvdata(dev);
-
-	cdns_pcie_disable_phy(pcie);
-
-	return 0;
-}
-
-static int cdns_pcie_resume_noirq(struct device *dev)
-{
-	struct cdns_pcie *pcie = dev_get_drvdata(dev);
-	int ret;
-
-	ret = cdns_pcie_enable_phy(pcie);
-	if (ret) {
-		dev_err(dev, "failed to enable PHY\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-const struct dev_pm_ops cdns_pcie_pm_ops = {
-	NOIRQ_SYSTEM_SLEEP_PM_OPS(cdns_pcie_suspend_noirq,
-				  cdns_pcie_resume_noirq)
-};
-EXPORT_SYMBOL_GPL(cdns_pcie_pm_ops);
-
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Cadence PCIe controller driver");
 MODULE_AUTHOR("Cyrille Pitchen <cyrille.pitchen@free-electrons.com>");
-- 
2.49.0


