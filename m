Return-Path: <linux-pci+bounces-40238-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C526C3236F
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 18:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 859A534AE99
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 17:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CB033A03F;
	Tue,  4 Nov 2025 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NLmK4BH4"
X-Original-To: linux-pci@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010015.outbound.protection.outlook.com [52.101.56.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45DE33A02B;
	Tue,  4 Nov 2025 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275864; cv=fail; b=jk0FWeAeqFoVzDVTDeHXFs7M0fs+3aNg2WQoIs4yeaplfEiXMzXUvf9zM3XFyyYB+S2bECKZWC2SMQz2D5G9QKZ0RG4Nqqxfi7LjxTsZEDJ33WiaASFY3uNTniA2XT7O6ICdfwKe8Uxd+czvh9O2nwg1grq6RCgJ52XvXB/ZunA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275864; c=relaxed/simple;
	bh=FPm8ZZjEulz+In18IUYe115zXjh2/fGOcmW+/KNbiQM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gTmOmS9i3WLGKykBd9BKcaNgVLr+oKcomXb/gLYb69zZYen3RgWh9SygNs8My0qmahNgs4bqI30ojQHh7YZexClE5UJUlwNNTVCSFAevyr8ygTIAZ3GnUwmtgkm2z8IQLrXjGtKrp2DFQokEL/va1JrEnZBNMR8U8JTkDj8MhhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NLmK4BH4; arc=fail smtp.client-ip=52.101.56.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJsK6YYPS2XNuU718GagQKOZYrWZn0+EUVWd71LqExom183ZqA3JuOOGP62dcLgOJIGQZam/JOp81VAiV2hSnvZpdpjdII1aSoFJK4NLWY6QeafW2CHgjRbIbXEKf00xIOqoMOqH3xr7Sc0sjZ8Ihd2P3dgZkjMdz5jv1gQMHBcbIsxW3nFHrt3eUhLHBzLdVHdDC6nN4vKVc3ZX9SUfBeC7cYNNuXN6KuMYefzDrPWhSzwVcntgxRUDhIiXPRpe4Ud/heiPyziF+1Or9DNSBr5EDJSqOnbtMRFE8XMVtfghC4p9fGyZgZAN5iJcVx0V+LBTeF08lyIzCz2aiah2yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuM+XBsWnpY8CJY0NxYPLtyFjru+oMBnAmOdABVFCpc=;
 b=EkEBt7R+DiwnP30eA2zV3dJPQX1zbcsHdfZ0Yq1JhNeJYHjaWsdnRxiT/vm9Ynq50US/myWmhDJRouNk/73Bi0ZCNk6nFq4AQqUva/Cr8T/FDHIeFRDFtzoKFMOFKT6Jzo1njhDSVQoWF01iF3wEb25tHk2SdH4Nah6dG6hHVEqt+XCQDIg04vFToJ+0noyvElGOY3Q/WLrJ3zaNUkUY4jPGC0JF0mpNFauEZ2CenLZr+HMdtIfdPKKFuehsC0O4YtLfzc1cWH4UdzX3YJD6BVrVfZUn6JfS7yhZ5Xll6c8MxAW8q5S9gp5q7EkvgoMwN6A6Ksf5kINKQ7cFY/nKVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuM+XBsWnpY8CJY0NxYPLtyFjru+oMBnAmOdABVFCpc=;
 b=NLmK4BH4kTgtyD4uWqOwgK0414wNt8iRgJLFw+PczzsWCacPAfIyldMJrNq2WZ+MygwM90ix5afTtRsVwikAVPZktUKlmSWbOf8MnGb0hB5QG+4VmVkasnicws2wbGPjWMOn52KuIRtKO0SDep0C1yiZNgEOGFjnvhhGlByXNDM=
Received: from BLAP220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::29)
 by DM4PR12MB6376.namprd12.prod.outlook.com (2603:10b6:8:a0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 17:04:19 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::53) by BLAP220CA0024.outlook.office365.com
 (2603:10b6:208:32c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 17:04:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 17:04:18 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 09:04:17 -0800
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [RESEND v13 06/25] cxl: Move CXL driver's RCH error handling into core/ras_rch.c
Date: Tue, 4 Nov 2025 11:02:46 -0600
Message-ID: <20251104170305.4163840-7-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104170305.4163840-1-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|DM4PR12MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: 792e2405-55b2-45ed-01fd-08de1bc43152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hm2xqIORwtcbMMToDLXSggPnIWX1g5q/CyRu6ccISeDF/hL/ogmqEdo59v6k?=
 =?us-ascii?Q?Hh0o6o6Ho7F8oqqSrdPGCJnCNlqdPyKdampP4t4aaOXbI9jO6fja7YpCRWUp?=
 =?us-ascii?Q?5q/88Dihmcx3zpQkHx8gtcL7m8OmAtWjk8sDvnOqwzuqUAEuhgMoSxRoSZf8?=
 =?us-ascii?Q?v9V8tANlR0PVFbVR5oSRa3XoWqBqki4A+AMZGptKS9U2noSDdm/x0PV04cn5?=
 =?us-ascii?Q?h1i2BTuSau8Q1/1K9gLyjpMNX2ONfOzmOSIQ4WjbLLyAM7zAmczOK7PQ4EvG?=
 =?us-ascii?Q?p6R/ZppX2gi63qoLvg8KBdsfH3u6R68dC97VImArTnzvu0QLPFkEnb/7jIoc?=
 =?us-ascii?Q?pUkYzBJKZW9Y5t5urHYW0+KJODrOnxGxRDdOMb6DGJPa6k/3hN34otmK0h81?=
 =?us-ascii?Q?U2+ZY8vOAiY6vEhVwqdlkcK5rDnqHxdrK05dQ3DPoZ8qdGIj9v4fz/Y9Gc+9?=
 =?us-ascii?Q?wQpPcs25A2YTPWam11JitRpBXIVQW4UmqZ3JP09SP4ETt46ZP/M9SLlUCorX?=
 =?us-ascii?Q?tmWUXKhVzYZnQa7CKDsg+CVlbeQz1xFRaHO+O1hba6Lk/rj119l0Z7Yw/v8c?=
 =?us-ascii?Q?LFxisVK4Fd1vdBnNiNk4NjIZuyePcfGLhxUNsnuDs9yyd9H/6AAPzaAHS7FJ?=
 =?us-ascii?Q?3GarMaXKa08CwQqmGKMUdOIYYQMVtZPgz6/f25+wGPW1OszgesLnxa8mlNQL?=
 =?us-ascii?Q?6o/nRwR2BwANXzurWfTkFuRx8PRCkHWJS8pi6+F7yZ/oQYjECPkCnHNmi1D9?=
 =?us-ascii?Q?EY8BdUn2eQiDC/Q9A2MoTBt3CQWgJKqnthjazDB2hhsXq6CKTqvGyh+gUfed?=
 =?us-ascii?Q?jeVY16umxcgDefTbLaxtNNKgGiIw/Imc/R2UDiWtVnuegnmtKgaKJGur7y76?=
 =?us-ascii?Q?ELEzAJmI0W44pD70oKn51aiNB+EW5Yv7T0U8CV+uX6oBYPAleR2xkVWKa9lX?=
 =?us-ascii?Q?fxKGa/M7NeXA9weqFetEmVmTEI3deYFgnJjFanCOERMzcWG68PQksN+wBZ0x?=
 =?us-ascii?Q?h5c45SaY3MCBA3TsHwxvUw64+BZTn/wwLsfqODpE6a9KBOo3jcmsjjPtGOzr?=
 =?us-ascii?Q?SFo5UMigkVX6G21EYZHu79I+PXgbDAXSkvyg07B3EjbrjRhttCvWon+wVyg5?=
 =?us-ascii?Q?NEJOfaQOHzB+OlI67/Zus0lwXeyZHIcOIy3ysPRH/logeWjhI9uB3w6HWHTM?=
 =?us-ascii?Q?BqVEdaEInhj/m44b4bYNeFhA2IYcy+xPsI9Pjh8h9k1B7AIZcXz8NwH0hEwy?=
 =?us-ascii?Q?HsSWaMO77p+2DCQa0BKBI7uaAiraSxVrP36PZ0KEcA3f3jz+wi0o4PCkDorv?=
 =?us-ascii?Q?A3OGyRRsEMZlZUWJBkokanMlSFXWte7p+tJPHRt16M789APMR/GBq2ujhVEY?=
 =?us-ascii?Q?dbIEPJ1JYK33xQzIZ9KDJYd5z/F6PmTTYlLAgYTigYorqqgpAG8VWXYwxWSa?=
 =?us-ascii?Q?S6CNPSN9qOAfkoU8ZkOEesfEknxnAlzWcyv4qHEZg2OmBy2RvZgN2Zi27M7Y?=
 =?us-ascii?Q?lAzNbQXeXvzpFU4jzn/ShcvDubx1VgiEe8dcsHeKkO6A2gx04xOQ96rrCRcG?=
 =?us-ascii?Q?cTxbGdBFlDdBAKT7EXz0tCRwNqRNUQCmtDv5yUuv?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:04:18.7599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 792e2405-55b2-45ed-01fd-08de1bc43152
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6376

Restricted CXL Host (RCH) protocol error handling uses a procedure distinct
from the CXL Virtual Hierarchy (VH) handling. This is because of the
differences in the RCH and VH topologies. Improve the maintainability and
add ability to enable/disable RCH handling.

Move and combine the RCH handling code into a single block conditionally
compiled with the CONFIG_CXL_RCH_RAS kernel config.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v12->v13:
- None

Changes v11->v12:
- Moved CXL_RCH_RAS Kconfig definition here from following commit.

Changes v10->v11:
- New patch
---
 drivers/cxl/Kconfig        |   7 +++
 drivers/cxl/core/Makefile  |   1 +
 drivers/cxl/core/core.h    |   5 +-
 drivers/cxl/core/pci.c     | 115 -----------------------------------
 drivers/cxl/core/ras_rch.c | 120 +++++++++++++++++++++++++++++++++++++
 tools/testing/cxl/Kbuild   |   1 +
 6 files changed, 132 insertions(+), 117 deletions(-)
 create mode 100644 drivers/cxl/core/ras_rch.c

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 217888992c88..ffe6ad981434 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -237,4 +237,11 @@ config CXL_RAS
 	def_bool y
 	depends on ACPI_APEI_GHES && PCIEAER && CXL_PCI
 
+config CXL_RCH_RAS
+	bool "CXL: Restricted CXL Host (RCH) protocol error handling"
+	def_bool n
+	depends on CXL_RAS
+	help
+	  RAS support for Restricted CXL Host (RCH) defined in CXL1.1.
+
 endif
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index b2930cc54f8b..fa1d4aed28b9 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -20,3 +20,4 @@ cxl_core-$(CONFIG_CXL_MCE) += mce.o
 cxl_core-$(CONFIG_CXL_FEATURES) += features.o
 cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
 cxl_core-$(CONFIG_CXL_RAS) += ras.o
+cxl_core-$(CONFIG_CXL_RCH_RAS) += ras_rch.o
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index bc818de87ccc..c30ab7c25a92 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -4,6 +4,7 @@
 #ifndef __CXL_CORE_H__
 #define __CXL_CORE_H__
 
+#include <linux/pci.h>
 #include <cxl/mailbox.h>
 #include <linux/rwsem.h>
 
@@ -167,7 +168,7 @@ static inline void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem
 #endif /* CONFIG_CXL_RAS */
 
 /* Restricted CXL Host specific RAS functions */
-#ifdef CONFIG_CXL_RAS
+#ifdef CONFIG_CXL_RCH_RAS
 void cxl_dport_map_rch_aer(struct cxl_dport *dport);
 void cxl_disable_rch_root_ints(struct cxl_dport *dport);
 void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds);
