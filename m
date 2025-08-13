Return-Path: <linux-pci+bounces-33905-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C31D9B23FA1
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 06:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 043D9627CF9
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 04:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EEC3FC2;
	Wed, 13 Aug 2025 04:27:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023083.outbound.protection.outlook.com [40.107.44.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2672BE045;
	Wed, 13 Aug 2025 04:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755059238; cv=fail; b=ZZE3c2r6K/f0qDnM8HQjjEgo16+p3JmXKtWOnewm+WN+bxCfFQnqW12CrXezQStDIybD1UeTz95bmBdmOD7Jp8Y4MVv6mUdGNIZS152SSFCCExG9w8BKh2pY7B9M3SPgvsC+KJwV/4Qnh3xDxWofii7P6T3odZgF+5QoYe+cOZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755059238; c=relaxed/simple;
	bh=45LQUL5YuPbyD35oSShQwQZc+ZlYNOSRsd8Eapd5aiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qcrAaBEYonU075P98+ocppNT56Gf/X5WLLjeO/a6RrSC44RscULO6dmDC2YNkJVOxEhQSb5eEGlftWUeXy/L85P4h3J/uhWrLk4HKXUBomu6K3zNZp1Q1M4B4jlafrDmN7+lf7SXD5Jo2NsUDzAIZBFMNW3hPCcGdYtWrM2gua0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BzEm83mZvHdtlsq/sEmZIfz5wOb6Jz+R4XPtkAiZ4ZIlznxinrmUo4/pODTdPionBPke6d4TWdPh1mgJ6ZfUZC91raB0qtEHBcerT59tfeEUAXcdFPxbSFfPi864oacDMlxYD/JtgW88KZbtsAs02W+poK6X0D16UFwliwfkW7zsB4pZIN85D6L44BIxXIZrtHYicktGBD8jONiM/UQgP+6Ai/EnYGddVuGxci0pSG2otdJ3cXqJR1bt15llvzxXv7AYbdA3ML0jBPQFLVH5Gdw+IwNb8jxgpEv5SUpctKtsC4hcPukB3rUSht4adbKYIU0TKMlhzTb1f0VCvqmvWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1lhlew3XVDqFz347KZazD9OuPmP1EPoDWqzRj2kcXs=;
 b=Mrc69twmFWt9tZddqaRBVI47ATNCOJnHsJc8fmgbhRL3lGDqMHNz210frPGy0VRbjqcX6WVPDWtQKg2kR/tj61IlCIG/DM3QKc3XmFHKWEPpWTGI89v6eI7dkUcYUVNqaCoKx3Yk6aLLFx8iDFu4Cqmx2apW+b/v4ukALPicepEIEWGkWCsbP0uU12WYU0IPvnRXFaeJd/remCj5z6Hgn68gxrg13NVvXLh6WTIERQOhXGNSkwnBqdMYv/uFkZJKRc2dnxTZrbk1+dX+F7f0a9F6QpdANVjH6J8e/iNpuuIU1rFbqCf/YxBCihR+gv6KZ/OThwsdbpT6UX3pQKZ2CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR02CA0027.apcprd02.prod.outlook.com (2603:1096:3:18::15) by
 TYSPR06MB6390.apcprd06.prod.outlook.com (2603:1096:400:433::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.15; Wed, 13 Aug 2025 04:27:11 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:3:18:cafe::f5) by SG2PR02CA0027.outlook.office365.com
 (2603:1096:3:18::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 04:27:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 04:27:08 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id CDE4B41604E7;
	Wed, 13 Aug 2025 12:27:04 +0800 (CST)
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
Subject: [PATCH v7 10/13] PCI: sky1: Add PCIe host support for CIX Sky1
Date: Wed, 13 Aug 2025 12:23:28 +0800
Message-ID: <20250813042331.1258272-11-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250813042331.1258272-1-hans.zhang@cixtech.com>
References: <20250813042331.1258272-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|TYSPR06MB6390:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6d1efb34-428a-445f-4092-08ddda21aad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WLl8LfvOqMvL460nudYfFzr1xIn1DGKi9Rb1ECzhIjsmU4AdeMw6Drqxq6XY?=
 =?us-ascii?Q?HYCYUy1tff49dgD5ZPJWwdJ0m3M69lOePyl9wFTpeDe9Ffo01323vedvu+FO?=
 =?us-ascii?Q?eGXy7As+9CXwOiRwjtI/te69GDEU1jR+BukvZy0KbcCbwIMY9ie8EzrDXXxd?=
 =?us-ascii?Q?Ltb8kpcdSwqHVZB5wj77Ol+xwP1tMkALbwU9s4eE7hv6KQMfl0zZ+TuPzoJS?=
 =?us-ascii?Q?kY6T9nQNBnvMdd8Qu+DEtaLDFA78SvM7Ke87rVR5aQg/86TLkq/mafLxBoQt?=
 =?us-ascii?Q?YjEKTbUngMup1HIk+edo+AaGcRWc1WEsJR5Kt0UsCU0jdkW5mTnh4te7ZEGz?=
 =?us-ascii?Q?Ypr7ronUgI4NMPWxF6/DvHXg18zfBBLuFvh6iil10oE+rOI7ncTjJe+RRYc8?=
 =?us-ascii?Q?nrm5qgfFqAB02PgMpqFOrq4qWqDKdaPIBDCmUaVUHR2PMWdT9z5jmyh5DXyS?=
 =?us-ascii?Q?DO/3BW2imDWv0AkvebYvb9qyHMKV0N2eLID2Tl/rxbRnpSLZM1+OBCsXU6F9?=
 =?us-ascii?Q?ESK1F8qnDFHClPYBBg3y4hr6adnrurYd3Z7EUddbqTikSaG/QtSP7Z9wQ3Me?=
 =?us-ascii?Q?n3Muu3216dcq00HcgqzUwH0e/A+8FKvr0LbKEfTBNbrLTT1Dt1vktOLxLI72?=
 =?us-ascii?Q?buRzZcFoLSHP6ud4Kvub7izTny0bv+WwlDq3pYoAy4Qy6TIW+bi9/5w/eoBq?=
 =?us-ascii?Q?3DY2f3C86q8aSaeccV0EgwtABaMzJPiZEOJCC1cAp06xxaBe7qnCv5mLvC+L?=
 =?us-ascii?Q?YLRXkSYw0JXfbmpGWezpF8Q+QApHvIiViHx9y69O6BARlQBaHPLYMVNFiLBO?=
 =?us-ascii?Q?N4xs7CPL/HDqBq02Sasv/witdNNw3YxS92FUXhuA4jRUgdYfw4q5YtYQyzMw?=
 =?us-ascii?Q?rzdmnzUkG+KiqOGBgeBZZeiJyStDZLB/+Ul72Yk3Kf2Yd1BYrs2/s8nTsurl?=
 =?us-ascii?Q?oG2DIGDYcsJPp0ntCjyFrqAH7FvOqCJJp2XuZHccz8Lx3NqEdpJIprGbSTnE?=
 =?us-ascii?Q?9fFr8P/LLQuBjLNpoxmoggsqumjHSW+WNE3r1k0L0l2lHSI1iLV8B6oVUtyl?=
 =?us-ascii?Q?UPGteHbiFdorLQFp4zp4nr90YeLKVassQTxspWvDyrQlXDGcmWBlo3S+s6M2?=
 =?us-ascii?Q?VfEvz6U6ij4Er15EptgHn1qFDu6gcCHEoPDaElZ4nAE32oVQxkWKrg0adI1o?=
 =?us-ascii?Q?sbjZT7PCFtxGWaY6s36UQll7GVUPkOJ1y5f3CeRETcy0EdHqH6hOnjxeLtaU?=
 =?us-ascii?Q?wQF5iUlDw0eGcBoulMvc0yRv7KntJPur0JyT+M3xO3EuBVq/Hi9eGBT2azQz?=
 =?us-ascii?Q?xqotXO0bUJU4RYnZgupuHO8Xztu4LGZw6ti4RTndhTY60Sfz85tW771Xxvja?=
 =?us-ascii?Q?H3Xh2RegFeJWGv9WTE08X7UubxDy35R/uLkuQLO5V67+s3M3ydm7cdpUck7f?=
 =?us-ascii?Q?BQWh+vcJvKIYNBtoGr5t075KDE7YIsI3nIrRMcRNWZswyCiMe/pWCRN8e7s0?=
 =?us-ascii?Q?XtPAnqNs1YwXlIodUIs6/VJYALfyyspBCa/7?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 04:27:08.8950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1efb34-428a-445f-4092-08ddda21aad3
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6390

From: Hans Zhang <hans.zhang@cixtech.com>

Add driver for the CIX Sky1 SoC PCIe Gen4 16 GT/s controller based
on the Cadence PCIe core.

Supports MSI/MSI-x via GICv3, Single Virtual Channel, Single Function.

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 drivers/pci/controller/cadence/Kconfig    |  13 +
 drivers/pci/controller/cadence/Makefile   |   1 +
 drivers/pci/controller/cadence/pci-sky1.c | 294 ++++++++++++++++++++++
 3 files changed, 308 insertions(+)
 create mode 100644 drivers/pci/controller/cadence/pci-sky1.c

diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
index 117677a23d68..1716b7300fa1 100644
--- a/drivers/pci/controller/cadence/Kconfig
+++ b/drivers/pci/controller/cadence/Kconfig
@@ -67,4 +67,17 @@ config PCI_J721E_EP
 	  Say Y here if you want to support the TI J721E PCIe platform
 	  controller in endpoint mode. TI J721E PCIe controller uses Cadence PCIe
 	  core.
+
+config PCI_SKY1_HOST
+	tristate "CIX SKY1 PCIe controller (host mode)"
+	depends on OF
+	select PCIE_CADENCE_HOST
+	select PCI_ECAM
+	help
+	  Say Y here if you want to support the CIX SKY1 PCIe platform
+	  controller in host mode. CIX SKY1 PCIe controller uses Cadence HPA(High
+	  Performance Architecture IP[Second generation of cadence PCIe IP])
+
+	  This driver requires Cadence PCIe core infrastructure (PCIE_CADENCE_HOST)
+	  and hardware platform adaptation layer to function.
 endmenu
diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
index de4ddae7aca4..40d7c6e98b4d 100644
--- a/drivers/pci/controller/cadence/Makefile
+++ b/drivers/pci/controller/cadence/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host-mod.o
 obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep-mod.o
 obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
 obj-$(CONFIG_PCI_J721E) += pci-j721e.o
+obj-$(CONFIG_PCI_SKY1_HOST) += pci-sky1.o
diff --git a/drivers/pci/controller/cadence/pci-sky1.c b/drivers/pci/controller/cadence/pci-sky1.c
new file mode 100644
index 000000000000..36267d0bb5b6
--- /dev/null
+++ b/drivers/pci/controller/cadence/pci-sky1.c
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe controller driver for CIX's sky1 SoCs
+ *
+ * Author: Hans Zhang <hans.zhang@cixtech.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pci.h>
+#include <linux/pci-ecam.h>
+#include <linux/pci_ids.h>
+
+#include "pcie-cadence.h"
+#include "pcie-cadence-host-common.h"
+
+#define STRAP_REG(n) ((n) * 0x04)
+#define STATUS_REG(n) ((n) * 0x04)
+
+#define RCSU_STRAP_REG 0x300
+#define RCSU_STATUS_REG 0x400
+
+#define SKY1_IP_REG_BANK_OFFSET 0x1000
+#define SKY1_IP_CFG_CTRL_REG_BANK_OFFSET 0x4c00
+#define SKY1_IP_AXI_MASTER_COMMON_OFFSET 0xf000
+#define SKY1_AXI_SLAVE_OFFSET 0x9000
+#define SKY1_AXI_MASTER_OFFSET 0xb000
+#define SKY1_AXI_HLS_REGISTERS_OFFSET 0xc000
+#define SKY1_AXI_RAS_REGISTERS_OFFSET 0xe000
+#define SKY1_DTI_REGISTERS_OFFSET 0xd000
+
+#define IP_REG_I_DBG_STS_0 0x420
+
+#define LINK_TRAINING_ENABLE BIT(0)
+#define LINK_COMPLETE BIT(0)
+
+enum cix_soc_type {
+	CIX_SKY1,
+};
+
+struct sky1_pcie_data {
+	struct cdns_plat_pcie_of_data reg_off;
+	enum cix_soc_type soc_type;
+};
+
+struct sky1_pcie {
+	struct device *dev;
+	const struct sky1_pcie_data *data;
+	struct cdns_pcie *cdns_pcie;
+	struct cdns_pcie_rc *cdns_pcie_rc;
+
+	struct resource *cfg_res;
+	struct resource *msg_res;
+	struct pci_config_window *cfg;
+	void __iomem *rcsu_base;
+	void __iomem *strap_base;
+	void __iomem *status_base;
+	void __iomem *reg_base;
+	void __iomem *cfg_base;
+	void __iomem *msg_base;
+};
+
+static void sky1_pcie_clear_and_set_dword(void __iomem *addr, u32 clear,
+					  u32 set)
+{
+	u32 val;
+
+	val = readl(addr);
+	val &= ~clear;
+	val |= set;
+	writel(val, addr);
+}
+
+static void sky1_pcie_init_bases(struct sky1_pcie *pcie)
+{
+	pcie->strap_base = pcie->rcsu_base + RCSU_STRAP_REG;
+	pcie->status_base = pcie->rcsu_base + RCSU_STATUS_REG;
+}
+
+static int sky1_pcie_parse_mem(struct sky1_pcie *pcie)
+{
+	struct device *dev = pcie->dev;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct resource *res;
+	void __iomem *base;
+	int ret = 0;
+
+	base = devm_platform_ioremap_resource_byname(pdev, "reg");
+	if (IS_ERR(base)) {
+		dev_err(dev, "Parse \"reg\" resource err\n");
+		return PTR_ERR(base);
+	}
+	pcie->reg_base = base;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
+	if (!res) {
+		dev_err(dev, "Parse \"cfg\" resource err\n");
+		return -ENXIO;
+	}
+	pcie->cfg_res = res;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rcsu");
+	if (!res) {
+		dev_err(dev, "Parse \"rcsu\" resource err\n");
+		return -ENXIO;
+	}
+	pcie->rcsu_base = devm_ioremap(dev, res->start, resource_size(res));
+	if (!pcie->rcsu_base) {
+		dev_err(dev, "ioremap failed for resource %pR\n", res);
+		return -ENOMEM;
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "msg");
+	if (!res) {
+		dev_err(dev, "Parse \"msg\" resource err\n");
+		return -ENXIO;
+	}
+	pcie->msg_res = res;
+	pcie->msg_base = devm_ioremap(dev, res->start, resource_size(res));
+	if (!pcie->msg_base) {
+		dev_err(dev, "ioremap failed for resource %pR\n", res);
+		return -ENOMEM;
+	}
+
+	return ret;
+}
+
+static int sky1_pcie_parse_property(struct platform_device *pdev,
+				    struct sky1_pcie *pcie)
+{
+	int ret = 0;
+
+	ret = sky1_pcie_parse_mem(pcie);
+	if (ret < 0)
+		return ret;
+
+	sky1_pcie_init_bases(pcie);
+
+	return ret;
+}
+
+static int sky1_pcie_start_link(struct cdns_pcie *cdns_pcie)
+{
+	struct sky1_pcie *pcie = dev_get_drvdata(cdns_pcie->dev);
+
+	sky1_pcie_clear_and_set_dword(pcie->strap_base + STRAP_REG(1),
+				      0, LINK_TRAINING_ENABLE);
+
+	return 0;
+}
+
+static void sky1_pcie_stop_link(struct cdns_pcie *cdns_pcie)
+{
+	struct sky1_pcie *pcie = dev_get_drvdata(cdns_pcie->dev);
+
+	sky1_pcie_clear_and_set_dword(pcie->strap_base + STRAP_REG(1),
+				      LINK_TRAINING_ENABLE, 0);
+}
+
+
+static bool sky1_pcie_link_up(struct cdns_pcie *cdns_pcie)
+{
+	u32 val;
+
+	val = cdns_pcie_hpa_readl(cdns_pcie, REG_BANK_IP_REG,
+				  IP_REG_I_DBG_STS_0);
+	return val & LINK_COMPLETE;
+}
+
+static const struct cdns_pcie_ops sky1_pcie_ops = {
+	.start_link = sky1_pcie_start_link,
+	.stop_link = sky1_pcie_stop_link,
+	.link_up = sky1_pcie_link_up,
+};
+
+static int sky1_pcie_probe(struct platform_device *pdev)
+{
+	const struct sky1_pcie_data *data;
+	struct device *dev = &pdev->dev;
+	struct pci_host_bridge *bridge;
+	struct cdns_pcie *cdns_pcie;
+	struct resource_entry *bus;
+	struct cdns_pcie_rc *rc;
+	struct sky1_pcie *pcie;
+	int ret;
+
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	data = of_device_get_match_data(dev);
+	if (!data)
+		return -EINVAL;
+
+	pcie->data = data;
+	pcie->dev = dev;
+	dev_set_drvdata(dev, pcie);
+
+	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
+	if (!bridge)
+		return -ENOMEM;
+
+	bus = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
+	if (!bus)
+		return -ENODEV;
+
+	ret = sky1_pcie_parse_property(pdev, pcie);
+	if (ret < 0)
+		return -ENXIO;
+
+	pcie->cfg = pci_ecam_create(dev, pcie->cfg_res, bus->res,
+				    &pci_generic_ecam_ops);
+	if (IS_ERR(pcie->cfg))
+		return PTR_ERR(pcie->cfg);
+
+	bridge->ops = (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
+	rc = pci_host_bridge_priv(bridge);
+	rc->ecam_support_flag = 1;
+	rc->cfg_base = pcie->cfg->win;
+	rc->cfg_res = &pcie->cfg->res;
+
+	cdns_pcie = &rc->pcie;
+	cdns_pcie->dev = dev;
+	cdns_pcie->ops = &sky1_pcie_ops;
+	cdns_pcie->reg_base = pcie->reg_base;
+	cdns_pcie->msg_res = pcie->msg_res;
+	cdns_pcie->cdns_pcie_reg_offsets = &data->reg_off;
+	cdns_pcie->is_rc = data->reg_off.is_rc;
+
+	pcie->cdns_pcie = cdns_pcie;
+	pcie->cdns_pcie_rc = rc;
+	pcie->cfg_base = rc->cfg_base;
+	bridge->sysdata = pcie->cfg;
+
+	if (data->soc_type == CIX_SKY1) {
+		rc->vendor_id = PCI_VENDOR_ID_CIX;
+		rc->device_id = PCI_DEVICE_ID_CIX_SKY1;
+		rc->no_inbound_flag = 1;
+	}
+
+	ret = cdns_pcie_hpa_host_setup(rc);
+	if (ret < 0) {
+		pci_ecam_free(pcie->cfg);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct sky1_pcie_data sky1_pcie_rc_data = {
+	.reg_off = {
+		.is_rc = true,
+		.ip_reg_bank_offset = SKY1_IP_REG_BANK_OFFSET,
+		.ip_cfg_ctrl_reg_offset = SKY1_IP_CFG_CTRL_REG_BANK_OFFSET,
+		.axi_mstr_common_offset = SKY1_IP_AXI_MASTER_COMMON_OFFSET,
+		.axi_slave_offset = SKY1_AXI_SLAVE_OFFSET,
+		.axi_master_offset = SKY1_AXI_MASTER_OFFSET,
+		.axi_hls_offset = SKY1_AXI_HLS_REGISTERS_OFFSET,
+		.axi_ras_offset = SKY1_AXI_RAS_REGISTERS_OFFSET,
+		.axi_dti_offset = SKY1_DTI_REGISTERS_OFFSET,
+	},
+	.soc_type = CIX_SKY1,
+};
+
+static const struct of_device_id of_sky1_pcie_match[] = {
+	{
+		.compatible = "cix,sky1-pcie-host",
+		.data = &sky1_pcie_rc_data,
+	},
+	{},
+};
+
+static void sky1_pcie_remove(struct platform_device *pdev)
+{
+	struct sky1_pcie *pcie = platform_get_drvdata(pdev);
+
+	pci_ecam_free(pcie->cfg);
+}
+
+static struct platform_driver sky1_pcie_driver = {
+	.probe  = sky1_pcie_probe,
+	.remove = sky1_pcie_remove,
+	.driver = {
+		.name = "sky1-pcie",
+		.of_match_table = of_sky1_pcie_match,
+	},
+};
+module_platform_driver(sky1_pcie_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("PCIe controller driver for CIX's sky1 SoCs");
+MODULE_AUTHOR("Hans Zhang <hans.zhang@cixtech.com>");
-- 
2.49.0


