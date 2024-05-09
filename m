Return-Path: <linux-pci+bounces-7297-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D30788C12DA
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 18:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E73CB21D90
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 16:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC095170853;
	Thu,  9 May 2024 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H+DxcrGT"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0769816F8F7;
	Thu,  9 May 2024 16:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715272085; cv=fail; b=tyaNXkJ+XILEnXjMyf2fIJtwHQyAq5lJOrNfXgTAyf2mrk67WwTWaVjgvWIsPJ5EkCQMI6oHzhme4mFZEGcajbqAGxmuPtzJGa1QeE0VcB2YrKg597zCRhDTJn7Zf3UF27eDNKo6UCyD1+mNmfH3ClnH+G9l71ZptKp+hhLZGoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715272085; c=relaxed/simple;
	bh=Oi2JAhDjXFr+4b2HodN0Av/r2PrKL8/BAX7BUM/zt6A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pOl46REYiilaNr4KOmqto3+ltmmnNTk19OpPnmuQnvq67/eBvmaE2/VzRZw8AaRw2oirx6QC2kI+SwGChUO/EttT0LYiAr9OOi/J+k0+vOlhYWE1EgYUr1eC9yxCzqU1UTl2Y8oSnAPvsMdxzXHljt0FIJu5lPTQz1ehk8YyNYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H+DxcrGT; arc=fail smtp.client-ip=40.107.94.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ad1RHTCyt1tWico5QP80IR1JMTwvvnziZq/FIl9XWtYK5k53dTTv9hW3zzzy+/unPsgusgTC9Pb6vx9sCIuU9bUsO0SNsYher4LmtvSMl08tEcu+IjJe5GJduV4aHV15dRQoZ1hNrxsb5Gqjkgmxpt+ShoF2dHSE9B3D/F+yDX+UWs1en8DYNBNzbBsQUcpiIqP8bvdCJBG1fnXotR3IQ54LgxDZoIdSHO5CfRpYagi50/SC/UjCcsS7GHUutB1vo5zCzw/GzW2L/JU7IBFw7JqIRKkXmiPdGI0NxGr/S75moPIol600Vp9flb/cmkqn0QdcQTdQRfYuqi5MNvSjMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JiL5Pe+bmxJOSG+rM4CY2MEuGsszwZIA85ae3Z1h05g=;
 b=JyqFMlJM8SA2Ky8cPJPxFZQzAvHbSVLfaaMXWR8w5lCezzfmYTyxDG6c/+MqbJ+aHly1YMC9Wt029Dw3IDnu0pJXKDUPCagbvsbcqRoXUmJAi6MfD17HNUE7KJR0Oj2w0CiV88doGEdGDgWazwSkbSxhVbl9SeHI28RpvSlEqhMbiBxOWrjysZ0QREPGSthDoTATs2nBbQvjpkqAjgd99BqnCw9yc2xDzLUU93w6+wJ7LVjkOMw1MepVwNQ0tVgXSPHfqlKXNthkF3tsaINkq6pqZLhdckvW+N7GItJeiZK1wwAfQBCmn5yRMDgvSG6F/Hn9TTle2cAFO5mgcVSPCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiL5Pe+bmxJOSG+rM4CY2MEuGsszwZIA85ae3Z1h05g=;
 b=H+DxcrGTjskccHpTHxywWZUTVAL8oBB/5xLVLHN37z32xUAQIboiP+PJC3gwFKWhXYjg/o9jFnOKxtBkow8QDdo9xl2JVEY6SsOpX/gtXF67P/ujEwSbw/m5Lbr9yn6h/u4RiEO1kyXv05FkT2Hhv3ipoCcOI6pfgzUNQ2wDPLc=
