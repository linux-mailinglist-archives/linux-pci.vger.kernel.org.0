Return-Path: <linux-pci+bounces-12040-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE0195BFB0
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 22:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35AFD1C23396
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 20:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0891D0DF7;
	Thu, 22 Aug 2024 20:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PYC/y+2f"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2076.outbound.protection.outlook.com [40.107.212.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174B71CDFD5;
	Thu, 22 Aug 2024 20:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724359305; cv=fail; b=UOQ68yWIkDeUHlPxoskdeK4lQ3Jt7VFMeYuUGiVb/8ovrnZ4mUqvY4cmB7wm3J6KOPkns0eSw+41ejbCXlz4BICH2DwG61ZBlqulsqHRe900jAkhsLPJEiZHsbNlwgzWYZHdjC/KbV48swt/1r9bDHeR9OajUuBbYZUCYxCKbYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724359305; c=relaxed/simple;
	bh=aTMWadOUnxaFEtVI87wLEEzz7J/DRVmkbaG8kTDLut4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nijAFKO78lyUWWerSnKiIfEsDtTM+0aAiBalwH25w52ftaQ0Ztidg0sJigCRnG4ZUg3/9APaR7TmKsN0RP74tmqn8qV/MhE0opoJMlRbYquyFiRabDOux7mXSoJYIIPvCpo6+t76DBoxLZH60RDdw/wQVwy1VZ9STCQPBc0Pneg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PYC/y+2f; arc=fail smtp.client-ip=40.107.212.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oOgsOIUsmucmaK4t7Tt0z2+4If55j+CmEnXsWv00/zORICXEobC8iPFosdE+b0COdk6jxs8gH6KjJ/t+8k/Ma1DmBFb7CD+Xe1q/ZgIHcdtOhwUTHp43HYV060nwxOKh22nEb6wNGgU/Akdc8zHjWGM9OV3vkEfW1XDzMEvkt48A6bYZ6pkhFmr6+7xTmPVqZjMN/nPg4r30IsHGFaI0Jnrt2TKuRhvzIQv4JkcfcA/9ThYUsLWdILQ9aTxwikfoAXefgYlFszNOPSCf21yWjaMXGpAnYHDVpIQB/ldqdKh90A7VGFpsFizaQ+VHrpubzYqE8Wc7z5fmBFEss47Epw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jql50VMoXTOB/6gtiCqMMolAkPHge8M7BG4HU4aa/Jg=;
 b=m8r41qeblNkim89LtSAM9/LZQ6Ya1ugzUSAV4Uqt5LCEfKOOhem3fv5FUhpDc68f/SPqpuOuwMn4vR7XBrejnuNdh5r4jKi1S8kixJ00tEvG1BItIaS+cs+EyvButLgdOuLf6tWnJ7rfexjjbiDzHm1gTGmoB/t8O+wOeevgEAuH0LvizY2/lnal6dLibkhD/EqPCiq2zLHZGim/q7HZ67tPv5aqPG3CT7JNUz9EqVgaRgDRKiUtTqqjU3Tfi6z8RPIbcU//nbQ/I9iueyo0MCGPxhFbIK6V11BF48lH/C9q/8XV/A68yg0LXTuqBOWPS4nksxMUEc2Jb5rXrNwzgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jql50VMoXTOB/6gtiCqMMolAkPHge8M7BG4HU4aa/Jg=;
 b=PYC/y+2fGFFFnUXgs3Hgpqci6Y3++rvAvvkWpETZFYIotQB8JOIRG1JZkzM+nrX6yLmrprk1OsjdfUeywYqJhpykICY9hApZs//yI294tyKj5IJtZegbbiY6BJwz+uwBN4QzrZQTrFyZpORleI56REKly339DEL06YcNJitAnaM=
