Return-Path: <linux-pci+bounces-40249-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CD3C32426
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 18:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E2D418C6714
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 17:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FEE33BBA9;
	Tue,  4 Nov 2025 17:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CCwlA2wq"
X-Original-To: linux-pci@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010038.outbound.protection.outlook.com [52.101.46.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2FA33B951;
	Tue,  4 Nov 2025 17:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275987; cv=fail; b=sHntH0F/f9D3F8HX196dG5UzcxHsLovGa9ERT/GfxrI7dXc7/Ks9Y8bq544OgBhSJ4OBBgHaMYvK4mFvxdTkWe/BdDfyzJMmiC8aAMNKFe5w3fE7ujzg9JuxhVicZ1Tu71lPzXSas38ztf1JRRO/EXPanEk5v4f99hyIGTwSzTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275987; c=relaxed/simple;
	bh=xuJTIvvGHlNJvlPhzMXx2FTUeH5mQU44GU6onOhJfT4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bQp+ChkJ3E99wwKmYvaauvTgi9I3befxjsi1xQpx04abjpYGg/ZjUQHkR+8uGevvX2V0DhkgfwDtJkbmqMyJGHU5ZWdX8E2oMe5tkCZw0K7gzcPMWXQzN9VxUoVCR8yQskaQH92rHAZgpD3mPi5Yl7CfvrAm7vxm7Gi3Rkjx89A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CCwlA2wq; arc=fail smtp.client-ip=52.101.46.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lL81L9kry4ocMzg3Rm3sU4WMjHVLvE/sWM1ih/U4qRwMoBArKxNMm1bzyDtbVqdZKgh1nS6NrZY3CEk4mHucaJBGTKHDdSb11BAVB+83xoFh3P/woVo89trBasvXUnQ68oGWXccIMJqaEd3DZaE6tx1WWIrgEJOjLPqUiBhxYuh4Fm1DLjAIOVmaMC0um4BKLetepSqhpV6O9mPVyxYQv4XAjheyQEto1/b64F8l8wXTV2c/WA7UHLmgR/NGk87L4SPopXARpzanssPV1OaZOmRCanqg/RpN02QyjIw/e3jQbcH+IqlXAwhxbv7oAtRg9cjp00YKwbDhiXFrbLjrAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBAOsCzANn+ny3ivjZgFwLF23d9+NxQZDe2lLmklDmA=;
 b=HwHUqD/kI6tPC7WzD/BZtM/F1j/WNCVKLangeB8IXi4RrdI700iycYUO8jOxe4dfHAyajg8MXO5D3jf1QO7gUMZJA6QuknOS2vx5ehwowoMU7irbjurSZaWFFZ8e98toDnvF6fFpYRZVJNhZ3/jqwZgEjmEXkDmN8TI5uvT5dNRvaT3kuSTyIwJNPNHJo31sPYaCYZDekmz2aE2SDq8Y1xKdu5ViVT/W59h6zs1tPVcyrUZjPMdosLgAbc6b0UlLVB6SyJ/+xIhS/B5/cc9Kfdpfas7GiV0Soulmpsqtz2GJusHcUupp5lbVd3YPSHnggfd18naDcwvCF77oujANCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBAOsCzANn+ny3ivjZgFwLF23d9+NxQZDe2lLmklDmA=;
 b=CCwlA2wqGCjc83AbijsFGXSfymXv3Vz6g3zSkNVpTyzWB8UrRj+ZxxaGbYk7T7cLkJDJE78hg7x9Wrk+83Y/fP8igDsyt7TmHsIOO/0EcCQ8sGEneASuW/dGC9ZKBsLdMAI8ZmpUn/j2HK4/scQvSGgXy7GS3c23vey7Dd4cSzo=
Received: from BLAP220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::9)
 by CH3PR12MB9730.namprd12.prod.outlook.com (2603:10b6:610:253::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 17:06:21 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::b3) by BLAP220CA0004.outlook.office365.com
 (2603:10b6:208:32c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 17:06:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 17:06:21 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 09:06:20 -0800
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
Subject: [RESEND v13 17/25] cxl: Introduce cxl_pci_drv_bound() to check for bound driver
Date: Tue, 4 Nov 2025 11:02:57 -0600
Message-ID: <20251104170305.4163840-18-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|CH3PR12MB9730:EE_
X-MS-Office365-Filtering-Correlation-Id: 18aada6c-8811-4b1d-85c9-08de1bc47a41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fTxGFBD+4+ZqqerjHKmsX6Zy20Pmmt5Kd/YoElIDYfS3Q6jQo/MTNNGxEK7+?=
 =?us-ascii?Q?CwWyxFttTQY5pPaxsBKNftYax06HNlpA8CW2+iw2hRr5rCRYUEHT25E7ja2i?=
 =?us-ascii?Q?pfi11XefklG9J59xKpBS43tXTCrqYaKtqRDN1r84v4YfZSKj0LJpfaMaJk+o?=
 =?us-ascii?Q?ecgZ2ClYZt5hP/n1+/n+gS6g2JEGFmZaLtCZwMGkGuj288hNvbrAw3QiWzuZ?=
 =?us-ascii?Q?CvopP7Qsl8HuV8x1K4fWj6P+XCDCfUt/f4T9rfj1h+YJWPxMkwu0I5jmOVhJ?=
 =?us-ascii?Q?KOt38Ka/WxBbTCj0H6qEfmNzf7nc9OlN5eVA4HDYg7xJfrzR/pDPSp9bUsT3?=
 =?us-ascii?Q?dHWdXb4wIzT0Ilnp0nrBjNrOPl1Ci7a9p+Mg4pQX7JZZt+04/nrrKihFZ9kg?=
 =?us-ascii?Q?xippUoxgquOPZ+sswef2W4z2U/WDrmtBAE+u1m4eyTtdyvkyJ23GcZfSL3ER?=
 =?us-ascii?Q?k34T6ZzRe/GPxoayh8/HQxUj6ePfo9HDXaXHcUgbq/0TnYA05WrFWZi6n4nP?=
 =?us-ascii?Q?UATmLfMUp/HGATBfCbnjhPw9a0ccJ2eBIK3SsUukv3vjippaovQSP0dey4ho?=
 =?us-ascii?Q?Y7PaJFBHp1PXXBplevpd3Kb/97XDvEMMiEC8zrTg0yP8qOXIKGpd4wf2x8aW?=
 =?us-ascii?Q?/A2TD1BMrRqtnOkXvBbZXva5qDo+UZYYWY50b26kZdCk8972UGBw5Iv4snTg?=
 =?us-ascii?Q?yy7sxM7IyL0sU3AUlnZ0b1w8lBNjTPJoA/4R+EHHYzNQL58JmFunx4vIM9Hd?=
 =?us-ascii?Q?75mpT5jdySuThhfiYVLKT3ygSNPAZ8wuXK/aFaI34m+jPFOZDm7zlZUkl1fi?=
 =?us-ascii?Q?wHmUcKtKbPFDtLoh595R6BbewuxsnyVs1W7AiD+mbrNoQvsB/CERUIgzTbNv?=
 =?us-ascii?Q?TxuC3zVs33mdonfT7dN0Uf+cbgTvA7sqMlY/Sc5PMswvaXPMBbo4hFquudH8?=
 =?us-ascii?Q?5vT+d96qOXiJfay6fDGtBM1DjPSMzSkaXNLhmG7eI7OoUmIu7V43txEcwaLl?=
 =?us-ascii?Q?sYT1yhAOe5e5I7AZd7aWcnKK8Q01WR0cW4PDx3PVepGuGV219dxF7UD4nRzR?=
 =?us-ascii?Q?e6gx342q0yIKsLftaUR+6zzVN8AuNWbOcOD4dHhFxIezWvSkAvUdIAbcGmat?=
 =?us-ascii?Q?N7V56EOCgB4gkGPVauQS/21KvOAGwqNVbaJpgfaR+ZUhf1CPHX1go9CZSdbs?=
 =?us-ascii?Q?OYZX3z0gb1CcoAZEaL3JGo+oczTwU6s2/cC9ZFyq7WWJtuGOpFonW+WyHuSF?=
 =?us-ascii?Q?7ElJs9Bugmi68R5a2eCFHJ5mK0qoFaYYaN5+b7FFayZnasEJ9A9X+eUl7RYu?=
 =?us-ascii?Q?Xbp8tW5vBY6HprzJY269f79f5PLZ6eE4G8Q4jr39OJkTg6gWyNTXeMzSJjly?=
 =?us-ascii?Q?uekgUUl7NfmFuDm07YMTHZy5mqrmbx0yDc8R3s/9nkLl8cagaJPyYwCBNbIk?=
 =?us-ascii?Q?ua4wqXj/f3QdsvBX3Ro6M4hLEp8U2s5B6viN88epPUpe1/2dJE2s4gkYO6T+?=
 =?us-ascii?Q?KSGLYqt4NOWSLmuh52qlHpiYPxBWeFSCdLywA51tnQeCbBg+ICpkOnzD0CJu?=
 =?us-ascii?Q?0ZVwLueYqnDIXTv80x1N8aId7r9RSry7LobK37yo?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:06:21.1411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18aada6c-8811-4b1d-85c9-08de1bc47a41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9730

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


