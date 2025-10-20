Return-Path: <linux-pci+bounces-38704-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E8CBEF490
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 06:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6C471894D74
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 04:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F4A2C11F4;
	Mon, 20 Oct 2025 04:29:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023110.outbound.protection.outlook.com [52.101.127.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F5E1DF985;
	Mon, 20 Oct 2025 04:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760934548; cv=fail; b=cMcJK0FRhRosOssv9NUqlkxjVM+NKHCCHOloX9ic9z5kDT//CPu7R8daoy7kC/ChltodF+KdfA3htZyKb391gbnKC5jFylVC0dUvaMpgX1CRMU6Mm6r+rLjArDGP+dusnowSehD/pltIbUDO4bgCnSSUOQ+f6eKmu0PeQsYHSSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760934548; c=relaxed/simple;
	bh=vVbjcYd6fcZkJyCSSkneCwIAJ+2ln2zqz/+UvIuJAtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=es/7ukQZTlR5a5hxjjVJmsu01fr/rRNv4FYQK4K8Iuk+LV0rmvr2gUuwMEnvLYRRpU1zMU6qlS4+bHWwPSd3YPyMHBVW+vP0/bqS9LU3hIVt6SD4ZZUnaejUG3eHzCO4sDQf0zLr+Sq2tJpe7mUNuPaVov+je5WaRolywCWV+M8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SITouRGRaTi2wllvfl1NZXDpJ3NrItMZ3WVck/mzarZ4Eeb92VYhe0g8MpyC3LKbwTY8OMK7qgmxY00GEkX5IqDHrbqwaRlNG7ie95OMF0ubeFkH1mWl0REg/QGqimyYlQOXWV9F2Kh33nqoMq/Byi1yReaUoaXl0DkMo0WO1wxGnztNQiccYekxpoLpUzz5c9Q0sgEDRFn7uPGWrkjZLkyjeH/NTNEkUwvne/9NrxjKynWzw/8TNKUlK/7hcPI20A78DvF3fWMWXay4FV7BRTZgLfFS8nQL1WV5zFesUKgZLknLnon1QvrfcfMsGsChdgzg69p7DqqhdLVg/H2ZHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYJLMB12OcpyaY0eUT5EfrsWUIr1LEG+Z8YlzvVD6aA=;
 b=A7MKe30JKq/sxdvF3O6Whn8CKDBkv/CAioZBG4XPgJ+MyeSOTZsXgFU/jVjH1FEg8FLuVHrD+snAv2zup8vvV8sGXlqduoOL627tOgSQ+CHUpY/7ELH2UHN5RVOf3yE7oKKf8A1NcQf4Efxhy35kljgGechtZRgtmgTTi3P9gTMYiPvV3BkiOG3dG8mYhZcKsbxKOVXfSlqW/pnf0FDGaJw6C6i6Z5fN0YSSQ4XeRbFCTi26fd/U8t+SwB906yIKMSG/7irk+/OUCsNCA1Ws3LaFTygfE16PmBdoL94T0DdFrsNlmZ+QhuNPhBj43G8Jl1742urlDZ+7+xyRydbIvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI1PR02CA0009.apcprd02.prod.outlook.com (2603:1096:4:1f7::10)
 by TY2PPFF72AB57F6.apcprd06.prod.outlook.com (2603:1096:408::7b2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 04:29:00 +0000
Received: from SG1PEPF000082E3.apcprd02.prod.outlook.com
 (2603:1096:4:1f7:cafe::f7) by SI1PR02CA0009.outlook.office365.com
 (2603:1096:4:1f7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Mon,
 20 Oct 2025 04:29:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E3.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 04:28:58 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id F256C41C016C;
	Mon, 20 Oct 2025 12:28:57 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
	helgaas@kernel.org,
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
Subject: [PATCH v10 04/10] PCI: cadence: Add support for High Perf Architecture (HPA) controller
Date: Mon, 20 Oct 2025 12:28:51 +0800
Message-ID: <20251020042857.706786-5-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251020042857.706786-1-hans.zhang@cixtech.com>
References: <20251020042857.706786-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E3:EE_|TY2PPFF72AB57F6:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 424066e5-8de6-4469-c063-08de0f91307a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BTWumw56oGr6wfgUr003e3xOoVcusPaSR8xfE61+qaonuEdSO6xeYZPTaOB2?=
 =?us-ascii?Q?SFd43zXeC7bAxoShTM5j0UQWD34WcPsmCk2pT75HD6DErIV7SmVVt33XbqLG?=
 =?us-ascii?Q?OhWoaoPpXGGukLk+p2HWO5YNY6ZDxmh1P5xc5Q6HKaGHOHZTBIZZ7qLt/gvY?=
 =?us-ascii?Q?J78k0fHPRQR2o+zZ1JYhIVwspGmvhXEJI3sflJLAfXv9fq98y/DupQ99Tn2g?=
 =?us-ascii?Q?iX+1cIylglM4ogPCmArNikghL7T/TTwzsGO5dI9fPbAlJbQdSJWyDy+tu2PO?=
 =?us-ascii?Q?7jKa/FqAa/sX+OAzVgH2IUpiAc5CpfzipEVE8UBp1yvgT3jFkygdqBnlz4sI?=
 =?us-ascii?Q?YUrBS36QWl9p3s8iMfwFPG0YAE0jsp+0rX5f4NoujPZ7wjvGEp6cPklPNb0K?=
 =?us-ascii?Q?85pXStQghZYN4OVwVlfI+L3eCY/NfvC3COrKjkTJ0OmVqlJMFvmeZd1Gf9oD?=
 =?us-ascii?Q?iIxU6Ef4jDRQjMiAInyzsNpLDeK98nlVNd9N7bhdPmW7sp1lB3RkrPdi7zW9?=
 =?us-ascii?Q?4Ummz/VBICUxjYrPZZyvB68URlaBFHNsrGWvEn/rQsniKg94wYH3ETRWia8x?=
 =?us-ascii?Q?5KOFGiixPLRropPMG8ZFaL54iAy+jl1+PXnXTq9xhn4yV//jQ1QV0VfmLD74?=
 =?us-ascii?Q?9rV/Upd27Yo0P874TJU0nRKesMS7X/121zXUQg4agj/XUDUFJpZz8mXc7Tcf?=
 =?us-ascii?Q?J1riYAildaaIYwTx/gL2cqGiPaVBexzOvHQeb00H45Te3NV2ZcmNtO7BPALL?=
 =?us-ascii?Q?cUJVVqMsHpe5cp034jBBH2x8tQzr9EEc/HWUTOPHly1Akt663znXRADm9y0X?=
 =?us-ascii?Q?KPzU1/pJts1QH9z9JjQx5HiVVS8fr0hEwEQFmHjhlSHHt5cPgJVbwMJ7DMWF?=
 =?us-ascii?Q?TNLEYxALRYlQAjiG1lI1KR3UmXT2b0+HaIbYnftWZY3S2pHQsfRyoT4U9dTM?=
 =?us-ascii?Q?PRg5BqFlXZ5MO0Q6s9p4lXhuvmwfDdBCVXTk7zGv+32NeW30C3UvewP7iB6X?=
 =?us-ascii?Q?rzkcs/IyRdGl2fTLzH50XSukhJrDDECRUkbf9q5XWlEREHTWttM/XuvPbCrT?=
 =?us-ascii?Q?Ewbqqf3cAGxE7rYc68jIifmoZp9U9YMYANrcdnsn8tvfrVRNz9lNlkIV7RAJ?=
 =?us-ascii?Q?fEfwjh9ajLuxFc1GenzZBerIX9MUW00iSoSHo7GXs8PI9e6BMPSa1wRP6TDZ?=
 =?us-ascii?Q?zezvELF7eRm1g1ZxGlHIq56bpZjdhZkW4z46Kp//CcFfYcwbjcKD6Bbt+mXK?=
 =?us-ascii?Q?rnb3FqTX7ChOP/9aCj9X6AdAJZdmJzU+0eVoJXOKxTNeVebVYDMTkpRGY+Vf?=
 =?us-ascii?Q?5zRO2oX03K8/GlDmGd5HMg8mZKhTO/q8GzaHqXHf6mrT0oKayw7VS++bseSi?=
 =?us-ascii?Q?pnkg+EellOsH0zjg6U845JlIFjL1eN5xWFpo1QwcCN/HK2mJ8UzjFeiXaZms?=
 =?us-ascii?Q?hAq+lJf90GQ60cLYOSQiDhA6Dk7oK1PO9NQOmbq1+furJMHFHaRXdFqHqTed?=
 =?us-ascii?Q?aTGTm/9gOl+vMSklJuIrtB0oh1pEF1oj8fZ0BPumsWrlwt9et0ezwOn/4MZM?=
 =?us-ascii?Q?ZvepSwMDCV4IQammDRA=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 04:28:58.9270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 424066e5-8de6-4469-c063-08de0f91307a
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E3.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPFF72AB57F6

From: Manikandan K Pillai <mpillai@cadence.com>

Add support for Cadence PCIe RP and EP configuration for High
Performance Architecture (HPA) controllers. The Cadence High Performance
controllers are the latest PCIe controllers that have support for DMA,
optional IDE and updated register set. Add register definitions for High
Performance Architecture (HPA) PCIe controllers.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
Co-developed-by: Hans Zhang <hans.zhang@cixtech.com>
Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 drivers/pci/controller/cadence/Makefile       |  10 +-
 .../cadence/pcie-cadence-host-hpa.c           | 499 ++++++++++++++++++
 .../cadence/pcie-cadence-hpa-regs.h           | 193 +++++++
 .../pci/controller/cadence/pcie-cadence-hpa.c | 186 +++++++
 .../controller/cadence/pcie-cadence-plat.c    |   4 -
 drivers/pci/controller/cadence/pcie-cadence.c |  11 +
 drivers/pci/controller/cadence/pcie-cadence.h | 188 ++++++-
 7 files changed, 1069 insertions(+), 22 deletions(-)
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-hpa-regs.h
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-hpa.c

diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
index a52ebf6f3201..30189045a166 100644
--- a/drivers/pci/controller/cadence/Makefile
+++ b/drivers/pci/controller/cadence/Makefile
@@ -1,7 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence.o
-obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host-common.o pcie-cadence-host.o
-obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
+pcie-cadence-mod-y := pcie-cadence-hpa.o pcie-cadence.o
+pcie-cadence-host-mod-y := pcie-cadence-host-common.o pcie-cadence-host.o pcie-cadence-host-hpa.o
+pcie-cadence-ep-mod-y := pcie-cadence-ep.o
+
+obj-$(CONFIG_PCIE_CADENCE) = pcie-cadence-mod.o
+obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host-mod.o
+obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep-mod.o
 obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
 obj-$(CONFIG_PCI_J721E) += pci-j721e.o
 obj-$(CONFIG_PCIE_SG2042_HOST) += pcie-sg2042.o
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
new file mode 100644
index 000000000000..fa8b2c39c5d0
--- /dev/null
+++ b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
@@ -0,0 +1,499 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cadence PCIe host controller driver.
+ *
+ * Copyright (c) 2024, Cadence Design Systems
+ * Author: Manikandan K Pillai <mpillai@cadence.com>
+ */
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/list_sort.h>
+#include <linux/of_address.h>
+#include <linux/of_pci.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+
+#include "pcie-cadence.h"
+#include "pcie-cadence-host-common.h"
+
+static u8 bar_aperture_mask[] = {
+	[RP_BAR0] = 0x3F,
+	[RP_BAR1] = 0x3F,
+};
+
+void __iomem *cdns_pci_hpa_map_bus(struct pci_bus *bus, unsigned int devfn,
+				   int where)
+{
+	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
+	struct cdns_pcie_rc *rc = pci_host_bridge_priv(bridge);
+	struct cdns_pcie *pcie = &rc->pcie;
+	unsigned int busn = bus->number;
+	u32 addr0, desc0, desc1, ctrl0;
+	u32 regval;
+
+	if (pci_is_root_bus(bus)) {
+		/*
+		 * Only the root port (devfn == 0) is connected to this bus.
+		 * All other PCI devices are behind some bridge hence on another
+		 * bus.
+		 */
+		if (devfn)
+			return NULL;
+
+		return pcie->reg_base + (where & 0xfff);
+	}
+
+	/* Clear AXI link-down status */
+	regval = cdns_pcie_hpa_readl(pcie, REG_BANK_AXI_SLAVE, CDNS_PCIE_HPA_AT_LINKDOWN);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE, CDNS_PCIE_HPA_AT_LINKDOWN,
+			     (regval & ~GENMASK(0, 0)));
+
+	/* Update Output registers for AXI region 0 */
+	addr0 = CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS(12) |
+		CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) |
+		CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS(busn);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(0), addr0);
+
+	desc1 = cdns_pcie_hpa_readl(pcie, REG_BANK_AXI_SLAVE,
+				    CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0));
+	desc1 &= ~CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN_MASK;
+	desc1 |= CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(0);
+	ctrl0 = CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_BUS |
+		CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN;
+
+	if (busn == bridge->busnr + 1)
+		desc0 = CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0;
+	else
+		desc0 = CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE1;
+
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_DESC0(0), desc0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0), desc1);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(0), ctrl0);
+
+	return rc->cfg_base + (where & 0xfff);
+}
+
+static int cdns_pcie_hpa_host_wait_for_link(struct cdns_pcie *pcie)
+{
+	struct device *dev = pcie->dev;
+	struct cdns_pcie_rc *rc;
+	int retries, ret;
+
+	rc = container_of(pcie, struct cdns_pcie_rc, pcie);
+
+	/* Check if the link is up or not */
+	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
+		if (cdns_pcie_hpa_link_up(pcie)) {
+			dev_info(dev, "Link up\n");
+			return 0;
+		}
+		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
+	}
+	if (rc->quirk_retrain_flag)
+		ret = cdns_pcie_retrain(pcie);
+	return ret;
+}
+
+static struct pci_ops cdns_pcie_hpa_host_ops = {
+	.map_bus	= cdns_pci_hpa_map_bus,
+	.read		= pci_generic_config_read,
+	.write		= pci_generic_config_write,
+};
+
+static void cdns_pcie_hpa_host_enable_ptm_response(struct cdns_pcie *pcie)
+{
+	u32 val;
+
+	val = cdns_pcie_hpa_readl(pcie, REG_BANK_IP_REG, CDNS_PCIE_HPA_LM_PTM_CTRL);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_IP_REG, CDNS_PCIE_HPA_LM_PTM_CTRL,
+			     val | CDNS_PCIE_HPA_LM_PTM_CTRL_PTMRSEN);
+}
+
+static int cdns_pcie_hpa_host_bar_ib_config(struct cdns_pcie_rc *rc,
+					    enum cdns_pcie_rp_bar bar,
+					    u64 cpu_addr, u64 size,
+					    unsigned long flags)
+{
+	struct cdns_pcie *pcie = &rc->pcie;
+	u32 addr0, addr1, aperture, value;
+
+	if (!rc->avail_ib_bar[bar])
+		return -ENODEV;
+
+	rc->avail_ib_bar[bar] = false;
+
+	aperture = ilog2(size);
+	if (bar == RP_NO_BAR) {
+		addr0 = CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS(aperture) |
+			(lower_32_bits(cpu_addr) & GENMASK(31, 8));
+		addr1 = upper_32_bits(cpu_addr);
+	} else {
+		addr0 = lower_32_bits(cpu_addr);
+		addr1 = upper_32_bits(cpu_addr);
+	}
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_MASTER,
+			     CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0(bar), addr0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_MASTER,
+			     CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR1(bar), addr1);
+
+	if (bar == RP_NO_BAR)
+		bar = (enum cdns_pcie_rp_bar)BAR_0;
+
+	value = cdns_pcie_hpa_readl(pcie, REG_BANK_IP_CFG_CTRL_REG, CDNS_PCIE_HPA_LM_RC_BAR_CFG);
+	value &= ~(HPA_LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar) |
+		   HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar) |
+		   HPA_LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar) |
+		   HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar) |
+		   HPA_LM_RC_BAR_CFG_APERTURE(bar, bar_aperture_mask[bar] + 7));
+	if (size + cpu_addr >= SZ_4G) {
+		value |= HPA_LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar);
+		if ((flags & IORESOURCE_PREFETCH))
+			value |= HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar);
+	} else {
+		value |= HPA_LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar);
+		if ((flags & IORESOURCE_PREFETCH))
+			value |= HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar);
+	}
+
+	value |= HPA_LM_RC_BAR_CFG_APERTURE(bar, aperture);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_IP_CFG_CTRL_REG, CDNS_PCIE_HPA_LM_RC_BAR_CFG, value);
+
+	return 0;
+}
+
+static int cdns_pcie_hpa_host_bar_config(struct cdns_pcie_rc *rc,
+					 struct resource_entry *entry)
+{
+	u64 cpu_addr, pci_addr, size, winsize;
+	struct cdns_pcie *pcie = &rc->pcie;
+	struct device *dev = pcie->dev;
+	enum cdns_pcie_rp_bar bar;
+	unsigned long flags;
+	int ret;
+
+	cpu_addr = entry->res->start;
+	pci_addr = entry->res->start - entry->offset;
+	flags = entry->res->flags;
+	size = resource_size(entry->res);
+
+	if (entry->offset == 0) {
+		if (pci_addr != cpu_addr) {
+			dev_err(dev, "PCI addr: %llx must be equal to CPU addr: %llx\n",
+				pci_addr, cpu_addr);
+			return -EINVAL;
+		}
+	}
+
+	while (size > 0) {
+		/*
+		 * Try to find a minimum BAR whose size is greater than
+		 * or equal to the remaining resource_entry size. This will
+		 * fail if the size of each of the available BARs is less than
+		 * the remaining resource_entry size.
+		 *
+		 * If a minimum BAR is found, IB ATU will be configured and
+		 * exited.
+		 */
+		bar = cdns_pcie_host_find_min_bar(rc, size);
+		if (bar != RP_BAR_UNDEFINED) {
+			ret = cdns_pcie_hpa_host_bar_ib_config(rc, bar, cpu_addr,
+							       size, flags);
+			if (ret)
+				dev_err(dev, "IB BAR: %d config failed\n", bar);
+			return ret;
+		}
+
+		/*
+		 * If the control reaches here, it would mean the remaining
+		 * resource_entry size cannot be fitted in a single BAR. So we
+		 * find a maximum BAR whose size is less than or equal to the
+		 * remaining resource_entry size and split the resource entry
+		 * so that part of resource entry is fitted inside the maximum
+		 * BAR. The remaining size would be fitted during the next
+		 * iteration of the loop.
+		 *
+		 * If a maximum BAR is not found, there is no way we can fit
+		 * this resource_entry, so we error out.
+		 */
+		bar = cdns_pcie_host_find_max_bar(rc, size);
+		if (bar == RP_BAR_UNDEFINED) {
+			dev_err(dev, "No free BAR to map cpu_addr %llx\n",
+				cpu_addr);
+			return -EINVAL;
+		}
+
+		winsize = bar_max_size[bar];
+		ret = cdns_pcie_hpa_host_bar_ib_config(rc, bar, cpu_addr, winsize, flags);
+		if (ret) {
+			dev_err(dev, "IB BAR: %d config failed\n", bar);
+			return ret;
+		}
+
+		size -= winsize;
+		cpu_addr += winsize;
+	}
+
+	return 0;
+}
+
+static int cdns_pcie_hpa_host_map_dma_ranges(struct cdns_pcie_rc *rc)
+{
+	struct cdns_pcie *pcie = &rc->pcie;
+	struct device *dev = pcie->dev;
+	struct device_node *np = dev->of_node;
+	struct pci_host_bridge *bridge;
+	struct resource_entry *entry;
+	u32 no_bar_nbits = 32;
+	int err;
+
+	bridge = pci_host_bridge_from_priv(rc);
+	if (!bridge)
+		return -ENOMEM;
+
+	if (list_empty(&bridge->dma_ranges)) {
+		of_property_read_u32(np, "cdns,no-bar-match-nbits",
+				     &no_bar_nbits);
+		err = cdns_pcie_hpa_host_bar_ib_config(rc, RP_NO_BAR, 0x0,
+						       (u64)1 << no_bar_nbits, 0);
+		if (err)
+			dev_err(dev, "IB BAR: %d config failed\n", RP_NO_BAR);
+		return err;
+	}
+
+	list_sort(NULL, &bridge->dma_ranges, cdns_pcie_host_dma_ranges_cmp);
+
+	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
+		err = cdns_pcie_hpa_host_bar_config(rc, entry);
+		if (err) {
+			dev_err(dev, "Fail to configure IB using dma-ranges\n");
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static int cdns_pcie_hpa_host_init_root_port(struct cdns_pcie_rc *rc)
+{
+	struct cdns_pcie *pcie = &rc->pcie;
+	u32 value, ctrl;
+
+	/*
+	 * Set the root port BAR configuration register:
+	 * - disable both BAR0 and BAR1
+	 * - enable Prefetchable Memory Base and Limit registers in type 1
+	 *   config space (64 bits)
+	 * - enable IO Base and Limit registers in type 1 config
+	 *   space (32 bits)
+	 */
+
+	ctrl = CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_DISABLED;
+	value = CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_CTRL(ctrl) |
+		CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_CTRL(ctrl) |
+		CDNS_PCIE_HPA_LM_RC_BAR_CFG_PREFETCH_MEM_ENABLE |
+		CDNS_PCIE_HPA_LM_RC_BAR_CFG_PREFETCH_MEM_64BITS |
+		CDNS_PCIE_HPA_LM_RC_BAR_CFG_IO_ENABLE |
+		CDNS_PCIE_HPA_LM_RC_BAR_CFG_IO_32BITS;
+	cdns_pcie_hpa_writel(pcie, REG_BANK_IP_CFG_CTRL_REG,
+			     CDNS_PCIE_HPA_LM_RC_BAR_CFG, value);
+
+	if (rc->vendor_id != 0xffff)
+		cdns_pcie_hpa_rp_writew(pcie, PCI_VENDOR_ID, rc->vendor_id);
+
+	if (rc->device_id != 0xffff)
+		cdns_pcie_hpa_rp_writew(pcie, PCI_DEVICE_ID, rc->device_id);
+
+	cdns_pcie_hpa_rp_writeb(pcie, PCI_CLASS_REVISION, 0);
+	cdns_pcie_hpa_rp_writeb(pcie, PCI_CLASS_PROG, 0);
+	cdns_pcie_hpa_rp_writew(pcie, PCI_CLASS_DEVICE, PCI_CLASS_BRIDGE_PCI);
+
+	/* Enable bus mastering */
+	value = cdns_pcie_hpa_readl(pcie, REG_BANK_RP, PCI_COMMAND);
+	value |= (PCI_COMMAND_MEMORY | PCI_COMMAND_IO | PCI_COMMAND_MASTER);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_RP, PCI_COMMAND, value);
+	return 0;
+}
+
+static void cdns_pcie_hpa_create_region_for_cfg(struct cdns_pcie_rc *rc)
+{
+	struct cdns_pcie *pcie = &rc->pcie;
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(rc);
+	struct resource *cfg_res = rc->cfg_res;
+	struct resource_entry *entry;
+	u64 cpu_addr = cfg_res->start;
+	u32 addr0, addr1, desc1;
+	int busnr = 0;
+
+	entry = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
+	if (entry)
+		busnr = entry->res->start;
+
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_TAG_MANAGEMENT, 0x01000000);
+	/*
+	 * Reserve region 0 for PCI configure space accesses:
+	 * OB_REGION_PCI_ADDR0 and OB_REGION_DESC0 are updated dynamically by
+	 * cdns_pci_map_bus(), other region registers are set here once for all
+	 */
+	desc1 = CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS(busnr);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(0), 0x0);
+	/* Type-1 CFG */
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_DESC0(0), 0x05000000);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0), desc1);
+
+	addr0 = CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS(12) |
+		(lower_32_bits(cpu_addr) & GENMASK(31, 8));
+	addr1 = upper_32_bits(cpu_addr);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(0), addr0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(0), addr1);
+}
+
+static int cdns_pcie_hpa_host_init_address_translation(struct cdns_pcie_rc *rc)
+{
+	struct cdns_pcie *pcie = &rc->pcie;
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(rc);
+	struct resource_entry *entry;
+	int r = 0, busnr = 0;
+
+	if (!rc->ecam_supported)
+		cdns_pcie_hpa_create_region_for_cfg(rc);
+
+	entry = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
+	if (entry)
+		busnr = entry->res->start;
+
+	r++;
+	if (pcie->msg_res) {
+		cdns_pcie_hpa_set_outbound_region_for_normal_msg(pcie, busnr, 0, r,
+								 pcie->msg_res->start);
+
+		r++;
+	}
+	resource_list_for_each_entry(entry, &bridge->windows) {
+		struct resource *res = entry->res;
+		u64 pci_addr = res->start - entry->offset;
+
+		if (resource_type(res) == IORESOURCE_IO)
+			cdns_pcie_hpa_set_outbound_region(pcie, busnr, 0, r,
+							  true,
+							  pci_pio_to_address(res->start),
+							  pci_addr,
+							  resource_size(res));
+		else
+			cdns_pcie_hpa_set_outbound_region(pcie, busnr, 0, r,
+							  false,
+							  res->start,
+							  pci_addr,
+							  resource_size(res));
+
+		r++;
+	}
+
+	if (rc->no_inbound_map)
+		return 0;
+	else
+		return cdns_pcie_hpa_host_map_dma_ranges(rc);
+}
+
+static int cdns_pcie_hpa_host_init(struct cdns_pcie_rc *rc)
+{
+	int err;
+
+	err = cdns_pcie_hpa_host_init_root_port(rc);
+	if (err)
+		return err;
+
+	return cdns_pcie_hpa_host_init_address_translation(rc);
+}
+
+int cdns_pcie_hpa_host_link_setup(struct cdns_pcie_rc *rc)
+{
+	struct cdns_pcie *pcie = &rc->pcie;
+	struct device *dev = rc->pcie.dev;
+	int ret;
+
+	if (rc->quirk_detect_quiet_flag)
+		cdns_pcie_hpa_detect_quiet_min_delay_set(&rc->pcie);
+
+	cdns_pcie_hpa_host_enable_ptm_response(pcie);
+
+	ret = cdns_pcie_start_link(pcie);
+	if (ret) {
+		dev_err(dev, "Failed to start link\n");
+		return ret;
+	}
+
+	ret = cdns_pcie_hpa_host_wait_for_link(pcie);
+	if (ret)
+		dev_dbg(dev, "PCIe link never came up\n");
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_hpa_host_link_setup);
+
+int cdns_pcie_hpa_host_setup(struct cdns_pcie_rc *rc)
+{
+	struct device *dev = rc->pcie.dev;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct pci_host_bridge *bridge;
+	enum cdns_pcie_rp_bar bar;
+	struct cdns_pcie *pcie;
+	struct resource *res;
+	int ret;
+
+	bridge = pci_host_bridge_from_priv(rc);
+	if (!bridge)
+		return -ENOMEM;
+
+	pcie = &rc->pcie;
+	pcie->is_rc = true;
+
+	if (!pcie->reg_base) {
+		pcie->reg_base = devm_platform_ioremap_resource_byname(pdev, "reg");
+		if (IS_ERR(pcie->reg_base)) {
+			dev_err(dev, "missing \"reg\"\n");
+			return PTR_ERR(pcie->reg_base);
+		}
+	}
+
+	/* ECAM config space is remapped at glue layer */
+	if (!rc->cfg_base) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
+		rc->cfg_base = devm_pci_remap_cfg_resource(dev, res);
+		if (IS_ERR(rc->cfg_base))
+			return PTR_ERR(rc->cfg_base);
+		rc->cfg_res = res;
+	}
+
+	/* Put EROM Bar aperture to 0 */
+	cdns_pcie_hpa_writel(pcie, REG_BANK_IP_CFG_CTRL_REG, CDNS_PCIE_EROM, 0x0);
+
+	ret = cdns_pcie_hpa_host_link_setup(rc);
+	if (ret)
+		return ret;
+
+	for (bar = RP_BAR0; bar <= RP_NO_BAR; bar++)
+		rc->avail_ib_bar[bar] = true;
+
+	ret = cdns_pcie_hpa_host_init(rc);
+	if (ret)
+		return ret;
+
+	if (!bridge->ops)
+		bridge->ops = &cdns_pcie_hpa_host_ops;
+
+	return pci_host_probe(bridge);
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_hpa_host_setup);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Cadence PCIe host controller driver");
diff --git a/drivers/pci/controller/cadence/pcie-cadence-hpa-regs.h b/drivers/pci/controller/cadence/pcie-cadence-hpa-regs.h
new file mode 100644
index 000000000000..026e131600de
--- /dev/null
+++ b/drivers/pci/controller/cadence/pcie-cadence-hpa-regs.h
@@ -0,0 +1,193 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Cadence PCIe controller driver.
+ *
+ * Copyright (c) 2024, Cadence Design Systems
+ * Author: Manikandan K Pillai <mpillai@cadence.com>
+ */
+#ifndef _PCIE_CADENCE_HPA_REGS_H
+#define _PCIE_CADENCE_HPA_REGS_H
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/pci-epf.h>
+#include <linux/phy/phy.h>
+#include <linux/bitfield.h>
+
+/* High Performance Architecture (HPA) PCIe controller registers */
+#define CDNS_PCIE_HPA_IP_REG_BANK		0x01000000
+#define CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK	0x01003C00
+#define CDNS_PCIE_HPA_IP_AXI_MASTER_COMMON	0x02020000
+
+/* Address Translation Registers */
+#define CDNS_PCIE_HPA_AXI_SLAVE                 0x03000000
+#define CDNS_PCIE_HPA_AXI_MASTER                0x03002000
+
+/* Root Port register base address */
+#define CDNS_PCIE_HPA_RP_BASE			0x0
+
+#define CDNS_PCIE_HPA_LM_ID			0x1420
+
+/* Endpoint Function BARs */
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG(bar, fn) \
+	(((bar) < BAR_3) ? CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG0(fn) : \
+			CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG1(fn))
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG0(pfn) (0x4000 * (pfn))
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG1(pfn) ((0x4000 * (pfn)) + 0x04)
+#define CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG(bar, fn) \
+	(((bar) < BAR_3) ? CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG0(fn) : \
+			CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG1(fn))
+#define CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG0(vfn) ((0x4000 * (vfn)) + 0x08)
+#define CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG1(vfn) ((0x4000 * (vfn)) + 0x0C)
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(f) \
+	(GENMASK(5, 0) << (0x4 + (f) * 10))
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE(b, a) \
+	(((a) << (4 + ((b) * 10))) & (CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b)))
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(f) \
+	(GENMASK(3, 0) << ((f) * 10))
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, c) \
+	(((c) << ((b) * 10)) & (CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b)))
+
+/* Endpoint Function Configuration Register */
+#define CDNS_PCIE_HPA_LM_EP_FUNC_CFG		0x02C0
+
+/* Root Complex BAR Configuration Register */
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG                        0x14
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_APERTURE_MASK     GENMASK(9, 4)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_APERTURE(a) \
+	FIELD_PREP(CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_APERTURE_MASK, a)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_CTRL_MASK         GENMASK(3, 0)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_CTRL(c) \
+	FIELD_PREP(CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_CTRL_MASK, c)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_APERTURE_MASK     GENMASK(19, 14)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_APERTURE(a) \
+	FIELD_PREP(CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_APERTURE_MASK, a)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_CTRL_MASK         GENMASK(13, 10)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_CTRL(c) \
+	FIELD_PREP(CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_CTRL_MASK, c)
+
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_PREFETCH_MEM_ENABLE BIT(20)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_PREFETCH_MEM_64BITS BIT(21)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_IO_ENABLE           BIT(22)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_IO_32BITS           BIT(23)
+
+/* BAR control values applicable to both Endpoint Function and Root Complex */
+#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_DISABLED              0x0
+#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_IO_32BITS             0x3
+#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_32BITS            0x1
+#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS   0x9
+#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_64BITS            0x5
+#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS   0xD
+
+#define HPA_LM_RC_BAR_CFG_CTRL_DISABLED(bar)                \
+		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_DISABLED << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_CTRL_IO_32BITS(bar)               \
+		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_IO_32BITS << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar)              \
+		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_32BITS << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar) \
+		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar)              \
+		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_64BITS << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar) \
+		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_APERTURE(bar, aperture)           \
+		(((aperture) - 7) << (((bar) * 10) + 4))
+
+#define CDNS_PCIE_HPA_LM_PTM_CTRL		0x0520
+#define CDNS_PCIE_HPA_LM_PTM_CTRL_PTMRSEN	BIT(17)
+
+/* Root Port Registers PCI config space for root port function */
+#define CDNS_PCIE_HPA_RP_CAP_OFFSET	0xC0
+
+/* Region r Outbound AXI to PCIe Address Translation Register 0 */
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(r)            (0x1010 + ((r) & 0x1F) * 0x0080)
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS_MASK    GENMASK(5, 0)
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS(nbits) \
+	(((nbits) - 1) & CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS_MASK)
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN_MASK    GENMASK(23, 16)
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN_MASK, devfn)
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS_MASK      GENMASK(31, 24)
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS(bus) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS_MASK, bus)
+
+/* Region r Outbound AXI to PCIe Address Translation Register 1 */
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(r)            (0x1014 + ((r) & 0x1F) * 0x0080)
+
+/* Region r Outbound PCIe Descriptor Register */
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0(r)                (0x1008 + ((r) & 0x1F) * 0x0080)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK         GENMASK(28, 24)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MEM  \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x0)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_IO   \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x2)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0  \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x4)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE1  \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x5)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_NORMAL_MSG  \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x10)
+
+/* Region r Outbound PCIe Descriptor Register */
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1(r)        (0x100C + ((r) & 0x1F) * 0x0080)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS_MASK  GENMASK(31, 24)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS(bus) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS_MASK, bus)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN_MASK    GENMASK(23, 16)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(devfn) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN_MASK, devfn)
+
+#define CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(r)         (0x1018 + ((r) & 0x1F) * 0x0080)
+#define CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_BUS BIT(26)
+#define CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN BIT(25)
+
+/* Region r AXI Region Base Address Register 0 */
+#define CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(r)     (0x1000 + ((r) & 0x1F) * 0x0080)
+#define CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS_MASK    GENMASK(5, 0)
+#define CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS(nbits) \
+	(((nbits) - 1) & CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS_MASK)
+
+/* Region r AXI Region Base Address Register 1 */
+#define CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(r)     (0x1004 + ((r) & 0x1F) * 0x0080)
+
+/* Root Port BAR Inbound PCIe to AXI Address Translation Register */
+#define CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0(bar)              (((bar) * 0x0008))
+#define CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS_MASK        GENMASK(5, 0)
+#define CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS(nbits) \
+	(((nbits) - 1) & CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS_MASK)
+#define CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR1(bar)              (0x04 + ((bar) * 0x0008))
+
+/* AXI link down register */
+#define CDNS_PCIE_HPA_AT_LINKDOWN 0x04
+
+/*
+ * Physical Layer Configuration Register 0
+ * This register contains the parameters required for functional setup
+ * of Physical Layer.
+ */
+#define CDNS_PCIE_HPA_PHY_LAYER_CFG0               0x0400
+#define CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY_MASK  GENMASK(26, 24)
+#define CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY(delay) \
+	FIELD_PREP(CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY_MASK, delay)
+#define CDNS_PCIE_HPA_LINK_TRNG_EN_MASK  GENMASK(27, 27)
+
+#define CDNS_PCIE_HPA_PHY_DBG_STS_REG0             0x0420
+
+#define CDNS_PCIE_HPA_RP_MAX_IB     0x3
+#define CDNS_PCIE_HPA_MAX_OB        15
+
+/* Endpoint Function BAR Inbound PCIe to AXI Address Translation Register */
+#define CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar) (((fn) * 0x0080) + ((bar) * 0x0008))
+#define CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar) (0x4 + ((fn) * 0x0080) + ((bar) * 0x0008))
+
+/* Miscellaneous offsets definitions */
+#define CDNS_PCIE_HPA_TAG_MANAGEMENT        0x0
+#define CDNS_PCIE_HPA_SLAVE_RESP            0x100
+
+#define I_ROOT_PORT_REQ_ID_REG              0x141c
+#define LM_HAL_SBSA_CTRL                    0x1170
+
+#define I_PCIE_BUS_NUMBERS                  (CDNS_PCIE_HPA_RP_BASE + 0x18)
+#define CDNS_PCIE_EROM                      0x18
+#endif /* _PCIE_CADENCE_HPA_REGS_H */
diff --git a/drivers/pci/controller/cadence/pcie-cadence-hpa.c b/drivers/pci/controller/cadence/pcie-cadence-hpa.c
new file mode 100644
index 000000000000..91db406e62d7
--- /dev/null
+++ b/drivers/pci/controller/cadence/pcie-cadence-hpa.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cadence PCIe controller driver.
+ *
+ * Copyright (c) 2024, Cadence Design Systems
+ * Author: Manikandan K Pillai <mpillai@cadence.com>
+ */
+#include <linux/kernel.h>
+#include <linux/of.h>
+
+#include "pcie-cadence.h"
+
+bool cdns_pcie_hpa_link_up(struct cdns_pcie *pcie)
+{
+	u32 pl_reg_val;
+
+	pl_reg_val = cdns_pcie_hpa_readl(pcie, REG_BANK_IP_REG, CDNS_PCIE_HPA_PHY_DBG_STS_REG0);
+	if (pl_reg_val & GENMASK(0, 0))
+		return true;
+	return false;
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_hpa_link_up);
+
+void cdns_pcie_hpa_detect_quiet_min_delay_set(struct cdns_pcie *pcie)
+{
+	u32 delay = 0x3;
+	u32 ltssm_control_cap;
+
+	/* Set the LTSSM Detect Quiet state min. delay to 2ms */
+	ltssm_control_cap = cdns_pcie_hpa_readl(pcie, REG_BANK_IP_REG,
+						CDNS_PCIE_HPA_PHY_LAYER_CFG0);
+	ltssm_control_cap = ((ltssm_control_cap &
+			    ~CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY_MASK) |
+			    CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY(delay));
+
+	cdns_pcie_hpa_writel(pcie, REG_BANK_IP_REG,
+			     CDNS_PCIE_HPA_PHY_LAYER_CFG0, ltssm_control_cap);
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_hpa_detect_quiet_min_delay_set);
+
+void cdns_pcie_hpa_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
+				       u32 r, bool is_io,
+				       u64 cpu_addr, u64 pci_addr, size_t size)
+{
+	/*
+	 * roundup_pow_of_two() returns an unsigned long, which is not suited
+	 * for 64bit values
+	 */
+	u64 sz = 1ULL << fls64(size - 1);
+	int nbits = ilog2(sz);
+	u32 addr0, addr1, desc0, desc1, ctrl0;
+
+	if (nbits < 8)
+		nbits = 8;
+
+	/* Set the PCI address */
+	addr0 = CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS(nbits) |
+		(lower_32_bits(pci_addr) & GENMASK(31, 8));
+	addr1 = upper_32_bits(pci_addr);
+
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(r), addr0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(r), addr1);
+
+	/* Set the PCIe header descriptor */
+	if (is_io)
+		desc0 = CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_IO;
+	else
+		desc0 = CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MEM;
+	desc1 = 0;
+	ctrl0 = 0;
+
+	/*
+	 * Whether Bit [26] is set or not inside DESC0 register of the outbound
+	 * PCIe descriptor, the PCI function number must be set into
+	 * Bits [31:24] of DESC1 anyway.
+	 *
+	 * In Root Complex mode, the function number is always 0 but in Endpoint
+	 * mode, the PCIe controller may support more than one function. This
+	 * function number needs to be set properly into the outbound PCIe
+	 * descriptor.
+	 *
+	 * Besides, setting Bit [26] is mandatory when in Root Complex mode:
+	 * then the driver must provide the bus, resp. device, number in
+	 * Bits [31:24] of DESC1, resp. Bits[23:16] of DESC0. Like the function
+	 * number, the device number is always 0 in Root Complex mode.
+	 *
+	 * However when in Endpoint mode, we can clear Bit [26] of DESC0, hence
+	 * the PCIe controller will use the captured values for the bus and
+	 * device numbers.
+	 */
+	if (pcie->is_rc) {
+		/* The device and function numbers are always 0 */
+		desc1 = CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS(busnr) |
+			CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(0);
+		ctrl0 = CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_BUS |
+			CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN;
+	} else {
+		/*
+		 * Use captured values for bus and device numbers but still
+		 * need to set the function number
+		 */
+		desc1 |= CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(fn);
+	}
+
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_DESC0(r), desc0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_DESC1(r), desc1);
+
+	addr0 = CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS(nbits) |
+		(lower_32_bits(cpu_addr) & GENMASK(31, 8));
+	addr1 = upper_32_bits(cpu_addr);
+
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(r), addr0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(r), addr1);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(r), ctrl0);
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_hpa_set_outbound_region);
+
+void cdns_pcie_hpa_set_outbound_region_for_normal_msg(struct cdns_pcie *pcie,
+						      u8 busnr, u8 fn,
+						      u32 r, u64 cpu_addr)
+{
+	u32 addr0, addr1, desc0, desc1, ctrl0;
+
+	desc0 = CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_NORMAL_MSG;
+	desc1 = 0;
+	ctrl0 = 0;
+
+	/* See cdns_pcie_set_outbound_region() comments above */
+	if (pcie->is_rc) {
+		desc1 = CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS(busnr) |
+			CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(0);
+		ctrl0 = CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_BUS |
+			CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN;
+	} else {
+		desc1 |= CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(fn);
+	}
+
+	addr0 = CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS(17) |
+		(lower_32_bits(cpu_addr) & GENMASK(31, 8));
+	addr1 = upper_32_bits(cpu_addr);
+
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(r), 0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(r), 0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_DESC0(r), desc0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_DESC1(r), desc1);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(r), addr0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(r), addr1);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(r), ctrl0);
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_hpa_set_outbound_region_for_normal_msg);
+
+void cdns_pcie_hpa_reset_outbound_region(struct cdns_pcie *pcie, u32 r)
+{
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(r), 0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(r), 0);
+
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_DESC0(r), 0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_DESC1(r), 0);
+
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(r), 0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(r), 0);
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_hpa_reset_outbound_region);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Cadence PCIe controller driver");
diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
index ebd5c3afdfcd..b067a3296dd3 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -22,10 +22,6 @@ struct cdns_plat_pcie {
 	struct cdns_pcie        *pcie;
 };
 
