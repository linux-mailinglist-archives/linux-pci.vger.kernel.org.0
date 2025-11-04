Return-Path: <linux-pci+bounces-40173-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 580A4C2E8BA
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 01:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B876C189B320
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 00:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D308814D29B;
	Tue,  4 Nov 2025 00:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bO5Xuokk"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013064.outbound.protection.outlook.com [40.107.201.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6EB42A8B;
	Tue,  4 Nov 2025 00:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215203; cv=fail; b=qhPIaPveCKjBLcGO1c+AKr/Lj0JKLPFJqTmIWmYHvzA945IxMghU6wuu5X/5vnvvB64DnBTNUaW/imxTa8BWUno7jSj7HjBF1iO9ywwr/NKfvHWtxQ4qBB3Xb5lhcEjjbnDDhXQ979vvAWcBNKxpZRTk8s66hNo1DiT1AZvE4LU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215203; c=relaxed/simple;
	bh=xuJTIvvGHlNJvlPhzMXx2FTUeH5mQU44GU6onOhJfT4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oq1inNKiXblEosvnVOhvre+Ao/DT3aLAhNFGdx1WZ0JRA0zXk/DgEnxWOLVeTYSrL1Qiu+OsWJIncLkNyn3hGAmQ/t0+9tP+bKGh3dIyYbBxnnvkyqwbIqaL/n6txjEsFD/WqzHn2cfuG45Eydc50jQ8VmGFhPXfgDPgp1Tp5Rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bO5Xuokk; arc=fail smtp.client-ip=40.107.201.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n4f/qt6VT0N+8vomSDpM+fHLNWGoCz49iJEh6BgKsi6aPuLiO+Ut/CsltYveO3eZv88eArWI3AAzJVY60eALwGfnnq57NNDMG8r3HOgdJO6pMZsAW/nX9wSqLQNoLIiALvjqlbIdkmjM4tkxz74v5u41JZvS8ix2aA1vCfGzogMyTEkr4bxdSGqvRT5hncHxv33/tLtzqNuuPzQIfBozr3CW3One9LgZ5rkdPc82UF14CNgbSKIIUUtmWBPsYib02HtUG9OuG8axw19t6qrJYl5QgKJCH97gJPM5v9LZ9982emQnnOhIOxhI5cW5GSagre/ngWZfXX4coeXcrxYKvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBAOsCzANn+ny3ivjZgFwLF23d9+NxQZDe2lLmklDmA=;
 b=E8iiQHgQL/VTPicaxdYQ29IodDA5CO2zwpvyABi4xWI1uQr0gjgdGCiWr6GnN6OF0n24Xw9OfKV2sxH5DGjyWx88lvovLKmzwc4o1Spw66s9RRj3YaHEvZ/Jfx32e371FcK3vwCFsxgd/kMCo9Y5sZHUvno5TeZvbEo2S3i5IwHdcxptdKe0yoz5goqP9x//+UdrQnPaR5WXV5z/wBOR/ikxgKsa0hMOOYmTmZljK/RGxjtoMpEfpvef9xhkvri7Sjf5DOHma/6VYo/PHxvZtjzAgnCZgSpS4umFeD6hE8xRxGSvEI/DPMr/e0JSvRIbfD190/E93tSCpO1M0BZc/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBAOsCzANn+ny3ivjZgFwLF23d9+NxQZDe2lLmklDmA=;
 b=bO5XuokkkWpYX35SWZeqm9HNgZPajN5mWfz3c0MtUJ4vJ+E+LUgTrso7au8u1DaIkNPFmtDLIUiDP6El+Ddt3SQKnt33V0fphsCtq7XdoEmzTJ6rda6TQg22cfxprrfVDfsIFQ+yiwn4BzB9Arp8M1AuxR6xPYkHZLpIHnv9rrg=