Received: from CH2PR02CA0021.namprd02.prod.outlook.com (2603:10b6:610:4e::31)
 by SJ2PR12MB8942.namprd12.prod.outlook.com (2603:10b6:a03:53b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Thu, 9 May
 2024 16:27:59 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:610:4e:cafe::b6) by CH2PR02CA0021.outlook.office365.com
 (2603:10b6:610:4e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47 via Frontend
 Transport; Thu, 9 May 2024 16:27:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.0 via Frontend Transport; Thu, 9 May 2024 16:27:59 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 11:27:58 -0500
From: Wei Huang <wei.huang2@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <bhelgaas@google.com>, <corbet@lwn.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<alex.williamson@redhat.com>, <gospo@broadcom.com>,
	<michael.chan@broadcom.com>, <ajit.khaparde@broadcom.com>,
	<manoj.panicker2@amd.com>, <Eric.VanTassell@amd.com>, <wei.huang2@amd.com>
Subject: [PATCH V1 1/9] PCI: Introduce PCIe TPH support framework
Date: Thu, 9 May 2024 11:27:33 -0500
Message-ID: <20240509162741.1937586-2-wei.huang2@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240509162741.1937586-1-wei.huang2@amd.com>
References: <20240509162741.1937586-1-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|SJ2PR12MB8942:EE_
X-MS-Office365-Filtering-Correlation-Id: 936867e5-f695-4e79-cba0-08dc7044fd86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400017|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8as+7yQaeS1OJbuzcJCiukKZdJ8GTk+6Rt8JXDOV2J7kjKRB6Thke3Rkv2qz?=
 =?us-ascii?Q?6I7NRpy4D2f59L2EDUQ3MwJDAzaSTQBMpbBGSUEX7r43Kyd/WHkCmYBdBvJj?=
 =?us-ascii?Q?Zimc783noHljZeasgGN7Ofl2hPt/MfyucTZ8xrC3AlipFTGYAh1upXUPh2/C?=
 =?us-ascii?Q?I06h7/lWiZezT/YuNsgZvcEpVIsrXbPwPNxt7dfqlspwATENPpNc74Oa/RIa?=
 =?us-ascii?Q?cGr5eaf+DuSc+ZzDkIdhYZynQ4dKoI/4WdkG3FR5mV6EXEtwA8bwMUM8fNvd?=
 =?us-ascii?Q?Xo1YRkDZ01vXIsmh44fn81Ytj0nhEMQZwbFRfipGkrGWnMN/oQcGfgBuIQ/0?=
 =?us-ascii?Q?u1KMyQx05oZJtq5ULvyTrIEsuALOmNZePhc/v07bP6Xt02Z9F10MLZTvRS0A?=
 =?us-ascii?Q?Q3n9myWF+pzcqW9KhziNT8hmG9JjhvE5yLIqGlcpCwZInZ9zNPF9//0iw3PB?=
 =?us-ascii?Q?csYh7G/m+3u4knRbHMPseJYpEaadRKq72t7zLG9h1g/iioTokEw96pDlFpzA?=
 =?us-ascii?Q?jqrlfq27Sa35gsLqfTHsceUOkAp5R4HGuljJAE71IElivSG0gZtYLhEBVfEo?=
 =?us-ascii?Q?wUBRrDg/TSIixnq/uThuFuOK2DluPXSbcWX5jqHP4oeKHX0GyB0bcvx3UgFq?=
 =?us-ascii?Q?f1dO9+ifLgy6uGEDgy08XL+RZr4YWscMPFD+nbaUhYlZd14RWuJw3Vfz3oEv?=
 =?us-ascii?Q?o6CjNd9p3NnAy8RnJ2lYiA2UTqP9jB7AjsFZSkR/KHHo9euGsjof1JakFG0R?=
 =?us-ascii?Q?/RPxZFD8sf0saismE1c2Y8IceLmLz2IWu4mXOhzFNXjfd7B5+5+11ThzFHcU?=
 =?us-ascii?Q?PD+JzjqciWRHDq47HqptvXwyGIWgxWi7J68eEPZbKuWS+k911+fnTemKmcvv?=
 =?us-ascii?Q?dRvdCgE3SlqMgIvD1xMCblZtazj/VZSrSFIGB5AwrVS4hnsP336MoUIkICxo?=
 =?us-ascii?Q?0MRhVvvnPPbpn3Ukej7e3mVrpPEiKiF6gKU/5udm5t7nZ5ifKVciIyIr0T+H?=
 =?us-ascii?Q?pOin1AOPoiuoUOxd867NAfMAOeBoDyXeEynidWyRyBEQjrx3qZhlDAU9k9sr?=
 =?us-ascii?Q?IQdIvDOgIAQXO1BH60UxXrYCIyQnqyqMTJxPIwfp1UTRxYfNnrvcadCv662z?=
 =?us-ascii?Q?XG+qhlqUgKQBpdlStRR4KgcxG0PRgavEwKvMbvBaCPUWGzDy/C3hkOtsuDEl?=
 =?us-ascii?Q?1AdnNtlgtAWZhu2993BK8bSg3XjxAd1pXKbxgMJrfnpKJuM30AibRD5hTPB7?=
 =?us-ascii?Q?4d2Jlnn64jC3MXZ1KT43tAN0f0zHxlRHn+QrvE9u9UWxIF3jopEmHJ9BXv72?=
 =?us-ascii?Q?jmQFbQ66E1j/q/Cr+BxUC/uI0QZyXCVHwXLYx3FY+0rxoCFWYEmArsBUQ5qo?=
 =?us-ascii?Q?GMO2HmmDQaBjLzJ4ESOuo3F0qqg0?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400017)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 16:27:59.2699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 936867e5-f695-4e79-cba0-08dc7044fd86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8942

