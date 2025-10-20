Return-Path: <linux-pci+bounces-38706-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EDBBEF49A
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 06:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 995CB4EBE9A
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 04:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169FA2C21E2;
	Mon, 20 Oct 2025 04:29:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023099.outbound.protection.outlook.com [40.107.44.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBD72BEFED;
	Mon, 20 Oct 2025 04:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760934548; cv=fail; b=AwycfrP4y8V+DVBlV3sNZdjx/kwZpIz9a7zLymD4EPfSsQ+pH/4ixoypEHa5Y7/DVWEX4O4mUe2z92qlnbxAwPDpG+h11WC/zukcI2dJWHXfh8WYDKSoKcVrSpWEHtqbK2/ZHHj3i9aSYGSa3Ow2NZKVY+SLcy3uhwp/iu2IurM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760934548; c=relaxed/simple;
	bh=zofDeXcACUdWOszRDN49PnEd92KxSOpfz3Z/P6qtpn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B2tIEKYilzHC5uC+YIMeC18GV6r9gq1ypKAGx34zVyXpRW97LN3+jRF4cWhZMWYSKr7u5gr7Hdz4oVHYSCUQh+roTT3supxprZIhPLoPaDWJ6RE0Cds1FqGJ3pXp6MQcwH1h6zZlIK/xR21tBZhTn9o5scx4dBcO8Lnmv1FFZsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Udmx9wYh6VGj6pJkxhY2g+zGMI8qpabPfQ6kIhCqLVb2LpAMFlRkNsQvWD7lRpvHEzGWTx2bEDI7td+wyGx2l7n5f/iq5di+U1C39H7WgOLrH9GKgc0GBoJTiTkLyZDJdmS+O7yraqwF9NcUaiVxztuIh2oMOshGqcuPngFWoxqrhXG2aqI7VqCsKz3/pdsMuAafE/Q7szKVDTbZ0vf3Gs42AGx+0wj3YWtbjtclU7XKwz1r7vweHuYgenzEXsK2nRLy+cF0hKXZzxNFXYbyTrvO1r6qki4rKQ6JpIftY5c2hJCSuRIqAAfgUmacGKWyRMnNenvVP9Glsd4e5jPRdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCpj7UhNDWjEg9LrsNqZWGXDuw4+M0426URHb6VDkzE=;
 b=UkIFMot+O4mEqQ4jOeRxDqbN0/4NPjutjyOI3VFfCmMYJmiqsgbcmL1gH4txxi9Fta4yk2KKGCsXyO7B+GbuxVFTISQABKJyi5we2PlLXM/vvY7PTKdd16kuSORkTrsgHiB1b0/Ajorr/Y6ZrT8FRBzNTyCrCGSJcm0uxuo46Oc0XUy48k2Ia7ybGE12aVVnTzE66/FeK48HTnZf5NbzowON8VhxQj5Pa7dXRKV2Svky+j4uD4bdDLE7mYceRyfw6H1ZqiAN/+0z/8cbuOhwEUCbwSt9sUDllceTANtQEbXArG5R01/SPezg7dz5RLpnwfIyq/7S5DvBj6QH8vmiOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:300:58::22) by KL1PR06MB6590.apcprd06.prod.outlook.com
 (2603:1096:820:f1::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Mon, 20 Oct
 2025 04:29:02 +0000
Received: from TY2PEPF0000AB87.apcprd03.prod.outlook.com
 (2603:1096:300:58:cafe::74) by PS2PR01CA0034.outlook.office365.com
 (2603:1096:300:58::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Mon,
 20 Oct 2025 04:29:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB87.mail.protection.outlook.com (10.167.253.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 04:29:01 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 09E6E40F0506;
	Mon, 20 Oct 2025 12:28:58 +0800 (CST)
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
Subject: [PATCH v10 07/10] PCI: sky1: Add PCIe host support for CIX Sky1
Date: Mon, 20 Oct 2025 12:28:54 +0800
Message-ID: <20251020042857.706786-8-hans.zhang@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB87:EE_|KL1PR06MB6590:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ccb6bfce-402a-45a7-cfc7-08de0f9131ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mDAAO3iYTI7vIFo6c4mF6vTJeBIsv0AdPhe/Rs9CB7vNPF8xO2Z8hnhGfoMp?=
 =?us-ascii?Q?dgK9tpsipUSuDpMlEs0ed+OxdnBphERIA9gfF+r/9m9KxzozarxC8D3AUzgg?=
 =?us-ascii?Q?WA6OoM5RgeXLBRCrAet3LoOXtLvukNqlt25HmGLGbJ4Xh8jo1fb9U0vIX6tV?=
 =?us-ascii?Q?rer6tfO4tfLDPebATFFVkDtF4n1eQWKDeO+3aPNQKlCDJMoj21d3NYGexDQh?=
 =?us-ascii?Q?/X8LTG3IDtdnpEni6hY1KdZGC8vvvRDODvj4UJkPOzJVxPLjinDQ9rIyDzWv?=
 =?us-ascii?Q?Ic1299Iuvwz+kEK+2zDX9AYDJywEHWGX/flj77FVpuSMYYKe+ylxcosPalqG?=
 =?us-ascii?Q?V3Ld9WacA2Ss1AXTxcYt8WoINnFIJ1RuEvQ1m2zRO7yRGq6mWq5jnrI75A9t?=
 =?us-ascii?Q?k8okwrjsaNjqupBBgXJ0FtW0sRTgEWO9Gno9S6NTFd/Ql3R08UPay0YRFkVx?=
 =?us-ascii?Q?jbbWdzC6+9mLGTN32M3ymfL/DTQIVZ4jQTXlGKOnC1g6hOXpnn7hG3f7oB7a?=
 =?us-ascii?Q?u0btTdoDyMIYjlRCUW2SgYPs2dz3m59G1Jb45w3YEZ0h1qhkxBTRvR9IkQbd?=
 =?us-ascii?Q?t5GjJViF0GfYIgfi13LdhlDkdz6OcL+wI5OKqc3bW5G1SfSrQ2Y61qEVh6ym?=
 =?us-ascii?Q?Xup74oei1JaurCWX+X+JreyFnj+BzsfAb3x9aVeH4oSO+IRZxPg/NiRpoDqe?=
 =?us-ascii?Q?Wj3pJER+d/OEtXtZSDHnKKBee+24/lmmhyusDH1qDdKUZJimz0EH+IZWrSvz?=
 =?us-ascii?Q?DpLo3SyavBKndjPZ0PqCEEEeNnYWk46UPfRXjrVftTVY4PWW6zs32VjXPejC?=
 =?us-ascii?Q?lkD5MzfMY2Ac9i+sGfB6CTwYoOwUoRwLluQTEtdfmmPR6kEQDK37g7odjVEq?=
 =?us-ascii?Q?JjmbdNnc1EVnhL7NtA7tTmLCy4/HTr6BN3LW+L6XFg2bcsOcWHuRLNuQaSaU?=
 =?us-ascii?Q?Rv2SJyoBTL6uklF/ng+sJDNuSvlRn4quUzin7lknics3C85X6jAtQ4GRWyZ/?=
 =?us-ascii?Q?aNYm2P1epxQ++9Kcz9UtAjRSEnx6PT8XUp/ZMEm0u8AAgU1Rvjsh9T3Ya/8u?=
 =?us-ascii?Q?2zQCivjnKs8ti59A+TBdcLo/WxHTMSN4oIcONJYAbictRpT8iTPuQO/5XJpV?=
 =?us-ascii?Q?zzmhATb097RK10OL7x5e3MndQJec8D+ROeJhW33y8K/M4UFl4KKiYsUF5ua+?=
 =?us-ascii?Q?DVa5qQ3BOt22zEmWu71gjXYp06QvbRJE+BFJH816IxN+9RzdbUbauqAUMa9t?=
 =?us-ascii?Q?UBvbYcBFoEXdkYPQWd1pekBc/wtPC0VboZbPPSY/f5a9nVGsy0Bkk19IHHKu?=
 =?us-ascii?Q?doCPohNiiCE+zOGfRq2TCKaley6vQTg7FS4s1VUHd5Vqu5UPEsN2n8lh2xe9?=
 =?us-ascii?Q?j1Xqho5BKRbx23RH5JJFQkBcqQoKq5hBNz8/jkVgXDgVmP3Z80IqKssxn40x?=
 =?us-ascii?Q?3jJLm9ONRCMUSt8ZwKVoL+DG8NNf/WBRf3xmSoPnh+h2WIV8C46qK8fb5g70?=
 =?us-ascii?Q?nmfDLQVB6JGX/jKpB7dqbRVIRcqT+eOiOcgaT8rsodHcPFiS8mhy6IsZY60E?=
 =?us-ascii?Q?Wzie9v7XO5Edy3YCFU8=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 04:29:01.4312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb6bfce-402a-45a7-cfc7-08de0f9131ff
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB87.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6590

From: Hans Zhang <hans.zhang@cixtech.com>

Add driver for the CIX Sky1 SoC PCIe Gen4 16 GT/s controller based
on the Cadence PCIe core.

Supports MSI/MSI-x via GICv3, Single Virtual Channel, Single Function.

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 drivers/pci/controller/cadence/Kconfig    |  15 ++
 drivers/pci/controller/cadence/Makefile   |   1 +
 drivers/pci/controller/cadence/pci-sky1.c | 233 ++++++++++++++++++++++
 3 files changed, 249 insertions(+)
 create mode 100644 drivers/pci/controller/cadence/pci-sky1.c

diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
index 0b96499ae354..ceff65934e5f 100644
--- a/drivers/pci/controller/cadence/Kconfig
+++ b/drivers/pci/controller/cadence/Kconfig
@@ -51,6 +51,21 @@ config PCIE_SG2042_HOST
 	  controller in host mode. Sophgo SG2042 PCIe controller uses Cadence
 	  PCIe core.
 
+config PCI_SKY1_HOST
+	tristate "CIX SKY1 PCIe controller (host mode)"
+	depends on OF
+	select PCIE_CADENCE_HOST
+	select PCI_ECAM
+	help
+	  Say Y here if you want to support the CIX SKY1 PCIe platform
+	  controller in host mode. CIX SKY1 PCIe controller uses Cadence
+	  HPA (High Performance Architecture IP [Second generation of
+	  Cadence PCIe IP])
+
+	  This driver requires Cadence PCIe core infrastructure
+	  (PCIE_CADENCE_HOST) and hardware platform adaptation layer
+	  to function.
+
 config PCI_J721E
 	tristate
 	select PCIE_CADENCE_HOST if PCI_J721E_HOST != n
diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
index 30189045a166..b8ec1cecfaa8 100644
--- a/drivers/pci/controller/cadence/Makefile
+++ b/drivers/pci/controller/cadence/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep-mod.o
 obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
 obj-$(CONFIG_PCI_J721E) += pci-j721e.o
 obj-$(CONFIG_PCIE_SG2042_HOST) += pcie-sg2042.o
+obj-$(CONFIG_PCI_SKY1_HOST) += pci-sky1.o
diff --git a/drivers/pci/controller/cadence/pci-sky1.c b/drivers/pci/controller/cadence/pci-sky1.c
new file mode 100644
index 000000000000..4b0388394db3
--- /dev/null
+++ b/drivers/pci/controller/cadence/pci-sky1.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe controller driver for CIX's sky1 SoCs
+ *
+ * Copyright 2025 Cix Technology Group Co., Ltd.
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
+#define STRAP_REG(n)			((n) * 0x04)
+#define STATUS_REG(n)			((n) * 0x04)
+#define LINK_TRAINING_ENABLE		BIT(0)
+#define LINK_COMPLETE			BIT(0)
+
+#define SKY1_IP_REG_BANK		0x1000
+#define SKY1_IP_CFG_CTRL_REG_BANK	0x4c00
+#define SKY1_IP_AXI_MASTER_COMMON	0xf000
+#define SKY1_AXI_SLAVE			0x9000
+#define SKY1_AXI_MASTER			0xb000
+#define SKY1_AXI_HLS_REGISTERS		0xc000
+#define SKY1_AXI_RAS_REGISTERS		0xe000
+#define SKY1_DTI_REGISTERS		0xd000
+
+#define IP_REG_I_DBG_STS_0		0x420
+
+struct sky1_pcie {
+	struct cdns_pcie *cdns_pcie;
+	struct cdns_pcie_rc *cdns_pcie_rc;
+
+	struct resource *cfg_res;
+	struct resource *msg_res;
+	struct pci_config_window *cfg;
+	void __iomem *strap_base;
+	void __iomem *status_base;
+	void __iomem *reg_base;
+	void __iomem *cfg_base;
+	void __iomem *msg_base;
+};
+
+static int sky1_pcie_resource_get(struct platform_device *pdev,
+				  struct sky1_pcie *pcie)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	void __iomem *base;
+
+	base = devm_platform_ioremap_resource_byname(pdev, "reg");
+	if (IS_ERR(base))
+		return dev_err_probe(dev, PTR_ERR(base),
+				     "unable to find \"reg\" registers\n");
+	pcie->reg_base = base;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
+	if (!res)
+		return dev_err_probe(dev, ENXIO, "unable to get \"cfg\" resource\n");
+	pcie->cfg_res = res;
+
+	base = devm_platform_ioremap_resource_byname(pdev, "rcsu_strap");
+	if (IS_ERR(base))
+		return dev_err_probe(dev, PTR_ERR(base),
+				     "unable to find \"rcsu_strap\" registers\n");
+	pcie->strap_base = base;
+
+	base = devm_platform_ioremap_resource_byname(pdev, "rcsu_status");
+	if (IS_ERR(base))
+		return dev_err_probe(dev, PTR_ERR(base),
+				     "unable to find \"rcsu_status\" registers\n");
+	pcie->status_base = base;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "msg");
+	if (!res)
+		return dev_err_probe(dev, ENXIO, "unable to get \"msg\" resource\n");
+	pcie->msg_res = res;
+	pcie->msg_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(pcie->msg_base)) {
+		return dev_err_probe(dev, PTR_ERR(pcie->msg_base),
+				     "unable to ioremap msg resource\n");
+	}
+
+	return 0;
+}
+
+static int sky1_pcie_start_link(struct cdns_pcie *cdns_pcie)
+{
+	struct sky1_pcie *pcie = dev_get_drvdata(cdns_pcie->dev);
+	u32 val;
+
+	val = readl(pcie->strap_base + STRAP_REG(1));
+	val |= LINK_TRAINING_ENABLE;
+	writel(val, pcie->strap_base + STRAP_REG(1));
+
+	return 0;
+}
+
+static void sky1_pcie_stop_link(struct cdns_pcie *cdns_pcie)
+{
+	struct sky1_pcie *pcie = dev_get_drvdata(cdns_pcie->dev);
+	u32 val;
+
+	val = readl(pcie->strap_base + STRAP_REG(1));
+	val &= ~LINK_TRAINING_ENABLE;
+	writel(val, pcie->strap_base + STRAP_REG(1));
+}
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
+	struct cdns_plat_pcie_of_data *reg_off;
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
+	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
+	if (!bridge)
+		return -ENOMEM;
+
+	ret = sky1_pcie_resource_get(pdev, pcie);
+	if (ret < 0)
+		return ret;
+
+	bus = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
+	if (!bus)
+		return -ENODEV;
+
+	pcie->cfg = pci_ecam_create(dev, pcie->cfg_res, bus->res,
+				    &pci_generic_ecam_ops);
+	if (IS_ERR(pcie->cfg))
+		return PTR_ERR(pcie->cfg);
+
+	bridge->ops = (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
+	rc = pci_host_bridge_priv(bridge);
+	rc->ecam_supported = 1;
+	rc->cfg_base = pcie->cfg->win;
+	rc->cfg_res = &pcie->cfg->res;
+
+	cdns_pcie = &rc->pcie;
+	cdns_pcie->dev = dev;
+	cdns_pcie->ops = &sky1_pcie_ops;
+	cdns_pcie->reg_base = pcie->reg_base;
+	cdns_pcie->msg_res = pcie->msg_res;
+	cdns_pcie->is_rc = 1;
+
+	reg_off = devm_kzalloc(dev, sizeof(*reg_off), GFP_KERNEL);
+	if (!reg_off)
+		return -ENOMEM;
+
+	reg_off->ip_reg_bank_offset = SKY1_IP_REG_BANK;
+	reg_off->ip_cfg_ctrl_reg_offset = SKY1_IP_CFG_CTRL_REG_BANK;
+	reg_off->axi_mstr_common_offset = SKY1_IP_AXI_MASTER_COMMON;
+	reg_off->axi_slave_offset = SKY1_AXI_SLAVE;
+	reg_off->axi_master_offset = SKY1_AXI_MASTER;
+	reg_off->axi_hls_offset = SKY1_AXI_HLS_REGISTERS;
+	reg_off->axi_ras_offset = SKY1_AXI_RAS_REGISTERS;
+	reg_off->axi_dti_offset = SKY1_DTI_REGISTERS;
+	cdns_pcie->cdns_pcie_reg_offsets = reg_off;
+
+	pcie->cdns_pcie = cdns_pcie;
+	pcie->cdns_pcie_rc = rc;
+	pcie->cfg_base = rc->cfg_base;
+	bridge->sysdata = pcie->cfg;
+
+	rc->vendor_id = PCI_VENDOR_ID_CIX;
+	rc->device_id = PCI_DEVICE_ID_CIX_SKY1;
+	rc->no_inbound_map = 1;
+
+	dev_set_drvdata(dev, pcie);
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
+static const struct of_device_id of_sky1_pcie_match[] = {
+	{ .compatible = "cix,sky1-pcie-host", },
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