-struct cdns_plat_pcie_of_data {
-	bool is_rc;
-};
-
 static const struct of_device_id cdns_plat_pcie_of_match[];
 
 static u64 cdns_plat_cpu_addr_fixup(struct cdns_pcie *pcie, u64 cpu_addr)
diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index 8186947134d6..e6f1a4ac0fb7 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -23,6 +23,17 @@ u16 cdns_pcie_find_ext_capability(struct cdns_pcie *pcie, u8 cap)
 }
 EXPORT_SYMBOL_GPL(cdns_pcie_find_ext_capability);
 
+bool cdns_pcie_linkup(struct cdns_pcie *pcie)
+{
+	u32 pl_reg_val;
+
+	pl_reg_val = cdns_pcie_readl(pcie, CDNS_PCIE_LM_BASE);
+	if (pl_reg_val & GENMASK(0, 0))
+		return true;
+	return false;
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_linkup);
+
 void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie)
 {
 	u32 delay = 0x3;
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 0b8ba4ed5913..928809193c23 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -12,6 +12,7 @@
 #include <linux/pci-epf.h>
 #include <linux/phy/phy.h>
 #include "pcie-cadence-lga-regs.h"
+#include "pcie-cadence-hpa-regs.h"
 
 enum cdns_pcie_rp_bar {
 	RP_BAR_UNDEFINED = -1,
@@ -26,18 +27,57 @@ struct cdns_pcie_rp_ib_bar {
 };
 
 struct cdns_pcie;
+struct cdns_pcie_rc;
+
+enum cdns_pcie_reg_bank {
+	REG_BANK_RP,
+	REG_BANK_IP_REG,
+	REG_BANK_IP_CFG_CTRL_REG,
+	REG_BANK_AXI_MASTER_COMMON,
+	REG_BANK_AXI_MASTER,
+	REG_BANK_AXI_SLAVE,
+	REG_BANK_AXI_HLS,
+	REG_BANK_AXI_RAS,
+	REG_BANK_AXI_DTI,
+	REG_BANKS_MAX,
+};
 
 struct cdns_pcie_ops {
-	int	(*start_link)(struct cdns_pcie *pcie);
-	void	(*stop_link)(struct cdns_pcie *pcie);
-	bool	(*link_up)(struct cdns_pcie *pcie);
+	int     (*start_link)(struct cdns_pcie *pcie);
+	void    (*stop_link)(struct cdns_pcie *pcie);
+	bool    (*link_up)(struct cdns_pcie *pcie);
 	u64     (*cpu_addr_fixup)(struct cdns_pcie *pcie, u64 cpu_addr);
 };
 
+/**
+ * struct cdns_plat_pcie_of_data - Register bank offset for a platform
+ * @is_rc: controller is a RC
+ * @ip_reg_bank_offset: ip register bank start offset
+ * @ip_cfg_ctrl_reg_offset: ip config control register start offset
+ * @axi_mstr_common_offset: AXI master common register start offset
+ * @axi_slave_offset: AXI slave start offset
+ * @axi_master_offset: AXI master start offset
+ * @axi_hls_offset: AXI HLS offset start
+ * @axi_ras_offset: AXI RAS offset
+ * @axi_dti_offset: AXI DTI offset
+ */
+struct cdns_plat_pcie_of_data {
+	u32 is_rc:1;
+	u32 ip_reg_bank_offset;
+	u32 ip_cfg_ctrl_reg_offset;
+	u32 axi_mstr_common_offset;
+	u32 axi_slave_offset;
+	u32 axi_master_offset;
+	u32 axi_hls_offset;
+	u32 axi_ras_offset;
+	u32 axi_dti_offset;
+};
+
 /**
  * struct cdns_pcie - private data for Cadence PCIe controller drivers
  * @reg_base: IO mapped register base
  * @mem_res: start/end offsets in the physical system memory to map PCI accesses
+ * @msg_res: Region for send message to map PCI accesses
  * @dev: PCIe controller
  * @is_rc: tell whether the PCIe controller mode is Root Complex or Endpoint.
  * @phy_count: number of supported PHY devices
@@ -45,16 +85,19 @@ struct cdns_pcie_ops {
  * @link: list of pointers to corresponding device link representations
  * @ops: Platform-specific ops to control various inputs from Cadence PCIe
  *       wrapper
+ * @cdns_pcie_reg_offsets: Register bank offsets for different SoC
  */
 struct cdns_pcie {
-	void __iomem		*reg_base;
-	struct resource		*mem_res;
-	struct device		*dev;
-	bool			is_rc;
-	int			phy_count;
-	struct phy		**phy;
-	struct device_link	**link;
-	const struct cdns_pcie_ops *ops;
+	void __iomem		             *reg_base;
+	struct resource		             *mem_res;
+	struct resource                      *msg_res;
+	struct device		             *dev;
+	bool			             is_rc;
+	int			             phy_count;
+	struct phy		             **phy;
+	struct device_link	             **link;
+	const  struct cdns_pcie_ops          *ops;
+	const  struct cdns_plat_pcie_of_data *cdns_pcie_reg_offsets;
 };
 
 /**
@@ -70,6 +113,8 @@ struct cdns_pcie {
  *                available
  * @quirk_retrain_flag: Retrain link as quirk for PCIe Gen2
  * @quirk_detect_quiet_flag: LTSSM Detect Quiet min delay set as quirk
+ * @ecam_supported: Whether the ECAM is supported
+ * @no_inbound_map: Whether inbound mapping is supported
  */
 struct cdns_pcie_rc {
 	struct cdns_pcie	pcie;
@@ -80,6 +125,8 @@ struct cdns_pcie_rc {
 	bool			avail_ib_bar[CDNS_PCIE_RP_MAX_IB];
 	unsigned int		quirk_retrain_flag:1;
 	unsigned int		quirk_detect_quiet_flag:1;
+	unsigned int            ecam_supported:1;
+	unsigned int            no_inbound_map:1;
 };
 
 /**
@@ -132,6 +179,43 @@ struct cdns_pcie_ep {
 	unsigned int		quirk_disable_flr:1;
 };
 
+static inline u32 cdns_reg_bank_to_off(struct cdns_pcie *pcie, enum cdns_pcie_reg_bank bank)
+{
+	u32 offset = 0x0;
+
+	switch (bank) {
+	case REG_BANK_RP:
+		offset = 0;
+		break;
+	case REG_BANK_IP_REG:
+		offset = pcie->cdns_pcie_reg_offsets->ip_reg_bank_offset;
+		break;
+	case REG_BANK_IP_CFG_CTRL_REG:
+		offset = pcie->cdns_pcie_reg_offsets->ip_cfg_ctrl_reg_offset;
+		break;
+	case REG_BANK_AXI_MASTER_COMMON:
+		offset = pcie->cdns_pcie_reg_offsets->axi_mstr_common_offset;
+		break;
+	case REG_BANK_AXI_MASTER:
+		offset = pcie->cdns_pcie_reg_offsets->axi_master_offset;
+		break;
+	case REG_BANK_AXI_SLAVE:
+		offset = pcie->cdns_pcie_reg_offsets->axi_slave_offset;
+		break;
+	case REG_BANK_AXI_HLS:
+		offset = pcie->cdns_pcie_reg_offsets->axi_hls_offset;
+		break;
+	case REG_BANK_AXI_RAS:
+		offset = pcie->cdns_pcie_reg_offsets->axi_ras_offset;
+		break;
+	case REG_BANK_AXI_DTI:
+		offset = pcie->cdns_pcie_reg_offsets->axi_dti_offset;
+		break;
+	default:
+		break;
+	};
+	return offset;
+}
 
 /* Register access */
 static inline void cdns_pcie_writel(struct cdns_pcie *pcie, u32 reg, u32 value)
@@ -144,6 +228,27 @@ static inline u32 cdns_pcie_readl(struct cdns_pcie *pcie, u32 reg)
 	return readl(pcie->reg_base + reg);
 }
 
+static inline void cdns_pcie_hpa_writel(struct cdns_pcie *pcie,
+					enum cdns_pcie_reg_bank bank,
+					u32 reg,
+					u32 value)
+{
+	u32 offset = cdns_reg_bank_to_off(pcie, bank);
+
+	reg += offset;
+	writel(value, pcie->reg_base + reg);
+}
+
+static inline u32 cdns_pcie_hpa_readl(struct cdns_pcie *pcie,
+				      enum cdns_pcie_reg_bank bank,
+				      u32 reg)
+{
+	u32 offset = cdns_reg_bank_to_off(pcie, bank);
+
+	reg += offset;
+	return readl(pcie->reg_base + reg);
+}
+
 static inline u16 cdns_pcie_readw(struct cdns_pcie *pcie, u32 reg)
 {
 	return readw(pcie->reg_base + reg);
@@ -239,6 +344,29 @@ static inline u16 cdns_pcie_rp_readw(struct cdns_pcie *pcie, u32 reg)
 	return cdns_pcie_read_sz(addr, 0x2);
 }
 
+static inline void cdns_pcie_hpa_rp_writeb(struct cdns_pcie *pcie,
+					   u32 reg, u8 value)
+{
+	void __iomem *addr = pcie->reg_base + CDNS_PCIE_HPA_RP_BASE + reg;
+
+	cdns_pcie_write_sz(addr, 0x1, value);
+}
+
+static inline void cdns_pcie_hpa_rp_writew(struct cdns_pcie *pcie,
+					   u32 reg, u16 value)
+{
+	void __iomem *addr = pcie->reg_base + CDNS_PCIE_HPA_RP_BASE + reg;
+
+	cdns_pcie_write_sz(addr, 0x2, value);
+}
+
+static inline u16 cdns_pcie_hpa_rp_readw(struct cdns_pcie *pcie, u32 reg)
+{
+	void __iomem *addr = pcie->reg_base + CDNS_PCIE_HPA_RP_BASE + reg;
+
+	return cdns_pcie_read_sz(addr, 0x2);
+}
+
 /* Endpoint Function register access */
 static inline void cdns_pcie_ep_fn_writeb(struct cdns_pcie *pcie, u8 fn,
 					  u32 reg, u8 value)
@@ -303,6 +431,7 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc);
 void cdns_pcie_host_disable(struct cdns_pcie_rc *rc);
 void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
 			       int where);
