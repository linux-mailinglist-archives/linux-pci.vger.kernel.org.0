Return-Path: <linux-pci+bounces-22625-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 091A0A49526
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 10:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44B3E18964C6
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 09:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C049256C8C;
	Fri, 28 Feb 2025 09:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="neZljSk2"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B693C230276;
	Fri, 28 Feb 2025 09:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735275; cv=fail; b=ac/m9fzVhYwbs2Is3z6oCPqIV3gCPEPnIO50KX54ZhOClLNmvTuCat+UP0QJHLLpAGDJM0nddmL76RcXSxFtbzWjSrszRppV0F7dZh+gLSrjkY1JdqE/qKrdnE5y0Il6y3YneK0WDUehq/WrqTh4/qj/oCC5h+565i7BeOW9288=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735275; c=relaxed/simple;
	bh=Ah9RnsefYWN+UVXRdi9uTOIGJ0+3PNBnPCWieal258I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HmntXVJnYcy73MvIR02HSwpX7fOkHNkPG4K1KmIt+th5zkzg49C7RFQ4bFwe9ikkocFeL6KUSVxd7cdFRloukxQgLEsYJ/6k1HvibNSKDN+Y//4A11cz9pF5YCAKnpDiTyD+Pi6mBRoDoXFI1M+SS3LBjvdb1f0SAtIhmfiBpVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=neZljSk2; arc=fail smtp.client-ip=40.107.212.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BaSpgNeUwyyY1SZ4OB16UCiXtjvRv/U6RthMCK25SCRBW9anQb0UL2H0NYMeiK+hkIxGLXHWu7iE5JIEfu3d76YntIi3LopSZ4VuN84ezAWO7Hp1Emks3GqROGdPJ5k5CP0L3nhx+3/RXHrwuElESu0zU6XntGYC2dpuluFU5Tik2+Ej9K2/E3NtIKvIBiTVBtC1sVtob6/c5/iF03WabLREx/R0IxRbUSk+3uFmLKeBW4UHREjgvd1guDif9h2x2EeqCaX6ZAyrljdH4QYFHakVFuTqihUKQXxmv92OjhP/fOEili2ZtC74nbWC0GewUuaMyMqZUyh2VH0KKfWDqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCWagJ/usJxbxxHU+QZXzrRsGPwdG1+tajYPuUp3RdY=;
 b=XOzvQzNAcAxYmovvTgWzMWIb+Lf0pgOsH+I1ZfNw00BuycmQDP4dOe4zpphW6FM7l6YrrHfgiISje5RGeljmg2Ah2omB/1zL7lnjzy6tsgw8CHlwLPOwfEHOMHoatFAEFzjDb/Xq+o99k949I+RNupi0shCX8wQHTTHBVsqEgS+Z7PKzgiY644mJAL5Hqn/rsbyvvd+tXH9nZ24x0EG74MnzWpYJPOn0yPl6izBNYWpudRJeTI7TNRvTlxY4PD1WIzCrg1d5VhR1O5ihJKKMUMoF5g59i1DWVDfFYVhRBtAa6b8SqaEB0muireSUVgE18WLnFi3oK8mD02s15PuQCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCWagJ/usJxbxxHU+QZXzrRsGPwdG1+tajYPuUp3RdY=;
 b=neZljSk2JuTutljoIifBj7R3915qtmamjKA1iSO6dBxsbtLxvhF7RWvls3nawIUw2pb4377GOgDvjLvgtHz8v8AODu5VR2hKjZDVbguwkQ0hZXEAuVmcAF+WqH6L5FqwpUkCZEWLAGMqsuLv//oD3YTsQdhaQfp4JkpkcVU1p6M=
