Return-Path: <linux-pci+bounces-20129-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80159A16459
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 23:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 666637A24A0
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 22:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2701E04A8;
	Sun, 19 Jan 2025 22:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4EwewLgj"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522BC1DFE00;
	Sun, 19 Jan 2025 22:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737326612; cv=fail; b=LW4DFkd1oVHRnLqBWeQ1GNCZLnoVSwejW503sh+sOOhOnzYO8ey64wp+KE9T5yVcsFk+tbN/pfo1uYLi+ubK1SB639bvdmnfo8KMpOvyV50Rtltvy93k3iwS9IJOE3iDez+VQjtjjSuB0Lr7iNwsMkBeKVWsTemXSw06+kx9sO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737326612; c=relaxed/simple;
	bh=EnN11Cy5UNS/92JjLHiThvNMeuBxg9awfEMO5Nlj/XU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j0ygX+IgfWE7Z3CJm6bP7SnsJX3pAMgOqZLj7QBIomazcD38ncycf/EyVG64M7Tna/xPk34PHJ62M2CIUIDE2oZqHvft/A7KNvI+mtQJkefHuE2F8ljLMjaHAktj+DdvOmulrw9lEOOglfPVvUY9uGZIyUvYys7u5ccNx+mzqOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4EwewLgj; arc=fail smtp.client-ip=40.107.101.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Md0P6MoKyVc7FRQcpmS/x7Y5SqmHl9GoTGYDMljcyive3ZWBDwDmR4XVaUdP6bJWkq104QglPGx+WuyayQpuCDfsp7vOJ+K/7KQ50b9rObAzl0lw1s+WSmUZjbjawIqZYZjLrCUlmfUmvdqc5gAGJ+lKiiWKvxGvVUybdcHtpBI/ZmIWkaGBZPuU9Ur+mszy1y3XE/dvlF5OcsCkgAAEk/XZw9QrEBLqqyqrBhRy1E5G7xPCWHjFSo3DSldFsqaU8vyAuBf5JbpdPY330ThnvLj/Px7BZPkeVec63Q8s6EBIpJLH/83DCcHM6g2VQBM4NHwwtw/XDWADD7psQv8WRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PiISgWkV4MDOiq2rwrhngBwEWx1uOUJ5mQ/MKFTJU2c=;
 b=TRjb/rIl7aPoA2nKSluUiCw5RvShDPBAwsKTbpq/0P185ZSm6YhF84lHHbLkoXzIWJiRH9QEDz9fJIPZaO1oByXNGacuwEe0aC7/O5S2qUY4pYcXPnNf6EsTmp8/vj8MXUFkhNZ1QydQzqoqSs0ryuDXzIKwbGfFG5ZADskwgeYuMDbVt1zpIBKpGtdQg+Ff/8/6QdlK5U/MTN06oEiYlIWbq2xrIxVZnWLzHFDnXWIfYy06Qbz1O4epmRewI66ti6prJdgBaxr7gzDNDnctsBqHEN09usRRu2VkLZieERBuSJjTTYxUrX0RvGHzMWZQkSAYinmTMBbIxOn9uLqU5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PiISgWkV4MDOiq2rwrhngBwEWx1uOUJ5mQ/MKFTJU2c=;
 b=4EwewLgjNTRxnRJZ6N8dU579mCcQHx3FHPT9CYgJnudHwKEUzPkjJoDpDJeoXklKFsMezvI+g0RMJVHd65apw0WeZbXznGfUIj1mHq+LjCR6hz4uaJRHeYUUQigwknusTLY2BtTTyjlsg0Fs2XJzuHPSstx1drQh2slc0hWLz7g=
