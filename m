Return-Path: <linux-pci+bounces-21142-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BD5A303BA
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 07:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B72743A5A1A
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 06:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E031E9B22;
	Tue, 11 Feb 2025 06:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gpNRLsMV"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC32D1E9B21;
	Tue, 11 Feb 2025 06:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739255960; cv=fail; b=ZoFwagdLxFsHhxfY8AW8mEe8eN1k9WE6oGnCmCRRyq/OwHTakLqu4g74KosMgrFjZD64cj9oFYF5nQAbWPSBJIiZwPscxQQltQRePeF2hPggCx/9krPFpsj5Zr5nwqTZalIBlKzECiZ0xm5CqYzIBQNXIbC63DQ10wJaba7xmME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739255960; c=relaxed/simple;
	bh=hTsvYxQvLh9OKW7BcBYGhVFlJHPl5eIM0nDNMIudsPs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i66yWcLK0Ni23Lu6efjZhfNvu0+jBytm0g17A179sQdvTv1KYcPmsVW3WMxVmKoqVTrl5ZbAoneEI8KcyWfqYODlmI32oSA88KyRUvKTHEs6HWk23y64qn8C/Vx2R7FkJjD8a8U5HEniVGGVYGl5vwxTFQ9iankGTkFo718DzEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gpNRLsMV; arc=fail smtp.client-ip=40.107.244.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unVOc+YLAI6r3hN9iQMs03z9Gtzig9yxKo512Hf6ULSn/jh28sBS4ifezXM140U1eWKP3Wi05kQa+wdr2O1EUDzvUT8YJBAHtVjsP/ksPbxerHWVN0rByhdTNw8bGJskUUSeqd9yudS1+i29ld6RzAKXVfUDOljdLjF7SV2GCHt14hH5vVH017l+hr2YDVE5uXW3yyyPC+bkGJCcUGMTVBrDvfjoTq9bFJEnhPzAQvJ4P5VAzJjv6HjsKB7MfH2rJt2LF+rJrcJNvPb72B9JzrYJws0RdNAdiM9El+9EGP17RZYzuB2rg94ljyyJAn62trB8PLMo0QG7K1AaDC4yYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0EinyfNitlltQbcarNFyXiIuUPCeW+orjTCXUs+ky4=;
 b=Vfj1mF5uJKRtpeM11UxsScD8hii+j4Eigut6AY/Cr9O5NIPcSmP73GDP8qJzUQKflJ4QJWOsqUbMc3mccorswBe0u3sVcncZqDGWmfzv070r61/STvsORYIQCD53NM3hjWjcxcrtxAKVlGiu0+fH72ip9Tnp9UlTTY1neCPOQVeslsrjb7IbZ9NHTN3JsBrPb5W0FFsOihAJSjuIxrLcuTx9Csxm7Gd4ikaXeDOJvNdONGVW+D4whbUlUOGSuPZGTkLT+EQ8bZZ4jD3dOpjnTo+vm4osOz4z2PJ2/ujfSwH8NGwJHfjqPSWJb+pQ7Pv1sMCxVdgpMwsP0m7mECNJgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0EinyfNitlltQbcarNFyXiIuUPCeW+orjTCXUs+ky4=;
 b=gpNRLsMVLmfI3hua4A2oyNpj0PNGoxdpcMHUt1Jpw0+CvjoPkE08xV0qbcTI3nYIwoDvgI+f8KBw3EghPuLQS+AmL0d8ZqB+wjcJzCX63xcdx2EZSmNEFiJfnaxSI4OnVk9QK+p/LIHg2QC+1j/tzfeWdAC9nKbl2wegq5KcK0U=
