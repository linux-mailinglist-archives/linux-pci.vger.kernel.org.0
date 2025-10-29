Return-Path: <linux-pci+bounces-39617-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78287C18F42
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 09:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92DB14640E7
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 08:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC783128CC;
	Wed, 29 Oct 2025 08:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dxPgKMqV"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazhn15012016.outbound.protection.outlook.com [52.102.137.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8096131B10D;
	Wed, 29 Oct 2025 08:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.137.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725177; cv=fail; b=BMf9eVDO9Ev5X/+CnURiLoBm28erM3AfqByovaGe1dczNsDf1YsX01yX4igFX4u2gTqPZh64GS8uN1PFoBzIPp+1EbUn5kLTTu/TFQ7hSst7/s32dvcaNQ7bQREXUzkmgGDKzCgGuGqP97UWQtu3yQBbVqlBdgyNkw3M3xKc3ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725177; c=relaxed/simple;
	bh=Pu2qbLo05SeIku5YlbqlxZEy6k1+xzLTzWX9GtElL2k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b4dk124r2WBM3ejd4gZmc2P2aW6VQIhLP0l2WiG0yC6fpj6aEmqMcjru4FC5n4zmczRayNT2UpQorGdJHhHduC6QQc9HV8SO6jVDvn5LyEysqWTf/PvUxc2ZW+3HkH2hnuv9bsfF19QuFo72CSPQZqnGbQFBKbxtaOtbtMuNEhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dxPgKMqV; arc=fail smtp.client-ip=52.102.137.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fV6AedWLqwfniXig+fQkbd9b6KH8PJDTICZXoU/o4PgXFB/2E+cP1V4ub8wf1epGRrd/BrbeoWxNsF1p/BaLB2Wr4fYuB8n+KzsH+oRS5rOgIEn4+Djc1iyTpiBCaEauJ1TbO321Rr8LXRzBvkcFL0rg88aT0rMAAA+11+0gvbaD89BOvQiv8Ivbi480YnSi264S5ZrBmvcPRxeUiJUwfHjELbkwIXtBKFmaA91pyJzneriCanoian6LyfdHnZTOMXyR9L79quwBeLpmyBaOvylq7t29bf+Kc1clQ34ZltkIS5X8zD/rRnecE5m7ZqV7BCMPOtnPN5vQUk6ifSc9EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cfeFEwvP97w5VwKIXsqz1yzfF7xnqTbAvPZSTTJstQ=;
 b=EPVhfKt75iZW0ThL1kITBkjJRXpKW3kKP1+OsJg9ovdrDcxy3F5vYT6J7ThFJmNNfswqHZhIwycq+JWUP2UcnWfr/0DIT1RqqYiYKRO7jHBC3RWkS9tqYvBsOO3tswCOPXkQLXoM977Uq+v9nV+8uS/r61I1qk75V/WuO9jcjDhCAclLVwolGcsL1/PHKpsyHc4zY0P7fJXt5pcDCn3lwu1dgu7sfH0jGwy9TJTY+wcvvzXPp9QodhkAVxZptyagJccNDxB4nX35f9blPBQEiMNo1hiFvq/Y6LC5LPTPTS1/9BZS1+jOXMV8MDsZhw3pkRKL0rEs3WlW/jaEhbvU3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cfeFEwvP97w5VwKIXsqz1yzfF7xnqTbAvPZSTTJstQ=;
 b=dxPgKMqVq6Abejj3afThhIBb6OrGFHyq3iTv3YV2ZZzgADit+2o9Ra7YeR8iy8UV+dSdgzub2cjqcLfsS2RMmHyS8HdRokqpY26igO+D67FwpJZIAI3+wmbeVNFLEvuFASc3BnGjIk2SbtItjFJPyv9MdqpIgJ5JSc9CAstaEL0=
Received: from CH2PR05CA0057.namprd05.prod.outlook.com (2603:10b6:610:38::34)
 by MW4PR10MB6369.namprd10.prod.outlook.com (2603:10b6:303:1ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 29 Oct
 2025 08:06:12 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::29) by CH2PR05CA0057.outlook.office365.com
 (2603:10b6:610:38::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Wed,
 29 Oct 2025 08:06:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 08:06:10 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 03:06:07 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 03:06:06 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 29 Oct 2025 03:06:06 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59T85aXi3704660;
	Wed, 29 Oct 2025 03:06:01 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<christian.bruel@foss.st.com>, <krishna.chundru@oss.qualcomm.com>,
	<qiang.yu@oss.qualcomm.com>, <shradha.t@samsung.com>,
	<thippeswamy.havalige@amd.com>, <inochiama@gmail.com>, <fan.ni@samsung.com>,
	<cassel@kernel.org>, <kishon@kernel.org>, <18255117159@163.com>,
	<rongqianfeng@vivo.com>, <jirislaby@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v5 4/4] PCI: keystone: Add support to build as a loadable module