Received: from CH5PR05CA0018.namprd05.prod.outlook.com (2603:10b6:610:1f0::28)
 by DM4PR12MB5916.namprd12.prod.outlook.com (2603:10b6:8:69::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Sun, 19 Jan
 2025 22:43:25 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::dc) by CH5PR05CA0018.outlook.office365.com
 (2603:10b6:610:1f0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.12 via Frontend Transport; Sun,
 19 Jan 2025 22:43:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Sun, 19 Jan 2025 22:43:25 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 19 Jan
 2025 16:43:24 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 19 Jan
 2025 16:43:24 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 19 Jan 2025 16:43:20 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jingoohan1@gmail.com>,
	<michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v7 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Date: Mon, 20 Jan 2025 04:13:05 +0530
Message-ID: <20250119224305.4016221-4-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250119224305.4016221-1-thippeswamy.havalige@amd.com>
References: <20250119224305.4016221-1-thippeswamy.havalige@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|DM4PR12MB5916:EE_
X-MS-Office365-Filtering-Correlation-Id: 55f8247f-c9e9-4203-ca54-08dd38daaf55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6Mv8rGsJrGmfR4r1Laqnr1n2r/4Lq81BowsygAunHsLK7qw4FCKmMtGJ+SzQ?=
 =?us-ascii?Q?XQSmQcjANYv8Z/7rZB2MJAvlc+Szsr4ifNBxkzB0M0QbVUh/MOibbVMdvorM?=
 =?us-ascii?Q?1hqkWabDq17Zc5bbnzShfroG85ffhLtKdXxUV66QGhvCZyJ65wbWb+OJZl8L?=
 =?us-ascii?Q?sctvQdoPyKCI6qW9Odl1qJaDcBmyM4Mi90SmzVRlzWr75CgNQ/or0nNkomaI?=
 =?us-ascii?Q?+J1T5ElyKJXrrZa4AGzUeR7zSSc8n3eFDO0NLGYMuiiIrjxE5UdlN5KC/ndk?=
 =?us-ascii?Q?G+5S/MDNbiaPhg/SxruEMjqR1hX8piijHQAtdC+JmrARQtdhhyLcF/T3ZOOC?=
 =?us-ascii?Q?SePmQ+WlnKXHZuYo0pqO5NA6BWiOmepyk4tSAweMnwwrct2a69DMUITqt4+y?=
 =?us-ascii?Q?4F9MovNkWNs2dxTp2UQCIxi3eMuqlom3xI9rwaX8cfWb551z90o7nZ5vNyex?=
 =?us-ascii?Q?2IagrEcD9GKhsNhjZv79O4p3x3obZsFrOuFUlC6PNVUFSmPUYMOcDYFQYge1?=
 =?us-ascii?Q?PQW/6SOqNdIuXsPUk/eJJb2LTxiWbVxaUjEmzFkF91jo7sCrE7vKPUo2Bo+b?=
 =?us-ascii?Q?/pyKXaPiyB3X4/3v19KleZ7gupKjJYAQD+0XJpLuRMFFXjmu8I+KXDGqIVKg?=
 =?us-ascii?Q?/7FyT78HUk7FpKuXWoU0GNlFpzNzE4NqMAbp0jC0oKsL1kumO+8I5PG2KdZr?=
 =?us-ascii?Q?viyIyU8Rt1m9uLfHeWvSyUBADvEGpcCblhiOiN1vrEXdieIxQI7kQq2BLkPU?=
 =?us-ascii?Q?VgsIqcgFDTKxKlO7YJNZ+ThPVeAVc/0QkK/fKgxjtg03YIzzzn1NyvMBKVkn?=
 =?us-ascii?Q?fDk66AdR51ecyE+HngUAHmB0cieIZfSdli+xIN3xVz8K0si1nE2UWJhS8DXK?=
 =?us-ascii?Q?2a2/4QqY9ukAmulD7Mi5x4TJmO5x+6BCrUbYuGzKIpSORLMwrLnWKxOKTUYH?=
 =?us-ascii?Q?QDF/8XOf3VPeOVhJ6Xr0R6eGAvU5DTraqUz/3U+uLP47ML8F6hOQS/emffSy?=
 =?us-ascii?Q?VfCyYZxwDMvdTlUS1yH62OX5fB0ui/4AiERL1ymPMy7Oek7dKvpPWb2F2UmL?=
 =?us-ascii?Q?aI+3SQ2iVZuPXRHRqD+1arbkwtVxtHEiV7rzfx/w5Qk4G4f9NUsRqAdmVCSg?=
 =?us-ascii?Q?vyTWeO5vXxacopZOzqYuya7GvUbFnnY6xI2MGFF2HsrGztdhwRM+88eJFBKc?=
 =?us-ascii?Q?FOkvYTpZ09u1svA8ZFIzd6e0x6FCIvVu3WpSd94/DOI+3luxT1wBs6Aa7uyj?=
 =?us-ascii?Q?BHnT7BBCxszN+haNrLuieCfuL2wbuufsOSzmuIKpRpZ7bPwpy8S5X0PzCiCA?=
 =?us-ascii?Q?8Ossck+pqPhGAuDlNaTc2Oay75xcrOHWmAI8eOx7YyRxubRcQ/bQFImvNRtL?=
 =?us-ascii?Q?jZzi32BP4QA9TaYvOHFiGSeOT33RYYhjaJDy8aLv0FMKqmKwZyiA1oAHth+D?=
 =?us-ascii?Q?nAhSxNvJ2ycKCWgNphAM3ni4RI55u15lQWkrVwbJdKCPXAci5jD2c0E7cogd?=
 =?us-ascii?Q?pB2mbacWUuqM1wA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2025 22:43:25.1202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f8247f-c9e9-4203-ca54-08dd38daaf55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5916

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
---
 drivers/pci/controller/dwc/Kconfig        |  11 +
 drivers/pci/controller/dwc/Makefile       |   1 +
 drivers/pci/controller/dwc/pcie-amd-mdb.c | 436 ++++++++++++++++++++++
 3 files changed, 448 insertions(+)
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
index 000000000000..ef1ac757d41c
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
@@ -0,0 +1,436 @@
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
+#define AMD_MDB_PCIE_IDRN_SHIFT			16
+
+/* Interrupt registers definitions */
+#define AMD_MDB_PCIE_INTR_CMPL_TIMEOUT		15
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
+		IMR(FATAL)				\
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
+static void amd_mdb_mask_intx_irq(struct irq_data *data)
+{
+	struct amd_mdb_pcie *pcie = irq_data_get_irq_chip_data(data);
+	struct dw_pcie *pci = &pcie->pci;
+	struct dw_pcie_rp *port = &pci->pp;
+	unsigned long flags;
+	u32 mask, val;
+
+	mask = BIT(data->hwirq + AMD_MDB_PCIE_IDRN_SHIFT);
+	raw_spin_lock_irqsave(&port->lock, flags);
+
+	val = pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC);
+	pcie_write(pcie, (val & (~mask)), AMD_MDB_TLP_IR_STATUS_MISC);
+
+	raw_spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static void amd_mdb_unmask_intx_irq(struct irq_data *data)
+{
+	struct amd_mdb_pcie *pcie = irq_data_get_irq_chip_data(data);
+	struct dw_pcie *pci = &pcie->pci;
+	struct dw_pcie_rp *port = &pci->pp;
+	unsigned long flags;
+	u32 mask;
+	u32 val;
+
+	mask = BIT(data->hwirq + AMD_MDB_PCIE_IDRN_SHIFT);
+	raw_spin_lock_irqsave(&port->lock, flags);
+
+	val = pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC);
+	pcie_write(pcie, (val | mask), AMD_MDB_TLP_IR_STATUS_MISC);
+
+	raw_spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static struct irq_chip amd_mdb_intx_irq_chip = {
+	.name		= "INTx",
+	.irq_mask	= amd_mdb_mask_intx_irq,
+	.irq_unmask	= amd_mdb_unmask_intx_irq,
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
+/**
+ * amd_mdb_pcie_init_port - Initialize hardware
+ * @pcie: PCIe port information
+ */
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
+static void amd_mdb_mask_event_irq(struct irq_data *d)
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
+static void amd_mdb_unmask_event_irq(struct irq_data *d)
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
+	.name		= "RC-Event",
+	.irq_mask	= amd_mdb_mask_event_irq,
+	.irq_unmask	= amd_mdb_unmask_event_irq,
+};
+
+static int amd_mdb_pcie_event_map(struct irq_domain *domain,
+				  unsigned int irq, irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &amd_mdb_event_irq_chip,
+				 handle_level_irq);
+	irq_set_chip_data(irq, domain->host_data);
+	irq_set_status_flags(irq, IRQ_LEVEL);
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
+		return -EINVAL;
+	}
+
+	pcie->mdb_domain = irq_domain_add_linear(pcie_intc_node, 32,
+						 &event_domain_ops, pcie);
+	if (!pcie->mdb_domain)
+		goto out;
+
+	irq_domain_update_bus_token(pcie->mdb_domain, DOMAIN_BUS_NEXUS);
+
+	pcie->intx_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
+						  &amd_intx_domain_ops, pcie);
+	if (!pcie->intx_domain)
+		goto mdb_out;
+
+	irq_domain_update_bus_token(pcie->intx_domain, DOMAIN_BUS_WIRED);
+
+	of_node_put(pcie_intc_node);
+	raw_spin_lock_init(&pp->lock);
+
+	return 0;
+mdb_out:
+	amd_mdb_pcie_free_irq_domains(pcie);
+out:
+	of_node_put(pcie_intc_node);
+	dev_err(dev, "Failed to allocate IRQ domains\n");
+
+	return -ENOMEM;
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
+		dev_warn(dev, "Unknown IRQ %ld\n", d->hwirq);
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
+	for (i = 0; i < ARRAY_SIZE(intr_cause); i++) {
+		if (!intr_cause[i].str)
+			continue;
+		irq = irq_create_mapping(pcie->mdb_domain, i);
+		if (!irq) {
+			dev_err(dev, "Failed to map mdb domain interrupt\n");
+			return -ENXIO;
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
+	/* Plug the main event chained handler */
+	err = devm_request_irq(dev, pp->irq, amd_mdb_pcie_event_flow,
+			       IRQF_SHARED | IRQF_NO_THREAD, "pcie_irq", pcie);
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
+	amd_mdb_pcie_init_port(pcie);
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
2.34.1


