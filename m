Return-Path: <linux-pci+bounces-31037-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE79AED343
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 06:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 886661895290
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 04:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9827F1C5D57;
	Mon, 30 Jun 2025 04:16:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023099.outbound.protection.outlook.com [40.107.44.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0B319E82A;
	Mon, 30 Jun 2025 04:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751256976; cv=fail; b=pW/hbEBq0VicRktnbIYCNtw/tLe60+C0A4JJKVm+OERQcwn2yQkihHXj/F7TrD7O15hr5gA03Sccl2jZ9WyEilKHjjZLfjrchPyn3FlnuijgLCXBYzmt1BHGR33PHQuHtMqJfpfR9isEbIy1EcE3sh46Amq2N1fPQ8eKO3/7ByQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751256976; c=relaxed/simple;
	bh=3HRMirO8+2Yo+p+441IfIarcAAn0pfwDl0zWoW8ZYCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IUmVbwmdpVkYeGCfrrpEuietFtM6l926b+T35partDBU+Y3xWkyoENbOpV1+EeNJxu+CWGXeWzNFdneMJgk5jRGyC+7JKjWVQm4GqSVEMLOSt3TkWtzw9AT37nz+RvAwiptS3LQ10yaPOHjm9I9LmhlDA+KrKAPY+sxpEECbvk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mkoXeSQAiyfGEa9O1H0C2PV9dDIfv2NXJjx3KkGMvdjCM7VB5aAycbkhq5mxmO9LeJOyQSwcnnRi8kufERpBVYdDT/IDn0gd+zOM9Zi3rfcMEmYdpMMllvMsEa6mPHvgq2jD3qZ5T4emQnDyCX3DDpP0qjHzOvGhTKXPxdqSVFtzRRE3IU/a86BMhYiXCdhTPfEz9Wz+5r0kw2OtDToFQyKADL34TqhL9RnAULLRUUinsJ0LLlBwIUHS3XkCH7thtIhQgLcTBdInGj146Jy3RL4UMV0epiev4lixN4R4dDGXX/ug9aOWTbJ3LkU9sIYHESqEtwHzVaQc8kU4SkeniA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ooiFDlD623JzLpXoNEyZr+Tf1dhciIYz11nD+77SAJY=;
 b=rCRtJqljPg6/n10ElaFZbEHbFm8rd6XZlSKypDzt/7l4bsUVM28oijH6EzTKZhhNw37WMKEE8OeIFUu7TLM1CnNmZVXe7hk1OLqcf+HoX7C1DYPlZo8J6CJq9aHcMwimJeFhKoFt7qY+N8yQPW6ErPgX6dqdmFMSzlRS454UmcP1pwwlRt/pDvPo8Kc8x/Tm+xymVJiqWk3E9apuNbymCXyiNc704pX1hxeuzVzu1zAhKDNR6AtRbv84O9soc5UqnwTmGnRyDSTSWOLdAoRfVMogUxUItf7GdBg4YOs/UEhRKgDk+8D2ZnQMjyEf924dhCIaH5jfyUF3MWfRvLrZRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2P153CA0003.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::20) by
 JH0PR06MB7268.apcprd06.prod.outlook.com (2603:1096:990:96::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.25; Mon, 30 Jun 2025 04:16:09 +0000
Received: from SG2PEPF000B66D0.apcprd03.prod.outlook.com
 (2603:1096:4:140:cafe::ff) by SI2P153CA0003.outlook.office365.com
 (2603:1096:4:140::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.6 via Frontend Transport; Mon,
 30 Jun 2025 04:16:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66D0.mail.protection.outlook.com (10.167.240.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 04:16:09 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id B0DFA41604F2;
	Mon, 30 Jun 2025 12:16:06 +0800 (CST)
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
Subject: [PATCH v5 07/14] PCI: cadence: Split the common functions for PCIE controller support
Date: Mon, 30 Jun 2025 12:15:54 +0800
Message-ID: <20250630041601.399921-8-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630041601.399921-1-hans.zhang@cixtech.com>
References: <20250630041601.399921-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66D0:EE_|JH0PR06MB7268:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6e12ee99-e2a1-401c-065e-08ddb78cd7b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r0G42MHP+BXv01Q3uot8fojNBh64B9VywpwSKIxW8yy/J8mYgsYKJez0O5Xk?=
 =?us-ascii?Q?h6QHdPHNz62gFePW0fg5MhAR4Nw3N2gbwqBMVmSG3hc97pcPj6T3qLkbWNAM?=
 =?us-ascii?Q?Ikc0FMOh9f424h2ZKgsVebiPjn2SzQCHtn5oaTNpoaYG5SvAKeCrW/UMMGUm?=
 =?us-ascii?Q?X7QHekxPqIEoOGWf1g3ihkgFxeizTG6xfX8e23ya40Ls4kCMAlnj86rgoISJ?=
 =?us-ascii?Q?EMLGsOnVxZhcnN/WwKZAAtDPaCqwTvsEV0Dd2lILXD9jVVeRtLSPzYn1rZmu?=
 =?us-ascii?Q?5U3Q5Dvjqpg7phBEMGkjzXNe6trMMfE0JVg73+zjHvBUjx6nNOxyBW5AqY/M?=
 =?us-ascii?Q?1n1hMEm2m3EegyTvJsoS5ijseCOxDlgaBdjf/zgmYwtTcTyHYmIoeEabZVIQ?=
 =?us-ascii?Q?+2WcLxPCE7ZTySas8KEkifnx/Q5tzyU9VlFQJUxebvLPkMlU34XEpzfm4T36?=
 =?us-ascii?Q?KmEjv9J33lWGm9IxtZ6T7tk3dVOL09C8RB9xNwNPxnBet33VPQiY/kaWYVcC?=
 =?us-ascii?Q?+nqIydp/ZgRw4ts7Wvo4K9Z6o1GKSAx0LULt4LROxW7KZAwkZd2VG8uSmmjz?=
 =?us-ascii?Q?mTry+pR2RqOANz2N530okmV7eE3LwGwIoG4/Fb/BiuwUwoinqPyVr2pqLyoA?=
 =?us-ascii?Q?U80S1j1fQDkqt20+MqPiJYBrq8X7YXh7ojxc8IRxCQZK1s7IScukAe5fgKaI?=
 =?us-ascii?Q?CN3PNGfpUPlf9AUEJQEEsvrtFTLPWsAPWBHrkeRTBMHAiVUFmM7ZOittt9sp?=
 =?us-ascii?Q?81XO716RsxUWsQLqYx0dqxW6k/xEJMShTLIUksDgJhre5Sli+HG5iNK/qyj5?=
 =?us-ascii?Q?CDkzeF7SBbn3Dm1UzKbVrlLptWnwe6N7e82V4VpnkXIZvmRZdKIBCBY2mox9?=
 =?us-ascii?Q?fW5G8EPm4gk7QFErINdw4k1yvS85xxtZ8A80l0ZsFr1wFGEVfkMwlC3ovU2U?=
 =?us-ascii?Q?K3vmUWdJ3DZazSvesnvP6/p2bQQXPI2yXLyopdJh+f0+piKxtloru4CD8IL8?=
 =?us-ascii?Q?OoU8PDAiB0ncsmiFfvqh8Yi/zX6I2JeK2Dh+cHheH0a8ORUV1nR3h2Z97Q7U?=
 =?us-ascii?Q?8SNyUcGvmJlLHGnK/ONbI0PMkv4pjKZG0DvWyTk01N5QVn0dCWYBjODU1bFD?=
 =?us-ascii?Q?N1dXWhhcNtUAtNMKfw52Igm+SRmHRIUaCi7e9G9uCT/1CvlDCw6oZlci8lS5?=
 =?us-ascii?Q?Si3ALlU1GbBgCq5Vk/RYY0Kgi9nnjXaB8wLj+Zloa9NnQb7UbjUIKI/x2lkP?=
 =?us-ascii?Q?lhYv8tiDC1EikSdkYKELxl96A3nmHnrXCyzRYwwvX5IhBQjF6vr9B6iYU7xP?=
 =?us-ascii?Q?H1+BNTA3XRct8xQj0iAZKrJBkp7F6GN/Oee8199myxOygpIhVlh5iF5M3Z0D?=
 =?us-ascii?Q?38f3KE9848VGqkkgkUu6SCHgufRojjLDi7DK9EpNOVJRUKDfvRw18E/uysiT?=
 =?us-ascii?Q?gEZ0IZPuWlV1xZPNq4darMYpfqjSa/gfisso/sjXqaB5/pw1jnMER2Bt7iRu?=
 =?us-ascii?Q?P7k24XbQ6ByBQBylFsVDmYw6hIFUXSeuwSFn?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 04:16:09.6011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e12ee99-e2a1-401c-065e-08ddb78cd7b7
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66D0.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7268

From: Manikandan K Pillai <mpillai@cadence.com>

Separate the functions to platform specific functions and common
library functions.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
Co-developed-by: Hans Zhang <hans.zhang@cixtech.com>
Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 drivers/pci/controller/cadence/Makefile       |   2 +-
 .../controller/cadence/pcie-cadence-common.c  | 134 ++++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.c | 128 -----------------
 3 files changed, 135 insertions(+), 129 deletions(-)
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-common.c

diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
index 0440ac6aba5d..3fe5dd2bbd5b 100644
--- a/drivers/pci/controller/cadence/Makefile
+++ b/drivers/pci/controller/cadence/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence.o
+obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence-common.o pcie-cadence.o
 obj-$(CONFIG_PCIE_CADENCE_EP_COMMON) += pcie-cadence-ep-common.o
 obj-$(CONFIG_PCIE_CADENCE_HOST_COMMON) += pcie-cadence-host-common.o
 obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
diff --git a/drivers/pci/controller/cadence/pcie-cadence-common.c b/drivers/pci/controller/cadence/pcie-cadence-common.c
new file mode 100644
index 000000000000..8399a73b3a4d
--- /dev/null
+++ b/drivers/pci/controller/cadence/pcie-cadence-common.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2017 Cadence
+// Cadence PCIe controller driver.
+// Author: Manikandan K Pillai <mpillai@cadence.com>
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
diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index 70a19573440e..51c9bc4eb174 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -152,134 +152,6 @@ void cdns_pcie_reset_outbound_region(struct cdns_pcie *pcie, u32 r)
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
-
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Cadence PCIe controller driver");
 MODULE_AUTHOR("Cyrille Pitchen <cyrille.pitchen@free-electrons.com>");
-- 
2.49.0


