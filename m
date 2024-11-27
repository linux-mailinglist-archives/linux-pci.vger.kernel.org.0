Return-Path: <linux-pci+bounces-17414-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 336E69DA78B
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 13:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93DAEB2810D
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 11:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A471F9F71;
	Wed, 27 Nov 2024 11:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FIhwnlm2"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78531F9F6C;
	Wed, 27 Nov 2024 11:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732708721; cv=fail; b=oGKw1ZBEHKBVwrMWnw7/U/Cwq8hcnSHysgbpkJmh+1fnYHeOe5Jmnc7YaAXCKbV12Mm0V1BkXkqFnO1H1ZAEzEHhJYiY2PaqeFO8aKoGW8JmI1tgq1PyVDXbSjfLiRmCQHxMrrnZ4MolLF/GYSnvfTaab3gDclJ39qFkVTV27y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732708721; c=relaxed/simple;
	bh=7T1jrZ1/ybcNK4YODWvSQ54FChjrnICAUOqNvmSRM98=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8/qst0hDnr2dq62CyI/ZW4Kqk2AVHwaFz7Bfz1vR2YaTYNltIiEfadnkxMzJqsjChL5jlQj6AVxldBtBS4948Jcnbte2zgCwyKtzI/z/DCVqxTWaiogqnWAk/6i1YaGvKH0JlWGh/HEqinpP2/Rk+zoyquOrmwrJ+pt0CmX0RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FIhwnlm2; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r7gravcA6/IcQEhk1QJdjhvPK2u+ldYTxxmsR139AdgRQCIMZ+OB/LVPKOSffs+3z+I2pHFvc8QKxZkffjtNMlGzuhz8WOI75sxSHziG+uiOzn6JC+W/RL2ImcAr92p8H3uryV/9ILsoEYNjOLEc6Z7QPWekKOtSxz/4X3te4l/xOHRQubSL5TjZPkoQl3YQBSAydkzE9ZB2xfxr45GNFoejCyooOD3J1EFIFXGSLzdW4/Nv8Gmy2QJDM50lwSN4ETNGA5nTB+hyA6Qv8RcK4yBtCS9RP2ksA5nP4NAmB4LgeETDQB9hDmoJZYHKDBJlPwrrED4LJFwtbfT4M5zl0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBoFFbJpvHmB0GBfQCOzVlZC+zWhjdAaOWuILbkBopg=;
 b=w91mxL+1tp+Qfykl2SqzAH6i9daBmsttwRm+grODRrvSJzoiCbohEvnqrm0O4dGYfdMprJiMN1gCR0R+gszcHBY+mJ2ha13dfCIR7R/DjkYon2zSeqKd3T/bS5MxsQTcJQh3UnAawnR9bkfrTp5edh+9QdGm8kpODrUZfuYheiVDt/DiDbkiSb3dgQU39r46e/1iiBjM1YEZSQqfiGZkYHp9+oFfa06E8UR5rD02t011ZAOkMot8cZSgs/MGBZHfXVoikzEBTME3awmhNdZSL5ivNc62Fj1dbZLP1IPpmCAt1oa5gUaMoAjc9MeNR9Q0PdSAnY2gTwH4yr5VcBqwAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBoFFbJpvHmB0GBfQCOzVlZC+zWhjdAaOWuILbkBopg=;
 b=FIhwnlm271y6WB0Kt5xnm4mfmrVEybY9GpcQ+cfVpqz+wOlFlbrhcYif7UxX77NUF6/R62hq7amQgYP5E9KeOuIEjA4GQQPMo7ja/BS6qPucpzxSdOscaIhhI2RIMe935qHm8uv7Le5ZR1TB0rEFN5pTBHhx0AGdIRwGL4B5/oI=
