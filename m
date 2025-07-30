Return-Path: <linux-pci+bounces-33207-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE60DB1687D
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 23:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1D4B16896A
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 21:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC1122068F;
	Wed, 30 Jul 2025 21:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0q0iAzTF"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D300213D246;
	Wed, 30 Jul 2025 21:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753912111; cv=fail; b=gtaP+H4A80WWMEX4ooQap6iRnb+yHXypfqa3t7qS6xEtOfP8389xI+mAVBzPwZNqllKBC9kuiO2b6sis/Ye63fif4RnEUigsEXJ4q9ZwlJUZ4zIxPdje79dGomr3PrLIaL8AacqiHeS9fzGBuqCvTNcifuBxWw/ZGpcwRZJiQ4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753912111; c=relaxed/simple;
	bh=O62Y8JH1neR0ilRgPffk7vPXCyfd//O3ul0Yi+06+MY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U+1w0btWaLSNtAQE+6GrKkrXJ/p/kqp+/D4OGHHfmZZ6Ph3CbIcJelye2AyTasGQ0DJHcp70hlAFlL+TzErVQvLmp0OBa8PU96AHxDkfAefybNrSfd5qV+RvFzlaLtuW05lrco+uIUqqcN1Kfbl8YSKmsihGbj3lo8mv9vmvmFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0q0iAzTF; arc=fail smtp.client-ip=40.107.223.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MCMdSMhfr5rk8h/HeFDZpJpyGiEJ7X/TqpKU4MPhxnU08TUM/nYjlOmdq7i/cA4pLCqjVpaeby/bkbPzlJyvVe+TAb5oiJwSHFBu25ZfHhPaT7wvsdRckCIsw8C1jVSeSiOjzivrjXHSFTzI1yrBUIZTHpIbriV9irYReJvsCT1A9qMSSNbfs7iO+CvSGPyi+Cjc3QM7F1tbxCBVcXociZrlhCVWhH+skiLnKVQ8QzknkLYZg3zpFJUoI8/FwZgePH2R6o4ngytKiYnbOpELezaWpSBjixHWo7VyN8/c1HxN+p1oAduq+ojt3Q3/5emhp+E3OdYDW7oqBQ0AjwjHZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCUvQ1HqQs4PkkA1F/NO9Uxcxx+JhzHUOE4S6HtPxUs=;
 b=xhjKFqAUcwtk9aFUOO745MZVENTiNTqNE2HmeAj3q4S5kd9yZLZKZ6QLPmoO+xfxyY4McqnYCwwLrQx8GNn4bq/HXu4PJaf5622MH9LitadlLmA3aH1ibwrKyefjP8K0+hO8FvHPa1pCQbUmCu4g+h3l/OOieYNzcWhU9WKtdWNLKubFanRkfXOqRLGYXUVQz5tUELqT2A1rz8JLpAiCw8qu3nEeI15lRZQE2Zpl/N5y6B3BB7R4GA627FoKgqedaw0XSyeg2fu4xfgNaojp2USWvcACnXt/r6zZELtwQs/l3ILEhnrndAtnQTFysmu4VAyLymxf1aGuEZPcLSJCIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCUvQ1HqQs4PkkA1F/NO9Uxcxx+JhzHUOE4S6HtPxUs=;
 b=0q0iAzTFbLXI+Msoz2NETR5Lt4B2SKKzjPwQxKQrXATzG5TLFaHnI5eIPGob6UetUpaoFfz8fkypWaz3eb6TEwySsT5zFPrdU2XUr0KUo2HZ6ghru7l92H074DqyhOobag7JissI1nUOUbYC1S4JfSeMmsOwF3E/cO7H+2M4aAk=