Date: Wed, 29 Oct 2025 13:34:52 +0530
Message-ID: <20251029080547.1253757-5-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029080547.1253757-1-s-vadapalli@ti.com>
References: <20251029080547.1253757-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|MW4PR10MB6369:EE_
X-MS-Office365-Filtering-Correlation-Id: 78747c45-e70d-449c-3f2c-08de16c2055e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|34020700016|1800799024|36860700013|376014|82310400026|7416014|921020|12100799066;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U/CcA40PsCoa2Q3Q2rIsXs2JhPTMIXbMxlU/TcM2kxN8znHbIbf33pmcAs8k?=
 =?us-ascii?Q?ckw7rt8hWTCHJoa+UI14QxeoEJp8/n+d4r6uiBPSSyS9k6DWlfj4B4kCavXM?=
 =?us-ascii?Q?BiHoz+VXub64ohbh4IF3cMgT+hvS5wX1xGIYAB6Xt6a95iPzT8lEPgcJkL9u?=
 =?us-ascii?Q?cnUzylQUBt+llOaFJrBRRXX3t4GT8Gu44Tdnze2e6hhDkwn1C6zy4vGJYxio?=
 =?us-ascii?Q?r9zA9LIaaY9z2ZwlN8ol7WaXKyNgfpT6GC2rjTSO3FgTPV0XFl3Av5sNHrBT?=
 =?us-ascii?Q?wnQSQqq/gqrvTj/NyJYNenf/stUZR35SlzxRWcdoPBAd50CZUwVP+1kxEcYa?=
 =?us-ascii?Q?bxkAAVIMikg2PsogYm7spH2GfOl+1g/PjQA4w8g8TDkaUtTk35makAVAkWv+?=
 =?us-ascii?Q?8/jGxyiK4cDjTp2lnVN/gEj3n3m3fIky6JhUynjPIJjbwCD+w9Z4lV1E+z7O?=
 =?us-ascii?Q?VK/9M/BlVmMUrba9XouH1PjzwX4aWQaPyfHNTP3pWK1pfr5S2vvyHFHbJavc?=
 =?us-ascii?Q?cki+nZ3nSwCmJujQJTb2zEjcKHnjzSbnX58kAPxIsN7VlCLEnPKzmrjzg6YV?=
 =?us-ascii?Q?bAA7WJWVAwInZpH7OcRghk4jk66fPyvqADtfpDmTYMBdlQ0TnDY8zcQ+v2Bu?=
 =?us-ascii?Q?RbR/UZahQNupgCxgTHouMbFEN74qsNptSDsB3W7H0iy1IfKai3pGDoLFnwgz?=
 =?us-ascii?Q?y8bizNQaUn1QDVhZEt1QWzCpdxFBEwcm6RhfoNvwtG7X5BfUjts6in2oO+Mx?=
 =?us-ascii?Q?XheF2zD9d8OHR2Bz1zBgT1fG7wXMlABcQZQPLVXd74XMHpiCiS/rCONP3itA?=
 =?us-ascii?Q?CKfw6bUACXO70LDIxDMX5PukWig2s/lJ6B/vXSx+PwGY2YVReoA7gFGrJBCF?=
 =?us-ascii?Q?8W8adZxWD5i9EsUqoyZmpnV2JAkj5T5V1vacUAax872A0AGuk53HbHu5Nhbg?=
 =?us-ascii?Q?CHW2Sy7X+RYPIErPYLo+D/C2OPEBrxRsPGdCcevvsxcbckGA9S3KFQJlzgGD?=
 =?us-ascii?Q?kvKK060Sol4lvdrn1bziHGrhr5Cz826LphGfKUiRCbLM/d/Ubcyi6UURgUAm?=
 =?us-ascii?Q?v/CbqkoionXZdJbZLuwXdYDZDN2zm3YOVTy4ZM5QgjM/wL2YJzPWTLci4jmj?=
 =?us-ascii?Q?OM+yR2FrYnuVjr1JwO11C3Zp0p8/bjeKPiCIMAST1dk3i9wOTa45pPHINlD5?=
 =?us-ascii?Q?4mxarD3IVJ9EAnJIGeRoAEns5V6dmneUo57Li4A2WNORY3WhFZ/04sQ0NUZE?=
 =?us-ascii?Q?5nBuFKPyNDLM+Q4/RATrwtjBlk7YV7kWCjwr5BCvj2bGKoRi97EpqxZWnrU3?=
 =?us-ascii?Q?KZcyJ+KI0kDHUT4jM/qmGwZHho/88erLD1BElXcL6e3+ChXIeePrqvhDctnp?=
 =?us-ascii?Q?tSNhbSUVfFVHzU9z3Iccil+ssrjZj35pEZXh+CVk9HdfMFWqCnln0WzhDa6O?=
 =?us-ascii?Q?i4V90fdxa5IZQfpjZI+eQKm0Zj29sOFIe32FIV4y1niPpwfEF6urCVjdqHwr?=
 =?us-ascii?Q?mPZ42aRNB0BzM/4UEtC+hUlufck4ChYLApnh?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(34020700016)(1800799024)(36860700013)(376014)(82310400026)(7416014)(921020)(12100799066);DIR:OUT;SFP:1501;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:06:10.1464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78747c45-e70d-449c-3f2c-08de16c2055e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6369