Received: from CH2PR14CA0003.namprd14.prod.outlook.com (2603:10b6:610:60::13)
 by DS0PR12MB6437.namprd12.prod.outlook.com (2603:10b6:8:cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Tue, 4 Nov
 2025 00:13:16 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::1c) by CH2PR14CA0003.outlook.office365.com
 (2603:10b6:610:60::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 00:12:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 00:13:16 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 16:13:15 -0800
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
Subject: [PATCH v13 17/25] cxl: Introduce cxl_pci_drv_bound() to check for bound driver
Date: Mon, 3 Nov 2025 18:09:53 -0600
Message-ID: <20251104001001.3833651-18-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104001001.3833651-1-terry.bowman@amd.com>
References: <20251104001001.3833651-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|DS0PR12MB6437:EE_
X-MS-Office365-Filtering-Correlation-Id: c88b0aeb-5747-4164-6ffd-08de1b36f3e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6dgk9dNzIHnx+arV+4PD+S6YOf5zaZRq4dAdd3lBYxnswqiOpKRpVnr9QJq/?=
 =?us-ascii?Q?Kb5BQ3glHlRl2iQAqWCGDiuquTwKN6mQnsmKI2eFuSF2zQOc1O+A+R9OTygM?=
 =?us-ascii?Q?suVKfN+0YH35+RQunoKVsnBnWfpsPZgrpno8cDmhYA5fWEcwkXQE8q+a0l2B?=
 =?us-ascii?Q?fZu4Kpdw9QLx1JlVgz1HBRR5w1u3GZ0Y7gx8EuHrCMxMdWp0/j/MhOX2X2iy?=
 =?us-ascii?Q?U3RpPW5zMLjLLeKFQD5H8gZyXO2FIP46lUrH/vF0VVBEbOVILsbc9zR18ypV?=
 =?us-ascii?Q?ZgIQi4UkXgOpumwZ1C4LLS5sb7+eQXYew3SO/LjULtnUeCCKF191QaR/8AHT?=
 =?us-ascii?Q?+BmSOhab+E3LFzcbqntNvktL8jsKJdc56ETabh7wJ+ebHYu0s2RyT0bAsySa?=
 =?us-ascii?Q?l+k5uxh9EOZHgzPtqBEJaxrsjx8ll+xpcg0nILKuyYsT8wHmRZBRPnZZ1WOV?=
 =?us-ascii?Q?/TYq4fEkVleXMkebYM756+24oityqT8KQefX5aEC1gCtRETfsRGf/D7XAjD/?=
 =?us-ascii?Q?EdTVOR9FUWlCZKv+rfgaU7FrCV7HKM794o0jc74yE0EOHT/yFVuaBItypT58?=
 =?us-ascii?Q?jobW7IINZU1ZI6X2DABJJItWUIziXOHbhuGyhvntYH4MRSrAcNZUD1KYydAV?=
 =?us-ascii?Q?HGvP9yMCh43V8/I3rFHrROr9OVV0gof3vwBrGRFTfE8z7Q6zCjpFayDCgMUh?=
 =?us-ascii?Q?v/eZsdp+L8hp1GiQ2ez1H121uju7HXC5U21NkxZU44IoKWeTi7uIxIwZ4ItH?=
 =?us-ascii?Q?cxTAh3P4ZGSdz6BAhNh8glbDrlZdS02VOEXfMbVICCBKWGdua3ZRJicben5J?=
 =?us-ascii?Q?ck1rMKPtJDm3JX7DzktYznnW/kIhK2OQDr/o4HOWS9tH7lqhhtBJi/Buu4qg?=
 =?us-ascii?Q?2vQh5cpEJ95s38uvzaSafJL97/Ma9Wjr2rL+kWYk+q0U0pRYqu7JZKCOKiaS?=
 =?us-ascii?Q?KY4JWsWkdZrGKKUyoxpx3mtR4fzgVt1/s2oTggwj3DhVkNwt1/BIg2LY+2ZH?=
 =?us-ascii?Q?S2T7UlpYcXBhVjdaPELcu9ntpbYlgWZW/V4LNqior1aOshh88zkFA4ZnPcea?=
 =?us-ascii?Q?13yJjBVCG3AY0T9IagXCYhsiUMt8OMNGIv5d3u1nbNep/lQ0kxMhv6sMS4U5?=
 =?us-ascii?Q?xfSQl73If8KKQU5Ec+DEHA8GkPNCVesAUFWyX4ANit1bNnoFUJB5UVWqVOQ8?=
 =?us-ascii?Q?PB2VTZFxiHasyY/FPXOCh0kwgSv5ayCHFJatqd/IdeSjfB2vyYC975E3IgeX?=
 =?us-ascii?Q?zpUrooHZcTaL9zOQr8g6Ayzcy8jB/1uJXrleIX9RA6oA4nG/FjfKEqKXbLkO?=
 =?us-ascii?Q?/M1ViZfjL5Nh52VX9YcCMtUYpjSLmk/pRPsMj+OKiwz7/teVnlTI43AOtvt8?=
 =?us-ascii?Q?s2n5FfC+f+YXLfAsMpahn7J/KP9//iSI7c7mf+lmfBL8N+z2PBFg5cQ8zrKO?=
 =?us-ascii?Q?oWyjWSxvD26lTv9CT6u023k8bwC6rnEDVS68rlqi37iRx+OKAQO5B27fjB28?=
 =?us-ascii?Q?0fHH3LpSvsVtJqphCWgClpqyjHIAttbxY21iE7mKeY2yMxrPQ9JZazJtivVy?=
 =?us-ascii?Q?vthvzh+VtlH6Q+RDDvA2mtuPVTaWkO7oPL5iq4ac?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 00:13:16.6538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c88b0aeb-5747-4164-6ffd-08de1b36f3e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6437

CXL devices handle protocol errors via driver-specific callbacks rather
than the generic pci_driver::err_handlers by default. The callbacks are
implemented in the cxl_pci driver and are not part of struct pci_driver, so
cxl_core must verify that a device is actually bound to the cxl_pci
module's driver before invoking the callbacks (the device could be bound
to another driver, e.g. VFIO).