Received: from BL1PR13CA0415.namprd13.prod.outlook.com (2603:10b6:208:2c2::30)
 by CH1PPF931B95D07.namprd12.prod.outlook.com (2603:10b6:61f:fc00::619) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 30 Jul
 2025 21:48:26 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::83) by BL1PR13CA0415.outlook.office365.com
 (2603:10b6:208:2c2::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Wed,
 30 Jul 2025 21:48:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 21:48:26 +0000
Received: from SCS-L-bcheatha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 16:48:22 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [PATCH 03/16] PCI: PCIe portdrv: Add CXL Isolation service driver
Date: Wed, 30 Jul 2025 16:47:05 -0500
Message-ID: <20250730214718.10679-4-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
References: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|CH1PPF931B95D07:EE_
X-MS-Office365-Filtering-Correlation-Id: 53334590-af79-442a-f0e7-08ddcfb2d033
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H3z1j7CMhh27gf6caQEybP1MH+VHaW8gA5haIOXS54Oc1VCrCmaC7re5S/AQ?=
 =?us-ascii?Q?MgPxX0BnbkHBr6nJ4PaXZBSbwSma9DJfT2fEV7m1gruSBVDwAxjesluNEmTe?=
 =?us-ascii?Q?44wQFmCMr1k4bxfI+RKu4UqRQ8TiY0+eGD5G8WoJSyNPlW7K96hntBxaaawl?=
 =?us-ascii?Q?pBBriJpNucv0jBqSpic9K1Hetcauj/FVk/mHF7MfngqRIzDFsgvyhNytVwzE?=
 =?us-ascii?Q?Nrc6j0BLlb4lGYWIKfM4HJx5NJamVgSxuibgrRbqyfDJBrKc1qHDTLcw3PKn?=
 =?us-ascii?Q?vqoYGmMSN6X7CFywK8UJK3fIm6dOC09z5MBJuVq2rRwn4/jlUEqUjHTW0E8n?=
 =?us-ascii?Q?2tKP9B0AqIpwAeG8s0wFbLUkH3ysvxTPSsNK2VsDPsF1QDVUUBMONuwgfXcM?=
 =?us-ascii?Q?Kh7ZgD5DKlmEO8bkjtTFY6ZbnR3SNSDoumUoWQVf0tw3ua5pwfQyzC2BJJuz?=
 =?us-ascii?Q?PgKof2I4aCqL3cKLcIJV1hZQfDX9Ug+O5ixsncpzhSOPYwgULKACasduLp08?=
 =?us-ascii?Q?jGfknSY8hO+NQQrTW+OLCJXsLwHM7VGMcgKT/MZUWvbzBUzmYZ7rEU6bBwbt?=
 =?us-ascii?Q?pbpKmZK0da8QE1vjYhkR8ktekwihIr56kM+wvfdIcDbXRcZ770KAFaIjytxS?=
 =?us-ascii?Q?mPxFRmeF8xnFwdMGG9BVb65FEIRslqNq5zV4YYzpflceblxtNViqL8UxyDRQ?=
 =?us-ascii?Q?vucqZqjdkHoMIF7OhO6MUOzoYDMF02q2U6g7/pDco+nF+30X1lh2sCnoiwff?=
 =?us-ascii?Q?AhJSw81XOcA/lTfGELsB7K1eljXGAEin/HjTMiAkur+QDnQPab//kF8g/y0J?=
 =?us-ascii?Q?ABHjuWZ3P0jBeu955zDhkKvv7F9cS/qa0y8CllXnNXcSKeXlfchAsdxn5tH2?=
 =?us-ascii?Q?KGrwOS0xFCdaTyOleqS/ZSozOYss2DUkFgaK6avZNaL9a4bUz5PeOD/u1Vs9?=
 =?us-ascii?Q?lw2KCKCaNuXBx6zqmXdkefi4RLF7P/uwETs+RnNu17qk/a5edE4KKrHRr3q2?=
 =?us-ascii?Q?2+T3asPswXH0wsPH6cGQdly0PC7w1DSH6kCLvUhOY1KFp6Z6mk9evusXldjm?=
 =?us-ascii?Q?1L5DJPsYQpbMxVrmssY6zSxb4XWrq4vJMOloSPESPVTiGSlNswWPY8KhDd2t?=
 =?us-ascii?Q?/NNrZA/kIaBMf6lEJZ4dwbjTy/ydnmZLigTyeKHpPWyTlX4h7hVLgAIGCYaR?=
 =?us-ascii?Q?7jiKhEUyXEcqAmTlabXW/wHaWWYyqEFYXu3kf8sYQC5+hlHe7Yx1Vg3SOZEn?=
 =?us-ascii?Q?cuMXbfk0Px2+Xyy3JE4FFZOO+bWpY++aJhjzD8yKGr3QAtAyA4FvUevXd1zU?=
 =?us-ascii?Q?WORVtDSxZ6r73kj6SeJB7i7lGdQW4aXKtzHY2LUNxAPDl+LiFS2xjmjzIVCg?=
 =?us-ascii?Q?zpgzam42bJAyvi2JxF3yemR3Evhw9gubTWaJy0KHalziW4T6t2TFkkYnIcUn?=
 =?us-ascii?Q?PSIMkNmH9INxK63d/dI4TPIDRrDxntcdJDd2XSeKyFe7Tf8zVDRGk/GM9N6t?=
 =?us-ascii?Q?AxWCtURenSQf2/GbqLtJ9skAEHs9u1xNreML?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 21:48:26.0238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53334590-af79-442a-f0e7-08ddcfb2d033
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF931B95D07

Add the CXL isolation service, which will provide the necessary
information to the PCIe portdrv and CXL drivers to map, setup, and
handle CXL isolation interrupts.

Add functions to get the CXL isolation MSI/-X interrupt vector
from the PCIe portdrv.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/Kconfig              | 14 +++++
 drivers/cxl/cxl.h                |  4 ++
 drivers/pci/pcie/Makefile        |  1 +
 drivers/pci/pcie/cxl_isolation.c | 87 ++++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.c       |  1 +
 drivers/pci/pcie/portdrv.h       | 18 ++++++-
 6 files changed, 124 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/pcie/cxl_isolation.c

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 57274de54a45..537e1e8e13da 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -247,4 +247,18 @@ config CXL_NATIVE_RAS
 	  If unsure, or if this kernel is meant for production environments,
 	  say Y.
 
+config CXL_ISOLATION
+	bool "CXL.mem Isolation Support"
+	depends on PCIEPORTBUS
+	depends on CXL_BUS=PCIEPORTBUS
+	help
+	  Enables the CXL.mem isolation PCIe port bus service driver. This
+	  driver, in combination with the CXL driver core, is responsible
+	  for managing CXL-capable PCIe root ports that undergo CXL.mem
+	  error isolation due to either a CXL.mem transaction timeout or
+	  link down condition. Without error isolation, either of these
+	  conditions will trigger a system reset.
+
+	  If unsure say 'y'
+
 endif
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 3013ba600ba3..fdd7c4e024a6 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -135,6 +135,10 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 }
 
 /* CXL 3.2 8.2.4.24 CXL Timeout and Isolation Capability Structure */