This patch implements the framework for PCIe TPH support. It introduces
tph.c source file, along with CONFIG_PCIE_TPH, to Linux PCIe subsystem.
A new member, named tph_cap, is also introduced in pci_dev to cache TPH
capability offset.

Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/pci/pci.h         |  6 ++++++
 drivers/pci/pcie/Kconfig  | 10 ++++++++++
 drivers/pci/pcie/Makefile |  1 +
 drivers/pci/pcie/tph.c    | 28 ++++++++++++++++++++++++++++
 drivers/pci/probe.c       |  1 +
 include/linux/pci.h       |  4 ++++
 6 files changed, 50 insertions(+)
 create mode 100644 drivers/pci/pcie/tph.c

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 17fed1846847..6f1d35a68126 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -508,6 +508,12 @@ static inline int pci_iov_bus_range(struct pci_bus *bus)
 
 #endif /* CONFIG_PCI_IOV */
 
+#ifdef CONFIG_PCIE_TPH
+void pcie_tph_init(struct pci_dev *dev);
+#else
+static inline void pcie_tph_init(struct pci_dev *dev) {}
+#endif
+
 #ifdef CONFIG_PCIE_PTM
 void pci_ptm_init(struct pci_dev *dev);
 void pci_save_ptm_state(struct pci_dev *dev);
diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 8999fcebde6a..a4940e2af9b1 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -155,3 +155,13 @@ config PCIE_EDR
 	  the PCI Firmware Specification r3.2.  Enable this if you want to
 	  support hybrid DPC model which uses both firmware and OS to
 	  implement DPC.
+
+config PCIE_TPH
+	bool "TLP Processing Hints"
+	default n
+	help
+	  This option adds support for PCIE TLP Processing Hints (TPH).
+	  TPH allows endpoint devices to provide optimization hints, such as
+	  desired caching behavior, for requests that target memory space.
+	  These hints, called steering tags, can empower the system hardware
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
index 000000000000..5f0cc06b74bb
--- /dev/null
+++ b/drivers/pci/pcie/tph.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TPH (TLP Processing Hints) support
+ *
+ * Copyright (C) 2024 Advanced Micro Devices, Inc.
+ *     Eric Van Tassell <Eric.VanTassell@amd.com>
+ *     Wei Huang <wei.huang2@amd.com>
+ */
+
+#define pr_fmt(fmt) "TPH: " fmt
+#define dev_fmt pr_fmt
+
+#include <linux/acpi.h>
+#include <uapi/linux/pci_regs.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/msi.h>
+#include <linux/pci.h>
+#include <linux/msi.h>
+#include <linux/pci-acpi.h>
+
+#include "../pci.h"
+
+void pcie_tph_init(struct pci_dev *dev)
+{
+	dev->tph_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_TPH);
+}
+
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 1325fbae2f28..9ac511032639 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2481,6 +2481,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_dpc_init(dev);		/* Downstream Port Containment */
 	pci_rcec_init(dev);		/* Root Complex Event Collector */
 	pci_doe_init(dev);		/* Data Object Exchange */
+	pcie_tph_init(dev);             /* TLP Processing Hints */
 
 	pcie_report_downtraining(dev);
 	pci_init_reset_methods(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 16493426a04f..73d92c7d2c5b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -529,6 +529,10 @@ struct pci_dev {
 
 	/* These methods index pci_reset_fn_methods[] */
 	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
+
+#ifdef CONFIG_PCIE_TPH
+	u16 tph_cap; /* TPH capability offset */
+#endif
 };
 
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
-- 
2.44.0


