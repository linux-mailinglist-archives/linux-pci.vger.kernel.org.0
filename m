Return-Path: <linux-pci+bounces-33611-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16511B1E397
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 09:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9172E16C5E6
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 07:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFC7275845;
	Fri,  8 Aug 2025 07:29:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023106.outbound.protection.outlook.com [52.101.127.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A918D25229D;
	Fri,  8 Aug 2025 07:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754638186; cv=fail; b=LUmxtxvut4aSIMl+nkJ8kB3Q1vNASxLIyVPxyHCjcIypesu0YKzAWV1ct0zsFsYHp+a2bcl4mvPUdesX2i2Pyom0UcfgyjqYLlWwcUlux8YoiW0PHY93nudyTzNBzk0Mlwsj1rcXxseify7JkXO6t4v8/mZ3NvVTUNnU/w5urlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754638186; c=relaxed/simple;
	bh=7BELHzqkhXvAQNh69pfQa8evyvK+gemxPF41GgRNJ+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a5O90m23GCcJtQEGIM3rmhSLzrFjKDhnEKU4UpPaLkDZW95pdwHlk1e5YGOHpTHib+4cFd/bKD5r6ShGc9Gw2Dxn56ryjjgHft2nnMUz8oXgc7cgPnBqttQP0BEHj+5qn2A/+c9xz/TGZrvwm6Wh5KisAOaNb9d/ALujwgA3Z5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHYvNdpBJZmUEiUZgwBvjH/n+jx90O5WGvxkvSx4r5O1uQRQFRrMnJcGR+MJtZV6ajxSIvMvff+wIRdT6GCrcsbMzqhTu1xwACwt7c8eQib/PijgVgfZM8qb08jxLL3fEH2Beay2vs9pmJQwQJ2Q1Gjp1AGGemmm8FDXrK7eUUJO5o17HrrajvlUfjmQwNFxD8W87Mc+pPIsU5zwuvtVR6YjEj/oGsCGtUjQ0qUjgd5215Oz7PkRggH6Wg5+vu0E+A5VWTkUpwYugcBqHMTpdJkc+jHJFMPvpKbl8VLqu+qcy9jxxz6vlLRJfb3vi1x8Rg++5nP4tjADUH1mx290Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qN+Up9kIATMmuh6cmk47JBfVdWrE5lK20Tk1ip3bYo=;
 b=AjTsAYguKR++JOG9cv8FKJBtOwOzGiwBVVaPL9MCM+WOGlWAfbLo90UeKMuo8jUKb+sHp0kV8fYldEeH7AOYjW4rKMj0an0x7EtLkvJB4jeBYmLbOO0suby1wh5X0F8rcgm/MmgmQUSseLbLvfxLYK2sKTQvjQNNZna53POrrpaiLQ8pzVtxrR92Gm59hcyEoSLYBNVSH2i5E5ZS4uq8cLysapeFrHw1CZ2k96qpp26xaAv9okAjLisL57dtVzOsjIHJbTQPMHyeyMrcvwoNRss4pxsJvSO1minNWHI3/PYlnNBhpbXPpQcZP33d25zu3WWs+G/9rmoMNzeJcTJ5/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCP286CA0363.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:79::10)
 by SI2PR06MB5386.apcprd06.prod.outlook.com (2603:1096:4:1ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Fri, 8 Aug
 2025 07:29:36 +0000
Received: from TY2PEPF0000AB8A.apcprd03.prod.outlook.com
 (2603:1096:405:79:cafe::32) by TYCP286CA0363.outlook.office365.com
 (2603:1096:405:79::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.16 via Frontend Transport; Fri,
 8 Aug 2025 07:29:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB8A.mail.protection.outlook.com (10.167.253.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 07:29:35 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 4B61541604E0;
	Fri,  8 Aug 2025 15:29:31 +0800 (CST)
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
Subject: [PATCH v6 05/12] PCI: cadence: Split the common functions for PCIe controller support
Date: Fri,  8 Aug 2025 15:29:22 +0800
Message-ID: <20250808072929.4090694-6-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250808072929.4090694-1-hans.zhang@cixtech.com>
References: <20250808072929.4090694-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB8A:EE_|SI2PR06MB5386:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 95a17d84-f384-48af-b7e7-08ddd64d53e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8Tvp8HxG0nXTaqCcnjxJYzwulPSWAmYWpW3gYwpXXBhY3XLiSqC6iQhr6Bi3?=
 =?us-ascii?Q?0xKWd98eEw0xTnao9wUk8re711EF8/DZceLHLLD009n6qMsM2/Vmgkcn61+8?=
 =?us-ascii?Q?HV2jhGTOOcXRzw87/zyl75NaOSBKJnZekVMcfd36BEVqsPTd6EHhjdUQjWVL?=
 =?us-ascii?Q?X4MYSlCP8NUFuTqxcRAmMKkqosPyXSOFlswsCuHx5ZzkuwQBCTDotg5AwkE+?=
 =?us-ascii?Q?jtFeSNOAuhJss7iwnIh1FU9tRMwASW+fYpnHtakUubf+UzZaKdOPxJtfG4Ho?=
 =?us-ascii?Q?6d3VClDcYViN1IDIXIl9h1QeyHZu1Md1y/2foLbEGsOuBR0UIyH7FROruVsE?=
 =?us-ascii?Q?WAR5S3ihdGSljsYYnr4CNC1HEx2as/LQz+ZFbjIwUHkmY48yPBBrr9XoCjtC?=
 =?us-ascii?Q?hE/GqdEN4w2sOJQNTLHvBwiuS/91zjt2Aip5Tej4mDbkV/H98XUwmlmpkHg7?=
 =?us-ascii?Q?djvHlNLtEQ1fYbCdYZsmAxRGXjbAdBMSNO6q/DAwBOkuIiCHHLVYXlvEONfV?=
 =?us-ascii?Q?RI8aPPpwfY0kasDufjEKAXFTZHG/1Vlrm2FfpBZmoSG7+nMocJdJ1s5j4adU?=
 =?us-ascii?Q?y3d9TImAvcYeyJXZntN8vXPH2dwBL3aScibQ8PxuLVqZnv5aJ+JOPCgGVx5W?=
 =?us-ascii?Q?mxQbrFZWHJmUGA34wkfEllSxRk/tUz4TblnuI021z71sNoF8D54LmPJOXNHH?=
 =?us-ascii?Q?FijD7WY4ugjnC7IvCBgRqOzqaKwCWNt7ThKtipDKcJL4qb4ewjHYtXlxdKcu?=
 =?us-ascii?Q?Ub1kdlKWN9H5aRgv+HGJZILDe2+5cPotXBOfAa9WvRBYgPl8cOoF9yR94pl5?=
 =?us-ascii?Q?NEzXjF0XgY8b2/HIyvQPd9ZkVxt7+y7rd4rIpSXMU59gZXrjYT7jGpDJC++8?=
 =?us-ascii?Q?yNTs08joKr/6row7WGTclVuPh3rZDON5UBkqgSCW3FoP/e0fLZmcu1R5wWrZ?=
 =?us-ascii?Q?PABUkmlHjjlI5k/LBOm91CaEg3WMMQFpaOD64xbjq21CasGc0M1ZQhoefidL?=
 =?us-ascii?Q?AroQE/GFCCv9rrjflyxAABikiWF2sQmjPm7qdR4TGxy5L6O8ZWtcRXjXlOjA?=
 =?us-ascii?Q?SC/A8/IgGqlStvZF/brCVcmLn/CVUnIvxbAvX103Wwa+6fbEfKXQV+8FEK6X?=
 =?us-ascii?Q?4S/2jeXPuzeXb8FDG0GzM1lbXoIvHkvBPVK/ydCuxF8XQUpTnWuJoUVIWfp3?=
 =?us-ascii?Q?hMlyGti90cCatW7Z6eO4Z+C1jRJIlSMguUqNm338ihzDhNIaMBzDQYZJGa9A?=
 =?us-ascii?Q?NyRabyc9l5+pOAhqDeY4vNsePVh9LmND/b41G9PdZDR8/mH1QTnyjzA8mtPw?=
 =?us-ascii?Q?SaYmFPtg7BJKGWWhO0OW+T8/1+xe1nTLRI+JfjiNVa5Kmp0tVNw3L02evtV8?=
 =?us-ascii?Q?qu/mAOkWAEH2r6GUvCBPBEDDReKmIF4NM4LnIchfgnJ2NnG9qxhYU22scq+i?=
 =?us-ascii?Q?rsl+QnhJLasFe5XZq9zd2szzNnqUTBf8wTubfpim7eAeec9JURiJVA8Tiu2y?=
 =?us-ascii?Q?F65fYDnT9gQBvUc16r0Q2+KsYcTNuiH+hgHf?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 07:29:35.9120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a17d84-f384-48af-b7e7-08ddd64d53e2
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB8A.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5386

From: Manikandan K Pillai <mpillai@cadence.com>

Separate the functions for platform specific tasks and common
library tasks into different files.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
Co-developed-by: Hans Zhang <hans.zhang@cixtech.com>
Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 drivers/pci/controller/cadence/Makefile       |   2 +-
 .../controller/cadence/pcie-cadence-common.c  | 138 ++++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.c | 128 ----------------
 3 files changed, 139 insertions(+), 129 deletions(-)
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
index 000000000000..90e2b008774f
--- /dev/null
+++ b/drivers/pci/controller/cadence/pcie-cadence-common.c
@@ -0,0 +1,138 @@
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


