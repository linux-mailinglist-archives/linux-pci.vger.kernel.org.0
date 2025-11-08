Return-Path: <linux-pci+bounces-40630-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE79C42DB1
	for <lists+linux-pci@lfdr.de>; Sat, 08 Nov 2025 15:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96BCA1887F3F
	for <lists+linux-pci@lfdr.de>; Sat,  8 Nov 2025 14:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5556722538F;
	Sat,  8 Nov 2025 14:03:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022114.outbound.protection.outlook.com [40.107.75.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D0C1FCCF8;
	Sat,  8 Nov 2025 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762610597; cv=fail; b=GNCU0gNkhRMxrDnGgyjwoI9qClsTc+ptZQfisDZdbzBv44qaLe+VVT8syfjli8t/eur2P0AvwlJxRE6R+g/ArmO+Gq99pduOC13La/7QXKthVLVEpNA8FSMPttDuVyHDmwO9bcRF1JAmNGssPflLuga5MEk8v0nf1YjBOwug+g0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762610597; c=relaxed/simple;
	bh=fMLjF2v6NRwp6kKXJLnqD5rLfGbGzfNWYLVUDHTaNPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aCdi27Tcz+H7Tk4e+I3bLEn3Ra0DDpMYCexrQrN0FiFlvHU8n0aA6fUPkKDHxnFA85nwhbpqTjmbxj4ygJ8EhwYHAby53chex1KvI/AR+IpRyAu0PjuRzLM8g8pk2zN4QBwhhJTGYqVpNVO/8EOxn5ZrzCXn8oURDp9zlLXm+EM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arnZG0YkpKkAPq2QP7vg7Bpxi1sG+9n7MOefw2yYKM4/5cr0NuyWA73psJyO7D7rMbvPcqcTE5uJ2vfMy9rvfJtUL1Z+ESmRXX57EJkvCSM8nLukQT4Lu+FByH4KDTgdRGjkzTcmR/gnDgqesugqXYS6Bcjq2/Mc5Pe5Y0dsE5J8vsnOwF/K3G/rNHx9erNtkPf/UijJ8Z8KhRNk3uBAVu4iU5ThS6CMKGpv6Uj8uXzp4KJrLJ6+zKRheir+6xPsQMK6XV7LpeCXBE4GdFhcFAPXf3SQovNaW3T8p63lXehvzRsP5QHqjVuncbyQk2nqPXhFmVcOUfnYYPHvpXFwBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhSDlBGVDUOfaDh9K4bNJCtKkrWDyCArocKXz1X9/C4=;
 b=NH4sXtsOAhXNSlp6Mhrkg9SHLFnUqxPyxDGZgeE6r28qn59pIIi00S6W6iDh6uiwBcZa11YJEqDq/4su9Bqr1Rj9B+Bn14/pyUOzWDfCIeJYJ+evcod9idVXy2qYexT1uck3kqTR2wVugy5a9fXvq+uwPqBg/oOAc2WDQQp/joXjMBMvkgbfPOaVjbcXL06lFAl4/zdvKamTdz7Uny4P+jn/2DTjm5ZbM2lwDEc9L/WKjgjGYqE0bJo58Fjs6G1QhykzKMLUsKjwiMzaRNRN33BzvnPnf5cCaSdamYfmzjl9OV06q0s5Gg5wMlDat6VXZAj2EazSnR8QZte0Epbhvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PSBPR02CA0015.apcprd02.prod.outlook.com (2603:1096:301::25) by
 SEZPR06MB6976.apcprd06.prod.outlook.com (2603:1096:101:1f0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.15; Sat, 8 Nov 2025 14:03:11 +0000
Received: from TY2PEPF0000AB87.apcprd03.prod.outlook.com
 (2603:1096:301:0:cafe::ec) by PSBPR02CA0015.outlook.office365.com
 (2603:1096:301::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.15 via Frontend Transport; Sat,
 8 Nov 2025 14:02:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB87.mail.protection.outlook.com (10.167.253.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Sat, 8 Nov 2025 14:03:09 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 40FE54126FFD;
	Sat,  8 Nov 2025 22:03:06 +0800 (CST)
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
Subject: [PATCH v11 07/10] PCI: sky1: Add PCIe host support for CIX Sky1
Date: Sat,  8 Nov 2025 22:03:02 +0800
Message-ID: <20251108140305.1120117-8-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251108140305.1120117-1-hans.zhang@cixtech.com>
References: <20251108140305.1120117-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB87:EE_|SEZPR06MB6976:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ae0cc876-074e-4c82-d078-08de1ecf8ce7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W+DN/rbrlfz7mG/QcwBq8RLPygrl7pCrsOHj+ubxxmJa7DPg2nRinqSAHG4U?=
 =?us-ascii?Q?y9Iz9UWN1NMOTfrDiGBXo5w+Y3YIDn46jfrPHbzWDl9sk4HEEi6QzSBMbgtk?=
 =?us-ascii?Q?uLSIXwH6mZ2Ekaby95AKteMglyy1iDlld+uQ9gGNajg2a9lCheZOpI+KpKYf?=
 =?us-ascii?Q?eLZkjvkQejK20UDTXj0OcbapjdpXbuYrBeGcL7UzJtSsaUWh8Ndb5IV91aNK?=
 =?us-ascii?Q?8bh9rtNNM+rW4wl0sl2apSH4rIsp1pzJWmzfnL3c4PDHVL7OOZa1gy28cPi1?=
 =?us-ascii?Q?PeIOl1mmwSEgPSNO/c3byl4083YjptDuTYQTPT9lRRCoYjrCl8a1E6d8CiFn?=
 =?us-ascii?Q?ejg+DrX65vTvnHVolbiMzJPtlCXQy4kqCWSc82InobdlFPOLrof1Ohp7yIla?=
 =?us-ascii?Q?3rKbftcAu7e/1gPD4hMFMELw2nhHPG7eH4IjVJYypYD654F5oCDZjH7ojXAy?=
 =?us-ascii?Q?VOQIFwZIx2xJOZ2nR8xrReT4h424QH9T6GAQOiiVmQTV6xOVMAMmn2xfQgQc?=
 =?us-ascii?Q?SrMI/C+dUxdfzvIsYGdbv7Fx7NnnlBN4sRzW/H6lmfAX48BJQxvO8R3M5Gmx?=
 =?us-ascii?Q?SnMGqHyaWv3FEtFaYrN0BoQynFccR55h6vYhb2Mu4mNqQtYl3Nn4dQxl2tJf?=
 =?us-ascii?Q?/wR+LRsL6K9P7PYqt+ERS0ryOL3xTL1mAhRHLAnzkWhqxMGxAuHhrW436Hhu?=
 =?us-ascii?Q?HlZNgdPTBFKACg7jYUl7BPN8DX04XhgclEmwMdiJiKfaXB0vWpsgI+qJZyB/?=
 =?us-ascii?Q?3K//0HZy0dNhq6uxbQ2xbcjj8TSNJVjbVAUAwuTzvUR9KZaMMSOZHv7r/E5K?=
 =?us-ascii?Q?Uw/vXQtT+WpFwX6PkA9j/krfQiVSqkA61a+1qG3SgWi9uRx34eWjJfcS/T4U?=
 =?us-ascii?Q?S8JiDC5Zc7FT10Sa+r5RphwvVIP8LaPWgi2GdcQdjx9Tic0e1A9D/2Vojzfi?=
 =?us-ascii?Q?H7mfe1gtNKKJS2/G1t1UQSW2mPm24TamBoxDVVoV1QAVIKal/o5A2PnK1d0g?=
 =?us-ascii?Q?B19jKIgHjP17Ra9owpoDrdxHDu5w6zUaIzYEpfvNWcs+kKk6F2YFBKZkXA8a?=
 =?us-ascii?Q?SlSlJ/QWoieFZP+Y1UIfNZTZcGmgdaLFth9tq+zeNPifxrdEEFpLenWLrwlV?=
 =?us-ascii?Q?idpv3si1eqRdjgw8GDvGft2pMe+DnXpMXyvUVrYfoozw/saNoUCMM2FQOrOF?=
 =?us-ascii?Q?B3b9CG7nWPD62mv8J1ymx9AwYm1zxle19seY5sEOhhBzMKlR/f/Wwh4FbQmu?=
 =?us-ascii?Q?mHvcR1emTqiIlP6jbQDrfGQrKC4NArPrSLb8ZgfbAJNrdJmPcEl33KjDZXNV?=
 =?us-ascii?Q?ftyW2XOLPq5XZx3oHyaQHAuqowMTgWQFaCgOM8Z2oZCT0YA0tXsvjiK7eudX?=
 =?us-ascii?Q?6qjEYceZFvkFaUWDmXDqGO0OuKl0gT6sTJNnLdQM4PdC5aNEBbbAnZVkiNM9?=
 =?us-ascii?Q?B0mQHMxAysDuqoHcywoddkBirVipA+PD1408eFXRoQ4c0+KfUQKlqDN62zIG?=
 =?us-ascii?Q?+lhOWFrNjq4XJs4LsJNiZvBByeuz/RL4MVNFrNBw6zVACDO3b6mWSyGbvZQt?=
 =?us-ascii?Q?CTs7e0Q9xpo3g/B5Q/Q=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 14:03:09.6960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0cc876-074e-4c82-d078-08de1ecf8ce7
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB87.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6976

From: Hans Zhang <hans.zhang@cixtech.com>

Add driver for the CIX Sky1 SoC PCIe Gen4 16 GT/s controller based
on the Cadence PCIe core.

Supports MSI/MSI-x via GICv3, Single Virtual Channel, Single Function.

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 drivers/pci/controller/cadence/Kconfig    |  15 ++
 drivers/pci/controller/cadence/Makefile   |   1 +
 drivers/pci/controller/cadence/pci-sky1.c | 235 ++++++++++++++++++++++
 3 files changed, 251 insertions(+)
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
index 000000000000..ceb36bb74771
--- /dev/null
+++ b/drivers/pci/controller/cadence/pci-sky1.c
@@ -0,0 +1,235 @@
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
+		return dev_err_probe(dev, ENODEV, "unable to get \"cfg\" resource\n");
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
+		return dev_err_probe(dev, ENODEV, "unable to get \"msg\" resource\n");
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
+MODULE_DEVICE_TABLE(of, of_sky1_pcie_match);
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
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+};
+module_platform_driver(sky1_pcie_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("PCIe controller driver for CIX's sky1 SoCs");
+MODULE_AUTHOR("Hans Zhang <hans.zhang@cixtech.com>");
-- 
2.49.0