Received: from MW4PR04CA0106.namprd04.prod.outlook.com (2603:10b6:303:83::21)
 by CY8PR12MB8313.namprd12.prod.outlook.com (2603:10b6:930:7d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 11:58:34 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:303:83:cafe::b0) by MW4PR04CA0106.outlook.office365.com
 (2603:10b6:303:83::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12 via Frontend Transport; Wed,
 27 Nov 2024 11:58:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Wed, 27 Nov 2024 11:58:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 27 Nov
 2024 05:58:33 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 27 Nov 2024 05:58:29 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jingoohan1@gmail.com>,
	<michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH 2/2] PCI: amd-mdb: Add AMD MDB Root Port driver
Date: Wed, 27 Nov 2024 17:28:04 +0530
Message-ID: <20241127115804.2046576-3-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241127115804.2046576-1-thippeswamy.havalige@amd.com>
References: <20241127115804.2046576-1-thippeswamy.havalige@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|CY8PR12MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: 69d1c759-e353-4342-5e70-08dd0edad210
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RljUUZITy/iRm4aZotGJi58DPGoXN5irkQ6DrxOJTwsMGdBxLOUZP6o7IInQ?=
 =?us-ascii?Q?wvpJ5CvlFJTrtqtdcK42AAsMCdTCrKuxHu8ioUds/IY596A9Bf4Gnsn+3FlX?=
 =?us-ascii?Q?vs81q5eOY1RHp4oGLx/OJb75snvVI5lNKxoiYuqSqu9HV4bEqTwPTvhxuDnh?=
 =?us-ascii?Q?fOAncAM3kfxfpkyOYUmL5GXV5DcNIKbk6LcFKvdyE5XRRjrryne+6MktQ7W+?=
 =?us-ascii?Q?T3zdQXagZAcPYzniRSS6f/FrWftjnFTWbnLBoaJbopsLTIpB80fvmyiUm646?=
 =?us-ascii?Q?b+/W9UjKUtcwOZbe75QyuRr7JytduWjtb6Rw/MegPCWIbYuIjS6CLjneFc1p?=
 =?us-ascii?Q?3HE9CldH/HfNYLU+1zodUgSRjsUpLru/gnY3XVlgNWcVoYiKAIb4IhncCnCs?=
 =?us-ascii?Q?EK4sxpqfFc/l1byycFV743q7ylwwPCnp17/p1ESyJj3QdsJZmGldgwR+OXsw?=
 =?us-ascii?Q?ar265wySDQKzyDuq8UDkMmbYs4CiFnfUBjpOKZQiAoXTATLaSICjK4lQRLAI?=
 =?us-ascii?Q?OnCgC7iT+v2aVIS0J6eCeecFGsWww/YiajMdA/g2VxSIFR8c8asDSIY1h6vM?=
 =?us-ascii?Q?/LjmpY7RG6dUgOFOue8xGFPx0cDR5f3Aky3A7BEwJuwQHPQ872DNjVzeVCDq?=
 =?us-ascii?Q?ktUfdtfU4S8ioujUD8Oh+M9KeShV5YKkTKSTO/it5TZNocy/xs8k9L1PstTG?=
 =?us-ascii?Q?omG/ER6WJu5V+h1dBzIQgv/EQHAQ2/zV8O+mpV2ZZNBCQqPpzfdi+hXahJY5?=
 =?us-ascii?Q?D4aqTda2XYAq5Y885vG6gkmlanlAMdrZtt/L015Eu6DcIKQtqqo7KyV8hb0X?=
 =?us-ascii?Q?KpiHMRSenPAIIo3UF253De3ovT5bbktxxIPsrj42mURFeF3BX3QAHaCSGHaR?=
 =?us-ascii?Q?NC69bpQgqfA5hQkdmdlrOuq4jD1vEHrXj3nQNY04E/PvKZjidMZFoqdlWpK2?=
 =?us-ascii?Q?N8E0Pdl+AP6fmjtRqs4C5ncQQCy2XyTzWuCr6yfeWvEiuCq40v8on6QZkasx?=
 =?us-ascii?Q?HfgEUNPcLF7qXMtSX70EI3kYPGBck1VId2D47XXt5Z3oZdLq+cv5NpeYj37Y?=
 =?us-ascii?Q?Scqq8WQQ++jeB4LGmZXYzRVb37sQ0zJHMPiIwRsYUmAOFXKDm1JoPwNU/WBe?=
 =?us-ascii?Q?giUh55U8PDUeQY0WM9UOmjH4W9Sc73+cP0rTReim5qU8/oU6UePXl0ZH66FV?=
 =?us-ascii?Q?oPuW4d8C9Beytvw5/gznDVabvxEm6ZqxImvQMLu9yPaKhZTXRyKiVCB07gGj?=
 =?us-ascii?Q?PeZFJSfQCTg/U3WaWHrp9zQac0ARSsgmjfQoN5OwMQYSLV9ORhT3/MlLqZYG?=
 =?us-ascii?Q?DL30LS/zAoh9tW6D/3i7bF3FdVpsDjIiSlRuASigJQaQWXTHf2aJh5O+dACX?=
 =?us-ascii?Q?PAg0iu1VjBhdjXNLyRE37nGEex09vW/ISUYjeC0tcasSnJuWp5EFmZfhbbem?=
 =?us-ascii?Q?ysoiX5lHZQpQw7gRUol7GU1zCD5EK3EA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 11:58:34.4863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d1c759-e353-4342-5e70-08dd0edad210
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8313