+int cdns_pcie_hpa_host_setup(struct cdns_pcie_rc *rc);
 #else
 static inline int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
 {
@@ -319,6 +448,11 @@ static inline int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 	return 0;
 }
 
+static inline int cdns_pcie_hpa_host_setup(struct cdns_pcie_rc *rc)
+{
+	return 0;
+}
+
 static inline void cdns_pcie_host_disable(struct cdns_pcie_rc *rc)
 {
 }
@@ -333,6 +467,7 @@ static inline void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int d
 #if IS_ENABLED(CONFIG_PCIE_CADENCE_EP)
 int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep);
 void cdns_pcie_ep_disable(struct cdns_pcie_ep *ep);
+int cdns_pcie_hpa_ep_setup(struct cdns_pcie_ep *ep);
 #else
 static inline int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 {
@@ -342,10 +477,19 @@ static inline int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 static inline void cdns_pcie_ep_disable(struct cdns_pcie_ep *ep)
 {
 }
+
+static inline int cdns_pcie_hpa_ep_setup(struct cdns_pcie_ep *ep)
+{
+	return 0;
+}
+
 #endif
 
-u8 cdns_pcie_find_capability(struct cdns_pcie *pcie, u8 cap);
-u16 cdns_pcie_find_ext_capability(struct cdns_pcie *pcie, u8 cap);
+u8   cdns_pcie_find_capability(struct cdns_pcie *pcie, u8 cap);
+u16  cdns_pcie_find_ext_capability(struct cdns_pcie *pcie, u8 cap);
+bool cdns_pcie_linkup(struct cdns_pcie *pcie);
+int  cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie);
+int  cdns_pcie_host_start_link(struct cdns_pcie_rc *rc);
 
 void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie);
 