Received: from CH0PR04CA0002.namprd04.prod.outlook.com (2603:10b6:610:76::7)
 by SA0PR12MB4429.namprd12.prod.outlook.com (2603:10b6:806:73::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 06:39:11 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::c5) by CH0PR04CA0002.outlook.office365.com
 (2603:10b6:610:76::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 06:39:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 06:39:11 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 00:39:11 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 00:39:10 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 11 Feb 2025 00:39:06 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jingoohan1@gmail.com>,
	<michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v10 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Date: Tue, 11 Feb 2025 12:08:51 +0530
Message-ID: <20250211063852.319566-4-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250211063852.319566-1-thippeswamy.havalige@amd.com>
References: <20250211063852.319566-1-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|SA0PR12MB4429:EE_
X-MS-Office365-Filtering-Correlation-Id: ef7d1cd9-56ae-45d7-9a17-08dd4a66cb6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jMShRqdWnmS0tC5av5I98H8Fq+CV7YrG2rP+kgcYDZBS2Qyus47IX0P8PgQN?=
 =?us-ascii?Q?CJCdslARoos7bTPvvDTMBu5LvRnKyvxHqBkC0erjqUFWTbYdJ4ElvsF4ZCjk?=
 =?us-ascii?Q?grYnFPsYVCjoIRSx3/GN8iafwhdTR+DP2SZ88UhQGtaTpPBFf6WlkkKVdm8F?=
 =?us-ascii?Q?MwYieDQ7bhI967UoZ40fBQba+lrDAjhZQ2LyShmZK/pxfqcfCCwsH9zVbNHQ?=
 =?us-ascii?Q?GTMaTfvfXIQ7DlNgQ1Hxis02K0rRmeTUaq5GQqcXxgJ5tEfLrsKLUixBs4ZS?=
 =?us-ascii?Q?QOvTmF2jiNcEyYUHVuP3HvCqrUp87JJuJDkiP9ZOwwsBV7lZTzo0LRVcvADS?=
 =?us-ascii?Q?+GpRNMrvZr1meWRgHnP5eOYXWpdIDrJ55vG5xvOBMgh/aEhsR9VqssNLHAEK?=
 =?us-ascii?Q?aIl6+paW34Bzkw123ymZArz2IqiqXEWD1zdLqoBvymhxgRH1zOU5UHlqMVoA?=
 =?us-ascii?Q?EBx/20Od1uILQiAPK2rgkaWez3Finu76lIY6nemyRhIXOIfdRGHEsoW64hxh?=
 =?us-ascii?Q?+UFXxJ9F+SuCrHhXydILewAW4IyuzqXRzRWSUvdV40bL0PapN6UvSYS2ZN/l?=
 =?us-ascii?Q?B0bdciMjNSr9PxTNNPHB4Akn09eRJRf0fmzxCVQWZP8vm8/MQ/PmmdGX2LVc?=
 =?us-ascii?Q?fJsSh1vPTV/eUL1BthWZxlYF/qnCXtuu7KXS+c1R9fFX8s3VDfO8xE7lKLER?=
 =?us-ascii?Q?jKBLeIpVFQQGc8IlqsLhcN5UaMz7LRKYSH+kYnzJJAo0P4afjtEYuPVnDEY5?=
 =?us-ascii?Q?bUuqAkp6pt7U0VJcKWzjDgEZyNTgQnK3Gh+OqVXa7aAX7LNoZYvCbqRi6bAO?=
 =?us-ascii?Q?WaSxyB6eIBmisekKdqitWhnHAi6CRgWmBltPWyzXm/a4TjVHRIvQsvCs0GQz?=
 =?us-ascii?Q?LDnfvFGq4xoX2P1mTNOd2DnFEy92WgxLSlaO8fM5VNv2kaW85/Xm0DvfRGh/?=
 =?us-ascii?Q?uQbuvPhdVHIuZmTNY46ledTWmcJreNLUJ16yzYhriyr7e/wp65c5dWIz6Zn1?=
 =?us-ascii?Q?2MimNGoa3UyJXszMp6/5XT64WUaCXSIZcpY8yc08fbZ+D6buaVrZVHEhCEkE?=
 =?us-ascii?Q?BOSS6di9WBDqqAv2i3puyCCVaYz85yYZF8icy64JaSSsKHz2xSppaT0/aso6?=
 =?us-ascii?Q?/yVBRlvXwxRUdliE8vTd3lg18jy5HGRucT+bIs8utPOfhF+wjF7rGfuL3XtC?=
 =?us-ascii?Q?2+Ikf2lDf1ha8I/aDKis0ZmWhD1uWpWVop5DzbgpEUz25/kNK7Cwc6/7HpDD?=
 =?us-ascii?Q?th6rZBryh1ABxuRX8T+N3twaXq/9ZfOybEnP+QqS7u6zeBYh4EF+LKW4Tj54?=
 =?us-ascii?Q?ckMT0jGENqf1cISj62K9oEnDrP38WCuGj5P9ou3AATf4tdkLFhExhmPB13tm?=
 =?us-ascii?Q?xdOlXHUdHgeVpAmRjaZX7qZLogRmVYBgiWDChEtIecJ0NVSzqe0PVL3oCzdI?=
 =?us-ascii?Q?vowhFXBRJuDUILcHYQ0uk+viTZf+nhd0XweGRCpUMzBH8E2Q46YK9k252nnq?=
 =?us-ascii?Q?q2j+Hm94zvo0VCY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 06:39:11.5643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef7d1cd9-56ae-45d7-9a17-08dd4a66cb6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4429

Add support for AMD MDB (Multimedia DMA Bridge) IP core as Root Port.

The Versal2 devices include MDB Module. The integrated block for MDB along
with the integrated bridge can function as PCIe Root Port controller at
Gen5 32-Gb/s operation per lane.

Bridge supports error and legacy interrupts and are handled using platform
specific interrupt line in Versal2.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
---
changes in v2:
-------------
- Update Gen5 speed in the patch description.
- Modify Kconfig file.
- Update string _leg_ to intx.
- Get platform structure through automic variables.
- Remove _rp_ in function.
Changes in v3:
--------------
-None.
Changes in v4:
--------------
-None.
Changes in v5:
--------------
-None.
Changes in v6:
--------------
- Remove pdev automatic variable.
- Update register name to slcr.
- Fix whitespace.
- remove Spurious extra line.
- Update Legacy to INTx.
- Add space before (SLCR).
- Update menuconfig description.
Changes in v7:
--------------
- None.
Changes in v8:
--------------
- Remove inline keyword.
- Fix indentations.
- Add AMD MDB prefix to interrupt names.
- Remove Kernel doc.
- Fix return types.
- Modify dev_warn to dev_warn_once.
- Add Intx handler & callbacks.
Changes in v10:
---------------
- Add intx assert & deassert macros.
- Move amd_mdb_pcie_init_port function.
- Add kernel doc for error warning messages.
---
 drivers/pci/controller/dwc/Kconfig        |  11 +
 drivers/pci/controller/dwc/Makefile       |   1 +
 drivers/pci/controller/dwc/pcie-amd-mdb.c | 477 ++++++++++++++++++++++
 3 files changed, 489 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-amd-mdb.c

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index b6d6778b0698..61d119646749 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -27,6 +27,17 @@ config PCIE_AL
 	  required only for DT-based platforms. ACPI platforms with the
 	  Annapurna Labs PCIe controller don't need to enable this.
 
+config PCIE_AMD_MDB
+	bool "AMD MDB Versal2 PCIe Host controller"
+	depends on OF || COMPILE_TEST
+	depends on PCI && PCI_MSI
+	select PCIE_DW_HOST
+	help
+	  Say Y here if you want to enable PCIe controller support on AMD
+	  Versal2 SoCs. The AMD MDB Versal2 PCIe controller is based on DesignWare
+	  IP and therefore the driver re-uses the Designware core functions to
+	  implement the driver.
+
 config PCI_MESON
 	tristate "Amlogic Meson PCIe controller"
 	default m if ARCH_MESON
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index a8308d9ea986..ae27eda6ec5e 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_PCIE_DW) += pcie-designware.o
 obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
 obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
 obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
