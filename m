Return-Path: <linux-pci+bounces-17887-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC159E8392
	for <lists+linux-pci@lfdr.de>; Sun,  8 Dec 2024 05:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4427916472B
	for <lists+linux-pci@lfdr.de>; Sun,  8 Dec 2024 04:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D2129D0D;
	Sun,  8 Dec 2024 04:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gNzZO/Qc"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF9520B22;
	Sun,  8 Dec 2024 04:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733632852; cv=fail; b=YwnU03Ew7aTv9UJH6rH2swGSKpcE5AgJmAMFsEvaxoR/HPkgT2DeslENP5aFxD4zfm//q6JJJmbzMqRnj4FDCi0wieruSD1jVSxvEpcXmgaThphsdEzGAVCNRvFARV/GkezdK4CWwwmW8ekOvVsKK+7Et03SOEx/OFmOqCaGkQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733632852; c=relaxed/simple;
	bh=b+2qEidAe5L3HVjPNEwYossrBSWZzBji5mz1gm61FcI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HVh+B+XRuPlQwxLfbLxdk9brl//OPESSRtYrCNKIY0Cp1VRosqBzWozFnLdEewyEqBFG4KMhLM8eyCmyIdhcYy0tgJpCjBZheACzp2QupOBxp4IsNQx4+DK1S8n9BolIW4a6hw4VYy2YxRcNIK0Xby1+5qIDhm+88BfiZGwaoNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gNzZO/Qc; arc=fail smtp.client-ip=40.107.96.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PMvASbSZTn56JGFAmasVrYeG9fnHqBEIdx2itzWgCqOcHjbwbhEcWwhNR1CQx8f40G86E++JhUzb1FX0UJS/gV3FhbqnA32ejNEHxEmvSmteLhcqAWvDHI2ZXZfFhwDRfrbfTESR3+EyMQ1g3SZH4HKM3CyJbRd0jT/7//CtA0T/uG5JKKzKktTeCxBeqpxPJYoh7ZDfYjAbEGelM8SjroaYer7ZPP89MnzsdptZ/1voy6YpEh1bPD4kWOQOh7BjteHVr63eL8cNkb++AMtzvHHtByW2zueu8TZJXhF2+mWrM31ZnKKgt6xuSg3Zr+MqoG7yHZMDgPLXm2/F2iEztw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ea3kf0QHSnX1UDW1DDJiuhwiFQqnkl2lGSAeUJtepLk=;
 b=fPB+D1RUYP6joPNTf+/YzuGxZIW72CyrLPYV0ubObZxCAZ0PojbGuTUGcp86x41/p+2lgeEn1OleOjE0W25SeAGUwEK5wpVIexD8fILOJSuZYLZ8It0ammyCeGjc61MiMSGXIuvVZwxpy2DS8RXS2F+tHMsmso/M3EIzmtDiXXL4QZ/6ztwiaiJdkJiupyQxkI9e7Ia5biLQE0uMO4TpIVA+lj/YqAV3F0VmekiG4C2oasn+4oKle8hNdP9t2Arzhji8uuCva2/WAgIgfyU+p74zfUbnya23N4+cYAU8NkeiAiAJIP2Xr3S8o0g6FEazEOUs2cD7yGtYB7YGEUGnNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ea3kf0QHSnX1UDW1DDJiuhwiFQqnkl2lGSAeUJtepLk=;
 b=gNzZO/QcIJRoLRZQWzRe7QICa2BPmokWqO8+WjcVUSPNT3K1jI4M5hcQqOh3rjETwAjKjUfE4+M+G8v2pBKFx/lrvcpleLsduE7cqD4xORmueOZTYsl7bY4NskNa6qv4s1HSZ5hDP8Ho4spy0TEiEfqtGz3R1mNBdmzOPCYALzI=