Received: from SJ0P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::22)
 by SA1PR12MB6972.namprd12.prod.outlook.com (2603:10b6:806:24f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Fri, 28 Feb
 2025 09:34:28 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::f9) by SJ0P220CA0014.outlook.office365.com
 (2603:10b6:a03:41b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.20 via Frontend Transport; Fri,
 28 Feb 2025 09:34:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 09:34:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 03:34:22 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 28 Feb 2025 03:34:19 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <jingoohan1@gmail.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v15 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Date: Fri, 28 Feb 2025 15:03:51 +0530
Message-ID: <20250228093351.923615-4-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228093351.923615-1-thippeswamy.havalige@amd.com>
References: <20250228093351.923615-1-thippeswamy.havalige@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|SA1PR12MB6972:EE_
X-MS-Office365-Filtering-Correlation-Id: f7b71f73-9c2d-4c7a-f5f8-08dd57db18a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BXHVGSqP48Qd6dVFJcRXH7DUZUxPa1HPNp2EJ88jSMfKU9d7I6T8r5/hGLPv?=
 =?us-ascii?Q?D7BEzJtRxHk4u/+SGVxMuOA0M9w1dn2eH76Pt+i5nIN728Aahjo4NVRF124P?=
 =?us-ascii?Q?yR5Vu2rKMurqf+vKXT8CQMlLJTbE529Z0mWQt/olAF5DXhAz9XPYdw+FxbIR?=
 =?us-ascii?Q?I1qIndmI35HpsY1dsNjE77jA0bwEjeFZvFkpW88lFpP+7STjKCwhSNTYVfeG?=
 =?us-ascii?Q?6X/H/bkvelRjLnKUheMP1cOoKG4wj4VofePzj/kxGp3JZZVpK+/8q9qkotr8?=
 =?us-ascii?Q?NwyZphh88Oiobs4igSgkUJDfd/xqK/n6M6sOzxnCnR9znY+L6t/nqklKfDnh?=
 =?us-ascii?Q?aXXmAwebx8zKDbdGZtJanhk+arQDhznyu9rkEBDtSeGM2YbLSeluILKJNjj3?=
 =?us-ascii?Q?wT+YnwlhD32abxWNzl6hLADm26hDd2rfwrmwoeQJBN1NUdOpENhAjHFp/vHx?=
 =?us-ascii?Q?+fL1EvRBWTv7z8sa7AV/AHVG48lVPQPl5bR/PfzDgjo35FdONGPU+OYCHlg9?=
 =?us-ascii?Q?px9BfRoWRQ6dAoFOqc3QaNYpN73DyOEe5Kcac9iTC4NYYCaueFbIDMDv8I4l?=
 =?us-ascii?Q?niaP0ZtcIWVm2wxEmLXjYjctDG5Ts53Vs1N4ghVvA835AMg7cvH4QJLZ+Mex?=
 =?us-ascii?Q?WVh5niv//ITVoScTSvZllVUZ/ICh0alrVsK/y+ISf+1gt7b5vR/RFMP+5ByO?=
 =?us-ascii?Q?DKjdriEDb4o1D//qOMqgONnbbkwxiKpybHa9xArNqTeIGgrHAlhNDSsvaLDz?=
 =?us-ascii?Q?uTEWGSQsOAF32UgUwa4K7trap1SKS7WD2qAvDlN2WbFXx2edNr5WW0j0HcGc?=
 =?us-ascii?Q?LsGoJQyXeAIpHfiMJYrVbyyuPyvHu8Rv4O99eTi8VUgSLUlXIJEsy3Elj6X4?=
 =?us-ascii?Q?7WFsU/zLC7w1gnRJrcKFcZQn/gqSocxxOvYFUkgX0Et5ljdnss9qCd/e2f57?=
 =?us-ascii?Q?I7PZbcWbTORWv8K9G5e3Sepw5bn7N2oX+HmdYz/IpROqpC/rn2RuB7tSmExZ?=
 =?us-ascii?Q?lEM51launP7NngqtdmXr6gNzu53qAY6GdEn+DMPqOUu8PqHhwNF9+Ktc2U7J?=
 =?us-ascii?Q?1vKXwt/p+bqFPahhEObpG7zwfch3C9VOy1kkGCiqA/t5zOfNcQzQnGsu+g9c?=
 =?us-ascii?Q?vE8+FUDlHTaEiZtvhdlZWujpsCYvsdEDA4xdN0Y7MbLQtFAe43TrfNciFlWm?=
 =?us-ascii?Q?0D/6BgwdvFpKkLW/nNttIVneVnZhJe85LYdmmCi/cjkAiKhEMq1DcBl3lf7F?=
 =?us-ascii?Q?QZZFYKZgH6daWwT3Z5kYVkyNQ3LQHYFS511p5CL84WS9ysKQzHne+mXFYrgx?=
 =?us-ascii?Q?UMojwcDYfIANz2EU+iFRTbbh478HrIYk8DngxN5jr+S4w8c9A42bO/2h6RrO?=
 =?us-ascii?Q?hkaSNFOgiIAtOknE8Q6FCCbrdmNuFIqHBH1kHMDrfmfypaM3jfM9hqgvYmqW?=
 =?us-ascii?Q?khfNHOYgak/3R/R/AVVdjd3sGkoErqrbUBu10WjziHhcUGE8Vwm+WfmhJijQ?=
 =?us-ascii?Q?XSg5ooT37bGHC84=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 09:34:27.8030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b71f73-9c2d-4c7a-f5f8-08dd57db18a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6972

Add support for AMD MDB (Multimedia DMA Bridge) IP core as Root Port.

The Versal2 devices include MDB Module. The integrated block for MDB along
with the integrated bridge can function as PCIe Root Port controller at
Gen5 32-GT/s operation per lane.

Bridge supports error and INTx interrupts and are handled using platform
specific interrupt line in Versal2.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
| Reported-by: kernel test robot <lkp@intel.com>
| Closes:
| https://lore.kernel.org/oe-kbuild-all/202502191741.xrVmEAG4-lkp@intel.
| com/
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
Changes in v11:
---------------
- Remove intx deassert macro & generic handler.
- Update Kconfig description.
- Update INTx mask macro to handle only asser bits.
- Move INTx handler.
- Address other review comments.
Changes in v12:
---------------
- ADD TLP_IR_DISABLE_MISC register.
- Modify intx call back function
Changes in v13:
- Add kernel doc for intx_irq
Changes in v14:
--------------
- Modify mask in intx_irq_mask/unmask functions.
- Modify mask in intx_flow handler.
Changes in v15:
---------------
- Fix commit message with GT/s
- Fix Kconfig
- Fix alignment issues.
- Remove pcie_read & pcie_write API's
- Fix function return types.
- Remove IRQF_SHARED for interrupt handler.
- Use lock_irqsave & unlock_irqrestore at required places.
- Remove _flow suffix for interrupt handlers.
---
 drivers/pci/controller/dwc/Kconfig        |  11 +
 drivers/pci/controller/dwc/Makefile       |   1 +
 drivers/pci/controller/dwc/pcie-amd-mdb.c | 472 ++++++++++++++++++++++
 3 files changed, 484 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-amd-mdb.c

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index b6d6778b0698..279240960828 100644
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
+	  Versal2 SoCs. The AMD MDB Versal2 PCIe controller is based on
+	  DesignWare IP and therefore the driver re-uses the DesignWare core
+	  functions to implement the driver.
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
index 000000000000..1f302d1c009a
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
@@ -0,0 +1,472 @@
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
+#define AMD_MDB_TLP_IR_DISABLE_MISC		0x4CC
+
+#define AMD_MDB_TLP_PCIE_INTX_MASK	GENMASK(23, 16)
+
+#define AMD_MDB_PCIE_INTR_INTX_ASSERT(x)	BIT((x) * 2)
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
+ * @intx_irq: INTx IRQ interrupt number
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
+static void amd_mdb_intx_irq_mask(struct irq_data *data)
+{
+	struct amd_mdb_pcie *pcie = irq_data_get_irq_chip_data(data);
+	struct dw_pcie *pci = &pcie->pci;
+	struct dw_pcie_rp *port = &pci->pp;
+	unsigned long flags;
+	u32 val;
+
+	raw_spin_lock_irqsave(&port->lock, flags);
+	val = FIELD_PREP(AMD_MDB_TLP_PCIE_INTX_MASK,
+			 AMD_MDB_PCIE_INTR_INTX_ASSERT(data->hwirq));
+
+	/*
+	 * Writing '1' to a bit in AMD_MDB_TLP_IR_DISABLE_MISC disables that
+	 * interrupt, writing '0' has no effect.
+	 */
+	writel_relaxed(val, pcie->slcr + AMD_MDB_TLP_IR_DISABLE_MISC);
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
+	val = FIELD_PREP(AMD_MDB_TLP_PCIE_INTX_MASK,
+			 AMD_MDB_PCIE_INTR_INTX_ASSERT(data->hwirq));
+
+	/*
+	 * Writing '1' to a bit in AMD_MDB_TLP_IR_ENABLE_MISC enables that
+	 * interrupt, writing '0' has no effect.
+	 */
+	writel_relaxed(val, pcie->slcr + AMD_MDB_TLP_IR_ENABLE_MISC);
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
+static irqreturn_t dw_pcie_rp_intx(int irq, void *args)
+{
+	struct amd_mdb_pcie *pcie = args;
+	unsigned long val;
+	int i, int_status;
+
+	val = readl_relaxed(pcie->slcr + AMD_MDB_TLP_IR_STATUS_MISC);
+	int_status = FIELD_GET(AMD_MDB_TLP_PCIE_INTX_MASK, val);
+
+	for (i = 0; i < PCI_NUM_INTX; i++) {
+		if (int_status & AMD_MDB_PCIE_INTR_INTX_ASSERT(i))
+			generic_handle_domain_irq(pcie->intx_domain, i);
+	}
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
+	unsigned long flags;
+	u32 val;
+
+	raw_spin_lock_irqsave(&port->lock, flags);
+	val = BIT(d->hwirq);
+	writel_relaxed(val, pcie->slcr + AMD_MDB_TLP_IR_DISABLE_MISC);
+	raw_spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static void amd_mdb_event_irq_unmask(struct irq_data *d)
+{
+	struct amd_mdb_pcie *pcie = irq_data_get_irq_chip_data(d);
+	struct dw_pcie *pci = &pcie->pci;
+	struct dw_pcie_rp *port = &pci->pp;
+	unsigned long flags;
+	u32 val;
+
+	raw_spin_lock_irqsave(&port->lock, flags);
+	val = BIT(d->hwirq);
+	writel_relaxed(val, pcie->slcr + AMD_MDB_TLP_IR_ENABLE_MISC);
+	raw_spin_unlock_irqrestore(&port->lock, flags);
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
+static irqreturn_t amd_mdb_pcie_event(int irq, void *args)
+{
+	struct amd_mdb_pcie *pcie = args;
+	unsigned long val;
+	int i;
+
+	val = readl_relaxed(pcie->slcr + AMD_MDB_TLP_IR_STATUS_MISC);
+	val &= ~readl_relaxed(pcie->slcr + AMD_MDB_TLP_IR_MASK_MISC);
+	for_each_set_bit(i, &val, 32)
+		generic_handle_domain_irq(pcie->mdb_domain, i);
+	writel_relaxed(val, pcie->slcr + AMD_MDB_TLP_IR_STATUS_MISC);
+
+	return IRQ_HANDLED;
+}
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
+static int amd_mdb_pcie_init_port(struct amd_mdb_pcie *pcie)
+{
+	unsigned long val;
+
+	/* Disable all TLP Interrupts */
+	writel_relaxed(AMD_MDB_PCIE_IMR_ALL_MASK,
+		       pcie->slcr + AMD_MDB_TLP_IR_DISABLE_MISC);
+
+	/* Clear pending TLP interrupts */
+	val = readl_relaxed(pcie->slcr + AMD_MDB_TLP_IR_STATUS_MISC);
+	val &= AMD_MDB_PCIE_IMR_ALL_MASK;
+	writel_relaxed(val, pcie->slcr + AMD_MDB_TLP_IR_STATUS_MISC);
+
+	/* Enable all TLP Interrupts */
+	writel_relaxed(AMD_MDB_PCIE_IMR_ALL_MASK,
+		       pcie->slcr + AMD_MDB_TLP_IR_ENABLE_MISC);
+
+	return 0;
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
+	int err;
+
+	pcie_intc_node = of_get_next_child(node, NULL);
+	if (!pcie_intc_node) {
+		dev_err(dev, "No PCIe Intc node found\n");
+		return -ENODEV;
+	}
+
+	pcie->mdb_domain = irq_domain_add_linear(pcie_intc_node, 32,
+						 &event_domain_ops, pcie);
+	if (!pcie->mdb_domain) {
+		err = -ENOMEM;
+		dev_err(dev, "Failed to add mdb_domain\n");
+		goto out;
+	}
+
+	irq_domain_update_bus_token(pcie->mdb_domain, DOMAIN_BUS_NEXUS);
+
+	pcie->intx_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
+						  &amd_intx_domain_ops, pcie);
+	if (!pcie->intx_domain) {
+		err = -ENOMEM;
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
+	return err;
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
+	/*
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
+
+		irq = irq_create_mapping(pcie->mdb_domain, i);
+		if (!irq) {
+			dev_err(dev, "Failed to map mdb domain interrupt\n");
+			return -ENOMEM;
+		}
+
+		err = devm_request_irq(dev, irq, amd_mdb_pcie_intr_handler,
+				       IRQF_NO_THREAD, intr_cause[i].sym, pcie);
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
+	err = devm_request_irq(dev, pcie->intx_irq, dw_pcie_rp_intx,
+			       IRQF_NO_THREAD, NULL, pcie);
+	if (err) {
+		dev_err(dev, "Failed to request INTx IRQ %d\n", irq);
+		return err;
+	}
+
+	/* Plug the main event handler */
+	err = devm_request_irq(dev, pp->irq, amd_mdb_pcie_event, IRQF_NO_THREAD,
+			       "amd_mdb pcie_irq", pcie);
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


