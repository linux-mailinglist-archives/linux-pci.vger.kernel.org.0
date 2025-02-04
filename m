Return-Path: <linux-pci+bounces-20700-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B9EA27255
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 13:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9CA188163C
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 12:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F91F2139D8;
	Tue,  4 Feb 2025 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vF0LRSCk"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806612135D8;
	Tue,  4 Feb 2025 12:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738673213; cv=fail; b=iZhTYxxo9vEUfERVeMzsBLx3iQMajfsUjq+3SLf0ytJXOZl45CBk8C1Jvt8V9HEiCxY7xJj3SDLofxHMdBFRuy1NNWBD3fXvLmjLzvGrSktDXc2yBdkgEXwhAJM0EIrj7SFhAiDLJC8XddW6DyGpxbzY2jxQXNNRun577/83m6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738673213; c=relaxed/simple;
	bh=lh7ornp2yQFX6N0TBTyBFR43ut6AyUxsxYYH8S2bu1Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NX1mCpTejUX9qAAvc4t/wdKQw42j7Pff/Yb+SPym3PRnbg5xMPeZAO4iykQFPG7KEzrTTcd+7Y0w8z+x1zZQPoeS/HQgv46DR9nKdc+WJd35jyqtbpSBCY/07ryMmqfQx2gEzlxQ1Wq2rFWZ4Zul6PRjVCr3pcaqqgCYJXCfbEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vF0LRSCk; arc=fail smtp.client-ip=40.107.237.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DMhowm0GQedIJfNpsATOZ98lZNsOALP3fWWorqBbVQXnWzI6InxBocpRjc7SxyQ5fcOCiVYqbdF6kMXznBjmESSGMUgkat26tyYLkQO3AfWv2sKEBKWCOZnYmrVW+tP/5dMRvPrbPmXp8zg2i53uRAEI63Wtke9pv80bLUnyf8dYfnaNd9nJv4GCKcbxCzF8onOdRc1LpesGAJpiHHsDqy1nFiKode8u1DlGbMnlm/bNAn14YSK41YEh7oXVMVCWRlaUatbnVXiiToVGu+ljqBr7Dv26np4SZz6dDO8BmpI/yV/83Mda1LjqVT6QrPhuTCgs18V4a7vfimMYpOVpQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtnVUwhJKlS0EpQsTYJh2JvgVC8+r7gDscA9Fn9bmp8=;
 b=uBe4jIN5OqhmwTcDrWWpv1mHsRuSuhJ307X6Bf0Jhn9jci66i9rg0GnD385e+p5Z4Wu6EYAYOEFepNM5AJTSwxzyYMpvtCXQ8V2LBWMUS1U8VgXKa8QkkYdiwkgmwYPAITUQlYHSLM1YCJwzLJkDUrc2cQ1kb3E57qc55arw5Pa2EzQ7vu9CAQjtfWFEKCqbm9AmJI3oCxNfMzLtx2tNEnaniFlC66u5g4kv/1yi2pbWY+CH1dLpq1XjhZzlrQNMjkqBOfTSSPD8rVvUxLPrSL4E/Kf2Boe1ck23spr4sO75U4FMVV8TnbnNkFOcbUhNNVRyeG9DWJS+bxnY9e7LcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtnVUwhJKlS0EpQsTYJh2JvgVC8+r7gDscA9Fn9bmp8=;
 b=vF0LRSCkUAJ6mN0vVhpwOLLSCfYaSIlZmoksWwjb42dOByYEm3hEK7v2e/JmHMPaUVMRA2w20uHmLJK/7lOj/1sJjMZzsAsfJn5Z2my9R/tUmlNzIUXmLIiMOIi3500rZm2BTyT+6DzDtidwjSZ9+mc1jKFhN/Q7ozkCjuN1OJg=