Received: from MW4PR03CA0123.namprd03.prod.outlook.com (2603:10b6:303:8c::8)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Thu, 22 Aug
 2024 20:41:40 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:303:8c:cafe::8a) by MW4PR03CA0123.outlook.office365.com
 (2603:10b6:303:8c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20 via Frontend
 Transport; Thu, 22 Aug 2024 20:41:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 20:41:39 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Aug
 2024 15:41:37 -0500
From: Wei Huang <wei.huang2@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <Jonathan.Cameron@Huawei.com>, <helgaas@kernel.org>, <corbet@lwn.net>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <alex.williamson@redhat.com>, <gospo@broadcom.com>,
	<michael.chan@broadcom.com>, <ajit.khaparde@broadcom.com>,
	<somnath.kotur@broadcom.com>, <andrew.gospodarek@broadcom.com>,
	<manoj.panicker2@amd.com>, <Eric.VanTassell@amd.com>, <wei.huang2@amd.com>,
	<vadim.fedorenko@linux.dev>, <horms@kernel.org>, <bagasdotme@gmail.com>,
	<bhelgaas@google.com>, <lukas@wunner.de>, <paul.e.luse@intel.com>,
	<jing2.liu@intel.com>
Subject: [PATCH V4 01/12] PCI: Introduce PCIe TPH support framework
Date: Thu, 22 Aug 2024 15:41:09 -0500
Message-ID: <20240822204120.3634-2-wei.huang2@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240822204120.3634-1-wei.huang2@amd.com>
References: <20240822204120.3634-1-wei.huang2@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: c1b07fce-4d87-47fb-f490-08dcc2ead2ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z/t4kiw4vMesdF4qwbwwDGsXpk1q3QqPEtMtSTd4H6cqf+qR0i5ZGU45IGaq?=
 =?us-ascii?Q?mz57ruA/xTouLv2LLwPjI4X9hTUr47PEfZzWhCdKQk3xJKUl+HDpSOqW5AvS?=
 =?us-ascii?Q?uPRkZyTa/EhKQYOxGdjjIfMsvY+1aI0PS4g3n8raMX6wm8mBQ8tYXiPBQv5n?=
 =?us-ascii?Q?Cf7/s7F0GqVWfpKExuTxeE78I6PnFYTVRF+DycV4WpGddHfWaDaosDrvtQzK?=
 =?us-ascii?Q?qWkXPFLoj7ilhF+3jf2IZ5u6UoHRq4/hW7nswolg4CSEwkH2mfspCIqBoQm+?=
 =?us-ascii?Q?JPmjKxoUL875WqEi1yFTN6YCvTdMI/DubM1r5CTXfhp7MQbc9np4Wg5Q94Kw?=
 =?us-ascii?Q?FRcMj/GHataB8d28asHz+StlYw5YCOOI4afFnz1Q7F9t0UbYGLk0lHT7d/Zg?=
 =?us-ascii?Q?pmR4KuYj4iNHPpp3kx8ZaEAQzilzHsGsnn6FLTVvBWqPRu/2W3hbDAzUnELI?=
 =?us-ascii?Q?742BaRNkuXeQHeBj6rWIiOgeQZe4xuiq26OPDLtF66jafoXiAK8OrM6Suk5V?=
 =?us-ascii?Q?dOi9GN/bBHwmz2pWRkxjSzcubGl5t4P0JQf1jJlTzYv4ZXYmK0K/7gN3hm0k?=
 =?us-ascii?Q?F7IHVuPWQC5v9i5moYSAxL06XlLie9hg7EtkljdmX+yH/Lsv0uwZ7bSRnNI4?=
 =?us-ascii?Q?aIba3SLP1vjdiiv9b9mDQ6X9OXE3NQr6cFC80vMSquff6rz0++edYBFrxYRm?=
 =?us-ascii?Q?QOY7aIkNNwG2BaZvoNyFJZ2MNVpW4YAk0Q9+/Ns+R6foZmczptwxph09KBH0?=
 =?us-ascii?Q?NXWRzyt1Y6uIcyCOme+qZlLZqzlIzlnK35eNqVhGrDQ75KUl7HJ3fOUJ+r0N?=
 =?us-ascii?Q?OjnUdALArjMNwg7QCXB6s0AiopawSxLnnqxE5lF5W3mNY+8azZwWaaIr3D0W?=
 =?us-ascii?Q?DrTM08WA8yTPfuXSDzVTb59FFA/OMZlpaNlxATwHAMICitC5K0PdPSet4oxP?=
 =?us-ascii?Q?VmWbRj7QUWtV9hZGLtXCdYqUF1/sV9654M3IfzZlRH5s0Cs7L/lMQcumjlx/?=
 =?us-ascii?Q?tl1ZbruzEPnwvS62Ovc05YakgQXI4wnSa5wBUtsLrW1vGYZCN2TFXp6rFC7Z?=
 =?us-ascii?Q?iFXcvD2AdhGFsxM3KYzPxeL79Q4M+ZGXJWuyhAl0KT9vNHZVh5Xqar1ZTKpx?=
 =?us-ascii?Q?BTKkZLc/lymM+vsbutLSjXTm09sPWFUMel6scyRN83f9QpfN2CLprB5GsjPh?=
 =?us-ascii?Q?YN/eEoR7ZYT3P3AWg8oFSgvP+QKeO+IlfQFYlqQV3k4FpaQPdXY7Ve0/b9lF?=
 =?us-ascii?Q?MH7z6j7H/qeavNZ2qiBQ2pd39s8NeQKSpmDTueXFQYxHqvE3+dt+fG4VlyWf?=
 =?us-ascii?Q?u5hZn5klY3aDuOOj8v0I1kMqKrC8Yf9aS2Jb8ljXq054PRqqxFBtoPDKJB/a?=
 =?us-ascii?Q?XyjbOVv53ecSWMR92pgHUUeu9gX8Ina7wXnjxjuVYUGWK+ui+HwOmK5VcOaG?=
 =?us-ascii?Q?WZvoHzkOUByZo0iLVUygxe5FI4G1Q46o?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 20:41:39.3875
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b07fce-4d87-47fb-f490-08dcc2ead2ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451

Implement the framework for PCIe TPH support by introducing tph.c
source file, along with CONFIG_PCIE_TPH, to Linux PCIe subsystem. Add
tph_cap in pci_dev to cache TPH capability offset.

Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pci.h         |  6 ++++++
 drivers/pci/pcie/Kconfig  | 11 +++++++++++
 drivers/pci/pcie/Makefile |  1 +
 drivers/pci/pcie/tph.c    | 15 +++++++++++++++
 drivers/pci/probe.c       |  1 +
 include/linux/pci.h       |  4 ++++
 6 files changed, 38 insertions(+)
 create mode 100644 drivers/pci/pcie/tph.c

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 79c8398f3938..289eddfe350b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -571,6 +571,12 @@ static inline int pci_iov_bus_range(struct pci_bus *bus)
 
 #endif /* CONFIG_PCI_IOV */
 
+#ifdef CONFIG_PCIE_TPH
+void pci_tph_init(struct pci_dev *dev);
+#else
+static inline void pci_tph_init(struct pci_dev *dev) { }
+#endif
+
 #ifdef CONFIG_PCIE_PTM
 void pci_ptm_init(struct pci_dev *dev);
 void pci_save_ptm_state(struct pci_dev *dev);
diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 17919b99fa66..61e4bd16eaf1 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -155,3 +155,14 @@ config PCIE_EDR
 	  the PCI Firmware Specification r3.2.  Enable this if you want to
 	  support hybrid DPC model which uses both firmware and OS to
 	  implement DPC.
+
+config PCIE_TPH
+	bool "TLP Processing Hints"
+	depends on ACPI
+	default n
+	help
+	  This option adds support for PCIe TLP Processing Hints (TPH).
+	  TPH allows endpoint devices to provide optimization hints, such as
+	  desired caching behavior, for requests that target memory space.
+	  These hints, called Steering Tags, can empower the system hardware
+	  to optimize the utilization of platform resources.
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index 6461aa93fe76..3542b42ea0b9 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_PCIE_PME)		+= pme.o
 obj-$(CONFIG_PCIE_DPC)		+= dpc.o
 obj-$(CONFIG_PCIE_PTM)		+= ptm.o
 obj-$(CONFIG_PCIE_EDR)		+= edr.o
