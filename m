Return-Path: <linux-pci+bounces-31039-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7C3AED348
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 06:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3CD37A735F
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 04:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113941D5ACE;
	Mon, 30 Jun 2025 04:16:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022084.outbound.protection.outlook.com [52.101.126.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B6719F40B;
	Mon, 30 Jun 2025 04:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751256976; cv=fail; b=NHDr4XhFPk08l7YiF9Skj8h3/cX+YlBS9N9oYvbHTiaV1w91G+oiw+xmDuwT5TsOZkQYJ+CVF4OuXTgXyQ22kZsEmRfKKKqlA9qmQBmmtfA5+shaaYupw3dRrA431vVHlLIJdazDHXY8twTUwy1P4RZeSn8MYhiHCQXIisWo4Fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751256976; c=relaxed/simple;
	bh=RFqxZUWlaVwIU4UWPQ58/Ui6tsgZzH8JZazd4kEqDa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=toVFRQ6VRPiDID5Pf3ES0VDHkEqNIIOnkmqBypK04TQWUDiHVH9oFS2eKgaNRWfEAT8/2LoCKkIa7OLvsPcZNWc/uuGs6byHulxA55jFXEV6+gB/7moG5B8vKrytcwAc4wO78ORpUjdzR6lYpoqTpyQBpdbudhwve5djTSWEP8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AXPgiVydpK6RcPg+nsVwCxb2GiWyayh+g75CHuOwd6HxIuEibpqWPXiR10UGiwm7ZSSDs8rXwIdbp6otjgc8JhzxO/gNsk5SaIqPEgicB5RRPeo22ipb5JC7ck747l4AoUOYOlJR/Jjx2gWeA8ZLzMMeJ+YBMsnzu9xYONsdHPTKdYmZif0NjlGvJn5AD9kJaX0i7gV96rbcCrVghC9KanSMxGqhn6TldaQzW0cRCQtAqScyVt+PjbmKiSq32siGpBMS2bpZok9jPBWjaK2QOQqa9+t9m1CqdquAqbGoq+wNPvPV+ps6C8KxZlO9o8yAv7PEJq89U0Ij65dtsziyQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdjHPF21ChxYKXmXajrI8SapJj/mzgYd8E+wbfiR6MM=;
 b=g0xjLwofSHIJs2zJKyYZIgPR/60dA/qy65b+xF1uXMK3yT0wHyrNKwsixFzCFuyFXHzSlBV4R4S0OzTDchgCKkMrcptPBuQAxilwMrQ/LVP8pub4s70QgsjfnpqTiU0ubbUJvCV4BVTmjPkNwQrhn1tmJHubU1ORg+Krs8bFTktB8dYtsbG4wqQqzH0iFUxVSFflpy7jtbmZ6TdbLBGGLAmNX5LDMl2nigUy7kVgNaw7agdmDta/owzv2P1g8TzHkwgnSqwPBPZOV0W4l4IjObefWB/ShropcMz630TLsdK8DKbl0WUuMeLKd33UbVKB92BOcRW5dSAkwU6XLm+5Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI1PR02CA0036.apcprd02.prod.outlook.com (2603:1096:4:1f6::20)
 by TYZPR06MB5528.apcprd06.prod.outlook.com (2603:1096:400:28e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Mon, 30 Jun
 2025 04:16:10 +0000
Received: from SG2PEPF000B66CC.apcprd03.prod.outlook.com
 (2603:1096:4:1f6:cafe::3c) by SI1PR02CA0036.outlook.office365.com
 (2603:1096:4:1f6::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.31 via Frontend Transport; Mon,
 30 Jun 2025 04:16:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CC.mail.protection.outlook.com (10.167.240.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 04:16:09 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id C00DA41604F7;
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
Subject: [PATCH v5 09/14] PCI: cadence: Add support for PCIe HPA controller platform
Date: Mon, 30 Jun 2025 12:15:56 +0800
Message-ID: <20250630041601.399921-10-hans.zhang@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CC:EE_|TYZPR06MB5528:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5d8067ac-4d77-465b-a968-08ddb78cd7a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nnlVUPCMN1r9WIYhV4k3M44aVwMjfx4sE9ARyKaIN4QKWZsTg45gZv6q0KVl?=
 =?us-ascii?Q?Oyx3QWUTWf8EuRelTz1MOKMu4/6iLFxu7CiAolaU+OLNTZVascGaThO+MOpo?=
 =?us-ascii?Q?igENxB0L6rOdYPk0KCII+Jz2/zbZ9B573AC++MefOuJxZg25xho04JUbrgso?=
 =?us-ascii?Q?6RRaogyQM7H4MUEob5hPxoqy0+jO/xCNY/BlQVxnb5eS0MoUW5j5mcqAtpZO?=
 =?us-ascii?Q?AXjNiMPac5faAOUea+TFz+VpEpnHV0Zp/tRH85YHAn9/L0FBs3PF3Mg5TUMc?=
 =?us-ascii?Q?Djo1jw8XqbaSRbZp32cvTkUfEoEqIGVrgN9lMXiFjcwJ/HuMP8sxYAg+0Meh?=
 =?us-ascii?Q?bZgSh9YQO9FgyjhaMpaaCE4W4f4ns+45CLAyWQU5LP1WTCm9A7i9+x2QCouU?=
 =?us-ascii?Q?KCKW2HAQVZSMOIl55Fsb1okPZoVH5smfWdRAzdyhl4Hz/gIE/iQbopD1b458?=
 =?us-ascii?Q?spmVNfR5H2wgawE5Pz0TfrPikShn/rks1u47gVmbUGu9KIZHK7CwSTPx5m3B?=
 =?us-ascii?Q?6olDv82vCFUFwO5v9vqS0YQSlP+4AjTmxjb2HqjxpCfZVzeySqb9uAo0kHOL?=
 =?us-ascii?Q?NMEx+TUPamDAI2sihEbiPctaGeCZH2X0Pi/KQXRzd5ddv9H65ebn9p4Au2P/?=
 =?us-ascii?Q?pp++Y0QG5c8detNdL2VoOgGs9Z71xdfD3QTSFUIqAdDGPFt1PLUZvrSaQVCT?=
 =?us-ascii?Q?87XC804P1aiJRnB0KdAz29+hwTJ1tvlt/EdmfJ5uP4r+Bb2qIeX7Mqw6yrBL?=
 =?us-ascii?Q?59jRCFp6ZVkc+Ftwq0fUOO+H6N81H66YR5XZiOI2nO+l24aaC5S+1dwbpjkN?=
 =?us-ascii?Q?naE3pV+drKROxb5A+21mX15RvWhrYXD/MFMz5DAsYsDe52zbdvNnOnnRxgS3?=
 =?us-ascii?Q?HYh4SavBHBz4FreE9Ua9Aq2DOHw4TnthORGnvjQW2s/FZ3mr8FqTfLc7eEny?=
 =?us-ascii?Q?ebh+t/1GGYguBHdLLvZoz+uTFgps8E5jP5/bgFmYGi7eATH0YuSZQi6encdB?=
 =?us-ascii?Q?MBFc6Jkz71mbGCFawRAs36VvXc5yCAOShfROs/UuVS6xL7MVG6hACfm7fnDm?=
 =?us-ascii?Q?ovbySSFrxm4vU65PyHbA2AnDJu2SO6eMvzHjAscqTc0G+wiSkIpiXIRav9JU?=
 =?us-ascii?Q?qdyLlxksJMoI6aHHzp4FuwCfB4rYSd6JSw01A16ZxgOWQ3IGJ4k19M8NyC/6?=
 =?us-ascii?Q?SPqu30DFSX8aJckx3eerKdltIqSOzhH3LUx17jWJfQiVA7m/veEEvrqlPaYD?=
 =?us-ascii?Q?c615hAG/Jyfawap9jr177LWlA8/2cAZlgRTAYjQfMagwytnkQcYYG7SSEFae?=
 =?us-ascii?Q?IL6fMb+vuchQpMdZ/KIFT78psT8WiNho5yaBpm8C+1E9YnpLXbvMhM1FxgeN?=
 =?us-ascii?Q?6cwNKoAnkcnYcV56+9jdbpHcco6303c9h4+RXi9E8LuhlMED4wrbyYULhCsG?=
 =?us-ascii?Q?2oHDI7urvBZfdrsN6Kv8UdVe5+1ozVuXIgZBHysGYKAgo9QuSqoY1JqYGgnm?=
 =?us-ascii?Q?dUuxyuvxWIzuzUy7hlqNk4djgYx24MK4mXTH?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 04:16:09.5985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8067ac-4d77-465b-a968-08ddb78cd7a4
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CC.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5528

From: Manikandan K Pillai <mpillai@cadence.com>

Add support for Cadence HPA PCIe controller based platform.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
Co-developed-by: Hans Zhang <hans.zhang@cixtech.com>
Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 drivers/pci/controller/cadence/Kconfig        |   5 +
 drivers/pci/controller/cadence/Makefile       |   1 +
 .../cadence/pcie-cadence-plat-hpa.c           | 183 ++++++++++++++++++
 3 files changed, 189 insertions(+)
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-plat-hpa.c

diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
index a1caf154888d..427aa9beca22 100644
--- a/drivers/pci/controller/cadence/Kconfig
+++ b/drivers/pci/controller/cadence/Kconfig
@@ -29,11 +29,15 @@ config PCIE_CADENCE_EP
 config PCIE_CADENCE_PLAT
 	bool
 
+config PCIE_CADENCE_PLAT_HPA
+	bool
+
 config PCIE_CADENCE_PLAT_HOST
 	bool "Cadence platform PCIe controller (host mode)"
 	depends on OF
 	select PCIE_CADENCE_HOST
 	select PCIE_CADENCE_PLAT
+	select PCIE_CADENCE_PLAT_HPA
 	help
 	  Say Y here if you want to support the Cadence PCIe platform controller in
 	  host mode. This PCIe controller may be embedded into many different
@@ -45,6 +49,7 @@ config PCIE_CADENCE_PLAT_EP
 	depends on PCI_ENDPOINT
 	select PCIE_CADENCE_EP
 	select PCIE_CADENCE_PLAT
+	select PCIE_CADENCE_PLAT_HPA
 	help
 	  Say Y here if you want to support the Cadence PCIe platform controller in
 	  endpoint mode. This PCIe controller may be embedded into many
diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
index e2df24ff4c33..f8575a0eee2d 100644
--- a/drivers/pci/controller/cadence/Makefile
+++ b/drivers/pci/controller/cadence/Makefile
@@ -5,4 +5,5 @@ obj-$(CONFIG_PCIE_CADENCE_HOST_COMMON) += pcie-cadence-host-common.o
 obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o pcie-cadence-host-hpa.o
 obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o pcie-cadence-ep-hpa.o
 obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
+obj-$(CONFIG_PCIE_CADENCE_PLAT_HPA) += pcie-cadence-plat-hpa.o
 obj-$(CONFIG_PCI_J721E) += pci-j721e.o
diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat-hpa.c b/drivers/pci/controller/cadence/pcie-cadence-plat-hpa.c
new file mode 100644
index 000000000000..fb42547d47d2
--- /dev/null
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat-hpa.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cadence PCIe platform  driver.
+ *
+ * Copyright (c) 2019, Cadence Design Systems
+ * Author: Manikandan K Pillai <mpillai@cadence.com>
+ */
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_pci.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include "pcie-cadence.h"
+
+/**
+ * struct cdns_plat_pcie - private data for this PCIe platform driver
+ * @pcie: Cadence PCIe controller
+ */
+struct cdns_plat_pcie {
+	struct cdns_pcie        *pcie;
+};
+
+static const struct cdns_pcie_ops cdns_plat_hpa_ops = {
+	.start_link = cdns_pcie_hpa_start_link,
+	.stop_link = cdns_pcie_hpa_stop_link,
+	.link_up = cdns_pcie_hpa_link_up,
+};
+
+static int cdns_plat_pcie_hpa_probe(struct platform_device *pdev)
+{
+	const struct cdns_plat_pcie_of_data *data;
+	struct cdns_plat_pcie *cdns_plat_pcie;
+	struct device *dev = &pdev->dev;
+	struct pci_host_bridge *bridge;
+	struct cdns_pcie_ep *ep;
+	struct cdns_pcie_rc *rc;
+	int phy_count;
+	bool is_rc;
+	int ret;
+
+	data = of_device_get_match_data(dev);
+	if (!data)
+		return -EINVAL;
+
+	is_rc = data->is_rc;
+
+	pr_debug(" Started %s with is_rc: %d\n", __func__, is_rc);
+	cdns_plat_pcie = devm_kzalloc(dev, sizeof(*cdns_plat_pcie), GFP_KERNEL);
+	if (!cdns_plat_pcie)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, cdns_plat_pcie);
+	if (is_rc) {
+		if (!IS_ENABLED(CONFIG_PCIE_CADENCE_PLAT_HOST))
+			return -ENODEV;
+
+		bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
+		if (!bridge)
+			return -ENOMEM;
+
+		rc = pci_host_bridge_priv(bridge);
+		rc->pcie.dev = dev;
+		rc->pcie.ops = &cdns_plat_hpa_ops;
+		rc->pcie.is_rc = data->is_rc;
+
+		/*
+		 * Store the register bank offsets pointer
+		 */
+		rc->pcie.cdns_pcie_reg_offsets = data;
+
+		cdns_plat_pcie->pcie = &rc->pcie;
+
+		ret = cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
+		if (ret) {
+			dev_err(dev, "failed to init phy\n");
+			return ret;
+		}
+		pm_runtime_enable(dev);
+		ret = pm_runtime_get_sync(dev);
+		if (ret < 0) {
+			dev_err(dev, "pm_runtime_get_sync() failed\n");
+			goto err_get_sync;
+		}
+
+		ret = cdns_pcie_hpa_host_setup(rc);
+		if (ret)
+			goto err_init;
+	} else {
+		if (!IS_ENABLED(CONFIG_PCIE_CADENCE_PLAT_EP))
+			return -ENODEV;
+
+		ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
+		if (!ep)
+			return -ENOMEM;
+
+		ep->pcie.dev = dev;
+		ep->pcie.ops = &cdns_plat_hpa_ops;
+		ep->pcie.is_rc = data->is_rc;
+
+		/*
+		 * Store the register bank offset pointer
+		 */
+		ep->pcie.cdns_pcie_reg_offsets = data;
+
+		cdns_plat_pcie->pcie = &ep->pcie;
+
+		ret = cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
+		if (ret) {
+			dev_err(dev, "failed to init phy\n");
+			return ret;
+		}
+
+		pm_runtime_enable(dev);
+		ret = pm_runtime_get_sync(dev);
+		if (ret < 0) {
+			dev_err(dev, "pm_runtime_get_sync() failed\n");
+			goto err_get_sync;
+		}
+
+		ret = cdns_pcie_hpa_ep_setup(ep);
+		if (ret)
+			goto err_init;
+	}
+
+	return 0;
+
+ err_init:
+ err_get_sync:
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+	cdns_pcie_disable_phy(cdns_plat_pcie->pcie);
+	phy_count = cdns_plat_pcie->pcie->phy_count;
+	while (phy_count--)
+		device_link_del(cdns_plat_pcie->pcie->link[phy_count]);
+
+	return 0;
+}
+
+static void cdns_plat_pcie_hpa_shutdown(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cdns_pcie *pcie = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_put_sync(dev);
+	if (ret < 0)
+		dev_dbg(dev, "pm_runtime_put_sync failed\n");
+
+	pm_runtime_disable(dev);
+
+	cdns_pcie_disable_phy(pcie);
+}
+
+static const struct cdns_plat_pcie_of_data cdns_plat_pcie_hpa_host_of_data = {
+	.is_rc = true,
+};
+
+static const struct cdns_plat_pcie_of_data cdns_plat_pcie_hpa_ep_of_data = {
+	.is_rc = false,
+};
+
+static const struct of_device_id cdns_plat_pcie_hpa_of_match[] = {
+	{
+		.compatible = "cdns,cdns-pcie-hpa-host",
+		.data = &cdns_plat_pcie_hpa_host_of_data,
+	},
+	{
+		.compatible = "cdns,cdns-pcie-hpa-ep",
+		.data = &cdns_plat_pcie_hpa_ep_of_data,
+	},
+	{},
+};
+
+static struct platform_driver cdns_plat_pcie_hpa_driver = {
+	.driver = {
+		.name = "cdns-pcie-hpa",
+		.of_match_table = cdns_plat_pcie_hpa_of_match,
+		.pm	= &cdns_pcie_pm_ops,
+	},
+	.probe = cdns_plat_pcie_hpa_probe,
+	.shutdown = cdns_plat_pcie_hpa_shutdown,
+};
+builtin_platform_driver(cdns_plat_pcie_hpa_driver);
-- 
2.49.0