+#define CXL_ISOLATION_CAPABILITY_OFFSET 0x0
+#define   CXL_ISOLATION_CAP_MEM_ISO_SUPP BIT(16)
+#define   CXL_ISOLATION_CAP_INTR_SUPP BIT(26)
+#define   CXL_ISOLATION_CAP_INTR_MASK GENMASK(31, 27)
 #define CXL_ISOLATION_CAPABILITY_LENGTH 0x10
 
 /* RAS Registers CXL 2.0 8.2.5.9 CXL RAS Capability Structure */
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index cd2cb925dbd5..8b959ddb9684 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -14,3 +14,4 @@ obj-$(CONFIG_PCIE_PME)		+= pme.o
 obj-$(CONFIG_PCIE_DPC)		+= dpc.o
 obj-$(CONFIG_PCIE_PTM)		+= ptm.o
 obj-$(CONFIG_PCIE_EDR)		+= edr.o
+obj-$(CONFIG_CXL_ISOLATION)	+= cxl_isolation.o
diff --git a/drivers/pci/pcie/cxl_isolation.c b/drivers/pci/pcie/cxl_isolation.c
new file mode 100644
index 000000000000..550f16271d1c
--- /dev/null
+++ b/drivers/pci/pcie/cxl_isolation.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The CXL Isolation PCIe port service driver provides functions to allocate
+ * and set up CXL Timeout & Isolation interrupts (CXL 3.2 12.3). This driver
+ * does no actual interrupt handling, it only provides the information for
+ * the CXL driver to set up its own handling because the CXL driver is better
+ * equipped to handle isolation interrupts.
+ *
+ * Copyright (C) 2025, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author: Ben Cheatham <Benjamin.Cheatham@amd.com>
+ */
+
+#include <linux/pci.h>
+
+#include "../../cxl/cxlpci.h"
+#include "portdrv.h"
+
+static int get_isolation_intr_vec(u32 cap)
+{
+	if (!FIELD_GET(CXL_ISOLATION_CAP_INTR_SUPP, cap) ||
+	    !FIELD_GET(CXL_ISOLATION_CAP_MEM_ISO_SUPP, cap))
+		return -ENXIO;
+
+	return FIELD_GET(CXL_ISOLATION_CAP_INTR_MASK, cap);
+}
+
+int pcie_cxliso_get_intr_vec(struct pci_dev *dev, int *vec)
+{
+	struct cxl_component_regs regs;
+	struct cxl_register_map map;
+	u32 cap;
+	int rc;
+
+	rc = cxl_find_regblock(dev, CXL_REGLOC_RBI_COMPONENT, &map);
+	if (rc)
+		return rc;
+
+	rc = cxl_setup_regs(&map);
+	if (rc)
+		return rc;
+
+	if (!map.component_map.isolation.valid)
+		return -ENXIO;
+
+	rc = cxl_map_component_regs(&map, &regs,
+				    BIT(CXL_CM_CAP_CAP_ID_ISOLATION));
+	if (rc)
+		return rc;
+
+	cap = readl(regs.isolation + CXL_ISOLATION_CAPABILITY_OFFSET);
+	rc = get_isolation_intr_vec(cap);
+	if (rc < 0) {
+		cxl_unmap_component_regs(&map, &regs,
+					 BIT(CXL_CM_CAP_CAP_ID_ISOLATION));
+		return rc;
+	}
+
+	if (vec)
+		*vec = rc;
+
+	cxl_unmap_component_regs(&map, &regs, BIT(CXL_CM_CAP_CAP_ID_ISOLATION));
+	return 0;
+
+}
+
+static int cxl_isolation_probe(struct pcie_device *dev)
+{
+	if (!pcie_is_cxl(dev->port) || pcie_cxliso_get_intr_vec(dev->port, NULL))
+		return -ENXIO;
+
+	pci_info(dev->port, "CXLISO: Signaling with IRQ %d\n", dev->irq);
+	return 0;
+}
+
+static struct pcie_port_service_driver isolationdriver = {
+	.name = "cxl_isolation",
+	.port_type = PCI_EXP_TYPE_ROOT_PORT,
+	.service = PCIE_PORT_SERVICE_CXLISO,
+	.probe = cxl_isolation_probe,
+};
+
+int __init pcie_cxliso_init(void)
+{
+	return pcie_port_service_register(&isolationdriver);
+}
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index e8318fd5f6ed..465d1aec4ca6 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -834,6 +834,7 @@ static void __init pcie_init_services(void)
 	pcie_dpc_init();
 	pcie_bwctrl_init();
 	pcie_hp_init();
