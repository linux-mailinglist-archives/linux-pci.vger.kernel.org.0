Return-Path: <linux-pci+bounces-35254-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E87B3DE4E
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 11:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00197189F27C
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 09:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E46D31AF1B;
	Mon,  1 Sep 2025 09:21:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023115.outbound.protection.outlook.com [52.101.127.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5C130E847;
	Mon,  1 Sep 2025 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718478; cv=fail; b=kivA1CqAK06JMg9Dc85BrpHav5hmmVYaa0mopr+lKzNLk6GFZuW9YOgr9kef1MADnGvzdKtXKlE5JG4h30YUCFm6nlAGuBFZMl8Xov7Pnwo257MMIbcKuePVhl14zWzMQXKEUIll++D5W9eFDDPowfi79+dn0uqEWcS6O9EfsOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718478; c=relaxed/simple;
	bh=fiTmmeLvlVLzofdpbXvFtqNDElKfmYUKaJRi+7AYhms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dFvGrtpPQM3QYR2afuO5NgqIbKr1m/ZQBs6otljcpslnUaoW2AVlBnug/dTw54j7vBJFgMmBsXCiKuPD+DxUAwDUCcTvwYAQ78d4fvIA6kn0aXERxsbqxtTfP53M2CaM5P30IeXAXcImV+LaoXUXc1CIcYi5tXN2e5MMJ90/SlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aOzCpQ1vRJeeQnzUtA7aCnaUTsce6YnY1LRuKOok4yqtgf4i+dBnimnND7wOTXwDxAC+fy1T/bpNo4Ldz+yVASHuFuqj/unYio22rsmotMW6D8osuokcCn0ZUoGu4g6CJKfJXlw0KKoC77jshwcz/rlw+n9dV+KatFgHTEy/hkU4ZWAaomFCWBKwLHbrHQc12HEagiqmakpMwOXggUZUdDmkNl158nb6XguClqTi6lfua1Dg8GyT+uLQulBgHJwi7aHRbpRMl0AHUnjGCKomg1LpV4WX6rUqDxerX09sF+swpJw0ibRDKeitsOh8sgXX1x3N34LJro59TPuMLdiijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aEiGFp15mjrANsOATivEH47+WT0E+NtnKM7CpBFz444=;
 b=MRG2C4fW3lF5DRmRfvSmqFBcAMG5JXxGvTiYH644FjMCHDXLo8tNZv5DEUyiXLak+H46ttkB3/0E0x150Xct+S6KJd6ovZTQwC27mte1yZEkeUPjt3OF+tQOXDhnCUuBVbVrL62V8Qv7SZgjPDYtwivuzPrQxboCBpgBZt8IQW/8kIQrrEMhYxvnvgjx5jvjT8QRbf+76+GsKbC6EtObRWx4+9693JPwiio1BExYtj5i18VY4YzB0tBpdRmR5tm7/uWpAj1PXjfz5wFMyd6Lh93d14eMFQ5xYC+fZIFjl4bjzmB0B32hYR2UAKNpCLC3sGW8sTwMWAX+Y2CKM+uKJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR06CA0241.apcprd06.prod.outlook.com (2603:1096:4:ac::25) by
 SEYPR06MB6708.apcprd06.prod.outlook.com (2603:1096:101:167::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.21; Mon, 1 Sep 2025 09:21:10 +0000
Received: from SG2PEPF000B66CE.apcprd03.prod.outlook.com
 (2603:1096:4:ac:cafe::f4) by SG2PR06CA0241.outlook.office365.com
 (2603:1096:4:ac::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.26 via Frontend Transport; Mon,
 1 Sep 2025 09:21:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CE.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Mon, 1 Sep 2025 09:21:09 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 7241341604EB;
	Mon,  1 Sep 2025 17:21:05 +0800 (CST)
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
Subject: [PATCH v9 11/14] PCI: sky1: Add PCIe host support for CIX Sky1
Date: Mon,  1 Sep 2025 17:20:49 +0800
Message-ID: <20250901092052.4051018-12-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250901092052.4051018-1-hans.zhang@cixtech.com>
References: <20250901092052.4051018-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CE:EE_|SEYPR06MB6708:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2eef85ad-4225-4c33-d03b-08dde938e30a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sl/EJI/AqGJUhlVFuzu8EdUvM1doTR0cUVEM8p2exfWDb7NACtCLYr4g33b3?=
 =?us-ascii?Q?pU0gI6knBI2Ith01CQtXkOYPCfuh8GLg06qv9Ltr3obTmYXNhGZ2PrIh89mu?=
 =?us-ascii?Q?Ap6BeB5JzCVVSGNg89ADDY5KKlXrbs2/CmmYV1TY59s7m7+o4MWK/zW/PVnb?=
 =?us-ascii?Q?rZXftPU6s0dmU34/9t3AI2W8Op1OYWmCqGsithnz96AAq+cMFuBhuV+J37Bu?=
 =?us-ascii?Q?LUTL6278lm9USxcxwOSf3NJMP/j+K5I3TSG9D2p6k9wW2+mUbkiVglv+Qp/n?=
 =?us-ascii?Q?v4hSNGgYqc5ua232xex0Rp9mqIM48eVmnWISyU7yO2rW7DtPJM5+6Mvu6FmP?=
 =?us-ascii?Q?09+Uj0ZpSWs2iwexD54NrDTEmPbccWPobr8w7sFuX4D2dsfCQNbQYed8MP5f?=
 =?us-ascii?Q?oI8N4ILiAigyHou1nvc7/6k6Craxr80Wt3dTB4oNa8SJuc1aXroaX1yO/xlT?=
 =?us-ascii?Q?k8cJk7FLzURFJeRdX0Vs+a6C5GhHtqoSkm7ggfg6QgZWSqvi0QXE91Xh8ZR5?=
 =?us-ascii?Q?JAtB9s8ExIlNN5xaJrVy8sMtFPVgc7tjFWjcNWfOYgNRu3ZgNmhzTa7zlZ5o?=
 =?us-ascii?Q?5g1ghGR5N3FXs9PuPXhIKuAaXedbZB9TT3Xa9shg088Enob2xIWkYSaXqiJd?=
 =?us-ascii?Q?ORWN45y3hJK57Cg3ztlbfkQZeflUdDOWvfz0ELy5K6XB0NgH1cEasC+0/P6D?=
 =?us-ascii?Q?UVe52QOqyWpvvzKyjK8MvAIvtTtFAcPoCd0P0izUorEV2rz1AzWS2S4uar5F?=
 =?us-ascii?Q?yoicPBa0ctqT1BHROXYLgNInM+xIZqHtA8pyLfySpjsdf3FlFSRuG90uXhtC?=
 =?us-ascii?Q?HWm6aj+LEGlWCQ4uyrIvjv+dzQS9UOwvaiRy/MrvGrarDAmYZd0iieap2XQR?=
 =?us-ascii?Q?BmXsGMCgApqrlHp26LFqIP9UgaaHYN8heuzcWK9NAfsqmVABZt+U4Veo//J0?=
 =?us-ascii?Q?RTxHN5v8aIgFjocw6udmpfVQ5S1g0O/hRYsBnvNcwvr0On3nU4ZmfXHyzu8N?=
 =?us-ascii?Q?fWsgZNY398H5OM7gl3r+HoZhKAHN1z4ZQtJ+Obq3AVjO0q3ObrVUTQCRsMH9?=
 =?us-ascii?Q?z90cD11SwPwo1bSs7lKVnDF2qbwx0bwGbpTWB1za4G2MdzjgxKLhakpAjlHr?=
 =?us-ascii?Q?h5jRUPk6ch71G4xq3hASotJQ4Zcb0xSshhTzQO2KLoInby/nGiM7FdHBDzxS?=
 =?us-ascii?Q?k11Qqw3ebJr0d5Jmd0hLh16ge4UO9Je+/fQmcMi/UDDcML3jsbDwjOl3AnQd?=
 =?us-ascii?Q?X6hr2FWKiKpbXfTgJZLyVdZuin3aeHTGqQzHOYglagNfq9U/RZeIgLkp0i+6?=
 =?us-ascii?Q?rT+2/xmuspAdntTv4phWwCiG8uJgn4Gb6NqKhbjmAfuu4dzISeusZdN9/ItS?=
 =?us-ascii?Q?Rwk9iebsuRsu96swZ2ZTa5ZFmjbadoBKpcrXi0G+c0QPjCPz0lol/XIIlMk4?=
 =?us-ascii?Q?gGpoMStG5TGMY0H3ZNmmgPXwv6WXu9Dp3w5O2WAUKcBaWay2skrnIP3TmAW4?=
 =?us-ascii?Q?1fo6MFDnG/yiyPn+4niEBiyeCX++aAqgDpY9?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 09:21:09.1378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eef85ad-4225-4c33-d03b-08dde938e30a
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CE.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6708

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
index 117677a23d68..26a248cdc78a 100644
--- a/drivers/pci/controller/cadence/Kconfig
+++ b/drivers/pci/controller/cadence/Kconfig
@@ -42,6 +42,21 @@ config PCIE_CADENCE_PLAT_EP
 	  endpoint mode. This PCIe controller may be embedded into many
 	  different vendors SoCs.
 
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
index ee3bd0a69b5c..f70c0df67c77 100644
--- a/drivers/pci/controller/cadence/Makefile
+++ b/drivers/pci/controller/cadence/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host-mod.o
 obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep-mod.o
 obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
 obj-$(CONFIG_PCI_J721E) += pci-j721e.o
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