The 'pci-keystone.c' driver is the application/glue/wrapper driver for the
Designware PCIe Controllers on TI SoCs. Now that all of the helper APIs
that the 'pci-keystone.c' driver depends upon have been exported for use,
enable support to build the driver as a loadable module.

Additionally, the functions marked by the '__init' keyword may be invoked:
a) After a probe deferral
OR
b) During a delayed probe - Delay attributed to driver being built as a
   loadable module

In both of the cases mentioned above, the '__init' memory will be freed
before the functions are invoked. This results in an exception of the form:

	Unable to handle kernel paging request at virtual address ...
	Mem abort info:
	...
	pc : ks_pcie_host_init+0x0/0x540
	lr : dw_pcie_host_init+0x170/0x498
	...
	ks_pcie_host_init+0x0/0x540 (P)
	ks_pcie_probe+0x728/0x84c
	platform_probe+0x5c/0x98
	really_probe+0xbc/0x29c
	__driver_probe_device+0x78/0x12c
	driver_probe_device+0xd8/0x15c
	...

To address this, introduce a new function namely 'ks_pcie_init()' to
register the 'fault handler' while removing the '__init' keyword from
existing functions.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

v4:
https://lore.kernel.org/r/20251022095724.997218-5-s-vadapalli@ti.com/
Changes since v4:
- To fix the build error on ARM32 platforms as reported at:
  https://lore.kernel.org/r/202510281008.jw19XuyP-lkp@intel.com/
  patch 4 in the series has been updated by introducing a new config
  named "PCI_KEYSTONE_TRISTATE" which allows building the driver as
  a loadable module. Additionally, this newly introduced config can
  be enabled only for non-ARM32 platforms. As a result, ARM32 platforms
  continue using the existing PCI_KEYSTONE config which is a bool, while
  ARM64 platforms can use PCI_KEYSTONE_TRISTATE which is a tristate, and
  can optionally enabled loadable module support being enabled by this
  series.

Regards,
Siddharth.

 drivers/pci/controller/dwc/Kconfig        | 15 +++--
 drivers/pci/controller/dwc/Makefile       |  3 +
 drivers/pci/controller/dwc/pci-keystone.c | 78 +++++++++++++----------
 3 files changed, 59 insertions(+), 37 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 349d4657393c..c5bc2f0b1f39 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -482,15 +482,21 @@ config PCI_DRA7XX_EP
 	  to enable device-specific features PCI_DRA7XX_EP must be selected.
 	  This uses the DesignWare core.
 
+# ARM32 platforms use hook_fault_code() and cannot support loadable module.
 config PCI_KEYSTONE
 	bool
 
+# On non-ARM32 platforms, loadable module can be supported.
+config PCI_KEYSTONE_TRISTATE
+	tristate
+
 config PCI_KEYSTONE_HOST
-	bool "TI Keystone PCIe controller (host mode)"
+	tristate "TI Keystone PCIe controller (host mode)"
 	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
 	depends on PCI_MSI
 	select PCIE_DW_HOST
-	select PCI_KEYSTONE
+	select PCI_KEYSTONE if ARM
+	select PCI_KEYSTONE_TRISTATE if !ARM
 	help
 	  Enables support for the PCIe controller in the Keystone SoC to
 	  work in host mode. The PCI controller on Keystone is based on
@@ -498,11 +504,12 @@ config PCI_KEYSTONE_HOST
 	  DesignWare core functions to implement the driver.
 
 config PCI_KEYSTONE_EP
-	bool "TI Keystone PCIe controller (endpoint mode)"
+	tristate "TI Keystone PCIe controller (endpoint mode)"
 	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