@@ -175,7 +176,7 @@ void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds);
 static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
 static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
 static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
-#endif /* CONFIG_CXL_RAS */
+#endif /* CONFIG_CXL_RCH_RAS */
 
 int cxl_gpf_port_setup(struct cxl_dport *dport);
 
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index cd73cea93282..a66f7a84b5c8 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -711,121 +711,6 @@ void read_cdat_data(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
 
-#ifdef CONFIG_CXL_RAS
-void cxl_dport_map_rch_aer(struct cxl_dport *dport)
-{
-	resource_size_t aer_phys;
-	struct device *host;
-	u16 aer_cap;
-
-	aer_cap = cxl_rcrb_to_aer(dport->dport_dev, dport->rcrb.base);
-	if (aer_cap) {
-		host = dport->reg_map.host;
-		aer_phys = aer_cap + dport->rcrb.base;
-		dport->regs.dport_aer = devm_cxl_iomap_block(host, aer_phys,
-						sizeof(struct aer_capability_regs));
-	}
-}
-
-void cxl_disable_rch_root_ints(struct cxl_dport *dport)
-{
-	void __iomem *aer_base = dport->regs.dport_aer;
-	u32 aer_cmd_mask, aer_cmd;
-
-	if (!aer_base)
-		return;
-
-	/*
-	 * Disable RCH root port command interrupts.
-	 * CXL 3.0 12.2.1.1 - RCH Downstream Port-detected Errors
-	 *
-	 * This sequence may not be necessary. CXL spec states disabling
-	 * the root cmd register's interrupts is required. But, PCI spec
-	 * shows these are disabled by default on reset.
-	 */
-	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
-			PCI_ERR_ROOT_CMD_NONFATAL_EN |
-			PCI_ERR_ROOT_CMD_FATAL_EN);
-	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
-	aer_cmd &= ~aer_cmd_mask;
-	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
-}
-
-/*
- * Copy the AER capability registers using 32 bit read accesses.
- * This is necessary because RCRB AER capability is MMIO mapped. Clear the
- * status after copying.
- *
- * @aer_base: base address of AER capability block in RCRB
- * @aer_regs: destination for copying AER capability
- */
-static bool cxl_rch_get_aer_info(void __iomem *aer_base,
-				 struct aer_capability_regs *aer_regs)
-{
-	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
-	u32 *aer_regs_buf = (u32 *)aer_regs;
-	int n;
-
-	if (!aer_base)
-		return false;
-
-	/* Use readl() to guarantee 32-bit accesses */
-	for (n = 0; n < read_cnt; n++)
-		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
-
-	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
-	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
-
-	return true;
-}
-
-/* Get AER severity. Return false if there is no error. */
-static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
-				     int *severity)
-{
-	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
-		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
-			*severity = AER_FATAL;
-		else
-			*severity = AER_NONFATAL;
-		return true;
-	}
-
-	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
-		*severity = AER_CORRECTABLE;
-		return true;
-	}
-
-	return false;
-}
-
-void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
-{
-	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
-	struct aer_capability_regs aer_regs;
-	struct cxl_dport *dport;
-	int severity;
-
-	struct cxl_port *port __free(put_cxl_port) =
-		cxl_pci_find_port(pdev, &dport);
-	if (!port)
-		return;
-
-	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
-		return;
-
-	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
-		return;
-
-	pci_print_aer(pdev, severity, &aer_regs);
-
-	if (severity == AER_CORRECTABLE)
-		cxl_handle_cor_ras(cxlds, dport->regs.ras);
-	else
-		cxl_handle_ras(cxlds, dport->regs.ras);
-}
-#endif
-
 static int cxl_flit_size(struct pci_dev *pdev)
 {
 	if (cxl_pci_flit_256(pdev))
diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
new file mode 100644
index 000000000000..f6de5492a8b7
--- /dev/null
+++ b/drivers/cxl/core/ras_rch.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2025 AMD Corporation. All rights reserved. */
+
+#include <linux/pci.h>
+#include <linux/aer.h>
+#include <cxl/event.h>
+#include <cxlmem.h>
+#include "trace.h"
+
+void cxl_dport_map_rch_aer(struct cxl_dport *dport)
+{
+	resource_size_t aer_phys;
+	struct device *host;
+	u16 aer_cap;
+
+	aer_cap = cxl_rcrb_to_aer(dport->dport_dev, dport->rcrb.base);
+	if (aer_cap) {
+		host = dport->reg_map.host;
+		aer_phys = aer_cap + dport->rcrb.base;
+		dport->regs.dport_aer = devm_cxl_iomap_block(host, aer_phys,
+							     sizeof(struct aer_capability_regs));
+	}
+}
+
+void cxl_disable_rch_root_ints(struct cxl_dport *dport)
+{
+	void __iomem *aer_base = dport->regs.dport_aer;
+	u32 aer_cmd_mask, aer_cmd;
+
+	if (!aer_base)
+		return;
+
+	/*
+	 * Disable RCH root port command interrupts.
+	 * CXL 3.0 12.2.1.1 - RCH Downstream Port-detected Errors
+	 *
+	 * This sequence may not be necessary. CXL spec states disabling
+	 * the root cmd register's interrupts is required. But, PCI spec
+	 * shows these are disabled by default on reset.
+	 */
+	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
+			PCI_ERR_ROOT_CMD_NONFATAL_EN |
+			PCI_ERR_ROOT_CMD_FATAL_EN);
+	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
+	aer_cmd &= ~aer_cmd_mask;
+	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
+}
+
+/*
+ * Copy the AER capability registers using 32 bit read accesses.
+ * This is necessary because RCRB AER capability is MMIO mapped. Clear the
+ * status after copying.
+ *
+ * @aer_base: base address of AER capability block in RCRB
+ * @aer_regs: destination for copying AER capability
+ */
+static bool cxl_rch_get_aer_info(void __iomem *aer_base,
+				 struct aer_capability_regs *aer_regs)
+{
+	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
+	u32 *aer_regs_buf = (u32 *)aer_regs;
+	int n;
+
+	if (!aer_base)
+		return false;
+
+	/* Use readl() to guarantee 32-bit accesses */
+	for (n = 0; n < read_cnt; n++)
+		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
+
+	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
+	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
+
+	return true;
+}
+
+/* Get AER severity. Return false if there is no error. */
+static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
+				     int *severity)
+{
+	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
+		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
+			*severity = AER_FATAL;
+		else
+			*severity = AER_NONFATAL;
+		return true;
+	}
+
+	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
+		*severity = AER_CORRECTABLE;
+		return true;
+	}
+
+	return false;
+}
+
+void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	struct aer_capability_regs aer_regs;
+	struct cxl_dport *dport;
+	int severity;
+
+	struct cxl_port *port __free(put_cxl_port) =
+		cxl_pci_find_port(pdev, &dport);
+	if (!port)
+		return;
+
+	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
+		return;
+
+	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
+		return;
+
+	pci_print_aer(pdev, severity, &aer_regs);
+	if (severity == AER_CORRECTABLE)
+		cxl_handle_cor_ras(cxlds, dport->regs.ras);
+	else
+		cxl_handle_ras(cxlds, dport->regs.ras);
+}
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 927fbb6c061f..6905f8e710ab 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -64,6 +64,7 @@ cxl_core-$(CONFIG_CXL_MCE) += $(CXL_CORE_SRC)/mce.o
 cxl_core-$(CONFIG_CXL_FEATURES) += $(CXL_CORE_SRC)/features.o
 cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += $(CXL_CORE_SRC)/edac.o
 cxl_core-$(CONFIG_CXL_RAS) += $(CXL_CORE_SRC)/ras.o
+cxl_core-$(CONFIG_CXL_RCH_RAS) += $(CXL_CORE_SRC)/ras_rch.o
 cxl_core-y += config_check.o
 cxl_core-y += cxl_core_test.o
 cxl_core-y += cxl_core_exports.o
-- 
2.34.1