Received: from DS7P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::15) by
 SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 12:46:47 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:8:1ca:cafe::11) by DS7P220CA0008.outlook.office365.com
 (2603:10b6:8:1ca::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Tue,
 4 Feb 2025 12:46:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 12:46:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Feb
 2025 06:46:45 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Feb 2025 06:46:42 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jingoohan1@gmail.com>,
	<michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v9 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Date: Tue, 4 Feb 2025 18:16:27 +0530
Message-ID: <20250204124628.106754-4-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250204124628.106754-1-thippeswamy.havalige@amd.com>
References: <20250204124628.106754-1-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: thippeswamy.havalige@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|SA1PR12MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: b6c75a52-3ad3-4db8-cd19-08dd4519fc7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nwfM6FA3AyY+Hk8KRTLFWbkJ+rUqW8Le5mWd5zhmOh0cZszD928ZS7FkidFu?=
 =?us-ascii?Q?OZEf4ujnpliC4zTXh3j4Uhk+AT3MXQPPhpRyqeKEothp6+HoLg5xZJVH9LDp?=
 =?us-ascii?Q?YM3XbOYw3Er0nLyNPNyig13LZIRvE2jWQrYtd1IjH/+1laYQAnpgFhN7ufSp?=
 =?us-ascii?Q?ie2CHo5lH6wdW+QvbSQRfP2UWeIOOP6FFIcDHHZI1pj9TqZhU9TBnfR7rtcO?=
 =?us-ascii?Q?jSvIyuVz/9ECTCydDvWYH8LJZ2WeYJLsg9SNvkdOFt693dmZJoMheHf9GCzG?=
 =?us-ascii?Q?RuV9N9SclyCTyGgoqiISpgIzGcWEanWxzh8jondoblr0qH6rQSeOUUa017Sf?=
 =?us-ascii?Q?rBLKl+NeIg7RImqiUdZWODBG+x4Hyt2kNNYValH3BsLEMNvY9vnoIB3jzYd3?=
 =?us-ascii?Q?Bwd0k5het2OFjlIb2tbgWTgk0uqOXreFZuJPnMe5rpngtG6hvWoYhxptVljY?=
 =?us-ascii?Q?eueZ+YA8rm2b0nBnD6avjlxCO5BULh8occ8Dew8ApPu0s8BFnH0CsGa0Qjem?=
 =?us-ascii?Q?wOfYtWy0vMXojW2P9s29hcVNYjWh5EACCoLLAwusfhXX+jO1oM5KTNqp4FAy?=
 =?us-ascii?Q?1/OZ2oOw9MOUBK5h4h9kCwHrhPaCzlOtc/tGi7uK6ZKuY+dX1WWGEzlaaGjs?=
 =?us-ascii?Q?vdzJYC3s9gNc54vOuxByMUTiC6eHFQxoprJPbR0Aa4kS4u92NmTNrueHrWKN?=
 =?us-ascii?Q?0LUQnUcpXRXGRxclVswF6aupAxFWabvQtWShoT5FkwQ5UQBxD72jVNE9XC+e?=
 =?us-ascii?Q?NlNePrijHWYXNZ5sD9dmohVO6/sAF7UkyQ1ADlhwx4HxDO8txbTY3i/2Vt1g?=
 =?us-ascii?Q?i6qIlMrMRY761WgLkMFb4D4Z5bJ96RR/82Jh+Hg0ftV5sjZLciDmEs3CtTLo?=
 =?us-ascii?Q?kjBFxp7YyZ23hMW/jNqU+dUkdkTgVEH0U1S0Np0cFucmVf9F0rrAyg42yQZH?=
 =?us-ascii?Q?VVjX+prnKilobNLVFF8Ss4SJXgefN+VArWlpnfnMykIWlm1cbhf+I/hkmTjf?=
 =?us-ascii?Q?TtrlZtuNrzODqKCSpRPILsL6783yaY0LqQ+rPIEcNg3D60WeVPF9099XHPRf?=
 =?us-ascii?Q?NhfoRJQd9rKK+nwX0Me9guyNoduQblpzf5nzMYtpF2DjZq3z9tJ2lmk5Glez?=
 =?us-ascii?Q?ATGJnuf00xblJCXRrT+b2yeB7P1mCErL32avpWC2WUrkmug3ACWMmy7Xv1OW?=
 =?us-ascii?Q?veSqE4aOZWCIWMSwDgLVz2K8OZqjyuOFRqXj/S4WFNs2FjeLKZPOGc5T5iaC?=
 =?us-ascii?Q?KjY5OrPrdFOf7OcmNi81w9b7WJoLe9OIaIG/UJfaSGcA4HI0/Y/6fmwN0qOm?=
 =?us-ascii?Q?FIxuAKwOhO1ygB9J5X4+F/5rD/JrKk9PBy5xQvhytU9p3qlYpJOCVXITFFUn?=
 =?us-ascii?Q?olE3AyUtMWVzBeZdbJpewK5jnUPQHrNyeOaM4EMILIzARLXAvKp0x+rzL9uF?=
 =?us-ascii?Q?keQ4iNWYhTdCcC+DY77Po/oBbSFt7WGiSubgWfIwKz95Y+d/s9/W7owSpd1s?=
 =?us-ascii?Q?UQXw6WDZVNkxZ0U=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 12:46:46.7790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c75a52-3ad3-4db8-cd19-08dd4519fc7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8144

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
Changes in v9:
--------------
- Change SHIFT MACRO.
- Add deassert bits.
- Change callback function name.
---
 drivers/pci/controller/dwc/Kconfig        |  11 +
 drivers/pci/controller/dwc/Makefile       |   1 +
 drivers/pci/controller/dwc/pcie-amd-mdb.c | 474 ++++++++++++++++++++++
 3 files changed, 486 insertions(+)
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
index 000000000000..e4e9d850d10e
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
@@ -0,0 +1,474 @@
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
+/* Interrupt registers definitions */
+#define AMD_MDB_PCIE_INTR_CMPL_TIMEOUT		15
+#define AMD_MDB_PCIE_INTR_INTA_ASSERT		16
+#define AMD_MDB_PCIE_INTR_INTA_DEASSERT		17
+#define AMD_MDB_PCIE_INTR_INTB_ASSERT		18
+#define AMD_MDB_PCIE_INTR_INTB_DEASSERT		19
+#define AMD_MDB_PCIE_INTR_INTC_ASSERT		20
+#define AMD_MDB_PCIE_INTR_INTC_DEASSERT		21
+#define AMD_MDB_PCIE_INTR_INTD_ASSERT		22
+#define AMD_MDB_PCIE_INTR_INTD_DEASSERT		23
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
+	for_each_set_bit(i, &val, 8)
+		generic_handle_domain_irq(pcie->intx_domain, i);
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
+	pp->irq = platform_get_irq(pdev, 0);
+	if (pp->irq < 0)
+		return pp->irq;
+
+	amd_mdb_pcie_init_port(pcie);
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
+					    AMD_MDB_PCIE_INTR_INTA_ASSERT);
+	if (!pcie->intx_irq) {
+		dev_err(dev, "Failed to map INTx interrupt\n");
+		return -ENXIO;
+	}
+
+	/* Plug the INTx handler */
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