@@ -359,8 +503,22 @@ void cdns_pcie_set_outbound_region_for_normal_msg(struct cdns_pcie *pcie,
 
 void cdns_pcie_reset_outbound_region(struct cdns_pcie *pcie, u32 r);
 void cdns_pcie_disable_phy(struct cdns_pcie *pcie);
-int cdns_pcie_enable_phy(struct cdns_pcie *pcie);
-int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie);
+int  cdns_pcie_enable_phy(struct cdns_pcie *pcie);
+int  cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie);
+void cdns_pcie_hpa_detect_quiet_min_delay_set(struct cdns_pcie *pcie);
+void cdns_pcie_hpa_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
+				       u32 r, bool is_io,
+				       u64 cpu_addr, u64 pci_addr, size_t size);
+void cdns_pcie_hpa_set_outbound_region_for_normal_msg(struct cdns_pcie *pcie,
+						      u8 busnr, u8 fn,
+						      u32 r, u64 cpu_addr);
+void cdns_pcie_hpa_reset_outbound_region(struct cdns_pcie *pcie, u32 r);
+int  cdns_pcie_hpa_host_link_setup(struct cdns_pcie_rc *rc);
+void __iomem *cdns_pci_hpa_map_bus(struct pci_bus *bus, unsigned int devfn,
+				   int where);
+int  cdns_pcie_hpa_host_start_link(struct cdns_pcie_rc *rc);
+bool cdns_pcie_hpa_link_up(struct cdns_pcie *pcie);
+
 extern const struct dev_pm_ops cdns_pcie_pm_ops;
 
 #endif /* _PCIE_CADENCE_H */
-- 
2.49.0