+obj-$(CONFIG_PCIE_AMD_MDB) += pcie-amd-mdb.o
 obj-$(CONFIG_PCIE_BT1) += pcie-bt1.o
 obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
 obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
diff --git a/drivers/pci/controller/dwc/pcie-amd-mdb.c b/drivers/pci/controller/dwc/pcie-amd-mdb.c
new file mode 100644
index 000000000000..eabaf943679d
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
@@ -0,0 +1,477 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe host controller driver for AMD MDB PCIe Bridge
+ *
+ * Copyright (C) 2024-2025, Advanced Micro Devices, Inc.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/of_device.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/resource.h>
+#include <linux/types.h>
+
+#include "pcie-designware.h"
+
+#define AMD_MDB_TLP_IR_STATUS_MISC		0x4C0
+#define AMD_MDB_TLP_IR_MASK_MISC		0x4C4
+#define AMD_MDB_TLP_IR_ENABLE_MISC		0x4C8
+
+#define AMD_MDB_TLP_PCIE_INTX_MASK	GENMASK(23, 16)
+
+#define AMD_MDB_PCIE_INTX_BIT(x) FIELD_PREP(AMD_MDB_TLP_PCIE_INTX_MASK, BIT(x))
+
+#define AMD_MDB_PCIE_INTR_INTX_ASSERT(x)	BIT((x) * 2)
+#define AMD_MDB_PCIE_INTR_INTX_DEASSERT(x)	BIT(((x) * 2) + 1)
+
+/* Interrupt registers definitions */
+#define AMD_MDB_PCIE_INTR_CMPL_TIMEOUT		15
+#define AMD_MDB_PCIE_INTR_INTX			16
+#define AMD_MDB_PCIE_INTR_PM_PME_RCVD		24
+#define AMD_MDB_PCIE_INTR_PME_TO_ACK_RCVD	25
+#define AMD_MDB_PCIE_INTR_MISC_CORRECTABLE	26
+#define AMD_MDB_PCIE_INTR_NONFATAL		27
+#define AMD_MDB_PCIE_INTR_FATAL			28
+
+#define IMR(x) BIT(AMD_MDB_PCIE_INTR_ ##x)
+#define AMD_MDB_PCIE_IMR_ALL_MASK			\
+	(						\
+		IMR(CMPL_TIMEOUT)	|		\
+		IMR(PM_PME_RCVD)	|		\
+		IMR(PME_TO_ACK_RCVD)	|		\
+		IMR(MISC_CORRECTABLE)	|		\
+		IMR(NONFATAL)		|		\
+		IMR(FATAL)		|		\
+		AMD_MDB_TLP_PCIE_INTX_MASK		\
+	)
+
+/**
+ * struct amd_mdb_pcie - PCIe port information
+ * @pci: DesignWare PCIe controller structure
+ * @slcr: MDB System Level Control and Status Register (SLCR) Base
+ * @intx_domain: INTx IRQ domain pointer
+ * @mdb_domain: MDB IRQ domain pointer
+ */
+struct amd_mdb_pcie {
+	struct dw_pcie			pci;
+	void __iomem			*slcr;
+	struct irq_domain		*intx_domain;
+	struct irq_domain		*mdb_domain;
+	int				intx_irq;
+};
+
+static const struct dw_pcie_host_ops amd_mdb_pcie_host_ops = {
+};
+
+static inline u32 pcie_read(struct amd_mdb_pcie *pcie, u32 reg)
+{
+	return readl_relaxed(pcie->slcr + reg);
+}
+
+static inline void pcie_write(struct amd_mdb_pcie *pcie,
+			      u32 val, u32 reg)
+{
+	writel_relaxed(val, pcie->slcr + reg);
+}
+
+static void amd_mdb_intx_irq_mask(struct irq_data *data)
+{
+	struct amd_mdb_pcie *pcie = irq_data_get_irq_chip_data(data);
+	struct dw_pcie *pci = &pcie->pci;
+	struct dw_pcie_rp *port = &pci->pp;
+	unsigned long flags;
+	u32 val;
+
+	raw_spin_lock_irqsave(&port->lock, flags);
+	val = pcie_read(pcie, AMD_MDB_TLP_IR_MASK_MISC);
+	val &= ~AMD_MDB_PCIE_INTX_BIT(data->hwirq);
+	pcie_write(pcie, val, AMD_MDB_TLP_IR_ENABLE_MISC);
+	raw_spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static void amd_mdb_intx_irq_unmask(struct irq_data *data)
+{
+	struct amd_mdb_pcie *pcie = irq_data_get_irq_chip_data(data);
+	struct dw_pcie *pci = &pcie->pci;
+	struct dw_pcie_rp *port = &pci->pp;
+	unsigned long flags;
+	u32 val;
+
+	raw_spin_lock_irqsave(&port->lock, flags);
+	val = pcie_read(pcie, AMD_MDB_TLP_IR_MASK_MISC);
+	val |= AMD_MDB_PCIE_INTX_BIT(data->hwirq);
+	pcie_write(pcie, val, AMD_MDB_TLP_IR_ENABLE_MISC);
+	raw_spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static struct irq_chip amd_mdb_intx_irq_chip = {
+	.name		= "AMD MDB INTx",
+	.irq_mask	= amd_mdb_intx_irq_mask,
+	.irq_unmask	= amd_mdb_intx_irq_unmask,
+};
+
+/**
+ * amd_mdb_pcie_intx_map - Set the handler for the INTx and mark IRQ
+ * as valid
+ * @domain: IRQ domain
+ * @irq: Virtual IRQ number
+ * @hwirq: HW interrupt number
+ *
+ * Return: Always returns 0.
+ */
+static int amd_mdb_pcie_intx_map(struct irq_domain *domain,
+				 unsigned int irq, irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &amd_mdb_intx_irq_chip,
+				 handle_level_irq);
+	irq_set_chip_data(irq, domain->host_data);
+	irq_set_status_flags(irq, IRQ_LEVEL);
+
+	return 0;
+}
+
+/* INTx IRQ Domain operations */
+static const struct irq_domain_ops amd_intx_domain_ops = {
+	.map = amd_mdb_pcie_intx_map,
+};
+
+static int amd_mdb_pcie_init_port(struct amd_mdb_pcie *pcie)
+{
+	int val;
+
+	/* Disable all TLP Interrupts */
+	pcie_write(pcie, pcie_read(pcie, AMD_MDB_TLP_IR_ENABLE_MISC) &
+		   ~AMD_MDB_PCIE_IMR_ALL_MASK,
+		   AMD_MDB_TLP_IR_ENABLE_MISC);
+
+	/* Clear pending TLP interrupts */
+	pcie_write(pcie, pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC) &
+		   AMD_MDB_PCIE_IMR_ALL_MASK,
+		   AMD_MDB_TLP_IR_STATUS_MISC);
+
+	/* Enable all TLP Interrupts */
+	val = pcie_read(pcie, AMD_MDB_TLP_IR_ENABLE_MISC);
+	pcie_write(pcie, (val | AMD_MDB_PCIE_IMR_ALL_MASK),
+		   AMD_MDB_TLP_IR_ENABLE_MISC);
+
+	return 0;
+}
+
+static irqreturn_t amd_mdb_pcie_event_flow(int irq, void *args)
+{
+	struct amd_mdb_pcie *pcie = args;
+	unsigned long val;
+	int i;
+
+	val = pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC);
+	val &= ~pcie_read(pcie, AMD_MDB_TLP_IR_MASK_MISC);
+	for_each_set_bit(i, &val, 32)
+		generic_handle_domain_irq(pcie->mdb_domain, i);
+	pcie_write(pcie, val, AMD_MDB_TLP_IR_STATUS_MISC);
+
+	return IRQ_HANDLED;
+}
+
+#define _IC(x, s)[AMD_MDB_PCIE_INTR_ ## x] = { __stringify(x), s }
+
+static const struct {
+	const char	*sym;
+	const char	*str;
+} intr_cause[32] = {
+	_IC(CMPL_TIMEOUT,	"completion timeout"),
+	_IC(PM_PME_RCVD,	"PM_PME message received"),
+	_IC(PME_TO_ACK_RCVD,	"PME_TO_ACK message received"),
+	_IC(MISC_CORRECTABLE,	"Correctable error message"),
+	_IC(NONFATAL,		"Non fatal error message"),
+	_IC(FATAL,		"Fatal error message"),
+};
+
+static void amd_mdb_event_irq_mask(struct irq_data *d)
+{
+	struct amd_mdb_pcie *pcie = irq_data_get_irq_chip_data(d);
+	struct dw_pcie *pci = &pcie->pci;
+	struct dw_pcie_rp *port = &pci->pp;
+	u32 val;
+
+	raw_spin_lock(&port->lock);
+	val = pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC);
+	val &= ~BIT(d->hwirq);
+	pcie_write(pcie, val, AMD_MDB_TLP_IR_STATUS_MISC);
+	raw_spin_unlock(&port->lock);
+}
+
+static void amd_mdb_event_irq_unmask(struct irq_data *d)
+{
+	struct amd_mdb_pcie *pcie = irq_data_get_irq_chip_data(d);
+	struct dw_pcie *pci = &pcie->pci;
+	struct dw_pcie_rp *port = &pci->pp;
+	u32 val;
+
+	raw_spin_lock(&port->lock);
+	val = pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC);
+	val |= BIT(d->hwirq);
+	pcie_write(pcie, val, AMD_MDB_TLP_IR_STATUS_MISC);
+	raw_spin_unlock(&port->lock);
+}
+
+static struct irq_chip amd_mdb_event_irq_chip = {
+	.name		= "AMD MDB RC-Event",
+	.irq_mask	= amd_mdb_event_irq_mask,
+	.irq_unmask	= amd_mdb_event_irq_unmask,
+};
+
+static int amd_mdb_pcie_event_map(struct irq_domain *domain,
+				  unsigned int irq, irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &amd_mdb_event_irq_chip,
+				 handle_level_irq);
+	irq_set_chip_data(irq, domain->host_data);
+	irq_set_status_flags(irq, IRQ_LEVEL);
+
+	return 0;
+}
+
+static const struct irq_domain_ops event_domain_ops = {
+	.map = amd_mdb_pcie_event_map,
+};
+
+static void amd_mdb_pcie_free_irq_domains(struct amd_mdb_pcie *pcie)
+{
+	if (pcie->intx_domain) {
+		irq_domain_remove(pcie->intx_domain);
+		pcie->intx_domain = NULL;
+	}
+
+	if (pcie->mdb_domain) {
+		irq_domain_remove(pcie->mdb_domain);
+		pcie->mdb_domain = NULL;
+	}
+}
+
+/**
+ * amd_mdb_pcie_init_irq_domains - Initialize IRQ domain
+ * @pcie: PCIe port information
+ * @pdev: platform device
+ * Return: '0' on success and error value on failure
+ */
+static int amd_mdb_pcie_init_irq_domains(struct amd_mdb_pcie *pcie,
+					 struct platform_device *pdev)
+{
+	struct dw_pcie *pci = &pcie->pci;
+	struct dw_pcie_rp *pp = &pci->pp;
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+	struct device_node *pcie_intc_node;
+
+	/* Setup INTx */
+	pcie_intc_node = of_get_next_child(node, NULL);
+	if (!pcie_intc_node) {
+		dev_err(dev, "No PCIe Intc node found\n");
+		return -ENODATA;
+	}
+
+	pcie->mdb_domain = irq_domain_add_linear(pcie_intc_node, 32,
+						 &event_domain_ops, pcie);
+	if (!pcie->mdb_domain) {
+		dev_err(dev, "Failed to add mdb_domain\n");
+		goto out;
+	}
+
+	irq_domain_update_bus_token(pcie->mdb_domain, DOMAIN_BUS_NEXUS);
+
+	pcie->intx_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
+						  &amd_intx_domain_ops, pcie);
+	if (!pcie->intx_domain) {
+		dev_err(dev, "Failed to add intx_domain\n");
+		goto mdb_out;
+	}
+
+	of_node_put(pcie_intc_node);
+	irq_domain_update_bus_token(pcie->intx_domain, DOMAIN_BUS_WIRED);
+
+	raw_spin_lock_init(&pp->lock);
+
+	return 0;
+mdb_out:
+	amd_mdb_pcie_free_irq_domains(pcie);
+out:
+	of_node_put(pcie_intc_node);
+
+	return -ENOMEM;
+}
+
+static irqreturn_t dw_pcie_rp_intx_flow(int irq, void *args)
+{
+	struct amd_mdb_pcie *pcie = args;
+	unsigned long val;
+	int i;
+
+	val = FIELD_GET(AMD_MDB_TLP_PCIE_INTX_MASK,
+			pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC));
+
+	for (i = 0; i < PCI_NUM_INTX; i++) {
+		if (val & AMD_MDB_PCIE_INTR_INTX_ASSERT(i))
+			generic_handle_domain_irq(pcie->intx_domain, i);
+		if (val & AMD_MDB_PCIE_INTR_INTX_DEASSERT(i)
+			generic_handle_domain_irq(pcie->intx_domain, (i * 2) + 1);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t amd_mdb_pcie_intr_handler(int irq, void *args)
+{
+	struct amd_mdb_pcie *pcie = args;
+	struct device *dev;
+	struct irq_data *d;
+
+	dev = pcie->pci.dev;
+
+	/**
+	 * In future, error reporting will be hooked to the AER subsystem.
+	 * Currently, the driver prints a warning message to the user.
+	 */
+	d = irq_domain_get_irq_data(pcie->mdb_domain, irq);
+	if (intr_cause[d->hwirq].str)
+		dev_warn(dev, "%s\n", intr_cause[d->hwirq].str);
+	else
+		dev_warn_once(dev, "Unknown IRQ %ld\n", d->hwirq);
+
+	return IRQ_HANDLED;
+}
+
+static int amd_mdb_setup_irq(struct amd_mdb_pcie *pcie,
+			     struct platform_device *pdev)
+{
+	struct dw_pcie *pci = &pcie->pci;
+	struct dw_pcie_rp *pp = &pci->pp;
+	struct device *dev = &pdev->dev;
+	int i, irq, err;
+
+	amd_mdb_pcie_init_port(pcie);
+
+	pp->irq = platform_get_irq(pdev, 0);
+	if (pp->irq < 0)
+		return pp->irq;
+
+	for (i = 0; i < ARRAY_SIZE(intr_cause); i++) {
+		if (!intr_cause[i].str)
+			continue;
+		irq = irq_create_mapping(pcie->mdb_domain, i);
+		if (!irq) {
+			dev_err(dev, "Failed to map mdb domain interrupt\n");
+			return -ENOMEM;
+		}
+		err = devm_request_irq(dev, irq, amd_mdb_pcie_intr_handler,
+				       IRQF_SHARED | IRQF_NO_THREAD,
+				       intr_cause[i].sym, pcie);
+		if (err) {
+			dev_err(dev, "Failed to request IRQ %d\n", irq);
+			return err;
+		}
+	}
+
+	pcie->intx_irq = irq_create_mapping(pcie->mdb_domain,
+					    AMD_MDB_PCIE_INTR_INTX);
+	if (!pcie->intx_irq) {
+		dev_err(dev, "Failed to map INTx interrupt\n");
+		return -ENXIO;
+	}
+
+	err = devm_request_irq(dev, pcie->intx_irq,
+			       dw_pcie_rp_intx_flow,
+			       IRQF_SHARED | IRQF_NO_THREAD, NULL, pcie);
+	if (err) {
+		dev_err(dev, "Failed to request INTx IRQ %d\n", irq);
+		return err;
+	}
+
+	/* Plug the main event handler */
+	err = devm_request_irq(dev, pp->irq, amd_mdb_pcie_event_flow,
+			       IRQF_SHARED | IRQF_NO_THREAD, "amd_mdb pcie_irq", pcie);
+	if (err) {
+		dev_err(dev, "Failed to request event IRQ %d\n", pp->irq);
+		return err;
+	}
+
+	return 0;
+}
+
+static int amd_mdb_add_pcie_port(struct amd_mdb_pcie *pcie,
+				 struct platform_device *pdev)
+{
+	struct dw_pcie *pci = &pcie->pci;
+	struct dw_pcie_rp *pp = &pci->pp;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	pcie->slcr = devm_platform_ioremap_resource_byname(pdev, "slcr");
+	if (IS_ERR(pcie->slcr))
+		return PTR_ERR(pcie->slcr);
+
+	ret = amd_mdb_pcie_init_irq_domains(pcie, pdev);
+	if (ret)
+		return ret;
+
+	ret = amd_mdb_setup_irq(pcie, pdev);
+	if (ret) {
+		dev_err(dev, "Failed to set up interrupts\n");
+		goto out;
+	}
+
+	pp->ops = &amd_mdb_pcie_host_ops;
+
+	ret = dw_pcie_host_init(pp);
+	if (ret) {
+		dev_err(dev, "Failed to initialize host\n");
+		goto out;
+	}
+
+	return 0;
+
+out:
+	amd_mdb_pcie_free_irq_domains(pcie);
+	return ret;
+}
+
+static int amd_mdb_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct amd_mdb_pcie *pcie;
+	struct dw_pcie *pci;
+
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	pci = &pcie->pci;
+	pci->dev = dev;
+
+	platform_set_drvdata(pdev, pcie);
+
+	return amd_mdb_add_pcie_port(pcie, pdev);
+}
+
+static const struct of_device_id amd_mdb_pcie_of_match[] = {
+	{
+		.compatible = "amd,versal2-mdb-host",
+	},
+	{},
+};
+
+static struct platform_driver amd_mdb_pcie_driver = {
+	.driver = {
+		.name	= "amd-mdb-pcie",
+		.of_match_table = amd_mdb_pcie_of_match,
+		.suppress_bind_attrs = true,
+	},
+	.probe = amd_mdb_pcie_probe,
+};
+builtin_platform_driver(amd_mdb_pcie_driver);
-- 
2.43.0