-	select PCI_KEYSTONE
+	select PCI_KEYSTONE if ARM
+	select PCI_KEYSTONE_TRISTATE if !ARM
 	help
 	  Enables support for the PCIe controller in the Keystone SoC to
 	  work in endpoint mode. The PCI controller on Keystone is based
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index 7ae28f3b0fb3..7c8de0067612 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -11,7 +11,10 @@ obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
 obj-$(CONFIG_PCIE_FU740) += pcie-fu740.o
 obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
 obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
+# ARM32 platforms use hook_fault_code() and cannot support loadable module.
 obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone.o
+# On non-ARM32 platforms, loadable module can be supported.
+obj-$(CONFIG_PCI_KEYSTONE_TRISTATE) += pci-keystone.o
 obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
 obj-$(CONFIG_PCI_LAYERSCAPE_EP) += pci-layerscape-ep.o
 obj-$(CONFIG_PCIE_QCOM_COMMON) += pcie-qcom-common.o
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 25b8193ffbcf..53f88b31ad43 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -17,6 +17,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/mfd/syscon.h>
+#include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
@@ -777,29 +778,7 @@ static int ks_pcie_config_intx_irq(struct keystone_pcie *ks_pcie)
 	return ret;
 }
 
-#ifdef CONFIG_ARM
-/*
- * When a PCI device does not exist during config cycles, keystone host
- * gets a bus error instead of returning 0xffffffff (PCI_ERROR_RESPONSE).
- * This handler always returns 0 for this kind of fault.
- */
-static int ks_pcie_fault(unsigned long addr, unsigned int fsr,
-			 struct pt_regs *regs)
-{
-	unsigned long instr = *(unsigned long *) instruction_pointer(regs);
-
-	if ((instr & 0x0e100090) == 0x00100090) {
-		int reg = (instr >> 12) & 15;
-
-		regs->uregs[reg] = -1;
-		regs->ARM_pc += 4;
-	}
-
-	return 0;
-}
-#endif
-
-static int __init ks_pcie_init_id(struct keystone_pcie *ks_pcie)
+static int ks_pcie_init_id(struct keystone_pcie *ks_pcie)
 {
 	int ret;
 	unsigned int id;
@@ -831,7 +810,7 @@ static int __init ks_pcie_init_id(struct keystone_pcie *ks_pcie)
 	return 0;
 }
 
-static int __init ks_pcie_host_init(struct dw_pcie_rp *pp)
+static int ks_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
@@ -861,15 +840,6 @@ static int __init ks_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret < 0)
 		return ret;
 
-#ifdef CONFIG_ARM
-	/*
-	 * PCIe access errors that result into OCP errors are caught by ARM as
-	 * "External aborts"
-	 */
-	hook_fault_code(17, ks_pcie_fault, SIGBUS, 0,
-			"Asynchronous external abort");
-#endif
-
 	return 0;
 }
 
@@ -1134,6 +1104,7 @@ static const struct of_device_id ks_pcie_of_match[] = {
 	},
 	{ },
 };
+MODULE_DEVICE_TABLE(of, ks_pcie_of_match);
 
 static int ks_pcie_probe(struct platform_device *pdev)
 {
@@ -1381,4 +1352,45 @@ static struct platform_driver ks_pcie_driver = {
 		.of_match_table = ks_pcie_of_match,
 	},
 };
+
+#ifdef CONFIG_ARM
+/*
+ * When a PCI device does not exist during config cycles, keystone host
+ * gets a bus error instead of returning 0xffffffff (PCI_ERROR_RESPONSE).
+ * This handler always returns 0 for this kind of fault.
+ */
+static int ks_pcie_fault(unsigned long addr, unsigned int fsr,
+			 struct pt_regs *regs)
+{
+	unsigned long instr = *(unsigned long *)instruction_pointer(regs);
+
+	if ((instr & 0x0e100090) == 0x00100090) {
+		int reg = (instr >> 12) & 15;
+
+		regs->uregs[reg] = -1;
+		regs->ARM_pc += 4;
+	}
+
+	return 0;
+}
+
+static int __init ks_pcie_init(void)
+{
+	/*
+	 * PCIe access errors that result into OCP errors are caught by ARM as
+	 * "External aborts"
+	 */
+	if (of_find_matching_node(NULL, ks_pcie_of_match))
+		hook_fault_code(17, ks_pcie_fault, SIGBUS, 0,
+				"Asynchronous external abort");
+
+	return platform_driver_register(&ks_pcie_driver);
+}
+device_initcall(ks_pcie_init);
+#else
 builtin_platform_driver(ks_pcie_driver);
+#endif
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("PCIe controller driver for Texas Instruments Keystone SoCs");
+MODULE_AUTHOR("Murali Karicheri <m-karicheri2@ti.com>");
-- 
2.51.0