Add support for AMD MDB(Multimedia DMA Bridge) IP core as Root Port.

The Versal2 devices include MDB Module. The integrated block for MDB along
with the integrated bridge can function as PCIe Root Port controller at
Gen5 speed.

Bridge error and legacy interrupts in Versal2 MDB are handled using Versal2
MDB specific interrupt line.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
---
 drivers/pci/controller/dwc/Kconfig        |  10 +
 drivers/pci/controller/dwc/Makefile       |   1 +
 drivers/pci/controller/dwc/pcie-amd-mdb.c | 455 ++++++++++++++++++++++
 3 files changed, 466 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-amd-mdb.c

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index b6d6778b0698..e7ddab8da2c4 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -14,6 +14,16 @@ config PCIE_DW_EP
 	bool
 	select PCIE_DW
 
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
 config PCIE_AL
 	bool "Amazon Annapurna Labs PCIe controller"
 	depends on OF && (ARM64 || COMPILE_TEST)
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
index 000000000000..73ec8ad5f39c
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
@@ -0,0 +1,455 @@
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
+static inline struct amd_mdb_pcie *get_mdb_pcie(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = container_of(pp, struct dw_pcie, pp);
+
+	return container_of(pci, struct amd_mdb_pcie, pci);
+}
+
+static void amd_mdb_mask_leg_irq(struct irq_data *data)
+{
+	struct dw_pcie_rp *port = irq_data_get_irq_chip_data(data);
+	struct amd_mdb_pcie *pcie;
+	unsigned long flags;
+	u32 mask, val;
+
+	pcie = get_mdb_pcie(port);
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
+static void amd_mdb_unmask_leg_irq(struct irq_data *data)
+{
+	struct dw_pcie_rp *port = irq_data_get_irq_chip_data(data);
+	struct amd_mdb_pcie *pcie;
+	unsigned long flags;
+	u32 mask;
+	u32 val;
+
+	pcie = get_mdb_pcie(port);
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
+static struct irq_chip amd_mdb_leg_irq_chip = {
+	.name		= "INTx",
+	.irq_mask	= amd_mdb_mask_leg_irq,
+	.irq_unmask	= amd_mdb_unmask_leg_irq,
+};
+
+/**
+ * amd_mdb_pcie_rp_intx_map - Set the handler for the INTx and mark IRQ
+ * as valid
+ * @domain: IRQ domain
+ * @irq: Virtual IRQ number
+ * @hwirq: HW interrupt number
+ *
+ * Return: Always returns 0.
+ */
+static int amd_mdb_pcie_rp_intx_map(struct irq_domain *domain,
+				    unsigned int irq, irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &amd_mdb_leg_irq_chip,
+				 handle_level_irq);
+	irq_set_chip_data(irq, domain->host_data);
+	irq_set_status_flags(irq, IRQ_LEVEL);
+
+	return 0;
+}
+
+/* INTx IRQ Domain operations */
+static const struct irq_domain_ops amd_intx_domain_ops = {
+	.map = amd_mdb_pcie_rp_intx_map,
+};
+
+/**
+ * amd_mdb_pcie_rp_init_port - Initialize hardware
+ * @pcie: PCIe port information
+ * @pdev: platform device
+ */
+static int amd_mdb_pcie_rp_init_port(struct amd_mdb_pcie *pcie,
+				     struct platform_device *pdev)
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
+static irqreturn_t amd_mdb_pcie_rp_event_flow(int irq, void *args)
+{
+	struct dw_pcie_rp *port = args;
+	struct amd_mdb_pcie *pcie;
+	unsigned long val;
+	int i;
+
+	pcie = get_mdb_pcie(port);
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
+	struct dw_pcie_rp *port = irq_data_get_irq_chip_data(d);
+	struct amd_mdb_pcie *pcie;
+	u32 val;
+
+	pcie = get_mdb_pcie(port);
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
+	struct dw_pcie_rp *port = irq_data_get_irq_chip_data(d);
+	struct amd_mdb_pcie *pcie;
+	u32 val;
+
+	pcie = get_mdb_pcie(port);
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
+ * amd_mdb_pcie_rp_init_irq_domain - Initialize IRQ domain
+ * @pcie: PCIe port information
+ * @pdev: platform device
+ * Return: '0' on success and error value on failure
+ */
+static int amd_mdb_pcie_rp_init_irq_domain(struct amd_mdb_pcie *pcie,
+					   struct platform_device *pdev)
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
+					       pp);
+	if (!pcie->mdb_domain)
+		goto out;
+
+	irq_domain_update_bus_token(pcie->mdb_domain, DOMAIN_BUS_NEXUS);
+
+	pcie->intx_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
+						  &amd_intx_domain_ops, pp);
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
+static irqreturn_t amd_mdb_pcie_rp_intr_handler(int irq, void *dev_id)
+{
+	struct dw_pcie_rp *port = dev_id;
+	struct amd_mdb_pcie *pcie;
+	struct device *dev;
+	struct irq_data *d;
+
+	pcie = get_mdb_pcie(port);
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
+		err = devm_request_irq(dev, irq, amd_mdb_pcie_rp_intr_handler,
+				       IRQF_SHARED | IRQF_NO_THREAD,
+				       intr_cause[i].sym, pp);
+		if (err) {
+			dev_err(dev, "Failed to request IRQ %d\n", irq);
+			return err;
+		}
+	}
+
+	/* Plug the main event chained handler */
+	err = devm_request_irq(dev, pp->irq, amd_mdb_pcie_rp_event_flow,
+			       IRQF_SHARED | IRQF_NO_THREAD, "pcie_irq", pp);
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
+	pp->ops = &amd_mdb_pcie_host_ops;
+
+	pcie->mdb_base = devm_platform_ioremap_resource_byname(pdev, "mdb_pcie_slcr");
+	if (IS_ERR(pcie->mdb_base))
+		return PTR_ERR(pcie->mdb_base);
+
+	ret = amd_mdb_pcie_rp_init_irq_domain(pcie, pdev);
+	if (ret)
+		return ret;
+
+	amd_mdb_pcie_rp_init_port(pcie, pdev);
+
+	ret = amd_mdb_setup_irq(pcie, pdev);
+	if (ret) {
+		dev_err(dev, "Failed to set up interrupts\n");
+		goto out;
+	}
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