However, cxl_core can not reference symbols in the cxl_pci module because
it creates a circular dependency. This prevents cxl_core from checking the
EP's bound driver and calling the callbacks.

To fix this, move drivers/cxl/pci.c into drivers/cxl/core/pci_drv.c and
build it as part of the cxl_core module. Compile into cxl_core using
CXL_PCI and CXL_CORE Kconfig dependencies. This removes the standalone
cxl_pci module, consolidates the cxl_pci driver code into cxl_core, and
eliminates the circular dependency so cxl_core can safely perform
bound-driver checks and invoke the CXL PCI callbacks.

Introduce cxl_pci_drv_bound() to return boolean depending on if the PCI EP
parameter is bound to a CXL driver instance. This will be used in future
patch when dequeuing work from the kfifo.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

---

Changes in v12->v13;
- Add Dave Jiang's review-by.

Changes in v11->v12:
- Add device_lock_assert() in cxl_pci_drv_bound() (Dave Jiang)
- Add Jonathan's review-by

Changes in v11->v12:
- None

Changes in v10->v11:
- cxl_error_detected() - Change handlers' scoped_guard() to guard() (Jonathan)
- cxl_error_detected() - Remove extra line (Shiju)
- Changes moved to core/ras.c (Terry)
- cxl_error_detected(), remove 'ue' and return with function call. (Jonathan)
- Remove extra space in documentation for PCI_ERS_RESULT_PANIC definition
- Move #include "pci.h from cxl.h to core.h (Terry)
- Remove unnecessary includes of cxl.h and core.h in mem.c (Terry)
---
 drivers/cxl/Kconfig                   |  6 +++---
 drivers/cxl/Makefile                  |  2 --
 drivers/cxl/core/Makefile             |  1 +
 drivers/cxl/core/core.h               |  9 +++++++++
 drivers/cxl/{pci.c => core/pci_drv.c} | 21 +++++++++++++--------
 drivers/cxl/core/port.c               |  3 +++
 tools/testing/cxl/Kbuild              |  1 +
 7 files changed, 30 insertions(+), 13 deletions(-)
 rename drivers/cxl/{pci.c => core/pci_drv.c} (99%)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index ffe6ad981434..360c78fa7e97 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -20,7 +20,7 @@ menuconfig CXL_BUS
 if CXL_BUS
 
 config CXL_PCI
-	tristate "PCI manageability"
+	bool "PCI manageability"
 	default CXL_BUS
 	help
 	  The CXL specification defines a "CXL memory device" sub-class in the
@@ -29,12 +29,12 @@ config CXL_PCI
 	  memory to be mapped into the system address map (Host-managed Device
 	  Memory (HDM)).
 
-	  Say 'y/m' to enable a driver that will attach to CXL memory expander
+	  Say 'y' to enable a driver that will attach to CXL memory expander
 	  devices enumerated by the memory device class code for configuration
 	  and management primarily via the mailbox interface. See Chapter 2.3
 	  Type 3 CXL Device in the CXL 2.0 specification for more details.
 
-	  If unsure say 'm'.
+	  If unsure say 'y'.
 
 config CXL_MEM_RAW_COMMANDS
 	bool "RAW Command Interface for Memory Devices"
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index 2caa90fa4bf2..ff6add88b6ae 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -12,10 +12,8 @@ obj-$(CONFIG_CXL_PORT) += cxl_port.o
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
 obj-$(CONFIG_CXL_MEM) += cxl_mem.o