Received: from BN6PR17CA0039.namprd17.prod.outlook.com (2603:10b6:405:75::28)
 by PH7PR12MB6417.namprd12.prod.outlook.com (2603:10b6:510:1ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Sun, 8 Dec
 2024 04:40:43 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:405:75:cafe::d1) by BN6PR17CA0039.outlook.office365.com
 (2603:10b6:405:75::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Sun,
 8 Dec 2024 04:40:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sun, 8 Dec 2024 04:40:42 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Dec
 2024 22:40:41 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sat, 7 Dec 2024 22:40:38 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jingoohan1@gmail.com>,
	<michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v5 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Date: Sun, 8 Dec 2024 10:09:28 +0530
Message-ID: <20241208043928.3287585-4-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241208043928.3287585-1-thippeswamy.havalige@amd.com>
References: <20241208043928.3287585-1-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: thippeswamy.havalige@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|PH7PR12MB6417:EE_
X-MS-Office365-Filtering-Correlation-Id: 188f0848-46bd-461e-275e-08dd17427950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wPq6JoD9uY0B6Aya/tkTwFlI/FbreRgXD762DzmfEGoc3TZSxNNqvmkLDIB3?=
 =?us-ascii?Q?s254IoSNqEudJKvdrlu38O07KfbsKVBu7LoeS/Z/Q9adBXSwcVmvNFokpmKL?=
 =?us-ascii?Q?v8EzSKHHDibbrx84qaeKsrUfIAp0Fm8zozGLlrAWOU4HsSnRpYYNhJfBOVom?=
 =?us-ascii?Q?eEKL1rAVtb6Ji+am7owFyA8rjz3yYxzSivPhK8XDztsm2XLDLB/wwUwzIXIc?=
 =?us-ascii?Q?wQasbZT+iaTbU5FlhrBFwNceCXRt8LQg/5O7e/+FIvt7Fukdz99RZU9Uoiph?=
 =?us-ascii?Q?DxG2Qhfw/MaX1+KH2ySQS2lT9XVogeun71CDTLyJmjmzbROZPAdbQ+U/CrlK?=
 =?us-ascii?Q?sXKLgzuwDcTmlmV2eptbRezWqUHe3W+dk0DZPzCrTNP9OKTCpBeXrsrBkhV1?=
 =?us-ascii?Q?UFrkQh70yuZByN9qkTFVBWqYL6/Zv76GR9osHiuXbj0gTVYWMiznTNjPuisW?=
 =?us-ascii?Q?HyHfXRhK6ELxXgbBnBpPWtdQZtQmsku1FI04wf+SIHl2WKTU6Ebv1AtDO4Dq?=
 =?us-ascii?Q?ORzbvPyz/6UsxLawhqZV/dG50q8EOcZffcu/2YB90s6LejC0JaRSRKu41eLV?=
 =?us-ascii?Q?m2kxKURNe9jB7k2x/5Di1Gg8Pvs3pv9rV1TRX3DWihXsBLvYqniGdHQwTLh5?=
 =?us-ascii?Q?ejG+DhX59TmmiEZ6iqps+ii7fdBv0jYzzT+l30QAb6A/T5HjHHluKZNNH6yr?=
 =?us-ascii?Q?apAE15B9TaAF15CQf5kHOu+kT2EuzL0Tvrg3yGhIzen5nr3RRRiZEyYeKTMs?=
 =?us-ascii?Q?PgZBloKmt6+oSUblzP6mxnF3mC9Ve3+Z8hce2ZkHmuxveOayc1yKffpLJs6e?=
 =?us-ascii?Q?DyayO2R6lHYQ/8JY339RcG6kSnv8Rzj0XOFzLxE4kF5+zDu8CzH/B5AKrxcr?=
 =?us-ascii?Q?YGK61jbxUIWZjuc6jjNMKbJqPtTeLY8EII3rTZYwHJafM/OHS/vjlMRCsR2l?=
 =?us-ascii?Q?1eBenHX5snPpr3E9iDHElOTwNIHr2YVoeElKAP+kMffHsILXUacxHipe+ghL?=
 =?us-ascii?Q?U3U5ONjGyIBoXKrTvNdZiZzifG34UuNBsI2JerIAwrs93SL6pti9BtO9IiMS?=
 =?us-ascii?Q?EhmQ1cKDKaR4PnyCksvoSvWc65Aey1dcawRjzkly6hNihcTNp+tARRoP2hBn?=
 =?us-ascii?Q?FOinBzQDG1cPdHUacvjQcMoah6D5PxMxTEkwFsendCFSvghsX0vwjBKrABfr?=
 =?us-ascii?Q?die8/h3Z39v4KRLD0RIODRlvNAcaAyKQSJytFjmKf5UryTrrRqswh4JBC1Fk?=
 =?us-ascii?Q?VlhB330vme3Kpqd/UsJxfj8EjRbY751zpRJbP/Hu+E4Ph5A6Q7edsCcv1piV?=
 =?us-ascii?Q?vW898PoBM6V00OBKqlZHjkSMkMrjiNKdgo7b8Hps44GM6fyCpjM5b8waBhzr?=
 =?us-ascii?Q?ZnUun7AEW6mlRYVbbaqS8L5960DfkBOUEAviUkjPFp0FmjZ0IR3AglSnYhJX?=
 =?us-ascii?Q?+uDso1qv8FaCLRK2OJJLNcqdu9/A7vog?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 04:40:42.6117
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 188f0848-46bd-461e-275e-08dd17427950
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6417

Add support for AMD MDB(Multimedia DMA Bridge) IP core as Root Port.

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
---
 drivers/pci/controller/dwc/Kconfig        |  10 +
 drivers/pci/controller/dwc/Makefile       |   1 +
 drivers/pci/controller/dwc/pcie-amd-mdb.c | 439 ++++++++++++++++++++++
 3 files changed, 450 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-amd-mdb.c

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index b6d6778b0698..30d0a3eadf1d 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -27,6 +27,16 @@ config PCIE_AL
 	  required only for DT-based platforms. ACPI platforms with the
 	  Annapurna Labs PCIe controller don't need to enable this.
 
+config PCIE_AMD_MDB
+	bool "AMD PCIe controller (host mode)"
+	depends on OF || COMPILE_TEST
+	depends on PCI && PCI_MSI
+	select PCIE_DW_HOST
+	help
+	  Say Y here to enable PCIe controller support on AMD SoCs. The
+	  PCIe controller is based on DesignWare Hardware and uses AMD
+	  hardware wrappers.
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
index 000000000000..3947aad13ea0
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
@@ -0,0 +1,439 @@
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
+ * @mdb_base: MDB System Level Control and Status Register(SLCR) Base
+ * @intx_domain: Legacy IRQ domain pointer
+ * @mdb_domain: MDB IRQ domain pointer
+ */
+struct amd_mdb_pcie {
+	struct dw_pcie			pci;
+	void __iomem			*mdb_base;
+	struct irq_domain		*intx_domain;
+	struct irq_domain		*mdb_domain;
+};
+
+static const struct dw_pcie_host_ops amd_mdb_pcie_host_ops = {
+};
+
+static inline u32 pcie_read(struct amd_mdb_pcie *pcie, u32 reg)
+{
+	return readl_relaxed(pcie->mdb_base + reg);
+}
+
+static inline void pcie_write(struct amd_mdb_pcie *pcie,
+			      u32 val, u32 reg)
+{
+	writel_relaxed(val, pcie->mdb_base + reg);
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
+ * @pdev: platform device
+ */
+static int amd_mdb_pcie_init_port(struct amd_mdb_pcie *pcie,
+				  struct platform_device *pdev)
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
+	val =  pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC);
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
+						 &event_domain_ops,
+					       pcie);
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
+	pcie->mdb_base = devm_platform_ioremap_resource_byname(pdev, "mdb_pcie_slcr");
+	if (IS_ERR(pcie->mdb_base))
+		return PTR_ERR(pcie->mdb_base);
+
+	ret = amd_mdb_pcie_init_irq_domains(pcie, pdev);
+	if (ret)
+		return ret;
+
+	amd_mdb_pcie_init_port(pcie, pdev);
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


