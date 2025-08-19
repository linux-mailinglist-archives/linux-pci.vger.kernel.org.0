Return-Path: <linux-pci+bounces-34286-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D370B2C268
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 13:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21B3680CD4
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 11:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62F5335BBC;
	Tue, 19 Aug 2025 11:55:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023108.outbound.protection.outlook.com [40.107.44.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00D932C304;
	Tue, 19 Aug 2025 11:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755604518; cv=fail; b=tupzy6W3DOz2gavJcmDKymtTmKVD199scIdilMaLTKERk9MiP3S3j7MY+BirDfroNw9qkM0LZcP96NLJ8/YTEvIvH8FbWvVJ7WZL8c+avgp9yhlzMmAxAHalymffdPF3wRQ03pLNLFP+beKO3tdeAqZLA1jOl9LR4gCEEsXU5lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755604518; c=relaxed/simple;
	bh=I9n3OJhkKNg3PyE7QqnlRzkDpU7dM8IxaDrQgBrLcao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RV712fox1phNDIAFBb5XMnujvN0/f5xIpK9SxTULHNj1rRg48vNqtKR/c+oC4PSMh7+l4AxSy6ZdRfGvLxg7UsBg8Q7cd8c/qxDAfCyyKgl4FEbg56Ww94PtIdN1uFdTDqu4yrxH4i//MnOW/cCypok8x0G0QAGbOxalu6QobzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jxaVPd1696OrRhMrEcEM/0HEkOua+4H34Xo94lFLZkKBI4soUALRAoop3shikRhktPhkkl3SDKA3QM8wDqXfFY0050s0GEGNl/6WLWMIxWkDSHs6HqgzbgJxf5OQMyBy/nzfx2j+wp77ZsQle3kk8l3HjS8Sh6kIuceAMpvQyytbW0V8cr79TsJOdgv2LOtgPC0k2/94TquvIvD/SyXyWrCliaK7gPxl3NhztlpdIl0JGY9Rmy1FtCiGD66KCvxKYO9fzfNbx9RDhE6HqIju4v8DH0iYmmqUvlpuFT4iV2xghoNTehaIcDqINmVfmRoqqKVPnn1vG4CstLM3OGSifA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGKpRDPv9FYZKhjnMZytXKbMXDRsF2swP/T63r4R7ps=;
 b=gmojmDWDwUniHdknjA6Dnql2+Ggou2q3rQUk1hwGalKRN6R35JTinyOvZulJwemTq9wwmvEYt9tjSkArJdrtFymZsh4ntsI55i4ntUHvri5wfnUcteFEcYP5L2+8SlEnuiKjbk29/uHnU0YLvcoRTE9D/ZL3u7tCbZ5ZWgUawkhalNOK2A4+wuTziC7Kh5FwWAURq6AFXP0zlOlhvDRGvMiFYUryBr5nbTD5YrPGZekPMGPcsdECsBMj/hkPmd93SJbAfWDWkijAFvFVcoVnntCYVnwW2rzz0fSKPxi8qLGadnoDERgj0xa9w9XJ0os4xHB1eu3ATcJ9tRlrHsCaLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TY2PR06CA0047.apcprd06.prod.outlook.com (2603:1096:404:2e::35)
 by TYZPR06MB6513.apcprd06.prod.outlook.com (2603:1096:400:452::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 11:55:12 +0000
Received: from OSA0EPF000000C7.apcprd02.prod.outlook.com
 (2603:1096:404:2e:cafe::8a) by TY2PR06CA0047.outlook.office365.com
 (2603:1096:404:2e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.20 via Frontend Transport; Tue,
 19 Aug 2025 11:55:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C7.mail.protection.outlook.com (10.167.240.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 11:55:10 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id EDA6D4160508;
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
Subject: [PATCH v8 12/15] PCI: sky1: Add PCIe host support for CIX Sky1
Date: Tue, 19 Aug 2025 19:52:36 +0800
Message-ID: <20250819115239.4170604-13-hans.zhang@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C7:EE_|TYZPR06MB6513:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 881a2e06-4c59-44c9-5b7b-08dddf174043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?crleQZmEcbz0KqDRhcnqrZBAWg38sdTgZNdvq3Neckr6xR7tN2i6iUZ9teld?=
 =?us-ascii?Q?zhkVczwxRWsF8J3r/S1f+0hvAb8hsudGOwKvJHu2H0lXqSCAbNyIosAvXno7?=
 =?us-ascii?Q?+Iapz9/IA8xJIn19w3cb5Tzgl7DMkVIe8wldjtMzEbvAKK6kGvtAMLlz/yiJ?=
 =?us-ascii?Q?WvdsuAZztfZN4zKP91TFscnk3RoqpIWwsmwaYkP3vQeoNG/xYKiEs9aBKows?=
 =?us-ascii?Q?lLXApYaRhUu6qN5k94bejolDKB+IakBcSj/1gIAissFCXvStNFOAbaF6XApu?=
 =?us-ascii?Q?cjbRqxm9ZfvwhA1j7sO/jiXd47q+RlWTSM9+RYakKpaJO8wdRLmBYe9O383A?=
 =?us-ascii?Q?G9rPf8kKpaipkm5DJL2o3Hg1KvAkXRGWkCeg6AbkLjbuq43BHLGRToo3/JdO?=
 =?us-ascii?Q?1iv0BUKSk8cIGaW/PxM0cOzcnNAj5rvJgBQ0HlC6+D1G6OnV355bB+icV4e+?=
 =?us-ascii?Q?HDbU5IXVeYycDfonn9US0ygD9htV0oCghv+RsiMzpaCON+FD1stpDJalmbrb?=
 =?us-ascii?Q?QnLtW3JagymuADX6X5oNtccqLhdin5x8KAr1K2DZ8TEa4gnvjQRDmGl0TWqs?=
 =?us-ascii?Q?iJTZFQqubsN+756xg7SJQW+xHhir87/oxang2/GqF4L8YxIjUrTR9E0WpCOh?=
 =?us-ascii?Q?yZiWZvw4uIjrVpv/+MjDeIs7/bcuJjJY0I0LmTDgqg5lmfhLfes+Mrq8LjE8?=
 =?us-ascii?Q?19mzJV0QIj59p2s6f9rzlKmqeKKsJHfQkE4JOw3HVNcrgbVZAJ/KKXU5lNdJ?=
 =?us-ascii?Q?VyCU6jNkxxJvhsazsKh0JRMkYthGIpn/ugB2/2VHp3Yn4wm/y8+V5EGZM8aq?=
 =?us-ascii?Q?g371JmSYVE7TjbehkO9G0o3X3yJGC39hR3ayoPlb7wuxxKEkSnXBbgK0vWDx?=
 =?us-ascii?Q?volvgBVfKzZDcWe5VoEiwbI0lgBSjZj3u/VlHirj4PEhS1pFUc9a3Yv5XBpS?=
 =?us-ascii?Q?neZE/W0HC41lEzXD3+PFVoI9JsnCVgWFKvrTjbOl1bIxnDo7WcokRtISBBH7?=
 =?us-ascii?Q?vrq4cxUKlxpMQGrTdpEfbx9SvUAtJJOgea3On9SWS65HxJ19ulQ9fSVoYdUa?=
 =?us-ascii?Q?vuZNAeVl5+KPL9EESYR6gkGiosC7qMXyTD6btPu1FqB0V2jgZZ0A9DNSSRGX?=
 =?us-ascii?Q?yj4EfrC00Nzoc/CmNBd4F7wTSVm4Jx7OYBxtPuPFZgHpl3Yx4n0mp7z9Z69d?=
 =?us-ascii?Q?DWGLjjpdmKM9Xo1Ff879IJIG6ek6BJPDqYbxSzXzAAYKa2BRE7dNA/q0Hg3M?=
 =?us-ascii?Q?BeF9nz+HBhlAS4qLTKtoU8hRjCDlG467xiluxTFyKS+2nvGiCvuZQwfZqY69?=
 =?us-ascii?Q?F+rGnkVJcLzcQUEFOIEYN0dmg5VY6Q+Wib74ShanH0D3nsW0G3sngVP9i1y8?=
 =?us-ascii?Q?Fe5Q6bR2AV9inii7WMtNrc+jqQcAj34XIT5B6GtRm+ToIF7eafwUlgE4s4LG?=
 =?us-ascii?Q?W7IdIoY+el+j3tUDXeJDBShWJcK6x+njDiQ9jU2wB2FVGWQRr5Gk6y5wFupU?=
 =?us-ascii?Q?z3/3jZVlez34vnF3gYnFf688c323wjBZXFSG?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 11:55:10.9583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 881a2e06-4c59-44c9-5b7b-08dddf174043
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000C7.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6513

From: Hans Zhang <hans.zhang@cixtech.com>

Add driver for the CIX Sky1 SoC PCIe Gen4 16 GT/s controller based
on the Cadence PCIe core.

Supports MSI/MSI-x via GICv3, Single Virtual Channel, Single Function.

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
Changes for v8:
- Optimization of CIX SKY1 Root Port driver. (Bjorn and Krzysztof)
- Use devm_platform_ioremap_resource_byname.
---
 drivers/pci/controller/cadence/Kconfig    |  15 ++
 drivers/pci/controller/cadence/Makefile   |   1 +
 drivers/pci/controller/cadence/pci-sky1.c | 232 ++++++++++++++++++++++
 3 files changed, 248 insertions(+)
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
index 000000000000..7dd3546275c5
--- /dev/null
+++ b/drivers/pci/controller/cadence/pci-sky1.c
@@ -0,0 +1,232 @@
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
+#define STRAP_REG(n)			((n) * 0x04)
+#define STATUS_REG(n)			((n) * 0x04)
+#define  LINK_TRAINING_ENABLE		BIT(0)
+#define  LINK_COMPLETE			BIT(0)
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
+				     "unable to find reg registers\n");
+	pcie->reg_base = base;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
+	if (!res)
+		return dev_err_probe(dev, ENXIO, "unable to get cfg resource\n");
+	pcie->cfg_res = res;
+
+	base = devm_platform_ioremap_resource_byname(pdev, "rcsu_strap");
+	if (IS_ERR(base))
+		return dev_err_probe(dev, PTR_ERR(base),
+				     "unable to find rcsu strap registers\n");
+	pcie->strap_base = base;
+
+	base = devm_platform_ioremap_resource_byname(pdev, "rcsu_status");
+	if (IS_ERR(base))
+		return dev_err_probe(dev, PTR_ERR(base),
+				     "unable to find rcsu status registers\n");
+	pcie->status_base = base;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "msg");
+	if (!res)
+		return dev_err_probe(dev, ENXIO, "unable to get msg resource\n");
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
+		return -ENXIO;
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
+	rc->ecam_support_flag = 1;
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
+	rc->no_inbound_flag = 1;
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