-obj-$(CONFIG_CXL_PCI) += cxl_pci.o
 
 cxl_port-y := port.o
 cxl_acpi-y := acpi.o
 cxl_pmem-y := pmem.o security.o
 cxl_mem-y := mem.o
-cxl_pci-y := pci.o
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index fa1d4aed28b9..2937d0ddcce2 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -21,3 +21,4 @@ cxl_core-$(CONFIG_CXL_FEATURES) += features.o
 cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
 cxl_core-$(CONFIG_CXL_RAS) += ras.o
 cxl_core-$(CONFIG_CXL_RCH_RAS) += ras_rch.o
+cxl_core-$(CONFIG_CXL_PCI) += pci_drv.o
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index e47ae7365ce0..61c6726744d7 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -195,4 +195,13 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		    u16 *return_code);
 #endif
 
+#ifdef CONFIG_CXL_PCI
+bool cxl_pci_drv_bound(struct pci_dev *pdev);
+int cxl_pci_driver_init(void);
+void cxl_pci_driver_exit(void);
+#else
+static inline bool cxl_pci_drv_bound(struct pci_dev *pdev) { return false; };
+static inline int cxl_pci_driver_init(void) { return 0; }
+static inline void cxl_pci_driver_exit(void) { }
+#endif
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/core/pci_drv.c
similarity index 99%
rename from drivers/cxl/pci.c
rename to drivers/cxl/core/pci_drv.c
index bd95be1f3d5c..06f2fd993cb0 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/core/pci_drv.c
@@ -1131,6 +1131,17 @@ static struct pci_driver cxl_pci_driver = {
 	},
 };
 
+bool cxl_pci_drv_bound(struct pci_dev *pdev)
+{
+	device_lock_assert(&pdev->dev);
+
+	if (pdev->driver != &cxl_pci_driver)
+		pr_err_ratelimited("%s device not bound to CXL PCI driver\n",
+				   pci_name(pdev));
+
+	return (pdev->driver == &cxl_pci_driver);
+}
+
 #define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
 static void cxl_handle_cper_event(enum cxl_event_type ev_type,
 				  struct cxl_cper_event_rec *rec)
@@ -1177,7 +1188,7 @@ static void cxl_cper_work_fn(struct work_struct *work)
 }
 static DECLARE_WORK(cxl_cper_work, cxl_cper_work_fn);
 
-static int __init cxl_pci_driver_init(void)
+int __init cxl_pci_driver_init(void)
 {
 	int rc;
 
@@ -1192,15 +1203,9 @@ static int __init cxl_pci_driver_init(void)
 	return rc;
 }
 
-static void __exit cxl_pci_driver_exit(void)
+void cxl_pci_driver_exit(void)
 {
 	cxl_cper_unregister_work(&cxl_cper_work);
 	cancel_work_sync(&cxl_cper_work);
 	pci_unregister_driver(&cxl_pci_driver);
 }
-
-module_init(cxl_pci_driver_init);
-module_exit(cxl_pci_driver_exit);
-MODULE_DESCRIPTION("CXL: PCI manageability");
-MODULE_LICENSE("GPL v2");
-MODULE_IMPORT_NS("CXL");
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 48f6a1492544..b70e1b505b5c 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2507,6 +2507,8 @@ static __init int cxl_core_init(void)
 	if (rc)
 		goto err_ras;
 
+	cxl_pci_driver_init();
+
 	return 0;
 
 err_ras:
@@ -2522,6 +2524,7 @@ static __init int cxl_core_init(void)
 
 static void cxl_core_exit(void)
 {
+	cxl_pci_driver_exit();
 	cxl_ras_exit();
 	cxl_region_exit();
 	bus_unregister(&cxl_bus_type);
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 6905f8e710ab..d8b8272ef87b 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -65,6 +65,7 @@ cxl_core-$(CONFIG_CXL_FEATURES) += $(CXL_CORE_SRC)/features.o
 cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += $(CXL_CORE_SRC)/edac.o
 cxl_core-$(CONFIG_CXL_RAS) += $(CXL_CORE_SRC)/ras.o
 cxl_core-$(CONFIG_CXL_RCH_RAS) += $(CXL_CORE_SRC)/ras_rch.o
+cxl_core-$(CONFIG_CXL_PCI) += $(CXL_CORE_SRC)/pci_drv.o
 cxl_core-y += config_check.o
 cxl_core-y += cxl_core_test.o
 cxl_core-y += cxl_core_exports.o
-- 
2.34.1