+	pcie_cxliso_init();
 }
 
 static int __init pcie_portdrv_init(void)
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index bd29d1cc7b8b..a9bfdb0b82be 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -22,8 +22,10 @@
 #define PCIE_PORT_SERVICE_DPC		(1 << PCIE_PORT_SERVICE_DPC_SHIFT)
 #define PCIE_PORT_SERVICE_BWCTRL_SHIFT	4	/* Bandwidth Controller (notifications) */
 #define PCIE_PORT_SERVICE_BWCTRL	(1 << PCIE_PORT_SERVICE_BWCTRL_SHIFT)
+#define PCIE_PORT_SERVICE_CXLISO_SHIFT	5	/* CXL Timeout & Isolation */
+#define PCIE_PORT_SERVICE_CXLISO	(1 << PCIE_PORT_SERVICE_CXLISO_SHIFT)
 
-#define PCIE_PORT_DEVICE_MAXSERVICES   5
+#define PCIE_PORT_DEVICE_MAXSERVICES   6
 
 extern bool pcie_ports_dpc_native;
 
@@ -53,6 +55,12 @@ static inline int pcie_dpc_init(void) { return 0; }
 
 int pcie_bwctrl_init(void);
 
+#ifdef CONFIG_CXL_ISOLATION
+int pcie_cxliso_init(void);
+#else
+static inline int pcie_cxliso_init(void) { return 0; }
+#endif
+
 /* Port Type */
 #define PCIE_ANY_PORT			(~0)
 
@@ -123,4 +131,12 @@ static inline void pcie_pme_interrupt_enable(struct pci_dev *dev, bool en) {}
 #endif /* !CONFIG_PCIE_PME */
 
 struct device *pcie_port_find_device(struct pci_dev *dev, u32 service);
+
+#ifdef CONFIG_CXL_ISOLATION
+int pcie_cxliso_get_intr_vec(struct pci_dev *dev, int *vec);
+#else
+static inline int pcie_cxliso_get_intr_vec(struct pci_dev *dev, int *vec)
+{ return -ENXIO; }
+#endif
+
 #endif /* _PORTDRV_H_ */
-- 
2.34.1