+obj-$(CONFIG_PCIE_TPH)		+= tph.o
diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
new file mode 100644
index 000000000000..a547858c3f68
--- /dev/null
+++ b/drivers/pci/pcie/tph.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TPH (TLP Processing Hints) support
+ *
+ * Copyright (C) 2024 Advanced Micro Devices, Inc.
+ *     Eric Van Tassell <Eric.VanTassell@amd.com>
+ *     Wei Huang <wei.huang2@amd.com>
+ */
+
+#include "../pci.h"
+
+void pci_tph_init(struct pci_dev *pdev)
+{
+	pdev->tph_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_TPH);
+}
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b14b9876c030..c74adcdee52b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2498,6 +2498,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_dpc_init(dev);		/* Downstream Port Containment */
 	pci_rcec_init(dev);		/* Root Complex Event Collector */
 	pci_doe_init(dev);		/* Data Object Exchange */
+	pci_tph_init(dev);		/* TLP Processing Hints */
 
 	pcie_report_downtraining(dev);
 	pci_init_reset_methods(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4cf89a4b4cbc..c59e7ecab491 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -530,6 +530,10 @@ struct pci_dev {
 
 	/* These methods index pci_reset_fn_methods[] */
 	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
+
+#ifdef CONFIG_PCIE_TPH
+	u16		tph_cap;	/* TPH capability offset */
+#endif
 };
 
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
-- 
2.45.1


